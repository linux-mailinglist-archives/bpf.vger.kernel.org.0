Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4454F2B64
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbiDEJy6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348399AbiDEJrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 05:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD76E57B;
        Tue,  5 Apr 2022 02:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D5D4616D2;
        Tue,  5 Apr 2022 09:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16F6C385A6;
        Tue,  5 Apr 2022 09:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151233;
        bh=68gbc2AXKSN3tRLzHyhrzyqpSc4gZP8dxeQpKcf9ezA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZcXmZ+AWPl+uE14MwKlMpmmcsKfi3t1I3TnC+TGAc4agrmtaPtWcGP6znqejd017
         07Blju+cSqrhL4+m/2HwlI4Y+fS+YLVm8booS5rdL3RhK85mLr2vf2AScdCmCw0Z6m
         MDVvanNn0UbMNZpzKG99fYRC1Vd5Oddmv2dzjpmGkbTGPO5Mtd1P/XfvUgKSo+Aht7
         KM5g6wH57uvRB93250SuWzyDBpAhSGZBUd2yTm/+ZsXQVdxVi14TQBhoc4PsJbJiX9
         oMi0Xibos6mNUXNdrzd5Dj1CZxDA0qTvGetZgD6hNUH1f91L8z8bUrIIJjNnTIQaEE
         1ybOAVUFVjtQg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf 1/4] ARM: unwind: Initialize the lr_addr field of unwind_ctrl_block
Date:   Tue,  5 Apr 2022 18:33:47 +0900
Message-Id: <164915122721.982637.1510683757540074397.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164915121498.982637.12787715964983738566.stgit@devnote2>
References: <164915121498.982637.12787715964983738566.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the unwind_ctrl_block::lr_addr is finally passed to
stackframe::lr_addr, that value will be exposed unconditionally.
Thus it should be initialized.

Without this fix, when unwind_frame() doesn't update the
unwind_ctrl_block::lr_addr (e.g. 'lr' register is not saved in the
target function), stackframe::lr_addr will contain a wrong value.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/kernel/unwind.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index a37ea6c772cd..93e767682cf4 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -404,6 +404,7 @@ int unwind_frame(struct stackframe *frame)
 	ctrl.vrs[SP] = frame->sp;
 	ctrl.vrs[LR] = frame->lr;
 	ctrl.vrs[PC] = 0;
+	ctrl.lr_addr = 0;
 
 	if (idx->insn == 1)
 		/* can't unwind */

