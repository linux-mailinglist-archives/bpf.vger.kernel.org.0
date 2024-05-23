Return-Path: <bpf+bounces-30392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1C8CD1EC
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8DC1C203BD
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083214883D;
	Thu, 23 May 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1xeK4y9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3778C8B;
	Thu, 23 May 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466366; cv=none; b=CsTfami6G/YNOCqBlTzkVQHYeJIlqiYUtJ6Mx2fDNG9PnFrlE0jUDMXE1mghVtMNp+Wb2W9JdlPmi+mmJ84WFcWSV3SmBhae7CGdJSb/3ySHLECs+Xoxo4AUFP7KH6CXX4YOU3FnFDWm35t9pPW3tSIJ7xGK4U7YeMZndTpR5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466366; c=relaxed/simple;
	bh=H7m0sHQPtyf1voojk8tll6CO+KmjIGNVI3OSqf3KuMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOf/OTjmkILMDzsk9WLvgza/IxV6Zoyy2CDz4RHY3aVCcAxzlc+aANEhBmIO+SXNSEV+QoIMnK/oE7X9PEEyaHV8dqq2GNYxkO+m8UMK6VKdsJuexNLtfFo7eUsiRZM5hw6CEY0zreLJ3WIlXBNPdeCKMiP2+k53jyOmPpiZ7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1xeK4y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA04C3277B;
	Thu, 23 May 2024 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716466365;
	bh=H7m0sHQPtyf1voojk8tll6CO+KmjIGNVI3OSqf3KuMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1xeK4y9enoIkkkcx0IM3G13R7grhVOyon7oHBPYnKdRDWHVVkn9SeUg7XD6yDWpV
	 nVEnKsvTe+8heAk2wJHdyIfHA//3D7PTnKc1VKYbojVc22+j5mFb0xb1PH7yMyaTy9
	 D6RUbfTWrXsvPaG9Tl4ie8OE7RXzNNysEBeeJB3TM108RJAy2hS7/Advdq6eqebixc
	 sOXF4yjpFdHB1oE+9zl4Q/a9I0Qwsw0sXNPjvWd+7pETNfwxXHa5wwHxJMzKLQ1ufy
	 1cXcNZfkrizxi4yxJOK82jYKNNigG6Mi9BSjUM3CQvieije5wClBEyK5r5HKV6rRGj
	 Gc5n2a8UO41RQ==
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
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv7 bpf-next 4/9] selftests/x86: Add return uprobe shadow stack test
Date: Thu, 23 May 2024 14:11:44 +0200
Message-ID: <20240523121149.575616-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523121149.575616-1-jolsa@kernel.org>
References: <20240523121149.575616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding return uprobe test for shadow stack and making sure it's
working properly. Borrowed some of the code from bpf selftests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/x86/test_shadow_stack.c | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 757e6527f67e..e3501b7e2ecc 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -34,6 +34,7 @@
 #include <sys/ptrace.h>
 #include <sys/signal.h>
 #include <linux/elf.h>
+#include <linux/perf_event.h>
 
 /*
  * Define the ABI defines if needed, so people can run the tests
@@ -681,6 +682,144 @@ int test_32bit(void)
 	return !segv_triggered;
 }
 
+static int parse_uint_from_file(const char *file, const char *fmt)
+{
+	int err, ret;
+	FILE *f;
+
+	f = fopen(file, "re");
+	if (!f) {
+		err = -errno;
+		printf("failed to open '%s': %d\n", file, err);
+		return err;
+	}
+	err = fscanf(f, fmt, &ret);
+	if (err != 1) {
+		err = err == EOF ? -EIO : -errno;
+		printf("failed to parse '%s': %d\n", file, err);
+		fclose(f);
+		return err;
+	}
+	fclose(f);
+	return ret;
+}
+
+static int determine_uprobe_perf_type(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/type";
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int determine_uprobe_retprobe_bit(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
+
+	return parse_uint_from_file(file, "config:%d\n");
+}
+
+static ssize_t get_uprobe_offset(const void *addr)
+{
+	size_t start, end, base;
+	char buf[256];
+	bool found = false;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(f);
+
+	if (!found)
+		return -ESRCH;
+
+	return (uintptr_t)addr - start + base;
+}
+
+static __attribute__((noinline)) void uretprobe_trigger(void)
+{
+	asm volatile ("");
+}
+
+/*
+ * This test setups return uprobe, which is sensitive to shadow stack
+ * (crashes without extra fix). After executing the uretprobe we fail
+ * the test if we receive SIGSEGV, no crash means we're good.
+ *
+ * Helper functions above borrowed from bpf selftests.
+ */
+static int test_uretprobe(void)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	const char *file = "/proc/self/exe";
+	int bit, fd = 0, type, err = 1;
+	struct perf_event_attr attr;
+	struct sigaction sa = {};
+	ssize_t offset;
+
+	type = determine_uprobe_perf_type();
+	if (type < 0) {
+		if (type == -ENOENT)
+			printf("[SKIP]\tUretprobe test, uprobes are not available\n");
+		return 0;
+	}
+
+	offset = get_uprobe_offset(uretprobe_trigger);
+	if (offset < 0)
+		return 1;
+
+	bit = determine_uprobe_retprobe_bit();
+	if (bit < 0)
+		return 1;
+
+	sa.sa_sigaction = segv_gp_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	/* Setup return uprobe through perf event interface. */
+	memset(&attr, 0, attr_sz);
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config = 1 << bit;
+	attr.config1 = (__u64) (unsigned long) file;
+	attr.config2 = offset;
+
+	fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, -1 /* cpu */,
+		     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0)
+		goto out;
+
+	if (sigsetjmp(jmp_buffer, 1))
+		goto out;
+
+	ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+
+	/*
+	 * This either segfaults and goes through sigsetjmp above
+	 * or succeeds and we're good.
+	 */
+	uretprobe_trigger();
+
+	printf("[OK]\tUretprobe test\n");
+	err = 0;
+
+out:
+	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+	signal(SIGSEGV, SIG_DFL);
+	if (fd)
+		close(fd);
+	return err;
+}
+
 void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
 {
 	/* The SSP adjustment caused a segfault. */
@@ -867,6 +1006,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (test_uretprobe()) {
+		ret = 1;
+		printf("[FAIL]\turetprobe test\n");
+		goto out;
+	}
+
 	return ret;
 
 out:
-- 
2.45.1


