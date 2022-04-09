Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9EC4FA676
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbiDIJfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbiDIJfJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF69DECC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14so10786223pjj.0
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBUR4e3FrJ2wZXhfLQJ/fmCHGq7Ij8zIc+7bYmy55yM=;
        b=Ec0JINThXIwXZVWCT55T7LvZg2pq559QgNJYoMY8fAz6Sq1SFLrysBNcrguddU4B5k
         nqNLWjF165GwZGQAhIZzrlSr9dIlMq0tWhD8oq8LJEqn7e/izuHI/5ICvmgFDVVXrKhJ
         roCXrfXnn6d94C9pTOfob/KO/C1g0kuD92lHdzPGyms52d+O7XIKyTusi7x9TNK/+6bY
         fkwlg/J4DMN1MFrQNJW9fIWIfYrmO9vsvYCmeWWXoepu+F8xtBsxIB26fufczDo2Z1hQ
         QK+U4lp0KnrAfExDhWzn/Me/x4KpgYJ/KpCxbTceY9uigl7H6HCrkYxsb5bRlpeii4ls
         kqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBUR4e3FrJ2wZXhfLQJ/fmCHGq7Ij8zIc+7bYmy55yM=;
        b=1yOVEPAVQHiGxgPYVCa1ylPG2IldQy+Unag+1n7GtyDa+o/Os2AvEfyC522rNY6YfA
         MWkDUf8xflp0dIu9n/ljEDMvqqHumAElUiX5WUmMbFZuVVYvpR7Y0jqo6V4nKTK8jHUu
         YdAPTJnMh6I+X6b0XPLnwU92auDOuRItsVCzZqAYoeMc4LxJdzPYCL62LhpofgYibUaD
         2TlTEYvJwch2cWasd7FEZ5Fp6tAWVf+JdwLscys+/RxSLCR7TT5dLgxz0SQDLK7aYaT4
         1NtdkDb4AXVN/7PSJGBxpgVFKICIFJMg3kV54gcXqTc6MhtZU6TomuIeyLZHOOYyJSsJ
         gcag==
X-Gm-Message-State: AOAM530a95lJ1AOpRofm+FyURj3O1D+UvCkD8bSnj1wnZNfvvIaDv85f
        etghCPSjRTkhiPCNDZNhgNG4xktBxyw=
X-Google-Smtp-Source: ABdhPJzXoym9OP33MKeD05Z/Ma1D49cxbBG5IgOnn4+F3Ui2SjQCIGlIJ0Q+Vwpa3G5aJPYxNsJaPA==
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id oo6-20020a17090b1c8600b001bf2a7e5c75mr26424544pjb.145.1649496780973;
        Sat, 09 Apr 2022 02:33:00 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm15912819pjb.34.2022.04.09.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 03/13] bpf: Allow storing unreferenced kptr in map
Date:   Sat,  9 Apr 2022 15:02:53 +0530
Message-Id: <20220409093303.499196-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25108; h=from:subject; bh=klT6VVnLr/J+ahB01IadyXmpa2TniZ3XD7udtkMuTqk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0XA8O3MxAyrJfau4Hl0DLNW/CfflcwZ8a9ZTF MT0gUceJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RymW5D/ 94ARMjCgelVa8077RgbAbv7HqTgpHZrt/gMRJJVq67Hp+SezXE1el6m+NCYyl/LuWLaiLqiDXHAAbe 1hjhvn+l+yHFoIyIUfyc9kV6miMUeZS8hUfhrZto40taD3F5AvBePrASz684j5+tPzGWjlkLDhQBPt /CRnbnFKJNz4bUMaczGXPpjep95cv53p8kx7SdxdXCi2yFN19fAd73GdVCE345IoNrCtHx2tHkOGGB 41BRhwjPuD0XLDu+khhgfdByBgnGXqHPc9cnIPCzhmDhhEvxmEyhHP2wc3C8No8zvwq+/RDAaskPDz AKIux66F/FUdtiqxtPMTZhUOGLJFGnOVf9GO7siavBHw7mhU0/5eU1ThJeupk51+DuanukB5gKUx1y 2E03W8Dv2/avRsVCPYF2WpuU5OZEBJroX0nYJX8IhzOPhWheJOvtmcKHgcSS4XGwgHoerzkLS6sLJZ Y/SZfosUcDE5LYJ89rkHVDOtNI42UGliZZrOwABSAqH0QPbh1uZyk3tQQsQKDdx58YwS6mdQycs9wb I+r/UngpkY2bNx4wGXZm7sFkm9ybUghcCDrqC4+nkpIMEh7pqX64SA3yvJHKxY/5EEnRzSZK6QbQtf H7suHn4uo0dclX/BuDPnQFVlvs9bm76MJS6UZxuneyFNdkmqbL3+YGY67LrA==
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
in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
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
having kptrs, similar to the bpf_timer case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h     |  29 +++++++-
 include/linux/btf.h     |   2 +
 kernel/bpf/btf.c        | 160 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/map_in_map.c |   5 +-
 kernel/bpf/syscall.c    | 114 +++++++++++++++++++++++++++-
 kernel/bpf/verifier.c   | 116 ++++++++++++++++++++++++++++-
 6 files changed, 399 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..e267db260cb7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,22 @@ struct bpf_map_ops {
 	const struct bpf_iter_seq_info *iter_seq_info;
 };
 
+enum {
+	/* Support at most 8 pointers in a BPF map value */
+	BPF_MAP_VALUE_OFF_MAX = 8,
+};
+
+struct bpf_map_value_off_desc {
+	u32 offset;
+	u32 btf_id;
+	struct btf *btf;
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
@@ -171,6 +187,7 @@ struct bpf_map {
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	int spin_lock_off; /* >=0 valid offset, <0 error */
+	struct bpf_map_value_off *kptr_off_tab;
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
@@ -184,7 +201,7 @@ struct bpf_map {
 	char name[BPF_OBJ_NAME_LEN];
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 14 bytes hole */
+	/* 6 bytes hole */
 
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
@@ -217,6 +234,11 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
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
@@ -1497,6 +1519,11 @@ void bpf_prog_put(struct bpf_prog *prog);
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
index db7bf05adfc5..28b1d9e9124e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3166,9 +3166,16 @@ static void btf_struct_log(struct btf_verifier_env *env,
 enum {
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
 
@@ -3176,23 +3183,50 @@ static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t
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
+static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
+			       u32 off, int sz, struct btf_field_info *info)
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
 				 const char *name, int sz, int align, int field_type,
-				 struct btf_field_info *info)
+				 struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_member *member;
+	struct btf_field_info tmp;
+	int ret, idx = 0;
 	u32 i, off;
-	int ret;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
@@ -3212,24 +3246,38 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
-			ret = btf_find_field_struct(btf, member_type, off, sz, info);
+			ret = btf_find_field_struct(btf, member_type, off, sz, idx < info_cnt ?
+						    &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
+		case BTF_FIELD_KPTR:
+			ret = btf_find_field_kptr(btf, member_type, off, sz, idx < info_cnt ?
+						  &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
 			break;
 		default:
 			return -EFAULT;
 		}
+
+		if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
+			return -E2BIG;
+		else if (ret == BTF_FIELD_IGNORE)
+			continue;
+		++idx;
 	}
-	return 0;
+	return idx;
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				const char *name, int sz, int align, int field_type,
-				struct btf_field_info *info)
+				struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_var_secinfo *vsi;
+	struct btf_field_info tmp;
+	int ret, idx = 0;
 	u32 i, off;
-	int ret;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
@@ -3247,19 +3295,32 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
-			ret = btf_find_field_struct(btf, var_type, off, sz, info);
+			ret = btf_find_field_struct(btf, var_type, off, sz, idx < info_cnt ?
+						    &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
+		case BTF_FIELD_KPTR:
+			ret = btf_find_field_kptr(btf, var_type, off, sz, idx < info_cnt ?
+						  &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
 			break;
 		default:
 			return -EFAULT;
 		}
+
+		if (ret == BTF_FIELD_FOUND && idx >= info_cnt)
+			return -E2BIG;
+		if (ret == BTF_FIELD_IGNORE)
+			continue;
+		++idx;
 	}
-	return 0;
+	return idx;
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  int field_type, struct btf_field_info *info)
+			  int field_type, struct btf_field_info *info, int info_cnt)
 {
 	const char *name;
 	int sz, align;
@@ -3275,14 +3336,19 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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
 
@@ -3292,26 +3358,78 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
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
+	tab->nr_off = 0;
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
+		tab->off[i].btf_id = id;
+		tab->off[i].btf = off_btf;
+		tab->nr_off = i + 1;
+	}
+	return tab;
+end:
+	while (tab->nr_off--)
+		btf_put(tab->off[tab->nr_off].btf);
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
index cdaa1152436a..edfe691284b0 100644
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
@@ -473,12 +474,95 @@ static void bpf_map_release_memcg(struct bpf_map *map)
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
+		struct btf *btf = tab->off[i].btf;
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
+		btf_get(tab->off[i].btf);
+
+	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
+	new_tab = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+	if (!new_tab) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	memcpy(new_tab, tab, size);
+	return new_tab;
+end:
+	while (i--)
+		btf_put(tab->off[i].btf);
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
@@ -640,7 +724,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	int err;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map))
+	    map_value_has_timer(map) || map_value_has_kptrs(map))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -820,9 +904,33 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			return -EOPNOTSUPP;
 	}
 
-	if (map->ops->map_check_btf)
+	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
+	if (map_value_has_kptrs(map)) {
+		if (!bpf_capable()) {
+			ret = -EPERM;
+			goto free_map_tab;
+		}
+		if (map->map_flags & BPF_F_RDONLY_PROG) {
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
 
@@ -1639,7 +1747,7 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
 
 	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map)) {
+	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71827d14724a..01d45c5010f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3507,6 +3507,83 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 	return __check_ptr_off_reg(env, reg, regno, false);
 }
 
+static int map_kptr_match_type(struct bpf_verifier_env *env,
+			       struct bpf_map_value_off_desc *off_desc,
+			       struct bpf_reg_state *reg, u32 regno)
+{
+	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
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
+				  off_desc->btf, off_desc->btf_id))
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
+	if (BPF_MODE(insn->code) != BPF_MEM)
+		goto end;
+
+	if (class == BPF_LDX) {
+		val_reg = reg_state(env, value_regno);
+		/* We can simply mark the value_regno receiving the pointer
+		 * value from map as PTR_TO_BTF_ID, with the correct type.
+		 */
+		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
+				off_desc->btf_id, PTR_MAYBE_NULL);
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
+		goto end;
+	}
+	return 0;
+end:
+	verbose(env, "kptr in map can only be accessed using BPF_LDX/BPF_STX/BPF_ST\n");
+	return -EACCES;
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			    int off, int size, bool zero_size_allowed)
@@ -3545,6 +3622,32 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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
 
@@ -4412,6 +4515,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_MAP_VALUE) {
+		struct bpf_map_value_off_desc *off_desc = NULL;
+
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into map\n", value_regno);
@@ -4421,7 +4526,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			return err;
 		err = check_map_access(env, regno, off, size, false);
-		if (!err && t == BPF_READ && value_regno >= 0) {
+		if (err)
+			return err;
+		if (tnum_is_const(reg->var_off))
+			off_desc = bpf_map_kptr_off_contains(reg->map_ptr,
+							     off + reg->var_off.value);
+		if (off_desc) {
+			err = check_map_kptr_access(env, regno, value_regno, insn_idx, off_desc);
+			if (err)
+				return err;
+		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
 			/* if map is read-only, track its contents as scalars */
-- 
2.35.1

