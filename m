Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C729F9AA
	for <lists+bpf@lfdr.de>; Fri, 30 Oct 2020 01:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgJ3A20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 20:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgJ3A2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Oct 2020 20:28:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1A3C0613CF
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 17:28:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so3708802pgb.10
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDwi5fkz2fdA7OaRrde67x0Vx0YqzDJ9WtGqBgk5940=;
        b=WUyaw4KuGE29rwG84kcGmxDADN6HUT6oeKCmqcPeat6AWXYlZm/GbXSaIvvrli8t5O
         YNOeAaEwDWcLx18V0tku7Y6BspBcRKwHwfzXusIwbllqo605pX6bhwOPPkei9S09Mdq7
         wtMd5aTupcySHbfDtwfur+2zAFv4uje4YVg/2odQZjLFfYwDW7dc0jvBoCeyig+/mgr3
         b60uwyy7evfL+LoBv6Opfg3GNq50IwvvU+k0RVIfCxMo+g+/hu4rr5+5jd8lAi0CZXBa
         uqH4wsr+3VYXU/efy/D7nHoe85z1FXAoHbe8NvNPN7HJQoxOEjrItT/oIlPexo15Tc6S
         J7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDwi5fkz2fdA7OaRrde67x0Vx0YqzDJ9WtGqBgk5940=;
        b=aHD+aE/jO6s4KbavJlh8RkAM0WYKasC1+FwJ+5zpN/BvAtZNIe6uIoCA5+K06Df4+m
         ME4Qnufb0CLL/3kUmP9w8mHThE9+1ThJiFnD3xbwZLf40G94rLKg8Pa4bZgNstC9JpBx
         nerg3UWzj9V9OyiIx+pj562LtQEgsaWGSZrta9yOE4qZ28977IeOd9zcd+xb/yQiXcSO
         vLVxTEdXTRmelOpeUOpoN1Bb2G0UNcBqaeaeoyva9Sem8IFKkgbmsXFGGmKzuQ+0t36/
         cm8Leve/XHZaAfrR53Ee7dVYj/QqCVIYXE01cQQ3Zf11i2+1kD2dky7hss58x+ejy7mp
         mxrQ==
X-Gm-Message-State: AOAM532B2dm85iUK20i6fOdT4W244d+Y06/nj94o8GOzPfneFYdyJbdA
        T86LTRfgeIa4ohtnHuLlRRAxJNNgD+afwi18Men2KA==
X-Google-Smtp-Source: ABdhPJwGhvPJ5K3S8YutGjeIV2dzBV6BJ3VkAWawExavdFHjCJPyR1FeMCSP1JrX9apzWmZAwXAfHbls/Fil83VRAaU=
X-Received: by 2002:aa7:9a04:0:b029:163:fe2a:9e04 with SMTP id
 w4-20020aa79a040000b0290163fe2a9e04mr7213480pfj.30.1604017703610; Thu, 29 Oct
 2020 17:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201028171506.15682-1-ardb@kernel.org> <20201028171506.15682-2-ardb@kernel.org>
 <20201028213903.fvdjydadqt6tx765@ast-mbp.dhcp.thefacebook.com>
 <CAMj1kXFHcM-Jb+MwsLtB4NMUmMyAGGLeNGNLC9vTATot3NJLrA@mail.gmail.com>
 <20201028225919.6ydy3m2u4p7x3to7@ast-mbp.dhcp.thefacebook.com>
 <CAMj1kXG8PmvO6bLhGXPWtzKMnAsip2WDa-qdrd+kFfr30sd8-A@mail.gmail.com> <20201028232001.pp7erdwft7oyt2xm@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201028232001.pp7erdwft7oyt2xm@ast-mbp.dhcp.thefacebook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Oct 2020 17:28:11 -0700
Message-ID: <CAKwvOd=Zrza=i54_=H3n2HkmMhg9EJ3Wy0kR5AXTSqBowsQV5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: don't rely on GCC __attribute__((optimize))
 to disable GCSE
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <netdev@vger.kernel.org>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Oct 28, 2020 at 4:20 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 29, 2020 at 12:10:52AM +0100, Ard Biesheuvel wrote:
> > On Wed, 28 Oct 2020 at 23:59, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > I'm totally fine with making
> > > #define __no_fgcse __attribute__((optimize("-fno-gcse,-fno-omit-frame-pointer")))
> > > to be gcc+x86 only.
> > > I'd like to get rid of it, but objtool is not smart enough to understand
> > > generated asm without it.
> >
> > I'll defer to the x86 folks to make the final call here, but I would
> > be perfectly happy doing
> >
> > index d1e3c6896b71..68ddb91fbcc6 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -176,4 +176,6 @@
> >  #define __diag_GCC_8(s)
> >  #endif
> >
> > +#ifdef CONFIG_X86
> >  #define __no_fgcse __attribute__((optimize("-fno-gcse")))
> > +#endif
>
> If you're going to submit this patch could you please add
> ,-fno-omit-frame-pointer
> to the above as well?

You'll be playing whack-a-mole with other -f flags that should have
been used, which changes even based on the config.  The -fsanitize=
flags come to mind with the sanitizers.

defconfig shows:
$ make LLVM=1 -j71 kernel/bpf/core.o V=1 2>&1 | grep "\-f"
the following -f flags set:

-fno-strict-aliasing
-fno-common
-fshort-wchar
-fno-PIE
-fno-asynchronous-unwind-tables
-fno-delete-null-pointer-checks
-fomit-frame-pointer
-fmacro-prefix-map=./=
-fstack-protector-strong

We already know that -fno-asynchronous-unwind-tables get dropped,
hence this patch.  And we know -fomit-frame-pointer or
-fno-omit-frame-pointer I guess gets dropped, hence your ask.  We
might not know the full extent which other flags get dropped with the
optimize attribute, but I'd argue that my list above can all result in
pretty bad bugs when accidentally omitted (ok, maybe not -fshort-wchar
or -fmacro-prefix-map, idk what those do) or when mixed with code that
has different values those flags control.  Searching GCC's bug tracker
for `__attribute__((optimize` turns up plenty of reports to make me
think this attribute maybe doesn't work the way folks suspect or
intend: https://gcc.gnu.org/bugzilla/buglist.cgi?quicksearch=__attribute__%28%28optimize&list_id=283390.

There's plenty of folks arguing against the use of the optimize
attribute in favor of the command line flag.  I urge you to please
reconsider the request.

> Frankly I'm more worried that -Os will generate incorrect code.

If you have observed bugs as a result of setting
CONFIG_CC_OPTIMIZE_FOR_SIZE, we would love to help you get to the
bottom of them and help you debug them.  But we should also remain
vigilant against rejecting progress on the status quo for known issues
over hypothetical issues without proper regard for evidence.
Correctness is the chief concern of a compiler; that it generates
incorrect code unless default-on optimizations are explicitly disabled
would be concerning, if that was in fact the case.  Such a bug report
would be invaluable to this code base, and likely others.  I trust
you've seen bugs here, but I would like to help verify this claim.

> All compilers have bugs. Kernel has bugs. What can go wrong?

This is more terrifyingly precise and infinitely wise than you may
have initially intended.  That my phone and laptop don't catch fire
simultaneously now is nothing short of miraculous.  I'm still holding
my breath.

--
Thanks,
~Nick Desaulniers
