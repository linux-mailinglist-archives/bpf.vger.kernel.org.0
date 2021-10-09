Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8101427B0F
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhJIPDE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhJIPDE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 11:03:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C003FC061570
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 08:01:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk10so9789187pjb.1
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oJW7122f4me76xl44a/OhxacHDQkKSoRCdXKn+Iqn8=;
        b=Cz8YPq4iuwe5tdYsY8nDtYm41q4a4hEdEtC3gZFPb1ln/sjdyKZu2OvR/p/NfdY5nB
         g+SxEQbuCLXWnQIh6VFBAYu5YsxeC/7KIGc8YCKTWPSwLhySa84zK94fZQFlnXT/wKgc
         lM0weIuteXby69s1nlVERFAwGtJ+lipT4OLu89Otrk5HPLFzmWMaJ2R92vfoDoiEV4ph
         xO/cm9Jm91PGMpKhqdmFIqBG+XKcoaAMJbaRKIGmdjgY943qy2kGGODMdlKsO9LfAACy
         5iEwGZUHV9Ww5d62QHyNsjnY/CKcSIdHVZiTzLw5ewCGWmMydZUBaLfJKsuD6TsfV2nx
         //dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oJW7122f4me76xl44a/OhxacHDQkKSoRCdXKn+Iqn8=;
        b=CdYhFkLk3G6t5NvK95LNlCNVJbQOPZGjBCTU8x0Y59OwzXkvsF6JqLsHhlc9vC6ljj
         koUoWn7H5DdhRxWYNsBkhcc7F/TyrkADhwn2u6wtK6e2i6nXMEVmzwHJH4bwr5wYs2RN
         KbXYoWUpVWRaCFjE/w4sWDo+6yyIOnHSpNoZ37StFg9mhLyirwL3zkho2a1NmCv2ukhj
         8Nz7RmGlDvhXZX3/af/alKoLa4zjAXk5k1RiAzaDsClzNCoY10cvy3fQG0czbSCU57+g
         csJctRv7iapGB0pTpOyr4vZtpqri/7qK/UU+3yEWXMlRoGCeUbLWGCntG7ma02rIxCwO
         eryw==
X-Gm-Message-State: AOAM5320LzOWrKH5Fpey8FYwDZ7blWH3jw8X/pPDGLcr8VoCsg9PFUl8
        21AS/cEoiI+tXO1PNjTrEYkW/aoWsHRRW0iB
X-Google-Smtp-Source: ABdhPJxYX8hmaxqntvTshK5l8hGJQhqH1mRUxCydnw5feL0BvzINCk8CVl962FjzcbriF/sUamMr0g==
X-Received: by 2002:a17:902:a385:b0:13e:99e9:17f3 with SMTP id x5-20020a170902a38500b0013e99e917f3mr14953028pla.65.1633791666893;
        Sat, 09 Oct 2021 08:01:06 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id w8sm2659331pfd.4.2021.10.09.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:01:06 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Add btf__type_cnt() and btf__raw_data() APIs
Date:   Sat,  9 Oct 2021 23:00:28 +0800
Message-Id: <20211009150029.1746383-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211009150029.1746383-1-hengqi.chen@gmail.com>
References: <20211009150029.1746383-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf__type_cnt() and btf__raw_data() APIs and deprecate
btf__get_nr_type() and btf__get_raw_data() since the old APIs
don't follow the libbpf naming convention for getters which
omit 'get' in the name.[0] btf__raw_data() is just an alias to
the existing btf__get_raw_data(). btf__type_cnt() now returns
the number of all types of the BTF object including 'void'.

  [0] Closes: https://github.com/libbpf/libbpf/issues/279

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
 tools/lib/bpf/btf.h      |  4 ++++
 tools/lib/bpf/btf_dump.c |  8 ++++----
 tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++----------------
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
 6 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 60fbd1c6d466..c9dc723b6075 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -57,7 +57,7 @@ struct btf {
 	 * representation is broken up into three independently allocated
 	 * memory regions to be able to modify them independently.
 	 * raw_data is nulled out at that point, but can be later allocated
-	 * and cached again if user calls btf__get_raw_data(), at which point
+	 * and cached again if user calls btf__raw_data(), at which point
 	 * raw_data will contain a contiguous copy of header, types, and
 	 * strings:
 	 *
@@ -435,6 +435,11 @@ __u32 btf__get_nr_types(const struct btf *btf)
 	return btf->start_id + btf->nr_types - 1;
 }
 
+__u32 btf__type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
 const struct btf *btf__base_btf(const struct btf *btf)
 {
 	return btf->base_btf;
@@ -466,8 +471,8 @@ static int determine_ptr_size(const struct btf *btf)
 	if (btf->base_btf && btf->base_btf->ptr_sz > 0)
 		return btf->base_btf->ptr_sz;
 
-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);
 		if (!btf_is_int(t))
 			continue;
@@ -684,12 +689,12 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 
 __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 {
-	__u32 i, nr_types = btf__get_nr_types(btf);
+	__u32 i, nr_types = btf__type_cnt(btf);
 
 	if (!strcmp(type_name, "void"))
 		return 0;
 
-	for (i = 1; i <= nr_types; i++) {
+	for (i = 1; i < nr_types; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
 		const char *name = btf__name_by_offset(btf, t->name_off);
 
@@ -703,12 +708,12 @@ __s32 btf__find_by_name(const struct btf *btf, const char *type_name)
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __u32 kind)
 {
-	__u32 i, nr_types = btf__get_nr_types(btf);
+	__u32 i, nr_types = btf__type_cnt(btf);
 
 	if (kind == BTF_KIND_UNKN || !strcmp(type_name, "void"))
 		return 0;
 
-	for (i = start_id; i <= nr_types; i++) {
+	for (i = start_id; i < nr_types; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
 		const char *name;
 
@@ -781,7 +786,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
-		btf->start_id = btf__get_nr_types(base_btf) + 1;
+		btf->start_id = btf__type_cnt(base_btf);
 		btf->start_str_off = base_btf->hdr->str_len;
 	}
 
@@ -831,7 +836,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
-		btf->start_id = btf__get_nr_types(base_btf) + 1;
+		btf->start_id = btf__type_cnt(base_btf);
 		btf->start_str_off = base_btf->hdr->str_len;
 	}
 
@@ -1317,7 +1322,7 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	return NULL;
 }
 
-const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
+const void *btf__raw_data(const struct btf *btf_ro, __u32 *size)
 {
 	struct btf *btf = (struct btf *)btf_ro;
 	__u32 data_sz;
@@ -1325,7 +1330,7 @@ const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
 
 	data = btf_get_raw_data(btf, &data_sz, btf->swapped_endian);
 	if (!data)
-		return errno = -ENOMEM, NULL;
+		return errno = ENOMEM, NULL;
 
 	btf->raw_size = data_sz;
 	if (btf->swapped_endian)
@@ -1336,6 +1341,9 @@ const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
 	return data;
 }
 
+__attribute__((alias("btf__raw_data")))
+const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+
 const char *btf__str_by_offset(const struct btf *btf, __u32 offset)
 {
 	if (offset < btf->start_str_off)
@@ -1744,7 +1752,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	old_strs_len = btf->hdr->str_len;
 
 	data_sz = src_btf->hdr->type_len;
-	cnt = btf__get_nr_types(src_btf);
+	cnt = btf__type_cnt(src_btf) - 1;
 
 	/* pre-allocate enough memory for new types */
 	t = btf_add_type_mem(btf, data_sz);
@@ -2061,7 +2069,7 @@ int btf__add_union(struct btf *btf, const char *name, __u32 byte_sz)
 
 static struct btf_type *btf_last_type(struct btf *btf)
 {
-	return btf_type_by_id(btf, btf__get_nr_types(btf));
+	return btf_type_by_id(btf, btf__type_cnt(btf) - 1);
 }
 
 /*
@@ -3265,7 +3273,7 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 		goto done;
 	}
 
-	type_cnt = btf__get_nr_types(btf) + 1;
+	type_cnt = btf__type_cnt(btf);
 	d->map = malloc(sizeof(__u32) * type_cnt);
 	if (!d->map) {
 		err = -ENOMEM;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 864eb51753a1..49397a22d72b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -131,7 +131,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
 					const char *type_name, __u32 kind);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__type_cnt() instead")
 LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
+LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
 LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
 						  __u32 id);
@@ -144,7 +146,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
 LIBBPF_API int btf__fd(const struct btf *btf);
 LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
+LIBBPF_DEPRECATED_SINCE(0, 6, "use btf__raw_data() instead")
 LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ad6df97295ae..e7ad6c00a901 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -188,7 +188,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 
 static int btf_dump_resize(struct btf_dump *d)
 {
-	int err, last_id = btf__get_nr_types(d->btf);
+	int err, last_id = btf__type_cnt(d->btf) - 1;
 
 	if (last_id <= d->last_id)
 		return 0;
@@ -262,7 +262,7 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 {
 	int err, i;
 
-	if (id > btf__get_nr_types(d->btf))
+	if (id >= btf__type_cnt(d->btf))
 		return libbpf_err(-EINVAL);
 
 	err = btf_dump_resize(d);
@@ -294,11 +294,11 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
  */
 static int btf_dump_mark_referenced(struct btf_dump *d)
 {
-	int i, j, n = btf__get_nr_types(d->btf);
+	int i, j, n = btf__type_cnt(d->btf);
 	const struct btf_type *t;
 	__u16 vlen;
 
-	for (i = d->last_id + 1; i <= n; i++) {
+	for (i = d->last_id + 1; i < n; i++) {
 		t = btf__type_by_id(d->btf, i);
 		vlen = btf_vlen(t);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae0889bebe32..c2fe484f9792 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2458,8 +2458,8 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		return -EINVAL;
 	}
 
-	nr_types = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= nr_types; i++) {
+	nr_types = btf__type_cnt(obj->btf);
+	for (i = 1; i < nr_types; i++) {
 		t = btf__type_by_id(obj->btf, i);
 		if (!btf_is_datasec(t))
 			continue;
@@ -2539,7 +2539,7 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	struct btf_type *t;
 	int i, j, vlen;
 
-	for (i = 1; i <= btf__get_nr_types(btf); i++) {
+	for (i = 1; i < btf__type_cnt(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);
 
 		if ((!has_datasec && btf_is_var(t)) || (!has_tag && btf_is_tag(t))) {
@@ -2767,8 +2767,8 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		if (!prog->mark_btf_static || !prog_is_subprog(obj, prog))
 			continue;
 
-		n = btf__get_nr_types(obj->btf);
-		for (j = 1; j <= n; j++) {
+		n = btf__type_cnt(obj->btf);
+		for (j = 1; j < n; j++) {
 			t = btf_type_by_id(obj->btf, j);
 			if (!btf_is_func(t) || btf_func_linkage(t) != BTF_FUNC_GLOBAL)
 				continue;
@@ -2788,7 +2788,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		__u32 sz;
 
 		/* clone BTF to sanitize a copy and leave the original intact */
-		raw_data = btf__get_raw_data(obj->btf, &sz);
+		raw_data = btf__raw_data(obj->btf, &sz);
 		kern_btf = btf__new(raw_data, sz);
 		err = libbpf_get_error(kern_btf);
 		if (err)
@@ -2801,7 +2801,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 
 	if (obj->gen_loader) {
 		__u32 raw_size = 0;
-		const void *raw_data = btf__get_raw_data(kern_btf, &raw_size);
+		const void *raw_data = btf__raw_data(kern_btf, &raw_size);
 
 		if (!raw_data)
 			return -ENOMEM;
@@ -3181,8 +3181,8 @@ static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
 	if (!btf)
 		return -ESRCH;
 
-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);
 
 		if (!btf_is_var(t) && !btf_is_func(t))
@@ -3213,8 +3213,8 @@ static int find_extern_sec_btf_id(struct btf *btf, int ext_btf_id) {
 	if (!btf)
 		return -ESRCH;
 
-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);
 
 		if (!btf_is_datasec(t))
@@ -3298,8 +3298,8 @@ static int find_int_btf_id(const struct btf *btf)
 	const struct btf_type *t;
 	int i, n;
 
-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);
 
 		if (btf_is_int(t) && btf_int_bits(t) == 32)
@@ -4897,8 +4897,8 @@ static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	size_t targ_essent_len;
 	int n, i;
 
-	n = btf__get_nr_types(targ_btf);
-	for (i = targ_start_id; i <= n; i++) {
+	n = btf__type_cnt(targ_btf);
+	for (i = targ_start_id; i < n; i++) {
 		t = btf__type_by_id(targ_btf, i);
 		if (btf_kind(t) != btf_kind(local_cand->t))
 			continue;
@@ -5073,7 +5073,7 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
 		err = bpf_core_add_cands(&local_cand, local_essent_len,
 					 obj->btf_modules[i].btf,
 					 obj->btf_modules[i].name,
-					 btf__get_nr_types(obj->btf_vmlinux) + 1,
+					 btf__type_cnt(obj->btf_vmlinux),
 					 cands);
 		if (err)
 			goto err_out;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f270d25e4af3..5f3cdb992d72 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,6 @@ LIBBPF_0.6.0 {
 		bpf_object__prev_program;
 		btf__add_btf;
 		btf__add_tag;
+		btf__raw_data;
+		btf__type_cnt;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 2df880cefdae..2c602c817d3b 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -921,7 +921,7 @@ static int check_btf_type_id(__u32 *type_id, void *ctx)
 {
 	struct btf *btf = ctx;
 
-	if (*type_id > btf__get_nr_types(btf))
+	if (*type_id >= btf__type_cnt(btf))
 		return -EINVAL;
 
 	return 0;
@@ -948,8 +948,8 @@ static int linker_sanity_check_btf(struct src_obj *obj)
 	if (!obj->btf)
 		return 0;
 
-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		t = btf_type_by_id(obj->btf, i);
 
 		err = err ?: btf_type_visit_type_ids(t, check_btf_type_id, obj->btf);
@@ -1659,8 +1659,8 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
 		return -EINVAL;
 	}
 
-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(obj->btf, i);
 
 		/* some global and extern FUNCs and VARs might not be associated with any
@@ -2131,8 +2131,8 @@ static int linker_fixup_btf(struct src_obj *obj)
 	if (!obj->btf)
 		return 0;
 
-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		struct btf_var_secinfo *vi;
 		struct btf_type *t;
 
@@ -2235,14 +2235,14 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 	if (!obj->btf)
 		return 0;
 
-	start_id = btf__get_nr_types(linker->btf) + 1;
-	n = btf__get_nr_types(obj->btf);
+	start_id = btf__type_cnt(linker->btf);
+	n = btf__type_cnt(obj->btf);
 
 	obj->btf_type_map = calloc(n + 1, sizeof(int));
 	if (!obj->btf_type_map)
 		return -ENOMEM;
 
-	for (i = 1; i <= n; i++) {
+	for (i = 1; i < n; i++) {
 		struct glob_sym *glob_sym = NULL;
 
 		t = btf__type_by_id(obj->btf, i);
@@ -2297,8 +2297,8 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 	}
 
 	/* remap all the types except DATASECs */
-	n = btf__get_nr_types(linker->btf);
-	for (i = start_id; i <= n; i++) {
+	n = btf__type_cnt(linker->btf);
+	for (i = start_id; i < n; i++) {
 		struct btf_type *dst_t = btf_type_by_id(linker->btf, i);
 
 		if (btf_type_visit_type_ids(dst_t, remap_type_id, obj->btf_type_map))
@@ -2657,7 +2657,7 @@ static int finalize_btf(struct bpf_linker *linker)
 	__u32 raw_sz;
 
 	/* bail out if no BTF data was produced */
-	if (btf__get_nr_types(linker->btf) == 0)
+	if (btf__type_cnt(linker->btf) == 1)
 		return 0;
 
 	for (i = 1; i < linker->sec_cnt; i++) {
@@ -2694,7 +2694,7 @@ static int finalize_btf(struct bpf_linker *linker)
 	}
 
 	/* Emit .BTF section */
-	raw_data = btf__get_raw_data(linker->btf, &raw_sz);
+	raw_data = btf__raw_data(linker->btf, &raw_sz);
 	if (!raw_data)
 		return -ENOMEM;
 
-- 
2.30.2

