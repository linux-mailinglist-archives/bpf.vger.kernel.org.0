Return-Path: <bpf+bounces-71221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44741BEA3C2
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50E71AA75DA
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93377330B37;
	Fri, 17 Oct 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLJ1mePu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFD330B0D;
	Fri, 17 Oct 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716067; cv=none; b=tOyOi3KP5vLII5Y0sJHNE1OyYoQMxNeiXld9X1wmRzyZXD7t5u2f4gcg8tKk8N95MtVC5mqibDWSiFu+I3Wkg+U8V3nD4ml+dMWSzCzyLichMsfVlgjMOa+07b985Fd4oHxDLH9yh3N+vOLpVw34Jzc6zxmMdVmdn1c9lTWR6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716067; c=relaxed/simple;
	bh=N51bFOBz2p94LI5bf0TX+8dwgIVjXdPkruSvk68Tg8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFTEeX181F/y8MTr/XzLf4HAlfnjuj1bxkMoR43uvGa8hM++V0p3XCi+g8uWbeuxkfU1LmJwm7LlJLDNnrVOemxIQaFrC9NvxsuOrXEtNoVXl2+vbJ7zodKWU9lUZ7aPWIIeFhoQyj9FzeCTCcjdCy7jnWZke6XsJDrrgxBXlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLJ1mePu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9711C4CEE7;
	Fri, 17 Oct 2025 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760716066;
	bh=N51bFOBz2p94LI5bf0TX+8dwgIVjXdPkruSvk68Tg8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLJ1mePuIxg8o/YQ44d/UGeVPakM8wNLEZ7rR2GrZeMZM4+ndx+liuRGczTqO2bX1
	 zEPkyWLPDiKoeipAeAeecdTY2UWQLRlyXLRliSBawol6OCaxOxUpEAIuHra5JcIHxC
	 Ntdgo5YlRDD/m0ZERR5/cFKxM+MNTJdQtWPvDFiGtl8KrdqgeFZKtJoRwmtvs7kfmF
	 RHlJpU+58c5XaZYXRC2iVxuykuNX7Fya9dKh1a9f8ExdJdj6jEc2qyu0zgsSONbAqJ
	 4DCHDmK2OmECKvG0/h10jcwFZKUYr3TsOHjjNwY9sEjZa5XvFE4Q9PKg8PcmocVc/J
	 O3p6l0GZrMVKw==
Date: Fri, 17 Oct 2025 05:47:45 -1000
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
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPJlIUF-KkdOdDvM@slm.duckdns.org>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-7-arighi@nvidia.com>

On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> +static struct task_struct *
> +ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> +{
> +	return pick_task_scx(dl_se->rq, rf);
> +}

I wonder whether we should tell pick_task_scx() to suppress the
rq_modified_above() test in this case as a fair or RT task being enqueued
has no reason to restart the picking process. While it will behave fine on
retry, it's probably useful to be explicit here.

Thanks.

-- 
tejun

