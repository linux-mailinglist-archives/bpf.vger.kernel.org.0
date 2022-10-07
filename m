Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8307A5F76B0
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJGKNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 06:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGKNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 06:13:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98ECF870;
        Fri,  7 Oct 2022 03:13:41 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MkPDH0QXKzVhjy;
        Fri,  7 Oct 2022 18:09:19 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 18:13:37 +0800
Message-ID: <a008c3a4-5a0a-30c6-0b3b-c312a6b02635@huawei.com>
Date:   Fri, 7 Oct 2022 18:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
 <YzG51Jyd5zhvygtK@arm.com> <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
 <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
 <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home>
 <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
 <20221006122922.53802a5c@gandalf.local.home>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20221006122922.53802a5c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/2022 12:29 AM, Steven Rostedt wrote:
> On Thu, 6 Oct 2022 18:19:12 +0200
> Florent Revest <revest@chromium.org> wrote:
> 
>> Sure, we can give this a try, I'll work on a macro that generates the
>> 7 callbacks and we can check how much that helps. My belief right now
>> is that ftrace's iteration over all ops on arm64 is where we lose most
>> time but now that we have numbers it's pretty easy to check hypothesis
>> :)
> 
> Ah, I forgot that's what Mark's code is doing. But yes, that needs to be
> fixed first. I forget that arm64 doesn't have the dedicated trampolines yet.
> 
> So, let's hold off until that is complete.
> 
> -- Steve
> 
> .


Here is the perf data I captured.

1. perf report

     99.94%     0.00%  ld-linux-aarch6  bench                                           [.] trigger_producer
             |
             ---trigger_producer
                |
                |--98.04%--syscall
                |          |
                |           --81.35%--el0t_64_sync
                |                     el0t_64_sync_handler
                |                     el0_svc
                |                     do_el0_svc
                |                     |
                |                     |--80.75%--el0_svc_common.constprop.0
                |                     |          |
                |                     |          |--49.70%--invoke_syscall
                |                     |          |          |
                |                     |          |           --46.66%--__arm64_sys_getpgid
                |                     |          |                     |
                |                     |          |                     |--40.73%--ftrace_call
                |                     |          |                     |          |
                |                     |          |                     |          |--38.71%--ftrace_ops_list_func
                |                     |          |                     |          |          |
                |                     |          |                     |          |          |--25.06%--fprobe_handler
                |                     |          |                     |          |          |          |
                |                     |          |                     |          |          |          |--13.20%--bpf_fprobe_entry
                |                     |          |                     |          |          |          |          |
                |                     |          |                     |          |          |          |           --11.47%--call_bpf_prog.isra.0
                |                     |          |                     |          |          |          |                     |
                |                     |          |                     |          |          |          |                     |--4.08%--__bpf_prog_exit
                |                     |          |                     |          |          |          |                     |          |
                |                     |          |                     |          |          |          |                     |           --0.87%--migrate_enable
                |                     |          |                     |          |          |          |                     |
                |                     |          |                     |          |          |          |                     |--2.46%--__bpf_prog_enter
                |                     |          |                     |          |          |          |                     |
                |                     |          |                     |          |          |          |                      --2.18%--bpf_prog_21856463590f61f1_bench_trigger_fentry
                |                     |          |                     |          |          |          |
                |                     |          |                     |          |          |          |--8.68%--rethook_trampoline_handler
                |                     |          |                     |          |          |          |
                |                     |          |                     |          |          |           --1.59%--rethook_try_get
                |                     |          |                     |          |          |                     |
                |                     |          |                     |          |          |                      --0.58%--rcu_is_watching
                |                     |          |                     |          |          |
                |                     |          |                     |          |          |--6.65%--rethook_trampoline_handler
                |                     |          |                     |          |          |
                |                     |          |                     |          |           --0.77%--rethook_recycle
                |                     |          |                     |          |
                |                     |          |                     |           --1.74%--hash_contains_ip.isra.0
                |                     |          |                     |
                |                     |          |                      --3.62%--find_task_by_vpid
                |                     |          |                                |
                |                     |          |                                 --2.75%--idr_find
                |                     |          |                                           |
                |                     |          |                                            --2.17%--__radix_tree_lookup
                |                     |          |
                |                     |           --1.30%--ftrace_caller
                |                     |
                |                      --0.60%--invoke_syscall
                |
                |--0.88%--0xffffb2807594
                |
                 --0.87%--syscall@plt


2. perf annotate

2.1 ftrace_caller

          : 39               SYM_CODE_START(ftrace_caller)
          : 40               bti     c
     0.00 :   ffff80000802e0c4:       bti     c
          :
          : 39               /* Save original SP */
          : 40               mov     x10, sp
     0.00 :   ffff80000802e0c8:       mov     x10, sp
          :
          : 42               /* Make room for pt_regs, plus two frame records */
          : 43               sub     sp, sp, #(FREGS_SIZE + 32)
     0.00 :   ffff80000802e0cc:       sub     sp, sp, #0x90
          :
          : 45               /* Save function arguments */
          : 46               stp     x0, x1, [sp, #FREGS_X0]
     0.00 :   ffff80000802e0d0:       stp     x0, x1, [sp]
          : 45               stp     x2, x3, [sp, #FREGS_X2]
     0.00 :   ffff80000802e0d4:       stp     x2, x3, [sp, #16]
          : 46               stp     x4, x5, [sp, #FREGS_X4]
    16.67 :   ffff80000802e0d8:       stp     x4, x5, [sp, #32] // entry-ftrace.S:46
          : 47               stp     x6, x7, [sp, #FREGS_X6]
     8.33 :   ffff80000802e0dc:       stp     x6, x7, [sp, #48] // entry-ftrace.S:47
          : 48               str     x8,     [sp, #FREGS_X8]
     0.00 :   ffff80000802e0e0:       str     x8, [sp, #64]
          :
          : 52               /* Save the callsite's FP, LR, SP */
          : 53               str     x29, [sp, #FREGS_FP]
     8.33 :   ffff80000802e0e4:       str     x29, [sp, #80] // entry-ftrace.S:51
          : 52               str     x9,  [sp, #FREGS_LR]
     8.33 :   ffff80000802e0e8:       str     x9, [sp, #88] // entry-ftrace.S:52
          : 53               str     x10, [sp, #FREGS_SP]
     0.00 :   ffff80000802e0ec:       str     x10, [sp, #96]
          :
          : 57               /* Save the PC after the ftrace callsite */
          : 58               str     x30, [sp, #FREGS_PC]
    16.67 :   ffff80000802e0f0:       str     x30, [sp, #104] // entry-ftrace.S:56
          :
          : 60               /* Create a frame record for the callsite above the ftrace regs */
          : 61               stp     x29, x9, [sp, #FREGS_SIZE + 16]
    16.67 :   ffff80000802e0f4:       stp     x29, x9, [sp, #128] // entry-ftrace.S:59
          : 60               add     x29, sp, #FREGS_SIZE + 16
     0.00 :   ffff80000802e0f8:       add     x29, sp, #0x80
          :
          : 64               /* Create our frame record above the ftrace regs */
          : 65               stp     x29, x30, [sp, #FREGS_SIZE]
    16.67 :   ffff80000802e0fc:       stp     x29, x30, [sp, #112] // entry-ftrace.S:63
          : 64               add     x29, sp, #FREGS_SIZE
     0.00 :   ffff80000802e100:       add     x29, sp, #0x70
          :
          : 67               sub     x0, x30, #AARCH64_INSN_SIZE     // ip (callsite's BL insn)
     0.00 :   ffff80000802e104:       sub     x0, x30, #0x4
          : 67               mov     x1, x9                          // parent_ip (callsite's LR)
     0.00 :   ffff80000802e108:       mov     x1, x9
          : 68               ldr_l   x2, function_trace_op           // op
     0.00 :   ffff80000802e10c:       adrp    x2, ffff800009638000 <folio_wait_table+0x14c0>
     0.00 :   ffff80000802e110:       ldr     x2, [x2, #3320]
          : 69               mov     x3, sp                          // regs
     0.00 :   ffff80000802e114:       mov     x3, sp
          :
          : 72               ffff80000802e118 <ftrace_call>:
          :
          : 73               SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
          : 74               bl      ftrace_stub
     0.00 :   ffff80000802e118:       bl      ffff80000802e144 <ftrace_stub>
          : 80               * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
          : 81               * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
          : 82               * to restore x0-x8, x29, and x30.
          : 83               */
          : 84               /* Restore function arguments */
          : 85               ldp     x0, x1, [sp, #FREGS_X0]
     8.33 :   ffff80000802e11c:       ldp     x0, x1, [sp] // entry-ftrace.S:80
          : 81               ldp     x2, x3, [sp, #FREGS_X2]
     0.00 :   ffff80000802e120:       ldp     x2, x3, [sp, #16]
          : 82               ldp     x4, x5, [sp, #FREGS_X4]
     0.00 :   ffff80000802e124:       ldp     x4, x5, [sp, #32]
          : 83               ldp     x6, x7, [sp, #FREGS_X6]
     0.00 :   ffff80000802e128:       ldp     x6, x7, [sp, #48]
          : 84               ldr     x8,     [sp, #FREGS_X8]
     0.00 :   ffff80000802e12c:       ldr     x8, [sp, #64]
          :
          : 88               /* Restore the callsite's FP, LR, PC */
          : 89               ldr     x29, [sp, #FREGS_FP]
     0.00 :   ffff80000802e130:       ldr     x29, [sp, #80]
          : 88               ldr     x30, [sp, #FREGS_LR]
     0.00 :   ffff80000802e134:       ldr     x30, [sp, #88]
          : 89               ldr     x9,  [sp, #FREGS_PC]
     0.00 :   ffff80000802e138:       ldr     x9, [sp, #104]
          :
          : 93               /* Restore the callsite's SP */
          : 94               add     sp, sp, #FREGS_SIZE + 32
     0.00 :   ffff80000802e13c:       add     sp, sp, #0x90
          :
          : 95               ret     x9
     0.00 :   ffff80000802e140:       ret     x9


2.2 arch_ftrace_ops_list_func

          : 7554             void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
          : 7555             struct ftrace_ops *op, struct ftrace_regs *fregs)
          : 7556             {
     0.00 :   ffff80000815bdf0:       paciasp
     4.65 :   ffff80000815bdf4:       stp     x29, x30, [sp, #-144]! // ftrace.c:7551
     0.00 :   ffff80000815bdf8:       mrs     x2, sp_el0
     0.00 :   ffff80000815bdfc:       mov     x29, sp
     2.32 :   ffff80000815be00:       stp     x19, x20, [sp, #16]
     0.00 :   ffff80000815be04:       mov     x20, x1
          : 7563             trace_test_and_set_recursion():
          : 147              int start)
          : 148              {
          : 149              unsigned int val = READ_ONCE(current->trace_recursion);
          : 150              int bit;
          :
          : 152              bit = trace_get_context_bit() + start;
     0.00 :   ffff80000815be08:       mov     w5, #0x8                        // #8
          : 154              arch_ftrace_ops_list_func():
     0.00 :   ffff80000815be0c:       stp     x21, x22, [sp, #32]
     0.00 :   ffff80000815be10:       mov     x21, x3
     2.32 :   ffff80000815be14:       stp     x23, x24, [sp, #48]
     0.00 :   ffff80000815be18:       mov     x23, x0
     0.00 :   ffff80000815be1c:       ldr     x4, [x2, #1168]
     2.32 :   ffff80000815be20:       str     x4, [sp, #136]
     0.00 :   ffff80000815be24:       mov     x4, #0x0                        // #0
          : 7558             trace_test_and_set_recursion():
          : 148              if (unlikely(val & (1 << bit))) {
     0.00 :   ffff80000815be28:       mov     w2, #0x1                        // #1
          : 150              get_current():
          : 19               */
          : 20               static __always_inline struct task_struct *get_current(void)
          : 21               {
          : 22               unsigned long sp_el0;
          :
          : 24               asm ("mrs %0, sp_el0" : "=r" (sp_el0));
     0.00 :   ffff80000815be2c:       mrs     x4, sp_el0
          : 26               trace_test_and_set_recursion():
          : 144              unsigned int val = READ_ONCE(current->trace_recursion);
     0.00 :   ffff80000815be30:       ldr     x7, [x4, #2520]
          : 146              preempt_count():
          : 13               #define PREEMPT_NEED_RESCHED    BIT(32)
          : 14               #define PREEMPT_ENABLED (PREEMPT_NEED_RESCHED)
          :
          : 16               static inline int preempt_count(void)
          : 17               {
          : 18               return READ_ONCE(current_thread_info()->preempt.count);
     0.00 :   ffff80000815be34:       ldr     w6, [x4, #8]
          : 20               interrupt_context_level():
          : 94               static __always_inline unsigned char interrupt_context_level(void)
          : 95               {
          : 96               unsigned long pc = preempt_count();
          : 97               unsigned char level = 0;
          :
          : 99               level += !!(pc & (NMI_MASK));
     0.00 :   ffff80000815be38:       tst     w6, #0xf00000
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
          : 97               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff80000815be3c:       and     w1, w6, #0xffff00
          : 94               level += !!(pc & (NMI_MASK));
     0.00 :   ffff80000815be40:       cset    w4, ne  // ne = any
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff80000815be44:       and     w1, w1, #0xffff01ff
          : 95               level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
     0.00 :   ffff80000815be48:       tst     w6, #0xff0000
     0.00 :   ffff80000815be4c:       cinc    w4, w4, ne      // ne = any
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff80000815be50:       cmp     w1, #0x0
          : 98               trace_get_context_bit():
          : 121              return TRACE_CTX_NORMAL - bit;
     0.00 :   ffff80000815be54:       cinc    w4, w4, ne      // ne = any
          : 123              trace_test_and_set_recursion():
          : 147              bit = trace_get_context_bit() + start;
     0.00 :   ffff80000815be58:       sub     w5, w5, w4
          : 148              if (unlikely(val & (1 << bit))) {
     0.00 :   ffff80000815be5c:       lsl     w2, w2, w5
     0.00 :   ffff80000815be60:       tst     w2, w7
     0.00 :   ffff80000815be64:       b.ne    ffff80000815bf84 <arch_ftrace_ops_list_func+0x194>  // b.any
          : 152              trace_clear_recursion():
          : 180              */
          : 181              static __always_inline void trace_clear_recursion(int bit)
          : 182              {
          : 183              preempt_enable_notrace();
          : 184              barrier();
          : 185              trace_recursion_clear(bit);
     4.65 :   ffff80000815be68:       mvn     w22, w2 // trace_recursion.h:180
     0.00 :   ffff80000815be6c:       str     x25, [sp, #64]
     0.00 :   ffff80000815be70:       sxtw    x22, w22
          : 189              trace_test_and_set_recursion():
          : 165              current->trace_recursion = val;
     0.00 :   ffff80000815be74:       orr     w2, w2, w7
          : 167              get_current():
     0.00 :   ffff80000815be78:       mrs     x4, sp_el0
          : 20               trace_test_and_set_recursion():
     2.32 :   ffff80000815be7c:       str     x2, [x4, #2520] // trace_recursion.h:165
          : 166              __preempt_count_add():
          : 47               return !current_thread_info()->preempt.need_resched;
          : 48               }
          :
          : 50               static inline void __preempt_count_add(int val)
          : 51               {
          : 52               u32 pc = READ_ONCE(current_thread_info()->preempt.count);
     0.00 :   ffff80000815be80:       ldr     w1, [x4, #8]
          : 48               pc += val;
     0.00 :   ffff80000815be84:       add     w1, w1, #0x1
          : 49               WRITE_ONCE(current_thread_info()->preempt.count, pc);
     2.32 :   ffff80000815be88:       str     w1, [x4, #8] // preempt.h:49
          : 51               __ftrace_ops_list_func():
          : 7506             do_for_each_ftrace_op(op, ftrace_ops_list) {
     0.00 :   ffff80000815be8c:       adrp    x0, ffff800009638000 <folio_wait_table+0x14c0>
     0.00 :   ffff80000815be90:       add     x25, x0, #0xc28
          : 7527             } while_for_each_ftrace_op(op);
     0.00 :   ffff80000815be94:       add     x24, x25, #0x8
          : 7506             do_for_each_ftrace_op(op, ftrace_ops_list) {
     0.00 :   ffff80000815be98:       ldr     x19, [x0, #3112]
          : 7508             if (op->flags & FTRACE_OPS_FL_STUB)
     4.72 :   ffff80000815be9c:       ldr     x0, [x19, #16] // ftrace.c:7508
     0.00 :   ffff80000815bea0:       tbnz    w0, #5, ffff80000815bef8 <arch_ftrace_ops_list_func+0x108>
          : 7519             if ((!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching()) &&
     2.32 :   ffff80000815bea4:       tbnz    w0, #14, ffff80000815bf74 <arch_ftrace_ops_list_func+0x184> // ftrace.c:7519
          : 7521             ftrace_ops_test():
          : 1486             rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
     2.32 :   ffff80000815bea8:       ldr     x0, [x19, #88] // ftrace.c:1486
     0.00 :   ffff80000815beac:       add     x1, sp, #0x60
     0.00 :   ffff80000815beb0:       ldr     x0, [x0, #8]
     0.00 :   ffff80000815beb4:       stlr    x0, [x1]
          : 1487             rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);
     0.00 :   ffff80000815beb8:       ldr     x0, [x19, #88]
     0.00 :   ffff80000815bebc:       add     x1, sp, #0x58
     0.00 :   ffff80000815bec0:       ldr     x0, [x0]
     2.32 :   ffff80000815bec4:       stlr    x0, [x1] // ftrace.c:1487
          : 1489             if (hash_contains_ip(ip, &hash))
    44.15 :   ffff80000815bec8:       ldp     x1, x2, [sp, #88] // ftrace.c:1489
     0.00 :   ffff80000815becc:       mov     x0, x23
     0.00 :   ffff80000815bed0:       bl      ffff80000815b530 <hash_contains_ip.isra.0>
     0.00 :   ffff80000815bed4:       tst     w0, #0xff
     0.00 :   ffff80000815bed8:       b.eq    ffff80000815bef8 <arch_ftrace_ops_list_func+0x108>  // b.none
          : 1495             __ftrace_ops_list_func():
          : 7521             if (FTRACE_WARN_ON(!op->func)) {
     0.00 :   ffff80000815bedc:       ldr     x4, [x19]
     0.00 :   ffff80000815bee0:       cbz     x4, ffff80000815bfa0 <arch_ftrace_ops_list_func+0x1b0>
          : 7525             op->func(ip, parent_ip, op, fregs);
     0.00 :   ffff80000815bee4:       mov     x3, x21
     0.00 :   ffff80000815bee8:       mov     x2, x19
     0.00 :   ffff80000815beec:       mov     x1, x20
     0.00 :   ffff80000815bef0:       mov     x0, x23
     0.00 :   ffff80000815bef4:       blr     x4
          : 7527             } while_for_each_ftrace_op(op);
     0.00 :   ffff80000815bef8:       ldr     x19, [x19, #8]
     0.00 :   ffff80000815befc:       cmp     x19, #0x0
     0.00 :   ffff80000815bf00:       ccmp    x19, x24, #0x4, ne      // ne = any
     0.00 :   ffff80000815bf04:       b.ne    ffff80000815be9c <arch_ftrace_ops_list_func+0xac>  // b.any
          : 7532             get_current():
     0.00 :   ffff80000815bf08:       mrs     x1, sp_el0
          : 20               __preempt_count_dec_and_test():
          : 62               }
          :
          : 64               static inline bool __preempt_count_dec_and_test(void)
          : 65               {
          : 66               struct thread_info *ti = current_thread_info();
          : 67               u64 pc = READ_ONCE(ti->preempt_count);
     0.00 :   ffff80000815bf0c:       ldr     x0, [x1, #8]
          :
          : 66               /* Update only the count field, leaving need_resched unchanged */
          : 67               WRITE_ONCE(ti->preempt.count, --pc);
     0.00 :   ffff80000815bf10:       sub     x0, x0, #0x1
     0.00 :   ffff80000815bf14:       str     w0, [x1, #8]
          : 74               * need of a reschedule. Otherwise, we need to reload the
          : 75               * preempt_count in case the need_resched flag was cleared by an
          : 76               * interrupt occurring between the non-atomic READ_ONCE/WRITE_ONCE
          : 77               * pair.
          : 78               */
          : 79               return !pc || !READ_ONCE(ti->preempt_count);
     0.00 :   ffff80000815bf18:       cbnz    x0, ffff80000815bf64 <arch_ftrace_ops_list_func+0x174>
          : 81               trace_clear_recursion():
          : 178              preempt_enable_notrace();
     0.00 :   ffff80000815bf1c:       bl      ffff800008ae88d0 <preempt_schedule_notrace>
          : 180              get_current():
     2.32 :   ffff80000815bf20:       mrs     x1, sp_el0 // current.h:19
          : 20               trace_clear_recursion():
          : 180              trace_recursion_clear(bit);
     0.00 :   ffff80000815bf24:       ldr     x0, [x1, #2520]
     0.00 :   ffff80000815bf28:       and     x0, x0, x22
     2.32 :   ffff80000815bf2c:       str     x0, [x1, #2520] // trace_recursion.h:180
          : 184              arch_ftrace_ops_list_func():
          : 7553             __ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
          : 7554             }
     0.00 :   ffff80000815bf30:       ldr     x25, [sp, #64]
     0.00 :   ffff80000815bf34:       mrs     x0, sp_el0
     2.32 :   ffff80000815bf38:       ldr     x2, [sp, #136] // ftrace.c:7553
     0.00 :   ffff80000815bf3c:       ldr     x1, [x0, #1168]
     0.00 :   ffff80000815bf40:       subs    x2, x2, x1
     0.00 :   ffff80000815bf44:       mov     x1, #0x0                        // #0
     0.00 :   ffff80000815bf48:       b.ne    ffff80000815bf98 <arch_ftrace_ops_list_func+0x1a8>  // b.any
     2.32 :   ffff80000815bf4c:       ldp     x19, x20, [sp, #16]
     0.00 :   ffff80000815bf50:       ldp     x21, x22, [sp, #32]
     2.32 :   ffff80000815bf54:       ldp     x23, x24, [sp, #48]
     0.00 :   ffff80000815bf58:       ldp     x29, x30, [sp], #144
     0.00 :   ffff80000815bf5c:       autiasp
     0.00 :   ffff80000815bf60:       ret
          : 7568             __preempt_count_dec_and_test():
    11.62 :   ffff80000815bf64:       ldr     x0, [x1, #8] // preempt.h:74
     0.00 :   ffff80000815bf68:       cbnz    x0, ffff80000815bf20 <arch_ftrace_ops_list_func+0x130>
          : 76               trace_clear_recursion():
          : 178              preempt_enable_notrace();
     0.00 :   ffff80000815bf6c:       bl      ffff800008ae88d0 <preempt_schedule_notrace>
     0.00 :   ffff80000815bf70:       b       ffff80000815bf20 <arch_ftrace_ops_list_func+0x130>
          : 181              __ftrace_ops_list_func():
          : 7519             if ((!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching()) &&
     0.00 :   ffff80000815bf74:       bl      ffff8000080e5770 <rcu_is_watching>
     0.00 :   ffff80000815bf78:       tst     w0, #0xff
     0.00 :   ffff80000815bf7c:       b.ne    ffff80000815bea8 <arch_ftrace_ops_list_func+0xb8>  // b.any
     0.00 :   ffff80000815bf80:       b       ffff80000815bef8 <arch_ftrace_ops_list_func+0x108>
          : 7524             trace_test_and_set_recursion():
          : 158              if (val & (1 << bit)) {
     0.00 :   ffff80000815bf84:       tbnz    w7, #9, ffff80000815bf34 <arch_ftrace_ops_list_func+0x144>
     0.00 :   ffff80000815bf88:       mov     x22, #0xfffffffffffffdff        // #-513
     0.00 :   ffff80000815bf8c:       mov     w2, #0x200                      // #512
     0.00 :   ffff80000815bf90:       str     x25, [sp, #64]
     0.00 :   ffff80000815bf94:       b       ffff80000815be74 <arch_ftrace_ops_list_func+0x84>
     0.00 :   ffff80000815bf98:       str     x25, [sp, #64]
          : 165              arch_ftrace_ops_list_func():
          : 7553             }
     0.00 :   ffff80000815bf9c:       bl      ffff800008ae5de0 <__stack_chk_fail>
          : 7555             __ftrace_ops_list_func():
          : 7521             if (FTRACE_WARN_ON(!op->func)) {
     0.00 :   ffff80000815bfa0:       brk     #0x800
          : 7523             ftrace_kill():
          : 8040             */
          : 8041             void ftrace_kill(void)
          : 8042             {
          : 8043             ftrace_disabled = 1;
          : 8044             ftrace_enabled = 0;
          : 8045             ftrace_trace_function = ftrace_stub;
     0.00 :   ffff80000815bfa4:       adrp    x3, ffff80000802e000 <arch_ftrace_update_code+0x10>
     0.00 :   ffff80000815bfa8:       add     x3, x3, #0x144
          : 8038             ftrace_disabled = 1;
     0.00 :   ffff80000815bfac:       mov     w4, #0x1                        // #1
          : 8040             __ftrace_ops_list_func():
          : 7522             pr_warn("op=%p %pS\n", op, op);
     0.00 :   ffff80000815bfb0:       mov     x2, x19
     0.00 :   ffff80000815bfb4:       mov     x1, x19
     0.00 :   ffff80000815bfb8:       adrp    x0, ffff800008d80000 <kallsyms_token_index+0x17f60>
     0.00 :   ffff80000815bfbc:       add     x0, x0, #0x678
          : 7527             ftrace_kill():
          : 8040             ftrace_trace_function = ftrace_stub;
     0.00 :   ffff80000815bfc0:       str     x3, [x25, #192]
          : 8039             ftrace_enabled = 0;
     0.00 :   ffff80000815bfc4:       stp     w4, wzr, [x25, #200]
          : 8041             __ftrace_ops_list_func():
          : 7522             pr_warn("op=%p %pS\n", op, op);
     0.00 :   ffff80000815bfc8:       bl      ffff800008ad5220 <_printk>
          : 7523             goto out;
     0.00 :   ffff80000815bfcc:       b       ffff80000815bf08 <arch_ftrace_ops_list_func+0x118>


2.3 fprobe_handler

          : 28               static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
          : 29               struct ftrace_ops *ops, struct ftrace_regs *fregs)
          : 30               {
     0.00 :   ffff8000081a2020:       paciasp
     0.00 :   ffff8000081a2024:       stp     x29, x30, [sp, #-64]!
     0.00 :   ffff8000081a2028:       mov     x29, sp
     0.00 :   ffff8000081a202c:       stp     x19, x20, [sp, #16]
     0.00 :   ffff8000081a2030:       mov     x19, x2
     0.00 :   ffff8000081a2034:       stp     x21, x22, [sp, #32]
     0.00 :   ffff8000081a2038:       mov     x22, x3
     0.00 :   ffff8000081a203c:       str     x23, [sp, #48]
     0.00 :   ffff8000081a2040:       mov     x23, x0
          : 40               fprobe_disabled():
          : 49               */
          : 50               #define FPROBE_FL_KPROBE_SHARED 2
          :
          : 52               static inline bool fprobe_disabled(struct fprobe *fp)
          : 53               {
          : 54               return (fp) ? fp->flags & FPROBE_FL_DISABLED : false;
     0.00 :   ffff8000081a2044:       cbz     x2, ffff8000081a2050 <fprobe_handler+0x30>
    20.00 :   ffff8000081a2048:       ldr     w0, [x2, #192] // fprobe.h:49
     0.00 :   ffff8000081a204c:       tbnz    w0, #0, ffff8000081a2128 <fprobe_handler+0x108>
          : 58               get_current():
          : 19               */
          : 20               static __always_inline struct task_struct *get_current(void)
          : 21               {
          : 22               unsigned long sp_el0;
          :
          : 24               asm ("mrs %0, sp_el0" : "=r" (sp_el0));
     0.00 :   ffff8000081a2050:       mrs     x0, sp_el0
          : 26               trace_test_and_set_recursion():
          : 144              * Preemption is promised to be disabled when return bit >= 0.
          : 145              */
          : 146              static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
          : 147              int start)
          : 148              {
          : 149              unsigned int val = READ_ONCE(current->trace_recursion);
    10.00 :   ffff8000081a2054:       ldr     x9, [x0, #2520] // trace_recursion.h:144
          : 151              trace_get_context_bit():
          : 121              return TRACE_CTX_NORMAL - bit;
     0.00 :   ffff8000081a2058:       mov     w6, #0x3                        // #3
          : 123              preempt_count():
          : 13               #define PREEMPT_NEED_RESCHED    BIT(32)
          : 14               #define PREEMPT_ENABLED (PREEMPT_NEED_RESCHED)
          :
          : 16               static inline int preempt_count(void)
          : 17               {
          : 18               return READ_ONCE(current_thread_info()->preempt.count);
     0.00 :   ffff8000081a205c:       ldr     w8, [x0, #8]
          : 20               trace_test_and_set_recursion():
          : 148              int bit;
          :
          : 150              bit = trace_get_context_bit() + start;
          : 151              if (unlikely(val & (1 << bit))) {
     0.00 :   ffff8000081a2060:       mov     w4, #0x1                        // #1
          : 153              interrupt_context_level():
          : 94               static __always_inline unsigned char interrupt_context_level(void)
          : 95               {
          : 96               unsigned long pc = preempt_count();
          : 97               unsigned char level = 0;
          :
          : 99               level += !!(pc & (NMI_MASK));
     0.00 :   ffff8000081a2064:       tst     w8, #0xf00000
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
          : 97               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff8000081a2068:       and     w7, w8, #0xffff00
          : 94               level += !!(pc & (NMI_MASK));
     0.00 :   ffff8000081a206c:       cset    w5, ne  // ne = any
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff8000081a2070:       and     w7, w7, #0xffff01ff
          : 95               level += !!(pc & (NMI_MASK | HARDIRQ_MASK));
     0.00 :   ffff8000081a2074:       tst     w8, #0xff0000
     0.00 :   ffff8000081a2078:       cinc    w5, w5, ne      // ne = any
          : 96               level += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
     0.00 :   ffff8000081a207c:       cmp     w7, #0x0
          : 98               trace_get_context_bit():
          : 121              return TRACE_CTX_NORMAL - bit;
     0.00 :   ffff8000081a2080:       cinc    w5, w5, ne      // ne = any
     0.00 :   ffff8000081a2084:       sub     w5, w6, w5
          : 124              trace_test_and_set_recursion():
          : 148              if (unlikely(val & (1 << bit))) {
     0.00 :   ffff8000081a2088:       lsl     w4, w4, w5
          : 150              trace_clear_recursion():
          : 180              */
          : 181              static __always_inline void trace_clear_recursion(int bit)
          : 182              {
          : 183              preempt_enable_notrace();
          : 184              barrier();
          : 185              trace_recursion_clear(bit);
    10.00 :   ffff8000081a208c:       mvn     w20, w4 // trace_recursion.h:180
     0.00 :   ffff8000081a2090:       sxtw    x20, w20
          : 188              trace_test_and_set_recursion():
          : 148              if (unlikely(val & (1 << bit))) {
     0.00 :   ffff8000081a2094:       tst     w4, w9
     0.00 :   ffff8000081a2098:       b.ne    ffff8000081a2194 <fprobe_handler+0x174>  // b.any
          : 165              current->trace_recursion = val;
     0.00 :   ffff8000081a209c:       orr     w4, w4, w9
          : 167              get_current():
     0.00 :   ffff8000081a20a0:       mrs     x5, sp_el0
          : 20               trace_test_and_set_recursion():
     0.00 :   ffff8000081a20a4:       str     x4, [x5, #2520]
          : 166              __preempt_count_add():
          : 47               return !current_thread_info()->preempt.need_resched;
          : 48               }
          :
          : 50               static inline void __preempt_count_add(int val)
          : 51               {
          : 52               u32 pc = READ_ONCE(current_thread_info()->preempt.count);
     0.00 :   ffff8000081a20a8:       ldr     w4, [x5, #8]
          : 48               pc += val;
     0.00 :   ffff8000081a20ac:       add     w4, w4, #0x1
          : 49               WRITE_ONCE(current_thread_info()->preempt.count, pc);
     0.00 :   ffff8000081a20b0:       str     w4, [x5, #8]
          : 51               fprobe_handler():
          : 43               if (bit < 0) {
          : 44               fp->nmissed++;
          : 45               return;
          : 46               }
          :
          : 48               if (fp->exit_handler) {
     0.00 :   ffff8000081a20b4:       ldr     x0, [x19, #224]
     0.00 :   ffff8000081a20b8:       cbz     x0, ffff8000081a2140 <fprobe_handler+0x120>
          : 44               rh = rethook_try_get(fp->rethook);
    10.00 :   ffff8000081a20bc:       ldr     x0, [x19, #200] // fprobe.c:44
     0.00 :   ffff8000081a20c0:       bl      ffff8000081a2a54 <rethook_try_get>
     0.00 :   ffff8000081a20c4:       mov     x21, x0
          : 45               if (!rh) {
     0.00 :   ffff8000081a20c8:       cbz     x0, ffff8000081a21a4 <fprobe_handler+0x184>
          : 50               fp->nmissed++;
          : 51               goto out;
          : 52               }
          : 53               fpr = container_of(rh, struct fprobe_rethook_node, node);
          : 54               fpr->entry_ip = ip;
     0.00 :   ffff8000081a20cc:       str     x23, [x0, #48]
          : 54               private = fpr->private;
          : 55               }
          :
          : 57               if (fp->entry_handler)
     0.00 :   ffff8000081a20d0:       ldr     x4, [x19, #216]
     0.00 :   ffff8000081a20d4:       cbz     x4, ffff8000081a2180 <fprobe_handler+0x160>
          : 55               should_rethook = fp->entry_handler(fp, ip, fregs, fpr->private);
     0.00 :   ffff8000081a20d8:       mov     x1, x23
     0.00 :   ffff8000081a20dc:       mov     x0, x19
     0.00 :   ffff8000081a20e0:       add     x3, x21, #0x38
     0.00 :   ffff8000081a20e4:       mov     x2, x22
     0.00 :   ffff8000081a20e8:       blr     x4
          :
          : 59               if (rh) {
          : 60               if (should_rethook)
     0.00 :   ffff8000081a20ec:       tst     w0, #0xff
     0.00 :   ffff8000081a20f0:       b.ne    ffff8000081a2180 <fprobe_handler+0x160>  // b.any
          : 61               rethook_hook(rh, fregs, true);
          : 62               else
          : 63               rethook_recycle(rh);
     0.00 :   ffff8000081a20f4:       mov     x0, x21
     0.00 :   ffff8000081a20f8:       bl      ffff8000081a2bf0 <rethook_recycle>
          : 66               get_current():
     0.00 :   ffff8000081a20fc:       mrs     x1, sp_el0
          : 20               __preempt_count_dec_and_test():
          : 62               }
          :
          : 64               static inline bool __preempt_count_dec_and_test(void)
          : 65               {
          : 66               struct thread_info *ti = current_thread_info();
          : 67               u64 pc = READ_ONCE(ti->preempt_count);
     0.00 :   ffff8000081a2100:       ldr     x0, [x1, #8]
          :
          : 66               /* Update only the count field, leaving need_resched unchanged */
          : 67               WRITE_ONCE(ti->preempt.count, --pc);
     0.00 :   ffff8000081a2104:       sub     x0, x0, #0x1
     0.00 :   ffff8000081a2108:       str     w0, [x1, #8]
          : 74               * need of a reschedule. Otherwise, we need to reload the
          : 75               * preempt_count in case the need_resched flag was cleared by an
          : 76               * interrupt occurring between the non-atomic READ_ONCE/WRITE_ONCE
          : 77               * pair.
          : 78               */
          : 79               return !pc || !READ_ONCE(ti->preempt_count);
     0.00 :   ffff8000081a210c:       cbnz    x0, ffff8000081a2170 <fprobe_handler+0x150>
          : 81               trace_clear_recursion():
          : 178              preempt_enable_notrace();
     0.00 :   ffff8000081a2110:       bl      ffff800008ae88d0 <preempt_schedule_notrace>
     0.00 :   ffff8000081a2114:       nop
          : 181              get_current():
    10.00 :   ffff8000081a2118:       mrs     x1, sp_el0 // current.h:19
          : 20               trace_clear_recursion():
          : 180              trace_recursion_clear(bit);
     0.00 :   ffff8000081a211c:       ldr     x0, [x1, #2520]
     0.00 :   ffff8000081a2120:       and     x0, x0, x20
    10.00 :   ffff8000081a2124:       str     x0, [x1, #2520] // trace_recursion.h:180
          : 184              fprobe_handler():
          : 66               }
          :
          : 68               out:
          : 69               ftrace_test_recursion_unlock(bit);
          : 70               }
     0.00 :   ffff8000081a2128:       ldp     x19, x20, [sp, #16]
     0.00 :   ffff8000081a212c:       ldp     x21, x22, [sp, #32]
     0.00 :   ffff8000081a2130:       ldr     x23, [sp, #48]
    20.00 :   ffff8000081a2134:       ldp     x29, x30, [sp], #64 // fprobe.c:66
     0.00 :   ffff8000081a2138:       autiasp
    10.00 :   ffff8000081a213c:       ret
          : 54               if (fp->entry_handler)
     0.00 :   ffff8000081a2140:       ldr     x4, [x19, #216]
     0.00 :   ffff8000081a2144:       cbz     x4, ffff8000081a215c <fprobe_handler+0x13c>
          : 55               should_rethook = fp->entry_handler(fp, ip, fregs, fpr->private);
     0.00 :   ffff8000081a2148:       mov     x2, x22
     0.00 :   ffff8000081a214c:       mov     x1, x23
     0.00 :   ffff8000081a2150:       mov     x0, x19
     0.00 :   ffff8000081a2154:       mov     x3, #0x38                       // #56
     0.00 :   ffff8000081a2158:       blr     x4
          : 61               get_current():
     0.00 :   ffff8000081a215c:       mrs     x1, sp_el0
          : 20               __preempt_count_dec_and_test():
          : 62               u64 pc = READ_ONCE(ti->preempt_count);
     0.00 :   ffff8000081a2160:       ldr     x0, [x1, #8]
          : 65               WRITE_ONCE(ti->preempt.count, --pc);
     0.00 :   ffff8000081a2164:       sub     x0, x0, #0x1
     0.00 :   ffff8000081a2168:       str     w0, [x1, #8]
          : 74               return !pc || !READ_ONCE(ti->preempt_count);
     0.00 :   ffff8000081a216c:       cbz     x0, ffff8000081a2110 <fprobe_handler+0xf0>
     0.00 :   ffff8000081a2170:       ldr     x0, [x1, #8]
     0.00 :   ffff8000081a2174:       cbnz    x0, ffff8000081a2118 <fprobe_handler+0xf8>
          : 78               trace_clear_recursion():
          : 178              preempt_enable_notrace();
     0.00 :   ffff8000081a2178:       bl      ffff800008ae88d0 <preempt_schedule_notrace>
     0.00 :   ffff8000081a217c:       b       ffff8000081a2118 <fprobe_handler+0xf8>
          : 181              fprobe_handler():
          : 59               rethook_hook(rh, fregs, true);
     0.00 :   ffff8000081a2180:       mov     x1, x22
     0.00 :   ffff8000081a2184:       mov     x0, x21
     0.00 :   ffff8000081a2188:       mov     w2, #0x1                        // #1
     0.00 :   ffff8000081a218c:       bl      ffff8000081a27d0 <rethook_hook>
     0.00 :   ffff8000081a2190:       b       ffff8000081a215c <fprobe_handler+0x13c>
          : 65               trace_test_and_set_recursion():
          : 158              if (val & (1 << bit)) {
     0.00 :   ffff8000081a2194:       tbnz    w9, #4, ffff8000081a21b4 <fprobe_handler+0x194>
     0.00 :   ffff8000081a2198:       mov     x20, #0xffffffffffffffef        // #-17
     0.00 :   ffff8000081a219c:       mov     w4, #0x10                       // #16
     0.00 :   ffff8000081a21a0:       b       ffff8000081a209c <fprobe_handler+0x7c>
          : 163              fprobe_handler():
          : 46               fp->nmissed++;
     0.00 :   ffff8000081a21a4:       ldr     x0, [x19, #184]
     0.00 :   ffff8000081a21a8:       add     x0, x0, #0x1
     0.00 :   ffff8000081a21ac:       str     x0, [x19, #184]
          : 47               goto out;
     0.00 :   ffff8000081a21b0:       b       ffff8000081a215c <fprobe_handler+0x13c>
          : 39               fp->nmissed++;
     0.00 :   ffff8000081a21b4:       ldr     x0, [x19, #184]
     0.00 :   ffff8000081a21b8:       add     x0, x0, #0x1
     0.00 :   ffff8000081a21bc:       str     x0, [x19, #184]
          : 40               return;
     0.00 :   ffff8000081a21c0:       b       ffff8000081a2128 <fprobe_handler+0x108>


2.4 bpf_fprobe_entry

          : 5                ffff8000081e19f0 <bpf_fprobe_entry>:
          : 6                bpf_fprobe_entry():
          : 1057             flags = u64_stats_update_begin_irqsave(&stats->syncp);
          : 1058             u64_stats_inc(&stats->cnt);
          : 1059             u64_stats_add(&stats->nsecs, sched_clock() - start);
          : 1060             u64_stats_update_end_irqrestore(&stats->syncp, flags);
          : 1061             }
          : 1062             }
     0.00 :   ffff8000081e19f0:       bti     c
     0.00 :   ffff8000081e19f4:       nop
     0.00 :   ffff8000081e19f8:       nop
          : 165              {
     0.00 :   ffff8000081e19fc:       paciasp
     0.00 :   ffff8000081e1a00:       stp     x29, x30, [sp, #-80]!
     0.00 :   ffff8000081e1a04:       mov     w4, #0x0                        // #0
     0.00 :   ffff8000081e1a08:       mov     x29, sp
     0.00 :   ffff8000081e1a0c:       stp     x19, x20, [sp, #16]
     0.00 :   ffff8000081e1a10:       mov     x19, x3
     0.00 :   ffff8000081e1a14:       stp     x21, x22, [sp, #32]
     0.00 :   ffff8000081e1a18:       mov     x22, x0
     0.00 :   ffff8000081e1a1c:       mov     x21, x2
     0.00 :   ffff8000081e1a20:       stp     x23, x24, [sp, #48]
     0.00 :   ffff8000081e1a24:       str     x25, [sp, #64]
          : 167              struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
     0.00 :   ffff8000081e1a28:       ldr     x24, [x0, #24]
          : 168              struct bpf_tramp_links *links = fprobe_ctx->links;
     0.00 :   ffff8000081e1a2c:       ldr     x23, [x24]
          : 174              memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
     0.00 :   ffff8000081e1a30:       stp     xzr, xzr, [x3]
          : 175              call_ctx->ip = ip;
     0.00 :   ffff8000081e1a34:       str     x1, [x3, #16]
          : 176              for (i = 0; i < fprobe_ctx->nr_args; i++)
     0.00 :   ffff8000081e1a38:       ldr     w0, [x24, #8]
     0.00 :   ffff8000081e1a3c:       cmp     w0, #0x0
     0.00 :   ffff8000081e1a40:       b.gt    ffff8000081e1a64 <bpf_fprobe_entry+0x74>
     0.00 :   ffff8000081e1a44:       b       ffff8000081e1a90 <bpf_fprobe_entry+0xa0>
          : 177              call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
     0.00 :   ffff8000081e1a48:       ldr     x0, [x21, x1, lsl #3]
     0.00 :   ffff8000081e1a4c:       add     x1, x19, x1, lsl #3
          : 176              for (i = 0; i < fprobe_ctx->nr_args; i++)
     0.00 :   ffff8000081e1a50:       add     w4, w4, #0x1
          : 177              call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
    16.67 :   ffff8000081e1a54:       str     x0, [x1, #24] // trampoline.c:177
          : 176              for (i = 0; i < fprobe_ctx->nr_args; i++)
     0.00 :   ffff8000081e1a58:       ldr     w0, [x24, #8]
     0.00 :   ffff8000081e1a5c:       cmp     w0, w4
     0.00 :   ffff8000081e1a60:       b.le    ffff8000081e1a90 <bpf_fprobe_entry+0xa0>
          : 177              call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
     8.33 :   ffff8000081e1a64:       sxtw    x1, w4
     0.00 :   ffff8000081e1a68:       mov     x0, #0x0                        // #0
     0.00 :   ffff8000081e1a6c:       cmp     w4, #0x7
     0.00 :   ffff8000081e1a70:       b.le    ffff8000081e1a48 <bpf_fprobe_entry+0x58>
     0.00 :   ffff8000081e1a74:       sxtw    x1, w4
          : 176              for (i = 0; i < fprobe_ctx->nr_args; i++)
     0.00 :   ffff8000081e1a78:       add     w4, w4, #0x1
          : 177              call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
     0.00 :   ffff8000081e1a7c:       add     x1, x19, x1, lsl #3
     0.00 :   ffff8000081e1a80:       str     x0, [x1, #24]
          : 176              for (i = 0; i < fprobe_ctx->nr_args; i++)
     0.00 :   ffff8000081e1a84:       ldr     w0, [x24, #8]
     0.00 :   ffff8000081e1a88:       cmp     w0, w4
     0.00 :   ffff8000081e1a8c:       b.gt    ffff8000081e1a64 <bpf_fprobe_entry+0x74>
          : 179              for (i = 0; i < fentry->nr_links; i++)
     0.00 :   ffff8000081e1a90:       ldr     w1, [x23, #304]
          : 185              call_ctx->args);
     0.00 :   ffff8000081e1a94:       add     x25, x19, #0x18
     0.00 :   ffff8000081e1a98:       mov     x20, #0x0                       // #0
          : 179              for (i = 0; i < fentry->nr_links; i++)
     0.00 :   ffff8000081e1a9c:       cmp     w1, #0x0
     0.00 :   ffff8000081e1aa0:       b.le    ffff8000081e1ad4 <bpf_fprobe_entry+0xe4>
     0.00 :   ffff8000081e1aa4:       nop
          : 180              call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
     0.00 :   ffff8000081e1aa8:       ldr     x1, [x23, x20, lsl #3]
     0.00 :   ffff8000081e1aac:       mov     x3, x25
     0.00 :   ffff8000081e1ab0:       mov     x2, x19
          : 179              for (i = 0; i < fentry->nr_links; i++)
     0.00 :   ffff8000081e1ab4:       add     x20, x20, #0x1
          : 180              call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
    16.67 :   ffff8000081e1ab8:       ldr     x0, [x1, #24] // trampoline.c:180
     0.00 :   ffff8000081e1abc:       ldr     x1, [x1, #80]
     0.00 :   ffff8000081e1ac0:       bl      ffff8000081e1800 <call_bpf_prog.isra.0>
          : 179              for (i = 0; i < fentry->nr_links; i++)
     0.00 :   ffff8000081e1ac4:       ldr     w0, [x23, #304]
     0.00 :   ffff8000081e1ac8:       cmp     w0, w20
     0.00 :   ffff8000081e1acc:       b.gt    ffff8000081e1aa8 <bpf_fprobe_entry+0xb8>
     0.00 :   ffff8000081e1ad0:       ldr     w0, [x24, #8]
          : 182              call_ctx->args[fprobe_ctx->nr_args] = 0;
     0.00 :   ffff8000081e1ad4:       add     x0, x19, w0, sxtw #3
          : 183              for (i = 0; i < fmod_ret->nr_links; i++) {
     0.00 :   ffff8000081e1ad8:       add     x25, x23, #0x270
          : 185              call_ctx->args);
     0.00 :   ffff8000081e1adc:       add     x24, x19, #0x18
     0.00 :   ffff8000081e1ae0:       mov     x20, #0x0                       // #0
          : 182              call_ctx->args[fprobe_ctx->nr_args] = 0;
    25.00 :   ffff8000081e1ae4:       str     xzr, [x0, #24] // trampoline.c:182
          : 183              for (i = 0; i < fmod_ret->nr_links; i++) {
     0.00 :   ffff8000081e1ae8:       ldr     w0, [x25, #304]
     0.00 :   ffff8000081e1aec:       cmp     w0, #0x0
     0.00 :   ffff8000081e1af0:       b.gt    ffff8000081e1b04 <bpf_fprobe_entry+0x114>
    16.67 :   ffff8000081e1af4:       b       ffff8000081e1ba8 <bpf_fprobe_entry+0x1b8> // trampoline.c:183
     0.00 :   ffff8000081e1af8:       ldr     w0, [x25, #304]
     0.00 :   ffff8000081e1afc:       cmp     w0, w20
     0.00 :   ffff8000081e1b00:       b.le    ffff8000081e1ba8 <bpf_fprobe_entry+0x1b8>
          : 184              ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
     0.00 :   ffff8000081e1b04:       ldr     x1, [x25, x20, lsl #3]
     0.00 :   ffff8000081e1b08:       mov     x3, x24
     0.00 :   ffff8000081e1b0c:       mov     x2, x19
          : 183              for (i = 0; i < fmod_ret->nr_links; i++) {
     0.00 :   ffff8000081e1b10:       add     x20, x20, #0x1
          : 184              ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
     0.00 :   ffff8000081e1b14:       ldr     x0, [x1, #24]
     0.00 :   ffff8000081e1b18:       ldr     x1, [x1, #80]
     0.00 :   ffff8000081e1b1c:       bl      ffff8000081e1800 <call_bpf_prog.isra.0>
          : 187              if (ret) {
     0.00 :   ffff8000081e1b20:       cbz     w0, ffff8000081e1af8 <bpf_fprobe_entry+0x108>
          : 189              ftrace_override_function_with_return(regs);
     0.00 :   ffff8000081e1b24:       ldr     x2, [x21, #88]
          : 188              ftrace_regs_set_return_value(regs, ret);
     0.00 :   ffff8000081e1b28:       sxtw    x1, w0
     0.00 :   ffff8000081e1b2c:       str     x1, [x21]
          : 191              bpf_fprobe_exit():
          : 160              for (i = 0; i < fexit->nr_links; i++)
     0.00 :   ffff8000081e1b30:       mov     x20, #0x0                       // #0
          : 162              bpf_fprobe_entry():
          : 189              ftrace_override_function_with_return(regs);
     0.00 :   ffff8000081e1b34:       str     x2, [x21, #104]
          : 191              bpf_fprobe_exit():
          : 153              struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
     0.00 :   ffff8000081e1b38:       ldr     x2, [x22, #24]
          : 158              call_ctx->args[fprobe_ctx->nr_args] = ftrace_regs_return_value(regs);
     0.00 :   ffff8000081e1b3c:       ldrsw   x0, [x2, #8]
          : 154              struct bpf_tramp_links *links = fprobe_ctx->links;
     0.00 :   ffff8000081e1b40:       ldr     x21, [x2]
          : 158              call_ctx->args[fprobe_ctx->nr_args] = ftrace_regs_return_value(regs);
     0.00 :   ffff8000081e1b44:       add     x0, x19, x0, lsl #3
          : 160              for (i = 0; i < fexit->nr_links; i++)
     0.00 :   ffff8000081e1b48:       add     x21, x21, #0x138
          : 158              call_ctx->args[fprobe_ctx->nr_args] = ftrace_regs_return_value(regs);
     0.00 :   ffff8000081e1b4c:       str     x1, [x0, #24]
          : 160              for (i = 0; i < fexit->nr_links; i++)
     0.00 :   ffff8000081e1b50:       ldr     w0, [x21, #304]
     0.00 :   ffff8000081e1b54:       cmp     w0, #0x0
     0.00 :   ffff8000081e1b58:       b.le    ffff8000081e1b88 <bpf_fprobe_entry+0x198>
     0.00 :   ffff8000081e1b5c:       nop
          : 161              call_bpf_prog(fexit->links[i], &call_ctx->ctx, call_ctx->args);
     0.00 :   ffff8000081e1b60:       ldr     x1, [x21, x20, lsl #3]
     0.00 :   ffff8000081e1b64:       mov     x3, x24
     0.00 :   ffff8000081e1b68:       mov     x2, x19
          : 160              for (i = 0; i < fexit->nr_links; i++)
     0.00 :   ffff8000081e1b6c:       add     x20, x20, #0x1
          : 161              call_bpf_prog(fexit->links[i], &call_ctx->ctx, call_ctx->args);
     0.00 :   ffff8000081e1b70:       ldr     x0, [x1, #24]
     0.00 :   ffff8000081e1b74:       ldr     x1, [x1, #80]
     0.00 :   ffff8000081e1b78:       bl      ffff8000081e1800 <call_bpf_prog.isra.0>
          : 160              for (i = 0; i < fexit->nr_links; i++)
     0.00 :   ffff8000081e1b7c:       ldr     w0, [x21, #304]
     0.00 :   ffff8000081e1b80:       cmp     w0, w20
     0.00 :   ffff8000081e1b84:       b.gt    ffff8000081e1b60 <bpf_fprobe_entry+0x170>
          : 164              bpf_fprobe_entry():
          : 192              return false;
     0.00 :   ffff8000081e1b88:       mov     w0, #0x0                        // #0
          : 197              }
     0.00 :   ffff8000081e1b8c:       ldp     x19, x20, [sp, #16]
     0.00 :   ffff8000081e1b90:       ldp     x21, x22, [sp, #32]
     0.00 :   ffff8000081e1b94:       ldp     x23, x24, [sp, #48]
     0.00 :   ffff8000081e1b98:       ldr     x25, [sp, #64]
     0.00 :   ffff8000081e1b9c:       ldp     x29, x30, [sp], #80
     0.00 :   ffff8000081e1ba0:       autiasp
     0.00 :   ffff8000081e1ba4:       ret
          : 196              return fexit->nr_links;
     0.00 :   ffff8000081e1ba8:       ldr     w0, [x23, #616]
          : 197              }
     0.00 :   ffff8000081e1bac:       ldp     x19, x20, [sp, #16]
          : 196              return fexit->nr_links;
     0.00 :   ffff8000081e1bb0:       cmp     w0, #0x0
     0.00 :   ffff8000081e1bb4:       cset    w0, ne  // ne = any
          : 197              }
     0.00 :   ffff8000081e1bb8:       ldp     x21, x22, [sp, #32]
     0.00 :   ffff8000081e1bbc:       ldp     x23, x24, [sp, #48]
     0.00 :   ffff8000081e1bc0:       ldr     x25, [sp, #64]
     0.00 :   ffff8000081e1bc4:       ldp     x29, x30, [sp], #80
     0.00 :   ffff8000081e1bc8:       autiasp
    16.67 :   ffff8000081e1bcc:       ret // trampoline.c:197

2.5 call_bpf_prog

          : 5                ffff8000081e1800 <call_bpf_prog.isra.0>:
          : 6                call_bpf_prog.isra.0():
          :
          : 200              if (oldp)
          : 201              *oldp = old;
          :
          : 203              if (unlikely(!old))
          : 204              refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
    13.33 :   ffff8000081e1800:       nop // refcount.h:199
     0.00 :   ffff8000081e1804:       nop
          : 207              call_bpf_prog():
          :
          : 108              mutex_unlock(&tr->mutex);
          : 109              return ret;
          : 110              }
          : 111              #else
          : 112              static unsigned int call_bpf_prog(struct bpf_tramp_link *l,
     0.00 :   ffff8000081e1808:       paciasp
     0.00 :   ffff8000081e180c:       stp     x29, x30, [sp, #-64]!
     0.00 :   ffff8000081e1810:       mov     x29, sp
     0.00 :   ffff8000081e1814:       stp     x19, x20, [sp, #16]
     0.00 :   ffff8000081e1818:       mov     x19, x0
     0.00 :   ffff8000081e181c:       mov     x20, x2
     0.00 :   ffff8000081e1820:       stp     x21, x22, [sp, #32]
     6.67 :   ffff8000081e1824:       stp     x23, x24, [sp, #48] // trampoline.c:107
     0.00 :   ffff8000081e1828:       mov     x24, x3
          : 118              struct bpf_tramp_run_ctx *run_ctx) = __bpf_prog_exit;
          : 119              struct bpf_prog *p = l->link.prog;
          : 120              unsigned int ret;
          : 121              u64 start_time;
          :
          : 123              if (p->aux->sleepable) {
    60.00 :   ffff8000081e182c:       ldr     x0, [x0, #56] // trampoline.c:118
    13.33 :   ffff8000081e1830:       ldrb    w0, [x0, #140]
     0.00 :   ffff8000081e1834:       cbnz    w0, ffff8000081e1858 <call_bpf_prog.isra.0+0x58>
          : 121              enter = __bpf_prog_enter_sleepable;
          : 122              exit = __bpf_prog_exit_sleepable;
          : 123              } else if (p->expected_attach_type == BPF_LSM_CGROUP) {
     0.00 :   ffff8000081e1838:       ldr     w0, [x19, #8]
     0.00 :   ffff8000081e183c:       cmp     w0, #0x2b
     0.00 :   ffff8000081e1840:       b.eq    ffff8000081e18c4 <call_bpf_prog.isra.0+0xc4>  // b.none
          : 112              void (*exit)(struct bpf_prog *prog, u64 start,
     0.00 :   ffff8000081e1844:       adrp    x22, ffff8000081e1000 <print_bpf_insn+0x580>
          : 110              u64 (*enter)(struct bpf_prog *prog,
     0.00 :   ffff8000081e1848:       adrp    x2, ffff8000081e1000 <print_bpf_insn+0x580>
          : 112              void (*exit)(struct bpf_prog *prog, u64 start,
     0.00 :   ffff8000081e184c:       add     x22, x22, #0xbd0
          : 110              u64 (*enter)(struct bpf_prog *prog,
     0.00 :   ffff8000081e1850:       add     x2, x2, #0xd20
     0.00 :   ffff8000081e1854:       b       ffff8000081e1868 <call_bpf_prog.isra.0+0x68>
          : 120              exit = __bpf_prog_exit_sleepable;
     0.00 :   ffff8000081e1858:       adrp    x22, ffff8000081e1000 <print_bpf_insn+0x580>
          : 119              enter = __bpf_prog_enter_sleepable;
     0.00 :   ffff8000081e185c:       adrp    x2, ffff8000081e1000 <print_bpf_insn+0x580>
          : 120              exit = __bpf_prog_exit_sleepable;
     0.00 :   ffff8000081e1860:       add     x22, x22, #0xc60
          : 119              enter = __bpf_prog_enter_sleepable;
     0.00 :   ffff8000081e1864:       add     x2, x2, #0xe10
          : 126              enter = __bpf_prog_enter_lsm_cgroup;
          : 127              exit = __bpf_prog_exit_lsm_cgroup;
          : 128              }
          :
          : 130              ctx->bpf_cookie = l->cookie;
     0.00 :   ffff8000081e1868:       str     x1, [x20]
          :
          : 129              start_time = enter(p, ctx);
     0.00 :   ffff8000081e186c:       mov     x0, x19
     0.00 :   ffff8000081e1870:       mov     x1, x20
          : 130              if (!start_time)
          : 131              return 0;
     0.00 :   ffff8000081e1874:       mov     w23, #0x0                       // #0
          : 128              start_time = enter(p, ctx);
     0.00 :   ffff8000081e1878:       blr     x2
     0.00 :   ffff8000081e187c:       mov     x21, x0
          : 129              if (!start_time)
     0.00 :   ffff8000081e1880:       cbz     x0, ffff8000081e18a8 <call_bpf_prog.isra.0+0xa8>
          :
          : 133              ret = p->bpf_func(args, p->insnsi);
     0.00 :   ffff8000081e1884:       ldr     x2, [x19, #48]
     0.00 :   ffff8000081e1888:       add     x1, x19, #0x48
     0.00 :   ffff8000081e188c:       mov     x0, x24
     0.00 :   ffff8000081e1890:       blr     x2
     0.00 :   ffff8000081e1894:       mov     w23, w0
          :
          : 135              exit(p, start_time, ctx);
     0.00 :   ffff8000081e1898:       mov     x2, x20
     0.00 :   ffff8000081e189c:       mov     x1, x21
     0.00 :   ffff8000081e18a0:       mov     x0, x19
     0.00 :   ffff8000081e18a4:       blr     x22
          :
          : 138              return ret;
          : 139              }
     0.00 :   ffff8000081e18a8:       mov     w0, w23
     0.00 :   ffff8000081e18ac:       ldp     x19, x20, [sp, #16]
     0.00 :   ffff8000081e18b0:       ldp     x21, x22, [sp, #32]
     0.00 :   ffff8000081e18b4:       ldp     x23, x24, [sp, #48]
     6.67 :   ffff8000081e18b8:       ldp     x29, x30, [sp], #64 // trampoline.c:137
     0.00 :   ffff8000081e18bc:       autiasp
     0.00 :   ffff8000081e18c0:       ret
          : 123              exit = __bpf_prog_exit_lsm_cgroup;
     0.00 :   ffff8000081e18c4:       adrp    x22, ffff8000081e1000 <print_bpf_insn+0x580>
          : 122              enter = __bpf_prog_enter_lsm_cgroup;
     0.00 :   ffff8000081e18c8:       adrp    x2, ffff8000081e1000 <print_bpf_insn+0x580>
          : 123              exit = __bpf_prog_exit_lsm_cgroup;
     0.00 :   ffff8000081e18cc:       add     x22, x22, #0x200
          : 122              enter = __bpf_prog_enter_lsm_cgroup;
     0.00 :   ffff8000081e18d0:       add     x2, x2, #0x1c0
     0.00 :   ffff8000081e18d4:       b       ffff8000081e1868 <call_bpf_prog.isra.0+0x68>
