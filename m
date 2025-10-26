Return-Path: <bpf+bounces-72258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053FC0B112
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20794E8F5E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7292FE560;
	Sun, 26 Oct 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYbOva4f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990D261581
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506444; cv=none; b=sURuxIrTe3PeQoQeQNTQI2N8/6wZNjjP3dPwc8UKyvrf3CVVsSpC7E1Q95JyXtbmcyv+TStC+MXhPAeVRwfHCDsrijXOHSSKJafpe23/k1sL5k/VtwZKlw/Cp/ukc75KiZMhZauOBpH0sTr4e5UU6qWdL5AukwBP6VM8bm8Wf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506444; c=relaxed/simple;
	bh=V4+isqYCbba7LgOTf76cHCo7ZPTpZ9v+mCaWK7Kld4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QouRxc1k1PmD1Q1mtJ7+/U/EzuIXGIoa5KtRiAu4Yrzr37TZy33QWG6c2EMAUflJWVucJACJAap9EvGspaFOqQ2JRZVI/7X0hJChHORCNPeCxmex8RVoTBNRPAi0y5EZ7gVETvxLJjYo+IsA4Iu++TfUGxrW+O9mY0DR/+31ElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYbOva4f; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso9088135e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506439; x=1762111239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tHYQF+k0K0I6osZOXpzduebNCd6nFdY86FQqfUT91Q=;
        b=dYbOva4f/gh+Lbi/F6/cyRXHmH+x11FWUvgtUcIAtPmD3P0Wh5wqinyhmmfVwZI4mN
         yLwmkzhlf4pjdGFa3avgU0VyVLSsxOB8agqRt1ZaKTWXjQbHMMpzaWMzLh1BtNqNrEn3
         fr345IJoXgeT4tHO5uPINn6cafaBiSEqmdcNAyKmw/cXCMbxhWlKmMRM9/rltBtiWg1y
         dY0OcJxada+4HcH0sfQ+q4NVIfuglfM96Xv1foQH+7H7yfgl7kHlF0+hzp0/SzU17Q8q
         RuGmEq1lMakWcN51VinFgL5PVr1oZyqTAZKr5Nwj8ekKHC9V5QygAnLoSDd1H+0oZQfW
         PmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506439; x=1762111239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tHYQF+k0K0I6osZOXpzduebNCd6nFdY86FQqfUT91Q=;
        b=Fc/5t0MfnLyjTX+EPlGoImgI7yMbk30XyhctZXUYtDdhWjBRyy6vcF/jLOTCTk8KAR
         M8H/aSYBB+cSibNwGyt5N6Ou45dv6AxPW/iIFmPqO0Pbybj0QhCEXYFe+ydTjhoMNMcg
         NcazBCGfUkEz+JPxc0NRHnz7BYY4CMRioOJQ80kwdldpFNMu6xEgTrzZUVOO943Bvpjj
         Ey9PC+0TVwqQjF80z9ZOxkoV1lFRkHsPrQ70ClN3lql4Tz9PKWs7IDkB/RxrzUkzOGB+
         8qzfmWpaO077Bu48AA38IVUdOq7fb+XfDbfhRaIBvmSBC2J411Ysjjy8gYDiw79Aggq1
         fvaA==
X-Gm-Message-State: AOJu0YyoLmT5+1Zg8dN3BH6m6IrC78iqd59YYSVtl0iVrsr1cdyODedb
	TUywORsyqAI3JIPiEoaEJ+QpLLYATYRAuoYt5TLBuNxi+y25GoKcftgNYtBiKg==
X-Gm-Gg: ASbGncvTVgy9UzCoBVjmkiZZP1PEJt6ezT9lGAQ0P/G4a1ZBXnBCPqvKU7Bpwx3jvJg
	FPkLz4ghT9zkuj3P/aEe9aBa9/STYio77q6tsHaQwldtjsC9cnmvw/YncuFpTICAQftBr8otBb/
	jdiboOEtTj1z01khpyzO0WwmORMn9FpTe6onOjFHPCpb5Rdyl8EtSls1UmFs42YmDCQzgemLxGs
	HgC9RfzltyJOzxJQe/oAN7U8j8PSccPkaiveACgYyxKwrnQ42kb6Rl+jao2RDchjzpuF+TGBmxg
	rhU52bPGsR9JYiPqoi04Ejs8FjUQLc4ikTCUk6K5muEPcELj+gM/nyYk3odl82HdgL2vN4MigjD
	B36zVVmHKKlyGKM7vipzTssrx+USnt4+Xpw7FoYJ7KrB/qH0ocsIp7qIlQe5vssfRJqV3ZYsl2E
	yKska6OHneu19hG/3wCkenTxxotJQJ1Q==
X-Google-Smtp-Source: AGHT+IHa/t5uOs4+omb2PXDCSYEiqc5GZiTb9ZaNn/ddx2AgpvxI19GH61cgd6ti+UJZ2yGeu5gy+g==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr280668505e9.30.1761506437614;
        Sun, 26 Oct 2025 12:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:37 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 01/12] bpf, x86: add new map type: instructions array
Date: Sun, 26 Oct 2025 19:26:58 +0000
Message-Id: <20251026192709.1964787-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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
 arch/x86/net/bpf_jit_comp.c    |  23 +++
 include/linux/bpf.h            |  19 +++
 include/linux/bpf_types.h      |   1 +
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |  21 +++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_insn_array.c    | 284 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  22 +++
 kernel/bpf/verifier.c          |  43 +++++
 tools/include/uapi/linux/bpf.h |  21 +++
 10 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..d8ee0c4d9af8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3648,6 +3648,22 @@ struct x64_jit_data {
 	struct jit_context ctx;
 };
 
+struct insn_ptrs_data {
+	int *addrs;
+	u8 *image;
+};
+
+static void update_insn_ptr(void *jit_priv, u32 xlated_off, u32 *jitted_off, long *ip)
+{
+	struct insn_ptrs_data *data = jit_priv;
+
+	if (!data->addrs || !data->image || !jitted_off || !ip)
+		return;
+
+	*jitted_off = data->addrs[xlated_off];
+	*ip = (long)(data->image + *jitted_off);
+}
+
 #define MAX_PASSES 20
 #define PADDING_PASSES (MAX_PASSES - 5)
 
@@ -3658,6 +3674,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct bpf_prog *tmp, *orig_prog = prog;
 	void __percpu *priv_stack_ptr = NULL;
 	struct x64_jit_data *jit_data;
+	struct insn_ptrs_data insn_ptrs_data;
 	int priv_stack_alloc_sz;
 	int proglen, oldproglen = 0;
 	struct jit_context ctx = {};
@@ -3827,6 +3844,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			jit_data->header = header;
 			jit_data->rw_header = rw_header;
 		}
+
+		/* jit_data may not contain proper info, copy the required fields */
+		insn_ptrs_data.addrs = addrs;
+		insn_ptrs_data.image = image;
+		bpf_prog_update_insn_ptrs(prog, &insn_ptrs_data, update_insn_ptr);
+
 		/*
 		 * ctx.prog_offset is used when CFI preambles put code *before*
 		 * the function. See emit_cfi(). For FineIBT specifically this code
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e53cda0aabb6..b64c2382fbb7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3789,4 +3789,23 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
+int bpf_insn_array_ready(struct bpf_map *map);
+void bpf_insn_array_release(struct bpf_map *map);
+void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+
+typedef void (*update_insn_ptr_func_t)(void *jit_priv, u32 xlated_off, u32 *jitted_off, long *ip);
+
+#ifdef CONFIG_BPF_SYSCALL
+void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
+			       update_insn_ptr_func_t update_insn_ptr);
+#else
+static inline void
+bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
+			  update_insn_ptr_func_t update_insn_ptr);
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
index 6829936d33f5..805d441363cd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7645,4 +7646,24 @@ enum bpf_kfunc_flags {
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
index 000000000000..f9f875ee2027
--- /dev/null
+++ b/kernel/bpf/bpf_insn_array.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Isovalent */
+
+#include <linux/bpf.h>
+
+#define MAX_INSN_ARRAY_ENTRIES 256
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
+	if (attr->max_entries > MAX_INSN_ARRAY_ENTRIES)
+		return -E2BIG;
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
+void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, void *jit_priv,
+			       update_insn_ptr_func_t update_insn_ptr)
+{
+	struct bpf_insn_array *insn_array;
+	struct bpf_map *map;
+	u32 xlated_off;
+	int i, j;
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
+			update_insn_ptr(jit_priv, xlated_off,
+					&insn_array->values[j].jitted_off,
+					&insn_array->ips[j]);
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
index 6d175849e57a..5c3f3c4e4f47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10083,6 +10083,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		goto error;
 	default:
 		break;
 	}
@@ -20541,6 +20543,15 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
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
 
@@ -20787,6 +20798,33 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
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
@@ -20828,6 +20866,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -21011,6 +21050,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	adjust_insn_arrays_after_remove(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -24811,6 +24852,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	adjust_btf_func(env);
 
 err_release_maps:
+	if (ret)
+		release_insn_arrays(env);
 	if (!env->prog->aux->used_maps)
 		/* if we didn't copy map pointers into bpf_prog_info, release
 		 * them now. Otherwise free_used_maps() will release them.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..805d441363cd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7645,4 +7646,24 @@ enum bpf_kfunc_flags {
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


