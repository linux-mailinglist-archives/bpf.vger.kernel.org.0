Return-Path: <bpf+bounces-59505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D3ACC8E1
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D43B188F166
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0FB3E47B;
	Tue,  3 Jun 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+ID4G6x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25724238C34
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960155; cv=none; b=CY8tOCOd0eWXOy2/r8fPRK78UJEv95i0Uwt1Q/19G5WXarzZUw8KapxIynE2KhetLuvN6rySF+km6s6qT6cMWZfenoCiM0tLVjLOdvvCaE7NzaBpDbh4Fh9gRBQIvDjSoUjKcWT28AkQvOXJsp1OsOpv859wSX9TRiT2LjrC8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960155; c=relaxed/simple;
	bh=RnYiKUqRblzk4ZJYFFR2SUJ1hne3zrlLlvcK3ciNWXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=litfDLM75wYLFSaJENHVInK7JgL90qvWGXOAPFLaSTRskEsqhBOjjwiwrHG8ZgQaeJYFKyjlaVPS9wlkhV/J4vNAyY83SJJYKxd7FyYuESeMQfqiruP8UjS3iwRkjhKdYojDq9RphUz/8N2+zUdDoabDZS7HzAM1rsEp/M6YaHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+ID4G6x; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-602e203db66so9830518a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960151; x=1749564951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxVdQSMTqRwFjabyM0u1EAj8PBs1OukFHP23aE1ZMw8=;
        b=Y+ID4G6xdzkT9BXo/2K9+or7R2D97La7AxeGVg9fgIb1XDkeF8flHSQywzF6SBaffT
         Bt5Blf3NHAfyED66y3WGHXoyJmzDPrOGRNDOi5DP+E5tTKUPofd3T+9D+x2nO+lTD6UV
         FetNr77/NHjbf2j/wvweLses9glGSAchuVI3YlxSeRnGlKYL6x+KHdJdIMvDzCv6/P8F
         RziFqRciUGOnWhw9yaalYTpXcYJW0VasTlJDr91FM7zB6pqywP4Riq81nuuYxaQTiSCI
         HOWjm1/xi5HGWY9sWsyR4H8lOlHnW34zUiAIROCrnswTsjre+PtW2Rjn2ilkQynr0fc/
         jBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960151; x=1749564951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxVdQSMTqRwFjabyM0u1EAj8PBs1OukFHP23aE1ZMw8=;
        b=u9IP+BHgS2aMqXMRP1UxFD7j2FZzEGQ3E5JTAxwbsSRgsD0CHaywoPBCAuVrj7cHTn
         wR4gZqOgIOdW0brBffqWPOUPVdbHE8V4bjqpgz8t7GfWqdlk3tUD5e/FZqmVHCwdPmXE
         xOEp1l7pPNC0YdzlJMtthSh9/AZic3X70YL8v62Li9KtzUxCS83gqxZtqMP8fiGdnU5Q
         Si54QCEcy5CfxK5UMwP93b7EKp+Ay1SoYzH1ZjFvK8xGhVBUL1Az4u3i9PelNqmVu/3B
         7l7plPNK42rSxnl3b+dveJykzJMU9g9z3aFX7xcuBYBO5E5cFgwqajGLUjyF1cIRFMWd
         RFWQ==
X-Gm-Message-State: AOJu0YwEViSIzmpvDkpoD83jLAP/TjCncG1CT2fdqGMqQKk2+FuQZL/d
	MIjSXQ5eIYl1mgMZjzdU9xpA6uZQ5H8rVNyf0QIqNuXJ5JCVehVzKMZsYUg5xT0m
X-Gm-Gg: ASbGncsNwd34/GWj2SU32lHKvv7hgnLVWpWK0ONF0L1w3qR9vC9wChzE/1PK8OmDMYe
	rJ+xnclAVO+ITIOS6IWq8SV6DSAHUr7dWlJcxBx/PCpf7hZ0Ooy7Uf1qadLtchXF3rl14R7FrF8
	ujNqt1YBSFTfnGieVoQb9lNlM6sc7CU/e+HJypx7FwuSZRu+mFfLIoUrzz73r1EwFE7lKuFbkTf
	CPY+TQZx9micWZIysJB/5iSohwSM0KQmLD0PbMqE02CnHRPfhpzMbnpf5Hj3lYD6Y4jVInxhKsy
	3mvH0iJZc3Y3khQoZmaILBmFMlg6ZXhF2D3jmN9UOU0ZXLkmsJDBdJqRLkfr
X-Google-Smtp-Source: AGHT+IG3icnFCFs/moNVEkUA7NA5D+AcoexDD8WdhGEQXWs9QLvYlFyiHqTpxObuMcRf0w+qfuvlsw==
X-Received: by 2002:a05:6402:3593:b0:601:6c34:5ed2 with SMTP id 4fb4d7f45d1cf-605b77213d4mr11638154a12.4.1748960151004;
        Tue, 03 Jun 2025 07:15:51 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:8d44:8ebc:1af3:5969])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c2b39asm7757329a12.7.2025.06.03.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:15:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: support array presets in veristat
Date: Tue,  3 Jun 2025 15:15:38 +0100
Message-ID: <20250603141539.86878-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement support for presetting values for array elements in veristat.
For example:
```
sudo ./veristat set_global_vars.bpf.o -G "struct1[2].struct2[1].u.var_u8[2] = 3" -G "arr[3] = 9"
```
Arrays of structures and structure of arrays work, but each individual
scalar value has to be set separately: `foo[1].bar[2] = value`.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_veristat.c  |  9 +--
 .../selftests/bpf/progs/set_global_vars.c     | 12 ++--
 tools/testing/selftests/bpf/veristat.c        | 63 +++++++++++++++++--
 3 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 47b56c258f3f..1af5d02bb2d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -60,12 +60,13 @@ static void test_set_global_vars_succeeds(void)
 	    " -G \"var_s8 = -128\" "\
 	    " -G \"var_u8 = 255\" "\
 	    " -G \"var_ea = EA2\" "\
-	    " -G \"var_eb = EB2\" "\
-	    " -G \"var_ec = EC2\" "\
+	    " -G \"var_eb  =  EB2\" "\
+	    " -G \"var_ec=EC2\" "\
 	    " -G \"var_b = 1\" "\
-	    " -G \"struct1.struct2.u.var_u8 = 170\" "\
+	    " -G \"struct1[2].struct2[1].u.var_u8[2]=170\" "\
 	    " -G \"union1.struct3.var_u8_l = 0xaa\" "\
 	    " -G \"union1.struct3.var_u8_h = 0xaa\" "\
+	    " -G \"arr[2] = 0xaa\" "	\
 	    "-vl2 > %s", fix->veristat, fix->tmpfile);
 
 	read(fix->fd, fix->output, fix->sz);
@@ -81,7 +82,7 @@ static void test_set_global_vars_succeeds(void)
 	__CHECK_STR("_w=12 ", "var_eb = EB2");
 	__CHECK_STR("_w=13 ", "var_ec = EC2");
 	__CHECK_STR("_w=1 ", "var_b = 1");
-	__CHECK_STR("_w=170 ", "struct1.struct2.u.var_u8 = 170");
+	__CHECK_STR("_w=170 ", "struct1.struct2[1].u.var_u8[2] = 170");
 	__CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
 
 out:
diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/testing/selftests/bpf/progs/set_global_vars.c
index 90f5656c3991..db11e26d7a42 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -23,6 +23,7 @@ const volatile enum Enum var_ea = EA1;
 const volatile enum Enumu64 var_eb = EB1;
 const volatile enum Enums64 var_ec = EC1;
 const volatile bool var_b = false;
+const volatile __s32 arr[5];
 
 struct Struct {
 	int:16;
@@ -35,16 +36,16 @@ struct Struct {
 		volatile struct {
 			const int:1;
 			union {
-				const volatile __u8 var_u8;
+				const volatile __u8 var_u8[3];
 				const volatile __s16 filler3;
 				const int:1;
 			} u;
 		};
-	} struct2;
+	} struct2[2];
 };
 
 const volatile __u32 stru = 0; /* same prefix as below */
-const volatile struct Struct struct1 = {.struct2 = {.u = {.var_u8 = 1}}};
+const volatile struct Struct struct1[3] = {{.struct2 = {{}, {.u = {.var_u8 = {1}}}}}};
 
 union Union {
 	__u16 var_u16;
@@ -62,8 +63,6 @@ union Union {
 
 const volatile union Union union1 = {.var_u16 = -1};
 
-char arr[4] = {0};
-
 SEC("socket")
 int test_set_globals(void *ctx)
 {
@@ -81,8 +80,9 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
-	a = struct1.struct2.u.var_u8;
+	a = struct1[2].struct2[1].u.var_u8[2];
 	a = union1.var_u16;
+	a = arr[3];
 
 	return a;
 }
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..79c5ea6476ca 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1379,7 +1379,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	memset(cur, 0, sizeof(*cur));
 	(*cnt)++;
 
-	if (sscanf(expr, "%s = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
+	if (sscanf(expr, "%[][a-zA-Z0-9_.] = %s %n", var, val, &n) != 2 || n != strlen(expr)) {
 		fprintf(stderr, "Failed to parse expression '%s'\n", expr);
 		return -EINVAL;
 	}
@@ -1486,6 +1486,39 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
+static int adjust_array_secinfo(const struct btf *btf, const struct btf_type *t,
+				struct btf_var_secinfo *sinfo, const char *var)
+{
+	struct btf_array *barr;
+	const struct btf_type *type;
+	char arr[64], idx[64];
+	int i = 0, tid;
+
+	if (!btf_is_array(t))
+		return 0;
+
+	barr = btf_array(t);
+	tid = btf__resolve_type(btf, barr->type);
+	type = btf__type_by_id(btf, tid);
+
+	/* var may contain chained expression e.g.: foo[1].bar */
+	if (sscanf(var, "%[a-zA-Z0-9_][%[a-zA-Z0-9]]", arr, idx) != 2) {
+		fprintf(stderr, "Could not parse array expression %s\n", var);
+		return -EINVAL;
+	}
+	errno = 0;
+	i = strtol(idx, NULL, 0);
+	if (errno || i < 0 || i >= barr->nelems) {
+		fprintf(stderr, "Preset index %s is invalid or out of bounds [0, %d]\n",
+			idx, barr->nelems);
+		return -EINVAL;
+	}
+	sinfo->size = type->size;
+	sinfo->type = tid;
+	sinfo->offset += i * type->size;
+	return 0;
+}
+
 const int btf_find_member(const struct btf *btf,
 			  const struct btf_type *parent_type,
 			  __u32 parent_offset,
@@ -1493,7 +1526,7 @@ const int btf_find_member(const struct btf *btf,
 			  int *member_tid,
 			  __u32 *member_offset)
 {
-	int i;
+	int i, err;
 
 	if (!btf_is_composite(parent_type))
 		return -EINVAL;
@@ -1511,8 +1544,12 @@ const int btf_find_member(const struct btf *btf,
 		member_type = btf__type_by_id(btf, tid);
 		if (member->name_off) {
 			const char *name = btf__name_by_offset(btf, member->name_off);
+			int name_len = strlen(name);
 
-			if (strcmp(member_name, name) == 0) {
+			if (strcmp(member_name, name) == 0 ||
+			    (btf_is_array(member_type) &&
+			     strncmp(name, member_name, name_len) == 0 &&
+			     member_name[name_len] == '[')) {
 				if (btf_member_bitfield_size(parent_type, i) != 0) {
 					fprintf(stderr, "Bitfield presets are not supported %s\n",
 						name);
@@ -1520,6 +1557,16 @@ const int btf_find_member(const struct btf *btf,
 				}
 				*member_offset = parent_offset + member->offset;
 				*member_tid = tid;
+				if (btf_is_array(member_type)) {
+					struct btf_var_secinfo sinfo = {.offset = 0};
+
+					err = adjust_array_secinfo(btf, member_type,
+								   &sinfo, member_name);
+					if (err)
+						return err;
+					*member_tid = sinfo.type;
+					*member_offset += sinfo.offset * 8;
+				}
 				return 0;
 			}
 		} else if (btf_is_composite(member_type)) {
@@ -1548,6 +1595,13 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 	snprintf(expr, sizeof(expr), "%s", var);
 	strtok_r(expr, ".", &saveptr);
 
+	if (btf_is_array(base_type)) {
+		err = adjust_array_secinfo(btf, base_type, sinfo, var);
+		if (err)
+			return err;
+		base_type = btf__type_by_id(btf, sinfo->type);
+	}
+
 	while ((name = strtok_r(NULL, ".", &saveptr))) {
 		err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
 		if (err) {
@@ -1673,7 +1727,8 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 
 				if (strncmp(var_name, presets[k].name, var_len) != 0 ||
 				    (presets[k].name[var_len] != '\0' &&
-				     presets[k].name[var_len] != '.'))
+				     presets[k].name[var_len] != '.' &&
+				     presets[k].name[var_len] != '['))
 					continue;
 
 				if (presets[k].applied) {
-- 
2.49.0


