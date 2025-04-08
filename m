Return-Path: <bpf+bounces-55449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33CEA7FCCB
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DD7A58D0
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD86926980C;
	Tue,  8 Apr 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEG9SLzH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADC267B83
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109157; cv=none; b=uchVTVHO5GajXYDxKH785MYsB6O7VvsZDaguHtGjaS2Vig//rqSSPjjq8NyNp1x5FtgFINUWc9wxRNk+PsQHPfdrGznjkjSBuFXGjbOCkJNiAjJ94Mn4dGoZBRNSCLOZmCJElns8pHeuenaPiajGJbexbOXMYayS69hjE7lJAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109157; c=relaxed/simple;
	bh=hwm0KP6hEthrtCymxw9aqI8a8Kv5u9YN5FfsN066qe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3l+rWF26KGPOuLB7xXo6tQ1+gZqtEn3MViEpJi8jxPXanCfxmNpXS207cmSInGhaWFrb1R2I3w4r14IaiUNiUXq8HoYBPLsgwhOokJHpjKOCiZ3ZpROmDxWRf/9ix2d7XWS8haCbM6S8TuaWsRP19400Puk+oxEfesmM0IwIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEG9SLzH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so42341805e9.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744109153; x=1744713953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXQENBli5qmynkVKhJMEjYhElHi9duRhq6O7c1KOzZA=;
        b=LEG9SLzHVTlJbhrY45W85/GFfUS6PxW/htCUmhBYuwoJ6XbOSZpjCXuZUUUlPT7AAr
         BdLsNzBsG7exWHomkIbpP7lqlStb4k+MMZJo+SdeeVyC+iO1I3Rdet/t1MpVI17gBQBA
         yGD2sYT+p+EcUufAFDlPmeDqcezo5JHLMRC+/yk/IAno0JOogmQ9abp365NRBz6vQUTx
         qnQfvunFxdtXkqpw+iQ05qa1m5+MyWgNUfl1Pn0lWs2TwPOEUlqfBqofvO6Nu927EwD3
         IPsSgcxd4ylJg8BK8ZkhdkPXDtTETuUvItb2IdNV+onm3hkLtWTFU89d2zhfoc6sFG83
         4vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109153; x=1744713953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXQENBli5qmynkVKhJMEjYhElHi9duRhq6O7c1KOzZA=;
        b=bFXbpixmuPaa0vSb9v7cDvHSwNvwsjMED9ju+e1eHTy1026cQxwOhjCLf6EysBl1fe
         h9Sf3v+STHul7iavxP6pybSqCNVmpDnHOSh2+vM6DhjSbR2BDtCZCz8RC++WzbEAQswM
         B6E4IZsMZ0akPzDzdCnZjVqRoyN4RgtYAhdqT0jqBwhlOZmleJ6Vv9tAUyutriKME7Ay
         G3y/Ts0Qjv9FHKZYeq3mqMpbUHHAzl4zEDVQvdBAgFty/wmU35oBbLP1SRlEGksL4v6+
         SlnYfVElzxKIWgpBlDKIPkOlUg8NLItG2t67P9YN7pn+femKg7kmOy1CdsVnRwctnEVw
         v+8w==
X-Gm-Message-State: AOJu0YzHnF+0GXbSCKBwNjrvAbKhFAZU9a/ql+St0N6t0UZjUuIZctQt
	l1l20T5wEiq8Q0657/4Kog9JcZl0iyFNi9gZEeM/H46Gek21vM5eeDPqLw==
X-Gm-Gg: ASbGncsjPUxcLC2siUbjd/CfjnGsZ9jAhY+j0avSlrcLc18l0jY1ypiqUTGiwOtHFs4
	LPf57ZnINfpqTGmtDEXXEuavI86ozIUvVHSmtpYjyPHkQkMYZpgxrMmzXtRQ/UvyloYJV3+iLw+
	dRnY7g7Xz1g+VPL8CJ0hX1iAw+NWQimCfVPGml9PExhjmO1xTfQgNX3pgewEdtoZCTZ889kYhiL
	Ba3U5waWFSaE8OTEnI3FzfUyCtxjSthX/GHyd/S/j3zSfeHxhf7+2zJJ9Wf3qA/v/vs5ivWAjVO
	0EJSU/HDtWbqsOKkh4USDeRXsBW6dzfD+jbtse1/YXyzr4RJUtIEXY9Q2aqbnxw=
X-Google-Smtp-Source: AGHT+IEhAzbU2mLcsqcONnWQWUULym3AwYpBbF5wCjxvQJCnDnmZm6WSPOwla7oPakuJsNIYxdymoQ==
X-Received: by 2002:a05:600c:1e13:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-43ed0da49e6mr186099805e9.30.1744109153131;
        Tue, 08 Apr 2025 03:45:53 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364a0c7sm156378255e9.29.2025.04.08.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:45:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3] selftests/bpf: support struct/union presets in veristat
Date: Tue,  8 Apr 2025 11:45:44 +0100
Message-ID: <20250408104544.140317-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
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
 .../selftests/bpf/progs/set_global_vars.c     |  41 +++++++
 tools/testing/selftests/bpf/veristat.c        | 101 ++++++++++++++++--
 4 files changed, 140 insertions(+), 8 deletions(-)

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
index 9adb5ba4cd4d..90f5656c3991 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -24,6 +24,44 @@ const volatile enum Enumu64 var_eb = EB1;
 const volatile enum Enums64 var_ec = EC1;
 const volatile bool var_b = false;
 
+struct Struct {
+	int:16;
+	__u16 filler;
+	struct {
+		const __u16 filler2;
+	};
+	struct Struct2 {
+		__u16 filler;
+		volatile struct {
+			const int:1;
+			union {
+				const volatile __u8 var_u8;
+				const volatile __s16 filler3;
+				const int:1;
+			} u;
+		};
+	} struct2;
+};
+
+const volatile __u32 stru = 0; /* same prefix as below */
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
@@ -43,5 +81,8 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
+	a = struct1.struct2.u.var_u8;
+	a = union1.var_u16;
+
 	return a;
 }
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a18972ffdeb6..b2bb20b00952 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1486,7 +1486,84 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
-static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+const int btf_find_member(const struct btf *btf,
+			  const struct btf_type *parent_type,
+			  __u32 parent_offset,
+			  const char *member_name,
+			  int *member_tid,
+			  __u32 *member_offset)
+{
+	int i;
+
+	if (!btf_is_composite(parent_type))
+		return -EINVAL;
+
+	for (i = 0; i < btf_vlen(parent_type); ++i) {
+		const struct btf_member *member;
+		const struct btf_type *member_type;
+		int tid;
+
+		member = btf_members(parent_type) + i;
+		tid =  btf__resolve_type(btf, member->type);
+		if (tid < 0)
+			return -EINVAL;
+
+		member_type = btf__type_by_id(btf, tid);
+		if (member->name_off) {
+			const char *name = btf__name_by_offset(btf, member->name_off);
+
+			if (strcmp(member_name, name) == 0) {
+				if (btf_member_bitfield_size(parent_type, i) != 0) {
+					fprintf(stderr, "Bitfield presets are not supported %s\n",
+						name);
+					return -EINVAL;
+				}
+				*member_offset = parent_offset + member->offset;
+				*member_tid = tid;
+				return 0;
+			}
+		} else if (btf_is_composite(member_type)) {
+			int err;
+
+			err = btf_find_member(btf, member_type, parent_offset + member->offset,
+					      member_name, member_tid, member_offset);
+			if (!err)
+				return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
+			      struct btf_var_secinfo *sinfo, const char *var)
+{
+	char expr[256], *saveptr;
+	const struct btf_type *base_type, *member_type;
+	int err, member_tid;
+	char *name;
+	__u32 member_offset = 0;
+
+	base_type = btf__type_by_id(btf, btf__resolve_type(btf, t->type));
+	snprintf(expr, sizeof(expr), "%s", var);
+	strtok_r(expr, ".", &saveptr);
+
+	while ((name = strtok_r(NULL, ".", &saveptr))) {
+		err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
+		if (err) {
+			fprintf(stderr, "Could not find member %s for variable %s\n", name, var);
+			return err;
+		}
+		member_type = btf__type_by_id(btf, member_tid);
+		sinfo->offset += member_offset / 8;
+		sinfo->size = member_type->size;
+		sinfo->type = member_tid;
+		base_type = member_type;
+	}
+	return 0;
+}
+
+static int set_global_var(struct bpf_object *obj, struct btf *btf,
 			  struct bpf_map *map, struct btf_var_secinfo *sinfo,
 			  struct var_preset *preset)
 {
@@ -1495,9 +1572,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
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
@@ -1530,7 +1607,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
 		if (value >= max_val || value < -max_val) {
 			fprintf(stderr,
 				"Variable %s value %lld is out of range [%lld; %lld]\n",
-				btf__name_by_offset(btf, t->name_off), value,
+				btf__name_by_offset(btf, base_type->name_off), value,
 				is_signed ? -max_val : 0, max_val - 1);
 			return -EINVAL;
 		}
@@ -1583,14 +1660,20 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 		for (j = 0; j < n; ++j, ++sinfo) {
 			const struct btf_type *var_type = btf__type_by_id(btf, sinfo->type);
 			const char *var_name;
+			int var_len;
 
 			if (!btf_is_var(var_type))
 				continue;
 
 			var_name = btf__name_by_offset(btf, var_type->name_off);
+			var_len = strlen(var_name);
 
 			for (k = 0; k < npresets; ++k) {
-				if (strcmp(var_name, presets[k].name) != 0)
+				struct btf_var_secinfo tmp_sinfo;
+
+				if (strncmp(var_name, presets[k].name, var_len) != 0 ||
+				    (presets[k].name[var_len] != '\0' &&
+				     presets[k].name[var_len] != '.'))
 					continue;
 
 				if (presets[k].applied) {
@@ -1598,13 +1681,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
 						var_name);
 					return -EINVAL;
 				}
+				tmp_sinfo = *sinfo;
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
2.49.0


