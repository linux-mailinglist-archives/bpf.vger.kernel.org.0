Return-Path: <bpf+bounces-6260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965517675D4
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA19F2812C6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF16156EC;
	Fri, 28 Jul 2023 18:49:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7C1426E
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:49:41 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 11:49:40 PDT
Received: from out-97.mta1.migadu.com (out-97.mta1.migadu.com [IPv6:2001:41d0:203:375::61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC311D
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 11:49:40 -0700 (PDT)
Date: Fri, 28 Jul 2023 11:42:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690569752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEBfReHkumv+ijKaHru3+PQiXRd/5c56MSyCUuc5ebs=;
	b=jtrGMOIySUXUV2fpE2d6Fh3hrGt+uTlJOJCevCNvunPhAh9g5AsiryeyyYVgR3fcvLlw/r
	SAfoHjvjwcxgaF7vO4axYLjV1xaOtZSf3BravKtArxuKuhC7Yrv4NGtoLxL/41fuj4WBvS
	phpIDtZkG2DU2l3uJf6Q0TsyO+xmCio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, robin.lu@bytedance.com
Subject: Re: [RFC PATCH 0/5] mm: Select victim memcg using BPF_OOM_POLICY
Message-ID: <ZMQME4f9Okp8Rl7N@P9FQF9L96D>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <ZMInlGaW90Uw1hSo@dhcp22.suse.cz>
 <ZMNESaE/tWgRd4FI@P9FQF9L96D>
 <ZMN3Do86cxsXyD84@dhcp22.suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMN3Do86cxsXyD84@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 10:06:38AM +0200, Michal Hocko wrote:
> On Thu 27-07-23 21:30:01, Roman Gushchin wrote:
> > On Thu, Jul 27, 2023 at 10:15:16AM +0200, Michal Hocko wrote:
> > > On Thu 27-07-23 15:36:27, Chuyi Zhou wrote:
> > > > This patchset tries to add a new bpf prog type and use it to select
> > > > a victim memcg when global OOM is invoked. The mainly motivation is
> > > > the need to customizable OOM victim selection functionality so that
> > > > we can protect more important app from OOM killer.
> > > 
> > > This is rather modest to give an idea how the whole thing is supposed to
> > > work. I have looked through patches very quickly but there is no overall
> > > design described anywhere either.
> > > 
> > > Please could you give us a high level design description and reasoning
> > > why certain decisions have been made? e.g. why is this limited to the
> > > global oom sitation, why is the BPF program forced to operate on memcgs
> > > as entities etc...
> > > Also it would be very helpful to call out limitations of the BPF
> > > program, if there are any.
> > 
> > One thing I realized recently: we don't have to make a victim selection
> > during the OOM, we [almost always] can do it in advance.
> > 
> > Kernel OOM's must guarantee the forward progress under heavy memory pressure
> > and it creates a lot of limitations on what can and what can't be done in
> > these circumstances.
> > 
> > But in practice most policies except maybe those which aim to catch very fast
> > memory spikes rely on things which are fairly static: a logical importance of
> > several workloads in comparison to some other workloads, "age", memory footprint
> > etc.
> > 
> > So I wonder if the right path is to create a kernel interface which allows
> > to define a OOM victim (maybe several victims, also depending on if it's
> > a global or a memcg oom) and update it periodically from an userspace.
> 
> We already have that interface. Just echo OOM_SCORE_ADJ_MAX to any tasks
> that are to be killed with a priority...
> Not a great interface but still something available.
> 
> > In fact, the second part is already implemented by tools like oomd, systemd-oomd etc.
> > Someone might say that the first part is also implemented by the oom_score
> > interface, but I don't think it's an example of a convenient interface.
> > It's also not a memcg-level interface.
> 
> What do you mean by not memcg-level interface? What kind of interface
> would you propose instead?

Something like memory.oom.priority, which is 0 by default, but if set to 1,
the memory cgroup is considered a good oom victim. Idk if we need priorities
or just fine with a binary thing.

Under oom conditions the kernel can look if we have a pre-selected oom target
and if not fallback to the current behavior.

Thanks!

