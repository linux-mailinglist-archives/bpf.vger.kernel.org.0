Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60A95FA9FA
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJKBYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJKBXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534483065
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e129so11574860pgc.9
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlV/KDZogU2wjVy/Q1tHlu43YSO7EV/11K+Dme9/QU8=;
        b=PCrp4MAqVcSuS59P7ONzB1rk3HJppSgU6Lua6KpqN4628BjoHj1LJP+FtXCyd2YkcC
         VTxesWLElzxweX07gPtJGI/bNs/XneGOX+ZvGgTVxRVULMaNttq+EzrYLaMouwWgmo1n
         lytqFBU+MArqWuNcx8vbO+RVTZqLKOgfAYAKbEQRgJ5YfEddJwFZVARI20As9U8TJ9o1
         ZNxohaO7Sf8HdLyErgtckYXngRgAgbJmrZfiw7ar4w3hxp0VXkNUtFLvWf//TQLqWT0x
         4hTtegUo0BrhGwIik9PBJ2b2HhG0pZkq2kOyfV10wzvfdg1bXNjhxuNkMLfxBdPnC6oA
         P4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlV/KDZogU2wjVy/Q1tHlu43YSO7EV/11K+Dme9/QU8=;
        b=wFGk4/6tFpbHr4/Hli3Dz6D+PmgMeMpTEWQ76BEQ6yBXgR3pvt1ywtfMA6S+mPuk9j
         xL8saRilS1hOAFsjhwpBxfUcHh7v/kWGUAYi44wfzFVHfaYjSR3vH2VvUsIdMFSCuiKi
         kGFK5wEBcqRMUGVIbGo4LC1NWGoLvtJsCWOyH6tSE0YWYGo3sSGQ24G4fH1vY0UnI6tJ
         iUZxeIOV8HwNhs6+uwvrANmZHTAI/VhTX6hLilixT0DIxGfqBrIN9y5HjrauScVPHrFE
         Fb123xsQE7RLgd3P+WjEFe8U7pSgrkyizwrvm2niiPusPhtr9fUgSo8UAG9eq5VWj27Y
         CAGQ==
X-Gm-Message-State: ACrzQf1mepvUrxzc/+wmRYnccenheq/wfu87HWR2woDYzWPYBUuOfZOR
        Du/jyv+jgPnetBOs7jaFMRBDtjnQn7Ljqg==
X-Google-Smtp-Source: AMsMyM6M2+ZYSS2RbE/LsaKaaQT7YrZuVSVMK3oNpNVJwM+77e8oelIhRhcDYMBzjwq2vdGC0iEiNw==
X-Received: by 2002:a65:4bcf:0:b0:460:c57f:9dad with SMTP id p15-20020a654bcf000000b00460c57f9dadmr11240147pgr.18.1665451387180;
        Mon, 10 Oct 2022 18:23:07 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b0016dbdf7b97bsm7145546plg.266.2022.10.10.18.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:23:06 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 08/25] bpf: Refactor map->off_arr handling
Date:   Tue, 11 Oct 2022 06:52:23 +0530
Message-Id: <20221011012240.3149-9-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8770; i=memxor@gmail.com; h=from:subject; bh=HP9T/Us0d3dM2RakQimKtbo4oAPF0KVwtC0CXWulGG0=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUaehMYfuAXCDOzj2GgW+9KF+d4Vyas0k7huepF Fc2JgfqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8Rym4hD/ oCtxSIzRvDtxnuJmCg0au4xWrMsKfb2GcgznXoEQCI+bIO6EOm4VMWWVHcQwSaDCKofxVeb52yleba 5mMvcxCcorP9CWFvGuM4w2Q5qWwsfOMGaa3Y+bf75+hW4ARJPo/dDwH3Jo2Xu000VBIFSOn92jvhoi nCpHE4gc5LqZfT/YQK8Vbmuj0y0JgbHgO3YjJT2RtzfuPF3fJtfFxGeaHFkTmjn8hcl2fu0UirQrlW nKB4NvdYQucE78TsKL+EbsWCKRg72LeH35ljB4lLIURUCK5A+MutWw1H7HomrzIk4tCdl79HsS6IqX eZXltIzadskvD49zID+46hdI7sOqxRf2FN4eW/c5SN4+uqhXMNjizHS6YsN8hOXC3eg2bNEaBtE8CI fIPAKIjONyKOKOVLlL8qlewJZAJ0+bxEA85oWVQ0cM5X6hzuyzc97rIrs7K7x+zCmS8vSCIn700sNm P3lwuYzzQ7ypTIFbg8aNuv++xbLCHWSibSeZoVPeiCDseX+sUiP0cntaIzL+2MPq+Ifh14xXbk0BmB XEoGngAgeH4j0MasNPePEhSrfpeBbhzz0MvIRZWUcVpl+8iiKqiB2bgBhvTxnsrnnnqDUzUMqKXLR4 LLKB6b9piKjIutxMHtchaA51TSd1sUS1PJ+oj+3XdvFAFHKCxGsxY1tQ3Q4w==
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
index fe00d9c95c96..444a2b1d18f1 100644
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
+	if (IS_ERR_OR_NULL(tab))
+		return NULL;
+
+	off_arr = kzalloc(sizeof(*off_arr), GFP_KERNEL | __GFP_NOWARN);
+	if (!off_arr)
+		return ERR_PTR(-ENOMEM);
+	off_arr->cnt = 0;
+
+	off = &off_arr->field_off[off_arr->cnt];
+	sz = &off_arr->field_sz[off_arr->cnt];
+	for (i = 0; i < tab->cnt; i++) {
+		*off++ = tab->fields[i].offset;
+		*sz++ = btf_field_type_size(tab->fields[i].type);
+	}
+	off_arr->cnt = tab->cnt;
+
+	if (off_arr->cnt == 1)
+		return off_arr;
+	sort_r(off_arr->field_off, off_arr->cnt, sizeof(off_arr->field_off[0]),
+	       btf_type_fields_off_cmp, btf_type_fields_off_swap, tab);
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
2.34.1

