Return-Path: <bpf+bounces-67338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E5B42A52
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F052B58288A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99876369356;
	Wed,  3 Sep 2025 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLs0xCmm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82C2D375D;
	Wed,  3 Sep 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929300; cv=none; b=p8PSMYBcuiq/Pbnyu0wtRpL22jYDksbSzp4uiOHO3yrRaiWKskUnwMprp4ovq8Me4VXL4gGyodYyyttfQQECzlHS5mkkZhjnkSYB5y7VQRZSwElRfQYEhqA+xSeINFJM2GoFsHpSVIdwFpX/Cys2X6E/It4T51r8vl3JzGhhYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929300; c=relaxed/simple;
	bh=Y0aZQ9XYioBaP7HiOKYWHtnV6ggeBrFbfcoIFOWgOjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtL4L54jcMgz7MGlfexOgMbWH7Whyfye2zF4/qy8IgpEMR7LaX8cUmCnhZzNts+EZcDJnREQqd3ztJrbKEm6YmXbKNmOUU0b+3RjVl1Cr+Ka3bpt5QO7lfxKfRjj7+0KmEOaT4wzGRKD1bqFKDmIOnkishzZlXjAtb7NcbgNFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLs0xCmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F5C4CEF1;
	Wed,  3 Sep 2025 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929299;
	bh=Y0aZQ9XYioBaP7HiOKYWHtnV6ggeBrFbfcoIFOWgOjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLs0xCmms0aV725uGwmp5f4fkAePkixTSm7iXZ7y1ci/3vA/39LmbnL6JVhOCU4nR
	 FqEkdJoz09iTbFnzFAaW4MXFCGBUiczMvqQ/NBu5pj30RXM2Vmi5MmTcxskZxwAkNk
	 MabzyibSf6JudKQFdMvbXu/UVMrVy8sdjw9F5vzhnqq0HFemt9hD0W8nlnrwMvr6YE
	 tq8wVwug96bnI+WSgzmt9VyyuO5WCQqQtvuPsqDiObfgPbeMjfNf14nRoMpwFt28xz
	 F6K+uWPLvc3CY5rZ/fyeDy9Hj2063vbKjCUBYbuyKmLovy9Pb3U+WCtFgy0/s/1X89
	 CWU1Snt9hXoPQ==
Date: Wed, 3 Sep 2025 09:54:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aLidEvX41Xie5kwY@slm.duckdns.org>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-8-arighi@nvidia.com>

Hello,

On Wed, Sep 03, 2025 at 11:33:33AM +0200, Andrea Righi wrote:
> +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
> +						void *flags)
> +{
> +	struct rq_flags *rf = flags;
> +
> +	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
> +	return pick_task_scx(dl_se->rq, rf);
> +}

I'm a bit confused. This series doesn't have prep patches to add @rf to
dl_server_pick_f. Is this the right patch?

Thanks.

-- 
tejun

