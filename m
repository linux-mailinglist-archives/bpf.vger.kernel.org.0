Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F53497D0
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCYRWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCYRWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 13:22:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DCBC06174A;
        Thu, 25 Mar 2021 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GxysH/sfU1TRUv+WvnZiMSjg/sA1NBgFdqQhe6AYykM=; b=RuhNkz3N9UMJB97033Ocv+ShRl
        3bk6UO733ktjXcx8plXR2YK4rgH45Ugcwy4rahc7MeWvu1pMoilPnmySRGwaZ+UQ+LnoZ7zGQBHEh
        eFy1ypze4mhxkl4a9BIta4EGTzkQm/3b8FVUg5hA659cxsGj+WuGgngRSk9oE6ASHY47evnq8RvHG
        jufArXMKKJoVjLedELvT1W+WzvvEFSFn0veiidXdBl97MghbE3k3Ro68ovQD5uM0eczTZOLRXFcRM
        S3JJREOuYvoOYaGr7JJUDNcOvPdtJ6gHC4el8btoIjzu/a96+ngZ2GOOJwWyFNNHc/IZzfaB9eamL
        afhcYO9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPTgN-001txT-AG; Thu, 25 Mar 2021 17:22:07 +0000
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
