Return-Path: <bpf+bounces-72924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFE0C1DA1D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFB93A212D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9402E6CC4;
	Wed, 29 Oct 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW+cqAVC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE062E5B09;
	Wed, 29 Oct 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778778; cv=none; b=mjyb6DNM6Br0lJjGLPlBaLtHhTzSTJPmgYCJJKJf9FlpejvrcPTwTS0ZMwjiZW1DifX0clqKgx6O5NZxnUy+untv6wn902BNPqx/Bn3gxmpqnFOnmS+fh99P1wbiv5jdObO4RfLIgkKOEGK95moeWMs32PIdmqr3WmkMyE9rBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778778; c=relaxed/simple;
	bh=vsALvB66YS+oJy282YuBqx/N0hfKCbNNomExS9wRJt8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JFA+W2ng789wTJ0/p1Z72Gt5EqoVOWJrB9UpUIS8ZE9EzpgRBi3RXo9iKT+Wan3DdORdtF4UYVmD2YXeEWltx0NV2fmVMzn/k/098LrRA5aYf9LGvTM2cIa1IYSPddgnNxWIKSTcDn2yVH3JctNZkSgWmLFwXtEkotYzbqU6BJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW+cqAVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF48C4CEF7;
	Wed, 29 Oct 2025 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761778778;
	bh=vsALvB66YS+oJy282YuBqx/N0hfKCbNNomExS9wRJt8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VW+cqAVChbcju/OS+KUzpStrv2sueDIYN9CDWXmcyU6K80XvHR5bH/bvA4geaO3DL
	 mXSsdy4o3zXxC8laWH8Ep2ziTb0BJ3UmVMUWrKgmdmjiN9ibuCh4BZh2NK8NXHuBoe
	 6H/xDPLgK0SFm39rE0XG8KAxuE8Kmix6baMVLLz4O2cLOxiLdfUP+I5FY6LgHYaSk+
	 lFNks44MYgpMFkF1inhro/puyOjhPF0i4nO3xGN2YrKOg82ZDKGzn2jrfaqgD41yiE
	 nbEEF2ZdwzqL53BwAhWdd5T5Ppd3UD9bc/5oY5WbOx65bRwHO817ivw4ousKa/+i4M
	 fG/7jrJfjFVeA==
Content-Type: multipart/mixed; boundary="===============7878305878613788522=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9f13992d679d08d193cb40c15c70fbf4adfe9d94a6235b20858fbe161be58a1@mail.kernel.org>
In-Reply-To: <20251029221315.2694841-3-maciej.fijalkowski@intel.com>
References: <20251029221315.2694841-3-maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v5 bpf 2/2] veth: update mem type in xdp_buff
From: bot+bpf-ci@kernel.org
To: maciej.fijalkowski@intel.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org
Cc: netdev@vger.kernel.org,magnus.karlsson@intel.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,toke@redhat.com,lorenzo@kernel.org,kuba@kernel.org,maciej.fijalkowski@intel.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 22:59:36 +0000 (UTC)

--===============7878305878613788522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 96d6e22337a81e8606de33d22173ff80ab961bc8
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

veth: update mem type in xdp_buff

The commit fixes a page_pool leak by properly detecting page_pool memory
and using appropriate reference counting APIs. The xdp_buff mem type is
now dynamically set based on skb->pp_recycle instead of always using
MEM_TYPE_PAGE_SHARED.

Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index a3046142c..187f30e2c 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
>  	}
>  }
>
> -static void veth_xdp_get(struct xdp_buff *xdp)
> +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>  {
>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>  	int i;
> @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>  		__skb_frag_ref(&sinfo->frags[i]);
>  }
>
> +static void veth_xdp_get_pp(struct xdp_buff *xdp)
> +{
> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> +	int i;
> +
> +	page_pool_ref_page(virt_to_page(xdp->data));
> +	if (likely(!xdp_buff_has_frags(xdp)))
> +		return;
> +
> +	for (i = 0; i < sinfo->nr_frags; i++) {
> +		skb_frag_t *frag = &sinfo->frags[i];
> +
> +		page_pool_ref_page(netmem_to_page(frag->netmem));
> +	}
> +}
> +
> +static void veth_xdp_get(struct xdp_buff *xdp)
> +{
> +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
> +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
> +}
> +

[ ... ]

> @@ -822,24 +831,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>  	case XDP_TX:
>  		veth_xdp_get(xdp);
>  		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
>  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
>  			trace_xdp_exception(rq->dev, xdp_prog, act);
>  			stats->rx_drops++;
>  			goto err_xdp;
>  		}

Can veth_xdp_rcv_skb() leak page references in the XDP_TX error path?
When veth_xdp_tx() fails, the code jumps to err_xdp without releasing
the page references acquired by veth_xdp_get(). The skb was already
consumed, so the pages still have the extra references from either
veth_xdp_get_pp() or veth_xdp_get_shared().

veth_xdp_tx() can return -EOVERFLOW when xdp_convert_buff_to_frame()
returns NULL, which is a reachable error path.

>  		stats->xdp_tx++;
> +		rq->xdp_rxq.mem = rq->xdp_mem;
>  		rcu_read_unlock();
>  		goto xdp_xmit;
>  	case XDP_REDIRECT:
>  		veth_xdp_get(xdp);
>  		consume_skb(skb);
> -		xdp->rxq->mem = rq->xdp_mem;
>  		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
>  			stats->rx_drops++;
>  			goto err_xdp;
>  		}

Similar question for the XDP_REDIRECT case - when xdp_do_redirect()
fails, does this also leak the page references taken by veth_xdp_get()?

>  		stats->xdp_redirect++;
> +		rq->xdp_rxq.mem = rq->xdp_mem;
>  		rcu_read_unlock();
>  		goto xdp_xmit;
>  	default:


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `veth: update mem type in xdp_buff`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18923812102

--===============7878305878613788522==--

