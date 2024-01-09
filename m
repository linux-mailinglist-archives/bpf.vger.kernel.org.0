Return-Path: <bpf+bounces-19241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC1827C30
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9ED2839BB
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258AF647;
	Tue,  9 Jan 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZv/nrEQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B456743
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5576fae29ffso2274316a12.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704761044; x=1705365844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2INMq1jSEBaYaXp+tHbt8h6C0Lmr0UJQjbxb8re7lo=;
        b=gZv/nrEQA7sxqZvDd1noDF1u1POje18yPMsMJQM9PgH0yM5FFMGYlY4xE6we2Fcegq
         aVndCHN9EZ1dvBqXIexXRf30PV2zoMRFNU3oiQK2HqkVuZMWZjguM61GTQKNHV/eoc3/
         QagIdQ1zUojetSHz3SkKtz94CBvW1pw17sDTrj78bceSYq0NXVua159pFgxZC+VCBSu6
         +ALsg+MKdcLn8PCgHpEVrtVCi+B5WheuAGSKoFjzvUtiat5Vqt4PO7oyjhRJ68fDjRxO
         uerlP5uZEEVeXuiJWEQbE/5eOupsIBEebWvsH03SCDUuRWTZvmodFobu5SUhTwBtrC1F
         UY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704761044; x=1705365844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2INMq1jSEBaYaXp+tHbt8h6C0Lmr0UJQjbxb8re7lo=;
        b=vNRKiiluinyKGDPTWFPAr+8aGkpoqadI4YVISLwl9WMmb5fUZyljrmWbIm7f9pkml7
         4fuXtGGVpj3JKAbpwsBQ60b1oVv+S0nrEPjndD2HQYL2zQUV2bCPfBOswBvsEBT22zum
         ZVRqvSoG5XMj+11GU1FLOrl78uM0qhK93KwtY7AqriHJtI3vtKOQwPo3JNbY4T1YAFbO
         nJDmyC8xALosHodSmA+lYAJ+//0qip0HtCV2Qbi5JTZ0c1/kPK0fkZ/l0293EgDgDRVQ
         p5DmO3VFkv/hw9vM87MUfxC9YY5aAFd+q4n0DDbLzSQ60kzqexO5m7mdnPf+4GyOz9BE
         dY3g==
X-Gm-Message-State: AOJu0YzWoflTxdluAXaRmLYUm7fM46ogXSzAfPvIH+xA7v4OdaAV+wJF
	3gIvcMnpi8OvsGw3oLR5GQJCJ9kpyN7vvkx3zjpX3orj
X-Google-Smtp-Source: AGHT+IFv6eGutVr2GCH8bEbKSyXypG9b6Dd9ZvbdCXXtVon0RiA2bwFT71CaZT1dwcUAkkQ233zPuGCjSHCiH2YJSaw=
X-Received: by 2002:a50:9993:0:b0:556:e686:ba4 with SMTP id
 m19-20020a509993000000b00556e6860ba4mr2084542edb.84.1704761044257; Mon, 08
 Jan 2024 16:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108132802.6103-1-eddyz87@gmail.com> <20240108132802.6103-2-eddyz87@gmail.com>
 <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5NNWRroWtg5cRy4FUV8-AhrRbsd7_D12F3SJu7hTcqw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 16:43:52 -0800
Message-ID: <CAEf4BzYP-AVF5a3=KM-+T=fHN3-0YHEGrQKPLVqvbJsKJJXZvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: simplify try_match_pkt_pointers()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, zenczykowski@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:40=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 8, 2024 at 5:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > Reduce number of cases handled in try_match_pkt_pointers()
> > to <pkt_data> <op> <pkt_end> or <pkt_meta> <op> <pkt_data>
> > by flipping opcode.
> >
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 104 ++++++++++--------------------------------
> >  1 file changed, 24 insertions(+), 80 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index adbf330d364b..918e6a7912e2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14677,6 +14677,9 @@ static bool try_match_pkt_pointers(const struct=
 bpf_insn *insn,
> >                                    struct bpf_verifier_state *this_bran=
ch,
> >                                    struct bpf_verifier_state *other_bra=
nch)
> >  {
> > +       int opcode =3D BPF_OP(insn->code);
> > +       int dst_regno =3D insn->dst_reg;
> > +
> >         if (BPF_SRC(insn->code) !=3D BPF_X)
> >                 return false;
> >
> > @@ -14684,90 +14687,31 @@ static bool try_match_pkt_pointers(const stru=
ct bpf_insn *insn,
> >         if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
> >                 return false;
> >
> > -       switch (BPF_OP(insn->code)) {
> > +       if (dst_reg->type =3D=3D PTR_TO_PACKET_END ||
> > +           src_reg->type =3D=3D PTR_TO_PACKET_META) {
> > +               swap(src_reg, dst_reg);
> > +               dst_regno =3D insn->src_reg;
> > +               opcode =3D flip_opcode(opcode);
> > +       }
> > +
> > +       if ((dst_reg->type !=3D PTR_TO_PACKET ||
> > +            src_reg->type !=3D PTR_TO_PACKET_END) &&
> > +           (dst_reg->type !=3D PTR_TO_PACKET_META ||
> > +            !reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)))
> > +               return false;
>
> this inverted original condition just breaks my brain, I can't wrap my
> head around it :) I think the original is easier to reason about
> because it's two clear allowable patterns for which we do something. I
> understand that this early exit reduces nestedness, but at least for
> me it would be simpler to have the original non-inverted condition
> with a nested switch.
>
>
> > +
> > +       switch (opcode) {
> >         case BPF_JGT:
> > -               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
> > -                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
> > -                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
> > -                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET))) =
{
> > -                       /* pkt_data' > pkt_end, pkt_meta' > pkt_data */
> > -                       find_good_pkt_pointers(this_branch, dst_reg,
> > -                                              dst_reg->type, false);
> > -                       mark_pkt_end(other_branch, insn->dst_reg, true)=
;

it seems like you can make a bit of simplification if mark_pkt_end
would just accept struct bpf_reg_state * instead of int regn (you
won't need to keep track of dst_regno at all, right?)

> > -               } else if ((dst_reg->type =3D=3D PTR_TO_PACKET_END &&
> > -                           src_reg->type =3D=3D PTR_TO_PACKET) ||
> > -                          (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PAC=
KET) &&
> > -                           src_reg->type =3D=3D PTR_TO_PACKET_META)) {
> > -                       /* pkt_end > pkt_data', pkt_data > pkt_meta' */
> > -                       find_good_pkt_pointers(other_branch, src_reg,
> > -                                              src_reg->type, true);
> > -                       mark_pkt_end(this_branch, insn->src_reg, false)=
;
> > -               } else {
> > -                       return false;
> > -               }
> > -               break;
>
> [...]

