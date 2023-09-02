Return-Path: <bpf+bounces-9137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A855D7906AB
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 11:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B22819CE
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34F23C25;
	Sat,  2 Sep 2023 09:00:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC36258D;
	Sat,  2 Sep 2023 09:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7799DC433C8;
	Sat,  2 Sep 2023 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693645237;
	bh=MxpykyJ+0W4Y9Le7FBH89s04jQ7y+TZQ+BhkHSsoQmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/dJUHpCbuqZyy7tb0qX7ioXhcTLm5vl5wcDsovBNXFMfiHduExeCPuyMcUEkpA+c
	 JV4wM8jvnJtftoJmQs0Dhqaw4Wbm8gvPG8l4vXgfUdtWLDVAVnKjtWeUA1uqAe7H1a
	 jeN4jHlB3xfgJSgas2pTmuV7hk72UWNA/xAjW9vQpTsaYoqh/UsiRq+3W6+wQm1JUs
	 75dVifk4P5TE+9aaJjwONAM6N4vkLkOoGWyyZMGcAGveIZTP8LFF+dZiHk0H7h+1tm
	 QWPkYU0RbtwBcP5XOUPWidtHzo3dAbtEzU30wHgjh128Qm3Fy+/4KN6jZO3asJPb8s
	 i6ajBTzcrOsgw==
Date: Sat, 2 Sep 2023 11:00:32 +0200
From: Simon Horman <horms@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: olsajiri@gmail.com, xukuohai@huawei.com, eddyz87@gmail.com,
	edumazet@google.com, cong.wang@bytedance.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking
 changes
Message-ID: <20230902090032.GB2146@kernel.org>
References: <20230901202137.214666-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901202137.214666-1-john.fastabend@gmail.com>

On Fri, Sep 01, 2023 at 01:21:37PM -0700, John Fastabend wrote:
> There is a race where skb's from the sk_psock_backlog can be referenced
> after userspace side has already skb_consumed() the sk_buff and its
> refcnt dropped to zer0 causing use after free.
> 
> The flow is the following,
> 
>   while ((skb = skb_peek(&psock->ingress_skb))
>     sk_psock_handle_Skb(psock, skb, ..., ingress)
>     if (!ingress) ...
>     sk_psock_skb_ingress
>        sk_psock_skb_ingress_enqueue(skb)
>           msg->skb = skb
>           sk_psock_queue_msg(psock, msg)
>     skb_dequeue(&psock->ingress_skb)
> 
> The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
> what the application reads when recvmsg() is called. An application can
> read this anytime after the msg is placed on the queue. The recvmsg
> hook will also read msg->skb and then after user space reads the msg
> will call consume_skb(skb) on it effectively free'ing it.
> 
> But, the race is in above where backlog queue still has a reference to
> the skb and calls skb_dequeue(). If the skb_dequeue happens after the
> user reads and free's the skb we have a use after free.
> 
> The !ingress case does not suffer from this problem because it uses
> sendmsg_*(sk, msg) which does not pass the sk_buff further down the
> stack.
> 
> The following splat was observed with 'test_progs -t sockmap_listen':
> 
> [ 1022.710250][ T2556] general protection fault, ...
>  ...
> [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
> [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
> [ 1022.713653][ T2556] Code: ...
>  ...
> [ 1022.720699][ T2556] Call Trace:
> [ 1022.720984][ T2556]  <TASK>
> [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
> [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
> [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
> [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
> [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
> [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
> [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
> [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
> [ 1022.724386][ T2556]  kthread+0xfd/0x130
> [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
> [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
> [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
> [ 1022.726201][ T2556]  </TASK>
> 
> To fix we add an skb_get() before passing the skb to be enqueued in
> the engress queue. This bumps the skb->users refcnt so that consume_skb
> and kfree_skb will not immediately free the sk_buff. With this we can
> be sure the skb is still around when we do the dequeue. Then we just
> need to decrement the refcnt or free the skb in the backlog case which
> we do by calling kfree_skb() on the ingress case as well as the sendmsg
> case.
> 
> Before locking change from fixes tag we had the sock locked so we
> couldn't race with user and there was no issue here.
> 
> Fixes: 799aa7f98d53e (skmsg: Avoid lock_sock() in sk_psock_backlog())

Hi John,

A minor nit from my side.
I think the usual format for a fixes tag is follows.

Fixes: 799aa7f98d53e ("skmsg: Avoid lock_sock() in sk_psock_backlog()")

> Reported-by: Jiri Olsa  <jolsa@kernel.org>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

...

