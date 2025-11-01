Return-Path: <bpf+bounces-73229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA867C27C4F
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C983BFFF1
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9742F25F3;
	Sat,  1 Nov 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI3b9QAl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A12F1FC7
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994869; cv=none; b=pN1eCP2HmyyfHsjEfT/wvIKEOjCveqPPW7kOxlcL2GHjA0M7DkBFPJmRUM/3XZEjNJCBiPIIyBtcbLoTfJPbivEzlY70G+M3a3ko376AMTi54jMbAYp+FS7w2YCOvYanM7c4e2xv6GWd8kGeKT7Y1i6Cn1D/fwVQez9TPaqoVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994869; c=relaxed/simple;
	bh=/WOdLENo7/KlAdVrq6BVglXebH1vWDK6f94MUtETm/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq4rL9itqMuFgICbOPasnDofxsaiyoH5iVrdVLR14Kxax+/kGDmOS7TtgUEVeXHg5xi36IgCKTrNr6xU4hVXnehsrRP0ZPmHaQjspzjxeKyiIQ1KznTpnEB4p4KqtA92tDF3oj7QgAdjOm1tQSJKnNJlEy3nHVVuzKWcGkxcJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI3b9QAl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso37545175e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994863; x=1762599663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yjtf1bdt3uUyN/DUhPQMvE+ebUNrjOJflB6vkigp7to=;
        b=KI3b9QAlOLRANVMxh6Vnr3cjYcjrRNG1zSrFdRFZlskS8B4s/vHffuPu7JnpTxEx/S
         WQvDarLQJ62K76cyYW+1tZdjB04Mvo5aM+ObhwU625qxm74KOeCdAs5g2/wPEekc7oJv
         VitaAkhE3qu90tF1axScrQXGbEAQjbt8raQiwv6+5Cj/88MUIti4AutASRGnW97W4KiV
         45lG8F5C+TgSVGnAJaBot6Lvihf0CfWck7lbEO5R3WYUe6ieRsC6UYqTWAhhwCNY3I/Y
         JqtqK2Ky5zOCiNCHpmrfIqrvWKtihpD9mB1/8IYw04ML7wInYyYvT2SP0VJrJRBARXFJ
         W8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994863; x=1762599663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yjtf1bdt3uUyN/DUhPQMvE+ebUNrjOJflB6vkigp7to=;
        b=KokpAAo1yej7oS0mdyEAo/W0BsQV2IaBqMf/lux7TM3EvghhTxsmeZud7dY3awTlWq
         GMACCnk1GRMeaFnB8IRxIk9vlsMRGLBlBG1YGhJYMUFbUxOZ9YVwfx/DJzQE2/6h6Hwt
         h0j2aYqZrZadDHNDu8gbfWnri5o4kemPrsx2mO7W+eudxB4yTjSmjbAUFy44d2zJei8S
         TeakZA25gtUYEL7oYx4YwTeQGcCvHjTy39SamTe6VWJMi7YooMeFgJyYOcTuwYdmQV1M
         /DyP9cLzV6VUKGssWbGAftzkDq2RZgbLODy6roieDUb8gHMZvzFadZAcF8pbSskr+vzz
         HeMg==
X-Gm-Message-State: AOJu0YzWoJN/wU1okWgeJ+x2AuR5IsRQw7LVgnn0dYCqMChFZCOnn0D1
	3YKkno63ePb9J5SkLRc1jztZpcoXAgo/Fnyb2qcGwncePzjX3GY8I0uW3g4sLQ==
X-Gm-Gg: ASbGnctEaTPnaxYK7kFK6XT04K3BOk2658R7l01c9pYY44JC3ljSevbNvwojIvOUzSm
	WdmgQLsACzJ5i+COgsXQRPRnNNJJwRuJGhqPn2LuYtT+Tpmu3yNjKssyIiUYkwOC6yTBKGfYQkr
	xwq7mky2ZHCoWpK2O9+Ex7LCKXGEaAFme8NsgDlabgVtuGXwQD4jXXCVXfwl4jtt59ztryUlgwd
	Vuk60Zxu/kRSphyWLFzPXIJoHpkKm+fxIf5TrOu7BSpvpiGibH0IqkJvpU9fbcLjJ/yff94Kll7
	LwvyEWnHCN64Z2r/Sb5gO8G7MBvMqnO2MY/Bn1pv19AXwfcwF70DU1cIQU5afQfvhZpSeABmEcK
	BuuiNNne649jS+/rol1NSnKXDC9tqt8Rqmzo4JvM0jcyeF53VHiCpQpOz92KZcuhqqE6HAcI4ux
	9B67uAqMrBW8n2snCUBXI=
X-Google-Smtp-Source: AGHT+IFLl7WV2t6RtoJ1MGmS4fPc6onX+3RQIZc0CMEN4UXFXGnlLks8ifWACBWRcUpXbCgpPEbMBw==
X-Received: by 2002:a05:600c:820b:b0:471:c72:c807 with SMTP id 5b1f17b1804b1-4773087af79mr51956155e9.22.1761994862540;
        Sat, 01 Nov 2025 04:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:01 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 01/11] bpf, x86: add new map type: instructions array
Date: Sat,  1 Nov 2025 11:07:07 +0000
Message-Id: <20251101110717.2860949-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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
instruction listed in an instruction array. This is required for every
future application of instruction arrays: static keys, indirect jumps
and indirect calls.

A map of the BPF_MAP_TYPE_INSN_ARRAY type must be created with a u32
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

An instruction array map, containing, e.g., instructions [0,4,7,12]
will be translated by the verifier to [0,4,13,20]. A map with
index 5 (the middle of 16-byte instruction) or indexes greater than 12
(outside the program boundaries) would be rejected.

The functionality provided by this patch will be extended in consequent
patches to implement BPF Static Keys, indirect jumps, and indirect calls.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c    |   9 ++
 include/linux/bpf.h            |  15 ++
 include/linux/bpf_types.h      |   1 +
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |  21 +++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_insn_array.c    | 286 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  22 +++
 kernel/bpf/verifier.c          |  43 +++++
 tools/include/uapi/linux/bpf.h |  21 +++
 10 files changed, 421 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..6e3574033473 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3827,6 +3827,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			jit_data->header = header;
 			jit_data->rw_header = rw_header;
 		}
+
+		/*
+		 * The bpf_prog_update_insn_ptrs function expects addrs to
+		 * point to the first byte of the jitted instruction (unlike
+		 * the bpf_prog_fill_jited_linfo below, which, for historical
+		 * reasons, expects to point to the next instruction)
+		 */
+		bpf_prog_update_insn_ptrs(prog, addrs, image);
+
 		/*
 		 * ctx.prog_offset is used when CFI preambles put code *before*
 		 * the function. See emit_cfi(). For FineIBT specifically this code
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..9d41a6affcef 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3797,4 +3797,19 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
+int bpf_insn_array_ready(struct bpf_map *map);
+void bpf_insn_array_release(struct bpf_map *map);
+void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+
+#ifdef CONFIG_BPF_SYSCALL
+void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
+#else
+static inline void
+bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
+{
+}
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..b13de31e163f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -133,6 +133,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c6eb68b6389c..6b820d8d77af 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -754,8 +754,10 @@ struct bpf_verifier_env {
 	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
 	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
+	struct bpf_map *insn_array_maps[MAX_USED_MAPS]; /* array of INSN_ARRAY map's to be relocated */
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
+	u32 insn_array_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_ARRAY */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	int exception_callback_subprog;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1d73f165394d..f5713f59ac10 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7649,4 +7650,24 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
+ *
+ * Before the map is used the orig_off field should point to an
+ * instruction inside the program being loaded. The other fields
+ * must be set to 0.
+ *
+ * After the program is loaded, the xlated_off will be adjusted
+ * by the verifier to point to the index of the original instruction
+ * in the xlated program. If the instruction is deleted, it will
+ * be set to (u32)-1. The jitted_off will be set to the corresponding
+ * offset in the jitted image of the program.
+ */
+struct bpf_insn_array_value {
+	__u32 orig_off;
+	__u32 xlated_off;
+	__u32 jitted_off;
+	__u32 :32;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7fd0badfacb1..232cbc97434d 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -9,7 +9,7 @@ CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
new file mode 100644
index 000000000000..d29f38721b14
--- /dev/null
+++ b/kernel/bpf/bpf_insn_array.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Isovalent */
+
+#include <linux/bpf.h>
+
+struct bpf_insn_array {
+	struct bpf_map map;
+	atomic_t used;
+	long *ips;
+	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
+};
+
+#define cast_insn_array(MAP_PTR) \
+	container_of((MAP_PTR), struct bpf_insn_array, map)
+
+#define INSN_DELETED ((u32)-1)
+
+static inline u32 insn_array_alloc_size(u32 max_entries)
+{
+	const u32 base_size = sizeof(struct bpf_insn_array);
+	const u32 entry_size = sizeof(struct bpf_insn_array_value);
+
+	return base_size + max_entries * (entry_size + sizeof(long));
+}
+
+static int insn_array_alloc_check(union bpf_attr *attr)
+{
+	u32 value_size = sizeof(struct bpf_insn_array_value);
+
+	if (attr->max_entries == 0 || attr->key_size != 4 ||
+	    attr->value_size != value_size || attr->map_flags != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void insn_array_free(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+
+	bpf_map_area_free(insn_array);
+}
+
+static struct bpf_map *insn_array_alloc(union bpf_attr *attr)
+{
+	u64 size = insn_array_alloc_size(attr->max_entries);
+	struct bpf_insn_array *insn_array;
+
+	insn_array = bpf_map_area_alloc(size, NUMA_NO_NODE);
+	if (!insn_array)
+		return ERR_PTR(-ENOMEM);
+
+	/* ips are allocated right after the insn_array->values[] array */
+	insn_array->ips = (void *)&insn_array->values[attr->max_entries];
+
+	bpf_map_init_from_attr(&insn_array->map, attr);
+
+	return &insn_array->map;
+}
+
+static void *insn_array_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 index = *(u32 *)key;
+
+	if (unlikely(index >= insn_array->map.max_entries))
+		return NULL;
+
+	return &insn_array->values[index];
+}
+
+static long insn_array_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 index = *(u32 *)key;
+	struct bpf_insn_array_value val = {};
+
+	if (unlikely(index >= insn_array->map.max_entries))
+		return -E2BIG;
+
+	if (unlikely(map_flags & BPF_NOEXIST))
+		return -EEXIST;
+
+	copy_map_value(map, &val, value);
+	if (val.jitted_off || val.xlated_off)
+		return -EINVAL;
+
+	insn_array->values[index].orig_off = val.orig_off;
+
+	return 0;
+}
+
+static long insn_array_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+static int insn_array_check_btf(const struct bpf_map *map,
+			      const struct btf *btf,
+			      const struct btf_type *key_type,
+			      const struct btf_type *value_type)
+{
+	if (!btf_type_is_i32(key_type))
+		return -EINVAL;
+
+	if (!btf_type_is_i64(value_type))
+		return -EINVAL;
+
+	return 0;
+}
+
+static u64 insn_array_mem_usage(const struct bpf_map *map)
+{
+	return insn_array_alloc_size(map->max_entries);
+}
+
+BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
+
+const struct bpf_map_ops insn_array_map_ops = {
+	.map_alloc_check = insn_array_alloc_check,
+	.map_alloc = insn_array_alloc,
+	.map_free = insn_array_free,
+	.map_get_next_key = bpf_array_get_next_key,
+	.map_lookup_elem = insn_array_lookup_elem,
+	.map_update_elem = insn_array_update_elem,
+	.map_delete_elem = insn_array_delete_elem,
+	.map_check_btf = insn_array_check_btf,
+	.map_mem_usage = insn_array_mem_usage,
+	.map_btf_id = &insn_array_btf_ids[0],
+};
+
+static inline bool is_frozen(struct bpf_map *map)
+{
+	guard(mutex)(&map->freeze_mutex);
+
+	return map->frozen;
+}
+
+static bool is_insn_array(const struct bpf_map *map)
+{
+	return map->map_type == BPF_MAP_TYPE_INSN_ARRAY;
+}
+
+static inline bool valid_offsets(const struct bpf_insn_array *insn_array,
+				 const struct bpf_prog *prog)
+{
+	u32 off;
+	int i;
+
+	for (i = 0; i < insn_array->map.max_entries; i++) {
+		off = insn_array->values[i].orig_off;
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
+int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	struct bpf_insn_array_value *values = insn_array->values;
+	int i;
+
+	if (!is_frozen(map))
+		return -EINVAL;
+
+	if (!valid_offsets(insn_array, prog))
+		return -EINVAL;
+
+	/*
+	 * There can be only one program using the map
+	 */
+	if (atomic_xchg(&insn_array->used, 1))
+		return -EBUSY;
+
+	/*
+	 * Reset all the map indexes to the original values.  This is needed,
+	 * e.g., when a replay of verification with different log level should
+	 * be performed.
+	 */
+	for (i = 0; i < map->max_entries; i++)
+		values[i].xlated_off = values[i].orig_off;
+
+	return 0;
+}
+
+int bpf_insn_array_ready(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_array->values[i].xlated_off == INSN_DELETED)
+			continue;
+		if (!insn_array->ips[i])
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+void bpf_insn_array_release(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+
+	atomic_set(&insn_array->used, 0);
+}
+
+void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	int i;
+
+	if (len <= 1)
+		return;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_array->values[i].xlated_off <= off)
+			continue;
+		if (insn_array->values[i].xlated_off == INSN_DELETED)
+			continue;
+		insn_array->values[i].xlated_off += len - 1;
+	}
+}
+
+void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_array->values[i].xlated_off < off)
+			continue;
+		if (insn_array->values[i].xlated_off == INSN_DELETED)
+			continue;
+		if (insn_array->values[i].xlated_off < off + len)
+			insn_array->values[i].xlated_off = INSN_DELETED;
+		else
+			insn_array->values[i].xlated_off -= len;
+	}
+}
+
+/*
+ * This function is called by JITs. The image is the real program
+ * image, the offsets array set up the xlated -> jitted mapping.
+ * The offsets[xlated] offset should point to the beginning of
+ * the jitted instruction.
+ */
+void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
+{
+	struct bpf_insn_array *insn_array;
+	struct bpf_map *map;
+	u32 xlated_off;
+	int i, j;
+
+	if (!offsets || !image)
+		return;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (!is_insn_array(map))
+			continue;
+
+		insn_array = cast_insn_array(map);
+		for (j = 0; j < map->max_entries; j++) {
+			xlated_off = insn_array->values[j].xlated_off;
+			if (xlated_off == INSN_DELETED)
+				continue;
+			if (xlated_off < prog->aux->subprog_start)
+				continue;
+			xlated_off -= prog->aux->subprog_start;
+			if (xlated_off >= prog->len)
+				continue;
+
+			insn_array->values[j].jitted_off = offsets[xlated_off];
+			insn_array->ips[j] = (long)(image + offsets[xlated_off]);
+		}
+	}
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..f62d61b6730a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1493,6 +1493,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
+	case BPF_MAP_TYPE_INSN_ARRAY:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
@@ -2853,6 +2854,23 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
 	return err;
 }
 
+static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		if (prog->aux->used_maps[i]->map_type != BPF_MAP_TYPE_INSN_ARRAY)
+			continue;
+
+		err = bpf_insn_array_ready(prog->aux->used_maps[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_PROG_LOAD_LAST_FIELD keyring_id
 
@@ -3082,6 +3100,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
+	err = bpf_prog_mark_insn_arrays_ready(prog);
+	if (err < 0)
+		goto free_used_maps;
+
 	err = bpf_prog_alloc_id(prog);
 	if (err)
 		goto free_used_maps;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..dd597ea80d99 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10086,6 +10086,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		goto error;
 	default:
 		break;
 	}
@@ -20551,6 +20553,15 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
 	env->used_maps[env->used_map_cnt++] = map;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
+		err = bpf_insn_array_init(map, env->prog);
+		if (err) {
+			verbose(env, "Failed to properly initialize insn array\n");
+			return err;
+		}
+		env->insn_array_maps[env->insn_array_map_cnt++] = map;
+	}
+
 	return env->used_map_cnt - 1;
 }
 
@@ -20797,6 +20808,33 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 	}
 }
 
+static void release_insn_arrays(struct bpf_verifier_env *env)
+{
+	int i;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_release(env->insn_array_maps[i]);
+}
+
+static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	if (len == 1)
+		return;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_adjust(env->insn_array_maps[i], off, len);
+}
+
+static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_adjust_after_remove(env->insn_array_maps[i], off, len);
+}
+
 static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 {
 	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
@@ -20838,6 +20876,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -21021,6 +21060,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	adjust_insn_arrays_after_remove(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -24840,6 +24881,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	adjust_btf_func(env);
 
 err_release_maps:
+	if (ret)
+		release_insn_arrays(env);
 	if (!env->prog->aux->used_maps)
 		/* if we didn't copy map pointers into bpf_prog_info, release
 		 * them now. Otherwise free_used_maps() will release them.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d73f165394d..f5713f59ac10 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7649,4 +7650,24 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
+ *
+ * Before the map is used the orig_off field should point to an
+ * instruction inside the program being loaded. The other fields
+ * must be set to 0.
+ *
+ * After the program is loaded, the xlated_off will be adjusted
+ * by the verifier to point to the index of the original instruction
+ * in the xlated program. If the instruction is deleted, it will
+ * be set to (u32)-1. The jitted_off will be set to the corresponding
+ * offset in the jitted image of the program.
+ */
+struct bpf_insn_array_value {
+	__u32 orig_off;
+	__u32 xlated_off;
+	__u32 jitted_off;
+	__u32 :32;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.34.1


