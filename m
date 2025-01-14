Return-Path: <bpf+bounces-48873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B71A1151A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FD160B57
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F215B2144B8;
	Tue, 14 Jan 2025 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1TeRr48"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE827214212
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896260; cv=none; b=CmCAldbGfoNxYb63zavApsbF5BXNuA9XcSSBlrHrAwTmRNTCafXWuXaHibdXhIuBy/yc+QCYJ3w1NucRtLIZ/lXF0V3yEAzEDBo+xVcSk2fRzo+rNKk0kfOX5KMi5IMLTUj26j9J2W2E/M1KEaW4HivRDIB43ul7L04qgvvod6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896260; c=relaxed/simple;
	bh=dXMHH/iXnIjdtjBNP4kVBjg7olDWs3JlBf3UmmX1Hw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbYKLxM4Q+asr1ULJb2K59mn+uHw0OruWUbsKeA9p+aPdS5B+pgaWO3Aa9Z7Pl76iktPUKV6qGUvX8Gg2oRZ9PYMSyY5Uo6QVgnTGbkG8EIL9eA4FQmJvMZFlRBO9Ud09sH+MPmRHcyWx1BX5h5eUjDpBmBRR/rP8xxfz3We/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1TeRr48; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163b0c09afso111707915ad.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736896258; x=1737501058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrgqIsTn5BQAwP1qNjKGO7uVFsew4IHZSxTIVUArylY=;
        b=X1TeRr48atlz0l1gddFKDGneNrKgDGcip1IdQ0vKwO3+lZkYYOeWeX+sMogee1jywA
         nPTwIFvsrJhlZePS+rm/IGiuaWRQfmYXIFZ+SxESA7/UvUk6N37N9RXl6P7xNYTyNSsn
         aqUcVt5AEpO23Ns9dFcU94eskIIwy1aphucG+f2ll8sNMaLc6lhumKNtm2U7znE9vYQb
         VSgi+KM8TPK8EIrVvBtnPLUtip3crlUedk4EIA2t+WI01ZVr+okKaZ+TONCRioHBNABL
         bu1pDmHAWEvwxEAp5drXhVe5MxnWT79NrViVPErfC05XM1IbGrTsFdhJ2itngcalVeFL
         e9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896258; x=1737501058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrgqIsTn5BQAwP1qNjKGO7uVFsew4IHZSxTIVUArylY=;
        b=J+/oBTHWLho+bFaIIa2W8tPUl8fuksH8lb3Xnz27G7r0/f1ZNkM/TC5HVm7pDMBFVa
         sSZmBVx+aRpA3p5fNFB/436J3tIy7e74ZQkrJKsI+R5tdTMjjaN6XfifNmqkiZ6ijVA7
         HA4JTbAxZCvSLFC1U6uePv0FxTmg0wc3o02S6cuembhDwXcw22AqEWOMf8aO0i35Qhf8
         LbJGkyGM4k/fXNFPoJbvsP4kYhz2A2TsxxjYSS9u9ICx5b96JEf8oUPJWlQCW3uOhbF+
         gvSHTfgHV1QAlyOgDEUaKJNiCsP0CffS0MeZb+yp5K3CbxyMwP/jqiQ49fb1SrLh9eGJ
         5o/w==
X-Gm-Message-State: AOJu0Yyag1A3QgaMYZ1M4Msww6AI/Mr5wwIhJxUaZ4iSFSXfijuFWDN2
	HD/XepNUWhkBxdbe3fAItNNBQt9Ak295GrCnP93pV5Cnw4cjfqdXZ/39ugSkqhcZK4M5SGSBe5T
	sUj0F1I+Cb435xzfbgcqiQdiz6R0=
X-Gm-Gg: ASbGncsFpf/59DDpKnHG3tWGjcdOvDtqQkKnZE/iQg/+rIsoBj791RWcKMJx73/e3+I
	qk+KJmp7VroNyWvN7YPZe960PZ5mNNLLdy0dN
X-Google-Smtp-Source: AGHT+IHIc8CxpAbKZpUuP9m3b2l6jVyyy3qaMdmyzJcKkiPJ8d8NprLv4Pqfwyj0Toa22C100sU5JHS659Fnbxgu0Pw=
X-Received: by 2002:a17:90a:d00b:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f548ebf53cmr37356066a91.13.1736896257904; Tue, 14 Jan 2025
 15:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113152437.67196-1-leon.hwang@linux.dev> <20250113152437.67196-2-leon.hwang@linux.dev>
In-Reply-To: <20250113152437.67196-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 15:10:43 -0800
X-Gm-Features: AbW1kvZ2G4Y9-MtPF_pCJ8OSTWgeYXzyWiaEKx6sRrB2zf1_PAkhZqflIrPuvuM
Message-ID: <CAEf4BzahZ04K5LDaqaToJnQ9yvRZ48yh-2+ywsKRgcj8whMheA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:25=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces global per-CPU data, inspired by commit
> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> definition of global per-CPU variables in BPF, similar to the
> DEFINE_PER_CPU() macro in the kernel[0].
>
> For example, in BPF, it is able to define a global per-CPU variable like
> this:
>
> int percpu_data SEC(".data..percpu");
>
> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
> BPF code for handling LBRs. The code can be updated from
>
> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs"=
);
>
> to
>
> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".data..percpu.=
lbrs");
>
> This eliminates the need to retrieve the CPU ID using the
> bpf_get_smp_processor_id() helper.
>
> Additionally, by reusing global per-CPU variables, sharing information
> between tail callers and callees or freplace callers and callees becomes
> simpler compared to using percpu_array maps.
>
> Links:
> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe=
90be28c5a3/include/linux/percpu-defs.h#L114
> [1] https://github.com/anakryiko/retsnoop
> [2] https://github.com/Asphaltt/bpflbr
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/arraymap.c  |  39 +++++++++++++-
>  kernel/bpf/verifier.c  |  45 +++++++++++++++++
>  tools/lib/bpf/libbpf.c | 112 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 171 insertions(+), 25 deletions(-)
>

So I think the feature overall makes sense, but we need to think
through at least libbpf's side of things some more. Unlike .data,
per-cpu .data section is not mmapable, and so that has implication on
BPF skeleton and we should make sure all that makes sense on BPF
skeleton side. In that sense, per-cpu global data is more akin to
struct_ops initialization image, which can be accessed by user before
skeleton is loaded to initialize the image.

There are a few things to consider. What's the BPF skeleton interface?
Do we expose it as single struct and use that struct as initial image
for each CPU (which means user won't be able to initialize different
CPU data differently, at least not through BPF skeleton facilities)?
Or do we expose this as an array of structs and let user set each CPU
data independently?

I feel like keeping it simple and having one image for all CPUs would
cover most cases. And users can still access the underlying
PERCPU_ARRAY map if they need more control.

But either way, we need tests for skeleton, making sure we NULL-out
this per-cpu global data, but take it into account before the load.

Also, this huge calloc for possible CPUs, I'd like to avoid it
altogether for the (probably very common) zero-initialized case.

So in short, needs a bit of iteration to figure out all the
interfacing issues, but makes sense overall. See some more low-level
remarks below.

pw-bot: cr


[...]

> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
>         .map_get_next_key =3D array_map_get_next_key,
>         .map_lookup_elem =3D percpu_array_map_lookup_elem,
>         .map_gen_lookup =3D percpu_array_map_gen_lookup,
> +       .map_direct_value_addr =3D percpu_array_map_direct_value_addr,
> +       .map_direct_value_meta =3D percpu_array_map_direct_value_meta,
>         .map_update_elem =3D array_map_update_elem,
>         .map_delete_elem =3D array_map_delete_elem,
>         .map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b8ca227c78af1..94ce02a48ddc1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6809,6 +6809,8 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +               return -EINVAL;

I'd invert the condition and reject anything by BPF_MAP_TYPE_ARRAY. I
don't see how any other possible map type can support this magic that
we do with ARRAY. So to be on the safe side, let's just reject
everything that's non-ARRAY (here and elsewhere)?

>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6c262d0152f81..881174f4f90a4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

definitely let's split out libbpf changes from kernel-side changes

> @@ -516,6 +516,7 @@ struct bpf_struct_ops {
>  };
>
>  #define DATA_SEC ".data"
> +#define PERCPU_DATA_SEC ".data..percpu"

I don't like this prefix, even if that's what we have in the kernel.
Something like just ".percpu" or ".percpu_data" or ".data_percpu" is
better, IMO.

>  #define BSS_SEC ".bss"
>  #define RODATA_SEC ".rodata"
>  #define KCONFIG_SEC ".kconfig"
> @@ -562,6 +563,8 @@ struct bpf_map {
>         __u32 btf_value_type_id;
>         __u32 btf_vmlinux_value_type_id;
>         enum libbpf_map_type libbpf_type;
> +       int num_cpus;
> +       void *data;
>         void *mmaped;
>         struct bpf_struct_ops *st_ops;
>         struct bpf_map *inner_map;
> @@ -1923,11 +1926,35 @@ static bool map_is_mmapable(struct bpf_object *ob=
j, struct bpf_map *map)
>         return false;
>  }
>
> +static bool map_is_percpu_data(struct bpf_map *map)
> +{
> +       return str_has_pfx(map->real_name, PERCPU_DATA_SEC);
> +}

we have enum libbpf_map_type which is used to distinguish BSS vs
RODATA vs DATA vs others, let's stick to that

> +
> +static void map_copy_data(struct bpf_map *map, const void *data)
> +{
> +       bool is_percpu_data =3D map_is_percpu_data(map);
> +       size_t data_sz =3D map->def.value_size;
> +       size_t elem_sz =3D roundup(data_sz, 8);
> +       int i;
> +
> +       if (!data)
> +               return;
> +
> +       if (!is_percpu_data)
> +               memcpy(map->mmaped, data, data_sz);
> +       else
> +               for (i =3D 0; i < map->num_cpus; i++)
> +                       memcpy(map->data + i*elem_sz, data, data_sz);
> +}
> +
>  static int
>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_ty=
pe type,
>                               const char *real_name, int sec_idx, void *d=
ata, size_t data_sz)
>  {
> +       bool is_percpu_data =3D str_has_pfx(real_name, PERCPU_DATA_SEC);
>         struct bpf_map_def *def;
> +       const char *data_desc;
>         struct bpf_map *map;
>         size_t mmap_sz;
>         int err;
> @@ -1948,7 +1975,8 @@ bpf_object__init_internal_map(struct bpf_object *ob=
j, enum libbpf_map_type type,
>         }
>
>         def =3D &map->def;
> -       def->type =3D BPF_MAP_TYPE_ARRAY;
> +       def->type =3D is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
> +                                  : BPF_MAP_TYPE_ARRAY;
>         def->key_size =3D sizeof(int);
>         def->value_size =3D data_sz;
>         def->max_entries =3D 1;
> @@ -1958,29 +1986,57 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
>         /* failures are fine because of maps like .rodata.str1.1 */
>         (void) map_fill_btf_type_info(obj, map);
>
> -       if (map_is_mmapable(obj, map))
> -               def->map_flags |=3D BPF_F_MMAPABLE;
> +       data_desc =3D is_percpu_data ? "percpu " : "";

nit: just inline the logic in that single place you use it

> +       pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, fl=
ags %x.\n",
> +                map->name, data_desc, map->sec_idx, map->sec_offset,
> +                def->map_flags);
>
> -       pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flag=
s %x.\n",
> -                map->name, map->sec_idx, map->sec_offset, def->map_flags=
);
> +       if (is_percpu_data) {
> +               map->num_cpus =3D libbpf_num_possible_cpus();
> +               if (map->num_cpus < 0) {
> +                       err =3D errno;

map->num_cpus should have actual error value already, avoid using
errno unnecessarily

> +                       pr_warn("failed to get possible cpus\n");
> +                       goto free_name;
> +               }
>
> -       mmap_sz =3D bpf_map_mmap_sz(map);
> -       map->mmaped =3D mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> -                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> -       if (map->mmaped =3D=3D MAP_FAILED) {
> -               err =3D -errno;
> -               map->mmaped =3D NULL;
> -               pr_warn("failed to alloc map '%s' content buffer: %s\n", =
map->name, errstr(err));
> -               zfree(&map->real_name);
> -               zfree(&map->name);
> -               return err;
> -       }
> +               map->data =3D calloc(map->num_cpus, roundup(data_sz, 8));
> +               if (!map->data) {
> +                       err =3D -ENOMEM;
> +                       pr_warn("failed to alloc percpu map '%s' content =
buffer: %s\n",
> +                               map->name, errstr(err));

please stick to establish reporting style (i.e., for map operations we
always use "map '%s': " prefix)

> +                       goto free_name;
> +               }

[...]

> @@ -10370,7 +10434,7 @@ void *bpf_map__initial_value(const struct bpf_map=
 *map, size_t *psize)
>                 return map->st_ops->data;
>         }
>
> -       if (!map->mmaped)
> +       if ((!map->mmaped && !map->data))

nit: why unnecessary extra () ?


>                 return NULL;
>
>         if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
> @@ -10378,7 +10442,7 @@ void *bpf_map__initial_value(const struct bpf_map=
 *map, size_t *psize)
>         else
>                 *psize =3D map->def.value_size;
>
> -       return map->mmaped;
> +       return map->def.type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ? map->data=
 : map->mmaped;
>  }
>
>  bool bpf_map__is_internal(const struct bpf_map *map)
> --
> 2.47.1
>

