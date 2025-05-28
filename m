Return-Path: <bpf+bounces-59109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7AAC6070
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00F89E11D4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232A21E094;
	Wed, 28 May 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRAHr2Y/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58521CC71;
	Wed, 28 May 2025 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404222; cv=none; b=CggqQuerExIoauh+l2AzaowKhzu/yhSQuuBvmfnsTSq6AUVSs3iynZDcM3HDpAn+TYXVA4XhpXwS10DPYy2CWt96UCZBZDz/M1xcm2/qMRCag1fdKErlZjh2juqWer4d8SKuAbBt0itVGTK60e7aInyOTClBpHN0u/SglmS+qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404222; c=relaxed/simple;
	bh=Cg0Y83b329LN/NLe5Rd1wETYp97M1UfTmvlXP4dlxQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXjFUVrJY7B/nH2/JvGPzlRjnJ8mN4xxqgKpavwogUu+3cgXDC6gyMjnGKButozb3rUI3su4snQJfbGI4mQGka1IaF3Yb5g/8+t611IVZ8DLTQ3cYhX3GZiGpCF1YLrHYaS5KJeVm4UKZ5lMXo6b4g2Aonp5gNKgMn2PMmlpfSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRAHr2Y/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-23035b3edf1so30877705ad.3;
        Tue, 27 May 2025 20:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404220; x=1749009020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppMvLXTeAVvwICb0b3sYSiEahNB4W8tGcpU/rQDfwuU=;
        b=cRAHr2Y/y+obMbKpBPI6GwhsvMpEWZXpmeRgyA1BFtnw+6LIaWSFJlmZeD4zMsmQ7g
         ZvFULvNVLVBtMKE7S/EatPiszGJBdYo4+DxO5e/QBnK+60VK3fS6+FlEtZAgdIRri6Pm
         E68jRhQtnsTinWvlmKNEuAP9vVIefbx7ZJaxv0Y+UBMouo2hBdNuo7iRozE8ppWGLrwo
         /Du20/uzLSq2hUEZ/6emFMhcjtsUtZ51UAoK4telD65GlF/VNl8NFOXlAUqwmcHktm6C
         yEJW0ETMakWHub5WTMSc0C1mK02Kq6OTcpICNhHxwRoCWM0lDFL2CzjAyhK0xOm5TD+r
         N6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404220; x=1749009020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppMvLXTeAVvwICb0b3sYSiEahNB4W8tGcpU/rQDfwuU=;
        b=BnctoszIztFf0yKx4qE1uHrLCbRfkp3/zpdwX5XB+LsxJoPzyt0aMPdPWGNwfZ+rSG
         yd8W5d+tIUun3+R2yFBOOeimMaAVTOmwXB1skpgtrN9OL464MO8UZ8Vj7Dr/05tKxCVt
         f/hZ8M5eUxyxr42yAZiP9TXdPbkrl8e1rJAf/f+2Kx1K57hgl6yiejOPjghwek7qr9Y0
         FVeZihV1izQuHXZ273qtQt2x/dwAeGPQ2Z1e4w7Id06oMi09h+MNtdiWI3jvp4XQ3hmR
         q1XGBWrk0h3Tr5vV8KW+uOhLyMGAAdpb5W5ia1A+efbP66YR0dkA4x+Kx2+Q/yZHYM0W
         d00A==
X-Forwarded-Encrypted: i=1; AJvYcCUiJmLabYD98P5QOgf3vCXAa5/1FXzPcGwHM/8xrNYL8eH0mzmBDGg5XaXeq+J8UE4pR2kOGi3wCAsZoPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lZadbUzaLFDkrZKf4Q6kNYl6JG4OjLSza9++U9krkjTFZ2r2
	SZSzUfzr1GS6NMCtuQnw31O/xq44JM79N+INZlo7ZGi6XmPXD3nks7oO
X-Gm-Gg: ASbGncuAJoBV7sxJWxgjRYqlaOnMtQ/ekjh/+dq7DagYXzO0eR/ZIEMNnTL1//d4oCv
	xmcDf5PEat8VZIMBNuJIYio0kahgfisGrTG+ZLfMCUGz4M7nVi8JGYNLBbSOE5FyHcFMDqMG8OJ
	AREzub26Z79r6g61sHdJLcflzxuROx7XxBd8E2MOaFz0V7E59czYhPQyV/MQiMHa0b2Z/TwtPY6
	oM3cqhAk29Zc2XtAhHkIGTmJ2yjTPpo4xd7PZBqr97/GbHJoZKw+MfKf3b7QJw3dB9oDWkjoSBo
	zt+iMSULzEi2h/+nattoP4khDHDcXepBAs/If7AYQxypue9lYXZd3pj2F22Q+PMeIDY+Pd5E6TB
	M/wg=
X-Google-Smtp-Source: AGHT+IGY4I9vvI1XK8m9Bv5+nxTB1QcaQm+Nu44QbsEkVPydM4PCaf7ATyYKIvKCS4IIHIi+e1yqAA==
X-Received: by 2002:a17:903:986:b0:234:c8f6:1b03 with SMTP id d9443c01a7336-234d2c4aa08mr13167895ad.47.1748404219819;
        Tue, 27 May 2025 20:50:19 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 20/25] libbpf: add btf type hash lookup support
Date: Wed, 28 May 2025 11:47:07 +0800
Message-Id: <20250528034712.138701-21-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
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
index f1d495dc66bb..a0df16296a94 100644
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
+bool btf__hash_hash(struct btf *btf)
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
index 4392451d634b..8639377a1f3b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -335,6 +335,12 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 			 const void *data, size_t data_sz,
 			 const struct btf_dump_type_data_opts *opts);
 
+
+LIBBPF_API __s32 btf__make_hash(struct btf *btf);
+LIBBPF_API bool btf__hash_hash(struct btf *btf);
+LIBBPF_API int
+btf__find_by_func_hash(struct btf *btf, const char *type_name, __u32 kind);
+
 /*
  * A set of helpers for easier BTF types handling.
  *
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c4ed5d237e5..4a903102e0c7 100644
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
@@ -10040,7 +10042,7 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 	}
 }
 
-static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
+static int find_btf_by_prefix_kind(struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind)
 {
 	char btf_type_name[BTF_MAX_NAME_SIZE];
@@ -10054,6 +10056,10 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 	 */
 	if (ret < 0 || ret >= sizeof(btf_type_name))
 		return -ENAMETOOLONG;
+
+	if (btf__hash_hash(btf))
+		return btf__find_by_func_hash(btf, btf_type_name, kind);
+
 	return btf__find_by_name_kind(btf, btf_type_name, kind);
 }
 
@@ -10126,9 +10132,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int t
 
 static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 			      enum bpf_attach_type attach_type,
-			      int *btf_obj_fd, int *btf_type_id)
+			      int *btf_obj_fd, int *btf_type_id, bool use_hash)
 {
-	int ret, i, mod_len;
+	int ret, i, mod_len, err;
 	const char *fn_name, *mod_name = NULL;
 
 	fn_name = strchr(attach_name, ':');
@@ -10139,6 +10145,11 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
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
@@ -10161,6 +10172,11 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
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
@@ -10210,7 +10226,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	} else {
 		err = find_kernel_btf_id(prog->obj, attach_name,
 					 attach_type, btf_obj_fd,
-					 btf_type_id);
+					 btf_type_id, false);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
@@ -12854,11 +12870,16 @@ struct bpf_link *bpf_program__attach_trace_multi_opts(const struct bpf_program *
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
@@ -13936,7 +13957,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 			return libbpf_err(err);
 		err = find_kernel_btf_id(prog->obj, attach_func_name,
 					 prog->expected_attach_type,
-					 &btf_obj_fd, &btf_id);
+					 &btf_obj_fd, &btf_id, false);
 		if (err)
 			return libbpf_err(err);
 	}
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index fab014528b86..100b14de9b22 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -445,4 +445,7 @@ LIBBPF_1.6.0 {
 		bpf_program__line_info_cnt;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		btf__hash_hash;
+		btf__find_by_func_hash;
+		btf__make_hash;
 } LIBBPF_1.5.0;
-- 
2.39.5


