Return-Path: <bpf+bounces-67367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28437B42DC0
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E8B567ED6
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CE730EF77;
	Wed,  3 Sep 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FOlDAg0m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485593019A0
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943856; cv=none; b=FGlA79RVxGKJOUOnTHupMedc+ikbZC5VHSip7rHIwCO4mzFTwjqfomyyMYKH4A6rmC1IQCDOvQ6EhiM3DSeUPDypbvHv4ydttiSf754wUp3YUeAPHtNgQ9vyk5kAq+riW0rh8fJAjBQDkLKd0v9Y81Kcj68pt5bosRvLfCSKVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943856; c=relaxed/simple;
	bh=SUFI4fwiX0pBPTs7+ouWpfjlXTs2fFG0hyy+3BztGSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghgPMUtT1/GhCipzcYudXAXaZhzMUkG0Q14MxqMwnxG9Mxn1gcD4vvtSqmoN6MrN9lIcbZj8dEUFtGIEDSXVNUPAVevMX1U9oW+RjLavv0Zit/DBj3karZgJn7KuCOzSaYePjgiEU8UcmpXUeqAQOwOTwIjpv5kwpJvWYpHsv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FOlDAg0m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5608d792558so402788e87.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756943852; x=1757548652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv09e4Lt/OLR/n/FcaiPwgpNIdknD6J+E8y3JnmMEsw=;
        b=FOlDAg0mMvNaWa5svhyW/LaL4AT92V53zu6nuO774DA67WaCIVMPo63As4JuLuixZF
         e2TThcAT1YyJtsZCMTqI4tgV7Tz5sWO6Kz6TbhgOuU4ierlL6tBfEjilf+KcnRbLgAfx
         TKvPTcm1+tZ6t2QAD0lB78/3wfXvyTMsHnatI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943852; x=1757548652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv09e4Lt/OLR/n/FcaiPwgpNIdknD6J+E8y3JnmMEsw=;
        b=p/khDZf3fy40yAbKhGsKI7Emzt6wQ+ERnQ4QIXIFhF7m4cFEEaiEWzNSaJHCWM5kXu
         5EOM/6cpV9UkBZhUGvHOHumb6WwYoigXHixZkCFDRe2khmRmwSV1NeueDjofbFpsUweq
         4wbdHkKsYERFPvEed4VjataYg6wamw4NplWmoprN4IeHy30OLyvydXzGZRwQpNaGsjoi
         7ZmZHM/CpUEAG5mijidTSKxlNj2dHUquazgOnd8kzbXPSHEEW1bdRbsKW3kdQyLQfuaW
         kRsPBHZkxn3nOHIUstfiVT1JbHyTpHRx/umhA6jL/p0dL/xPvav5yw7OLZNqdLAlDudT
         MZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEPTszHfGv9bc2idobkQlus6f7ZaofjXGzIirMPJayyxOYG+2+KACWurWwvSLPyEO02vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhaf3/q96ETPuyYl/dPeX845paJt6e9uAK4glSpyJT/C8EnaW
	ryS908AAt8FDv5Bg64UAGo4rFNEn6FQH33Uxz44iROUCJY8N3hlEhXvPapoqITHxEkK6GZ/Rl+L
	Joqo2jnI5V4U1d/ZQ/RJmcd3EVlZZ5zrBXXh67lyFSg==
X-Gm-Gg: ASbGncuNXIxpAWcdZkjeOQD/sqG2nIJ3qTk8msMQ2cqPFpqTFUbJLoEA9Ihgf3vI3+/
	YgBEmClfm8PgwdSaZrdck5OQdQKOgD3+Noev+yfx2HnPhqwTcS8381PdlR1e53iaQJgdTPtePIj
	0zw12de4qAxmwajOjCv87bNqR3hZnkNQRKhxdxj4K2kx93p5SaHVw8w42wOTIbYV5M5DNuf8AKp
	LrX+aUpYzQmasU5BVvNY1aOwTtdw7fbEh0q0tiPz0VZlw5iEScMng0dyJxKiW3ULw==
X-Google-Smtp-Source: AGHT+IGbfS54Qvlf3EmjlTU6FR8DV3xID1CvDF3YSGWCmbcuFezhFih12dZx/PfGzkY4crFSlHcgYjsHQ9Nf3+VX3fI=
X-Received: by 2002:a05:6512:4381:b0:55f:4e8a:19a4 with SMTP id
 2adb3069b0e04-55f708b6079mr4267537e87.23.1756943852379; Wed, 03 Sep 2025
 16:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
 <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com>
In-Reply-To: <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 3 Sep 2025 16:57:21 -0700
X-Gm-Features: Ac12FXwt9zGovKtsi3q9pwxQj_g5H63amgYnMGWNl5-bfcInmOgb5rKBGXq_9aY
Message-ID: <CADg4-L_83eNn9huME6tuZKeQWyG2xkKCUj9erqzMBGxWt=NKcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
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

On Wed, Sep 3, 2025 at 4:39=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>
>
> On 8/28/25 8:36 PM, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
> > frag_list.
> >
> > This is of course not good when we are CPU-limited. Also causes a worse
> > skb->len/truesize ratio,...
> >
> > So, let's avoid copying parts of the payload to the linear part. We use
> > eth_get_headlen() to parse the headers and compute the length of the
> > protocol headers, which will be used to copy the relevant bits ot the
> > skb's linear part.
> >
> > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networki=
ng
> > stack needs to call pskb_may_pull() later on, we don't need to realloca=
te
> > memory.
> >
> > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC an=
d
> > LRO enabled):
> >
> > BEFORE:
> > =3D=3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >   87380  16384 262144    60.00    85094.90
> >
> > Additional tests across a larger range of parameters w/ and w/o LRO, w/
> > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differen=
t
> > TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> > better performance with this patch.
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad7789c3=
28456e3609440455d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >               dma_sync_single_for_cpu(rq->pdev, addr + head_offset, hea=
dlen,
> >                                       rq->buff.map_dir);
> >
> > +             headlen =3D eth_get_headlen(skb->dev, head_addr, headlen)=
;
> > +
>
> Hi,
>
> I am building on top of this patchset and got a kernel crash. It was
> triggered by attaching an xdp program.
>
> I think the problem is skb->dev is still NULL here. It will be set later =
by:
> mlx5e_complete_rx_cqe() -> mlx5e_build_rx_skb() -> eth_type_trans()

Hmmm... Not sure what happened here...
I'm almost certain I tested with xdp as well...

I will try again later/tomorrow.

Thanks!
Christoph

>
>
> >               frag_offset +=3D headlen;
> >               byte_cnt -=3D headlen;
> >               linear_hr =3D skb_headroom(skb);
> > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                               pagep->frags++;
> >                       while (++pagep < frag_page);
> >               }
> > +
> > +             headlen =3D eth_get_headlen(skb->dev, mxbuf->xdp.data, he=
adlen);
> > +
> >               __pskb_pull_tail(skb, headlen);
> >       } else {
> >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> >
>

