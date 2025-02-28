Return-Path: <bpf+bounces-52920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B79BA4A5ED
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C42A189C194
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCF1D9A5D;
	Fri, 28 Feb 2025 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHg4Su7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA323F39A
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781881; cv=none; b=g/8hw8ulW8DXypNoruXT8fmpVvq4+uB9VceEtCbqx2raBw6o9mYvCXro2PcpiW2SsRIIhcvUeNglshuPjw0cZh5Cb9q43jzaMEM1589V7GmO9/8vvbh92urxgrZv7Qu15cJu8YY+ce6P6C3zTd4G1HRbcp+IDJbPXZC6AfxYiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781881; c=relaxed/simple;
	bh=/5wOWy0G7FerhymVyhiYeJNrpdUV05PBgnNnrPu7IuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJkVeMh/CgKf2XawnGBHrsL0xkWW/ExpHdBp3dEjWweGAGcQFMF8qW274L9qSFGhY0HV3uDDvI3oDJYXuCBZyfKCfLNOG2KmyWUcLQcLOwlv7XM1GUZ4Km7mZYXn//owwjmJJQF3kpvLu7O7R16dxHvLhpkTZXGMbfbYw4L5bO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHg4Su7z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so5497679a91.3
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740781879; x=1741386679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDL/WtQIkCNVViEjhDLR/2hlYkAeAdEfshXhnGkCqm0=;
        b=VHg4Su7zl14898ANxOi59qQI6IzF4dJiMoYil1HlEwxx9cJ8iNRL/CMqx+h0+N3+Fm
         8qd3UngrXDQEWBrM1q1WRi6CWR8FcX/x++r4wjq0Vc+DW0fdtYSBhRhEjqY/yd/X/oAl
         NV3CnLgkrk7BSt3KDRCpO1ybeN3A62LuSzAB0SE1++foQqytXsqG5NuCu/oXR6bb1mqI
         LnPwJE/OUlfFzMxqSyoiljfwf9dCL5d/qvXxOVmDR7aDXCgS5HpEd6bDZI/4Ms4JfOft
         yodsaVCCJXou+Lr86MGWExDW9Q7bDCGm5H0f2pEVtpKaIB1Nc5qbBRaqNVFeEVlmo4v4
         FJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781879; x=1741386679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDL/WtQIkCNVViEjhDLR/2hlYkAeAdEfshXhnGkCqm0=;
        b=wytnYyR8sVm6ZOJ8pFavX1oPR1eIi/NNEC5bWZ1mxyKVCL852Ld4J1Zzy1mTbJ8TZQ
         v1hRsnmmFhAZLWdgCwH6npzOZL4hEstx5ZipxkTFLfhEhBpRElbPhZ2ZxxM3xAmevT9h
         wl/ahh63k/IwnI0OaJmNgXWZYq6jNeMJf0F99nkLzkhzsR99M0jhAkqn31OURH9mPmFp
         0hgRA0+Ky6OyiQTERD+BBCDd76dEXMW8mU9w6YF8EVr94o0sjNkkmfrKvU1hJqxWmlSY
         nsYNXacKxGStiEEG0mdiYYzzso6b+cmOUYbysWkCrSckWOZGM/r3dAUsoOmyfOQum1vB
         qvdQ==
X-Gm-Message-State: AOJu0YxbOOe9jnn+RA5IYDobjhlu/umEJXBX9oPenkV05PXzgV1Xzpl0
	BD3h30UlQH9DR+GIzkirdKZlaUxKyMqDg99hP5mKd+NTRjcDY6IoE9D4yZf7L/rZWsLd8xX+xtQ
	ke2epPTB8zHktlKUYstcl4/zXicE=
X-Gm-Gg: ASbGnctntVS7PKeegNOzBVLH65G9yaBGm66oFsDmglyp+utkhe7tjT9vxIWvpY7cCLV
	mY9Zfhcon9to/FdakDP7WL0NkdvgfoG5H5NhzW7H+I3EMK8RBoB73cd7doF4/hP2/BUNnGZuAhc
	bPhyyxHKg4e9teq/3oXwhHV/0=
X-Google-Smtp-Source: AGHT+IHyws9IuUmN+PbB2yLQzDlgp2HK1TNgFDQIzKVuHzaOFC4rJ6Y9tQ9fhlO2YS/bOfzciiLP3v4ezDljns1umI4=
X-Received: by 2002:a17:90b:3a8d:b0:2fe:a292:793 with SMTP id
 98e67ed59e1d1-2febab78826mr7294989a91.21.1740781878927; Fri, 28 Feb 2025
 14:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com> <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:31:07 -0800
X-Gm-Features: AQ5f1JrGqQBlE-FtPR4UfnbGG67_2Vjf-Nc3fHRT9edDgtPaabRPMAtV1wfUFzc
Message-ID: <CAEf4BzasCWbVxZ-3SZzxgd3CPHTeN82vO1-qj2_L5QGMaO0-pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: split bpf object load into prepare/load
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:53=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce bpf_object__prepare API: additional intermediate step,
> executing all steps that bpf_object__load is running before the actual
> loading of BPF programs.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 161 +++++++++++++++++++++++++++------------
>  tools/lib/bpf/libbpf.h   |   9 +++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 121 insertions(+), 50 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 9ced1ce2334c..dd2f64903c3b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
>
>  int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>  {
> -       if (map->obj->state >=3D OBJ_LOADED)
> +       if (map->obj->state >=3D OBJ_PREPARED)

ah, ok, so you've decided to change that in this patch... that works
as well, I guess

>                 return libbpf_err(-EBUSY);
>
>         map->autocreate =3D autocreate;
> @@ -4952,7 +4952,7 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *=
map)
>
>  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
>  {
> -       if (map->obj->state >=3D OBJ_LOADED)
> +       if (map->obj->state >=3D OBJ_PREPARED)
>                 return libbpf_err(-EBUSY);
>
>         map->def.max_entries =3D max_entries;
> @@ -5199,7 +5199,7 @@ static void bpf_map__destroy(struct bpf_map *map);
>
>  static bool map_is_created(const struct bpf_map *map)

we should use this helper in bpf_map__set_max_entries() and other
setters like that. We better error out when someone is trying to set
different value size for the map that was explicitly set from FD with
bpf_map__reuse_fd()... Can you please add a patch that would fix this
up (before all this OBJ_PREPARED refactoring)?

>  {
> -       return map->obj->state >=3D OBJ_LOADED || map->reused;
> +       return map->obj->state >=3D OBJ_PREPARED || map->reused;
>  }
>
>  static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map=
 *map, bool is_inner)
> @@ -7901,13 +7901,6 @@ bpf_object__load_progs(struct bpf_object *obj, int=
 log_level)
>         size_t i;
>         int err;
>
> -       for (i =3D 0; i < obj->nr_programs; i++) {
> -               prog =3D &obj->programs[i];
> -               err =3D bpf_object__sanitize_prog(obj, prog);
> -               if (err)
> -                       return err;
> -       }
> -
>         for (i =3D 0; i < obj->nr_programs; i++) {
>                 prog =3D &obj->programs[i];
>                 if (prog_is_subprog(obj, prog))
> @@ -7933,6 +7926,21 @@ bpf_object__load_progs(struct bpf_object *obj, int=
 log_level)
>         return 0;
>  }
>
> +static int bpf_object_prepare_progs(struct bpf_object *obj)
> +{
> +       struct bpf_program *prog;
> +       size_t i;
> +       int err;
> +
> +       for (i =3D 0; i < obj->nr_programs; i++) {
> +               prog =3D &obj->programs[i];
> +               err =3D bpf_object__sanitize_prog(obj, prog);
> +               if (err)
> +                       return err;
> +       }
> +       return 0;
> +}
> +
>  static const struct bpf_sec_def *find_sec_def(const char *sec_name);
>
>  static int bpf_object_init_progs(struct bpf_object *obj, const struct bp=
f_object_open_opts *opts)
> @@ -8549,9 +8557,72 @@ static int bpf_object_prepare_struct_ops(struct bp=
f_object *obj)
>         return 0;
>  }
>
> +static void bpf_object_unpin(struct bpf_object *obj)
> +{
> +       int i;
> +
> +       /* unpin any maps that were auto-pinned during load */
> +       for (i =3D 0; i < obj->nr_maps; i++)
> +               if (obj->maps[i].pinned && !obj->maps[i].reused)
> +                       bpf_map__unpin(&obj->maps[i], NULL);
> +}
> +
> +static void bpf_object_post_load_cleanup(struct bpf_object *obj)
> +{
> +       int i;
> +
> +       /* clean up fd_array */
> +       zfree(&obj->fd_array);
> +
> +       /* clean up module BTFs */
> +       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> +               close(obj->btf_modules[i].fd);
> +               btf__free(obj->btf_modules[i].btf);
> +               free(obj->btf_modules[i].name);
> +       }
> +       free(obj->btf_modules);
> +
> +       /* clean up vmlinux BTF */
> +       btf__free(obj->btf_vmlinux);
> +       obj->btf_vmlinux =3D NULL;
> +}
> +
> +static int bpf_object_prepare(struct bpf_object *obj, const char *target=
_btf_path)
> +{
> +       int err;
> +
> +       if (!obj)
> +               return -EINVAL;

meh, drop this please, can't be NULL

> +
> +       if (obj->state >=3D OBJ_PREPARED) {
> +               pr_warn("object '%s': prepare loading can't be attempted =
twice\n", obj->name);
> +               return -EINVAL;
> +       }
> +
> +       err =3D bpf_object_prepare_token(obj);
> +       err =3D err ? : bpf_object__probe_loading(obj);
> +       err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
> +       err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> +       err =3D err ? : bpf_object__sanitize_maps(obj);
> +       err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
> +       err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
> +       err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
> +       err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> +       err =3D err ? : bpf_object__create_maps(obj);
> +       err =3D err ? : bpf_object_prepare_progs(obj);
> +       obj->state =3D OBJ_PREPARED;
> +
> +       if (err) {
> +               bpf_object_unpin(obj);
> +               bpf_object_unload(obj);
> +               return err;
> +       }
> +       return 0;
> +}
> +
>  static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
>  {
> -       int err, i;
> +       int err;
>
>         if (!obj)
>                 return libbpf_err(-EINVAL);
> @@ -8571,17 +8642,12 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
>                 return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
>         }
>
> -       err =3D bpf_object_prepare_token(obj);
> -       err =3D err ? : bpf_object__probe_loading(obj);
> -       err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
> -       err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> -       err =3D err ? : bpf_object__sanitize_maps(obj);
> -       err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
> -       err =3D err ? : bpf_object_adjust_struct_ops_autoload(obj);
> -       err =3D err ? : bpf_object__relocate(obj, obj->btf_custom_path ? =
: target_btf_path);
> -       err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> -       err =3D err ? : bpf_object__create_maps(obj);
> -       err =3D err ? : bpf_object__load_progs(obj, extra_log_level);
> +       if (obj->state < OBJ_PREPARED) {
> +               err =3D bpf_object_prepare(obj, target_btf_path);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +       err =3D bpf_object__load_progs(obj, extra_log_level);
>         err =3D err ? : bpf_object_init_prog_arrays(obj);
>         err =3D err ? : bpf_object_prepare_struct_ops(obj);
>
> @@ -8593,35 +8659,22 @@ static int bpf_object_load(struct bpf_object *obj=
, int extra_log_level, const ch
>                         err =3D bpf_gen__finish(obj->gen_loader, obj->nr_=
programs, obj->nr_maps);
>         }
>
> -       /* clean up fd_array */
> -       zfree(&obj->fd_array);
> +       bpf_object_post_load_cleanup(obj);
> +       obj->state =3D OBJ_LOADED;/* doesn't matter if successfully or no=
t */
>
> -       /* clean up module BTFs */
> -       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> -               close(obj->btf_modules[i].fd);
> -               btf__free(obj->btf_modules[i].btf);
> -               free(obj->btf_modules[i].name);
> +       if (err) {
> +               bpf_object_unpin(obj);
> +               bpf_object_unload(obj);
> +               pr_warn("failed to load object '%s'\n", obj->path);
> +               return libbpf_err(err);
>         }
> -       free(obj->btf_modules);
> -
> -       /* clean up vmlinux BTF */
> -       btf__free(obj->btf_vmlinux);
> -       obj->btf_vmlinux =3D NULL;
> -
> -       obj->state =3D OBJ_LOADED;/* doesn't matter if successfully or no=
t */
> -       if (err)
> -               goto out;
>
>         return 0;
> -out:
> -       /* unpin any maps that were auto-pinned during load */
> -       for (i =3D 0; i < obj->nr_maps; i++)
> -               if (obj->maps[i].pinned && !obj->maps[i].reused)
> -                       bpf_map__unpin(&obj->maps[i], NULL);
> +}
>
> -       bpf_object_unload(obj);
> -       pr_warn("failed to load object '%s'\n", obj->path);
> -       return libbpf_err(err);
> +int bpf_object__prepare(struct bpf_object *obj)
> +{
> +       return libbpf_err(bpf_object_prepare(obj, NULL));
>  }
>
>  int bpf_object__load(struct bpf_object *obj)
> @@ -8871,8 +8924,8 @@ int bpf_object__pin_maps(struct bpf_object *obj, co=
nst char *path)
>         if (!obj)
>                 return libbpf_err(-ENOENT);
>
> -       if (obj->state < OBJ_LOADED) {
> -               pr_warn("object not yet loaded; load it first\n");
> +       if (obj->state < OBJ_PREPARED) {
> +               pr_warn("object not yet loaded/prepared; load/prepare it =
first\n");

let's keep the original simpler message, this is way too much of
either/or. Most users will never care about bpf_object__prepare()
anyways.

>                 return libbpf_err(-ENOENT);
>         }
>
> @@ -9069,6 +9122,14 @@ void bpf_object__close(struct bpf_object *obj)
>         if (IS_ERR_OR_NULL(obj))
>                 return;
>
> +       /*
> +        * if user called bpf_object__prepare() without ever getting to
> +        * bpf_object__load(), we need to clean up stuff that is normally
> +        * cleaned up at the end of loading step
> +        */
> +       if (obj->state =3D=3D OBJ_PREPARED)
> +               bpf_object_post_load_cleanup(obj);
> +

let's make bpf_object_post_load_cleanup() idempotent, so calling it
multiple times won't hurt, it should be pretty simple (just set
obj->btf_module_cnt to zero)

>         usdt_manager_free(obj->usdt_man);
>         obj->usdt_man =3D NULL;
>
> @@ -10304,7 +10365,7 @@ static int map_btf_datasec_resize(struct bpf_map =
*map, __u32 size)
>
>  int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>  {
> -       if (map->obj->state >=3D OBJ_LOADED || map->reused)
> +       if (map->obj->state >=3D OBJ_PREPARED || map->reused)
>                 return libbpf_err(-EBUSY);
>
>         if (map->mmaped) {
> @@ -10350,7 +10411,7 @@ int bpf_map__set_initial_value(struct bpf_map *ma=
p,
>  {
>         size_t actual_sz;
>
> -       if (map->obj->state >=3D OBJ_LOADED || map->reused)
> +       if (map->obj->state >=3D OBJ_PREPARED || map->reused)
>                 return libbpf_err(-EBUSY);
>
>         if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG)
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3020ee45303a..09e87998c64e 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -241,6 +241,15 @@ LIBBPF_API struct bpf_object *
>  bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
>                      const struct bpf_object_open_opts *opts);
>
> +/**
> + * @brief **bpf_object__prepare()** prepares BPF object for loading.

a bit too brief. Please add that preparation step performs ELF
processing, relocations, prepares final state of BPF program
instructions (accessible with bpf_program__insns()), creates and
(potentially) pins maps, and stops short of loading BPF programs.

This is an important aspect that veristat and others will be relying
on, so it should be documented properly

> + * @param obj Pointer to a valid BPF object instance returned by
> + * **bpf_object__open*()** API
> + * @return 0, on success; negative error code, otherwise, error code is
> + * stored in errno
> + */
> +int bpf_object__prepare(struct bpf_object *obj);
> +
>  /**
>   * @brief **bpf_object__load()** loads BPF object into kernel.
>   * @param obj Pointer to a valid BPF object instance returned by
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index b5a838de6f47..22edde0bf85e 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
>                 bpf_linker__new_fd;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
> +               bpf_object__prepare;

this is sorted list

pw-bot: cr

>  } LIBBPF_1.5.0;
> --
> 2.48.1
>

