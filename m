Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A944F8BC3
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 02:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiDHAw6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 20:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiDHAw5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 20:52:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9809A6E365;
        Thu,  7 Apr 2022 17:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3110E618DB;
        Fri,  8 Apr 2022 00:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A4BC385A4;
        Fri,  8 Apr 2022 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649379054;
        bh=Fnq1dNA08/LWYoTGEL2vJKKrr5mYlJKc9c+6cJld2N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnLqp19VtblguBhMSGIxaseONA8r+Rcy9/cwcGcdd80faI2m/zBLxathG3BLtF31m
         5jWu7pGSjxdbrBizkNsGJoQjC1d84csnLXM/Z1JiMN2sx2fFUA6jl2i8CKvtAqWo8E
         c0yL3edWumVdK0k/ExKbh97aW1aLS65EETQgVVIRk81Ig4NXLi9Ce8VxSiIQ4Kf7al
         ZL/iLEr59ZpuPyO0U4L2/hKptkS3VRPV1I+gA8QtisHxH44S5Fvd8D0Bxw27yAJk48
         ylMdDcuEO4NEigfp2aStHDz3DrYIxZQ+7E02TUG6S9FTYC/waGjTvAR6z67tczPpjH
         3YFy0tvYvDjuw==
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
Subject: [PATCH bpf v2 1/4] ARM: unwind: Initialize the lr_addr field of unwind_ctrl_block
Date:   Fri,  8 Apr 2022 09:50:47 +0900
Message-Id: <164937904755.1272679.25073555823596728.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164937903547.1272679.7244379141135199176.stgit@devnote2>
References: <164937903547.1272679.7244379141135199176.stgit@devnote2>
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
  Changes in v2:
   - Initialize pointer by NULL instead of 0.
---
 arch/arm/kernel/unwind.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index a37ea6c772cd..c9f719e1b350 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -404,6 +404,7 @@ int unwind_frame(struct stackframe *frame)
 	ctrl.vrs[SP] = frame->sp;
 	ctrl.vrs[LR] = frame->lr;
 	ctrl.vrs[PC] = 0;
+	ctrl.lr_addr = NULL;
 
 	if (idx->insn == 1)
 		/* can't unwind */

