Return-Path: <bpf+bounces-21908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EFB853FEA
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44973B2CF98
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55D62A1D;
	Tue, 13 Feb 2024 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9/JJ8r9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6289629FB
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866107; cv=none; b=q8X6LyQKbjYvHzo8GVWhAO/2KkHUBhmyPWs5GGrUNehLgEmCEwym1RxUscO/q/KTaGe8Xb7SnPFh1ItlsaDQZjSHAdn3KF0QVugn/ialbG5i8VZOKJjTvsAn7ieVCK2uN5I2vtxuvL11OF1UuIqmjgAj0O4TqfuORIWgXqP+pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866107; c=relaxed/simple;
	bh=zfK4g3BWZQhPxu7iCWOunyi1yxXI4CClKiZMXbaOc5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiLbFUveOuAeD92ylTYrJA0GW7ttO+173L3bTEQSrsrBzs6ft8s09J7XpQ7e1i6HkTa4SloB5Kur/YEwaHD5+eEti7CghNNu63x2CR199aV7A1XFCrWv5y6p1uP/xTlPjJHVQQtK52DXg8j42YaSt/BdxhnqBRRkNrRu2XvGZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9/JJ8r9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so3261558a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866105; x=1708470905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OEKfcCmXlb4wWGiTUjfKHFZp2kD3XANacG8DRhPJEM=;
        b=a9/JJ8r9ceEk09tRUYF8h4IsLdFsYzu9xJ/XoE6O6ve3O2QP8KB3v7/uvc/wk2htOr
         XRTVpIWdp/98ipxUxk6awd593WWlvklhsYQ3VO02zlDR9t2VuGHCby4A8mQgrZQuKOSP
         7rWKMfhTiNwQPI72z10b/hCeZnj3S0t0y5+hqQE7uNYj93b3q378jAKyrw+X7xhKLp76
         Tea6GBGyAhaQi7Ps8RHSgEvucJHqEScUpLRHi743DmRixe8IfAvkEFmvkmVaglpOiY7J
         Q+9vUZAvLc5PVGg7nB0kw3eBOJaKanT1bkKLil0YjuLkCiCsZ8yqE1ad6gZva62Sl4KG
         l6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866105; x=1708470905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OEKfcCmXlb4wWGiTUjfKHFZp2kD3XANacG8DRhPJEM=;
        b=Lc9dvB/0d1edFhYSXiNXkkFNDPVKj22E8mo0Kcz3K5GWqAYR+kZO+04vdFCy8kOsOs
         YxBDm2ObVHEe5q3ASB9iTGjMuB32By2vHD3Jhgk91WrTuMpebSSzFQMc4kdMYiMqhEYH
         Tmpf21PvMXWRyUTZVvoii5BKpnne1uYp4ZKjOn4MFZu/F4ybi2JOeMABdrO65jj1Rm/K
         yH6v7SUsy28n5ZumsF0pasg1LmJpP0E7BNCWle3dmEGvcEB/hie4kpLWwWICb4uYU78f
         ydBT0YGGP2gO3Aj0dTVIz/GOaXOc1bM/ESpsCg9gRwJ2ULe2M8+EHYG412wRyKolHEq1
         0TIw==
X-Gm-Message-State: AOJu0Yz5XWM7PBKur2cS2whDHwYMp5yLIJnX6K3G2VaZ7I1920UyX50P
	WmcbaoQTdkkS694K7lNleTZakesimJY+pDtBftzQpMH9z55XXIBuyCoRrR1Q9Mf4eyHidRJri82
	etmesmn2QcYEy65kcfY9hdKZN/30=
X-Google-Smtp-Source: AGHT+IE3RLo6cFKzVSEIsAkFOiDmgzqiSvpBC0ef7oaO0CGfM0GnCrWvurVzyvblR91XCTA7611s69nZsXHYHQX6qgc=
X-Received: by 2002:a05:6a20:9585:b0:19e:ce54:4746 with SMTP id
 iu5-20020a056a20958500b0019ece544746mr1371092pzb.9.1707866104871; Tue, 13 Feb
 2024 15:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-11-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:14:51 -0800
Message-ID: <CAEf4Bzb=G=S3=bqxSHRLO+zd+EjbqyPcMgXBWGEiC_29rdBXSQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/20] bpf: Recognize btf_decl_tag("arg:arena")
 as PTR_TO_ARENA.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In global bpf functions recognize btf_decl_tag("arg:arena") as PTR_TO_ARE=
NA.
>
> Note, when the verifier sees:
>
> __weak void foo(struct bar *p)
>
> it recognizes 'p' as PTR_TO_MEM and 'struct bar' has to be a struct with =
scalars.
> Hence the only way to use arena pointers in global functions is to tag th=
em with "arg:arena".
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/btf.c      | 19 +++++++++++++++----
>  kernel/bpf/verifier.c | 15 +++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5eeb9bf7e324..fa49602194d5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9348,6 +9348,18 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
>                                 bpf_log(log, "arg#%d is expected to be no=
n-NULL\n", i);
>                                 return -EINVAL;
>                         }
> +               } else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_ARE=
NA) {
> +                       /*
> +                        * Can pass any value and the kernel won't crash,=
 but
> +                        * only PTR_TO_ARENA or SCALAR make sense. Everyt=
hing
> +                        * else is a bug in the bpf program. Point it out=
 to
> +                        * the user at the verification time instead of
> +                        * run-time debug nightmare.
> +                        */
> +                       if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D=
 SCALAR_VALUE) {

the comment above doesn't explain why it's ok to pass SCALAR_VALUE. Is
it because PTR_TO_ARENA will become SCALAR_VALUE after some arithmetic
operations and we don't want to regress user experience? If that's the
case, what's the way for user to convert SCALAR_VALUE back to
PTR_TO_ARENA without going through global subprog? bpf_cast_xxx
instruction through assembly?

> +                               bpf_log(log, "R%d is not a pointer to are=
na or scalar.\n", regno);
> +                               return -EINVAL;
> +                       }
>                 } else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_=
RDONLY)) {
>                         ret =3D process_dynptr_func(env, regno, -1, arg->=
arg_type, 0);
>                         if (ret)
> @@ -20329,6 +20341,9 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
>                                 reg->btf =3D bpf_get_btf_vmlinux(); /* ca=
n't fail at this point */
>                                 reg->btf_id =3D arg->btf_id;
>                                 reg->id =3D ++env->id_gen;
> +                       } else if (base_type(arg->arg_type) =3D=3D ARG_PT=
R_TO_ARENA) {
> +                               /* caller can pass either PTR_TO_ARENA or=
 SCALAR */
> +                               mark_reg_unknown(env, regs, i);

shouldn't we set the register type to PTR_TO_ARENA here?


>                         } else {
>                                 WARN_ONCE(1, "BUG: unhandled arg#%d type =
%d\n",
>                                           i - BPF_REG_1, arg->arg_type);
> --
> 2.34.1
>

