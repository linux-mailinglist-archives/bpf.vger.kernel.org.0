Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4775B67E0
	for <lists+bpf@lfdr.de>; Tue, 13 Sep 2022 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIMGYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiIMGYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 02:24:36 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166B12D1C3;
        Mon, 12 Sep 2022 23:24:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MRYKT1BRdz6S2j8;
        Tue, 13 Sep 2022 14:22:21 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgCHSYkDIiBjT3sKAw--.4735S6;
        Tue, 13 Sep 2022 14:24:12 +0800 (CST)
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
Subject: [PATCH bpf-next 4/4] ftrace: Fix dead loop caused by direct call in ftrace selftest
Date:   Tue, 13 Sep 2022 02:31:46 -0400
Message-Id: <20220913063146.74750-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220913063146.74750-1-xukuohai@huaweicloud.com>
References: <20220913063146.74750-1-xukuohai@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHSYkDIiBjT3sKAw--.4735S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3WrWUXr4fCr43XF47urg_yoW8tFWDpa
        s3urnrKr15AF4kKas7u3W8CryUAwn8A343Kw1UG3sYvrZ8AryUKrZ2vrn7Z34DJa95C3y3
        ZF42vr1rGr4UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

After direct call is enabled for arm64, ftrace selftest enters a
dead loop:

<trace_selftest_dynamic_test_func>:
00  bti     c
01  mov     x9, x30                            <trace_direct_tramp>:
02  bl      <trace_direct_tramp>    ---------->     ret
                                                     |
                                         lr/x30 is 03, return to 03
                                                     |
03  mov     w0, #0x0   <-----------------------------|
     |                                               |
     |                   dead loop!                  |
     |                                               |
04  ret   ---- lr/x30 is still 03, go back to 03 ----|

The reason is that when the direct caller trace_direct_tramp() returns
to the patched function trace_selftest_dynamic_test_func(), lr is still
the address after the instrumented instruction in the patched function,
so when the patched function exits, it returns to itself!

To fix this issue, we need to restore lr before trace_direct_tramp()
exits, so use a dedicated trace_direct_tramp() for arm64.

Reported-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/ftrace.h | 4 ++++
 kernel/trace/trace_selftest.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index b07a3c24f918..15247f73bf54 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -128,6 +128,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 #define ftrace_dummy_tramp ftrace_dummy_tramp
 extern void ftrace_dummy_tramp(void);
 
+#ifdef CONFIG_FTRACE_SELFTEST
+#define trace_direct_tramp ftrace_dummy_tramp
+#endif /* CONFIG_FTRACE_SELFTEST */
+
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #endif /* ifndef __ASSEMBLY__ */
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index a2d301f58ced..092239bc373c 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -785,8 +785,10 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#ifndef trace_direct_tramp
 noinline __noclone static void trace_direct_tramp(void) { }
 #endif
+#endif
 
 /*
  * Pretty much the same than for the function tracer from which the selftest
-- 
2.30.2

