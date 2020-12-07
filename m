Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521922D1DCA
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLGWye (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 17:54:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgLGWye (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 17:54:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01174AB63;
        Mon,  7 Dec 2020 22:53:52 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 82A27603C1; Mon,  7 Dec 2020 23:53:51 +0100 (CET)
Date:   Mon, 7 Dec 2020 23:53:51 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Justin Forbes <jmforbes@linuxtx.org>, bpf <bpf@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
 <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 02:44:22PM -0800, Alexei Starovoitov wrote:
> On Mon, Dec 7, 2020 at 10:36 AM Justin Forbes <jmforbes@linuxtx.org> wrote:
> >
> > On Mon, Dec 7, 2020 at 2:16 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> > >
> > > On Thu, Nov 12, 2020 at 08:18:57AM +0800, Alex Shi wrote:
> > > >
> > > >
> > > > 在 2020/11/11 上午3:50, Andrew Morton 写道:
> > > > > On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > > >
> > > > >> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> > > > >>>
> > > > >>> Otherwise it cause gcc warning:
> > > > >>>           ^~~~~~~~~~~~~~~
> > > > >>> ../mm/filemap.c:830:14: warning: no previous prototype for
> > > > >>> ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
> > > > >>>  noinline int __add_to_page_cache_locked(struct page *page,
> > > > >>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >>
> > > > >> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> > > > >
> > > > > hm, yes.
> > > >
> > > > When the config enabled, compiling looks good untill pahole tool
> > > > used to get BTF info, but I still failed on a right version pahole
> > > > > 1.16. Sorry.
> > > >
> > > > >
> > > > >>>
> > > > >>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >>> Cc: linux-mm@kvack.org
> > > > >>> Cc: linux-kernel@vger.kernel.org
> > > > >>> ---
> > > > >>>  mm/filemap.c | 2 +-
> > > > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >>>
> > > > >>> diff --git a/mm/filemap.c b/mm/filemap.c
> > > > >>> index d90614f501da..249cf489f5df 100644
> > > > >>> --- a/mm/filemap.c
> > > > >>> +++ b/mm/filemap.c
> > > > >>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
> > > > >>>  }
> > > > >>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> > > > >>>
> > > > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > > > >>> +static noinline int __add_to_page_cache_locked(struct page *page,
> > > > >>>                                         struct address_space *mapping,
> > > > >>>                                         pgoff_t offset, gfp_t gfp,
> > > > >>>                                         void **shadowp)
> > > > >
> > > > > It's unclear to me whether BTF_ID() requires that the target symbol be
> > > > > non-static.  It doesn't actually reference the symbol:
> > > > >
> > > > > #define BTF_ID(prefix, name) \
> > > > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> > > > >
> > > >
> > > > The above usage make me thought BTF don't require the symbol, though
> > > > the symbol still exist in vmlinux with 'static'.
> > > >
> > > > So any comments of this, Alexei?
> 
> Sorry. I've completely missed this thread.
> Now I have a hard time finding context in archives.
> If I understood what's going on the removal of "static" cases issues?
> Yes. That's expected.
> noinline alone is not enough to work reliably.

Not removal, commit 3351b16af494 ("mm/filemap: add static for function
__add_to_page_cache_locked") made the function static which breaks the
build in btfids phase - but it seems to happen only on some
architectures. In our case, ppc64, ppc64le and riscv64 are broken,
x86_64, i586 and s390x succeed. (I made a mistake above, aarch64 did not
fail - but only because it was not built at all.)

The thread starts with
http://lkml.kernel.org/r/1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com

Michal

