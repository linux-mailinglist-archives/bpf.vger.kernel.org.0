Return-Path: <bpf+bounces-50915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B904A2E3F7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5842C188A955
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 06:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF64191F94;
	Mon, 10 Feb 2025 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMsfjtwq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D3134BD;
	Mon, 10 Feb 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167272; cv=none; b=cgCrNnUJOVxvN5M/+tnqtTatSDjTs2S89uot9mbztXFcZoX0/1gRQXPEcHXr6PB2ummrVpWSAnblDme4s62RdJaZg/bTR0iVsY8yis2CTwlqEb1UwGIif7leFUDC/vgSbjBBnMQmeQfYROOr+X3NuAUSHVcO0k1hjoq1/hNJKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167272; c=relaxed/simple;
	bh=6qRPLyMYSQ3aYN+AulqqnePcABBBtcUCuJ2PRTsZTk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RclhxSPyOvoJByqVvFvqcy5WH+SfkUMYzs7S9XqFjWCav0XKy9GYY5g5Vpa9mjgJmCZZKNUNlOdQF1wnE81/WW/HemPaCRsQiDQ7aagm1x0yg5HvcCQZr+PfxlwvLZm9uJZXsDrT0sWCuWRK0y/B9frCxsbXufsZ9U89LDsxFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMsfjtwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8313C4CED1;
	Mon, 10 Feb 2025 06:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739167270;
	bh=6qRPLyMYSQ3aYN+AulqqnePcABBBtcUCuJ2PRTsZTk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMsfjtwqkQSL4S9qTnmf6+3gO4FDJmQuRTYzw9k8Hp7/4N9yck0DNm52AAFE96JEf
	 YiOzK46kpyXIEXOp9+f9l+mhsrsgNkA5Yl2+FaGf7DQMHA9o+kZSAQ+rzgfXQKT3Bo
	 EQsKghN+eU/eTLGPw7bVfjv7RE7VvmCWfN3IlZNRTZcGF8ZKwSikxtqojlvVLne3GA
	 qUH6oGmrdPG4J6rYepED5ah+fG2Y4fPoE8GiljmKKp8RU5+3OoviRc8i1oPV22gwtk
	 HckSafLnUOfPDGv121s4JWO9cp4YXAACfrapqGj3bdroeymuZaM1l7hYu5alNpXexx
	 sBbOnU8bRXN+Q==
Date: Sun, 9 Feb 2025 20:01:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z6mWISy3U710ghbf@slm.duckdns.org>
References: <20250207211104.30009-1-arighi@nvidia.com>
 <20250207211104.30009-7-arighi@nvidia.com>
 <Z6aLvYaYlQ3KRZQM@slm.duckdns.org>
 <Z6chqn0Xf6xhL5gA@gpd3>
 <Z6hLvxEKFlgmIeOQ@slm.duckdns.org>
 <Z6hjI3ul5E0BBtjp@gpd3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6hjI3ul5E0BBtjp@gpd3>

Hello,

On Sun, Feb 09, 2025 at 09:11:15AM +0100, Andrea Righi wrote:
...
> About scx_cpu_node(), which is used internally, I think it's convenient to
> return NUMA_NO_NODE when idle-per-node is disabled, just to avoid repeating
> the same check for scx_builtin_idle_per_node everywhere, and NUMA_NO_NODE
> internally always means "use the global cpumask".
> 
> Do you think this is still error-prone? Or should I try to refactor the
> code to get rid of this NUMA_NO_NODE == global cpumask logic?

I think that's fine as long as the name clearly indicates that the function
is doing something special other than mapping CPU to node. It can get pretty
confusing if something with a really generic name doesn't behave in a
generic manner.

Thanks.

-- 
tejun

