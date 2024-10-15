Return-Path: <bpf+bounces-41912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A483699DB31
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68824281960
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49E147C86;
	Tue, 15 Oct 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDCyPovh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C413D638;
	Tue, 15 Oct 2024 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954738; cv=none; b=EE2xPdsgCGJXfmqNeEBShopZkgEn32zuktHzjwQ/TZzjvguCmAXR4kp6Xb1hOeE4iUcleh9nesxGoDg1gHR/j13dGm5mlGNX0iwEuoKoz0NoE1RpxEiNFrJh72NMjJ+57EQQpeIEkVotuIovtKSXPobMh4CtXM1oP9aJCMHZKpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954738; c=relaxed/simple;
	bh=N7YgB/aJIcYk4TbRz/WcqcrcLnGH/WHybCO9EmWj5bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQuRNWD+K9byHtfYtP/RyI0Fajpyf6x66O1E6ddexHMYkCCJvkGoA65Zr50c6yO4lcw/qKtwu+g21pb6JSMsgZpQe6sTCGFt2gwF7s/GSQDvjDlSUQ39KjRJPtrvTmpvyVb73ffqsJoL4YjxFnGaIot9W2O7WtvvtJT0OXn8ayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDCyPovh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD34C4CEC3;
	Tue, 15 Oct 2024 01:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954737;
	bh=N7YgB/aJIcYk4TbRz/WcqcrcLnGH/WHybCO9EmWj5bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDCyPovhUtr9k/kLw128rWIb/xhU9NwSZIbmsrf4b5+lj9XjC1RErvvAt9S/fkt8x
	 XQ+nUgsphtlVbEFhfNS3lXDCqCECQDW2q7y+jbXVW3qRPpDxg+rChzYsE5uuTeAcdV
	 lytxxcN2KEmFzrVG1VQTqjviJyBqA6ISYMtyDfSmOx2tujKwt7UOgJQ79Ow05tZ1dA
	 WQ9ThWttFziqH4YO08YP7XoRERcWY+O7LZ5NMl//EVuBFQhPIzTMHk7fd3srXaYkwv
	 W3gzye/ZewbCgaPFGfyNpP/1vg2Lun3kovL5FvXXdJzQ78KzmVwhjnPh0TxdWn1Jg4
	 nyaLWgjBcFpFQ==
Date: Mon, 14 Oct 2024 15:12:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw3BcEWQQVLxcrOp@slm.duckdns.org>
References: <20241014220603.35280-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014220603.35280-1-andrea.righi@linux.dev>

Hello,

On Tue, Oct 15, 2024 at 12:06:03AM +0200, Andrea Righi wrote:
> @@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>  {
>  	update_idle_core(rq);
> -	scx_update_idle(rq, true);
>  	schedstat_inc(rq->sched_goidle);
>  	next->se.exec_start = rq_clock_task(rq);
>  }
>  
>  struct task_struct *pick_task_idle(struct rq *rq)
>  {
> +	scx_update_idle(rq, true);

Thanks a lot for debugging this. Both the analysis and solution make sense
to me. However, as this puts scx_update_idle() in a different place from
other idle handling functions, can you please add a comment explaining why
it needs to be in pick_task_idle() instead of set_next_task_idle()?

Thanks.

-- 
tejun

