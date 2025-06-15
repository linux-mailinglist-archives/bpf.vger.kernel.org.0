Return-Path: <bpf+bounces-60675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBDCADA15F
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A837A8F36
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898B265289;
	Sun, 15 Jun 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McIVSZ5F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55514264604
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977732; cv=none; b=VgTNEE4lbTbnJq51PJGRPTJ5qqocW93sEQxYeF4jm9rWs2FshlbMkEY5wEOUgOy+WX4HShpjV6s7Lf3UwS3us+IWvpoW+yTqdyBfABFpSclFmR4DUz+Yuh+bOVI8Yfp1x06BgS36TfxJjodVaXEvrNy6EagTUCDXu3yRLLAK/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977732; c=relaxed/simple;
	bh=IA7YbOjQZdHcOmbgAkSW2WVW7LX/EYzdcjnrBxmiWZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqViaCUvEI8+AUqXKOjEdV3XQwrCYzydGL+PPUwcQfaXzDnLmqgY5MfH/XiiRBuTQvLpwAHHa0tSULF5COzp4ds6yOnD00Anuz9PZEu9OyjQw8EIO4uDIhIV548E9j9Z5Un46am6qpnTgkyFM5jYp3TsbEZnXWT2Qx87MNPHimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McIVSZ5F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4530921461aso28812425e9.0
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977728; x=1750582528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW3agZRL8pCPlmAQH4Zr9l7jvYn2XlheT029eexTnBk=;
        b=McIVSZ5FOPAI5XD+wBmwKRlhmLjs27A1yA+Nd3Se6qpA8LDS2lbyfMAsqAampXRGUr
         3W2Ue0VpblZjWMb8tn/BL1488GiO+vxqZU2a0M+MdqA+WlhcKxB+YmAZQwHI6JnP0JXh
         JWxbD4sHL0zq10/AfV0BJmOT1kweoQZ1G1A4UHLadH9vm/KJMefl5iMa1PsSdSLOMnTG
         FwP5VHaOmTt9KbwO9iOHz+vg3KfaC+bQswx5a/4HLaUVt5KGghf3Dww4FV6h2rmPYxA7
         cbhXGHsHrfvgvLnnAnqpRO2MnfIHVOghORC/fHGyJF1CAfcV79vtIYXFfpvuFheE6+zb
         5gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977728; x=1750582528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW3agZRL8pCPlmAQH4Zr9l7jvYn2XlheT029eexTnBk=;
        b=Q3Gpfcj8nCFJPcGY+OmhkZ0lx4XzUuBHONQ4ORtkrGY1mH4utLs5WxsGwmlRa5Um7T
         tYcnV1uxXXJmv3YSqUbN+xwAx7SQjJBgoV3Pzd/C3Mdb63r85KWWbQI+tZ7GLZLD2AJF
         l6jjEBimI+S1Xvkd26K/6awl8QkDX1Xa1YqkqEcPXNLeHb9layAJNNOpBKcRNbG9QiCc
         Tvv+im27PzzKg/g5NNbCOt7Cu69QDlCjpLqh5DNul3jAtmdKEf/VMXEv9EfQH0+ldxf0
         Ar7WDIE5Quh3mrNBBBIFmOnajHtrxPsPfZItVgMhyl5f0jM+RnQaBeoV7LUGzO0ZT43H
         bV3A==
X-Gm-Message-State: AOJu0Yxealmeabqdi/25w9rfHLacEekEuSO3yBscgJWl/zRnc9fyf/LA
	kAvQeY17aga5YXLFcXpFyCD6xCKYMX2OrCezo/tcz6AcrNlUczsBFzsy3Xsyxw==
X-Gm-Gg: ASbGncsC/q69eLjHE359YeC0I2XZTb86DJyHoAGfJ+095KQ6DfbMFjeByFz6k5N1wFM
	DMOKzmH8TyPcuKtHTyz8GccRoSolLJsqy4jEyw1nETjHxVj31syqmp3VNG2hIytpMsnvzWks3Pq
	2pJ2DhGlvTeJaJhohosC8SeWH3qCxVmiGgiIFzXUVcLl59Dz3vSiEGwXyRqVM7XxOlBHjpBOsCF
	Tw8QE8TXymE0Aaixb0X/JZYRTG+A9FnBs4tAE/2S08oMuBg6tl7uX6iW8w83p5ajCiyWPuAPw5+
	2s3iGCZOkr+g/Xy/Uev1t33d7BsO/HjXkmh+M7ih7SSfSbQqwlE/UliRxUJrFtNhe4y2vlh3alD
	tweTrWGf7rEO6blbd
X-Google-Smtp-Source: AGHT+IGNrbHB+u11DFhffuMl8U1A1MPWNCW1KnMmR4b8PW0UcSJdDipspe03ZRQ81QFPOHlFHKZjtQ==
X-Received: by 2002:a05:6000:401e:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a57189690emr4490433f8f.0.1749977727622;
        Sun, 15 Jun 2025 01:55:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:26 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
Date: Sun, 15 Jun 2025 08:59:36 +0000
Message-Id: <20250615085943.3871208-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On bpf(BPF_PROG_LOAD) syscall user-supplied BPF programs are
translated by the verifier into "xlated" BPF programs. During this
process the original instructions offsets might be adjusted and/or
individual instructions might be replaced by new sets of instructions,
or deleted.

Add a new BPF map type which is aimed to keep track of how, for a
given program, the original instructions were relocated during the
verification. Also, besides keeping track of the original -> xlated
mapping, make x86 JIT to build the xlated -> jitted mapping for every
instruction listed in an instruction set. This is required for every
future application of instruction sets: static keys, indirect jumps
and indirect calls.

A map of the BPF_MAP_TYPE_INSN_SET type must be created with a u32
keys and value of size 8. The values have different semantics for
userspace and for BPF space. For userspace a value consists of two
u32 values – xlated and jitted offsets. For BPF side the value is
a real pointer to a jitted instruction.

On map creation/initialization, before loading the program, each
element of the map should be initialized to point to an instruction
offset within the program. Before the program load such maps should
be made frozen. After the program verification xlated and jitted
offsets can be read via the bpf(2) syscall.

If a tracked instruction is removed by the verifier, then the xlated
offset is set to (u32)-1 which is considered to be too big for a valid
BPF program offset.

One such a map can, obviously, be used to track one and only one BPF
program.  If the verification process was unsuccessful, then the same
map can be re-used to verify the program with a different log level.
However, if the program was loaded fine, then such a map, being
frozen in any case, can't be reused by other programs even after the
program release.

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

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c    |  11 ++
 include/linux/bpf.h            |  21 ++
 include/linux/bpf_types.h      |   1 +
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |  11 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_insn_set.c      | 338 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  22 +++
 kernel/bpf/verifier.c          |  43 +++++
 tools/include/uapi/linux/bpf.h |  11 ++
 10 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_insn_set.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc..923c38f212dc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1615,6 +1615,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		int adjust_off = 0;
+		int abs_xlated_off;
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
@@ -1770,6 +1772,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
 			insn++;
 			i++;
+			adjust_off = 1;
 			break;
 
 			/* dst %= src, dst /= src, dst %= imm32, dst /= imm32 */
@@ -2642,6 +2645,14 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			memcpy(rw_image + proglen, temp, ilen);
+
+			/*
+			 * Instruction sets need to know how xlated code
+			 * maps to jited code
+			 */
+			abs_xlated_off = bpf_prog->aux->subprog_start + i - 1 - adjust_off;
+			bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen, ilen,
+						 jmp_offset, image + proglen);
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8189f49e43d6..008bcd44c60e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3596,4 +3596,25 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog);
+int bpf_insn_set_ready(struct bpf_map *map);
+void bpf_insn_set_release(struct bpf_map *map);
+void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+
+struct bpf_insn_ptr {
+	void *jitted_ip;
+	u32 jitted_len;
+	int jitted_jump_offset;
+	struct bpf_insn_set_value user_value; /* userspace-visible value */
+	u32 orig_xlated_off;
+};
+
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      u32 jitted_len,
+			      int jitted_jump_offset,
+			      void *jitted_ip);
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
index 7e459e839f8b..84b5e6b25c52 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -766,8 +766,10 @@ struct bpf_verifier_env {
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
index 39e7818cca80..a833c3b4dd75 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_SET,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7589,4 +7590,14 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_SET entry must be of this type.
+ * On updates jitted_off must be equal to 0.
+ */
+struct bpf_insn_set_value {
+	__u32 jitted_off;
+	__u32 xlated_off;
+};
+
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3a335c50e6e3..18dfbc30184f 100644
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
index 000000000000..c20e99327118
--- /dev/null
+++ b/kernel/bpf/bpf_insn_set.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <linux/sort.h>
+
+#define MAX_ISET_ENTRIES 256
+
+struct bpf_insn_set {
+	struct bpf_map map;
+	struct mutex state_mutex;
+	int state;
+	long *ips;
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
+#define INSN_DELETED ((u32)-1)
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
+	    attr->value_size != 8 ||
+	    attr->map_flags != 0)
+		return -EINVAL;
+
+	if (attr->max_entries > MAX_ISET_ENTRIES)
+		return -E2BIG;
+
+	return 0;
+}
+
+static void insn_set_free(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+
+	kfree(insn_set->ips);
+	bpf_map_area_free(insn_set);
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
+	insn_set->ips = kcalloc(attr->max_entries, sizeof(long), GFP_KERNEL);
+	if (!insn_set->ips) {
+		insn_set_free(&insn_set->map);
+		return ERR_PTR(-ENOMEM);
+	}
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
+	return &insn_set->ptrs[index].user_value;
+}
+
+static long insn_set_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	u32 index = *(u32 *)key;
+	struct bpf_insn_set_value val = {};
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
+	copy_map_value(map, &val, value);
+	if (val.jitted_off || val.xlated_off == INSN_DELETED)
+		return -EINVAL;
+
+	insn_set->ptrs[index].orig_xlated_off = val.xlated_off;
+	insn_set->ptrs[index].user_value.xlated_off = val.xlated_off;
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
+static u64 insn_set_mem_usage(const struct bpf_map *map)
+{
+	u64 extra_size = 0;
+
+	extra_size += sizeof(long) * map->max_entries; /* insn_set->ips */
+
+	return insn_set_alloc_size(map->max_entries) + extra_size;
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
+	guard(mutex)(&map->freeze_mutex);
+
+	return map->frozen;
+}
+
+static bool is_insn_set(const struct bpf_map *map)
+{
+	return map->map_type == BPF_MAP_TYPE_INSN_SET;
+}
+
+static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
+				 const struct bpf_prog *prog)
+{
+	u32 off;
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
+		insn_set->ptrs[i].user_value.xlated_off = insn_set->ptrs[i].orig_xlated_off;
+
+	return 0;
+}
+
+int bpf_insn_set_ready(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_set->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		if (!insn_set->ips[i])
+			return -EFAULT;
+	}
+
+	insn_set->state = INSN_SET_STATE_READY;
+	return 0;
+}
+
+void bpf_insn_set_release(struct bpf_map *map)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+
+	insn_set->state = INSN_SET_STATE_FREE;
+}
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
+		if (insn_set->ptrs[i].user_value.xlated_off <= off)
+			continue;
+		if (insn_set->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		insn_set->ptrs[i].user_value.xlated_off += len - 1;
+	}
+}
+
+void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_set->ptrs[i].user_value.xlated_off < off)
+			continue;
+		if (insn_set->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		if (insn_set->ptrs[i].user_value.xlated_off >= off &&
+		    insn_set->ptrs[i].user_value.xlated_off < off + len)
+			insn_set->ptrs[i].user_value.xlated_off = INSN_DELETED;
+		else
+			insn_set->ptrs[i].user_value.xlated_off -= len;
+	}
+}
+
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      u32 jitted_len,
+			      int jitted_jump_offset,
+			      void *jitted_ip)
+{
+	struct bpf_insn_set *insn_set;
+	struct bpf_map *map;
+	int i, j;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (!is_insn_set(map))
+			continue;
+
+		insn_set = cast_insn_set(map);
+		for (j = 0; j < map->max_entries; j++) {
+			if (insn_set->ptrs[j].user_value.xlated_off == xlated_off) {
+				insn_set->ips[j] = (long)jitted_ip;
+				insn_set->ptrs[j].jitted_ip = jitted_ip;
+				insn_set->ptrs[j].jitted_len = jitted_len;
+				insn_set->ptrs[j].jitted_jump_offset = jitted_jump_offset;
+				insn_set->ptrs[j].user_value.jitted_off = jitted_off;
+			}
+		}
+	}
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 56500381c28a..b9123fe0e872 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1458,6 +1458,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
+	case BPF_MAP_TYPE_INSN_SET:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
@@ -2754,6 +2755,23 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static int bpf_prog_mark_insn_sets_ready(struct bpf_prog *prog)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		if (prog->aux->used_maps[i]->map_type != BPF_MAP_TYPE_INSN_SET)
+			continue;
+
+		err = bpf_insn_set_ready(prog->aux->used_maps[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
@@ -2977,6 +2995,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
+	err = bpf_prog_mark_insn_sets_ready(prog);
+	if (err < 0)
+		goto free_used_maps;
+
 	err = bpf_prog_alloc_id(prog);
 	if (err)
 		goto free_used_maps;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 98c51f824956..8ac9a0b5af53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10007,6 +10007,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INSN_SET:
+		goto error;
 	default:
 		break;
 	}
@@ -20312,6 +20314,15 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
 	env->used_maps[env->used_map_cnt++] = map;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_SET) {
+		err = bpf_insn_set_init(map, env->prog);
+		if (err) {
+			verbose(env, "Failed to properly initialize insn set\n");
+			return err;
+		}
+		env->insn_set_maps[env->insn_set_map_cnt++] = map;
+	}
+
 	return env->used_map_cnt - 1;
 }
 
@@ -20561,6 +20572,33 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
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
@@ -20599,6 +20637,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_data, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_insn_sets(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -20782,6 +20821,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	adjust_insn_sets_after_remove(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -24625,6 +24666,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	adjust_btf_func(env);
 
 err_release_maps:
+	if (ret)
+		release_insn_sets(env);
 	if (!env->prog->aux->used_maps)
 		/* if we didn't copy map pointers into bpf_prog_info, release
 		 * them now. Otherwise free_used_maps() will release them.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 39e7818cca80..a833c3b4dd75 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1013,6 +1013,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_SET,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7589,4 +7590,14 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_SET entry must be of this type.
+ * On updates jitted_off must be equal to 0.
+ */
+struct bpf_insn_set_value {
+	__u32 jitted_off;
+	__u32 xlated_off;
+};
+
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.34.1


