Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94295AC678
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIDUmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiIDUmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB72CDDB
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q21so1379970edc.9
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oH5608x8Xk1f21fPwnG19U2alN1fCk6LlCygXLmN59Q=;
        b=ewL8RKXF4OwMW0S1KcAGRh5Orxgq38iduo6YKKCIu/YHG6X3M2z2VqSkVl2R2kw4bk
         WMZHEcDN2HRKYDA++Vf+YyeDrHd93tMVhjCW37l9TAQYrAek27FlK9N8KP8hGmbtDfxw
         AxKCUddZsBR41gm6JfvahFR09a0TDcVv/ol453SKh6rpRNjt/1slAbaqxopnxAMsb31Y
         YEI27R2CNUsjPb+sKwjzWtI7WZavncjeR/KJs1k8Dc0RLISX6c1QgmGq3Vw+pH65EUSM
         SLWCx7KIbo9CjX4glKVs9+TPrdQo7oRiCA6vyAsTS7N5s33V+MJ/I6RzLq95Z1uPiJFJ
         cMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oH5608x8Xk1f21fPwnG19U2alN1fCk6LlCygXLmN59Q=;
        b=Zdos6ISLl2S6TNbtAOajFK7EKQZbp+GcW/L5p59xnjz+REsYOQPi4FJn5I5ujLVy/X
         2Ij0mzemw0aC1Rm8jabg21v+ScYqzxKc9AptYd7bS5STHbLVL9myls8dLwcb9bVGVAfe
         tOHG0pAc6fSRJPFdJ+khZkdacLGZ0aAUTTbQLTaYGv64t5RGyFWyz0BwRyGjcwJk/5wc
         lAFGgf2LBfP4/azN6u8VzuiyUN82CdKZf1tpa2GsGOe33uSEE6hFBlqIKFV7lQNX9YvE
         8DG4oFEU58xlE27zicae14O+2y7L8FIb6elg4HINH62q5+UqK1dOlFqToh/+0jzRxYQu
         MDjA==
X-Gm-Message-State: ACgBeo2fiTIWkSjuNH8FtfF2msYmIwu2g9iZLdwh8vIK1LTnvRC4akEt
        BYHoMRDf/CCL+/JJfL7CpDTGmD3a+OIMVQ==
X-Google-Smtp-Source: AA6agR5w6C2gmrpYQv3FCiwBjfw4BNSsllXffXq/s7ms0b+o0uRYwANHVu86prrirUmm8nuWJHXbcQ==
X-Received: by 2002:a05:6402:1e8c:b0:448:8776:d813 with SMTP id f12-20020a0564021e8c00b004488776d813mr26929387edf.15.1662324129360;
        Sun, 04 Sep 2022 13:42:09 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id ck7-20020a170906c44700b00722e603c39asm4184344ejb.31.2022.09.04.13.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:09 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 19/32] bpf: Support bpf_list_head in local kptrs
Date:   Sun,  4 Sep 2022 22:41:32 +0200
Message-Id: <20220904204145.3089-20-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11928; i=memxor@gmail.com; h=from:subject; bh=9PYf7F9T68RTcuS7mG+qN7YLBJLhbjeijt1KZkUGumo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1xC2sV+kySd9iMfIj5kPNSP2FrUBdbC1mxY8SB MbrPBvqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RyhdHD/ 91LV43ZjNoh5Ga95OJ2Dp1pXmXf/zSGo/QtFvVosytWgLMDNYvxSMzclXs8vZy9/j09NMCu8ldv0rQ 7ViVGz9isaCtjaixWqN9MJvCDTrf2zBDmTMsjTnviJiHoracrLOl4Ea1VeqZhXiN4CwkP62UmXgtVG ZPGZZD7R+JgaiqgXvrcPq5+EaLgl6a38IB8X36TMyGednSiBHze6ceascBwWP5L7Cx2GFMVd6h+fpS FPCXMXwTWVIMgudqzkcbTnz4+AUOiR0i+T1ONqbmkkq3l7KKE/fvzdsoT1z3MLQKXOTOdrIg0azDlD 5w4g08lEl+Ru5LGNTJxYrf+fjo107aVCmXRn1pCbPZALfrfA0W3xZR44OeXpMwRtEb4AV9seNlW2gu QV5QGybqBaod7EYAK5QxkB3+/aCq593nmGIF6cq8fkaTaC+Aune+p4Ek9WZJizhO2IGUDTSbfg0FNo TesO9gZV4VDAlWhObg5fpingPG8xtnwZC1op45Y/qZ4B3TUMzLlDg1ERPa2nFyVx5wApVBgQU3Dwjz /4P4PHrMz7YkzWECTg1eOYn2NJ8sIw+3fAVnUBBgkuM7odZUiqhYyVBclUWyBXYVV9Q9N7eXShaTmg VJFkI5Y/aYuEj3jYE0Qn/KcPJJv6dSVR5gzauTmC6Y8usaBQVvfYJTZeX3nw==
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

To support map-in-map style use case, allow embedding a bpf_list_head
inside a allocated kptr representing local type. Now, this is a field
that will actually need explicit action while destructing the object,
i.e. popping off all the nodes owned by the bpf_list_head and then
freeing each one of them. Hence, the destruction state needs tracking
when we are in the phase, and we also need to reject freeing when the
embedded list_head is not destructed.

For now, needs_destruction is false. Future patch will flip it to true
once adding items to such list_head is supported.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h                           |  8 ++
 kernel/bpf/btf.c                              | 89 ++++++++++++++++---
 kernel/bpf/helpers.c                          |  8 ++
 kernel/bpf/verifier.c                         |  4 +
 .../testing/selftests/bpf/bpf_experimental.h  |  9 ++
 5 files changed, 106 insertions(+), 12 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index d99cad21e6d9..42c7f0283887 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -437,6 +437,8 @@ int btf_local_type_has_bpf_list_node(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
 int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 				     const struct btf_type *t, u32 *offsetp);
+int btf_local_type_has_bpf_list_head(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp);
 bool btf_local_type_has_special_fields(const struct btf *btf,
 				       const struct btf_type *t);
 #else
@@ -489,6 +491,12 @@ static inline int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 {
 	return -ENOENT;
 }
+static inline int btf_local_type_has_bpf_list_head(const struct btf *btf,
+					           const struct btf_type *t,
+					           u32 *offsetp)
+{
+	return -ENOENT;
+}
 static inline bool btf_local_type_has_special_fields(const struct btf *btf,
 						     const struct btf_type *t)
 {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 63193c324898..c8d4513cc73e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3185,7 +3185,8 @@ enum btf_field_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
-	BTF_FIELD_LIST_HEAD,
+	BTF_FIELD_LIST_HEAD_MAP,
+	BTF_FIELD_LIST_HEAD_KPTR,
 	BTF_FIELD_LIST_NODE,
 };
 
@@ -3204,6 +3205,7 @@ struct btf_field_info {
 		struct {
 			u32 value_type_id;
 			const char *node_name;
+			enum btf_field_type type;
 		} list_head;
 	};
 };
@@ -3282,9 +3284,11 @@ static const char *btf_find_decl_tag_value(const struct btf *btf,
 	return NULL;
 }
 
-static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
-			      int comp_idx, const struct btf_type *t,
-			      u32 off, int sz, struct btf_field_info *info)
+static int btf_find_list_head(const struct btf *btf,
+			      enum btf_field_type field_type,
+			      const struct btf_type *pt, int comp_idx,
+			      const struct btf_type *t, u32 off, int sz,
+			      struct btf_field_info *info)
 {
 	const char *value_type;
 	const char *list_node;
@@ -3316,6 +3320,7 @@ static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
 	info->off = off;
 	info->list_head.value_type_id = id;
 	info->list_head.node_name = list_node;
+	info->list_head.type = field_type;
 	return BTF_FIELD_FOUND;
 }
 
@@ -3361,8 +3366,9 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 			if (ret < 0)
 				return ret;
 			break;
-		case BTF_FIELD_LIST_HEAD:
-			ret = btf_find_list_head(btf, t, i, member_type, off, sz,
+		case BTF_FIELD_LIST_HEAD_MAP:
+		case BTF_FIELD_LIST_HEAD_KPTR:
+			ret = btf_find_list_head(btf, field_type, t, i, member_type, off, sz,
 						 idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
@@ -3420,8 +3426,9 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			if (ret < 0)
 				return ret;
 			break;
-		case BTF_FIELD_LIST_HEAD:
-			ret = btf_find_list_head(btf, var, -1, var_type, off, sz,
+		case BTF_FIELD_LIST_HEAD_MAP:
+		case BTF_FIELD_LIST_HEAD_KPTR:
+			ret = btf_find_list_head(btf, field_type, var, -1, var_type, off, sz,
 						 idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
@@ -3462,7 +3469,8 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 		sz = sizeof(u64);
 		align = 8;
 		break;
-	case BTF_FIELD_LIST_HEAD:
+	case BTF_FIELD_LIST_HEAD_MAP:
+	case BTF_FIELD_LIST_HEAD_KPTR:
 		name = "bpf_list_head";
 		sz = sizeof(struct bpf_list_head);
 		align = __alignof__(struct bpf_list_head);
@@ -3615,13 +3623,53 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+static bool list_head_value_ok(const struct btf *btf, const struct btf_type *pt,
+			       const struct btf_type *vt,
+			       enum btf_field_type type)
+{
+	struct btf_field_info info;
+	int ret;
+
+	/* This is the value type of either map or kptr list_head. For map
+	 * list_head, we allow the value_type to have another bpf_list_head, but
+	 * for kptr list_head, we cannot allow another level of list_head.
+	 *
+	 * Also, in the map case, we must catch the case where the value_type's
+	 * list_head encodes the map_value as its own value_type.
+	 *
+	 * Essentially, we want only two levels for map, one level for kptr, and
+	 * no cycles at all in the type graph.
+	 */
+	WARN_ON_ONCE(btf_is_kernel(btf) || !__btf_type_is_struct(vt));
+	ret = btf_find_field(btf, vt, type, "kernel", &info, 1);
+	if (ret < 0)
+		return false;
+	/* For map or kptr, if value doesn't have list_head, it's ok! */
+	if (!ret)
+		return true;
+	if (ret) {
+		/* For kptr, we don't allow list_head in the value type. */
+		if (type == BTF_FIELD_LIST_HEAD_KPTR)
+			return false;
+		/* The map's list_head's value has another list head. We now
+		 * need to ensure it doesn't refer to map value type itself,
+		 * creating a cycle.
+		 */
+		vt = btf_type_by_id(btf, info.list_head.value_type_id);
+		if (vt == pt)
+			return false;
+	}
+	return true;
+}
+
 struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf, const struct btf_type *t)
 {
 	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
 	struct bpf_map_value_off *tab;
+	const struct btf_type *pt = t;
 	int ret, i, nr_off;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD, NULL, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD_MAP, NULL, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (!ret)
@@ -3644,6 +3692,8 @@ struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf, const struct btf
 		 * verify its type.
 		 */
 		ret = -EINVAL;
+		if (!list_head_value_ok(btf, pt, t, BTF_FIELD_LIST_HEAD_MAP))
+			goto end;
 		for_each_member(j, t, member) {
 			if (strcmp(info_arr[i].list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
 				continue;
@@ -5937,12 +5987,19 @@ static int btf_find_local_type_field(const struct btf *btf,
 	int ret;
 
 	/* These are invariants that must hold if this is a local type */
-	WARN_ON_ONCE(btf_is_kernel(btf) || !__btf_type_is_struct(t));
+	WARN_ON_ONCE(btf_is_kernel(btf) || !__btf_type_is_struct(t) || type == BTF_FIELD_LIST_HEAD_MAP);
 	ret = btf_find_field(btf, t, type, "kernel", &info, 1);
 	if (ret < 0)
 		return ret;
 	if (!ret)
 		return 0;
+	/* A validation step needs to be done for bpf_list_head in local kptrs */
+	if (type == BTF_FIELD_LIST_HEAD_KPTR) {
+		const struct btf_type *vt = btf_type_by_id(btf, info.list_head.value_type_id);
+
+		if (!list_head_value_ok(btf, t, vt, type))
+			return -EINVAL;
+	}
 	if (offsetp)
 		*offsetp = info.off;
 	return ret;
@@ -5960,10 +6017,17 @@ int btf_local_type_has_bpf_spin_lock(const struct btf *btf,
 	return btf_find_local_type_field(btf, t, BTF_FIELD_SPIN_LOCK, offsetp);
 }
 
+int btf_local_type_has_bpf_list_head(const struct btf *btf,
+				     const struct btf_type *t, u32 *offsetp)
+{
+	return btf_find_local_type_field(btf, t, BTF_FIELD_LIST_HEAD_KPTR, offsetp);
+}
+
 bool btf_local_type_has_special_fields(const struct btf *btf, const struct btf_type *t)
 {
 	return btf_local_type_has_bpf_list_node(btf, t, NULL) == 1 ||
-	       btf_local_type_has_bpf_spin_lock(btf, t, NULL) == 1;
+	       btf_local_type_has_bpf_spin_lock(btf, t, NULL) == 1 ||
+	       btf_local_type_has_bpf_list_head(btf, t, NULL) == 1;
 }
 
 int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
@@ -5993,6 +6057,7 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
 	}
 		PREVENT_DIRECT_WRITE(bpf_list_node);
 		PREVENT_DIRECT_WRITE(bpf_spin_lock);
+		PREVENT_DIRECT_WRITE(bpf_list_head);
 
 #undef PREVENT_DIRECT_WRITE
 		err = 0;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 94a23a544aee..8eee0793c7f1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1724,6 +1724,13 @@ void bpf_spin_lock_init(struct bpf_spin_lock *lock__clkptr)
 	memset(lock__clkptr, 0, sizeof(*lock__clkptr));
 }
 
+void bpf_list_head_init(struct bpf_list_head *head__clkptr)
+{
+	BUILD_BUG_ON(sizeof(struct bpf_list_head) != sizeof(struct list_head));
+	BUILD_BUG_ON(__alignof__(struct bpf_list_head) != __alignof__(struct list_head));
+	INIT_LIST_HEAD((struct list_head *)head__clkptr);
+}
+
 __diag_pop();
 
 BTF_SET8_START(tracing_btf_ids)
@@ -1733,6 +1740,7 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kptr_alloc, KF_ACQUIRE | KF_RET_NULL | __KF_RET_DYN_BTF)
 BTF_ID_FLAGS(func, bpf_list_node_init)
 BTF_ID_FLAGS(func, bpf_spin_lock_init)
+BTF_ID_FLAGS(func, bpf_list_head_init)
 BTF_SET8_END(tracing_btf_ids)
 
 static const struct btf_kfunc_id_set tracing_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 130a4f0550f5..a5aa5de4b246 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7811,12 +7811,14 @@ BTF_ID_LIST(special_kfuncs)
 BTF_ID(func, bpf_kptr_alloc)
 BTF_ID(func, bpf_list_node_init)
 BTF_ID(func, bpf_spin_lock_init)
+BTF_ID(func, bpf_list_head_init)
 BTF_ID(struct, btf) /* empty entry */
 
 enum bpf_special_kfuncs {
 	KF_SPECIAL_bpf_kptr_alloc,
 	KF_SPECIAL_bpf_list_node_init,
 	KF_SPECIAL_bpf_spin_lock_init,
+	KF_SPECIAL_bpf_list_head_init,
 	KF_SPECIAL_bpf_empty,
 	KF_SPECIAL_MAX = KF_SPECIAL_bpf_empty,
 };
@@ -7984,6 +7986,7 @@ struct local_type_field {
 	enum {
 		FIELD_bpf_list_node,
 		FIELD_bpf_spin_lock,
+		FIELD_bpf_list_head,
 		FIELD_MAX,
 	} type;
 	enum bpf_special_kfuncs ctor_kfunc;
@@ -8030,6 +8033,7 @@ static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct loca
 
 	FILL_LOCAL_TYPE_FIELD(bpf_list_node, bpf_list_node_init, bpf_empty, false);
 	FILL_LOCAL_TYPE_FIELD(bpf_spin_lock, bpf_spin_lock_init, bpf_empty, false);
+	FILL_LOCAL_TYPE_FIELD(bpf_list_head, bpf_list_head_init, bpf_empty, false);
 
 #undef FILL_LOCAL_TYPE_FIELD
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8b1cdfb2f6bc..f0b6e92c6908 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -50,4 +50,13 @@ void bpf_list_node_init(struct bpf_list_node *node) __ksym;
  */
 void bpf_spin_lock_init(struct bpf_spin_lock *node) __ksym;
 
+/* Description
+ *	Initialize bpf_list_head field in a local kptr. This kfunc has
+ *	constructor semantics, and thus can only be called on a local kptr in
+ *	'constructing' phase.
+ * Returns
+ *	Void.
+ */
+void bpf_list_head_init(struct bpf_list_head *node) __ksym;
+
 #endif
-- 
2.34.1

