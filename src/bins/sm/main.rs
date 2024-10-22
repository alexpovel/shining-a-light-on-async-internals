use std::{future::Future, task::Poll, time::Duration};

use tokio::time::sleep;

#[tokio::main]
async fn main() {
    greet().await;
    let x = greet();
}
async fn greet() {
    println!("Hi!");
    sleep(Duration::from_secs(1)).await;
    println!("Bye!");
}

enum GreetFutureStateMachine {
    Init,
    Wait1(SleepFut),
    Done,
}

type SleepFut = tokio::time::Sleep;

impl Future for GreetFutureStateMachine {
    type Output = ();

    fn poll(self: std::pin::Pin<&mut Self>, cx: &mut std::task::Context<'_>) -> Poll<Self::Output> {
        match *self {
            Self::Init => {
                println!("Hi!");
                let sf = sleep(Duration::from_secs(1));

                *self = Self::Wait1(sf);
                Poll::Pending
            }
            Self::Wait1(sf) => {
                sf.poll(cx)?; // Check if ready (fake syntax)

                println!("Bye!");

                *self = Self::Done;
                Poll::Ready(())
            }
            Self::Done => panic!("polled after completion"),
        }
    }
}
