Return-Path: <bpf+bounces-16885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB078071FF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55B4B20E68
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D439B3DBAF;
	Wed,  6 Dec 2023 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XNxp08kf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F7D51
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 06:13:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b399a6529so5199765e9.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1701872029; x=1702476829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iawa77ErIO3uM0nFJSl0bnovHJlBAXU0a52h01OI+f8=;
        b=XNxp08kfsKHmYG/NENtvzJTfNv5L1qbqsXrZ6cfzPkjMzyCQNmWlM6JWU52sbEsM10
         Jab34U/SfF0n1raEeV2lf1BM1vQDryogWssiqgLQSF+MsqDRy+KK6FsW2XoRSUL6SvsT
         gt0EcFWE+u0+8LH5hliLcEVra6nUz63LtgFIFwtNQHFjP+DxzAdylLX1maDLjHJn+Rcz
         S5jGp481dCCcdkZMhb2GsNKl6kSnYX4baIOW5ybpPCMgOtLEggqdgTxHgjsXHidQt7yX
         NnC+BpfTrNjER7piAYGxU33xONmxqLkLFXTlCew6RMBXSY/tT9nFH26ndgKp3+O1J6m+
         z+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872029; x=1702476829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iawa77ErIO3uM0nFJSl0bnovHJlBAXU0a52h01OI+f8=;
        b=UDSyZZnlJaWNAdqAtWPz4PG7qwTnebnqOVvuxK+kLHpiL9vd5x2nMFKgrsxuyrvPmM
         KJ1ga034H95cw8q8iPKOlPsHgIilrwCd8jzZEycBgbiJRvVEXBy482/PukT8qq389E3w
         sn4dYmq69SDzG35XrKvTxxUDwI9O/N8qb+54Q9Ad6LDD4zpR76Y464pT66xRCxJQ6yG4
         b65pqKVheGFjihsejEwAatd2ELo9Dl17O7eIIs/NboMHTvfqXnNG6yL9SFeZmQFkdnhz
         Xknkc3jM3VAo2nU0sR9Uekqx0RYtIvPssynazCNWPOILAjTsneCy8ilod4MFiCjZAK10
         01Fw==
X-Gm-Message-State: AOJu0YxfkcYkiioDSsf2Uy13M7+ymmQqchetuWWTw9lGPNJ8c4JSAfJT
	hibURSyDzrtFQOPSrsIU/tsQZTCP3Ca9wtNgYG0=
X-Google-Smtp-Source: AGHT+IHpy/nNKep/Hv/xm91sVTXHX+ZyMWWCokM5UK5OJI0ewQot3ENv/cK4nR2Bo0T7d0AZtOpA8g==
X-Received: by 2002:a05:600c:46d4:b0:40b:5e26:2373 with SMTP id q20-20020a05600c46d400b0040b5e262373mr1651327wmo.36.1701872028757;
        Wed, 06 Dec 2023 06:13:48 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c311200b0040b42df75fcsm22140330wmo.39.2023.12.06.06.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:13:47 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 4/7] bpf: implement BPF Static Keys support
Date: Wed,  6 Dec 2023 14:10:27 +0000
Message-Id: <20231206141030.1478753-5-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206141030.1478753-1-aspsk@isovalent.com>
References: <20231206141030.1478753-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF static keys are created as array maps with BPF_F_STATIC_KEY in the
map_flags and with the following parameters (any other combination is
considered invalid):

    map_type: BPF_MAP_TYPE_ARRAY
    key_size: 4
    value_size: 4
    max_entries: 1

Given such a map, a BPF program can use it to control a "static branch",
which is a JA +OFF instruction which can be toggled to become a JA +0 by
writing 0 or 1 to the map. One branch is described by the

    struct bpf_static_branch_info {
            __u32 map_fd;
            __u32 insn_offset;
            __u32 jump_target;
            __u32 flags;
    };

structure. Here map_fd should point to a corresponding static key,
insn_offset is the offset of a JA instruction, jump_target is the
[absolute] address of instruction to which the JA jumps. The flags can be
either 0 or BPF_F_INVERSE_BRANCH which lets users to specify one of two
types of static branches: normal one patched to NOP/JUMP when key is
zero/non-zero, the other is inverse. This may seem non-obvious why
we need both normal and inverse branches, the answer is that both
are required if we want to implement "unlikely" and "likely" branches
controlled by a static key, see the consequent patch which implements
libbpf support for BPF static keys.

On program load a list of branches described by the struct
bpf_static_branch_info are passed via new attributes:

    __aligned_u64 static_branches_info;
    __u32         static_branches_info_size;

This patch doesn't actually fully implement the functionality for any
architecture. To do so, one should implement a
bpf_arch_poke_static_branch() helper which implements text poking for
particular architecture. The arch-specific code should also configure the
internal representation of the static branch appropriately (fill in
arch-specific fields).

The verification of the new feature is straightforward: instead of going
one edge for JA instruction, insert two edges for the original JA and NOP
(i.e., JA +0) instructions.

In order not to pollute kernel/bpf/{syscall.c,verier.c} files with new code
a new kernel/bpf/skey.c file was added.

For more details on design of the feature see the following talk at Linux
Plumbers 2023: https://lpc.events/event/17/contributions/1608/

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 MAINTAINERS                    |   6 +
 include/linux/bpf.h            |  29 ++++
 include/uapi/linux/bpf.h       |  18 ++
 kernel/bpf/Makefile            |   2 +
 kernel/bpf/arraymap.c          |   2 +-
 kernel/bpf/core.c              |   9 +
 kernel/bpf/skey.c              | 306 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  46 ++++-
 kernel/bpf/verifier.c          |  88 +++++++++-
 tools/include/uapi/linux/bpf.h |  18 ++
 10 files changed, 511 insertions(+), 13 deletions(-)
 create mode 100644 kernel/bpf/skey.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 14e1194faa4b..e2f655980c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3887,6 +3887,12 @@ S:	Maintained
 F:	kernel/bpf/stackmap.c
 F:	kernel/trace/bpf_trace.c
 
+BPF [STATIC KEYS]
+M:	Anton Protopopov <aspsk@isovalent.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/skey.c
+
 BROADCOM ASP 2.0 ETHERNET DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8085780b7fcd..6985b4893191 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -289,8 +289,18 @@ struct bpf_map {
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	s64 __percpu *elem_count;
+	struct list_head static_key_list_head;
+	struct mutex static_key_mutex;
 };
 
+bool bpf_jit_supports_static_keys(void);
+struct bpf_static_branch *bpf_static_branch_by_offset(struct bpf_prog *bpf_prog,
+						      u32 offset);
+int bpf_prog_register_static_branches(struct bpf_prog *prog);
+int bpf_prog_init_static_branches(struct bpf_prog *prog, union bpf_attr *attr);
+int bpf_static_key_update(struct bpf_map *map, void *key, void *value, u64 flags);
+void bpf_static_key_remove_prog(struct bpf_map *map, struct bpf_prog_aux *aux);
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
@@ -1381,6 +1391,17 @@ struct btf_mod_pair {
 
 struct bpf_kfunc_desc_tab;
 
+struct bpf_static_branch {
+	struct bpf_map *map;
+	u32 flags;
+	u32 bpf_offset;
+	void *arch_addr;
+	u32 arch_len;
+	u8 bpf_jmp[8];
+	u8 arch_nop[8];
+	u8 arch_jmp[8];
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1473,6 +1494,8 @@ struct bpf_prog_aux {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct bpf_static_branch *static_branches;
+	u32 static_branches_len;
 };
 
 struct bpf_prog {
@@ -3176,6 +3199,9 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
 int bpf_arch_text_invalidate(void *dst, size_t len);
 
+int bpf_arch_poke_static_branch(struct bpf_prog *prog,
+				struct bpf_static_branch *branch, bool on);
+
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
@@ -3232,4 +3258,7 @@ struct bpf_prog_aux_list_elem {
 	struct bpf_prog_aux *aux;
 };
 
+int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map,
+			bool check_boundaries);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..2d3cf9175cf9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1325,6 +1325,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Treat this map as a BPF Static Key */
+	BPF_F_STATIC_KEY	= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1369,6 +1372,18 @@ struct bpf_stack_build_id {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+/* flags for bpf_static_branch_info */
+enum {
+	BPF_F_INVERSE_BRANCH = 1,
+};
+
+struct bpf_static_branch_info {
+	__u32 map_fd;			/* map in control */
+	__u32 insn_offset;		/* absolute offset of the branch instruction */
+	__u32 jump_target;		/* absolute offset of the jump target */
+	__u32 flags;
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1467,6 +1482,9 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		/* An array of struct bpf_static_branch_info */
+		__aligned_u64	static_branches_info;
+		__u32		static_branches_info_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..f0f0eb9acf18 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -46,3 +46,5 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
 	$(call if_changed_rule,cc_o_c)
+
+obj-$(CONFIG_BPF_SYSCALL) += skey.o
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7e6df6bd7e7a..f968489e1df8 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -17,7 +17,7 @@
 
 #define ARRAY_CREATE_FLAG_MASK \
 	(BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK | \
-	 BPF_F_PRESERVE_ELEMS | BPF_F_INNER_MAP)
+	 BPF_F_PRESERVE_ELEMS | BPF_F_INNER_MAP | BPF_F_STATIC_KEY)
 
 static void bpf_array_free_percpu(struct bpf_array *array)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 08626b519ce2..b10ffcb0a6e6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2670,6 +2670,8 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
 			map->ops->map_poke_untrack(map, aux);
+		if (map->map_flags & BPF_F_STATIC_KEY)
+			bpf_static_key_remove_prog(map, aux);
 		bpf_map_put(map);
 	}
 }
@@ -2927,6 +2929,13 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp,
 {
 }
 
+int __weak bpf_arch_poke_static_branch(struct bpf_prog *prog,
+				       struct bpf_static_branch *branch,
+				       bool on)
+{
+	return -EOPNOTSUPP;
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 static int __init bpf_global_ma_init(void)
 {
diff --git a/kernel/bpf/skey.c b/kernel/bpf/skey.c
new file mode 100644
index 000000000000..8f1915ba6d44
--- /dev/null
+++ b/kernel/bpf/skey.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Isovalent
+ */
+
+#include <linux/bpf.h>
+
+bool bpf_jit_supports_static_keys(void)
+{
+	int err;
+
+	/* Should return -EINVAL if supported */
+	err = bpf_arch_poke_static_branch(NULL, NULL, false);
+	return err != -EOPNOTSUPP;
+}
+
+struct bpf_static_branch *bpf_static_branch_by_offset(struct bpf_prog *bpf_prog, u32 offset)
+{
+	u32 i, n = bpf_prog->aux->static_branches_len;
+	struct bpf_static_branch *branch;
+
+	for (i = 0; i < n; i++) {
+		branch = &bpf_prog->aux->static_branches[i];
+		if (branch->bpf_offset == offset)
+			return branch;
+	}
+	return NULL;
+}
+
+static int bpf_prog_update_static_branches(struct bpf_prog *prog,
+					   const struct bpf_map *map, bool on)
+{
+	struct bpf_static_branch *branch;
+	int err = 0;
+	int i;
+
+	for (i = 0; i < prog->aux->static_branches_len; i++) {
+		branch = &prog->aux->static_branches[i];
+		if (branch->map != map)
+			continue;
+
+		err = bpf_arch_poke_static_branch(prog, branch, on);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int static_key_add_prog(struct bpf_map *map, struct bpf_prog *prog)
+{
+	struct bpf_prog_aux_list_elem *elem;
+	u32 key = 0;
+	int err = 0;
+	u32 *val;
+
+	mutex_lock(&map->static_key_mutex);
+
+	val = map->ops->map_lookup_elem(map, &key);
+	if (!val) {
+		err = -ENOENT;
+		goto unlock_ret;
+	}
+
+	list_for_each_entry(elem, &map->static_key_list_head, list)
+		if (elem->aux == prog->aux)
+			goto unlock_ret;
+
+	elem = kmalloc(sizeof(*elem), GFP_KERNEL);
+	if (!elem) {
+		err = -ENOMEM;
+		goto unlock_ret;
+	}
+
+	INIT_LIST_HEAD(&elem->list);
+	elem->aux = prog->aux;
+
+	list_add_tail(&elem->list, &map->static_key_list_head);
+
+	err = bpf_prog_update_static_branches(prog, map, *val);
+
+unlock_ret:
+	mutex_unlock(&map->static_key_mutex);
+	return err;
+}
+
+void bpf_static_key_remove_prog(struct bpf_map *map, struct bpf_prog_aux *aux)
+{
+	struct bpf_prog_aux_list_elem *elem, *tmp;
+
+	mutex_lock(&map->static_key_mutex);
+	list_for_each_entry_safe(elem, tmp, &map->static_key_list_head, list) {
+		if (elem->aux == aux) {
+			list_del_init(&elem->list);
+			kfree(elem);
+			break;
+		}
+	}
+	mutex_unlock(&map->static_key_mutex);
+}
+
+int bpf_static_key_update(struct bpf_map *map, void *key, void *value, u64 flags)
+{
+	struct bpf_prog_aux_list_elem *elem;
+	bool on = *(u32 *)value;
+	int err;
+
+	mutex_lock(&map->static_key_mutex);
+
+	err = map->ops->map_update_elem(map, key, value, flags);
+	if (err)
+		goto unlock_ret;
+
+	list_for_each_entry(elem, &map->static_key_list_head, list) {
+		err = bpf_prog_update_static_branches(elem->aux->prog, map, on);
+		if (err)
+			break;
+	}
+
+unlock_ret:
+	mutex_unlock(&map->static_key_mutex);
+	return err;
+}
+
+static bool init_static_jump_instruction(struct bpf_prog *prog,
+					 struct bpf_static_branch *branch,
+					 struct bpf_static_branch_info *branch_info)
+{
+	bool inverse = !!(branch_info->flags & BPF_F_INVERSE_BRANCH);
+	u32 insn_offset = branch_info->insn_offset;
+	u32 jump_target = branch_info->jump_target;
+	struct bpf_insn *jump_insn;
+	s32 jump_offset;
+
+	if (insn_offset % 8 || jump_target % 8)
+		return false;
+
+	if (insn_offset / 8 >= prog->len || jump_target / 8 >= prog->len)
+		return false;
+
+	jump_insn = &prog->insnsi[insn_offset / 8];
+	if (jump_insn->code != (BPF_JMP | BPF_JA) &&
+	    jump_insn->code != (BPF_JMP32 | BPF_JA))
+		return false;
+
+	if (jump_insn->dst_reg || jump_insn->src_reg)
+		return false;
+
+	if (jump_insn->off && jump_insn->imm)
+		return false;
+
+	jump_offset = ((long)jump_target - (long)insn_offset) / 8 - 1;
+
+	if (inverse) {
+		if (jump_insn->code == (BPF_JMP | BPF_JA)) {
+			if (jump_insn->off != jump_offset)
+				return false;
+		} else {
+			if (jump_insn->imm != jump_offset)
+				return false;
+		}
+	} else {
+		/* The instruction here should be JA 0. We will replace it by a
+		 * non-zero jump so that this is simpler to verify this program
+		 * (verifier might optimize out such instructions and we don't
+		 * want to care about this). After verification the instruction
+		 * will be set to proper value
+		 */
+		if (jump_insn->off || jump_insn->imm)
+			return false;
+
+		if (jump_insn->code == (BPF_JMP | BPF_JA))
+			jump_insn->off = jump_offset;
+		else
+			jump_insn->imm = jump_offset;
+	}
+
+	memcpy(branch->bpf_jmp, jump_insn, 8);
+	branch->bpf_offset = insn_offset;
+	return true;
+}
+
+static int
+__bpf_prog_init_static_branches(struct bpf_prog *prog,
+				struct bpf_static_branch_info *static_branches_info,
+				int n)
+{
+	size_t size = n * sizeof(*prog->aux->static_branches);
+	struct bpf_static_branch *static_branches;
+	struct bpf_map *map;
+	int i, err = 0;
+
+	static_branches = kzalloc(size, GFP_USER | __GFP_NOWARN);
+	if (!static_branches)
+		return -ENOMEM;
+
+	for (i = 0; i < n; i++) {
+		if (static_branches_info[i].flags & ~(BPF_F_INVERSE_BRANCH)) {
+			err = -EINVAL;
+			goto free_static_branches;
+		}
+		static_branches[i].flags = static_branches_info[i].flags;
+
+		if (!init_static_jump_instruction(prog, &static_branches[i],
+						  &static_branches_info[i])) {
+			err = -EINVAL;
+			goto free_static_branches;
+		}
+
+		map = bpf_map_get(static_branches_info[i].map_fd);
+		if (IS_ERR(map)) {
+			err = PTR_ERR(map);
+			goto free_static_branches;
+		}
+
+		if (!(map->map_flags & BPF_F_STATIC_KEY)) {
+			bpf_map_put(map);
+			err = -EINVAL;
+			goto free_static_branches;
+		}
+
+		err = __bpf_prog_bind_map(prog, map, true);
+		if (err) {
+			bpf_map_put(map);
+			if (err != -EEXIST)
+				goto free_static_branches;
+		}
+
+		static_branches[i].map = map;
+	}
+
+	prog->aux->static_branches = static_branches;
+	prog->aux->static_branches_len = n;
+
+	return 0;
+
+free_static_branches:
+	kfree(static_branches);
+	return err;
+}
+
+int bpf_prog_init_static_branches(struct bpf_prog *prog, union bpf_attr *attr)
+{
+	void __user *user_static_branches = u64_to_user_ptr(attr->static_branches_info);
+	size_t item_size = sizeof(struct bpf_static_branch_info);
+	struct bpf_static_branch_info *static_branches_info;
+	size_t size = attr->static_branches_info_size;
+	int err = 0;
+
+	if (!attr->static_branches_info)
+		return size ? -EINVAL : 0;
+	if (!size)
+		return -EINVAL;
+	if (size % item_size)
+		return -EINVAL;
+
+	if (!bpf_jit_supports_static_keys())
+		return -EOPNOTSUPP;
+
+	static_branches_info = kzalloc(size, GFP_USER | __GFP_NOWARN);
+	if (!static_branches_info)
+		return -ENOMEM;
+
+	if (copy_from_user(static_branches_info, user_static_branches, size)) {
+		err = -EFAULT;
+		goto free_branches;
+	}
+
+	err = __bpf_prog_init_static_branches(prog, static_branches_info,
+					      size / item_size);
+	if (err)
+		goto free_branches;
+
+	err = 0;
+
+free_branches:
+	kfree(static_branches_info);
+	return err;
+}
+
+int bpf_prog_register_static_branches(struct bpf_prog *prog)
+{
+	int n_branches = prog->aux->static_branches_len;
+	struct bpf_static_branch *branch;
+	int err;
+	u32 i;
+
+	for (i = 0; i < n_branches; i++) {
+		branch = &prog->aux->static_branches[i];
+
+		/* JIT compiler did not detect this branch
+		 * and thus won't be able to poke it when asked to
+		 */
+		if (!branch->arch_len)
+			return -EINVAL;
+	}
+
+	for (i = 0; i < n_branches; i++) {
+		branch = &prog->aux->static_branches[i];
+		err = static_key_add_prog(branch->map, prog);
+		if (err)
+			break;
+	}
+
+	return 0;
+}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 81625ef98a7d..a85ade499e45 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -197,6 +197,10 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		   map->map_type == BPF_MAP_TYPE_STACK ||
 		   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
 		err = map->ops->map_push_elem(map, value, flags);
+	} else if (map->map_flags & BPF_F_STATIC_KEY) {
+		rcu_read_lock();
+		err = bpf_static_key_update(map, key, value, flags);
+		rcu_read_unlock();
 	} else {
 		rcu_read_lock();
 		err = map->ops->map_update_elem(map, key, value, flags);
@@ -1096,6 +1100,16 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
+static bool is_static_key(u32 map_type, u32 key_size, u32 value_size,
+			    u32 max_entries, u32 map_flags)
+{
+	return map_type == BPF_MAP_TYPE_ARRAY &&
+	       key_size == 4 &&
+	       value_size == 4 &&
+	       max_entries == 1 &&
+	       map_flags & BPF_F_STATIC_KEY;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1104,6 +1118,7 @@ static int map_create(union bpf_attr *attr)
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
+	bool static_key;
 	int f_flags;
 	int err;
 
@@ -1123,6 +1138,13 @@ static int map_create(union bpf_attr *attr)
 	    attr->map_extra != 0)
 		return -EINVAL;
 
+	static_key = is_static_key(attr->map_type, attr->key_size, attr->value_size,
+				   attr->max_entries, attr->map_flags);
+	if (static_key && !bpf_jit_supports_static_keys())
+		return -EOPNOTSUPP;
+	if (!static_key && (attr->map_flags & BPF_F_STATIC_KEY))
+		return -EINVAL;
+
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
 		return f_flags;
@@ -1221,7 +1243,9 @@ static int map_create(union bpf_attr *attr)
 	atomic64_set(&map->refcnt, 1);
 	atomic64_set(&map->usercnt, 1);
 	mutex_init(&map->freeze_mutex);
+	mutex_init(&map->static_key_mutex);
 	spin_lock_init(&map->owner.lock);
+	INIT_LIST_HEAD(&map->static_key_list_head);
 
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
@@ -2366,7 +2390,7 @@ struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 }
 EXPORT_SYMBOL_GPL(bpf_prog_get_type_dev);
 
-static int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map)
+int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map, bool check_boundaries)
 {
 	struct bpf_map **used_maps_new;
 	int i;
@@ -2375,6 +2399,13 @@ static int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map)
 		if (prog->aux->used_maps[i] == map)
 			return -EEXIST;
 
+	/*
+	 * This is ok to add more maps after the program is loaded, but not
+	 * before bpf_check, as verifier env only has MAX_USED_MAPS slots
+	 */
+	if (check_boundaries && prog->aux->used_map_cnt >= MAX_USED_MAPS)
+		return -E2BIG;
+
 	used_maps_new = krealloc_array(prog->aux->used_maps,
 				       prog->aux->used_map_cnt + 1,
 				       sizeof(used_maps_new[0]),
@@ -2388,6 +2419,7 @@ static int __bpf_prog_bind_map(struct bpf_prog *prog, struct bpf_map *map)
 	return 0;
 }
 
+
 /* Initially all BPF programs could be loaded w/o specifying
  * expected_attach_type. Later for some of them specifying expected_attach_type
  * at load time became required so that program could be validated properly.
@@ -2576,7 +2608,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define	BPF_PROG_LOAD_LAST_FIELD static_branches_info_size
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
@@ -2734,6 +2766,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_prog_sec;
 
+	err = bpf_prog_init_static_branches(prog, attr);
+	if (err < 0)
+		goto free_prog_sec;
+
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
 	if (err < 0)
@@ -2743,6 +2779,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_used_maps;
 
+	err = bpf_prog_register_static_branches(prog);
+	if (err < 0)
+		goto free_used_maps;
+
 	err = bpf_prog_alloc_id(prog);
 	if (err)
 		goto free_used_maps;
@@ -5326,7 +5366,7 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	}
 
 	mutex_lock(&prog->aux->used_maps_mutex);
-	ret = __bpf_prog_bind_map(prog, map);
+	ret = __bpf_prog_bind_map(prog, map, false);
 	mutex_unlock(&prog->aux->used_maps_mutex);
 
 	if (ret)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5d38ee2e74a1..6b591f4a01c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15534,6 +15534,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
+	struct bpf_static_branch *branch;
 	int ret, off;
 
 	if (bpf_pseudo_func(insn))
@@ -15587,15 +15588,26 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		else
 			off = insn->imm;
 
-		/* unconditional jump with single edge */
-		ret = push_insn(t, t + off + 1, FALLTHROUGH, env,
-				true);
-		if (ret)
-			return ret;
+		branch = bpf_static_branch_by_offset(env->prog, t * 8);
+		if (unlikely(branch)) {
+			/* static branch with two edges */
+			mark_prune_point(env, t);
 
-		mark_prune_point(env, t + off + 1);
-		mark_jmp_point(env, t + off + 1);
+			ret = push_insn(t, t + 1, FALLTHROUGH, env, true);
+			if (ret)
+				return ret;
+
+			ret = push_insn(t, t + off + 1, BRANCH, env, true);
+		} else {
+			/* unconditional jump with single edge */
+			ret = push_insn(t, t + off + 1, FALLTHROUGH, env,
+					true);
+			if (ret)
+				return ret;
 
+			mark_prune_point(env, t + off + 1);
+			mark_jmp_point(env, t + off + 1);
+		}
 		return ret;
 
 	default:
@@ -17547,6 +17559,10 @@ static int do_check(struct bpf_verifier_env *env)
 
 				mark_reg_scratched(env, BPF_REG_0);
 			} else if (opcode == BPF_JA) {
+				struct bpf_verifier_state *other_branch;
+				struct bpf_static_branch *branch;
+				u32 jmp_offset;
+
 				if (BPF_SRC(insn->code) != BPF_K ||
 				    insn->src_reg != BPF_REG_0 ||
 				    insn->dst_reg != BPF_REG_0 ||
@@ -17557,9 +17573,20 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 
 				if (class == BPF_JMP)
-					env->insn_idx += insn->off + 1;
+					jmp_offset = insn->off + 1;
 				else
-					env->insn_idx += insn->imm + 1;
+					jmp_offset = insn->imm + 1;
+
+				branch = bpf_static_branch_by_offset(env->prog, env->insn_idx * 8);
+				if (unlikely(branch)) {
+					other_branch = push_stack(env, env->insn_idx + jmp_offset,
+								  env->insn_idx, false);
+					if (!other_branch)
+						return -EFAULT;
+
+					jmp_offset = 1;
+				}
+				env->insn_idx += jmp_offset;
 				continue;
 
 			} else if (opcode == BPF_EXIT) {
@@ -17854,6 +17881,11 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
+	if (map->map_flags & BPF_F_STATIC_KEY) {
+		verbose(env, "progs cannot access static keys yet\n");
+		return -EINVAL;
+	}
+
 	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
 	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
@@ -18223,6 +18255,25 @@ static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
 	}
 }
 
+static void adjust_static_branches(struct bpf_prog *prog, u32 off, u32 len)
+{
+	struct bpf_static_branch *branch;
+	const u32 delta = (len - 1) * 8; /* # of new prog bytes */
+	int i;
+
+	if (len <= 1)
+		return;
+
+	for (i = 0; i < prog->aux->static_branches_len; i++) {
+		branch = &prog->aux->static_branches[i];
+		if (branch->bpf_offset <= off * 8)
+			continue;
+
+		branch->bpf_offset += delta;
+		memcpy(branch->bpf_jmp, &prog->insnsi[branch->bpf_offset/8], 8);
+	}
+}
+
 static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 					    const struct bpf_insn *patch, u32 len)
 {
@@ -18249,6 +18300,7 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
 	adjust_func_info(env, off, len);
 	adjust_subprog_starts(env, off, len);
 	adjust_poke_descs(new_prog, off, len);
+	adjust_static_branches(new_prog, off, len);
 	return new_prog;
 }
 
@@ -18914,6 +18966,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		func[i]->aux->static_branches = prog->aux->static_branches;
+		func[i]->aux->static_branches_len = prog->aux->static_branches_len;
+
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
@@ -20704,6 +20759,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
 	is_priv = bpf_capable();
 
+	/* the program could already have referenced some maps */
+	if (env->prog->aux->used_map_cnt) {
+		if (WARN_ON(env->prog->aux->used_map_cnt > MAX_USED_MAPS ||
+			    !env->prog->aux->used_maps))
+			return -EFAULT;
+
+		memcpy(env->used_maps, env->prog->aux->used_maps,
+		       sizeof(env->used_maps[0]) * env->prog->aux->used_map_cnt);
+		env->used_map_cnt = env->prog->aux->used_map_cnt;
+
+		kfree(env->prog->aux->used_maps);
+		env->prog->aux->used_map_cnt = 0;
+		env->prog->aux->used_maps = NULL;
+	}
+
 	bpf_get_btf_vmlinux();
 
 	/* grab the mutex to protect few globals used by verifier */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..2d3cf9175cf9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1325,6 +1325,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Treat this map as a BPF Static Key */
+	BPF_F_STATIC_KEY	= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1369,6 +1372,18 @@ struct bpf_stack_build_id {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+/* flags for bpf_static_branch_info */
+enum {
+	BPF_F_INVERSE_BRANCH = 1,
+};
+
+struct bpf_static_branch_info {
+	__u32 map_fd;			/* map in control */
+	__u32 insn_offset;		/* absolute offset of the branch instruction */
+	__u32 jump_target;		/* absolute offset of the jump target */
+	__u32 flags;
+};
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1467,6 +1482,9 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
+		/* An array of struct bpf_static_branch_info */
+		__aligned_u64	static_branches_info;
+		__u32		static_branches_info_size;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.34.1


