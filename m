Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FD3FE0F9
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbhIARM2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhIARM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 13:12:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4241C061575;
        Wed,  1 Sep 2021 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3sWXBY6NNcGhB2reOpiXBClc3engCHc7t+RgqJpOess=; b=R4QdXiCtGn0RosMhstl4lhe3jc
        +zadhK+5SxXRN6NUvp4kIR6jLZ6/NfgO86tMfF91XKJocCmccC97Q0M3O2XrpxmMF9eIoE0O1h+LT
        njJUZHXCe/ed5yLr+cV5ke5mffquRcndI1pmITwmUKKGXLxIqcDPrNyxXQ4IDOdgDnEP35tTLUOQg
        yFTXvfG8uApChvvLlPZQ0l0I9Dqq0fbRTcKIfd5N59RZUER+SRtIIfjC0900eSSihcaeW+VXn1FDr
        B+ejN7zA/cpFoaMAURd2FedJWjf9oA3yQgEdt2j48P9APaGExOVeINR6HnKi16TBP+TBIMYCCxc/K
        /jbH/4/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLTjl-002aeU-VZ; Wed, 01 Sep 2021 17:09:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C59E30018A;
        Wed,  1 Sep 2021 19:09:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F5FB2B83870A; Wed,  1 Sep 2021 19:09:21 +0200 (CEST)
Date:   Wed, 1 Sep 2021 19:09:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YS+zwVNMVBKWxGc3@hirez.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <F70BD5BE-C698-4C53-9ECD-A4805CB2D659@fb.com>
 <YS0CBphTuIdTWEXF@hirez.programming.kicks-ass.net>
 <106E85E3-D30C-48BC-8EB6-8DFEEECF2022@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106E85E3-D30C-48BC-8EB6-8DFEEECF2022@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 04:36:44PM +0000, Song Liu wrote:

> > /*
> > * Static call support
> > *
> > * Static calls use code patching to hard-code function pointers into direct
> > * branch instructions. They give the flexibility of function pointers, but
> > * with improved performance. This is especially important for cases where
> > * retpolines would otherwise be used, as retpolines can significantly impact
> > * performance.
> > *
> 
> [...]
> 
> > *
> > * Notes on NULL function pointers:
> > *
> > *   Static_call()s support NULL functions, with many of the caveats that
> > *   regular function pointers have.
> > *
> > *   Clearly calling a NULL function pointer is 'BAD', so too for
> > *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
> > *   fatal). A NULL static_call can be the result of:
> > *
> 
> Probably add:
> 
>  *     /* for function that returns NULL */
> > *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
> 
> 
>  *   or 
>  *     /* for function that returns int */
>  *     DECLARE_STATIC_CALL_RET0(my_static_call, int (*)(int));
>  * 

No, anything that uses static_call_cond() must have void return. Note
that static_call_cond() replaces:

	if (func_ptr)
		func_ptr(args);

which is a statement, not an expression, and as such can't function as
an rvalue.

> So it is clear that we need two different macros. IIUC, the number and 
> type of arguments doesn't matter? 

Right, arguments are irrelevant, provided CDECL ABI, which mandates that
arguments that are pushed on the stack are cleaned up by the caller, not
the callee.

> Also, the default return int function has to return 0, right? Can we let 
> it return -EOPNOSUPP? 

Difficult, in principle we can patch any value that fits in a single
instruction, but the more variants we have, the harder it gets.
