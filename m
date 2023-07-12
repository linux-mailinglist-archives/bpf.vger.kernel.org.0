Return-Path: <bpf+bounces-4818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5974FD48
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B5281804
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEC64B;
	Wed, 12 Jul 2023 02:50:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14894182;
	Wed, 12 Jul 2023 02:50:20 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A949B;
	Tue, 11 Jul 2023 19:50:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b5c2433134so3635121fa.0;
        Tue, 11 Jul 2023 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689130216; x=1691722216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY+qaYG6RosLYXLcPBPwKFMIWqlAzerFec5bPNoPzdQ=;
        b=h3xMnZ/AZNuKdbL9yWo3JWaMAGV0sY6W04YJmOdpVZtByV/DvoxUVWHnLeFyZZkvab
         3cA/HDMrVgPegtz2LuIwUZU50sZcEb9NSbRnYTqo3KhG7pUACKbU0o76FehlHs8zNSwm
         Q0GUaOpTi/5kCu3UzrbojC2N3RVu2NhbhifXqQv5WcWN90aAnwj+TzTSUmoda+N42Ivo
         5Ln+Sock7JZ+kMg1+JIc1i45Ubef6PL9sCoIScIn1MTP226qAkdNd+SmmfwtHL9BuIJc
         abN+hm6RxVD4OFE2adt6QK/cIgg02LDKgIFfWc3QqJB1tI5jHNqR74FRqigABLxTdvwB
         ntEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689130216; x=1691722216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY+qaYG6RosLYXLcPBPwKFMIWqlAzerFec5bPNoPzdQ=;
        b=ClcT4hVyKd7h9Ws58Md+gUBb72e9gdk8rq9XVJEwFe3CRLJXofLvMxFS1rvTUCkeZ5
         rjptNohH41IuFuBzZcsgTs9CRBPpSJJYRQ3jH27c3qAkluArAeUVdIwTLzUVt03kzj9b
         wR3rFG1TIwowueugsMDTCmwIiTasXX689gP3YPsWuopvZgEL6PcGJP2v+9jDXRuNMqcA
         k35tYs2E7vwBFrXHyTHJaz5DLtBAq/YPAP+e+mO4Jf0KsB5A4PtRQ30I1IWvTII2KOLr
         cKGNC7Kt8y/apy/dYNsUQ8L3II7u1KLMgNlSfuosl/vWemEcR6emrEr/zoJ6a7cLk6Ui
         kRfQ==
X-Gm-Message-State: ABy/qLYDXxrxmtr5dzghj7zsPOKeCGD+HU0uiT7xYty3vIaYGOBbR/QB
	RGPWr/h5m00VAOImI572H41vaSDfJG1W/lJTSsE=
X-Google-Smtp-Source: APBJJlEoXLqpJMQbJCteH5KcjvXrqcqqXgdPH63mSGHLVpaOoxwe9duxF5JwQIbRKCGLSvDmfPOyr0Vq7jURLUIHiCA=
X-Received: by 2002:a2e:a4c5:0:b0:2b6:a0c8:fde3 with SMTP id
 p5-20020a2ea4c5000000b002b6a0c8fde3mr193924ljm.6.1689130215922; Tue, 11 Jul
 2023 19:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com> <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
In-Reply-To: <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 19:50:04 -0700
Message-ID: <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Stanislav Fomichev <sdf@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 5:15=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Jul 11, 2023 at 4:45=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 11, 2023 at 4:25=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On Tue, Jul 11, 2023 at 3:57=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrote:
> > > > > +
> > > > > +static int mlx5e_devtx_request_l4_checksum(const struct devtx_ct=
x *_ctx,
> > > > > +                                        u16 csum_start, u16 csum=
_offset)
> > > > > +{
> > > > > +     const struct mlx5e_devtx_ctx *ctx =3D (void *)_ctx;
> > > > > +     struct mlx5_wqe_eth_seg *eseg;
> > > > > +
> > > > > +     if (unlikely(!ctx->wqe))
> > > > > +             return -ENODATA;
> > > > > +
> > > > > +     eseg =3D &ctx->wqe->eth;
> > > > > +
> > > > > +     switch (csum_offset) {
> > > > > +     case sizeof(struct ethhdr) + sizeof(struct iphdr) + offseto=
f(struct udphdr, check):
> > > > > +     case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offse=
tof(struct udphdr, check):
> > > > > +             /* Looks like HW/FW is doing parsing, so offsets ar=
e largely ignored. */
> > > > > +             eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_=
WQE_L4_CSUM;
> > > > > +             break;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > >
> > > > I think this proves my point: csum is not generalizable even across=
 veth and mlx5.
> > > > Above is a square peg that tries to fit csum_start/offset api (that=
 makes sense from SW pov)
> > > > into HW that has different ideas about csum-ing.
> > > >
> > > > Here is what mlx5 does:
> > > > mlx5e_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff =
*skb,
> > > >                             struct mlx5e_accel_tx_state *accel,
> > > >                             struct mlx5_wqe_eth_seg *eseg)
> > > > {
> > > >         if (unlikely(mlx5e_ipsec_txwqe_build_eseg_csum(sq, skb, ese=
g)))
> > > >                 return;
> > > >
> > > >         if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {
> > > >                 eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM;
> > > >                 if (skb->encapsulation) {
> > > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L3_INNER_C=
SUM |
> > > >                                           MLX5_ETH_WQE_L4_INNER_CSU=
M;
> > > >                         sq->stats->csum_partial_inner++;
> > > >                 } else {
> > > >                         eseg->cs_flags |=3D MLX5_ETH_WQE_L4_CSUM;
> > > >                         sq->stats->csum_partial++;
> > > >                 }
> > > >
> > > > How would you generalize that into csum api that will work across N=
ICs ?
> > > >
> > > > My answer stands: you cannot.
> > > >
> > > > My proposal again:
> > > > add driver specifc kfuncs and hooks for things like csum.
> > >
> > > I do see your point, but to also give you my perspective: I have no
> > > clue what those _CSUM tx bits do (as a non-mlx employee). And what
> > > kind of packets they support (initial patch doesn't give any info).
> > > We can definitely expose mlx5 specific request_l4_checksum(bool encap=
)
> > > which does things similar to mlx5e_txwqe_build_eseg_csum, but then,
> > > what does it _actually_ do? It obviously can't checksum arbitrary
> > > packet formats (because it has this inner/outer selection bit), so
> > > there is really no way for me to provide a per-driver kfunc api. Mayb=
e
> > > the vendors can?
> > >
> > > So having csum_start/csum_offset abstraction which works with fixed
> > > offsets seems like at least it correctly sets the expectation for BPF
> > > program writers.
> > > The vendors are already supposed to conform to this start/offset API =
for skb.
> > >
> > > But back to your point: should we maybe try to meet somewhere in the =
middle?
> > > 1. We try to provide "generic" offload kfuncs; for mlx5, we'll have
> > > this mlx5e_devtx_request_l4_checksum which works for fixed offsets
> >
> > But it doesn't.
> > Even if you add a check for csum_start (that's missing in the patch)
> > there need to be a way to somehow figure out
> > whether skb->encapsulation is true and set appropriate flags.
> > Otherwise this request csum will do "something" that only the HW vendor=
 knows.
> > That would be even harder to debug for bpf prog writers.
> >
> > So instead of helping bpf prog devs it will actively hurt them.
>
> Can we make it more robust? The device can look at the payload (via
> descriptors or extra payload pointer via devtx_ctx) and verify
> h_proto/nexthdr.
> It won't be perfect, I agree, but we can get it working for the common
> cases (and have device-specific kfuncs for the rest).

More robust with more checks ?
That will slow things down and the main advantage of XDP vs skb
layer will be lost.
It's best to stay at skb then when csum and timestamp is available.

> > Another example. If bpf prog was developed and tested on veth
> > it will work for some values of csum_offset on real HW and will -EINVAL
> > for the other values.
> > Just horrible user experience comparing to the case where
> > the user knows that each netdev is potentially different and
> > _has_ to develop and test their prog on the given HW NIC and
> > not assume that the kernel can "do the right thing".
>
> For this, I was actually thinking that we need to provide some
> SW-based fallback mechanism.
> Because if I have a program and a nic that doesn't have an offload
> implemented at all, having a fallback might be useful:
>
> if (bpf_devtx_request_l4_csum(...)) {
>   /* oops, hw bailed on us, fallback to sw and expose a counter */
>   bpf_devtx_l4_csum_slowpath(csum_start, csum_offset, data, len);
>   pkt_sw_csum++;
> }
>
> This is probably needed regardless of which way we do it?

sw fallback? We already have 'generic XDP' and people misuse it
thinking it's a layer they should be using.
It's a nice feeling to say that my XDP prog was developed
and tested on mlx5, but I can move it to a different server
with brand new NIC that doesn't support XDP yet and my prog will
still work because of "generic XDP".
I think such devs are playing with fire and will be burned
when "generic XDP" NIC will be DDoSed.
Same thing here. If we do HW offload of csum it's better be in HW.
Devs have to be 100% certain that HW is offloading it.

>
> Regarding veth vs non-veth: we already have similar issues with
> generic xdp vs non-generic.
> I'm not sure we can completely avoid having surprises when switching
> from sw to hw paths.
> It's whether the users will have to debug 10-20% of their program or
> they'd have to start completely from scratch for every nic.

If rewrite for a nic is not acceptable then they should be using skb layer.

>
> > This csum exercise is clear example that kernel is not in a position
> > to do so.
> > For timestamp it's arguable, but for csum there is no generic api that
> > kernel can apply universally to NICs.
>
> Sure, I agree, it's a mix of both. For some offloads, we can have
> something common, for some we can't.
> But I'm not sure why we have to pick one or another. We can try to
> have common apis (maybe not ideal, yes) and we can expose vendor
> specific ones if there is need.
> If the generic ones get unused - we kill them in the future. If none
> of the vendors comes up with non-generic ones - the generic ones are
> good enough.
>
> I'm assuming you favor non-generic ones because it's easier to implement?

Not only.
yes, it's easier to implement, but the expectations are also clear.
The kernel won't be trying to fall back to the slow path.
XDP prog will tell HW 'do csum' and HW will do it.
For generality we have an skb layer.

