Return-Path: <bpf+bounces-54315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9EA67668
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCD4228A5
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BB20E01D;
	Tue, 18 Mar 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TA42wgJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173520E319
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308196; cv=none; b=J1wX5AkVzV2N5W+NwMYGVYVpr0rT4aXCn8Z+OztPPIX+eGuPHZndLxkaySEXvLeJ4lgZwL3t5PIjNIfbJdk56p60YxBhRHRZ26oFR2/Vu70TBs1NLdDDjmVV1k9xSzOxSvoC6Lb9pcGqrx08yKXMb/rpYz2FhAoKe3h/UBIwnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308196; c=relaxed/simple;
	bh=e+ALpF+2hjxlZnhSlSyqW9N4MXf/9gZ8sklCqIPN97w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ly/nclI3Exy8HS8tuiSYmZFdMDyv+m1alXfL/ZeEXzb7DUsMd2RP3DgFU+JGmCfjI2Zcmsdbo6Jywbxndn2O2SMXuW+2b+NUPTQQin4F2Iws9ruh3Kt+kBREAE77WEM305gwm0mh+rA1y4q1vSVXn+rklQBpRv1el3DStrqrRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TA42wgJz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3112535f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308193; x=1742912993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yIHhOTBmXRFrcEBcM58B53THvexekzxpRQQqRcX9Ak=;
        b=TA42wgJzX7ypqSx/Qb028ZkKda7+oBpk1RGCKmfheg7/QTwMaUmsEiV9RTh2/zqajk
         jEhu4er6jUEPfQNQdt3gnTo6cN6vaAeo3EHAhahYz2e6SUAI//KUEhAGYv1Sd6L8mkaI
         YoYSCydeZMTE3wcbwAUSSigNKnJOglAFVE2VLxjjtHGFQY/0lATKolqdRkjYlSAQaYEM
         4YGwIOQBC0a7qPXmeH3b+R9xVs+tWKo7+evObba6/58VfGt1JJ3Vqi8OW3Js02SIiYQZ
         9vSI22ALk6r2uywbQRxI+kgdzuCmeCX/0eEdCOcBJOHiKFjPdVhP1j31c2YqUS17zff0
         Xy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308193; x=1742912993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yIHhOTBmXRFrcEBcM58B53THvexekzxpRQQqRcX9Ak=;
        b=ALeHAgFs6GPhfUXbMe84Ifwai3AiTDg1KX2bP40G3YucXlhJgF5QQJ1mRb9W3Adi62
         eP0a2youDsuDwVm7aJBt0zOJqql5NuVPKFDiTOaf4hyyfrfRnco4Yt6ZnH/XVAIiy6L3
         MHYrbQsctJItyk+x/GqsUjRhy2aEaXukEWixTcsYhZct2ekryX3RJknpW814dDN0fdP8
         SbeEQUzawD0SWTEWI2Oz3Noc3KiTP5wNcxHENeRZzSpUNhV3JYeVGiWKTQmO67ORUn+I
         JF5my0TF27TaScAnz5BACP2HZ5gXsgg4bNe5BXBPL76XXWJQfYQ65W6MYT441VZPvcvA
         bynQ==
X-Gm-Message-State: AOJu0YxMPx3MsB9s1T51TkBFnGekDEZc8y6ElU8Wtv8Vv5K8/p1LrVNp
	BFD5L0OKkOhfKO4bRx7DvTgqday7gNjO4GDyRXSGAOqrN+tD2G5vo5hfRpVFWAAlstkac27LXM3
	i
X-Gm-Gg: ASbGncv/liWz32B4DJcNNLxWq+i04BE++AuE43KvZRy0aEqxjcwS/TNZDseovFvYv5l
	vdZ49UFx1Kmmer6HsgvxK1SklEu+mqVWS29zQtSKyRcMFDoy1Ez+WrUtx7yaY66jKu6pmEYHB9B
	dktWANe7DFZjiuyGPNnp7UZ9OjgJuic1gFQUhCzf3+AXze50Tvlws3RXW6AHQJV7Fm1od8kBpHz
	xNbAZjgXq/YH5C2nLncnDXBJu1Jxy9qUuG1Ud9coacbu0CFkvD7bl5eP4S+n1TcNey1ggI0nMBZ
	4oQlUfH7OyjnZsSyvzkX6SEUd2/qGFy3Uqu30sKflzbn5cC9zDvqxRWqnw==
X-Google-Smtp-Source: AGHT+IHYMG2egFUNdE6zvkl7TxShiH7lmG39OaweczGcpB3O2EReaIlbM/AReMpyIhHQLBz4gEMhvg==
X-Received: by 2002:a5d:5f47:0:b0:391:2e0f:efec with SMTP id ffacd0b85a97d-3971ddd6136mr19123323f8f.7.1742308191988;
        Tue, 18 Mar 2025 07:29:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:51 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 06/14] bpf: add BPF_STATIC_KEY_UPDATE syscall
Date: Tue, 18 Mar 2025 14:33:10 +0000
Message-Id: <20250318143318.656785-7-aspsk@isovalent.com>
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

Add a new bpf system call, BPF_STATIC_KEY_UPDATE, which allows users
to update static keys in BPF. Namely, this system call is executed as

    bpf(BPF_STATIC_KEY_UPDATE, attrs={map_fd, on})

where map_fd is a BPF static key, i.e., a map of type BPF_MAP_TYPE_INSN_SET
which points to one or more goto_or_nop/nop_or_goto instructions. The "on"
parameter is a boolean value to set this key on or off. if it is true/false,
then goto_or_nop/nop_or_goto instructions controlled by the key are jitted to
jump/nop, correspondingly.

To implement this for a particular architecture, re-define the weak
bpf_arch_poke_static_branch() function in the corresponding bpf_jit_comp.c

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h            |  16 +++++
 include/uapi/linux/bpf.h       |  27 +++++++
 kernel/bpf/bpf_insn_set.c      | 124 +++++++++++++++++++++++++++++++--
 kernel/bpf/core.c              |   5 ++
 kernel/bpf/syscall.c           |  27 +++++++
 tools/include/uapi/linux/bpf.h |  27 +++++++
 6 files changed, 220 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0b5f4d4745ee..42ddd2b61866 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3561,8 +3561,24 @@ void bpf_insn_set_adjust(struct bpf_map *map, u32 off, u32 len);
 void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
 
 struct bpf_insn_ptr {
+	void *jitted_ip;
+	u32 jitted_off;
+	u32 jitted_len;
+	int jitted_jump_offset;
+
 	u32 orig_xlated_off;
 	u32 xlated_off;
+	bool inverse_ja_or_nop;
 };
 
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      u32 jitted_len,
+			      int jitted_jump_offset,
+			      void *jitted_ip);
+
+int bpf_static_key_set(struct bpf_map *map, bool on);
+int bpf_arch_poke_static_branch(struct bpf_insn_ptr *ptr, bool on);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 57e0fd636a27..7c4954f93d44 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,19 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_STATIC_KEY_UPDATE
+ *	Description
+ *		Turn a static key on/off: update jitted code for the specified
+ *		jump instructions controlled by the *map_fd* static key.
+ *		Depending on the type of instruction (goto_or_nop/nop_or_goto)
+ *		and the *on* parameter the binary code of each instruction is
+ *		set to either jump or nop.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +974,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_STATIC_KEY_UPDATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1853,6 +1867,11 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_STATIC_KEY_UPDATE command */
+		__u32		map_fd;
+		__u32		on;
+	} static_key;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
@@ -7551,4 +7570,12 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Flags to control creation of BPF Instruction Sets
+ *     - BPF_F_STATIC_KEY: Map will be used as a Static Key.
+ */
+enum bpf_insn_set_flags {
+	BPF_F_STATIC_KEY = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/bpf_insn_set.c b/kernel/bpf/bpf_insn_set.c
index e788dd7109b1..40df7bfcd0be 100644
--- a/kernel/bpf/bpf_insn_set.c
+++ b/kernel/bpf/bpf_insn_set.c
@@ -33,7 +33,8 @@ static int insn_set_alloc_check(union bpf_attr *attr)
 	if (attr->max_entries == 0 ||
 	    attr->key_size != 4 ||
 	    attr->value_size != 4 ||
-	    attr->map_flags != 0)
+	    attr->map_flags != 0 ||
+	    attr->map_extra & ~BPF_F_STATIC_KEY)
 		return -EINVAL;
 
 	if (attr->max_entries > MAX_ISET_ENTRIES)
@@ -176,6 +177,30 @@ static inline bool is_frozen(struct bpf_map *map)
 	return ret;
 }
 
+static bool is_static_key(const struct bpf_map *map)
+{
+	if (map->map_type != BPF_MAP_TYPE_INSN_SET)
+		return false;
+
+	if (!(map->map_extra & BPF_F_STATIC_KEY))
+		return false;
+
+	return true;
+}
+
+static bool is_ja_or_nop(const struct bpf_insn *insn)
+{
+	u8 code = insn->code;
+
+	return (code == (BPF_JMP | BPF_JA) || code == (BPF_JMP32 | BPF_JA)) &&
+		(insn->src_reg & BPF_STATIC_BRANCH_JA);
+}
+
+static bool is_inverse_ja_or_nop(const struct bpf_insn *insn)
+{
+	return insn->src_reg & BPF_STATIC_BRANCH_NOP;
+}
+
 static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
 				 const struct bpf_prog *prog)
 {
@@ -188,16 +213,17 @@ static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
 		if (off >= prog->len)
 			return false;
 
-		if (off > 0) {
-			if (prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
-				return false;
-		}
+		if (off > 0 && prog->insnsi[off-1].code == (BPF_LD | BPF_DW | BPF_IMM))
+			return false;
 
 		if (i > 0) {
 			prev_off = insn_set->ptrs[i-1].orig_xlated_off;
 			if (off <= prev_off)
 				return false;
 		}
+
+		if (is_static_key(&insn_set->map) && !is_ja_or_nop(&prog->insnsi[off]))
+			return false;
 	}
 
 	return true;
@@ -206,6 +232,7 @@ static inline bool valid_offsets(const struct bpf_insn_set *insn_set,
 int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
 {
 	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	const struct bpf_insn *insn;
 	int i;
 
 	if (!is_frozen(map))
@@ -228,11 +255,16 @@ int bpf_insn_set_init(struct bpf_map *map, const struct bpf_prog *prog)
 	/*
 	 * Reset all the map indexes to the original values.  This is needed,
 	 * e.g., when a replay of verification with different log level should
-	 * be performed.
+	 * be performed
 	 */
 	for (i = 0; i < map->max_entries; i++)
 		insn_set->ptrs[i].xlated_off = insn_set->ptrs[i].orig_xlated_off;
 
+	for (i = 0; i < map->max_entries; i++) {
+		insn = &prog->insnsi[insn_set->ptrs[i].xlated_off];
+		insn_set->ptrs[i].inverse_ja_or_nop = is_inverse_ja_or_nop(insn);
+	}
+
 	return 0;
 }
 
@@ -286,3 +318,83 @@ void bpf_insn_set_adjust_after_remove(struct bpf_map *map, u32 off, u32 len)
 			insn_set->ptrs[i].xlated_off -= len;
 	}
 }
+
+static struct bpf_insn_ptr *insn_ptr_by_offset(struct bpf_prog *prog, u32 xlated_off)
+{
+	struct bpf_insn_set *insn_set;
+	struct bpf_map *map;
+	int i, j;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++) {
+		map = prog->aux->used_maps[i];
+		if (!is_static_key(map))
+			continue;
+
+		insn_set = cast_insn_set(map);
+		for (j = 0; j < map->max_entries; j++) {
+			if (insn_set->ptrs[j].xlated_off == xlated_off)
+				return &insn_set->ptrs[j];
+		}
+	}
+
+	return NULL;
+}
+
+void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
+			      u32 xlated_off,
+			      u32 jitted_off,
+			      u32 jitted_len,
+			      int jitted_jump_offset,
+			      void *jitted_ip)
+{
+	struct bpf_insn_ptr *ptr;
+
+	ptr = insn_ptr_by_offset(prog, xlated_off);
+	if (ptr) {
+		ptr->jitted_ip = jitted_ip;
+		ptr->jitted_off = jitted_off;
+		ptr->jitted_len = jitted_len;
+		ptr->jitted_jump_offset = jitted_jump_offset;
+	}
+}
+
+static int check_state(struct bpf_insn_set *insn_set)
+{
+	int ret = 0;
+
+	mutex_lock(&insn_set->state_mutex);
+	if (insn_set->state == INSN_SET_STATE_FREE)
+		ret = -EINVAL;
+	if (insn_set->state == INSN_SET_STATE_INIT)
+		ret = -EBUSY;
+	mutex_unlock(&insn_set->state_mutex);
+
+	return ret;
+}
+
+int bpf_static_key_set(struct bpf_map *map, bool on)
+{
+	struct bpf_insn_set *insn_set = cast_insn_set(map);
+	struct bpf_insn_ptr *ptr;
+	int ret = 0;
+	int i;
+
+	if (!is_static_key(map))
+		return -EINVAL;
+
+	ret = check_state(insn_set);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < map->max_entries && ret == 0; i++) {
+		ptr = &insn_set->ptrs[i];
+		if (ptr->xlated_off == INSN_DELETED)
+			continue;
+
+		ret = bpf_arch_poke_static_branch(ptr, on ^ ptr->inverse_ja_or_nop);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 62cb9557ad3b..5c3afbae8ab0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3173,6 +3173,11 @@ static int __init bpf_global_ma_init(void)
 late_initcall(bpf_global_ma_init);
 #endif
 
+int __weak bpf_arch_poke_static_branch(struct bpf_insn_ptr *ptr, bool on)
+{
+	return -EOPNOTSUPP;
+}
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c417bf5eed74..af9d46aea93a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1346,6 +1346,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    attr->map_type != BPF_MAP_TYPE_INSN_SET &&
 	    attr->map_extra != 0)
 		return -EINVAL;
 
@@ -1691,6 +1692,29 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_STATIC_KEY_UPDATE_LAST_FIELD static_key.on
+
+static int bpf_static_key_update(const union bpf_attr *attr)
+{
+	bool on = attr->static_key.on & 1;
+	struct bpf_map *map;
+	int ret;
+
+	if (CHECK_ATTR(BPF_STATIC_KEY_UPDATE))
+		return -EINVAL;
+
+	if (attr->static_key.on & ~1)
+		return -EINVAL;
+
+	map = bpf_map_get(attr->static_key.map_fd);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	ret = bpf_static_key_set(map, on);
+
+	bpf_map_put(map);
+	return ret;
+}
 
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
@@ -5908,6 +5932,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_STATIC_KEY_UPDATE:
+		err = bpf_static_key_update(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 57e0fd636a27..7c4954f93d44 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,19 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_STATIC_KEY_UPDATE
+ *	Description
+ *		Turn a static key on/off: update jitted code for the specified
+ *		jump instructions controlled by the *map_fd* static key.
+ *		Depending on the type of instruction (goto_or_nop/nop_or_goto)
+ *		and the *on* parameter the binary code of each instruction is
+ *		set to either jump or nop.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -961,6 +974,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_STATIC_KEY_UPDATE,
 	__MAX_BPF_CMD,
 };
 
@@ -1853,6 +1867,11 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_STATIC_KEY_UPDATE command */
+		__u32		map_fd;
+		__u32		on;
+	} static_key;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
@@ -7551,4 +7570,12 @@ enum bpf_kfunc_flags {
 	BPF_F_PAD_ZEROS = (1ULL << 0),
 };
 
+/*
+ * Flags to control creation of BPF Instruction Sets
+ *     - BPF_F_STATIC_KEY: Map will be used as a Static Key.
+ */
+enum bpf_insn_set_flags {
+	BPF_F_STATIC_KEY = (1ULL << 0),
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.34.1


