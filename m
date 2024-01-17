Return-Path: <bpf+bounces-19727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6083043E
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 12:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27591F23127
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194E1DFCA;
	Wed, 17 Jan 2024 11:10:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6DE1EB21;
	Wed, 17 Jan 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489816; cv=none; b=NrN0Jrya2clQUELOXNNYmBKOJ86tQqD7f+Qr75rrSAeeqYmyrIviyoqGRTG05oJO5rVGV5h47h9zihWp0zm4N6gtvKrPOpPBc0xJmxstV36TWLlNGuzJXXF3mC80hmqiQYgfTXyCvUzLtfkyrscc21GKMwnlZiiE1pwNnCzkI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489816; c=relaxed/simple;
	bh=Hk5UpisSZLGFNyFw4ZvpOxdO81V2SRW39DUJ6gwVWtc=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam; b=NY2XVPJAFDo8jGVjN8EyolkChq7cNrg+fgG6ns1OA2DOUEb3koRKpD0yt4MQC7WY4OqTPQ1oERh4Vvz3XzWYpA1ufGNaTsCGf1Svkt9Ti0cUwab5hA8IB5z0rWhSNGGR2mYPKlu4+VSjh0WdkslLGuQgG6b908v0PAP1yTwIxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxruuNtadldiYBAA--.5302S3;
	Wed, 17 Jan 2024 19:10:05 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c6Jtadl+1MGAA--.32440S5;
	Wed, 17 Jan 2024 19:10:04 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Skip callback tests if jit is disabled in  test_verifier
Date: Wed, 17 Jan 2024 19:10:00 +0800
Message-ID: <20240117111000.12763-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117111000.12763-1-yangtiezhu@loongson.cn>
References: <20240117111000.12763-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c6Jtadl+1MGAA--.32440S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3tr1UtrW5ur1xGF1fKrX_yoWrXr1fpF
	WkGF1qkF18XFyI93y2y3WfWF1Yyw1kXayUGryYg3y5Z3WkAr17Xrn7KFy3ZF9xWrWYva4f
	Zw4xuFW8Gw4UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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
if jit is disabled, just handle this case in do_test_single().

After including bpf/libbpf_internal.h, there exist some build errors:

  error: attempt to use poisoned "u32"
  error: attempt to use poisoned "u64"

replace u32 and u64 with __u32 and __u64 to fix them.

With this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  Summary: 768 PASSED, 21 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 1a09fc34d093..c7f57b5b04a7 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -41,6 +41,7 @@
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
 #include "testing_helpers.h"
+#include "bpf/libbpf_internal.h"
 
 #ifndef ENOTSUPP
 #define ENOTSUPP 524
@@ -74,6 +75,7 @@
 		    1ULL << CAP_BPF)
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 static bool unpriv_disabled = false;
+static bool jit_disabled;
 static int skips;
 static bool verbose = false;
 static int verif_log_level = 0;
@@ -1143,8 +1145,8 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 		} while (*fixup_map_xskmap);
 	}
 	if (*fixup_map_stacktrace) {
-		map_fds[12] = create_map(BPF_MAP_TYPE_STACK_TRACE, sizeof(u32),
-					 sizeof(u64), 1);
+		map_fds[12] = create_map(BPF_MAP_TYPE_STACK_TRACE, sizeof(__u32),
+					 sizeof(__u64), 1);
 		do {
 			prog[*fixup_map_stacktrace].imm = map_fds[12];
 			fixup_map_stacktrace++;
@@ -1203,7 +1205,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	}
 	if (*fixup_map_reuseport_array) {
 		map_fds[19] = __create_map(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
-					   sizeof(u32), sizeof(u64), 1, 0);
+					   sizeof(__u32), sizeof(__u64), 1, 0);
 		do {
 			prog[*fixup_map_reuseport_array].imm = map_fds[19];
 			fixup_map_reuseport_array++;
@@ -1622,6 +1624,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	alignment_prevented_execution = 0;
 
 	if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
+		if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
+			for (i = 0; i < prog_len; i++, prog++) {
+				if (!insn_is_pseudo_func(prog))
+					continue;
+				printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
+				skips++;
+				goto close_fds;
+			}
+		}
+
 		if (fd_prog < 0) {
 			printf("FAIL\nFailed to load prog '%s'!\n",
 			       strerror(saved_errno));
@@ -1844,6 +1856,8 @@ int main(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	jit_disabled = !is_jit_enabled();
+
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-- 
2.42.0


