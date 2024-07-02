Return-Path: <bpf+bounces-33669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC69249AB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD84285C95
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26720013B;
	Tue,  2 Jul 2024 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjxO1IIB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C701BA06B
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954113; cv=none; b=kNHuTodPlfXVMWwbdlYXPIQ3+T0QOgN7n5Xsa1L2soMnzOFWavB7Sd+RDpvsyU3D4SmjxWmXB+gTgQW0rcL1trkqgUh1dnwGq232numIB9lySPxbk5WC5laONSsieXMt2PVysI2GRvscWi/9Aqzs0DUvKiSXyUuk7zgmKDqHbNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954113; c=relaxed/simple;
	bh=D9VKOJYqfTtiI9NqvIwDS6YPsAoIL2Vdv6upAZt4fIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeL+LbEzObfw27NKGZou8rmhdavsIXbt9P2Og/r2AgNsIf3mktEUOoOGKxtp5sdXhAjywQ6D0LWi2ARaBR0L4T7Eg8UpTSAgbQ1cUy7Rk3yh4Tvqe3MdQYEkqArzWxCASLvPYH0gU3pHatXtzwRYItrwwuBI1dkpt46dUDXzWEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjxO1IIB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-718b714d362so2621333a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954111; x=1720558911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA5biUSOZ6bCmQe4/1F+HIZGzYi5zys+nYbTIX2rPtU=;
        b=YjxO1IIBhIPAfWXVD2s8uuoTBXoCf6t3tz7MUyvPGmb87AzhIoFnUDPHXMayBTb1ab
         tBmtcW3YxYYCeI4MBzPusTh0vP6snmoP37mWfvOwUVI6oovYF7ZYnAQ/3xBe+2IJB3E9
         pbJfHKwCSnshJdUl5pAbHnXXB49UTl5UzAjhwPEb+VBkCKJn6I9cPhhAxwpnNz5Q/KwO
         L1amqsxZSxErCYCTVmyLEkSsRNCJt2pkZOuIWnxSqfk1/9piFSgY+BG3Shdt2o2mEz7L
         u/nQY9Rbau9QXzZvs/ShZi7XgKihyHf7U38qHQ/15YfaCYNtSbcsd4qaPvUtWIHBsfv2
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954111; x=1720558911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA5biUSOZ6bCmQe4/1F+HIZGzYi5zys+nYbTIX2rPtU=;
        b=AHRrQh0ly0+/aCBiQs5IoSeRQSjJ4hAgu/b0Gm4yJjxbBD9JkHyPUGV7m4JM2vobSz
         iAG67iqyPlU9BP4H5cg1AF5xVe/oM3kBoF+pfc4jTsKuFKOtxwdEX/8OijnidZdIH0AT
         thDD5ML93iINwVk1ExLWICdw+dhCj9mxv2UACd0xr8nxbFwoLvcUEQcci758/iwIgupx
         jqoNJf+jM8Oas2fjiapHtZaVlaqIC3eV4CuVNBRWHmP+k/IpPs+60IfNiocMUR0YKiVv
         k6V9Yq+KPnYPiHgyYzkpn7gAsjgEOBtIm/Xfqh6weDgENZ0kdol4RlECKiuoKtafOp1N
         2H3g==
X-Gm-Message-State: AOJu0YwWW8YVrGgq8SlnokXh10iNZ2WdI29mRDsVFeh09iWs8aSX5NZz
	iTX6hRoqKKBxWpZHxerDGtSLk+Jk6UeDAAH70zWdNyfiCDi5rDQUA3rI+4Yn1Hu4CC94i9ZP9m6
	02nJzi/VzcoZbwfb+fXYrGCM/z+U=
X-Google-Smtp-Source: AGHT+IGZRmBWyGaxDNctl2XwYzu0fT4MsSUTqUvf6HqtmqkKGvVNgpa9qp1Ot5Zp/hVjZ3SvbQTMU2QyYlz6rbrmAyE=
X-Received: by 2002:a05:6a20:748a:b0:1bd:ce64:68dd with SMTP id
 adf61e73a8af0-1bef6198cbfmr10825664637.28.1719954110914; Tue, 02 Jul 2024
 14:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702195941.448432-1-yatsenko@meta.com>
In-Reply-To: <20240702195941.448432-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:01:39 -0700
Message-ID: <CAEf4BzY+gEacgRX+_pFYeciYm9VGZXNDURrRKS6uhuK-HO3MrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: use original struct sizes for skeleton iterations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:12=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> BPF skeletons can be created by previous or newer versions of libbpf,
> for which sizeof(bpf_map_skeleton) or bpf_prog_skeleton may differ.
> Libbpf should not rely on array indexing, but instead use original
> sizes via map_skel_sz/prog_skel_sz for iterating over the
> arrays of maps/progs.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
>

See mechanical suggestions below.

But importantly we should also try to make new generated skeleton
files as backwards compatible with all the libbpf versions with this
bug as possible. Can you add also bpftool patch that would keep
map_skel_sz at old value (not including new link field) if there are
no auto-attachable maps? This way latest bpftool won't break currently
released libbpf versions.

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4a28fac4908a..b46cf29d74b6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13712,14 +13712,16 @@ int libbpf_num_possible_cpus(void)
>
>  static int populate_skeleton_maps(const struct bpf_object *obj,

we can pass `struct bpf_object_skeleton *s` here instead of obj and
maps (they are accessible as s->obj and s->maps)

>                                   struct bpf_map_skeleton *maps,
> -                                 size_t map_cnt)
> +                                 size_t map_cnt, size_t map_sz)

and then we don't need to pass map_sz, it's s->map_skel_sz


>  {
>         int i;
>
>         for (i =3D 0; i < map_cnt; i++) {
> -               struct bpf_map **map =3D maps[i].map;
> -               const char *name =3D maps[i].name;
> -               void **mmaped =3D maps[i].mmaped;
> +               struct bpf_map_skeleton *map_skel =3D (struct bpf_map_ske=
leton *)
> +                       ((char *)maps + map_sz * i);

unnecessary casts, try something like:

struct bpf_map_skeleton *map_skel =3D (void *)s->maps + skel->map_skel_sz *=
 i;

fits on single line :)


> +               struct bpf_map **map =3D map_skel->map;
> +               const char *name =3D map_skel->name;
> +               void **mmaped =3D map_skel->mmaped;
>
>                 *map =3D bpf_object__find_map_by_name(obj, name);
>                 if (!*map) {
> @@ -13736,13 +13738,15 @@ static int populate_skeleton_maps(const struct =
bpf_object *obj,
>
>  static int populate_skeleton_progs(const struct bpf_object *obj,
>                                    struct bpf_prog_skeleton *progs,
> -                                  size_t prog_cnt)
> +                                  size_t prog_cnt, size_t prog_sz)
>  {
>         int i;
>
>         for (i =3D 0; i < prog_cnt; i++) {
> -               struct bpf_program **prog =3D progs[i].prog;
> -               const char *name =3D progs[i].name;
> +               struct bpf_prog_skeleton *cur_prog =3D (struct bpf_prog_s=
keleton *)
> +                       ((char *)progs + prog_sz * i);
> +               struct bpf_program **prog =3D cur_prog->prog;
> +               const char *name =3D cur_prog->name;
>

same suggestion as for populate_skeleton_maps

>                 *prog =3D bpf_object__find_program_by_name(obj, name);
>                 if (!*prog) {
> @@ -13783,13 +13787,13 @@ int bpf_object__open_skeleton(struct bpf_object=
_skeleton *s,
>         }
>
>         *s->obj =3D obj;
> -       err =3D populate_skeleton_maps(obj, s->maps, s->map_cnt);
> +       err =3D populate_skeleton_maps(obj, s->maps, s->map_cnt, s->map_s=
kel_sz);
>         if (err) {
>                 pr_warn("failed to populate skeleton maps for '%s': %d\n"=
, s->name, err);
>                 return libbpf_err(err);
>         }
>
> -       err =3D populate_skeleton_progs(obj, s->progs, s->prog_cnt);
> +       err =3D populate_skeleton_progs(obj, s->progs, s->prog_cnt, s->pr=
og_skel_sz);
>         if (err) {
>                 pr_warn("failed to populate skeleton progs for '%s': %d\n=
", s->name, err);
>                 return libbpf_err(err);
> @@ -13819,13 +13823,13 @@ int bpf_object__open_subskeleton(struct bpf_obj=
ect_subskeleton *s)
>                 return libbpf_err(-errno);
>         }
>
> -       err =3D populate_skeleton_maps(s->obj, s->maps, s->map_cnt);
> +       err =3D populate_skeleton_maps(s->obj, s->maps, s->map_cnt, s->ma=
p_skel_sz);
>         if (err) {
>                 pr_warn("failed to populate subskeleton maps: %d\n", err)=
;
>                 return libbpf_err(err);
>         }
>
> -       err =3D populate_skeleton_progs(s->obj, s->progs, s->prog_cnt);
> +       err =3D populate_skeleton_progs(s->obj, s->progs, s->prog_cnt, s-=
>prog_skel_sz);
>         if (err) {
>                 pr_warn("failed to populate subskeleton maps: %d\n", err)=
;
>                 return libbpf_err(err);
> @@ -13879,10 +13883,12 @@ int bpf_object__load_skeleton(struct bpf_object=
_skeleton *s)
>         }
>
>         for (i =3D 0; i < s->map_cnt; i++) {
> -               struct bpf_map *map =3D *s->maps[i].map;
> +               struct bpf_map_skeleton *map_skel =3D (struct bpf_map_ske=
leton *)
> +                       ((char *)s->maps + s->map_skel_sz * i);

same as above

> +               struct bpf_map *map =3D *map_skel->map;
>                 size_t mmap_sz =3D bpf_map_mmap_sz(map);
>                 int prot, map_fd =3D map->fd;
> -               void **mmaped =3D s->maps[i].mmaped;
> +               void **mmaped =3D map_skel->mmaped;
>
>                 if (!mmaped)
>                         continue;
> @@ -13930,8 +13936,10 @@ int bpf_object__attach_skeleton(struct bpf_objec=
t_skeleton *s)
>         int i, err;
>
>         for (i =3D 0; i < s->prog_cnt; i++) {
> -               struct bpf_program *prog =3D *s->progs[i].prog;
> -               struct bpf_link **link =3D s->progs[i].link;
> +               struct bpf_prog_skeleton *prog_skel =3D (struct bpf_prog_=
skeleton *)
> +                       ((char *)s->progs + s->prog_skel_sz * i);
> +               struct bpf_program *prog =3D *prog_skel->prog;
> +               struct bpf_link **link =3D prog_skel->link;
>

ditto

>                 if (!prog->autoload || !prog->autoattach)
>                         continue;

[...]

