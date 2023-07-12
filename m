Return-Path: <bpf+bounces-4817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC7474FD20
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 04:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA963281752
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 02:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AD395;
	Wed, 12 Jul 2023 02:37:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F031182;
	Wed, 12 Jul 2023 02:37:45 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD81987;
	Tue, 11 Jul 2023 19:37:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b708e49059so100976501fa.3;
        Tue, 11 Jul 2023 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689129455; x=1691721455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADCOd4p+TNxKA3O8fQeclFRSALEHnH+Ken/uTXornfI=;
        b=S7VBb2jpxj0fdFjUfB/4olKFS2r6xy5YdpIiVXo/3z01kYrsumMQ9N+xEKxEcRk5HK
         ligxnzEll/MRWpAyPv5P1Tw4BDSk/gEoTRNrmS68DB4EjhQJRgVAQKsGXKME5rPypmMw
         SxqBekvAcZqtW5m9fc0S/GB/Toaer4oZigfEoeHMGR2HkompMEh1qbNLAD+BU1JKFm5s
         Ls4xUD7F46ZI3+V5HqMiBQMEwgYXmuSOBNxNYFQSMCUap0eBlCjacj3L+wgmdvZHj3TF
         Ggp7qhlygdzg/RmCzhpUithNYSzDwjvuZBnjBDQj32a4ojgReybnr1IKcB//14sHkjEn
         RDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689129455; x=1691721455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADCOd4p+TNxKA3O8fQeclFRSALEHnH+Ken/uTXornfI=;
        b=FLErZ+ujiIrz7xVzpu6lilc6AG/eexUN9Xyft/xf78A3VXtKz5enPSJ1cEgCJpK8C8
         p0v35gd23bsuoKbObnmX9FLLB0rOFxaKH67qMl2dk+WeJYjpc8oXb1iVdXXRGZOo9ws3
         9NRiJypj9SUVAcM5z34ZDaFz+Bh6c6cs3noqP0SlNhtg7bUeY2l2hpDzWa/X8jDaClAU
         KPh0sc7XCnf4Ksso79ULKHinVe+8x1zk+ubD2x6VmXtkf8iEJGUEhZDBPZZcZo//L6PF
         FOqDQfK43L02LAT/FUDkgLtRdDimvEVeA006zkuDfbg061EPHOHozOQiZfO6uyFrLrpG
         DzwA==
X-Gm-Message-State: ABy/qLZUDs6icLHimIaecXXNkR3K1G9X2nUaIJO2nKDTfbJDUAtYShRg
	ukM04YjAdS4heEdDOntP78nAths/kzgW4rRIWMWw6W0RJF0=
X-Google-Smtp-Source: APBJJlEfaTgLAP90EVDPWG1AyVXbL0U355vIE8aih/khypvHPoN1TbMFitlNivgR40va0gZEhxPsEdwIkz91tvYD96U=
X-Received: by 2002:a2e:3313:0:b0:2b6:fa3e:f2fa with SMTP id
 d19-20020a2e3313000000b002b6fa3ef2famr14053544ljc.32.1689129455256; Tue, 11
 Jul 2023 19:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <20230711173226.7e9cca4a@kernel.org>
In-Reply-To: <20230711173226.7e9cca4a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 19:37:23 -0700
Message-ID: <CAADnVQJ3iyoZaxaALWd4zTsDT3Z=czU4g7qpmBFWPUs5ucqCMg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 5:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Jul 2023 15:56:57 -0700 Alexei Starovoitov wrote:
> > I think this proves my point: csum is not generalizable even across vet=
h and mlx5.
> > Above is a square peg that tries to fit csum_start/offset api (that mak=
es sense from SW pov)
> > into HW that has different ideas about csum-ing.
> >
> > Here is what mlx5 does:
> > mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb=
,
> >                             struct mlx5e_accel_tx_state *accel,
> >                             struct mlx5_wqe_eth_seg *eseg)
> > {
> >         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
> >                 return;
> >
> >         if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {
> >                 eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM;
> >                 if (skb->encapsulation) {
>
> This should be irrelevant today, as LCO exists?

Hmm. Maybe. But LCO is an example that prog devs have to be aware of
and use it properly.
Meaning for certain protocols compute outer csum LCO way and
let inner go through HW csuming.
In this case I have no idea what these mlx5 flags do.
I hope this part of the code was tested with udp tunnels.

> >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L3_INNER_CSUM =
|
> >                                           MLX5_ETH_WQE_L4_INNER_CSUM;
> >                         sq->stats->csum_partial_inner++;
> >                 } else {
> >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L4_CSUM;
> >                         sq->stats->csum_partial++;
> >                 }
> >
> > How would you generalize that into csum api that will work across NICs =
?
> >
> > My answer stands: you cannot.
> >
> > My proposal again:
> > add driver specifc kfuncs and hooks for things like csum.
> >
> > Kuba,
> > since you nacked driver specific stuff please suggest a way to unblock =
this stalemate.
>
> I hope I'm not misremembering but I think I suggested at the beginning
> to create a structure describing packet geometry and requested offloads,
> and for the prog fill that in.

hmm. but that's what skb is for. skb =3D=3D packet geometry =3D=3D
layout of headers, payload, inner vs outer, csum partial, gso params.

bpf at tc layer supposed to interact with that correctly.
If the packet is modified skb geometry should be adjusted accordingly.
Like BPF_F_RECOMPUTE_CSUM flag in bpf_skb_store_bytes().

>
> All operating systems I know end up doing that, we'll end up doing
> that as well. The question is whether we're willing to learn from
> experience or prefer to go on a wild ride first...

I don't follow. This thread was aimed to add xdp layer knobs.
To me XDP is a driver level. 'struct xdp_md' along with
BPF_F_XDP_HAS_FRAGS is the best abstraction we could do generalizing
dma-buffers (page and multi-page) that drivers operate on.
Everything else at driver level is too unique to generalize.
skb layer is already doing its job.

In that sense "generic XDP" is a feature for testing only.
Trying to make "generic XDP" fast is missing the point of XDP.

AF_XDP is a different concept. Exposing timestamp,
csum, TSO to AF_XDP users is a different design challenge.
I'm all for doing that, but trying to combine "timestamp in xdp tx"
and "timestamp in AF_XDP" will lead to bad trade-off-s for both.
Which I think this patchset demonstrates.

