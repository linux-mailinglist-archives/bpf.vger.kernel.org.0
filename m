Return-Path: <bpf+bounces-19519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C412A82D45D
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 08:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B806F1C21142
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B515C98;
	Mon, 15 Jan 2024 07:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91063C0B;
	Mon, 15 Jan 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx3+v916RlkEMAAA--.1038S3;
	Mon, 15 Jan 2024 15:00:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax3c7716RlzbIBAA--.8673S4;
	Mon, 15 Jan 2024 15:00:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Skip callback tests if jit is disabled in test_verifier
Date: Mon, 15 Jan 2024 15:00:10 +0800
Message-ID: <20240115070010.12338-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115070010.12338-1-yangtiezhu@loongson.cn>
References: <20240115070010.12338-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Ax3c7716RlzbIBAA--.8673S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3tr1UtrW5ur1xGr1kCrX_yoW5Cry5pF
	WkXFyqkF1UZFyI9ry7Awn3GFWY9w4kX3y8GFy5W3y8Za1kCr43Jr1xKryYvF9xGrWrWa4f
	ZFZrurWUuw4UJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

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
 tools/testing/selftests/bpf/test_verifier.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 1a09fc34d093..70f903e869b7 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -74,6 +74,7 @@
 		    1ULL << CAP_BPF)
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled = false;
+static bool jit_disabled;
 static int skips;
 static bool verbose = false;
 static int verif_log_level = 0;
@@ -1355,6 +1356,16 @@ static bool is_skip_insn(struct bpf_insn *insn)
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
 static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
 {
 	int i;
@@ -1619,6 +1630,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		goto close_fds;
 	}
 
+	if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
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
@@ -1844,6 +1865,8 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	jit_disabled = !is_jit_enabled();
+
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-- 
2.42.0


