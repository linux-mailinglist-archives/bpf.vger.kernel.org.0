Return-Path: <bpf+bounces-21417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD0D84CE2A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A29C1C209C2
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610D7FBBA;
	Wed,  7 Feb 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPjCw9RP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B25A0F7
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320199; cv=none; b=ZzLTWaw/0pB67OUri5+LKaKSsoJuob+Yrebw5KV5fRoa3vefBhRIqvKUgBtCeH6cyhG1OZ8nZEmgRRKpbATE3OVj9gK/RuXcZsMlMIIRifFkEzwdtTBoQqeHJ5culKIXDKcLbEN6XkVPm2T4NGrLyT1GzQzLzz9QTREWPEwYGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320199; c=relaxed/simple;
	bh=TZ+/eQe4BCWhx+HDEGhFdBZ5LY/Fnivvm7Re18diGT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlsgWjqshgdaNAhQ1HTzZC5W55tocNVGpk/2CGGYyhmOWv4aqUbFwZrOrZaiaLYar1sVBxeNfdmPHUyGEaA/ovQx8M61I2EuZb0didVQ/5b75RFLo1a+THgXLn5pHi4KmI82jradWGd3NqlbVqvpLarclhkiSePkGNBBBoB/wXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPjCw9RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F01C433F1;
	Wed,  7 Feb 2024 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707320198;
	bh=TZ+/eQe4BCWhx+HDEGhFdBZ5LY/Fnivvm7Re18diGT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPjCw9RPAND4S20JwAo/NcZovM8eIYzJBvTH4zuhSfjxwCVd7ZtbmYkWx8XKZL8VU
	 B/d8+2l8lwEKz0bq/psYEFEPQVUHeEZGC6Fq/BoU6zVpPblTJ6bIpPE8BSUzV5RXn/
	 0gTElPTxOUgFSYI0WO1lJerGh3irpjSTeMLpPi0wuL6Dzps73tyWLfLOBMGo3WUZQF
	 2Y3U1iMyPqipc2VyoNBePd5nYBimMFs4hq9PboEsQ4jzhk00e4vPSQeorLw5lk314b
	 PfKWO1cDr/hmH3gnQJz7OaKPXFgg7n+O5n9+EFSZtVD0IfsIdNSpeUepjauyRcZU0Q
	 iCBNno6Bu63Ag==
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
Subject: [PATCH RFC bpf-next 4/4] selftests/bpf: Add kprobe multi return prog test
Date: Wed,  7 Feb 2024 16:35:50 +0100
Message-ID: <20240207153550.856536-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207153550.856536-1-jolsa@kernel.org>
References: <20240207153550.856536-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test for kprobe multi return program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        |  53 +++++++++
 .../bpf/progs/kprobe_multi_return_prog.c      | 105 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 05000810e28e..b6991a6c0b2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_return_prog.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -326,6 +327,56 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
+static void test_attach_return_prog(void)
+{
+	struct kprobe_multi_return_prog *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int err, prog_fd;
+
+	skel = kprobe_multi_return_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test_kretprobe);
+	opts.return_prog = true;
+	opts.return_prog_fd = prog_fd;
+
+	skel->bss->pid = getpid();
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe,
+						     "bpf_fentry_test*", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts2"))
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
+	kprobe_multi_return_prog__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -538,4 +589,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("return_prog"))
+		test_attach_return_prog();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c b/tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c
new file mode 100644
index 000000000000..e4e49ffa110f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_return_prog.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
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
+static int kprobe_multi_check(void *ctx, bool is_return)
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
+SEC("kprobe.multi")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return kprobe_multi_check(ctx, false);
+}
+
+SEC("kretprobe.multi")
+int test_kretprobe(struct pt_regs *ctx)
+{
+	return kprobe_multi_check(ctx, true);
+}
-- 
2.43.0


