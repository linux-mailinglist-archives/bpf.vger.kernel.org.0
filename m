Return-Path: <bpf+bounces-27409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF08ACCA1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299571F21324
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7F1474C0;
	Mon, 22 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM8PzZGS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA7145B1D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788042; cv=none; b=B9K/Bw0dGHXsBSKaInW/sKmfpg4McDmDvqAf9ITQnY0DGmXVdJvk5ySw+1VrAuTk3jP/xsD03l17Z+4YhrknRhqB+RWb8FDfJaQ9luUJZjTRwJ93BCBYUcJ/2Jmv6nA/KHDfvSHXSzeYw3tmi1L3y8GvRuMdice7mEU6dtBoDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788042; c=relaxed/simple;
	bh=aCF/rbIbWX9H7HbTbc+vGeKMfNToTxatFJwFewjv3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoWEr2BFlc/AbMqMRpnLGG9TLJhk6xOK9C9ipKvevYF4WPGoj/viVscKvX5Bz7sb6XQPUtqsvBCyVyb7oQepYRfsQG30jA9i49yRw9NCibpA+zFMaB+t/8dkK3ncDwBGQUp5Xjfj5uVYieiByD9aG5fWbry3uidPNcEtrh6tVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM8PzZGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7843C113CC;
	Mon, 22 Apr 2024 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713788042;
	bh=aCF/rbIbWX9H7HbTbc+vGeKMfNToTxatFJwFewjv3aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oM8PzZGSlpOt2Ak3NEw45R21K+SuqLiV9d/SpDTXP/U7uM0SY7H/Nn/2WbrS4onA7
	 H5jqXpCgOEwpqXaPYwIOA4RYwpkZ6CFN4jhowXcR23V3N+LXEJiOZoT0vkgpCWQG17
	 EoSUAWErcz92076euDq2r6ah6OQrJS5sdwoF4Vvn7UJJjzExUWwCkDblijlDMBBiag
	 zb2YZEHViZ1CJIibrvjkm/47NHcGMSCkrjYSZzIa5Kc9Sg/OCCI4s7ahZA8GDzsoSl
	 N4mj4y8XSvQAkdOiYGgXbol3xaURN6PtE1aEZp+h/HT4ITQCzALl3mMFWhNYCvxW7V
	 bSXNzZ/pvapHg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add kprobe multi wrapper cookie test
Date: Mon, 22 Apr 2024 14:12:41 +0200
Message-ID: <20240422121241.1307168-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422121241.1307168-1-jolsa@kernel.org>
References: <20240422121241.1307168-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe multi session test that verifies the cookie
value get properly propagated from entry to return program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  1 +
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   | 56 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 180030b5d828..0281921cd654 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -77,4 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 extern bool bpf_session_is_return(void) __ksym;
+extern __u64 *bpf_session_cookie(void) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index d1f116665551..2896467ca3cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -5,6 +5,7 @@
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
+#include "kprobe_multi_session_cookie.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -373,6 +374,38 @@ static void test_session_skel_api(void)
 	kprobe_multi_session__destroy(skel);
 }
 
+static void test_session_cookie_skel_api(void)
+{
+	struct kprobe_multi_session_cookie *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int err, prog_fd;
+
+	skel = kprobe_multi_session_cookie__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = kprobe_multi_session_cookie__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_wrapper__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test_kprobe_1_result, 1, "test_kprobe_1_result");
+	ASSERT_EQ(skel->bss->test_kprobe_2_result, 2, "test_kprobe_2_result");
+	ASSERT_EQ(skel->bss->test_kprobe_3_result, 3, "test_kprobe_3_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	kprobe_multi_session_cookie__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -739,4 +772,6 @@ void test_kprobe_multi_test(void)
 		test_attach_override();
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_cookie"))
+		test_session_cookie_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
new file mode 100644
index 000000000000..b5c04b7b180c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+__u64 test_kprobe_1_result = 0;
+__u64 test_kprobe_2_result = 0;
+__u64 test_kprobe_3_result = 0;
+
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+	return 0;
+}
+
+static int check_cookie(__u64 val, __u64 *result)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	__u64 *cookie = bpf_session_cookie();
+
+	if (bpf_session_is_return())
+		*result = *cookie == val ? val : 0;
+	else
+		*cookie = val;
+	return 0;
+}
+
+SEC("kprobe.session/bpf_fentry_test1")
+int test_kprobe_1(struct pt_regs *ctx)
+{
+	return check_cookie(1, &test_kprobe_1_result);
+}
+
+SEC("kprobe.session/bpf_fentry_test1")
+int test_kprobe_2(struct pt_regs *ctx)
+{
+	return check_cookie(2, &test_kprobe_2_result);
+}
+
+SEC("kprobe.session/bpf_fentry_test1")
+int test_kprobe_3(struct pt_regs *ctx)
+{
+	return check_cookie(3, &test_kprobe_3_result);
+}
-- 
2.44.0


