Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A051035E6B6
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDMS5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhDMS5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 14:57:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1915C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 11:56:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z8so20537870ljm.12
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARfjqOYNlaO1jlju+4KpJJ8P9tnwboLeDU5ZxUNADXs=;
        b=XtMB5W7g9lY6AlnmGkOSwvq52ixaNb4o6KK3VO1O8ZO1r0weC6u9I5V28BZx2iPmVD
         osbmxjmWZA79yAEsCO53+lbdFwFV6r8PFo8Jb4jWPqJELLqRdUe4OtF70aT+Hr3666y4
         7jqZ9BEorgfnKwP+RGS8pU2Dlgm0xy6lV/BGwNFuPpDanUWNQQhGGYwfLksFaQaiTwio
         QyXz0I+vh7KCw6YA7AZH0tXrXDR8kHXt/7t3uVFfCm4Sd0jVom1gW6zvIJHDr+k/rq7u
         FS/8ixHryX9vkJljDjOZBLFuzA78A0iVpxg1drgrIBX69RDFw7LFlp0CGMHIXSaIkM6m
         6t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARfjqOYNlaO1jlju+4KpJJ8P9tnwboLeDU5ZxUNADXs=;
        b=PowjCAaCL35I7jpwcqOx5aJ1qFK/HZH91TBB4th3wuN/uTqiVObxMQrHOaq9KofIIQ
         S6lSK0Q1cw29fEiw7SxVP4f6STjPDCDiTeDpAoZipTPkXuuG4Gs11Gd8JlNLxjdS2xQT
         8y6t0pxjAZRuM1l8xdJFX9Q4moe/SQ76nHr1i59zYXzrTaxF1LBDFsqOTmw/a3ZR9Oeb
         RAx665fX/lLa+cUp0BTZlnr3qX6VjXqTjTOItkICql5nO7WNhPSXRcxHuC/EAkcQzoEG
         NBnilSQmftSiNYcNVKLgFZRu1G54rQoCu6xvpnyc0pEGFzZ5OvFZzCiXfvqQjrAJEgqK
         NLKQ==
X-Gm-Message-State: AOAM531GY0IrfMRgQNKe7o3D8uI8fJONlRAkqN2qi6bSq7Jgs39+eKxm
        W+Z1uPo2NDJm5lookSvTz4EEjivkpq2vd8V/Mk7tLA==
X-Google-Smtp-Source: ABdhPJyljz1Cvhkj/tag3RLbVji65GDzfSuLlN43MNyZ0MSVdmHwhq0r03hGyi+wlNWpDhJuf3T9KQyMV+QuKSpSSJY=
X-Received: by 2002:a2e:988a:: with SMTP id b10mr22038250ljj.341.1618340204142;
 Tue, 13 Apr 2021 11:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com> <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
In-Reply-To: <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 11:56:33 -0700
Message-ID: <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 11:46 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Apr 12, 2021 at 5:31 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 4/12/21 5:02 PM, Nick Desaulniers wrote:
> > > On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > >>
> > >> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> > >>>
> > >>> To build kernel with clang, people typically use
> > >>>    make -j60 LLVM=1 LLVM_IAS=1
> > >>> LLVM_IAS=1 is not required for non-LTO build but
> > >>> is required for LTO build. In my environment,
> > >>> I am always having LLVM_IAS=1 regardless of
> > >>> whether LTO is enabled or not.
> > >>>
> > >>> After kernel is build with clang, the following command
> > >>> can be used to build selftests with clang:
> > >>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> > >>
> > >> Thank you for the series Yonghong.  When I test the above command with
> > >> your series applied, I observe:
> > >> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> > >> 'reallocarray' follows non-static declaration
> > >> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
> > >>                      ^
> > >> /usr/include/stdlib.h:559:14: note: previous declaration is here
> > >> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
> > >>               ^
> > >> so perhaps the detection of
> > >> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?
> > >
> > > Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
> > >         reallocarray():
> > >             Since glibc 2.29:
> > >                 _DEFAULT_SOURCE
> > >             Glibc 2.28 and earlier:
> > >                 _GNU_SOURCE
> > >
> >
> > You can try the following patch to see whether it works or not.
> >
> > diff --git a/tools/build/feature/test-reallocarray.c
> > b/tools/build/feature/test-reallocarray.c
> > index 8f6743e31da7..500cdeca07a7 100644
> > --- a/tools/build/feature/test-reallocarray.c
> > +++ b/tools/build/feature/test-reallocarray.c
> > @@ -1,5 +1,5 @@
> >   // SPDX-License-Identifier: GPL-2.0
> > -#define _GNU_SOURCE
> > +#define _DEFAULT_SOURCE
> >   #include <stdlib.h>
> >
> >   int main(void)
> > @@ -7,4 +7,4 @@ int main(void)
> >          return !!reallocarray(NULL, 1, 1);
> >   }
> >
> > -#undef _GNU_SOURCE
> > +#undef _DEFAULT_SOURCE
>
> Yeah, I had tried that. No luck though; same error message.  Even:
>
> $ cat foo.c
> #define _DEFAULT_SOURCE
> #include <stdlib.h>
> void *reallocarray(void *ptr, size_t nmemb, size_t size) { return (void*)0; };
> $ clang -c foo.c
> $ echo $?
> 0
>
> So I'm not sure precisely what's going on here.  I probably have to go
> digging around to understand tools/build/feature/ anyways.  With your
> v3 applied, I consistently see:
> No zlib found
> and yet, I certainly do have zlib on my host.
> https://stackoverflow.com/a/54558861

Jiri, any tips on how to debug feature detection in
tools/build/feature/Makefile?

>
> > [yhs@devbig003.ftw2 ~/work/bpf-next/tools/build]$
> >
> > > $ cd tools/testing/selftests/bpf
> > > $ grep -rn _DEFAULT_SOURCE | wc -l
> > > 0
> > > $ grep -rn _GNU_SOURCE | wc -l
> > > 37
> > > $ ldd --version | head -n1
> > > ldd (Debian GLIBC 2.31-9+build1) 2.31
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
