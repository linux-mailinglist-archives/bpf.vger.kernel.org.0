Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0869B770
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 02:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBRBZJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 20:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRBZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 20:25:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E353EFE
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:25:04 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id h3so2937947ybi.5
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sR5eHexHihsZ2D7X2joTXSOIZS9L59dzRpHsZy6ZnQg=;
        b=Uqv3x8HB6cB3xDicvor5RlUClDpJfl364BznO/JXaaNQt9TFnNvAAvSyF9KSl9FXHI
         rKRJtl+/HtJ1iiqNoblqVEkQ8YCaAziKeQqqPnKCNC+/SaB4pd9bCcn5On/lfqAn+vOP
         5QkDXfg33RaT7PB7MIGmFvrL9uvqIRNATnce1JVrqeFg85ZzLt9N+51BZrr/wsGLqhE0
         NZOBOW7ahUHXMndlxqhS1+c4WxN98IHMGSmlwIrYIk3RzfxUo/XkWVijcrkiEQkAXJTk
         EYev1rRvXjzv9RgvZ3YxY5lFaj0hRKlfSbDbNnt8wftXS4eEyK3CupJo8BOfPZ7yrHag
         NZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR5eHexHihsZ2D7X2joTXSOIZS9L59dzRpHsZy6ZnQg=;
        b=rryrIm95Hwgdhny488fh9+NtIY50ncqoKQzlyXUlKJvAvYDhGvO60lBp5OpiuR06TY
         +aGg5PdGjGWerfjBe/VdrOK15VAzezqks+/pWE/kOSNtusQKoKWZ12mGxRu5kuGEpqGf
         Ik5joPtt7kWYuxEZr+jZZHIKS1Ab5tpZ0GHozgqPXqtA9luGVEQ1BvyNhFAJC/xGipKG
         +F3JtLYpzKTDlJp/oqXztSLr4nutUfIyebGwJYyqpkj8AXWQeyKUiHL4WbsyCogd5rMM
         +yohWuDnqJOh7AoTQ3dN1cTFlgufPsBRObIYrvM74hFgxnxxb3xBg1ekbls6Q5LFissF
         ZFAg==
X-Gm-Message-State: AO0yUKUhI5c+xkIKPq96QO+bFt4lUhuW5H2MctmsaCJ1VhoG6NZ8LJBq
        SgG7CMjpFt+btmwsY66NdnVJ9kvjtAlOyhhAHAwMW5gBVQ4=
X-Google-Smtp-Source: AK7set9T/8lWQM/PFN40/yc87ZHnrwlck4IlZc7njsD0sPn6L/SUsQbi83wN0zKANWxSbJcyGuSFi6hsRI4719yFYTs=
X-Received: by 2002:a25:8d08:0:b0:94a:ebba:cba7 with SMTP id
 n8-20020a258d08000000b0094aebbacba7mr229978ybl.8.1676683503692; Fri, 17 Feb
 2023 17:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20230214043350.3497406-1-joannelkoong@gmail.com> <CAADnVQJsrjo7-mbEa1MWG4E53=0QUN8iWzjEjkahzgfzmwP_Cw@mail.gmail.com>
In-Reply-To: <CAADnVQJsrjo7-mbEa1MWG4E53=0QUN8iWzjEjkahzgfzmwP_Cw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 17 Feb 2023 17:24:52 -0800
Message-ID: <CAJnrk1bpHRcXZhL9H_T4u7CV7P1Mh8JtiqF_VWShTrM+etwbDw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next] bpf: Update kfunc __sz documentation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 12:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 13, 2023 at 8:35 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > A bpf program calling a kfunc with a __sz-annotated arg must explicitly
> > initialize the stack themselves if the pointer to the memory region is
> > a pointer to the stack. This is because in the verifier, we do not
> > explicitly initialize the stack space for reg type PTR_TO_STACK
> > kfunc args. Thus, the verifier will reject the program with:
> >
> > invalid indirect read from stack
> > arg#0 arg#1 memory, len pair leads to invalid memory access
> >
> > Alternatively, the verifier could support initializing the stack
> > space on behalf of the program for KF_ARG_PTR_TO_MEM_SIZE args,
> > but this has some drawbacks. For example this would not allow the
> > verifier to reject a program for passing in an uninitialized
> > PTR_TO_STACK for an arg that should have valid data. Another example is
> > that since there's no current way in a kfunc to differentiate between
> > whether the arg should be treated as uninitialized or not, additional
> > check_mem_access calls would need to be called even on PTR_TO_STACKs
> > that have been initialized, which is inefficient. Please note
> > that non-kfuncs don't have this problem because of the MEM_UNINIT tag;
> > only if the arg is tagged as MEM_UNINIT, then do we call
> > check_mem_access byte-by-byte for the size of the buffer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  Documentation/bpf/kfuncs.rst | 35 +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > index ca96ef3f6896..97497a7879d6 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -71,10 +71,37 @@ An example is given below::
> >          ...
> >          }
> >
> > -Here, the verifier will treat first argument as a PTR_TO_MEM, and second
> > -argument as its size. By default, without __sz annotation, the size of the type
> > -of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
> > -pointer.
> > +Here, the verifier will treat first argument (KF_ARG_PTR_TO_MEM_SIZE) as a
> > +pointer to the memory region and second argument as its size. By default,
> > +without __sz annotation, the size of the type of the pointer is used. Without
> > +__sz annotation, a kfunc cannot accept a void pointer.
> > +
> > +Please note that if the memory is on the stack, the stack space must be
> > +explicitly initialized by the program. For example:
> > +
> > +.. code-block:: c
> > +
> > +       SEC("tc")
> > +       int prog(struct __sk_buff *skb)
> > +       {
> > +               char buf[8];
> > +
> > +               bpf_memzero(buf, sizeof(buf));
> > +       ...
> > +       }
> > +
> > +should be
> > +
> > +.. code-block:: c
> > +
> > +       SEC("tc")
> > +       int prog(struct __sk_buff *skb)
> > +       {
> > +               char buf[8] = {};
> > +
> > +               bpf_memzero(buf, sizeof(buf));
>
> Actually we might go the other way.
> Instead of asking users to explicitly init things
> we will allow uninit memory.
> See this discussion:
> https://lore.kernel.org/bpf/082fd8451321a832f334882a1872b5cee240d811.camel@gmail.com/
>
> Eduard, is about to send those verifier patches.
>
> In parallel we can relax __sz to accept uninit under allow_uninit_stack.

in that case, for kfuncs it needs to grow the stack state if the
buffer + __sz is beyond the current allocated stack, or else
check_stack_range_initialized() will automatically fail if the user
tries to pass in an uninitialized buffer. i have a local patch for
this in my tree, I'll tidy it up and submit it next week
