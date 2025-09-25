Return-Path: <bpf+bounces-69683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C62B9E7F1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52A17A5A4F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 09:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD702727FD;
	Thu, 25 Sep 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEKpyGIM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98621A92F
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793786; cv=none; b=NCxPPA05F5Xl7w7eciS8JGu7VYslsdbwiUNEJ6TgcpYPSYJJRa7mO1jhoKSeFXHvYYpYxa4vaDXkg3OrRbeHfDvfJTvh+MLut7C1n0iTJDa6+UmQlaOg33V8MQwBKUcQeL5nrPoVv5Kq0x4gXhbHm8120koADDxlpCrQHhE18N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793786; c=relaxed/simple;
	bh=8Ar+LW16cuafXplhrJrUtsg6Y0P549XzFqMr05t7WHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckEEu3hr3hdicCM0OSBRO4wqTWDOKnDZqmFQY1vMWH/ZqdQVICisUYiN9CgUD7RDJ6KTJ9rVth3LNB05HOskdXu6HlHV2tZnREhWhkwFSiYqYD0fP1d/PHNK2sMjI6+7E+2ugJJxHUt79G2dg46ww+BZvsGC7w9+AIgGmiyx7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEKpyGIM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso807863f8f.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758793783; x=1759398583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAdB0h6gywyYGEbcKZEpB8tiADjT0Zg7QlPCyUrAOtk=;
        b=XEKpyGIMZUrpgF9oIsujNdtSj4k/VSkSfIzAkzjWUxj0H6Y/SMWD1RbXfErURNXU0D
         o7zEodBsBdwiAX34eDRxol6XTXv24VZHaodDP9iaYMcLfFxpROo/iiuyfqGgAEeI4h0A
         CYiCFdQ9C9/pLqK5YM3LjHRreTnLuFHfslkHohaG6f9e+Zgt7srZWBl22zMra6+u0d/E
         Wi2R/LwGByUajOyFDCEzYW7WUfIhWJ4d9/h8KXs/XOzYR7/Ei20FsRSRl8iy9bZsWuF/
         aBbanQVbnbfA7oIw0KPE5zehwk0jNGO1h+4+eOn04kn/Ck3pkgnowwmpLWW7WSWMREW6
         t/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793783; x=1759398583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAdB0h6gywyYGEbcKZEpB8tiADjT0Zg7QlPCyUrAOtk=;
        b=KzvS/GzVuZO15Orj5ytoC86e73TjhrUa3Zx4EIOmxrE02S7ZAgHrD7GiXSNHRhz72e
         mAO9vxqU9zK2GjhVHSDsUPM9RtEzLXPVPZW9sS7vixfA9I0PqnJb92jqZ0MzR2Bnrp0b
         NKXWWiP0px8BPC2YKef99HnB7TG10sFfHLJYWBwO+ytx0j9+KtIsx5y70vlTBLxV0BZ+
         5wZPcOdMzvJ+GkkY0RgUlZGVnGcCLcfk0zeVOqxnE86O94sL0I1Njcl1t0RFsmvjl1kH
         4JJXZln3XYFv/EDOQQdZOMlcGQpvKttU+c/GD6C3hHo8DVf2TrmZxTJO9lOW8gXvSrLz
         eXOQ==
X-Gm-Message-State: AOJu0Yy9Bf6oK+JzfjH5MsUMdxI+iguIERjAfZ8p5SKkoRpCXiKib1cC
	cI9LAxDkYUDjAklcjh26Y4IA0WcvnIuDZFz68kA6BUZdG8P4oDyUtDJ0GDVfoiFv8SDDJ5gtvhy
	wDYMFFgqUewcrYN/XOWbN6BRkQ2nnjKkBKpQrVdZGsQ==
X-Gm-Gg: ASbGnctS9ZXVnD9w3iceqekaUp03Q1yBEEEukyiuldzHpN7Pt24al3ytD4pqo+8oEfi
	mGV0RWbg8ayXMP50OFFwKqmrob0DEwV2A4/L6Cac5vn81XSstqTnaFuUJ/7NCP6mHyFG33+aEkh
	cPXyOmCiXaLwY5DyMLe5gozbNzGeaHzXgz3fUfZCUKhjUcIE/Qy20TY6Tu/Y/jBfFbrWPEGTaJa
	cTrjQ==
X-Google-Smtp-Source: AGHT+IEo0J7byEs7BdWOXsGPzkT2J09Ix+etXUhkwQcB9QQkq4MZ1w/7V+zQyT9gfSuagZLTrmn+cv5Vxa5I6YBHVns=
X-Received: by 2002:a05:6000:220f:b0:3ec:3cac:7dfd with SMTP id
 ffacd0b85a97d-40e44c3da28mr2914145f8f.26.1758793782363; Thu, 25 Sep 2025
 02:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-2-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-2-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 10:49:31 +0100
X-Gm-Features: AS18NWDI0PcoHJucBujAEwrYnqvMKkwuEPh-avG_8_H40XT5_nl48CsvY_ofg7w
Message-ID: <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Define KF_IMPLICIT_PROG_AUX_ARG and handle it in the BPF verifier.
>
> The mechanism of patching is exactly the same as for __prog parameter
> annotation: in check_kfunc_args() detect the relevant parameter and
> remember regno in cur_aux(env)->arg_prog.
>
> Then the (unchanged in this patch) fixup_kfunc_call() adds a mov
> instruction to set the actual pointer to prog_aux.
>
> The caveat for KF_IMPLICIT_PROG_AUX_ARG is in implicitness. We have to
> separately check that the number of arguments is under
> MAX_BPF_FUNC_REG_ARGS.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  include/linux/btf.h   |  3 +++
>  kernel/bpf/verifier.c | 43 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..479ee96c2c97 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,9 @@
>  #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
> +/* kfunc takes a pointer to struct bpf_prog_aux as the last argument,
> + * passed implicitly in BPF */

This is neither networking nor kernel comment style.
Pls use proper kernel comment style in a new code,
and reformat old net/bpf style when adjusting old comments.

> +#define KF_IMPLICIT_PROG_AUX_ARG (1 << 16)

The name is too verbose imo.
How about
KF_HIDDEN_PROG_ARG
or
KF_PROG_LAST_ARG

"Implicit" is not 100% correct, since it's very explicit
in kfunc definition in C, but removed from BTF.
"Hidden" is also not an exact fit for the same reasons.
Hence my preference is KF_PROG_LAST_ARG.

"aux" part is also an implementation detail.

>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e892df386eed..f1f9ea21f99b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11948,6 +11948,11 @@ static bool is_kfunc_rcu_protected(struct bpf_kf=
unc_call_arg_meta *meta)
>         return meta->kfunc_flags & KF_RCU_PROTECTED;
>  }
>
> +static bool is_kfunc_with_implicit_prog_aux_arg(struct bpf_kfunc_call_ar=
g_meta *meta)
> +{
> +       return meta->kfunc_flags & KF_IMPLICIT_PROG_AUX_ARG;
> +}
> +
>  static bool is_kfunc_arg_mem_size(const struct btf *btf,
>                                   const struct btf_param *arg,
>                                   const struct bpf_reg_state *reg)
> @@ -12029,6 +12034,18 @@ static bool is_kfunc_arg_prog(const struct btf *=
btf, const struct btf_param *arg
>         return btf_param_match_suffix(btf, arg, "__prog");
>  }
>
> +static int set_kfunc_arg_prog_regno(struct bpf_verifier_env *env, struct=
 bpf_kfunc_call_arg_meta *meta, u32 regno)
> +{
> +       if (meta->arg_prog) {
> +               verifier_bug(env, "Only 1 prog->aux argument supported pe=
r-kfunc");
> +               return -EFAULT;
> +       }
> +       meta->arg_prog =3D true;
> +       cur_aux(env)->arg_prog =3D regno;
> +
> +       return 0;
> +}
> +
>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>                                           const struct btf_param *arg,
>                                           const char *name)
> @@ -13050,6 +13067,21 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                 return -EINVAL;
>         }
>
> +       /* KF_IMPLICIT_PROG_AUX_ARG means that the kfunc has one less arg=
ument in BTF,
> +        * so we have to set_kfunc_arg_prog_regno() outside the arg check=
 loop.
> +        */

Use kernel comment style.

> +       if (is_kfunc_with_implicit_prog_aux_arg(meta)) {
> +               if (nargs + 1 > MAX_BPF_FUNC_REG_ARGS) {
> +                       verifier_bug(env, "A kfunc with KF_IMPLICIT_PROG_=
AUX_ARG flag has %d > %d args",
> +                                    nargs + 1, MAX_BPF_FUNC_REG_ARGS);
> +                       return -EFAULT;
> +               }
> +               u32 regno =3D nargs + 1;

Variable declaration should be first in the block
followed by a blank line.

Also I would remove this double "> MAX_BPF_FUNC_REG_ARGS" check.
Move if (is_kfunc_with_prog_last_arg(meta))
couple lines above before the check,
and actual_nargs =3D nargs + 1;
if (actual_nargs > MAX_BPF_FUNC_REG_ARGS)
to cover both cases.
I wouldn't worry that verbose() isn't too specific.
If it prints nargs and actual_nargs whoever develops a kfunc
can get an idea.
Also in the future there is a good chance we will add more
KF_FOO_LAST_ARG flags to cleanup other *_impl() kfuncs
that have a special last argument, like bpf_rbtree_add_impl.
If all of them copy paste "> MAX_BPF_FUNC_REG_ARGS" check
it will be too verbose. Hence one nargs check for them all.

pw-bot: cr

