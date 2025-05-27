Return-Path: <bpf+bounces-59030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C2AC5D28
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041781BC26C6
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484120D516;
	Tue, 27 May 2025 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfOoiTfc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2720296E
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385100; cv=none; b=r82JBnBo5KpXRmUppPK+qSt4MNnfa8HjnyTqiNhDWLwR58wLnwbh7gBhe6Cw39bIYCG6e9J2D8FUI0ITb7vBX0U7Doh0pzdL/FyAheuZ2zkjyjHaSo27b8FREiFgKgFUaOyfN6+uwpWND3BBAJ6NnkKle6pkIzBduRU2LJu6VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385100; c=relaxed/simple;
	bh=SehaxcAwWVjeV0LJ+EPTD4eHOj9xJ5pBq2w4Eka3g9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArX+J2BFUzUchonedZDPJQD8A6yQIU1srPuI1Hew+ZHjiY/t9Sac1Gms4ww8gB5VoAUGCyUfN2o6uBoc409LjxFd3MhVv6icV3OQlM9rFkT/V4OqVIz4eOJL9dEOL3E/pz1zGembGiWwF1frwIHrM8pRrniJzJlMSRGFurDasU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfOoiTfc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-310f3c7bd87so2802342a91.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385098; x=1748989898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ3R4EBQ/ctmcciCRgykb7QdD3IDe8oRXxFkfuoO+AE=;
        b=GfOoiTfczZwS8QYLe91Ui3bWUZgrqG2MrVC0xd850qtJXwNXgP8czWykFgrEjg01Vr
         Rn5EOrxJ7ALVobFPdOqvYFl7Oy5n8Wc9xZKHjj/7muJVCqWClbFHidtQP8O2wB2ZRWme
         giZ1FNoQce08Ge59oOfxXYgG4fDfbcBSTzOAZZKL4xL3C15E1Wrft8u1pQXTMPauhPSF
         6ZW5clqhj/kje8LXPKYY8rd3mLibpVKCJgsVy2WurSHz0sNLDvE8kPPGyqsw/ULuO2hg
         YHvkppAaPftGavS1xBsBm4GEx+ZOssrXNbSxcD28hW0pAraHgG19gOxwXVV0vy7qo3c5
         n0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385098; x=1748989898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ3R4EBQ/ctmcciCRgykb7QdD3IDe8oRXxFkfuoO+AE=;
        b=nngUshVvIOtEYMoGuZPNIghGF38fU+hY3n2dXPAXIcj6KgEBl11hKUTozRROyjXeag
         glDEN67JU/kltqavzgHkY/VWxCbYOtHptmMKwKarLQWvAYrPAW/M9ekE+MwkQ1OrT8YS
         2qZVho9cQtVjF6U4n2Xssg+t23bb+1sxZkavO+eTS1JS/fYrQ7xr4/1jHONghyGUdRXP
         gWRaI0m0Llb7kZgrF3MPK61WvaVr5V0TWh2MIK+CL59sEgHLKQK94XAJ54wtVQErUmLI
         9NKjX25JA5mBwRLDhmM7pldakVdFdcaVYB0xxAiE5VaFiJJ844nqpOQ7tEWrRANVl0Kp
         a3xA==
X-Gm-Message-State: AOJu0YwXN3f4dfmkDVlS9gpUnFLlfemLZtXFTWqUngnv7KKrJYHkhciy
	RtSjVgll7Q1vvrbBunuR/j/DX9aqTvTzep+c6HAy1eRq2+KOv2slGv8UQFqIT/H4tndB6LSpXe4
	uZ2QDsie6+iZ8EsHXVMlzNqShxZdxXbw=
X-Gm-Gg: ASbGncs/PhpYE/IrGIeF/igyIz2pLzJXkF4e4o8KAkQ/BLWiXb+FI02V9UMeN7pK3cr
	b9jPcrPTYi71qVJeN3PPGzMfXBJ2n4zSvChDiVff2M6hBwG7jQxgSfVhU33O+KL1XSMV0GZCW1A
	MU/ZRBJlAhzMNqnmlv6UsGY9IKJmUFbzUBqji0oXBzlOoKaIm+
X-Google-Smtp-Source: AGHT+IESCHPgWhz33CaMTyZqjZaRcqIOr6Ap8Tlvkwv/J59zeMXN+XmA9nW9JhFem136lhx9Xg7eLok9zaGBLXixYMU=
X-Received: by 2002:a17:90b:2d46:b0:311:d5f1:927a with SMTP id
 98e67ed59e1d1-311d5f19283mr2051199a91.4.1748385097603; Tue, 27 May 2025
 15:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-4-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 15:31:21 -0700
X-Gm-Features: AX0GCFsircvMR3QIsqTdE7A2NjgO1czboHl8X8XkQdCvhuICzb-gQx9i4dhxl-g
Message-ID: <CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf, bpftool: Generate skeleton for
 global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding libbpf-rs maintainer, Daniel, for awareness, as Rust skeleton
will have to add support for this, once this patch set lands upstream.


On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch enhances bpftool to generate skeletons that properly handle
> global percpu variables. The generated skeleton now includes a dedicated
> structure for percpu data, allowing users to initialize and access percpu
> variables more efficiently.
>
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
>
> struct test_global_percpu_data {
>         struct bpf_object_skeleton *skeleton;
>         struct bpf_object *obj;
>         struct {
>                 struct bpf_map *data__percpu;
>         } maps;
>         // ...
>         struct test_global_percpu_data__data__percpu {
>                 int data;
>                 char run;
>                 struct {
>                         char set;
>                         int i;
>                         int nums[7];
>                 } struct_data;
>                 int nums[7];
>         } __aligned(8) *data__percpu;
>
>         // ...
> };
>
>   * The "struct test_global_percpu_data__data__percpu *data__percpu" poin=
ts
>     to initialized data, which is actually "maps.data__percpu->mmaped".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__data__percpu *data__percpu" modifies
>     the initial value of the corresponding global percpu variables.
>   * After loading the skeleton, accessing or updating this struct is not
>     allowed because this struct pointer has been reset as NULL. Instead,
>     users must interact with the global percpu variables via the
>     "maps.data__percpu" map.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c | 47 +++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 67a60114368f5..c672f52110221 100644
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
> +       static const char *sfxs[] =3D { ".data..percpu", ".data", ".rodat=
a", ".bss", ".kconfig" };
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
> +       static const char *pfxs[] =3D { ".data..percpu", ".data", ".rodat=
a", ".bss", ".kconfig" };
>         int i, n;
>
>         /* recognize hard coded LLVM section name */
> @@ -148,7 +148,8 @@ static int codegen_datasec_def(struct bpf_object *obj=
,
>                                struct btf *btf,
>                                struct btf_dump *d,
>                                const struct btf_type *sec,
> -                              const char *obj_name)
> +                              const char *obj_name,
> +                              bool is_percpu)
>  {
>         const char *sec_name =3D btf__name_by_offset(btf, sec->name_off);
>         const struct btf_var_secinfo *sec_var =3D btf_var_secinfos(sec);
> @@ -228,7 +229,7 @@ static int codegen_datasec_def(struct bpf_object *obj=
,
>
>                 off =3D sec_var->offset + sec_var->size;
>         }
> -       printf("        } *%s;\n", sec_ident);
> +       printf("        }%s *%s;\n", is_percpu ? " __aligned(8)" : "", se=
c_ident);
>         return 0;
>  }
>
> @@ -263,13 +264,13 @@ static bool is_mmapable_map(const struct bpf_map *m=
ap, char *buf, size_t sz)
>                 return true;
>         }
>
> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF=
_F_MMAPABLE))
> -               return false;
> -
> -       if (!get_map_ident(map, buf, sz))
> -               return false;
> +       if (bpf_map__is_internal(map) &&
> +           ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
> +            bpf_map__is_internal_percpu(map)) &&
> +           get_map_ident(map, buf, sz))
> +               return true;
>
> -       return true;
> +       return false;
>  }
>
>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name=
)
> @@ -303,7 +304,8 @@ static int codegen_datasecs(struct bpf_object *obj, c=
onst char *obj_name)
>                         printf("        struct %s__%s {\n", obj_name, map=
_ident);
>                         printf("        } *%s;\n", map_ident);
>                 } else {
> -                       err =3D codegen_datasec_def(obj, btf, d, sec, obj=
_name);
> +                       err =3D codegen_datasec_def(obj, btf, d, sec, obj=
_name,
> +                                                 bpf_map__is_internal_pe=
rcpu(map));
>                         if (err)
>                                 goto out;
>                 }
> @@ -795,7 +797,8 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
>         bpf_object__for_each_map(map, obj) {
>                 const char *mmap_flags;
>
> -               if (!is_mmapable_map(map, ident, sizeof(ident)))
> +               if (!is_mmapable_map(map, ident, sizeof(ident)) ||
> +                   bpf_map__is_internal_percpu(map))
>                         continue;
>
>                 if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
> @@ -1434,7 +1437,25 @@ static int do_skeleton(int argc, char **argv)
>                 static inline int                                        =
   \n\
>                 %1$s__load(struct %1$s *obj)                             =
   \n\
>                 {                                                        =
   \n\
> -                       return bpf_object__load_skeleton(obj->skeleton); =
   \n\
> +                       int err;                                         =
   \n\
> +                                                                        =
   \n\
> +                       err =3D bpf_object__load_skeleton(obj->skeleton);=
     \n\
> +                       if (err)                                         =
   \n\
> +                               return err;                              =
   \n\
> +                                                                        =
   \n\
> +               ", obj_name);
> +
> +       if (map_cnt) {
> +               bpf_object__for_each_map(map, obj) {
> +                       if (bpf_map__is_internal_percpu(map) &&
> +                           get_map_ident(map, ident, sizeof(ident)))
> +                               printf("\tobj->%s =3D NULL;\n", ident);
> +               }
> +       }

hm... maybe we can avoid this by making libbpf re-mmap() this
initialization image to be read-only during bpf_object load? Then the
pointer can stay in the skeleton and be available for querying of
"initialization values" (if anyone cares), and we won't have any extra
post-processing steps in code generated skeleton code?

And Rust skeleton will be able to expose this as a non-mutable
reference with no extra magic behind it?


> +
> +       codegen("\
> +               \n\
> +                       return 0;                                        =
   \n\
>                 }                                                        =
   \n\
>                                                                          =
   \n\
>                 static inline struct %1$s *                              =
   \n\
> --
> 2.49.0
>

