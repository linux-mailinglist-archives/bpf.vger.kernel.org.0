Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50818569578
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiGFWyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 18:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiGFWyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 18:54:15 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4764C2A94A
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 15:54:14 -0700 (PDT)
Date:   Wed, 6 Jul 2022 15:54:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657148051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lz2FbgkzXpsYglBWracLt+nXVup0eMNxn/M0c2hWXBo=;
        b=aEVXNbJOOFMBLc3x5punvY+VCqkzi+opHiitMRm6g4iBfNxaTdjuNUudt+q4NGH9uipUU+
        nGJmNdf467i9mwGGK+vL1CdgMDbC/mVLYVsbph7sHtvKHeO0Vgr0OrGYupod2dtxxMfphA
        DUoV1J8NR4Qv+seprN+YcvMAQtMNGMg=
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
Message-ID: <YsYSjAUGUkERUZ4q@castle>
References: <20220706155848.4939-1-laoar.shao@gmail.com>
 <20220706155848.4939-2-laoar.shao@gmail.com>
 <CAADnVQJEK+Puyz8b4eUV3H7Z+OtrvHd4MU42OsPiBodMQxEw-g@mail.gmail.com>
 <YsXd2Tah+irhth9t@castle>
 <CAADnVQ+c_2Q6GxH3E0iD0RkOy2H2-UhuYL4V3v2BTQ6sZNxQAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+c_2Q6GxH3E0iD0RkOy2H2-UhuYL4V3v2BTQ6sZNxQAA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 03:11:46PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 6, 2022 at 12:09 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Wed, Jul 06, 2022 at 09:47:32AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > > easily break the memcg limit by force charge. So it is very dangerous to
> > > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > > too much memory.
> > > >
> > > > We introduced BPF_F_NO_PREALLOC is because full map pre-allocation is
> > > > too memory expensive for some cases. That means removing __GFP_HIGH
> > > > doesn't break the rule of BPF_F_NO_PREALLOC, but has the same goal with
> > > > it-avoiding issues caused by too much memory. So let's remove it.
> > > >
> > > > The force charge of GFP_ATOMIC was introduced in
> > > > commit 869712fd3de5 ("mm: memcontrol: fix network errors from failing
> > > > __GFP_ATOMIC charges") by checking __GFP_ATOMIC, then got improved in
> > > > commit 1461e8c2b6af ("memcg: unify force charging conditions") by
> > > > checking __GFP_HIGH (that is no problem because both __GFP_HIGH and
> > > > __GFP_ATOMIC are set in GFP_AOMIC). So, if we want to fix it in memcg,
> > > > we have to carefully verify all the callsites. Now that we can fix it in
> > > > BPF, we'd better not modify the memcg code.
> > > >
> > > > This fix can also apply to other run-time allocations, for example, the
> > > > allocation in lpm trie, local storage and devmap. So let fix it
> > > > consistently over the bpf code
> > > >
> > > > __GFP_KSWAPD_RECLAIM doesn't cooperate well with memcg pressure neither
> > > > currently. But the memcg code can be improved to make
> > > > __GFP_KSWAPD_RECLAIM work well under memcg pressure if desired.
> > >
> > > Could you elaborate ?
> > >
> > > > It also fixes a typo in the comment.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > >
> > > Roman, do you agree with this change ?
> >
> > Yes, removing __GFP_HIGH makes sense to me. I can imagine we might want
> > it for *some* bpf allocations, but applying it unconditionally looks wrong.
> 
> Yeah. It's a difficult trade-off to make without having the data
> to decide whether removing __GFP_HIGH can cause issues or not,

Yeah, the change looks reasonable, but it's hard to say without giving
it a good testing in (something close to) a production environment.

> but do you agree that __GFP_HIGH doesn't cooperate well with memcg ?
> If so it's a bug on memcg side, right?

No. Historically we allowed high-prio allocations to exceed the memcg limit
because otherwise there were too many stability and performance issues.
It's not a memcg bug, it's a way to avoid exposing ENOMEM handling bugs all over
the kernel code. Without memory cgroups GFP_ATOMIC allocations rarely fail
and a lot of code paths in the kernel are not really ready for it (at least
it was the case several years ago, maybe things are better now).

But it was usually thought in the context of small(ish) allocations which do not
change the global memory usage picture. Subsequent "normal" allocations are
triggering reclaim/OOM, so from a user's POV the limit works as expected.

But with the ownership model and size of bpf maps it's a different story:
if a bpf map belongs to an abandoned cgroup, it might consume a lot of memory
and there will be no "normal" allocations. So cgroup memory limit will be never
applied. It's a valid issue, I agree with Yafang here.

> but we should probably
> apply this band-aid on bpf side to fix the bleeding.
> Later we can add a knob to allow __GFP_HIGH usage on demand from
> bpf prog.

Yes, it sounds like a good idea. I have to think what's the best approach
here, it's not obvious for me.

Thanks!
