Return-Path: <bpf+bounces-28254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2C8B7455
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B8286CFA
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC55F12C805;
	Tue, 30 Apr 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgPCqTOX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275012D215
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476579; cv=none; b=tI5wYBZAP3KS74CwI5o34Am/m5bFwJ6qZ1Q+umgP0z55Q1NyM0CVfrf+3W/ejbNb/E6kmM3Aj275J6iwTwK2PoV2Li1u/i0cIwUsIodyTtLPi26zhhMlARKqtT2b8nWOH+IXCYIUNrbBRsx0H2ZymkLPGleXES862NcsyNapy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476579; c=relaxed/simple;
	bh=8eauQXNMzUAfuDEQQk5IIyWAbZFCA28ZHIN7vjO+R6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBvWJ2iGRoJa9ZVC91q9n70wfHNAogOI3OG/rLbaRcj7kTpWOfvoIGRkm7yCyMGcEp+lX9mNNNdQBoGiy4t4oBmlcvpmGpnFtBsuyYOvJHHaVcZH9W/LdD8dOwbGiL0zMAM7FOsj+og/ZdVxA5jLW/e8An99kqetZUXrjk5MHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgPCqTOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E9C2BBFC;
	Tue, 30 Apr 2024 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714476579;
	bh=8eauQXNMzUAfuDEQQk5IIyWAbZFCA28ZHIN7vjO+R6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgPCqTOXrdSCuZO6eTyMXkguXH3gt45v2kliprrqWyS+iXQpq74IKjGQEr0U4DXPf
	 PbdBmx//e7aIFTEurHqRAsYggJksuykiq0fYz5N+N3aD0JMiCFyqg0skg6Kyi453+f
	 pJfFpMi9vMzakQ4THyB3I9+tdOMHm+nFuyeAjXW3oWorlU/CbVqw9CaRfmFWj25yAb
	 vid3ogVzbLRoONzpXJVmuGzRn9uwGi2mMAFrqZlJNUl6VC/GCDqGhZXUkPMbzSfbeT
	 yv/gYshxXrmCcqDkL9pvd25rsa12hrcJJOcmA1wrH89vveDeJBJReZvikoWq6arXQm
	 4fecT4cjYThbw==
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
Subject: [PATCHv2 bpf-next 6/7] selftests/bpf: Add kprobe session test
Date: Tue, 30 Apr 2024 13:28:29 +0200
Message-ID: <20240430112830.1184228-7-jolsa@kernel.org>
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

Adding kprobe session test and testing that the entry program
return value controls execution of the return probe program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  2 +
 .../bpf/prog_tests/kprobe_multi_test.c        | 39 ++++++++++
 .../bpf/progs/kprobe_multi_session.c          | 78 +++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 14ebe7d9e1a3..180030b5d828 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -75,4 +75,6 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
+
+extern bool bpf_session_is_return(void) __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 51628455b6f5..42d6592f1e7f 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -326,6 +327,42 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
+static void test_session_skel_api(void)
+{
+	struct kprobe_multi_session *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int i, err, prog_fd;
+
+	skel = kprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = kprobe_multi_session__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	/* bpf_fentry_test1-4 trigger return probe, result is 2 */
+	for (i = 0; i < 4; i++)
+		ASSERT_EQ(skel->bss->kprobe_session_result[i], 2, "kprobe_session_result");
+
+	/* bpf_fentry_test5-8 trigger only entry probe, result is 1 */
+	for (i = 4; i < 8; i++)
+		ASSERT_EQ(skel->bss->kprobe_session_result[i], 1, "kprobe_session_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	kprobe_multi_session__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -690,4 +727,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("session"))
+		test_session_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
new file mode 100644
index 000000000000..f70fab1de4bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
@@ -0,0 +1,78 @@
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
+__u64 kprobe_session_result[8];
+
+static const void *kfuncs[8] = {
+	&bpf_fentry_test1,
+	&bpf_fentry_test2,
+	&bpf_fentry_test3,
+	&bpf_fentry_test4,
+	&bpf_fentry_test5,
+	&bpf_fentry_test6,
+	&bpf_fentry_test7,
+	&bpf_fentry_test8,
+};
+
+static int session_check(void *ctx)
+{
+	unsigned int i;
+	__u64 addr;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	addr = bpf_get_func_ip(ctx);
+
+	for (i = 0; i < 8; i++) {
+		if (kfuncs[i] == (void *) addr) {
+			kprobe_session_result[i]++;
+			break;
+		}
+	}
+
+	/*
+	 * Force probes for function bpf_fentry_test[5-8] not to
+	 * install and execute the return probe
+	 */
+	if (((const void *) addr == &bpf_fentry_test5) ||
+	    ((const void *) addr == &bpf_fentry_test6) ||
+	    ((const void *) addr == &bpf_fentry_test7) ||
+	    ((const void *) addr == &bpf_fentry_test8))
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
+SEC("kprobe.session/bpf_fentry_test*")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return session_check(ctx);
+}
-- 
2.44.0


