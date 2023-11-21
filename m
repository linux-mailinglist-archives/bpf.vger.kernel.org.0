Return-Path: <bpf+bounces-15585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5C7F36CE
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BEB1C20CC2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3723C5B210;
	Tue, 21 Nov 2023 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoJoIqTy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F712C
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:30:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00a9d677fcso243199266b.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700595016; x=1701199816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zLXbfhErrunYg232eQrMvqop0ovtGaCWAp1U3mMQfU=;
        b=PoJoIqTysw+ArMwa5DFw92I807RVJU9FG7AxJqGDi0+y3Q8Y2T9Ny33IvWiUqbyDTQ
         PXrQaAhdoRhHo4x9y9qXgAb1Tu1aZIQbl70Nnfrhz4gqqOFlGbmhbfgJ4Z5Kf22CtFiS
         nWdR/yDuncZAbZLoEnrSGgCy7fAPJQhzfpMzGzELSAWd2R+yANiv8m+SSDZTR2h798Ge
         Hz/RtZwPePrl9p0S9+CGXSWg36rZDjGYLOQ9gylsfDD5HnISfqhdos3l9Wje0c2yyn2o
         ArK0F5jejF0EMGVVpa2L2sh7EWPo9fwZTUd1QP350Ta9V0uIGanxGpE+reKjlYjgDErj
         nwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700595016; x=1701199816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zLXbfhErrunYg232eQrMvqop0ovtGaCWAp1U3mMQfU=;
        b=C24Ytg6av3kSjpGbxo7at+TdFhM8NGN/K+ilaqsWnGQyJsQyvUcYdeg+jzKyqxVRRt
         MOZdjPGgyLnlo734/AwceEx0gUdalZy3U0BZN9PO8xKcvKr3FAxQDI15sAozmEvMGZA+
         PezgU4dt6jL4AX4PAxGLiw1DTTCNomRvUdyMNGnN/a4MXuQ9ubssO/9/n3CGb6t9YYxi
         UKFX5u23D5R2tHmA9/LbmTLb2Jx+46JR5aBTbXgDMjYCt3rV7ysLoFhMPkmHHVzVtNDq
         QeRFmYHbKKQ3Yeca50IeLhO2nl98LjHeTRo171Xy8aQby15df8/xR3myUwQ1oLatFjsw
         8b0w==
X-Gm-Message-State: AOJu0YyoeUAOGnVIo8fzo0fHI7w9l8RsvQmKc2qGFdn7DF9J0wrVEVF/
	LVv80RiDU0nueEO5snVikNrm9CzLP3+ccafpcKGXZErx
X-Google-Smtp-Source: AGHT+IHDOG00QjvGGazo13xb5gwRn59BOzARtx6ftCLuhuf7yZgEJAaWqcT353/bbWvrsnBj6qnu8I8dGOMmb/OhcNc=
X-Received: by 2002:a17:906:24d4:b0:9fd:59ea:2dec with SMTP id
 f20-20020a17090624d400b009fd59ea2decmr5909024ejb.73.1700595015818; Tue, 21
 Nov 2023 11:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120175925.733167-1-davemarchevsky@fb.com> <20231120175925.733167-2-davemarchevsky@fb.com>
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 11:30:03 -0800
Message-ID: <CAEf4BzYZGC3VVMn0q9o=2KauT=7gsQPHbi1epC_Q5oPiPekRWw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local storage
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 9:59=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> This patch modifies the generic bpf_local_storage infrastructure to
> support mmapable map values and adds mmap() handling to task_local
> storage leveraging this new functionality. A userspace task which
> mmap's a task_local storage map will receive a pointer to the map_value
> corresponding to that tasks' key - mmap'ing in other tasks' mapvals is
> not supported in this patch.
>
> Currently, struct bpf_local_storage_elem contains both bookkeeping
> information as well as a struct bpf_local_storage_data with additional
> bookkeeping information and the actual mapval data. We can't simply map
> the page containing this struct into userspace. Instead, mmapable
> local_storage uses bpf_local_storage_data's data field to point to the
> actual mapval, which is allocated separately such that it can be
> mmapped. Only the mapval lives on the page(s) allocated for it.
>
> The lifetime of the actual_data mmapable region is tied to the
> bpf_local_storage_elem which points to it. This doesn't necessarily mean
> that the pages go away when the bpf_local_storage_elem is free'd - if
> they're mapped into some userspace process they will remain until
> unmapped, but are no longer the task_local storage's mapval.
>
> Implementation details:
>
>   * A few small helpers are added to deal with bpf_local_storage_data's
>     'data' field having different semantics when the local_storage map
>     is mmapable. With their help, many of the changes to existing code
>     are purely mechanical (e.g. sdata->data becomes sdata_mapval(sdata),
>     selem->elem_size becomes selem_bytes_used(selem)).

might be worth doing this as a pre-patch with no functional changes to
make the main change a bit smaller and more focused?

>
>   * The map flags are copied into bpf_local_storage_data when its
>     containing bpf_local_storage_elem is alloc'd, since the
>     bpf_local_storage_map associated with them may be gone when
>     bpf_local_storage_data is free'd, and testing flags for
>     BPF_F_MMAPABLE is necessary when free'ing to ensure that the
>     mmapable region is free'd.
>     * The extra field doesn't change bpf_local_storage_elem's size.
>       There were 48 bytes of padding after the bpf_local_storage_data
>       field, now there are 40.
>
>   * Currently, bpf_local_storage_update always creates a new
>     bpf_local_storage_elem for the 'updated' value - the only exception
>     being if the map_value has a bpf_spin_lock field, in which case the
>     spin lock is grabbed instead of the less granular bpf_local_storage
>     lock, and the value updated in place. This inplace update behavior
>     is desired for mmapable local_storage map_values as well, since
>     creating a new selem would result in new mmapable pages.
>
>   * The size of the mmapable pages are accounted for when calling
>     mem_{charge,uncharge}. If the pages are mmap'd into a userspace task
>     mem_uncharge may be called before they actually go away.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf_local_storage.h |  14 ++-
>  kernel/bpf/bpf_local_storage.c    | 145 ++++++++++++++++++++++++------
>  kernel/bpf/bpf_task_storage.c     |  35 ++++++--
>  kernel/bpf/syscall.c              |   2 +-
>  4 files changed, 163 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 173ec7f43ed1..114973f925ea 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
>          * the number of cachelines accessed during the cache hit case.
>          */
>         struct bpf_local_storage_map __rcu *smap;
> -       u8 data[] __aligned(8);
> +       /* Need to duplicate smap's map_flags as smap may be gone when
> +        * it's time to free bpf_local_storage_data
> +        */
> +       u64 smap_map_flags;
> +       /* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
> +        * Otherwise the actual mapval data lives here
> +        */
> +       union {
> +               DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
> +               void *actual_data __aligned(8);

I don't know if it's the issue, but probably best to keep FLEX_ARRAY
member the last even within the union, just in case if some tool
doesn't handle FLEX_ARRAY not being last line number-wise?


> +       };
>  };
>
>  /* Linked to bpf_local_storage and bpf_local_storage_map */
> @@ -124,6 +134,8 @@ static struct bpf_local_storage_cache name =3D {     =
                 \
>  /* Helper functions for bpf_local_storage */
>  int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
>
> +void *sdata_mapval(struct bpf_local_storage_data *data);
> +
>  struct bpf_map *
>  bpf_local_storage_map_alloc(union bpf_attr *attr,
>                             struct bpf_local_storage_cache *cache,
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 146824cc9689..9b3becbcc1a3 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -15,7 +15,8 @@
>  #include <linux/rcupdate_trace.h>
>  #include <linux/rcupdate_wait.h>
>
> -#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CL=
ONE)
> +#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
> +       (BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
>
>  static struct bpf_local_storage_map_bucket *
>  select_bucket(struct bpf_local_storage_map *smap,
> @@ -24,6 +25,51 @@ select_bucket(struct bpf_local_storage_map *smap,
>         return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
>  }
>
> +struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map);
> +
> +void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
> +{
> +       struct mem_cgroup *memcg, *old_memcg;
> +       void *ptr;
> +
> +       memcg =3D bpf_map_get_memcg(&smap->map);
> +       old_memcg =3D set_active_memcg(memcg);
> +       ptr =3D bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_si=
ze),
> +                                         NUMA_NO_NODE);
> +       set_active_memcg(old_memcg);
> +       mem_cgroup_put(memcg);
> +
> +       return ptr;
> +}
> +
> +void *sdata_mapval(struct bpf_local_storage_data *data)
> +{
> +       if (data->smap_map_flags & BPF_F_MMAPABLE)
> +               return data->actual_data;
> +       return &data->data;
> +}

given this being potentially high-frequency helper called from other
.o files and it is simple, should this be a static inline in .h header
instead?

> +
> +static size_t sdata_data_field_size(struct bpf_local_storage_map *smap,
> +                                   struct bpf_local_storage_data *data)
> +{
> +       if (smap->map.map_flags & BPF_F_MMAPABLE)
> +               return sizeof(void *);
> +       return (size_t)smap->map.value_size;
> +}
> +

[...]

> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
> index adf6dfe0ba68..ce75c8d8b2ce 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -90,6 +90,7 @@ void bpf_task_storage_free(struct task_struct *task)
>  static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void =
*key)
>  {
>         struct bpf_local_storage_data *sdata;
> +       struct bpf_local_storage_map *smap;
>         struct task_struct *task;
>         unsigned int f_flags;
>         struct pid *pid;
> @@ -114,7 +115,8 @@ static void *bpf_pid_task_storage_lookup_elem(struct =
bpf_map *map, void *key)
>         sdata =3D task_storage_lookup(task, map, true);
>         bpf_task_storage_unlock();
>         put_pid(pid);
> -       return sdata ? sdata->data : NULL;
> +       smap =3D (struct bpf_local_storage_map *)map;

smap seems unused?

> +       return sdata ? sdata_mapval(sdata) : NULL;
>  out:
>         put_pid(pid);
>         return ERR_PTR(err);
> @@ -209,18 +211,19 @@ static void *__bpf_task_storage_get(struct bpf_map =
*map,
>                                     u64 flags, gfp_t gfp_flags, bool nobu=
sy)
>  {
>         struct bpf_local_storage_data *sdata;
> +       struct bpf_local_storage_map *smap;
>
> +       smap =3D (struct bpf_local_storage_map *)map;

used much later, so maybe move it down? or just not change this part?

>         sdata =3D task_storage_lookup(task, map, nobusy);
>         if (sdata)
> -               return sdata->data;
> +               return sdata_mapval(sdata);
>
>         /* only allocate new storage, when the task is refcounted */
>         if (refcount_read(&task->usage) &&
>             (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
> -               sdata =3D bpf_local_storage_update(
> -                       task, (struct bpf_local_storage_map *)map, value,
> -                       BPF_NOEXIST, gfp_flags);
> -               return IS_ERR(sdata) ? NULL : sdata->data;
> +               sdata =3D bpf_local_storage_update(task, smap, value,
> +                                                BPF_NOEXIST, gfp_flags);
> +               return IS_ERR(sdata) ? NULL : sdata_mapval(sdata);
>         }
>
>         return NULL;
> @@ -317,6 +320,25 @@ static void task_storage_map_free(struct bpf_map *ma=
p)
>         bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_bu=
sy);
>  }
>
> +static int task_storage_map_mmap(struct bpf_map *map, struct vm_area_str=
uct *vma)
> +{
> +       void *data;
> +
> +       if (!(map->map_flags & BPF_F_MMAPABLE) || vma->vm_pgoff ||
> +           (vma->vm_end - vma->vm_start) < map->value_size)

so we enforce that vm_pgoff is zero, that's understandable. But why
disallowing mmaping only a smaller portion of map value?

Also, more importantly, I think you should reject `vma->vm_end -
vma->vm_start > PAGE_ALIGN(map->value_size)`, no?

Another question. I might have missed it, but where do we disallow
mmap()'ing maps that have "special" fields in map_value, like kptrs,
spin_locks, timers, etc?

> +               return -EINVAL;
> +
> +       WARN_ON_ONCE(!bpf_rcu_lock_held());
> +       bpf_task_storage_lock();
> +       data =3D __bpf_task_storage_get(map, current, NULL, BPF_LOCAL_STO=
RAGE_GET_F_CREATE,
> +                                     0, true);
> +       bpf_task_storage_unlock();
> +       if (!data)
> +               return -EINVAL;
> +
> +       return remap_vmalloc_range(vma, data, vma->vm_pgoff);
> +}
> +
>  BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_loca=
l_storage_map)
>  const struct bpf_map_ops task_storage_map_ops =3D {
>         .map_meta_equal =3D bpf_map_meta_equal,
> @@ -331,6 +353,7 @@ const struct bpf_map_ops task_storage_map_ops =3D {
>         .map_mem_usage =3D bpf_local_storage_map_mem_usage,
>         .map_btf_id =3D &bpf_local_storage_map_btf_id[0],
>         .map_owner_storage_ptr =3D task_storage_ptr,
> +       .map_mmap =3D task_storage_map_mmap,
>  };
>
>  const struct bpf_func_proto bpf_task_storage_get_recur_proto =3D {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e43ddd1b83f..d7c05a509870 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -404,7 +404,7 @@ static void bpf_map_release_memcg(struct bpf_map *map=
)
>                 obj_cgroup_put(map->objcg);
>  }
>
> -static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
> +struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
>  {
>         if (map->objcg)
>                 return get_mem_cgroup_from_objcg(map->objcg);
> --
> 2.34.1
>

