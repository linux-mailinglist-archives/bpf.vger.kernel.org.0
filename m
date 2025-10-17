Return-Path: <bpf+bounces-71250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4EBEB54D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DCF624AD6
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2833F8DF;
	Fri, 17 Oct 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbl55exf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50A33F8A2;
	Fri, 17 Oct 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727865; cv=none; b=rgN57Gl2M8gkYyBjFBkbkyagI0Nx3ufcukoA1BCpMs4ePdUUS3fYWZGtWMnOomJXdVC8rWssGeSWJ6oeA+QfPyHh+aTQtgq5CJmJ0cK9ZZPVNOaSvuYb9epHtMavyJqvpdPfi0GHt+/oWcioKaEZje3dap6NOcrqdtMJZkVfBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727865; c=relaxed/simple;
	bh=Qt32d63SAE4stAqVZnBzVQMrPivjtQekm9eUkbEgEN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzbmcI0D/ptwDlHjVcH1gnFnhtXrUq+HI5aRM6htRjKBlbi6c/VJk3ANwuwQZq7Ma6aUJty7cyl6MvLPdLqSWK9cZr5t3sqXWL1Laq8KyIj7WlTEw2M9GRoWy6QeaYmh7rMju83VZCGEVCB0USxYi5BgW1FM/bsEw1KX87BsGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbl55exf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80F1C4CEE7;
	Fri, 17 Oct 2025 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760727865;
	bh=Qt32d63SAE4stAqVZnBzVQMrPivjtQekm9eUkbEgEN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbl55exf6cNSoTFxKXyWbkqtLizHLgPj30XTZKFQq2LeCr6NVK5f1I0sihyUUlFQR
	 fhy0/lR94ikYDaSL+kBpRKKv6DCdd0uwoDJ146UHAeX9S8MWX7LgGq7zV1SeiOPoiE
	 WvbaNEEbIdaemxNsDBeicPVLCGaYSHgYRYwQzUuloQxr5YaIedb8SrWMAgM3Ck196T
	 ffEdF9cqwabagS6ueNZp4ume07sakJhrYNUx2VG+Sy6+aDP2qVdDTpJh8UUeLJ8zwp
	 W6m8L6v64HrwwTLcYUttGJY0UOg9Op24Pw2s1H24lb0KqWAKFpinO8CTInNd68J0pA
	 ttq9ha2UPvf5g==
Date: Fri, 17 Oct 2025 09:04:23 -1000
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
Message-ID: <aPKTN7-JtZVT7wG5@slm.duckdns.org>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPJlIUF-KkdOdDvM@slm.duckdns.org>
 <aPKR23mnuuUdmHhZ@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKR23mnuuUdmHhZ@gpd4>

On Fri, Oct 17, 2025 at 08:58:35PM +0200, Andrea Righi wrote:
> On Fri, Oct 17, 2025 at 05:47:45AM -1000, Tejun Heo wrote:
> > On Fri, Oct 17, 2025 at 11:25:53AM +0200, Andrea Righi wrote:
> > > +static struct task_struct *
> > > +ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > +{
> > > +	return pick_task_scx(dl_se->rq, rf);
> > > +}
> > 
> > I wonder whether we should tell pick_task_scx() to suppress the
> > rq_modified_above() test in this case as a fair or RT task being enqueued
> > has no reason to restart the picking process. While it will behave fine on
> > retry, it's probably useful to be explicit here.
> 
> Yeah, that's a valid point. Maybe we can add a new flag to rq->scx.flags?
> Something like SCX_RQ_DL_SERVER_PICK?

We can factor out the internals of pick_task_scx() into a separate function
and add a flag there?

Thanks.

-- 
tejun

