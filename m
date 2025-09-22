Return-Path: <bpf+bounces-69192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925AB90063
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D71A42311E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B22FFFA9;
	Mon, 22 Sep 2025 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCEBsmGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA381287510
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537158; cv=none; b=qbWBxbt27021ln6zdTGKOR680gHq5zonP7M3upSEnOrme08tm2Yoe/qSmv+LCxaizFtBRtTww0nJoCc94nCwUNwMXl2WuvRNIbaKzaJZoWFxHSQVzqyk0XjkjLlyjjgcfgyvgXi+IWZ5ygaVChe8D92zcVQaMce6FJVGlXnBTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537158; c=relaxed/simple;
	bh=dX/E4Kck3t8c6qyfR/Z5LFKUwf0aHU3NbPKIauNd9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCFzTg8GBFA8hBvEuipE4tV8W9pPsiSE5lUcTu56YPDuCO7zoahtg33BWJRX/ByuYlRWXjAtQ7yESMR7tJ6zrS5faSEGdelhLbUdbua7yx0Nxovb0IkwtduuHlw/qbA8QXhRtyYb/fbwJaUvhURDVH/k7x4yQ4LkZhItgA6ymEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCEBsmGv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46d40c338b8so5719885e9.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758537154; x=1759141954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6GnOjHq4cn8eihHQCq8cdi4niKzKzQD9LrX0OY57rw=;
        b=NCEBsmGvLcSzv3pkIEnKQ/5P8bfgnSIwgBzgOjmZC9G26jDjLV/i718fKTJFtSlC6z
         Da7sgWZJtAMGokEb8pj+x1b7UjUSr3c0ypTNr5HTMphVKKFVyy9eW0+JpXpEoIZJSKQt
         wWnXhn4IBR7nmcwaGjEGuAeWvaOJFDoAFfK1f4UcJHVBFb3xkTbkYT/9wn56Hu2ogrMa
         X3mmQAbClXISSc40oVs6kNYww1/VVnXzqDAFQLpqBuAe5IlTfvv12Dx12M3oarIMgbqA
         61p8gbPuERzU7vsQuQJ/sdazk1EdGqCbGIQ6YS2K2lBZ/GA0lYVGENMQsUYcDBEp69dB
         GTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537154; x=1759141954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6GnOjHq4cn8eihHQCq8cdi4niKzKzQD9LrX0OY57rw=;
        b=TnJC/1A7nn6o996VL4eWiOLpIl0YK+JwDNQyeOdulkkRFs23puDkLKqz0bPQlMLB8d
         GxvbOT2i96zrVQ4SwkFhoDvYj5uGq1B0Vk8DISo9h8paEDqwgA8qjZzJbvjU/PwFuXX5
         6djl/rLUe1lBmxmV6a48bCki1DR3H7uDzyH5iwt4ZRNGxbVcrxvmhTQwCfewJVdhqOh8
         tG0P0pNzvJ6juhC8BvjtzmGWVvhttg4lMfzCaaWEQ1aIqtqB7vOI2UP//pH2HoV0mDRd
         x5UuHvl7iAk3FFWCph4NEvHbT5VdktXxP6gPLtXEZosKn4tOpJWd/x2OTY8raQZDFddL
         aFIg==
X-Gm-Message-State: AOJu0YyUTkftOPd9KPmuOq+6z0zuLheAo84MbJPoRyIzApqGMwJ7y3lz
	34Q/Ux6dCYQdblmPzvO23/gq+CTUU7fbD2ZUXIeTnB/6uouwr3zfXClKhfqjUw==
X-Gm-Gg: ASbGnctU4BdhkNjIhtQLgPqyLvKZEou1uuskjbDw8zQiWQGVzUeIEp5ZWRKT+3kc0vo
	7bJkkTOFl+UP/uFKjVbru/LNL1F3c/4X1gd0eo2JZzNF3wmVYKMhqxWtSftzFrcBY8gGT9xz/Km
	QnLXAKIt+vKpGsQCcsB0jHm/Y7qvgjLTCVPBObfuNmHwiiMYMlWMmFYWPc5h2o00p594suQzH5p
	k5j2dxijS6opsnaxM86l/JUkYsQtaCVWFbfBau+IrF8e9lGpTIy+jQkNecIb/R+2k1F55hdTXSK
	gQBRVNhs+GBtGxZy7Qo0JXGxRNa4xBSGfsZ4BTU8jRstO0cZ0Keuvff6dCAWYVRDbyKImQYnEyK
	6Kd/PrR5/Wy6K8g3BeVNURaQzIpOyp3LO
X-Google-Smtp-Source: AGHT+IFfocSYeTfqOrwavfsv+srD73ObrwRz3KskHo9VFKVZ4wJpgqOco/qpkTgllVedmWK3On2nfw==
X-Received: by 2002:a05:600c:4451:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-467ead682c5mr97908075e9.20.1758537153925;
        Mon, 22 Sep 2025 03:32:33 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f4e4sm219976715e9.13.2025.09.22.03.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:32:33 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:38:37 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
Message-ID: <aNEnLZzOyEuNOtXu@mail.gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com>
 <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>

On 25/09/19 05:30PM, Alexei Starovoitov wrote:
> On Sat, Sep 13, 2025 at 12:33 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -0,0 +1,336 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> 
> add copyright?

Yes, thanks!

> > +#include <linux/bpf.h>
> > +#include <linux/sort.h>
> > +
> > +#define MAX_INSN_ARRAY_ENTRIES 256
> > +
> > +struct bpf_insn_array {
> > +       struct bpf_map map;
> > +       struct mutex state_mutex;
> > +       int state;
> > +       long *ips;
> > +       DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> > +};
> > +
> > +enum {
> > +       INSN_ARRAY_STATE_FREE = 0,
> > +       INSN_ARRAY_STATE_INIT,
> > +       INSN_ARRAY_STATE_READY,
> > +};
> > +
> > +#define cast_insn_array(MAP_PTR) \
> > +       container_of(MAP_PTR, struct bpf_insn_array, map)
> 
> container_of((MAP_PTR)
> checkpatch will be happier.

Thanks, fixed

> > +
> > +#define INSN_DELETED ((u32)-1)
> > +
> > +static inline u32 insn_array_alloc_size(u32 max_entries)
> > +{
> > +       const u32 base_size = sizeof(struct bpf_insn_array);
> > +       const u32 entry_size = sizeof(struct bpf_insn_ptr);
> > +
> > +       return base_size + entry_size * max_entries;
> > +}
> > +
> > +static int insn_array_alloc_check(union bpf_attr *attr)
> > +{
> > +       if (attr->max_entries == 0 ||
> > +           attr->key_size != 4 ||
> > +           attr->value_size != 8 ||
> > +           attr->map_flags != 0)
> > +               return -EINVAL;
> 
> Use single line or two, instead of 4.

Done

> > +
> > +       if (attr->max_entries > MAX_INSN_ARRAY_ENTRIES)
> > +               return -E2BIG;
> > +
> > +       return 0;
> > +}
> > +
> > +static void insn_array_free(struct bpf_map *map)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +
> > +       kfree(insn_array->ips);
> > +       bpf_map_area_free(insn_array);
> > +}
> > +
> > +static struct bpf_map *insn_array_alloc(union bpf_attr *attr)
> > +{
> > +       u64 size = insn_array_alloc_size(attr->max_entries);
> > +       struct bpf_insn_array *insn_array;
> > +
> > +       insn_array = bpf_map_area_alloc(size, NUMA_NO_NODE);
> > +       if (!insn_array)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       insn_array->ips = kcalloc(attr->max_entries, sizeof(long), GFP_KERNEL);
> > +       if (!insn_array->ips) {
> > +               insn_array_free(&insn_array->map);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       bpf_map_init_from_attr(&insn_array->map, attr);
> > +
> > +       mutex_init(&insn_array->state_mutex);
> > +       insn_array->state = INSN_ARRAY_STATE_FREE;
> > +
> > +       return &insn_array->map;
> > +}
> > +
> > +static int insn_array_get_next_key(struct bpf_map *map, void *key, void *next_key)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +       u32 index = key ? *(u32 *)key : U32_MAX;
> > +       u32 *next = (u32 *)next_key;
> > +
> > +       if (index >= insn_array->map.max_entries) {
> > +               *next = 0;
> > +               return 0;
> > +       }
> > +
> > +       if (index == insn_array->map.max_entries - 1)
> > +               return -ENOENT;
> > +
> > +       *next = index + 1;
> > +       return 0;
> > +}
> 
> Full copy paste of array_map_get_next_key() is a bit too much.
> Pls refactor array_map_get_next_key() to avoid casting
> to struct bpf_array, then such a helper can work for both maps.

Ok, thank, will do.

> > +
> > +static void *insn_array_lookup_elem(struct bpf_map *map, void *key)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +       u32 index = *(u32 *)key;
> > +
> > +       if (unlikely(index >= insn_array->map.max_entries))
> > +               return NULL;
> > +
> > +       return &insn_array->ptrs[index].user_value;
> > +}
> > +
> > +static long insn_array_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +       u32 index = *(u32 *)key;
> > +       struct bpf_insn_array_value val = {};
> > +       int err = 0;
> > +
> > +       if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> > +               return -EINVAL;
> 
> copy paste gone wrong. BPF_F_LOCK is not supported here.

thanks, removed

> > +
> > +       if (unlikely(index >= insn_array->map.max_entries))
> > +               return -E2BIG;
> > +
> > +       if (unlikely(map_flags & BPF_NOEXIST))
> > +               return -EEXIST;
> > +
> > +       /* No updates for maps in use */
> > +       if (!mutex_trylock(&insn_array->state_mutex))
> > +               return -EBUSY;
> 
> trylock ?!
> 
> If I'm reading it correctly
> check_map_func_compatibility() prevents usage of this helper
> from the prog, so this is syscall only,
> but trylock?!

See the comment below.

> > +
> > +       if (insn_array->state != INSN_ARRAY_STATE_FREE) {
> > +               err = -EBUSY;
> > +               goto unlock;
> > +       }
> > +
> > +       copy_map_value(map, &val, value);
> > +       if (val.jitted_off || val.xlated_off == INSN_DELETED) {
> > +               err = -EINVAL;
> > +               goto unlock;
> > +       }
> > +
> > +       insn_array->ptrs[index].orig_xlated_off = val.xlated_off;
> > +       insn_array->ptrs[index].user_value.xlated_off = val.xlated_off;
> > +
> > +unlock:
> > +       mutex_unlock(&insn_array->state_mutex);
> > +       return err;
> > +}
> > +
> > +static long insn_array_delete_elem(struct bpf_map *map, void *key)
> > +{
> > +       return -EINVAL;
> > +}
> > +
> > +static int insn_array_check_btf(const struct bpf_map *map,
> > +                             const struct btf *btf,
> > +                             const struct btf_type *key_type,
> > +                             const struct btf_type *value_type)
> > +{
> > +       if (!btf_type_is_i32(key_type))
> > +               return -EINVAL;
> > +
> > +       if (!btf_type_is_i64(value_type))
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> > +static u64 insn_array_mem_usage(const struct bpf_map *map)
> > +{
> > +       u64 extra_size = 0;
> > +
> > +       extra_size += sizeof(long) * map->max_entries; /* insn_array->ips */
> > +
> > +       return insn_array_alloc_size(map->max_entries) + extra_size;
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
> > +
> > +const struct bpf_map_ops insn_array_map_ops = {
> > +       .map_alloc_check = insn_array_alloc_check,
> > +       .map_alloc = insn_array_alloc,
> > +       .map_free = insn_array_free,
> > +       .map_get_next_key = insn_array_get_next_key,
> > +       .map_lookup_elem = insn_array_lookup_elem,
> > +       .map_update_elem = insn_array_update_elem,
> > +       .map_delete_elem = insn_array_delete_elem,
> > +       .map_check_btf = insn_array_check_btf,
> > +       .map_mem_usage = insn_array_mem_usage,
> > +       .map_btf_id = &insn_array_btf_ids[0],
> > +};
> > +
> > +static bool is_insn_array(const struct bpf_map *map)
> > +{
> > +       return map->map_type == BPF_MAP_TYPE_INSN_ARRAY;
> > +}
> > +
> > +static inline bool valid_offsets(const struct bpf_insn_array *insn_array,
> > +                                const struct bpf_prog *prog)
> > +{
> > +       u32 off;
> > +       int i;
> > +
> > +       for (i = 0; i < insn_array->map.max_entries; i++) {
> > +               off = insn_array->ptrs[i].orig_xlated_off;
> > +
> > +               if (off >= prog->len)
> > +                       return false;
> > +
> > +               if (off > 0) {
> > +                       if (prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
> > +                               return false;
> > +               }
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
> > +{
> > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > +       int i;
> > +
> > +       if (!valid_offsets(insn_array, prog))
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * There can be only one program using the map
> > +        */
> > +       mutex_lock(&insn_array->state_mutex);
> > +       if (insn_array->state != INSN_ARRAY_STATE_FREE) {
> > +               mutex_unlock(&insn_array->state_mutex);
> > +               return -EBUSY;
> > +       }
> > +       insn_array->state = INSN_ARRAY_STATE_INIT;
> > +       mutex_unlock(&insn_array->state_mutex);
> 
> only verifier calls this helpers, no?
> Why all the mutexes here and below ?
> All the mutexes is a big red flag to me.
> Will stop any further comments here.

Mutex came here from the future patch for static keys.
I will see how to rewrite this with just an atomic state.
(Try lock came from fixing some robot report which I struggle to find now...)

