Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC42D1DA4
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgLGWpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 17:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgLGWpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 17:45:15 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A3C061793;
        Mon,  7 Dec 2020 14:44:35 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t22so16923724ljk.0;
        Mon, 07 Dec 2020 14:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=84NZyZiyC4OmRBVaSotinan5g5hCm7otD/hM6jLzgCE=;
        b=fsVrGztcKudL75OYLON1S5/amW5C1gnztHnfl2ajkJFdra0sd906St+Rg5dHEbJjv6
         AdzdxrTy7vuBz1XF03Cpe7OTM8Q82YAnBwk7TWcyHGhBWMBc7iR4tBsypP57ydTs1BlK
         LC+d/DOZehBxwMMFn3A1hXSQF8DtRDVinDzabW9NeZHNveWxSdOCJmjL1bEuq2HyPq+z
         XuNr7u0Pt6uQKeVSHOkvWVyK4W/oqjxKoI/XwWTVNg8ZeQB3cRlsBISZMyNryUMbi/UF
         1d4k8K097iroGBSjBJ4eK4Hz+9T/hI44cY+j6jW6ks/R4QHsPWQfil0zo03mZ7Psqcrd
         0iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84NZyZiyC4OmRBVaSotinan5g5hCm7otD/hM6jLzgCE=;
        b=CHBrTXxnVzCHDVOymOt5Eo/1FVggMtWAEl1cQjTVTvbf1gJZUwog7UAEm4ChAJwmir
         MdG3tacMeTyczbdrMck3OfhNVoGkdMqMyzmN0LLk59BKJP8lJkMLh/oNRDJcpdn5EC79
         EWG2cYQupcQRehJy8hLRtleN4dB9udnmDDcPXF9joTYuS94ur77fUJ/zSU79ZXOLFb/+
         TcSquMdFferbA1YCBNmecn1K2fepM7vV+oJwXJcZKpd5U7cAjYpjeJte7LDByddCT8VV
         9PEBi2OXHyc3BpUqSp8wiKT/HG+ni6DG+w/z7nrhLwcWAoBFjze+8bUp3VNJdqRdFm9V
         9/Dg==
X-Gm-Message-State: AOAM5324Gn61HqkIGJKp5MiMihUQzbTWvyeXy0aH96fUy8GtKLVf8t+h
        xZW0OGMlLR5vorjoycrn8YGLbgNL031hal+850V4YF9g
X-Google-Smtp-Source: ABdhPJx8I+D+uIgDpHwXbmfqMnBD3T9/NjWmEqKW6qsR4llivZuoaMfVvsqeEJhx5xCEOIwaaIDRq6POv7SrKW1v5iU=
X-Received: by 2002:a2e:8891:: with SMTP id k17mr9048437lji.290.1607381073733;
 Mon, 07 Dec 2020 14:44:33 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com> <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
In-Reply-To: <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 14:44:22 -0800
Message-ID: <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Justin Forbes <jmforbes@linuxtx.org>, bpf <bpf@vger.kernel.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 10:36 AM Justin Forbes <jmforbes@linuxtx.org> wrote:
>
> On Mon, Dec 7, 2020 at 2:16 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > On Thu, Nov 12, 2020 at 08:18:57AM +0800, Alex Shi wrote:
> > >
> > >
> > > =E5=9C=A8 2020/11/11 =E4=B8=8A=E5=8D=883:50, Andrew Morton =E5=86=99=
=E9=81=93:
> > > > On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gma=
il.com> wrote:
> > > >
> > > >> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.co=
m> wrote:
> > > >>>
> > > >>> Otherwise it cause gcc warning:
> > > >>>           ^~~~~~~~~~~~~~~
> > > >>> ../mm/filemap.c:830:14: warning: no previous prototype for
> > > >>> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-prototype=
s]
> > > >>>  noinline int __add_to_page_cache_locked(struct page *page,
> > > >>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >>
> > > >> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> > > >
> > > > hm, yes.
> > >
> > > When the config enabled, compiling looks good untill pahole tool
> > > used to get BTF info, but I still failed on a right version pahole
> > > > 1.16. Sorry.
> > >
> > > >
> > > >>>
> > > >>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > >>> Cc: linux-mm@kvack.org
> > > >>> Cc: linux-kernel@vger.kernel.org
> > > >>> ---
> > > >>>  mm/filemap.c | 2 +-
> > > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/mm/filemap.c b/mm/filemap.c
> > > >>> index d90614f501da..249cf489f5df 100644
> > > >>> --- a/mm/filemap.c
> > > >>> +++ b/mm/filemap.c
> > > >>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old,=
 struct page *new, gfp_t gfp_mask)
> > > >>>  }
> > > >>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> > > >>>
> > > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > > >>> +static noinline int __add_to_page_cache_locked(struct page *page=
,
> > > >>>                                         struct address_space *map=
ping,
> > > >>>                                         pgoff_t offset, gfp_t gfp=
,
> > > >>>                                         void **shadowp)
> > > >
> > > > It's unclear to me whether BTF_ID() requires that the target symbol=
 be
> > > > non-static.  It doesn't actually reference the symbol:
> > > >
> > > > #define BTF_ID(prefix, name) \
> > > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> > > >
> > >
> > > The above usage make me thought BTF don't require the symbol, though
> > > the symbol still exist in vmlinux with 'static'.
> > >
> > > So any comments of this, Alexei?

Sorry. I've completely missed this thread.
Now I have a hard time finding context in archives.
If I understood what's going on the removal of "static" cases issues?
Yes. That's expected.
noinline alone is not enough to work reliably.
