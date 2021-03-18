Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52D1341006
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhCRVnq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 17:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhCRVnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 17:43:22 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057CFC061762
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:43:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id e7so2375865vsq.3
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfHwrQyYaFFNRaf/CvYeB2LRT6h3FeiX5O3UtAqnQiA=;
        b=D2ijjP5ePIfYIDEXrOl6SDjSdjWjga6MRV8x79wzTLPOVqUpfTJnY2QYInFiUQe300
         7Wd0/IAuihmXXNGJNDqs9nk9heQzahphl4UNIcCz0UvOFNTtXMXihJAT4F3fY2MkU9tP
         anRJPdXyTpdcRVy1iVvr5R3m6pZbhB3eIjk8ak7rAUjS5dmaRT40Vve02NnL2PJ0bpOv
         vfy6ZmelVNhYlyWj1owJSp8hEW9w0mXHGHES9YqGKthabTM77JnbUtneR9a9qfjT+7l3
         TvPo6wJhx8LTr1JrQPctmfiHr8yymDGcyklaDaW6+jKBDnPLjVNDVuW0ElWvM5MEXohP
         81lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfHwrQyYaFFNRaf/CvYeB2LRT6h3FeiX5O3UtAqnQiA=;
        b=bDi+bl4mCk0ZmEBNj/Jo1fyYgcCx8MGwEmC/+4SiOmh42kxpUgOy9KJtc1kujL0ID0
         FBkvHnlvdVkYug7AGi5Krr66+2Rd2q/WA00wMaWliTN0rz+BYpNZ4DPrlkQTss7ZU0i9
         XN/YoHS9YImZN6Y2qKHiMvvp7y9CVT0xw6o4UORnO9qYyEwyz290+GjF2ywRW23vOVA6
         fqaX83N9o3G683cX/UR71ApbPUZt8nn4haJY/AuROQHeqtfsG4jZBTdN2vdNVMSqpaJv
         z28pHrNzq8MwRjDrOzcdCqaNBfZzuuEdTR4hIAld5xCt9nK3bokGCey7GljFOgNARnvE
         fqlQ==
X-Gm-Message-State: AOAM532B3jalqF7m4gnyQcHb+AJ/4cKTeCplTPb7GgnstZVRbH/roBtY
        1AoNVHGrdxFdBZh5q6OPz0v9NCw3WRUqallVkBTW6w==
X-Google-Smtp-Source: ABdhPJy9nS3adGHPZWSvJ9275dmkHoQl55Y6NziJFaephhWth/YdK5K0qI8noGx0c2z+S/anWDkygwUMfNbI12wJXp8=
X-Received: by 2002:a05:6102:124e:: with SMTP id p14mr1004922vsg.14.1616103800982;
 Thu, 18 Mar 2021 14:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
 <20210318171111.706303-5-samitolvanen@google.com> <CAKwvOdkbok-BoYGfvHH1HR=cMztaBYZKB-UHRDZ4g5YjSCuq2A@mail.gmail.com>
In-Reply-To: <CAKwvOdkbok-BoYGfvHH1HR=cMztaBYZKB-UHRDZ4g5YjSCuq2A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 18 Mar 2021 14:43:09 -0700
Message-ID: <CABCJKuektSxnfcPxadj-eA3qdVkqBaXQAGC40vvR-eBjzZguvw@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] module: ensure __cfi_check alignment
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

On Thu, Mar 18, 2021 at 12:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 10:11 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
> > aligned and at the beginning of the .text section. While Clang would
> > normally align the function correctly, it fails to do so for modules
> > with no executable code.
> >
> > This change ensures the correct __cfi_check() location and
> > alignment. It also discards the .eh_frame section, which Clang can
> > generate with certain sanitizers, such as CFI.
> >
> > Link: https://bugs.llvm.org/show_bug.cgi?id=46293
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  scripts/module.lds.S | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> > index 168cd27e6122..93518579cf5d 100644
> > --- a/scripts/module.lds.S
> > +++ b/scripts/module.lds.S
> > @@ -3,10 +3,19 @@
> >   * Archs are free to supply their own linker scripts.  ld will
> >   * combine them automatically.
> >   */
> > +#include <asm/page.h>
> > +
> > +#ifdef CONFIG_CFI_CLANG
> > +# define ALIGN_CFI ALIGN(PAGE_SIZE)
> > +#else
> > +# define ALIGN_CFI
> > +#endif
> > +
> >  SECTIONS {
> >         /DISCARD/ : {
> >                 *(.discard)
> >                 *(.discard.*)
> > +               *(.eh_frame)
>
> Do we want to unconditionally discard this section from modules for
> all arches/configs?  I like how we conditionally do so on
> SANITIZER_DISCARDS in include/asm-generic/vmlinux.lds.h for example.

I think nothing should generate this section unless one of the
sanitizers is enabled, but I'm fine with using the same logic as
vmlinux.lds.h here. I'll change this in v3.

Sami
