Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20742A1BD
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhJLKSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 06:18:18 -0400
Received: from foss.arm.com ([217.140.110.172]:32968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbhJLKSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 06:18:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943AF101E;
        Tue, 12 Oct 2021 03:16:16 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE12E3F694;
        Tue, 12 Oct 2021 03:16:15 -0700 (PDT)
Date:   Tue, 12 Oct 2021 11:16:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <20211012101613.bv3szjjl2ak2glqk@e107158-lin.cambridge.arm.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
 <20211006163949.zwze5du6szdabxos@e107158-lin.cambridge.arm.com>
 <YV3v3RkxOB6g/O+8@carbon.lan>
 <20211011163852.s4pq45rs2j3qhdwl@e107158-lin.cambridge.arm.com>
 <YWR9339EvxX6Ld1U@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWR9339EvxX6Ld1U@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/11/21 11:09, Roman Gushchin wrote:
> > Convenient will be only true assuming you have a full comprehensive list of
> > hooks to never require adding a new one. As I highlighted above, this
> > convenience is limited to hooks that you added now.
> > 
> > Do people always want more hooks? Rhetorical question ;-)
> 
> Why do you think that the list of the hooks will be so large/dynamic?

It's not a fact. Just my thoughts/guess based on how things usually end up.
It's very likely this will grow. I could be wrong of course :)

> I'm not saying we can figure it out from a first attempt, but I'm pretty sure
> that after some initial phase it can be relatively stable, e.g. changing only
> with some _major_ changes in the scheduler code.

My point was that the speed up in workflow will be limited by the what's
available. It might be enough for a large use cases as you say, but at some
point there will be a new bottleneck that you might think worth experimenting
with and the chances a suitable hook is available are 50:50 in theory. So it's
not a magical fix where one would *never* have to push a custom kernel on all
these systems to experiment with some scheduler changes.

> > > > So my worry is that this will open the gate for these hooks to get more than
> > > > just micro-optimization done in a platform specific way. And that it will
> > > > discourage having the right discussion to fix real problems in the scheduler
> > > > because the easy path is to do whatever you want in userspace. I am not sure we
> > > > can control how these hooks are used.
> > > 
> > > I totally understand your worry. I think we need to find a right balance between
> > > allowing to implement custom policies and keeping the core functionality
> > > working well enough for everybody without a need to tweak anything.
> > > 
> > > It seems like an alternative to this "let's allow cfs customization via bpf"
> > > approach is to completely move the scheduler code into userspace/bpf, something
> > > that Google's ghOSt is aiming to do.
> > 
> > Why not ship a custom kernel instead then?
> 
> Shipping a custom kernel (actually any kernel) at this scale isn't easy or fast.
> Just for example, imagine a process of rebooting of a 1000000 machines running
> 1000's different workloads, each with their own redundancy and capacity requirements.
> 
> This what makes an ability to push scheduler changes without a reboot/kernel upgrade
> so attractive.
> 
> Obviously, it's not a case when we talk about a single kernel engineer and their
> laptop/dev server/vm.

I think you're still referring to ghOSt here. I thought your 2 use cases are
different as you mentioned they "completely move the scheduler code into
userspace/bpf"; but it could be just me mis-interpreting what this means. That
didn't read to me they want to micro-optimize (few) certain decisions in the
scheduler, rather replace it altogether, hence my question.

Anyway. My 2cents here is that we should be careful not to introduce something
that encourages out-of-tree workarounds for real scheduler problems nor have it
done in a way where we lose visibility over how these hooks are used and being
able to share it with others who could benefit from the same mico-optimization
too.

Thanks!

--
Qais Yousef
