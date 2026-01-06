Return-Path: <bpf+bounces-77907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E786CF6606
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 02:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74890306C548
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B45216E24;
	Tue,  6 Jan 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce2Z4Fdq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC553E0B;
	Tue,  6 Jan 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664073; cv=none; b=U8que0SwSU3MRRhM7lf1URNg9VymObq3F6o65s0qWZfLuAWfSjLL+XzZrfK7GUqYNaHPBEzN6wzoG7CPGvZA7bYwA+83mUJvCNVmQEGeZ/ogO04sWpDwgTbpxzOI6e6F8lL7k+sbLZ7qFzb1bITWmRNEq+JcyJXC2Z4lH5C0jnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664073; c=relaxed/simple;
	bh=N9LGvbpymn/yIWtYp/l2GW/A90JRJq3dlwPhB2dyHLo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YVVIogZARJlKfPpwwQ7Q2xVSe33Wy6xF+4UshrHrIZ+FEc5ZOeSmqv1+xu5y90SQ3ADK+LgbsvP1T1QwXHKa0pjQccjU+jxYfGU/r86YFK1A9qdu5BCIdIijlgbXKBTD+rBNmxJPcyZ4eQXk+TmaaMRYJDi6zl/0z8719DTduYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce2Z4Fdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4FBC116D0;
	Tue,  6 Jan 2026 01:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664072;
	bh=N9LGvbpymn/yIWtYp/l2GW/A90JRJq3dlwPhB2dyHLo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ce2Z4FdqSF7mecGX+GDXZ0l8du1GHY3mq2F45nP4iGDxVwouE8Q5Truzw9omGX5LO
	 UTK5fhxX23jLhZXVo7RtkF3sR1pNODaEpqIOTWT6lCjmSuuWB68mWI905BgitWqrRt
	 JW2fT9QsQapwNUclqf40RGpirq9i+0AIVxmnbQexU/EWRPp/7AjNr2GjJTQ5Jyeehq
	 JRF4AgepPIhCU/4k6faWh6cqhTaClgk3LToZ5FlCnYOy0kUZ0YNMCR3Dh2cF4Q0Djt
	 5aRw7gIBHmMFdLPDSSBNBEOxq+meGcLmV2mRdlRIQOp8g9xmKTptOcuOsZyhjLP3Vm
	 rab3x6lOBiSHw==
Content-Type: multipart/mixed; boundary="===============0074876398316781492=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89fee0bdf782c9fab10781be2a42c099bfb9f99a53c342dd6e41fd99651943f6@mail.kernel.org>
In-Reply-To: <20260106013112.56250-3-kerneljasonxing@gmail.com>
References: <20260106013112.56250-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] xsk: introduce a dedicated local completion queue for each xsk
From: bot+bpf-ci@kernel.org
To: kerneljasonxing@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,kernelxing@tencent.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  6 Jan 2026 01:47:52 +0000 (UTC)

--===============0074876398316781492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f41e0b480aa4..f80721165fdc 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> -static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> +static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
>  {
> +	struct xsk_buff_pool *pool = xs->pool;
> +	struct local_cq *lcq = xs->lcq;
>  	int ret;
>
>  	spin_lock(&pool->cq_cached_prod_lock);
>  	ret = xskq_prod_reserve(pool->cq);
>  	spin_unlock(&pool->cq_cached_prod_lock);
> +	if (!ret)
> +		lcq->desc[lcq->prod++ & lcq->ring_mask] = addr;
>
>  	return ret;
>  }

[ ... ]

> +/* Record the position of first desc in local cq */
> +static void xsk_skb_destructor_set_addr(struct sk_buff *skb,
> +					struct xdp_sock *xs)
>  {
> -	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> +	long val;
> +
> +	val = ((xs->lcq->prod - 1) & xs->lcq->ring_mask) << XSK_DESTRUCTOR_DESCS_SHIFT;
> +	skb_shinfo(skb)->destructor_arg = (void *)val;
>  }

[ ... ]

> +static void xsk_cq_write_addr(struct sk_buff *skb, u32 desc_processed)
> +{
> +	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
> +	u32 idx, pos = xsk_get_start_addr(skb);
> +	struct xdp_sock *xs = xdp_sk(skb->sk);
> +	u64 addr;
> +
> +	idx = xskq_get_prod(pool->cq) + desc_processed;
> +	addr = xs->lcq->desc[(pos + desc_processed) & xs->lcq->ring_mask];
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +	xskq_prod_write_addr(pool->cq, idx, addr);
> +}

Can this read stale or corrupted data from lcq->desc[] if skb destructors
run out of order?

Consider this scenario with a completion queue of 4 entries:
  1. SKB1 reserves and writes to lcq[0], stores start_pos=0
  2. SKB2 reserves and writes to lcq[1], stores start_pos=1
  3. SKB3 reserves and writes to lcq[2], stores start_pos=2
  4. SKB4 reserves and writes to lcq[3], stores start_pos=3
  5. Backpressure - cq is full
  6. Network completes SKB4 first (out of order), destructor reads lcq[3],
     submits to cq, space becomes available
  7. SKB5 reserves and writes to lcq[0] (wraparound), overwriting SKB1's data
  8. SKB1's destructor finally runs, reads lcq[0] which now contains SKB5's
     address instead of SKB1's original address

The old code stored addresses in a per-skb xsk_addrs structure, so each skb
had its own copy that could not be overwritten. The new shared ring buffer
design appears to be vulnerable to out-of-order completion corrupting the
address data.

> +static void xsk_cq_submit_addr_locked(struct sk_buff *skb)
>  {
> -	u32 num_descs = xsk_get_num_desc(skb);
> -	struct xsk_addrs *xsk_addr;
> -	u32 descs_processed = 0;
> +	struct xsk_buff_pool *pool = xdp_sk(skb->sk)->pool;
> +	u8 i, num = xsk_get_num_desc(skb);
>  	unsigned long flags;
> -	u32 idx, i;
>
>  	spin_lock_irqsave(&pool->cq_prod_lock, flags);
> -	idx = xskq_get_prod(pool->cq);
> -
> -	if (unlikely(num_descs > 1)) {
> -		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> -
> -		for (i = 0; i < num_descs; i++) {
> -			xskq_prod_write_addr(pool->cq, idx + descs_processed,
> -					     xsk_addr->addrs[i]);
> -			descs_processed++;
> -		}
> -		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> -	} else {
> -		xskq_prod_write_addr(pool->cq, idx,
> -				     xsk_skb_destructor_get_addr(skb));
> -		descs_processed++;
> -	}
> -	xskq_prod_submit_n(pool->cq, descs_processed);
> +	for (i = 0; i < num; i++)
> +		xsk_cq_write_addr(skb, i);
> +	xskq_prod_submit_n(pool->cq, num);
>  	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20735004935

--===============0074876398316781492==--

