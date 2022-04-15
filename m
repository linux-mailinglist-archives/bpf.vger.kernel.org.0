Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C033502D6D
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355239AbiDOQGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiDOQGi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6DA9D4DB
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 22so1183625pfu.1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptZDxZ/0Pslyv2zeFLcwnB8PQS609ggrJ2E+mEOUJx0=;
        b=KlMVRwvI0dD5GtXv3y6gvESjPNdR8/MIU4VtTmSlSR4gW1XDe0sgJlkmgX3wRiaZ+A
         WIr4+jm6+0s1yx3sGN3+Z9/eJStVK8p6LJRPWg0jflaeYH0SYaflIuyOiebv7h1p7/lh
         x9oAoGT9aazeqZY5SR7d/6gylL3qx4fCdT8nxFSTo6SPyYf3U13a+zHPnaNNtI9C9yua
         SaEfiHY1QN+5J+zsvNY/3JPdXHcAely5AavH0/4BOzmLkrRFIYIO4CSce6aHvCdXW8ve
         g7S7Y/68w1xSF8B02AVz90ZxVWHlfoypQFukhrb2PEp/z5N/zZlZouKvFZSqjh95cFwW
         Q/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptZDxZ/0Pslyv2zeFLcwnB8PQS609ggrJ2E+mEOUJx0=;
        b=06I3jmrfcixJ178GTAXvZGh/3rtcGsKR5kNyNDppS5C0lI8EpvsyZksrp/TlgMGyk5
         O5+FXr4wBo10bxwv24+svXeVEztQmKnq1vXItue+DI8X/gUQsr0ZOZS3idn6tVFC+xtG
         vYvIFpqAQ/Yna1QJ3dnaxSEQx/waUYH2BNvhHeiKt8XXHwhS/JvzX4BuqXaIr+6ccAE+
         dcTiocX/Nqa5AFCJ92hGnqKDKEyWSnuhDgfWec1UB47lqOpnWWlxeYqca48yBR/XX55P
         0Hb/Wf0C+A0E4f9DP7G2hJeqxUb8coaneTNt61M5qdPDKhdjk4pEXbwqOW4wkfSnFXeM
         0nXw==
X-Gm-Message-State: AOAM532znsIZ3mf4zZpZyGYwxYYoi2x2O0kkmu+hlgXg2lzbcWbQ4QDX
        Dp4d6IQPanCVeTlO+m5eOc1xzlPvrpI=
X-Google-Smtp-Source: ABdhPJxxdJjGLYW7vM9cMxTdGj09lsTP+cWJqObs8K/g84Z7VoQ7iP3sBpzrMfdLWlZsZEBtP59Zdg==
X-Received: by 2002:a05:6a00:1988:b0:4fa:c15d:190d with SMTP id d8-20020a056a00198800b004fac15d190dmr9361792pfl.44.1650038648202;
        Fri, 15 Apr 2022 09:04:08 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00135100b004fa9df39517sm3313241pfu.198.2022.04.15.09.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:07 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 03/13] bpf: Allow storing unreferenced kptr in map
Date:   Fri, 15 Apr 2022 21:33:44 +0530
Message-Id: <20220415160354.1050687-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29293; h=from:subject; bh=Js8+S+het7VU8qZBPyNg1y5tpcNHy9xZ4SLPKNMidS0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdBUkiLwBPTa4AwV34o4rwxX7m2DSlw3LMDmtpA cQ3/PUmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQQAKCRBM4MiGSL8RygRXEA CWZqkFne2IjC8NDYoW1snq54oCJ8AXspgjHEwIGLiRyRbbQLqdNWfP6S2Ctrv94LADS+bjr0o09y1x Yq3Whot2fKZa/1LH2QxqJuMQH9yLOLLFcZtESTpPQRWACip9JkRWiIikkmhbT6dN6J4PeqTZsYRUzD BKwTFIMMYuBOje1Pz5VbgqkZPMyBdVfbnDOISLITDeK1HWc+yo8zLkHWOjP3I2oZst4Dl/6PoGrHNk 6n+QBS8FWN8mazw4kSeVkl/g6xylF7vqHFRqivrsbgkc0PtuopV8HZPBI68CWbcSC22tLxgSovyu3q 41EopK5aybV1zCZa5kACbu3ZLjXwWSiIrN5qcd7qXcypfCGw6YS44wvXLEfTA+xrqUA17fcx7No6fv AhBcVLeqfq6EtJm0WjmRkxo5G9v1/OGaPh7ejl4Vj5ufFSKdqmfMwhd6mcH32L30uQHHS6oUzRzrdw tEqyH7fqv4KOmNXBA3iZV32AkxXU/7tQylqQbfcvEP3bgIsk1+uqiX4jsG4TpPjxvzasNddjjq5lSq 05bhWqP95sF0xjrprfNqQCtfdU3Ivk5Ka2A/rxKET28WnXN01B3s7BSurQglpPrqeDF1nn+90aU8tA 3b3x5TO2LXz4GDe8Owqt0f9T6N9pnSvBetehkZ8jDoamhil4FlNPHn+WkK/A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces a new pointer type 'kptr' which can be embedded
in a map value to hold a PTR_TO_BTF_ID stored by a BPF program during
its invocation. When storing such a kptr, BPF program's PTR_TO_BTF_ID
register must have the same type as in the map value's BTF, and loading
a kptr marks the destination register as PTR_TO_BTF_ID with the correct
kernel BTF and BTF ID.

Such kptr are unreferenced, i.e. by the time another invocation of the
BPF program loads this pointer, the object which the pointer points to
may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
patched to PROBE_MEM loads by the verifier, it would safe to allow user
to still access such invalid pointer, but passing such pointers into
BPF helpers and kfuncs should not be permitted. A future patch in this
series will close this gap.

The flexibility offered by allowing programs to dereference such invalid
pointers while being safe at runtime frees the verifier from doing
complex lifetime tracking. As long as the user may ensure that the
object remains valid, it can ensure data read by it from the kernel
object is valid.

The user indicates that a certain pointer must be treated as kptr
capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
information is recorded in the object BTF which will be passed into the
kernel by way of map's BTF information. The name and kind from the map
value BTF is used to look up the in-kernel type, and the actual BTF and
BTF ID is recorded in the map struct in a new kptr_off_tab member. For
now, only storing pointers to structs is permitted.

An example of this specification is shown below:

	#define __kptr __attribute__((btf_type_tag("kptr")))

	struct map_value {
		...
		struct task_struct __kptr *task;
		...
	};

Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
task_struct into the map, and then load it later.

Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
the verifier cannot know whether the value is NULL or not statically, it
must treat all potential loads at that map value offset as loading a
possibly NULL pointer.

Only BPF_LDX, BPF_STX, and BPF_ST (with insn->imm = 0 to denote NULL)
are allowed instructions that can access such a pointer. On BPF_LDX, the
destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
it is checked whether the source register type is a PTR_TO_BTF_ID with
same BTF type as specified in the map BTF. The access size must always
be BPF_DW.

For the map in map support, the kptr_off_tab for outer map is copied
from the inner map's kptr_off_tab. It was chosen to do a deep copy
instead of introducing a refcount to kptr_off_tab, because the copy only
needs to be done when paramterizing using inner_map_fd in the map in map
case, hence would be unnecessary for all other users.

It is not permitted to use MAP_FREEZE command and mmap for BPF map
having kptrs, similar to the bpf_timer case. A kptr also requires that
BPF program has both read and write access to the map (hence both
BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG are disallowed).

Note that check_map_access must be called from both
check_helper_mem_access and for the BPF instructions, hence the kptr
check must distinguish between ACCESS_DIRECT and ACCESS_HELPER, and
reject ACCESS_HELPER cases. We rename stack_access_src to bpf_access_src
and reuse it for this purpose.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h     |  31 +++++++-
 include/linux/btf.h     |   2 +
 kernel/bpf/btf.c        | 167 +++++++++++++++++++++++++++++++++++-----
 kernel/bpf/map_in_map.c |   5 +-
 kernel/bpf/syscall.c    | 113 ++++++++++++++++++++++++++-
 kernel/bpf/verifier.c   | 139 ++++++++++++++++++++++++++++++---
 6 files changed, 421 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..ab86f4675db2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,24 @@ struct bpf_map_ops {
 	const struct bpf_iter_seq_info *iter_seq_info;
 };
 
+enum {
+	/* Support at most 8 pointers in a BPF map value */
+	BPF_MAP_VALUE_OFF_MAX = 8,
+};
+
+struct bpf_map_value_off_desc {
+	u32 offset;
+	struct {
+		struct btf *btf;
+		u32 btf_id;
+	} kptr;
+};
+
+struct bpf_map_value_off {
+	u32 nr_off;
+	struct bpf_map_value_off_desc off[];
+};
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -171,6 +189,7 @@ struct bpf_map {
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	int spin_lock_off; /* >=0 valid offset, <0 error */
+	struct bpf_map_value_off *kptr_off_tab;
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
@@ -184,7 +203,7 @@ struct bpf_map {
 	char name[BPF_OBJ_NAME_LEN];
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 14 bytes hole */
+	/* 6 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
@@ -217,6 +236,11 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
 	return map->timer_off >= 0;
 }
 
+static inline bool map_value_has_kptrs(const struct bpf_map *map)
+{
+	return !IS_ERR_OR_NULL(map->kptr_off_tab);
+}
+
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
@@ -1497,6 +1521,11 @@ void bpf_prog_put(struct bpf_prog *prog);
 void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
 
+struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
+void bpf_map_free_kptr_off_tab(struct bpf_map *map);
+struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
+bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
+
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 36bc09b8e890..19c297f9a52f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -123,6 +123,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
+struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
+					  const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e2efc81a5ec3..be191df76ea4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3166,9 +3166,16 @@ static void btf_struct_log(struct btf_verifier_env *env,
 enum btf_field_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
+	BTF_FIELD_KPTR,
+};
+
+enum {
+	BTF_FIELD_IGNORE = 0,
+	BTF_FIELD_FOUND  = 1,
 };
 
 struct btf_field_info {
+	u32 type_id;
 	u32 off;
 };
 
@@ -3176,29 +3183,57 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 			   u32 off, int sz, struct btf_field_info *info)
 {
 	if (!__btf_type_is_struct(t))
-		return 0;
+		return BTF_FIELD_IGNORE;
 	if (t->size != sz)
-		return 0;
-	if (info->off != -ENOENT)
-		/* only one such field is allowed */
-		return -E2BIG;
+		return BTF_FIELD_IGNORE;
 	info->off = off;
-	return 0;
+	return BTF_FIELD_FOUND;
+}
+
+static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
+			 u32 off, int sz, struct btf_field_info *info)
+{
+	u32 res_id;
+
+	/* For PTR, sz is always == 8 */
+	if (!btf_type_is_ptr(t))
+		return BTF_FIELD_IGNORE;
+	t = btf_type_by_id(btf, t->type);
+
+	if (!btf_type_is_type_tag(t))
+		return BTF_FIELD_IGNORE;
+	/* Reject extra tags */
+	if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
+		return -EINVAL;
+	if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
+		return -EINVAL;
+
+	/* Get the base type */
+	t = btf_type_skip_modifiers(btf, t->type, &res_id);
+	/* Only pointer to struct is allowed */
+	if (!__btf_type_is_struct(t))
+		return -EINVAL;
+
+	info->type_id = res_id;
+	info->off = off;
+	return BTF_FIELD_FOUND;
 }
 
 static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
 				 const char *name, int sz, int align,
 				 enum btf_field_type field_type,
-				 struct btf_field_info *info)
+				 struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_member *member;
+	struct btf_field_info tmp;
+	int ret, idx = 0;
 	u32 i, off;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
 
-		if (strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
+		if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
 			continue;
 
 		off = __btf_member_bit_offset(t, member);
@@ -3212,20 +3247,38 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
-			return btf_find_struct(btf, member_type, off, sz, info);
+			ret = btf_find_struct(btf, member_type, off, sz,
+					      idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
+		case BTF_FIELD_KPTR:
+			ret = btf_find_kptr(btf, member_type, off, sz,
+					    idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
+
+		if (ret == BTF_FIELD_IGNORE)
+			continue;
+		if (idx >= info_cnt)
+			return -E2BIG;
+		++idx;
 	}
-	return 0;
+	return idx;
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				const char *name, int sz, int align,
 				enum btf_field_type field_type,
-				struct btf_field_info *info)
+				struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_var_secinfo *vsi;
+	struct btf_field_info tmp;
+	int ret, idx = 0;
 	u32 i, off;
 
 	for_each_vsi(i, t, vsi) {
@@ -3234,7 +3287,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		off = vsi->offset;
 
-		if (strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
+		if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
 			continue;
 		if (vsi->size != sz)
 			continue;
@@ -3244,17 +3297,33 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
-			return btf_find_struct(btf, var_type, off, sz, info);
+			ret = btf_find_struct(btf, var_type, off, sz,
+					      idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
+		case BTF_FIELD_KPTR:
+			ret = btf_find_kptr(btf, var_type, off, sz,
+					    idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
+
+		if (ret == BTF_FIELD_IGNORE)
+			continue;
+		if (idx >= info_cnt)
+			return -E2BIG;
+		++idx;
 	}
-	return 0;
+	return idx;
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 			  enum btf_field_type field_type,
-			  struct btf_field_info *info)
+			  struct btf_field_info *info, int info_cnt)
 {
 	const char *name;
 	int sz, align;
@@ -3270,14 +3339,19 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 		sz = sizeof(struct bpf_timer);
 		align = __alignof__(struct bpf_timer);
 		break;
+	case BTF_FIELD_KPTR:
+		name = NULL;
+		sz = sizeof(u64);
+		align = 8;
+		break;
 	default:
 		return -EFAULT;
 	}
 
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, name, sz, align, field_type, info);
+		return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info);
+		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt);
 	return -EINVAL;
 }
 
@@ -3287,26 +3361,77 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
  */
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
 {
-	struct btf_field_info info = { .off = -ENOENT };
+	struct btf_field_info info;
 	int ret;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info);
+	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info, 1);
 	if (ret < 0)
 		return ret;
+	if (!ret)
+		return -ENOENT;
 	return info.off;
 }
 
 int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 {
-	struct btf_field_info info = { .off = -ENOENT };
+	struct btf_field_info info;
 	int ret;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info);
+	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info, 1);
 	if (ret < 0)
 		return ret;
+	if (!ret)
+		return -ENOENT;
 	return info.off;
 }
 
+struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
+					  const struct btf_type *t)
+{
+	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
+	struct bpf_map_value_off *tab;
+	int ret, i, nr_off;
+
+	/* Revisit stack usage when bumping BPF_MAP_VALUE_OFF_MAX */
+	BUILD_BUG_ON(BPF_MAP_VALUE_OFF_MAX != 8);
+
+	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (!ret)
+		return NULL;
+
+	nr_off = ret;
+	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
+	if (!tab)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_off; i++) {
+		const struct btf_type *t;
+		struct btf *off_btf;
+		s32 id;
+
+		t = btf_type_by_id(btf, info_arr[i].type_id);
+		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
+				     &off_btf);
+		if (id < 0) {
+			ret = id;
+			goto end;
+		}
+
+		tab->off[i].offset = info_arr[i].off;
+		tab->off[i].kptr.btf_id = id;
+		tab->off[i].kptr.btf = off_btf;
+	}
+	tab->nr_off = nr_off;
+	return tab;
+end:
+	while (i--)
+		btf_put(tab->off[i].kptr.btf);
+	kfree(tab);
+	return ERR_PTR(ret);
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 5cd8f5277279..135205d0d560 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,6 +52,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
 	inner_map_meta->timer_off = inner_map->timer_off;
+	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
@@ -71,6 +72,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
+	bpf_map_free_kptr_off_tab(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
 }
@@ -83,7 +85,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->timer_off == meta1->timer_off &&
-		meta0->map_flags == meta1->map_flags;
+		meta0->map_flags == meta1->map_flags &&
+		bpf_map_equal_kptr_off_tab(meta0, meta1);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e9621cfa09f2..fba49f390ed5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6,6 +6,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bsearch.h>
 #include <linux/btf.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
@@ -473,12 +474,94 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
+static int bpf_map_kptr_off_cmp(const void *a, const void *b)
+{
+	const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
+
+	if (off_desc1->offset < off_desc2->offset)
+		return -1;
+	else if (off_desc1->offset > off_desc2->offset)
+		return 1;
+	return 0;
+}
+
+struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
+{
+	/* Since members are iterated in btf_find_field in increasing order,
+	 * offsets appended to kptr_off_tab are in increasing order, so we can
+	 * do bsearch to find exact match.
+	 */
+	struct bpf_map_value_off *tab;
+
+	if (!map_value_has_kptrs(map))
+		return NULL;
+	tab = map->kptr_off_tab;
+	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
+}
+
+void bpf_map_free_kptr_off_tab(struct bpf_map *map)
+{
+	struct bpf_map_value_off *tab = map->kptr_off_tab;
+	int i;
+
+	if (!map_value_has_kptrs(map))
+		return;
+	for (i = 0; i < tab->nr_off; i++) {
+		struct btf *btf = tab->off[i].kptr.btf;
+
+		btf_put(btf);
+	}
+	kfree(tab);
+	map->kptr_off_tab = NULL;
+}
+
+struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
+{
+	struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
+	int size, i, ret;
+
+	if (!map_value_has_kptrs(map))
+		return ERR_PTR(-ENOENT);
+	/* Do a deep copy of the kptr_off_tab */
+	for (i = 0; i < tab->nr_off; i++)
+		btf_get(tab->off[i].kptr.btf);
+
+	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
+	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
+	if (!new_tab) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	return new_tab;
+end:
+	while (i--)
+		btf_put(tab->off[i].kptr.btf);
+	return ERR_PTR(ret);
+}
+
+bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+{
+	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
+	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
+	int size;
+
+	if (!a_has_kptr && !b_has_kptr)
+		return true;
+	if (a_has_kptr != b_has_kptr)
+		return false;
+	if (tab_a->nr_off != tab_b->nr_off)
+		return false;
+	size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
+	return !memcmp(tab_a, tab_b, size);
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
+	bpf_map_free_kptr_off_tab(map);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -640,7 +723,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	int err;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map))
+	    map_value_has_timer(map) || map_value_has_kptrs(map))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -820,9 +903,33 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			return -EOPNOTSUPP;
 	}
 
-	if (map->ops->map_check_btf)
+	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
+	if (map_value_has_kptrs(map)) {
+		if (!bpf_capable()) {
+			ret = -EPERM;
+			goto free_map_tab;
+		}
+		if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
+			ret = -EACCES;
+			goto free_map_tab;
+		}
+		if (map->map_type != BPF_MAP_TYPE_HASH &&
+		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+		    map->map_type != BPF_MAP_TYPE_ARRAY) {
+			ret = -EOPNOTSUPP;
+			goto free_map_tab;
+		}
+	}
+
+	if (map->ops->map_check_btf) {
 		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
+		if (ret < 0)
+			goto free_map_tab;
+	}
 
+	return ret;
+free_map_tab:
+	bpf_map_free_kptr_off_tab(map);
 	return ret;
 }
 
@@ -1639,7 +1746,7 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
 
 	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map)) {
+	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71827d14724a..c802e51c4e18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3211,7 +3211,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	return 0;
 }
 
-enum stack_access_src {
+enum bpf_access_src {
 	ACCESS_DIRECT = 1,  /* the access is performed by an instruction */
 	ACCESS_HELPER = 2,  /* the access is performed by a helper */
 };
@@ -3219,7 +3219,7 @@ enum stack_access_src {
 static int check_stack_range_initialized(struct bpf_verifier_env *env,
 					 int regno, int off, int access_size,
 					 bool zero_size_allowed,
-					 enum stack_access_src type,
+					 enum bpf_access_src type,
 					 struct bpf_call_arg_meta *meta);
 
 static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
@@ -3507,9 +3507,87 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 	return __check_ptr_off_reg(env, reg, regno, false);
 }
 
+static int map_kptr_match_type(struct bpf_verifier_env *env,
+			       struct bpf_map_value_off_desc *off_desc,
+			       struct bpf_reg_state *reg, u32 regno)
+{
+	const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
+	const char *reg_name = "";
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
+		goto bad_type;
+
+	if (!btf_is_kernel(reg->btf)) {
+		verbose(env, "R%d must point to kernel BTF\n", regno);
+		return -EINVAL;
+	}
+	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
+	reg_name = kernel_type_name(reg->btf, reg->btf_id);
+
+	if (__check_ptr_off_reg(env, reg, regno, true))
+		return -EACCES;
+
+	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+				  off_desc->kptr.btf, off_desc->kptr.btf_id))
+		goto bad_type;
+	return 0;
+bad_type:
+	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
+		reg_type_str(env, reg->type), reg_name);
+	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	return -EINVAL;
+}
+
+static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
+				 int value_regno, int insn_idx,
+				 struct bpf_map_value_off_desc *off_desc)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	int class = BPF_CLASS(insn->code);
+	struct bpf_reg_state *val_reg;
+
+	/* Things we already checked for in check_map_access and caller:
+	 *  - Reject cases where variable offset may touch kptr
+	 *  - size of access (must be BPF_DW)
+	 *  - tnum_is_const(reg->var_off)
+	 *  - off_desc->offset == off + reg->var_off.value
+	 */
+	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
+	if (BPF_MODE(insn->code) != BPF_MEM) {
+		verbose(env, "kptr in map can only be accessed using BPF_MEM instruction mode\n");
+		return -EACCES;
+	}
+
+	if (class == BPF_LDX) {
+		val_reg = reg_state(env, value_regno);
+		/* We can simply mark the value_regno receiving the pointer
+		 * value from map as PTR_TO_BTF_ID, with the correct type.
+		 */
+		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
+				off_desc->kptr.btf_id, PTR_MAYBE_NULL);
+		val_reg->id = ++env->id_gen;
+	} else if (class == BPF_STX) {
+		val_reg = reg_state(env, value_regno);
+		if (!register_is_null(val_reg) &&
+		    map_kptr_match_type(env, off_desc, val_reg, value_regno))
+			return -EACCES;
+	} else if (class == BPF_ST) {
+		if (insn->imm) {
+			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
+				off_desc->offset);
+			return -EACCES;
+		}
+	} else {
+		verbose(env, "kptr in map can only be accessed using BPF_LDX/BPF_STX/BPF_ST\n");
+		return -EACCES;
+	}
+	return 0;
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
-			    int off, int size, bool zero_size_allowed)
+			    int off, int size, bool zero_size_allowed,
+			    enum bpf_access_src src)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
@@ -3545,6 +3623,36 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 	}
+	if (map_value_has_kptrs(map)) {
+		struct bpf_map_value_off *tab = map->kptr_off_tab;
+		int i;
+
+		for (i = 0; i < tab->nr_off; i++) {
+			u32 p = tab->off[i].offset;
+
+			if (reg->smin_value + off < p + sizeof(u64) &&
+			    p < reg->umax_value + off + size) {
+				if (src != ACCESS_DIRECT) {
+					verbose(env, "kptr cannot be accessed indirectly by helper\n");
+					return -EACCES;
+				}
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "kptr access cannot have variable offset\n");
+					return -EACCES;
+				}
+				if (p != off + reg->var_off.value) {
+					verbose(env, "kptr access misaligned expected=%u off=%llu\n",
+						p, off + reg->var_off.value);
+					return -EACCES;
+				}
+				if (size != bpf_size_to_bytes(BPF_DW)) {
+					verbose(env, "kptr access size must be BPF_DW\n");
+					return -EACCES;
+				}
+				break;
+			}
+		}
+	}
 	return err;
 }
 
@@ -4316,7 +4424,7 @@ static int check_stack_slot_within_bounds(int off,
 static int check_stack_access_within_bounds(
 		struct bpf_verifier_env *env,
 		int regno, int off, int access_size,
-		enum stack_access_src src, enum bpf_access_type type)
+		enum bpf_access_src src, enum bpf_access_type type)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
@@ -4412,6 +4520,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_MAP_VALUE) {
+		struct bpf_map_value_off_desc *kptr_off_desc = NULL;
+
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into map\n", value_regno);
@@ -4420,8 +4530,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		err = check_map_access_type(env, regno, off, size, t);
 		if (err)
 			return err;
-		err = check_map_access(env, regno, off, size, false);
-		if (!err && t == BPF_READ && value_regno >= 0) {
+		err = check_map_access(env, regno, off, size, false, ACCESS_DIRECT);
+		if (err)
+			return err;
+		if (tnum_is_const(reg->var_off))
+			kptr_off_desc = bpf_map_kptr_off_contains(reg->map_ptr,
+								  off + reg->var_off.value);
+		if (kptr_off_desc) {
+			err = check_map_kptr_access(env, regno, value_regno, insn_idx,
+						    kptr_off_desc);
+		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
 			/* if map is read-only, track its contents as scalars */
@@ -4724,7 +4842,7 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 static int check_stack_range_initialized(
 		struct bpf_verifier_env *env, int regno, int off,
 		int access_size, bool zero_size_allowed,
-		enum stack_access_src type, struct bpf_call_arg_meta *meta)
+		enum bpf_access_src type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
@@ -4874,7 +4992,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					  BPF_READ))
 			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
-					zero_size_allowed);
+					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
 			if (meta && meta->raw_mode) {
@@ -5642,7 +5760,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 
 		err = check_map_access(env, regno, reg->off,
-				       map->value_size - reg->off, false);
+				       map->value_size - reg->off, false,
+				       ACCESS_HELPER);
 		if (err)
 			return err;
 
@@ -7462,7 +7581,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 			return -EACCES;
 		break;
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access(env, dst, dst_reg->off, 1, false)) {
+		if (check_map_access(env, dst, dst_reg->off, 1, false, ACCESS_HELPER)) {
 			verbose(env, "R%d pointer arithmetic of map value goes out of range, "
 				"prohibited for !root\n", dst);
 			return -EACCES;
-- 
2.35.1

