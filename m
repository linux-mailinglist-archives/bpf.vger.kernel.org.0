Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0064B70C
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbiLMONB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiLMOMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F92099A;
        Tue, 13 Dec 2022 06:11:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB060B81205;
        Tue, 13 Dec 2022 14:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41CFC433EF;
        Tue, 13 Dec 2022 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940687;
        bh=L3dLWR+tH6h4YBPl5sEAES9TbqXYPM4UsT+1ed7mwZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7b4ghLj0tNGUBieTebpmE3KUtFz3fZKKPlnwxCJcoa5Vx8mSG4fKhk1kZFGp0TwJ
         tS0duLbVOi7NSf1mWFBPYyKaFLOv0HfQ/3AxtsKbvlqUP/k0JvcW7DI+3NakssTcVT
         hInb7cUUlIUabaIDXrrXUj5BzzNaXOI+sKpoS4pskfCiF6p2yFUbMxZ6QYoHQd3pLq
         XUrvki9bTWUwDfW2jBQOPErNq3hK3WoYs7c4yiwO8NSg/PYXoqzUCjWya82dB2jfTz
         kCvt+sYPJJywr8OSfvZ9kh074ZXpm0eMaLskrJnE41JTYC5AVYvFjMj7MizGpAwwWq
         cklhVTK6NTHMw==
Date:   Tue, 13 Dec 2022 23:11:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
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
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: fault-injection: Add requirements of error
 injectable functions
Message-Id: <20221213231122.7ae94229bdd6e9e232a4c32c@kernel.org>
In-Reply-To: <35654230-fdd3-0a94-5de2-ab5b03efa0ae@infradead.org>
References: <167081319306.387937.10079195394503045678.stgit@devnote3>
        <167081321427.387937.15475445689482551048.stgit@devnote3>
        <35654230-fdd3-0a94-5de2-ab5b03efa0ae@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Randy,

Thank you very much for the review!
OK, I'll fix those typos and misses.

Thanks!

On Mon, 12 Dec 2022 22:54:08 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> On 12/11/22 18:46, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a section about the requirements of the error injectable functions
> > and the type of errors.
> > Since this section must be read before using ALLOW_ERROR_INJECTION()
> > macro, that section is referred from the comment of the macro too.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Link: https://lore.kernel.org/all/20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org/T/#u
> > ---
> >  Documentation/fault-injection/fault-injection.rst |   65 +++++++++++++++++++++
> >  include/asm-generic/error-injection.h             |    6 +-
> >  2 files changed, 69 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> > index 17779a2772e5..da6c5796b1f8 100644
> > --- a/Documentation/fault-injection/fault-injection.rst
> > +++ b/Documentation/fault-injection/fault-injection.rst
> > @@ -233,6 +233,71 @@ proc entries
> >  	This feature is intended for systematic testing of faults in a single
> >  	system call. See an example below.
> >  
> > +
> > +Error Injectable Functions
> > +--------------------------
> > +
> > +This part is for the kenrel developers considering to add a function to
> 
>                         kernel developers considering adding a function
> 
> > +ALLOW_ERROR_INJECTION() macro.
> 
>    using the ALLOW_ERROR_INJECTION() macro.
> 
> > +
> > +Requirements for the Error Injectable Functions
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Since the function-level error injection forcibly changes the code path
> > +and returns an error even if the input and conditions are proper, this can
> > +cause unexpected kernel crash if you allow error injection on the function
> > +which is NOT error injectable. Thus, you (and reviewers) must ensure;
> > +
> > +- The function returns an error code if it fails, and the callers must check
> > +  it correctly (need to recover from it).
> > +
> > +- The function does not execute any code which can change any state before
> > +  the first error return. The state includes global or local, or input
> > +  variable. For example, clear output address storage (e.g. `*ret = NULL`),
> > +  increments/decrements counter, set a flag, preempt/irq disable or get
> 
>      increment/decrement a counter,
> 
> > +  a lock (if those are recovered before returning error, that will be OK.)
> > +
> > +The first requirement is important, and it will result in that the release
> > +(free objects) functions are usually harder to inject errors than allocate
> > +functions. If errors of such release functions are not correctly handled
> > +it will cause a memory leak easily (the caller will confuse that the object
> > +has been released or corrupted.)
> > +
> > +The second one is for the caller which expects the function should always
> > +does something. Thus if the function error injection skips whole of the
> 
>    do something.                                        skips all of the
> 
> > +function, the expectation is betrayed and causes an unexpected error.
> > +
> > +Type of the Error Injectable Functions
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Each error injectable functions will have the error type specified by the
> 
>                          function
> 
> > +ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
> > +a new error injectable function. If the wrong error type is chosen, the
> > +kernel may crash because it may not be able to handle the error.
> > +There are 4 types of errors defined in include/asm-generic/error-injection.h
> > +
> > +EI_ETYPE_NULL
> > +  This function will return `NULL` if it fails. e.g. return an allocateed
> 
>                                                                   allocated
> 
> > +  object address.
> > +
> > +EI_ETYPE_ERRNO
> > +  This function will return an `-errno` error code if it fails. e.g. return
> > +  -EINVAL if the input is wrong. This will include the functions which will
> > +  return an address which encodes `-errno` by ERR_PTR() macro.
> > +
> > +EI_ETYPE_ERRNO_NULL
> > +  This function will return an `-errno` or `NULL` if it fails. If the caller
> > +  of this function checks the return value with IS_ERR_OR_NULL() macro, this
> > +  type will be appropriate.
> > +
> > +EI_ETYPE_TRUE
> > +  This function will return `true` (non-zero positive value) if it fails.
> > +
> > +If you specifies a wrong type, for example, EI_TYPE_ERRNO for the function
> 
>           specify
> 
> > +which returns an allocated object, it may cause a problem because the returned
> > +value is not an object address and the caller can not access to the address.
> > +
> > +
> >  How to add new fault injection capability
> >  -----------------------------------------
> >  
> > diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> > index c0b9d3217ed9..b05253f68eaa 100644
> > --- a/include/asm-generic/error-injection.h
> > +++ b/include/asm-generic/error-injection.h
> > @@ -19,8 +19,10 @@ struct pt_regs;
> >  
> >  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
> >  /*
> > - * Whitelist generating macro. Specify functions which can be
> > - * error-injectable using this macro.
> > + * Whitelist generating macro. Specify functions which can be error-injectable
> > + * using this macro. If you unsure what is required for the error-injectable
> 
>                         If you are unsure ...
> 
> > + * functions, please read Documentation/fault-injection/fault-injection.rst
> > + * 'Error Injectable Functions' section.
> >   */
> >  #define ALLOW_ERROR_INJECTION(fname, _etype)				\
> >  static struct error_injection_entry __used				\
> > 
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
