Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9596E939D
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 14:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjDTMDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjDTMDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 08:03:17 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3049FA
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 05:03:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ppT0E-0002J0-3Y; Thu, 20 Apr 2023 14:03:06 +0200
Date:   Thu, 20 Apr 2023 14:03:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: bpf-next hang+kasan uaf refcount acquire splat when running
 test_progs
Message-ID: <ZEEp+j22imoN6rn9@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

while working on bpf-netfilter test cases i found that test_progs
never invokes bpf_test_run().

After applying following small patch it gets called as expected.

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 47e9e076bc8f..e2a1bdc5a570 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -587,7 +587,7 @@ void run_subtest(struct test_loader *tester,
                /* For some reason test_verifier executes programs
                 * with all capabilities restored. Do the same here.
                 */
-               if (!restore_capabilities(&caps))
+               if (restore_capabilities(&caps))
                        goto tobj_cleanup;

                do_prog_test_run(bpf_program__fd(tprog), &retval);

... but then output just hangs.  With KASAN enabled I see following splat,
followed by a refcount saturation warning:

BUG: KASAN: slab-out-of-bounds in bpf_refcount_acquire_impl+0x63/0xd0
Write of size 4 at addr ffff8881072b34e8 by task new_name/12847

CPU: 1 PID: 12847 Comm: new_name Not tainted 6.3.0-rc6+ #129
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x32/0x40
 print_address_description.constprop.0+0x2b/0x3d0
 ? bpf_refcount_acquire_impl+0x63/0xd0
 print_report+0xb0/0x260
 ? bpf_refcount_acquire_impl+0x63/0xd0
 ? kasan_addr_to_slab+0x9/0x70
 ? bpf_refcount_acquire_impl+0x63/0xd0
 kasan_report+0xad/0xd0
 ? bpf_refcount_acquire_impl+0x63/0xd0
 kasan_check_range+0x13b/0x190
 bpf_refcount_acquire_impl+0x63/0xd0
 bpf_prog_affcc6c9d58016ca___insert_in_tree_and_list+0x54/0x131
 bpf_prog_795203cdef4805f4_insert_and_remove_tree_true_list_true+0x15/0x11b
 bpf_test_run+0x2a0/0x5f0
 ? bpf_test_timer_continue+0x430/0x430
 ? kmem_cache_alloc+0xe5/0x260
 ? kasan_set_track+0x21/0x30
 ? krealloc+0x9e/0xe0
 bpf_prog_test_run_skb+0x890/0x1270
 ? __kmem_cache_free+0x9f/0x170
 ? bpf_prog_test_run_raw_tp+0x570/0x570
 ? __fget_light+0x52/0x4d0
 ? map_update_elem+0x680/0x680
 __sys_bpf+0x75e/0xd10
 ? bpf_link_by_id+0xa0/0xa0
 ? rseq_get_rseq_cs+0x67/0x650
 ? __blkcg_punt_bio_submit+0x1b0/0x1b0
 __x64_sys_bpf+0x6f/0xb0
 do_syscall_64+0x3a/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2f6a8b392d
Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 e4 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe46938328 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000007150690 RCX: 00007f2f6a8b392d
RDX: 0000000000000050 RSI: 00007ffe46938360 RDI: 000000000000000a
RBP: 00007ffe46938340 R08: 0000000000000064 R09: 00007ffe46938360
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffe46938b78 R14: 0000000000e09db0 R15: 00007f2f6a9ff000
 </TASK>

I can also reproduce this on bpf-next/780c69830ec6b27e0224586ce26bc89552fcf163.
Is this a known bug?

If you can't reproduce this I can make .config available.

Thanks.
