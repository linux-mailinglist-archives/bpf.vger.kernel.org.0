Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A95701D5
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiGKMPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiGKMPL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 08:15:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039314332D
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 05:15:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A6222227FB;
        Mon, 11 Jul 2022 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657541709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nh7Cjgh1nIXP+UwTbrJCXYNeOJjUHlMFOdlb+pzeUDQ=;
        b=nVPskBYi7az3KFfHEr30XgLz83iUMuVIhwEgmOAX3YOCWb2clpxAVK0X5y0G6SW48eJkXn
        mvLM/VrQJl88YyQtRO4e1xHFx9hbF7Nw6QeCXkvuV8Afl8MrW+TtNxjfxaYBiiQcKQX+EV
        dF1B9pcF/J0DfiZmszoYKdl5onydFck=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E9182C141;
        Mon, 11 Jul 2022 12:15:07 +0000 (UTC)
Date:   Mon, 11 Jul 2022 14:15:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
References: <YrlWLLDdvDlH0C6J@infradead.org>
 <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local>
 <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710073213.bkkdweiqrlnr35sv@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> [...]
> > >
> > > Most probably Michal's comment was on free objects sitting in the caches
> > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > OOM or should we ignore them as the amount of memory is not significant?
> > 
> > Are you suggesting to design a shrinker for 0.01% of the memory
> > consumed by bpf?
> 
> No, just claim that the memory sitting on such caches is insignificant.

yes, that is not really clear from the patch description. Earlier you
have said that the memory consumed might go into GBs. If that is a
memory that is actively used and not really reclaimable then bad luck.
There are other users like that in the kernel and this is not a new
problem. I think it would really help to add a counter to describe both
the overall memory claimed by the bpf allocator and actively used
portion of it. If you use our standard vmstat infrastructure then we can
easily show that information in the OOM report.
-- 
Michal Hocko
SUSE Labs
