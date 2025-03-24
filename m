Return-Path: <bpf+bounces-54612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19DA6DA2A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A43816EF11
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB925E82C;
	Mon, 24 Mar 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7H6hDN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A725DD13
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819702; cv=none; b=QB3RDljeILv+qWu5NgeuuRgNWN5Qw/csVXZv5DxDR65DT5GMR8nQRD5qszGK6mY4i/DwNFvNIZ5POFaUPWtB/zhu8bIo+OQjBcs9/0LwQxY8qfBIJY7aVt/SL5FKGqEsQYYvlF7B80yFHutkIpDO8bBn28M9qLf9eQKlaxm1Whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819702; c=relaxed/simple;
	bh=AOgjhG4mN/wlN9ZlXtSJyssgLEPVGhyKCJtn8cS3NAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/Q+UMrpmJ5Bf7l9YgUjp+Fi8nvN5guuFDwRR0IuGZUQuoeZCBojTZq63iV7IvNVRKQR5AM4ute0O3y9OTF6K25lsJwBKfXXAKNjwo3A2A+wGFQhFBdqWesKhHTeGwXgtAB/AP14+9GCldXtCqss4Rttzw5el3TchAcYErdf424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7H6hDN3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso22758475e9.0
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742819699; x=1743424499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZenLTV2SR2pg4UJa0OQeDpuMKgi//Qzs7ht2ZYO4IpM=;
        b=f7H6hDN392HQo6g6HI8y4pDPc0RGYkmaUpXC2A5SyYhXbXGcm6fxHWg7VoH9uj64pL
         X1KcXBUGT6Tp6UJmogItedH/vNqWSZBMX2Fy7TpafcqPmj9mA/fdPHJv7sdN9k9hgLiy
         TmMu25A9gfLZoKY/KRQepwMI73gAcFDp3vIu0+goB84K/BVLyxBopGPPIhw59htyl2eZ
         hF87NEcUMeCM2gIx6t/TQyu5RwAeAq6iF8f5mUaoK6DjjIkfFee2kwyg1paUMw30SkIK
         0ajU05PThePBpjUDhVUZBvaUi2fPtGdlsqAEWXwKeQQgHBDcrDQGYvFdzsRzdp3YfIYU
         KaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819699; x=1743424499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZenLTV2SR2pg4UJa0OQeDpuMKgi//Qzs7ht2ZYO4IpM=;
        b=l769SQNM4RKQXRJWesiYQ1nw65rQQtoWZfxPo/4YZNSubPe54siYa9iZUKISzAMl7a
         qNMzZIQTJytgWX9APAeHaA8WsJvRxVPRV6XGMU/zecClKcWPC2HQ+0BpdZ/QHkB8Gefd
         l9oRs7ypJqP3vKqf6kQ9XF+S5VCfE+mb392Qed+IHFQhJKb87Cu8IERJ7wNUAQcis9r0
         t7n4QEXvNvkKyEjH9y7L7KufOCby8NCSpyBQjO7tRqdAHnp3hYYJc5j8q5R3EQIHo1mA
         GRkKXFULtzNDpFe6O4zrYCuikhdHN9HvyFpL8tu24hY09MsemGQYk7PiXKGBViQt5JJk
         D9lQ==
X-Gm-Message-State: AOJu0YxvpLQDvBF+6r08z6fpWCFVA4voJ56MeX+s1bexTB46Kq8BUCDv
	rrsPZiW2h/pnYfafD7lNA99sBc6gnRLwH1UwJnKzc7ZpYSviM9SYv/uPHw==
X-Gm-Gg: ASbGncvIMrPCIHmuuHft5/ffyuJHz3F/tysRGbFp3uB8nJjEXUbnNAFrRf3Ewn5ENnK
	ZiHoNCkU/i+OHlioEj84j9NZEv62R5Oqg8Vsoiw3GEsXnAgCdLfX0ZiLGf63nYymt7GMEAv06Hc
	weNNyDkbIe1LRBUkqiAKLgGvAbUQi1zki7Ha5vJQxPvyud29YbPTCSt+k6Mw5BgiGRaT1CdmeWV
	AOq9OUZ1VPEEOxguMkxLldixLUgEgBOA/b7KeteKMdpqY1uAr1RGwr1SdVoa2yGOXPxquuc/QU5
	cdqE5ODLY6eVezDDfIJigu7+cVEvhM3v6SAZzI1CMzJMntYWzsxQzpHqAUvcYjfPSA6cb5v93A=
	=
X-Google-Smtp-Source: AGHT+IEmnlKfyoOavLUFTcjKKkoReQKD0nvuUzaSyCJK3SL7obNoG5cCgGlHymD2NZMQw6GOPJ+iEg==
X-Received: by 2002:a05:600c:c0b:b0:43d:ed:ad07 with SMTP id 5b1f17b1804b1-43d50a3c7aamr129822835e9.29.1742819698681;
        Mon, 24 Mar 2025 05:34:58 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55c99sm170943615e9.24.2025.03.24.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:34:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] selftests/bpf: support struct/union presets in veristat
Date: Mon, 24 Mar 2025 12:34:55 +0000
Message-ID: <20250324123455.35888-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend commit e3c9abd0d14b ("selftests/bpf: Implement setting global
variables in veristat") to support applying presets to members of
the global structs or unions in veristat.
For example:
```
./veristat set_global_vars.bpf.o  -G "union1.struct3.var_u8_h = 0xBB"
```

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_veristat.c  |   5 +
 tools/testing/selftests/bpf/progs/prepare.c   |   1 -
 .../selftests/bpf/progs/set_global_vars.c     |  39 +++++
 tools/testing/selftests/bpf/veristat.c        | 141 +++++++++++++++++-
 4 files changed, 178 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index a95b42bf744a..47b56c258f3f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -63,6 +63,9 @@ static void test_set_global_vars_succeeds(void)
 	    " -G \"var_eb = EB2\" "\
 	    " -G \"var_ec = EC2\" "\
 	    " -G \"var_b = 1\" "\
+	    " -G \"struct1.struct2.u.var_u8 = 170\" "\
+	    " -G \"union1.struct3.var_u8_l = 0xaa\" "\
+	    " -G \"union1.struct3.var_u8_h = 0xaa\" "\
 	    "-vl2 > %s", fix->veristat, fix->tmpfile);
 
 	read(fix->fd, fix->output, fix->sz);
@@ -78,6 +81,8 @@ static void test_set_global_vars_succeeds(void)
 	__CHECK_STR("_w=12 ", "var_eb = EB2");
 	__CHECK_STR("_w=13 ", "var_ec = EC2");
 	__CHECK_STR("_w=1 ", "var_b = 1");
+	__CHECK_STR("_w=170 ", "struct1.struct2.u.var_u8 = 170");
+	__CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
 
 out:
 	teardown_fixture(fix);
diff --git a/tools/testing/selftests/bpf/progs/prepare.c b/tools/testing/selftests/bpf/progs/prepare.c
index 1f1dd547e4ee..cfc1f48e0d28 100644
--- a/tools/testing/selftests/bpf/progs/prepare.c
+++ b/tools/testing/selftests/bpf/progs/prepare.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2025 Meta */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-//#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/testing/selftests/bpf/progs/set_global_vars.c
index 9adb5ba4cd4d..0259d290d5f2 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -24,6 +24,42 @@ const volatile enum Enumu64 var_eb = EB1;
 const volatile enum Enums64 var_ec = EC1;
 const volatile bool var_b = false;
 
+struct Struct {
+	int:16;
+	__u16 filler;
+	struct {
+		__u16 filler2;
+	};
+	struct Struct2 {
+		__u16 filler;
+		volatile struct {
+			__u32 filler2;
+			union {
+				const volatile __u8 var_u8;
+				const volatile __s16 filler3;
+			} u;
+		};
+	} struct2;
+};
+const volatile __u32 struc = 0; /* same prefix as below */
+const volatile struct Struct struct1 = {.struct2 = {.u = {.var_u8 = 1}}};
+
+union Union {
+	__u16 var_u16;
+	struct Struct3 {
+		struct {
+			__u8 var_u8_l;
+		};
+		struct {
+			struct {
+				__u8 var_u8_h;
+			};
+		};
+	} struct3;
+};
+
+const volatile union Union union1 = {.var_u16 = -1};
+
 char arr[4] = {0};
 
 SEC("socket")
@@ -43,5 +79,8 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
+	a = struct1.struct2.u.var_u8;
+	a = union1.var_u16;
+
 	return a;
 }
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a18972ffdeb6..4fb52767ea73 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -23,6 +23,7 @@
 #include <float.h>
 #include <math.h>
 #include <limits.h>
+#include <linux/err.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -1486,7 +1487,124 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
-static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+struct btf_anon_stack {
+	const struct btf_type *type;
+	__u32 offset;
+};
+
+const struct btf_member *btf_find_member(const struct btf *btf,
+					 const struct btf_type *parent_type,
+					 const char *member_name,
+					 __u32 *anon_offset)
+{
+	struct btf_anon_stack *anon_stack;
+	const struct btf_member *retval = NULL;
+	__u32 cur_offset = 0;
+	const char *name;
+	int top = 0, i;
+
+	if (!btf_is_struct(parent_type) && !btf_is_union(parent_type))
+		return ERR_PTR(-EINVAL);
+
+	anon_stack = malloc(sizeof(*anon_stack));
+	if (!anon_stack)
+		return ERR_PTR(-ENOMEM);
+
+	anon_stack[top].type = parent_type;
+	anon_stack[top++].offset = 0;
+
+	do {
+		parent_type = anon_stack[--top].type;
+		cur_offset = anon_stack[top].offset;
+
+		for (i = 0; i < btf_vlen(parent_type); ++i) {
+			const struct btf_member *member;
+			const struct btf_type *member_type;
+			int member_tid;
+
+			member = btf_members(parent_type) + i;
+			member_tid =  btf__resolve_type(btf, member->type);
+			if (member_tid < 0) {
+				retval = ERR_PTR(-EINVAL);
+				goto out;
+			}
+			member_type = btf__type_by_id(btf, member_tid);
+			if (member->name_off) {
+				name = btf__name_by_offset(btf, member->name_off);
+				if (name && strcmp(member_name, name) == 0) {
+					*anon_offset = cur_offset;
+					retval = member;
+					goto out;
+				}
+			} else if (btf_is_struct(member_type) || btf_is_union(member_type)) {
+				struct btf_anon_stack *tmp;
+				/* Anonymous union/struct: push to stack */
+				tmp = realloc(anon_stack, (top + 1) * sizeof(*anon_stack));
+				if (!tmp) {
+					retval = ERR_PTR(-ENOMEM);
+					goto out;
+				}
+				anon_stack = tmp;
+				anon_stack[top].type = member_type;
+				anon_stack[top++].offset = cur_offset + member->offset;
+			}
+		}
+	} while (top > 0);
+out:
+	free(anon_stack);
+	return retval;
+}
+
+static int adjust_var_secinfo_tok(char **name_tok, const struct btf *btf,
+				  const struct btf_type *t, struct btf_var_secinfo *sinfo)
+{
+	char *name = strtok_r(NULL, ".", name_tok);
+	const struct btf_type *member_type;
+	const struct btf_member *member;
+	int member_tid;
+	__u32 anon_offset = 0;
+
+	if (!name)
+		return 0;
+
+	member = btf_find_member(btf, t, name, &anon_offset);
+	if (IS_ERR(member)) {
+		fprintf(stderr, "Could not find member %s\n", name);
+		return -EINVAL;
+	}
+
+	member_tid = btf__resolve_type(btf, member->type);
+	member_type = btf__type_by_id(btf, member_tid);
+
+	if (btf_kflag(t)) {
+		fprintf(stderr, "Bitfield presets are not supported %s\n", name);
+		return -EINVAL;
+	}
+	sinfo->offset += (member->offset + anon_offset) / 8;
+	sinfo->size = member_type->size;
+	sinfo->type = member_tid;
+
+	return adjust_var_secinfo_tok(name_tok, btf, member_type, sinfo);
+}
+
+static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
+			      struct btf_var_secinfo *sinfo, const char *var)
+{
+	char expr[256], *saveptr;
+	const struct btf_type *base_type;
+	int err;
+
+	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	strncpy(expr, var, 256);
+	strtok_r(expr, ".", &saveptr);
+	err = adjust_var_secinfo_tok(&saveptr, btf, base_type, sinfo);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int set_global_var(struct bpf_object *obj, struct btf *btf,
 			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
 			  struct var_preset *preset)
 {
@@ -1495,9 +1613,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
 	long long value = preset->ivalue;
 	size_t size;
 
-	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	base_type = btf__type_by_id(btf, btf__resolve_type(btf, sinfo->type));
 	if (!base_type) {
-		fprintf(stderr, "Failed to resolve type %d\n", t->type);
+		fprintf(stderr, "Failed to resolve type %d\n", sinfo->type);
 		return -EINVAL;
 	}
 	if (!is_preset_supported(base_type)) {
@@ -1530,7 +1648,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
 		if (value >= max_val || value < -max_val) {
 			fprintf(stderr,
 				"Variable %s value %lld is out of range [%lld; %lld]\n",
-				btf__name_by_offset(btf, t->name_off), value,
+				btf__name_by_offset(btf, base_type->name_off), value,
 				is_signed ? -max_val : 0, max_val - 1);
 			return -EINVAL;
 		}
@@ -1590,7 +1708,12 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 			var_name = btf__name_by_offset(btf, var_type->name_off);
 
 			for (k = 0; k < npresets; ++k) {
-				if (strcmp(var_name, presets[k].name) != 0)
+				struct btf_var_secinfo tmp_sinfo;
+				int var_len = strlen(var_name);
+
+				if (strncmp(var_name, presets[k].name, var_len) != 0 ||
+				    (presets[k].name[var_len] != '\0' &&
+				     presets[k].name[var_len] != '.'))
 					continue;
 
 				if (presets[k].applied) {
@@ -1598,13 +1721,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 						var_name);
 					return -EINVAL;
 				}
+				memcpy(&tmp_sinfo, sinfo, sizeof(*sinfo));
+				err = adjust_var_secinfo(btf, var_type,
+							 &tmp_sinfo, presets[k].name);
+				if (err)
+					return err;
 
-				err = set_global_var(obj, btf, var_type, map, sinfo, presets + k);
+				err = set_global_var(obj, btf, map, &tmp_sinfo, presets + k);
 				if (err)
 					return err;
 
 				presets[k].applied = true;
-				break;
 			}
 		}
 	}
-- 
2.48.1


