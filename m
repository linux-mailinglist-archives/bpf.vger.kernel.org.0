Return-Path: <bpf+bounces-52918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17CA4A5C9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784663B9165
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CF1DE2C4;
	Fri, 28 Feb 2025 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTOc4Avx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CA1C54AF
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781237; cv=none; b=pIpzhp64hbz2gawVWXaYrcSM/lOnG7gInaI563dHDzhoC2MucbhYnAezFAO2Ggdwup5hIzN1S2C2OkpZvzhsgA0hBISQI6gzdoV0sU+EpaUkwVQu3XPRuqRI0gU7oW0+EbnBqyKELQBkVyHf1p1pub4XGpvcSeea3h8xfBEtqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781237; c=relaxed/simple;
	bh=kc8EX2Uxt6Dwdv4AWDs9+i47x82d4cwlWo6wo7PsTV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWKaq/Ow3CmVZquyVJOsk6OgyicQWtBtHJFBN4tLe8aGCktJpqvmubQUhpcYmvadC3aI9QlszE9lvaVs3Z0RSEh+1bYPHDMCG8WRi3cBHuu5Bj9cfQB/WY8+OV1RdFfxNvoCUbbhSO/TrV/zH85pldI9abPqPtDfKFwb9wJBMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTOc4Avx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so5111077a91.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740781235; x=1741386035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN4LE6uvju1aptQf+wn8ZWDGK266Yw4gLbPe0eIlSq8=;
        b=kTOc4AvxfgsmaJ5DIOKb1WlEZsY7fSsOulOL/22Iy+FMC1WEMH/fN86UpqNPhfGCbK
         PBLrOxbQBeyzOajhqMdhcJIMnl2ilXe2ycSGfLtRgFSy0VbZTvpjbyJcL9r/GSxBSARY
         KnCJdgtN0SlnVS4KMIrR3mm+rEhFzYkLu9KhXIa1GHA8BZVnoVhc4YP6Bqv6zZ7wFZod
         ZmWfVwp549mjFwT+rlUQd9mgHNrTb6XpX9MvnS2fjscxctI3Neo3VtEEqlTnj01we726
         7BSqbZaVcdtOM/QJTGbaJvLCN2CR7EGPd7g6cLadN1F6sXT6WNGpri7zcnhBqFo+7nKq
         ufJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781235; x=1741386035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN4LE6uvju1aptQf+wn8ZWDGK266Yw4gLbPe0eIlSq8=;
        b=rVK68gfgUVcvMHYkHsrrncII4hYd64Hl8DeMdvPFaWSXg4+bnx1cLxOIMTaiWUPAAc
         zHYelp/459tBt/0oQ04WYEYVCUBaEMNtc2+3I6fuGlpeO6rNnr0zT7ioYnwgQliUg6qP
         x9fS5K4tAe5IIcTs2PxCesvMXX1m9xUH7JecpCbdYdzL/35WJaEZCD2J3xr9lgewCuhK
         cM1Edm8OfVgASQd/PYElni4jTYHZVMPqaTxkgaFcxoFTzwNS6O7+1jLnVoF10u/hIz60
         Cl91dOJUCBNAZpDPfBagK57DLY8khaw82usMQRMSnkz0O7YHV4JUzjRx+K084eU5lhYo
         2fpQ==
X-Gm-Message-State: AOJu0YxeVSfQnp1yFS37nsbEHmtCrr/8ZW6k/bIq18qcN1a5wI6/WBO5
	+HPNl5vduQmes0AOwo1I3mL+yTevcSG09cWDJu+GnpEH/LXTX3n9tORH/V0gzjPa28AH+UnNRZ0
	BCzoEj8l0HWb7gNW5VhMiIsOAm7uQpw==
X-Gm-Gg: ASbGncsRdl1A+rhvsADimwWoqmBer4yZ9RjMmRR6zEmDRZSiQ+qNAr/kCWALWVYWvBp
	dipG7PLRlh6R2bDC4hocBctiH+GJ4hDwhtQQU8FpRp7PD/5p8iA5p9Cmlgs32MlLhumjRU8odDo
	osl96U//IO6FSnAbqBVBJBya4Fr4fK/XuUzNh5a/0TeA==
X-Google-Smtp-Source: AGHT+IH402TFG6oCfdNiObL5OhOxMoi+721IIbva1XGIaPFa29y5cKN5p8OSEljce04P1Hm45qt0Uu/8hMn0S857ChA=
X-Received: by 2002:a17:90b:33c2:b0:2fe:84d6:cdfc with SMTP id
 98e67ed59e1d1-2febabfb00emr8001935a91.35.1740781235367; Fri, 28 Feb 2025
 14:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com> <20250228175255.254009-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250228175255.254009-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 14:20:21 -0800
X-Gm-Features: AQ5f1JrOXIFIx-brB9p7tgdFakcnEMCnaPQbPApr7MF0IELwHbpT9oY2YK1mCnM
Message-ID: <CAEf4BzZHpjDgjAT0tJhcr7Tj084RyjM6ipTmcYVzKvZGJgUqkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: introduce more granular state for bpf_object
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
> Add struct bpf_object_state, substitute bpf_object member loaded by
> state. State could be OBJ_OPEN - indicates that bpf_object was just
> created, OBJ_PREPARED - prepare step will be introduced in the next
> patch, OBJ_LOADED - indicates that bpf_object is loaded, similar to
> loaded=3Dtrue currently.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 47 +++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 899e98225f3b..9ced1ce2334c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -670,11 +670,18 @@ struct elf_state {
>
>  struct usdt_manager;
>
> +enum bpf_object_state {
> +       OBJ_OPEN,
> +       OBJ_PREPARED,
> +       OBJ_LOADED,
> +};
> +
>  struct bpf_object {
>         char name[BPF_OBJ_NAME_LEN];
>         char license[64];
>         __u32 kern_version;
>
> +       enum bpf_object_state state;
>         struct bpf_program *programs;
>         size_t nr_programs;
>         struct bpf_map *maps;
> @@ -686,7 +693,6 @@ struct bpf_object {
>         int nr_extern;
>         int kconfig_map_idx;
>
> -       bool loaded;
>         bool has_subcalls;
>         bool has_rodata;
>
> @@ -1511,7 +1517,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
>         obj->kconfig_map_idx =3D -1;
>
>         obj->kern_version =3D get_kernel_version();
> -       obj->loaded =3D false;
> +       obj->state  =3D OBJ_OPEN;
>
>         return obj;
>  }
> @@ -4852,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
>
>  int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>  {
> -       if (map->obj->loaded)
> +       if (map->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         map->autocreate =3D autocreate;
> @@ -4946,7 +4952,7 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *=
map)
>
>  int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
>  {
> -       if (map->obj->loaded)
> +       if (map->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         map->def.max_entries =3D max_entries;
> @@ -5193,7 +5199,7 @@ static void bpf_map__destroy(struct bpf_map *map);
>
>  static bool map_is_created(const struct bpf_map *map)
>  {
> -       return map->obj->loaded || map->reused;
> +       return map->obj->state >=3D OBJ_LOADED || map->reused;
>  }
>
>  static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map=
 *map, bool is_inner)
> @@ -8550,7 +8556,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
>         if (!obj)
>                 return libbpf_err(-EINVAL);
>
> -       if (obj->loaded) {
> +       if (obj->state >=3D OBJ_LOADED) {
>                 pr_warn("object '%s': load can't be attempted twice\n", o=
bj->name);
>                 return libbpf_err(-EINVAL);
>         }
> @@ -8602,8 +8608,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
>         btf__free(obj->btf_vmlinux);
>         obj->btf_vmlinux =3D NULL;
>
> -       obj->loaded =3D true; /* doesn't matter if successfully or not */
> -
> +       obj->state =3D OBJ_LOADED;/* doesn't matter if successfully or no=
t */
>         if (err)
>                 goto out;
>
> @@ -8866,7 +8871,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, co=
nst char *path)
>         if (!obj)
>                 return libbpf_err(-ENOENT);
>
> -       if (!obj->loaded) {
> +       if (obj->state < OBJ_LOADED) {

this one seems ok in OBJ_PREPARED as well, all the maps will be
created by that time

>                 pr_warn("object not yet loaded; load it first\n");
>                 return libbpf_err(-ENOENT);
>         }
> @@ -8945,7 +8950,7 @@ int bpf_object__pin_programs(struct bpf_object *obj=
, const char *path)
>         if (!obj)
>                 return libbpf_err(-ENOENT);
>
> -       if (!obj->loaded) {
> +       if (obj->state < OBJ_LOADED) {
>                 pr_warn("object not yet loaded; load it first\n");
>                 return libbpf_err(-ENOENT);
>         }
> @@ -9132,7 +9137,7 @@ int bpf_object__btf_fd(const struct bpf_object *obj=
)
>
>  int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
>  {
> -       if (obj->loaded)
> +       if (obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EINVAL);
>
>         obj->kern_version =3D kern_version;
> @@ -9229,7 +9234,7 @@ bool bpf_program__autoload(const struct bpf_program=
 *prog)
>
>  int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
>  {
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EINVAL);
>
>         prog->autoload =3D autoload;
> @@ -9261,7 +9266,7 @@ int bpf_program__set_insns(struct bpf_program *prog=
,
>  {
>         struct bpf_insn *insns;
>
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         insns =3D libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*=
insns));
> @@ -9304,7 +9309,7 @@ static int last_custom_sec_def_handler_id;
>
>  int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type t=
ype)
>  {
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         /* if type is not changed, do nothing */
> @@ -9335,7 +9340,7 @@ enum bpf_attach_type bpf_program__expected_attach_t=
ype(const struct bpf_program
>  int bpf_program__set_expected_attach_type(struct bpf_program *prog,
>                                            enum bpf_attach_type type)
>  {
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         prog->expected_attach_type =3D type;
> @@ -9349,7 +9354,7 @@ __u32 bpf_program__flags(const struct bpf_program *=
prog)
>
>  int bpf_program__set_flags(struct bpf_program *prog, __u32 flags)
>  {
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         prog->prog_flags =3D flags;
> @@ -9363,7 +9368,7 @@ __u32 bpf_program__log_level(const struct bpf_progr=
am *prog)
>
>  int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level=
)
>  {
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         prog->log_level =3D log_level;
> @@ -9382,7 +9387,7 @@ int bpf_program__set_log_buf(struct bpf_program *pr=
og, char *log_buf, size_t log
>                 return libbpf_err(-EINVAL);
>         if (prog->log_size > UINT_MAX)
>                 return libbpf_err(-EINVAL);
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EBUSY);
>
>         prog->log_buf =3D log_buf;
> @@ -10299,7 +10304,7 @@ static int map_btf_datasec_resize(struct bpf_map =
*map, __u32 size)
>
>  int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>  {
> -       if (map->obj->loaded || map->reused)
> +       if (map->obj->state >=3D OBJ_LOADED || map->reused)

OBJ_PREPARED, maps can't be changed after that step

>                 return libbpf_err(-EBUSY);
>
>         if (map->mmaped) {
> @@ -10345,7 +10350,7 @@ int bpf_map__set_initial_value(struct bpf_map *ma=
p,
>  {
>         size_t actual_sz;
>
> -       if (map->obj->loaded || map->reused)
> +       if (map->obj->state >=3D OBJ_LOADED || map->reused)

ditto, I think we have to ban it after OBJ_PREPARED


>                 return libbpf_err(-EBUSY);
>
>         if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG)
> @@ -13666,7 +13671,7 @@ int bpf_program__set_attach_target(struct bpf_pro=
gram *prog,
>         if (!prog || attach_prog_fd < 0)
>                 return libbpf_err(-EINVAL);
>
> -       if (prog->obj->loaded)
> +       if (prog->obj->state >=3D OBJ_LOADED)
>                 return libbpf_err(-EINVAL);
>
>         if (attach_prog_fd && !attach_func_name) {
> --
> 2.48.1
>

