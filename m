Return-Path: <bpf+bounces-10591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034C7AA1EB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08341F217AD
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7A1946C;
	Thu, 21 Sep 2023 21:08:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E39CA47;
	Thu, 21 Sep 2023 21:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B8C433C9;
	Thu, 21 Sep 2023 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695330523;
	bh=Y7PA9z04pQLI2kDJ+QF7Z+ZWmBHHybIHmWGJyNWnLy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzgvOt/tPb/EpAqcK6tYNGVO6PlU2Z5l+PGY/OkdF76fc46UUfxkKnFAod7KQjqnY
	 z89BAtyTtu25aYZC/QvoXhg7WZdKOfkYjvInKfAlih4zDqutI0vKvL+zc/QPiwa89Y
	 Gl1yr4/vg7RO/ENPnbmj/fOyvG1gjbHb+3ydVtFJU+sOiRL2OsbepCsi3gFkgFxjX5
	 Huy5rPxu9kQwVYXeRWwwV+J9QNKUclVW/jxsAFOIHj9KEixASseqgtfJn4jsG5Tp+S
	 /xSMxXP0cUbNSEBdEjV2hqO51vjte1tDmPtOpYRjvxFMTkdZxrPapiC3yFHjSIUVKd
	 JOkOxuxJk+4Bg==
Date: Thu, 21 Sep 2023 22:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
	jakub@cloudflare.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/3] bpf: tcp_read_skb needs to pop skb regardless of
 seq
Message-ID: <20230921210838.GR224399@kernel.org>
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920232706.498747-2-john.fastabend@gmail.com>

On Wed, Sep 20, 2023 at 04:27:04PM -0700, John Fastabend wrote:
> Before fix e5c6de5fa0258 tcp_read_skb() would increment the tp->copied-seq
> value. This (as described in the commit) would cause an error for apps
> because once that is incremented the application might believe there is no
> data to be read. Then some apps would stall or abort believing no data is
> available.
> 
> However, the fix is incomplete because it introduces another issue in
> the skb dequeue. The loop does tcp_recv_skb() in a while loop to consume
> as many skbs as possible. The problem is the call is,
> 
>   tcp_recv_skb(sk, seq, &offset)
> 
> Where 'seq' is
> 
>   u32 seq = tp->copied_seq;
> 
> Now we can hit a case where we've yet incremented copied_seq from BPF side,
> but then tcp_recv_skb() fails this test,
> 
>  if (offset < skb->len || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
> 
> so that instead of returning the skb we call tcp_eat_recv_skb() which frees
> the skb. This is because the routine believes the SKB has been collapsed
> per comment,
> 
>  /* This looks weird, but this can happen if TCP collapsing
>   * splitted a fat GRO packet, while we released socket lock
>   * in skb_splice_bits()
>   */
> 
> This can't happen here we've unlinked the full SKB and orphaned it. Anyways
> it would confuse any BPF programs if the data were suddenly moved underneath
> it.
> 
> To fix this situation do simpler operation and just skb_peek() the data
> of the queue followed by the unlink. It shouldn't need to check this
> condition and tcp_read_skb() reads entire skbs so there is no need to
> handle the 'offset!=0' case as we would see in tcp_read_sock().
> 
> Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/ipv4/tcp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0c3040a63ebd..45e7f39e67bc 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1625,12 +1625,11 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  	u32 seq = tp->copied_seq;

Hi John,

according to clang-16, with this change seq is now set but unused.
I guess seq can simply be removed as part of this change.

>  	struct sk_buff *skb;
>  	int copied = 0;
> -	u32 offset;
>  
>  	if (sk->sk_state == TCP_LISTEN)
>  		return -ENOTCONN;
>  
> -	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
> +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
>  		u8 tcp_flags;
>  		int used;
>  
> -- 
> 2.33.0
> 
> 

