Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67773502EEF
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbiDOTGQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 15:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347623AbiDOTGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 15:06:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21FDA09A;
        Fri, 15 Apr 2022 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6HzF+upEgux6jeyTUvqIhEFVqtPf6F78zI7LldDeVqo=; b=yOR8vjzmH9dv3TXNkWPHUr4Jo4
        8p/N8wsEcAProi2PY1nAuUzmrT/uoMrQ5rnVUWfl9CPvrPXITuuwgasoCCJN8tG/FYy4CqonpUxWz
        44PR5mqMuxhl1ohEfbDu3JBAErZ52ABZXbJMnpLwmaAFBEcHMffC2J2nEB8h8oCC1QTD5IbcAbM+7
        itqZRblvkWnI3Au9UcLAkRneGaZRwTAJU2Fx7X2h1tlZoa+v8qFW6mEVrMJDajAlVu6ZgGwzyYyAm
        U3D6e3oI2F+2TkHsn4B+EQZ8+57fsTCUXgZFwtbnL98YVSzWr40b5HG0m6jazStHtme6QwZvPV6k3
        /MW7zPpw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfREM-00B9WG-Bs; Fri, 15 Apr 2022 19:03:42 +0000
Date:   Fri, 15 Apr 2022 12:03:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Message-ID: <YlnBjizystrWB47D@bombadil.infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-4-song@kernel.org>
 <YliFO2sDv31j5vLb@bombadil.infradead.org>
 <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
 <YliOC455r6XmE24Q@bombadil.infradead.org>
 <CAPhsuW5=BfCoWqFgnsLu-X+8FriJCxQ80+aS_9t6fFB1eGCvRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5=BfCoWqFgnsLu-X+8FriJCxQ80+aS_9t6fFB1eGCvRQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 02:31:18PM -0700, Song Liu wrote:
> On Thu, Apr 14, 2022 at 2:11 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 02:03:17PM -0700, Song Liu wrote:
> > > Hi Luis,
> > >
> > > On Thu, Apr 14, 2022 at 1:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> > > > > Introduce module_alloc_huge, which allocates huge page backed memory in
> > > > > module memory space. The primary user of this memory is bpf_prog_pack
> > > > > (multiple BPF programs sharing a huge page).
> > > > >
> > > > > Signed-off-by: Song Liu <song@kernel.org>
> > > >
> > > > See modules-next [0], as modules.c has been chopped up as of late.
> > > > So if you want this to go throug modules this will need to rebased
> > > > on that tree. fortunately the amount of code in question does not
> > > > seem like much.
> > > >
> > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> > >
> > > We are hoping to ship this with to 5.18, as the set addresses some issue with
> > > huge page backed vmalloc. I guess we cannot ship it via modules-next branch.
> > >
> >
> > Huh, you intend this to go in as a fix for v5.18 (already released) once
> > properly reviewed?  This seems quite large... for a fix.
> >
> > > How about we ship module_alloc_huge() to 5.18 in module.c for now, and once
> > > we update modules-next branch, I will send another patch to clean it up?
> >
> > I rather set the expectations right about getting such a large fix in
> > for v5.18. I haven't even sat down to review all the changes in light of
> > this, but a cursorary glance seems to me it's rather "large" for a fix.
> 
> Yes, I agree this is a little too big for a fix. I guess we can discuss whether
> some of the set need to wait until 5.19.

Doing a more thorough review of this now, and when the other changes
landed, it seems this is *large follow up fix* for an optimization for when tons
of JIT eBPF programs are used. It's so large I can't be confident this also
doesn't go in with other holes or issues, or that the other stuff merged
already also has some other issues. So I can't see anything screaming
for why this needs to go in for v5.18 other than it'd be nice.

So my preference is for this to go through v5.19 as I see no rush.

  Luis
