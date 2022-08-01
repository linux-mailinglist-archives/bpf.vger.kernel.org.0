Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD558631A
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiHADd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 23:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHADd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 23:33:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BCFDF47;
        Sun, 31 Jul 2022 20:33:56 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lx3XN0hhWzWfgL;
        Mon,  1 Aug 2022 11:29:56 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 11:33:53 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 1 Aug 2022 11:33:53 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <chenzhongjin@huawei.com>
Subject: [PATCH -next v2] kprobes: Forbid probing on trampoline and bpf prog
Date:   Mon, 1 Aug 2022 11:31:04 +0800
Message-ID: <20220801033104.227091-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel_text_address returns ftrace_trampoline, kprobe_insn_slot
and bpf_text_address as kprobe legal address.

These text are removable and changeable without any notifier to
kprobes. Probing on them can trigger some unexpected behavior[1].

Considering that jump_label and static_call text are already be
forbiden to probe, kernel_text_address should be replaced with
core_kernel_text and is_module_text_address to check other text
which is unsafe to kprobe.

[1] https://lkml.org/lkml/2022/7/26/1148

Fixes: 5b485629ba0d ("kprobes, extable: Identify kprobes trampolines as kernel text area")
Fixes: 74451e66d516 ("bpf: make jited programs visible in traces")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
v1 -> v2:
Check core_kernel_text and is_module_text_address rather than
only kprobe_insn.
Also fix title and commit message for this. See old patch at [1].
---
 kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..80697e5e03e4 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	preempt_disable();
 
 	/* Ensure it is not in reserved area nor out of text */
-	if (!kernel_text_address((unsigned long) p->addr) ||
+	if (!(core_kernel_text((unsigned long) p->addr) ||
+	    is_module_text_address((unsigned long) p->addr)) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-- 
2.17.1

