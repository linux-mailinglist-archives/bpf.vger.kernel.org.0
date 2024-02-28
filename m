Return-Path: <bpf+bounces-22853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E673586AAD9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE3A2836F5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7C360AE;
	Wed, 28 Feb 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp6NG46A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D332C8C
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111014; cv=none; b=TSkxLM0ZNHwDoa9UZWlOFzvTa4SwfC5TvTeRJtBrwCMh5F1vDka4IJ7rh1iUgv1enA3tuoxsD1vRDS7yismdbTdHqM2Q19NxtAgl3D18qj5IRUWro/3UUK3VOUjJkR3ZfOKFWHpMlWbU6+qfCZ6yAY88jZF5et45yS5YRNtwkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111014; c=relaxed/simple;
	bh=ID56fNu8hPmaxgyvRfZ0c4Y2eVCJiQ6bPBXak+xhKqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTcatxEva6oCKj91bxUeuft+ZfNd0DB1xhVO5MqiptKomMYFSEpCnsdrBWfvLYZQFj8Qb9vMoeZ+U+BG9QlygW7eS3MdcuEAFNsLkTTR2H7IxlkkqREGdG22IX8cI3/OkMQ5ePThM64UExQxs6lnZ/872H7kSGqlPu6C9roLdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp6NG46A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD859C43390;
	Wed, 28 Feb 2024 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709111014;
	bh=ID56fNu8hPmaxgyvRfZ0c4Y2eVCJiQ6bPBXak+xhKqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wp6NG46Ap5GL0oKVLMs1WGUxfcyXZ6GSq7V4Vl3kGWIi5bXAf242JE1D8U0NkO69t
	 m3W++E7UybgLxMCpgxHtpws5xxVaXNNQ0mS2YRj0WYeWoW7K9U/dbcRIlktih3CtTS
	 e6VfUA0kxGzTlwtlHaI+aUlWR+oQjhFbRGmFJV0dhq81eDLXZRQ6emZtyYa76TMKzo
	 mr4E57lGI643yNfVUHZtp1a6uhaXwwLT1X1fe2cgG2gJKtFkqdXHvW49fNcdmkhh/s
	 jBl8jlyYjonlJFQa4yCQloLSj9VQ/eufFBKfPbDpqL3GQWanc8tj+xdiIZbHNxtEgf
	 LSQBZQunjTyCg==
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH RFCv2 bpf-next 4/4] selftests/bpf: Add kprobe multi wrapper test
Date: Wed, 28 Feb 2024 10:02:42 +0100
Message-ID: <20240228090242.4040210-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228090242.4040210-1-jolsa@kernel.org>
References: <20240228090242.4040210-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding kprobe multi wrapper test and also testing the entry program
return value controls execution of the return probe program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   2 +
 .../bpf/prog_tests/kprobe_multi_test.c        |  49 +++++++++
 .../bpf/progs/kprobe_multi_wrapper.c          | 100 ++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 14ebe7d9e1a3..9ad4c64b19e9 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
+
+extern bool bpf_kprobe_multi_is_return(void) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 05000810e28e..1120c43b215c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_wrapper.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -326,6 +327,52 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
+static void test_wrapper_skel_api(void)
+{
+	struct kprobe_multi_wrapper *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int err, prog_fd;
+
+	skel = kprobe_multi_wrapper__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err =  kprobe_multi_wrapper__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_wrapper__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->kprobe_test1_result, 1, "kprobe_test1_result");
+	ASSERT_EQ(skel->bss->kprobe_test2_result, 1, "kprobe_test2_result");
+	ASSERT_EQ(skel->bss->kprobe_test3_result, 1, "kprobe_test3_result");
+	ASSERT_EQ(skel->bss->kprobe_test4_result, 1, "kprobe_test4_result");
+	ASSERT_EQ(skel->bss->kprobe_test5_result, 1, "kprobe_test5_result");
+	ASSERT_EQ(skel->bss->kprobe_test6_result, 1, "kprobe_test6_result");
+	ASSERT_EQ(skel->bss->kprobe_test7_result, 1, "kprobe_test7_result");
+	ASSERT_EQ(skel->bss->kprobe_test8_result, 1, "kprobe_test8_result");
+
+	ASSERT_EQ(skel->bss->kretprobe_test1_result, 0, "kretprobe_test1_result");
+	ASSERT_EQ(skel->bss->kretprobe_test2_result, 1, "kretprobe_test2_result");
+	ASSERT_EQ(skel->bss->kretprobe_test3_result, 0, "kretprobe_test3_result");
+	ASSERT_EQ(skel->bss->kretprobe_test4_result, 1, "kretprobe_test4_result");
+	ASSERT_EQ(skel->bss->kretprobe_test5_result, 0, "kretprobe_test5_result");
+	ASSERT_EQ(skel->bss->kretprobe_test6_result, 1, "kretprobe_test6_result");
+	ASSERT_EQ(skel->bss->kretprobe_test7_result, 0, "kretprobe_test7_result");
+	ASSERT_EQ(skel->bss->kretprobe_test8_result, 1, "kretprobe_test8_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	kprobe_multi_wrapper__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -538,4 +585,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("wrapper"))
+		test_wrapper_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c b/tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c
new file mode 100644
index 000000000000..975492bba8cc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_wrapper.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern const void bpf_fentry_test1 __ksym;
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+
+int pid = 0;
+
+__u64 kprobe_test1_result = 0;
+__u64 kprobe_test2_result = 0;
+__u64 kprobe_test3_result = 0;
+__u64 kprobe_test4_result = 0;
+__u64 kprobe_test5_result = 0;
+__u64 kprobe_test6_result = 0;
+__u64 kprobe_test7_result = 0;
+__u64 kprobe_test8_result = 0;
+
+__u64 kretprobe_test1_result = 0;
+__u64 kretprobe_test2_result = 0;
+__u64 kretprobe_test3_result = 0;
+__u64 kretprobe_test4_result = 0;
+__u64 kretprobe_test5_result = 0;
+__u64 kretprobe_test6_result = 0;
+__u64 kretprobe_test7_result = 0;
+__u64 kretprobe_test8_result = 0;
+
+static int wrapper_check(void *ctx, bool is_return)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	__u64 addr = bpf_get_func_ip(ctx);
+
+#define SET(__var, __addr) ({			\
+	if ((const void *) addr == __addr)	\
+		__var = 1;			\
+})
+
+	if (is_return) {
+		SET(kretprobe_test1_result, &bpf_fentry_test1);
+		SET(kretprobe_test2_result, &bpf_fentry_test2);
+		SET(kretprobe_test3_result, &bpf_fentry_test3);
+		SET(kretprobe_test4_result, &bpf_fentry_test4);
+		SET(kretprobe_test5_result, &bpf_fentry_test5);
+		SET(kretprobe_test6_result, &bpf_fentry_test6);
+		SET(kretprobe_test7_result, &bpf_fentry_test7);
+		SET(kretprobe_test8_result, &bpf_fentry_test8);
+	} else {
+		SET(kprobe_test1_result, &bpf_fentry_test1);
+		SET(kprobe_test2_result, &bpf_fentry_test2);
+		SET(kprobe_test3_result, &bpf_fentry_test3);
+		SET(kprobe_test4_result, &bpf_fentry_test4);
+		SET(kprobe_test5_result, &bpf_fentry_test5);
+		SET(kprobe_test6_result, &bpf_fentry_test6);
+		SET(kprobe_test7_result, &bpf_fentry_test7);
+		SET(kprobe_test8_result, &bpf_fentry_test8);
+	}
+
+#undef SET
+
+	/*
+	 * Force probes for function bpf_fentry_test[1357] not to
+	 * install and execute the return probe
+	 */
+	if (((const void *) addr == &bpf_fentry_test1) ||
+	    ((const void *) addr == &bpf_fentry_test3) ||
+	    ((const void *) addr == &bpf_fentry_test5) ||
+	    ((const void *) addr == &bpf_fentry_test7))
+		return 1;
+
+	return 0;
+}
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
+SEC("kprobe.wrapper/bpf_fentry_test*")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return wrapper_check(ctx, bpf_kprobe_multi_is_return());
+}
-- 
2.43.2


