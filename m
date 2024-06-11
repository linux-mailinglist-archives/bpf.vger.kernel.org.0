Return-Path: <bpf+bounces-31813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8589039E0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1821C232DC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58317B432;
	Tue, 11 Jun 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6PPmhS0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F617B406;
	Tue, 11 Jun 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104975; cv=none; b=RydroMzldWIiLkikdjdhE7Eif66Ta/czf7zfMkfn5LSQFaR2kZc8h+JZgg+DQqwBSC/FKBQUNSypGNQBnRKgPnoSmoJdm5X6kUBt8TCgKMEqeV6oG69Gjox8/7ZnC8uCL0RCMZL4gNW/zeNwEUF8T1OjwHw2MwKgHpHrfuwGW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104975; c=relaxed/simple;
	bh=uOz/aMSFQPquNtZuA2x4QffKF4wgRighKr2eGEBffRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad1Q2GrtOAj+oUElJUxmS8RRp78TNnXhxWhSmypO0t/nvl+z8iXst8gnFILhEucxjzGSejAvH43lkvXaGgmT5MlfykOLRW8KGbJSLFRHUBJsK2KT5hI9g5wGoX+KOpiy/CqLig79HoeFaBznrDIUlRDOSfbDtyNUlTNcJQzoxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6PPmhS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32E6C2BD10;
	Tue, 11 Jun 2024 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718104975;
	bh=uOz/aMSFQPquNtZuA2x4QffKF4wgRighKr2eGEBffRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6PPmhS0yMaw7TLJPy9/H9OLmF9VRJXlwCsSO7AS4NCWNlsWUHqqX+g/LWbOAwxuo
	 spgegUBvy270a4/PpV2jDFb/n0thCGeuRos8dTBpScXqQs6Gz30aT8ze7fuQSe0JtD
	 jf99lYJDf4+LzDQRmZzAY5/J5wg7nsgz3dciYCSWE+BUTe2A5X0btuEyotNfdJxzzw
	 YhUe9hoiGDB5yV1z9SzQFD6xQHT4ug6lAqhUlwYcKYk5L6XaQHHPgynGH8EJzX+j+Q
	 OFGcWuByCNCyO3rkgvLbnzbGFUgAg912Z0Y51ZsmqbSyEQVmBGODJqj7+DQPxrgYTo
	 64msYDsQiioiQ==
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
Subject: [PATCHv8 bpf-next 4/9] selftests/x86: Add return uprobe shadow stack test
Date: Tue, 11 Jun 2024 13:21:53 +0200
Message-ID: <20240611112158.40795-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611112158.40795-1-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding return uprobe test for shadow stack and making sure it's
working properly. Borrowed some of the code from bpf selftests.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/x86/test_shadow_stack.c | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index ee909a7927f9..21af54d5f4ea 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -34,6 +34,7 @@
 #include <sys/ptrace.h>
 #include <sys/signal.h>
 #include <linux/elf.h>
+#include <linux/perf_event.h>
 
 /*
  * Define the ABI defines if needed, so people can run the tests
@@ -734,6 +735,144 @@ int test_32bit(void)
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
@@ -926,6 +1065,12 @@ int main(int argc, char *argv[])
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


