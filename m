Return-Path: <bpf+bounces-78325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D825D0A588
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED65731A9485
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A735EDD4;
	Fri,  9 Jan 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWUj5ZEl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911E35CB6A
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963645; cv=none; b=VnTTFXYDVA3oW49bUN5QBJpnDERRAueDEwG8u4FbV7MBollbSxHdpIul+M++OBldNwRFJmaeywKRNOLG2M1myU1WZMSHoqM+njndxXvZI34bbkr3lYza5mO4E6Slk46pkdQHpMidlGLSyD+zVjmCdVTAqD1VknqYSUukInpZNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963645; c=relaxed/simple;
	bh=y+RkYpOAQ7uM/0ey3EZvsKbFdv6jknz7JJQBhw+sV0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWFYgVPh03mjtlTsk9Vv23jjx3ybckzn/XD8NIQm2yAqq8r3dlLRoY9+NR9fNUs6UPAwWeRfWspyQ/xAgv2YBOzInK7vhUWwPZAmIL/rOMGBBGYDxJGPKeqw/HZURsnc+DZbM+TvZK0SawGHcGG3ScJ3nyH3F13NfqBxAc6ryzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWUj5ZEl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f1bc40b35so49230505ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963643; x=1768568443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO7278nlQYTAPfu3eaWy0xSK9M5O/y06GriyWS2ce/U=;
        b=dWUj5ZElExOKPKl7s7CV1ni/De8q/UmB/wwa/o3C53egK803aB42F9qDyDhQJ+Zdkh
         Vjr7ra2S8N+I11AlBPTND3Q5GX8pRP/tD0GhGGWlz0QJBglZC6IAnPBQGzuA1cUk9Zg/
         W+7o6LotVXVQcfmUiPBk13OEELPvtJPmH3FpUqkG88Rc7kZMzEBeRI9kPzD2VxivJFqH
         OFJ6joWU9rroLOIwV7C9AytYqhWFySgc7JmoC1+MCtbzTVxv9IM6wWo2QMVLlvQdWOcr
         cKMWQsffzhlRwtKDqf+OY7XJF9thTe84TAcbsmU7nDNPyQTSTp6fgEQ8fZ66+r4QDRkL
         QcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963643; x=1768568443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO7278nlQYTAPfu3eaWy0xSK9M5O/y06GriyWS2ce/U=;
        b=KvtMS9sjrAWiGSzuKt14wBN0R9qVhKrPfQxivoQt7rLU9pEUK16jev98Zi+obY/7Ll
         Ar1Ni+4GABrqEHpxMi8v0zziG63+GCx7VbYaEeWi10RJy4goYkVE0Dt59XAU5l/HyMgK
         NjFNuU5OSw5LX46SYDoZGJp4hlkVQHzoM3CAwU4yuCj4MKn14GIw5/8fMNrO8PNVEBrg
         fgCaUvOAcc/JTCs4vfIfuQ7yD4pclhAoqmd5jmfuPoiyeyST/U2E5VvTKlk5/Kb5epPt
         wP0juqsHJOOImXk1fucBZ5zP5yo8xlwhUemwCt51mwgex7uLnYwoyXB4j88aGn8o3tCo
         kElA==
X-Forwarded-Encrypted: i=1; AJvYcCU8gNFKxp1Nvhp6riJ9NT30R6QIkJdIgbbO4Lg4Hh0TR5ZQzlAxehUimOnA9MxWFYPp8CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1h9C2BxmSiwUyHEcEmuGoGjrgT3HJvnsrs2ZF3l5sq0bOf+H
	jAkMFTmE1Q9viNfgAgGlE2zcZFZdP53VqibtLwZXFxCKonUPtxz4TZDA
X-Gm-Gg: AY/fxX5lGCgVdbYkkfrLJNIxf6u7AWSrGrClNj7W/TTvnw9UqUv5lAKrzsx+yS0KSqm
	1FrzSh0DM7gS9W9cn9EUrG2sIUwzVDcOhoBCnYnIVf0aKrfnCOVeJW3UzFCDAOcQ8lb0ma88tmY
	7QxHEvjM5hevVR/4W39A8eFMOJw5LI8IJtKrqrLw4dlyYuOGiuMWZUiRtcEXuB4j5L8FZ8WwmVM
	A24FFeQtW9et8XSl7tGbxc5BUc53U8obT2xz8pds80E4Y9t/ZAex84zWhFvaSQk2laBNMatVPUZ
	zkZHGb7Afzh3yp/r7EL5Wum21RwJu7i4RRbmY7v5kCTz4T6imaudCKnY5PpUDqZVFtf1d4bD12x
	efo5Nqbz/3wpZr8wh8w2Zpbnx1ndjxz4Y4r1/O3ECtTvk7i0Xzm6ya14ycMJdqlRcpIRREGcP4J
	v3UdiEAAPpm0KpEJhyHIOKX05i4r8=
X-Google-Smtp-Source: AGHT+IG5Cqo3+38kG8ESzhWrBgdKbUFhdU0k029rjUkM6vXAH4vvVwZEbE/pXDENcUb+VYMnZzwlCQ==
X-Received: by 2002:a17:903:1cd:b0:2a0:b02b:2114 with SMTP id d9443c01a7336-2a3ee413b9cmr100817785ad.11.1767963642383;
        Fri, 09 Jan 2026 05:00:42 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:41 -0800 (PST)
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
Subject: [PATCH bpf-next v12 11/11] btf: Refactor the code by calling str_is_empty
Date: Fri,  9 Jan 2026 21:00:03 +0800
Message-Id: <20260109130003.3313716-12-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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
index 918d9fa6ec36..66e4a57896b3 100644
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
index 6ea81701e274..bbcfd72b07d5 100644
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


