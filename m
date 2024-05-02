Return-Path: <bpf+bounces-28438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049358B9ACF
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D0C1C209DA
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626983CC3;
	Thu,  2 May 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbXXD2nd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE847E572;
	Thu,  2 May 2024 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652675; cv=none; b=f/ac9ZNawswJ6aCeWYqr62LZgGDH3WQd/019rLESutNPlAS5my2P6MNTRWmx8e5FKSqfCjwMQ016FzHRRKy6yp5LkvkFUprMFhRwiwIz6P7MMSCQ/Hrrwz3xFf+RNLtCs9b8UaPZHErB4yAD4QCVc1+2yOkbdeHxvtN73gQRxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652675; c=relaxed/simple;
	bh=mWPTncrHfcSbvk7ZrPHsoF82D8w6WmakvxUwocjd27M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePJcvcNf76cuHFZjtgsqCKi9BwLxPp0UYpztJ/2erL3XTR4pzpxZSAkc5/DGmuQDSEbDCIttgCt0YlTbbpUUmDPAeRkeT52k8ADUTuNufxoKm/hrU0IFMXhqcroMMffDhvU6dw46TizHsimTkVu1T90w7xEGa3aiLExuTgYeeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbXXD2nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39765C113CC;
	Thu,  2 May 2024 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714652674;
	bh=mWPTncrHfcSbvk7ZrPHsoF82D8w6WmakvxUwocjd27M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbXXD2ndjyF0VwzzJ33+q4aW9IuxGR3i4LXarga1ddjMHZMdyE9xEHaaeJlc5fq/C
	 Hyls2SCrN7ksHsKoUr5HiS6+3a+xOFZijobc1/mfRrQ7G+AvJPBaE8FsPNOJQuDQ+m
	 lcxItl84dO6Vb21H5ON4ykueoD4d50b+xiM+CQ43sHM8OJqy2CgJGBOYJjMRGLubfm
	 p1NJSwuD0nBJD2OptcgOTnj0UEJi3hy46Qxx1TXt1mHaHJqTdpE28zbiLo7G5UZfhF
	 DEllKFNsvCQNEKnyiuJW02605jxMCtZckBPHiHUXOwhKiS8qxp/gn6jv9YE+HYuW1i
	 UnPn2N7xajkUQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCHv4 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
Date: Thu,  2 May 2024 14:23:12 +0200
Message-ID: <20240502122313.1579719-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502122313.1579719-1-jolsa@kernel.org>
References: <20240502122313.1579719-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that adds return uprobe inside 32-bit task
and verify the return uprobe and attached bpf programs
get properly executed.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          |  7 ++-
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 60 +++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index f1aebabfb017..69d71223c0dd 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -45,6 +45,7 @@ test_cpp
 /veristat
 /sign-file
 /uprobe_multi
+/uprobe_compat
 *.ko
 *.tmp
 xskxceiver
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 82247aeef857..a94352162290 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -133,7 +133,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features bpf_test_no_cfi.ko
 
-TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi uprobe_compat
 
 ifneq ($(V),1)
 submake_extras := feature_display=0
@@ -631,6 +631,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(OUTPUT)/uprobe_compat				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
@@ -752,6 +753,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
 
+$(OUTPUT)/uprobe_compat:
+	$(call msg,BINARY,,$@)
+	$(Q)echo "int main() { return 0; }" | $(CC) $(CFLAGS) -xc -m32 -O0 - -o $@
+
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c6fdb8c59ea3..bfea9a0368a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -5,6 +5,7 @@
 #ifdef __x86_64__
 
 #include <unistd.h>
+#include <stdlib.h>
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
 #include <linux/stringify.h>
@@ -297,6 +298,58 @@ static void test_uretprobe_syscall_call(void)
 	close(go[1]);
 	close(go[0]);
 }
+
+static void test_uretprobe_compat(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.retprobe = true,
+	);
+	struct uprobe_syscall_executed *skel;
+	int err, go[2], pid, c, status;
+
+	if (pipe(go))
+		return;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		goto cleanup;
+
+	pid = fork();
+	if (pid < 0)
+		goto cleanup;
+
+	/* child */
+	if (pid == 0) {
+		close(go[1]);
+
+		/* wait for parent's kick */
+		err = read(go[0], &c, 1);
+		if (err != 1)
+			exit(-1);
+		execl("./uprobe_compat", "./uprobe_compat", NULL);
+		exit(-1);
+	}
+
+	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
+							    "./uprobe_compat", "main", &opts);
+	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	/* kick the child */
+	write(go[1], &c, 1);
+	err = waitpid(pid, &status, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+
+	/* verify the child exited normally and the bpf program got executed */
+	ASSERT_EQ(WIFEXITED(status), 1, "WIFEXITED");
+	ASSERT_EQ(WEXITSTATUS(status), 0, "WEXITSTATUS");
+	ASSERT_EQ(skel->bss->executed, 1, "executed");
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+	close(go[0]);
+	close(go[1]);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -312,6 +365,11 @@ static void test_uretprobe_syscall_call(void)
 {
 	test__skip();
 }
+
+static void test_uretprobe_compat(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -322,4 +380,6 @@ void test_uprobe_syscall(void)
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
+	if (test__start_subtest("uretprobe_compat"))
+		test_uretprobe_compat();
 }
-- 
2.44.0


