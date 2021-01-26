Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635233038D7
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbhAZJSx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 04:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390893AbhAZJQK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 04:16:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E4BC061573
        for <bpf@vger.kernel.org>; Tue, 26 Jan 2021 01:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y63ons5ewOFgOkNz2cG2NjkjH4lXzVOR7t94xcBkSh4=; b=s4guv9cFb157VVY7Kk6phzsgVL
        qfAZasJAd+VJbRnEhvDWAqZM0cqL0syGGIPYinGSThWeCXqJMMkAQpUqCGPnBuJ3Otoseb3dY0HMS
        dN1nQ+ekQunTokk8vIJww1eOCiipTlMdF7CkHqCmzFCPQS77YNXHizPD7aTrJrbdExxd3iZNlrSMI
        74TlkX3vGklHTvmHVs0nmP+vrkZQbapzQGSoHM5Vwjlm+8ig+tK63ikWatZkvD23dlaAzzOxYkd/x
        vT95rV0XLeZV1qD60/qPBjjw7wpz1zw+JRPgPowPyem08HSjtr+7qIzBr1m9XtJwfMonWJj9VtvBH
        qy40dKyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4KRX-0004UY-PP; Tue, 26 Jan 2021 09:15:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50B4F300DB4;
        Tue, 26 Jan 2021 10:15:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3888C209C50F2; Tue, 26 Jan 2021 10:15:22 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:15:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        x86@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions
 properly
Message-ID: <YA/dqup/752hHBI4@hirez.programming.kicks-ass.net>
References: <20210126001219.845816-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126001219.845816-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 04:12:19PM -0800, Yonghong Song wrote:
> When the test is run normally after login prompt, cpu_feature_enabled(X86_FEATURE_SMAP)
> is true and bad_area_nosemaphore() is called and then fixup_exception() is called,
> where bpf specific handler is able to fixup the exception.
> 
> But when the test is run at /sbin/init time, cpu_feature_enabled(X86_FEATURE_SMAP) is
> false, the control reaches

That makes no sense, cpu features should be set in stone long before we
reach userspace.

> To fix the issue, before the above mmap_read_trylock(), we will check
> whether fault ip can be served by bpf exception handler or not, if
> yes, the exception will be fixed up and return.



> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f1f1b5a0956a..e8182d30bf67 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1317,6 +1317,15 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		if (emulate_vsyscall(hw_error_code, regs, address))
>  			return;
>  	}
> +
> +#ifdef CONFIG_BPF_JIT
> +	/*
> +	 * Faults incurred by bpf program might need emulation, i.e.,
> +	 * clearing the dest register.
> +	 */
> +	if (fixup_bpf_exception(regs, X86_TRAP_PF, hw_error_code, address))
> +		return;
> +#endif
>  #endif

NAK, this is broken. You're now disallowing faults that should've gone
through.
