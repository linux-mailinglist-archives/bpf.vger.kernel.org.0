Return-Path: <bpf+bounces-28255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07918B745C
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1146B21168
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD8A12D76B;
	Tue, 30 Apr 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI8kX7ex"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61A12C805
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476589; cv=none; b=AnxFmJ9JIZYMO8L4CoBu+ORsaFrngJWou48wQD783+EQvwNmVBPDL8d8j9Id5GqlAMIgQjCnfZeX1fmwcQO2KKvBX/bbavx4C2VoupUVUqxie3PuCSGiHRr957NVb7Rwvnipxfjm15PzWYslWTITyXrRMo+XSGd0xlIZSpcPvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476589; c=relaxed/simple;
	bh=R9dSfGej9VGbAUw5Yt9Ip+SRzxeWnE0a3pku/nwTJL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyN4hL0eA+LLYMZQwa/GZy0V/j18oE/lbjeiUlovoV18o3nY0ie6EP5Mqr1Sx4hlE22FRw+uBvVtmrfIe/qFz7XRJwBRzY2C7aaLLV09zqbCA8oTINBoT4AG78/zbGjgzZS5xMeDSK7Ad7/LKOvSYdH1B/G3JM/F1jXx6ycu/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI8kX7ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653CEC4AF19;
	Tue, 30 Apr 2024 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476589;
	bh=R9dSfGej9VGbAUw5Yt9Ip+SRzxeWnE0a3pku/nwTJL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bI8kX7ex02KcdvP6ZSTc136BpFb8RG+XnDAbMI033LLfcYMmN2lMl8aIvI0KT4hcK
	 dADCBEcSQeieDX2tZK/8rHSC40vcQQkSStMajU6Ds+fLaTGjFco/fd1/um2GZBNv9I
	 pRmH2QMHA5UUO5UYr9CsdWNW2TvnloOJ4dVAWNJ8K/5cEIZau9NsBpwt/AdxgrLnMm
	 Zz8EXu/NswlpV51zQbxnB1QKQ7T9oV7EiOchkZhokBRkman0CcLl+egG+PkEW2ZRKL
	 5vviugcd6swxXDq7Z5+rtOWimGf6n+EEuie/yFMSQ5EVxV9rOT/w/hTt38hqo60C/2
	 idXbmJp5UUq9Q==
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
Subject: [PATCHv2 bpf-next 7/7] selftests/bpf: Add kprobe session cookie test
Date: Tue, 30 Apr 2024 13:28:30 +0200
Message-ID: <20240430112830.1184228-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430112830.1184228-1-jolsa@kernel.org>
References: <20240430112830.1184228-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe session test that verifies the cookie value
get properly propagated from entry to return program.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  1 +
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 +++++++++++
 .../bpf/progs/kprobe_multi_session_cookie.c   | 58 +++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 180030b5d828..0b7ca4ff8d6d 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -77,4 +77,5 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
 extern bool bpf_session_is_return(void) __ksym;
+extern long *bpf_session_cookie(void) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 42d6592f1e7f..960c9323d1e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -5,6 +5,7 @@
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
+#include "kprobe_multi_session_cookie.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -363,6 +364,38 @@ static void test_session_skel_api(void)
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
+		return;
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
@@ -729,4 +762,6 @@ void test_kprobe_multi_test(void)
 		test_attach_override();
 	if (test__start_subtest("session"))
 		test_session_skel_api();
+	if (test__start_subtest("session_cookie"))
+		test_session_cookie_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
new file mode 100644
index 000000000000..d49070803e22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -0,0 +1,58 @@
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
+	long *cookie;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	cookie = bpf_session_cookie();
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


