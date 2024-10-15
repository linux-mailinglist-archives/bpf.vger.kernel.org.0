Return-Path: <bpf+bounces-42105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8799FB0B
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AA31C23B81
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8AE1DAC99;
	Tue, 15 Oct 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gc5CSKB9"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035021B0F22
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030370; cv=none; b=sxoo61/Y+G1EQdOOCxacoVLOKzAf09ZEOAW1nNCAarVjKpWRrWtGvENaePD/++u/u+pmex7yPAN5owxNXG2g3xeRsrQxtxMX/ZcAZX1Z34r4cemJuCP18P+rSnMMr5giNPZDknPWRtr2KFWAkXNLwzMM/X+x5ACWSVt4eSX/MDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030370; c=relaxed/simple;
	bh=qKsquAPd7RGZiWNsticIIwkqt1epwzwHhaYWEFEPAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/r+Fk9y5IdXp2s9cBO7JtoJdy3/tQM1y7j4KaY81iavU3F31V4sakD5c+E1/OdvOHz5q51ojgEV1YEnZX3jjqF/n9p3aW6mSM1kaySc/fR+3MWH02fYiS6jfUaWSDdUAgnQOnzoHpzAyD0KththHFwf47Mblq14z0OnzQ9znIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gc5CSKB9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 00:12:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729030364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMcOU7/QSRVq81BFSE+q603ftk9NynIpdrS2PM4Y+tE=;
	b=Gc5CSKB9NjcCXKTXpG0ru4DmqBujy50QWZYCNngMFhDv0qgJyXFUHRzAoTij1hIbz4imLZ
	1fwyjlSZlx1S8rd3mXz9FEA+2uEhCP41Ev7fwnl+l9mGxkRofx4zaJK3FftbcjSDaIhAl6
	i+iVWUNvI8AWJfqqtVU3zFw/ITn/jno=
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
Message-ID: <Zw7o0ot9Utomq9qa@gpd3>
References: <20241015111539.12136-1-andrea.righi@linux.dev>
 <Zw5_FlXfbLXDLCPG@slm.duckdns.org>
 <Zw6KuWHPn9d6GWOK@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6KuWHPn9d6GWOK@gpd3>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 05:31:09PM +0200, Andrea Righi wrote:
...
> > - For the purpose of determining whether a CPU is idle for e.g. task
> >   placement from ops.select_cpu(). The CPU *should* be considered idle in
> >   this polling state.
> > 
> > Overall, it feels a bit contrived to generate update_idle() events
> > consecutively for this. If a scheduler wants to poll in idle state, can't it
> > do something like the following?
> > 
> > - Trigger kick from update_idle(cpu, true) and remember that the CPU is in
> >   the polling state.
> > 
> > - Keep kicking from ops.dispatch() until polling state is cleared.
> > 
> > As what kick() guarnatees is at least one dispatch event after kicking, this
> > is guaranteed to be correct and the control flow, while a bit more
> > complicated, makes sense - it triggers dispatch on idle transition and keeps
> > dispatching in the idle state.
> > 
> > What do you think?
> 
> That seems to work in theory, I'll run some tests to confirm that it
> also works in practice. :)
> 
> It looks definitely nicer than triggering multiple ops.update_idle()
> from the kernel and we can maintain the proper semantic of triggering
> update_idle() only on actual idle state changes.

For the record, this seems to be working for now. Here is the
implementation of the idea proposed by Tejun:
https://github.com/sched-ext/scx/commit/40ccca8cbef8fc73e16bfb789c7565326b3cca62

Therefore, we can ignore the kernel patch.

Thanks for the help on this!
-Andrea

