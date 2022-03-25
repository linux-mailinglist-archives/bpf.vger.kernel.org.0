Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF744E70E5
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359359AbiCYKOA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358687AbiCYKMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 06:12:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45270929;
        Fri, 25 Mar 2022 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VRexANbzMtWcQlHpMlOt6xn11ZKelygzpbZu1vRfJaw=; b=UQPDMBAwUSPnjtKI/vgn2IVqxK
        uF+8teDZkpbs4588gkl1GCr1D9Zr4CXZ7BsSGiRZ0FtweXgiEjArX2IT4vusFGP1UE16XQV3SRb3m
        7N2JI1DSFiq7tq/K+xrEzv485whVPyYu8HMA/xXfRkP1n6lH1Tk6FXt0WLxvFudSdHKlhIiC5BPRK
        iUuwHK7D1gx7G0y8D+2EPVQ4CxaM8Fpci/fsOgU35Nr0xYBB7Dzd5ut2UcaQoUguH4g5Bs2ikHGaF
        kf5/x5RzSS2U0fWjz8X2CDqT3iSIIR6CJrDs1SmHDajqlhJfm98pf4BhHKhsRgkFK8Tv0M4WbfOvt
        00PHHdIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXgt5-004LKX-O7; Fri, 25 Mar 2022 10:09:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4C919862A6; Fri, 25 Mar 2022 11:09:40 +0100 (CET)
Date:   Fri, 25 Mar 2022 11:09:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH bpf-next 2/2] rethook: kprobes: x86: Replace kretprobe
 with rethook on x86
Message-ID: <20220325100940.GM8939@worktop.programming.kicks-ass.net>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
 <164818254148.2252200.5054811796192907193.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164818254148.2252200.5054811796192907193.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 25, 2022 at 01:29:01PM +0900, Masami Hiramatsu wrote:
> Replaces the kretprobe code with rethook on x86. With this patch,
> kretprobe on x86 uses the rethook instead of kretprobe specific
> trampoline code.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/Kconfig                 |    1 
>  arch/x86/include/asm/unwind.h    |   23 +++----
>  arch/x86/kernel/Makefile         |    1 
>  arch/x86/kernel/kprobes/common.h |    1 
>  arch/x86/kernel/kprobes/core.c   |  107 ----------------------------------
>  arch/x86/kernel/rethook.c        |  121 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 135 insertions(+), 119 deletions(-)
>  create mode 100644 arch/x86/kernel/rethook.c

I'm thinking you'll find it builds much better with this on...

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..794fdef2501a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -550,15 +550,15 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
 		/*
 		 * There is a small chance to interrupt at the entry of
-		 * __kretprobe_trampoline() where the ORC info doesn't exist.
-		 * That point is right after the RET to __kretprobe_trampoline()
+		 * arch_rethook_trampoline() where the ORC info doesn't exist.
+		 * That point is right after the RET to arch_rethook_trampoline()
 		 * which was modified return address.
-		 * At that point, the @addr_p of the unwind_recover_kretprobe()
+		 * At that point, the @addr_p of the unwind_recover_rethook()
 		 * (this has to point the address of the stack entry storing
 		 * the modified return address) must be "SP - (a stack entry)"
 		 * because SP is incremented by the RET.
 		 */
-		state->ip = unwind_recover_kretprobe(state, state->ip,
+		state->ip = unwind_recover_rethook(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
@@ -573,7 +573,7 @@ bool unwind_next_frame(struct unwind_state *state)
 			goto err;
 		}
 		/* See UNWIND_HINT_TYPE_REGS case comment. */
-		state->ip = unwind_recover_kretprobe(state, state->ip,
+		state->ip = unwind_recover_rethook(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
 
 		if (state->full_regs)
