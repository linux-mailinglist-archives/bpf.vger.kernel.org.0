Return-Path: <bpf+bounces-54312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A152FA6765E
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1033B3464
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7420E307;
	Tue, 18 Mar 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="CcVaQ0E+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8E20E016
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308192; cv=none; b=VE8Nh+fCvH+92iWmcQyMD4EGlzsEYLnWrhC8VemfpycT0qDm8kCfz8iTqUeRbsUtz0fOVTXyssRmGPIkzF592gcudnp6GWsV2y/TdmC4BDvPuaBvZLt6kLrzRj8xJqJ8YD+pgTbrOikHYn/M5aZhOhhwVsR6RKLmNCezT8HnpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308192; c=relaxed/simple;
	bh=DTN8BmBHrA/3QbQoASHTNbC5Ec7yCUEv6Es6bBmDg3k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQ+nGjenTAKlKy76mwaog5tkO0pdT81T4A638jMk4uk0LP/NCX5urT0yXSyRGCRE6D00AwUtmLMxzcGJ+Mx8novyZQQiVrvHHpkKjM8neT3GCE2zdz2iwj3dC9zGPUmU8Jt+db1Bf1CHr0EoW0ojEvKDNxoj6azq606Xu4liB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=CcVaQ0E+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4716526f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308188; x=1742912988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTsn2YKpsf2SBdKCterEG/2gkYF+hvstZeEhLUh7XbI=;
        b=CcVaQ0E+37p96Oucb2eWQkM8zd+HHviytEfqnvdYEwv5G1ruKS0IMVZ8P+/oAoLu9F
         45OMr2ngu97CTFZDCbYLYh9dXuXa3MCHY9qw8quS7AzYcN2W2nA8OM3kxdeuc/KYyalH
         TKqrgWyYhPG5PEIk6htCmYgMCxr2biYZat5js5ULwWJH/eAwNr40Pe2+XCGum9oukNfx
         u827FexG2q4o7nmi/EGdUMw21oTt5CbEAVjPu0I5P2TfH9qPpadD6gWd7aXZgBAy/yBV
         qZt15+pLmhXhv21OFU354aUHQvjgkDAPOTPt/xMbTtK1osNaLcFx6JQ2UnqT5k0iC5o6
         sQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308188; x=1742912988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTsn2YKpsf2SBdKCterEG/2gkYF+hvstZeEhLUh7XbI=;
        b=dDoRMGLMI7uwvKcSm4GACFcPnENi1Y85Q6wGp9+cySFr3FG7tjnOo41cgSXN8Z/Tu0
         J1LMyelcxrrJjYuAeUMsImVzaUOqrdqUxkYchaoyPvWn6bvA54LkxK6JeXWBipNFo492
         +HXHoWEv/WVJ5XZrDfV+y1hV+kpu5dhl3onXM7HpyU73CFaRs8AK8iS0NeT23Wd+esGy
         igZb+BhLGbzIdFIQlhO6tR0eg4iFqQFnz7dRoIflen7MmP8Ee7KHg2cd0ZxIPrsYEVxW
         igtYZ9v2mmoTskHMysSPz1u24g6fLV++ljITrOxxE9mTR8kxmIzG4BJQiWymrToZG6vl
         Zl8A==
X-Gm-Message-State: AOJu0YzXTeEValtmjsFzTfrgY7ggTPDgJVX15dOu/houLR3M9gbIYF48
	D6s7xGmRHKwD1tpgzRJyHcjD7fX6Hh6CQomNNZVHL/vtFQR21RcIIr7UK1IthQwcvys2NCGFdh0
	T
X-Gm-Gg: ASbGncsM56Fyh/39Grpyp3EWlCf2x9nyRnpjyQnyCXJPtCyhLH7LJUrSax3JYuoV1E4
	hkOVEkXuLgwEwgExahc2ertAlJhH5xekjaIPXQbel2+IY47GfZ9ZggY94UrTlRwHrCX9ylhFOp3
	J1yBgK8kGNANakm/uhw6H5IG9SpFyJ09Jw/9geWgn4Q8FylKjbKhpuNokWlClYYwIyLpCrlgwD/
	mBxI9qvtT6ZsEnBMt0MrzJRR69Vk2QMV68qY/4SJ+EoewUC2OBJJZkwGsO2OxrwuhX+RBCS4ZVo
	sXJa5TIX+b+A6xrzURoz6xmsmxELc6iJtrML1W+KICv1t0X4OSjlHWkFew==
X-Google-Smtp-Source: AGHT+IFa/eeZwUfAhZLNF2flBjtUlhgp285UwrcVWRv9gYh+14xKsBqamcR0K4jTuc/H4GHm2J42dg==
X-Received: by 2002:a5d:47aa:0:b0:391:2c0c:1247 with SMTP id ffacd0b85a97d-3971dce077amr16196642f8f.1.1742308188124;
        Tue, 18 Mar 2025 07:29:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:47 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 02/14] bpf: add new map type: instructions set
Date: Tue, 18 Mar 2025 14:33:06 +0000
Message-Id: <20250318143318.656785-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the bpf(BPF_PROG_LOAD) syscall a user-supplied BPF program is
translated by the verifier into an "xlated" BPF program. During this
process the original instruction offsets might be adjusted and/or
individual instructions might be replaced by new sets of instructions,
or deleted.  Add new BPF map type which is aimed to keep track of
how, for a given program, original instructions were relocated during
the verification.

A map of the BPF_MAP_TYPE_INSN_SET type is created with key and value
size of 4 (size of u32). One such map can be used to track only one BPF
program. To do so each element of the map should be initialized to point
to an instruction offset within the program. Offsets within the map
should be sorted. Before the program load such maps should be made frozen.
After the verification xlated offsets can be read via the bpf(2) syscall.
No BPF-side operations are allowed on the map.

If a tracked instruction is removed by the verifier, then the xlated
offset is set to (u32)-1 which is considered to be too big for a valid
BPF program offset.

If the verification process was unsuccessful, then the same map can
be re-used to verify the program with a different log level. However,
if the program was loaded fine, then such a map, being frozen in any
case, can't be reused by other programs even after the program release.

Example. Consider the following original and xlated programs:

    Original prog:                      Xlated prog:

     0:  r1 = 0x0                        0: r1 = 0
     1:  *(u32 *)(r10 - 0x4) = r1        1: *(u32 *)(r10 -4) = r1
     2:  r2 = r10                        2: r2 = r10
     3:  r2 += -0x4                      3: r2 += -4
     4:  r1 = 0x0 ll                     4: r1 = map[id:88]
     6:  call 0x1                        6: r1 += 272
                                         7: r0 = *(u32 *)(r2 +0)
                                         8: if r0 >= 0x1 goto pc+3
                                         9: r0 <<= 3
                                        10: r0 += r1
                                        11: goto pc+1
                                        12: r0 = 0
     7:  r6 = r0                        13: r6 = r0
     8:  if r6 == 0x0 goto +0x2         14: if r6 == 0x0 goto pc+4
     9:  call 0x76                      15: r0 = 0xffffffff8d2079c0
                                        17: r0 = *(u64 *)(r0 +0)
    10:  *(u64 *)(r6 + 0x0) = r0        18: *(u64 *)(r6 +0) = r0
    11:  r0 = 0x0                       19: r0 = 0x0
    12:  exit                           20: exit

An instruction set map, containing, e.g., indexes [0,4,7,12]
will be translated by the verifier to [0,4,13,20]. A map with
index 5 (the middle of 16-byte instruction) or indexes greater than 12
(outside the program boundaries) would be rejected.

The functionality provided by this patch will be extended in consequent
patches to implement BPF Static Keys, indirect jumps, and indirect calls.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h            |  11 ++
 include/linux/bpf_types.h      |   1 +
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_insn_set.c      | 288 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   1 +
 kernel/bpf/verifier.c          |  50 ++++++
 tools/include/uapi/linux/bpf.h |   1 +
 9 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_insn_set.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d7b70124d81..0b5f4d4745ee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3554,4 +3554,15 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
+void bpf_insn_set_ready(struct bpf_map *map);
+void bpf_insn_set_release(struct bpf_map *map);
+void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+
+struct bpf_insn_ptr {
+	u32 orig_xlated_off;
+	u32 xlated_off;
+};
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..01df0e47a3f7 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -133,6 +133,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_SET, insn_set_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d6cfc4ee6820..f694c08f39d1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -722,8 +722,10 @@ struct bpf_verifier_env {
 	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
 	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
+	struct bpf_map *insn_set_maps[MAX_USED_MAPS]; /* array of INSN_SET map's to be relocated */
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
+	u32 insn_set_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_SET */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	int exception_callback_subprog;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1388db053d9e..b8e588ed6406 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_SET,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 410028633621..a4399089557b 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -9,7 +9,7 @@ CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_set.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
new file mode 100644
index 000000000000..e788dd7109b1
--- /dev/null
+++ b/kernel/bpf/bpf_insn_set.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+
+#define MAX_ISET_ENTRIES 128
+
+struct bpf_insn_set {
+	struct bpf_map map;
+	struct mutex state_mutex;
+	int state;
+	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
+};
+
+enum {
+	INSN_SET_STATE_FREE = 0,
+	INSN_SET_STATE_INIT,
+	INSN_SET_STATE_READY,
+};
+
+#define cast_insn_set(MAP_PTR) \
+	container_of(MAP_PTR, struct bpf_insn_set, map)
+
+static inline u32 insn_set_alloc_size(u32 max_entries)
+{
+	const u32 base_size = sizeof(struct bpf_insn_set);
+	const u32 entry_size = sizeof(struct bpf_insn_ptr);
+
+	return base_size + entry_size * max_entries;
+}
+
+static int insn_set_alloc_check(union bpf_attr *attr)
+{
+	if (attr->max_entries == 0 ||
+	    attr->key_size != 4 ||
+	    attr->value_size != 4 ||
+	    attr->map_flags != 0)
+		return -EINVAL;
+
+	if (attr->max_entries > MAX_ISET_ENTRIES)
+		return -E2BIG;
+
+	return 0;
+}
+
+static struct bpf_map *insn_set_alloc(union bpf_attr *attr)
+{
+	u64 size = insn_set_alloc_size(attr->max_entries);
+	struct bpf_insn_set *insn_set;
+
+	insn_set = bpf_map_area_alloc(size, NUMA_NO_NODE);
+	if (!insn_set)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&insn_set->map, attr);
+
+	mutex_init(&insn_set->state_mutex);
+	insn_set->state = INSN_SET_STATE_FREE;
+
+	return &insn_set->map;
+}
+
+static int insn_set_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	u32 index = key ? *(u32 *)key : U32_MAX;
+	u32 *next = (u32 *)next_key;
+
+	if (index >= insn_set->map.max_entries) {
+		*next = 0;
+		return 0;
+	}
+
+	if (index == insn_set->map.max_entries - 1)
+		return -ENOENT;
+
+	*next = index + 1;
+	return 0;
+}
+
+static void *insn_set_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	u32 index = *(u32 *)key;
+
+	if (unlikely(index >= insn_set->map.max_entries))
+		return NULL;
+
+	return &insn_set->ptrs[index].xlated_off;
+}
+
+static long insn_set_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	u32 index = *(u32 *)key;
+
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
+		return -EINVAL;
+
+	if (unlikely(index >= insn_set->map.max_entries))
+		return -E2BIG;
+
+	if (unlikely(map_flags & BPF_NOEXIST))
+		return -EEXIST;
+
+	copy_map_value(map, &insn_set->ptrs[index].orig_xlated_off, value);
+	insn_set->ptrs[index].xlated_off = insn_set->ptrs[index].orig_xlated_off;
+
+	return 0;
+}
+
+static long insn_set_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+static int insn_set_check_btf(const struct bpf_map *map,
+			      const struct btf *btf,
+			      const struct btf_type *key_type,
+			      const struct btf_type *value_type)
+{
+	u32 int_data;
+
+	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
+		return -EINVAL;
+
+	if (BTF_INFO_KIND(value_type->info) != BTF_KIND_INT)
+		return -EINVAL;
+
+	int_data = *(u32 *)(key_type + 1);
+	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
+		return -EINVAL;
+
+	int_data = *(u32 *)(value_type + 1);
+	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void insn_set_free(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+
+	bpf_map_area_free(insn_set);
+}
+
+static u64 insn_set_mem_usage(const struct bpf_map *map)
+{
+	return insn_set_alloc_size(map->max_entries);
+}
+
+BTF_ID_LIST_SINGLE(insn_set_btf_ids, struct, bpf_insn_set)
+
+const struct bpf_map_ops insn_set_map_ops = {
+	.map_alloc_check = insn_set_alloc_check,
+	.map_alloc = insn_set_alloc,
+	.map_free = insn_set_free,
+	.map_get_next_key = insn_set_get_next_key,
+	.map_lookup_elem = insn_set_lookup_elem,
+	.map_update_elem = insn_set_update_elem,
+	.map_delete_elem = insn_set_delete_elem,
+	.map_check_btf = insn_set_check_btf,
+	.map_mem_usage = insn_set_mem_usage,
+	.map_btf_id = &insn_set_btf_ids[0],
+};
+
+static inline bool is_frozen(struct bpf_map *map)
+{
+	bool ret = true;
+
+	mutex_lock(&map->freeze_mutex);
+	if (!map->frozen)
+		ret = false;
+	mutex_unlock(&map->freeze_mutex);
+
+	return ret;
+}
+
+static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
+				 const struct bpf_prog *prog)
+{
+	u32 off, prev_off;
+	int i;
+
+	for (i = 0; i < insn_set->map.max_entries; i++) {
+		off = insn_set->ptrs[i].orig_xlated_off;
+
+		if (off >= prog->len)
+			return false;
+
+		if (off > 0) {
+			if (prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
+				return false;
+		}
+
+		if (i > 0) {
+			prev_off = insn_set->ptrs[i-1].orig_xlated_off;
+			if (off <= prev_off)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	int i;
+
+	if (!is_frozen(map))
+		return -EINVAL;
+
+	if (!valid_offsets(insn_set, prog))
+		return -EINVAL;
+
+	/*
+	 * There can be only one program using the map
+	 */
+	mutex_lock(&insn_set->state_mutex);
+	if (insn_set->state != INSN_SET_STATE_FREE) {
+		mutex_unlock(&insn_set->state_mutex);
+		return -EBUSY;
+	}
+	insn_set->state = INSN_SET_STATE_INIT;
+	mutex_unlock(&insn_set->state_mutex);
+
+	/*
+	 * Reset all the map indexes to the original values.  This is needed,
+	 * e.g., when a replay of verification with different log level should
+	 * be performed.
+	 */
+	for (i = 0; i < map->max_entries; i++)
+		insn_set->ptrs[i].xlated_off = insn_set->ptrs[i].orig_xlated_off;
+
+	return 0;
+}
+
+void bpf_insn_set_ready(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+
+	insn_set->state = INSN_SET_STATE_READY;
+}
+
+void bpf_insn_set_release(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+
+	insn_set->state = INSN_SET_STATE_FREE;
+}
+
+#define INSN_DELETED ((u32)-1)
+
+void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	int i;
+
+	if (len <= 1)
+		return;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_set->ptrs[i].xlated_off <= off)
+			continue;
+		if (insn_set->ptrs[i].xlated_off == INSN_DELETED)
+			continue;
+		insn_set->ptrs[i].xlated_off += len - 1;
+	}
+}
+
+void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_set->ptrs[i].xlated_off < off)
+			continue;
+		if (insn_set->ptrs[i].xlated_off == INSN_DELETED)
+			continue;
+		if (insn_set->ptrs[i].xlated_off >= off &&
+		    insn_set->ptrs[i].xlated_off < off + len)
+			insn_set->ptrs[i].xlated_off = INSN_DELETED;
+		else
+			insn_set->ptrs[i].xlated_off -= len;
+	}
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 380b445a304c..c417bf5eed74 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1436,6 +1436,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
+	case BPF_MAP_TYPE_INSN_SET:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605ee8..6554f7aea0d8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9877,6 +9877,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INSN_SET:
+		goto error;
 	default:
 		break;
 	}
@@ -19873,6 +19875,13 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
 	env->used_maps[env->used_map_cnt++] = map;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_SET) {
+		err = bpf_insn_set_init(map, env->prog);
+		if (err)
+			return err;
+		env->insn_set_maps[env->insn_set_map_cnt++] = map;
+	}
+
 	return env->used_map_cnt - 1;
 }
 
@@ -20122,6 +20131,41 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
+static void mark_insn_sets_ready(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 0; i < env->insn_set_map_cnt; i++)
+		bpf_insn_set_ready(env->insn_set_maps[i]);
+}
+
+static void release_insn_sets(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 0; i < env->insn_set_map_cnt; i++)
+		bpf_insn_set_release(env->insn_set_maps[i]);
+}
+
+static void adjust_insn_sets(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	if (len == 1)
+		return;
+
+	for (i = 0; i < env->insn_set_map_cnt; i++)
+		bpf_insn_set_adjust(env->insn_set_maps[i], off, len);
+}
+
+static void adjust_insn_sets_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	for (i = 0; i < env->insn_set_map_cnt; i++)
+		bpf_insn_set_adjust_after_remove(env->insn_set_maps[i], off, len);
+}
+
 static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 {
 	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
@@ -20160,6 +20204,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_data, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_insn_sets(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -20343,6 +20388,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	adjust_insn_sets_after_remove(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -23927,8 +23974,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	}
 
 	adjust_btf_func(env);
+	mark_insn_sets_ready(env);
 
 err_release_maps:
+	if (ret)
+		release_insn_sets(env);
 	if (!env->prog->aux->used_maps)
 		/* if we didn't copy map pointers into bpf_prog_info, release
 		 * them now. Otherwise free_used_maps() will release them.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1388db053d9e..b8e588ed6406 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_SET,
 	__MAX_BPF_MAP_TYPE
 };
 
-- 
2.34.1


