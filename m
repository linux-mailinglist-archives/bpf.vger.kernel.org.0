Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1404D08C8
	for <lists+bpf@lfdr.de>; Mon,  7 Mar 2022 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiCGUvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 15:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiCGUvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 15:51:13 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2CE29CA1
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 12:50:19 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id q11so15097207pln.11
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 12:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dWRmhhoglB2pCubiBBDZCOAd3xguaQiXm0eJvJceo9Y=;
        b=NeUTfA1NwSCzH0OnxniYQvdOELD6E8WL5FL3BmzSVRRcvlESQTVa97k4BV0DCOA8Gv
         ntFpyRh5FjfYPP/8nVKSUf1uAZkavgLIOcRDDg6jH8NPjS0lZHNExysXy1NVATZRije/
         CdR2T3nvqz+bTQedzWugnqEnkfw5qEShjI3f4ChVQOpjSDEX39CSzKNq1+tSg0Zt2dZb
         OYkYMSXA0FhFvSPIDuVXwZ0qAWC1adny3Q3YtmI3PpRBUzuN1XWaeX6DtEayCmDmRYAD
         cbSwoCXKFQ4mxPltu6wA79icRsw7kXJbh787j/Fspe6Ly1YyZHvQyfWMHNBdHTHIf2JN
         IRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dWRmhhoglB2pCubiBBDZCOAd3xguaQiXm0eJvJceo9Y=;
        b=7QOKKPJXGcgRA2Pf88KfGi0LCEb3JN99Ud/hOLzdb7hSv9wvqS3Rf0HWom7PhiT6HY
         3a/UBjMi6pD0ORguE6DP3P9BuxC2eBcR4tmgorFidHmccntzU1kMVi0umSedZL5Edgs8
         bT6O9pW7XOzzj7CuBhy+xr8fIFDSTINZvtt7WkhAUGHGiLcd+NqBq913Fwxck4A4laKv
         fSzRr1ONpoF/oQRphHxzbHP67sr9kr1+mNmC4hOZoY9YChKK+OrPan3EToLO5xjOrp0e
         vB4Fi12w+xzjgpQFdXWwjo3w5u+K8aE9NZiH0kqK8wYMR8GRHYfNS6DGSr+ADA4WZw58
         WD/A==
X-Gm-Message-State: AOAM532IeN4IXnxSgw/xoOjkabQep3LlGWqym0pstu+CxGR+kBGAQz06
        FuzkNxytiTsfpEM4jyr7NWU=
X-Google-Smtp-Source: ABdhPJyscdJ6CmCTfDTugPDJoIUsTilwgRD+PAEsC4dX1ok9uTqbXgn3MM9SHTwq0RHK6GKRHLtMbg==
X-Received: by 2002:a17:90a:6404:b0:1b9:28a8:935f with SMTP id g4-20020a17090a640400b001b928a8935fmr858046pjj.197.1646686218680;
        Mon, 07 Mar 2022 12:50:18 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id y34-20020a056a00182200b004f71c56a7e8sm1886063pfa.213.2022.03.07.12.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:50:18 -0800 (PST)
Date:   Tue, 8 Mar 2022 02:20:16 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v4 5/8] compiler-clang.h: Add __diag
 infrastructure for clang
Message-ID: <20220307205016.ljkpq4zv7wzwraxv@apollo.legion>
References: <20220304224645.3677453-1-memxor@gmail.com>
 <20220304224645.3677453-6-memxor@gmail.com>
 <CAKwvOdnEyvjZn14WAPyL1O=S9C-LGx7aB3fYc7TAbgngfcXM5A@mail.gmail.com>
 <CAKwvOdnwiRdvTRA1Y30bzOsnwUyvSEbq+qT0tU4_vVHz=y_0Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnwiRdvTRA1Y30bzOsnwUyvSEbq+qT0tU4_vVHz=y_0Ng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 08, 2022 at 12:57:20AM IST, Nick Desaulniers wrote:
> Also, please cc me and the llvm mailing list on all changes to
> include/linux/compiler-clang.h. I see now on lore there's further
> patches here than just this single patch I was cc'ed on.
>

Mea culpa, sorry about that.

> On Mon, Mar 7, 2022 at 11:25 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Mar 4, 2022 at 2:47 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > From: Nathan Chancellor <nathan@kernel.org>
> > >
> > > Add __diag macros similar to those in compiler-gcc.h, so that warnings
> > > that need to be adjusted for specific cases but not globally can be
> > > ignored when building with clang.
> > >
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > [ Kartikeya: wrote commit message ]
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  include/linux/compiler-clang.h | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > > index 3c4de9b6c6e3..f1aa41d520bd 100644
> > > --- a/include/linux/compiler-clang.h
> > > +++ b/include/linux/compiler-clang.h
> >
> > The equivalent functionality for GCC has
> > 357 #ifndef __diag_GCC
> > 358 #define __diag_GCC(version, severity, string)
> > 359 #endif
> > in include/linux/compiler_types.h. Should this patch as well? (at
> > least #define __diag_clang`)?
> >

I left it out because there are no users for it, no code is doing
__diag_ignore(clang, ...), all of the current ones are hardcoding e.g.
__diag_ignore(GCC, 8, ...).

> > > @@ -68,3 +68,25 @@
> > >
> > >  #define __nocfi                __attribute__((__no_sanitize__("cfi")))
> > >  #define __cficanonical __attribute__((__cfi_canonical_jump_table__))
> > > +
> > > +/*
> > > + * Turn individual warnings and errors on and off locally, depending
> > > + * on version.
> > > + */
> > > +#define __diag_clang(version, severity, s) \
> > > +       __diag_clang_ ## version(__diag_clang_ ## severity s)
> > > +
> > > +/* Severity used in pragma directives */
> > > +#define __diag_clang_ignore    ignored
> > > +#define __diag_clang_warn      warning
> > > +#define __diag_clang_error     error
> >
> > These severities match GCC. I wonder if rather than copy+pasting these
> > over, we could rework __diag_ignore, __diag_warn, and __diag_error to
> > not invoke a compiler-suffixed macro and rather pass the compiler
> > along (or make it implicit since we know CONFIG_CC_IS_CLANG vs
> > CONFIG_CC_IS_GCC)?  We can probably land this than follow up on better
> > code-reuse between compilers for diagnostics.
> >

That was the idea with __diag_ignore_all in the next patch. FYI this series has
already been applied.

> > > +
> > > +#define __diag_str1(s)         #s
> > > +#define __diag_str(s)          __diag_str1(s)
> > > +#define __diag(s)              _Pragma(__diag_str(clang diagnostic s))
> > > +
> > > +#if CONFIG_CLANG_VERSION >= 110000
> > > +#define __diag_clang_11(s)     __diag(s)
> > > +#else
> > > +#define __diag_clang_11(s)
> > > +#endif
> > > --
> > > 2.35.1
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers

--
Kartikeya
