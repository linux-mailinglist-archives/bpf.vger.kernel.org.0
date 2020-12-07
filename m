Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0142D1DF2
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 00:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLGXAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 18:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGXAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 18:00:00 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126BC061749;
        Mon,  7 Dec 2020 14:59:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x23so9893257lji.7;
        Mon, 07 Dec 2020 14:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKys6aQAOOu2xRthtid9ZbGkHLUjLpfvBcgRg/5bxvk=;
        b=elsF3rSNZAbI9/2G00yUr28qtowqhHbiZKFz1Ivb86RoPN3Dp4DLIdvcRNNHESwjyY
         pjcvDvL6tHu/xJ6uMTL01G9KkoFt7b/+0CiZalRi/XQ+o6dLDWim7dr4P7eve4FIxHxz
         2/LXHyYCWZcMr4JGJxELX5vtEZF9Wna51soS7M9XZ8BNcWTva09khvzq8S+2OVMy6e0e
         +kbHIKWQ8O3jASOt1kG/BD6ZA2yWHXg9YW6KVAX/V3e2NzWAI3PvHNWn7kvbgPeWksCb
         WwULrk0gcjI7s4w15BtaNO3w7uJl2jAfhT6p9aFN2rx8LQNAA8WAcEGOKO63HA2ZYYKJ
         Hi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKys6aQAOOu2xRthtid9ZbGkHLUjLpfvBcgRg/5bxvk=;
        b=jd/Gjw9PFoRMxlqzxBV+e8jiPBqkP78sIu7NpD8ym4Sa/rHbIIKZJm2cXOep/viZdx
         bAHliat5uNEMy1nwj7pFE/KHgnehMKZnABcgzadlsIVAbZRR+VsUNvSWDFXpjZMLBxLA
         81k3JFp+jqoDMAgVhoehgDh0qF4J/U8dYW9T2zU3poZ3Fo7xYCsl0CCf0GFbSClWJW50
         lAKQts15U6LJaCpIYbz1PaeNApy2HkNZ8dpKW+4OG+hljr4kD55R7xnxOLHZxwDZPvNK
         14HBv+Py5H+72ZYFUXd1eWe2HQWTOGCeZkmrCscLTWzUzeuW4KacRHLyO6XhsCuP00HO
         /CBw==
X-Gm-Message-State: AOAM530fuLfCHxPnfPyY44enu1kA1vXUCAgH7bit5MbYVha+J7lxuNwa
        2Pdy6hXSP/3VuBrXKvI2hbxcJ22pIrT3pPnCjP4=
X-Google-Smtp-Source: ABdhPJxd50n5Yn5CbKb//VSZsmqHaObc8/h0mN/v7CJKhtAeL7MydpDBbu+pR+pE7Y42p9/WHBrYFVzuR5xs2PRfWJo=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr2015643ljm.121.1607381958870;
 Mon, 07 Dec 2020 14:59:18 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com> <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com> <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
In-Reply-To: <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 14:59:07 -0800
Message-ID: <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
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

On Mon, Dec 7, 2020 at 2:53 PM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Mon, Dec 07, 2020 at 02:44:22PM -0800, Alexei Starovoitov wrote:
> > On Mon, Dec 7, 2020 at 10:36 AM Justin Forbes <jmforbes@linuxtx.org> wr=
ote:
> > >
> > > On Mon, Dec 7, 2020 at 2:16 AM Michal Kubecek <mkubecek@suse.cz> wrot=
e:
> > > >
> > > > On Thu, Nov 12, 2020 at 08:18:57AM +0800, Alex Shi wrote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2020/11/11 =E4=B8=8A=E5=8D=883:50, Andrew Morton =E5=86=
=99=E9=81=93:
> > > > > > On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux=
@gmail.com> wrote:
> > > > > >
> > > > > >> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibab=
a.com> wrote:
> > > > > >>>
> > > > > >>> Otherwise it cause gcc warning:
> > > > > >>>           ^~~~~~~~~~~~~~~
> > > > > >>> ../mm/filemap.c:830:14: warning: no previous prototype for
> > > > > >>> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-proto=
types]
> > > > > >>>  noinline int __add_to_page_cache_locked(struct page *page,
> > > > > >>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >>
> > > > > >> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> > > > > >
> > > > > > hm, yes.
> > > > >
> > > > > When the config enabled, compiling looks good untill pahole tool
> > > > > used to get BTF info, but I still failed on a right version pahol=
e
> > > > > > 1.16. Sorry.
> > > > >
> > > > > >
> > > > > >>>
> > > > > >>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > >>> Cc: linux-mm@kvack.org
> > > > > >>> Cc: linux-kernel@vger.kernel.org
> > > > > >>> ---
> > > > > >>>  mm/filemap.c | 2 +-
> > > > > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >>>
> > > > > >>> diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > >>> index d90614f501da..249cf489f5df 100644
> > > > > >>> --- a/mm/filemap.c
> > > > > >>> +++ b/mm/filemap.c
> > > > > >>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *=
old, struct page *new, gfp_t gfp_mask)
> > > > > >>>  }
> > > > > >>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> > > > > >>>
> > > > > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > > > > >>> +static noinline int __add_to_page_cache_locked(struct page *=
page,
> > > > > >>>                                         struct address_space =
*mapping,
> > > > > >>>                                         pgoff_t offset, gfp_t=
 gfp,
> > > > > >>>                                         void **shadowp)
> > > > > >
> > > > > > It's unclear to me whether BTF_ID() requires that the target sy=
mbol be
> > > > > > non-static.  It doesn't actually reference the symbol:
> > > > > >
> > > > > > #define BTF_ID(prefix, name) \
> > > > > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> > > > > >
> > > > >
> > > > > The above usage make me thought BTF don't require the symbol, tho=
ugh
> > > > > the symbol still exist in vmlinux with 'static'.
> > > > >
> > > > > So any comments of this, Alexei?
> >
> > Sorry. I've completely missed this thread.
> > Now I have a hard time finding context in archives.
> > If I understood what's going on the removal of "static" cases issues?
> > Yes. That's expected.
> > noinline alone is not enough to work reliably.
>
> Not removal, commit 3351b16af494 ("mm/filemap: add static for function
> __add_to_page_cache_locked") made the function static which breaks the
> build in btfids phase - but it seems to happen only on some
> architectures. In our case, ppc64, ppc64le and riscv64 are broken,
> x86_64, i586 and s390x succeed. (I made a mistake above, aarch64 did not
> fail - but only because it was not built at all.)
>
> The thread starts with
> http://lkml.kernel.org/r/1604661895-5495-1-git-send-email-alex.shi@linux.=
alibaba.com

Got it. So the above commit is wrong.
The addition of "static" is incorrect here.
Regardless of btf_id generation.
"static noinline" means that the error injection in that spot is unreliable=
.
Even when bpf is completely compiled out of the kernel.
