Return-Path: <bpf+bounces-54503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67DCA6B137
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A6486D99
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308E227E9F;
	Thu, 20 Mar 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI72fD28"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3021B9D5
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510756; cv=none; b=A6cZGZx16RrmS+tAo0mzHLg+lc5p/lAAix3H3G8Sm0MyYGkfwdxyR1FuLRf/8a+qaLoyAjU8wnMeX/dzmzfyiTbhaFPhO610hiVEpHlg6HEuxG6kQ7Q4Yvxm8JJ86ZfM7Hw5fwFmvL/i7ERlK596/AFkXF5/Gd9vchtv7sDbaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510756; c=relaxed/simple;
	bh=N2OgH31n8KquC3gNjsyj3jEQpujMCMTyouZGxSIJzwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN56wiNHylxXaNusHm9e6j4Xof1oEgmv9f70ja8uIuDBS6wkMuM+k4+m7zfzyUI/IxMwa2m2XLp5AI3dKOmaKwWBlEhNFAh/lWDvXeL4L/u+HlCk4XquNb+rDsndApEe4FzsbOOVbHNIiYhL3SwtU4aU7wf00s5YtNX/QDiQVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI72fD28; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so263357966b.3
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742510752; x=1743115552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EXd+PSSYylqdas8tMRweqlWX+HGoyj1plTcjFfpzEo=;
        b=AI72fD28qf0IZQ2D5jUoAvdVQ5CVLNEaKcY2WQk5qsxBpQ5jfSazdwdOEqi/VZdM8R
         Hg7EqlhP56feA6t1mPcJozjuUbha6Xx2eA1RvfD5jDEz4o0DM6MoFTadIcW55P68slKL
         3YJQsQTcVfjvlLcVIaQffDHdB9ykwJTHMPT3MlGLtsJaOu/AWaB+zgOoekk6ahguHGbx
         ka9RNj+mRaMWEu4gbMv+j/V16wjCWloTlqO0i2X/qTmsSbWcTObBuoc1hlmJ7Q9m2KCK
         UzKSnDDRm/59MJQMrnnVKk28cd7AyFcjehZow9KU9cQC0n4GFffs9ZVhqWLTNL1Sbk80
         upkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510752; x=1743115552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EXd+PSSYylqdas8tMRweqlWX+HGoyj1plTcjFfpzEo=;
        b=OFBw8Zab5AoxhEXtYoFNDcN2kt/6MbhMF8esvO53cBgvSmSmcdY90iW0jRpalFVRQe
         5MIgZKAvtwJxH1xrMET4eLCz6rnb1m3fXhB099QSOuVXQATbN1KqDaZI7FeClyIBFr+C
         w0izjQsM/8u16ILlD88KF8kh/kshZ/HkUtyANJl1xJaaUFWJ3/0uLnDuN/LlgRFlX65S
         T2EnqumS9NZAD/RVZ+Bp+efko1m0gDg3tJzAXeSi/mPf0t7oSwnF45f/7v4ap6HSBPQn
         Zz5wbfgC6NsRpmQNZ6OVGzy5lF4tTdVupjUJvam+W4lXut4nvPgpb4ivD4No+sCfg4YJ
         vXwA==
X-Gm-Message-State: AOJu0YxGCEy9Rxs1d7Ael8WHT+5Q+UIEKoiZDTrsVmaUja9RKr4CQCnY
	P8KQO5cbqockabTAMkC5zX4zFol05YvdtZGRtLkgkgMSUQIZuNZK5uOyJQ==
X-Gm-Gg: ASbGnctmH8zP9vejf6QmHWL1PxB90eDkHtZKXozmXCUnKXPBUgW3fKp6XtqPVQDAJBy
	CSIxZO9jqMEpCxqSk0LATK0ZQIG6tWuJiNTEDj/wVm4uAU375hYpZwuElOdr9a0DNCVKDS8BgwV
	OHSc9BVn836Dh95HV197z9yTs0zCWtx0CDxNjFxJAwF3y5MLkAPWl64ak89iP9KzdpnQ+mamsnI
	q27kmW4UzdOQv9+1Qe1rNph9eJ4PZ1rYzJl8aJDc/W4/5FmRTQJcMZ63KgP4mck4REE7A+bnpAv
	CGN6iLMfYZfIsrc6Uf+LnKBTq4FjTkiZx0WiXoUb89pRZgEbLnczf9YJHy0=
X-Google-Smtp-Source: AGHT+IEhWzb4lXDn31NgiKcQ+uiB92tVWozBXOSFfFHkUeMHXgj6u2oodrr+QT/VT01Q5C/l0ZwrZw==
X-Received: by 2002:a17:907:96aa:b0:abf:614a:3e48 with SMTP id a640c23a62f3a-ac3f252656amr86178766b.50.1742510751893;
        Thu, 20 Mar 2025 15:45:51 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbde4bfsm41497366b.143.2025.03.20.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:45:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: support struct/union presets in veristat
Date: Thu, 20 Mar 2025 22:45:46 +0000
Message-ID: <20250320224546.241673-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/progs/set_global_vars.c     |  38 +++++
 tools/testing/selftests/bpf/veristat.c        | 148 +++++++++++++++++-
 4 files changed, 184 insertions(+), 8 deletions(-)

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
index 9adb5ba4cd4d..f2b354decbb8 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -24,6 +24,41 @@ const volatile enum Enumu64 var_eb = EB1;
 const volatile enum Enums64 var_ec = EC1;
 const volatile bool var_b = false;
 
+struct Struct {
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
@@ -43,5 +78,8 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
+	a = struct1.struct2.u.var_u8;
+	a = union1.var_u16;
+
 	return a;
 }
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index a18972ffdeb6..babc97b799a2 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -23,6 +23,7 @@
 #include <float.h>
 #include <math.h>
 #include <limits.h>
+#include <linux/err.h>
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
@@ -1486,7 +1487,131 @@ static bool is_preset_supported(const struct btf_type *t)
 	return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
 }
 
-static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct btf_type *t,
+struct btf_anon_stack {
+	const struct btf_type *t;
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
+	anon_stack[top].t = parent_type;
+	anon_stack[top++].offset = 0;
+
+	do {
+		parent_type = anon_stack[--top].t;
+		cur_offset = anon_stack[top].offset;
+
+		for (i = 0; i < btf_vlen(parent_type); ++i) {
+			const struct btf_member *member;
+			const struct btf_type *t;
+			int tid;
+
+			member = btf_members(parent_type) + i;
+			tid =  btf__resolve_type(btf, member->type);
+			if (tid < 0) {
+				retval = ERR_PTR(-EINVAL);
+				goto out;
+			}
+			t = btf__type_by_id(btf, tid);
+			if (member->name_off) {
+				name = btf__name_by_offset(btf, member->name_off);
+				if (name && strcmp(member_name, name) == 0) {
+					if (anon_offset)
+						*anon_offset = cur_offset;
+					retval = member;
+					goto out;
+				}
+			} else if (t) {
+				struct btf_anon_stack *tmp;
+
+				tmp = realloc(anon_stack, (top + 1) * sizeof(*anon_stack));
+				if (!tmp) {
+					retval = ERR_PTR(-ENOMEM);
+					goto out;
+				}
+				anon_stack = tmp;
+				/* Anonymous union/struct: push to stack */
+				anon_stack[top].t = t;
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
+	if (!btf_is_union(t) && !btf_is_struct(t))
+		return -EINVAL;
+
+	member = btf_find_member(btf, t, name, &anon_offset);
+	if (IS_ERR(member))
+		return -EINVAL;
+
+	member_tid = btf__resolve_type(btf, member->type);
+	member_type = btf__type_by_id(btf, member_tid);
+
+	if (btf_kflag(t)) {
+		sinfo->offset += (BTF_MEMBER_BIT_OFFSET(member->offset) + anon_offset) / 8;
+		sinfo->size = BTF_MEMBER_BITFIELD_SIZE(member->offset) / 8;
+	} else {
+		sinfo->offset += (member->offset + anon_offset) / 8;
+		sinfo->size = member_type->size;
+	}
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
+	if (!btf_is_union(base_type) && !btf_is_struct(base_type))
+		return 0;
+
+	strcpy(expr, var);
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
@@ -1495,9 +1620,9 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
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
@@ -1530,7 +1655,7 @@ static int set_global_var(struct bpf_object *obj, struct btf *btf, const struct
 		if (value >= max_val || value < -max_val) {
 			fprintf(stderr,
 				"Variable %s value %lld is out of range [%lld; %lld]\n",
-				btf__name_by_offset(btf, t->name_off), value,
+				btf__name_by_offset(btf, base_type->name_off), value,
 				is_signed ? -max_val : 0, max_val - 1);
 			return -EINVAL;
 		}
@@ -1590,7 +1715,12 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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
@@ -1598,13 +1728,17 @@ static int set_global_vars(struct bpf_object *obj, struct var_preset *presets, i
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


