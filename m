Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A402D4DE2
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 23:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbgLIWdO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 17:33:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388604AbgLIWc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 17:32:57 -0500
Date:   Wed, 9 Dec 2020 17:32:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
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
Message-ID: <20201209223206.GA1935@home.goodmis.org>
References: <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
 <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl>
 <20201209150826.GP7338@casper.infradead.org>
 <20201209155148.GA5552@wp.pl>
 <20201209180552.GA28692@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209180552.GA28692@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 09, 2020 at 06:05:52PM +0000, Christoph Hellwig wrote:
> On Wed, Dec 09, 2020 at 04:51:48PM +0100, Stanislaw Gruszka wrote:
> > On Wed, Dec 09, 2020 at 03:08:26PM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 09, 2020 at 03:46:28PM +0100, Stanislaw Gruszka wrote:
> > > > At this point of release cycle we should probably go with revert,
> > > > but I think the main problem is that BPF and ERROR_INJECTION use
> > > > function that is not intended to be used externally. For external users
> > > > add_to_page_cache_lru() and add_to_page_cache_locked() are exported
> > > > and I think those should be used (see the patch below).
> > > 
> > > FWIW, I intend to do some consolidation/renaming in this area.  I
> > > trust that will not be a problem?
> > 
> > If it does not break anything, it will be not a problem ;-)
> > 
> > It's possible that __add_to_page_cache_locked() can be a global symbol
> > with add_to_page_cache_lru() + add_to_page_cache_locked() being just
> > static/inline wrappers around it.
> 
> So what happens to BTF if we change this area entirely?  Your IDs
> sound like some kind of ABI to me, which is extremely scary.

Is BTF becoming the new tracepoint? That is, random additions of things like:

   BTF_ID(func,__add_to_page_cache_locked)

Like was done in commit 1e6c62a882155 ("bpf: Introduce sleepable BPF
programs") without any notification to the maintainers of the
__add_to_page_cache_locked code, will suddenly become an API?

There's no mention in the change log to why __add_to_page_cache_locked was
added. And interesting enough, __add_to_page_cache_locked is not in any header
file, which is why it was switched to static.

-- Steve


