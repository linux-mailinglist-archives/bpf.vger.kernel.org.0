Return-Path: <bpf+bounces-71597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF91BF7DE0
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D064672CC
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957343502AF;
	Tue, 21 Oct 2025 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjISmd9r"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256534E743;
	Tue, 21 Oct 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067148; cv=none; b=ltXiFKW1iJ+Itk54v1eIGtYsVEq16c32x7w87ddfQBbEOvNT0iIJT+EgFHikzoBXaqBTLveyZDnAryAeQ3Elhv/+N/Orl3A4aL2NhKp8rr7hT6GLGdkwTIuO5AVaJWMLzzD0YKXeh6hdv7DFzdOvJwo5A8qI3l4g4BfWSQv22pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067148; c=relaxed/simple;
	bh=2YDkoOJDBp9Nbjj2vW2HkcQGmRFOiFoNvp3AjR0IkaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFlvlsh6t+7tVDMO+zy6NlRA9fIU1W93V1ospTrQyOGs+hJ7DMJTe9vTbPQoLwxgqCQpAcE1Jpm/J7CyW+OiZMEveRZiZXEsJysMuXSbNNACZpc62tX6kLLSPkCfmvMa3WC9PPE+DR8DSmBhECNM9dWMf/15P2fCGascyue0oEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjISmd9r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gHFywIhXem6Wo6k3BOTsD13pvTGelkbwQt/Im/rNtDY=; b=OjISmd9r25aLSPCGLiW3hqoolQ
	JBoz3xniO5N9k4GGhDuHiY6HF/Q5HZmpdcJLKJ/QyoLs+rq/OMEjwdAI1B/aX6IpFXdVcsXupvQx1
	OOygZtWMsE4EkPbI6ncy14zLzJ0xfd7ty7crnY8ZRjSvv3+Qecbo1RN3FaD4AxKypsv29ke2KwIOS
	qpGtgEBL5EUVgfsivtaFYZfTCWnvWaOVJL6d+hODrScePjweqcVIY/We4OInxr+AejkZZSpzP36N+
	mA8k+D6fOdLyZspaXYwPwK5r4GAS4/or+2mNAvCKqmdEH/1WOpo/gQIOvsi/l4I1f2QNsr0cSK34g
	650ac66g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0c-0000000DsWZ-1B8U;
	Tue, 21 Oct 2025 17:18:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89D023030D0; Mon, 20 Oct 2025 13:03:03 +0200 (CEST)
Date: Mon, 20 Oct 2025 13:03:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tao Chen <chen.dylane@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
Message-ID: <20251020110303.GS3419281@noisy.programming.kicks-ass.net>
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
 <20251019170118.2955346-3-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019170118.2955346-3-chen.dylane@linux.dev>

On Mon, Oct 20, 2025 at 01:01:18AM +0800, Tao Chen wrote:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
> per-cpu BPF callchain entry is used here.

And now you can only unwind 3 tasks, and then start failing. This is
acceptable, why?

> -	if (may_fault)
> -		rcu_read_lock(); /* need RCU for perf's callchain below */
> -

I know you propose to remove this code; but how was that correct? The
perf callchain code hard relies on non-preemptible context, RCU does not
imply such a thing.

>  	if (trace_in)
>  		trace = trace_in;
> -	else if (kernel && task)
>  		trace = get_callchain_entry_for_task(task, max_depth);
> -	else
> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -					   crosstask, false);



