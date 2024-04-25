Return-Path: <bpf+bounces-27862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7E8B2D6B
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADD01F21B74
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D862155A34;
	Thu, 25 Apr 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVyBvOY1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381F80BFF
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086321; cv=none; b=HqaSFRIFdpU3ZqbVmVWr4R7X2NLzEkFLV8sEu/oyWv88HHXt5RekZy9Z59VtlYnpT8cVEWJYZXiMTQp6GO0h27/hKZZ22TZmZXuvZGiNbeLA5/AarBz11KkaFtqat2tUzQo5ve+o4Jgq/IZzv4RzeHr+C8MGVSkarVEj7jOPY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086321; c=relaxed/simple;
	bh=kxKeExrGPLXKbL/inOYabEzc5DRpqK+5OgD/8NMHFO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu6xG7MWeFzaXtwuJB6d6iavkBBYVe8+rHwwetr+lNhlWQGRTjMS3JHUINfA1Btb3WN9/5dma7OEwx3O8ZqRiIlddA1AM6xreF1CZYiRssaKZkvD63CHA8Yzg00cIFQjF3iNzQlZgqEyh0/MWI3vy2t1ri9LEu1ZFaDDfwr7Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVyBvOY1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5c7d087e1so14258155ad.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714086320; x=1714691120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di4UkYmby41dYkJJUnoVuniv3VnZ618zvRyBUgqUNgw=;
        b=iVyBvOY1Gr62owXgY9OXaW4hZCWf12eLY8zDfCx6+pkJ8esgWrc5YM3k8eHAlQJRO2
         oHPSVH9cs8b4lBst0TctGQYZQyVBIEX9r6m+TATq2b2foJ4szBzGLD0zVH2fdJs+j8wl
         0vMpPB4Cn4LPL2FvJVkKj8cICFk6T7Q1BBL8SZ7IqIoyKVrIF7S3ErXXo0qQSvjdA8+G
         4KAoUkZRBOBL0v661p0FMhpcTttxecZNd8n2O3Wrk2DTrbIFyYyaFUtzSlbkZk0udM/+
         6vZQSny3p/z2M8YJhTcNlUyx21AiZN+fSPJ++fz2PDP2Y1eGNFZTfBBpimm3UfCBrhmq
         qcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714086320; x=1714691120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di4UkYmby41dYkJJUnoVuniv3VnZ618zvRyBUgqUNgw=;
        b=gL0loSJhaf7rrGKMWMerqea6FYcmd4mWM2bWmrRMUsZvDyiuUfU5CeeDuYeM+Pl44w
         mbO/R4HvFK0mstNumM9T3voAecGzVFH0GtI0lxvWZU6DnYgaoD+lqsHjqvXO668Db5a6
         H+VOLiFUTb+JL0ovF+TiW8bywW02EnEp1hU/qGpa9GFxBo5jwh3h/R827RBkifAHyD5Z
         CiZWKa4iBXPcaQx0qpTHPtpu5M5msoqUDyxGf72nSYjdvInkN0EqA2mV4dsKSlSJE46E
         fSjIby1yvTBwvUpVTnojCk+jWvMGwbuwdmz2cimdjI3VXexOO2IByc6I4vc+AsXOECJ1
         BcWA==
X-Gm-Message-State: AOJu0Yy0zNAqSj1LW1r0OoFEtflK9rdFGY4CmGvuR4yJ4ubNH0e0dxWt
	ifUgQpFJvEsKVUiZwGccJTQUDK6EEoRZX7CayvfDWha0PEQyb9Gb+fRkbtaCRCzYKVepxiA3v8P
	dZJhXzoQNpJDY72ZDfyCLCaJU0N0=
X-Google-Smtp-Source: AGHT+IFLfWN6EaMpDSp5PybP4G87ABv0oavo2VSWQMpLNf3dTUP/cBngs2/5+W+q6wAuRoOQp/cD7Efexo6ZlgpdCLk=
X-Received: by 2002:a17:90a:68cd:b0:2ad:1e60:502a with SMTP id
 q13-20020a17090a68cd00b002ad1e60502amr1078461pjj.38.1714086319765; Thu, 25
 Apr 2024 16:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com> <20240424224053.471771-3-cupertino.miranda@oracle.com>
In-Reply-To: <20240424224053.471771-3-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 16:05:05 -0700
Message-ID: <CAEf4BzYuHv7QnSAFVX0JH2YQd8xAR5ZKzWxEY=8yongH9kepng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range computation
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Split range computation checks in its own function, isolating pessimitic
> range set for dst_reg and failing return to a single point.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>  kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
>  1 file changed, 77 insertions(+), 64 deletions(-)
>

I know you are moving around pre-existing code, so a bunch of nits
below are to pre-existing code, but let's use this as an opportunity
to clean it up a bit.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6fe641c8ae33..829a12d263a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf_reg_s=
tate *dst_reg,
>         __update_reg_bounds(dst_reg);
>  }
>
> +static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,

hm.. why passing reg_state by value? Use pointer?

> +                                  bool *valid)
> +{
> +       s64 smin_val =3D reg.smin_value;
> +       s64 smax_val =3D reg.smax_value;
> +       u64 umin_val =3D reg.umin_value;
> +       u64 umax_val =3D reg.umax_value;
> +

don't add empty line between variable declarations, all variables
should be in a single continuous block

> +       s32 s32_min_val =3D reg.s32_min_value;
> +       s32 s32_max_val =3D reg.s32_max_value;
> +       u32 u32_min_val =3D reg.u32_min_value;
> +       u32 u32_max_val =3D reg.u32_max_value;
> +

but see below, I'm not sure we even need these local variables, they
don't save all that much typing

> +       bool known =3D alu32 ? tnum_subreg_is_const(reg.var_off) :
> +                            tnum_is_const(reg.var_off);

"known" is a misnomer, imo. It's `is_const`.

> +
> +       if (alu32) {
> +               if ((known &&
> +                    (s32_min_val !=3D s32_max_val || u32_min_val !=3D u3=
2_max_val)) ||
> +                     s32_min_val > s32_max_val || u32_min_val > u32_max_=
val)
> +                       *valid =3D false;
> +       } else {
> +               if ((known &&
> +                    (smin_val !=3D smax_val || umin_val !=3D umax_val)) =
||
> +                   smin_val > smax_val || umin_val > umax_val)
> +                       *valid =3D false;
> +       }
> +
> +       return known;


The above is really hard to follow, especially how known && !known
cases are being handled is very easy to misinterpret. How about we
rewrite the equivalent logic in a few steps:

if (alu32) {
    if (tnum_subreg_is_const(reg.var_off)) {
        return reg->s32_min_value =3D=3D reg->s32_max_value &&
               reg->u32_min_value =3D=3D reg->u32_max_value;
    } else {
        return reg->s32_min_value <=3D reg->s32_max_value &&
               reg->u32_min_value <=3D reg->u32_max_value;
    }
} else {
   /* same as above for 64-bit bounds */
}

And you don't even need any local variables, while all the important
conditions are a bit more easy to follow? Or is it just me?

> +}
> +
> +static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
> +                                            struct bpf_reg_state src_reg=
)
> +{
> +       bool src_known;
> +       u64 insn_bitness =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) ? 6=
4 : 32;

whole u64 for this seems like an overkill, I'd just stick to `int`

> +       bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);

insn_bitness =3D=3D 32 ?

> +       u8 opcode =3D BPF_OP(insn->code);
> +

nit: don't split variables block with empty line

> +       bool valid_known =3D true;

need an empty line between variable declarations and the rest

> +       src_known =3D is_const_reg_and_valid(src_reg, alu32, &valid_known=
);
> +
> +       /* Taint dst register if offset had invalid bounds
> +        * derived from e.g. dead branches.
> +        */
> +       if (valid_known =3D=3D false)

nit: !valid_known

> +               return false;

given this logic/handling, why not just return false from
is_const_reg_and_valid() if it's a constant, but it's not
valid/consistent? It's simpler and fits the logic and function's name,
no? See my suggestion above

> +
> +       switch (opcode) {

inline opcode variable here, you use it just once

> +       case BPF_ADD:
> +       case BPF_SUB:
> +       case BPF_AND:
> +               return true;
> +
> +       /* Compute range for the following only if the src_reg is known.
> +        */
> +       case BPF_XOR:
> +       case BPF_OR:
> +       case BPF_MUL:
> +               return src_known;
> +
> +       /* Shift operators range is only computable if shift dimension op=
erand
> +        * is known. Also, shifts greater than 31 or 63 are undefined. Th=
is
> +        * includes shifts by a negative number.
> +        */
> +       case BPF_LSH:
> +       case BPF_RSH:
> +       case BPF_ARSH:

preserve original comment?

> -                       /* Shifts greater than 31 or 63 are undefined.
> -                        * This includes shifts by a negative number.
> -                        */

> +               return (src_known && src_reg.umax_value < insn_bitness);

nit: unnecessary ()

> +       default:
> +               break;

return false here, and drop return below

> +       }
> +
> +       return false;
> +}
> +
>  /* WARNING: This function does calculations on 64-bit values, but the ac=
tual
>   * execution may occur on 32-bit values. Therefore, things like bitshift=
s
>   * need extra checks in the 32-bit case.

[...]

