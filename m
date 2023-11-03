Return-Path: <bpf+bounces-14057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DB7DFD7E
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 01:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB23B21394
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048A7E1;
	Fri,  3 Nov 2023 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoL/9SF2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F9180
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 00:13:46 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0F136
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:13:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c773ac9b15so222596966b.2
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698970423; x=1699575223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFGfW14AOytVQhU78drhE/soSidaO8LnbX/Xeb8hz80=;
        b=SoL/9SF2ovdaaXN6HGNc2vAOh4GLYZnHeni2KuqgS/tTmfM9Ng4zznzbV3If+uODcS
         HRFNg7s/yfDYBmzVB5FglyNM0n9Icbuwm/03r05MIp1qKQnuMnA/l3op3BZhKVe+Sgsi
         /5Xe9jBD9a5vDwK7eTctXrgyb2WDI2718lvcxyKIhnqSLxz2w2/EXxmxKMq12RewXPIp
         qMeKqfsnAc0adXVywOrQgDSJC31iJcaH87UGJsh21n8dbEEC+Q/T32BJuLUHLEDATUM0
         julxDjHlGe7yhwO8RQp0y98ssoRtGES/Xz+zH1kWRGrAfQXx7Fz+oM5ZOVftVs+l1C2K
         JNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698970423; x=1699575223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFGfW14AOytVQhU78drhE/soSidaO8LnbX/Xeb8hz80=;
        b=iUS/+ZSk5sccUQF6KMKgKlpiXcqIIfBpY4uplkNBnzPHebBvmEjgx7zbBo7VLUdKtZ
         2Qz5+rQnDfF9+wpoXJzI0pDudSjaGHKOqdQ5IPEdJcBX/04cFp+eWueXQCqBzIvbbdyN
         u46SUvAPooZMeVQ7XkPZiJ3qWmqLbWI+Gs/r8urdNCyfoGOkxWI7akxD6Dpz6tEniaeU
         ps4Q0d3c9JNnNv9OkYPg4OUJQxhomzNzu/Q/rf6HxVyUaoM22GUjbZ7/YHirhwpRAx9w
         SPRMSdzoWETUeV2ITGxvIZkGAPxQlb5OFwwDINb/tOkmJQsTkTeNxXo0MnqK3LujneRC
         GnDA==
X-Gm-Message-State: AOJu0YwdJYtGpjqn144wnkUNHHFUwv6MsHC8tw5pazCMsCTo0qm6gCTg
	CPjlE++oi2x6Su5o/lPIy5R8aPRrmW7PCOEqs4c=
X-Google-Smtp-Source: AGHT+IG1Z4XkPmD6fZNwiCTRy6XV/Nor7e2PCEl+CGV7nEDWF01j0KqgrHMzXS7qmZWqXyoXe9RHWm/Jul7TmbybCdM=
X-Received: by 2002:a17:906:d931:b0:9be:cdca:dae9 with SMTP id
 rn17-20020a170906d93100b009becdcadae9mr4420450ejb.36.1698970423198; Thu, 02
 Nov 2023 17:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-3-andrii@kernel.org>
In-Reply-To: <20231103000822.2509815-3-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 17:13:31 -0700
Message-ID: <CAEf4BzZnCSpnUCUcy=qPWFLh-HRcAt+MjFpaiThhCW+J6FvdRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/13] bpf: generalize is_scalar_branch_taken() logic
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 5:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> cases when both registers are not constants. Previously supported
> <range> vs <scalar> cases are a natural subset of more generic <range>
> vs <range> set of cases.
>
> Generalized logic relies on straightforward segment intersection checks.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 103 ++++++++++++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52934080042c..2627461164ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14187,82 +14187,104 @@ static int is_scalar_branch_taken(struct bpf_r=
eg_state *reg1, struct bpf_reg_sta
>                                   u8 opcode, bool is_jmp32)
>  {
>         struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->=
var_off;
> +       struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->=
var_off;
>         u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_va=
lue;
>         u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_va=
lue;
>         s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_va=
lue;
>         s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_va=
lue;
> -       u64 uval =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : r=
eg2->var_off.value;
> -       s64 sval =3D is_jmp32 ? (s32)uval : (s64)uval;
> +       u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_va=
lue;
> +       u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_va=
lue;
> +       s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_va=
lue;
> +       s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_va=
lue;
>
>         switch (opcode) {
>         case BPF_JEQ:
> -               if (tnum_is_const(t1))
> -                       return !!tnum_equals_const(t1, uval);
> -               else if (uval < umin1 || uval > umax1)
> +               /* constants, umin/umax and smin/smax checks would be
> +                * redundant in this case because they all should match
> +                */
> +               if (tnum_is_const(t1) && tnum_is_const(t2))
> +                       return t1.value =3D=3D t2.value;
> +               /* const ranges */
> +               if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> +                       return umin1 =3D=3D umin2;
> +               if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> +                       return smin1 =3D=3D smin2;

seems like I didn't remove these checks from BPF_JEQ (but I did for
BPF_JNE below). I'll fix it in next revision, but will wait for people
to review this one first.


> +               /* non-overlapping ranges */
> +               if (umin1 > umax2 || umax1 < umin2)
>                         return 0;
> -               else if (sval < smin1 || sval > smax1)
> +               if (smin1 > smax2 || smax1 < smin2)
>                         return 0;
>                 break;
>         case BPF_JNE:
> -               if (tnum_is_const(t1))
> -                       return !tnum_equals_const(t1, uval);
> -               else if (uval < umin1 || uval > umax1)
> +               /* constants, umin/umax and smin/smax checks would be
> +                * redundant in this case because they all should match
> +                */
> +               if (tnum_is_const(t1) && tnum_is_const(t2))
> +                       return t1.value !=3D t2.value;
> +               /* non-overlapping ranges */
> +               if (umin1 > umax2 || umax1 < umin2)
>                         return 1;
> -               else if (sval < smin1 || sval > smax1)
> +               if (smin1 > smax2 || smax1 < smin2)
>                         return 1;
>                 break;

[...]

