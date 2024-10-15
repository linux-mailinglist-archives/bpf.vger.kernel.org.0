Return-Path: <bpf+bounces-42065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61E99F13B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320181F2294C
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90A1F667D;
	Tue, 15 Oct 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P29PkKmb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460771B3947
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006275; cv=none; b=NcPR3rDMOMyruD2ZadlSyWThGwXu2SFnFt4MTvQGniEnLbhIS1Gw+LLX9NXCeCD4DDBDlnpAkigiV3kDMsZ9MpGgrz2BksSz+1OJuMvcki9rRJCBmhLKlWWURUIgbc5TZ/uC66dGyPRoU4X3/E+V4Whyu5CUbjj/i9saDi1Ob2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006275; c=relaxed/simple;
	bh=cYDjyfICw+aco4oTCL4aC6eqZy+qk7+Izy9dgfp1BlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKVIlEqTBC9LJb6+YqGzpfmNidT/VoiA64k9mCHFK21CMju/32iGTjkSaK618VS3VwSfOYcUQwIBP6tVvqYG/75CwPkmgAbmr8ohNVP8PQwgUnrIc6NTDCBan8QsLxtGcuyaQvqRy6pyyn2FpC+YKzsOWG4lR2ibrhrn6McdEiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P29PkKmb; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 17:31:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729006269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2oVBkIbdWBPV/rhtbMw4Aicym6UbdoQlviv3nYH6oHA=;
	b=P29PkKmbGQnCvO64CI5YolcufqilNVtP4U+15+MVPVfj3PcecFr+ut5dN826uxNQbOhq8Z
	NytjM0E/H6d+QgT7CLZ/CkL7XmS70NNa8dn/cuQASwQ6klQrlspq4kmzont50f7ddvk457
	vhxjZvJRBjkj2Oiu64/iZlFV4wQqaao=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw6KuWHPn9d6GWOK@gpd3>
References: <20241015111539.12136-1-andrea.righi@linux.dev>
 <Zw5_FlXfbLXDLCPG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5_FlXfbLXDLCPG@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 04:41:26AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Tue, Oct 15, 2024 at 01:15:39PM +0200, Andrea Righi wrote:
> ...
> > For example, a BPF scheduler might use logic like the following to keep
> > the CPU active under specific conditions:
> > 
> > void BPF_STRUCT_OPS(sched_update_idle, s32 cpu, bool idle)
> > {
> > 	if (!idle)
> > 		return;
> > 	if (condition)
> > 		scx_bpf_kick_cpu(cpu, 0);
> > }
> > 
> > A call to scx_bpf_kick_cpu() wakes up the CPU, so in theory,
> > ops.update_idle() should be triggered again until the condition becomes
> > false. However, this doesn't happen, and scx_bpf_kick_cpu() doesn't
> > produce the expected effect.
> 
> I thought more about this scenario and I'm not sure anymore whether we want
> to guarantee that scx_bpf_kick_cpu() is followed by update_idle(cpu, true).
> Here are a couple considerations:
> 
> - As implemented, the transtions aren't balanced. ie. When the above
>   happens, update_idle(cpu, true) will be generated multiple times without
>   intervening update_idle(cpu, false). We can insert artificial false
>   transtions but that's cumbersome and...

Agreed, I wouldn't suggest adding artificial false events.

> 
> - For the purpose of determining whether a CPU is idle for e.g. task
>   placement from ops.select_cpu(). The CPU *should* be considered idle in
>   this polling state.
> 
> Overall, it feels a bit contrived to generate update_idle() events
> consecutively for this. If a scheduler wants to poll in idle state, can't it
> do something like the following?
> 
> - Trigger kick from update_idle(cpu, true) and remember that the CPU is in
>   the polling state.
> 
> - Keep kicking from ops.dispatch() until polling state is cleared.
> 
> As what kick() guarnatees is at least one dispatch event after kicking, this
> is guaranteed to be correct and the control flow, while a bit more
> complicated, makes sense - it triggers dispatch on idle transition and keeps
> dispatching in the idle state.
> 
> What do you think?

That seems to work in theory, I'll run some tests to confirm that it
also works in practice. :)

It looks definitely nicer than triggering multiple ops.update_idle()
from the kernel and we can maintain the proper semantic of triggering
update_idle() only on actual idle state changes.

Thanks,
-Andrea

