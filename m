Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9132654C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 15:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEVN6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 09:58:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVN6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 09:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=stoReT4l5YzQVAfQyuDlkRZNXTb+4C0OYLElAHjZh1M=; b=EwPVMgH1NSlQBE6DSSuhGWezC
        vtkSBVOm2RRupQquWj3DB2AgwQmIGnJD9ld/bu9Pr6bBIxPAg22hsAN1wv5HuqJUGVOKbw8XqBd3F
        eeWL6hxCRMOMC1bnePP+7+UleiMNlysdZCdq3kwVM2JTMWP41XO28a7KklpczCcA2kuqaKsqTOV4w
        EKaOTxKXdMaS+VUr7X2+oVkTnsSsL0XGrSccHQ/OPeTyPQG25CteOdS8g1vD14ZZPHjeSaDmJO073
        nwgS3rfERrwrOPLtrjoYHHXkkJeQASoQ4ss7bzF1x3XFFLQDp0RqPNbxRsZJrxwCS67f4Y1U8MPEm
        rwk+rgzxw==;
Received: from [31.161.185.207] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTRlZ-00040l-P7; Wed, 22 May 2019 13:58:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 359BA984E09; Wed, 22 May 2019 15:58:50 +0200 (CEST)
Date:   Wed, 22 May 2019 15:58:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, Kairui Song <kasong@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86: always include regs->ip in callchain
Message-ID: <20190522135850.GB16275@worktop.programming.kicks-ass.net>
References: <20190521204813.1167784-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521204813.1167784-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 21, 2019 at 01:48:13PM -0700, Song Liu wrote:
> Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
> breaks tests like test_stacktrace_map from selftests/bpf/tests_prog.

That test is broken by something else; just the one entry is wrong too.

That said, yes the patch below is actually correct, but the above
description is misleading at best.

> This patch adds regs->ip back.
> 
> Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index f315425d8468..7b8a9eb4d5fd 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  		return;
>  	}
>  
> +	if (perf_callchain_store(entry, regs->ip))
> +		return;
>  	if (perf_hw_regs(regs)) {
> -		if (perf_callchain_store(entry, regs->ip))
> -			return;
>  		unwind_start(&state, current, regs, NULL);
>  	} else {
>  		unwind_start(&state, current, NULL, (void *)regs->sp);
> -- 
> 2.17.1
> 
