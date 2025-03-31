Return-Path: <bpf+bounces-55015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C3A76FF3
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66563188C53B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05321B9D1;
	Mon, 31 Mar 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/e6LlMH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F3211A0D
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455545; cv=none; b=rpkIbmVWsisAzhjVqTHdya9e1ot5hQtBP3TIJzdzqn2d8v80PqEubic521QlTAlj2cIrVa3x/qZDwzOG19EDkJzRzTHpFE8je3q2HZhB8C3C1iQox5SJI2uVr5LyN89QNWijn5c7xPUDkcUZoLJJMo/RQUwPGVScz23CUD+alss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455545; c=relaxed/simple;
	bh=TB35numRpboUGf95i/WRfeDEYrJ3JHuMyQawhhzer5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOCCiXCVlaMOatGOpyICiZWIxetqxh30mZ++i2CtV4l4Zdj3n5tzBzMxWCPqDo4Htcp32diS6t7b5yvSQ5tXl4xBK3qb7oJlz4HLrw54ZkmzQ31aehSggfvnP6b4TLulpuhPkdpirLUvNXkEcj1sBCYXMwcJ47cVhnEmBsp4m2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/e6LlMH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913b539aabso2849730f8f.2
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743455542; x=1744060342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75+1bIjcq7hjKlwy6DU8dwZAptfb1u6fCGcmj7gWmdY=;
        b=Z/e6LlMHWyx5UMJux/Naz23p1JDhcb2/bVtVPjlX0FT+lNBZY6VeVjTrEJJHcl5RHE
         +a73kED5d/5KxTAIV7ONr6ZwrtV9rlkIZB1RJvB16MGYTjQFHR9n9p5SG17pV5CzpfeY
         XnyeOcq4B0eSo8u/UyQ/H7y4dugxr9b6uYPK1N/UqmCHgsRDX6cejRt/bIJqQJ7kZoQl
         hioo+rqGNHc8Y4k9XXEskAoahnwK6rpnjwdovCurj0o2MxXi6+P7mnvmMIp5EbJh+WjN
         KoQkXNagjm1q7DUShcPTGZ3tJ1rvKY1/SYN+fLwiZqmtGmY+i/y/biWQe61bZIZabaJX
         YQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743455542; x=1744060342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75+1bIjcq7hjKlwy6DU8dwZAptfb1u6fCGcmj7gWmdY=;
        b=J/GNQ+aIsdv1N/WJCZxdOc+6F8cz4gi8NGN4Drb32bxy0VZdyBu0nLYsqQ8OIPf2gM
         LPziRSFo+SGDywrAv58lOSusw8xNzpWl9aqjNb1wG2LxvKBEr3nIwGi/p4AWgIvPYQUA
         A8K7CQxmvjksZfRyGG+xucKT/l0nuwaHvP61AL3eF6mfud3d46N8z0u8ahXRivo2jtXT
         DCSuz1Jv9GHUHFeU2ysimHOE3mD2SMcZfCA46RUxnfvGKfT43btzBRFKLpsZ5M9Odb7i
         2ebnVFE/HIG7+JL9RZPDeDgUT6WjnBTos5POcT9xN4xKjLaJHT/9lz9svwVweU3rpFWl
         6Y7Q==
X-Gm-Message-State: AOJu0YyeOj1wSWO8Q5b3WWB/q+x2KRjc0NhVuYknnmqBJa4nGOoUfNpS
	gjpTFBet6SGnFfHBWT1cwZR5Q8hYSFDxMKtZ4U4tss5l9JH5jSP1rOx9pA==
X-Gm-Gg: ASbGncv5P7Ofu3HhBpLbaA4NNXu04Q5DnVM2YPmPvGLSo4SGVqjo7V6xx9eAp5uEQdY
	fheFVKjyRhbPOu4nJajpywJZeyZkL18DRj0tjn3SEco+p5qH1jVhJ7auZGt0GYnCCuZsIDsNzLK
	c6+LayxL92z2OWK99lB/wIj/kj7b19LxNT8CfKC1/Fvo0HwhClDF+kM5/lVGLt02RqUEboUWyWm
	C8ND/qnCWQjFHIKpmmIcUVdeRzaVu6QRQglutsJ743OCZOwGNarQ2KwamakZVwcdyfKI81g9RlG
	4rAlwS41WNATfqWxgV6kvxMobvKz7fQ9Y1gL1hJ2V10Ip3nIdOgNeGI4N/JmESU=
X-Google-Smtp-Source: AGHT+IGuUHxjYpFioHHmn6Wt6t//LxDbeRQ0HL+FDR4vqrFqMhQxXlsZyu+fsBft/5mXhmcbLVmvgA==
X-Received: by 2002:a05:6000:420d:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-39c120c7d4cmr7974178f8f.1.1743455541405;
        Mon, 31 Mar 2025 14:12:21 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a41c0sm12049617f8f.88.2025.03.31.14.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:12:20 -0700 (PDT)
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
Date: Mon, 31 Mar 2025 22:12:17 +0100
Message-ID: <20250331211217.201198-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/progs/set_global_vars.c     |  40 +++++++
 tools/testing/selftests/bpf/veristat.c        | 106 ++++++++++++++++--
 4 files changed, 144 insertions(+), 8 deletions(-)

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
index 9adb5ba4cd4d..187e9791e72e 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -24,6 +24,43 @@ const volatile enum Enumu64 var_eb = EB1;
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
+			const __u32 filler2;
+			union {
+				const volatile __u8 var_u8;
+				const volatile __s16 filler3;
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
@@ -43,5 +80,8 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
+	a = struct1.struct2.u.var_u8;
+	a = union1.var_u16;
+
 	return a;
 }
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a18972ffdeb6..727ef80a1e47 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1486,7 +1486,89 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
-static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+struct btf_anon_stack {
+	const struct btf_type *type;
+	__u32 offset;
+};
+
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
+	strncpy(expr, var, 255);
+	expr[255] = '\0';
+	strtok_r(expr, ".", &saveptr);
+
+	while ((name = strtok_r(NULL, ".", &saveptr))) {
+		err = btf_find_member(btf, base_type, 0, name, &member_tid, &member_offset);
+		if (err) {
+			fprintf(stderr, "Could not find member %s for variable %s\n", name, var);
+			return err;
+		}
+		if (btf_kflag(base_type)) {
+			fprintf(stderr, "Bitfield presets are not supported %s\n", name);
+			return -EINVAL;
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
@@ -1495,9 +1577,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
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
@@ -1530,7 +1612,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
 		if (value >= max_val || value < -max_val) {
 			fprintf(stderr,
 				"Variable %s value %lld is out of range [%lld; %lld]\n",
-				btf__name_by_offset(btf, t->name_off), value,
+				btf__name_by_offset(btf, base_type->name_off), value,
 				is_signed ? -max_val : 0, max_val - 1);
 			return -EINVAL;
 		}
@@ -1583,14 +1665,20 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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
@@ -1598,13 +1686,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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
2.49.0


