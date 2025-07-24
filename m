Return-Path: <bpf+bounces-64260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BCDB10AC2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75543AE5FBA
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592462D5412;
	Thu, 24 Jul 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyPO9sS2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD72D4B6C
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361697; cv=none; b=BiRnN5o0R2MwG7F7Ppq7suIZnmRWAsuJH8qQaP5zA33iHXrTo+pgsUb3TtlkdIyGPQzsXh0LFAvbCXIj8Vw4omZbxpse/wYD1p4Nfa+OKz7D5IKbeIcO+DKmj1iK0rhnloanZVKG/VteTX3sfrst/nfTq+OL+tjvv8/qjyB4NZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361697; c=relaxed/simple;
	bh=CPxtIqReNuWYFCHmdyElcMZ60mEEp1fy+jQHGTdKU8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvYCRzTSoi6nhnETjqKG+kEOORx9ypH0FPwbkPnqJg7VxQeH8zDJSsOpFanDyVBG/usEp+pGNW1JXZpWPOcGe1FJQBlfE221jUUDrU3d+ERAAoGr2Dno3R1L1+bpGUIu0CCOuQAxnsLlaC+GlyHi9qHff5QrcTGHz8KE9dy0hAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyPO9sS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A96CC4CEEF;
	Thu, 24 Jul 2025 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753361697;
	bh=CPxtIqReNuWYFCHmdyElcMZ60mEEp1fy+jQHGTdKU8Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SyPO9sS2X1TlSECSdn+1iiUIq/5JHvpcIxHa7RiGYPDfNYmMFii3yFD7b08eAJBC3
	 Tf92+Ry59luOa8GtVuVLsHMRfTn0lKJ4pZs0IeXimIEetVk9ZkblJ7l06vBZNwTbQX
	 RpoAFH1BbPf8JnCtJkDW1seC2TdgD9YJdX7CIbAKJpiee04DItVRItIHEHw9X7Gj+P
	 X/+sS2qBPGbiltow0qd+v/w2ajgzL+Z0wlhWc5ygiYBcVkGPhwOiTWkEp7mdb/IhBZ
	 uwFf9z6Mi2HPx4l0oWhvAad0155BnCtGroLu2hD3OSdNrD4G3hPvIwzXq+bAZqWGf8
	 llEFbCs2UukrA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable timed may_goto tests for arm64
Date: Thu, 24 Jul 2025 12:54:40 +0000
Message-ID: <20250724125443.26182-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250724125443.26182-1-puranjay@kernel.org>
References: <20250724125443.26182-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As arm64 JIT now supports timed may_goto instruction, make sure all
relevant tests run on this architecture. Some tests were enabled and
other required modifications to work properly on arm64.

 $ ./test_progs -a "stream*","*may_goto*",verifier_bpf_fastcall

 #404     stream_errors:OK
 [...]
 #406/2   stream_success/stream_cond_break:OK
 [...]
 #494/23  verifier_bpf_fastcall/may_goto_interaction_x86_64:SKIP
 #494/24  verifier_bpf_fastcall/may_goto_interaction_arm64:OK
 [...]
 #539/1   verifier_may_goto_1/may_goto 0:OK
 #539/2   verifier_may_goto_1/batch 2 of may_goto 0:OK
 #539/3   verifier_may_goto_1/may_goto batch with offsets 2/1/0:OK
 #539/4   verifier_may_goto_1/may_goto batch with offsets 2/0:OK
 #539     verifier_may_goto_1:OK
 #540/1   verifier_may_goto_2/C code with may_goto 0:OK
 #540     verifier_may_goto_2:OK
 Summary: 7/16 PASSED, 25 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  2 +-
 .../bpf/progs/verifier_bpf_fastcall.c         | 27 +++++++++------
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++---------------
 3 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index d9f0185dca61b..13f27e3f1f360 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -77,7 +77,7 @@ void test_stream_errors(void)
 		ASSERT_OK(ret, "ret");
 		ASSERT_OK(opts.retval, "retval");
 
-#if !defined(__x86_64__)
+#if !defined(__x86_64__) && !defined(__aarch64__)
 		ASSERT_TRUE(1, "Timed may_goto unsupported, skip.");
 		if (i == 0) {
 			ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index c258b0722e045..fb4fa465d67c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -660,19 +660,24 @@ __naked void may_goto_interaction_x86_64(void)
 
 SEC("raw_tp")
 __arch_arm64
-__log_level(4) __msg("stack depth 16")
-/* may_goto counter at -16 */
-__xlated("0: *(u64 *)(r10 -16) =")
-__xlated("1: r1 = 1")
-__xlated("2: call bpf_get_smp_processor_id")
+__log_level(4) __msg("stack depth 24")
+/* may_goto counter at -24 */
+__xlated("0: *(u64 *)(r10 -24) =")
+/* may_goto timestamp at -16 */
+__xlated("1: *(u64 *)(r10 -16) =")
+__xlated("2: r1 = 1")
+__xlated("3: call bpf_get_smp_processor_id")
 /* may_goto expansion starts */
-__xlated("3: r11 = *(u64 *)(r10 -16)")
-__xlated("4: if r11 == 0x0 goto pc+3")
-__xlated("5: r11 -= 1")
-__xlated("6: *(u64 *)(r10 -16) = r11")
+__xlated("4: r11 = *(u64 *)(r10 -24)")
+__xlated("5: if r11 == 0x0 goto pc+6")
+__xlated("6: r11 -= 1")
+__xlated("7: if r11 != 0x0 goto pc+2")
+__xlated("8: r11 = -24")
+__xlated("9: call unknown")
+__xlated("10: *(u64 *)(r10 -24) = r11")
 /* may_goto expansion ends */
-__xlated("7: *(u64 *)(r10 -8) = r1")
-__xlated("8: exit")
+__xlated("11: *(u64 *)(r10 -8) = r1")
+__xlated("12: exit")
 __success
 __naked void may_goto_interaction_arm64(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 3966d827f2889..08385b6a736de 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -9,6 +9,7 @@
 SEC("raw_tp")
 __description("may_goto 0")
 __arch_x86_64
+__arch_arm64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -27,6 +28,7 @@ __naked void may_goto_simple(void)
 SEC("raw_tp")
 __description("batch 2 of may_goto 0")
 __arch_x86_64
+__arch_arm64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -47,6 +49,7 @@ __naked void may_goto_batch_0(void)
 SEC("raw_tp")
 __description("may_goto batch with offsets 2/1/0")
 __arch_x86_64
+__arch_arm64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -69,8 +72,9 @@ __naked void may_goto_batch_1(void)
 }
 
 SEC("raw_tp")
-__description("may_goto batch with offsets 2/0 - x86_64")
+__description("may_goto batch with offsets 2/0")
 __arch_x86_64
+__arch_arm64
 __xlated("0: *(u64 *)(r10 -16) = 65535")
 __xlated("1: *(u64 *)(r10 -8) = 0")
 __xlated("2: r11 = *(u64 *)(r10 -16)")
@@ -84,33 +88,7 @@ __xlated("9: r0 = 1")
 __xlated("10: r0 = 2")
 __xlated("11: exit")
 __success
-__naked void may_goto_batch_2_x86_64(void)
-{
-	asm volatile (
-	".8byte %[may_goto1];"
-	".8byte %[may_goto3];"
-	"r0 = 1;"
-	"r0 = 2;"
-	"exit;"
-	:
-	: __imm_insn(may_goto1, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* offset */, 0)),
-	  __imm_insn(may_goto3, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* offset */, 0))
-	: __clobber_all);
-}
-
-SEC("raw_tp")
-__description("may_goto batch with offsets 2/0 - arm64")
-__arch_arm64
-__xlated("0: *(u64 *)(r10 -8) = 8388608")
-__xlated("1: r11 = *(u64 *)(r10 -8)")
-__xlated("2: if r11 == 0x0 goto pc+3")
-__xlated("3: r11 -= 1")
-__xlated("4: *(u64 *)(r10 -8) = r11")
-__xlated("5: r0 = 1")
-__xlated("6: r0 = 2")
-__xlated("7: exit")
-__success
-__naked void may_goto_batch_2_arm64(void)
+__naked void may_goto_batch_2(void)
 {
 	asm volatile (
 	".8byte %[may_goto1];"
-- 
2.47.3


