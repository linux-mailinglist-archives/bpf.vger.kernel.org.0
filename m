Return-Path: <bpf+bounces-50713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E901AA2B865
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7547D1667D6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D89BEAE7;
	Fri,  7 Feb 2025 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQI4d4LW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827D4C6E
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892897; cv=none; b=MWIpIWgjZNWGJ5xCAIXf2gehtBPQJC7Lvbvl5wRTP+9gmC3dGCZCMHBFm89zW8gqUIMej6xDv2z8uWrNbXFLW/S4tKZ+amkqZb0CEpEeKHUKJov+3AcW9OtmBtZ95GqeDdRmdlgXZEdR+D/fNWfVvnkQcncMgWFohaXDVoQGWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892897; c=relaxed/simple;
	bh=6tUvsRooh1QRzLDxv8nKxB4haFbsiIid4UPkq1FjXMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOIFszjcjGfVhyHs0UJCHsR27AR0qRTRa3hXS77ZbiI7WzocxHVRG73UyQScWsIvmcsg5bOWh/jrPQ8CD3pBXiDefMw74L6GjutQhtvFGghRskWnLUaWwMhDVbt+SBwcoTTbvxUP3XKUTobrMKcmzZmQEVs1WL4O9CHI0uCdaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQI4d4LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26403C4CEDD;
	Fri,  7 Feb 2025 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738892894;
	bh=6tUvsRooh1QRzLDxv8nKxB4haFbsiIid4UPkq1FjXMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQI4d4LWyph+/Xjrpa2UccKKelHurMZLWuCOx8ue8XT+77q6b+k2OchsjzVOBCsah
	 Q9ll8udGCu8AMweGXmHvacVX/pOOg1jX2dK9dpEagTL7yNm/BUewamwNfJvVZN6NMm
	 QSvu73IqQ3JgS5K4/IWvTUmo+FJHTp7ToxQWndZwjM/06gNzbErWR2EpPz7BlTaVIC
	 50YU9+vZTp0kxiOWhjGvH+Hi8gct1x5FS2KryZ0dIH41Uh3oPEe4WPtqxvzR3y1SYz
	 wG4wVsJnTjiqtBXqayJRDVbzkDwod2QjmmzSaMAzh0MI5YXcll9qxJGzwoWsbwTo1g
	 MS5n48zj1eoWw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test for LDX/STX/ST relocations over array field
Date: Thu,  6 Feb 2025 17:48:09 -0800
Message-ID: <20250207014809.1573841-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250207014809.1573841-1-andrii@kernel.org>
References: <20250207014809.1573841-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple repro for the issue of miscalculating LDX/STX/ST CO-RE
relocation size adjustment when the CO-RE relocation target type is an
ARRAY.

We need to make sure that compiler generates LDX/STX/ST instruction with
CO-RE relocation against entire ARRAY type, not ARRAY's element. With
the code pattern in selftest, we get this:

      59:       61 71 00 00 00 00 00 00 w1 = *(u32 *)(r7 + 0x0)
                00000000000001d8:  CO-RE <byte_off> [5] struct core_reloc_arrays::a (0:0)

Where offset of `int a[5]` is embedded (through CO-RE relocation) into memory
load instruction itself.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  6 ++++--
 ...f__core_reloc_arrays___err_bad_signed_arr_elem_sz.c |  3 +++
 tools/testing/selftests/bpf/progs/core_reloc_types.h   | 10 ++++++++++
 .../selftests/bpf/progs/test_core_reloc_arrays.c       |  5 +++++
 4 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index e10ea92c3fe2..08963c82f30b 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -85,11 +85,11 @@ static int duration = 0;
 #define NESTING_ERR_CASE(name) {					\
 	NESTING_CASE_COMMON(name),					\
 	.fails = true,							\
-	.run_btfgen_fails = true,							\
+	.run_btfgen_fails = true,					\
 }
 
 #define ARRAYS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {	\
-	.a = { [2] = 1 },						\
+	.a = { [2] = 1, [3] = 11 },					\
 	.b = { [1] = { [2] = { [3] = 2 } } },				\
 	.c = { [1] = { .c =  3 } },					\
 	.d = { [0] = { [0] = { .d = 4 } } },				\
@@ -108,6 +108,7 @@ static int duration = 0;
 	.input_len = sizeof(struct core_reloc_##name),			\
 	.output = STRUCT_TO_CHAR_PTR(core_reloc_arrays_output) {	\
 		.a2   = 1,						\
+		.a3   = 12,						\
 		.b123 = 2,						\
 		.c1c  = 3,						\
 		.d00d = 4,						\
@@ -602,6 +603,7 @@ static const struct core_reloc_test_case test_cases[] = {
 	ARRAYS_ERR_CASE(arrays___err_non_array),
 	ARRAYS_ERR_CASE(arrays___err_wrong_val_type),
 	ARRAYS_ERR_CASE(arrays___err_bad_zero_sz_arr),
+	ARRAYS_ERR_CASE(arrays___err_bad_signed_arr_elem_sz),
 
 	/* enum/ptr/int handling scenarios */
 	PRIMITIVES_CASE(primitives),
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
new file mode 100644
index 000000000000..21a560427b10
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_arrays___err_bad_signed_arr_elem_sz x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index fd8e1b4c6762..5760ae015e09 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -347,6 +347,7 @@ struct core_reloc_nesting___err_too_deep {
  */
 struct core_reloc_arrays_output {
 	int a2;
+	int a3;
 	char b123;
 	int c1c;
 	int d00d;
@@ -455,6 +456,15 @@ struct core_reloc_arrays___err_bad_zero_sz_arr {
 	struct core_reloc_arrays_substruct d[1][2];
 };
 
+struct core_reloc_arrays___err_bad_signed_arr_elem_sz {
+	/* int -> short (signed!): not supported case */
+	short a[5];
+	char b[2][3][4];
+	struct core_reloc_arrays_substruct c[3];
+	struct core_reloc_arrays_substruct d[1][2];
+	struct core_reloc_arrays_substruct f[][2];
+};
+
 /*
  * PRIMITIVES
  */
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
index 51b3f79df523..448403634eea 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
@@ -15,6 +15,7 @@ struct {
 
 struct core_reloc_arrays_output {
 	int a2;
+	int a3;
 	char b123;
 	int c1c;
 	int d00d;
@@ -41,6 +42,7 @@ int test_core_arrays(void *ctx)
 {
 	struct core_reloc_arrays *in = (void *)&data.in;
 	struct core_reloc_arrays_output *out = (void *)&data.out;
+	int *a;
 
 	if (CORE_READ(&out->a2, &in->a[2]))
 		return 1;
@@ -53,6 +55,9 @@ int test_core_arrays(void *ctx)
 	if (CORE_READ(&out->f01c, &in->f[0][1].c))
 		return 1;
 
+	a = __builtin_preserve_access_index(({ in->a; }));
+	out->a3 = a[0] + a[1] + a[2] + a[3];
+
 	return 0;
 }
 
-- 
2.43.5


