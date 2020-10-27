Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41EB29CC14
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 23:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506760AbgJ0WiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 18:38:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44310 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410088AbgJ0WiS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 18:38:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id o3so1603802pgr.11
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9O+TmXhlnfP5R6O9DpvzK2ercmawtIkUjzbxe45Iwg=;
        b=otD0MCq45wssDlOXzQwczNbnAOzRVOtZq8ghq/C9+xy1YHDSsCKD90mb3q8OLOqT04
         AWo+bHszx+5HStkJxvJhg262Oqr0seRMbRPO2PwP29amCUZyYV6nax37AcvcQDidjX7k
         BoSPvpE0Go7t2cGoWmLGxZhAL195kZI4C8kSw6TZJsqHFC8MhcuKrPBQNyrgrfaeCY6f
         gWlRsRRvcroD3aYV82K9WS4hqzO3eDXAGVsUZ8YrybzSHF3qoqgYhZuSyvXSrp6Lh+1U
         ZIDUyXA0G3vT/1CkBNC7OodyLxOIBILUbnGwO70M3ujrcyA9spiw7g3ZCl6CzSshSTEv
         szCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9O+TmXhlnfP5R6O9DpvzK2ercmawtIkUjzbxe45Iwg=;
        b=PMK1t6SiyQ3Ia6pFDd/8Ncf6IIuINRrKaJUUMmpUV/vsSQq6HQzPqyerwrIlyQstYb
         3EYwP/K4kF2GqVHnPvqvIv2zWlQEapHna8ehx4KhKZ01mXXIkZoXNmlcmPyZGjZhnKc9
         J1Mz0JrYmi+qkQe34DykCzOPcLjb1fuPaQQrLoio5KPOD+0N0RfPlUDHjSLSJw+6Lhkx
         gtK+mpmd093hv4FH+bqFNW/aUwkzn7iZ8SkPbQ9NXVbn4dLkwvR8h5WhmrjozCXar+oP
         cxPzvCS9/p1lFTasSL0cpqErlaHtMgeCF8vZDBJ1lUTLvMhDwlu/nmY5R9OrNlr8uPEM
         JssA==
X-Gm-Message-State: AOAM5301rLZ3yzg2OuEOzBMAD/eB05Y85cfSHMH7h2CAw8aIWquD4sOl
        PI4x1gFuGmlk1FYfNHsTq0KCbfL5WiLyD+96+eKgHg==
X-Google-Smtp-Source: ABdhPJzP7j1Lbj4WSsoUKb2lWQx7WDgPStbwHlqaHM9gPztwgyJ4hgczG3OAoGh39yapaieXK2OogSBg7OE6lsO67Tk=
X-Received: by 2002:a62:2905:0:b029:15b:57ef:3356 with SMTP id
 p5-20020a6229050000b029015b57ef3356mr3561178pfp.36.1603838297314; Tue, 27 Oct
 2020 15:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201027205723.12514-1-ardb@kernel.org> <CAKwvOdmSaVcgq2eKRjRL+_StdFNG2QnNe3nGCs2PWfH=HceadA@mail.gmail.com>
 <CAMj1kXHb8Fe9fqpj4-90ccEMB+NJ6cbuuog-2Vuo7tr7VjZaTA@mail.gmail.com>
 <CAKwvOdnfkZXJdZkKO6qT53j6nH4HF=CcpUZcr7XOqdnQLSShmw@mail.gmail.com> <CAMj1kXGFWr5FSiO79VYEYhB2eCpDP5vyTJmdskxrKWnUz-GP-w@mail.gmail.com>
In-Reply-To: <CAMj1kXGFWr5FSiO79VYEYhB2eCpDP5vyTJmdskxrKWnUz-GP-w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Oct 2020 15:38:06 -0700
Message-ID: <CAKwvOdmcuSce_R_4=BmewPm_3t75_dkDan7YMXF_cb39mQEDyw@mail.gmail.com>
Subject: Re: [PATCH] bpf: don't rely on GCC __attribute__((optimize)) to
 disable GCSE
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 3:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 23:03, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 2:50 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 27 Oct 2020 at 22:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Tue, Oct 27, 2020 at 1:57 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > > > index 6e390d58a9f8..ac3fa37a84f9 100644
> > > > > --- a/include/linux/compiler_types.h
> > > > > +++ b/include/linux/compiler_types.h
> > > > > @@ -247,10 +247,6 @@ struct ftrace_likely_data {
> > > > >  #define asm_inline asm
> > > > >  #endif
> > > > >
> > > > > -#ifndef __no_fgcse
> > > > > -# define __no_fgcse
> > > > > -#endif
> > > > > -
> > > > Finally, this is going to disable GCSE for the whole translation unit,
> > > > which may be overkill.   Previously it was isolated to one function
> > > > definition.  You could lower the definition of the preprocessor define
> > > > into kernel/bpf/core.c to keep its use isolated as far as possible.
> > > >
> > >
> > > Which preprocessor define?
> >
> > __no_fgcse
> >
>
> But we can't use that, that is the whole point of this patch.

Ah, right because the attribute drops other command line flags...ok,
then -fno-gcse the whole translation unit it is then.

Still need to avoid new warnings with clang though.
-- 
Thanks,
~Nick Desaulniers
