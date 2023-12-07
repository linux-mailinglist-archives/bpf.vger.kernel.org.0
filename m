Return-Path: <bpf+bounces-16979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D68F807E96
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD841F21ACC
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4FD1846;
	Thu,  7 Dec 2023 02:33:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1314D4B;
	Wed,  6 Dec 2023 18:33:35 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vy-5ywS_1701916412;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vy-5ywS_1701916412)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 10:33:33 +0800
Message-ID: <1701916081.917355-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
Date: Thu, 7 Dec 2023 10:28:01 +0800
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
 <1701740897.6795166-1-xuanzhuo@linux.alibaba.com>
 <CANn89i+Xs3sSDQcub9p=YGUp1_XainGQpS=0RVpYTiDjvRN1rw@mail.gmail.com>
In-Reply-To: <CANn89i+Xs3sSDQcub9p=YGUp1_XainGQpS=0RVpYTiDjvRN1rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 5 Dec 2023 20:39:28 +0100, Eric Dumazet <edumazet@google.com> wrote:
> On Tue, Dec 5, 2023 at 3:11=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Mon, 4 Dec 2023 13:28:21 +0100, Eric Dumazet <edumazet@google.com> w=
rote:
> > > On Mon, Dec 4, 2023 at 12:43=E2=80=AFPM Philo Lu <lulie@linux.alibaba=
.com> wrote:
> > > >
> > > > Add 3 tracepoints, namely tcp_data_send/tcp_data_recv/tcp_data_acke=
d,
> > > > which will be called every time a tcp data packet is sent, received=
, and
> > > > acked.
> > > > tcp_data_send: called after a data packet is sent.
> > > > tcp_data_recv: called after a data packet is receviced.
> > > > tcp_data_acked: called after a valid ack packet is processed (some =
sent
> > > > data are ackknowledged).
> > > >
> > > > We use these callbacks for fine-grained tcp monitoring, which colle=
cts
> > > > and analyses every tcp request/response event information. The whole
> > > > system has been described in SIGMOD'18 (see
> > > > https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
> > > > achieve this with bpf, we require hooks for data events that call b=
pf
> > > > prog (1) when any data packet is sent/received/acked, and (2) after
> > > > critical tcp state variables have been updated (e.g., snd_una, snd_=
nxt,
> > > > rcv_nxt). However, existing bpf hooks cannot meet our requirements.
> > > > Besides, these tracepoints help to debug tcp when data send/recv/ac=
ked.
> > >
> > > This I do not understand.
> > >
> > > >
> > > > Though kretprobe/fexit can also be used to collect these informatio=
n,
> > > > they will not work if the kernel functions get inlined. Considering=
 the
> > > > stability, we prefer tracepoint as the solution.
> > >
> > > I dunno, this seems quite weak to me. I see many patches coming to add
> > > tracing in the stack, but no patches fixing any issues.
> >
> >
> > We have implemented a mechanism to split the request and response from =
the TCP
> > connection using these "hookers", which can handle various protocols su=
ch as
> > HTTP, HTTPS, Redis, and MySQL. This mechanism allows us to record impor=
tant
> > information about each request and response, including the amount of da=
ta
> > uploaded, the time taken by the server to handle the request, and the t=
ime taken
> > for the client to receive the response. This mechanism has been running
> > internally for many years and has proven to be very useful.
> >
> > One of the main benefits of this mechanism is that it helps in locating=
 the
> > source of any issues or problems that may arise. For example, if there =
is a
> > problem with the network, the application, or the machine, we can use t=
his
> > mechanism to identify and isolate the issue.
> >
> > TCP has long been a challenge when it comes to tracking the transmissio=
n of data
> > on the network. The application can only confirm that it has sent a cer=
tain
> > amount of data to the kernel, but it has limited visibility into whethe=
r the
> > client has actually received this data. Our mechanism addresses this is=
sue by
> > providing insights into the amount of data received by the client and t=
he time
> > it was received. Furthermore, we can also detect any packet loss or del=
ays
> > caused by the server.
> >
> > https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7912288961=
/9732df025beny.svg
> >
> > So, we do not want to add some tracepoint to do some unknow debug.
> > We have a clear goal. debugging is just an incidental capability.
> >
>
> We have powerful mechanisms in the stack already that ordinary (no
> privilege requested) applications can readily use.
>
> We have been using them for a while.
>
> If existing mechanisms are missing something you need, please expand them.
>
> For reference, start looking at tcp_get_timestamping_opt_stats() history.
>
> Sender side can for instance get precise timestamps.
>
> Combinations of these timestamps reveal different parts of the overall
> network latency,
>
> T0: sendmsg() enters TCP
> T1: first byte enters qdisc
> T2: first byte sent to the NIC
> T3: first byte ACKed in TCP
> T4: last byte sent to the NIC
> T5: last byte ACKed
> T1 - T0: how long the first byte was blocked in the TCP layer ("Head
> of Line Blocking" latency).
> T2 - T1: how long the first byte was blocked in the Linux traffic
> shaping layer (known as QDisc).
> T3 - T2: the network =E2=80=98distance=E2=80=99 (propagation delay + curr=
ent queuing
> delay along the network path and at the receiver).
> T5 - T2: how fast the sent chunk was delivered.
> Message Size / (T5 - T0): goodput (from application=E2=80=99s perspective)


The key point is that using our mechanism, the application does not need to=
 be
modified.

As long as the app's network protocol is request-response, we can trace tcp
connection at any time to analyze the request and response. And record the =
start
and end times of request and response. Of course there is some ttl and other
information.

Thanks.

