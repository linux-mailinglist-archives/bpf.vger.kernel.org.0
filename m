Return-Path: <bpf+bounces-27342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D18AC110
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E6128121C
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC94205B;
	Sun, 21 Apr 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us4WsazY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323F28DDF;
	Sun, 21 Apr 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728608; cv=none; b=jBhC0W3NHT02glj1wTeZbuZIOuYbMZMLjchX3K46zppHkYnvrtJqFY1vmbmaOjjmlG9yqmSCJqW5G2c+DQLKfCmXc5RYhwa2ygit+DjvcjIAN0v3zOsjtTr4F48lHioo5w2pikvMwWx0lQ+w5A0zh5whymmYrMscCSc+RIBiyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728608; c=relaxed/simple;
	bh=i+DcjfVrFPHPURtr8mJSVqRQ94gO73L1dZ+DRtr/A1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVG54EJEOp4iarQPYDwr8ufPPhEgwhVzADm8+ph+fk6STpg0PKK3OzRzd3VZxv+KAz+qj4SpNNcT9tDBjd81gjD5iARszIGB8eBLuvmCU6frco1HlYNNIGxDZcnwP7QSpVXplir5H9GS+Vio00TIUfmbVNi+CTnHIrKePnRu7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us4WsazY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF77DC113CE;
	Sun, 21 Apr 2024 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728608;
	bh=i+DcjfVrFPHPURtr8mJSVqRQ94gO73L1dZ+DRtr/A1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=us4WsazYeVxuGWocOd7OfDa3SYP1x8dqhruEHiS3dz1eWzZ64gboBxmtTvMsilbrd
	 3aGFVczTQuPymqRt7uCx8AfXi/heFF5gmptNuMDdDZP6PHYfaDuqrvqgkZwo3oGOlV
	 IDtIBeAMxulwFhz3IIY8iyYXxfe2nnyT6UmX8mHUDABZnXx88FkKMctyAu/SphulAv
	 /i7LofItKZMj+Ed9Fx+GBm2ZEYFqTmtZ95oTOjAXewcQldQSOrT6LUNALHt9aRB6/k
	 3bCjG0OFSeStk/WCac+efitYPXK+iw6VzrPcHSxzvpi/PyqQOkyA7qCGYFPa/ZRfpj
	 LbjlSRIc3sw+g==
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
Subject: [PATCHv3 bpf-next 6/7] selftests/bpf: Add uretprobe compat test
Date: Sun, 21 Apr 2024 21:42:05 +0200
Message-ID: <20240421194206.1010934-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194206.1010934-1-jolsa@kernel.org>
References: <20240421194206.1010934-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that adds return uprobe inside 32 bit task
and verify the return uprobe and attached bpf programs
get properly executed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          |  6 ++-
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 40 +++++++++++++++++++
 .../bpf/progs/uprobe_syscall_compat.c         | 13 ++++++
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c

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
index edc73f8f5aef..d170b63eca62 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -134,7 +134,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
 	xdp_features bpf_test_no_cfi.ko
 
-TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
+TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi uprobe_compat
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
@@ -761,6 +761,10 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
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
index 9233210a4c33..3770254d893b 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -11,6 +11,7 @@
 #include <sys/wait.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_call.skel.h"
+#include "uprobe_syscall_compat.skel.h"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -291,6 +292,35 @@ static void test_uretprobe_syscall_call(void)
 		 "read_trace_pipe_iter");
 	ASSERT_EQ(found, 0, "found");
 }
+
+static void trace_pipe_compat_cb(const char *str, void *data)
+{
+	if (strstr(str, "uretprobe compat") != NULL)
+		(*(int *)data)++;
+}
+
+static void test_uretprobe_compat(void)
+{
+	struct uprobe_syscall_compat *skel = NULL;
+	int err, found = 0;
+
+	skel = uprobe_syscall_compat__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_compat__open_and_load"))
+		goto cleanup;
+
+	err = uprobe_syscall_compat__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_syscall_compat__attach"))
+		goto cleanup;
+
+	system("./uprobe_compat");
+
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_compat_cb, &found, 1000),
+		 "read_trace_pipe_iter");
+	ASSERT_EQ(found, 1, "found");
+
+cleanup:
+	uprobe_syscall_compat__destroy(skel);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -306,6 +336,11 @@ static void test_uretprobe_syscall_call(void)
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
@@ -320,3 +355,8 @@ void serial_test_uprobe_syscall_call(void)
 {
 	test_uretprobe_syscall_call();
 }
+
+void serial_test_uprobe_syscall_compat(void)
+{
+	test_uretprobe_compat();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
new file mode 100644
index 000000000000..f8adde7f08e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_compat.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("uretprobe.multi/./uprobe_compat:main")
+int uretprobe_compat(struct pt_regs *ctx)
+{
+	bpf_printk("uretprobe compat\n");
+	return 0;
+}
-- 
2.44.0


