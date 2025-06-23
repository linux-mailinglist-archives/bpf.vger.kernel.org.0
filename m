Return-Path: <bpf+bounces-61290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11527AE4573
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F959178AF3
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E060253939;
	Mon, 23 Jun 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOUy+pYG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424D248891
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686529; cv=none; b=N7YpO1lR/aaC3J/co91DqQNM58wGy5iRfXWKt+6BZCCAAqFOooYJdX1gpITNOvweZVNE+fs7WX5fakOpHPt4reR+moHXglyvjyfTWhYv3OrRPdUeiIS8ga91ezlmGoM0FxzWjPriE/HNuifaITe6qBLtmAi1uiOwmjeD6dsSdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686529; c=relaxed/simple;
	bh=BrRjE8pAleIlEOxhxfFYvnuvyGwSPpTPSOftApInygY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVG9PuFKq41zG2e0hrQ1Cepg11cpoHqERukJu6dI6d7ZlilWVtkkKUw+u04T1WK1TczBiYTxa8hN3b1oC+GQooezsarC3ulvSvlzquSZf+4QSgbbTlPYyK8StFsr0ENJZvP3rgtR8ygsAz61fHg1YD2NGmn/MhsftV8xPYaQ58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TOUy+pYG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dT5xi2UJ23RlKGF2GQVa98h997qZX4iwZNYZ8nkSDo=;
	b=TOUy+pYGUJt2zKSqj7f3SYHsDnKlgRl1FYvLwl95lqPGTXpSMOYk3vUuhpa443ca8TAnCO
	0AHL2Vfr8goSimL/+tfzzpoHap7WzgHsV29dnMUhB0sOovN26vqPtOWORumJBGTuhd8fuM
	2q49JVkO+GPEyOkKn0aS5oyiAhAcKO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-FB6quu5FMQytJK0aM2j0wA-1; Mon,
 23 Jun 2025 09:48:41 -0400
X-MC-Unique: FB6quu5FMQytJK0aM2j0wA-1
X-Mimecast-MFC-AGG-ID: FB6quu5FMQytJK0aM2j0wA_1750686518
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1F9B19560B1;
	Mon, 23 Jun 2025 13:48:37 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.33.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45FFE1803AA1;
	Mon, 23 Jun 2025 13:48:33 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v7 4/4] selftests/bpf: Add tests for string kfuncs
Date: Mon, 23 Jun 2025 15:48:03 +0200
Message-ID: <c04fd8d67c94eda2daeb3fe191e0bb0534318443.1750681829.git.vmalik@redhat.com>
In-Reply-To: <cover.1750681829.git.vmalik@redhat.com>
References: <cover.1750681829.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add both positive and negative tests cases using string kfuncs added in
the previous patches.

Positive tests check that the functions work as expected.

Negative tests pass various incorrect strings to the kfuncs and check
for the expected error codes:
  -E2BIG  when passing too long strings
  -EFAULT when trying to read inaccessible kernel memory
  -ERANGE when passing userspace pointers on arches with non-overlapping
          address spaces

A majority of the tests use the RUN_TESTS helper which executes BPF
programs with BPF_PROG_TEST_RUN and check for the expected return value.
An exception to this are tests for long strings as we need to memset the
long string from userspace (at least I haven't found an ergonomic way to
memset it from a BPF program), which cannot be done using the RUN_TESTS
infrastructure.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c  | 63 ++++++++++++++
 .../bpf/progs/string_kfuncs_failure1.c        | 85 +++++++++++++++++++
 .../bpf/progs/string_kfuncs_failure2.c        | 21 +++++
 .../bpf/progs/string_kfuncs_success.c         | 35 ++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
new file mode 100644
index 000000000000..39322f1649ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include <test_progs.h>
+#include "string_kfuncs_success.skel.h"
+#include "string_kfuncs_failure1.skel.h"
+#include "string_kfuncs_failure2.skel.h"
+#include <sys/mman.h>
+
+static const char * const string_kfuncs[] = {
+	"strcmp",
+	"strchr",
+	"strchrnul",
+	"strnchr",
+	"strrchr",
+	"strlen",
+	"strnlen",
+	"strspn",
+	"strcspn",
+	"strstr",
+	"strnstr",
+};
+
+void run_too_long_tests(void)
+{
+	struct string_kfuncs_failure2 *skel;
+	struct bpf_program *prog;
+	char test_name[256];
+	int err, i;
+
+	skel = string_kfuncs_failure2__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "string_kfuncs_failure2__open_and_load"))
+		return;
+
+	memset(skel->bss->long_str, 'a', sizeof(skel->bss->long_str));
+
+	for (i = 0; i < ARRAY_SIZE(string_kfuncs); i++) {
+		sprintf(test_name, "test_%s_too_long", string_kfuncs[i]);
+		if (!test__start_subtest(test_name))
+			continue;
+
+		prog = bpf_object__find_program_by_name(skel->obj, test_name);
+		if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+			goto cleanup;
+
+		LIBBPF_OPTS(bpf_test_run_opts, topts);
+		err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+		if (!ASSERT_OK(err, "bpf_prog_test_run"))
+			goto cleanup;
+
+		ASSERT_EQ(topts.retval, -E2BIG, "reading too long string fails with -E2BIG");
+	}
+
+cleanup:
+	string_kfuncs_failure2__destroy(skel);
+}
+
+void test_string_kfuncs(void)
+{
+	RUN_TESTS(string_kfuncs_success);
+	RUN_TESTS(string_kfuncs_failure1);
+
+	run_too_long_tests();
+}
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
new file mode 100644
index 000000000000..ed67328e837a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <linux/limits.h>
+#include "bpf_misc.h"
+#include "errno.h"
+
+char *user_ptr = (char *)1;
+char *invalid_kern_ptr = (char *)-1;
+
+/* When passing userspace pointers, the error code differs based on arch:
+ *   -ERANGE on arches with non-overlapping address spaces
+ *   -EFAULT on other arches
+ */
+#if defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_loongarch) || \
+    defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_x86)
+#define USER_PTR_ERR -ERANGE
+#else
+#define USER_PTR_ERR -EFAULT
+#endif
+
+/* On s390, __get_kernel_nofault (used in string kfuncs) returns 0 for NULL and
+ * user_ptr (instead of causing an exception) so the below two groups of tests
+ * are not applicable.
+ */
+#ifndef __TARGET_ARCH_s390
+
+/* Passing NULL to string kfuncs (treated as a userspace ptr) */
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strrchr_null(void *ctx) { return bpf_strrchr(NULL, 'a'); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strlen_null(void *ctx) { return bpf_strlen(NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strnlen_null(void *ctx) { return bpf_strnlen(NULL, 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null1(void *ctx) { return bpf_strspn(NULL, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strspn_null2(void *ctx) { return bpf_strspn("hello", NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null1(void *ctx) { return bpf_strcspn(NULL, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strcspn_null2(void *ctx) { return bpf_strcspn("hello", NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null1(void *ctx) { return bpf_strstr(NULL, "hello"); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strstr_null2(void *ctx) { return bpf_strstr("hello", NULL); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return bpf_strnstr(NULL, "hello", 1); }
+SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
+
+/* Passing userspace ptr to string kfuncs */
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strrchr_user_ptr(void *ctx) { return bpf_strrchr(user_ptr, 'a'); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strlen_user_ptr(void *ctx) { return bpf_strlen(user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strnlen_user_ptr(void *ctx) { return bpf_strnlen(user_ptr, 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strspn_user_ptr1(void *ctx) { return bpf_strspn(user_ptr, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strspn_user_ptr2(void *ctx) { return bpf_strspn("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr1(void *ctx) { return bpf_strcspn(user_ptr, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strcspn_user_ptr2(void *ctx) { return bpf_strcspn("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr1(void *ctx) { return bpf_strstr(user_ptr, "hello"); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strstr_user_ptr2(void *ctx) { return bpf_strstr("hello", user_ptr); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { return bpf_strnstr(user_ptr, "hello", 1); }
+SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
+
+#endif /* __TARGET_ARCH_s390 */
+
+/* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
+SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
+SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
+SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
+SEC("syscall") __retval(-EFAULT) int test_strrchr_pagefault(void *ctx) { return bpf_strrchr(invalid_kern_ptr, 'a'); }
+SEC("syscall") __retval(-EFAULT) int test_strlen_pagefault(void *ctx) { return bpf_strlen(invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strnlen_pagefault(void *ctx) { return bpf_strnlen(invalid_kern_ptr, 1); }
+SEC("syscall") __retval(-EFAULT) int test_strspn_pagefault1(void *ctx) { return bpf_strspn(invalid_kern_ptr, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strspn_pagefault2(void *ctx) { return bpf_strspn("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault1(void *ctx) { return bpf_strcspn(invalid_kern_ptr, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strcspn_pagefault2(void *ctx) { return bpf_strcspn("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault1(void *ctx) { return bpf_strstr(invalid_kern_ptr, "hello"); }
+SEC("syscall") __retval(-EFAULT) int test_strstr_pagefault2(void *ctx) { return bpf_strstr("hello", invalid_kern_ptr); }
+SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return bpf_strnstr(invalid_kern_ptr, "hello", 1); }
+SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
new file mode 100644
index 000000000000..685d221d8aa0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <linux/limits.h>
+
+char long_str[XATTR_SIZE_MAX + 1];
+
+SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
+SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
+SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
+SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
+SEC("syscall") int test_strrchr_too_long(void *ctx) { return bpf_strrchr(long_str, 'b'); }
+SEC("syscall") int test_strlen_too_long(void *ctx) { return bpf_strlen(long_str); }
+SEC("syscall") int test_strnlen_too_long(void *ctx) { return bpf_strnlen(long_str, sizeof(long_str)); }
+SEC("syscall") int test_strspn_too_long(void *ctx) { return bpf_strspn(long_str, "a"); }
+SEC("syscall") int test_strcspn_too_long(void *ctx) { return bpf_strcspn(long_str, "b"); }
+SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str, "hello"); }
+SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
new file mode 100644
index 000000000000..d0e94921e811
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char str[] = "hello world";
+
+#define __test(retval) SEC("syscall") __success __retval(retval)
+
+/* Functional tests */
+__test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
+__test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
+__test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
+__test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
+__test(-1) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }
+__test(1) int test_strchrnul_found(void *ctx) { return bpf_strchrnul(str, 'e'); }
+__test(11) int test_strchrnul_notfound(void *ctx) { return bpf_strchrnul(str, 'x'); }
+__test(1) int test_strnchr_found(void *ctx) { return bpf_strnchr(str, 5, 'e'); }
+__test(11) int test_strnchr_null(void *ctx) { return bpf_strnchr(str, 12, '\0'); }
+__test(-1) int test_strnchr_notfound(void *ctx) { return bpf_strnchr(str, 5, 'w'); }
+__test(9) int test_strrchr_found(void *ctx) { return bpf_strrchr(str, 'l'); }
+__test(-1) int test_strrchr_notfound(void *ctx) { return bpf_strrchr(str, 'x'); }
+__test(11) int test_strlen(void *ctx) { return bpf_strlen(str); }
+__test(11) int test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
+__test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
+__test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
+__test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world"); }
+__test(-1) int test_strstr_notfound(void *ctx) { return bpf_strstr(str, "hi"); }
+__test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, ""); }
+__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6); }
+__test(-1) int test_strnstr_notfound(void *ctx) { return bpf_strnstr(str, "hi", 10); }
+__test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1); }
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


