Return-Path: <bpf+bounces-67521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A32B44A74
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3920F5867CD
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37C2F60CD;
	Thu,  4 Sep 2025 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0DaRo0A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFF422AE5D;
	Thu,  4 Sep 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757028629; cv=none; b=QIkSgGzHAW+YjB+zFvvSnf18t7oRmkfcbguwuX4pBOoshooNJ5BVDJoyeXvectOpA73IqYkbM5cd5ttKC1SLSlOrse7KBOcYyvzlSSRx0G+oQjkD65OvrLR+MJyxzOfdCfIqUT7JT7GV5ZjLooNfZAChO2QzURp7fzMz/y6Ba5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757028629; c=relaxed/simple;
	bh=p/rMtgcnAkAWxolDLeOwFR5vRIeJEU8J6COxczsLrGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYLflde/T2jpjONTzz8xSpLRvZ8KIPulHAZsH8dzCsXG95r6GljidLfBk/wrA2nqj1oh0AAz+ryBy2g886zYNL5XH6DfWhmsaapdyUk3tM4ixoIXQ6ppVhO1VRv2T60UluF8cBTsYkt7JFGhiln4ZO5haJZAmgKuXEpBLT/Ihz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0DaRo0A; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-723bc91d7a6so15421927b3.3;
        Thu, 04 Sep 2025 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757028626; x=1757633426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+Z4+to42C8w3A13cbDXdfgH5dFIJtyUfea10+gxoeA=;
        b=f0DaRo0AbEoEbMofmxqCW9boM3gN4ZZO28fPyHke/4Ztvsh3PNbIcv06YZ/pXuSTca
         6ODyJrgIz5VW10leLew9InX3vj9OG1hzjNNkLejZhzEwnKe9YkSvxPduu8iDf1bd0dB1
         kQuHx0UoNvkiUk5kyVPUoglOiM5nthhNeyw08ZcgO20KWvxbjpEtG1AnZ4vyaA5h9ks4
         fhg6Vaa9dEbZCpa4Z5dnKtdn3HKaUK76MO7hyzAJK7PFmH/pSF/OI6+sVkblReieSpMy
         BSXKKoIiP98cWTV+ECPDlmrzBGWXfHCYnWZjCPYnpSLx+UrAth4wlLriTuSKgvVPCTgD
         5p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757028626; x=1757633426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Z4+to42C8w3A13cbDXdfgH5dFIJtyUfea10+gxoeA=;
        b=E4DwrX0glY8LqOFUvjkTWkbeM7YEuslPi8JEiq1eFE3YOTJY/bo3CEOgYFTGZ9EyYj
         ECeq1zummeQSuzZ3AJ+6ZvQ2BjeHs74IcYkV/6ugyEdqfUzdZlgM8o3gVwkAPA2kRuTC
         Q7PfEq6QwF1jSbXQL86ff80608YwkdH09NJHADtsLZTrDMZkqDyawJe/cZuCkDi81Nhk
         J13s6qLAevGSCVJnmb7HC91gwNOsC0LG2JCByPxt4KWUudOxd9nKx7be9SWtgt6twtGB
         8Xd5fI/o5ozCbQ3NsSeOfm/Iwhqr/sZmLIgtUGBqO4diu+8qI+3W2sJ1PHL/HKietBca
         80fg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ11GFApqUXDrLh13+W2MLleAsoNUsp6InqmqQADr+UcDtpVXXk3aasjbSF8BFBA2Nkks=@vger.kernel.org, AJvYcCW/vTIzSQAHc7uf8OyhPr+HolbKD9cyvv3w8J+1dW76jx1lO+seMaJWgxVS6/I59ciW1wpAVkRrezZFOg==@vger.kernel.org, AJvYcCWRPYRFlHaqd+t0NDbrZX/w3waELk9LM/6tsSfZwyrvIAqlr2Gujknfbahi9Ei/PD13a1W8bx4V@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH9iJw4fD33z12WpztUNIW8KosHQUz1sOLxm8l7oKmqMntxXV
	IP9ge5PwCJqsc5oNJV7g1VhvtbxpBNaqNEZAhqImaJpv0acDgr5oCoMMbT1SEEukCb7A6RdZYJ3
	n7NF5+dTZi0Oqw7qCS+1FLXYFvAqAOMu9ww==
X-Gm-Gg: ASbGncsNJfPI44N4A5pWKBmvqj3vJpq1zwzvBLL05dW1YL45kIm2UIePRQsMK3SjWdJ
	YNq92JvYuanVyB1zwUlDzkgsy1unZOIe2WvzAsQoiR/U72vexYMEy5UhOSdIqjVzEygs4h9nV+O
	rF2HssyVqvHlOoR9BsV/sutmowtG63fcRdeGU+XcXOeGa6UQHj4eH2GUktIsuKNoh3wJ6jzRI8h
	ZKq2nc=
X-Google-Smtp-Source: AGHT+IFxHiIhchcqTWp5FAvNmEFHQVAcBHEEtR7SxE9kuYgkvu9oBt0tg+LRBBL9kKeFFidDxCqEJWWnaRDBERPhNTk=
X-Received: by 2002:a05:690c:9202:b0:722:875e:a32 with SMTP id
 00721157ae682-722875e0b3bmr191271377b3.36.1757028626261; Thu, 04 Sep 2025
 16:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
In-Reply-To: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Sep 2025 16:30:15 -0700
X-Gm-Features: Ac12FXwfut72qy1sNZwpakt6bOz4owWKuX40pGNLnJwPPapx7oK5dofv9m1oHxE
Message-ID: <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits ot the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60720d390de4=
5a5b6b453ed0a3f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                 dma_sync_single_for_cpu(rq->pdev, addr + head_offset, hea=
dlen,
>                                         rq->buff.map_dir);
>
> +               headlen =3D eth_get_headlen(rq->netdev, head_addr, headle=
n);
> +
>                 frag_offset +=3D headlen;
>                 byte_cnt -=3D headlen;
>                 linear_hr =3D skb_headroom(skb);
> @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                 pagep->frags++;
>                         while (++pagep < frag_page);
>                 }
> +
> +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->xdp.data, =
headlen);
> +

The size of mxbuf->xdp.data is most likely not headlen here.

The driver currently generates a xdp_buff with empty linear data, pass
it to the xdp program and assumes the layout If the xdp program does
not change the layout of the xdp_buff through bpf_xdp_adjust_head() or
bpf_xdp_adjust_tail(). The assumption is not correct and I am working
on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
will not contain any headers or payload. The thing that you try to do
probably should be:

        skb_frag_t *frag =3D &sinfo->frags[0];

        headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(frag),
skb_frag_size(frag));



>                 __pskb_pull_tail(skb, headlen);
>         } else {
>                 if (xdp_buff_has_frags(&mxbuf->xdp)) {
>
> --
> 2.50.1
>
>

