Return-Path: <bpf+bounces-69029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DACB8BB19
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4877B8C3B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B639A204C36;
	Sat, 20 Sep 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juzZhNXf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551981F2B88
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328220; cv=none; b=HfHz5uhOg+QIbToiT2JUZHlywN6a4QagGEn8gASs2P5w0JKv9jozQ2oIKLaJobVkDydqSq+yc5toCjobak5B6vVdhbPz+Pg8Qo6lBC+c7H8UNRx+VdMvthVftWVt3hE2cgoZDnNDOQpY5x4OfFUfxleCnbnXsojVcLh2WDkKA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328220; c=relaxed/simple;
	bh=QAVQbensOtnYtghRWZwunhHDQKHPPwiWFwwrG9EFXSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iy68MXJZLPEu1OAAs7XT3JOihre6lt7VlVHUVnIivEqiSpTknNnk9g+MrempWm3za4v+bApzDHXEFT+LI3p/8hJ9Ze9Hh8/tmsZlTTrG3RxCQEzgPacg+6K4UuMXKjfvdEuzJN2QaxWGWZ8ErWz0KPc/VLXaZuMQsnxzZIUEfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juzZhNXf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1534171f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758328216; x=1758933016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RB4S5BiWX31CXLaKdrcFO8ly9CdpJunvLxMblEHnO4=;
        b=juzZhNXffddSjoH+bfPxFctSalfywwrsK+wx+vGgVdE0bz/0sKIqSAyEoD+6e9sLLQ
         Zta1qlOy6qdneIrVcYh7fOYy5b1gS9MeFGTwER39jXnLNT3uHSwE4B72igH+I62RW05h
         /swexHgdTBOHn4V6LmNwcW0e2Rief2Y9OQeUaG2HIgm5Gu9tPBfLblf2+gvd+oiD5Gr6
         MDonhzJRmgIVeFXc4znVFfB5uTWmVn7yWbBLAHSpgCAB5eQwZYZls17FGKhqTGaL/zV0
         1mMjvSAdw2g3YAE0TwIdCgKDjk5zeN0/6tB3rkfshum7KpgZOA1MVer/OccJv+8Z5ci/
         Yq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758328216; x=1758933016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RB4S5BiWX31CXLaKdrcFO8ly9CdpJunvLxMblEHnO4=;
        b=Snt0jt5O8KDT5o6hQ2H0u6+osNTyIdrPVO2/tlHeMGnZh18goBsImajk3s/GJhyHFr
         +c+6kw+ieA3BNYi1OoiAC38v8TWItRYUlAqZaQE9vSjQKwlCcKPerUmNhOy2VhpsrKEB
         6SmQCbVyxgrvaEvq8RADslJbaow48gGJcecuFvh9FjFqO44rvAinCFuJleeVlYAzXnQW
         NKea8i1MgouK+MuCpgcqejbHFv4exyjNe1CUQSNb/x8+pTN0u3Cp4qq26oi/okvYPTNq
         EJiHUNsiM+rikSNMQeU+I3/L0JTBTMxNNGA4h1vwfMZ3dAs9AaYhAUZNnk7f9w6iz/cz
         +5pg==
X-Gm-Message-State: AOJu0Yz/GXFkLRpk059UnPkKCOzPYa6godVBHPEZpJC7eQICEajAhPGq
	36ZEMko+QN7BPXMI/xxMXGzIZl6H/GbvqKD9p7UmvqE8s4/zBbF8L77oC2D0RAbazVWrrFp+7v4
	tlE3kellL0SZGmQdttDT3eiB8iA014kI=
X-Gm-Gg: ASbGncsvevzBvAxIvT5WBbyALQA/7Acv85XmDnfjirxL+OuqTca8Ie1AD5AOOKP5VVX
	ANQc+bBNZdV6lQ5k49Th4wtwmB76FY+v2h4V8CPzD4RAT8nVEg8z5lmcdIb8p9CXO+pxcRcsV6s
	h3awKn1Gp4y4ev2RzyyZFEqcl5sE5d9OutWVHaTi4SdJtvOulJXm37EX7yGxC99Kbt1J3tsld3p
	lpIN9eRycSnEO3WEmNViiga3SqdGiklyJfK
X-Google-Smtp-Source: AGHT+IF9mzO1Gv/5EDIpjiS2XL/l/IkGD+jkDwZnMYuhzzMbjxLt/a5plQ8JN3Ifc0yd/hXPRiehmBAM6HnKwDvRLv0=
X-Received: by 2002:a05:6000:2207:b0:3c9:b8b7:ea4e with SMTP id
 ffacd0b85a97d-3ee7df1d10emr3998240f8f.19.1758328216318; Fri, 19 Sep 2025
 17:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com> <20250913193922.1910480-4-a.s.protopopov@gmail.com>
In-Reply-To: <20250913193922.1910480-4-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Sep 2025 17:30:05 -0700
X-Gm-Features: AS18NWCHP1yGkM0PAfzHV-dgH6iIIPFL4nlXcK8zZlbbuJ0UkPuLvpPI345KL4Y
Message-ID: <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 12:33=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> --- /dev/null
> +++ b/kernel/bpf/bpf_insn_array.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +

add copyright?

> +#include <linux/bpf.h>
> +#include <linux/sort.h>
> +
> +#define MAX_INSN_ARRAY_ENTRIES 256
> +
> +struct bpf_insn_array {
> +       struct bpf_map map;
> +       struct mutex state_mutex;
> +       int state;
> +       long *ips;
> +       DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> +};
> +
> +enum {
> +       INSN_ARRAY_STATE_FREE =3D 0,
> +       INSN_ARRAY_STATE_INIT,
> +       INSN_ARRAY_STATE_READY,
> +};
> +
> +#define cast_insn_array(MAP_PTR) \
> +       container_of(MAP_PTR, struct bpf_insn_array, map)

container_of((MAP_PTR)
checkpatch will be happier.

> +
> +#define INSN_DELETED ((u32)-1)
> +
> +static inline u32 insn_array_alloc_size(u32 max_entries)
> +{
> +       const u32 base_size =3D sizeof(struct bpf_insn_array);
> +       const u32 entry_size =3D sizeof(struct bpf_insn_ptr);
> +
> +       return base_size + entry_size * max_entries;
> +}
> +
> +static int insn_array_alloc_check(union bpf_attr *attr)
> +{
> +       if (attr->max_entries =3D=3D 0 ||
> +           attr->key_size !=3D 4 ||
> +           attr->value_size !=3D 8 ||
> +           attr->map_flags !=3D 0)
> +               return -EINVAL;

Use single line or two, instead of 4.

> +
> +       if (attr->max_entries > MAX_INSN_ARRAY_ENTRIES)
> +               return -E2BIG;
> +
> +       return 0;
> +}
> +
> +static void insn_array_free(struct bpf_map *map)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +
> +       kfree(insn_array->ips);
> +       bpf_map_area_free(insn_array);
> +}
> +
> +static struct bpf_map *insn_array_alloc(union bpf_attr *attr)
> +{
> +       u64 size =3D insn_array_alloc_size(attr->max_entries);
> +       struct bpf_insn_array *insn_array;
> +
> +       insn_array =3D bpf_map_area_alloc(size, NUMA_NO_NODE);
> +       if (!insn_array)
> +               return ERR_PTR(-ENOMEM);
> +
> +       insn_array->ips =3D kcalloc(attr->max_entries, sizeof(long), GFP_=
KERNEL);
> +       if (!insn_array->ips) {
> +               insn_array_free(&insn_array->map);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       bpf_map_init_from_attr(&insn_array->map, attr);
> +
> +       mutex_init(&insn_array->state_mutex);
> +       insn_array->state =3D INSN_ARRAY_STATE_FREE;
> +
> +       return &insn_array->map;
> +}
> +
> +static int insn_array_get_next_key(struct bpf_map *map, void *key, void =
*next_key)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +       u32 index =3D key ? *(u32 *)key : U32_MAX;
> +       u32 *next =3D (u32 *)next_key;
> +
> +       if (index >=3D insn_array->map.max_entries) {
> +               *next =3D 0;
> +               return 0;
> +       }
> +
> +       if (index =3D=3D insn_array->map.max_entries - 1)
> +               return -ENOENT;
> +
> +       *next =3D index + 1;
> +       return 0;
> +}

Full copy paste of array_map_get_next_key() is a bit too much.
Pls refactor array_map_get_next_key() to avoid casting
to struct bpf_array, then such a helper can work for both maps.

> +
> +static void *insn_array_lookup_elem(struct bpf_map *map, void *key)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +       u32 index =3D *(u32 *)key;
> +
> +       if (unlikely(index >=3D insn_array->map.max_entries))
> +               return NULL;
> +
> +       return &insn_array->ptrs[index].user_value;
> +}
> +
> +static long insn_array_update_elem(struct bpf_map *map, void *key, void =
*value, u64 map_flags)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +       u32 index =3D *(u32 *)key;
> +       struct bpf_insn_array_value val =3D {};
> +       int err =3D 0;
> +
> +       if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> +               return -EINVAL;

copy paste gone wrong. BPF_F_LOCK is not supported here.

> +
> +       if (unlikely(index >=3D insn_array->map.max_entries))
> +               return -E2BIG;
> +
> +       if (unlikely(map_flags & BPF_NOEXIST))
> +               return -EEXIST;
> +
> +       /* No updates for maps in use */
> +       if (!mutex_trylock(&insn_array->state_mutex))
> +               return -EBUSY;

trylock ?!

If I'm reading it correctly
check_map_func_compatibility() prevents usage of this helper
from the prog, so this is syscall only,
but trylock?!

> +
> +       if (insn_array->state !=3D INSN_ARRAY_STATE_FREE) {
> +               err =3D -EBUSY;
> +               goto unlock;
> +       }
> +
> +       copy_map_value(map, &val, value);
> +       if (val.jitted_off || val.xlated_off =3D=3D INSN_DELETED) {
> +               err =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       insn_array->ptrs[index].orig_xlated_off =3D val.xlated_off;
> +       insn_array->ptrs[index].user_value.xlated_off =3D val.xlated_off;
> +
> +unlock:
> +       mutex_unlock(&insn_array->state_mutex);
> +       return err;
> +}
> +
> +static long insn_array_delete_elem(struct bpf_map *map, void *key)
> +{
> +       return -EINVAL;
> +}
> +
> +static int insn_array_check_btf(const struct bpf_map *map,
> +                             const struct btf *btf,
> +                             const struct btf_type *key_type,
> +                             const struct btf_type *value_type)
> +{
> +       if (!btf_type_is_i32(key_type))
> +               return -EINVAL;
> +
> +       if (!btf_type_is_i64(value_type))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static u64 insn_array_mem_usage(const struct bpf_map *map)
> +{
> +       u64 extra_size =3D 0;
> +
> +       extra_size +=3D sizeof(long) * map->max_entries; /* insn_array->i=
ps */
> +
> +       return insn_array_alloc_size(map->max_entries) + extra_size;
> +}
> +
> +BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
> +
> +const struct bpf_map_ops insn_array_map_ops =3D {
> +       .map_alloc_check =3D insn_array_alloc_check,
> +       .map_alloc =3D insn_array_alloc,
> +       .map_free =3D insn_array_free,
> +       .map_get_next_key =3D insn_array_get_next_key,
> +       .map_lookup_elem =3D insn_array_lookup_elem,
> +       .map_update_elem =3D insn_array_update_elem,
> +       .map_delete_elem =3D insn_array_delete_elem,
> +       .map_check_btf =3D insn_array_check_btf,
> +       .map_mem_usage =3D insn_array_mem_usage,
> +       .map_btf_id =3D &insn_array_btf_ids[0],
> +};
> +
> +static bool is_insn_array(const struct bpf_map *map)
> +{
> +       return map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY;
> +}
> +
> +static inline bool valid_offsets(const struct bpf_insn_array *insn_array=
,
> +                                const struct bpf_prog *prog)
> +{
> +       u32 off;
> +       int i;
> +
> +       for (i =3D 0; i < insn_array->map.max_entries; i++) {
> +               off =3D insn_array->ptrs[i].orig_xlated_off;
> +
> +               if (off >=3D prog->len)
> +                       return false;
> +
> +               if (off > 0) {
> +                       if (prog->insnsi[off-1].code =3D=3D (BPF_LD | BPF=
_DW | BPF_IMM))
> +                               return false;
> +               }
> +       }
> +
> +       return true;
> +}
> +
> +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog=
)
> +{
> +       struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +       int i;
> +
> +       if (!valid_offsets(insn_array, prog))
> +               return -EINVAL;
> +
> +       /*
> +        * There can be only one program using the map
> +        */
> +       mutex_lock(&insn_array->state_mutex);
> +       if (insn_array->state !=3D INSN_ARRAY_STATE_FREE) {
> +               mutex_unlock(&insn_array->state_mutex);
> +               return -EBUSY;
> +       }
> +       insn_array->state =3D INSN_ARRAY_STATE_INIT;
> +       mutex_unlock(&insn_array->state_mutex);

only verifier calls this helpers, no?
Why all the mutexes here and below ?
All the mutexes is a big red flag to me.
Will stop any further comments here.

