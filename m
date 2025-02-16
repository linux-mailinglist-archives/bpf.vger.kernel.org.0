Return-Path: <bpf+bounces-51697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671BAA37580
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 17:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB7E18923E1
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA2199947;
	Sun, 16 Feb 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuTJ6viE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753C199235;
	Sun, 16 Feb 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722338; cv=none; b=sl7OzX+oECQPjkitgvugDza1sjf04Q6mWjG8cEJWY0plWxzQNZsCVXwVo+WpRV0011OP8OLaKOPLJr6cw0O0TT9RWeuHq6U6E0I5yp3X1pmdQ39J+COrYB8saGwr72MD0hjcOARHPYov0+0yUHycZzHDoiLRcHnRdQvXnV3achs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722338; c=relaxed/simple;
	bh=yU02kLPhiph18VfZl5bH8UyNE2t5wWEzf2d/AeDMaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoOnstVYIAvdnodhTXZrKoEBuaRmSp19Se7qCF2J6hi73+Jfqi00DVFxcH1dBs1whIIgU/GEBenFq5vi+G21pHr/mxqGaTowzyzSJLh444I+gAMMPTB3gNkufDAn0rtiKt0oMhtfoWdHLWxcMmQJOM4M7BwAlnpOqYj1d2p7hkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuTJ6viE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA2BC4CEDD;
	Sun, 16 Feb 2025 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739722337;
	bh=yU02kLPhiph18VfZl5bH8UyNE2t5wWEzf2d/AeDMaio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuTJ6viELCfFlsAkxOMQ1XNY67MbOH2WIdgkqbKq4oWy4fn2k/wYM9UZYKJ1PVz0Y
	 O/KjlYmq3wY8cLWLrCQkHauN2+EOrY0sPqTvKZUHpiPOZ1dM3xX1UkS8hUaGqx+l8+
	 y7RAak0ibg6jgbYnGpOPhaOSOdFbhCQnwwvdstKYvQJtG8RDJ1wAoTcR9Ves22KNZJ
	 aSjtvOxqBNS1RBafMa2YyYW3ZNMqkvaMhKExZnv+Ff1Smz1YGMuDm5oIccChRjJ7MA
	 QvIkhq5v4WIPaje6T3PiaCA33TOcI9+MAbdylG2Ter1q/58Zp3hTjVHAdp2iJDN5sh
	 Fz/gkZ/cgn93A==
Date: Sun, 16 Feb 2025 06:12:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] sched/topology: Introduce for_each_node_numadist()
 iterator
Message-ID: <Z7IOYMIltMP1V7oN@slm.duckdns.org>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-5-arighi@nvidia.com>
 <Z6-yxTEbuJZUZW8f@thinkpad>
 <Z6-1nzIPYlFV60dB@slm.duckdns.org>
 <Z6-2ClIa30DpI5X1@thinkpad>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6-2ClIa30DpI5X1@thinkpad>

On Fri, Feb 14, 2025 at 04:30:50PM -0500, Yury Norov wrote:
> On Fri, Feb 14, 2025 at 11:29:03AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Feb 14, 2025 at 04:16:53PM -0500, Yury Norov wrote:
> > > > Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > 
> > > Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > 
> > Yury, how do you want to route the topology updates? Do they usually go
> > through tip?
> 
> Can you take it with the rest of the series? I can move it with my
> branch if you prefer.

Will route it through sched_ext.

Thanks.

-- 
tejun

