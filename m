Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A742D50E3
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 03:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgLJCcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 21:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbgLJCcL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 21:32:11 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC5E23C43;
        Thu, 10 Dec 2020 02:31:28 +0000 (UTC)
Date:   Wed, 9 Dec 2020 21:31:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20201209213126.79ca1326@oasis.local.home>
In-Reply-To: <CAADnVQKiBWG9NVNEV9EqGkyd-n3Yj88cNJpH997js-63eTVAOQ@mail.gmail.com>
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
        <20201209223206.GA1935@home.goodmis.org>
        <CAADnVQKiBWG9NVNEV9EqGkyd-n3Yj88cNJpH997js-63eTVAOQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Dec 2020 17:12:43 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > > > > FWIW, I intend to do some consolidation/renaming in this area.  I
> > > > > trust that will not be a problem?  
> > > >
> > > > If it does not break anything, it will be not a problem ;-)
> > > >
> > > > It's possible that __add_to_page_cache_locked() can be a global symbol
> > > > with add_to_page_cache_lru() + add_to_page_cache_locked() being just
> > > > static/inline wrappers around it.  
> > >
> > > So what happens to BTF if we change this area entirely?  Your IDs
> > > sound like some kind of ABI to me, which is extremely scary.  
> >
> > Is BTF becoming the new tracepoint? That is, random additions of things like:
> >
> >    BTF_ID(func,__add_to_page_cache_locked)
> >
> > Like was done in commit 1e6c62a882155 ("bpf: Introduce sleepable BPF
> > programs") without any notification to the maintainers of the
> > __add_to_page_cache_locked code, will suddenly become an API?  
> 
> huh? what api/abi you're talking about?

If the function __add_to_page_cache_locked were to be removed due to
the code being rewritten,  would it break any user space? If not, then
there's nothing to worry about. ;-)

-- Steve
