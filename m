Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81835619B
	for <lists+bpf@lfdr.de>; Wed,  7 Apr 2021 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbhDGDCI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 23:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbhDGDCH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 23:02:07 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E6C06174A;
        Tue,  6 Apr 2021 20:01:57 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l9so8900753ils.6;
        Tue, 06 Apr 2021 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=wGQ0sxcwnuJFFVwGhbqE7uRx2c2DK/aUefWolAGGvoo=;
        b=IhRDrWKuQdFvDAwYh/ag3QDqqS4SlyVAFfhoqOf/5NwNRgIcr6cxHyQzYEfHFTEtz3
         fYrnuf2ZM6myi8QZmKOJb820lezGoCyuV7QkZmhelhppo05GfRxDbBG+gEb2O1uLaaO6
         cwKWDcukBWuLafFT57q20JQ9xOEprDRCGG9i5JImzQ1dwCctEsgVUjUGi0rnkDcMk6MY
         QOn18MZjHhwc2diXtnBiIhOpyNd4uSVnFCtPoWs0CzPv+0UxnrPBFF632UrjvfTWYF4B
         K/074qMewTMx/6YlF8ZwQOejDBUP3+A0BYr1jqexXZLl8AWdOh+L9U8oaesY3yKi9BSy
         7OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wGQ0sxcwnuJFFVwGhbqE7uRx2c2DK/aUefWolAGGvoo=;
        b=Kaa6h+z12Cq8DTxVVCjmx+ql4B7JP0LqvzuChI2eACVlw0NUexNzfCAl6P8+wSZ7AN
         xm2/d8Hx4gwAGqXamdXZfRBp4QlE554nctJAbf4UbgzdDru3YJ2qvTaLdKM6u34am6Or
         Z8CsJmnX6au4UgjI/7zGfI7GU8RBAOnF0PwwQ1tvP317lSbNj3D4dxhWXzkJ9AkVa+aH
         IyFhjZE8MvPhVbVBqtRCVib0hFYwtQqMc9xvRufEeACDJmlgWpQebzK7glYqRxR6FlVp
         2/kbW2C14Jod2/OZra1Hn6MtlxFzmFywo/oaZQx+NooiMcdwwL0MQ5+X7geCud3pf+Tj
         nKgQ==
X-Gm-Message-State: AOAM533ygjCiJZ4Eisqj3DPGP4nO5GaL+S4fwoPCVnrjV7+g09IU9GlV
        uBnhZeihTlxsmiRJyGW8cYhKsN/Jon7u+oQNOW8=
X-Google-Smtp-Source: ABdhPJySsp6EeFECpuYSDaIXmzhBjJCCHKBB+Gi7xjqjMjTEXwsFCSzi5z2LeipY9OsVQ6WscFPvEcLseoPQayWr6hg=
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr1045849ilu.186.1617764516036;
 Tue, 06 Apr 2021 20:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVKCY4UJfSG_sXjZHwfOQZfBZQu0pj1VZ9cXX4e7w0n6g@mail.gmail.com> <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
In-Reply-To: <c6daf068-ead0-810b-2afa-c4d1c8305893@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 7 Apr 2021 05:01:27 +0200
Message-ID: <CA+icZUWYQ8wjOYHYrTX52AbEa3nbXco6ZKdqeMwJaZfHuJ5BhA@mail.gmail.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 6, 2021 at 6:13 PM Yonghong Song <yhs@fb.com> wrote:
>
>
> Masahiro and Michal,
>
> Friendly ping. Any comments on this patch?
>
> The addition LTO .notes information emitted by kernel is used by pahole
> in the following patch:
>     https://lore.kernel.org/bpf/20210401025825.2254746-1-yhs@fb.com/
>     (dwarf_loader: check .notes section for lto build info)
>

Hi Yonghong,

the above pahole patch has this define and comment:

-static bool cus__merging_cu(Dwarf *dw)
+/* Match the define in linux:include/linux/elfnote.h */
+#define LINUX_ELFNOTE_BUILD_LTO 0x101

...and does not fit with the define and comment in this kernel patch:

+#include <linux/elfnote.h>
+
+#define LINUX_ELFNOTE_LTO_INFO 0x101

Thanks.

- Sedat -


> Thanks,
>
> Yonghong
>
> On 4/6/21 12:05 AM, Sedat Dilek wrote:
> > On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> >>
> >> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> Currently, clang LTO built vmlinux won't work with pahole.
> >>> LTO introduced cross-cu dwarf tag references and broke
> >>> current pahole model which handles one cu as a time.
> >>> The solution is to merge all cu's as one pahole cu as in [1].
> >>> We would like to do this merging only if cross-cu dwarf
> >>> references happens. The LTO build mode is a pretty good
> >>> indication for that.
> >>>
> >>> In earlier version of this patch ([2]), clang flag
> >>> -grecord-gcc-switches is proposed to add to compilation flags
> >>> so pahole could detect "-flto" and then merging cu's.
> >>> This will increate the binary size of 1% without LTO though.
> >>>
> >>> Arnaldo suggested to use a note to indicate the vmlinux
> >>> is built with LTO. Such a cheap way to get whether the vmlinux
> >>> is built with LTO or not helps pahole but is also useful
> >>> for tracing as LTO may inline/delete/demote global functions,
> >>> promote static functions, etc.
> >>>
> >>> So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
> >>> The owner of the note is "Linux".
> >>>
> >>> With gcc 8.4.1 and clang trunk, without LTO, I got
> >>>    $ readelf -n vmlinux
> >>>    Displaying notes found in: .notes
> >>>      Owner                Data size        Description
> >>>    ...
> >>>      Linux                0x00000004       func
> >>>       description data: 00 00 00 00
> >>>    ...
> >>> With "readelf -x ".notes" vmlinux", I can verify the above "func"
> >>> with type code 0x101.
> >>>
> >>> With clang thin-LTO, I got the same as above except the following:
> >>>       description data: 01 00 00 00
> >>> which indicates the vmlinux is built with LTO.
> >>>
> >>>    [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
> >>>    [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> >>>
> >>> Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>
> >> LGTM thanks Yonghong!
> >> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >>
> >
> > Thanks for the patch.
> >
> > Feel free to add:
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc4 (x86-64)
> >
> > As a note for the pahole side:
> > Recent patches require an adaptation of the define and its comment.
> >
> > 1. LINUX_ELFNOTE_BUILD_LTO -> LINUX_ELFNOTE_LTO_INFO
> > 2. include/linux/elfnote.h -> include/linux/elfnote-lto.h
> >
> > - Sedat -
> >
> >>> ---
> >>>   include/linux/elfnote-lto.h | 14 ++++++++++++++
> >>>   init/version.c              |  2 ++
> >>>   scripts/mod/modpost.c       |  2 ++
> >>>   3 files changed, 18 insertions(+)
> >>>   create mode 100644 include/linux/elfnote-lto.h
> >>>
> >>> Changelogs:
> >>>    v3 -> v4:
> >>>      . put new lto note in its own header file similar to
> >>>        build-salt.h. (Nick)
> >>>    v2 -> v3:
> >>>      . abandoned the approach of adding -grecord-gcc-switches,
> >>>        instead create a note to indicate whether it is a lto build
> >>>        or not. The note definition is in compiler.h. (Arnaldo)
> >>>    v1 -> v2:
> >>>      . limited to add -grecord-gcc-switches for LTO_CLANG
> >>>        instead of all clang build
> >>>
> >>> diff --git a/include/linux/elfnote-lto.h b/include/linux/elfnote-lto.h
> >>> new file mode 100644
> >>> index 000000000000..d4635a3ecc4f
> >>> --- /dev/null
> >>> +++ b/include/linux/elfnote-lto.h
> >>> @@ -0,0 +1,14 @@
> >>> +#ifndef __ELFNOTE_LTO_H
> >>> +#define __ELFNOTE_LTO_H
> >>> +
> >>> +#include <linux/elfnote.h>
> >>> +
> >>> +#define LINUX_ELFNOTE_LTO_INFO 0x101
> >>> +
> >>> +#ifdef CONFIG_LTO
> >>> +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> >>> +#else
> >>> +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> >>> +#endif
> >>> +
> >>> +#endif /* __ELFNOTE_LTO_H */
> >>> diff --git a/init/version.c b/init/version.c
> >>> index 92afc782b043..1a356f5493e8 100644
> >>> --- a/init/version.c
> >>> +++ b/init/version.c
> >>> @@ -9,6 +9,7 @@
> >>>
> >>>   #include <generated/compile.h>
> >>>   #include <linux/build-salt.h>
> >>> +#include <linux/elfnote-lto.h>
> >>>   #include <linux/export.h>
> >>>   #include <linux/uts.h>
> >>>   #include <linux/utsname.h>
> >>> @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
> >>>          " (" LINUX_COMPILER ") %s\n";
> >>>
> >>>   BUILD_SALT;
> >>> +BUILD_LTO_INFO;
> >>> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> >>> index 24725e50c7b4..98fb2bb024db 100644
> >>> --- a/scripts/mod/modpost.c
> >>> +++ b/scripts/mod/modpost.c
> >>> @@ -2191,10 +2191,12 @@ static void add_header(struct buffer *b, struct module *mod)
> >>>           */
> >>>          buf_printf(b, "#define INCLUDE_VERMAGIC\n");
> >>>          buf_printf(b, "#include <linux/build-salt.h>\n");
> >>> +       buf_printf(b, "#include <linux/elfnote-lto.h>\n");
> >>>          buf_printf(b, "#include <linux/vermagic.h>\n");
> >>>          buf_printf(b, "#include <linux/compiler.h>\n");
> >>>          buf_printf(b, "\n");
> >>>          buf_printf(b, "BUILD_SALT;\n");
> >>> +       buf_printf(b, "BUILD_LTO_INFO;\n");
> >>>          buf_printf(b, "\n");
> >>>          buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
> >>>          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> >>> --
> >>> 2.30.2
> >>>
> >>
> >>
> >> --
> >> Thanks,
> >> ~Nick Desaulniers
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com .
