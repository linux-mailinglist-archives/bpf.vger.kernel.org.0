Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C664977B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiLLAxn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiLLAxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:53:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0146358;
        Sun, 11 Dec 2022 16:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC58B80AEE;
        Mon, 12 Dec 2022 00:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A2C433D2;
        Mon, 12 Dec 2022 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670806418;
        bh=zm4aJyjGzVp87mDC05UMOQbOPxEO6O7rDswDiqb3MR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JObeRmUvvpff5wl94IbAyRZ7+ijQK1w13OSZmWOJ/NgwgpuRzNX5ZvNUWv2cR0uzl
         Zua8E5KKuWPU9tFFGQrK20/z/gSoSQaWTCQgshvj0MFFFUZtsD+HMk8sSWmR2Vdajz
         ryee+Oz+uCImsYZ8AAGB9CSzoJoQolBVoe95U5gL1xuCWyX9yKEI7bK+DZZSqM5Oh5
         Wz5AjLKAAQG2aSBJ3Z/pLG5pEFSlJk3YvMLZftqxwBiXAQ0fV/bgNZq5MJhr4vV8vi
         82fgzRyL6iiOvRyvzmF/6ndBanu0laWReDALXRtsWMRmD9X2y6LbG2Z2MYLcg6msZd
         YcxzdAf+cqsYA==
Date:   Mon, 12 Dec 2022 09:53:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
Message-Id: <20221212095333.01599330d97de6c7ddc3eebe@kernel.org>
In-Reply-To: <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3>
        <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com>
        <20221205075921.02edfe6b54abc5c2f9831875@kernel.org>
        <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com>
        <20221206162035.97ae19674d6d17108bed1910@kernel.org>
        <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com>
        <20221206233947.4c27cc9d@gandalf.local.home>
        <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
        <20221207074806.6f869be2@gandalf.local.home>
        <20221208043628.el5yykpjr4j45zqx@macbook-pro-6.dhcp.thefacebook.com>
        <20221211115218.2e6e289bb85f8cf53c11aa97@kernel.org>
        <CACYkzJ72-hJweZoFN_YN8u3NOmp5x82M2xA-ZKBi5ubt6yrzZA@mail.gmail.com>
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

Hi,

On Sun, 11 Dec 2022 08:49:01 +0100
KP Singh <kpsingh@kernel.org> wrote:

> 1. Revisit what is allowed for error injection in the kernel and if
> they can cause any subtle issues. My initial take is that functions
> that are directly called from syscall path should generally be okay.
> But let's check them for the patterns you mentioned.
> 2. If it helps, add the list of BPF modify return programs to stack
> traces. Although this is really needed if we don't do [1] properly.
> 3. Check if anything needs to be improved in the verification logic
> for modify return trampolines.

Hmm, I found that bpf might not check the acceptable error type of
each ALLOW_ERROR_INJECTION().

Except for EI_ETYPE_NONE, we have 4 types of the error.

        EI_ETYPE_NULL,          /* Return NULL if failure */
        EI_ETYPE_ERRNO,         /* Return -ERRNO if failure */
        EI_ETYPE_ERRNO_NULL,    /* Return -ERRNO or NULL if failure */
        EI_ETYPE_TRUE,          /* Return true if failure */

These specifies that what return value will be treated as an error
by the caller.

If bpf trampoline only expect that the function will return -errno
in error cases, bpf should check the error type as below.

etype = get_injectable_error_type(addr);
if (etype != EI_ETYPE_ERRNO && etype != EI_ETYPE_ERRNO_NULL)
	/* reject it */

If bpf can handle any case, it still need to verify that the user
bpf prog specifies correct return value for each type.
See adjust_error_retval()@kernel/fail_function.c for the available
return values.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
