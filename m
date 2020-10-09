Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8832881BB
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgJIFfL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgJIFfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 01:35:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F4C0613D4
        for <bpf@vger.kernel.org>; Thu,  8 Oct 2020 22:35:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g10so5904324pfc.8
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XIdDXZRhz37tftITDPN3YNgJVGlOJnM9JsgYjb/1FXE=;
        b=WGuMCeg8HRFhfL9xv5josACQa4Ayr0gq4NmLmAmq05XCJpivwjrG2kMxdt4rKCIV8z
         JbTyUrJHG83fomoTwM1xIDNPvfLoKJAZXqvvfrFaAurphSjLVSXbUayG31oSqGQXiQHL
         ODmtE5v9kkvCYHCbVVTisV2Bm7MtgIB293WGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XIdDXZRhz37tftITDPN3YNgJVGlOJnM9JsgYjb/1FXE=;
        b=O8LJCToMpNald02kXwMvPZReHRp3ONU0n8OOV9msoXA2QaJYKUR6WhXQNIFrR4UKld
         ZahIOc7/SOQn0QsRyVfwVOeDwJEnI7ArclfkzEJfXIT0UdhtzCafyUAfD5WLW/DgulKG
         NJWhc2Xy/jcqSQEDA3qSz4Csa2OGSg5426XBCeiKONlZwt22BudPenXE/7PeNAH6H3tv
         iJixPzK5br9D9MYMkoGEwtS5m9TzGtLz51s5EEvC4RTTJAd5pTuYbyQ5G2hjW0r3YaQA
         ieEbWxfDPcyVmokA6A6CIfGKXbUpeCKjoxeXkntx+D7L5UBllunq8K/+kuxE7XZ8zi5i
         0Xkg==
X-Gm-Message-State: AOAM530Z0wZPXh1Pl9C3XLfFrRlwa2ELLF1h/H1Bl+x2kgU/LYzc4ekN
        RdIrHhoRDx/LcIjQpyLQ+Fzj3w==
X-Google-Smtp-Source: ABdhPJwWlTDSch7HFPQiAjEx67gWISRHKOLLPBnbQPmegZcyaqq6YCtFdArCda8ugJ5SqLfu/DVmtQ==
X-Received: by 2002:a17:90a:4489:: with SMTP id t9mr453187pjg.89.1602221709401;
        Thu, 08 Oct 2020 22:35:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm9701173pfd.198.2020.10.08.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 22:35:08 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:35:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 3/5] seccomp/cache: Lookup syscall allowlist
 for fast path
Message-ID: <202010082234.C044F0FA@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <83c72471f9f79fa982508bd4db472686a67b8320.1601478774.git.yifeifz2@illinois.edu>
 <202009301422.D9F6E6A@keescook>
 <CABqSeASbRXLYgE=rbKO8g8Si9q7nKEGB2UZpi-BcYG5etWVcjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeASbRXLYgE=rbKO8g8Si9q7nKEGB2UZpi-BcYG5etWVcjA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 08, 2020 at 07:17:39PM -0500, YiFei Zhu wrote:
> On Wed, Sep 30, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 10:19:14AM -0500, YiFei Zhu wrote:
> > > From: YiFei Zhu <yifeifz2@illinois.edu>
> > >
> > > The fast (common) path for seccomp should be that the filter permits
> > > the syscall to pass through, and failing seccomp is expected to be
> > > an exceptional case; it is not expected for userspace to call a
> > > denylisted syscall over and over.
> > >
> > > This first finds the current allow bitmask by iterating through
> > > syscall_arches[] array and comparing it to the one in struct
> > > seccomp_data; this loop is expected to be unrolled. It then
> > > does a test_bit against the bitmask. If the bit is set, then
> > > there is no need to run the full filter; it returns
> > > SECCOMP_RET_ALLOW immediately.
> > >
> > > Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> > > Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> > > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > I'd like the content/ordering of this and the emulator patch to be reorganized a bit.
> > I'd like to see the infrastructure of the cache added first (along with
> > the "always allow" test logic in this patch), with the emulator missing:
> > i.e. the patch is a logical no-op: no behavior changes because nothing
> > ever changes the cache bits, but all the operational logic, structure
> > changes, etc, is in place. Then the next patch would be replacing the
> > no-op with the emulator.
> >
> > > ---
> > >  kernel/seccomp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index f09c9e74ae05..bed3b2a7f6c8 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -172,6 +172,12 @@ struct seccomp_cache_filter_data { };
> > >  static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
> > >  {
> > >  }
> > > +
> > > +static inline bool seccomp_cache_check(const struct seccomp_filter *sfilter,
> >
> > bikeshedding: "cache check" doesn't tell me anything about what it's
> > actually checking for. How about calling this seccomp_is_constant_allow() or
> > something that reflects both the "bool" return ("is") and what that bool
> > means ("should always be allowed").
> 
> We have a naming conflict here. I'm about to rename
> seccomp_emu_is_const_allow to seccomp_is_const_allow. Adding another
> seccomp_is_constant_allow is confusing. Suggestions?
> 
> I think I would prefer to change seccomp_cache_check to
> seccomp_cache_check_allow. While in this patch set seccomp_cache_check
> does imply the filter is "constant" allow, argument-processing cache
> may change this, and specifying an "allow" in the name specifies the
> 'what that bool means ("should always be allowed")'.

Yeah, that seems good.

-- 
Kees Cook
