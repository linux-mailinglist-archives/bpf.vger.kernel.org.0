Return-Path: <bpf+bounces-54438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B8A6A2AB
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607618A2043
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194A212B3E;
	Thu, 20 Mar 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="A3rojX/C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0BAD23
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463039; cv=none; b=IXqkQ9+JLJ6D1HnM8LjIWclSx2p0fU9MWwBKLB5213Caj4JseC6sO6P1UZ5P9egz35ypxFFFmUfSqQegjeYqVWz/xYwKctMEu8DZtHnYVnNN8EMtxR3lELtTcwZ+1XD313YPHbdfIDiiHy7iBfdwiSWCzU1eX5Jg+abKGeTFKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463039; c=relaxed/simple;
	bh=Mofkiav6yFoSQCTnxk2LuHkh3wS1hx3IN+7tfsCCQF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfC2WtHvY+toMvykelYhVOmjhRC+23M8BNgWckrBHW+LPpwBjV7L9FQApiOil5h4KZg14LMVfI0T4pNjVkaHpKNSg9oP9Rlrp4C8iIksRidn+0SAeaaxWtivqB+VZcnBlPTqCo2XQCScNG2Fii+H+iNjKpL5eXbEeiEC/yM454s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=A3rojX/C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914a5def6bso286401f8f.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742463035; x=1743067835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98L3fDuZZquL10BIvehM+gzv1LA+IyLxvfu2+dwUPoU=;
        b=A3rojX/CkzYuIS+1TiHjr0zvd+rCKrn/onJrvbxTYq1XdHPI9sztmJNRgBHJAZ9lBl
         p51InWw+Rd/VoK4SL4Thyqz3qvy4ju2C1sTpZf5em1WbCKBjPboefq7F7UfGSTTdPmj7
         tdfl4orVyEiCENx3+T8AbKr1tKXd4p+m8iwprsLQiZA6KA1XwDIK/CwAz1fEUsJg+z9M
         NPvCWHiZC8op4A/ZgXjV4Qrmt2gHpoc0Bo4JiQ9V4U32lLdfS8VOatl7TpyOLCObFec0
         pRWe7VeWWmMIC36dWApuejhnaHNdOjwRK58xvSpp+iTrJpIpUjWdTuFNnYwVESa/CslV
         BMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742463035; x=1743067835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98L3fDuZZquL10BIvehM+gzv1LA+IyLxvfu2+dwUPoU=;
        b=M6uUV0r/7veS/OkACuDbS9bOzHjHgWX1UnM/PcIIMMNkk78RbVSVZ5Y+pf8H0m2CXS
         v3xbAlnx0vhVG2oi+y0D2ALcx/m3A6jgAkctDzuWkhdnOi/33MTqwa12mzpM2iHUsJwv
         xt0ghtiFp9hqfuGSXE0GjYeoOnjHE7BH+Ni10/uzWV5wkC9L7C/HXCULfJ95D1afS5Sf
         9TnXvrW5v9Xgi8sSnM9YSPCyKJxA7RUoAaAKf3RMOsj8tQmnRp155qFE1v+fl/WYxN+K
         YcI9dF+DIG8IDBsXm8aKy72Cc9R4NRalhJPMY8ZVhsVKlbDd5ndhwvJs6mLxCfdbXTAu
         el1Q==
X-Gm-Message-State: AOJu0YycAk1z/WNW43NFB/8xR2ylGBwS5+iV+8fu4TzZcU4BrXU1OZOP
	29bqQRgIcG3E+wxgv+F+6kLg9ivWGTTdIRFJqUEU9kxa+iKI5xhG9xVaa2ryLt7N6pUEEy1r6d7
	D
X-Gm-Gg: ASbGncuAkVmDmNNMwyvGsg1Vsp9mpC/5J7IOExmEGDdw+MsZLYtOWabfQBLU/0BxWzN
	Zg/SmQJfKIYndbE3YD3yshEfHZxwycncVliuh88P04aVGJ+c+p+aisuGeCmy2vm3pJ1VkEa6pHL
	61tyW+sFyP4ncztia5ijnu4JXlhvr9qJxf21VukPc4FTKfSQp/uB1NmAELOumB+C/48Q+Gd25uK
	pwv6+ifiEwoK5ltXjXR8tVnZCbaJkStGhQ8kAIIB5xFbGNQmQA3qIEe4KmQcbP+3AFiM1oE5aR0
	JbJoDNp7rh0NOvUElE8ZOuRKuiLXhnoTmoGX2tpVfjFBEyM5
X-Google-Smtp-Source: AGHT+IFZu5A3iQMnzjnaDSqU33BPSIx4kltXDh1x9l8H/97ahCE+yq/MM/LFkIS4//kaJvql9Yy2fA==
X-Received: by 2002:a5d:64c6:0:b0:391:23de:b1b4 with SMTP id ffacd0b85a97d-39973b08f87mr5082052f8f.45.1742463035205;
        Thu, 20 Mar 2025 02:30:35 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a3dsm23441666f8f.74.2025.03.20.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 02:30:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:34:13 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH bpf-next 02/14] bpf: add new map type: instructions
 set
Message-ID: <Z9vhFcfmad4ujpSf@mail.gmail.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-3-aspsk@isovalent.com>
 <fde2bfd6-3856-4256-99df-65edad224942@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde2bfd6-3856-4256-99df-65edad224942@gmail.com>

On 25/03/20 03:56PM, Leon Hwang wrote:
> 
> 
> On 18/3/25 22:33, Anton Protopopov wrote:
> > On the bpf(BPF_PROG_LOAD) syscall a user-supplied BPF program is
> > translated by the verifier into an "xlated" BPF program. During this
> > process the original instruction offsets might be adjusted and/or
> > individual instructions might be replaced by new sets of instructions,
> > or deleted.  Add new BPF map type which is aimed to keep track of
> > how, for a given program, original instructions were relocated during
> > the verification.
> > 
> > A map of the BPF_MAP_TYPE_INSN_SET type is created with key and value
> > size of 4 (size of u32). One such map can be used to track only one BPF
> > program. To do so each element of the map should be initialized to point
> > to an instruction offset within the program. Offsets within the map
> > should be sorted. Before the program load such maps should be made frozen.
> > After the verification xlated offsets can be read via the bpf(2) syscall.
> > No BPF-side operations are allowed on the map.
> > 
> > If a tracked instruction is removed by the verifier, then the xlated
> > offset is set to (u32)-1 which is considered to be too big for a valid
> > BPF program offset.
> > 
> > If the verification process was unsuccessful, then the same map can
> > be re-used to verify the program with a different log level. However,
> > if the program was loaded fine, then such a map, being frozen in any
> > case, can't be reused by other programs even after the program release.
> > 
> > Example. Consider the following original and xlated programs:
> > 
> >     Original prog:                      Xlated prog:
> > 
> >      0:  r1 = 0x0                        0: r1 = 0
> >      1:  *(u32 *)(r10 - 0x4) = r1        1: *(u32 *)(r10 -4) = r1
> >      2:  r2 = r10                        2: r2 = r10
> >      3:  r2 += -0x4                      3: r2 += -4
> >      4:  r1 = 0x0 ll                     4: r1 = map[id:88]
> >      6:  call 0x1                        6: r1 += 272
> >                                          7: r0 = *(u32 *)(r2 +0)
> >                                          8: if r0 >= 0x1 goto pc+3
> >                                          9: r0 <<= 3
> >                                         10: r0 += r1
> >                                         11: goto pc+1
> >                                         12: r0 = 0
> >      7:  r6 = r0                        13: r6 = r0
> >      8:  if r6 == 0x0 goto +0x2         14: if r6 == 0x0 goto pc+4
> >      9:  call 0x76                      15: r0 = 0xffffffff8d2079c0
> >                                         17: r0 = *(u64 *)(r0 +0)
> >     10:  *(u64 *)(r6 + 0x0) = r0        18: *(u64 *)(r6 +0) = r0
> >     11:  r0 = 0x0                       19: r0 = 0x0
> >     12:  exit                           20: exit
> > 
> > An instruction set map, containing, e.g., indexes [0,4,7,12]
> > will be translated by the verifier to [0,4,13,20]. A map with
> > index 5 (the middle of 16-byte instruction) or indexes greater than 12
> > (outside the program boundaries) would be rejected.
> > 
> > The functionality provided by this patch will be extended in consequent
> > patches to implement BPF Static Keys, indirect jumps, and indirect calls.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > ---
> >  include/linux/bpf.h            |  11 ++
> >  include/linux/bpf_types.h      |   1 +
> >  include/linux/bpf_verifier.h   |   2 +
> >  include/uapi/linux/bpf.h       |   1 +
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/bpf_insn_set.c      | 288 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/syscall.c           |   1 +
> >  kernel/bpf/verifier.c          |  50 ++++++
> >  tools/include/uapi/linux/bpf.h |   1 +
> >  9 files changed, 356 insertions(+), 1 deletion(-)
> >  create mode 100644 kernel/bpf/bpf_insn_set.c
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 0d7b70124d81..0b5f4d4745ee 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3554,4 +3554,15 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
> >  	return prog->aux->func_idx != 0;
> >  }
> >  
> > +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
> > +void bpf_insn_set_ready(struct bpf_map *map);
> > +void bpf_insn_set_release(struct bpf_map *map);
> > +void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> > +void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> > +
> > +struct bpf_insn_ptr {
> > +	u32 orig_xlated_off;
> > +	u32 xlated_off;
> > +};
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index fa78f49d4a9a..01df0e47a3f7 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -133,6 +133,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_SET, insn_set_map_ops)
> >  
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> >  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index d6cfc4ee6820..f694c08f39d1 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -722,8 +722,10 @@ struct bpf_verifier_env {
> >  	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
> >  	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
> >  	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
> > +	struct bpf_map *insn_set_maps[MAX_USED_MAPS]; /* array of INSN_SET map's to be relocated */
> >  	u32 used_map_cnt;		/* number of used maps */
> >  	u32 used_btf_cnt;		/* number of used BTF objects */
> > +	u32 insn_set_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_SET */
> >  	u32 id_gen;			/* used to generate unique reg IDs */
> >  	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
> >  	int exception_callback_subprog;
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1388db053d9e..b8e588ed6406 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1013,6 +1013,7 @@ enum bpf_map_type {
> >  	BPF_MAP_TYPE_USER_RINGBUF,
> >  	BPF_MAP_TYPE_CGRP_STORAGE,
> >  	BPF_MAP_TYPE_ARENA,
> > +	BPF_MAP_TYPE_INSN_SET,
> >  	__MAX_BPF_MAP_TYPE
> >  };
> >  
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 410028633621..a4399089557b 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -9,7 +9,7 @@ CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
> >  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
> >  obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> > -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> > +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_set.o
> >  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> >  obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
> >  obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
> > diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> > new file mode 100644
> > index 000000000000..e788dd7109b1
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_insn_set.c
> > @@ -0,0 +1,288 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/bpf.h>
> > +
> > +#define MAX_ISET_ENTRIES 128
> > +
> > +struct bpf_insn_set {
> > +	struct bpf_map map;
> > +	struct mutex state_mutex;
> > +	int state;
> > +	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> > +};
> > +
> > +enum {
> > +	INSN_SET_STATE_FREE = 0,
> > +	INSN_SET_STATE_INIT,
> > +	INSN_SET_STATE_READY,
> > +};
> > +
> > +#define cast_insn_set(MAP_PTR) \
> > +	container_of(MAP_PTR, struct bpf_insn_set, map)
> > +
> > +static inline u32 insn_set_alloc_size(u32 max_entries)
> > +{
> > +	const u32 base_size = sizeof(struct bpf_insn_set);
> > +	const u32 entry_size = sizeof(struct bpf_insn_ptr);
> > +
> > +	return base_size + entry_size * max_entries;
> > +}
> > +
> > +static int insn_set_alloc_check(union bpf_attr *attr)
> > +{
> > +	if (attr->max_entries == 0 ||
> > +	    attr->key_size != 4 ||
> > +	    attr->value_size != 4 ||
> > +	    attr->map_flags != 0)
> > +		return -EINVAL;
> > +
> > +	if (attr->max_entries > MAX_ISET_ENTRIES)
> > +		return -E2BIG;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct bpf_map *insn_set_alloc(union bpf_attr *attr)
> > +{
> > +	u64 size = insn_set_alloc_size(attr->max_entries);
> > +	struct bpf_insn_set *insn_set;
> > +
> > +	insn_set = bpf_map_area_alloc(size, NUMA_NO_NODE);
> > +	if (!insn_set)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	bpf_map_init_from_attr(&insn_set->map, attr);
> > +
> > +	mutex_init(&insn_set->state_mutex);> +	insn_set->state = INSN_SET_STATE_FREE;
> > +
> > +	return &insn_set->map;
> > +}
> > +
> > +static int insn_set_get_next_key(struct bpf_map *map, void *key, void *next_key)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +	u32 index = key ? *(u32 *)key : U32_MAX;
> > +	u32 *next = (u32 *)next_key;
> > +
> > +	if (index >= insn_set->map.max_entries) {
> > +		*next = 0;
> > +		return 0;
> > +	}
> > +
> > +	if (index == insn_set->map.max_entries - 1)
> > +		return -ENOENT;
> > +
> > +	*next = index + 1;
> > +	return 0;
> > +}
> > +
> > +static void *insn_set_lookup_elem(struct bpf_map *map, void *key)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +	u32 index = *(u32 *)key;
> > +
> > +	if (unlikely(index >= insn_set->map.max_entries))
> > +		return NULL;
> > +
> > +	return &insn_set->ptrs[index].xlated_off;
> > +}
> > +
> > +static long insn_set_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +	u32 index = *(u32 *)key;
> > +
> > +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> > +		return -EINVAL;
> > +
> > +	if (unlikely(index >= insn_set->map.max_entries))
> > +		return -E2BIG;
> > +
> > +	if (unlikely(map_flags & BPF_NOEXIST))
> > +		return -EEXIST;
> > +
> > +	copy_map_value(map, &insn_set->ptrs[index].orig_xlated_off, value);
> > +	insn_set->ptrs[index].xlated_off = insn_set->ptrs[index].orig_xlated_off;
> > +
> > +	return 0;
> > +}
> > +
> > +static long insn_set_delete_elem(struct bpf_map *map, void *key)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +static int insn_set_check_btf(const struct bpf_map *map,
> > +			      const struct btf *btf,
> > +			      const struct btf_type *key_type,
> > +			      const struct btf_type *value_type)
> > +{
> > +	u32 int_data;
> > +
> > +	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
> > +		return -EINVAL;
> > +
> > +	if (BTF_INFO_KIND(value_type->info) != BTF_KIND_INT)
> > +		return -EINVAL;
> > +
> > +	int_data = *(u32 *)(key_type + 1);
> > +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> > +		return -EINVAL;
> > +
> > +	int_data = *(u32 *)(value_type + 1);
> > +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static void insn_set_free(struct bpf_map *map)
> > +{
> > +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> > +
> > +	bpf_map_area_free(insn_set);
> > +}
> > +
> > +static u64 insn_set_mem_usage(const struct bpf_map *map)
> > +{
> > +	return insn_set_alloc_size(map->max_entries);
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(insn_set_btf_ids, struct, bpf_insn_set)
> > +
> > +const struct bpf_map_ops insn_set_map_ops = {
> > +	.map_alloc_check = insn_set_alloc_check,
> > +	.map_alloc = insn_set_alloc,
> > +	.map_free = insn_set_free,
> > +	.map_get_next_key = insn_set_get_next_key,
> > +	.map_lookup_elem = insn_set_lookup_elem,
> > +	.map_update_elem = insn_set_update_elem,
> > +	.map_delete_elem = insn_set_delete_elem,
> > +	.map_check_btf = insn_set_check_btf,
> > +	.map_mem_usage = insn_set_mem_usage,
> > +	.map_btf_id = &insn_set_btf_ids[0],
> > +};
> > +
> > +static inline bool is_frozen(struct bpf_map *map)
> > +{
> > +	bool ret = true;
> > +
> > +	mutex_lock(&map->freeze_mutex);
> > +	if (!map->frozen)
> > +		ret = false;
> > +	mutex_unlock(&map->freeze_mutex);> +
> > +	return ret;
> > +}
> 
> It would be better to use guard(mutex) here:
> 
> static inline bool is_frozen(struct bpf_map *map)
> {
> 	guard(mutex)(&map->freeze_mutex);
> 	return map->frozen;
> }

Thanks! Patchded.

> Thanks,
> Leon
> 
> > +
> > +static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
> > +				 const struct bpf_prog *prog)
> > +{
> > +	u32 off, prev_off;
> > +	int i;
> > +
> > +	for (i = 0; i < insn_set->map.max_entries; i++) {
> > +		off = insn_set->ptrs[i].orig_xlated_off;
> > +
> > +		if (off >= prog->len)
> > +			return false;
> > +
> > +		if (off > 0) {
> > +			if (prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
> > +				return false;
> > +		}
> > +
> > +		if (i > 0) {
> > +			prev_off = insn_set->ptrs[i-1].orig_xlated_off;
> > +			if (off <= prev_off)
> > +				return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> [...]
> 

