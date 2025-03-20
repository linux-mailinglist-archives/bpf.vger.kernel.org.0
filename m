Return-Path: <bpf+bounces-54436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51FA6A0DE
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CA67AEAAB
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1A205AA5;
	Thu, 20 Mar 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX4VhdBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256031E3769
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457415; cv=none; b=dp9E2siSkNa3EQtGhsgKT0bCDCFXI3mnROfzU9F7RatIGhCu8Rwz05Whmm18sHi/cz9IUofdDfl//1w+T29mWcZmbglRXBKzEBh1WHWXgFEWJH2ikJcPXwa7cMk9DOiDWLnvSX4ozq0Q+UvOwglDJmr1FzZ3VdekJJaEqKV4vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457415; c=relaxed/simple;
	bh=nfPGN7G7DUOWi3/gOpJWF7NrEcfgCesLRPJC4pG4dwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I85a9c9E+6K/VoYT1foAoB6ikhdo3oBoczr/bqMf1qdfSuPMfZGx1txP+1RfEgDFwhaPWO+K3PEFRuiRb4I4Re6bQgacKKsNG8ppyagtzbEhDHsgb6xriIYoJ9mXWy1gpOZhztAD7cmuxyFgtrosvyQkpg8TzcMZeMwPLtLo3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX4VhdBp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22398e09e39so7324665ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742457412; x=1743062212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgOpIACVuvxlUpWleRmGxhbkUETJ3+iWNhHhz7O4QSg=;
        b=mX4VhdBpdnw/rrK31PNi7QBd0d6Nz3TAUp5H5oG75CAJyJ6hFICZfwx41O476OBK1h
         oYsR8HBbOBrcCRgr2aaMGsJw86MSBpg9EHwH50mldStEkxxb7EVYgfvtPAKNjGxhHD4D
         fLlfKbbPLHC4spsPUI29rd0tN4/65FFljQJ/nr3rsMpohf3ZaQsoeVmM1fFtryxuvVmg
         BNpPuhq6V4w/OjQQcanF1+/bEYyQQRyW7JKxCxRm2TY+1vMcD2HtlF8A8e8SnMkR82yU
         WPcG7LBI5MLrReWEvh08bFN4ehNKnaPd9vA1CLb+7OhGldvygk+fnGwPUJAvQ+3pPByz
         7cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742457412; x=1743062212;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgOpIACVuvxlUpWleRmGxhbkUETJ3+iWNhHhz7O4QSg=;
        b=QNo1O3vGYy72k4OwwQfFpdLldy/kio31ewr0HXHebn3XA37rHXIBqsDrq2+myQN2um
         SbYHwa38kKhW04xJCztdJ/XKWFogJSjn3TKRWvGwQLQbv/gP/f1a4VBmUbQ1pXLxd9w0
         at2qQ8b2zg59CNSV9LFEH5vaEMGGRBqnLOvtTqrAw3N0rnUmgg1agBwHAMbzv5Y/2kjP
         erbM8d4MXTlFohiBap95ZBOPLT7WsKMcSeCtXUJL3RNXyfLp4fmFANEJEedbkJcuNbD9
         G3A7uDTTuA8vUXdlDCR4Yc9esnWwdd0TrN0HSNzQs5QDwTdLYMEgHCbT3BP1DAfs4fkA
         X4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWFDbuaXVqYvBWmG88K0QlMhHqMT7ev0ygkf1dqfOTwonBb43qPX5ka+TQzlfZNaFzq54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznhl7CFWhEvkdfjy2a2kXLmL5pz/orM2kSYm4KjBP6swvJJwsN
	B7X5wEomgNy52yZngctboYThUZ2lDhuNL3NgkRmHUusLv4a7u9SS
X-Gm-Gg: ASbGncsZoqt9r/EKzezmQk1l2CtBDVftCVRtSywxtFKA4C7pSfuuj78KwRpgs92b5n9
	oyqcvNRYutR/kRNl2GZP+PQ6l4pGoSEXkHWNo4XBhL2kKreYiwhZksuTDXRD1CH0XfCbgln6MTN
	wCCJ29cVF1HS1+7Sgsln16iQCkfDsAXui8LpWJ6eZ64j+Yrn8TGX8q1UhK5A4l9mEfd0W7FJoum
	no+9P+EWq4hNxfLQMJ3db+CjuApvA108/vjsxBOhXdRUihjEbqAKb0b76y1+PZ4kqRoWNULQ7jG
	FItOe6o8UctCKeJnkj/HyMXLSwCElXeYPcPvCvu4Ff23qLhTEsuAG9M=
X-Google-Smtp-Source: AGHT+IEAQGk++hqDcxe6vcmHWRbhVVOAnte0LFmH0d9ntqRLoIgJcrFUKWu0SChDpbQzLDDzegMk5g==
X-Received: by 2002:a17:903:320e:b0:224:1eab:97b5 with SMTP id d9443c01a7336-2265ed68d5dmr38107055ad.1.1742457412105;
        Thu, 20 Mar 2025 00:56:52 -0700 (PDT)
Received: from [10.22.68.68] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5da2sm128380045ad.254.2025.03.20.00.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:56:51 -0700 (PDT)
Message-ID: <fde2bfd6-3856-4256-99df-65edad224942@gmail.com>
Date: Thu, 20 Mar 2025 15:56:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 02/14] bpf: add new map type: instructions
 set
Content-Language: en-US
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-3-aspsk@isovalent.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20250318143318.656785-3-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/3/25 22:33, Anton Protopopov wrote:
> On the bpf(BPF_PROG_LOAD) syscall a user-supplied BPF program is
> translated by the verifier into an "xlated" BPF program. During this
> process the original instruction offsets might be adjusted and/or
> individual instructions might be replaced by new sets of instructions,
> or deleted.  Add new BPF map type which is aimed to keep track of
> how, for a given program, original instructions were relocated during
> the verification.
> 
> A map of the BPF_MAP_TYPE_INSN_SET type is created with key and value
> size of 4 (size of u32). One such map can be used to track only one BPF
> program. To do so each element of the map should be initialized to point
> to an instruction offset within the program. Offsets within the map
> should be sorted. Before the program load such maps should be made frozen.
> After the verification xlated offsets can be read via the bpf(2) syscall.
> No BPF-side operations are allowed on the map.
> 
> If a tracked instruction is removed by the verifier, then the xlated
> offset is set to (u32)-1 which is considered to be too big for a valid
> BPF program offset.
> 
> If the verification process was unsuccessful, then the same map can
> be re-used to verify the program with a different log level. However,
> if the program was loaded fine, then such a map, being frozen in any
> case, can't be reused by other programs even after the program release.
> 
> Example. Consider the following original and xlated programs:
> 
>     Original prog:                      Xlated prog:
> 
>      0:  r1 = 0x0                        0: r1 = 0
>      1:  *(u32 *)(r10 - 0x4) = r1        1: *(u32 *)(r10 -4) = r1
>      2:  r2 = r10                        2: r2 = r10
>      3:  r2 += -0x4                      3: r2 += -4
>      4:  r1 = 0x0 ll                     4: r1 = map[id:88]
>      6:  call 0x1                        6: r1 += 272
>                                          7: r0 = *(u32 *)(r2 +0)
>                                          8: if r0 >= 0x1 goto pc+3
>                                          9: r0 <<= 3
>                                         10: r0 += r1
>                                         11: goto pc+1
>                                         12: r0 = 0
>      7:  r6 = r0                        13: r6 = r0
>      8:  if r6 == 0x0 goto +0x2         14: if r6 == 0x0 goto pc+4
>      9:  call 0x76                      15: r0 = 0xffffffff8d2079c0
>                                         17: r0 = *(u64 *)(r0 +0)
>     10:  *(u64 *)(r6 + 0x0) = r0        18: *(u64 *)(r6 +0) = r0
>     11:  r0 = 0x0                       19: r0 = 0x0
>     12:  exit                           20: exit
> 
> An instruction set map, containing, e.g., indexes [0,4,7,12]
> will be translated by the verifier to [0,4,13,20]. A map with
> index 5 (the middle of 16-byte instruction) or indexes greater than 12
> (outside the program boundaries) would be rejected.
> 
> The functionality provided by this patch will be extended in consequent
> patches to implement BPF Static Keys, indirect jumps, and indirect calls.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/bpf.h            |  11 ++
>  include/linux/bpf_types.h      |   1 +
>  include/linux/bpf_verifier.h   |   2 +
>  include/uapi/linux/bpf.h       |   1 +
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/bpf_insn_set.c      | 288 +++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |   1 +
>  kernel/bpf/verifier.c          |  50 ++++++
>  tools/include/uapi/linux/bpf.h |   1 +
>  9 files changed, 356 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/bpf_insn_set.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0d7b70124d81..0b5f4d4745ee 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3554,4 +3554,15 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>  	return prog->aux->func_idx != 0;
>  }
>  
> +int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
> +void bpf_insn_set_ready(struct bpf_map *map);
> +void bpf_insn_set_release(struct bpf_map *map);
> +void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
> +void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> +
> +struct bpf_insn_ptr {
> +	u32 orig_xlated_off;
> +	u32 xlated_off;
> +};
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fa78f49d4a9a..01df0e47a3f7 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -133,6 +133,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_SET, insn_set_map_ops)
>  
>  BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d6cfc4ee6820..f694c08f39d1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -722,8 +722,10 @@ struct bpf_verifier_env {
>  	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
>  	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
>  	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
> +	struct bpf_map *insn_set_maps[MAX_USED_MAPS]; /* array of INSN_SET map's to be relocated */
>  	u32 used_map_cnt;		/* number of used maps */
>  	u32 used_btf_cnt;		/* number of used BTF objects */
> +	u32 insn_set_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_SET */
>  	u32 id_gen;			/* used to generate unique reg IDs */
>  	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
>  	int exception_callback_subprog;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1388db053d9e..b8e588ed6406 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1013,6 +1013,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_USER_RINGBUF,
>  	BPF_MAP_TYPE_CGRP_STORAGE,
>  	BPF_MAP_TYPE_ARENA,
> +	BPF_MAP_TYPE_INSN_SET,
>  	__MAX_BPF_MAP_TYPE
>  };
>  
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 410028633621..a4399089557b 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -9,7 +9,7 @@ CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
>  obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
> -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_set.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>  obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>  obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
> diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
> new file mode 100644
> index 000000000000..e788dd7109b1
> --- /dev/null
> +++ b/kernel/bpf/bpf_insn_set.c
> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bpf.h>
> +
> +#define MAX_ISET_ENTRIES 128
> +
> +struct bpf_insn_set {
> +	struct bpf_map map;
> +	struct mutex state_mutex;
> +	int state;
> +	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
> +};
> +
> +enum {
> +	INSN_SET_STATE_FREE = 0,
> +	INSN_SET_STATE_INIT,
> +	INSN_SET_STATE_READY,
> +};
> +
> +#define cast_insn_set(MAP_PTR) \
> +	container_of(MAP_PTR, struct bpf_insn_set, map)
> +
> +static inline u32 insn_set_alloc_size(u32 max_entries)
> +{
> +	const u32 base_size = sizeof(struct bpf_insn_set);
> +	const u32 entry_size = sizeof(struct bpf_insn_ptr);
> +
> +	return base_size + entry_size * max_entries;
> +}
> +
> +static int insn_set_alloc_check(union bpf_attr *attr)
> +{
> +	if (attr->max_entries == 0 ||
> +	    attr->key_size != 4 ||
> +	    attr->value_size != 4 ||
> +	    attr->map_flags != 0)
> +		return -EINVAL;
> +
> +	if (attr->max_entries > MAX_ISET_ENTRIES)
> +		return -E2BIG;
> +
> +	return 0;
> +}
> +
> +static struct bpf_map *insn_set_alloc(union bpf_attr *attr)
> +{
> +	u64 size = insn_set_alloc_size(attr->max_entries);
> +	struct bpf_insn_set *insn_set;
> +
> +	insn_set = bpf_map_area_alloc(size, NUMA_NO_NODE);
> +	if (!insn_set)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bpf_map_init_from_attr(&insn_set->map, attr);
> +
> +	mutex_init(&insn_set->state_mutex);> +	insn_set->state = INSN_SET_STATE_FREE;
> +
> +	return &insn_set->map;
> +}
> +
> +static int insn_set_get_next_key(struct bpf_map *map, void *key, void *next_key)
> +{
> +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> +	u32 index = key ? *(u32 *)key : U32_MAX;
> +	u32 *next = (u32 *)next_key;
> +
> +	if (index >= insn_set->map.max_entries) {
> +		*next = 0;
> +		return 0;
> +	}
> +
> +	if (index == insn_set->map.max_entries - 1)
> +		return -ENOENT;
> +
> +	*next = index + 1;
> +	return 0;
> +}
> +
> +static void *insn_set_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> +	u32 index = *(u32 *)key;
> +
> +	if (unlikely(index >= insn_set->map.max_entries))
> +		return NULL;
> +
> +	return &insn_set->ptrs[index].xlated_off;
> +}
> +
> +static long insn_set_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
> +{
> +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> +	u32 index = *(u32 *)key;
> +
> +	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
> +		return -EINVAL;
> +
> +	if (unlikely(index >= insn_set->map.max_entries))
> +		return -E2BIG;
> +
> +	if (unlikely(map_flags & BPF_NOEXIST))
> +		return -EEXIST;
> +
> +	copy_map_value(map, &insn_set->ptrs[index].orig_xlated_off, value);
> +	insn_set->ptrs[index].xlated_off = insn_set->ptrs[index].orig_xlated_off;
> +
> +	return 0;
> +}
> +
> +static long insn_set_delete_elem(struct bpf_map *map, void *key)
> +{
> +	return -EINVAL;
> +}
> +
> +static int insn_set_check_btf(const struct bpf_map *map,
> +			      const struct btf *btf,
> +			      const struct btf_type *key_type,
> +			      const struct btf_type *value_type)
> +{
> +	u32 int_data;
> +
> +	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
> +		return -EINVAL;
> +
> +	if (BTF_INFO_KIND(value_type->info) != BTF_KIND_INT)
> +		return -EINVAL;
> +
> +	int_data = *(u32 *)(key_type + 1);
> +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> +		return -EINVAL;
> +
> +	int_data = *(u32 *)(value_type + 1);
> +	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void insn_set_free(struct bpf_map *map)
> +{
> +	struct bpf_insn_set *insn_set = cast_insn_set(map);
> +
> +	bpf_map_area_free(insn_set);
> +}
> +
> +static u64 insn_set_mem_usage(const struct bpf_map *map)
> +{
> +	return insn_set_alloc_size(map->max_entries);
> +}
> +
> +BTF_ID_LIST_SINGLE(insn_set_btf_ids, struct, bpf_insn_set)
> +
> +const struct bpf_map_ops insn_set_map_ops = {
> +	.map_alloc_check = insn_set_alloc_check,
> +	.map_alloc = insn_set_alloc,
> +	.map_free = insn_set_free,
> +	.map_get_next_key = insn_set_get_next_key,
> +	.map_lookup_elem = insn_set_lookup_elem,
> +	.map_update_elem = insn_set_update_elem,
> +	.map_delete_elem = insn_set_delete_elem,
> +	.map_check_btf = insn_set_check_btf,
> +	.map_mem_usage = insn_set_mem_usage,
> +	.map_btf_id = &insn_set_btf_ids[0],
> +};
> +
> +static inline bool is_frozen(struct bpf_map *map)
> +{
> +	bool ret = true;
> +
> +	mutex_lock(&map->freeze_mutex);
> +	if (!map->frozen)
> +		ret = false;
> +	mutex_unlock(&map->freeze_mutex);> +
> +	return ret;
> +}

It would be better to use guard(mutex) here:

static inline bool is_frozen(struct bpf_map *map)
{
	guard(mutex)(&map->freeze_mutex);
	return map->frozen;
}

Thanks,
Leon

> +
> +static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
> +				 const struct bpf_prog *prog)
> +{
> +	u32 off, prev_off;
> +	int i;
> +
> +	for (i = 0; i < insn_set->map.max_entries; i++) {
> +		off = insn_set->ptrs[i].orig_xlated_off;
> +
> +		if (off >= prog->len)
> +			return false;
> +
> +		if (off > 0) {
> +			if (prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
> +				return false;
> +		}
> +
> +		if (i > 0) {
> +			prev_off = insn_set->ptrs[i-1].orig_xlated_off;
> +			if (off <= prev_off)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
[...]


