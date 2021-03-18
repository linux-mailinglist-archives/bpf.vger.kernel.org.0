Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F69340FFF
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 22:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhCRVmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbhCRVmF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 17:42:05 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B1C06175F
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:41:15 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id b10so2395064uap.4
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+dtVAUVV+mOR0Fzj0Z90UC8t6lRmPnn/hBpUO6M6Ms=;
        b=kSXVwz/FZC+WpWQB/aGK9DOPu/ajHGciWvYsOcBoA08P2Lnqtj7wOrf8dZ6auNljTJ
         9QlM8ON25d0LHP1BBy4wcnyPzh1vqo7wzYc9ZHKCWsvXk6wRXrz7bnph+co4lGaiBe1U
         GPk5jrj2K9mTZHyq6QKspCmINSQHwHaH0+xkoKVVNeaQYdYJB9d8VSLDETaN7yEJcnZr
         5LJggvUx6k6av5QidARixRz9rJU0dYvgsrxrhEzbzqm4reIeZZEw3EYvPFndTZf4LTgw
         KwMukHwUAG20BQ614YEt8nG1pyvtKolhObYPjFyygTvMvr+8602BA21r+fs5TigrF0/w
         i1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+dtVAUVV+mOR0Fzj0Z90UC8t6lRmPnn/hBpUO6M6Ms=;
        b=thi8ISC8yznK0KAEmr1a+V9hh7tCGlfwZX+KsdtUyhSXENm7xoEnUZhdBx5D+b/py9
         BgTTwzTWBZhoWfPvB8xtbvvrKp4x/7MMk4K3lZXvBnZr9fsbA7PNzn7WqOnZOKqtTA/y
         SIW2EQMdJh62I+OcaWlwsv4cirBMOIzX/UBH/LNZyLZNn2/P16/aBku9zJ+LdnuuN2D4
         1c1zjwdvsM22MZPaJ0yR8ZvSvBwoh0Jql9aw3HYsVOCNL+ye2440PFE+e0ZgarZssu2N
         Pu8wikAqHzD/5g8KtiMDadNa8fKu4+UdFYz7ulpzinkFw81YwaT/iiNtPAfuLeGk6ns8
         N1Uw==
X-Gm-Message-State: AOAM531uY/MImeJUjr1d31QJ+wzS+49uqlEwyimdcfx+KkgZzZ9omEG5
        u1hMQ7Sk0HTOe9RhRfjNTYR5j3gRPrDScMET5wVLWw==
X-Google-Smtp-Source: ABdhPJzCEQzYkNsCoJUS10DgD6+JUA1cBSzuavn2A8KRdSpseJN1j+Mrv0FTmfbfmt5jjm1OJkiESZMfey2NR729Ct8=
X-Received: by 2002:ab0:5e9:: with SMTP id e96mr3726573uae.89.1616103674608;
 Thu, 18 Mar 2021 14:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-8-samitolvanen@google.com> <CAKwvOdkETA4OU5d_f_8eCeXgo4juagHuPWo6Fd4jg7C1cWqoYA@mail.gmail.com>
In-Reply-To: <CAKwvOdkETA4OU5d_f_8eCeXgo4juagHuPWo6Fd4jg7C1cWqoYA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 18 Mar 2021 14:41:03 -0700
Message-ID: <CABCJKueWJ0we0K+gw39=bF-uaz36dQ11uTsE+a5pAb6GrM-+5g@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kallsyms: strip ThinLTO hashes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 12:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> > of all static functions not marked __used. This can break userspace
> > tools that don't expect the function name to change, so strip out the
> > hash from the output.
> >
> > Suggested-by: Jack Pham <jackp@codeaurora.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/kallsyms.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 49 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 8043a90aa50e..17d3a704bafa 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -161,6 +161,26 @@ static unsigned long kallsyms_sym_address(int idx)
> >         return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
> >  }
> >
> > +#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> > +/*
> > + * LLVM appends a hash to static function names when ThinLTO and CFI are
> > + * both enabled, which causes confusion and potentially breaks user space
>
> Might be nice to add an example, something along the lines of:
> ie. foo() becomes foo$asfdasdfasdfasdf()

Agreed, I'll update the comment in v3.

>
> > + * tools, so we will strip the postfix from expanded symbol names.
>
> s/postfix/suffix/ ?

Ack.

>
> > + */
> > +static inline char *cleanup_symbol_name(char *s)
> > +{
> > +       char *res = NULL;
> > +
> > +       res = strrchr(s, '$');
> > +       if (res)
> > +               *res = '\0';
> > +
> > +       return res;
> > +}
> > +#else
> > +static inline char *cleanup_symbol_name(char *s) { return NULL; }
> > +#endif
>
> Might be nicer to return a `bool` and have the larger definition
> `return res != NULL`).  Not sure what a caller would do with `res` if
> it was not `NULL`?

Sure, I'll change this to bool.

Sami
