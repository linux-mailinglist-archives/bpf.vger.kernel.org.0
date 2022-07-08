Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88756BB0F
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiGHNlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiGHNly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 09:41:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF03A2CCA0
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 06:41:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA42221F9E;
        Fri,  8 Jul 2022 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657287712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrGC8i4SCMF9Esn1IzCdcU+AzOqu29pzLCK+893dvLQ=;
        b=PN0Xw+gEITOJWp4eEE1LIkOtrr1oAaxu+ZJi+JGJWMGkKEzb6McuEau9VButlqBitQ8F6N
        Zg558SQTkljutj1834QDNsv6aQXCXBZ+Kf83HfUtbfzRTBNjXg3P7jG6EurccNLZhehLBr
        kTggSvmglRVAp3BqvmXJb7lTtXjH4DE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67BE72C141;
        Fri,  8 Jul 2022 13:41:51 +0000 (UTC)
Date:   Fri, 8 Jul 2022 15:41:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed 06-07-22 11:05:25, Alexei Starovoitov wrote:
> On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
[...]
> > For example, I assume that a BPF program
> > has a fairly tight limit on how much memory it can cause to be allocated.
> > Right?
> 
> No. It's constrained by memcg limits only. It can allocate gigabytes.
 
I have very briefly had a look at the core allocator parts (please note
that my understanding of BPF is really close to zero so I might be
missing a lot of implicit stuff). So by constrained by memcg you mean
__GFP_ACCOUNT done from the allocation context (irq_work). The complete
gfp mask is GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_ACCOUNT
which means this allocation is not allowed to sleep and GFP_ATOMIC
implies __GFP_HIGH to say that access to memory reserves is allowed.
Memcg charging code interprets this that the hard limit can be breached
under assumption that these are rare and will be compensated in some
way. The bulk allocator implemented here, however, doesn't reflect that
and continues allocating as it sees a success so the breach of the limit
is only bound by the number of objects to be allocated. If those can be
really large then this is a clear problem and __GFP_HIGH usage is not
really appropriate.

Also, I do not see any tracking of the overall memory sitting in these
pools and I think this would be really appropriate. As there doesn't
seem to be any reclaim mechanism implemented this can hide quite some
unreachable memory.

Finally it is not really clear to what kind of entity is the life time
of these caches bound to. Let's say the system goes OOM, is any process
responsible for it and a clean up would be done if it gets killed?

Thanks!
-- 
Michal Hocko
SUSE Labs
