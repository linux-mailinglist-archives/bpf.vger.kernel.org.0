Return-Path: <bpf+bounces-15226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A387EF14A
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD3AB20BE2
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 11:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777171B28B;
	Fri, 17 Nov 2023 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 122E611D;
	Fri, 17 Nov 2023 02:59:54 -0800 (PST)
Received: from XMCDN1207038 (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltACHAhKmR1dl66hhAA--.26433S2;
	Fri, 17 Nov 2023 18:59:51 +0800 (CST)
From: "Pengcheng Yang" <yangpc@wangsu.com>
To: "'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Sitnicki'" <jakub@cloudflare.com>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com> <1699962120-3390-3-git-send-email-yangpc@wangsu.com> <6554713028d5b_3733620856@john.notmuch> <000101da17b9$36951720$a3bf4560$@wangsu.com> <6556c2c238099_537dc208ab@john.notmuch>
In-Reply-To: <6556c2c238099_537dc208ab@john.notmuch>
Subject: Re: [PATCH bpf-next 2/3] tcp: Add the data length in skmsg to SIOCINQ ioctl
Date: Fri, 17 Nov 2023 18:59:50 +0800
Message-ID: <009601da1945$2ff0d0c0$8fd27240$@wangsu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHO/J1mBkmXfIRCzv54wVJwMMBhiQJx1G0UAqlCf8QBxnk5/QJgXLDNsEp4bpA=
Content-Language: zh-cn
X-CM-TRANSID:SyJltACHAhKmR1dl66hhAA--.26433S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1xZw43AF4UXFyxAFykAFb_yoWrAw1UpF
	W5KF1Skr4kCr4xArZ2vw1fX3W3K393KF17Xrn8t3y3Aws0kFySyr45GF4Y9FZ7tr4rur4Y
	vr4jgrWS9wn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v2
	6r1j6r4UMcIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xS
	Y4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUD0edUUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/

John Fastabend <john.fastabend@gmail.com> wrote:
> Pengcheng Yang wrote:
> > John Fastabend <john.fastabend@gmail.com> wrote:
> > > Pengcheng Yang wrote:
> > > > SIOCINQ ioctl returns the number unread bytes of the receive
> > > > queue but does not include the ingress_msg queue. With the
> > > > sk_msg redirect, an application may get a value 0 if it calls
> > > > SIOCINQ ioctl before recv() to determine the readable size.
> > > >
> > > > Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> > >
> > > This will break the SK_PASS case I believe. Here we do
> > > not update copied_seq until data is actually copied into user
> > > space. This also ensures tcp_epollin_ready works correctly and
> > > tcp_inq. The fix is relatively recent.
> > >
> > >  commit e5c6de5fa025882babf89cecbed80acf49b987fa
> > >  Author: John Fastabend <john.fastabend@gmail.com>
> > >  Date:   Mon May 22 19:56:12 2023 -0700
> > >
> > >     bpf, sockmap: Incorrectly handling copied_seq
> > >
> > > The previous patch increments the msg_len for all cases even
> > > the SK_PASS case so you will get double counting.
> >
> > You are right, I missed the SK_PASS case of skb stream verdict.
> >
> > >
> > > I was starting to poke around at how to fix the other cases e.g.
> > > stream parser is in use and redirects but haven't got to it  yet.
> > > By the way I think even with this patch epollin_ready is likely
> > > not correct still. We observe this as either failing to wake up
> > > or waking up an application to early when using stream parser.
> > >
> > > The other thing to consider is redirected skb into another socket
> > > and then read off the list increment the copied_seq even though
> > > they shouldn't if they came from another sock?  The result would
> > > be tcp_inq would be incorrect even negative perhaps?
> > >
> > > What does your test setup look like? Simple redirect between
> > > two TCP sockets? With or without stream parser? My guess is we
> > > need to fix underlying copied_seq issues related to the redirect
> > > and stream parser case. I believe the fix is, only increment
> > > copied_seq for data that was put on the ingress_queue from SK_PASS.
> > > Then update previous patch to only incrmeent sk_msg_queue_len()
> > > for redirect paths. And this patch plus fix to tcp_epollin_ready
> > > would resolve most the issues. Its a bit unfortunate to leak the
> > > sk_sg_queue_len() into tcp_ioctl and tcp_epollin but I don't have
> > > a cleaner idea right now.
> > >
> >
> > What I tested was to use msg_verdict to redirect between two sockets
> > without stream parser, and the problem I encountered is that msg has
> > been queued in psock->ingress_msg, and the application has been woken up
> > by epoll (because of sk_psock_data_ready), but the ioctl(FIONREAD) returns 0.
> 
> Yep makes sense.
> 
> >
> > The key is that the rcv_nxt is not updated on ingress redirect, or we only need
> > to update rcv_nxt on ingress redirect, such as in bpf_tcp_ingress() and
> > sk_psock_skb_ingress_enqueue() ?
> >
> 
> I think its likely best not to touch rcv_nxt. 'rcv_nxt' is used in
> the tcp stack to calculate lots of things. If you just bump it and
> then ever received an actual TCP pkt you would get some really
> odd behavior because seq numbers and rcv_nxt would be unrelated then.
> 
> The approach you have is really the best bet IMO, but mask out
> the increment msg_len where its not needed. Then it should be OK.
> 

I think we can add a flag to msg to identify whether msg comes from the same
sock's receive_queue. In this way, we can increase and decrease the msg_len
based on this flag when msg is queued to ingress_msg and when it is read by
the application.

And, this can also fix the case you mentioned above:

	"The other thing to consider is redirected skb into another socket
	and then read off the list increment the copied_seq even though
	they shouldn't if they came from another sock?  The result would
	be tcp_inq would be incorrect even negative perhaps?"

During recv in tcp_bpf_recvmsg_parser(), we only need to increment copied_seq
when the msg comes from the same sock's receive_queue, otherwise copied_seq
may overflow rcv_nxt in this case.

> Mixing ingress redirect and TCP sending/recv pkts doesn't usually work
> very well anyway but I still think leaving rcv_nxt alone is best.


