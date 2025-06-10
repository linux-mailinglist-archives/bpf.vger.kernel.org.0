Return-Path: <bpf+bounces-60229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91471AD4288
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D11E189E7B7
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF12609CD;
	Tue, 10 Jun 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyE/IPhF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAA2F85B
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582534; cv=none; b=cMQEYUDCzDGIcE5G005qdyX8qV0qHw3ykJBMUa4aD+twbjRBpBpHkOefgV2QU8f9JxBKq9aSILRsOZcAQR+Olo33jcajbJr1S2KE9l/n6O0HebN60lDAqfNGPYucYXJD2EMqNRl0el9hTxf5gFtmaa1b5dNiFbGmi7b6DkcsuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582534; c=relaxed/simple;
	bh=3MV763uIn1GaI/fTHLxzZ0fyB0ntCJXgJAdCSkbdI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1PncVq6RQ5E5N/nMhNZinmUdzA8Dg3cduKxVBXlCnNtWvVjfACv5MPwffRiyvItkLNdotIg95ghkxlmQ0P8/rMmq5PK0b5Psdeu9C9Sa7bP/VorKMdjQQNHbrO/H899R6Ltdm+V243iUs8NHvFbrSE79x3fl3el2Le1RYDRbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyE/IPhF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso6003550a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749582531; x=1750187331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hqzZzcO1dgzJWSA9Pm67AQSHnbtE/6V+gMdwQpegno=;
        b=lyE/IPhFpqjVhvNk73LDDmp0W/Q3iAk/JMICqtgdLSDWCrOGSYBpwf/oIuc2rounAS
         xyzaC0F7yRg+K43UBVcOgaItG/xDTM4+rGtXB6/iTVTZ90X23yH7ZjsOVzzDjobuZP3s
         TkHLqvzoP+xZZa46EXCEyaZrZ7IoqsjC/KiA7Wp0NM/13OT0r70d4XuvrTrHvbT09+gF
         c9tydOHnJRruABJ5Kk16WhwurkZ56pkPGbeFEwIyvFaY66Kx281jjEGFOJWN5sgw9DPK
         ms8BoDCzg/qRFNv3FY0rE1Fe3yRpSHO0PNhZqjccl32YXLonCY5WPIxOYU3CzcWe3r/7
         7uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749582531; x=1750187331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hqzZzcO1dgzJWSA9Pm67AQSHnbtE/6V+gMdwQpegno=;
        b=EfrCyP7FatwmgLTFPd1cXPsl1tpHU+BhxTi6Z/5aOkj3t3VL7QzOt9F0VoSoYQx8Nl
         CmZWJ7OIv19wFsSs8QT2s1PvRab2j8n/ZzUrJUtDuLGiRs+g8d/JMeFTljaug7wHVlOH
         ls6ZFUcDUB93DYwPyfew5IgcdTAU5naCBW7kyt9ymuo0sHaI7EVEKW+QfYY3YyF0vTXd
         CFseS69R1/zZPnOXVfK9JvEWzNczeb/B7DomJAxmjzcPKFDPwCBivkdS5hgX7qj7lykz
         bUeqNHx7iV2YwVBGvC9+N8MZQHlCeje1hbMunWhRHoe2JGPFee7h14L1rY8T4gCZJnsf
         Gk6g==
X-Gm-Message-State: AOJu0YwS6+v5OiEqrx2ytOszB7GS7deQngpVjsGdvls1L0lZFROEVZ1/
	BYo3jCuvF9jQK3PoDJfr2k9J/XFg/7ChQr1ILqQOXYKfuKJ62iYjv3E5J7cBsK97DlA=
X-Gm-Gg: ASbGncvSJCVJ1WiOLwvLi3hEBtIySSLqbUW+VI1dgyXU1LRo8fTFrd2kp3wBswM1HP2
	CN6kIdHXhDkKd2t2MMq1aOSk7d2HI3wv1Qqzhc3qtgNvW4HzzDntNeMk1nCpxDuxP/lap0Ucth6
	4T9xrWueG0wff8+JbSSPaNCe6hPVpo06aF3hzLSNfPvusx231ZW1e2/sO9LM1a62iy1uOHfGHj4
	L9OAO0ReaKH5Ko5sDxexqub4FNQg4hE1GTpbRmo0+w6jbTjrqYDPfqTYqzdNcQXPRZSGVGRuW34
	bVyDL9lr7qrV8qrP6k0ORhh8LAHosMFJC5P4yLM4+w==
X-Google-Smtp-Source: AGHT+IGIty8yYwnagX4N4cxzHuTddEGomO7YIbD3JQf8sAHw7hqmXQQYmoajjwNjCjD+V9GLiCBs/A==
X-Received: by 2002:a17:907:7205:b0:ad8:a935:b908 with SMTP id a640c23a62f3a-ade8978388emr52878966b.30.1749582530440;
        Tue, 10 Jun 2025 12:08:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c82csm770067866b.174.2025.06.10.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 12:08:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: test array presets in veristat
Date: Tue, 10 Jun 2025 20:08:40 +0100
Message-ID: <20250610190840.1758122-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/test_veristat.c  | 136 +++++++++++++++++-
 .../selftests/bpf/progs/set_global_vars.c     |  51 ++++---
 2 files changed, 164 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 47b56c258f3f..bd3c04d9c54d 100644
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
@@ -129,6 +135,110 @@ static void test_set_global_vars_out_of_range(void)
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
+	__CHECK_STR("Unsupported array element type for variable ptr_arr", "ptr_arr");
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
+	__CHECK_STR("Can't resolve EG2 enum as an array indexFailed to set global variables", "arr[EG2]");
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
+	__CHECK_STR("Array index is expected for arr", "arr = 1");
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"struct1[0].struct2.u.var_u8[2]=1\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	pread(fix->fd, fix->output, fix->sz, 0);
+	__CHECK_STR("Array index is expected for struct2", "struct1[0].struct2.u.var_u8[2]=1");
+
+out:
+	teardown_fixture(fix);
+}
+
 void test_veristat(void)
 {
 	if (test__start_subtest("set_global_vars_succeeds"))
@@ -139,6 +249,24 @@ void test_veristat(void)
 
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
+
+	if (test__start_subtest("test_array_index_for_non_array"))
+		test_array_index_for_non_array();
+
+	if (test__start_subtest("test_no_array_index_for_array"))
+		test_no_array_index_for_array();
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


