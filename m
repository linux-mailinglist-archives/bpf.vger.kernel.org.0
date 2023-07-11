Return-Path: <bpf+bounces-4809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA16274FBD4
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B301C20E4C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C8B1ED52;
	Tue, 11 Jul 2023 23:25:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EDD1ED4D
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 23:25:11 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5865E7A
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:25:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so3119431a91.3
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689117907; x=1691709907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjl/p6TfEuAEGTGhoCvTJev9/k2QieEkED5ztCWsQvw=;
        b=eeSYzPYXng3ALfv56WXNa7sBb5UZb+g2FuutmlZDYec75/hK07M4fMAR6badnB+c4Z
         xqOaPnHDsH2re48KWzUNGaeLvdZZ6RqjhnOyFyR90CW7MPbGIlqgpiZ2rLYZ+QXZouDP
         T6bBZghjTl+a6bOZhz8uR8lLEzhcra8hFQgKUXQ4T6/RkCMQxTYdbfEhuj3bQLafR/xP
         Rju8eWKzOibbZPQkBE+sKMBFfOVK/OEdXKmmBMd9nHSOUex4o/8r1L7nLGLg/qCcpETF
         DDTcTUogK6YVLwZv8UgS/+gWsr0ru8eYN2zcKl934TKbDhstc9pto9mJE7GtEfCYj+7c
         vxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689117907; x=1691709907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjl/p6TfEuAEGTGhoCvTJev9/k2QieEkED5ztCWsQvw=;
        b=RfP4AtjuVqCcDv7Ahy4HFejt71P+faUzau3oLo7uLlz1kbi11tTSIsMUPolWyeVKte
         FvbB/2qFApZlyqsSMMHSMAqpnsu/NPyUY3yCsUWiKXS1iVHXme8xlHYEhMXmldfSjliC
         eUChDYvFqenjNjWU++MWLVXWV1mdPpGsjAP7kjEOyd/J/YOntYNXHgOrTtgNLtTjxJDN
         QmIjnLXV2w6bIrmHngCUpqY+jxY5CzCuwidwbfAYEirMK7LT859FV/G/NxQcPHvBdg2Z
         ad48oJrxfwH+taaO/G1Dq07zNrw2/OORzU2gX5XP+/9MxQMoBlXl2Um/5CXc9aKyk/XK
         VvMA==
X-Gm-Message-State: ABy/qLamZUWFDsdjqh2V7B3dZNAan4ZLaJccnVRVA5wEkV7GoIwjPuAu
	TwVa0NYaLAzw+Ee4hlMpgRlPRin95m/V21hg3ngqLA==
X-Google-Smtp-Source: APBJJlFbOGo5te+kAJKnSNfpGTq/05Y/zj9ffclbvX7sqta/MhhloEK0KgQmWnotVpW76yAMJHFd1tpddN6ypahu/50=
X-Received: by 2002:a17:90b:906:b0:263:71f0:1569 with SMTP id
 bo6-20020a17090b090600b0026371f01569mr12562030pjb.3.1689117907240; Tue, 11
 Jul 2023 16:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
In-Reply-To: <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 11 Jul 2023 16:24:54 -0700
Message-ID: <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 3:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrote:
> > +
> > +static int mlx5e_devtx_request_l4_checksum(const struct devtx_ctx *_ct=
x,
> > +                                        u16 csum_start, u16 csum_offse=
t)
> > +{
> > +     const struct mlx5e_devtx_ctx *ctx =3D (void *)_ctx;
> > +     struct mlx5_wqe_eth_seg *eseg;
> > +
> > +     if (unlikely(!ctx->wqe))
> > +             return -ENODATA;
> > +
> > +     eseg =3D &ctx->wqe->eth;
> > +
> > +     switch (csum_offset) {
> > +     case sizeof(struct ethhdr) + sizeof(struct iphdr) + offsetof(stru=
ct udphdr, check):
> > +     case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offsetof(st=
ruct udphdr, check):
> > +             /* Looks like HW/FW is doing parsing, so offsets are larg=
ely ignored. */
> > +             eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_L4=
_CSUM;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
>
> I think this proves my point: csum is not generalizable even across veth =
and mlx5.
> Above is a square peg that tries to fit csum_start/offset api (that makes=
 sense from SW pov)
> into HW that has different ideas about csum-ing.
>
> Here is what mlx5 does:
> mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>                             struct mlx5e_accel_tx_state *accel,
>                             struct mlx5_wqe_eth_seg *eseg)
> {
>         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)))
>                 return;
>
>         if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {
>                 eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM;
>                 if (skb->encapsulation) {
>                         eseg->cs_flags |=3D MLX5_ETH_WQE_L3_INNER_CSUM |
>                                           MLX5_ETH_WQE_L4_INNER_CSUM;
>                         sq->stats->csum_partial_inner++;
>                 } else {
>                         eseg->cs_flags |=3D MLX5_ETH_WQE_L4_CSUM;
>                         sq->stats->csum_partial++;
>                 }
>
> How would you generalize that into csum api that will work across NICs ?
>
> My answer stands: you cannot.
>
> My proposal again:
> add driver specifc kfuncs and hooks for things like csum.

I do see your point, but to also give you my perspective: I have no
clue what those _CSUM tx bits do (as a non-mlx employee). And what
kind of packets they support (initial patch doesn't give any info).
We can definitely expose mlx5 specific request_l4_checksum(bool encap)
which does things similar to mlx5e_txwqe_build_eseg_csum, but then,
what does it _actually_ do? It obviously can't checksum arbitrary
packet formats (because it has this inner/outer selection bit), so
there is really no way for me to provide a per-driver kfunc api. Maybe
the vendors can?

So having csum_start/csum_offset abstraction which works with fixed
offsets seems like at least it correctly sets the expectation for BPF
program writers.
The vendors are already supposed to conform to this start/offset API for sk=
b.

But back to your point: should we maybe try to meet somewhere in the middle=
?
1. We try to provide "generic" offload kfuncs; for mlx5, we'll have
this mlx5e_devtx_request_l4_checksum which works for fixed offsets
2. We also let vendors do device-specific "extensions" where devices
deviate too much: bpf_request_RAW_mlx5e_l4_checksum(bool encap)
This can give BPF authors opportunity to write somewhat portable
programs and also use vendor specific apis when/if needed.

I think we had a similar idea for rx side: have generic kfuncs, but
also let vendors experiment with custom kfuncs if they want to
differentiate.
WDYT? Can it give us the best things from both sides?

> Kuba,
> since you nacked driver specific stuff please suggest a way to unblock th=
is stalemate.

