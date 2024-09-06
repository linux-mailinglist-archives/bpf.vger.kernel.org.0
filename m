Return-Path: <bpf+bounces-39164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C796FCFD
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FE284C27
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA4158D7B;
	Fri,  6 Sep 2024 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sig9sfXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770B13D251
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656617; cv=none; b=ZSigVz2xpBltt8YIECmVxNHFPM7nPXSvOX8WFdGk98pRM0FpLnlPY+CV3xICFvftGvdXnPYOpbGhfRCeJokdC37mLe5tN8tFZIFJmO7RLMwV6Vekjzn+Pb7MJJF52M4ZMeiRPoGNOFi1a0wghQzkn7Yo9ajGDWFtBZMZzR2degk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656617; c=relaxed/simple;
	bh=J2lDXWN3oMRKTu6wKIeSLbcGHZz5xdKrrU6lN9laMfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ylj4lGv0WKIpHbp3lsaPvlO8PADXRjcvlZkMfQU9Iwucikt9DigLC9fw80SazGL7XA8UT/7eIFnxX81Sr5UlrSZ7z8cH0b6RnZ8fKTTRt4rWz806VFNUypcesw5+vLrugx1gkM+aVdb8JCcssP7NKkwKTY9BhcjbYNw/e/vLeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sig9sfXF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206f9b872b2so8112695ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656616; x=1726261416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlKu9VgT6p7xNaZRDOQkb58jkTjFkyQ8UhYkm0BTCM4=;
        b=Sig9sfXF69wFr1fSkIcmL0UZOIlm1uZWAzdfaUzDVIO+8u+rfMXwXnPQjTX8cWDxVZ
         86BhGufgeD5KrECLWXT242YX0s6Zn28Nh7xLIeNTAj213Xqf92jiWllWudBL5mW0XJQu
         1G7ZcgUsG+wCAGvY9mBr8GlSWtKzjvypInwRE1nmbugmKkEKmH24zoi9a5DDwXc9K+SW
         ggMB2KtNvUjuviA05k7R+OaXBOlHu5J/67L+dBupJr2pxQfv1E/vk4CKZJDl4uMlisy3
         IzAUcU3GM21zyf4Ey2cR2hIsa3wN6TnFGox2lJ//Z46+6Nqf3vwQw+DcjKj+njmg2cP3
         JEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656616; x=1726261416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlKu9VgT6p7xNaZRDOQkb58jkTjFkyQ8UhYkm0BTCM4=;
        b=k+OiwfS103K9xHXRt6SUVozCe/p8jb1o4/Do1UlJfETqhokxh3hoXlqWFuu7wZfs0m
         lGOYeGGso3oNBTQzV+p6re5mHP6oywsgpbnraSbMFzCMoZ5/WB8YSfcFnaUrGOJ5mpuV
         BHP6uW3MMp4cEZrIFkgm+1dpU9ZnSCQHj+Qun4tp1iCth9BVlB26stSVX9rtOd6c8Rrh
         513fNdhvqJT37tpdE+at9Lr4PB5dPd24QoiomeMvTMKYAif5lmFxEo7fVZ5V+AMjSozX
         yNwObNWP8woDmkpiyvgvGzNstYdELkUhih33439muz2AAg8Gr0KH+ASi3Hq8HjKi6Jmi
         7ktA==
X-Gm-Message-State: AOJu0YwRgzGDbe3ZP/K5mnX26Ayl7WR7AJM8iLMElX0Azuj6IsOhafVw
	ALIYESyN0QXaglPvcsbWiwOJK/w1p9+BNhOiFFAOsuvRNi2VgB5eVewbJ7DmdgpcU/Gewz0LlpW
	IvcK8b/415gHoAcgJRCev3gqDvh0=
X-Google-Smtp-Source: AGHT+IGJuufQbdKm7Vye4xiO9eEOFfdpFnAvtL8ZW3sagJfAKlGfWSxcN6MXv90Nlzy2wolHB8uhowp+Xp7gtTBnD04=
X-Received: by 2002:a17:90b:383:b0:2d6:1c0f:fea6 with SMTP id
 98e67ed59e1d1-2dad50d1bf2mr4714059a91.11.1725656615527; Fri, 06 Sep 2024
 14:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-3-daniel@iogearbox.net>
In-Reply-To: <20240906135608.26477-3-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:03:14 -0700
Message-ID: <CAEf4Bzag4+pNTuYjqLRN9x+bNe_6o=hv+PSkxwh2VKUhMqzpAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Fix helper writes to read-only maps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, shung-hsi.yu@suse.com, andrii@kernel.org, 
	ast@kernel.org, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Lonial found an issue that despite user- and BPF-side frozen BPF map
> (like in case of .rodata), it was still possible to write into it from
> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
> as arguments.
>
> In check_func_arg() when the argument is as mentioned, the meta->raw_mode
> is never set. Later, check_helper_mem_access(), under the case of
> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> subsequent call to check_map_access_type() and given the BPF map is
> read-only it succeeds.
>
> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UN=
INIT
> when results are written into them as opposed to read out of them. The
> latter indicates that it's okay to pass a pointer to uninitialized memory
> as the memory is written to anyway.
>
> However, ARG_PTR_TO_{LONG,INT} is a special case of ARG_PTR_TO_FIXED_SIZE=
_MEM
> just with additional alignment requirement. So it is better to just get
> rid of the ARG_PTR_TO_{LONG,INT} special cases altogether and reuse the
> fixed size memory types. For this, add MEM_ALIGNED to additionally ensure
> alignment given these helpers write directly into the args via *<ptr> =3D=
 val.
> The .arg*_size has been initialized reflecting the actual sizeof(*<ptr>).
>
> MEM_ALIGNED can only be used in combination with MEM_FIXED_SIZE annotated
> argument types, since in !MEM_FIXED_SIZE cases the verifier does not know
> the buffer size a priori and therefore cannot blindly write *<ptr> =3D va=
l.
>
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>  - switch to MEM_FIXED_SIZE
>  v3 -> v4:
>  - fixed 64bit in strto{u,}l (Alexei)
>
>  include/linux/bpf.h      |  7 +++++--
>  kernel/bpf/helpers.c     |  8 ++++++--
>  kernel/bpf/syscall.c     |  4 +++-
>  kernel/bpf/verifier.c    | 38 +++++---------------------------------
>  kernel/trace/bpf_trace.c |  8 ++++++--
>  net/core/filter.c        |  8 ++++++--
>  6 files changed, 31 insertions(+), 42 deletions(-)
>

Very neat. I only have stylistic nits, but LGTM anyways

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 5404bb964d83..0587d0c2375a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -537,7 +537,9 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> +                         MEM_UNINIT | MEM_ALIGNED,

nit: I wouldn't wrap the line here and everywhere else

> +       .arg4_size      =3D sizeof(s64),
>  };
>
>  BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> @@ -563,7 +565,9 @@ const struct bpf_func_proto bpf_strtoul_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_ANYTHING,
> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> +                         MEM_UNINIT | MEM_ALIGNED,
> +       .arg4_size      =3D sizeof(u64),
>  };
>

[...]

>  static const struct bpf_reg_types spin_lock_types =3D {
>         .types =3D {
>                 PTR_TO_MAP_VALUE,
> @@ -8453,8 +8433,6 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
>         [ARG_PTR_TO_SPIN_LOCK]          =3D &spin_lock_types,
>         [ARG_PTR_TO_MEM]                =3D &mem_types,
>         [ARG_PTR_TO_RINGBUF_MEM]        =3D &ringbuf_mem_types,
> -       [ARG_PTR_TO_INT]                =3D &int_ptr_types,
> -       [ARG_PTR_TO_LONG]               =3D &int_ptr_types,
>         [ARG_PTR_TO_PERCPU_BTF_ID]      =3D &percpu_btf_ptr_types,
>         [ARG_PTR_TO_FUNC]               =3D &func_ptr_types,
>         [ARG_PTR_TO_STACK]              =3D &stack_ptr_types,
> @@ -9020,6 +8998,11 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>                         err =3D check_helper_mem_access(env, regno,
>                                                       fn->arg_size[arg], =
false,
>                                                       meta);
> +                       if (err)
> +                               return err;
> +                       if (arg_type & MEM_ALIGNED)
> +                               err =3D check_ptr_alignment(env, reg, 0,
> +                                                         fn->arg_size[ar=
g], true);

nit: we should take advantage of 100 character lines and make this streamli=
ned:

@@ -9016,11 +9016,10 @@ static int check_func_arg(struct
bpf_verifier_env *env, u32 arg,
                 * next is_mem_size argument below.
                 */
                meta->raw_mode =3D arg_type & MEM_UNINIT;
-               if (arg_type & MEM_FIXED_SIZE) {
-                       err =3D check_helper_mem_access(env, regno,
-                                                     fn->arg_size[arg], fa=
lse,
-                                                     meta);
-               }
+               if (arg_type & MEM_FIXED_SIZE)
+                       err =3D check_helper_mem_access(env, regno,
fn->arg_size[arg], false, meta);
+               if (arg_type & MEM_ALIGNED)
+                       err =3D err ?: check_ptr_alignment(env, reg, 0,
fn->arg_size[arg], true);
                break;

>                 }
>                 break;
>         case ARG_CONST_SIZE:
> @@ -9044,17 +9027,6 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>                 if (err)
>                         return err;
>                 break;

[...]

