Return-Path: <bpf+bounces-62269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3250AF73C1
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93943A9BE4
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D52ED17F;
	Thu,  3 Jul 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeH9l+cY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0DA2ECD36;
	Thu,  3 Jul 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545083; cv=none; b=QHovGmzAbRsXmU0Puvm1P+lyQkSkvVaCcrOMtuoF9Yi7YL2dsSSl2a3phzRXLWmW78fyZllw+085NS5Hd7ZmgMsU3CAzPw8jreYG3qO+8pNKhIbc1pJXsgqnJygLR7nb/NIF6DpwJsjiqHUaNvr85SLvFSZxB7I+oCdGHy8F+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545083; c=relaxed/simple;
	bh=La0AYlZV9+FyK0AzDczaGI6UGEXcjfox0Ty1jx5f12o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrOAwf7FCttnoRxnIfze+jhWuHKmRwvj/MnFFUQd3SDsbuuWkF6mLqNHKewYexwQluPnXNmH2+JXZ+vlRyOumhzQ2mOhtM2H1GniWyl1oEt10OptS3HSpohgamBSR817MP466vwQgNi1FKhV2Vj5ozEwffC0kVL+Ka3CDUoXayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeH9l+cY; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so746183b3a.1;
        Thu, 03 Jul 2025 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545080; x=1752149880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Yx2i/RsFWEZLSLE80TIcdg2IPYq5S8xCkpagV7D8E=;
        b=WeH9l+cYzWfCO7ttZ91Zx0oAXhJKt2Rw9KkTX8Y7E0KgnAhe7XgdLMbBZUxXKNzUJ6
         It0haB3QNVX6vxZJaAsPhk+9YLcccVpBl++4UdYphSODES55syx8Nx6OFVm6jDOl1ioS
         ZRql8ysrsIvOKfHxyb4CBGvQeyQ29iL1VEEGilEGxYe+ANVhkh1YB31ZfIqHzZMghU3j
         fh1LPQ1sIYW1t3xmNPHqR2ZCJVvSWBUodV1GmQneW5ocdXqNfzp1/4WZS6JNWPBvxdpf
         xLp1JuDZkh/iqkN4FO/NLGpr8t9ZIG35OajBTiXuu82WmXGvQuaZ261QBMxFGgMbQ0fY
         Bw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545080; x=1752149880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9Yx2i/RsFWEZLSLE80TIcdg2IPYq5S8xCkpagV7D8E=;
        b=NQhCju9izrlz5uzoynPDD/qeV4oBwOfdN0rpoX0qK7jbXHZMQmH1nhCroC87t/zG+g
         1Joo13R1zW2+CSjruDJbsEo9VQPaVRPMbD57coRsCQCmPXX+upJvpph0VtA2EFp1QLgP
         AwZuD/DdHjG4bURRs8+l2BSh3JK02X++cLSByyngO38NRbZCmNkuMEZkTM42RC6MKj/C
         VXWw5kRkdMUghD1M38tZA/cZdFxYzmTVBKDbmnjTVSmI60BCDW23pPJZYU8MvvNscmoL
         /eU89rj238eCmtEyFwymBXXfhK8CbEqR6zmIx2eN3WbiX7sTbKMdAryTlhNrAZeFJ/YY
         NqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL7pYZbZWH69bp8GmaVwWA2yRmHqaYOWizdshIL8QwH/Tj9UjEzHtPDc7zXqZuDKgBZ8XyNi+UbaU64XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuXInhJsD1SpYeNo08gF9AGTWgeZLMExnjluMfXjMyf6kFh9U1
	yWMa+pt04CBk4glixhzOhJgggAlRnqQ9OKv3gAdKmNwLO7Xq0KiRPUiKA47klP9WXcC30A==
X-Gm-Gg: ASbGncsvG+FYl3sjsrMBOcNnWg96KAW8b3Da4qk4eDWtYM5Fq5s+RJ1CKpdcibV/RmF
	BaK/+1tsXbM4G/KJC8CmQK/sgr/8hlGEprs+nv90leynLWQOpi5f9tKgK+chZbCJXV5E8yTCBRp
	5btIEGI4XCnBRDen1VY0TvYQrDdeYy0QPm/S4ENzl1EqVrcPvSKf7UcM0dhKg6r2H60UV5D6x/s
	lonK2/92g8EZQOsT3/Wr6ZlEEzyXQpCp2YJqben334xuCWzTtWzmablEnpPdckVxhFEO7WwIu+Z
	ec/0hxgR0ypkwVWkT3H25jJolOYZNfcQ1L3YAV2Vr1yR8vQ37kNUxLlQPtnaP1xj+JM5BbzVZcM
	5WBM=
X-Google-Smtp-Source: AGHT+IFW7nLu42gFZeYMeydNeqs23o4zl1h5ZpweM/sg5kU2f7EeW+Ane0OCw6+7/i4Ex4rcBOPjCQ==
X-Received: by 2002:a05:6a00:71cc:b0:749:eb:22c6 with SMTP id d2e1a72fcca58-74cd519b7dfmr1721451b3a.1.1751545080122;
        Thu, 03 Jul 2025 05:18:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:59 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup support
Date: Thu,  3 Jul 2025 20:15:17 +0800
Message-Id: <20250703121521.1874196-15-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the libbpf find the btf type id by loop all the btf types and
compare its name, which is inefficient if we have many functions to
lookup.

We add the "use_hash" to the function args of find_kernel_btf_id() to
indicate if we should lookup the btf type id by hash. The hash table will
be initialized if it has not yet.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/lib/bpf/btf.c      | 102 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |   6 +++
 tools/lib/bpf/libbpf.c   |  37 +++++++++++---
 tools/lib/bpf/libbpf.map |   3 ++
 4 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 37682908cb0f..e8ed8e6de7d7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -35,6 +35,7 @@ struct btf {
 	void *raw_data;
 	/* raw BTF data in non-native endianness */
 	void *raw_data_swapped;
+	struct hashmap *func_hash;
 	__u32 raw_size;
 	/* whether target endianness differs from the native one */
 	bool swapped_endian;
@@ -131,6 +132,12 @@ struct btf {
 	int ptr_sz;
 };
 
+struct btf_type_key {
+	__u32 dummy;
+	const char *name;
+	int kind;
+};
+
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
@@ -938,6 +945,100 @@ static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 	return libbpf_err(-ENOENT);
 }
 
+static size_t btf_hash_name(long key, void *btf)
+{
+	const struct btf_type *t = (const struct btf_type *)key;
+	const char *name;
+
+	if (t->name_off > BTF_MAX_NAME_OFFSET)
+		name = ((struct btf_type_key *)key)->name;
+	else
+		name = btf__name_by_offset(btf, t->name_off);
+
+	return str_hash(name);
+}
+
+static bool btf_name_equal(long key1, long key2, void *btf)
+{
+	const struct btf_type *t1 = (const struct btf_type *)key1,
+		*t2 = (const struct btf_type *)key2;
+	const char *name1, *name2;
+	int k1, k2;
+
+	name1 = btf__name_by_offset(btf, t1->name_off);
+	k1 = btf_kind(t1);
+
+	if (t2->name_off > BTF_MAX_NAME_OFFSET) {
+		struct btf_type_key *t2_key = (struct btf_type_key *)key2;
+
+		name2 = t2_key->name;
+		k2 = t2_key->kind;
+	} else {
+		name2 = btf__name_by_offset(btf, t2->name_off);
+		k2 = btf_kind(t2);
+	}
+
+	return k1 == k2 && strcmp(name1, name2) == 0;
+}
+
+__s32 btf__make_hash(struct btf *btf)
+{
+	__u32 i, nr_types = btf__type_cnt(btf);
+	struct hashmap *map;
+
+	if (btf->func_hash)
+		return 0;
+
+	map = hashmap__new(btf_hash_name, btf_name_equal, (void *)btf);
+	if (!map)
+		return libbpf_err(-ENOMEM);
+
+	for (i = btf->start_id; i < nr_types; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		int err;
+
+		/* only function need this */
+		if (btf_kind(t) != BTF_KIND_FUNC)
+			continue;
+
+		err = hashmap__add(map, t, i);
+		if (err == -EEXIST) {
+			pr_warn("btf type exist: name=%s\n",
+				btf__name_by_offset(btf, t->name_off));
+			continue;
+		}
+
+		if (err)
+			return libbpf_err(err);
+	}
+
+	btf->func_hash = map;
+	return 0;
+}
+
+bool btf__has_hash(struct btf *btf)
+{
+	return !!btf->func_hash;
+}
+
+int btf__find_by_func_hash(struct btf *btf, const char *type_name, __u32 kind)
+{
+	struct btf_type_key key = {
+		.dummy = 0xffffffff,
+		.name = type_name,
+		.kind = kind,
+	};
+	long t;
+
+	if (!btf->func_hash)
+		return -ENOENT;
+
+	if (hashmap__find(btf->func_hash, &key, &t))
+		return t;
+
+	return -ENOENT;
+}
+
 __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
 				 __u32 kind)
 {
@@ -974,6 +1075,7 @@ void btf__free(struct btf *btf)
 	if (btf->fd >= 0)
 		close(btf->fd);
 
+	hashmap__free(btf->func_hash);
 	if (btf_is_modifiable(btf)) {
 		/* if BTF was modified after loading, it will have a split
 		 * in-memory representation for header, types, and strings
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..dd88800684c0 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -336,6 +336,12 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 			 const void *data, size_t data_sz,
 			 const struct btf_dump_type_data_opts *opts);
 
+
+LIBBPF_API __s32 btf__make_hash(struct btf *btf);
+LIBBPF_API bool btf__has_hash(struct btf *btf);
+LIBBPF_API int
+btf__find_by_func_hash(struct btf *btf, const char *type_name, __u32 kind);
+
 /*
  * A set of helpers for easier BTF types handling.
  *
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ae38b3ab84c7..4c67f6ee8a90 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -634,6 +634,7 @@ struct extern_desc {
 
 struct module_btf {
 	struct btf *btf;
+	struct hashmap *btf_name_hash;
 	char *name;
 	__u32 id;
 	int fd;
@@ -717,6 +718,7 @@ struct bpf_object {
 	 * it at load time.
 	 */
 	struct btf *btf_vmlinux;
+	struct hashmap *btf_name_hash;
 	/* Path to the custom BTF to be used for BPF CO-RE relocations as an
 	 * override for vmlinux BTF.
 	 */
@@ -1004,7 +1006,7 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 			    struct module_btf **res_mod_btf);
 
 #define STRUCT_OPS_VALUE_PREFIX "bpf_struct_ops_"
-static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
+static int find_btf_by_prefix_kind(struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
@@ -10052,7 +10054,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 	}
 }
 
-static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
+static int find_btf_by_prefix_kind(struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind)
 {
 	char btf_type_name[BTF_MAX_NAME_SIZE];
@@ -10066,6 +10068,10 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 	 */
 	if (ret < 0 || ret >= sizeof(btf_type_name))
 		return -ENAMETOOLONG;
+
+	if (btf__has_hash(btf))
+		return btf__find_by_func_hash(btf, btf_type_name, kind);
+
 	return btf__find_by_name_kind(btf, btf_type_name, kind);
 }
 
@@ -10138,9 +10144,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
-			      int *btf_obj_fd, int *btf_type_id)
+			      int *btf_obj_fd, int *btf_type_id, bool use_hash)
 {
-	int ret, i, mod_len;
+	int ret, i, mod_len, err;
 	const char *fn_name, *mod_name = NULL;
 
 	fn_name = strchr(attach_name, ':');
@@ -10151,6 +10157,11 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 	}
 
 	if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) == 0) {
+		if (use_hash) {
+			err = btf__make_hash(obj->btf_vmlinux);
+			if (err)
+				return err;
+		}
 		ret = find_attach_btf_id(obj->btf_vmlinux,
 					 mod_name ? fn_name : attach_name,
 					 attach_type);
@@ -10173,6 +10184,11 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 		if (mod_name && strncmp(mod->name, mod_name, mod_len) != 0)
 			continue;
 
+		if (use_hash) {
+			err = btf__make_hash(mod->btf);
+			if (err)
+				return err;
+		}
 		ret = find_attach_btf_id(mod->btf,
 					 mod_name ? fn_name : attach_name,
 					 attach_type);
@@ -10222,7 +10238,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	} else {
 		err = find_kernel_btf_id(prog->obj, attach_name,
 					 attach_type, btf_obj_fd,
-					 btf_type_id);
+					 btf_type_id, false);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
@@ -12866,11 +12882,16 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
 			goto err_free;
 		}
 		for (i = 0; i < cnt; i++) {
-			btf_obj_fd = btf_type_id = 0;
+			/* only use btf type function hashmap when the count
+			 * is big enough.
+			 */
+			bool func_hash = cnt > 1024;
+
 
+			btf_obj_fd = btf_type_id = 0;
 			err = find_kernel_btf_id(prog->obj, opts->syms[i],
 					 prog->expected_attach_type, &btf_obj_fd,
-					 &btf_type_id);
+					 &btf_type_id, func_hash);
 			if (err)
 				goto err_free;
 			btf_ids[i] = btf_type_id;
@@ -13976,7 +13997,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 			return libbpf_err(err);
 		err = find_kernel_btf_id(prog->obj, attach_func_name,
 					 prog->expected_attach_type,
-					 &btf_obj_fd, &btf_id);
+					 &btf_obj_fd, &btf_id, false);
 		if (err)
 			return libbpf_err(err);
 	}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5f580b134d18..e7435252d15d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -446,4 +446,7 @@ LIBBPF_1.6.0 {
 		btf__add_type_attr;
 		bpf_object__free_btfs;
 		bpf_program__attach_trace_multi_opts;
+		btf__has_hash;
+		btf__find_by_func_hash;
+		btf__make_hash;
 } LIBBPF_1.5.0;
-- 
2.39.5


