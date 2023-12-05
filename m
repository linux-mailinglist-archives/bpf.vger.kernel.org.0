Return-Path: <bpf+bounces-16691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C780447F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2C1F213B6
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ED946AD;
	Tue,  5 Dec 2023 02:11:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A4107;
	Mon,  4 Dec 2023 18:10:59 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VxsMv1R_1701742256;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxsMv1R_1701742256)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 10:10:56 +0800
Message-ID: <1701740897.6795166-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
Date: Tue, 5 Dec 2023 09:48:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com,
 davem@davemloft.net,
 dsahern@kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com,
 martin.lau@linux.dev,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com,
 hengqi@linux.alibaba.com,
 Philo Lu <lulie@linux.alibaba.com>
References: <20231204114322.9218-1-lulie@linux.alibaba.com>
 <CANn89iKUHQHA2wHw9k1SiazJf7ag7i4Tz+FPutgu870teVw_Bg@mail.gmail.com>
In-Reply-To: <CANn89iKUHQHA2wHw9k1SiazJf7ag7i4Tz+FPutgu870teVw_Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 4 Dec 2023 13:28:21 +0100, Eric Dumazet <edumazet@google.com> wrote:
> On Mon, Dec 4, 2023 at 12:43=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com=
> wrote:
> >
> > Add 3 tracepoints, namely tcp_data_send/tcp_data_recv/tcp_data_acked,
> > which will be called every time a tcp data packet is sent, received, and
> > acked.
> > tcp_data_send: called after a data packet is sent.
> > tcp_data_recv: called after a data packet is receviced.
> > tcp_data_acked: called after a valid ack packet is processed (some sent
> > data are ackknowledged).
> >
> > We use these callbacks for fine-grained tcp monitoring, which collects
> > and analyses every tcp request/response event information. The whole
> > system has been described in SIGMOD'18 (see
> > https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
> > achieve this with bpf, we require hooks for data events that call bpf
> > prog (1) when any data packet is sent/received/acked, and (2) after
> > critical tcp state variables have been updated (e.g., snd_una, snd_nxt,
> > rcv_nxt). However, existing bpf hooks cannot meet our requirements.
> > Besides, these tracepoints help to debug tcp when data send/recv/acked.
>
> This I do not understand.
>
> >
> > Though kretprobe/fexit can also be used to collect these information,
> > they will not work if the kernel functions get inlined. Considering the
> > stability, we prefer tracepoint as the solution.
>
> I dunno, this seems quite weak to me. I see many patches coming to add
> tracing in the stack, but no patches fixing any issues.


We have implemented a mechanism to split the request and response from the =
TCP
connection using these "hookers", which can handle various protocols such as
HTTP, HTTPS, Redis, and MySQL. This mechanism allows us to record important
information about each request and response, including the amount of data
uploaded, the time taken by the server to handle the request, and the time =
taken
for the client to receive the response. This mechanism has been running
internally for many years and has proven to be very useful.

One of the main benefits of this mechanism is that it helps in locating the
source of any issues or problems that may arise. For example, if there is a
problem with the network, the application, or the machine, we can use this
mechanism to identify and isolate the issue.

TCP has long been a challenge when it comes to tracking the transmission of=
 data
on the network. The application can only confirm that it has sent a certain
amount of data to the kernel, but it has limited visibility into whether the
client has actually received this data. Our mechanism addresses this issue =
by
providing insights into the amount of data received by the client and the t=
ime
it was received. Furthermore, we can also detect any packet loss or delays
caused by the server.

https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7912288961/973=
2df025beny.svg

So, we do not want to add some tracepoint to do some unknow debug.
We have a clear goal. debugging is just an incidental capability.

Thanks.


>
> It really looks like : We do not know how TCP stack works, we do not
> know if there is any issue,
> let us add trace points to help us to make forward progress in our analys=
is.
>
> These tracepoints will not tell how many segments/bytes were
> sent/acked/received, I really do not see
> how we will avoid adding in the future more stuff, forcing the
> compiler to save more state
> just in case the tracepoint needs the info.
>
> The argument of "add minimal info", so that we can silently add more
> stuff in the future "for free" is not something I buy.
>
> I very much prefer that you make sure the stuff you need is not
> inlined, so that standard kprobe/kretprobe facility can be used.

