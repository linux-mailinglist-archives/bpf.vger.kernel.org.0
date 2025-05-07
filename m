Return-Path: <bpf+bounces-57637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98105AAD656
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258501B68D25
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1F2116FB;
	Wed,  7 May 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xjm9P0Lu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1E211A19
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600085; cv=none; b=MQ/U3dptMacUbYb4dke4LoTwer4I+QSeT5PIBL6WTGd4PyBNwzSx3wNLcs3dOzs4EQ85UeYf2i2qavfHbgWLAod2ldIQ1Jbu1U8gcxYIjf+L0qkPpu8Fm6iXfcc3zqSHn/T6wW0ylJy4V6A0ADBwnfmupsvAprXMaclqy2P1/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600085; c=relaxed/simple;
	bh=fje+MC8ajd0I/cCXtRIdWK3sP/rMDbgJzk4HP6NqEHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2wrHl+ovgpF5TmTEz3wZo/1TMapjcPMyyFUWxNIuJnzc53/A0VV3MGz+//JdLYVPRRgMNrbui352C8cViXdzr1vzUUEX+ie45Tf3n2MFWceqXeJffAN9Kg6wonLLYnPovqkvQ77gT+fWU9NCOWoOtLQKPIbYhe2pHaZ+Eh8go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xjm9P0Lu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746600082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVX3t0b8lRTs+rypmfobqTprASiijTcY67RA6ivRVY8=;
	b=Xjm9P0LuUwYiTJFzENlofP1bdpYWcb7XibWy5+2742kQUV8MkaaDFXD73k2pbE/XzR/hM7
	e2PniBAUEPYkodIiuUyL/jC0rVfRP6SgxH45n3nzMI5k3f6807R/37DH10Cimlud4rNbNB
	pMzO+vj1YPeX//+qN5GBoHsPOzz3idc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-9RGttSSJOJuQXR-q7RktEg-1; Wed,
 07 May 2025 02:41:19 -0400
X-MC-Unique: 9RGttSSJOJuQXR-q7RktEg-1
X-Mimecast-MFC-AGG-ID: 9RGttSSJOJuQXR-q7RktEg_1746600077
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FFE5180035C;
	Wed,  7 May 2025 06:41:17 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46F9E18003FC;
	Wed,  7 May 2025 06:41:12 +0000 (UTC)
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
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Add tests for string kfuncs
Date: Wed,  7 May 2025 08:40:39 +0200
Message-ID: <5ce2c639a69253ccedc02aaf9740e8be01fd72a4.1746598898.git.vmalik@redhat.com>
In-Reply-To: <cover.1746598898.git.vmalik@redhat.com>
References: <cover.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add both positive and negative tests cases using string kfuncs added in
the previous patch.

Positive tests check that the functions work as expected on various
inputs and that they accept strings of various forms.

Negative tests are of two kinds. First, we check that passing invalid
pointers is rejected by the verifier. Second, we check that even though
some arguments are allowed by the verifier, they make the string kfuncs
fail during runtime and return an appropriate error code. Such arguments
include the NULL literal (kfuncs return -EFAULT) and strings longer than
XATTR_SIZE_MAX (kfuncs return -E2BIG).

A majority of the tests use the RUN_TESTS helper which executes BPF
programs with BPF_PROG_TEST_RUN and check for the expected return value.
An exception to this are tests for long strings as we need to set the
strings from userspace and that cannot be done using the RUN_TESTS
infrastructure.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../selftests/bpf/prog_tests/string_kfuncs.c  | 65 ++++++++++++++
 .../bpf/progs/string_kfuncs_failure1.c        | 51 +++++++++++
 .../bpf/progs/string_kfuncs_failure2.c        | 24 +++++
 .../bpf/progs/string_kfuncs_success.c         | 87 +++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
 create mode 100644 tools/testing/selftests/bpf/progs/string_kfuncs_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
new file mode 100644
index 000000000000..931f499343aa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -0,0 +1,65 @@
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
+	"strpbrk",
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
+
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
new file mode 100644
index 000000000000..e7ec2a8b06cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char *nullptr = NULL;
+char *invalid_ptr = (char *)0x12345678;
+
+/* Passing NULL by value to string kfuncs is allowed by the verifier but the kfunc should return -EINVAL */
+SEC("syscall") __retval(-14) int test_strcmp_null(void *ctx) { return bpf_strcmp(NULL, NULL); }
+SEC("syscall") __retval(-14) int test_strchr_null(void *ctx) { return (u64)bpf_strchr(NULL, 'a'); }
+SEC("syscall") __retval(-14) int test_strchrnul_null(void *ctx) { return (u64)bpf_strchrnul(NULL, 'a'); }
+SEC("syscall") __retval(-14) int test_strnchr_null(void *ctx) { return (u64)bpf_strnchr(NULL, 1, 'a'); }
+SEC("syscall") __retval(-14) int test_strrchr_null(void *ctx) { return (u64)bpf_strrchr(NULL, 'a'); }
+SEC("syscall") __retval(-14) int test_strlen_null(void *ctx) { return bpf_strlen(NULL); }
+SEC("syscall") __retval(-14) int test_strnlen_null(void *ctx) { return bpf_strnlen(NULL, 1); }
+SEC("syscall") __retval(-14) int test_strspn_null(void *ctx) { return bpf_strspn(NULL, NULL); }
+SEC("syscall") __retval(-14) int test_strcspn_null(void *ctx) { return bpf_strcspn(NULL, NULL); }
+SEC("syscall") __retval(-14) int test_strpbrk_null(void *ctx) { return (u64)bpf_strpbrk(NULL, NULL); }
+SEC("syscall") __retval(-14) int test_strstr_null(void *ctx) { return (u64)bpf_strstr(NULL, NULL); }
+SEC("syscall") __retval(-14) int test_strnstr_null(void *ctx) { return (u64)bpf_strnstr(NULL, NULL, 1); }
+
+/* Passing a NULL or an invalid pointer to string kfuncs should be rejected by the verifier*/
+SEC("syscall") __failure int test_strcmp_nullptr(void *ctx) { return bpf_strcmp(nullptr, nullptr); }
+SEC("syscall") __failure int test_strchr_nullptr(void *ctx) { return (u64)bpf_strchr(nullptr, 'a'); }
+SEC("syscall") __failure int test_strchrnul_nullptr(void *ctx) { return (u64)bpf_strchrnul(nullptr, 'a'); }
+SEC("syscall") __failure int test_strnchr_nullptr(void *ctx) { return (u64)bpf_strnchr(nullptr, 1, 'a'); }
+SEC("syscall") __failure int test_strrchr_nullptr(void *ctx) { return (u64)bpf_strrchr(nullptr, 'a'); }
+SEC("syscall") __failure int test_strlen_nullptr(void *ctx) { return bpf_strlen(nullptr); }
+SEC("syscall") __failure int test_strnlen_nullptr(void *ctx) { return bpf_strnlen(nullptr, 1); }
+SEC("syscall") __failure int test_strspn_nullptr(void *ctx) { return bpf_strspn(nullptr, nullptr); }
+SEC("syscall") __failure int test_strcspn_nullptr(void *ctx) { return bpf_strcspn(nullptr, nullptr); }
+SEC("syscall") __failure int test_strpbrk_nullptr(void *ctx) { return (u64)bpf_strpbrk(nullptr, nullptr); }
+SEC("syscall") __failure int test_strstr_nullptr(void *ctx) { return (u64)bpf_strstr(nullptr, nullptr); }
+SEC("syscall") __failure int test_strnstr_nullptr(void *ctx) { return (u64)bpf_strnstr(nullptr, nullptr, 1); }
+
+SEC("syscall") __failure int test_strcmp_invalid_ptr(void *ctx) { return bpf_strcmp(invalid_ptr, invalid_ptr); }
+SEC("syscall") __failure int test_strchr_invalid_ptr(void *ctx) { return (u64)bpf_strchr(invalid_ptr, 'a'); }
+SEC("syscall") __failure int test_strchrnul_invalid_ptr(void *ctx) { return (u64)bpf_strchrnul(invalid_ptr, 'a'); }
+SEC("syscall") __failure int test_strnchr_invalid_ptr(void *ctx) { return (u64)bpf_strnchr(invalid_ptr, 1, 'a'); }
+SEC("syscall") __failure int test_strrchr_invalid_ptr(void *ctx) { return (u64)bpf_strrchr(invalid_ptr, 'a'); }
+SEC("syscall") __failure int test_strlen_invalid_ptr(void *ctx) { return bpf_strlen(invalid_ptr); }
+SEC("syscall") __failure int test_strnlen_invalid_ptr(void *ctx) { return bpf_strnlen(invalid_ptr, 1); }
+SEC("syscall") __failure int test_strspn_invalid_ptr(void *ctx) { return bpf_strspn(invalid_ptr, invalid_ptr); }
+SEC("syscall") __failure int test_strcspn_invalid_ptr(void *ctx) { return bpf_strcspn(invalid_ptr, invalid_ptr); }
+SEC("syscall") __failure int test_strpbrk_invalid_ptr(void *ctx) { return (u64)bpf_strpbrk(invalid_ptr, invalid_ptr); }
+SEC("syscall") __failure int test_strstr_invalid_ptr(void *ctx) { return (u64)bpf_strstr(invalid_ptr, invalid_ptr); }
+SEC("syscall") __failure int test_strnstr_invalid_ptr(void *ctx) { return (u64)bpf_strnstr(invalid_ptr, invalid_ptr, 1); }
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
new file mode 100644
index 000000000000..7f0f9b24890e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2025 Red Hat, Inc.*/
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <linux/limits.h>
+
+char long_str[XATTR_SIZE_MAX + 1];
+char a[] = "a";
+char b[] = "b";
+
+SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
+SEC("syscall") const char *test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
+SEC("syscall") const char *test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
+SEC("syscall") const char *test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
+SEC("syscall") const char *test_strrchr_too_long(void *ctx) { return bpf_strrchr(long_str, 'b'); }
+SEC("syscall") int test_strlen_too_long(void *ctx) { return bpf_strlen(long_str); }
+SEC("syscall") int test_strnlen_too_long(void *ctx) { return bpf_strnlen(long_str, sizeof(long_str)); }
+SEC("syscall") int test_strspn_too_long(void *ctx) { return bpf_strspn(long_str, a); }
+SEC("syscall") int test_strcspn_too_long(void *ctx) { return bpf_strcspn(long_str, b); }
+SEC("syscall") const char *test_strpbrk_too_long(void *ctx) { return bpf_strpbrk(long_str, b); }
+SEC("syscall") const char *test_strstr_too_long(void *ctx) { return bpf_strstr(long_str, long_str); }
+SEC("syscall") const char *test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, long_str, sizeof(long_str)); }
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
new file mode 100644
index 000000000000..df8d6599b7e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -0,0 +1,87 @@
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
+__test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e') - str; }
+__test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0') - str; }
+__test(0) u64 test_strchr_notfound(void *ctx) { return (u64)bpf_strchr(str, 'x'); }
+__test(1) int test_strchrnul_found(void *ctx) { return bpf_strchrnul(str, 'e') - str; }
+__test(11) int test_strchrnul_notfound(void *ctx) { return bpf_strchrnul(str, 'x') - str; }
+__test(1) int test_strnchr_found(void *ctx) { return bpf_strnchr(str, 5, 'e') - str; }
+__test(11) int test_strnchr_null(void *ctx) { return bpf_strnchr(str, 12, '\0') - str; }
+__test(0) u64 test_strnchr_notfound(void *ctx) { return (u64)bpf_strnchr(str, 5, 'w'); }
+__test(9) int test_strrchr_found(void *ctx) { return bpf_strrchr(str, 'l') - str; }
+__test(0) u64 test_strrchr_notfound(void *ctx) { return (u64)bpf_strrchr(str, 'x'); }
+__test(11) size_t test_strlen(void *ctx) { return bpf_strlen(str); }
+__test(11) size_t test_strnlen(void *ctx) { return bpf_strnlen(str, 12); }
+__test(5) size_t test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
+__test(2) size_t test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
+__test(2) int test_strpbrk_found(void *ctx) { return bpf_strpbrk(str, "lo") - str; }
+__test(0) u64 test_strpbrk_notfound(void *ctx) { return (u64)bpf_strpbrk(str, "abc"); }
+__test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "world") - str; }
+__test(0) u64 test_strstr_notfound(void *ctx) { return (u64)bpf_strstr(str, "hi"); }
+__test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, "") - str; }
+__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "hello", 6) - str; }
+__test(0) u64 test_strnstr_notfound(void *ctx) { return (u64)bpf_strnstr(str, "hi", 10); }
+__test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, "", 1) - str; }
+
+/* The above functional tests pass a global variable (i.e. a map) to the kfuncs.
+ * Now check that the kfuncs accept strings in other forms:
+ * - string literals (i.e. read-only maps)
+ * - stack-allocated buffers
+ */
+SEC("syscall")
+__success __retval(0)
+int test_string_kfuncs_literal(void *ctx)
+{
+	if (bpf_strcmp("abc", "abc") != 0) return -1;
+	if (bpf_strchr("abc", 'x') != NULL) return -1;
+	if (bpf_strchrnul("abc", 'x') == NULL) return -1;
+	if (bpf_strnchr("abc", 3, 'x') != NULL) return -1;
+	if (bpf_strrchr("abc", 'x') != NULL) return -1;
+	if (bpf_strlen("abc") != 3) return -1;
+	if (bpf_strnlen("abc", 3) != 3) return -1;
+	if (bpf_strspn("abc", "abc") != 3) return -1;
+	if (bpf_strcspn("abc", "abc") != 0) return -1;
+	if (bpf_strpbrk("abc", "def") != NULL) return -1;
+	if (bpf_strstr("abc", "def") != NULL) return -1;
+	if (bpf_strnstr("abc", "def", 3) != NULL) return -1;
+
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int test_string_kfuncs_buffer(void *ctx)
+{
+	char buffer[16];
+
+	__builtin_memset(buffer, 'a', sizeof(buffer));
+	buffer[sizeof(buffer) - 1] = '\0';
+
+	if (bpf_strcmp(buffer, buffer) != 0) return -1;
+	if (bpf_strchr(buffer, 'a') != buffer) return -1;
+	if (bpf_strchrnul(buffer, 'a') != buffer) return -1;
+	if (bpf_strnchr(buffer, sizeof(buffer), 'a') != buffer) return -1;
+	if (bpf_strrchr(buffer, 'b') != NULL) return -1;
+	if (bpf_strlen(buffer) != sizeof(buffer) - 1) return -1;
+	if (bpf_strnlen(buffer, sizeof(buffer)) != sizeof(buffer) - 1) return -1;
+	if (bpf_strspn(buffer, buffer) != sizeof(buffer) - 1) return -1;
+	if (bpf_strcspn(buffer, buffer) != 0) return -1;
+	if (bpf_strpbrk(buffer, buffer) != buffer) return -1;
+	if (bpf_strstr(buffer, buffer) != buffer) return -1;
+	if (bpf_strnstr(buffer, buffer, sizeof(buffer)) != buffer) return -1;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


