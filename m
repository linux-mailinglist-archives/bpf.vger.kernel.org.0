Return-Path: <bpf+bounces-4811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32F74FBE8
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211721C20E20
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B151ED50;
	Tue, 11 Jul 2023 23:45:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877737A;
	Tue, 11 Jul 2023 23:45:34 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB8170F;
	Tue, 11 Jul 2023 16:45:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso100362361fa.1;
        Tue, 11 Jul 2023 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689119131; x=1691711131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zTxAvjlhktR9PL2oZvvoBlvbtdwZFY9QvnpTkujuU8=;
        b=AGEO9HXfaIbJQ7ofhvW3xwCsBS0WkFw7t45G0uAU8NO1N/AxQMI/Gos5p+6YmNPcvf
         DU3qxmmKGhw6N/9pkqz+JoUdV58QzlOugaxovfqMmnBbCg3k5neSy7R4FI1S+6rgD00l
         r9SJpbTb1cQBih8e1wMGhiBE5RHoQAXT11TMEvW+/JoXddPewT4E5ED/KU+Tsdi8ClAQ
         ThhYJlwpK8/V+ZkFtFaEU2GI7P2X7eXNVJ5/t4arlKb4geUIjemcWbKKR48ZGjFbJXUn
         BOa/Fa8pzSUnf+dLmhJY6X52sQXZOR/6Xjl1jmyfgorNyDaZ/Ey+dGnfKhrC8wL3pBgk
         aGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689119131; x=1691711131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zTxAvjlhktR9PL2oZvvoBlvbtdwZFY9QvnpTkujuU8=;
        b=W8F/57+Fvqrxaf4ZbaJHmNTnGqENXzXG7F4TagM9PXH/lgnUnknsYAw7XxAKmBZ8SL
         OLbehSoK/4tNCJTpRFeVTtIxF3t/nI58tlKn9tIZPoczQEI3qh4EzuWyKMyoPf4ysk4t
         72MUL1jPryCNMFhs99PsHTtSU8q3yPwxHGOQnYsLf5HT1ThDinln9TTqENpZ6/uXMeBO
         FkW06UHtb14el9q92yIml/bGR62exF1o8KGAi9ObYrgAihERMZuu2eepgKB3xbjqHTAB
         1zT+FdMTeizh6KjvfCSbp+PGxtxnxpCpvsmlp8m8crxIbr7e5gqZkgciZLYR1X087b57
         HGjg==
X-Gm-Message-State: ABy/qLZclJKyaGaLCyfXLDwav+3Bjwd6kO2WSzT1mYuogJPxfKpzIM35
	RWPSwhf8bbItlxQxd+CCx4DTwQunuKerL3CdhKA=
X-Google-Smtp-Source: APBJJlGE+uC1mEmv8AQTOheCuEb6XBItUj2JCShbtjgva6tNHtuqjeqVI91Dl9Tu8Q2XetMZ5idi/JjEdaIsSV1/9Ww=
X-Received: by 2002:a2e:380b:0:b0:2b6:fe55:7318 with SMTP id
 f11-20020a2e380b000000b002b6fe557318mr17039943lja.12.1689119130740; Tue, 11
 Jul 2023 16:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
In-Reply-To: <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 16:45:19 -0700
Message-ID: <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
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

On Tue, Jul 11, 2023 at 4:25=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Jul 11, 2023 at 3:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 07, 2023 at 12:30:01PM -0700, Stanislav Fomichev wrote:
> > > +
> > > +static int mlx5e_devtx_request_l4_checksum(const struct devtx_ctx *_=
ctx,
> > > +                                        u16 csum_start, u16 csum_off=
set)
> > > +{
> > > +     const struct mlx5e_devtx_ctx *ctx =3D (void *)_ctx;
> > > +     struct mlx5_wqe_eth_seg *eseg;
> > > +
> > > +     if (unlikely(!ctx->wqe))
> > > +             return -ENODATA;
> > > +
> > > +     eseg =3D &ctx->wqe->eth;
> > > +
> > > +     switch (csum_offset) {
> > > +     case sizeof(struct ethhdr) + sizeof(struct iphdr) + offsetof(st=
ruct udphdr, check):
> > > +     case sizeof(struct ethhdr) + sizeof(struct ipv6hdr) + offsetof(=
struct udphdr, check):
> > > +             /* Looks like HW/FW is doing parsing, so offsets are la=
rgely ignored. */
> > > +             eseg->cs_flags =3D MLX5_ETH_WQE_L3_CSUM | MLX5_ETH_WQE_=
L4_CSUM;
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> >
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
>
> I do see your point, but to also give you my perspective: I have no
> clue what those _CSUM tx bits do (as a non-mlx employee). And what
> kind of packets they support (initial patch doesn't give any info).
> We can definitely expose mlx5 specific request_l4_checksum(bool encap)
> which does things similar to mlx5e_txwqe_build_eseg_csum, but then,
> what does it _actually_ do? It obviously can't checksum arbitrary
> packet formats (because it has this inner/outer selection bit), so
> there is really no way for me to provide a per-driver kfunc api. Maybe
> the vendors can?
>
> So having csum_start/csum_offset abstraction which works with fixed
> offsets seems like at least it correctly sets the expectation for BPF
> program writers.
> The vendors are already supposed to conform to this start/offset API for =
skb.
>
> But back to your point: should we maybe try to meet somewhere in the midd=
le?
> 1. We try to provide "generic" offload kfuncs; for mlx5, we'll have
> this mlx5e_devtx_request_l4_checksum which works for fixed offsets

But it doesn't.
Even if you add a check for csum_start (that's missing in the patch)
there need to be a way to somehow figure out
whether skb->encapsulation is true and set appropriate flags.
Otherwise this request csum will do "something" that only the HW vendor kno=
ws.
That would be even harder to debug for bpf prog writers.

So instead of helping bpf prog devs it will actively hurt them.

Another example. If bpf prog was developed and tested on veth
it will work for some values of csum_offset on real HW and will -EINVAL
for the other values.
Just horrible user experience comparing to the case where
the user knows that each netdev is potentially different and
_has_ to develop and test their prog on the given HW NIC and
not assume that the kernel can "do the right thing".
This csum exercise is clear example that kernel is not in a position
to do so.
For timestamp it's arguable, but for csum there is no generic api that
kernel can apply universally to NICs.

> 2. We also let vendors do device-specific "extensions" where devices
> deviate too much: bpf_request_RAW_mlx5e_l4_checksum(bool encap)
> This can give BPF authors opportunity to write somewhat portable
> programs and also use vendor specific apis when/if needed.
>
> I think we had a similar idea for rx side: have generic kfuncs, but
> also let vendors experiment with custom kfuncs if they want to
> differentiate.
> WDYT? Can it give us the best things from both sides?
>
> > Kuba,
> > since you nacked driver specific stuff please suggest a way to unblock =
this stalemate.

