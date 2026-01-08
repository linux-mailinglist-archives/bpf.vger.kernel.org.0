Return-Path: <bpf+bounces-78202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A6D00D71
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B3463004F3B
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7802882D7;
	Thu,  8 Jan 2026 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhFRc36Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD8287502
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842246; cv=none; b=a/MwTGPzyOI1jJIdih7K4zcILqStP+1QVoEaNcHZ6tDo6hC4daBslUYR/5nWHjRR4jMKtRqJYg5zAErYn3iYaP1aTPtirVe087x+d+6fM/e81NekHmlJALkm51O726YgqtuJyxQLnEAkgc7RTFDE95G3J2q8srGHCAlSNq9oaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842246; c=relaxed/simple;
	bh=HSH2cDhcqa8hihNqzM0cmWjWRa6J9Mh9nklD8GnTVc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k7dZWxzO2N8vqO6sCqG/1KiQFlENXsMmKz/ljCEa3wH2wf2g1qygAFaWV/zM8WkLJ8h2PNiXsqVIQCHvLiHv7kjR4zMDKFSgK6+h9ky2pYAa7RJlqUqQTJ1S29qOAXti8v6lRQjg5Jat04LQS7YRXIzjy20pVXSnjFZV43kS2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhFRc36Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a12ed4d205so19311485ad.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842244; x=1768447044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdiOPkebuRw2iRYJsvN/KjHUwH4DMOaF+wqFYzZkeeI=;
        b=lhFRc36YaOEhMJZpF06mTmuwayWrtFDDX6byf3UYkjBw3lEqrhU/BH7gRrSsJxe3qS
         9AtTQWmXzV3EivzR8cvzQQ5iNXvScIuNOb56+r7UGWs7vq2578gvvkGZaFdV6rmRQP7J
         Id0xV3BO0+NBpOv/MNlGYGGmSqZwfnfkJWf5sq+uAPXnOAWJ/As0hkP8XalEyn/oue8e
         m5NXmK7CUum4P0aPxYUVVePEKLlam7hpLyLcT2tRiF160bTBF2Kzz1GBoeU74yHwlZTI
         ETSgzxZwertf1PW9+Dq7LdpdsxTKTzFJuqFLHhlLykYrE4CUQx9W98WUdfUaXumpCb3y
         O0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842244; x=1768447044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdiOPkebuRw2iRYJsvN/KjHUwH4DMOaF+wqFYzZkeeI=;
        b=aFTZnRiG7dYKjbN+IaaOBApmZhjkQ5Y28tFXgZgGVv2V0VNa91cUYu+CjfS5kPpeyH
         IjIleZzF2B9WpTCP2KIixy4QahTpMc5ejzLrzGiLEP2MFua+BfRlYSCVivJ6e/xiGhv/
         7INn7//cw3edQHTCi7y9wSgPzGeMVN6QmWsTDDm4PtuK/eLXH99S98RA3wnbgG7zNwv7
         aBK+I3fp7PVRQ3WP8arI1/a1HAhuVz6Aor7WbGKzf5KJuQ8iLNoRDXwUm/kRqCvKEVwr
         1bhsPFDWEoqkgiXQivJbBFcCCQqMkTQO22oPflbrZJ09/9zHABN6yyX8om3Ol5k7p84N
         LVMw==
X-Forwarded-Encrypted: i=1; AJvYcCVpnD/+QSVMlcN4UbhJT1doSIPTVVzXsJ5Q9N1VrWU6G7F1hFHFz6KItNcuvTEwh6MrRb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafLA8I7wZmUVGzEqB8nlm+pwy04NQ+dIYlLlnQS8YD/XkpqVW
	V2IaWKvg/ISSwiAphY2Vpek5bxW1FWINqu8Wmgi7mr9n/AcnVRgQ85U7
X-Gm-Gg: AY/fxX68WBr3VpJEO5h1jyYxAYQVXMUX0OlYWl5qlMpUHg+nH5EAqV6l5teOxd5j4uo
	HJSHnnJWj7Qo3ua4qHEjU9qwM2aqrqk3hFq9N1u3IL78r2Jxpd9qU/Yo+UVeslxQD69YcHf2wZG
	6uamwulOhlV5Y+xGlhsSDx/zRaeSn9cn9duO8RzGCHYd2sBrmYA8TwJlc0F2pBSRB4WtRPOjg69
	KKbW1q9S+TvNz6bj+rHAuEQkLO1P6OCV8Fen/KHDuOHR2L62rL5eYLKyRmieDz+IDDHc/y1tZ4A
	NM/DKDLl2H/O5WAHpLyWMEgJkN46SWIyVFe30xC/5jt0AgUHzJg5N7biWE2ZC8OUDhX4OuDxsuS
	EkRZkt9bZ0knv61glhEz2qdkbJmpXkAsyXs+1PH0E6/Br/gHYVRmKcDMRo2djfNa+rd8uEGhsMJ
	eHMNAbyEqHf4Qc5/FyfWtWV1P7tco=
X-Google-Smtp-Source: AGHT+IFHwpnuvrFOHyCGVuhHu+rmSokA2SwaPRlM6b2SPtuMKwHghdpOZ5xiMR48M1E38yqC4qytXw==
X-Received: by 2002:a17:903:228a:b0:2a0:9a07:f8be with SMTP id d9443c01a7336-2a3ee436040mr42072775ad.22.1767842244426;
        Wed, 07 Jan 2026 19:17:24 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:23 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 11/11] btf: Refactor the code by calling str_is_empty
Date: Thu,  8 Jan 2026 11:16:45 +0800
Message-Id: <20260108031645.1350069-12-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Calling the str_is_empty function to clarify the code and
no functional changes are introduced.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf.c    | 34 +++++++++++++++++-----------------
 tools/lib/bpf/libbpf.c |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9e8911755a79..a10019338ca4 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2128,7 +2128,7 @@ int btf__add_int(struct btf *btf, const char *name, size_t byte_sz, int encoding
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	/* byte_sz must be power of 2 */
 	if (!byte_sz || (byte_sz & (byte_sz - 1)) || byte_sz > 16)
@@ -2176,7 +2176,7 @@ int btf__add_float(struct btf *btf, const char *name, size_t byte_sz)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	/* byte_sz must be one of the explicitly allowed values */
@@ -2231,7 +2231,7 @@ static int btf_add_ref_kind(struct btf *btf, int kind, const char *name, int ref
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2308,7 +2308,7 @@ static int btf_add_composite(struct btf *btf, int kind, const char *name, __u32
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2409,7 +2409,7 @@ int btf__add_field(struct btf *btf, const char *name, int type_id,
 	if (!m)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2447,7 +2447,7 @@ static int btf_add_enum_common(struct btf *btf, const char *name, __u32 byte_sz,
 	if (!t)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2505,7 +2505,7 @@ int btf__add_enum_value(struct btf *btf, const char *name, __s64 value)
 		return libbpf_err(-EINVAL);
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (value < INT_MIN || value > UINT_MAX)
 		return libbpf_err(-E2BIG);
@@ -2582,7 +2582,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
 		return libbpf_err(-EINVAL);
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	/* decompose and invalidate raw data */
@@ -2622,7 +2622,7 @@ int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value)
  */
 int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
 {
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	switch (fwd_kind) {
@@ -2658,7 +2658,7 @@ int btf__add_fwd(struct btf *btf, const char *name, enum btf_fwd_kind fwd_kind)
  */
 int btf__add_typedef(struct btf *btf, const char *name, int ref_type_id)
 {
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPEDEF, name, ref_type_id, 0);
@@ -2710,7 +2710,7 @@ int btf__add_restrict(struct btf *btf, int ref_type_id)
  */
 int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
 {
-	if (!value || !value[0])
+	if (str_is_empty(value))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 0);
@@ -2727,7 +2727,7 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
  */
 int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id)
 {
-	if (!value || !value[0])
+	if (str_is_empty(value))
 		return libbpf_err(-EINVAL);
 
 	return btf_add_ref_kind(btf, BTF_KIND_TYPE_TAG, value, ref_type_id, 1);
@@ -2746,7 +2746,7 @@ int btf__add_func(struct btf *btf, const char *name,
 {
 	int id;
 
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (linkage != BTF_FUNC_STATIC && linkage != BTF_FUNC_GLOBAL &&
 	    linkage != BTF_FUNC_EXTERN)
@@ -2832,7 +2832,7 @@ int btf__add_func_param(struct btf *btf, const char *name, int type_id)
 	if (!p)
 		return libbpf_err(-ENOMEM);
 
-	if (name && name[0]) {
+	if (!str_is_empty(name)) {
 		name_off = btf__add_str(btf, name);
 		if (name_off < 0)
 			return name_off;
@@ -2867,7 +2867,7 @@ int btf__add_var(struct btf *btf, const char *name, int linkage, int type_id)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 	if (linkage != BTF_VAR_STATIC && linkage != BTF_VAR_GLOBAL_ALLOCATED &&
 	    linkage != BTF_VAR_GLOBAL_EXTERN)
@@ -2916,7 +2916,7 @@ int btf__add_datasec(struct btf *btf, const char *name, __u32 byte_sz)
 	int sz, name_off;
 
 	/* non-empty name */
-	if (!name || !name[0])
+	if (str_is_empty(name))
 		return libbpf_err(-EINVAL);
 
 	if (btf_ensure_modifiable(btf))
@@ -2993,7 +2993,7 @@ static int btf_add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
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


