Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55D352FFD
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 21:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhDBT4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBT4p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 15:56:45 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E72C0613E6;
        Fri,  2 Apr 2021 12:56:43 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r17so5486768ilt.0;
        Fri, 02 Apr 2021 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SEsb7vh+CZcEKmk1NVRcwdvZKX+CQxqLVH4FqSzjuYY=;
        b=FAN5wdPxYffrCEaqvrJbeNH2P2FBYMx4R5DY8QGvaTLz/kciflnwBUSKGvfMyBBUC7
         5sbY6BaGgMhGw8hFsfqRKCTlL3LK9i1SLLd9eKDBa6nxCHJuj3R0eTPxCxCQkdFsa62a
         8+no6Ug4AAjEl1/i5v+Cu+Aaip/tCrV6cKLFu9RqKvxR4UY1AeuiBde4hp05ZjE3TsmX
         zgvOqNRR3XNkDB18ZgbSPrSzh82urUc8iSd708weBToWt74H3kJaDeNOYDG5hxclFE7R
         Lcz5JzuhvwQqAAxyULt6wqBP/xrC+2KZlrun61IzlLaK0WoffaMF1TO3zmj2Di/L36eL
         f/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SEsb7vh+CZcEKmk1NVRcwdvZKX+CQxqLVH4FqSzjuYY=;
        b=nvrTy9yWBzUpj/ZJ6OLiaXh2tuv1z72YbCm0b5XeZTD0nw1l+Id05jRb2envdzb9RQ
         ELElW1blHARtG+Krs8rxQyDfonsmLBhkohrVdBZzZpK7MueOBAZw3qvaoxntDWLUqwIK
         MW4RWfKHuLlep3W4Nuu5n188oAPHQBfGrpY/OKAIACOjmt8R2xUjLsVgAAgZQ3P40WgW
         dCsHhAqVFwXq+flPotPHKcARMKVdyQJzfIVQuqWc11pSLbLpwk2TlLjrRP6RX8Thxl3u
         iakEjJf5a8DQDnZqgvxj1IU1DizJKnUrq/x0WqMBmW7y9MvC+i5T+xr/iTbP/S1XlWDe
         d4EA==
X-Gm-Message-State: AOAM533aygy8dEG7SbujeIjJzCrWWUL+Nf8yAltgI7ZhRAIi5wMGpVbc
        17Hd71gBocti11NokQStPu3pCK4fc/GMmvsqufs=
X-Google-Smtp-Source: ABdhPJwdme4xuPAU23c7OFsZ6SylAgjh3oSX8tO0hProiZn87QQc6xXh65YqO03tRnN4+1wkIgwzuqcqNqstbPKNoqI=
X-Received: by 2002:a92:d78f:: with SMTP id d15mr11976407iln.112.1617393403125;
 Fri, 02 Apr 2021 12:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210401232723.3571287-1-yhs@fb.com> <CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN=UBNdQiO3g@mail.gmail.com>
 <CA+icZUVkS4epkNoktGDGGEQcOY8CNcRsAHbjK=Z-9uLUgqiNfw@mail.gmail.com> <CA+icZUWskBYk9fFzJ-6=P9bRA3Fo-_+tQNO0HFOOuoA3S26oRA@mail.gmail.com>
In-Reply-To: <CA+icZUWskBYk9fFzJ-6=P9bRA3Fo-_+tQNO0HFOOuoA3S26oRA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 2 Apr 2021 21:56:06 +0200
Message-ID: <CA+icZUUJ73vNAAUToauSLdHWcwiA_fK64b4AK0mAp3gcbWrkUQ@mail.gmail.com>
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

On Fri, Apr 2, 2021 at 9:38 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Apr 2, 2021 at 8:31 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Apr 2, 2021 at 8:07 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Thu, Apr 1, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > > Currently, clang LTO built vmlinux won't work with pahole.
> > > > LTO introduced cross-cu dwarf tag references and broke
> > > > current pahole model which handles one cu as a time.
> > > > The solution is to merge all cu's as one pahole cu as in [1].
> > > > We would like to do this merging only if cross-cu dwarf
> > > > references happens. The LTO build mode is a pretty good
> > > > indication for that.
> > > >
> > > > In earlier version of this patch ([2]), clang flag
> > > > -grecord-gcc-switches is proposed to add to compilation flags
> > > > so pahole could detect "-flto" and then merging cu's.
> > > > This will increate the binary size of 1% without LTO though.
> > > >
> > > > Arnaldo suggested to use a note to indicate the vmlinux
> > > > is built with LTO. Such a cheap way to get whether the vmlinux
> > > > is built with LTO or not helps pahole but is also useful
> > > > for tracing as LTO may inline/delete/demote global functions,
> > > > promote static functions, etc.
> > > >
> > > > So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
> > > > The owner of the note is "Linux".
> > > >
> > > > With gcc 8.4.1 and clang trunk, without LTO, I got
> > > >   $ readelf -n vmlinux
> > > >   Displaying notes found in: .notes
> > > >     Owner                Data size        Description
> > > >   ...
> > > >     Linux                0x00000004       func
> > > >      description data: 00 00 00 00
> > > >   ...
> > > > With "readelf -x ".notes" vmlinux", I can verify the above "func"
> > > > with type code 0x101.
> > > >
> > > > With clang thin-LTO, I got the same as above except the following:
> > > >      description data: 01 00 00 00
> > > > which indicates the vmlinux is built with LTO.
> > > >
> > > >   [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
> > > >   [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
> > > >
> > > > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > >
> > > LGTM thanks Yonghong!
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > > ---
> > > >  include/linux/elfnote-lto.h | 14 ++++++++++++++
> > > >  init/version.c              |  2 ++
> > > >  scripts/mod/modpost.c       |  2 ++
> > > >  3 files changed, 18 insertions(+)
> > > >  create mode 100644 include/linux/elfnote-lto.h
> > > >
> > > > Changelogs:
> > > >   v3 -> v4:
> > > >     . put new lto note in its own header file similar to
> > > >       build-salt.h. (Nick)
> >
> > That is a bit smarter (and smaller) than v3.
> > Queued up and building a new clang-lto kernel...
> > Will report later.
> >
>
> link="https://lore.kernel.org/bpf/3f29403d-4942-e362-c98a-4e2d20a3db88@fb.com/T/#t"
> b4 -d am $link
>
> Needs this fix for the pahole side?
>
> $ git diff
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 026d13789ff9..244816042c88 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2501,8 +2501,8 @@ static int cus__load_debug_types(struct cus
> *cus, struct conf_load *conf,
>        return 0;
> }
>
> -/* Match the define in linux:include/linux/elfnote.h */
> -#define LINUX_ELFNOTE_BUILD_LTO                0x101
> +/* Match the define in linux:include/linux/elfnote-lto.h */
> +#define LINUX_ELFNOTE_LTO_INFO         0x101
>
> static bool cus__merging_cu(Dwarf *dw, Elf *elf)
> {
> @@ -2520,7 +2520,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
>                        size_t name_off, desc_off, offset = 0;
>                        GElf_Nhdr hdr;
>                        while ((offset = gelf_getnote(data, offset,
> &hdr, &name_off, &desc_off)) != 0) {
> -                               if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
> +                               if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
>                                        continue;
>
>                                /* owner is Linux */
>

I applied above diff against [1] which includes v3:

dwarf_loader: Handle subprogram ret type with abstract_origin properly
dwarf_loader: Check .notes section for LTO build info
dwarf_loader: Check .debug_abbrev for cross-CU references

- Sedat -

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.master

>
> >
> > > >   v2 -> v3:
> > > >     . abandoned the approach of adding -grecord-gcc-switches,
> > > >       instead create a note to indicate whether it is a lto build
> > > >       or not. The note definition is in compiler.h. (Arnaldo)
> > > >   v1 -> v2:
> > > >     . limited to add -grecord-gcc-switches for LTO_CLANG
> > > >       instead of all clang build
> > > >
> > > > diff --git a/include/linux/elfnote-lto.h b/include/linux/elfnote-lto.h
> > > > new file mode 100644
> > > > index 000000000000..d4635a3ecc4f
> > > > --- /dev/null
> > > > +++ b/include/linux/elfnote-lto.h
> > > > @@ -0,0 +1,14 @@
> > > > +#ifndef __ELFNOTE_LTO_H
> > > > +#define __ELFNOTE_LTO_H
> > > > +
> > > > +#include <linux/elfnote.h>
> > > > +
> > > > +#define LINUX_ELFNOTE_LTO_INFO 0x101
> > > > +
> > > > +#ifdef CONFIG_LTO
> > > > +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
> > > > +#else
> > > > +#define BUILD_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
> > > > +#endif
> > > > +
> > > > +#endif /* __ELFNOTE_LTO_H */
> > > > diff --git a/init/version.c b/init/version.c
> > > > index 92afc782b043..1a356f5493e8 100644
> > > > --- a/init/version.c
> > > > +++ b/init/version.c
> > > > @@ -9,6 +9,7 @@
> > > >
> > > >  #include <generated/compile.h>
> > > >  #include <linux/build-salt.h>
> > > > +#include <linux/elfnote-lto.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/uts.h>
> > > >  #include <linux/utsname.h>
> > > > @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
> > > >         " (" LINUX_COMPILER ") %s\n";
> > > >
> > > >  BUILD_SALT;
> > > > +BUILD_LTO_INFO;
> > > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > > index 24725e50c7b4..98fb2bb024db 100644
> > > > --- a/scripts/mod/modpost.c
> > > > +++ b/scripts/mod/modpost.c
> > > > @@ -2191,10 +2191,12 @@ static void add_header(struct buffer *b, struct module *mod)
> > > >          */
> > > >         buf_printf(b, "#define INCLUDE_VERMAGIC\n");
> > > >         buf_printf(b, "#include <linux/build-salt.h>\n");
> > > > +       buf_printf(b, "#include <linux/elfnote-lto.h>\n");
> > > >         buf_printf(b, "#include <linux/vermagic.h>\n");
> > > >         buf_printf(b, "#include <linux/compiler.h>\n");
> > > >         buf_printf(b, "\n");
> > > >         buf_printf(b, "BUILD_SALT;\n");
> > > > +       buf_printf(b, "BUILD_LTO_INFO;\n");
> > > >         buf_printf(b, "\n");
> > > >         buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
> > > >         buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> > > > --
> > > > 2.30.2
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CAKwvOdmX8d3XTzJFk5rN_PnOQYJ8bXMrh8DrhzqN%3DUBNdQiO3g%40mail.gmail.com.
