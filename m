Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946F64B010
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 07:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiLMGyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 01:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiLMGyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 01:54:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BC02DD6;
        Mon, 12 Dec 2022 22:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tJc0C+VnMuXijCnhz8V7XfDaJJMUgV2yyf/tTbhpF2A=; b=KWpayS/2cVmMcuSb9pzBn/FcaH
        YUE2cEb+w/fgUiZy60lHgq7ZEeor19l78LbtE320I/gpLZA1c/eqf7cNDd98NRSHh852K08tHtbZ9
        YrT0R9QQwL6kAm6/bRjWfmkhzqWa4NI2fZ/fNgocQMXlCYBbKqd7RignCr0NC7ybfos/GllkdzUvE
        jFN8yrHW5TxV9zm0oQkLdTpV0MYYp/fS376moiCk3TtCx46o0NwtShslYsyLRWO9Npq208x0UqViT
        LC+oQkI4Vd4Y58+4ml0FobBdWhngsp5epooyx6eyOPN4IYTAFcBYnm2TtlJmjUO59tLLhrcjz5gP8
        YKRLncjg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4zB3-00Buir-TP; Tue, 13 Dec 2022 06:54:10 +0000
Message-ID: <35654230-fdd3-0a94-5de2-ab5b03efa0ae@infradead.org>
Date:   Mon, 12 Dec 2022 22:54:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] docs: fault-injection: Add requirements of error
 injectable functions
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     bpf@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <167081319306.387937.10079195394503045678.stgit@devnote3>
 <167081321427.387937.15475445689482551048.stgit@devnote3>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <167081321427.387937.15475445689482551048.stgit@devnote3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi--

On 12/11/22 18:46, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a section about the requirements of the error injectable functions
> and the type of errors.
> Since this section must be read before using ALLOW_ERROR_INJECTION()
> macro, that section is referred from the comment of the macro too.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Link: https://lore.kernel.org/all/20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org/T/#u
> ---
>  Documentation/fault-injection/fault-injection.rst |   65 +++++++++++++++++++++
>  include/asm-generic/error-injection.h             |    6 +-
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index 17779a2772e5..da6c5796b1f8 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -233,6 +233,71 @@ proc entries
>  	This feature is intended for systematic testing of faults in a single
>  	system call. See an example below.
>  
> +
> +Error Injectable Functions
> +--------------------------
> +
> +This part is for the kenrel developers considering to add a function to

                        kernel developers considering adding a function

> +ALLOW_ERROR_INJECTION() macro.

   using the ALLOW_ERROR_INJECTION() macro.

> +
> +Requirements for the Error Injectable Functions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Since the function-level error injection forcibly changes the code path
> +and returns an error even if the input and conditions are proper, this can
> +cause unexpected kernel crash if you allow error injection on the function
> +which is NOT error injectable. Thus, you (and reviewers) must ensure;
> +
> +- The function returns an error code if it fails, and the callers must check
> +  it correctly (need to recover from it).
> +
> +- The function does not execute any code which can change any state before
> +  the first error return. The state includes global or local, or input
> +  variable. For example, clear output address storage (e.g. `*ret = NULL`),
> +  increments/decrements counter, set a flag, preempt/irq disable or get

     increment/decrement a counter,

> +  a lock (if those are recovered before returning error, that will be OK.)
> +
> +The first requirement is important, and it will result in that the release
> +(free objects) functions are usually harder to inject errors than allocate
> +functions. If errors of such release functions are not correctly handled
> +it will cause a memory leak easily (the caller will confuse that the object
> +has been released or corrupted.)
> +
> +The second one is for the caller which expects the function should always
> +does something. Thus if the function error injection skips whole of the

   do something.                                        skips all of the

> +function, the expectation is betrayed and causes an unexpected error.
> +
> +Type of the Error Injectable Functions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Each error injectable functions will have the error type specified by the

                         function

> +ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
> +a new error injectable function. If the wrong error type is chosen, the
> +kernel may crash because it may not be able to handle the error.
> +There are 4 types of errors defined in include/asm-generic/error-injection.h
> +
> +EI_ETYPE_NULL
> +  This function will return `NULL` if it fails. e.g. return an allocateed

                                                                  allocated

> +  object address.
> +
> +EI_ETYPE_ERRNO
> +  This function will return an `-errno` error code if it fails. e.g. return
> +  -EINVAL if the input is wrong. This will include the functions which will
> +  return an address which encodes `-errno` by ERR_PTR() macro.
> +
> +EI_ETYPE_ERRNO_NULL
> +  This function will return an `-errno` or `NULL` if it fails. If the caller
> +  of this function checks the return value with IS_ERR_OR_NULL() macro, this
> +  type will be appropriate.
> +
> +EI_ETYPE_TRUE
> +  This function will return `true` (non-zero positive value) if it fails.
> +
> +If you specifies a wrong type, for example, EI_TYPE_ERRNO for the function

          specify

> +which returns an allocated object, it may cause a problem because the returned
> +value is not an object address and the caller can not access to the address.
> +
> +
>  How to add new fault injection capability
>  -----------------------------------------
>  
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index c0b9d3217ed9..b05253f68eaa 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -19,8 +19,10 @@ struct pt_regs;
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  /*
> - * Whitelist generating macro. Specify functions which can be
> - * error-injectable using this macro.
> + * Whitelist generating macro. Specify functions which can be error-injectable
> + * using this macro. If you unsure what is required for the error-injectable

                        If you are unsure ...

> + * functions, please read Documentation/fault-injection/fault-injection.rst
> + * 'Error Injectable Functions' section.
>   */
>  #define ALLOW_ERROR_INJECTION(fname, _etype)				\
>  static struct error_injection_entry __used				\
> 

-- 
~Randy
