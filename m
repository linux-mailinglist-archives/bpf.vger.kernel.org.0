Return-Path: <bpf+bounces-7188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE28772CE7
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618152812DA
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47555156CD;
	Mon,  7 Aug 2023 17:28:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505D125CF
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 17:28:27 +0000 (UTC)
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [IPv6:2001:41d0:203:375::58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D191E74
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 10:28:26 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691429302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r70aw84iIw6YnT4dCaZ1pOEXNwbndODv8HyIxsu+9bA=;
	b=HYbHViCLW4K5QsWzHKAjloITjYJ+CVCoK0kPSN16V9JN+QH/+yBwm5lrFszwi3LE4zpMdW
	rrUqS9krA0VvGehM08z2pRnbaf5aB+KJFPNjO8Eh4Bgd+AUgECpRy/5a4U0P7MM6SAU7j5
	zkAitbFOM/qdH3+ruoqo77znS5gQcHQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	muchun.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 09:04:34AM +0200, Michal Hocko wrote:
> On Mon 07-08-23 10:21:09, Chuyi Zhou wrote:
> > 
> > 
> > 在 2023/8/4 21:34, Michal Hocko 写道:
> > > On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> > > [...]
> > > > > +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> > > > > +		case -EOPNOTSUPP: break; /* No BPF policy */
> > > > > +		case -EBUSY: goto abort; /* abort search process */
> > > > > +		case 0: goto next; /* ignore process */
> > > > > +		default: goto select; /* note the task */
> > > > > +	}

To be honest, I can't say I like it. IMO it's not really using the full bpf
potential and is too attached to the current oom implementation.

First, I'm a bit concerned about implicit restrictions we apply to bpf programs
which will be executed potentially thousands times under a very heavy memory
pressure. We will need to make sure that they don't allocate (much) memory, don't
take any locks which might deadlock with other memory allocations etc.
It will potentially require hard restrictions on what these programs can and can't
do and this is something that the bpf community will have to maintain long-term.

Second, if we're introducing bpf here (which I'm not yet convinced),
IMO we should use it in a more generic and expressive way.
Instead of adding hooks into the existing oom killer implementation, we can call
a bpf program before invoking the in-kernel oom killer and let it do whatever
it takes to free some memory. E.g. we can provide it with an API to kill individual
tasks as well as all tasks in a cgroup.
This approach is more generic and will allow to solve certain problems which
can't be solved by the current oom killer, e.g. deleting files from a tmpfs
instead of killing tasks.

So I think the alternative approach is to provide some sort of an interface to
pre-select oom victims in advance. E.g. on memcg level it can look like:

echo PID >> memory.oom.victim_proc

If the list is empty, the default oom killer is invoked.
If there are tasks, the first one is killed on OOM.
A similar interface can exist to choose between sibling cgroups:

echo CGROUP_NAME >> memory.oom.victim_cgroup

This is just a rough idea.

Thanks!

