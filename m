Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B16884E8
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBBQ5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 11:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBQ5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 11:57:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E78646FD33;
        Thu,  2 Feb 2023 08:57:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6999C14;
        Thu,  2 Feb 2023 08:57:44 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E0FC3F64C;
        Thu,  2 Feb 2023 08:57:00 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:56:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com
Subject: Re: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and
 !WITH_REGS
Message-ID: <Y9vrWUM8ypNNwHyv@FVFF77S0Q05N.cambridge.arm.com>
References: <20230201163420.1579014-1-revest@chromium.org>
 <20230201163420.1579014-6-revest@chromium.org>
 <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vcua0+JzjmTICO@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 02, 2023 at 03:54:33PM +0000, Mark Rutland wrote:
> On Wed, Feb 01, 2023 at 05:34:17PM +0100, Florent Revest wrote:
> > -#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
> > +#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT)
> 
> Unfortunately, I think this is broken for architectures where:
> 
> * DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> * DYNAMIC_FTRACE_WITH_REGS=y
> * DYNAMIC_FTRACE_WITH_ARGS=n
> 
> ... since those might pass a NULL ftrace_regs around, and so when using the
> list ops arch_ftrace_set_direct_caller() might blow up accessing an element of
> ftrace_regs.
> 
> It looks like 32-bit x86 is the only case with that combination, and its
> ftrace_caller implementation passes a NULL regs, so I reckon that'll blow up.
> However, it looks like there aren't any FTRACE_DIRECT samples wired up for
> 32-bit x86, so I'm not aware of a test case we can use.

FWIW, the FTRACE_STARTUP_TEST tickles this:

[    1.896209] Testing tracer function_graph: 
[    2.900282] BUG: kernel NULL pointer dereference, address: 0000002c
[    2.901171] #PF: supervisor write access in kernel mode
[    2.901171] #PF: error_code(0x0002) - not-present page
[    2.901171] *pde = 00000000 
[    2.901171] Oops: 0002 [#1] PREEMPT SMP
[    2.901171] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-00014-gcfd6340c71ce #1
[    2.901171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[    2.901171] EIP: call_direct_funcs+0xd/0x1c
[    2.901171] Code: 00 00 00 00 90 a9 00 00 00 01 0f 84 d7 fe ff ff 0d 00 00 80 00 89 46 04 e9 d2 fe ff ff 8b 41 64 85 c0 74 11 55 89 e5 8b 55 08 <89> 42 2c 5d c3 8d b6 00 00 00 00 c3 8d 76 00 89 c1 89 b
[    2.901171] EAX: cc3620e8 EBX: c1147e44 ECX: c1147e44 EDX: 00000000
[    2.901171] ESI: fffffeff EDI: cc354208 EBP: c1147dbc ESP: c1147dbc
[    2.901171] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    2.901171] CR0: 80050033 CR2: 0000002c CR3: 0d703000 CR4: 00350ed0
[    2.901171] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.901171] DR6: fffe0ff0 DR7: 00000400
[    2.901171] Call Trace:
[    2.901171]  arch_ftrace_ops_list_func+0xf5/0x1bc
[    2.901171]  ? ftrace_enable_ftrace_graph_caller+0x3b/0x44
[    2.901171]  ? trace_selftest_startup_function_graph+0x1d9/0x298
[    2.901171]  ? syscall_unregfunc+0xa0/0xa0
[    2.901171]  ftrace_call+0x5/0x13
[    2.901171]  trace_selftest_dynamic_test_func+0x5/0xc
[    2.901171]  trace_selftest_startup_function_graph+0x1d9/0x298
[    2.901171]  ? trace_selftest_dynamic_test_func+0x5/0xc
[    2.901171]  ? trace_selftest_startup_function_graph+0x1d9/0x298
[    2.901171]  ? ftrace_check_record+0x340/0x340
[    2.901171]  ? ftrace_check_record+0x340/0x340
[    2.901171]  ? ftrace_stub_graph+0x4/0x4
[    2.901171]  ? trace_selftest_test_regs_func+0x18/0x18
[    2.901171]  run_tracer_selftest+0x7d/0x1bc
[    2.901171]  ? graph_depth_read+0x90/0x90
[    2.901171]  register_tracer+0xd3/0x284
[    2.901171]  ? register_trace_event+0xf6/0x180
[    2.901171]  ? init_graph_tracefs+0x38/0x38
[    2.901171]  init_graph_trace+0x56/0x78
[    2.901171]  do_one_initcall+0x53/0x204
[    2.901171]  ? parse_args+0x143/0x3ec
[    2.901171]  ? __kmem_cache_alloc_node+0x2d/0x224
[    2.901171]  kernel_init_freeable+0x198/0x2bc
[    2.901171]  ? rdinit_setup+0x30/0x30
[    2.901171]  ? rest_init+0xb0/0xb0
[    2.901171]  kernel_init+0x1a/0x1d0
[    2.901171]  ? schedule_tail_wrapper+0x9/0xc
[    2.901171]  ret_from_fork+0x1c/0x28
[    2.901171] Modules linked in:
[    2.901171] CR2: 000000000000002c
[    2.901171] ---[ end trace 0000000000000000 ]---
[    2.901171] EIP: call_direct_funcs+0xd/0x1c
[    2.901171] Code: 00 00 00 00 90 a9 00 00 00 01 0f 84 d7 fe ff ff 0d 00 00 80 00 89 46 04 e9 d2 fe ff ff 8b 41 64 85 c0 74 11 55 89 e5 8b 55 08 <89> 42 2c 5d c3 8d b6 00 00 00 00 c3 8d 76 00 89 c1 89 b
[    2.901171] EAX: cc3620e8 EBX: c1147e44 ECX: c1147e44 EDX: 00000000
[    2.901171] ESI: fffffeff EDI: cc354208 EBP: c1147dbc ESP: c1147dbc
[    2.901171] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[    2.901171] CR0: 80050033 CR2: 0000002c CR3: 0d703000 CR4: 00350ed0
[    2.901171] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    2.901171] DR6: fffe0ff0 DR7: 00000400
[    2.901171] note: swapper/0[1] exited with preempt_count 1
[    2.901175] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    2.902171] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

The below diff solved that for me.

Thanks,
Mark.

---->8----
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 84f717f8959e..3d2156e335d7 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -241,6 +241,12 @@ enum {
        FTRACE_OPS_FL_DIRECT                    = BIT(17),
 };
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
+#else
+#define FTRACE_OPS_FL_SAVE_ARGS                        0
+#endif
+
 /*
  * FTRACE_OPS_CMD_* commands allow the ftrace core logic to request changes
  * to a ftrace_ops. Note, the requests may fail.
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 73b6f6489ba1..8e739303b6a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5282,7 +5282,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {

