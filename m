Return-Path: <bpf+bounces-65820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F9B28FFA
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CD5C09C9
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A7301491;
	Sat, 16 Aug 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvhfdvmO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2A70838
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367326; cv=none; b=QMSKkEAvVpnyabl+dMR7MJ5iOquRvku2T+KaP1BZOVyFNRyq40DUOCWVYqQJ2X5kJvUh4hbRkf3eDmPBPQScOTM8W4D5/Wgpl9saV0zov/VON8G8x5mSRbtUQAG4ajMFfRTntIUxyPqZAIeTg54Lous3qwhN+CaVYXQpHUWglV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367326; c=relaxed/simple;
	bh=Pn6lNqrsoYQGf6pkwucTiyXDVeEbATsc+UVcWzkGadM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knuCVHoddGkcR3Pi4rvp+fIIRXVMDuxz1Y1gdsp86P70nZdPGW+12hjrHtj/UDmjGx0arlwopF1Krkxwg2YDB4o444Zqmh79I4bh95bYGumVPGpiH7Sj2qhvFGBzxA9yJO+kKTtW0O97suOHqnAHsW/6f6VV8l/vzUuC91eTcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvhfdvmO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so1513970f8f.2
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367322; x=1755972122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5grBNI1v4V4EnBjroTpvOnsPFTqJGtFDgXfRRNyhyE=;
        b=JvhfdvmO+75E+SuPaycczaNck8O7mfcfL4RU1050a/ue16WHowIPj8XuMUNZ9KKhOo
         R3BKd2VRsZQqdqZsEQZu8ILgHTajR0Q4EQJbUYtKlTwMW5q5XqfzF+/wxxUJEDMqq6OI
         uT+oceAv4rD2x/eWLB4hm+ibc58cqr/2mt5XRv3Dx7SgqEp4KthVeC4LOxJhWXB4GUCn
         z7ZXIORPBXzUAsEkHT9ZptsWPlL/SODuYlk2XOXcQWpQ2bDBoNa89u9GdMeBwoYzXsap
         2cHwtIblNc1YJHNnrZENvZ5o8nHqRMW6MkvLS6VJZRcJLabHgu026kYAP+0eGfI0zLju
         DVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367322; x=1755972122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5grBNI1v4V4EnBjroTpvOnsPFTqJGtFDgXfRRNyhyE=;
        b=ttPadZCisOgfNh//NHb/e6bwyDWyJkZn/BslY54nODtmMa2QNW1WOyReu28yUueQdK
         NZk1eoA8Wp5zoHmKxrf7dVy1rdDMQXIs/D7rwZpl8Rsb4u+JymdkEAS+22DEhHt7cUeN
         Zd04ik5k7y+Ga4Bh3PWl5N0Ho7Jd/ilgecyJY4QcL2NE7nwdbTzwAB/bx2e9Nho1Hqam
         l5lAv5ktPr9m4b5Wi8CJXBEoJlidTBSEzXXqIbOkpVOXF/DM9yi87cagCmMp3gWy2jdn
         IBH8tHlWqvT4swrsV0fbFypGUjfYkyX/7nig3UBJjzyNij57KlsBL4jcFQlvoxn2WRHp
         EaAQ==
X-Gm-Message-State: AOJu0Ywd/v6kJZ83ogWKR86EFnfjc07ExcZEd+nauSL9UpYoJQRjwT0A
	s328K4YY9jA5hyWkwBiTawth0nfI7MLbnn5YHUoP1fzc8e9H7mFhAdE8MYF/IQ==
X-Gm-Gg: ASbGncu3IWhISEEfOOSjpLbY7IV5u2p9kmGRdn+fxoZJpKcn0ix8ogM+X2aHNj7SPZQ
	A2HnJ1AD/0BIG8luEeSH9oJhkCCxGuJI4vB8m/mwPFyYxJ/wAbeAqLsOAsn3CGWJ//lS1xfYLww
	O8FDiphAzOz1CrNBt+jABOz0CLJrQ+ySi1GaQmsND4sto9YVqO3TKukcmv+hyg356acp66ky6SM
	EMeX/tfaWluD1huZwGHJk+ySSX6NDVTJc02CPSKNUKHWVgiiSOZNas+qe25DrXlatlVb3+W5HHo
	weO2UT4w8dCyDwFqPHxDAUiKUmZnL5Y8inDGPtT2/n/liV6HtfeQJDJOugplDdogl2s4KJdBOPT
	i0pxD8CcoBZjGWsw4PtW28uTBfMJAgwxOpoccTa9NBhw=
X-Google-Smtp-Source: AGHT+IHM97e3jr2vyCq/C8rUOR9cUR9qGq5idHBSb/4PWoL2912gZ8/55i3C4LoUVVmXZrhaC4tT9Q==
X-Received: by 2002:a05:6000:2087:b0:3b7:9bfe:4f64 with SMTP id ffacd0b85a97d-3bb694b04cdmr4585343f8f.54.1755367321683;
        Sat, 16 Aug 2025 11:02:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:00 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 03/11] bpf, x86: add new map type: instructions array
Date: Sat, 16 Aug 2025 18:06:23 +0000
Message-Id: <20250816180631.952085-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
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
---
 arch/x86/net/bpf_jit_comp.c    |   8 +
 include/linux/bpf.h            |  28 +++
 include/linux/bpf_types.h      |   1 +
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |  11 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_insn_array.c    | 336 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  22 +++
 kernel/bpf/verifier.c          |  43 +++++
 tools/include/uapi/linux/bpf.h |  11 ++
 10 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_insn_array.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7e3fca164620..589c3d5119f9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1612,6 +1612,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	prog = temp;
 
 	for (i = 1; i <= insn_cnt; i++, insn++) {
+		u32 abs_xlated_off = bpf_prog->aux->subprog_start + i - 1;
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
@@ -2642,6 +2643,13 @@ st:			if (is_imm8(insn->off))
 				return -EFAULT;
 			}
 			memcpy(rw_image + proglen, temp, ilen);
+
+			/*
+			 * Instruction arrays need to know how xlated code
+			 * maps to jitted code
+			 */
+			bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off, proglen,
+						 image + proglen);
 		}
 		proglen += ilen;
 		addrs[i] = proglen;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index baca497163d7..534ce7733277 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3705,4 +3705,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog);
+int bpf_insn_array_ready(struct bpf_map *map);
+void bpf_insn_array_release(struct bpf_map *map);
+void bpf_insn_array_adjust(struct bpf_map *map, u32 off, u32 len);
+void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
+
+/*
+ * The struct bpf_insn_ptr structure describes a pointer to a
+ * particular instruction in a loaded BPF program. Initially
+ * it is initialised from userspace via user_value.xlated_off.
+ * During the program verification all other fields are populated
+ * accordingly:
+ *
+ *   jitted_ip:       address of the instruction in the jitted image
+ *   user_value:      user-visible xlated and jitted offsets
+ *   orig_xlated_off: original offset of the instruction
+ */
+struct bpf_insn_ptr {
+	void *jitted_ip;
+	struct bpf_insn_array_value user_value;
+	u32 orig_xlated_off;
+};
+
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      void *jitted_ip);
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
index 020de62bd09c..aca43c284203 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -766,8 +766,10 @@ struct bpf_verifier_env {
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
index 233de8677382..021c27ee5591 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7623,4 +7624,14 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
+ * On updates jitted_off must be equal to 0.
+ */
+struct bpf_insn_array_value {
+	__u32 jitted_off;
+	__u32 xlated_off;
+};
+
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269c04a24664..1cd5de523b5d 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -9,7 +9,7 @@ CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
new file mode 100644
index 000000000000..0c8dac62f457
--- /dev/null
+++ b/kernel/bpf/bpf_insn_array.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <linux/sort.h>
+
+#define MAX_INSN_ARRAY_ENTRIES 256
+
+struct bpf_insn_array {
+	struct bpf_map map;
+	struct mutex state_mutex;
+	int state;
+	long *ips;
+	DECLARE_FLEX_ARRAY(struct bpf_insn_ptr, ptrs);
+};
+
+enum {
+	INSN_ARRAY_STATE_FREE = 0,
+	INSN_ARRAY_STATE_INIT,
+	INSN_ARRAY_STATE_READY,
+};
+
+#define cast_insn_array(MAP_PTR) \
+	container_of(MAP_PTR, struct bpf_insn_array, map)
+
+#define INSN_DELETED ((u32)-1)
+
+static inline u32 insn_array_alloc_size(u32 max_entries)
+{
+	const u32 base_size = sizeof(struct bpf_insn_array);
+	const u32 entry_size = sizeof(struct bpf_insn_ptr);
+
+	return base_size + entry_size * max_entries;
+}
+
+static int insn_array_alloc_check(union bpf_attr *attr)
+{
+	if (attr->max_entries == 0 ||
+	    attr->key_size != 4 ||
+	    attr->value_size != 8 ||
+	    attr->map_flags != 0)
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
+	kfree(insn_array->ips);
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
+	insn_array->ips = kcalloc(attr->max_entries, sizeof(long), GFP_KERNEL);
+	if (!insn_array->ips) {
+		insn_array_free(&insn_array->map);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	bpf_map_init_from_attr(&insn_array->map, attr);
+
+	mutex_init(&insn_array->state_mutex);
+	insn_array->state = INSN_ARRAY_STATE_FREE;
+
+	return &insn_array->map;
+}
+
+static int insn_array_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 index = key ? *(u32 *)key : U32_MAX;
+	u32 *next = (u32 *)next_key;
+
+	if (index >= insn_array->map.max_entries) {
+		*next = 0;
+		return 0;
+	}
+
+	if (index == insn_array->map.max_entries - 1)
+		return -ENOENT;
+
+	*next = index + 1;
+	return 0;
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
+	return &insn_array->ptrs[index].user_value;
+}
+
+static long insn_array_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	u32 index = *(u32 *)key;
+	struct bpf_insn_array_value val = {};
+	int err = 0;
+
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
+		return -EINVAL;
+
+	if (unlikely(index >= insn_array->map.max_entries))
+		return -E2BIG;
+
+	if (unlikely(map_flags & BPF_NOEXIST))
+		return -EEXIST;
+
+	/* No updates for maps in use */
+	if (!mutex_trylock(&insn_array->state_mutex))
+		return -EBUSY;
+
+	if (insn_array->state != INSN_ARRAY_STATE_FREE) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	copy_map_value(map, &val, value);
+	if (val.jitted_off || val.xlated_off == INSN_DELETED) {
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	insn_array->ptrs[index].orig_xlated_off = val.xlated_off;
+	insn_array->ptrs[index].user_value.xlated_off = val.xlated_off;
+
+unlock:
+	mutex_unlock(&insn_array->state_mutex);
+	return err;
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
+	u64 extra_size = 0;
+
+	extra_size += sizeof(long) * map->max_entries; /* insn_array->ips */
+
+	return insn_array_alloc_size(map->max_entries) + extra_size;
+}
+
+BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
+
+const struct bpf_map_ops insn_array_map_ops = {
+	.map_alloc_check = insn_array_alloc_check,
+	.map_alloc = insn_array_alloc,
+	.map_free = insn_array_free,
+	.map_get_next_key = insn_array_get_next_key,
+	.map_lookup_elem = insn_array_lookup_elem,
+	.map_update_elem = insn_array_update_elem,
+	.map_delete_elem = insn_array_delete_elem,
+	.map_check_btf = insn_array_check_btf,
+	.map_mem_usage = insn_array_mem_usage,
+	.map_btf_id = &insn_array_btf_ids[0],
+};
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
+		off = insn_array->ptrs[i].orig_xlated_off;
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
+	int i;
+
+	if (!valid_offsets(insn_array, prog))
+		return -EINVAL;
+
+	/*
+	 * There can be only one program using the map
+	 */
+	mutex_lock(&insn_array->state_mutex);
+	if (insn_array->state != INSN_ARRAY_STATE_FREE) {
+		mutex_unlock(&insn_array->state_mutex);
+		return -EBUSY;
+	}
+	insn_array->state = INSN_ARRAY_STATE_INIT;
+	mutex_unlock(&insn_array->state_mutex);
+
+	/*
+	 * Reset all the map indexes to the original values.  This is needed,
+	 * e.g., when a replay of verification with different log level should
+	 * be performed.
+	 */
+	for (i = 0; i < map->max_entries; i++)
+		insn_array->ptrs[i].user_value.xlated_off = insn_array->ptrs[i].orig_xlated_off;
+
+	return 0;
+}
+
+int bpf_insn_array_ready(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	guard(mutex)(&insn_array->state_mutex);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_array->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		if (!insn_array->ips[i]) {
+			/*
+			 * Set the map free on failure; the program owning it
+			 * might be re-loaded with different log level
+			 */
+			insn_array->state = INSN_ARRAY_STATE_FREE;
+			return -EFAULT;
+		}
+	}
+
+	insn_array->state = INSN_ARRAY_STATE_READY;
+	return 0;
+}
+
+void bpf_insn_array_release(struct bpf_map *map)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	guard(mutex)(&insn_array->state_mutex);
+
+	insn_array->state = INSN_ARRAY_STATE_FREE;
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
+		if (insn_array->ptrs[i].user_value.xlated_off <= off)
+			continue;
+		if (insn_array->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		insn_array->ptrs[i].user_value.xlated_off += len - 1;
+	}
+}
+
+void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+	int i;
+
+	for (i = 0; i < map->max_entries; i++) {
+		if (insn_array->ptrs[i].user_value.xlated_off < off)
+			continue;
+		if (insn_array->ptrs[i].user_value.xlated_off == INSN_DELETED)
+			continue;
+		if (insn_array->ptrs[i].user_value.xlated_off >= off &&
+		    insn_array->ptrs[i].user_value.xlated_off < off + len)
+			insn_array->ptrs[i].user_value.xlated_off = INSN_DELETED;
+		else
+			insn_array->ptrs[i].user_value.xlated_off -= len;
+	}
+}
+
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      void *jitted_ip)
+{
+	struct bpf_insn_array *insn_array;
+	struct bpf_map *map;
+	int i, j;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (!is_insn_array(map))
+			continue;
+
+		insn_array = cast_insn_array(map);
+		for (j = 0; j < map->max_entries; j++) {
+			if (insn_array->ptrs[j].user_value.xlated_off == xlated_off) {
+				insn_array->ips[j] = (long)jitted_ip;
+				insn_array->ptrs[j].jitted_ip = jitted_ip;
+				insn_array->ptrs[j].user_value.jitted_off = jitted_off;
+			}
+		}
+	}
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..2f312527d684 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1461,6 +1461,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
 	case BPF_MAP_TYPE_ARENA:
+	case BPF_MAP_TYPE_INSN_ARRAY:
 		if (!bpf_token_capable(token, CAP_BPF))
 			goto put_token;
 		break;
@@ -2761,6 +2762,23 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
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
 #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
 
@@ -2984,6 +3002,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
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
index b034f88d72a0..e1f7744e132b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10084,6 +10084,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		goto error;
 	default:
 		break;
 	}
@@ -20492,6 +20494,15 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 
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
 
@@ -20738,6 +20749,33 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
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
@@ -20780,6 +20818,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	}
 	adjust_insn_aux_data(env, new_prog, off, len);
 	adjust_subprog_starts(env, off, len);
+	adjust_insn_arrays(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
 	return new_prog;
 }
@@ -20963,6 +21002,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	if (err)
 		return err;
 
+	adjust_insn_arrays_after_remove(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -24810,6 +24851,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	adjust_btf_func(env);
 
 err_release_maps:
+	if (ret)
+		release_insn_arrays(env);
 	if (!env->prog->aux->used_maps)
 		/* if we didn't copy map pointers into bpf_prog_info, release
 		 * them now. Otherwise free_used_maps() will release them.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..021c27ee5591 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_INSN_ARRAY,
 	__MAX_BPF_MAP_TYPE
 };
 
@@ -7623,4 +7624,14 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
+ * On updates jitted_off must be equal to 0.
+ */
+struct bpf_insn_array_value {
+	__u32 jitted_off;
+	__u32 xlated_off;
+};
+
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.34.1


