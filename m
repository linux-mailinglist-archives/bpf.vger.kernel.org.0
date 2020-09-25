Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ED2277D9D
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 03:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgIYB1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYB1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 21:27:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD0C0613CE;
        Thu, 24 Sep 2020 18:27:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so1553571pfa.10;
        Thu, 24 Sep 2020 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WX2GerDQN/1DZwYhOgS9HfUlktjE9DG6T36wNYd6ERA=;
        b=PKiLyTOIgHLW+moRjohVGN3nBXtAMxY2kYeSeyQ+lEwxjVykj1TU2m/L4+JKoM4xJP
         ZD5NQacU8BFBKmyzQZHKsWN/98bPRw49TlHi9pKqHibcCLtAf1QS0VXLijE1Cs6czB3N
         3FV6Ph1hXkRMiZsuVZd/MWznqd7sOgwK+P+/mwrQIl6x2+Wewik48GDaSWMpCnMaLw/l
         2HUPAkCy6bvpxVpZvsvkJtXo8s30ovp8FcyPPFv7BMfv142P8Wh5DhEXpOdYiaEwF8JR
         k5lYb97ny5XkQfNh77xbpa2eGyzBKLqYNA2qMwCsBFfi1R8pmaM0ASTB0cNqrvjoK7Fk
         rr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX2GerDQN/1DZwYhOgS9HfUlktjE9DG6T36wNYd6ERA=;
        b=t67l/UWl/2zTJ1OOA0rPX6ySHullJfYZ6Zu66PmITeIz/f/oB/BjKknf1pYQAUODlS
         Xqli4K5cl0KUTHm104urWB0ItzPVUyRub1M3+A8jJWPsiMo2uxkFgtOxg9Dt5gC62ja+
         NNNYFHFJZi/dGvVhYqPV4KOKQtPwpnB4CaOax2RWPN3vQrez0JJ8zOH0KUBy9/SWa1jS
         OeTwN7jdDsw3akYL+4jpfmwkEBGbXsY1Q0vw4KQGyCSQagCt6D739yyAW5nF9YtijBnK
         r1V0VN0M0O+AhYN7bQnioZYQssVOROd2+Xio7H9j8hfeLfVmSNns1EYXUoquuqhEZToP
         k3Rg==
X-Gm-Message-State: AOAM532IKmP/EFD44U2whG5uiRFY4KN3Dc7dzkykZNxdi4TZlDcEg8Mv
        WYOSD7aP32WSs+xsgc6vo/v1FPcMZiFOojElE78=
X-Google-Smtp-Source: ABdhPJySE+Qder4PaqnMJALNyB2UUS+F0xdqjGoIiv8n/RD6wdcY8DBlVZoIdbJGt48BGDMCA2TPysEzgBxUQCqP50s=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr1854155pfe.11.1600997271069; Thu, 24
 Sep 2020 18:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook>
In-Reply-To: <202009241658.A062D6AE@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 20:27:40 -0500
Message-ID: <CABqSeAQ=joheH+0LUZ201U-XwFFsHN3Ouo5FGoscUwn+itkL2w@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[resending this too]

On Thu, Sep 24, 2020 at 6:01 PM Kees Cook <keescook@chromium.org> wrote:
> Disregarding the "how" of this, yeah, we'll certainly need something to
> tell seccomp about the arrangement of syscall tables and how to find
> them.
>
> However, I'd still prefer to do this on a per-arch basis, and include
> more detail, as I've got in my v1.
>
> Something missing from both styles, though, is a consolidation of
> values, where the AUDIT_ARCH* isn't reused in both the seccomp info and
> the syscall_get_arch() return. The problems here were two-fold:
>
> 1) putting this in syscall.h meant you do not have full NR_syscall*
>    visibility on some architectures (e.g. arm64 plays weird games with
>    header include order).

I don't get this one -- I'm not playing with NR_syscall here.

> 2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
>    haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
>    it must be dealt with), which means seccomp's idea of the arch
>    "number" can't be the same as the AUDIT_ARCH.

Why so? Does anyone actually use x32 in a container? The memory cost
and analysis cost is on everyone. The worst case scenario if we don't
support it is that the syscall is not accelerated.

> So, likely a combo of approaches is needed: an array (or more likely,
> enum), declared in the per-arch seccomp.h file. And I don't see a way
> to solve #1 cleanly.
>
> Regardless, it needs to be split per architecture so that regressions
> can be bisected/reverted/isolated cleanly. And if we can't actually test
> it at runtime (or find someone who can) it's not a good idea to make the
> change. :)

You have a good point regarding tests. Don't see how it affects
regressions though. Only one file here is ever included per-build.

> > [...]
> > diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> > index 7cbf733d11af..e13bb2a65b6f 100644
> > --- a/arch/x86/include/asm/syscall.h
> > +++ b/arch/x86/include/asm/syscall.h
> > @@ -97,6 +97,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
> >       memcpy(&regs->bx + i, args, n * sizeof(args[0]));
> >  }
> >
> > +static __maybe_unused const int syscall_arches[] = {
> > +     AUDIT_ARCH_I386
> > +};
> > +
> >  static inline int syscall_get_arch(struct task_struct *task)
> >  {
> >       return AUDIT_ARCH_I386;
> > @@ -152,6 +156,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
> >       }
> >  }
> >
> > +static __maybe_unused const int syscall_arches[] = {
> > +     AUDIT_ARCH_X86_64,
> > +#ifdef CONFIG_IA32_EMULATION
> > +     AUDIT_ARCH_I386,
> > +#endif
> > +};
>
> I'm leaving this section quoted because I'll refer to it in a later
> patch review...
>
> --
> Kees Cook
