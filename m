Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41B33FB9CD
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhH3QIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbhH3QIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 12:08:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C08C061575;
        Mon, 30 Aug 2021 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eg5dRL4ThP5A+i9mC7RmGG1asnzaM0TTAEYM53xu7aw=; b=PwFAy3Jg2pKL70AY35Bj6q79Ls
        P6glow5EbR+riL8YlzMK8ePgvAcMWs4IJUs6t5l3sjsHRq60LFon8lMxAWmghV/mrAtNFdQu/2m11
        +K/Jcl/9A/S3LNxIq0xb5OXcuUDHWlPYZwnyVQAHtnF4VmqIazoHfFXGbc9lD/6MOTRuABXsFkVgT
        3JEXx8aN0kZOl2rIdXsnNcdskwGomdGurslg1WxHuNWbjcK+oORtZZpXrTLbsxMeyFw4x3OdO9GQm
        hXr+Cy1F2ygwfkRHfQ4z0Wt79pj1IzcLWU9vxLMb8AYrFGSNOFXRSjTmegPPS6hSw5de2rQHQfR5w
        J9Jzm4Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKjns-000J5U-4D; Mon, 30 Aug 2021 16:06:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DF963002BA;
        Mon, 30 Aug 2021 18:06:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 063F92C7F610C; Mon, 30 Aug 2021 18:06:31 +0200 (CEST)
Date:   Mon, 30 Aug 2021 18:06:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <YS0CBphTuIdTWEXF@hirez.programming.kicks-ass.net>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <F70BD5BE-C698-4C53-9ECD-A4805CB2D659@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F70BD5BE-C698-4C53-9ECD-A4805CB2D659@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 30, 2021 at 03:25:44PM +0000, Song Liu wrote:
> Thanks for these information! I did get confused these macros for quite a 
> while. Let me try with the _RET0 version.

Does you kernel have:

  9ae6ab27f44e ("static_call: Update API documentation")

?

With that included, the comment at the top of static_call.h reads like
the below. Please let me know where you think this can be improved.


/*
 * Static call support
 *
 * Static calls use code patching to hard-code function pointers into direct
 * branch instructions. They give the flexibility of function pointers, but
 * with improved performance. This is especially important for cases where
 * retpolines would otherwise be used, as retpolines can significantly impact
 * performance.
 *
 *
 * API overview:
 *
 *   DECLARE_STATIC_CALL(name, func);
 *   DEFINE_STATIC_CALL(name, func);
 *   DEFINE_STATIC_CALL_NULL(name, typename);
 *   DEFINE_STATIC_CALL_RET0(name, typename);
 *
 *   __static_call_return0;
 *
 *   static_call(name)(args...);
 *   static_call_cond(name)(args...);
 *   static_call_update(name, func);
 *   static_call_query(name);
 *
 *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
 *
 * Usage example:
 *
 *   # Start with the following functions (with identical prototypes):
 *   int func_a(int arg1, int arg2);
 *   int func_b(int arg1, int arg2);
 *
 *   # Define a 'my_name' reference, associated with func_a() by default
 *   DEFINE_STATIC_CALL(my_name, func_a);
 *
 *   # Call func_a()
 *   static_call(my_name)(arg1, arg2);
 *
 *   # Update 'my_name' to point to func_b()
 *   static_call_update(my_name, &func_b);
 *
 *   # Call func_b()
 *   static_call(my_name)(arg1, arg2);
 *
 *
 * Implementation details:
 *
 *   This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
 *   Otherwise basic indirect calls are used (with function pointers).
 *
 *   Each static_call() site calls into a trampoline associated with the name.
 *   The trampoline has a direct branch to the default function.  Updates to a
 *   name will modify the trampoline's branch destination.
 *
 *   If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
 *   themselves will be patched at runtime to call the functions directly,
 *   rather than calling through the trampoline.  This requires objtool or a
 *   compiler plugin to detect all the static_call() sites and annotate them
 *   in the .static_call_sites section.
 *
 *
 * Notes on NULL function pointers:
 *
 *   Static_call()s support NULL functions, with many of the caveats that
 *   regular function pointers have.
 *
 *   Clearly calling a NULL function pointer is 'BAD', so too for
 *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
 *   fatal). A NULL static_call can be the result of:
 *
 *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));
 *
 *   which is equivalent to declaring a NULL function pointer with just a
 *   typename:
 *
 *     void (*my_func_ptr)(int arg1) = NULL;
 *
 *   or using static_call_update() with a NULL function. In both cases the
 *   HAVE_STATIC_CALL implementation will patch the trampoline with a RET
 *   instruction, instead of an immediate tail-call JMP. HAVE_STATIC_CALL_INLINE
 *   architectures can patch the trampoline call to a NOP.
 *
 *   In all cases, any argument evaluation is unconditional. Unlike a regular
 *   conditional function pointer call:
 *
 *     if (my_func_ptr)
 *         my_func_ptr(arg1)
 *
 *   where the argument evaludation also depends on the pointer value.
 *
 *   When calling a static_call that can be NULL, use:
 *
 *     static_call_cond(name)(arg1);
 *
 *   which will include the required value tests to avoid NULL-pointer
 *   dereferences.
 *
 *   To query which function is currently set to be called, use:
 *
 *   func = static_call_query(name);
 *
 *
 * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
 *
 *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
 *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
 *   __static_call_return0 optimize the do nothing return 0 function.
 *
 *   This feature is strictly UB per the C standard (since it casts a function
 *   pointer to a different signature) and relies on the architecture ABI to
 *   make things work. In particular it relies on Caller Stack-cleanup and the
 *   whole return register being clobbered for short return values. All normal
 *   CDECL style ABIs conform.
 *
 *   In particular the x86_64 implementation replaces the 5 byte CALL
 *   instruction at the callsite with a 5 byte clear of the RAX register,
 *   completely eliding any function call overhead.
 *
 *   Notably argument setup is unconditional.
 *
 *
 * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
 *
 *   The difference is that the _TRAMP variant tries to only export the
 *   trampoline with the result that a module can use static_call{,_cond}() but
 *   not static_call_update().
 *
 */
