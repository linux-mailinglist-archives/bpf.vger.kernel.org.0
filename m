Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C982F631362
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTKlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 05:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKTKlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 05:41:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D678B20
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 02:41:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2819960C2D
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF88C433D6;
        Sun, 20 Nov 2022 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668940906;
        bh=MnnoYiWv3uPbIkrSnl3lVxNe3LuFVSR7+M/2fGlq7uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A65cuATyANOC5dHBDLeCZTNk5X3MwaF55DaP2/7LGXo11XAc/6p77rYCj6xqytQtJ
         xMbmKCbW9OP+SKzgolUx0lbPjIQ1r0CwVdsYWZb6Rp7PQxAwxjX5rhvV4n9yCLvLW5
         Ij6Ut+KU9w9UeSerFskmY3fruQxirvNg29MueN7VXomgkhfeVWPU1/ixh1XDra0ymD
         DAmE3AIou8+eFEtQjJP6/lR0i+sE6124NU1sHQ3LfHF6LwE4AsBTV6dOqUh074HzkX
         fE9sHixZO/nMD9RPP1Jq3BZ7VSIKe7VCs/nNw0B9Ossz4aHiVKbPjhr1vuyxfX3oKR
         L2aegSx0mT7ow==
Date:   Sun, 20 Nov 2022 12:41:32 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y3oEXP3UqHd1L6Z9@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
 <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
 <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
 <Y3X1uHNTLQJxmJnm@kernel.org>
 <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 17, 2022 at 10:36:43AM -0800, Song Liu wrote:
> On Thu, Nov 17, 2022 at 12:50 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Nov 14, 2022 at 12:30:49PM -0800, Song Liu wrote:
> > > On Sun, Nov 13, 2022 at 2:35 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > My concern is that the proposed execmem_alloc() cannot be used for
> > > > centralized handling of loading text. I'm not familiar enough with
> > > > modules/ftrace/kprobes/BPF to clearly identify the potential caveats, but
> > > > my gut feeling is that the proposed execmem_alloc() won't be an improvement
> > > > but rather a hindrance for moving to centralized handling of loading text.
> > >
> > > I don't follow why this could ever be a hindrance. Luis is very excited about
> > > this, and I am very sure it works for ftrace, kprobe, and BPF.
> >
> > Again, it's a gut feeling. But for execmem_alloc() to be a unified place of
> > code allocation, it has to work for all architectures. If architectures
> > have to override it, then where is the unification?
> >
> > The implementation you propose if great for x86, but to see it as unified
> > solution it should be good at least for the major architectures.
> 
> As I mentioned earlier, folks are working on using bpf_prog_pack for BPF
> JIT on powerpc. We will also work on something similar for ARM.

Does "something similar" mean that it won't use execmem_alloc() as is?

> I guess these are good enough for major architectures?

Sorry if I wasn't clear, I referred for unified solution for all code
allocations, not only BPF, so that execmem_alloc() will eventually replace
module_alloc(). And that means it has to be able to deal with with
architecture specific requirements at least on ARM and powerpc, probably
others as well.

> > > > It feels to me that a lot of ground work is needed to get to the point
> > > > where we can use centralized handling of loading text.
> > >
> > > Could you please be more specific on what is needed?
> >
> > The most obvious one to implement Peter's suggestion with VM_TOPDOWN_VMAP
> > so that execmem_alloc() can be actually used by modules.
> 
> Current implementation is an alternative to VM_TOPDOWN_VMAP. I am
> very sure it works for modules just like VM_TOPDOWN_VMAP solution.

It might, but it still does not. And until they do I consider these
patches as an optimization for BFP rather than unification of code
allocations.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
