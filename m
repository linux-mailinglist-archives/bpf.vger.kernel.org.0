Return-Path: <bpf+bounces-4824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C374FDB5
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D904281447
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CE138D;
	Wed, 12 Jul 2023 03:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F697F9
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 03:29:50 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA384E5C
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 20:29:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b82f399f9so6573109a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689132588; x=1691724588;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR3SFxNwogwPIxraOw2MMFrUVESGPtNtTKDU/aIogEc=;
        b=UwJNOl06PpkdtQzDuLtRmc0/ryP640Vt3HY1Bu4tKKV+8R/IUDUZ648BQOSKzctdgL
         +aR/du5aUL6wBRNWrXzAIwspLbO+HFVlz9DoJXpR+gkzeGJs9wtaGouhTYcUFmucFLBI
         M/yXKjigq4Pmk9JNGO5fYc7uOWm3/4crtkVwTS0EtK3fatUDKTyMqM06hsCLryaN233B
         dFJkrxJZy+SqeWPKSOaa+fQn+A2Ka8FJcj+aof+m2XAdgSheHX9Vh98tp/Nh1izGcId4
         1mzY9auYHP4lWuPL6v594w1GJc3QVKJQ9BF+bkbyXakbs0ON6EQvJVl1UFWNNsIQCKVj
         KaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689132588; x=1691724588;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jR3SFxNwogwPIxraOw2MMFrUVESGPtNtTKDU/aIogEc=;
        b=lwyVpqu5H60OlSPkTgU7rzmvVIt17jNEiLlSKElACmoteMhY7wastlGMqNYZxcHo12
         TpuB9glPk3I83Rk1cIBhUh2hoNfgovm5oUdq5ttOtG2FlrI9+RqmSeiPoGFU1JmhLC8D
         RhJYr4xlScrQSHnE8EIRCiQ4rlg3fGQXyccs28xlX5Sagz2/bkPPVHBX9B2rAuiCz3Gu
         e3sJnl4HncHoMH+3cvTKRzpgz/i+BM+vvMvQd2yK6n/lUF8dLylDVkd+W1JGCUzFnN5j
         w9Bx36ebBXdytaDjmiYHaLfYpk5b7W86GOMfUfOvmY849IF1HEuwsHBR3OizUcYW4quz
         W1Wg==
X-Gm-Message-State: ABy/qLYIaJHtojkgE8/30FhN6NSst3WOy9eQi0BcUs1CSQZYkd7mnms1
	+trUdlIsZnmwybgZUrE2ijatQOc=
X-Google-Smtp-Source: APBJJlGU4NAVv+83MDYJ5l2f4iKmcDFB57NtJujxA9OPHR+fZPnZwHfrUU8jHynGkGBIERWwI+jXjFo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9d4d:0:b0:55a:f882:137 with SMTP id
 i74-20020a639d4d000000b0055af8820137mr9663845pgd.5.1689132588154; Tue, 11 Jul
 2023 20:29:48 -0700 (PDT)
Date: Tue, 11 Jul 2023 20:29:46 -0700
In-Reply-To: <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
 <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com> <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
Message-ID: <ZK4eFox0DwbpyIJv@google.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=" <toke@kernel.org>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	magnus.karlsson@intel.com, 
	"=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>, maciej.fijalkowski@intel.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/11, Alexei Starovoitov wrote:
> On Tue, Jul 11, 2023 at 5:15=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On Tue, Jul 11, 2023 at 4:45=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 4:25=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> > > >
> > > > On Tue, Jul 11, 2023 at 3:57=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrot=
e:
> > > > > > +
> > > > > > +static int mlx5e_devtx_request_l4_checksum(const struct devtx_=
ctx *_ctx,
> > > > > > +                                        u16 csum_start, u16 cs=
um_offset)
> > > > > > +{
> > > > > > +     const struct mlx5e_devtx_ctx *ctx =3D (void *)_ctx;
> > > > > > +     struct mlx5_wqe_eth_seg *eseg;
> > > > > > +
> > > > > > +     if (unlikely(!ctx->wqe))
> > > > > > +             return -ENODATA;
> > > > > > +
> > > > > > +     eseg =3D &ctx->wqe->eth;
> > > > > > +
> > > > > > +     switch (csum_offset) {
> > > > > > +     case sizeof(struct ethhdr) + sizeof(struct iphdr) + offse=
tof(struct udphdr, check):
> > > > > > +     case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + off=
setof(struct udphdr, check):
> > > > > > +             /* Looks like HW/FW is doing parsing, so offsets =
are largely ignored. */
> > > > > > +             eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM | MLX5_ET=
H_WQE_L4_CSUM;
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > >
> > > > > I think this proves my point: csum is not generalizable even acro=
ss veth and mlx5.
> > > > > Above is a square peg that tries to fit csum_start/offset api (th=
at makes sense from SW pov)
> > > > > into HW that has different ideas about csum-ing.
> > > > >
> > > > > Here is what mlx5 does:
> > > > > mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buf=
f *skb,
> > > > >                             struct mlx5e_accel_tx_state *accel,
> > > > >                             struct mlx5_wqe_eth_seg *eseg)
> > > > > {
> > > > >         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, e=
seg)))
> > > > >                 return;
> > > > >
> > > > >         if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {
> > > > >                 eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM;
> > > > >                 if (skb->encapsulation) {
> > > > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L3_INNER=
_CSUM |
> > > > >                                           MLX5_ETH_WQE_L4_INNER_C=
SUM;
> > > > >                         sq->stats->csum_partial_inner++;
> > > > >                 } else {
> > > > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L4_CSUM;
> > > > >                         sq->stats->csum_partial++;
> > > > >                 }
> > > > >
> > > > > How would you generalize that into csum api that will work across=
 NICs ?
> > > > >
> > > > > My answer stands: you cannot.
> > > > >
> > > > > My proposal again:
> > > > > add driver specifc kfuncs and hooks for things like csum.
> > > >
> > > > I do see your point, but to also give you my perspective: I have no
> > > > clue what those _CSUM tx bits do (as a non-mlx employee). And what
> > > > kind of packets they support (initial patch doesn't give any info).
> > > > We can definitely expose mlx5 specific request_l4_checksum(bool enc=
ap)
> > > > which does things similar to mlx5e_txwqe_build_eseg_csum, but then,
> > > > what does it _actually_ do? It obviously can't checksum arbitrary
> > > > packet formats (because it has this inner/outer selection bit), so
> > > > there is really no way for me to provide a per-driver kfunc api. Ma=
ybe
> > > > the vendors can?
> > > >
> > > > So having csum_start/csum_offset abstraction which works with fixed
> > > > offsets seems like at least it correctly sets the expectation for B=
PF
> > > > program writers.
> > > > The vendors are already supposed to conform to this start/offset AP=
I for skb.
> > > >
> > > > But back to your point: should we maybe try to meet somewhere in th=
e middle?
> > > > 1. We try to provide "generic" offload kfuncs; for mlx5, we'll have
> > > > this mlx5e_devtx_request_l4_checksum which works for fixed offsets
> > >
> > > But it doesn't.
> > > Even if you add a check for csum_start (that's missing in the patch)
> > > there need to be a way to somehow figure out
> > > whether skb->encapsulation is true and set appropriate flags.
> > > Otherwise this request csum will do "something" that only the HW vend=
or knows.
> > > That would be even harder to debug for bpf prog writers.
> > >
> > > So instead of helping bpf prog devs it will actively hurt them.
> >
> > Can we make it more robust? The device can look at the payload (via
> > descriptors or extra payload pointer via devtx_ctx) and verify
> > h_proto/nexthdr.
> > It won't be perfect, I agree, but we can get it working for the common
> > cases (and have device-specific kfuncs for the rest).
>=20
> More robust with more checks ?
> That will slow things down and the main advantage of XDP vs skb
> layer will be lost.
> It's best to stay at skb then when csum and timestamp is available.

This will slow things down, but not to the point where it's on par
with doing sw checksum. At least in theory.
We can't stay at skb when using AF_XDP. AF_XDP would benefit from having
the offloads.

> > > Another example. If bpf prog was developed and tested on veth
> > > it will work for some values of csum_offset on real HW and will -EINV=
AL
> > > for the other values.
> > > Just horrible user experience comparing to the case where
> > > the user knows that each netdev is potentially different and
> > > _has_ to develop and test their prog on the given HW NIC and
> > > not assume that the kernel can "do the right thing".
> >
> > For this, I was actually thinking that we need to provide some
> > SW-based fallback mechanism.
> > Because if I have a program and a nic that doesn't have an offload
> > implemented at all, having a fallback might be useful:
> >
> > if (bpf_devtx_request_l4_csum(...)) {
> >   /* oops, hw bailed on us, fallback to sw and expose a counter */
> >   bpf_devtx_l4_csum_slowpath(csum_start, csum_offset, data, len);
> >   pkt_sw_csum++;
> > }
> >
> > This is probably needed regardless of which way we do it?
>=20
> sw fallback? We already have 'generic XDP' and people misuse it
> thinking it's a layer they should be using.
> It's a nice feeling to say that my XDP prog was developed
> and tested on mlx5, but I can move it to a different server
> with brand new NIC that doesn't support XDP yet and my prog will
> still work because of "generic XDP".
> I think such devs are playing with fire and will be burned
> when "generic XDP" NIC will be DDoSed.

This is user controlled. The users might as well chose to
not fallback to sw by not calling another helper and fail hard.

I agree with generic xdp concerns and veth path being deceptive,
but I also believe they serve their purpose of getting user's feet
wet before they switch to experimenting with real devices:
you get most of you program working and polish it up on the real HW.

Moving to a different NIC will obviously require testing. But the
difference with generic APIs is that the programs will mostly work
and won't have to be completely rewritten.

> Same thing here. If we do HW offload of csum it's better be in HW.
> Devs have to be 100% certain that HW is offloading it.

I hope we can both agree that with an api like
mlx5_l4_csum_offload(bool encap) we can't be 100% certain that the
hw is gonna handle any packet layout? So how is that different
from a generic api that also can't work in all cases?

> > Regarding veth vs non-veth: we already have similar issues with
> > generic xdp vs non-generic.
> > I'm not sure we can completely avoid having surprises when switching
> > from sw to hw paths.
> > It's whether the users will have to debug 10-20% of their program or
> > they'd have to start completely from scratch for every nic.
>=20
> If rewrite for a nic is not acceptable then they should be using skb laye=
r.

AF_XDP is a generic layer for low-level access and it provides generic
descriptor format, so why suddenly we have this requirement where we have
to do prog rewrite for every new nic?

Current AF_XDP programs are pretty portable (obviously depend on
a bunch of nic features), it seems like a good idea to try to preserve
this property? (again, with an asterisk, where we should allow some
differentiation, etc, etc)

> > > This csum exercise is clear example that kernel is not in a position
> > > to do so.
> > > For timestamp it's arguable, but for csum there is no generic api tha=
t
> > > kernel can apply universally to NICs.
> >
> > Sure, I agree, it's a mix of both. For some offloads, we can have
> > something common, for some we can't.
> > But I'm not sure why we have to pick one or another. We can try to
> > have common apis (maybe not ideal, yes) and we can expose vendor
> > specific ones if there is need.
> > If the generic ones get unused - we kill them in the future. If none
> > of the vendors comes up with non-generic ones - the generic ones are
> > good enough.
> >
> > I'm assuming you favor non-generic ones because it's easier to implemen=
t?
>=20
> Not only.
> yes, it's easier to implement, but the expectations are also clear.
> The kernel won't be trying to fall back to the slow path.
> XDP prog will tell HW 'do csum' and HW will do it.
> For generality we have an skb layer.

(seems like I've addressed these points above, I don't see anything
extra here)

