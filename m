Return-Path: <bpf+bounces-7842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A077F77D3AA
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 21:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB329281635
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7318AED;
	Tue, 15 Aug 2023 19:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A31426C
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 19:52:36 +0000 (UTC)
Received: from out-40.mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A619AD
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 12:52:34 -0700 (PDT)
Date: Tue, 15 Aug 2023 12:52:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692129151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiWwkuxZLXlsMAakbQTpqYVqMa7+2V8VgSeqKNwbqnY=;
	b=vVlL8aU/i8mbZu9EunVXTFOHbz1Iac2XLnCqGKmQUETNw3eGScVfMkct1OY9dsZ35mputG
	bQrBsX3UyZtcOEbe+PMx8oGtfdUiBtDD1HH1gtqsncvHwjvFyYYk+xq83u6m8zUB5dlsLu
	r1JRj2XHpnG1tFzKDyBvHiknMzvvqe4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Michal Hocko <mhocko@suse.com>, Chuyi Zhou <zhouchuyi@bytedance.com>,
	hannes@cmpxchg.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, muchun.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.lu@bytedance.com
Subject: Re: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNvXbX2HIFcl9OqQ@P9FQF9L96D.corp.robot.car>
References: <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
 <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
 <fdec0f4c-a65f-df16-b4ee-7cfd977c8d7f@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdec0f4c-a65f-df16-b4ee-7cfd977c8d7f@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 12:00:36PM +0800, Abel Wu wrote:
> On 8/9/23 3:53 PM, Michal Hocko wrote:
> > On Tue 08-08-23 14:41:17, Roman Gushchin wrote:
> > > It would be also nice to come up with some practical examples of bpf programs.
> > > What are meaningful scenarios which can be covered with the proposed approach
> > > and are not covered now with oom_score_adj.
> > 
> > Agreed here as well. This RFC serves purpose of brainstorming on all of
> > this.
> > 
> > There is a fundamental question whether we need BPF for this task in the
> > first place. Are there any huge advantages to export the callback and
> > allow a kernel module to hook into it?
> 
> The ancient oom-killer largely depends on memory usage when choosing
> victims, which might not fit the need of modern scenarios. It's common
> nowadays that multiple workloads (tenants) with different 'priorities'
> run together, and the decisions made by the oom-killer doesn't always
> obey the service level agreements.
> 
> While the oom_score_adj only adjusts the usage-based decisions, so it
> can hardly be translated into 'priority' semantic. How can we properly
> configure it given that we don't know how much memory the workloads
> will use? It's really hard for a static strategy to deal with dynamic
> provision. IMHO the oom_score_adj is just another demon.
> 
> Reworking the oom-killer's internal algorithm or patching some random
> metrics may satisfy the immediate needs, but for the next 10 years? I
> doubt it. So I think we do need the flexibility to bypass the legacy
> usage-based algorithm, through bpf or pre-select interfaces.

I agree in general, but I wouldn't call the existing implementation a legacy
or obsolete. It's all about trade-offs. The goal of the existing implementation
is to guarantee the forward progress without killing any processes prematurely.
And it does it relatively well.

Userspace oom killers (e.g. oomd) on top of PSI were initially created to
solve the problem of memory thrashing: having a system which is barely making
anything useful, but not stuck enough for the OOM killer to kick in.
But also they were able to provide a much better flexibility. The downside -
they can't be as reliable as the in-kernel OOM killer.

Bpf or a pre-select interface can in theory glue them together: make sure that
a user has a flexibility to choose the OOM victim without compromising on the
reliability. Pre-select interface could be preferable if all the logic is
already implemented in userspace, but might be slightly less accurate if some
statistics (e.g. memory usage) is used for the determination of the victim.
Bpf approach will require re-implementing the logic, but potentially is more
powerful due to a fast access to a lot of kernel data.

Thanks!

