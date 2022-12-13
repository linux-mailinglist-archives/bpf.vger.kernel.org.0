Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE164BE50
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 22:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiLMVYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 16:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMVYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 16:24:02 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8BD218AF;
        Tue, 13 Dec 2022 13:24:00 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id fz10so1000332qtb.3;
        Tue, 13 Dec 2022 13:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVbuTlw5StqCpUnT2Z3N8qBlMp/3yxGOfym0r6um0Eo=;
        b=Eo16T/j40jJgSBILOV2+Ev1y9PzX1x8XZeETL2WQk90vNXWb/nqB5/w1wLwGqce2lZ
         wSlkY3a4RMfk+jTNwt+sPGK7fJQZXrfvG4PfacbaIuMtrBcn5LDE+cWYof5LpOZJFUK+
         8nKXHxRFRQyx91pKgMTVc4mQ0ngjlRUAgLuONWBCl7agzMLX+TdOO7WfXbcb9sILclNi
         7iM9MXGES5JAtAexg7tJ/lzPTiZ1inb38wO+cVnzDVzAj33ZZcw8G9lBTb7+LxB5XQlL
         ibP1nCSj7keui84VfcTfxrM9ENWLHO9dBygj04VN5af4srZVGe0IFjPeYKAQmegN661w
         Julg==
X-Gm-Message-State: ANoB5pl7wGj2R2xK5Dx6+i9QUjvFdwjf28h7d9etA8Dwh/DZQXZy/i1n
        t1K4QE7SACnSWJFAIlP82Go=
X-Google-Smtp-Source: AA0mqf7r+QLWexqUutWYZ8ep9dyvSW9rbCjW2XVm2ChH8tW1CD4Qa+Ida5fK+XEb1bmXPdTgun3PEQ==
X-Received: by 2002:a05:622a:6108:b0:3a7:e838:11c8 with SMTP id hg8-20020a05622a610800b003a7e83811c8mr24898099qtb.45.1670966639395;
        Tue, 13 Dec 2022 13:23:59 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8faa])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8074a000000b00397b1c60780sm511190qth.61.2022.12.13.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 13:23:58 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:23:57 -0600
From:   David Vernet <void@manifault.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
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
        linux-doc@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/2] docs: fault-injection: Add requirements of error
 injectable functions
Message-ID: <Y5jtbcmXrkPCvrjj@maniforge.lan>
References: <167094067084.608798.11303550366840600235.stgit@devnote3>
 <167094069168.608798.9644454927302716989.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167094069168.608798.9644454927302716989.stgit@devnote3>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 11:11:31PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a section about the requirements of the error injectable functions
> and the type of errors.
> Since this section must be read before using ALLOW_ERROR_INJECTION()
> macro, that section is referred from the comment of the macro too.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Hi Masami,

Thanks for writing this up. I have a few suggestions and some small
grammar nits, please see below.

> Link: https://lore.kernel.org/all/20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org/T/#u
> ---
>  Changes in v2:
>   - Fix typos and misses according to Randy's comment.
> ---
>  Documentation/fault-injection/fault-injection.rst |   65 +++++++++++++++++++++
>  include/asm-generic/error-injection.h             |    6 +-
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index 17779a2772e5..76bc9c857761 100644
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
> +This part is for the kenrel developers considering adding a function

s/kenrel/kernel

> +using the ALLOW_ERROR_INJECTION() macro.
> +
> +Requirements for the Error Injectable Functions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

s/for the Error/for Error

> +
> +Since the function-level error injection forcibly changes the code path
> +and returns an error even if the input and conditions are proper, this can
> +cause unexpected kernel crash if you allow error injection on the function

s/cause unexpected/cause an unexpected

Starting off this paragraph with a few sentences describing the
high-level purpose of the macro may be useful here as well.

> +which is NOT error injectable. Thus, you (and reviewers) must ensure;

IMO the wording in the "...this can cause unexpected kernel crash if you
allow error injection on the function which is NOT error injectable"
part of the sentence could be improved. The function is error
injectable, so saying the kernel could crash if you allow error
injection on a function that's not error injectable is a bit confusing.
What about something like this for the whole sentence?

Because function-level error injection may forcibly change a function's
return value, a function that enables it may return an error _any_ time
it returns a value, including if it is invoked with expected parameters
and under proper conditions. This means that you must _always_ ensure
the following requirements are met in orer to avoid a kernel crash:

> +
> +- The function returns an error code if it fails, and the callers must check

I'm a bit confused by the first part of this sentence. The point is that
we're overriding the returned error code, right? What about something
like this:

Callers must always check for errors on every invocation of an
error-injectable function, and must safely recover if any error is
observed.

> +  it correctly (need to recover from it).
> +
> +- The function does not execute any code which can change any state before
> +  the first error return. The state includes global or local, or input
> +  variable. For example, clear output address storage (e.g. `*ret = NULL`),

s/global or local, or input variable/global, local, and input variables

> +  increment/decrement counter, set a flag, preempt/irq disable or get
> +  a lock (if those are recovered before returning error, that will be OK.)

small nit: s/get a lock/acquire a lock

Also, the presence of this caveat suggests to me that this second bullet
should possibly be rephrased in general:
>(if those are recovered before returning error, that will be OK.)

If I understand correctly, the larger point is that the caller should
never observe any side effects when calling an error-injectable function
if that function returns an error, correct? The caller expecting that
the function will always change some state before its first return
statement is definitely a violation of that, but I think it could apply
to other parts of the function as well.

What do you think about this:

An error-injectable function should never leak any observable state to
the caller if an error is returned, and the caller should never rely on
some state always being changed when the function is called. For
example, it would be a bug if a function ever returned -EBUSY with a
lock held, or if the caller assumed that a global counter would always
be incremented. Other examples of improper state change visibility
include writing to a pointer argument without restoring the original
value on any error path, enabling or disabling preemption or IRQs,
flushing a buffer, etc.

> +
> +The first requirement is important, and it will result in that the release
> +(free objects) functions are usually harder to inject errors than allocate
> +functions. If errors of such release functions are not correctly handled
> +it will cause a memory leak easily (the caller will confuse that the object
> +has been released or corrupted.)

I don't quite understand why release functions would be different than
calling any other error-injectable kernel function that needs to clean
up state, but I readily admit that I may be missing some context. Also,
such functions are typically void anyways, no? So wouldn't they usually
be less of a pain? Again, apologies if I'm missing context here.

> +
> +The second one is for the caller which expects the function should always
> +do something. Thus if the function error injection skips all of the
> +function, the expectation is betrayed and causes an unexpected error.

I would personally scrap this part, but it's up to you. I think it's all
well captured in the second bullet-point already.

> +
> +Type of the Error Injectable Functions
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Each error injectable function will have the error type specified by the
> +ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
> +a new error injectable function. If the wrong error type is chosen, the

I would consider removing the second two sentences in this paragraph.
We're working in the kernel, so being careful should be the baseline no
matter what you're doing. Also, it seems fairly clear that choosing the
wrong error-return type could cause a crash, unspecified behavior, etc.

> +kernel may crash because it may not be able to handle the error.
> +There are 4 types of errors defined in include/asm-generic/error-injection.h

s/4 types of errors/4 return types

I realize that we've been using 'error types' up to now for error
injection, but IMO it's really return types that we're concerned with.
Feel free to ignore if you disagree.

> +
> +EI_ETYPE_NULL
> +  This function will return `NULL` if it fails. e.g. return an allocated
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
> +If you specify a wrong type, for example, EI_TYPE_ERRNO for the function

s/a wrong type/the wrong type

also, s/for the function/for a function

> +which returns an allocated object, it may cause a problem because the returned
> +value is not an object address and the caller can not access to the address.

s/can not access to the address/cannot dereference it

or just drop everything after "is not an object address". If it's not an
address, you probably shouldn't be accessing it :-) (modulo masking out
flags, etc).

> +
> +
>  How to add new fault injection capability
>  -----------------------------------------
>  
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index c0b9d3217ed9..18324d7aa56d 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -19,8 +19,10 @@ struct pt_regs;
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  /*
> - * Whitelist generating macro. Specify functions which can be
> - * error-injectable using this macro.
> + * Whitelist generating macro. Specify functions which can be error-injectable
> + * using this macro. If you are unsure what is required for the error-injectable
> + * functions, please read Documentation/fault-injection/fault-injection.rst
> + * 'Error Injectable Functions' section.
>   */
>  #define ALLOW_ERROR_INJECTION(fname, _etype)				\
>  static struct error_injection_entry __used				\
> 
