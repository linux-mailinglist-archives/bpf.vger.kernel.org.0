Return-Path: <bpf+bounces-27408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F27D8ACCA0
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE18FB239B1
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D91474B6;
	Mon, 22 Apr 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiztnV7Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C714658C
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788032; cv=none; b=UwChCfq5wSJfeV00WKD3Bgc2cpkb9gPaDWqrorgXUPrTgkjQ05ytm2iWz64CAOeuskjoN+ng+heOCeIFgPjMhwVucJ1ROUV6UAQF17bOvCGrrlPYfN/s1uFw0g5h7mS5FknnXQQaNaqDkPYySv4z7Ou8YADKfdhnjKBXyi/WA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788032; c=relaxed/simple;
	bh=tTR3ZqYz0iP4M6HNFJ3bCpicp88dGya+RlicIZpd3a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0TQON78DlRpAa3pOO5mzQcR5AyyxnS67FWhbR+2sx1s6dl/oq9/kusQ6JEkeV+9IAFb1BGhT2SItW8dXfxEnVIXRxC0r/2KhgiPp1WsQXtZgCZtrawhL3llW3H57nB22mQd0S/3FVK3BAyFOnXBIO+tEXYhdYiwHLhZINYK1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiztnV7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF729C113CC;
	Mon, 22 Apr 2024 12:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713788031;
	bh=tTR3ZqYz0iP4M6HNFJ3bCpicp88dGya+RlicIZpd3a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiztnV7ZP6irkRuubhqfI0+wdHMMzXvZXEldnTuRYgy3tpCfD/RmQVjrecI/HroSh
	 a1QZ9iRRXHvJfW6qsBmNi5fvKhsdAZQeLdyYkmW+2Hxe/pCZ07Rh60G/kbwS79T4F7
	 No3RlD/6IIDymDSQtLt937XDK/Ncb6k7s4al+0CLMUVZhWgxC2GkIlOCLcduoHo0lf
	 84bdEje431Db7/OyIYIgcTphOxDXG4iNUPyBlv5r5EHQFrUs6QBRbV66WeRSgKIhaB
	 dXzmZaUGjOx+q6/dSSSMDjnY7nBGUs0q2trXEG8JWUuNTah1txvcIo84STqERvg1v9
	 1UAr1qAyCXlmg==
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
Subject: [PATCH bpf-next 6/7] selftests/bpf: Add kprobe multi session test
Date: Mon, 22 Apr 2024 14:12:40 +0200
Message-ID: <20240422121241.1307168-7-jolsa@kernel.org>
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

Adding kprobe multi session test and testing that the entry program
return value controls execution of the return probe program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   2 +
 .../bpf/prog_tests/kprobe_multi_test.c        |  49 +++++++++
 .../bpf/progs/kprobe_multi_session.c          | 100 ++++++++++++++++++
 3 files changed, 151 insertions(+)
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
index 51628455b6f5..d1f116665551 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -4,6 +4,7 @@
 #include "trace_helpers.h"
 #include "kprobe_multi_empty.skel.h"
 #include "kprobe_multi_override.skel.h"
+#include "kprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -326,6 +327,52 @@ static void test_attach_api_fails(void)
 	kprobe_multi__destroy(skel);
 }
 
+static void test_session_skel_api(void)
+{
+	struct kprobe_multi_session *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link = NULL;
+	int err, prog_fd;
+
+	skel = kprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err =  kprobe_multi_session__attach(skel);
+	if (!ASSERT_OK(err, " kprobe_multi_session__attach"))
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
+	kprobe_multi_session__destroy(skel);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
@@ -690,4 +737,6 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("session"))
+		test_session_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
new file mode 100644
index 000000000000..9fb87f7f69da
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
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
+static int session_check(void *ctx, bool is_return)
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
+SEC("kprobe.session/bpf_fentry_test*")
+int test_kprobe(struct pt_regs *ctx)
+{
+	return session_check(ctx, bpf_session_is_return());
+}
-- 
2.44.0


