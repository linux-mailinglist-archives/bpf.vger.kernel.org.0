Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E22346D2F
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 23:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCWWdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 18:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhCWWaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 18:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61313C061763;
        Tue, 23 Mar 2021 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GxysH/sfU1TRUv+WvnZiMSjg/sA1NBgFdqQhe6AYykM=; b=fRUKQx2x/zx7PmmwJts4MHI/NR
        95iESrw7QXBgCBBbHUerY5stBfvIU3FFM5LEb8AY63U0y+k2XQLC487fqYIxQeLMf5C71vLiuof8p
        shoIy+C57BF0nF2GLWWI+NhGOHK0s53vggCD3M+K6G9Ie2FZJFp7AxqHSJWnixj7CRIZX9xPkgwOY
        D1qwNz2tlvwp2eSKrF6FSOTXBf8X+dzktmiH/UMa0JqxgW+xDIiFHybb57zN0sV/421FR6+nVXUEL
        x13slsZ7B6edcstfJ3f17yNst264htMW9mtI4m3TWUbNHGAO9SmuP/UAfvdF+pmuT1Zl/AUczJWTZ
        gxTrZZbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOpXM-00Abyu-Hv; Tue, 23 Mar 2021 22:30:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF73A9864F6; Tue, 23 Mar 2021 23:30:07 +0100 (CET)
Date:   Tue, 23 Mar 2021 23:30:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address at
 kretprobe_trampoline
Message-ID: <20210323223007.GG4746@worktop.programming.kicks-ass.net>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
 <161639530062.895304.16962383429668412873.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161639530062.895304.16962383429668412873.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 22, 2021 at 03:41:40PM +0900, Masami Hiramatsu wrote:
>  	".global kretprobe_trampoline\n"
>  	".type kretprobe_trampoline, @function\n"
>  	"kretprobe_trampoline:\n"
>  #ifdef CONFIG_X86_64

So what happens if we get an NMI here? That is, after the RET but before
the push? Then our IP points into the trampoline but we've not done that
push yet.

> +	/* Push fake return address to tell the unwinder it's a kretprobe */
> +	"	pushq $kretprobe_trampoline\n"
>  	UNWIND_HINT_FUNC
> +	/* Save the sp-8, this will be fixed later */
> +	"	pushq %rsp\n"
>  	"	pushfq\n"
>  	SAVE_REGS_STRING
>  	"	movq %rsp, %rdi\n"
>  	"	call trampoline_handler\n"
>  	RESTORE_REGS_STRING
> +	"	addq $8, %rsp\n"
>  	"	popfq\n"
