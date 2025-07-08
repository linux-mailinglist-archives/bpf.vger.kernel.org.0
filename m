Return-Path: <bpf+bounces-62680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BFAFCC2E
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D916C742
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F02E0926;
	Tue,  8 Jul 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Qm44c1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054F2E06C9;
	Tue,  8 Jul 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981271; cv=none; b=o7NNn9FBASwEyDPKlDaNmZcDjxDIducY6cElghRDE7rfJCqwSxZDf955kb6V62GMjFIM9VqaUWurJq8xZIdho3NMNSwrCcoQqL9su4sVg/fdJEDUgS85/LGrFNIpP900+45C+AHA9nDfUfa0l2BP+dIBy1lyqa/8G/SmHuHNHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981271; c=relaxed/simple;
	bh=rs73C+tXGQjT/hoikQN1a2Z42vbX5pkx8Vuf5YemA9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn9K0s10tEb/5W0j9Seve/NYtPjDGs8bN+2Da+hWVNyQUKLmoKGzuCXjj+6oNywcFevR/ZP6mWeYV5TtTD1wbE7AfGpzK+1Lzw6uJT8d0LyZ7ehfB9JoFfXJFL/5hJRb04BuSXnkCKlmbtsm7VrYVPaAie7LfM1aKj5BonaIVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Qm44c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF9BC4CEED;
	Tue,  8 Jul 2025 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981271;
	bh=rs73C+tXGQjT/hoikQN1a2Z42vbX5pkx8Vuf5YemA9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8Qm44c19fdL2b4XCn44wYvaa90gWLXYfqkeifnf2uBKXsZYwteClV4c5GfwaaOof
	 IMukUmGpu8tvXBPEsWSU4ZQboUUg7vcUKbKYDv9D7IORnH3jtDQkx0k+CugPf7BS3p
	 vFi0kuuCG4BB9GYYxjBseziZnTOMn4pI7/TOgLCd0hxLtpJsjLIBsacaGuoVlhyQP+
	 HJEGXYKAm2K76qR/X2yMtK4DXSHrgs5yUBV52MCt1VXAJ8hvGHsqTW5lL6YOvr8T2e
	 WOd+mWUR84DSuN0TVT7613ASqzVnzvwRgM+eVHRMe+gi3S65raqHGaaDzfqlox4dm5
	 oaDN3w1pm6ZJw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Kees Cook <kees@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv4 perf/core 21/22] selftests/seccomp: validate uprobe syscall passes through seccomp
Date: Tue,  8 Jul 2025 15:23:30 +0200
Message-ID: <20250708132333.2739553-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe checks into the current uretprobe tests.

All the related tests are now executed with attached uprobe
or uretprobe or without any probe.

Renaming the test fixture to uprobe, because it seems better.

Cc: Kees Cook <keescook@chromium.org>
Cc: Eyal Birger <eyal.birger@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 107 ++++++++++++++----
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..2cf6fc825d86 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -73,6 +73,14 @@
 #define noinline __attribute__((noinline))
 #endif
 
+#ifndef __nocf_check
+#define __nocf_check __attribute__((nocf_check))
+#endif
+
+#ifndef __naked
+#define __naked __attribute__((__naked__))
+#endif
+
 #ifndef PR_SET_NO_NEW_PRIVS
 #define PR_SET_NO_NEW_PRIVS 38
 #define PR_GET_NO_NEW_PRIVS 39
@@ -4896,7 +4904,36 @@ TEST(tsync_vs_dead_thread_leader)
 	EXPECT_EQ(0, status);
 }
 
-noinline int probed(void)
+#ifdef __x86_64__
+
+/*
+ * We need naked probed_uprobe function. Using __nocf_check
+ * check to skip possible endbr64 instruction and ignoring
+ * -Wattributes, otherwise the compilation might fail.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wattributes"
+
+__naked __nocf_check noinline int probed_uprobe(void)
+{
+	/*
+	 * Optimized uprobe is possible only on top of nop5 instruction.
+	 */
+	asm volatile ("                                 \n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00     \n"
+		"ret                                    \n"
+	);
+}
+#pragma GCC diagnostic pop
+
+#else
+noinline int probed_uprobe(void)
+{
+	return 1;
+}
+#endif
+
+noinline int probed_uretprobe(void)
 {
 	return 1;
 }
@@ -4949,35 +4986,46 @@ static ssize_t get_uprobe_offset(const void *addr)
 	return found ? (uintptr_t)addr - start + base : -1;
 }
 
-FIXTURE(URETPROBE) {
+FIXTURE(UPROBE) {
 	int fd;
 };
 
-FIXTURE_VARIANT(URETPROBE) {
+FIXTURE_VARIANT(UPROBE) {
 	/*
-	 * All of the URETPROBE behaviors can be tested with either
-	 * uretprobe attached or not
+	 * All of the U(RET)PROBE behaviors can be tested with either
+	 * u(ret)probe attached or not
 	 */
 	bool attach;
+	/*
+	 * Test both uprobe and uretprobe.
+	 */
+	bool uretprobe;
 };
 
-FIXTURE_VARIANT_ADD(URETPROBE, attached) {
+FIXTURE_VARIANT_ADD(UPROBE, not_attached) {
+	.attach = false,
+	.uretprobe = false,
+};
+
+FIXTURE_VARIANT_ADD(UPROBE, uprobe_attached) {
 	.attach = true,
+	.uretprobe = false,
 };
 
-FIXTURE_VARIANT_ADD(URETPROBE, not_attached) {
-	.attach = false,
+FIXTURE_VARIANT_ADD(UPROBE, uretprobe_attached) {
+	.attach = true,
+	.uretprobe = true,
 };
 
-FIXTURE_SETUP(URETPROBE)
+FIXTURE_SETUP(UPROBE)
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
 	ssize_t offset;
 	int type, bit;
 
-#ifndef __NR_uretprobe
-	SKIP(return, "__NR_uretprobe syscall not defined");
+#if !defined(__NR_uprobe) || !defined(__NR_uretprobe)
+	SKIP(return, "__NR_uprobe ot __NR_uretprobe syscalls not defined");
 #endif
 
 	if (!variant->attach)
@@ -4987,12 +5035,17 @@ FIXTURE_SETUP(URETPROBE)
 
 	type = determine_uprobe_perf_type();
 	ASSERT_GE(type, 0);
-	bit = determine_uprobe_retprobe_bit();
-	ASSERT_GE(bit, 0);
-	offset = get_uprobe_offset(probed);
+
+	if (variant->uretprobe) {
+		bit = determine_uprobe_retprobe_bit();
+		ASSERT_GE(bit, 0);
+	}
+
+	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
 	ASSERT_GE(offset, 0);
 
-	attr.config |= 1 << bit;
+	if (variant->uretprobe)
+		attr.config |= 1 << bit;
 	attr.size = attr_sz;
 	attr.type = type;
 	attr.config1 = ptr_to_u64("/proc/self/exe");
@@ -5003,7 +5056,7 @@ FIXTURE_SETUP(URETPROBE)
 			   PERF_FLAG_FD_CLOEXEC);
 }
 
-FIXTURE_TEARDOWN(URETPROBE)
+FIXTURE_TEARDOWN(UPROBE)
 {
 	/* we could call close(self->fd), but we'd need extra filter for
 	 * that and since we are calling _exit right away..
@@ -5017,11 +5070,17 @@ static int run_probed_with_filter(struct sock_fprog *prog)
 		return -1;
 	}
 
-	probed();
+	/*
+	 * Uprobe is optimized after first hit, so let's hit twice.
+	 */
+	probed_uprobe();
+	probed_uprobe();
+
+	probed_uretprobe();
 	return 0;
 }
 
-TEST_F(URETPROBE, uretprobe_default_allow)
+TEST_F(UPROBE, uprobe_default_allow)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -5034,7 +5093,7 @@ TEST_F(URETPROBE, uretprobe_default_allow)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
 
-TEST_F(URETPROBE, uretprobe_default_block)
+TEST_F(UPROBE, uprobe_default_block)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -5051,11 +5110,14 @@ TEST_F(URETPROBE, uretprobe_default_block)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
 
-TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
+TEST_F(UPROBE, uprobe_block_syscall)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uprobe, 1, 2),
+#endif
 #ifdef __NR_uretprobe
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
 #endif
@@ -5070,11 +5132,14 @@ TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
 
-TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
+TEST_F(UPROBE, uprobe_default_block_with_syscall)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uprobe, 3, 0),
+#endif
 #ifdef __NR_uretprobe
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 2, 0),
 #endif
-- 
2.50.0


