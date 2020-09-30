Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850EF27F5E3
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 01:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgI3XVX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 19:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgI3XVX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 19:21:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B5BC0613D1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:21:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so2310859pgl.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x63BBbB7KwIQqJxUqTsIaDJvuWLQtOEVBES32Yy+YAo=;
        b=TZcivgXw3I1epH9uT9vdPCWx/4ExuFu3+g4x3a/AhrJ47vzwURw8KdgwcFvZLA4x6R
         N43c1jc09gyZaUIARtJRdVpNBz8HLiKvE3J/YzFFtLaGuQ5vdTXiZAYuWGd1EBHOC14M
         xS08nPZAgFW9Y6dbf3e9FfTYtNlPH/Srf7U4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x63BBbB7KwIQqJxUqTsIaDJvuWLQtOEVBES32Yy+YAo=;
        b=F22WYdPks9zUPyln3uOfGXRCWx8gjBXbljhYOnaxmWOFgjfkFr8KTEe2768Ozvc2Um
         vK9Ezfr8E9dVf3/OVsmHLVdIwsh+GQywb34siUHpW2FQj8O5aWjnqJVWlAsayfLdBf4G
         +ZmRWEjxS18PLuSwwuYP6f7lQMpQHJ6jUXXNjYByApjrnT1mOUejpwnD54pPklS4V4VP
         dv1KMiGsr33STAYSJ6uagNvCJwbvk/ewBbqGUonr2Fa/cQV/yYpLacFmNCkoy7RS+ZZq
         u9gLKohGtjZcjRSMvPXYmMLCRsMdubayVbkATof7wlIGJjcqvwrGn0sWnLZXmjdUY7st
         u7sw==
X-Gm-Message-State: AOAM531PeYuG/5M2l7GbpG0yXrNQuAnV4bJ1a2avOPX/FZ4cJnLw62xx
        LCRVtJVMvvD4zdx52FbFDzWJeg==
X-Google-Smtp-Source: ABdhPJxuU0x2CWFLEU2A+WDs32aP0TdSrFtCY2CLnbAl54vDjrmQMaeG/VBOLgLEbehuqlqMS0xYoQ==
X-Received: by 2002:a17:902:7002:b029:d2:950a:d82a with SMTP id y2-20020a1709027002b02900d2950ad82amr4444416plk.72.1601508082978;
        Wed, 30 Sep 2020 16:21:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 206sm3071721pgh.26.2020.09.30.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:21:22 -0700 (PDT)
Date:   Wed, 30 Sep 2020 16:21:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
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
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202009301612.E9DD7361@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <202009301554.590642EBE@keescook>
 <CAG48ez077wMkh-sJebjxd3nAmBsNRCF2U8Vmmy-Fc7dr8KRyqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez077wMkh-sJebjxd3nAmBsNRCF2U8Vmmy-Fc7dr8KRyqw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 01:08:04AM +0200, Jann Horn wrote:
> [adding x86 folks to enhance bikeshedding]
> 
> On Thu, Oct 1, 2020 at 12:59 AM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Sep 30, 2020 at 10:19:16AM -0500, YiFei Zhu wrote:
> > > From: YiFei Zhu <yifeifz2@illinois.edu>
> > >
> > > Currently the kernel does not provide an infrastructure to translate
> > > architecture numbers to a human-readable name. Translating syscall
> > > numbers to syscall names is possible through FTRACE_SYSCALL
> > > infrastructure but it does not provide support for compat syscalls.
> > >
> > > This will create a file for each PID as /proc/pid/seccomp_cache.
> > > The file will be empty when no seccomp filters are loaded, or be
> > > in the format of:
> > > <arch name> <decimal syscall number> <ALLOW | FILTER>
> > > where ALLOW means the cache is guaranteed to allow the syscall,
> > > and filter means the cache will pass the syscall to the BPF filter.
> > >
> > > For the docker default profile on x86_64 it looks like:
> > > x86_64 0 ALLOW
> > > x86_64 1 ALLOW
> > > x86_64 2 ALLOW
> > > x86_64 3 ALLOW
> > > [...]
> > > x86_64 132 ALLOW
> > > x86_64 133 ALLOW
> > > x86_64 134 FILTER
> > > x86_64 135 FILTER
> > > x86_64 136 FILTER
> > > x86_64 137 ALLOW
> > > x86_64 138 ALLOW
> > > x86_64 139 FILTER
> > > x86_64 140 ALLOW
> > > x86_64 141 ALLOW
> [...]
> > > diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> > > index 7b3a58271656..33ccc074be7a 100644
> > > --- a/arch/x86/include/asm/seccomp.h
> > > +++ b/arch/x86/include/asm/seccomp.h
> > > @@ -19,13 +19,16 @@
> > >  #ifdef CONFIG_X86_64
> > >  # define SECCOMP_ARCH_DEFAULT                        AUDIT_ARCH_X86_64
> > >  # define SECCOMP_ARCH_DEFAULT_NR             NR_syscalls
> > > +# define SECCOMP_ARCH_DEFAULT_NAME           "x86_64"
> > >  # ifdef CONFIG_COMPAT
> > >  #  define SECCOMP_ARCH_COMPAT                        AUDIT_ARCH_I386
> > >  #  define SECCOMP_ARCH_COMPAT_NR             IA32_NR_syscalls
> > > +#  define SECCOMP_ARCH_COMPAT_NAME           "x86_32"
> >
> > I think this should be "ia32"? Is there a good definitive guide on this
> > naming convention?
> 
> "man 2 syscall" calls them "x86-64" and "i386". The syscall table
> files use ABI names "i386" and "64". The syscall stub prefixes use
> "x64" and "ia32".
> 
> I don't think we have a good consistent naming strategy here. :P

Agreed. And with "i386" being so hopelessly inaccurate, I prefer
"ia32" ... *shrug*

I would hope we don't have to be super-pedantic and call them "x86-64" and "IA-32". :P

-- 
Kees Cook
