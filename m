Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA639572B36
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 04:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiGMCMt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 22:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGMCMt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 22:12:49 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E25CEB96
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 19:12:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:12:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657678366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4NZMHvEd+Wz6R+icJlQASumnTXEnRzXAIOG4yiXNsk=;
        b=eQXlx0GekEOodGnpP3rbICE7PWmnbaEn5Bt9naVGNBeckp8ips0W95/6bZToNA0f9wIHB3
        hwp4wkv7UibOfK+dGn7uQIwulbvVZs02/CptqrZFNSnXJjSWrgXVkkgPr9UsZ1wWqv1WnL
        BBHJvOdUcLucayTRa6xdG1LJ9fUP4MY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Make non-preallocated allocation
 low priority
Message-ID: <Ys4qFt5IsHt1pdfZ@castle>
References: <20220709154457.57379-1-laoar.shao@gmail.com>
 <20220709154457.57379-2-laoar.shao@gmail.com>
 <CALvZod5GfxSpQBZ2Kcbv9afHhjWy+8oEgaNUrSPM7VTdWY464w@mail.gmail.com>
 <CAADnVQJvxoteUZdnsoyMQ53Qx1bvyBz=ybQGrsWL9-4R=aasUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJvxoteUZdnsoyMQ53Qx1bvyBz=ybQGrsWL9-4R=aasUw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 05:49:24PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 11, 2022 at 12:19 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sat, Jul 9, 2022 at 8:45 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > easily break the memcg limit by force charge. So it is very dangerous to
> > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > too much memory. There's a plan to completely remove __GFP_ATOMIC in the
> > > mm side[1], so let's use GFP_NOWAIT instead.
> > >
> > > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > > too memory expensive for some cases. That means removing __GFP_HIGH
> > > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > > it-avoiding issues caused by too much memory. So let's remove it.
> > >
> > > This fix can also apply to other run-time allocations, for example, the
> > > allocation in lpm trie, local storage and devmap. So let fix it
> > > consistently over the bpf code
> > >
> > > It also fixes a typo in the comment.
> > >
> > > [1]. https://lore.kernel.org/linux-mm/163712397076.13692.4727608274002939094@noble.neil.brown.name/
> > >
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> Applied to bpf-next.

Looks like I'm a bit late to the party, but my ack still applies.

Thanks!
