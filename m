Return-Path: <bpf+bounces-50572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CAA29DC6
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1724C7A2DD0
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1451373;
	Thu,  6 Feb 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJBixNnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CB2904
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800576; cv=none; b=VRAmNnTtVCi3qxfO+q/qEabOcYS9C2K0qO3CXLb/LbWpcW4ChQFYLdm1yNhb/AVN6xvMq/kDcjhnCIIAcUOwKPLxWtGRK/RUr17pZ0E9YE9nbSHXXXKH3a9fzOOdhR+omIXQpJlQxX+UQWMP7yk5jYTJ6kjEbmllkmbLvWzXM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800576; c=relaxed/simple;
	bh=GOLObDGCvTdbIcZ1ZzRe++nOdSh/J3VXPbdlRizRbKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhSW5LokVJZe45OdIB4gLP3Pk/CafMqVmsowCK5MDMRNzkR32izWXbnBPI+l2Rqq6A0UfVkN02MbmWU0MwKjp71RRd00/xU4K5HoLCW32u7WGyusj4p5gkxyIhNfFN8aAfQ19S/q1kc6iHg6FSzDe8kzCD00vZXKUkEgwjqJ9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJBixNnF; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f833af7a09so384170a91.2
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 16:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738800574; x=1739405374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81XePSO9e6bYugWQFigZemit32BhqZsDoGVe/ygeTvM=;
        b=CJBixNnF56FeVYzFDky6NXvhPBMIEsjW4Og7hPhmXo0ijsnQL3B1ZRAC7Tm553ky9q
         HOzsUObCS2/mLScMHfKzvGXErMX/RrSPbEMsUDhiprt131/xUemzJBiMSTXodwBiKHNq
         YrtJL+IQ6y9A0/wdIkm1q/t48EFqDvLQDgKGIXFjelb3JlDhvwtbNDbgFhbdvjd8MMZL
         C+uO9FX7KulTPsyhBjYZwyBKkakBpvXfvk04HtSLwOyoTkhEFbQB1MoW5tuR1u4lph/i
         2oUxAZzGfkklxa5qEnxgi5zPg60ayazlq28fcnH8G2HKwbmodmYIXl2r69TdSCzqvZnj
         gnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800574; x=1739405374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81XePSO9e6bYugWQFigZemit32BhqZsDoGVe/ygeTvM=;
        b=NRMKo+JwE8M7Ypir25xAhWzHTjOOG8PXmXpdZNSxGow7BsO5sk0PXZPTF6jRBgeZjP
         RsAUMDHpCDT0ivtnbl5Qm8PEMaiNv6+WEAS2kdGHs+mBo3xcVWMXDRtD1aDQZIDQyI0U
         3eHYqbbczZDh0e3nmBn/fm3Y54WEdqpVFXhdscp945X6L3eetgSp6YXRW2hRpTovOqB+
         33GCyNshfxnk43NvMjkMNahkm7UsemdWVzn4PFoxxicZ0SFSm1OkXZ7+VZawOh3SNRIC
         V193lIpYbDGWmk1s0JfqUvHldcpdHeSFwHHDHM3bM3yD/eW7j1Az1RgCY/Kz0B+Mqx4E
         xHvw==
X-Gm-Message-State: AOJu0YwChsWA/KFayAs0K2coRQxcDg0MCoFaQQeIyvtf525UdEmUBavL
	BhDEX450ymGpU8v6mkMRdAjJTcTZpjtyH/XqOIVNffsfqt/O4speu26CzwXPosmqx2FltDlIGIV
	FQIDw7nNBbxy9xb0yl8n7x54Qx30=
X-Gm-Gg: ASbGnctSvzI/4FNvosl96ptff5WeW2DCPiYmjh0SAjFTxiCqSuwDx/pP3Fp12DHSbsX
	P9VaHkJ4uzArKmIjKAVJY1PzYaX7YgqjQccCUgxZzIbzKrm6rz6CXY1IzS8UE/6i31ddrZAC4IV
	WawQNNmMHnPphW
X-Google-Smtp-Source: AGHT+IH8u5lEOYbmZSgtO05MEpS3QNVtQnOvMHCN+BnSM/YN6xQFqhIKLDHAww0Fq74lwr6hz6qTghkf1o2M5x/iu94=
X-Received: by 2002:a17:90a:d410:b0:2ee:cd83:8fe7 with SMTP id
 98e67ed59e1d1-2f9e08682a8mr7567237a91.35.1738800573721; Wed, 05 Feb 2025
 16:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-4-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:09:17 -0800
X-Gm-Features: AWEUYZmWYJwfHA1H0R_xzzy1RGC0yW75lXcD4H30msQ3xLENzdJqHGRcBgjhPwU
Message-ID: <CAEf4BzYBo8bGoOEQ6horb=E69txnWN5Ch1+Pzfft0JKpGAaQAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf, bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch enhances bpftool to generate skeletons for global percpu
> variables. The generated skeleton includes a dedicated structure for
> percpu data, allowing users to initialize and access percpu variables
> efficiently.
>
> Changes:
>
> 1. skeleton structure:
>
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
>
> struct test_global_percpu_data {
>         struct bpf_object_skeleton *skeleton;
>         struct bpf_object *obj;
>         struct {
>                 struct bpf_map *bss;
>                 struct bpf_map *percpu;
>         } maps;
>         // ...
>         struct test_global_percpu_data__percpu {
>                 int percpu_data;
>         } *percpu;
>
>         // ...
> };
>
>   * The "struct test_global_percpu_data__percpu" points to initialized
>     data, which is actually "maps.percpu->data".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__percpu" modifies the initial value
>     of the corresponding global percpu variables.
>   * After loading the skeleton, accessing or updating this struct is no
>     longer meaningful. Instead, users must interact with the global
>     percpu variables via the "maps.percpu" map.

can we set this pointer to NULL after load to avoid accidental
(successful) reads/writes to it?

>
> 2. code changes:
>
>   * Added support for ".percpu" sections in bpftool's map identification
>     logic.
>   * Modified skeleton generation to handle percpu data maps
>     appropriately.
>   * Updated libbpf to make "percpu" pointing to "maps.percpu->data".
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c | 13 +++++++++----
>  tools/lib/bpf/libbpf.c  |  3 +++
>  tools/lib/bpf/libbpf.h  |  1 +
>  3 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689ed..975775683ca12 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *o=
bj_name, const char *suff
>
>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t b=
uf_sz)
>  {
> -       static const char *sfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> +       static const char *sfxs[] =3D { ".data", ".rodata", ".percpu", ".=
bss", ".kconfig" };
>         const char *name =3D bpf_map__name(map);
>         int i, n;
>
> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, =
char *buf, size_t buf_sz)
>
>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t bu=
f_sz)
>  {
> -       static const char *pfxs[] =3D { ".data", ".rodata", ".bss", ".kco=
nfig" };
> +       static const char *pfxs[] =3D { ".data", ".rodata", ".percpu", ".=
bss", ".kconfig" };
>         int i, n;
>
>         /* recognize hard coded LLVM section name */
> @@ -263,7 +263,9 @@ static bool is_mmapable_map(const struct bpf_map *map=
, char *buf, size_t sz)
>                 return true;
>         }
>
> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> +       if (!bpf_map__is_internal(map) ||
> +           (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE) &&
> +            bpf_map__type(map) !=3D BPF_MAP_TYPE_PERCPU_ARRAY))

there will be no BPF_F_MMAPABLE set for PERCPU_ARRAY, why adding these
unnecessary extra conditionals?

>                 return false;
>
>         if (!get_map_ident(map, buf, sz))
> @@ -903,7 +905,10 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t=
 map_cnt, bool mmaped, bool
>                         i, bpf_map__name(map), ident);
>                 /* memory-mapped internal maps */
>                 if (mmaped && is_mmapable_map(map, ident, sizeof(ident)))=
 {
> -                       printf("\tmap->mmaped =3D (void **)&obj->%s;\n", =
ident);
> +                       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU=
_ARRAY)
> +                               printf("\tmap->data =3D (void **)&obj->%s=
;\n", ident);
> +                       else
> +                               printf("\tmap->mmaped =3D (void **)&obj->=
%s;\n", ident);
>                 }
>
>                 if (populate_links && bpf_map__type(map) =3D=3D BPF_MAP_T=
YPE_STRUCT_OPS) {
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6da6004c5c84d..dafb419bc5b86 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13915,6 +13915,7 @@ static int populate_skeleton_maps(const struct bp=
f_object *obj,
>                 struct bpf_map **map =3D map_skel->map;
>                 const char *name =3D map_skel->name;
>                 void **mmaped =3D map_skel->mmaped;
> +               void **data =3D map_skel->data;
>
>                 *map =3D bpf_object__find_map_by_name(obj, name);
>                 if (!*map) {
> @@ -13925,6 +13926,8 @@ static int populate_skeleton_maps(const struct bp=
f_object *obj,
>                 /* externs shouldn't be pre-setup from user code */
>                 if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG=
)
>                         *mmaped =3D (*map)->mmaped;
> +               if (data && (*map)->libbpf_type =3D=3D LIBBPF_MAP_PERCPU_=
DATA)
> +                       *data =3D (*map)->data;
>         }
>         return 0;
>  }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 3020ee45303a0..c49d6e44b5630 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1701,6 +1701,7 @@ struct bpf_map_skeleton {
>         const char *name;
>         struct bpf_map **map;
>         void **mmaped;
> +       void **data;

this is breaking backwards/forward compatibility. let's try to reuse mmaped

>         struct bpf_link **link;
>  };
>
> --
> 2.47.1
>

