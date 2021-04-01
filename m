Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC3351FA4
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 21:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhDATXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbhDATXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 15:23:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE23C05BD2F
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 11:29:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u20so3213097lja.13
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZodewM9BDEcN7RA6IkLqbUAjYGLBtUxxRIlZauN5R30=;
        b=ceqqjt4Stn0V9AQ3sSr7NmTUjQeYCI9ykPvXBIc/X7+tbmHZI47vdlsXCqr7tXtrQm
         uP3Kn4jhag56YvGsn62nC1otJ5iVogOA87M/gK/k0JYnirOWBPbXgMUiebHxGsWWrJNM
         aaLdziVg7XaUJRcIp/4K7E4kYJdoJZwCmJSanBbD8/MXApdnz/QDt9X/d82NMW+Z6Ipi
         vVUyhDLA/HbHmAKw4IQ/PeIxulQPiDLPFH+TySEVaNUZ5iIOG0yOcv0sNSsbCd9+CyyT
         S4LZZqGbyc/HxQ5/0xRntqcsQufko6a8RXZ2SEqbfNezb0lJKdqhNSNMl5wjAZXGtmBr
         zyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZodewM9BDEcN7RA6IkLqbUAjYGLBtUxxRIlZauN5R30=;
        b=X202B/EinmTh3qiC2MVUjd1NNMVSNSEjhvtX2lmspAxTbkiB7FtywZhzDue2MNoOao
         2Cf8/O5h3ST2ELb1Q4cmI/2vi10ClzIrM4FDKEx+zi3SyuRqPc07PpRL4UPjJZhy7/zS
         4aB3UJBAO+xVwl5GvAP6gtOJnIaTkyH2In289D3c5gb6N6SEtNYKw2jkqCpIQoyVxzhC
         Pi7mD2AyqRzHzmG+alcRelIi4p4oQ4FNxtNGKqbS3V6GMPmHyiSZ/N9cfvp8tSV5aWic
         CwAxU7c7Z+OiZBwckK6zf9Uj3zB2w2soP9oAnL/bOIqXXLdiNWJErBeZOHX1lz+hAbBi
         CJew==
X-Gm-Message-State: AOAM533Z1yDd4l8/3dLvkaIl29DopGs2GEJqRFOfy31ff5fpkpqkKgfB
        MV3fOlvd15yBnijfu3+W6mMnDLG8vD5TucpzXGYM/Q==
X-Google-Smtp-Source: ABdhPJzjAsbhblRMKpLoXlyguONp+Qj7WC1Eqd/PUQFlNbTEyuxEjKtevwd69/Vxv+mGoYlJBvjvy9AEtHHiPsbL/eo=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr6207734ljj.341.1617301740883;
 Thu, 01 Apr 2021 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210401012406.1800957-1-yhs@fb.com> <20210401012417.1802681-1-yhs@fb.com>
In-Reply-To: <20210401012417.1802681-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Apr 2021 11:28:49 -0700
Message-ID: <CAKwvOdnDnO4ye5GToe04L8B4Tk+Ls6tAAoMVoi8LoC4gRLyLYQ@mail.gmail.com>
Subject: Re: [PATCH kbuild v3 2/2] kbuild: add an elfnote with type BUILD_COMPILER_LTO_INFO
To:     Yonghong Song <yhs@fb.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 6:24 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, clang LTO built vmlinux won't work with pahole.
> LTO introduced cross-cu dwarf tag references and broke
> current pahole model which handles one cu as a time.
> The solution is to merge all cu's as one pahole cu as in [1].
> We would like to do this merging only if cross-cu dwarf
> references happens. The LTO build mode is a pretty good
> indication for that.
>
> In earlier version of this patch ([2]), clang flag
> -grecord-gcc-switches is proposed to add to compilation flags
> so pahole could detect "-flto" and then merging cu's.
> This will increate the binary size of 1% without LTO though.
>
> Arnaldo suggested to use a note to indicate the vmlinux
> is built with LTO. Such a cheap way to get whether the vmlinux
> is built with LTO or not helps pahole but is also useful
> for tracing as LTO may inline/delete/demote global functions,
> promote static functions, etc.
>
> So this patch added an elfnote with type BUILD_COMPILER_LTO_INFO.
> The owner of the note is "Linux".
>
> With gcc 8.4.1 and clang trunk, without LTO, I got
>   $ readelf -n vmlinux
>   Displaying notes found in: .notes
>     Owner                Data size        Description
>   ...
>     Linux                0x00000004       func
>      description data: 00 00 00 00
>   ...
> With "readelf -x ".notes" vmlinux", I can verify the above "func"
> with type code 0x101.
>
> With clang thin-LTO, I got the same as above except the following:
>      description data: 01 00 00 00
> which indicates the vmlinux is built with LTO.
>
>  [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
>  [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/compiler.h | 8 ++++++++
>  include/linux/elfnote.h  | 1 +
>  init/version.c           | 2 ++
>  scripts/mod/modpost.c    | 1 +
>  4 files changed, 12 insertions(+)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index df5b405e6305..b92930877277 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -245,6 +245,14 @@ static inline void *offset_to_ptr(const int *off)
>   */
>  #define prevent_tail_call_optimization()       mb()
>
> +#include <linux/elfnote.h>
> +
> +#ifdef CONFIG_LTO
> +#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO, 1)
> +#else
> +#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO, 0)
> +#endif

With this approach BUILD_COMPILER_LTO_INFO won't be available `#ifdef
__ASSEMBLER__`; we don't need it today, and perhaps YAGNI, but I think
I prefer how include/linux/build-salt.h defines
LINUX_ELFNOTE_BUILD_SALT and keeps it isolated there.  Similarly, I
think it would be better to create a new header, say
include/linux/elfnote-lto.h that is basically a copy of
include/linux/build-salt.h, but with the relevant defines replaced
with the LTO identifiers you add above.  Then init/version.c and
scripts/mod/modpost.c can include include/linux/elfnote-lto.h and you
don't have to touch include/linux/build-salt.h and we can keep the
elfnote "types" isolated to their respective headers (otherwise this
approach reduces the usefulness of include/linux/build-salt.h even
existing, IMO. Feels like it should just be merged into
include/linux/elfnote.h entirely at that point).

But, this is a much nicer approach! I forgot that elf notes were a thing!

> +
>  #include <asm/rwonce.h>
>
>  #endif /* __LINUX_COMPILER_H */
> diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
> index 04af7ac40b1a..f5ec2b50ab7d 100644
> --- a/include/linux/elfnote.h
> +++ b/include/linux/elfnote.h
> @@ -100,5 +100,6 @@
>   * The types for "Linux" owned notes.
>   */
>  #define LINUX_ELFNOTE_BUILD_SALT       0x100
> +#define LINUX_ELFNOTE_BUILD_LTO                0x101
>
>  #endif /* _LINUX_ELFNOTE_H */
> diff --git a/init/version.c b/init/version.c
> index 92afc782b043..a4f74b06fe78 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -9,6 +9,7 @@
>
>  #include <generated/compile.h>
>  #include <linux/build-salt.h>
> +#include <linux/compiler.h>
>  #include <linux/export.h>
>  #include <linux/uts.h>
>  #include <linux/utsname.h>
> @@ -45,3 +46,4 @@ const char linux_proc_banner[] =
>         " (" LINUX_COMPILER ") %s\n";
>
>  BUILD_SALT;
> +BUILD_COMPILER_LTO_INFO;
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 24725e50c7b4..713c0d5d5525 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2195,6 +2195,7 @@ static void add_header(struct buffer *b, struct module *mod)
>         buf_printf(b, "#include <linux/compiler.h>\n");
>         buf_printf(b, "\n");
>         buf_printf(b, "BUILD_SALT;\n");
> +       buf_printf(b, "BUILD_COMPILER_LTO_INFO;\n");
>         buf_printf(b, "\n");
>         buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
>         buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
