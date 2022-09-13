Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C85B77CE
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiIMRXt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiIMRXV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 13:23:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CD59A9EE;
        Tue, 13 Sep 2022 09:10:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MRpLK1k15zlB0q;
        Wed, 14 Sep 2022 00:08:57 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBHB4dxqyBjcEAeAw--.28569S5;
        Wed, 14 Sep 2022 00:10:32 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v2 3/4] arm64: ftrace: Add ftrace direct call support
Date:   Tue, 13 Sep 2022 12:27:31 -0400
Message-Id: <20220913162732.163631-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913162732.163631-1-xukuohai@huaweicloud.com>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHB4dxqyBjcEAeAw--.28569S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4xJr48trykJF4rtFWxXrb_yoWrZF43pF
        9rZwn3Ja17uFs0k347WwnrWrW5ua1vq345GryUG34FkryY9ry5GFn2k39FkrW8ArWkZ3yf
        uF1F9ryUGF17X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

Add ftrace direct support for arm64.

1. When there is custom trampoline only, patch fentry callsite to call
   the custom trampoline directly.

2. When ftrace caller and custom trampoline coexist, jump from fentry to
   ftrace caller first, then jump to custom trampoline when ftrace caller
   exits. As pt_regs->orig_x0 is currently unused by ftrace, its space
   is reused as an intermediary for jumping from ftrace caller to custom
   trampoline.

In short, this patch does the same thing as the x86 commit 562955fe6a55
("ftrace/x86: Add register_ftrace_direct() for custom trampolines").

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/ftrace.h  | 12 ++++++++++++
 arch/arm64/include/asm/ptrace.h  |  6 +++++-
 arch/arm64/kernel/asm-offsets.c  |  1 +
 arch/arm64/kernel/entry-ftrace.S | 18 +++++++++++++++---
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..e2f6ca75b881 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -180,6 +180,8 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
+		if DYNAMIC_FTRACE_WITH_REGS
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 40e63435965b..b07a3c24f918 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -67,6 +67,18 @@ extern void return_to_handler(void);
 
 unsigned long ftrace_call_adjust(unsigned long addr);
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
+						 unsigned long addr)
+{
+	/*
+	 * Place custom trampoline address in regs->custom_tramp to let ftrace
+	 * trampoline jump to it.
+	 */
+	regs->custom_tramp = addr;
+}
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct dyn_ftrace;
 struct ftrace_ops;
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 41b332c054ab..9701c38fcc5f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -185,7 +185,11 @@ struct pt_regs {
 			u64 pstate;
 		};
 	};
-	u64 orig_x0;
+	union {
+		u64 orig_x0;
+		/* Only used by ftrace to save custom trampoline address */
+		u64 custom_tramp;
+	};
 #ifdef __AARCH64EB__
 	u32 unused2;
 	s32 syscallno;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1197e7679882..56d4acc52a86 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -80,6 +80,7 @@ int main(void)
   DEFINE(S_SDEI_TTBR1,		offsetof(struct pt_regs, sdei_ttbr1));
   DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
+  DEFINE(S_CUSTOM_TRAMP,	offsetof(struct pt_regs, custom_tramp));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   BLANK();
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 0bebe3ffdb58..ae03df89d031 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -62,6 +62,9 @@
 	str	x29, [sp, #S_FP]
 	.endif
 
+	/* Set custom_tramp to zero  */
+	str     xzr, [sp, #S_CUSTOM_TRAMP]
+
 	/* Save the callsite's SP and LR */
 	add	x10, sp, #(PT_REGS_SIZE + 16)
 	stp	x9, x10, [sp, #S_LR]
@@ -114,12 +117,21 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	/* Restore the callsite's FP, LR, PC */
 	ldr	x29, [sp, #S_FP]
 	ldr	x30, [sp, #S_LR]
-	ldr	x9, [sp, #S_PC]
-
+	ldr	x10, [sp, #S_PC]
+
+	ldr	x11, [sp, #S_CUSTOM_TRAMP]
+	cbz	x11, 1f
+	/* Set x9 to parent ip before jump to custom trampoline */
+	mov	x9,  x30
+	/* Set lr to self ip */
+	ldr	x30, [sp, #S_PC]
+	/* Set x10 (used for return address) to custom trampoline */
+	mov	x10, x11
+1:
 	/* Restore the callsite's SP */
 	add	sp, sp, #PT_REGS_SIZE + 16
 
-	ret	x9
+	ret	x10
 SYM_CODE_END(ftrace_common)
 
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-- 
2.30.2

