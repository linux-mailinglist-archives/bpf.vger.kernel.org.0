Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9856C265
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGHWYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiGHWYo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:24:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25CA2E42;
        Fri,  8 Jul 2022 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UHEzehHRKRsWXz+8IPbg41NbpQNGDaruCrZKYM7gqVs=; b=rnxODVY0bahe1vwOxdXRU4Q4CD
        23CMxLYDMfuwShOZdcRgiTh/izRoE5wPPYJWpyuKDdpJN0TbXjYJ11HLnD/XhFLfHGLThb0BUh5i+
        RAQXmru36B2JL95aXKu9mBtH9yb7HtxzmrTe0qnUcOMFGBDYwrCwcOKHpf1DM0ga3F/W5QUxOHI5m
        CEkWpn6zEs/5IEjy2Pk7n8kjXp012hn4jnMAqFNWpeLBHxWQEtwUBnwku/31ks5kHp7QELfUsyOtK
        6CZRonwrHEsQ2VgZgOXg+9TDUWL6rqQsw8In+Wy9r64TAspHaKK4qkt3PPXExVb7am1f8ivj5IUy8
        X1lJp52A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9wOs-006C4b-8a; Fri, 08 Jul 2022 22:24:38 +0000
Date:   Fri, 8 Jul 2022 15:24:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <YsiupnNJ8WANZiIc@bombadil.infradead.org>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 08, 2022 at 07:58:44PM +0000, Song Liu wrote:
> 
> 
> > On Jul 8, 2022, at 8:58 AM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > On Fri, Jul 08, 2022 at 01:36:25AM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Jul 7, 2022, at 5:53 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>> 
> >>> On Thu, Jul 07, 2022 at 11:52:58PM +0000, Song Liu wrote:
> >>>>> On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>>>> 
> >>>>> On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
> >>>>>> This set is the second half of v4 [1].
> >>>>>> 
> >>>>>> Changes v5 => v6:
> >>>>>> 1. Rebase and extend CC list.
> >>>>> 
> >>>>> Why post a new iteration so soon without completing the discussion we
> >>>>> had? It seems like we were at least going somewhere. If it's just
> >>>>> to include mm as I requested, sure, that's fine, but this does not
> >>>>> provide context as to what we last were talking about.
> >>>> 
> >>>> Sorry for sending v6 too soon. The primary reason was to extend the CC
> >>>> list and add it back to patchwork (v5 somehow got archived). 
> >>>> 
> >>>> Also, I think vmalloc_exec_ work would be a separate project, while this 
> >>>> set is the followup work of bpf_prog_pack. Does this make sense? 
> >>>> 
> >>>> Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
> >>>> more efficient to discuss this in person. 
> >>> 
> >>> What we need is input from mm / arch folks. What is not done here is
> >>> what that stuff we're talking about is and so mm folks can't guess. My
> >>> preference is to address that.
> >>> 
> >>> I don't think in person discussion is needed if the only folks
> >>> discussing this topic so far is just you and me.
> >> 
> >> How about we start a thread with mm / arch folks for the vmalloc_exec_*
> >> topic? I will summarize previous discussions and include pointers to 
> >> these discussions. If necessary, we can continue the discussion at LPC.
> > 
> > This sounds like a nice thread to use as this is why we are talking
> > about that topic.
> > 
> >> OTOH, I guess the outcome of that discussion should not change this set? 
> > 
> > If the above is done right then actually I think it would show similar
> > considerations for a respective free for module_alloc_huge().
> > 
> >> If we have concern about module_alloc_huge(), maybe we can have bpf code 
> >> call vmalloc directly (until we have vmalloc_exec_)? 
> > 
> > You'd need to then still open code in a similar way the same things
> > which we are trying to reach consensus on.
> 
> >> What do you think about this plan?
> > 
> > I think we should strive to not be lazy and sloppy, and prevent growth
> > of sloppy code. So long as we do that I think this is all reasoanble.
> 
> Let me try to understand your concerns here. Say if we want module code
> to be a temporary home for module_alloc_huge before we move it to mm
> code. Would you think it is ready to ship if we:

Please CC Christoph and linux-modules@vger.kernel.org on future patches
and dicussions aroudn this, and all others now CC'd.

> 1) Rename module_alloc_huge as module_alloc_text_huge();

module_alloc_text_huge() is too long, but I've suggested names before
which are short and generic, and also suggested that if modules are
not the only users this needs to go outside of modules and so
vmalloc_text_huge() or whatever.

To do this right it begs the question why we don't do that for the
existing module_alloc(), as the users of this code is well outside of
modules now. Last time a similar generic name was used all the special
arch stuff was left to be done by the module code still, but still
non-modules were still using that allocator. From my perspective the
right thing to do is to deal with all the arch stuff as well in the
generic handler, and have the module code *and* the other users which
use module_alloc() to use that new caller as well.

> 2) Add module_free_text_huge();

Right, we have special handling for how we free this special code for regular
module_alloc() and so similar considerations would be needed here for
the huge stuff.

> 3) Move set_memory_* and fill_ill_insn logic into module_alloc_text_huge()
>   and module_free_text_huge(). 

Yes, that's a bit hairy now, and so a saner and consistent way to do
this would be best.

> Are these on the right direction? Did I miss anything important?

I've also hinted before that another way to help here is to have draw
up a simple lib/test_vmalloc_text.c or something like that which would
enable a selftest to ensure correctness of this code on different archs
and maybe even let you do performance analysis using perf [0]. You have
good reasons to move to the huge allocator and the performance metrics
are an abstract load, however perf measurements can also give you real
raw data which you can reproduce and enable others to do similar
comparisons later.

The last thing I'd ask is just ensure you Cc folks who have already been in
these discussions.

[0] https://lkml.kernel.org/r/Yog+d+oR5TtPp2cs@bombadil.infradead.org

  Luis
