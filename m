Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC01276AE6
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgIXHg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIXHg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 03:36:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EEEC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 00:36:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so1367195pff.6
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLJqIscJmXcvk+sqZWhshYhF2CZRRuw+A8ZGwocEwRQ=;
        b=G+UWjHqRmZtL7aOwJRe0U89n54w3ZzxUfJM96kgA17jcRmleJkjoPM8xG/IgtKX+ka
         Ru6WiurvmQ7B/2qcOKO6h91E7rZHfAvvKXRQSk6IwPOMzwJAsA6GS4xx79fuZEIZsMMa
         O32mwaxtv3Spvme5j6mLBMKNpV4AWuTd4s9VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLJqIscJmXcvk+sqZWhshYhF2CZRRuw+A8ZGwocEwRQ=;
        b=VA1ZoBa9FSiLA9aQk993Wx06R9i+Djs1//ziX4VZ+SrS8uu9U8J2pWCPyzgGam7ReS
         xO/hyKG+Q3/U4B6+qBojb1KsvmzHx7AxOhBq87x1UeExf/kx/AmatzTaJjVXKUFq0EVA
         42/6IZ750c8bxAn7nw2XpYiUZ2lozGmKwiaoU4dfqiFah4jKInGjybU612UM3FQzVl/2
         6snzyKVmeYnraCVajlZDRcvzl3G9HikFiz9MLM1JklXDPY6oW+MJHYOdfTvEyP5xaSzr
         Os46hUd5sYFvfgf1KnrKUvhRgswukDpeayOr05Z5tYmDTEH1iqXYqKp9AaTBrTHbhRhw
         hnGg==
X-Gm-Message-State: AOAM532htf1pEIJycpUscH4piqavv7iKkfuEYiyPoBj78fTaDC6Zsd2R
        uYT0BImD8mJH6wTiVE8SpeYtGItCE0U0sN0p
X-Google-Smtp-Source: ABdhPJwOSKne6H8RnHQDk/kqxXJPImal+FWVDntmH5GURex1vAcAC3rXIH/UTAWQhS5owGkqenlz7w==
X-Received: by 2002:a63:5d08:: with SMTP id r8mr2852677pgb.174.1600933018492;
        Thu, 24 Sep 2020 00:36:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a27sm1817356pfk.52.2020.09.24.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:36:57 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:36:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
Message-ID: <202009240018.A4D8274F@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org>
 <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 02:25:03AM +0200, Jann Horn wrote:
> On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > +/* When no bits are set for a syscall, filters are run. */
> > +struct seccomp_bitmaps {
> > +#ifdef SECCOMP_ARCH
> > +       /* "allow" are initialized to set and only ever get cleared. */
> > +       DECLARE_BITMAP(allow, NR_syscalls);
> 
> This bitmap makes sense.
> 
> > +       /* These are initialized to clear and only ever get set. */
> > +       DECLARE_BITMAP(kill_thread, NR_syscalls);
> > +       DECLARE_BITMAP(kill_process, NR_syscalls);
> 
> I don't think these bitmaps make sense, this is not part of any fastpath.

That's a fair point. I think I arrived at this design because it ended
up making filter addition faster ("don't bother processing this one,
it's already 'kill'"), but it's likely not worse the memory usage
trade-off.

> (However, a "which syscalls have a fixed result" bitmap might make
> sense if we want to export the list of permitted syscalls as a text
> file in procfs, as I mentioned over at
> <https://lore.kernel.org/lkml/CAG48ez3Ofqp4crXGksLmZY6=fGrF_tWyUCg7PBkAetvbbOPeOA@mail.gmail.com/>.)

I haven't found a data structure I'm happy with for this. It seemed like
NR_syscalls * sizeof(u32) was rather a lot (i.e. to store the BPF_RET
value). However, let me discuss that more in the "why in in thread?"
below...

> The "NR_syscalls" part assumes that the compat syscall tables will not
> be bigger than the native syscall table, right? I guess that's usually
> mostly true nowadays, thanks to the syscall table unification...
> (might be worth a comment though)

Hrm, I had convinced myself it was a max() of compat. But I see no
evidence of that now. Which means that I can add these to the per-arch
seccomp defines with something like:

# define SECCOMP_NR_NATIVE	NR_syscalls
# define SECCOMP_NR_COMPAT	X32_NR_syscalls
...

> > +#endif
> > +};
> > +
> >  struct seccomp_filter;
> >  /**
> >   * struct seccomp - the state of a seccomp'ed process
> > @@ -45,6 +56,13 @@ struct seccomp {
> >  #endif
> >         atomic_t filter_count;
> >         struct seccomp_filter *filter;
> > +       struct seccomp_bitmaps native;
> > +#ifdef CONFIG_COMPAT
> > +       struct seccomp_bitmaps compat;
> > +#endif
> > +#ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> > +       struct seccomp_bitmaps multiplex;
> > +#endif
> 
> Why do we have one bitmap per thread (in struct seccomp) instead of
> putting the bitmap for a given filter and all its ancestors into the
> seccomp_filter?

I explicitly didn't want to add code that was run per-filter; I wanted
O(1), not O(n) even if the n work was a small constant. There is
obviously a memory/perf tradeoff here. I wonder if the middle ground
would be to put a bitmap and "constant action" results in the filter....
oh duh. The "top" filter is already going to be composed with its
ancestors. That's all that needs to be checked. Then the tri-state can
be:

bitmap accept[NR_syscalls]: accept or check "known" bitmap
bitmap filter[NR_syscalls]: run filter or return known action
u32 known_action[NR_syscalls];

(times syscall numbering "architecture" counts)

Though perhaps it would be just as fast as:

bitmap run_filter[NR_syscalls]: run filter or return known_action
u32 known_action[NR_syscalls];

where accept isn't treated special...

> 
> >  };
> >
> >  #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 0a3ff8eb8aea..111a238bc532 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -318,7 +318,7 @@ static inline u8 seccomp_get_arch(u32 syscall_arch, u32 syscall_nr)
> >
> >  #ifdef SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH
> >         if (syscall_arch == SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH) {
> > -               seccomp_arch |= (sd->nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
> > +               seccomp_arch |= (syscall_nr & SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK) >>
> >                                 SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT;
> 
> This belongs over into patch 1.

Thanks! I was rushing to get this posted so YiFei Zhu wouldn't spend
time fighting with arch and Kconfig stuff. :) I'll clean this (and the
other random cruft) up.

-- 
Kees Cook
