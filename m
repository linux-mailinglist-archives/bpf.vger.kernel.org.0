Return-Path: <bpf+bounces-19022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632A824275
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED265B217DD
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CE224CA;
	Thu,  4 Jan 2024 13:08:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1522327;
	Thu,  4 Jan 2024 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxnvDHrZZlSPcBAA--.7484S3;
	Thu, 04 Jan 2024 21:08:23 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvofGrZZlR8wBAA--.4535S2;
	Thu, 04 Jan 2024 21:08:22 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Return -ENOTSUPP if calls are not allowed in non-JITed programs
Date: Thu,  4 Jan 2024 21:08:17 +0800
Message-ID: <20240104130817.1221-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxvofGrZZlR8wBAA--.4535S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3tr1UtrW5ur1xAr48Zrc_yoW5ZFW8pa
	yUWr9FkF4Yq34xuw17JFs3Cayjv3yvqw47KFy5u34Fyan5CanrJr1fGryIvFyaqrWru348
	Z3yxuayjgw1UGFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=

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
if jit is disabled, just return -ENOTSUPP instead of -EINVAL for pseudo
calls in fixup_call_args().

With this patch:

  [root@linux bpf]# echo 0 > /proc/sys/net/core/bpf_jit_enable
  [root@linux bpf]# echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled
  [root@linux bpf]# ./test_verifier | grep FAIL
  Summary: 768 PASSED, 21 SKIPPED, 0 FAILED

Additionally, as Eduard suggested, return -ENOTSUPP instead of -EINVAL
for the other three places where "non-JITed" is used in error messages
to keep consistent.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  -- rebase on the latest bpf-next tree.
  -- return -ENOTSUPP instead of -EINVAL for the other three places
     where "non-JITed" is used in error messages to keep consistent.
  -- update the patch subject and commit message.

 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5f4ff1eb235..99558a5186b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8908,7 +8908,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		if (env->subprog_cnt > 1 && !allow_tail_call_in_subprogs(env)) {
 			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
-			return -EINVAL;
+			return -ENOTSUPP;
 		}
 		break;
 	case BPF_FUNC_perf_event_read:
@@ -19069,14 +19069,14 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (has_kfunc_call) {
 		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
 		/* When JIT fails the progs with bpf2bpf calls and tail_calls
 		 * have to be rejected, since interpreter doesn't support them yet.
 		 */
 		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
-		return -EINVAL;
+		return -ENOTSUPP;
 	}
 	for (i = 0; i < prog->len; i++, insn++) {
 		if (bpf_pseudo_func(insn)) {
@@ -19084,7 +19084,7 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 			 * have to be rejected, since interpreter doesn't support them yet.
 			 */
 			verbose(env, "callbacks are not allowed in non-JITed programs\n");
-			return -EINVAL;
+			return -ENOTSUPP;
 		}
 
 		if (!bpf_pseudo_call(insn))
-- 
2.42.0


