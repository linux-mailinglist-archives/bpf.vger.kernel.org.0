Return-Path: <bpf+bounces-42859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8A9ABB5B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3DDB222F2
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57D2D600;
	Wed, 23 Oct 2024 02:15:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5478825
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649749; cv=none; b=tnNf+xSqCK7d1su1mb/V7TU9Acxc4GI5ScfR1Q50tIP2uhde8Crm3kwHxZsE8SSrcucP2nADImqzbroyJnBNgbfpWU40H1nW/whKumVpEQTDrBThy7ZDsbiQmO1iIa/HbIWIQcZ+WD/C4zNvnOCIZlK6E2LXoiIWourN1CjVV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649749; c=relaxed/simple;
	bh=So/y0eXTDntGYp0b6i8TMiEDpt1bCS2gE8y9TBahEPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p2OE+VYljqmbZrT9+9h/2PdveH8HpaSWtaV5/9cjqoK1q4WrziwjQGoGoRGMpb0BUM7t5NJkjIf8sj3qUnQ+/OyZ5pbrdAekxbJ1QrtxIFWpENYYD38D8bILJPeLB7sRQbvhMNyfnxZWQwZbKnLZ84r8fpQAhykG/zFXr4LF/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XYCLh6W1Vz4f3jdh
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:15:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 528811A0568
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 10:15:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMlMXBhnfWFwEw--.61428S4;
	Wed, 23 Oct 2024 10:15:42 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf] bpf: Extend the size of scratched_stack_slots to 128 bits
Date: Wed, 23 Oct 2024 10:27:52 +0800
Message-Id: <20241023022752.172005-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMlMXBhnfWFwEw--.61428S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4DWF1xXw47ZFy8Ar17GFg_yoWrtw13pF
	9FganrCw4DtayUKa47AF4UZFy5A3WktF17CrW8Gry7ZF1rXFn5KFWrKryYqrnYy3yS9347
	Cw4qvrZ7Gw4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1aFAJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When the fastcall pattern is enabled for bpf helper or kfunc, the stack
size limitation is increased from MAX_BPF_STACK (512 bytes) to
MAX_BPF_STACK + CALLER_SAVED_REGS * BPF_REG_SIZE (560 bytes), as
implemented in check_stack_slot_within_bounds(). This additional stack
space is reserved for spilling and filling of caller saved registers.

However, when marking a stack slot as scratched during spilling through
mark_stack_slot_scratched(), a shift-out-of-bounds warning is reported
as shown below. And it can be easily reproducted by running:
./test_progs -t verifier_bpf_fastcall/bpf_fastcall_max_stack_ok.

  ------------[ cut here ]------------
  UBSAN: shift-out-of-bounds in ../include/linux/bpf_verifier.h:942:37
  shift exponent 64 is too large for 64-bit type 'long long unsigned int'
  CPU: 1 UID: 0 PID: 5169 Comm: new_name Tainted: G ...  6.11.0-rc4+
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x8f/0xb0
   dump_stack+0x10/0x20
   ubsan_epilogue+0x9/0x40
   __ubsan_handle_shift_out_of_bounds+0x10e/0x170
   check_mem_access.cold+0x61/0x6d
   do_check_common+0x2e2e/0x5da0
   bpf_check+0x48a2/0x5750
   bpf_prog_load+0xb2f/0x1250
   __sys_bpf+0xd78/0x36b0
   __x64_sys_bpf+0x45/0x60
   x64_sys_call+0x1b2a/0x20d0

However, the shift-out-of-bound issue doesn't seem to affect the output
of scratched stack slots in the verifier log. For example, for
bpf_fastcall_max_stack_ok, the 64-th stack slot is correctly marked as
scratched, as shown in the verifier log:

  2: (7b) *(u64 *)(r10 -520) = r1       ; R1_w=42 R10=fp0 fp-520_w=42

The reason relates to the compiler implementation. It appears that the
shift exponent is taken modulo 64 before applying the shift, so after
"slot = (1ULL << 64)", the value of slot becomes 1.

Fix the UBSAN warning by extending the size of scratched_stack_slots
from 64 bits to 128-bits.

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_verifier.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..1bb6c6def04d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -773,8 +773,11 @@ struct bpf_verifier_env {
 	 * since the last time the function state was printed
 	 */
 	u32 scratched_regs;
-	/* Same as scratched_regs but for stack slots */
-	u64 scratched_stack_slots;
+	/* Same as scratched_regs but for stack slots. The stack size may
+	 * temporarily exceed MAX_BPF_STACK (e.g., due to fastcall pattern
+	 * in check_stack_slot_within_bounds()), so two u64 values are used.
+	 */
+	u64 scratched_stack_slots[2];
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[2];
@@ -939,7 +942,7 @@ static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 
 static inline void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
 {
-	env->scratched_stack_slots |= 1ULL << spi;
+	env->scratched_stack_slots[spi / 64] |= 1ULL << (spi & 63);
 }
 
 static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -949,25 +952,28 @@ static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
 
 static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u64 regno)
 {
-	return (env->scratched_stack_slots >> regno) & 1;
+	return (env->scratched_stack_slots[regno / 64] >> (regno & 63)) & 1;
 }
 
 static inline bool verifier_state_scratched(const struct bpf_verifier_env *env)
 {
-	return env->scratched_regs || env->scratched_stack_slots;
+	return env->scratched_regs || env->scratched_stack_slots[0] ||
+	       env->scratched_stack_slots[1];
 }
 
 static inline void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = 0U;
-	env->scratched_stack_slots = 0ULL;
+	env->scratched_stack_slots[0] = 0ULL;
+	env->scratched_stack_slots[1] = 0ULL;
 }
 
 /* Used for printing the entire verifier state. */
 static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = ~0U;
-	env->scratched_stack_slots = ~0ULL;
+	env->scratched_stack_slots[0] = ~0ULL;
+	env->scratched_stack_slots[1] = ~0ULL;
 }
 
 static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
-- 
2.29.2


