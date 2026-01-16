Return-Path: <bpf+bounces-79262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF7D32904
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C77873017870
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1533375C3;
	Fri, 16 Jan 2026 14:25:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F43370E3
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573515; cv=none; b=SiPTYErNFMvLouEbGDbsdJXCbeNz2uY+JrOCDVnfbJtTfg8pniIEl2njukCE08LsZ3gOw7Ol5OxQN0Zs5gxG/VRRbJij8AxjMnTwBhv75oYFZpO8EQ+XHYFSHGW0OYvqKOrTcC6SqPEt4do4DlRxM7yTefHZ3J2ZRP8+P2R9Og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573515; c=relaxed/simple;
	bh=o55zc6O0LjI6q1LOk8AyqGSEGN7A5aF1DRA5NVUHw9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AL3BOJTGxhnxFTYN3Hyaee/9i20JT+QIGIftJ65OfQVZa5zr1dUxO8aTEQoNCOA+AIPEJJxPzV/NFq8H8ErrN93I0YNlOBEFhrbaE3fp5fdjO3fL8GzAKG3iVjE1uud8/mJ4XDnLZLZ2MMjc2ET/V4zi8Behbx9TrLTnwDDJLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: J8BxDhkoRHy/CjUxm79mLg==
X-CSE-MsgGUID: gyo9fzxTSGSG/hzVYNeB5g==
X-IPAS-Result: =?us-ascii?q?A2HzAgC2SWpp/zYImYJaglmCV4JbtmgGCQEBAQEBAQEBA?=
 =?us-ascii?q?VoEAQGFBwKMeCc3Bg4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBA?=
 =?us-ascii?q?QYDAQECAoEdhglThmMGMgFGEFFWGYMCgnS0EoEB3XotVIEmAQsUAYE4jVJxh?=
 =?us-ascii?q?HhCgg2BFYNogQ+JeASDMJQkSIEeA1ksARNCEw0KCwcFamECGQM1EioVbggRG?=
 =?us-ascii?q?R2BGQo+F4EKGwcFgVAGghWGaQ+JMoFcAwsYDUgRLDcUG0JuB48sR4IugQ+RO?=
 =?us-ascii?q?weHd48PoRGEJoRRH5xoTaprLphYo2lwhmaCAE04gyJSGQ+OLRbFLGk8AgcLA?=
 =?us-ascii?q?QEDCZNpAQE?=
IronPort-Data: A9a23:483qeaqKfe5cT9MHHLLlqLxSXIteBmK0ZBIvgKrLsJaIsI4StFCzt
 garIBmAbP+KZTHzKN8la4Tn8UhSuJKEy9BjQApu/3s3FS8QpJacVYWSI27OZB+ff5bJJK5FA
 2TySTViwOQcFCK0SsKFa+C5xZVE/fjWAOK6U6icZnwZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsfvrRC9H5qyo5mtB5wJmP5ingXeH/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR8/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7m0JAklVUFO0OevzXFSKqV/xWWeG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr8Dm6qKXSuprvOQya+LpAZMa5SBl6T6MWJ7KQbibK0nLzdpImTs9gsFQEOzPI
 dcUYnxmZ1LCe3WjOH9OU8p4xbrzwCm5LmEwRFG9/MLb50DS1wxwwbHoOfLVYtfMRN4Tg0uT4
 GvNuWbhav0fHIXHl2Xcqyz82ocjmwv0SYVDGq+oysVFu3LUxn4tOTsbfwa09KzRZkmWAYsFd
 BNNq0LCt5Ma9VerT8j0WhSQoGaP+B8HHcddGKsz40eP0sLpDx2xA3hBQjNFacIrrt5vAyEn3
 RmAlJXrHVSDrYF5V1q/pp2EgTOxPhI1PCgpZxIUSFRU5v3s9dRbYg30cjp1LEKipv/NcQwcL
 hiPvG0yirESk8MRxvz94F3MxTun4JrRJuLU2uk1dj/4hu+aTNf7D2BN1bQ9xawfRGp+ZgDQ1
 EXoY+DEsIgz4WilzURggIwlRdlFHcppzwEwcXY1RsN+qG38k5JSVZxQ7XljIkZ3P9wfeCP4K
 Ejd8Q5V6ZRPJnzvZqhyZp+3Cs8j0annE8+Na805r7NmPPBMSeNw1Ho/OhHBhT28yhZEfGNWE
 c7zTPtAxE0yUcxPpAdajc9GuVP37kjSHV/ueK0=
IronPort-HdrOrdr: A9a23:mZbg6Kp+MhHzwXh8Vy8+OSEaV5oSeYIsimQD101hICG9E/bo8P
 xG88506faZslcssRIb6LS90cu7MBDhHPdOiOF7AV7FZmnbUQCTQL2Kg7GO/xTQXwX46+5j1b
 x9acFFYuEYdWIK7/oStzPIdurJFrG8n5yVuQ==
X-Talos-CUID: 9a23:tNwNFGD60mn3QTX6Ews33l44GsMiSF3Mi1zSHl+9VjdsbLLAHA==
X-Talos-MUID: 9a23:Z8cGjgnjMzm3cBqzSaGldnptJcA57ba+NHsiqrpBu9u6BAp9EWqS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,231,1763391600"; 
   d="scan'208";a="106711685"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 23:25:08 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 86814183E388;
	Fri, 16 Jan 2026 23:25:08 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	mykyta.yatsenko5@gmail.com,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
Date: Fri, 16 Jan 2026 23:24:55 +0900
Message-ID: <20260116142455.3526150-3-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
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


