Return-Path: <bpf+bounces-79560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B41D3C029
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C325F50823F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BD36D4EF;
	Tue, 20 Jan 2026 07:04:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1F36AB61
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892681; cv=none; b=scDTVePcx+85moGEjuEOY2VUZYRYfE8GPFkha9NEF7EWzmkrSwNEEFRXJdZxs04Qc1t7DxcxqsnQxdQIXkFUAFQZGNpG8eHSAdKBjB60jdLCWfGJ0MnQXIv9EXCsFrrnX2zv3/wNbUM3GYgIV0oQOYtb81awy/2r3I9VQBIht80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892681; c=relaxed/simple;
	bh=o55zc6O0LjI6q1LOk8AyqGSEGN7A5aF1DRA5NVUHw9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFOCvST5/6t8fltZuZqdl0ieT1e5n8ly7X3OAUjgRv308hca3qv7pNm+9m6pucx9gjTTrDIQTYKzq7Hv/zORz4fXPbYlCe/2k5sdBwh2eArFr8XW0U4ESLo8qcb6B2l+aKkeoyvhu2KZ3mm8mJzTNbRFN6Klsv+rqqlU2v+ka+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: R5pRiHj5SdO1kzgbH8r6zQ==
X-CSE-MsgGUID: vvsLRmYATXS7KTUJeVGSKg==
X-IPAS-Result: =?us-ascii?q?A2GNAgDJJ29p/zcImYJaglmCV4JbtGmBfwYJAQEBAQEBA?=
 =?us-ascii?q?QEBWgQBAYUHAox6JzUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQICgR2GCVOGYwYyAUYQUVYZgwKCdLEsgQHdei1UgSYBCxQBgTiNU?=
 =?us-ascii?q?nGEeEKCDYEVg2iBD4l4BIMwlA5IgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuC?=
 =?us-ascii?q?BEZHYEZCj4XgQobBwWBIgaCFYZpD4kygV8DCxgNSBEsNxQbQm4HjxFHgi6BD?=
 =?us-ascii?q?5E7B4d3jw+hEYQmhFEfnGhNqmsumFijaXCGUQGCFE04gyJSGQ+OLRbMAWk8A?=
 =?us-ascii?q?gcLAQEDCZNpAQE?=
IronPort-Data: A9a23:rVcKDqrMCum4rOj3KjbsH8YTYB9eBmK+ZBIvgKrLsJaIsI4StFCzt
 garIBnSaK2CYWumLdtzPtnl8ElXvcfTzINjSQY5qS82ESwa+JacVYWSI27OZB+ff5bJJK5FA
 2TySTViwOQcFCK0SsKFa+C5xZVE/fjWAOK6U6icZnwZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsfvrRC9H5qyo5mtB5ARmPJingXeH/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR8/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7m0JAklVUFO0OevzXFSKqV/xWWeG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr9jr2Ii6ausxvcgEdcr5M4k/6ms+3wiMWJ7KQbibK0nLzdpImTs9gsFQEOzPI
 dcUYnxmZ1LCe3WjOH9OU8p4xbrzwCm5LmAwRFG9/MLb50DS1wxwwbHoOfLVYtfMRN4Tg0uT4
 GvNuWbhav0fHIXHl2vdqSzz2IcjmwvlRpk2LriJ38JauwKw+lExBSM5bni09KzRZkmWAYsFd
 BNNq0LCt5Ma9VerT8j0WhSQoGaP+B8HHcddGKsz40eP0sLpDx2xA3hBQjNFacIrrt5sAyEn3
 RmAlJXrHVSDrYF5V1qnq6+urBOwZBMZCjYBdyAObVsfvcva9dRbYg30cjp1LEKipv/NcQwcL
 hiPvG0yirESk8MRxv/94F3MxTun4JrRJuLU2uk1dj/6hu+aTNf6D2BN1bQ8xawYRLt1tnHb4
 BA5dzG2tYjjzfilzURhutnh441FF97faWeD3gc+d3XQ3yit9ja+e4FO7StlJVt4esEKMTLtb
 UTPowQU75hWOWasbKR+f4O2Dd9C8JUN1L3NCJjpUza5SsEtL1XdrX4/Ox/4MqKEuBFErJzT8
 KyzKa6EZUv2w4w8pNZqb4/xCYMW+x0=
IronPort-HdrOrdr: A9a23:lWg93qw+2B7mKnWO9j+pKrPwCr1zdoMgy1knxilNoHtuA6ilfq
 GV7ZEmPHrP4wr5N0tOpTntAsO9qBDnhPxICPcqXYtKNTOO0FdAR7sP0WKN+VDdMhy72/JH1a
 9mN4hyYeeAbmRSvILW/BK5G9Fl5NGG9Y+yg+O29RlQZDAvRr167w9/Tj2QC1BKQmB9ZKYEKA
 ==
X-Talos-CUID: 9a23:Y3JKaW3o/bv6U3v1qp5MQLxfIJ09SHz9zirrL2jhCnRmQp3FUwGCwfYx
X-Talos-MUID: 9a23:MXK13QZ+NsUlNuBTqSH3oAtnBe5U05/xK3wws5g4lPKnOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106903677"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 16:04:24 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 1C3D21839FBD;
	Tue, 20 Jan 2026 16:04:24 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
Date: Tue, 20 Jan 2026 16:03:36 +0900
Message-ID: <20260120070336.188850-3-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260120070336.188850-1-ishiyama@hpc.is.uec.ac.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testsuites for kfunc bpf_strncasecmp.

Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
---
 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
 tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 7 +++++++
 4 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 0f3bf594e7a5..300032a19445 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -9,6 +9,7 @@
 static const char * const test_cases[] = {
 	"strcmp",
 	"strcasecmp",
+	"strncasecmp",
 	"strchr",
 	"strchrnul",
 	"strnchr",
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
index 826e6b6aff7e..bddc4e8579d2 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -33,6 +33,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
+SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
 SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
@@ -57,6 +59,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { ret
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr1(void *ctx) { return bpf_strncasecmp(user_ptr, "HELLO", 5); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr2(void *ctx) { return bpf_strncasecmp("HELLO", user_ptr, 5);	 }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
 SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
@@ -83,6 +87,8 @@ SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return
 SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
 SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
 SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault1(void *ctx) { return bpf_strncasecmp(invalid_kern_ptr, "HELLO", 5); }
+SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault2(void *ctx) { return bpf_strncasecmp("HELLO", invalid_kern_ptr, 5);	 }
 SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
 SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 05e1da1f250f..412c53b87b18 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -8,6 +8,7 @@ char long_str[XATTR_SIZE_MAX + 1];
 
 SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
 SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
+SEC("syscall") int test_strncasecmp_too_long(void *ctx) { return bpf_strncasecmp(long_str, long_str, sizeof(long_str)); }
 SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
 SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
 SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index a8513964516b..3ccfae4d27d3 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -17,6 +17,13 @@ __test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO
 __test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
 __test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
 __test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
+__test(0) int test_strncasecmp_eq1(void *ctx) { return bpf_strncasecmp(str, "hello world", 11); }
+__test(0) int test_strncasecmp_eq2(void *ctx) { return bpf_strncasecmp(str, "HELLO WORLD", 11); }
+__test(0) int test_strncasecmp_eq3(void *ctx) { return bpf_strncasecmp(str, "HELLO world", 11); }
+__test(0) int test_strncasecmp_eq4(void *ctx) { return bpf_strncasecmp(str, "hello", 5); }
+__test(0) int test_strncasecmp_eq6(void *ctx) { return bpf_strncasecmp(str, "hello world!", 11); }
+__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasecmp(str, "hello!", 6); }
+__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecmp(str, "abc", 3); }
 __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
 __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
 __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
-- 
2.52.0


