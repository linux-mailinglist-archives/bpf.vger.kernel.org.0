Return-Path: <bpf+bounces-15092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0457EC168
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080F41C2091C
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EE17728;
	Wed, 15 Nov 2023 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0579171A3;
	Wed, 15 Nov 2023 11:45:28 +0000 (UTC)
Received: from wangsu.com (unknown [180.101.34.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2AD6E9;
	Wed, 15 Nov 2023 03:45:26 -0800 (PST)
Received: from XMCDN1207038 (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADn7QlQr1RlDnFeAA--.25295S2;
	Wed, 15 Nov 2023 19:45:21 +0800 (CST)
From: "Pengcheng Yang" <yangpc@wangsu.com>
To: "'John Fastabend'" <john.fastabend@gmail.com>,
	"'Jakub Sitnicki'" <jakub@cloudflare.com>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com> <1699962120-3390-3-git-send-email-yangpc@wangsu.com> <6554713028d5b_3733620856@john.notmuch>
In-Reply-To: <6554713028d5b_3733620856@john.notmuch>
Subject: Re: [PATCH bpf-next 2/3] tcp: Add the data length in skmsg to SIOCINQ ioctl
Date: Wed, 15 Nov 2023 19:45:20 +0800
Message-ID: <000101da17b9$36951720$a3bf4560$@wangsu.com>
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
Thread-Index: AQHO/J1mBkmXfIRCzv54wVJwMMBhiQJx1G0UAqlCf8SwaJ/CIA==
Content-Language: zh-cn
X-CM-TRANSID:SyJltADn7QlQr1RlDnFeAA--.25295S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr18XF4DWF45Gw4UWr4xCrg_yoW5XryrpF
	WrK3Z3Ar4kGrW8ArWvkr4fXa12k397KF13XF1kA3y5Zws8CFySyr45GF1YvF4ktr4ruw4Y
	vrW0grWvkas8Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v2
	6r1j6r4UMcIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_Cr0_Gr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY02Av
	z4vE14v_Gw4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07b82-5UUUUU=
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/

John Fastabend <john.fastabend@gmail.com> wrote:
> Pengcheng Yang wrote:
> > SIOCINQ ioctl returns the number unread bytes of the receive
> > queue but does not include the ingress_msg queue. With the
> > sk_msg redirect, an application may get a value 0 if it calls
> > SIOCINQ ioctl before recv() to determine the readable size.
> >
> > Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> 
> This will break the SK_PASS case I believe. Here we do
> not update copied_seq until data is actually copied into user
> space. This also ensures tcp_epollin_ready works correctly and
> tcp_inq. The fix is relatively recent.
> 
>  commit e5c6de5fa025882babf89cecbed80acf49b987fa
>  Author: John Fastabend <john.fastabend@gmail.com>
>  Date:   Mon May 22 19:56:12 2023 -0700
> 
>     bpf, sockmap: Incorrectly handling copied_seq
> 
> The previous patch increments the msg_len for all cases even
> the SK_PASS case so you will get double counting.

You are right, I missed the SK_PASS case of skb stream verdict.

> 
> I was starting to poke around at how to fix the other cases e.g.
> stream parser is in use and redirects but haven't got to it  yet.
> By the way I think even with this patch epollin_ready is likely
> not correct still. We observe this as either failing to wake up
> or waking up an application to early when using stream parser.
> 
> The other thing to consider is redirected skb into another socket
> and then read off the list increment the copied_seq even though
> they shouldn't if they came from another sock?  The result would
> be tcp_inq would be incorrect even negative perhaps?
> 
> What does your test setup look like? Simple redirect between
> two TCP sockets? With or without stream parser? My guess is we
> need to fix underlying copied_seq issues related to the redirect
> and stream parser case. I believe the fix is, only increment
> copied_seq for data that was put on the ingress_queue from SK_PASS.
> Then update previous patch to only incrmeent sk_msg_queue_len()
> for redirect paths. And this patch plus fix to tcp_epollin_ready
> would resolve most the issues. Its a bit unfortunate to leak the
> sk_sg_queue_len() into tcp_ioctl and tcp_epollin but I don't have
> a cleaner idea right now.
> 

What I tested was to use msg_verdict to redirect between two sockets
without stream parser, and the problem I encountered is that msg has
been queued in psock->ingress_msg, and the application has been woken up
by epoll (because of sk_psock_data_ready), but the ioctl(FIONREAD) returns 0.

The key is that the rcv_nxt is not updated on ingress redirect, or we only need
to update rcv_nxt on ingress redirect, such as in bpf_tcp_ingress() and
sk_psock_skb_ingress_enqueue() ?


