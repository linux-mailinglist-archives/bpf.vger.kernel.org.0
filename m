Return-Path: <bpf+bounces-61552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB0AE8B51
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870C27BD542
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE152DBF76;
	Wed, 25 Jun 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiJullb6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485D273D86
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870783; cv=none; b=qPiHf9DlLwhiM4QRFkW8B42wc09OgfP8rZs5ZBgtAsREI0rBop9DmrBUpc71kX2f6Q8Tw3yvf4cZplrPMSJW3ppAF0J0AZ9fr+E9t48JkhpDPyOYuXBA2/Cq+vyveFfV3h3Xix2wn3s1u9elgwyR8ByOcQ0OL0TfRJtKlJn3N1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870783; c=relaxed/simple;
	bh=ebyfYPuANs9s60N6rZ75/ZU/YNat4a0FLCsW1+wzNyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tcot9sobHnVgXz/Sw0AIxcFH1nBbfTKbTImNBebf1bZOg+qLLBWdhrLXT4BvPUEQzbEE3x0ZFqGcBPoElY9mndwbXYzMzNcmnTta8Ief9iA0sPKhPOTrAPJZQuqG1CfPJooakC+WjEWvnP4li0LgCfET0uJgLp848uAvL3p8cfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiJullb6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso124093a12.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870779; x=1751475579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ+1KHlvbkLx7Myu7jUkv3+E9GT6gxE21xaydJW4O8E=;
        b=GiJullb6iguyRopgbN4SAOKB7MRcOq5/qaQsRm5j2P4P//42d5MumeY6sevqB2z5Px
         0vasPimluK5MqZXDDKGfjGWcj/J/YbMzm8oes+AEGSOawSIe39Gw+e0DDLD4e2y3wrk0
         MX6VM4s1I/4PMY7axh60Yetiz4ehI4laPC5Grujn3rH1qKq2CCRsF4mrksLVcVNCfFvX
         JI8mQzVLL8uKoRc9PR7MSfr3M+JoCN/1G5AxsqmrXydtU+voZkUzinetv3LRnqXXe/Tp
         ggp5P0DP76HvkhMUulg1fqfMcRo59Bb8s8yrF3doOK0qk5r7JJ8JpFcfN+5JoSSCrdaE
         yAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870779; x=1751475579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ+1KHlvbkLx7Myu7jUkv3+E9GT6gxE21xaydJW4O8E=;
        b=IZSKiOFmibhX31ktMDQH6hP9J0ailup+bk8l1EtTwuSS8SN83tEkhfy0TTjA2q3q2+
         LJRKUZ9R2EK4/LJi6OCd2FcBhQgkKGTCYwZGRCGizPjx8DbqZWnoLJUVAXqq2aZzbpL1
         5usRRuMQ9QDWnlC0qIC3LHtoInZlxQ4/Isly5EKygHk84WAVkI/d5Rm02zDEWVAmGNlJ
         n3wAQNd1RAnl6YXpfVJFRzPysFA3T7YYLfcdB4Dazk/W16LH0ZhRdWbnwYmQYv8341ep
         T4B6NKrZ88ImvXQgzpoty990K/HVpe2vyIndoin/ylDKxs7Y3sqHM7u7B5TsHi3ixpZI
         SnSw==
X-Gm-Message-State: AOJu0Yw89sfPndjKzoE4VB23z0jBw/IBySuSEKjn7qPSse24jTf4CVYb
	ncHct4ZX/yn2wnIwEeVciBr68Rxgnai2k0UiJ7J3b3J/60wl5hn889HmTBD1c1mA
X-Gm-Gg: ASbGnctD2zVAqWXcmWcrXspZCbFF4SP2hJUq+2elF1GdFNfp7MPgq0L3c7FzSSp0G5u
	NnYOWIlL4sYKFwzqSKZN0QKjEyQvjqVPbxNusm9ltQVL7A/zymD4hTT1RS9+29BwuYnLUJBTsjt
	1i3NnCLMANLiCZuoOeOKiwAIrglQ3av7E/c0lihoUfSXOCNrCbXaCEB/RkBhsLC/DOonquhmlhf
	nfvfxWgMvydCDSm5PeT8WbXEWgK7uTKq1N14PlNJZ0ssJBe1oF7Os7h++lp3JfndybiA83r1tYa
	xL0VU+rfjeTTggzKi/snts7GPNGXKolwEj4/f7sV3Q==
X-Google-Smtp-Source: AGHT+IF0mLpG+HH4S0U/ppmYGx+a9Dg9yh5gR8fkE0U4qkBuXOa6p5rGf7EaLKuHm80ovIQEdSjSTQ==
X-Received: by 2002:a05:6402:2809:b0:60c:43d9:d075 with SMTP id 4fb4d7f45d1cf-60c6614b769mr362165a12.13.1750870779361;
        Wed, 25 Jun 2025 09:59:39 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:b255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c3b63d3a1sm2268402a12.51.2025.06.25.09.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:59:38 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: test array presets in veristat
Date: Wed, 25 Jun 2025 17:59:04 +0100
Message-ID: <20250625165904.87820-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
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
index 47b56c258f3f..367f47e4a936 100644
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
+	    " -G \"struct11 [ 7 ] [ 5 ] .struct2[0][1].u.mat[3][0] = 175\" " \
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
2.50.0


