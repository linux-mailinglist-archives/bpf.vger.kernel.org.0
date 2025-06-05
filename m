Return-Path: <bpf+bounces-59785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF45ACF74F
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F73117B397
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA727C16A;
	Thu,  5 Jun 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGW0qxvM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C927E7C0
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148617; cv=none; b=DL4AYdbBQWxab0xOyzb5JoDfpoiBscwFjeMwtmyujR7wC1SMFaQZjFeqvxll/uXPuqXjsKNX49A7hZ3Wcyv098slElBtysPv/yl7UCrn+l9tANA1zpFj7Lwi+LSmAn26xTtDuKP8iiLf6sV+4Z5IzEFSJ97Y9+KT/KfoGZAG+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148617; c=relaxed/simple;
	bh=RkvZunxF7Edxio+ho+lhiY9x2UGud1Gq1HlW3lVCBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcVPuomY21os8W6bjDweJBbNvJjXUvRlrw98tJ1ezJBJ24NauTQfiyrWAomw6N/+IjEiz7HZsENXlUCkj43VW0HsKkhZVdDUTn1yT6PicLfRj/9Ss9GakV7YsTkJKeFHsTyvIZY2ef4LsB1L0LZDHdHHSTaAc2ok3VIl4/VwQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGW0qxvM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d35dso2837906a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749148613; x=1749753413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4I0fWteE6rgz0RrqtrPJXroPeAGBVzASzfZptQU6G0=;
        b=MGW0qxvMk0pq5X9VbHNdf7NhpMVbHeIxxroJtV2z7BA8w/mS7RJ8HUlE2/ntngRlf+
         xXPscUFMDrhig1O4shzjytQLSFq6qshGemtjy2aR+9uWSZmJtSn0DCkzUK4omVovQX9b
         e/tmy3WuHfZ382fdXPyxYcjY3AM4UFeeVCqlmsGUE0JQagRpRjKVF9iYXWJ9AYJhkiHe
         zX+qqarqTF2n0tYuCdoYhIs8D6Z1beHyMYeU2gIVzSYwgIH9Hl7hFcTDKqe98XDCAfDj
         HarhDTZdqzsi28mVF+0rwPATplKxAD/qTVcvCJKEGpGVxw8qednueebZex1vl/PSfiQw
         COyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148613; x=1749753413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4I0fWteE6rgz0RrqtrPJXroPeAGBVzASzfZptQU6G0=;
        b=PGJ7RwoTG1s5EfjPO76a3bUdidDp6NZssZ3DbozyliQnNZt2Iu+tFuTFPVXiHgRVNe
         R9D8Wr9fEaze6VDMNbEM9cRTAG502VG0HV6iIo/6f/U+kDpptz4Nmo3ojMTkW71KXxgn
         8bUkgcBf1ye+H2CwpdjuXrVxiQCkfMcDniq6oPyRrmRTTN+/21WRfvg/drdux/4eAS/h
         nPzmhzByMqCc2CBqdoaqPEAGgRRPfkf//3VOs7o/dzlSfRuoCLSk7wkoo51AIQU6mVtt
         inS1optEWrnr8FBFM6b0/xeNqCl78SvnrlO7wHQWvlgka7txCQhsHMOVYvtJ/D6gEVxk
         S9YQ==
X-Gm-Message-State: AOJu0Ywwf2AObvp0Bc8pu4bEFkHUYj6pKqLXibWv2O1oPg+zvupgXOr9
	Qlrvy/blqpmPMow1qPWl5hOoVaLTpO0XtBIs5bZeRFHXoVXGU2eoNnc8gLAwGbeP0DU=
X-Gm-Gg: ASbGncsQ5bGIRmvM7ZTuVoh+bWBB/upd/XjDv03J/KMg8drpy5SS15Q1wag0w7Y1TC0
	SIwopsXVWALGedkyx4bCkKYka5pYjePy/s9f7SZynBI4PAl7BQtzxIgwulpKzkrhxjMvHm9GoZZ
	NTsczr5cmEWXPJfF+MyObCPAdfPTn4BW2fRBogm8p4eLK6R4riYdbwo5JtCxJ848WXer3d697ov
	ajL5DmtZxg1Wd9iR+nGwSUnyyDe6nNFDzTQQOsusfbRvRf2o2zUhBwrx1VdBrvXD01HYca2YolK
	E08FZa4+Yw+Nr1tY/YoWlnqO3otAxv8=
X-Google-Smtp-Source: AGHT+IFsV+DLnwEZL/e5+ipY/v1E6nGhAS8xhI3Po4N8Uynpsetm15bginvJKvie5Zgq6pIsbXp+Mg==
X-Received: by 2002:a05:6402:1941:b0:5f4:8c80:77d with SMTP id 4fb4d7f45d1cf-60772b61907mr288133a12.6.1749148613285;
        Thu, 05 Jun 2025 11:36:53 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:1013])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60600898ef9sm6594610a12.33.2025.06.05.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:36:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: test array presets in veristat
Date: Thu,  5 Jun 2025 19:36:42 +0100
Message-ID: <20250605183642.1323795-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com>
References: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Modify existing veristat tests to verify that array presets are applied
as expected.
Introduce few negative tests as well to check that common error modes
are handled.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/test_veristat.c  | 86 ++++++++++++++++++-
 .../selftests/bpf/progs/set_global_vars.c     | 51 +++++++----
 2 files changed, 114 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 47b56c258f3f..057c249c82fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -60,12 +60,15 @@ static void test_set_global_vars_succeeds(void)
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
+	    " -G \"arr[3]= 171\" "	\
+	    " -G \"arr[EA2] =172\" "	\
+	    " -G \"enum_arr[EC2]=EA3\" "	\
 	    "-vl2 > %s", fix->veristat, fix->tmpfile);
 
 	read(fix->fd, fix->output, fix->sz);
@@ -81,8 +84,11 @@ static void test_set_global_vars_succeeds(void)
 	__CHECK_STR("_w=12 ", "var_eb = EB2");
 	__CHECK_STR("_w=13 ", "var_ec = EC2");
 	__CHECK_STR("_w=1 ", "var_b = 1");
-	__CHECK_STR("_w=170 ", "struct1.struct2.u.var_u8 = 170");
+	__CHECK_STR("_w=170 ", "struct1.struct2[1].u.var_u8[2] = 170");
 	__CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
+	__CHECK_STR("_w=171 ", "arr[3]= 171");
+	__CHECK_STR("_w=172 ", "arr[EA2] =172");
+	__CHECK_STR("_w=10 ", "enum_arr[EC2]=EA3");
 
 out:
 	teardown_fixture(fix);
@@ -129,6 +135,66 @@ static void test_set_global_vars_out_of_range(void)
 	teardown_fixture(fix);
 }
 
+static void test_unsupported_2dim_array_type(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"matrix[0][0] = 1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("Could not parse 'matrix[0][0]'", "matrix");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_unsupported_ptr_array_type(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"ptr_arr[0] = 0\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("Unsupported array type for variable ptr_arr", "ptr_arr");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_array_out_of_bounds(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"arr[99] = 0\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("Preset index 99 is invalid or out of bounds", "arr[99]");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_array_index_not_found(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"arr[EG2] = 0\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("Could not find array index as enum value EG2", "arr[EG2]");
+
+out:
+	teardown_fixture(fix);
+}
+
 void test_veristat(void)
 {
 	if (test__start_subtest("set_global_vars_succeeds"))
@@ -139,6 +205,18 @@ void test_veristat(void)
 
 	if (test__start_subtest("set_global_vars_from_file_succeeds"))
 		test_set_global_vars_from_file_succeeds();
+
+	if (test__start_subtest("test_unsupported_2dim_array_type"))
+		test_unsupported_2dim_array_type();
+
+	if (test__start_subtest("test_unsupported_ptr_array_type"))
+		test_unsupported_ptr_array_type();
+
+	if (test__start_subtest("test_array_out_of_bounds"))
+		test_array_out_of_bounds();
+
+	if (test__start_subtest("test_array_index_not_found"))
+		test_array_index_not_found();
 }
 
 #undef __CHECK_STR
diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/testing/selftests/bpf/progs/set_global_vars.c
index 90f5656c3991..a022c08895b9 100644
--- a/tools/testing/selftests/bpf/progs/set_global_vars.c
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -7,22 +7,30 @@
 
 char _license[] SEC("license") = "GPL";
 
-enum Enum { EA1 = 0, EA2 = 11 };
+typedef __s32 s32;
+typedef s32 i32;
+typedef __u8 u8;
+
+enum Enum { EA1 = 0, EA2 = 11, EA3 = 10 };
 enum Enumu64 {EB1 = 0llu, EB2 = 12llu };
 enum Enums64 { EC1 = 0ll, EC2 = 13ll };
 
 const volatile __s64 var_s64 = -1;
 const volatile __u64 var_u64 = 0;
-const volatile __s32 var_s32 = -1;
+const volatile i32 var_s32 = -1;
 const volatile __u32 var_u32 = 0;
 const volatile __s16 var_s16 = -1;
 const volatile __u16 var_u16 = 0;
 const volatile __s8 var_s8 = -1;
-const volatile __u8 var_u8 = 0;
+const volatile u8 var_u8 = 0;
 const volatile enum Enum var_ea = EA1;
 const volatile enum Enumu64 var_eb = EB1;
 const volatile enum Enums64 var_ec = EC1;
 const volatile bool var_b = false;
+const volatile i32 arr[32];
+const volatile enum Enum enum_arr[32];
+const volatile i32 matrix[32][32];
+const volatile i32 *ptr_arr[32];
 
 struct Struct {
 	int:16;
@@ -35,34 +43,36 @@ struct Struct {
 		volatile struct {
 			const int:1;
 			union {
-				const volatile __u8 var_u8;
+				const volatile u8 var_u8[3];
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
 
-union Union {
-	__u16 var_u16;
-	struct Struct3 {
-		struct {
-			__u8 var_u8_l;
-		};
+struct Struct3 {
+	struct {
+		u8 var_u8_l;
+	};
+	struct {
 		struct {
-			struct {
-				__u8 var_u8_h;
-			};
+			u8 var_u8_h;
 		};
-	} struct3;
+	};
 };
 
-const volatile union Union union1 = {.var_u16 = -1};
+typedef struct Struct3 Struct3_t;
 
-char arr[4] = {0};
+union Union {
+	__u16 var_u16;
+	Struct3_t struct3;
+};
+
+const volatile union Union union1 = {.var_u16 = -1};
 
 SEC("socket")
 int test_set_globals(void *ctx)
@@ -81,8 +91,11 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
-	a = struct1.struct2.u.var_u8;
+	a = struct1[2].struct2[1].u.var_u8[2];
 	a = union1.var_u16;
+	a = arr[3];
+	a = arr[EA2];
+	a = enum_arr[EC2];
 
 	return a;
 }
-- 
2.49.0


