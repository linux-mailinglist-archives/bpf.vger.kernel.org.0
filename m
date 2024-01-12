Return-Path: <bpf+bounces-19395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B282B947
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FCBB26C47
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398A139F;
	Fri, 12 Jan 2024 01:57:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18D1399;
	Fri, 12 Jan 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx++punKBlH2wEAA--.12938S3;
	Fri, 12 Jan 2024 09:57:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxXN5tnKBlkHgSAA--.48129S2;
	Fri, 12 Jan 2024 09:57:01 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Skip callback tests if jit is disabled in test_verifier
Date: Fri, 12 Jan 2024 09:57:00 +0800
Message-ID: <20240112015700.19974-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxXN5tnKBlkHgSAA--.48129S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3tr1UtrW5ur1xGr1kCrX_yoW5uFy7pF
	WkGr1qkFn8JF1Sgr17ArnxKFWFvw4vqw18Jr98G3yUZa1DAw13Jrn7KFyYvF9xGrW5ua4S
	vFWxuFW5uw4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
exist 6 failed tests.

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  #106/p inline simple bpf_loop call FAIL
  #107/p don't inline bpf_loop call, flags non-zero FAIL
  #108/p don't inline bpf_loop call, callback non-constant FAIL
  #109/p bpf_loop_inline and a dead func FAIL
  #110/p bpf_loop_inline stack locations for loop vars FAIL
  #111/p inline bpf_loop call in a big program FAIL
  Summary: 768 PASSED, 15 SKIPPED, 6 FAILED

The test log shows that callbacks are not allowed in non-JITed programs,
interpreter doesn't support them yet, thus these tests should be skipped
if jit is disabled, copy some check functions from the other places under
tools directory, and then handle this case in do_test_single().

With this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  Summary: 768 PASSED, 21 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v2: Remove inline keyword in C files, sorry for that.

Thanks very much for the feedbacks from Eduard, John, Jiri and Daniel.
I do not move loop inlining tests to test_progs, just copy some check
functions and do the minimal changes in test_verifier.

 tools/testing/selftests/bpf/test_verifier.c | 39 +++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index f36e41435be7..d4e600e3caec 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -21,6 +21,7 @@
 #include <sched.h>
 #include <limits.h>
 #include <assert.h>
+#include <fcntl.h>
 
 #include <linux/unistd.h>
 #include <linux/filter.h>
@@ -1397,6 +1398,34 @@ static bool is_skip_insn(struct bpf_insn *insn)
 	return memcmp(insn, &skip_insn, sizeof(skip_insn)) == 0;
 }
 
+static bool is_ldimm64_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
+static bool insn_is_pseudo_func(struct bpf_insn *insn)
+{
+	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
+}
+
+static bool is_jit_enabled(void)
+{
+	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
+	bool enabled = false;
+	int sysctl_fd;
+
+	sysctl_fd = open(jit_sysctl, 0, O_RDONLY);
+	if (sysctl_fd != -1) {
+		char tmpc;
+
+		if (read(sysctl_fd, &tmpc, sizeof(tmpc)) == 1)
+			enabled = (tmpc != '0');
+		close(sysctl_fd);
+	}
+
+	return enabled;
+}
+
 static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
 {
 	int i;
@@ -1662,6 +1691,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		goto close_fds;
 	}
 
+	if (!is_jit_enabled()) {
+		for (i = 0; i < prog_len; i++, prog++) {
+			if (insn_is_pseudo_func(prog)) {
+				printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
+				skips++;
+				goto close_fds;
+			}
+		}
+	}
+
 	alignment_prevented_execution = 0;
 
 	if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
-- 
2.42.0


