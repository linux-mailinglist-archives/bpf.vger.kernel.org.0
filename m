Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1320352F4E
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhDBSby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhDBSbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 14:31:53 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87401C0613E6;
        Fri,  2 Apr 2021 11:31:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t14so5294635ilu.3;
        Fri, 02 Apr 2021 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BFBhTWbA18iJBRtXWFRSWL3NbbovxojieVF5twnWirs=;
        b=Tc5Kq3mPbIujxRM/yG4dLepyGe3i0xnWqqzhk0AX9o3ilPmgjdIqJgnqpM3YTpWGw3
         5QNeJsKtJ9G6JGR33u+dP5fkuVE/OpuixUnS6K/1Fa9tF0g/imuFkfKFqa9uuU/6hEFZ
         D5M9kJFAt9qEDOh9S3Bb6RWsgJgd7UydPZ3YDEUKC/gPAsPfK75tfukc1WqL7tAEqOAQ
         /TaPTZnPToIQU0ve6z18nvcDSQUx9ClWQHo6S8boDEnkn9HkLeJll3U0m7kwIKUfIH/j
         07xTY1Ic2AdUYrFgHehO935S2I9Dnzfkyg965q7eWrCFyHkorM2OmJycEY8nTIPixPql
         /mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BFBhTWbA18iJBRtXWFRSWL3NbbovxojieVF5twnWirs=;
        b=S+WCwtL6dbek+jLzQjJBwZe5ukgv28BPIn+ecqKeNxYH5Kj6M0uL0MfDubCxId6b7h
         RvrDx795l3wxuKuuxM+Ua+N0VmQLMdrmIfBKXHf6FmjavWatCV81GPqvcBZq361xiK1M
         SPv9dnmPPoc+z/yWRe29LFy8LkVbliRdledgmCqnNrohxRgmJsxw4YLRvb40iBlgWKcf
         4KP9sGxgwRhChOVp7dtMvaun1A3LqCihlEHnVmUYXLTg9tlh54Fdx9wsTMNVeRJmUoX/
         46rJu07u1AyqjXAwftR/MxRRrQC3AurJXolq+YkA2Rg8DeuHMAlmzdmuKuydjc3J05Tr
         Is8Q==
X-Gm-Message-State: AOAM5313alhR40BZ6TsGaFfDpHBVe9iHgRRGYEw0wBslC3lWvoW2lSbx
        E5H9SG/dtHdrM1N5TW3sf/IxIrm2I+Plumbs1Y0=
X-Google-Smtp-Source: ABdhPJyUdEuM58vXDHGVrWHdUM1vJXdEDdizX87W+x8pFH0Z7996KSbwX45KJxBPjWNVMtOpctxKXIYExrqnCJkXe38=
X-Received: by 2002:a92:444e:: with SMTP id a14mr11798341ilm.215.1617388311933;
 Fri, 02 Apr 2021 11:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
In-Reply-To: <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 2 Apr 2021 20:31:15 +0200
Message-ID: <CA+icZUVkS4epkNoktGDGGEQcOY8CNcRsAHbjK=Z-9uLUgqiNfw@mail.gmail.com>
Subject: Re: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is
 built with lto
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > Currently, clang LTO built vmlinux won't work with pahole.
> > LTO introduced cross-cu dwarf tag references and broke
> > current pahole model which handles one cu as a time.
> > The solution is to merge all cu's as one pahole cu as in [1].
> > We would like to do this merging only if cross-cu dwarf
> > references happens. The LTO build mode is a pretty good
> > indication for that.
> >
> > In earlier version of this patch ([2]), clang flag
> > -grecord-gcc-switches is proposed to add to compilation flags
> > so pahole could detect "-flto" and then merging cu's.
> > This will increate the binary size of 1% without LTO though.
> >
> > Arnaldo suggested to use a note to indicate the vmlinux
> > is built with LTO. Such a cheap way to get whether the vmlinux
> > is built with LTO or not helps pahole but is also useful
> > for tracing as LTO may inline/delete/demote global functions,
> > promote static functions, etc.
> >
> > So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
> > The owner of the note is "Linux".
> >
> > With gcc 8.4.1 and clang trunk, without LTO, I got
> >   $ readelf -n vmlinux
> >   Displaying notes found in: .notes
> >     Owner                Data size        Description
> >   ...
> >     Linux                0x00000004       func
> >      description data: 00 00 00 00
> >   ...
> > With "readelf -x ".notes" vmlinux", I can verify the above "func"
> > with type code 0x101.
> >
> > With clang thin-LTO, I got the same as above except the following:
> >      description data: 01 00 00 00
> > which indicates the vmlinux is built with LTO.
> >
> >   [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
> >   [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> >
> > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
>
> LGTM thanks Yonghong!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >  include/linux/elfnote-lto.h | 14 ++++++++++++++
> >  init/version.c              |  2 ++
> >  scripts/mod/modpost.c       |  2 ++
> >  3 files changed, 18 insertions(+)
> >  create mode 100644 include/linux/elfnote-lto.h
> >
> > Changelogs:
> >   v3 -> v4:
> >     . put new lto note in its own header file similar to
> >       build-salt.h. (Nick)

That is a bit smarter (and smaller) than v3.
Queued up and building a new clang-lto kernel...
Will report later.

- Sedat -

> >   v2 -> v3:
> >     . abandoned the approach of adding -grecord-gcc-switches,
> >       instead create a note to indicate whether it is a lto build
> >       or not. The note definition is in compiler.h. (Arnaldo)
> >   v1 -> v2:
> >     . limited to add -grecord-gcc-switches for LTO_CLANG
> >       instead of all clang build
> >
> > diff --git a/include/linux/elfnote-lto.h b/include/linux/elfnote-lto.h
> > new file mode 100644
> > index 000000000000..d4635a3ecc4f
> > --- /dev/null
> > +++ b/include/linux/elfnote-lto.h
> > @@ -0,0 +1,14 @@
> > +#ifndef __ELFNOTE_LTO_H
> > +#define __ELFNOTE_LTO_H
> > +
> > +#include <linux/elfnote.h>
> > +
> > +#define LINUX_ELFNOTE_LTO_INFO 0x101
> > +
> > +#ifdef CONFIG_LTO
> > +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> > +#else
> > +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> > +#endif
> > +
> > +#endif /* __ELFNOTE_LTO_H */
> > diff --git a/init/version.c b/init/version.c
> > index 92afc782b043..1a356f5493e8 100644
> > --- a/init/version.c
> > +++ b/init/version.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <generated/compile.h>
> >  #include <linux/build-salt.h>
> > +#include <linux/elfnote-lto.h>
> >  #include <linux/export.h>
> >  #include <linux/uts.h>
> >  #include <linux/utsname.h>
> > @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
> >         " (" LINUX_COMPILER ") %s\n";
> >
> >  BUILD_SALT;
> > +BUILD_LTO_INFO;
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 24725e50c7b4..98fb2bb024db 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2191,10 +2191,12 @@ static void add_header(struct buffer *b, struct module *mod)
> >          */
> >         buf_printf(b, "#define INCLUDE_VERMAGIC\n");
> >         buf_printf(b, "#include <linux/build-salt.h>\n");
> > +       buf_printf(b, "#include <linux/elfnote-lto.h>\n");
> >         buf_printf(b, "#include <linux/vermagic.h>\n");
> >         buf_printf(b, "#include <linux/compiler.h>\n");
> >         buf_printf(b, "\n");
> >         buf_printf(b, "BUILD_SALT;\n");
> > +       buf_printf(b, "BUILD_LTO_INFO;\n");
> >         buf_printf(b, "\n");
> >         buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
> >         buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> > --
> > 2.30.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN%3DUBNdQiO3g%40mail.gmail.com.
