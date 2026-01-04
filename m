Return-Path: <bpf+bounces-77759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC82CF0968
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 04:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9DD3015EE7
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 03:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D72BF3CF;
	Sun,  4 Jan 2026 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqbrkn1Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43337260F;
	Sun,  4 Jan 2026 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767497986; cv=none; b=gYwn97NGhkfhrGYKgxZ57JTUaO4u1AlndUdpHmNrnLY5OvdsyKp350CTKmdR21ZIMdSNOv7TLTatOjxz26kFRqsx3BiVshL4tvjW7a/YfgUdUEl4wL10XG0xCk2o2jGRO+lidv80xKYtMGMS0UvBgVZE6JlF7dauOIukhMFGRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767497986; c=relaxed/simple;
	bh=5r8iqOVcvXSOkMwPFhOzGH0ybiMC6bwkE2VmwotzUbw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ig4A92/6+zoLvXiUmyKLWzjsYIXF8uGhz2XW4hkRzk4q1Sd8xNk74TSudhxgArtsaBeNQrk95jXw8F7yySUK0qJcMILdPFXBrOC2e+8vas/YsSC/Wdf3QiWwT81QZdIf85pRakZiVSmTs5TElwkHVZq/Y6brgZXdFIGWJyDxOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqbrkn1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B8EC4CEF7;
	Sun,  4 Jan 2026 03:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767497986;
	bh=5r8iqOVcvXSOkMwPFhOzGH0ybiMC6bwkE2VmwotzUbw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Uqbrkn1Y9Y9T4E78DTcCrnjtjAJsNYZxMS1lIulZbWdbjO42D6KIQQ0GL2LxLJTmy
	 zgfwHqMPlDBdl9Xmnmhc18mzm18oM4+QDZFCUKpE8bKUCEwm0ZUTpgg3y6r8qnVji1
	 iT6ZqCyI2KIUm6OkKX+Muj9JQrXaISCnZrIJAx790E70P7S1X6acuWff9ZVRf0zdVx
	 xb+BIZCGqd8jPbBYfwbfBUBBr6CrqLQyapuL1fd22lt6gEDsSxsrFA0Ip54NH3v1sT
	 5jA5ev7kYNw9XcDwCB6ONnXG3Vufom44iBAl5ezRnj1UBq41FH9oO77tq4pK14D9+6
	 gn97SdFxEjG7g==
Content-Type: multipart/mixed; boundary="===============5096022303574277409=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e15de586e958d118e15c59026406ca4df756ccd9075fdcedd458639685b661a9@mail.kernel.org>
In-Reply-To: <20260104032313.76121-3-kerneljasonxing@gmail.com>
References: <20260104032313.76121-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] xsk: introduce a dedicated local completion queue for each xsk
From: bot+bpf-ci@kernel.org
To: kerneljasonxing@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,kernelxing@tencent.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  4 Jan 2026 03:39:45 +0000 (UTC)

--===============5096022303574277409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f41e0b480aa4..0a724cf20fcb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> +{
> +	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
> +	u32 idx, addr, pos = xsk_get_start_addr(skb);
             ^^^^

Should addr be u64 here? The lcq->desc[] array stores u64 values
(descriptor addresses), and xskq_prod_write_addr() expects a u64 parameter.
Declaring addr as u32 truncates the upper 32 bits when reading from
lcq->desc[].

For reference, struct local_cq in include/net/xdp_sock.h declares:

    u64 desc[] ____cacheline_aligned_in_smp;

And xskq_prod_write_addr() in net/xdp/xsk_queue.h has signature:

    static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)

If a umem is large enough that descriptor offsets exceed 4GB, this would
silently write incorrect addresses to the completion queue, causing user
space to receive corrupted descriptor addresses.

> +	struct xdp_sock *xs = xdp_sk(skb->sk);
> +
> +	idx = xskq_get_prod(pool->cq) + desc_processed;
> +	addr = xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mask];
> +	xskq_prod_write_addr(pool->cq, idx, addr);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20686964750

--===============5096022303574277409==--

