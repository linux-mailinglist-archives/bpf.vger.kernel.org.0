Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9350BA77
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448843AbiDVOpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448834AbiDVOp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 10:45:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E15BE6E;
        Fri, 22 Apr 2022 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JfaFBap5XOtEB+YkkJ9E9pvw6jjkwyxBWuZ63OV8jOo=; b=2iW4xAij7Xo+8jKTLoxPTikuIu
        Fi62Db6A46bHFst2qLDayoFWOb6RX6ajDK/tjDgbw4Pp5AR+9Y7Nc+WmtKOA5T3+cA6Hd1Ba/7NMl
        /H7JeZ4vNiMnbDct96DTc0XhWrFzeGMii1/9riBIc9DQAeXnDvco+HHPcdDJSXDvg/XPKZtB/77na
        zmba1NEbnS/W29AXrGd4wjDpw0S6Hh31RRpAHGtnkzgO4KYM3/9N1iN6BLGyxf86UL3iTp9S9EfJ2
        GynSoMhj1cmlB3tfGWVWw9qnFEUdF2Z0z7EwCyuhCfiJia20VFlM4CvE0TVx8EZ7CI0Rqw+PLuWMl
        BrrXqijA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhuUS-000s6V-32; Fri, 22 Apr 2022 14:42:32 +0000
Date:   Fri, 22 Apr 2022 07:42:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH bpf 0/4] bpf_prog_pack and vmalloc-on-huge-page fixes
Message-ID: <YmK+2AyIuqaySkHQ@bombadil.infradead.org>
References: <20220422051813.1989257-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422051813.1989257-1-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 10:18:09PM -0700, Song Liu wrote:
> NOTE: This set is based on Linus' master branch (d569e86915b7), not
> bpf/master.
> 
> There are various discussion about these changes, check out [1] [2].
> I guess we can use this thread to discuss which patches should go in 5.18.
> AFAICT, 1/4 need to with 5.18;

Since huge pages are effectively disabled on v5.18 I can't see why.

> 2/4 seems safe to go as well;

My impression on the discussion was that huge pages design was broken
and evidence for this came up after x86 finally enabled *a small*
portion use case of it. This revealed how broken huge pages were not
just for x86 but for other architectures. And so I can't see why we'd
enable for v5.18 huge pages for the large system hash.

> 3/4 and 4/4
> may still need more work/discussion.

Happy to review these but if huge pages are disabled I don't see the
point in a module_alloc_huge() yet.

  Luis

> 
> Thanks!
> 
> [1] https://lore.kernel.org/linux-mm/20220415164413.2727220-1-song@kernel.org/
> [2] https://lore.kernel.org/linux-mm/20220421072212.608884-1-song@kernel.org/
> 
> Song Liu (4):
>   bpf: invalidate unused part of bpf_prog_pack
>   page_alloc: use vmalloc_huge for large system hash
>   module: introduce module_alloc_huge
>   bpf: use module_alloc_huge for bpf_prog_pack
> 
>  arch/x86/kernel/module.c     | 21 +++++++++++++++++++++
>  arch/x86/net/bpf_jit_comp.c  | 22 ++++++++++++++++++++++
>  include/linux/bpf.h          |  2 ++
>  include/linux/moduleloader.h |  5 +++++
>  kernel/bpf/core.c            | 28 +++++++++++++++++++++-------
>  kernel/module.c              |  8 ++++++++
>  mm/page_alloc.c              |  2 +-
>  7 files changed, 80 insertions(+), 8 deletions(-)
> 
> --
> 2.30.2
