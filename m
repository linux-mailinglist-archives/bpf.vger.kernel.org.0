Return-Path: <bpf+bounces-15569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07227F35CC
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1481E1C2105B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D52487BC;
	Tue, 21 Nov 2023 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5HPgYkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674010C8
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:15:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so483274766b.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700590516; x=1701195316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx35UR8OTRO15nTyBwcj3NFd599LBNUOu2KR6E6srj8=;
        b=l5HPgYkceAJN0/59TpzHO/ZweiCn2X2NgY9KyQMsFOg4T/hRD69O8QHy+N816QRs8B
         sdOVd67lL9vJj1XuxlQPduEy3ZOG5QxZkSZ0DwU1FRIjGjQMGPL1p7WpAL0KGlaatsZ0
         nYx5b1jRuLRdSwJC7+omPEvr6/MxX80bv4sIvc3MjApv9Abf0Yy/WAhF3kaVTNeGWOe2
         3E4o5rZrW5ZiOvT/TyKj57maUjYy5QCi382O2W/iopvMl5t9NX5g11IFXHN40VNp7VYJ
         2fxTrJCRn6gU2n7W993BBDouJPyHy+9LXWIVK5xRdpmmYUW4SZILGlFKcnh7P6iixOsR
         MlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700590516; x=1701195316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx35UR8OTRO15nTyBwcj3NFd599LBNUOu2KR6E6srj8=;
        b=v1jrQAo5BT1wKIkB1zdV6g206MZcITa270Cg3ET07q8z4lKXgiXgTHzM8Kk8vfvWse
         WPNbFGsSPiGaVPNrnH7BhDeOHvOUKdGIXRP4pDi1OtpJxRsIWplvRFF7k9RDXnPWKoSK
         1FemBbwV4sOps5lJ2LKhVzrZxJJ65+cOceGpvzNi1IpeKJwTI3rasG+FYyd0qDYl6N9g
         PzT+kfMlilmoHQZHIb+iWvDYX/JF/qlyaSENZYmgZO2XVcQhvVdjnw9KsX29FrvZporl
         Ua8yrzddVlAGV6BkQe97g7/2H23VnuokXU3btOdRF9/qApVBjdvCxM0WxdCKqIlmJCcX
         7D6A==
X-Gm-Message-State: AOJu0Yx9FwVOtEKrfpffXjDDGNDAyVdGKNbkqIb0D8xHs1OzbjVp3nyF
	AyUf7zVP7NJ/4luGE59Wk/pYmuLcwpwP8zN/YO4=
X-Google-Smtp-Source: AGHT+IHZkSlCi/dvslcrs1Pl2BmPd2bD0UmXkthnDMgMnuThuBwyE6Ts6ef5jeyfkdQKSus6s96PX8GDznwTsnnFz2A=
X-Received: by 2002:a17:906:74d0:b0:a03:afb0:a761 with SMTP id
 z16-20020a17090674d000b00a03afb0a761mr322211ejl.38.1700590516191; Tue, 21 Nov
 2023 10:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121002221.3687787-1-andrii@kernel.org> <20231121002221.3687787-8-andrii@kernel.org>
 <0aea72de9d5d283be329e1f95fa8373bcba5e86a.camel@gmail.com>
In-Reply-To: <0aea72de9d5d283be329e1f95fa8373bcba5e86a.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 10:15:05 -0800
Message-ID: <CAEf4BzakvY-rGpOxYYk_qq6197bJZDJZhJNNFtSFaFd7LOjKPg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/10] selftests/bpf: validate zero
 preservation for sub-slot loads
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-11-20 at 16:22 -0800, Andrii Nakryiko wrote:
> [...]
>
> > +SEC("raw_tp")
> > +__log_level(2)
> > +__success
> > +__naked void partial_stack_load_preserves_zeros(void)
> > +{
> > +     asm volatile (
> > +             /* fp-8 is all STACK_ZERO */
> > +             "*(u64 *)(r10 -8) =3D 0;"
>
> This fails when compiled with llvm-16, bpf st assembly support is only
> present in llvm-18. If we want to preserve support for llvm-16 this
> test would require ifdefs or the following patch:

Ok, I'll use that, thanks! I need BPF_ST here to avoid register spill code =
path.


>
> @@ -3,6 +3,7 @@
>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include "../../../include/linux/filter.h"
>  #include "bpf_misc.h"
>
>  struct {
> @@ -510,7 +511,7 @@ __naked void partial_stack_load_preserves_zeros(void)
>  {
>         asm volatile (
>                 /* fp-8 is all STACK_ZERO */
> -               "*(u64 *)(r10 -8) =3D 0;"
> +               ".8byte %[fp8_st_zero];"
>
>                 /* fp-16 is const zero register */
>                 "r0 =3D 0;"
> @@ -559,7 +560,8 @@ __naked void partial_stack_load_preserves_zeros(void)
>                 "r0 =3D 0;"
>                 "exit;"
>         :
> -       : __imm_ptr(single_byte_buf)
> +       : __imm_ptr(single_byte_buf),
> +         __imm_insn(fp8_st_zero, BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0))
>         : __clobber_common);
>  }
>
>
> > +             /* fp-16 is const zero register */
> > +             "r0 =3D 0;"
> > +             "*(u64 *)(r10 -16) =3D r0;"
> > +
> > +             /* load single U8 from non-aligned STACK_ZERO slot */
> > +             "r1 =3D %[single_byte_buf];"
> > +             "r2 =3D *(u8 *)(r10 -1);"
> > +             "r1 +=3D r2;" /* this should be fine */
>
> Question: the comment suggests that adding something other than
>           zero would be an error, however error would only be
>           reported if *r1 is attempted, maybe add such access?
>           E.g. "*(u8 *)(r1 + 0) =3D r2;"?

you are right! I assumed we check bounds during pointer increment, but
I'm wrong. I added dereference instruction everywhere, thanks!

>
> [...]
>
>
>

