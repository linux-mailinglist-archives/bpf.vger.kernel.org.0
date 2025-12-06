Return-Path: <bpf+bounces-76195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D0CA9ADF
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 01:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15483105020
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8488462;
	Sat,  6 Dec 2025 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZANy3ye+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46B4C81
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764979899; cv=none; b=OQSDWgbYVOorVC+1B9xozYj0BLxbL8bczYr0IiviBIk/pFFu11UcWvFdQLdXIKEl4WO7XXsgHT8K9U5y7cgNZVH6MdagdtWOb6YzOzDOEGKA3LplMhbJ1HULUkcH4eNZ+qgmQppwWatl43Z24GYc05sGIdb3CIMiHEapPmS1tW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764979899; c=relaxed/simple;
	bh=5AhlX7C56vXKqCo/63Ya6FA/4n1jK8CXri1MweHqlQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENljnSqs56+JDpeXNB1Tomya4+tw2UZ3UUKi+J1qKYZlz6SiLGn7rmUcDdsy9wntiJu4Be8B2/iOTBZEe1tqA/82bRvmxuwWFj/TbqJ3zzUbhz/kyluGuSDrUrxjvn6JS7DXxr1lHuIxVQ0wBxXlXWToQFgc70m4auqzVexgLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZANy3ye+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34374febdefso2818083a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764979897; x=1765584697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVIgNg3yvRMLnyZGVHjgJ+fOuL5UdYSbueuVdo1cAKU=;
        b=ZANy3ye+P8Z97N6CGg0vjPTfBhG2AZ3OXBwgLi3D07f0xHeMkEGj0MQxyML+IIQS+n
         S9KlRPrCx4U+XURBwCmVuMvZS2WgRyNIQvyezrRkrlJPbGKP7TNUxKUHYQD2MvLSL4B1
         RgjQBh+5t/ICrq0AVlLBDpKp34NebkUkyETvozGE+tOXFCKieP9JBlBgdjzxgQN9VQhf
         RwbrAAXkOpWGZtJMYX5BL47qlY2AlOllAPDpX/EqPYbe5IKP6MCruZeYDfIB47eOej6y
         TNYcMQcokIOszXsjlOODZwycuB66XVTeNDoqNmQ+CGJM3MnpaIJ1HCQir6v1mk3RWrgH
         FXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764979897; x=1765584697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVIgNg3yvRMLnyZGVHjgJ+fOuL5UdYSbueuVdo1cAKU=;
        b=lF3TJcpfNZ/flieD0UB2uJ5m+0OZqFI7P9YR0+2dbV0wz8CICrjX7AgKif47NXaeWA
         rT8L6ZKnh/Q8IOgWSvTfMud61YAJ4I9K4lNH2UcxxUUyjPKVn72k/FmPbSC1CXKcZTgZ
         XPpqeL9iR+LPlZ9dr5yvSE+9T9SrZ7JwmEJR+2rJ0SbTJUAUt6S6scwbxp0L/rA+TkOA
         m5wYq7Gjp/WzToVPN6Dx7xkX5v+BcblNOciRnBrUG+9gOsJmt7s18bU7gd5lN3nCDddQ
         I11kGQJitGlbtnUVCGn/50RUi/o+qDeu/Ko5DydCRygn6TC5lslQ9CrfkLTOggHOJBVR
         TiiQ==
X-Gm-Message-State: AOJu0YzAeQX3DU3tTTSF/TjgSdqWrT8usdJ0RdWsuvsdij3IwIZnNklo
	BcuN9D70esO8ldJkDHSZnpyvkjmCSpm1tIT9rwefvblCsG/HAAMoalewnYpkhEFztsSKTTfYcUT
	ec3nNGiUB9drdpCsDKm5wNFQvrwF4lzg=
X-Gm-Gg: ASbGnctX/WiTv5JxH9jMb0+NvsouBBUQCFbFHLu5MuIk+sHfF8zhK/md6J5wtUOd1Y/
	Lvq9X2h0akSU3DJQzFaOD5jDi16nznUFo+wOK0wla5QWXE4vFfaP736Fv5rHEykv/Jpo3Auz/S+
	1Z7gXUWRpbc9l3dK0QtyjrwDkMcHaGzO6cr0KoqkwchCiIYFB0/pSPcABqRkyXNAlwXVtTiec9y
	S7sozTXfCqNqFO18DKQ3Jx/c8bLyx4XVtdMMNQmFtSmMhoRyjCwE7o+q9kE19DSEHAUGe028gBz
	W+5axBzIwKM=
X-Google-Smtp-Source: AGHT+IEEzpp5QjELyj50JgNX035m1/4E77acKlPsjqofgxb5x9U58qz0ZX/mSrvBIqL+76XxgCMrpOf7vs4CMtK2clk=
X-Received: by 2002:a17:90b:1e53:b0:341:8ac7:39b7 with SMTP id
 98e67ed59e1d1-349a25bd90dmr624398a91.25.1764979896666; Fri, 05 Dec 2025
 16:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203162625.13152-1-emil@etsalapatis.com> <20251203162625.13152-4-emil@etsalapatis.com>
In-Reply-To: <20251203162625.13152-4-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:11:22 -0800
X-Gm-Features: AWmQ_bmdmAmi-AUhViz8w9BYlqjcDhYuxwAuq4lVQ307Ob6V8wTqp0SBifdYvrw
Message-ID: <CAEf4Bza2BJYyMcDG7aRV0KStfJ49A+X91Lbi9SaaGs1FO88=Dg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] libbpf: move arena globals to the end of the arena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 8:26=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Arena globals are currently placed at the beginning of the arena
> by libbpf. This is convenient, but prevents users from reserving
> guard pages in the beginning of the arena to identify NULL pointer
> dereferences. Adjust the load logic to place the globals at the
> end of the arena instead.
>
> Also modify bpftool to set the arena pointer in the program's BPF
> skeleton to point to the globals. Users now call bpf_map__initial_value()
> to find the beginning of the arena mapping and use the arena pointer
> in the skeleton to determine which part of the mapping holds the
> arena globals and which part is free.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/lib/bpf/libbpf.c                        | 19 +++++++++++++++----
>  .../bpf/progs/verifier_arena_large.c          | 12 +++++++++---
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 706e7481bdf6..9642d697b690 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -757,6 +757,7 @@ struct bpf_object {
>         int arena_map_idx;
>         void *arena_data;
>         size_t arena_data_sz;
> +       __u32 arena_data_off;

nit: use size_t, please

>
>         void *jumptables_data;
>         size_t jumptables_data_sz;
> @@ -2991,10 +2992,11 @@ static int init_arena_map_data(struct bpf_object =
*obj, struct bpf_map *map,
>                                void *data, size_t data_sz)
>  {
>         const long page_sz =3D sysconf(_SC_PAGE_SIZE);
> +       const size_t data_alloc_sz =3D roundup(data_sz, page_sz);
>         size_t mmap_sz;
>
>         mmap_sz =3D bpf_map_mmap_sz(map);
> -       if (roundup(data_sz, page_sz) > mmap_sz) {
> +       if (data_alloc_sz > mmap_sz) {
>                 pr_warn("elf: sec '%s': declared ARENA map size (%zu) is =
too small to hold global __arena variables of size %zu\n",
>                         sec_name, mmap_sz, data_sz);
>                 return -E2BIG;
> @@ -3006,6 +3008,9 @@ static int init_arena_map_data(struct bpf_object *o=
bj, struct bpf_map *map,
>         memcpy(obj->arena_data, data, data_sz);
>         obj->arena_data_sz =3D data_sz;
>
> +       /* place globals at the end of the arena */
> +       obj->arena_data_off =3D mmap_sz - data_alloc_sz;
> +
>         /* make bpf_map__init_value() work for ARENA maps */
>         map->mmaped =3D obj->arena_data;
>
> @@ -4663,7 +4668,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
>                 reloc_desc->type =3D RELO_DATA;
>                 reloc_desc->insn_idx =3D insn_idx;
>                 reloc_desc->map_idx =3D obj->arena_map_idx;
> -               reloc_desc->sym_off =3D sym->st_value;
> +               reloc_desc->sym_off =3D sym->st_value + obj->arena_data_o=
ff;
>
>                 map =3D &obj->maps[obj->arena_map_idx];
>                 pr_debug("prog '%s': found arena map %d (%s, sec %d, off =
%zu) for insn %u\n",
> @@ -5624,7 +5629,8 @@ bpf_object__create_maps(struct bpf_object *obj)
>                                         return err;
>                                 }
>                                 if (obj->arena_data) {
> -                                       memcpy(map->mmaped, obj->arena_da=
ta, obj->arena_data_sz);
> +                                       memcpy(map->mmaped + obj->arena_d=
ata_off, obj->arena_data,
> +                                               obj->arena_data_sz);
>                                         zfree(&obj->arena_data);
>                                 }
>                         }
> @@ -14387,6 +14393,7 @@ void bpf_object__destroy_subskeleton(struct bpf_o=
bject_subskeleton *s)
>
>  int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
>  {
> +       void *mmaped;
>         int i, err;
>
>         err =3D bpf_object__load(*s->obj);
> @@ -14402,7 +14409,11 @@ int bpf_object__load_skeleton(struct bpf_object_=
skeleton *s)
>                 if (!map_skel->mmaped)
>                         continue;
>
> -               *map_skel->mmaped =3D map->mmaped;
> +               mmaped =3D map->mmaped;
> +               if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
> +                       mmaped +=3D map->obj->arena_data_off;
> +
> +               *map_skel->mmaped =3D mmaped;

this is minor, but I think doing

if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
    /* arena data is placed at the end of arena memory region */
    *map_skel->mmaped =3D map->mmaped + map->obj->arena_data_off;
else
    *map_skel->mmaped =3D map->mmaped;

would be a bit cleaner and easier to follow and no need for extra
mutable variable

>         }
>
>         return 0;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/t=
ools/testing/selftests/bpf/progs/verifier_arena_large.c
> index bd430a34c3ab..2b8cf2a4d880 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -31,16 +31,22 @@ int big_alloc1(void *ctx)
>         if (!page1)
>                 return 1;
>
> -       /* Account for global arena data. */
> -       if ((u64)page1 !=3D base + PAGE_SIZE)
> +       if ((u64)page1 !=3D base)
>                 return 15;
>
>         *page1 =3D 1;
> -       page2 =3D bpf_arena_alloc_pages(&arena, (void __arena *)(ARENA_SI=
ZE - PAGE_SIZE),
> +       page2 =3D bpf_arena_alloc_pages(&arena, (void __arena *)(ARENA_SI=
ZE - 2 * PAGE_SIZE),
>                                       1, NUMA_NO_NODE, 0);
>         if (!page2)
>                 return 2;
>         *page2 =3D 2;
> +
> +       /* Test for the guard region at the end of the arena. */
> +       no_page =3D bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_S=
IZE - PAGE_SIZE,
> +                                       1, NUMA_NO_NODE, 0);
> +       if (no_page)
> +               return 16;
> +
>         no_page =3D bpf_arena_alloc_pages(&arena, (void __arena *)ARENA_S=
IZE,
>                                         1, NUMA_NO_NODE, 0);
>         if (no_page)
> --
> 2.49.0
>

