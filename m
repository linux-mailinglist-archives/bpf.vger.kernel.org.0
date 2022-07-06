Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7882B569260
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGFTJ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiGFTJ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 15:09:26 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F702316B
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 12:09:24 -0700 (PDT)
Date:   Wed, 6 Jul 2022 12:09:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657134562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZrV9gZ3M7hyQBQVRJSRAAQW/nrB76C3hSoG3FLTFRhE=;
        b=BFx4o+Zn4HPzQFdHpfNqlMh1lYd1NMy8h3VaezauIwjA8OuK0rPGJaq4JEqFw05wcrijHP
        v/aI2kTB43TrYwvMPbf05pv+FKDJ5Jce9v5+CyGtGYT83lo1gGAjHRJ1/py93hMVbaSayb
        PS7K9X5SMbX5MJPFIlU6c5rYOyfVmYI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation
 low priority
Message-ID: <YsXd2Tah+irhth9t@castle>
References: <20220706155848.4939-1-laoar.shao@gmail.com>
 <20220706155848.4939-2-laoar.shao@gmail.com>
 <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 09:47:32AM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > easily break the memcg limit by force charge. So it is very dangerous to
> > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > too much memory.
> >
> > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > too memory expensive for some cases. That means removing __GFP_HIGH
> > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > it-avoiding issues caused by too much memory. So let's remove it.
> >
> > The force charge of GFP_ATOMIC was introduced in
> > commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> > __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> > commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> > checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> > __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> > we have to carefully verify all the callsites. Now that we can fix it in
> > BPF, we'd better not modify the memcg code.
> >
> > This fix can also apply to other run-time allocations, for example, the
> > allocation in lpm trie, local storage and devmap. So let fix it
> > consistently over the bpf code
> >
> > __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> > currently. But the memcg code can be improved to make
> > __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> 
> Could you elaborate ?
> 
> > It also fixes a typo in the comment.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Roman, do you agree with this change ?

Yes, removing __GFP_HIGH makes sense to me. I can imagine we might want
it for *some* bpf allocations, but applying it unconditionally looks wrong.

Thanks!
