Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035062D44DC
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgLIOyL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 09:54:11 -0500
Received: from mx4.wp.pl ([212.77.101.11]:56075 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbgLIOyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 09:54:09 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 09:54:09 EST
Received: (wp-smtpd smtp.wp.pl 13428 invoked from network); 9 Dec 2020 15:46:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1607525189; bh=G4gieWn3NOA1JhbTP5C00RsfdCAbf1Ni5bGd/KXjYBU=;
          h=From:To:Cc:Subject;
          b=yZ7Fs9KEiQTtlPKWuv8naJ3A1vIE3Ii3CET5v81g1ueRDyPP/CY0kvhQ+qtkXUwC/
           0wjgVdQnppcWJaaae38+Xr7Cd6qSpjSbcC7A32n/Na7+eLoVcwp692L2HqcxPgQ323
           8jiNmHuYBH4+IfyRPYZ02RgQJjNCFZaxSAC81wtw=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <alexei.starovoitov@gmail.com>; 9 Dec 2020 15:46:29 +0100
Date:   Wed, 9 Dec 2020 15:46:28 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201209144628.GA3474@wp.pl>
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
 <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
 <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
X-WP-MailID: 9e0b255261161f2ea3e8b8d7c7c110d4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oZPU]                               
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 05:12:52PM -0800, Alexei Starovoitov wrote:
> > > > > > > >>> -noinline int __add_to_page_cache_locked(struct page *page,
> > > > > > > >>> +static noinline int __add_to_page_cache_locked(struct page *page,
> > > > > > > >>>                                         struct address_space *mapping,
> > > > > > > >>>                                         pgoff_t offset, gfp_t gfp,
> > > > > > > >>>                                         void **shadowp)
> > > > > > > >
> > > > > > > > It's unclear to me whether BTF_ID() requires that the target symbol be
> > > > > > > > non-static.  It doesn't actually reference the symbol:
> > > > > > > >
> > > > > > > > #define BTF_ID(prefix, name) \
> > > > > > > >         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))

[snip]

> > > __add_to_page_cache_locked") made the function static which breaks the
> > > build in btfids phase - but it seems to happen only on some
> > > architectures. In our case, ppc64, ppc64le and riscv64 are broken,
> > > x86_64, i586 and s390x succeed. (I made a mistake above, aarch64 did not
> > > fail - but only because it was not built at all.)
> > >
> > > The thread starts with
> > > http://lkml.kernel.org/r/1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com

I have 5.10-rc7 build failure because of this on x86_64:

  BTFIDS  vmlinux
FAILED unresolved symbol __add_to_page_cache_locked
make: *** [Makefile:1170: vmlinux] Error 255

> > Got it. So the above commit is wrong.
> > The addition of "static" is incorrect here.
> > Regardless of btf_id generation.
> > "static noinline" means that the error injection in that spot is unreliable.
> > Even when bpf is completely compiled out of the kernel.
> 
> I finally realized that the addition of 'static' was pushed into Linus's tree :(
> Please revert commit 3351b16af494 ("mm/filemap: add static for
> function __add_to_page_cache_locked")

At this point of release cycle we should probably go with revert,
but I think the main problem is that BPF and ERROR_INJECTION use
function that is not intended to be used externally. For external users
add_to_page_cache_lru() and add_to_page_cache_locked() are exported
and I think those should be used (see the patch below).

Stanislaw

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1388bf733071..dd6357802504 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11487,7 +11487,8 @@ BTF_SET_START(btf_non_sleepable_error_inject)
 /* Three functions below can be called from sleepable and non-sleepable context.
  * Assume non-sleepable from bpf safety point of view.
  */
-BTF_ID(func, __add_to_page_cache_locked)
+BTF_ID(func, add_to_page_cache_locked)
+BTF_ID(func, add_to_page_cache_lru)
 BTF_ID(func, should_fail_alloc_page)
 BTF_ID(func, should_failslab)
 BTF_SET_END(btf_non_sleepable_error_inject)
diff --git a/mm/filemap.c b/mm/filemap.c
index 331f4261d723..168deec64a10 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -827,10 +827,10 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-static noinline int __add_to_page_cache_locked(struct page *page,
-					struct address_space *mapping,
-					pgoff_t offset, gfp_t gfp,
-					void **shadowp)
+static int __add_to_page_cache_locked(struct page *page,
+				      struct address_space *mapping,
+				      pgoff_t offset, gfp_t gfp,
+				      void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
@@ -907,7 +907,6 @@ static noinline int __add_to_page_cache_locked(struct page *page,
 	put_page(page);
 	return error;
 }
-ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 
 /**
  * add_to_page_cache_locked - add a locked page to the pagecache
@@ -928,6 +927,7 @@ int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 					  gfp_mask, NULL);
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
+ALLOW_ERROR_INJECTION(add_to_page_cache_locked, ERRNO);
 
 int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 				pgoff_t offset, gfp_t gfp_mask)
@@ -957,6 +957,7 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
+ALLOW_ERROR_INJECTION(add_to_page_cache_lru, ERRNO);
 
 #ifdef CONFIG_NUMA
 struct page *__page_cache_alloc(gfp_t gfp)
