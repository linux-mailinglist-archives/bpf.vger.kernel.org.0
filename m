Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B725FD4B2
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJMGXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJMGXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE3123473
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l1so915700pld.13
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36vwaT3Xv0AW7DsCDFdks4CgUDjEyOSbWTnRiUbKfww=;
        b=axZvzgkTPYPsvUF4l8N9Rdi0rnIa+6RrpAHqX22SLwdySOnGBN1UhsWjbaIZ1XyTrM
         pShPZF1+NdbLQOtICK9+S/AchTzvfaK0KYHe00VWuJogByPU0qlZ5LbynyPkP07qLEau
         Oj1SVidxwUC3Gfk9fMGJxnF9o7hQfwqmk0YVVV8vpnq+bzTJJXId2nUx+qKZc2O48NLj
         Pv7SAZdngB4kR9x4mL9diAJGw8V1tagvqFDG3KgqPV3ZCwN1PnhrbdaVebs29HPOB2eL
         sVtzDurTRUU6RSgfP08v60aH0VTYAF52hFualP4HG+inpdLaSPndKPbYxO7vCArrzN61
         Nt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36vwaT3Xv0AW7DsCDFdks4CgUDjEyOSbWTnRiUbKfww=;
        b=UojCGY9Swoz0bbWX+A5FKBu6Rph5kcJzF0vEsUtR4Ykb0sJByS5mZ1/7hJEIQNu7wI
         4gfmUQ8IADOLht8LWNw3I8JihSi5hAg70EhkBfIEvgopRVU4Jk+JPvXMyVyF3unxBc0H
         DvKLj+JGxwxWYAaziUu5Ce/fQJxMArIJLdSrPZvooo9ubckCmhgFoqOEUWU8m0PN1grF
         7P2cTdnMVE3V6nxjTqKdsDtRRXcPTFY10S08c/8pp3FC2pEGhLyMCmnHjhrBWu38QHpR
         wQWmm3sc3hemh44bbIgrsJXWWfEH1LYK0xz6oHpttO0EqsvxX4nfXBJVbrcfdFCfhthf
         ge7Q==
X-Gm-Message-State: ACrzQf2POQNUehJQZZ9ffHxkyDIGLFTThDZFetexzVLoX+I9N+bA9ixf
        A3VryWTGuKZ9V34yBxmDm0rBS838D1w=
X-Google-Smtp-Source: AMsMyM5u6K9mCbzZvn1vngFEdQ8WP9OU6CSX/7WZlmNRwFfUFgosJNHrNIsxcHZEh0g0VQUl/HnxHA==
X-Received: by 2002:a17:90b:4b02:b0:20d:3937:7ad with SMTP id lx2-20020a17090b4b0200b0020d393707admr9376146pjb.145.1665642224724;
        Wed, 12 Oct 2022 23:23:44 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090a678300b001f94d25bfabsm2459411pjj.28.2022.10.12.23.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:44 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 08/25] bpf: Refactor map->off_arr handling
Date:   Thu, 13 Oct 2022 11:52:46 +0530
Message-Id: <20221013062303.896469-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8868; i=memxor@gmail.com; h=from:subject; bh=o9qh1a+u6lLaWBJjKQ9XwYv1Ov+MsTkiFdhimtpFPm8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67DcmBHIsgSg/CSO2b4gX7/TFiK0RM5j8I/OFmG iWZiGhmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RytNWD/ 9kPf5tqgBIS1B3uWq3Yhx0oLKpUrjVUS3pSwoKBMHAUIZm1Ops4wqe2qeJaXw+Hn0R5Ne6xScNGxke CXqQxydEHK2aTQ2Ps4VLGcY16l2+ykihWSmEVCR3gZ4/xSluq0XQQfMIxlCh1DeBEZWYa8ia8IbTUJ cecBtOZDZGE3UB1cG/9L0RgVus5NrsntixE+7pGzobviCU8nEkz3FYJkZVJry3Gkz2464J/63nFD4A mwGPK8xeh3PDSmZTr85fKkzi4Ill0D3YsaVKKV2QySlORkehNHqaCYihtELMu60jXqaAoUZF6mXj82 Gv0AMJb8diefCiWvgBrITuzdbEP6x84YxVh7P1iaFtRZH45EqJmxU35D5W5vJVurZ+wYDoKS3jw90Q hb9B8suMMeTukM8w1gnZU9S0U4GArKuRNZa74eFft7M1IJiTLjCeCfK6kctntJZhygu70tBsdlwmCR 33iBjIH+BjygpfNB4vZct82sKV+L6a16VY2AarKH9JQT/B9QyoyqsTsBSdtyPcINrKFdtTMUME4gJL zHf7UQ/wW2Gw8Un9dGyWuNjvmWuyWiWOZnb3OGgRg2nzHr4h4AE9EoyGytwglHsYPniBqOTVwylOTh f0tfsrsxk5iGeQLwyH9x9vxBM2uVKkKz8t2PGnUWWLhHbnFYQSvPyokJdcJg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor map->off_arr handling into generic functions that can work on
their own without hardcoding map specific code. The btf_type_fields_off
structure is now returned from btf_parse_fields_off, which can be reused
later for types in program BTF.

All functions like copy_map_value, zero_map_value call generic
underlying functions so that they can also be reused later for copying
to values allocated in programs which encode specific fields.

Later, some helper functions will also require access to this off_arr
structure to be able to skip over special fields at runtime.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 41 ++++++++++++++-----------
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 55 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 71 +++++---------------------------------------
 4 files changed, 87 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba59147dfa61..bc8e7a132664 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -340,55 +340,62 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, bool long_memcpy)
+static inline void bpf_obj_memcpy(struct btf_type_fields_off *off_arr,
+				  void *dst, void *src, u32 size,
+				  bool long_memcpy)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->off_arr)) {
+	if (likely(!off_arr)) {
 		if (long_memcpy)
-			bpf_long_memcpy(dst, src, round_up(map->value_size, 8));
+			bpf_long_memcpy(dst, src, round_up(size, 8));
 		else
-			memcpy(dst, src, map->value_size);
+			memcpy(dst, src, size);
 		return;
 	}
 
-	for (i = 0; i < map->off_arr->cnt; i++) {
-		u32 next_off = map->off_arr->field_off[i];
+	for (i = 0; i < off_arr->cnt; i++) {
+		u32 next_off = off_arr->field_off[i];
 
 		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		curr_off += off_arr->field_sz[i];
 	}
-	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
+	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
 
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, false);
+	bpf_obj_memcpy(map->off_arr, dst, src, map->value_size, false);
 }
 
 static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, true);
+	bpf_obj_memcpy(map->off_arr, dst, src, map->value_size, true);
 }
 
-static inline void zero_map_value(struct bpf_map *map, void *dst)
+static inline void bpf_obj_memzero(struct btf_type_fields_off *off_arr, void *dst, u32 size)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->off_arr)) {
-		memset(dst, 0, map->value_size);
+	if (likely(!off_arr)) {
+		memset(dst, 0, size);
 		return;
 	}
 
-	for (i = 0; i < map->off_arr->cnt; i++) {
-		u32 next_off = map->off_arr->field_off[i];
+	for (i = 0; i < off_arr->cnt; i++) {
+		u32 next_off = off_arr->field_off[i];
 
 		memset(dst + curr_off, 0, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		curr_off += off_arr->field_sz[i];
 	}
-	memset(dst + curr_off, 0, map->value_size - curr_off);
+	memset(dst + curr_off, 0, size - curr_off);
+}
+
+static inline void zero_map_value(struct bpf_map *map, void *dst)
+{
+	bpf_obj_memzero(map->off_arr, dst, map->value_size);
 }
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 72136c9ae4cd..609809017ea1 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -166,6 +166,7 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 					 const struct btf_type *t,
 					 u32 field_mask, u32 value_size);
+struct btf_type_fields_off *btf_parse_fields_off(struct btf_type_fields *tab);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fe00d9c95c96..daadcd8641b5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3556,6 +3556,61 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+static int btf_type_fields_off_cmp(const void *_a, const void *_b, const void *priv)
+{
+	const u32 a = *(const u32 *)_a;
+	const u32 b = *(const u32 *)_b;
+
+	if (a < b)
+		return -1;
+	else if (a > b)
+		return 1;
+	return 0;
+}
+
+static void btf_type_fields_off_swap(void *_a, void *_b, int size, const void *priv)
+{
+	struct btf_type_fields_off *off_arr = (void *)priv;
+	u32 *off_base = off_arr->field_off;
+	u32 *a = _a, *b = _b;
+	u8 *sz_a, *sz_b;
+
+	sz_a = off_arr->field_sz + (a - off_base);
+	sz_b = off_arr->field_sz + (b - off_base);
+
+	swap(*a, *b);
+	swap(*sz_a, *sz_b);
+}
+
+struct btf_type_fields_off *btf_parse_fields_off(struct btf_type_fields *tab)
+{
+	struct btf_type_fields_off *off_arr;
+	u32 i, *off;
+	u8 *sz;
+
+	BUILD_BUG_ON(ARRAY_SIZE(off_arr->field_off) != ARRAY_SIZE(off_arr->field_sz));
+	if (IS_ERR_OR_NULL(tab) || WARN_ON_ONCE(tab->cnt > sizeof(off_arr->field_off)))
+		return NULL;
+
+	off_arr = kzalloc(sizeof(*off_arr), GFP_KERNEL | __GFP_NOWARN);
+	if (!off_arr)
+		return ERR_PTR(-ENOMEM);
+
+	off = &off_arr->field_off[0];
+	sz = &off_arr->field_sz[0];
+	for (i = 0; i < tab->cnt; i++) {
+		off[i] = tab->fields[i].offset;
+		sz[i] = btf_field_type_size(tab->fields[i].type);
+	}
+	off_arr->cnt = tab->cnt;
+
+	if (off_arr->cnt == 1)
+		return off_arr;
+	sort_r(off_arr->field_off, off_arr->cnt, sizeof(off_arr->field_off[0]),
+	       btf_type_fields_off_cmp, btf_type_fields_off_swap, off_arr);
+	return off_arr;
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index afa736132cc5..3f3f9697d299 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -943,68 +943,6 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_off_arr_cmp(const void *_a, const void *_b, const void *priv)
-{
-	const u32 a = *(const u32 *)_a;
-	const u32 b = *(const u32 *)_b;
-
-	if (a < b)
-		return -1;
-	else if (a > b)
-		return 1;
-	return 0;
-}
-
-static void map_off_arr_swap(void *_a, void *_b, int size, const void *priv)
-{
-	struct bpf_map *map = (struct bpf_map *)priv;
-	u32 *off_base = map->off_arr->field_off;
-	u32 *a = _a, *b = _b;
-	u8 *sz_a, *sz_b;
-
-	sz_a = map->off_arr->field_sz + (a - off_base);
-	sz_b = map->off_arr->field_sz + (b - off_base);
-
-	swap(*a, *b);
-	swap(*sz_a, *sz_b);
-}
-
-static int bpf_map_alloc_off_arr(struct bpf_map *map)
-{
-	bool has_fields = !IS_ERR_OR_NULL(map);
-	struct btf_type_fields_off *off_arr;
-	u32 i;
-
-	if (!has_fields) {
-		map->off_arr = NULL;
-		return 0;
-	}
-
-	off_arr = kmalloc(sizeof(*map->off_arr), GFP_KERNEL | __GFP_NOWARN);
-	if (!off_arr)
-		return -ENOMEM;
-	map->off_arr = off_arr;
-
-	off_arr->cnt = 0;
-	if (has_fields) {
-		struct btf_type_fields *tab = map->fields_tab;
-		u32 *off = &off_arr->field_off[off_arr->cnt];
-		u8 *sz = &off_arr->field_sz[off_arr->cnt];
-
-		for (i = 0; i < tab->cnt; i++) {
-			*off++ = tab->fields[i].offset;
-			*sz++ = btf_field_type_size(tab->fields[i].type);
-		}
-		off_arr->cnt = tab->cnt;
-	}
-
-	if (off_arr->cnt == 1)
-		return 0;
-	sort_r(off_arr->field_off, off_arr->cnt, sizeof(off_arr->field_off[0]),
-	       map_off_arr_cmp, map_off_arr_swap, map);
-	return 0;
-}
-
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1098,6 +1036,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 static int map_create(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
+	struct btf_type_fields_off *off_arr;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1177,9 +1116,13 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = bpf_map_alloc_off_arr(map);
-	if (err)
+
+	off_arr = btf_parse_fields_off(map->fields_tab);
+	if (IS_ERR(off_arr)) {
+		err = PTR_ERR(off_arr);
 		goto free_map;
+	}
+	map->off_arr = off_arr;
 
 	err = security_bpf_map_alloc(map);
 	if (err)
-- 
2.38.0

