Return-Path: <bpf+bounces-4812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCC74FC06
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 02:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02351C20C44
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414C362;
	Wed, 12 Jul 2023 00:15:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB7182
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 00:15:08 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFF171C
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:15:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-263121cd04eso3248833a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689120906; x=1691712906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0A2bjKs1pYZZoObbo7/lrHj3cq/338Hnh+WNA9RCo8=;
        b=wXWruCHNUqV/MRW6hVI0mmetK3kn9+RpPA2LsQkJxuJIOtnR4V5o2QwH/7aA20w011
         ROq2zJy0Jbu511CaS+pgKYb2+KKacJ9tJzHdhbGlwOgWisAMkOO/gPnZwrNtch5MPl+L
         YnUPFVD0u1gztbzlBa/AlOBq61LK1rRGtW3zvJluHbj6+ul+tHUPfpvqecl3qUH/dBvZ
         sfixKlrwngdqXqpqmAWVaevSToUSbDMn3yHZDkFvBaSsncf5J7l0NUE6E66+9gUwwpK1
         wODGyGM/8Krcc5fxLvaAeZQ/v4IqoEyXcdG4iZG/GKRpwfnWpLx+YxUvNd0t7Eb3/suv
         Rj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689120906; x=1691712906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0A2bjKs1pYZZoObbo7/lrHj3cq/338Hnh+WNA9RCo8=;
        b=PtLgOXfZUcofAYXn2wO29PnDXr7+kUW9dyO42R7biNq9mG/mPixhRU49+p5RUwnmDE
         fCv9QLsfnlw8My/4Gh/KYJVhI1woEcl2iiSrtjhmyHfZw8CyxiLQ8kq/4KqbNHq0PYHj
         DWJuZErMe+5GWd64XRnrtS5HClwYEnc9r2sTCLiNH6KjInf5C+XH1EyXSctoOXB5gT5V
         uLRe1+f01vTCtRP8byDrX/Nyv8Hrz6qBQQWvqlM07vesSOCQ1qJHULo/XzINkwLjIYHs
         347F3lVi/RgKl8hdWG+jgvp2Fls7dQMwm6Zho+C/w76QN86OSvsI7Ms46jsy9rJV4Y/+
         Rr2g==
X-Gm-Message-State: ABy/qLZJsSzyhQYrzbcf6LVrXBBLKqc1s66UIGSfhDFNKFts7Znh6OKi
	y415BSCHdzaA44Z1QZZOLUeHA/zdWkl1TSbeCDhj2w==
X-Google-Smtp-Source: APBJJlHXAWVpufjRIkjfml4mU/CCM9bvptg63RhX3xILF3gv9N19NVK4rVSSUiywOOt/kGyYr5o0Uel/YSKDCH4M6tI=
X-Received: by 2002:a17:90a:9293:b0:262:f0d0:97c0 with SMTP id
 n19-20020a17090a929300b00262f0d097c0mr14565055pjo.32.1689120906375; Tue, 11
 Jul 2023 17:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
In-Reply-To: <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 11 Jul 2023 17:14:54 -0700
Message-ID: <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 4:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 11, 2023 at 4:25=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Tue, Jul 11, 2023 at 3:57=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrote:
> > > > +
> > > > +static int mlx5e_devtx_request_l4_checksum(const struct devtx_ctx =
*_ctx,
> > > > +                                        u16 csum_start, u16 csum_o=
ffset)
> > > > +{
> > > > +     const struct mlx5e_devtx_ctx *ctx =3D (void *)_ctx;
> > > > +     struct mlx5_wqe_eth_seg *eseg;
> > > > +
> > > > +     if (unlikely(!ctx->wqe))
> > > > +             return -ENODATA;
> > > > +
> > > > +     eseg =3D &ctx->wqe->eth;
> > > > +
> > > > +     switch (csum_offset) {
> > > > +     case sizeof(struct ethhdr) + sizeof(struct iphdr) + offsetof(=
struct udphdr, check):
> > > > +     case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offseto=
f(struct udphdr, check):
> > > > +             /* Looks like HW/FW is doing parsing, so offsets are =
largely ignored. */
> > > > +             eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQ=
E_L4_CSUM;
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > >
> > > I think this proves my point: csum is not generalizable even across v=
eth and mlx5.
> > > Above is a square peg that tries to fit csum_start/offset api (that m=
akes sense from SW pov)
> > > into HW that has different ideas about csum-ing.
> > >
> > > Here is what mlx5 does:
> > > mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *s=
kb,
> > >                             struct mlx5e_accel_tx_state *accel,
> > >                             struct mlx5_wqe_eth_seg *eseg)
> > > {
> > >         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, eseg)=
))
> > >                 return;
> > >
> > >         if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {
> > >                 eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM;
> > >                 if (skb->encapsulation) {
> > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L3_INNER_CSU=
M |
> > >                                           MLX5_ETH_WQE_L4_INNER_CSUM;
> > >                         sq->stats->csum_partial_inner++;
> > >                 } else {
> > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L4_CSUM;
> > >                         sq->stats->csum_partial++;
> > >                 }
> > >
> > > How would you generalize that into csum api that will work across NIC=
s ?
> > >
> > > My answer stands: you cannot.
> > >
> > > My proposal again:
> > > add driver specifc kfuncs and hooks for things like csum.
> >
> > I do see your point, but to also give you my perspective: I have no
> > clue what those _CSUM tx bits do (as a non-mlx employee). And what
> > kind of packets they support (initial patch doesn't give any info).
> > We can definitely expose mlx5 specific request_l4_checksum(bool encap)
> > which does things similar to mlx5e_txwqe_build_eseg_csum, but then,
> > what does it _actually_ do? It obviously can't checksum arbitrary
> > packet formats (because it has this inner/outer selection bit), so
> > there is really no way for me to provide a per-driver kfunc api. Maybe
> > the vendors can?
> >
> > So having csum_start/csum_offset abstraction which works with fixed
> > offsets seems like at least it correctly sets the expectation for BPF
> > program writers.
> > The vendors are already supposed to conform to this start/offset API fo=
r skb.
> >
> > But back to your point: should we maybe try to meet somewhere in the mi=
ddle?
> > 1. We try to provide "generic" offload kfuncs; for mlx5, we'll have
> > this mlx5e_devtx_request_l4_checksum which works for fixed offsets
>
> But it doesn't.
> Even if you add a check for csum_start (that's missing in the patch)
> there need to be a way to somehow figure out
> whether skb->encapsulation is true and set appropriate flags.
> Otherwise this request csum will do "something" that only the HW vendor k=
nows.
> That would be even harder to debug for bpf prog writers.
>
> So instead of helping bpf prog devs it will actively hurt them.

Can we make it more robust? The device can look at the payload (via
descriptors or extra payload pointer via devtx_ctx) and verify
h_proto/nexthdr.
It won't be perfect, I agree, but we can get it working for the common
cases (and have device-specific kfuncs for the rest).

> Another example. If bpf prog was developed and tested on veth
> it will work for some values of csum_offset on real HW and will -EINVAL
> for the other values.
> Just horrible user experience comparing to the case where
> the user knows that each netdev is potentially different and
> _has_ to develop and test their prog on the given HW NIC and
> not assume that the kernel can "do the right thing".

For this, I was actually thinking that we need to provide some
SW-based fallback mechanism.
Because if I have a program and a nic that doesn't have an offload
implemented at all, having a fallback might be useful:

if (bpf_devtx_request_l4_csum(...)) {
  /* oops, hw bailed on us, fallback to sw and expose a counter */
  bpf_devtx_l4_csum_slowpath(csum_start, csum_offset, data, len);
  pkt_sw_csum++;
}

This is probably needed regardless of which way we do it?

Regarding veth vs non-veth: we already have similar issues with
generic xdp vs non-generic.
I'm not sure we can completely avoid having surprises when switching
from sw to hw paths.
It's whether the users will have to debug 10-20% of their program or
they'd have to start completely from scratch for every nic.

> This csum exercise is clear example that kernel is not in a position
> to do so.
> For timestamp it's arguable, but for csum there is no generic api that
> kernel can apply universally to NICs.

Sure, I agree, it's a mix of both. For some offloads, we can have
something common, for some we can't.
But I'm not sure why we have to pick one or another. We can try to
have common apis (maybe not ideal, yes) and we can expose vendor
specific ones if there is need.
If the generic ones get unused - we kill them in the future. If none
of the vendors comes up with non-generic ones - the generic ones are
good enough.

I'm assuming you favor non-generic ones because it's easier to implement?
But most of the netdev-bound infra is already there for rx, so there
is really not a lot of extra code to reuse it at tx. (it's two lines
to allow tracing progs to be dev-bound and to check whether devices
match at attach).
Or is there some other reason I'm missing?

> > 2. We also let vendors do device-specific "extensions" where devices
> > deviate too much: bpf_request_RAW_mlx5e_l4_checksum(bool encap)
> > This can give BPF authors opportunity to write somewhat portable
> > programs and also use vendor specific apis when/if needed.
> >
> > I think we had a similar idea for rx side: have generic kfuncs, but
> > also let vendors experiment with custom kfuncs if they want to
> > differentiate.
> > WDYT? Can it give us the best things from both sides?
> >
> > > Kuba,
> > > since you nacked driver specific stuff please suggest a way to unbloc=
k this stalemate.

