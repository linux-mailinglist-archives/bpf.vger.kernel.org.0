Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15143696968
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBNQZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 11:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNQZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 11:25:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291372A9A7
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9196B81E23
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5084DC4339B;
        Tue, 14 Feb 2023 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676391920;
        bh=LuWURY4FFKeKIoza3eLnRgl1jiOEIpdGZG7bWday3lQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cd0pCB93jtXrpx96m2wkGNutsKDwf2F+zq4ZVhUc+B4RHfuZQ5EkUTerejBJzln+Z
         DLx9UhdDb0znIJmWADwgoVkzz3om2KlqnSZ/bLG7Vr1xsiSgYaPLpoh7tbA+2OHZ4y
         O6FJ64O2SRPGOQve4QpVRZqJJXIYnWAQ65Ovvdb3WtbZqZHlfvv39NjzzD6fzwRrRZ
         3lI4AyH4LrHocUsXzIEBDkQDMmVDn6ndyKKc4PV8RvnG/945LLOw3mGD60pSQuRDNO
         TevFehVYvo6e6ZC+iFmADq3Azi7+dtl8ZtoV4Coc1QG3qew7ha4KcdW+dSFqQkAPEl
         mD3l4ttDKl8ag==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        bpf@vger.kernel.org
Subject: [PATCH] riscv, mm: Perform BPF exhandler fixup on page fault
Date:   Tue, 14 Feb 2023 17:25:15 +0100
Message-Id: <20230214162515.184827-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Commit 21855cac82d3 ("riscv/mm: Prevent kernel module to access user
memory without uaccess routines") added early exits/deaths for page
faults stemming from accesses to user-space without using proper
uaccess routines (where sstatus.SUM is set).

Unfortunatly, this is too strict for some BPF programs, which relies
on BPF exhandler fixups. These BPF programs loads "BTF pointers". A
BTF pointers could either be a valid kernel pointer or NULL, but not a
userspace address.

Resolve the problem by calling the fixup handler in the early exit
path.

Fixes: 21855cac82d3 ("riscv/mm: Prevent kernel module to access user memory without uaccess routines")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
Palmer,

This is a fix for BPF on riscv, but I'd still like to take it via the
RISC-V tree, given the mm changes.

BPF/BTF is a special snowflake, and needs special care. ;-)

If BPF_PROBE_MEM is ever to be used for usermode pointers in the
future, then the fixup call can be removed, in favor of setting
sstatus.SUM from the BPF jitted code.


Björn
---
 arch/riscv/mm/fault.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d86f7cebd4a7..eb0774d9c03b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -267,10 +267,12 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
-	if (!user_mode(regs) && addr < TASK_SIZE &&
-			unlikely(!(regs->status & SR_SUM)))
-		die_kernel_fault("access to user memory without uaccess routines",
-				addr, regs);
+	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
+		if (fixup_exception(regs))
+			return;
+
+		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
+	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 

base-commit: 950b879b7f0251317d26bae0687e72592d607532
-- 
2.37.2

