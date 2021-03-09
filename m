Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6178331C41
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhCIBUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 20:20:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230161AbhCIBT5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 20:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615252797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SX0KsRiYuzC72l142vDNhmy20ZK9cAQv1r2439KRtVY=;
        b=ARzULg5xtcJ+PxTvOmJXP3FzMaGmWR0ot48tqWlJ7n27BAMctsg8RHR2ZybTpMiwefag4m
        GdirkbwncDeOTUQC4GRMWuUSjOW8lw8WyIZqtgQAFFw7Icu7XmGv3cST6x8N1jltBQGXiM
        Bf7frsXiDoT0kkRZU3OfkL6pdvggbKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-vD4eWFTcMfm0vawrnMTuYA-1; Mon, 08 Mar 2021 20:19:53 -0500
X-MC-Unique: vD4eWFTcMfm0vawrnMTuYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC1311005D4F;
        Tue,  9 Mar 2021 01:19:50 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9AE5D9D3;
        Tue,  9 Mar 2021 01:19:47 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:19:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-ID: <20210309011945.ky7v3pnbdpxhmxkh@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
 <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
 <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
 <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
 <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 08, 2021 at 11:52:10AM +0900, Masami Hiramatsu wrote:
> So at the kretprobe handler, we have 2 issues.
> 1) the return address (caller_func+0x15) is not on the stack.
>    this can be solved by searching from current->kretprobe_instances.
> 2) the stack frame size of kretprobe_trampoline is unknown
>    Since the stackframe is fixed, the fixed number (0x98) can be used.
> 
> However, those solutions are only for the kretprobe handler. The stacktrace
> from interrupt handler hit in the kretprobe_trampoline still doesn't work.
> 
> So, here is my idea;
> 
> 1) Change the trampline code to prepare stack frame at first and save
>    registers on it, instead of "push". This will makes ORC easy to setup
>    stackframe information for this code.
> 2) change the return addres fixup timing. Instead of using return value
>    of trampoline handler, before removing the real return address from
>    current->kretprobe_instances.
> 3) Then, if orc_find() finds the ip is in the kretprobe_trampoline, it
>    checks the contents of the end of stackframe (at the place of regs->sp)
>    is same as the address of it. If it is, it can find the correct address
>    from current->kretprobe_instances. If not, there is a correct address.
> 
> I need to find how the ORC info is prepared for 1), maybe UNWIND_HINT macro
> may help?

Hi Masami,

If I understand correctly, for #1 you need an unwind hint which treats
the instruction *after* the "pushq %rsp" as the beginning of the
function.

I'm thinking this should work:


diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 8e574c0afef8..8b33674288ea 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -52,6 +52,11 @@
 	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=8 type=UNWIND_HINT_TYPE_FUNC
 .endm
 
+#else
+
+#define UNWIND_HINT_FUNC \
+	UNWIND_HINT(ORC_REG_SP, 8, UNWIND_HINT_TYPE_FUNC, 0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cdca327..38ff1387f95d 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -767,6 +767,7 @@ asm(
 	/* We don't bother saving the ss register */
 #ifdef CONFIG_X86_64
 	"	pushq %rsp\n"
+	UNWIND_HINT_FUNC
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
@@ -790,7 +791,6 @@ asm(
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
-STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 
 
 /*

