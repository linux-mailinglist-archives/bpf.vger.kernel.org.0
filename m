Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EDC4377AB
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJVNJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJVNJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:09:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB8C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:06:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ls18so2914272pjb.3
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIkOTBMmt0KfecHGFJ+UypXjpIGhkKq4GQ/dC/dPuWw=;
        b=U7GqdXAXUntM/sDpYRFfYJh38VknWr4A7VvWVFoqfPOk1a/GjWr5lE+p/KtyV39sWD
         BlSJ5yWhyb3N0nnT06AuLBnRjqsIwSkt3tAunt0RmAcdseG8nhtndfWekKuZKAACMjpK
         bZWrSMkH0vqT+B5YsdyPXha/1+IxefCXPZq2ung01Zu47WnUQOYLJGfoMm2/u1/1yvSX
         Z+JTf5HkBn+bcghruoKvDwiRuA+tAya/67jiZqyVh3F/g7o176N5uUFiE5OltXdVHsm0
         om066QGjr8yKHoTIgEbJCXKg4sd0IMUyTsbTAoGHmJTOqSpOrGopi/bnKismpNDiXguk
         nGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIkOTBMmt0KfecHGFJ+UypXjpIGhkKq4GQ/dC/dPuWw=;
        b=34fwajDQPgj99mhLKecyfD6QhR4RmJ+99EykcVphX5iRCSh2FcjkStpN4wvaBCuT+y
         DRZUUJRztiXpYPR6zuNO+5MW5qRspMDFSaxMYbJHP66a8CGqg+eMB78kzGGDF4m4MJNC
         ihbhTXKGUdKEMtfboQ+zZSRTCirYs/oMdKKf+rakSH1FvKiP+aRs5QV9+wWpyGK3Yg1D
         AbXYsJfOJt4kJvhP+ZohdaZjN+E1+OUy/lEZ9TYnAJ1O5FboxPTrX3vQ2etkUmFAQgB5
         q+Gle0zq3KTR62LPaFcsnR3E9H3TV7u4Biw3W/so/Gl9+zBduVmHRFveln8ranzv1ZA5
         hGiA==
X-Gm-Message-State: AOAM532ozlPCzYdL3ruZiy/MaV+iM9KuJYenSOHTV9yGPIG6LX7h+CbE
        zjLWSU74szImBig0Dbx0MK9B/HcfvUMZ6w==
X-Google-Smtp-Source: ABdhPJxn95DFywDAp+PY7NkYLgXo/Br6OZdV4K7kJkfWkF6ocpKTRcSkUzxSxFTDiTO7XQjVMP7ggQ==
X-Received: by 2002:a17:90b:1e50:: with SMTP id pi16mr8947702pjb.49.1634908013693;
        Fri, 22 Oct 2021 06:06:53 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:06:53 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/5 v2] libbpf: Add btf__type_cnt() and btf__raw_data() APIs
Date:   Fri, 22 Oct 2021 21:06:19 +0800
Message-Id: <20211022130623.1548429-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf__type_cnt() and btf__raw_data() APIs and deprecate
btf__get_nr_type() and btf__get_raw_data() since the old APIs
don't follow the libbpf naming convention for getters which
omit 'get' in the name (see [0]). btf__raw_data() is just an
alias to the existing btf__get_raw_data(). btf__type_cnt()
now returns the number of all types of the BTF object
including 'void'.

  [0] Closes: https://github.com/libbpf/libbpf/issues/279

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/btf.c      | 36 ++++++++++++++++++++++--------------
 tools/lib/bpf/btf.h      |  4 ++++
 tools/lib/bpf/btf_dump.c |  8 ++++----
 tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++------------------
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/linker.c   | 28 ++++++++++++++--------------
 6 files changed, 64 insertions(+), 50 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3a01c4b7f36a..ed88746a438f 100644
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

@@ -1224,7 +1229,7 @@ static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endi
 	return NULL;
 }

-const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
+const void *btf__raw_data(const struct btf *btf_ro, __u32 *size)
 {
 	struct btf *btf = (struct btf *)btf_ro;
 	__u32 data_sz;
@@ -1232,7 +1237,7 @@ const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)

 	data = btf_get_raw_data(btf, &data_sz, btf->swapped_endian);
 	if (!data)
-		return errno = -ENOMEM, NULL;
+		return errno = ENOMEM, NULL;

 	btf->raw_size = data_sz;
 	if (btf->swapped_endian)
@@ -1243,6 +1248,9 @@ const void *btf__get_raw_data(const struct btf *btf_ro, __u32 *size)
 	return data;
 }

+__attribute__((alias("btf__raw_data")))
+const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+
 const char *btf__str_by_offset(const struct btf *btf, __u32 offset)
 {
 	if (offset < btf->start_str_off)
@@ -1651,7 +1659,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 	old_strs_len = btf->hdr->str_len;

 	data_sz = src_btf->hdr->type_len;
-	cnt = btf__get_nr_types(src_btf);
+	cnt = btf__type_cnt(src_btf) - 1;

 	/* pre-allocate enough memory for new types */
 	t = btf_add_type_mem(btf, data_sz);
@@ -1968,7 +1976,7 @@ int btf__add_union(struct btf *btf, const char *name, __u32 byte_sz)

 static struct btf_type *btf_last_type(struct btf *btf)
 {
-	return btf_type_by_id(btf, btf__get_nr_types(btf));
+	return btf_type_by_id(btf, btf__type_cnt(btf) - 1);
 }

 /*
@@ -3172,7 +3180,7 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 		goto done;
 	}

-	type_cnt = btf__get_nr_types(btf) + 1;
+	type_cnt = btf__type_cnt(btf);
 	d->map = malloc(sizeof(__u32) * type_cnt);
 	if (!d->map) {
 		err = -ENOMEM;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index c9364be42035..bc005ba3ceec 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -132,7 +132,9 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
 LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
 					const char *type_name, __u32 kind);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__type_cnt() instead; note that btf__get_nr_types() == btf__type_cnt() - 1")
 LIBBPF_API __u32 btf__get_nr_types(const struct btf *btf);
+LIBBPF_API __u32 btf__type_cnt(const struct btf *btf);
 LIBBPF_API const struct btf *btf__base_btf(const struct btf *btf);
 LIBBPF_API const struct btf_type *btf__type_by_id(const struct btf *btf,
 						  __u32 id);
@@ -145,7 +147,9 @@ LIBBPF_API int btf__resolve_type(const struct btf *btf, __u32 type_id);
 LIBBPF_API int btf__align_of(const struct btf *btf, __u32 id);
 LIBBPF_API int btf__fd(const struct btf *btf);
 LIBBPF_API void btf__set_fd(struct btf *btf, int fd);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use btf__raw_data() instead")
 LIBBPF_API const void *btf__get_raw_data(const struct btf *btf, __u32 *size);
+LIBBPF_API const void *btf__raw_data(const struct btf *btf, __u32 *size);
 LIBBPF_API const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API const char *btf__str_by_offset(const struct btf *btf, __u32 offset);
 LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e9e5801ece4c..c09a020f56f9 100644
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
index db6e48014839..eb102440a28a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2497,8 +2497,8 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		return -EINVAL;
 	}

-	nr_types = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= nr_types; i++) {
+	nr_types = btf__type_cnt(obj->btf);
+	for (i = 1; i < nr_types; i++) {
 		t = btf__type_by_id(obj->btf, i);
 		if (!btf_is_datasec(t))
 			continue;
@@ -2579,7 +2579,7 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 	struct btf_type *t;
 	int i, j, vlen;

-	for (i = 1; i <= btf__get_nr_types(btf); i++) {
+	for (i = 1; i < btf__type_cnt(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);

 		if ((!has_datasec && btf_is_var(t)) || (!has_decl_tag && btf_is_decl_tag(t))) {
@@ -2763,9 +2763,9 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 static int btf_finalize_data(struct bpf_object *obj, struct btf *btf)
 {
 	int err = 0;
-	__u32 i, n = btf__get_nr_types(btf);
+	__u32 i, n = btf__type_cnt(btf);

-	for (i = 1; i <= n; i++) {
+	for (i = 1; i < n; i++) {
 		struct btf_type *t = btf_type_by_id(btf, i);

 		/* Loader needs to fix up some of the things compiler
@@ -2905,8 +2905,8 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		if (!prog->mark_btf_static || !prog_is_subprog(obj, prog))
 			continue;

-		n = btf__get_nr_types(obj->btf);
-		for (j = 1; j <= n; j++) {
+		n = btf__type_cnt(obj->btf);
+		for (j = 1; j < n; j++) {
 			t = btf_type_by_id(obj->btf, j);
 			if (!btf_is_func(t) || btf_func_linkage(t) != BTF_FUNC_GLOBAL)
 				continue;
@@ -2926,7 +2926,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		__u32 sz;

 		/* clone BTF to sanitize a copy and leave the original intact */
-		raw_data = btf__get_raw_data(obj->btf, &sz);
+		raw_data = btf__raw_data(obj->btf, &sz);
 		kern_btf = btf__new(raw_data, sz);
 		err = libbpf_get_error(kern_btf);
 		if (err)
@@ -2939,7 +2939,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)

 	if (obj->gen_loader) {
 		__u32 raw_size = 0;
-		const void *raw_data = btf__get_raw_data(kern_btf, &raw_size);
+		const void *raw_data = btf__raw_data(kern_btf, &raw_size);

 		if (!raw_data)
 			return -ENOMEM;
@@ -3350,8 +3350,8 @@ static int find_extern_btf_id(const struct btf *btf, const char *ext_name)
 	if (!btf)
 		return -ESRCH;

-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);

 		if (!btf_is_var(t) && !btf_is_func(t))
@@ -3382,8 +3382,8 @@ static int find_extern_sec_btf_id(struct btf *btf, int ext_btf_id) {
 	if (!btf)
 		return -ESRCH;

-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);

 		if (!btf_is_datasec(t))
@@ -3467,8 +3467,8 @@ static int find_int_btf_id(const struct btf *btf)
 	const struct btf_type *t;
 	int i, n;

-	n = btf__get_nr_types(btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(btf, i);

 		if (btf_is_int(t) && btf_int_bits(t) == 32)
@@ -5076,8 +5076,8 @@ static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 	size_t targ_essent_len;
 	int n, i;

-	n = btf__get_nr_types(targ_btf);
-	for (i = targ_start_id; i <= n; i++) {
+	n = btf__type_cnt(targ_btf);
+	for (i = targ_start_id; i < n; i++) {
 		t = btf__type_by_id(targ_btf, i);
 		if (btf_kind(t) != btf_kind(local_cand->t))
 			continue;
@@ -5252,7 +5252,7 @@ bpf_core_find_cands(struct bpf_object *obj, const struct btf *local_btf, __u32 l
 		err = bpf_core_add_cands(&local_cand, local_essent_len,
 					 obj->btf_modules[i].btf,
 					 obj->btf_modules[i].name,
-					 btf__get_nr_types(obj->btf_vmlinux) + 1,
+					 btf__type_cnt(obj->btf_vmlinux),
 					 cands);
 		if (err)
 			goto err_out;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e6fb1ba49369..116964a29e44 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,6 @@ LIBBPF_0.6.0 {
 		bpf_object__prev_program;
 		btf__add_btf;
 		btf__add_decl_tag;
+		btf__raw_data;
+		btf__type_cnt;
 } LIBBPF_0.5.0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 13e6fdc7d8cb..7bf658fbda80 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -920,7 +920,7 @@ static int check_btf_type_id(__u32 *type_id, void *ctx)
 {
 	struct btf *btf = ctx;

-	if (*type_id > btf__get_nr_types(btf))
+	if (*type_id >= btf__type_cnt(btf))
 		return -EINVAL;

 	return 0;
@@ -947,8 +947,8 @@ static int linker_sanity_check_btf(struct src_obj *obj)
 	if (!obj->btf)
 		return 0;

-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		t = btf_type_by_id(obj->btf, i);

 		err = err ?: btf_type_visit_type_ids(t, check_btf_type_id, obj->btf);
@@ -1658,8 +1658,8 @@ static int find_glob_sym_btf(struct src_obj *obj, Elf64_Sym *sym, const char *sy
 		return -EINVAL;
 	}

-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		t = btf__type_by_id(obj->btf, i);

 		/* some global and extern FUNCs and VARs might not be associated with any
@@ -2130,8 +2130,8 @@ static int linker_fixup_btf(struct src_obj *obj)
 	if (!obj->btf)
 		return 0;

-	n = btf__get_nr_types(obj->btf);
-	for (i = 1; i <= n; i++) {
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
 		struct btf_var_secinfo *vi;
 		struct btf_type *t;

@@ -2234,14 +2234,14 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
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
@@ -2296,8 +2296,8 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
 	}

 	/* remap all the types except DATASECs */
-	n = btf__get_nr_types(linker->btf);
-	for (i = start_id; i <= n; i++) {
+	n = btf__type_cnt(linker->btf);
+	for (i = start_id; i < n; i++) {
 		struct btf_type *dst_t = btf_type_by_id(linker->btf, i);

 		if (btf_type_visit_type_ids(dst_t, remap_type_id, obj->btf_type_map))
@@ -2656,7 +2656,7 @@ static int finalize_btf(struct bpf_linker *linker)
 	__u32 raw_sz;

 	/* bail out if no BTF data was produced */
-	if (btf__get_nr_types(linker->btf) == 0)
+	if (btf__type_cnt(linker->btf) == 1)
 		return 0;

 	for (i = 1; i < linker->sec_cnt; i++) {
@@ -2693,7 +2693,7 @@ static int finalize_btf(struct bpf_linker *linker)
 	}

 	/* Emit .BTF section */
-	raw_data = btf__get_raw_data(linker->btf, &raw_sz);
+	raw_data = btf__raw_data(linker->btf, &raw_sz);
 	if (!raw_data)
 		return -ENOMEM;

--
2.30.2
