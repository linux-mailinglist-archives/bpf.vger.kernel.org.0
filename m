Return-Path: <bpf+bounces-18643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA781D390
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412641F2220B
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868DCA53;
	Sat, 23 Dec 2023 10:39:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727198F79
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sy0zH5RKnz4f3jsh
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9E81C1A036B
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 18:39:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH1QvquIZljMSpEQ--.5375S5;
	Sat, 23 Dec 2023 18:39:42 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 1/3] bpf: Support inlining bpf_kptr_xchg() helper
Date: Sat, 23 Dec 2023 18:40:40 +0800
Message-Id: <20231223104042.1432300-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231223104042.1432300-1-houtao@huaweicloud.com>
References: <20231223104042.1432300-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH1QvquIZljMSpEQ--.5375S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5CF48GF1xXF1xtw4DXFb_yoWruF48pF
	Z8tryfKr4qq3WkA3srJan7Zry5Zw48C342gFnrury8A3W2qas7Xa4kK3Z0q3s8tr1UKa4F
	yr1j9rZI93s8XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The motivation of inlining bpf_kptr_xchg() comes from the performance
profiling of bpf memory allocator benchmark. The benchmark uses
bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
objects for free. After inling bpf_kptr_xchg(), the performance for
object free on 8-CPUs VM increases about 2%~10%. The inline also has
downside: both the kasan and kcsan checks on the pointer will be
unavailable.

bpf_kptr_xchg() can be inlined by converting the calling of
bpf_kptr_xchg() into an atomic_xchg() instruction. But the conversion
depends on two conditions:
1) JIT backend supports atomic_xchg() on pointer-sized word
2) For the specific arch, the implementation of xchg is the same as
   atomic_xchg() on pointer-sized words.

It seems most 64-bit JIT backends satisfies these two conditions. But
as a precaution, defining a weak function bpf_jit_supports_ptr_xchg()
to state whether such conversion is safe and only supporting inline for
64-bit host.

For x86-64, it supports BPF_XCHG atomic operation and both xchg() and
atomic_xchg() use arch_xchg() to implement the exchange, so enabling the
inline of bpf_kptr_xchg() on x86-64 first.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c |  5 +++++
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           | 10 ++++++++++
 kernel/bpf/helpers.c        |  1 +
 kernel/bpf/verifier.c       | 17 +++++++++++++++++
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8b7f4de69917..f798e2c22cd6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3247,3 +3247,8 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 		BUG_ON(ret < 0);
 	}
 }
+
+bool bpf_jit_supports_ptr_xchg(void)
+{
+	return true;
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fe..35f067fd3840 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -955,6 +955,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_ptr_xchg(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ea6843be2616..fbb1d95a9b44 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2925,6 +2925,16 @@ bool __weak bpf_jit_supports_far_kfunc_call(void)
 	return false;
 }
 
+/* Return TRUE if the JIT backend satisfies the following two conditions:
+ * 1) JIT backend supports atomic_xchg() on pointer-sized words.
+ * 2) Under the specific arch, the implementation of xchg() is the same
+ *    as atomic_xchg() on pointer-sized words.
+ */
+bool __weak bpf_jit_supports_ptr_xchg(void)
+{
+	return false;
+}
+
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
  */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index be72824f32b2..e04ca1af8927 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1414,6 +1414,7 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
 {
 	unsigned long *kptr = map_value;
 
+	/* This helper may be inlined by verifier. */
 	return xchg(kptr, (unsigned long)ptr);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a376eb609c41..69895194b3c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19790,6 +19790,23 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		/* Implement bpf_kptr_xchg inline */
+		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		    insn->imm == BPF_FUNC_kptr_xchg &&
+		    bpf_jit_supports_ptr_xchg()) {
+			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
+			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
+			cnt = 2;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
-- 
2.29.2


