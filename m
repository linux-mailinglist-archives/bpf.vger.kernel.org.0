Return-Path: <bpf+bounces-56350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6812CA9585E
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DD77A8BBE
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D91921C194;
	Mon, 21 Apr 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+8YgL1w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5819B5B8;
	Mon, 21 Apr 2025 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272126; cv=none; b=N04H3bKTa6eJ9RLMn1EyVkkcYVxNiD8ZhID/ItF07V0ZSWXBGz1OVIUFT1e9aS0mXZTGWD+EchSn1sqLyNRDVwpD/oPj5UIv9F2l6J6YiJUAv0wSP9tnQVEDfgPMkc4Tqbh2eyP9OhV5pa3aJsYKVk2wrXSvl7pu3OKAJTz9gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272126; c=relaxed/simple;
	bh=6wEmQ+HcOSae40FunG4oi3QmQm5OmiTydiftVUH95is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGWQEvNnd5mPECc4QsJv3ymyrN0lEPj+3ZaXv3pNvzBsFwvIRABaFX0h0ixTUmc+2mnE/0yyvClU9At3CUNkwkjljou+9D6NZj1SmRVXHOSxgm9HP16Hx8eU/4hbxs0oCVDh3os/hS03h3QStK4s0uzTJGe8bp6DFdTyASP1QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+8YgL1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B84C4CEE4;
	Mon, 21 Apr 2025 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272125;
	bh=6wEmQ+HcOSae40FunG4oi3QmQm5OmiTydiftVUH95is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+8YgL1wbKcrGjQyBPE79198KuPFLTRLHvyaA6czFdMyP8hrpCiUc8TMTJEp+9IiJ
	 VI3X/IKEq8/uTA4xz23xrFtehdnNZDU98C13oUOlJpFfLbdSe9gT/OKCAQgjJX9P3E
	 zRuljop6ydX8I0YPCZoVk0DlHxO6NgzTHrA3iZFyd23UVfZtq8+O1j8jm52seJjDNo
	 aelS1vKbMYbWsi+gWao9ERCamGxBW09EUK3GlMPCySlYfW7KCuIRJhigAPt7U847g3
	 G06/ZYPP2v6tp2nuH6KWoDqoc6ccs9X43uxDDzid+v5mScz5oH4iQB1f/5Thcl/K5/
	 Xa/TCCowZ6m7Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Eyal Birger <eyal.birger@gmail.com>,
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
Subject: [PATCH perf/core 21/22] selftests/seccomp: validate uprobe syscall passes through seccomp
Date: Mon, 21 Apr 2025 23:44:21 +0200
Message-ID: <20250421214423.393661-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 107 ++++++++++++++----
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b2f76a52215a..d566e40a6028 100644
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
@@ -4899,7 +4907,36 @@ TEST(tsync_vs_dead_thread_leader)
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
@@ -4952,35 +4989,46 @@ static ssize_t get_uprobe_offset(const void *addr)
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
@@ -4990,12 +5038,17 @@ FIXTURE_SETUP(URETPROBE)
 
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
@@ -5006,7 +5059,7 @@ FIXTURE_SETUP(URETPROBE)
 			   PERF_FLAG_FD_CLOEXEC);
 }
 
-FIXTURE_TEARDOWN(URETPROBE)
+FIXTURE_TEARDOWN(UPROBE)
 {
 	/* we could call close(self->fd), but we'd need extra filter for
 	 * that and since we are calling _exit right away..
@@ -5020,11 +5073,17 @@ static int run_probed_with_filter(struct sock_fprog *prog)
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
@@ -5037,7 +5096,7 @@ TEST_F(URETPROBE, uretprobe_default_allow)
 	ASSERT_EQ(0, run_probed_with_filter(&prog));
 }
 
-TEST_F(URETPROBE, uretprobe_default_block)
+TEST_F(UPROBE, uprobe_default_block)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
@@ -5054,11 +5113,14 @@ TEST_F(URETPROBE, uretprobe_default_block)
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
@@ -5073,11 +5135,14 @@ TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
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
2.49.0


