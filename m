Return-Path: <bpf+bounces-21912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813FB853FE4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFDD1F296D5
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBD63115;
	Tue, 13 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyjcV3Nc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681F63099
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866165; cv=none; b=hwA60jt8eMRjKrcaUAau4yvpNyD+JUfbNg3YTG5yNzoS0/npzmvdiibbmiJ4uwWpEzCffg5QlRG7H50yl7AU+OtcfR8lWEelaJI42PbRXmJ1H/KZdaauZbAowDFjKFlTMBOeEVm8iBAkvPGwnGR+nAdGv1RiWH4sj97URwUpEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866165; c=relaxed/simple;
	bh=8svr6rYBcNBEc5DWyDpzaYUIOphEBFxj7OW95DSe7Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evvKwMvHD1owbNNHDnzZoEVXnJYcGlIzqswiqiMKCmLFJNbWuYRIYsv6RBHAKSNUPodWH1v48BZFGu+x0wYwI1AY9zviXF8TSIJah1SBNHmpaCV1i8Km9rmaAfHM4skMovVaS9xjZXOcdVKIHy9xfRz72GTeVJ+19DQ6KcljT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyjcV3Nc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296e22f85abso3036131a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866163; x=1708470963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8bdMenaLJTIatKTmEETJ8kQRfZNPeSS9xW0bhOuIBk=;
        b=AyjcV3NcyrdomdDz3knTgbND2R0ktd5RcqsyzUN6+hMUOBeRMALp6Q50ExpSP69Cg9
         MWV8bEOybWcXeFcma+nzu8xrpSMP/ZY6jaJG99P1OF4Xf58eMisHEpFcjamHO5Zc7HoD
         8JtfHbuSghv3lB4/ONdfoMWoVxVjfj1ADzL5zkAxSURZwt+YWC+SZAZB53v29D+/TVDS
         QTJY2+19ri1ZU43pJSMVo4c91pWGKFCbOb/GXHP1QazKm8/97YHTG/IBl81rSH63heEu
         5ZlJgIHRdxHTVHAusulAFdOCuBSD/OdnGLMyEaqbRQaeAFkFSUDcNzLXMMtj/2MzuP/2
         u6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866163; x=1708470963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8bdMenaLJTIatKTmEETJ8kQRfZNPeSS9xW0bhOuIBk=;
        b=AVaJqwt3DPeHBzjkCSRmRho3scOzm5sgrVY43yr6NVs34/EktgVEOJUbIcfgS/IRmE
         /3teizvlzBFTLe+J6Sqco5NMkxD2I217PNc7aNaBWmpyGd3/I7+RNzCya2ZQDM+0iedL
         bqUR5u8dTUS/fByzPrh0RqT5kkn7Lh9Fe1FitNY0K3MbBjkJF1Fla/9qqVK0nP1xK7X5
         Llh+AC/8jSujCW9/sb3WZlSDhEYFFaUWr8PWOnOCjprnWRZcs5G1uh3ZmW7YkAQV1SQr
         GLMu/ASVqaNEykxqFlYOpR+Y8Pq4yieOjTVXLv7xLVEOV4emTSw+XFyyRive6EX01fiM
         GKEQ==
X-Gm-Message-State: AOJu0YyCygE661eydT0nDJz/wc21jgWk/ahr9levasYl4klfmpTBurXQ
	4Hc2+F0S7MoW4I/s4atgo1gKYUGTKT25/lfjjqkp+ZeH1BvTfO8qP5m68Dv+kbmfLw6W+Z7LnFY
	sFxfK01TCuV2j5FEHvGW2zVzgd0Mwtdsi
X-Google-Smtp-Source: AGHT+IEXYUiNeFFzRPbr4yj3nY290hUu3Wi26SeGJQowsI5gRz0aZwKSyg90d50LHpSjNnJbppPSCKNYoK2PHXKCSYI=
X-Received: by 2002:a17:90a:cc01:b0:298:d6b5:7fb0 with SMTP id
 b1-20020a17090acc0100b00298d6b57fb0mr4815pju.16.1707866162997; Tue, 13 Feb
 2024 15:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-15-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-15-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 15:15:51 -0800
Message-ID: <CAEf4BzZcLGk71VXRvDS=By2-xfqnPMyKhBiYoH=g69HcXYyr4A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> LLVM automatically places __arena variables into ".arena.1" ELF section.
> When libbpf sees such section it creates internal 'struct bpf_map' LIBBPF=
_MAP_ARENA
> that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> They share the same kernel's side bpf map and single map_fd.
> Both are emitted into skeleton. Real arena with the name given by bpf pro=
gram
> in SEC(".maps") and another with "__arena_internal" name.
> All global variables from ".arena.1" section are accessible from user spa=
ce
> via skel->arena->name_of_var.

This "real arena" vs "__arena_internal" seems like an unnecessary
complication. When processing .arena.1 ELF section, we search for
explicit BPF_MAP_TYPE_ARENA map, right? Great, at that point, we can
use that map and it's map->mmapable pointer (we mmap() anonymous
memory to hold initial values of global variables). We copy init
values into map->mmapable on actual arena struct bpf_map. Then during
map creation (during load) we do a new mmap(map_fd), taking into
account map_extra. Then memcpy() from the original anonymous mmap into
this arena-linked mmap. Then discard the original mmap.

This way we don't have fake maps anymore, we initialize actual map (we
might need to just remember smaller init mmap_sz, which doesn't seem
like a big complication). WDYT?

BTW, I think bpf_object__load_skeleton() can re-assign skeleton's
arena data pointer, so user accessing skel->arena->var before and
after skeleton load will be getting correct pointer.

>
> For bss/data/rodata the skeleton/libbpf perform the following sequence:
> 1. addr =3D mmap(MAP_ANONYMOUS)
> 2. user space optionally modifies global vars
> 3. map_fd =3D bpf_create_map()
> 4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
> 5. mmap(addr, MAP_FIXED, map_fd)
> after step 5 user spaces see the values it wrote at step 2 at the same ad=
dresses
>
> arena doesn't support update_map_elem. Hence skeleton/libbpf do:
> 1. addr =3D mmap(MAP_ANONYMOUS)
> 2. user space optionally modifies global vars
> 3. map_fd =3D bpf_create_map(MAP_TYPE_ARENA)
> 4. real_addr =3D mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
> 5. memcpy(real_addr, addr) // this will fault-in and allocate pages
> 6. munmap(addr)
>
> At the end look and feel of global data vs __arena global data is the sam=
e from bpf prog pov.
>
> Another complication is:
> struct {
>   __uint(type, BPF_MAP_TYPE_ARENA);
> } arena SEC(".maps");
>
> int __arena foo;
> int bar;
>
>   ptr1 =3D &foo;   // relocation against ".arena.1" section
>   ptr2 =3D &arena; // relocation against ".maps" section
>   ptr3 =3D &bar;   // relocation against ".bss" section
>
> Fo the kernel ptr1 and ptr2 has point to the same arena's map_fd
> while ptr3 points to a different global array's map_fd.
> For the verifier:
> ptr1->type =3D=3D unknown_scalar
> ptr2->type =3D=3D const_ptr_to_map
> ptr3->type =3D=3D ptr_to_map_value
>
> after the verifier and for JIT all 3 ptr-s are normal ld_imm64 insns.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c |  13 ++++-
>  tools/lib/bpf/libbpf.c  | 102 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 101 insertions(+), 14 deletions(-)
>

[...]

> @@ -1718,10 +1722,34 @@ static int
>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
>                               const char *real_name, int sec_idx, void *d=
ata, size_t data_sz)
>  {
> +       const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> +       struct bpf_map *map, *arena =3D NULL;
>         struct bpf_map_def *def;
> -       struct bpf_map *map;
>         size_t mmap_sz;
> -       int err;
> +       int err, i;
> +
> +       if (type =3D=3D LIBBPF_MAP_ARENA) {
> +               for (i =3D 0; i < obj->nr_maps; i++) {
> +                       map =3D &obj->maps[i];
> +                       if (map->def.type !=3D BPF_MAP_TYPE_ARENA)
> +                               continue;
> +                       arena =3D map;
> +                       real_name =3D "__arena_internal";
> +                       mmap_sz =3D bpf_map_mmap_sz(map);
> +                       if (roundup(data_sz, page_sz) > mmap_sz) {
> +                               pr_warn("Declared arena map size %zd is t=
oo small to hold"
> +                                       "global __arena variables of size=
 %zd\n",
> +                                       mmap_sz, data_sz);
> +                               return -E2BIG;
> +                       }
> +                       break;
> +               }
> +               if (!arena) {
> +                       pr_warn("To use global __arena variables the aren=
a map should"
> +                               "be declared explicitly in SEC(\".maps\")=
\n");
> +                       return -ENOENT;
> +               }

so basically here we found arena, let's arena->mmapable =3D
mmap(MAP_ANONYMOUS) here, memcpy(arena->mmapable, data, data_sz) and
exit early, not doing bpf_object__add_map()?


> +       }
>
>         map =3D bpf_object__add_map(obj);
>         if (IS_ERR(map))
> @@ -1732,6 +1760,7 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         map->sec_offset =3D 0;
>         map->real_name =3D strdup(real_name);
>         map->name =3D internal_map_name(obj, real_name);
> +       map->arena =3D arena;
>         if (!map->real_name || !map->name) {
>                 zfree(&map->real_name);
>                 zfree(&map->name);

[...]

> @@ -13437,6 +13508,11 @@ int bpf_object__load_skeleton(struct bpf_object_=
skeleton *s)
>                         continue;
>                 }
>
> +               if (map->arena) {
> +                       *mmaped =3D map->arena->mmaped;
> +                       continue;
> +               }
> +

yep, I was going to suggest that we can fix up this pointer in
load_skeleton, nice


>                 if (map->def.map_flags & BPF_F_RDONLY_PROG)
>                         prot =3D PROT_READ;
>                 else
> --
> 2.34.1
>

