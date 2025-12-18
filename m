Return-Path: <bpf+bounces-76983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9010CCBA16
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1BAC305B4E5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A6321445;
	Thu, 18 Dec 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhZMck+7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00C281532
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057525; cv=none; b=Qz0WchnT7ea90BSZgV9QUaGtlugpK4TS+G/OCtJ43ZIgVVTz9iQZmdZNoI8/WPUPfeCL5hmNK0C5gn2fOp/BPCvQgtx/K7uAo40szEtw5r7d7suYCKehUSS9umiuchocIYvg6VVfnUkLDP0/JAzJYYms7typg+pqBRSVCwSAy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057525; c=relaxed/simple;
	bh=HHZvtaPk3U38UuT89ZBstQ1qdjSdFHcPh8SIw5XW6RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecTpqEji8v75RVgRujxoy6AFH0i8G8Fl/fVzb8K8FFH97zQKv8CS+lZq74+IybAO0xe8c0nI6yNFmBWTlBrctr2CGEcOvA3k3EUQSNeDCVL1c4uqytMYtlQNZ8Dn/IMiWt4AlWOcIKgnM30Gx5wtomHU5ZKUyLTSCbMCIYGi+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhZMck+7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c868b197eso589660a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057522; x=1766662322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bzf60JLofSG2DA9NsCMwzI5A7CjeGtWYOi10qBfb/Y=;
        b=UhZMck+7OoG3MOzvs4qmKqXffLwzMH8Tsa4EasE77Pmylaemb9GDrKBCSYY7yb3Xwh
         F/3rHimx4tacktL6QuOvXrB6wCLl7GzSD8IkFKjQwwEugIWlMgV2mi573sZT/GVOucxB
         D6wALChjrY7e0PI+HvoE0cm2ZsYdEDHqMit/exCv1t9pIbHclENhws4GUQrXcuH7AXEL
         kWsI39NnK8HY1mDwKPZu2F/S6vAJzq2u+fIskk0+WCoSqS6Qk5qh0q8hRlMTknKCCac7
         G4R41VhVaQl0BjvUqW9vfT0pyYkWRTBqR9akUmQV19u1taLQAVG7VSiizK5aDJduTKvA
         YWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057522; x=1766662322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Bzf60JLofSG2DA9NsCMwzI5A7CjeGtWYOi10qBfb/Y=;
        b=fDJK7XZO2qh9gtzNU0GInN3ZdGYMMXM+EdgBA0gC9sycMxY9AJX3w3quMAbSVy/ips
         f9wvJxNFiduDH+W2BG74z8wv9ozAl5Qnd2wubKJx5rQdZ6gHU30dMJlhqTscoKmmE58r
         QC8sZtHOlhzF1GP5BXmEyzpKzUiVbSeMEx/NSL7gObmAYSSoe2Hp8ZOZMRgQoPxOp+Ey
         tVbMpCdIX9aGqbq0Q0Y0nkJX+NqxvI/kLgahwRnkxhO7U8LKg0eAQem85yzDylD4O3qu
         qyCBPSH2oKoxxVfeAm7v9OU+cvkrQjxB1VyjPGua+SqDtB29ca+hXXesGOra072dX+nR
         yxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6hbz2h3PdDu46o9qHN5O+twfw0MGg0RgNbECasUfOVU+nhAkL9XR/v6ulFrJz0E44wFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzeLooDxSJe/s0ttSttgXFUcPeYvhOpmTcL8kl97RefQ9vD0R
	bgggX4VRcO2KLDPD1ZWmO3h6hlXqX7PROF29fO1X5p6UXxfXylKTHayW
X-Gm-Gg: AY/fxX5DtqmlXjSTXoJl56bsZEYjy/TGgCN9ao/EWPF2G8iBqNUkXrWJkNGkjsU5jys
	l1cmJOeGstOjRrIFLWUXLVCOs2vfvse95Z+FDiTI4+M7g9BtRRpxzio1M9/zi/Q3a1VpYyWiZ1v
	DPI0cz8ZdVod2OEUM9Ec0I6yHZQCq5l3AipmZBd9urxD6CGzmQbTtv34dv+enT6p04Nw+YDd/Og
	ic77UZlAURKqx1QRW16rlytaNbSB05AE/Oq6MHnqdiTQGI8oai0Xqnx8XxB+l+xC6/GzBxWmn1Z
	mbdKm0HzDqvp0fuEYZtTHldunjWE9G9Eq7Lf1nnIqR1Hlq953b5zAm6HFbWJp7h9BR7kRQlVvTX
	M8kp+rfnZWUhkpyK6HX+dtJlEMzMj8d2hLXtYml7za/BfU9jr0i9bfCrYde4BRyb2Ksk5NNPAt8
	JzbqIqd8PjuACFMd1CoMtCEsUpfeo=
X-Google-Smtp-Source: AGHT+IGzuUSoe6qBzXdOooKd2p++fz1sAZV7aKg6xjIsW5m88zx941fiADaOW3O9M7LJ9BpuB6dUWg==
X-Received: by 2002:a17:90b:4c:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34abd6e0220mr21353294a91.12.1766057521908;
        Thu, 18 Dec 2025 03:32:01 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:59 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 13/13] btf: Refactor the code by calling str_is_empty
Date: Thu, 18 Dec 2025 19:30:51 +0800
Message-Id: <20251218113051.455293-14-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Calling the str_is_empty function to clarify the code and
no functional changes are introduced.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c    | 34 +++++++++++++++++-----------------
 tools/lib/bpf/libbpf.c |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 571b72bd90b5..013b1e5d396d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2169,7 +2169,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	/* byte_sz must be power of 2 */
 	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
@@ -2217,7 +2217,7 @@ int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	/* byte_sz must be one of the explicitly allowed values */
@@ -2272,7 +2272,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2349,7 +2349,7 @@ static int btf_add_composite(struct btf *btf, int kind, const char *name, __u32
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2450,7 +2450,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	if (!m)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2488,7 +2488,7 @@ static int btf_add_enum_common(struct btf *btf, const char *name, __u32 byte_sz,
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2546,7 +2546,7 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 		return libbpf_err(-EINVAL);
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (value < INT_MIN || value > UINT_MAX)
 		return libbpf_err(-E2BIG);
@@ -2623,7 +2623,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 		return libbpf_err(-EINVAL);
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
@@ -2663,7 +2663,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
  */
 int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
 {
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	switch (fwd_kind) {
@@ -2699,7 +2699,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
  */
 int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
 {
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id, 0);
@@ -2751,7 +2751,7 @@ int btf__add_restrict(struct btf *btf, int ref_type_id)
  */
 int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
 {
-	if (!value || !value[0])
+	if (str_is_empty(value))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 0);
@@ -2768,7 +2768,7 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
  */
 int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id)
 {
-	if (!value || !value[0])
+	if (str_is_empty(value))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 1);
@@ -2787,7 +2787,7 @@ int btf__add_func(struct btf *btf, const char *name,
 {
 	int id;
 
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (linkage != BTF_FUNC_STATIC && linkage != BTF_FUNC_GLOBAL &&
 	    linkage != BTF_FUNC_EXTERN)
@@ -2873,7 +2873,7 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 	if (!p)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2908,7 +2908,7 @@ int btf__add_var(struct btf *btf, const char *name, int linkage, int type_id)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (linkage != BTF_VAR_STATIC && linkage != BTF_VAR_GLOBAL_ALLOCATED &&
 	    linkage != BTF_VAR_GLOBAL_EXTERN)
@@ -2957,7 +2957,7 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	if (btf_ensure_modifiable(btf))
@@ -3034,7 +3034,7 @@ static int btf_add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
 	struct btf_type *t;
 	int sz, value_off;
 
-	if (!value || !value[0] || component_idx < -1)
+	if (str_is_empty(value) || component_idx < -1)
 		return libbpf_err(-EINVAL);
 
 	if (validate_type_id(ref_type_id))
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1a52d818a76c..96c6db972855 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2904,7 +2904,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 	var_extra = btf_var(var);
 	map_name = btf__name_by_offset(obj->btf, var->name_off);
 
-	if (map_name == NULL || map_name[0] == '\0') {
+	if (str_is_empty(map_name)) {
 		pr_warn("map #%d: empty name.\n", var_idx);
 		return -EINVAL;
 	}
@@ -4281,7 +4281,7 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 		if (!sym_is_extern(sym))
 			continue;
 		ext_name = elf_sym_str(obj, sym->st_name);
-		if (!ext_name || !ext_name[0])
+		if (str_is_empty(ext_name))
 			continue;
 
 		ext = obj->externs;
-- 
2.34.1


