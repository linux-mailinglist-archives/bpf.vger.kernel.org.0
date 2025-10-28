Return-Path: <bpf+bounces-72591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBBC15F42
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52A53BC84D
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624463446BF;
	Tue, 28 Oct 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5dBpYUL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48882C0286;
	Tue, 28 Oct 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669941; cv=none; b=YExtVBQjkr+TcQDXFtQ6JUY82W3dI51C51GK59fXa1fKWzKGLT1lPh2Dkpw8tKZM2qgbHBqGcHeVnhYqxrcFvCWq3yARXu8IvZ6lxhUMxTXa/GJMARbhswNUk2yfgSfWwwBFUk5xNqrArZD6qGSNuQoBtcaUvhVyCtdJJCQyv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669941; c=relaxed/simple;
	bh=yZ330NEhhUvCg2S6l+06VAtonuQXNHscx1TyS7+WG44=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iOMcpPWXouzVnhI5Pk8z7aXoLQj2JlnIppGREzmqszvog3tO8hb4JqG3latFAAMBoWKxnQAOzxNWGDe9QKi8zsJLUaVPi6K03Epy+verywomD98ziRJ8TggQo0Z+zxwex9aXAl2mKuCiAVm8hSG76bs6o6PNUsRsIfTquEMPyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5dBpYUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BDEC4CEE7;
	Tue, 28 Oct 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761669941;
	bh=yZ330NEhhUvCg2S6l+06VAtonuQXNHscx1TyS7+WG44=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=e5dBpYULUxrSnDnOQzz+uIp+OJ5vu4cRX1YYbMz1hXEUgHJogVwcg3cSFTcYo+muG
	 kicl25pvM5xZao9UrOQU+5W2iaPV/ocTE6zR4/cPGm+YlEaRVzpcIxTDWr3zzfuBmD
	 W7CGS2PxAddzt+lMCJSx/hS3/d032DGhnyLzaJI/QY5578+shywIBwpwJgVvnIt4K1
	 7UNxhETCQZNyhJmh7diGjegG/E7Vqmq+zJQuUEVCgU4lgx2WHUykrVL9/6QKLDEorD
	 IobV54JNmhd1Hpc/gUeaUZWXFgIdlGXRg9VXOHo+GAowXUiNK1hzbJIXUNyiXEqZkl
	 QHcNvVh+3e2Ig==
Content-Type: multipart/mixed; boundary="===============0226383592031790764=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b54b160eacd11f9b17b8fed22313aa0c7344843b2a4d0b1a33553545b1b9a8e@mail.kernel.org>
In-Reply-To: <20251028160200.4204-2-fmancera@suse.de>
References: <20251028160200.4204-2-fmancera@suse.de>
Subject: Re: [PATCH 2/2 bpf] xsk: avoid data corruption on cq descriptor number
From: bot+bpf-ci@kernel.org
To: fmancera@suse.de,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,kerneljasonxing@gmail.com,fw@strlen.de,fmancera@suse.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Oct 2025 16:45:40 +0000 (UTC)

--===============0226383592031790764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 517548717cd8f9023f71443add6daabf21ef7135
Author: Fernando Fernandez Mancera <fmancera@suse.de>

xsk: avoid data corruption on cq descriptor number

This patch fixes data corruption in AF_XDP by migrating descriptor
information from skb->cb (which can be overwritten by other subsystems
after transmit) to skb XDP extension.

Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70..4f3fc005d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -727,16 +730,32 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  				return ERR_PTR(err);
>  		}
>  	} else {
> +		struct xdp_skb_ext *ext;
> +
>  		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
>  		if (!xsk_addr)
>  			return ERR_PTR(-ENOMEM);
>
> +		ext = skb_ext_find(skb, SKB_EXT_XDP);
> +		if (!ext) {
> +			ext = skb_ext_add(skb, SKB_EXT_XDP);
> +			if (!ext)
> +				return ERR_PTR(-ENOMEM);
                                ^^^^

In xsk_build_skb_zerocopy(), when skb_ext_add() fails after the
kmem_cache_zalloc() succeeds, does this leak the xsk_addr allocation?

The xsk_addr node is allocated first, then if skb_ext_add() returns
NULL, the function returns ERR_PTR(-ENOMEM) without freeing xsk_addr.
It hasn't been added to any list yet, so nothing will clean it up.

> +			memset(ext, 0, sizeof(*ext));
> +			INIT_LIST_HEAD(&ext->addrs_list);
> +			ext->num_descs = 1;
> +		} else if (ext->num_descs == 0) {
> +			INIT_LIST_HEAD(&ext->addrs_list);
> +			ext->num_descs = 1;
> +		}
> +
>  		/* in case of -EOVERFLOW that could happen below,
>  		 * xsk_consume_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
>  		xsk_addr->addr = desc->addr;
> -		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +		list_add_tail(&xsk_addr->addr_node, &ext->addrs_list);
> +		xsk_inc_num_desc(skb);
>  	}

[ ... ]

> @@ -804,6 +823,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			if (unlikely(err))
>  				goto free_err;
>
> +			if (!skb_ext_add(skb, SKB_EXT_XDP)) {
> +				err = -ENOMEM;
> +				goto free_err;
> +			}
> +
                ^^^^

In xsk_build_skb() on the first-descriptor path, when skb_ext_add()
succeeds, does the extension get initialized?

The code adds the extension but doesn't capture the returned pointer
or initialize it. Later, xsk_destruct_skb()->xsk_cq_submit_addr_locked()
will read ext->num_descs, and for multi-buffer packets, subsequent
descriptors will find this extension and try to use ext->addrs_list.

Without initialization, ext->num_descs contains garbage which could be
interpreted as > 1, and ext->addrs_list is an uninitialized list_head.
This can cause the destructor to iterate a corrupt list, or
list_add_tail() in the multi-buffer path to corrupt memory.

Compare with the subsequent-descriptor path at lines 856-870 where
the extension is properly initialized with memset() and INIT_LIST_HEAD()
when added.

>  			xsk_skb_init_misc(skb, xs, desc->addr);
>  			if (desc->options & XDP_TX_METADATA) {
>  				err = xsk_skb_metadata(skb, buffer, desc,

[ ... ]


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `xsk: avoid data corruption on cq descriptor number`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18881598580

--===============0226383592031790764==--

