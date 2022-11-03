Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9D618848
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKCTLD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKCTLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7886412AB2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v28so2494225pfi.12
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjSBXyWn+y/SxLwxIT+FFxxrISQb4EZcyWD4MkvBT6Q=;
        b=R9WEazYNz/cM8Wu65/aJBgkjBvTgJtGSBQP8kZxRkf72HDW46jKuNDmgEI+JVpMjXy
         iyKBIE4Ae0zHycy+jhw58DiB6Cf6k6ozRqqpwVzKT9dMEQcMzHCj7e2aSm8EMpTaJi2U
         4PV6OS2K0e9TA4cKwY8BBvzlIpvYyQioBJfnhRSx8g1a6Te/bdqW8JRTZHDVeeiSM9Hq
         zjek7nT9ZF5PwFYANl5p9LA/pJneIFlzvQnZ3+0eDMCMRQON47/LXcbbZv2wnT7skehH
         y2Y6LsLRmJdjaYFWtOMXoyjGch+YaBo83/h6o9/5ow++xQtCuTtR4weTGzZqYwzqDJcs
         06EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjSBXyWn+y/SxLwxIT+FFxxrISQb4EZcyWD4MkvBT6Q=;
        b=gvv5BsWaFQX2vJzBLi+dhrX0jBQwyQHYanrto9Po5zs3vWtIlmCVXCkOPcmcA/BzLZ
         62tXROtDzb14T9biqawmxgoaeFa5k8Crv15Q+K1YzIb+0XZeBl/gudSxtdXxJ2xxQz8S
         SqcJ+wgUMMGhqYKpMbW2ILrctHo4eBcuqHLb4M7PBf65PnVYxT0QFu+BmzsDYXeCxB96
         hhhv4EInWUH8pZK2GR5xeda54c6DBxLokvHWH7VKD1r6R3V4W/WXF4sNH4JYtmlyqrjh
         wsASBO7x2o/Jw/LiIyhR+i0XRQ8H+bPWHZaOLx9yHgxomaeM6J7sfiS6XoUvsAFLyUot
         VuAg==
X-Gm-Message-State: ACrzQf1BpX/ve0YwmRHJj/L2jHC0XyhJmVC6tUivR3J099PbKzmXCU4M
        lRH7zJ89ynaS0LWRL7nrpwktosbvsMNWMg==
X-Google-Smtp-Source: AMsMyM73M91O3EVX1QzpXb53ooXsQ1MjznbT83jvH6dZhK23dMc3TCgcB9kSyAksBzY4YU1Q1T4KVw==
X-Received: by 2002:a63:fd09:0:b0:464:4ec8:89b3 with SMTP id d9-20020a63fd09000000b004644ec889b3mr26775388pgh.175.1667502658637;
        Thu, 03 Nov 2022 12:10:58 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090311d100b00178b77b7e71sm1003890plh.188.2022.11.03.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 08/24] bpf: Refactor map->off_arr handling
Date:   Fri,  4 Nov 2022 00:39:57 +0530
Message-Id: <20221103191013.1236066-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9136; i=memxor@gmail.com; h=from:subject; bh=kOtOUODrBNHno7Af6RM2fwwa6gF1dCWQnMZ3hmsJ8Zs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAAeBOv6f2p5oQi7zRIjc0BCj7M6S/HLsc8O2R N/y635aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RytLEEA CwUW+AIffOkjCemTozvXfLlTjCo4YBeBH9UnruSFCKxcOlzMXD8vfDuLZFgOETOVlaFJtY6iasxHWN Z1jcTA1u/4jtQ0CouiO6r6sd6jIukZhqHtZ/gRZxURKBGzYiR9dIyi3lQ2muSWJjVw08hr8xqUgoUL +xFs5CGk1yo8Pywfqs3OV2aIw9hVYx1+poc74vue6eKOf8NJPpxG1/YDw4LBNHw+imbVE/ATko8KpF +qS/TIqJ8/xMNVcEoahi0pDkM7xiz5DEAXSlespfGn7UTtQ2oGgOfOjE3wcwv40xlbSq4+Tj2WN3T1 Hk6S6zxpV7ps5bdPyJWoyzHiyxkY0bso+bzXQxEO+TYS9eYOH1+yCWAZUg4OJ4oMKx5FcT7MXSlbhE nJBdqVlkXgX8r9YMiSks1DI1cAgEbIp7wk18LO505UR3Ucbdy8a/8ufP/Ac9nfRfjYWk3YFWTaeLX1 ysaBpewNR1XPGZO3Z0yd6oMdWdI1pk2iinPwoDL1h/0It5fF3YzZI9i2zTc0wvnvEiw8a0MRO2UiQn vYevJR1JjS1YTyWwQ76NSFLpKwzw/z4z25wL+Z8EN5ob+zUST+eb0A6Jlwo3t4GUGofe5byLg0V781 UrAvLv6akYmEMS55NxwCW2PwvXxgDq0p86EPzuJzrE8cnM0CavNaLviU2shA==
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
their own without hardcoding map specific code. The btf_fields_offs
structure is now returned from btf_parse_field_offs, which can be reused
later for types in program BTF.

All functions like copy_map_value, zero_map_value call generic
underlying functions so that they can also be reused later for copying
to values allocated in programs which encode specific fields.

Later, some helper functions will also require access to this
btf_field_offs structure to be able to skip over special fields at
runtime.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 41 ++++++++++++++-----------
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 55 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 73 ++++++--------------------------------------
 4 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d5c81b09577a..bb96bf947e53 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -341,57 +341,64 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, bool long_memcpy)
+static inline void bpf_obj_memcpy(struct btf_field_offs *foffs,
+				  void *dst, void *src, u32 size,
+				  bool long_memcpy)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->field_offs)) {
+	if (likely(!foffs)) {
 		if (long_memcpy)
-			bpf_long_memcpy(dst, src, round_up(map->value_size, 8));
+			bpf_long_memcpy(dst, src, round_up(size, 8));
 		else
-			memcpy(dst, src, map->value_size);
+			memcpy(dst, src, size);
 		return;
 	}
 
-	for (i = 0; i < map->field_offs->cnt; i++) {
-		u32 next_off = map->field_offs->field_off[i];
+	for (i = 0; i < foffs->cnt; i++) {
+		u32 next_off = foffs->field_off[i];
 		u32 sz = next_off - curr_off;
 
 		memcpy(dst + curr_off, src + curr_off, sz);
-		curr_off += map->field_offs->field_sz[i] + sz;
+		curr_off += foffs->field_sz[i] + sz;
 	}
-	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
+	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
 
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, false);
+	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, false);
 }
 
 static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, true);
+	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, true);
 }
 
-static inline void zero_map_value(struct bpf_map *map, void *dst)
+static inline void bpf_obj_memzero(struct btf_field_offs *foffs, void *dst, u32 size)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->field_offs)) {
-		memset(dst, 0, map->value_size);
+	if (likely(!foffs)) {
+		memset(dst, 0, size);
 		return;
 	}
 
-	for (i = 0; i < map->field_offs->cnt; i++) {
-		u32 next_off = map->field_offs->field_off[i];
+	for (i = 0; i < foffs->cnt; i++) {
+		u32 next_off = foffs->field_off[i];
 		u32 sz = next_off - curr_off;
 
 		memset(dst + curr_off, 0, sz);
-		curr_off += map->field_offs->field_sz[i] + sz;
+		curr_off += foffs->field_sz[i] + sz;
 	}
-	memset(dst + curr_off, 0, map->value_size - curr_off);
+	memset(dst + curr_off, 0, size - curr_off);
+}
+
+static inline void zero_map_value(struct bpf_map *map, void *dst)
+{
+	bpf_obj_memzero(map->field_offs, dst, map->value_size);
 }
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 282006abd062..d80345fa566b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -165,6 +165,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
+struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3dad828db13c..197687c86dc1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3551,6 +3551,61 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+static int btf_field_offs_cmp(const void *_a, const void *_b, const void *priv)
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
+static void btf_field_offs_swap(void *_a, void *_b, int size, const void *priv)
+{
+	struct btf_field_offs *foffs = (void *)priv;
+	u32 *off_base = foffs->field_off;
+	u32 *a = _a, *b = _b;
+	u8 *sz_a, *sz_b;
+
+	sz_a = foffs->field_sz + (a - off_base);
+	sz_b = foffs->field_sz + (b - off_base);
+
+	swap(*a, *b);
+	swap(*sz_a, *sz_b);
+}
+
+struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
+{
+	struct btf_field_offs *foffs;
+	u32 i, *off;
+	u8 *sz;
+
+	BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
+	if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
+		return NULL;
+
+	foffs = kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
+	if (!foffs)
+		return ERR_PTR(-ENOMEM);
+
+	off = &foffs->field_off[0];
+	sz = &foffs->field_sz[0];
+	for (i = 0; i < rec->cnt; i++) {
+		off[i] = rec->fields[i].offset;
+		sz[i] = btf_field_type_size(rec->fields[i].type);
+	}
+	foffs->cnt = rec->cnt;
+
+	if (foffs->cnt == 1)
+		return foffs;
+	sort_r(foffs->field_off, foffs->cnt, sizeof(foffs->field_off[0]),
+	       btf_field_offs_cmp, btf_field_offs_swap, foffs);
+	return foffs;
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 73822d36aa56..85532d301124 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -943,66 +943,6 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_field_offs_cmp(const void *_a, const void *_b, const void *priv)
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
-static void map_field_offs_swap(void *_a, void *_b, int size, const void *priv)
-{
-	struct bpf_map *map = (struct bpf_map *)priv;
-	u32 *off_base = map->field_offs->field_off;
-	u32 *a = _a, *b = _b;
-	u8 *sz_a, *sz_b;
-
-	sz_a = map->field_offs->field_sz + (a - off_base);
-	sz_b = map->field_offs->field_sz + (b - off_base);
-
-	swap(*a, *b);
-	swap(*sz_a, *sz_b);
-}
-
-static int bpf_map_alloc_off_arr(struct bpf_map *map)
-{
-	bool has_fields = !IS_ERR_OR_NULL(map);
-	struct btf_field_offs *fo;
-	struct btf_record *rec;
-	u32 i, *off;
-	u8 *sz;
-
-	if (!has_fields) {
-		map->field_offs = NULL;
-		return 0;
-	}
-
-	fo = kmalloc(sizeof(*map->field_offs), GFP_KERNEL | __GFP_NOWARN);
-	if (!fo)
-		return -ENOMEM;
-	map->field_offs = fo;
-
-	rec = map->record;
-	off = &fo->field_off[fo->cnt];
-	sz = &fo->field_sz[fo->cnt];
-	for (i = 0; i < rec->cnt; i++) {
-		*off++ = rec->fields[i].offset;
-		*sz++ = btf_field_type_size(rec->fields[i].type);
-	}
-	fo->cnt = rec->cnt;
-
-	if (fo->cnt == 1)
-		return 0;
-	sort_r(fo->field_off, fo->cnt, sizeof(fo->field_off[0]),
-	       map_field_offs_cmp, map_field_offs_swap, map);
-	return 0;
-}
-
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1097,6 +1037,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 static int map_create(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
+	struct btf_field_offs *foffs;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1176,13 +1117,17 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = bpf_map_alloc_off_arr(map);
-	if (err)
+
+	foffs = btf_parse_field_offs(map->record);
+	if (IS_ERR(foffs)) {
+		err = PTR_ERR(foffs);
 		goto free_map;
+	}
+	map->field_offs = foffs;
 
 	err = security_bpf_map_alloc(map);
 	if (err)
-		goto free_map_off_arr;
+		goto free_map_field_offs;
 
 	err = bpf_map_alloc_id(map);
 	if (err)
@@ -1206,7 +1151,7 @@ static int map_create(union bpf_attr *attr)
 
 free_map_sec:
 	security_bpf_map_free(map);
-free_map_off_arr:
+free_map_field_offs:
 	kfree(map->field_offs);
 free_map:
 	btf_put(map->btf);
-- 
2.38.1

