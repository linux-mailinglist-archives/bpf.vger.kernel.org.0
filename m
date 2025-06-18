Return-Path: <bpf+bounces-60997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9CADF7E3
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B90F16FA0E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D1220F29;
	Wed, 18 Jun 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cItDgz6p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA96220F37
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279157; cv=none; b=DTbGGujDca61yG7QkYF4COBdmSZNOyYNJTzDhw211eYVo5+jwEcCQo7ONA3GI7jN1/c8vP2nEA+sBcwPIWSJLfvGglBshDwVzFNtb2QQ1iWn5CF17ZchmMEPU0inYa34jDF/o/C2QGyWnh9wsp5DxZ7I/9Rj1Ae3l65l1KnpwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279157; c=relaxed/simple;
	bh=4bASxe+9aO0lhBQMBWg0wUA4YlajNUOpne5ePQmKiaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chTDWLjOcdfM14oMRVatW48GLBHpqiTlj0zmbtg0gTqGkmf2Ozcf+336xBRqoVBf3Aoam0M7DOaNwTTzaMI4ro4ajoOHLjTq6lmHy5WiJMlZQNWLrpvjaNqGYk2t6qvjrHxXgI7NP/Xu7DejWEVsOu+R4bqPlR8oxI3mfQSqctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cItDgz6p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce671a08so386845e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750279153; x=1750883953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRl3r/9gC9pPlOy3IYxCGyH3BJFVf7Q4niPonVGegMk=;
        b=cItDgz6pBIuRrC6Rn1PqrbzFWKEN9BUPbaQLVLcB8xu/5NdAiTdnrAgCYIBtwuZ+as
         nmmNJhD2EPi1nIYUmkkLnuGIfE0Ty5yaC9SBt3pamsBOvCl1ZqE2Pb6RgczVLOhGNBst
         6y7JSlK8XEb6E+4u1DFXTH4ADDS6Uj20H+ifhkxG/CO1TRjRvy0pkWQBqtH2ccMl5hha
         /+vlLdWm6wzfn03X/UGp+1snjqTJgUV1lAbgmzibX6vrs2/BZtmpraPItpyxR/pJWrix
         BFJ6Vflz14WbXiPoRm0xV0FvLeiqHbyuHSZQgU1ucfWWP+NzPxEp4dPetO31bKy3PPw6
         NztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750279153; x=1750883953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRl3r/9gC9pPlOy3IYxCGyH3BJFVf7Q4niPonVGegMk=;
        b=vu/cZV7QnoO7K3N1Q5xV58zTvyzjg7OHR99c6Z5hghkZfTOXHq17GoTmObXKqW0ixb
         jbQouPsUuf2ZkrjCXZ0VJiVyIl651ym0LXwmzH3AJXedxXDRCYPCuJevxRd8dFcK4na9
         8k0/MN9ZyuZVte/A0qUxpdzu/hOB3uYKBz5Rbl8daOdGnzPKfXG5/1l6auxKU9H7/GTb
         BLC6CMugUWs9mPkvJlxNR+iCacyLGOVRbghy+uP9HNq6OKremIqC7NRaOZbkmd22U5hk
         Rwu8LRFW5keVqDp0rU1y65lxoNxnYIjoDAZjfxkgkEbS5celSZ20Bn0KthqTIemZxQQX
         xB4w==
X-Gm-Message-State: AOJu0Yz31N/W/tOIrA6bdSF8lxJcgyeclivnG+szvU45S9CXYggar8Ge
	ZHAYw0MuHBnPd9OkLbmL0B7pXBjT7ye3dWvJpLllM1Qe5vXi3MF6uPcANjd5AQ==
X-Gm-Gg: ASbGncv5YGJqo1N7yGNaaeDMEDvJM2I6Hsa7hSEmIDSXALlC9d9mD/x2vcm2NdnRAuK
	KcUzgIGg1xT4aAGZk2QdIN4/07etxvUCjJJuGUulMKmqs5a2MPo/SOsFopfmJ84M2WeLMk5DNqT
	D/h6RzXdUnRAuvm16e68f8mqXzDibrjtq9DneFpF2vmUF1EF1p2Ru/9G4DSWzfM6vtrY2E/OoCJ
	X0yLsAdGXJkJ5XmwWX25CaJyi2ABG8ZZ/DX4gQ45rvHvlMWPqBlYUnU+uNW4l4ZMABDuPMk6wb9
	+TcSH3xsBeG64awvHDfgvtt9KKTY1F0924YXwzfnw0DVxRhtwpkiHfW9UY2SqMBTRbzrxaQ=
X-Google-Smtp-Source: AGHT+IGuW5L8UKYgId8Mcv1/mPUZYlyFpUoyqEBNZ9uFS/ZNI155Vp3F41UfsqJGgqu8ABHKDkGVGg==
X-Received: by 2002:a05:600c:4e12:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45352f04d8emr91658905e9.9.1750279152939;
        Wed, 18 Jun 2025 13:39:12 -0700 (PDT)
Received: from localhost ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e99503asm7184485e9.29.2025.06.18.13.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:39:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: test array presets in veristat
Date: Wed, 18 Jun 2025 21:39:03 +0100
Message-ID: <20250618203903.539270-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/test_veristat.c  | 127 +++++++++++++++++-
 .../selftests/bpf/progs/set_global_vars.c     |  56 +++++---
 2 files changed, 159 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 47b56c258f3f..f4de22302083 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -60,13 +60,19 @@ static void test_set_global_vars_succeeds(void)
 	    " -G \"var_s8 = -128\" "\
 	    " -G \"var_u8 = 255\" "\
 	    " -G \"var_ea = EA2\" "\
-	    " -G \"var_eb = EB2\" "\
-	    " -G \"var_ec = EC2\" "\
+	    " -G \"var_eb  =  EB2\" "\
+	    " -G \"var_ec=EC2\" "\
 	    " -G \"var_b = 1\" "\
-	    " -G \"struct1.struct2.u.var_u8 = 170\" "\
+	    " -G \"struct1[2].struct2[1][2].u.var_u8[2]=170\" "\
 	    " -G \"union1.struct3.var_u8_l = 0xaa\" "\
 	    " -G \"union1.struct3.var_u8_h = 0xaa\" "\
-	    "-vl2 > %s", fix->veristat, fix->tmpfile);
+	    " -G \"arr[3]= 171\" "	\
+	    " -G \"arr[EA2] =172\" "	\
+	    " -G \"enum_arr[EC2]=EA3\" " \
+	    " -G \"three_d[31][7][EA2]=173\"" \
+	    " -G \"struct1[2].struct2[1][2].u.mat[5][3]=174\" " \
+	    " -G \"struct11[7][5].struct2[0][1].u.mat[3][0] = 175\" " \
+	    " -vl2 > %s", fix->veristat, fix->tmpfile);
 
 	read(fix->fd, fix->output, fix->sz);
 	__CHECK_STR("_w=0xf000000000000001 ", "var_s64 = 0xf000000000000001");
@@ -81,8 +87,14 @@ static void test_set_global_vars_succeeds(void)
 	__CHECK_STR("_w=12 ", "var_eb = EB2");
 	__CHECK_STR("_w=13 ", "var_ec = EC2");
 	__CHECK_STR("_w=1 ", "var_b = 1");
-	__CHECK_STR("_w=170 ", "struct1.struct2.u.var_u8 = 170");
+	__CHECK_STR("_w=170 ", "struct1[2].struct2[1][2].u.var_u8[2]=170");
 	__CHECK_STR("_w=0xaaaa ", "union1.var_u16 = 0xaaaa");
+	__CHECK_STR("_w=171 ", "arr[3]= 171");
+	__CHECK_STR("_w=172 ", "arr[EA2] =172");
+	__CHECK_STR("_w=10 ", "enum_arr[EC2]=EA3");
+	__CHECK_STR("_w=173 ", "matrix[31][7][11]=173");
+	__CHECK_STR("_w=174 ", "struct1[2].struct2[1][2].u.mat[5][3]=174");
+	__CHECK_STR("_w=175 ", "struct11[7][5].struct2[0][1].u.mat[3][0]=175");
 
 out:
 	teardown_fixture(fix);
@@ -129,6 +141,95 @@ static void test_set_global_vars_out_of_range(void)
 	teardown_fixture(fix);
 }
 
+static void test_unsupported_ptr_array_type(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"ptr_arr[0] = 0\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("Can't set ptr_arr[0]. Only ints and enums are supported", "ptr_arr");
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
+	__CHECK_STR("Array index 99 is out of bounds", "arr[99]");
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
+	__CHECK_STR("Can't resolve enum value EG2", "arr[EG2]");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_array_index_for_non_array(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"var_b[0] = 1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	pread(fix->fd, fix->output, fix->sz, 0);
+	__CHECK_STR("Array index is not expected for var_b", "var_b[0] = 1");
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"union1.struct3[0].var_u8_l=1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	pread(fix->fd, fix->output, fix->sz, 0);
+	__CHECK_STR("Array index is not expected for struct3", "union1.struct3[0].var_u8_l=1");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_no_array_index_for_array(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"arr = 1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	pread(fix->fd, fix->output, fix->sz, 0);
+	__CHECK_STR("Can't set arr. Only ints and enums are supported", "arr = 1");
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"struct1[0].struct2.u.var_u8[2]=1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	pread(fix->fd, fix->output, fix->sz, 0);
+	__CHECK_STR("Can't resolve field u for non-composite type", "struct1[0].struct2.u.var_u8[2]=1");
+
+out:
+	teardown_fixture(fix);
+}
+
 void test_veristat(void)
 {
 	if (test__start_subtest("set_global_vars_succeeds"))
@@ -139,6 +240,22 @@ void test_veristat(void)
 
 	if (test__start_subtest("set_global_vars_from_file_succeeds"))
 		test_set_global_vars_from_file_succeeds();
+
+	if (test__start_subtest("test_unsupported_ptr_array_type"))
+		test_unsupported_ptr_array_type();
+
+	if (test__start_subtest("test_array_out_of_bounds"))
+		test_array_out_of_bounds();
+
+	if (test__start_subtest("test_array_index_not_found"))
+		test_array_index_not_found();
+
+	if (test__start_subtest("test_array_index_for_non_array"))
+		test_array_index_for_non_array();
+
+	if (test__start_subtest("test_no_array_index_for_array"))
+		test_no_array_index_for_array();
+
 }
 
 #undef __CHECK_STR
diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/testing/selftests/bpf/progs/set_global_vars.c
index 90f5656c3991..ebaef28b2cb3 100644
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
+const volatile i32 three_d[47][19][17];
+const volatile i32 *ptr_arr[32];
 
 struct Struct {
 	int:16;
@@ -35,34 +43,38 @@ struct Struct {
 		volatile struct {
 			const int:1;
 			union {
-				const volatile __u8 var_u8;
+				const volatile u8 var_u8[3];
 				const volatile __s16 filler3;
 				const int:1;
+				s32 mat[7][5];
 			} u;
 		};
-	} struct2;
+	} struct2[2][4];
 };
 
 const volatile __u32 stru = 0; /* same prefix as below */
-const volatile struct Struct struct1 = {.struct2 = {.u = {.var_u8 = 1}}};
+const volatile struct Struct struct1[3];
+const volatile struct Struct struct11[11][7];
 
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
@@ -81,8 +93,14 @@ int test_set_globals(void *ctx)
 	a = var_eb;
 	a = var_ec;
 	a = var_b;
-	a = struct1.struct2.u.var_u8;
+	a = struct1[2].struct2[1][2].u.var_u8[2];
 	a = union1.var_u16;
+	a = arr[3];
+	a = arr[EA2];
+	a = enum_arr[EC2];
+	a = three_d[31][7][EA2];
+	a = struct1[2].struct2[1][2].u.mat[5][3];
+	a = struct11[7][5].struct2[0][1].u.mat[3][0];
 
 	return a;
 }
-- 
2.49.0


