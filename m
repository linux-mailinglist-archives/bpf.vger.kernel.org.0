Return-Path: <bpf+bounces-18809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E305B8222A7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9283B284812
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800631642D;
	Tue,  2 Jan 2024 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUbQSrrr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3716410
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so7289474a12.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704227786; x=1704832586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB1gr488IvxCzh0fKgzqu7Md6qsS0wkUvceUYb9ES1M=;
        b=hUbQSrrrss+Ln49Ytdst4W5Lbh93LNXxVkT/eKN7PAUlQrqu6HkusKZ4+F0legxCkW
         wSNECPnCsbhtnLUAm+C+umw77+kF8oan6wEMiW+Jx4nOd9DLYNvssPMmdu9EBFCCuDvc
         1/KC/EIoCBkzeS9UsUtNnaITQiwvq8fAbYozqGl5jKWRNduBO68foI1veTrvDHr5IvO8
         y7nHCqOsCe+IY3t3Iz207KxXjuXZOO2SFAiAC1mLlrpWkveR7I3xxsuQEcT/SWTfBykY
         8wyk20LiY25XhDghDemPN/DaEHe9xhMMchLJa2cTKI2z8QgQKNVScq+ZEXFBL8MX+QpB
         rJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227786; x=1704832586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB1gr488IvxCzh0fKgzqu7Md6qsS0wkUvceUYb9ES1M=;
        b=B0G6gx6he4tUmRXStajDHS8krIoLyug6VqqHJdv5ABb9amaxy58ujhGkAaYPzNY2cG
         prjLqIaNwqW6ouTjbEiIxpMiSzuc67Y06LBROSFxoEKdb3qrY//INXskIUZjzfUvESYT
         S0GJEQXu116s3jx2K0h/msrZtdxI+Vt5X3Hy0tdPt8U+1YCu3awwTKp1vBXm9GlK/iYc
         scJFuXBw6lopMOxTcnN/nVOD4U8dSAKZp+mUlXAtTPTvlkG6OfyQtjCUhM2GMRZLc1D+
         R8kLimeaScILcJEZRx9UmMXracVnLVvx/m5X56+i6DKTkDOVasB+s6fLz5VYB90092X9
         NJ5w==
X-Gm-Message-State: AOJu0YxEciQS+mZx0QhiQKVO0TPdl3DdX1Q+2hmpLWDLcxtoun5Z12XR
	9DJlc1doMYsade4sqMVfv+b+tXz78vYnHTMdmA0=
X-Google-Smtp-Source: AGHT+IFR/3KxfF6v8wA/MjRdszuBg8dxS8z/YP9d9kjCjPKmz2XwuzWYNxmyHbd1Ofp4AyyGCIzn0zhYfzzp+20iek4=
X-Received: by 2002:a17:906:da8d:b0:a28:7fe8:8b29 with SMTP id
 xh13-20020a170906da8d00b00a287fe88b29mr236790ejb.68.1704227785421; Tue, 02
 Jan 2024 12:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
 <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com> <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
In-Reply-To: <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 2 Jan 2024 12:36:14 -0800
Message-ID: <CAHo-OoxanNo=0ppvq940KaUZBMBWjLyMgWCXCMfmyhMR6pmC2g@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-01-02 at 10:30 -0800, Maciej =C5=BBenczykowski wrote:
> [...]
> >
> > The check is:
> >   if (data + 98 !=3D data_end) return;
> > so now (after this check) you *know* that 'data + 98 =3D=3D data_end' a=
nd
> > thus you know there are *exactly* 98 valid bytes.
>
> Apologies, you are correct.
> So you want to have something along the following lines:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a376eb609c41..6ddb34d5b9aa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14712,6 +14712,28 @@ static bool try_match_pkt_pointers(const struct =
bpf_insn *insn,
>                         return false;
>                 }
>                 break;
> +       case BPF_JEQ:
> +       case BPF_JNE:
> +               if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
> +                    src_reg->type =3D=3D PTR_TO_PACKET_END) ||
> +                   (dst_reg->type =3D=3D PTR_TO_PACKET_META &&
> +                    reg_is_init_pkt_pointer(src_reg, PTR_TO_PACKET)) ||
> +                   (dst_reg->type =3D=3D PTR_TO_PACKET_END &&
> +                    src_reg->type =3D=3D PTR_TO_PACKET) ||
> +                   (reg_is_init_pkt_pointer(dst_reg, PTR_TO_PACKET) &&
> +                    src_reg->type =3D=3D PTR_TO_PACKET_META)) {
> +                       /* pkt_data' !=3D pkt_end, pkt_meta' !=3D pkt_dat=
a,
> +                        * pkt_end !=3D pkt_data', pkt_data !=3D pkt_meta=
'
> +                        */
> +                       struct bpf_verifier_state *eq_branch;
> +
> +                       eq_branch =3D BPF_OP(insn->code) =3D=3D BPF_JEQ ?=
 other_branch : this_branch;
> +                       find_good_pkt_pointers(eq_branch, dst_reg, dst_re=
g->type, true);
> +                       mark_pkt_end(eq_branch, insn->dst_reg, false);
> +               } else {
> +                       return false;
> +               }
> +               break;
>         case BPF_JGE:
>                 if ((dst_reg->type =3D=3D PTR_TO_PACKET &&
>                      src_reg->type =3D=3D PTR_TO_PACKET_END) ||
>
> Right?

I think so? I don't fully follow the logic.

I wonder if JEQ/JNE couldn't simply be folded into the existing cases thoug=
h...
Or perhaps some other refactoring to tri-state the jmps...

switch (opcode) {
case BPF_JEQ: eq_branch =3D this_branch; lt_branch =3D gt_branch =3D
other_branch; break;
case BPF_JNE: lt_branch =3D gt_branch =3D this_branch; eq_branch =3D
other_branch; break;
case BPF_LT: lt_branch =3D this_branch; eq_branch =3D gt_branch =3D
other_branch; break;
...
}
and then you can ignore opcode...

> This passes the following test case:
>
> SEC("tc")
> __success
> __naked void data_plus_const_eq_pkt_end(void)
> {
>         asm volatile ("                                 \n\
>         r9 =3D r1;                                        \n\
>         r1 =3D *(u32*)(r9 + %[__sk_buff_data]);           \n\
>         r2 =3D *(u32*)(r9 + %[__sk_buff_data_end]);       \n\
>         r3 =3D r1;                                        \n\
>         r3 +=3D 8;                                        \n\
>         if r3 !=3D r2 goto 1f;                            \n\
>         r1 =3D *(u64 *)(r1 + 0);                          \n\
> 1:                                                      \n\
>         r0 =3D 0;                                         \n\
>         exit;                                           \n\
> "       :
>         : __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
>           __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data=
_end))
>         : __clobber_all);
> }
>
> And it's variations for EQ/NEQ, positive/negative.

