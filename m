Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C2650CB1
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiLSNgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 08:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSNgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 08:36:36 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F111109;
        Mon, 19 Dec 2022 05:36:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NbLMc3pCWz4f3lY4;
        Mon, 19 Dec 2022 21:36:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgAH++jcaKBjpueTAA--.19298S5;
        Mon, 19 Dec 2022 21:36:31 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [RFC PATCH bpf-next 3/4] riscv, bpf: Add bpf_arch_text_poke support for RV64
Date:   Mon, 19 Dec 2022 21:37:35 +0800
Message-Id: <20221219133736.1387008-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219133736.1387008-1-pulehui@huaweicloud.com>
References: <20221219133736.1387008-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAH++jcaKBjpueTAA--.19298S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4fKF13Aw1xJFW8tFW5Jrb_yoW7uFykpF
        srKry5ArWkXF4fXFy7Ja1DXr1Ykw4kWFZrGrW5Kw4SyFsFgr93C3Z5Kr43tr95CrW8Cr1I
        vF4DKFnxuan8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
        CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUojjgUUUU
        U
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

Implement bpf_arch_text_poke for RV64. For call scenario,
ftrace framework reserve 4 nops for RV64 kernel function
as function entry, and use auipc+jalr instructions to call
kernel or module functions. However, since the auipc+jalr
call instructions is non-atomic operation, we need to use
stop-machine to make sure instruction patching in atomic
context. As for jump scenario, since we only jump inside
the trampoline, a jal instruction is sufficient.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit.h        |   5 ++
 arch/riscv/net/bpf_jit_comp64.c | 131 +++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index d926e0f7ef57..bf9802a63061 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -573,6 +573,11 @@ static inline u32 rv_fence(u8 pred, u8 succ)
 	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
 }
 
+static inline u32 rv_nop(void)
+{
+	return rv_i_insn(0, 0, 0, 0, 0x13);
+}
+
 /* RVC instrutions. */
 
 static inline u16 rvc_addi4spn(u8 rd, u32 imm10)
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index bf4721a99a09..fa8b03c52463 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
+#include <linux/memory.h>
+#include <linux/stop_machine.h>
 #include "bpf_jit.h"
 
 #define RV_REG_TCC RV_REG_A6
@@ -238,7 +240,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
 	if (!is_tail_call)
 		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
 	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
-		  is_tail_call ? 4 : 0, /* skip TCC init */
+		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
 		  ctx);
 }
 
@@ -615,6 +617,127 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+struct text_poke_args {
+	void *addr;
+	const void *insns;
+	size_t len;
+	atomic_t cpu_count;
+};
+
+static int do_text_poke(void *data)
+{
+	int ret = 0;
+	struct text_poke_args *patch = data;
+
+	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
+		ret = patch_text_nosync(patch->addr, patch->insns, patch->len);
+		atomic_inc(&patch->cpu_count);
+	} else {
+		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	return ret;
+}
+
+static int bpf_text_poke_stop_machine(void *addr, const void *insns, size_t len)
+{
+	struct text_poke_args patch = {
+		.addr = addr,
+		.insns = insns,
+		.len = len,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+
+	return stop_machine(do_text_poke, &patch, cpu_online_mask);
+}
+
+static int gen_call_or_nops(void *target, void *ip, u32 *insns)
+{
+	int i, ret;
+	s64 rvoff;
+	struct rv_jit_context ctx;
+
+	ctx.ninsns = 0;
+	ctx.insns = (u16 *)insns;
+
+	if (!target) {
+		for (i = 0; i < 4; i++)
+			emit(rv_nop(), &ctx);
+		return 0;
+	}
+
+	rvoff = (s64)(target - ip);
+	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
+	ret = emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
+	if (ret)
+		return ret;
+	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
+
+	return 0;
+
+}
+
+static int bpf_text_poke_call(void *ip, void *old_addr, void *new_addr)
+{
+	int ret;
+	u32 old_insns[4], new_insns[4];
+
+	ret = gen_call_or_nops(old_addr, ip + 4, old_insns);
+	if (ret)
+		return ret;
+
+	ret = gen_call_or_nops(new_addr, ip + 4, new_insns);
+	if (ret)
+		return ret;
+
+	mutex_lock(&text_mutex);
+	if (memcmp(ip, old_insns, sizeof(old_insns))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (memcmp(ip, new_insns, sizeof(new_insns)))
+		ret = bpf_text_poke_stop_machine(ip, new_insns, sizeof(new_insns));
+out:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+static int bpf_text_poke_jump(void *ip, void *old_addr, void *new_addr)
+{
+	int ret;
+	u32 old_insn, new_insn;
+
+	old_insn = old_addr ? rv_jal(RV_REG_ZERO, (s64)(old_addr - ip) >> 1) : rv_nop();
+	new_insn = new_addr ? rv_jal(RV_REG_ZERO, (s64)(new_addr - ip) >> 1) : rv_nop();
+
+	mutex_lock(&text_mutex);
+	if (memcmp(ip, &old_insn, sizeof(old_insn))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	if (memcmp(ip, &new_insn, sizeof(new_insn)))
+		ret = patch_text_nosync(ip, &new_insn, sizeof(new_insn));
+out:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
+		       void *old_addr, void *new_addr)
+{
+	if (!is_kernel_text((unsigned long)ip) &&
+	    !is_bpf_text_address((unsigned long)ip))
+		return -ENOTSUPP;
+
+	return poke_type == BPF_MOD_CALL ?
+	       bpf_text_poke_call(ip, old_addr, new_addr) :
+	       bpf_text_poke_jump(ip, old_addr, new_addr);
+}
+
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		      bool extra_pass)
 {
@@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 {
-	int stack_adjust = 0, store_offset, bpf_stack_adjust;
+	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
 	bool is_main_prog = ctx->prog->aux->func_idx == 0;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
@@ -1294,6 +1417,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
 
 	store_offset = stack_adjust - 8;
 
+	/* reserve 4 nop insns */
+	for (i = 0; i < 4; i++)
+		emit(rv_nop(), ctx);
+
 	/* First instruction is always setting the tail-call-counter
 	 * (TCC) register. This instruction is skipped for tail calls.
 	 * Force using a 4-byte (non-compressed) instruction.
-- 
2.25.1

