Return-Path: <bpf+bounces-7271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51618774D2E
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ADE281807
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B1174C6;
	Tue,  8 Aug 2023 21:41:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570DCE569
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 21:41:25 +0000 (UTC)
Received: from out-70.mta1.migadu.com (out-70.mta1.migadu.com [IPv6:2001:41d0:203:375::46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CDF10C
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 14:41:24 -0700 (PDT)
Date: Tue, 8 Aug 2023 14:41:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691530882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeZ7s6x1uY9uLLgPEKePTpY7Hc8NdT1d3h6FH62iSdU=;
	b=Q8FfEmQrr6r1Emfrl4MzABCnQMHP5x/GtRz5z6fxBN6ZH41i5Jrd0/qiMiYHDDXV90213G
	yZ4eTOwIZwhA6LoXPoF+zhR7S0872dQBt+L3Z0AURGFl9zS52+uJK2CO22NoyyqKKvZDkp
	U8qF2DeyvCL6E8aCVGzVF0rJrjcg5y0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	muchun.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNK2fUmIfawlhuEY@P9FQF9L96D>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 10:18:39AM +0200, Michal Hocko wrote:
> On Mon 07-08-23 10:28:17, Roman Gushchin wrote:
> > On Mon, Aug 07, 2023 at 09:04:34AM +0200, Michal Hocko wrote:
> > > On Mon 07-08-23 10:21:09, Chuyi Zhou wrote:
> > > > 
> > > > 
> > > > 在 2023/8/4 21:34, Michal Hocko 写道:
> > > > > On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> > > > > [...]
> > > > > > > +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> > > > > > > +		case -EOPNOTSUPP: break; /* No BPF policy */
> > > > > > > +		case -EBUSY: goto abort; /* abort search process */
> > > > > > > +		case 0: goto next; /* ignore process */
> > > > > > > +		default: goto select; /* note the task */
> > > > > > > +	}
> > 
> > To be honest, I can't say I like it. IMO it's not really using the full bpf
> > potential and is too attached to the current oom implementation.
> 
> TBH I am not sure we are able to come up with an interface that would
> ise the full BPF potential at this stage and I strongly believe that we
> should start by something that is good enough.
> 
> > First, I'm a bit concerned about implicit restrictions we apply to bpf programs
> > which will be executed potentially thousands times under a very heavy memory
> > pressure. We will need to make sure that they don't allocate (much) memory, don't
> > take any locks which might deadlock with other memory allocations etc.
> > It will potentially require hard restrictions on what these programs can and can't
> > do and this is something that the bpf community will have to maintain long-term.
> 
> Right, BPF callbacks operating under OOM situations will be really
> constrained but this is more or less by definition. Isn't it?

What do you mean?
In general, the bpf community is trying to make it as generic as possible and
adding new and new features. Bpf programs are not as constrained as they were
when it's all started.

> 
> > Second, if we're introducing bpf here (which I'm not yet convinced),
> > IMO we should use it in a more generic and expressive way.
> > Instead of adding hooks into the existing oom killer implementation, we can call
> > a bpf program before invoking the in-kernel oom killer and let it do whatever
> > it takes to free some memory. E.g. we can provide it with an API to kill individual
> > tasks as well as all tasks in a cgroup.
> > This approach is more generic and will allow to solve certain problems which
> > can't be solved by the current oom killer, e.g. deleting files from a tmpfs
> > instead of killing tasks.
> 
> The aim of this proposal is to lift any heavy lifting steming from
> iterating tasks or cgroups which those BPF might need to make a
> decision. There are other ways of course and provide this iteration
> functionality as library functions but my BPF experience is very limited
> to say how easy is that.
> 
> > So I think the alternative approach is to provide some sort of an interface to
> > pre-select oom victims in advance. E.g. on memcg level it can look like:
> > 
> > echo PID >> memory.oom.victim_proc
> 
> this is just a terrible interface TBH. Pids are very volatile objects.
> At the time oom killer reads this pid it might be a completely different
> process.

Well, we already have cgroup.procs interface, which works ok.
Obviously if the task is dead (or is actually killed in a result of oom),
it's pid is removed from the list.

> 
> > If the list is empty, the default oom killer is invoked.
> > If there are tasks, the first one is killed on OOM.
> > A similar interface can exist to choose between sibling cgroups:
> > 
> > echo CGROUP_NAME >> memory.oom.victim_cgroup
> 
> Slightly less volatile but not much better either.
> 
> > This is just a rough idea.
> 
> I am pretty sure that both policies could be implemetd by the proposed
> BPF interface though if you want something like that.

As I said, I'm pretty concerned about how reliable (and effective) it will be.
I'm not convinced that executing a generic bpf program from the oom context
is safe (and we're talking about executing it potentially thousands of times).
If we're going this way, we need an explicit acknowledge from the bpf
community and a long-term agreement on how we'll keep thing safe.

It would be also nice to come up with some practical examples of bpf programs.
What are meaningful scenarios which can be covered with the proposed approach
and are not covered now with oom_score_adj.

Thanks!

