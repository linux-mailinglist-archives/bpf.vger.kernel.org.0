Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F492D1FD2
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLHBNq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLHBNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 20:13:45 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66440C061749;
        Mon,  7 Dec 2020 17:13:05 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 23so7794364lfg.10;
        Mon, 07 Dec 2020 17:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=st18wMWZmgiJ3TrDzx8005xHPQOLYwLmv1k6E6JRd5I=;
        b=SruCpWIBtgzCEDrLJ1rTREKNLpV9ILvhVkMaIhvHCznJyZhyYxbVuawqnzEy4/3ZVY
         JhkRHRtB3P0HZSl4yBQOcAZoNFHOyFlX2zaE/XZblnAGm04s+7If1/MkaCfAFme3uB1r
         G22aXxF2cK/u90ukI9L0+4UDwZqieOo+/aCqp6fmsmU9kolO7BsCebvuIFvJx6CPv47d
         Vy16Umsg8guwmLRciHbE9a9JOcLAazlwyVFtNyfxICHFEQjoSqDYWCH5uCnkDgYfcxx/
         0KOSAuf1VVEvkTH0p8IEkRDopb4UEHLF7z5sLDbid0sau2qp4HqFMlxhSrtI1OwoPR9X
         w0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=st18wMWZmgiJ3TrDzx8005xHPQOLYwLmv1k6E6JRd5I=;
        b=PY0ZCyefSA1DoPdok7DS0XOwd8Huwx1KEK39vNuCtcmItBwXnDTRMdvSxaL1Tvp3C5
         8jfUUvx4prLEnPWTTAZ8Q4wsP1Lh57hbEFBTAxZ34jbhtCM382hNZvJXc+lNBwJ5snF7
         QuuPAJlUAZ4TN4bDPqvsZ69iCl/rt0bLssIfLx/AGJZDlptR31fb0WwTn+4gxzi3fRcq
         pY1o5d9ssBZzGrUpL0NJc8KNihXG1MjDAkTZdDjwB0lpdVop42thxMyKV8vRlWKHHRC3
         bZU/Oa969mwcLv81dhKqt5rwdjyD8gh6zLi+S7QeA8kIobIIU7+Ebn5eBwiAcj2s/kvW
         H8/g==
X-Gm-Message-State: AOAM530+hODo7dKR3qty6MtgfLTEfraEAYJCOALVFWPp4jqxC8/ovug5
        rQZ+HlDHuwAKN2Eenb90d11NdP0lOvUKRdeIcAO3AlVw2Zo=
X-Google-Smtp-Source: ABdhPJyTUse4ur5pMadObGyX2+qcRRJzUOmjZKbsVtR2ugRQD8RuNbFAdHY3GSb6SbsOV2rkrW46eBL2rLZ/Mm9Q64s=
X-Received: by 2002:a05:6512:1102:: with SMTP id l2mr9527195lfg.500.1607389983850;
 Mon, 07 Dec 2020 17:13:03 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com> <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz> <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
In-Reply-To: <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 17:12:52 -0800
Message-ID: <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Justin Forbes <jmforbes@linuxtx.org>, bpf <bpf@vger.kernel.org>,
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

On Mon, Dec 7, 2020 at 2:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 2:53 PM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > On Mon, Dec 07, 2020 at 02:44:22PM -0800, Alexei Starovoitov wrote:
> > > On Mon, Dec 7, 2020 at 10:36 AM Justin Forbes <jmforbes@linuxtx.org> =
wrote:
> > > >
> > > > On Mon, Dec 7, 2020 at 2:16 AM Michal Kubecek <mkubecek@suse.cz> wr=
ote:
> > > > >
> > > > > On Thu, Nov 12, 2020 at 08:18:57AM +0800, Alex Shi wrote:
> > > > > >
> > > > > >
> > > > > > =E5=9C=A8 2020/11/11 =E4=B8=8A=E5=8D=883:50, Andrew Morton =E5=
=86=99=E9=81=93:
> > > > > > > On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.lin=
ux@gmail.com> wrote:
> > > > > > >
> > > > > > >> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alib=
aba.com> wrote:
> > > > > > >>>
> > > > > > >>> Otherwise it cause gcc warning:
> > > > > > >>>           ^~~~~~~~~~~~~~~
> > > > > > >>> ../mm/filemap.c:830:14: warning: no previous prototype for
> > > > > > >>> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-pro=
totypes]
> > > > > > >>>  noinline int __add_to_page_cache_locked(struct page *page,
> > > > > > >>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >>
> > > > > > >> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> > > > > > >
> > > > > > > hm, yes.
> > > > > >
> > > > > > When the config enabled, compiling looks good untill pahole too=
l
> > > > > > used to get BTF info, but I still failed on a right version pah=
ole
> > > > > > > 1.16. Sorry.
> > > > > >
> > > > > > >
> > > > > > >>>
> > > > > > >>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > > > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > > >>> Cc: linux-mm@kvack.org
> > > > > > >>> Cc: linux-kernel@vger.kernel.org
> > > > > > >>> ---
> > > > > > >>>  mm/filemap.c | 2 +-
> > > > > > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >>>
> > > > > > >>> diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > > >>> index d90614f501da..249cf489f5df 100644
> > > > > > >>> --- a/mm/filemap.c
> > > > > > >>> +++ b/mm/filemap.c
> > > > > > >>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page=
 *old, struct page *new, gfp_t gfp_mask)
> > > > > > >>>  }
> > > > > > >>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> > > > > > >>>
> > > > > > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > > > > > >>> +static noinline int __add_to_page_cache_locked(struct page=
 *page,
> > > > > > >>>                                         struct address_spac=
e *mapping,
> > > > > > >>>                                         pgoff_t offset, gfp=
_t gfp,
> > > > > > >>>                                         void **shadowp)
> > > > > > >
> > > > > > > It's unclear to me whether BTF_ID() requires that the target =
symbol be
> > > > > > > non-static.  It doesn't actually reference the symbol:
> > > > > > >
> > > > > > > #define BTF_ID(prefix, name) \
> > > > > > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> > > > > > >
> > > > > >
> > > > > > The above usage make me thought BTF don't require the symbol, t=
hough
> > > > > > the symbol still exist in vmlinux with 'static'.
> > > > > >
> > > > > > So any comments of this, Alexei?
> > >
> > > Sorry. I've completely missed this thread.
> > > Now I have a hard time finding context in archives.
> > > If I understood what's going on the removal of "static" cases issues?
> > > Yes. That's expected.
> > > noinline alone is not enough to work reliably.
> >
> > Not removal, commit 3351b16af494 ("mm/filemap: add static for function
> > __add_to_page_cache_locked") made the function static which breaks the
> > build in btfids phase - but it seems to happen only on some
> > architectures. In our case, ppc64, ppc64le and riscv64 are broken,
> > x86_64, i586 and s390x succeed. (I made a mistake above, aarch64 did no=
t
> > fail - but only because it was not built at all.)
> >
> > The thread starts with
> > http://lkml.kernel.org/r/1604661895-5495-1-git-send-email-alex.shi@linu=
x.alibaba.com
>
> Got it. So the above commit is wrong.
> The addition of "static" is incorrect here.
> Regardless of btf_id generation.
> "static noinline" means that the error injection in that spot is unreliab=
le.
> Even when bpf is completely compiled out of the kernel.

I finally realized that the addition of 'static' was pushed into Linus's tr=
ee :(
Please revert commit 3351b16af494 ("mm/filemap: add static for
function __add_to_page_cache_locked")
