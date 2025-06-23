Return-Path: <bpf+bounces-61323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1AAE55D5
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AC7B1870
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622522652D;
	Mon, 23 Jun 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ86Q7Vp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC419E7F9;
	Mon, 23 Jun 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716918; cv=none; b=WfU47+Haemybqp7nlyP29Op24tK85L2s27TyRBWIgt/RD9P5lOHjuCHCTTtH1v1KYUp+RTBHotId+C5nBTCiuzaXJiU2dowSCRd3X0MPaE2PKAY2T2UXt1dihWM0TRUHGXNoLwzn5NT+5JezPaAuZ+ZbovgptgyN2a4oAvkOzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716918; c=relaxed/simple;
	bh=NQnwdVGF9YDZMibpTyHJ/2X8jH/VklWZLlzwFJitvA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daXaT38kCWNq2kweQ+oz43RElogN46RM8oUZELntNXmAPu7m34PIFZsd9BW9z+cg/iW8z7rg52kCpqhwL4Zmzj7GaRdVSul37aJXuYa1wzNExrZ4lz+av3Z1yuCFvlnhynZ/VWp1EqkIZc2dFHSs+K5dtt8HG34f4pq1O9v385A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ86Q7Vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB573C4CEEA;
	Mon, 23 Jun 2025 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750716917;
	bh=NQnwdVGF9YDZMibpTyHJ/2X8jH/VklWZLlzwFJitvA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQ86Q7VpVqOCQrfi/hwLrTLo/Hyw1ZWw6cMaCiM0u8DdYBadWjSF76oxKNpSoSEiW
	 X+Rp4n2Buz5XOGDWN2li65qIkcPsYxo1xs2ucCwP3Yefk/DuVN4ItOIkewuaVa37Tu
	 epjnwtu7LLMpczPgMg9M9N+j4oXKT5SO/EfwXDRwg+xCbDyKuYjVoU7xD7+wBQCbGS
	 Tuwt8KKPfXZdOC49WT+xLK9/OWY+NfqpP8brfPRBAEz7SHCQ8xV4zUWIE4ez4abTLD
	 hm6W7nQMPZEe0U3ZCFugSG3m1kUrefBIEkuvbnZny5rV9X7TWglJB29Gbfp3V8efcs
	 gvWpHBdzQ9sjg==
Date: Mon, 23 Jun 2025 12:15:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Add a deadline server for sched_ext tasks
Message-ID: <aFnR9S6XTy6ww9_o@slm.duckdns.org>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620203234.3349930-1-joelagnelf@nvidia.com>

On Fri, Jun 20, 2025 at 04:32:15PM -0400, Joel Fernandes wrote:
> sched_ext tasks currently are starved by RT hoggers especially since RT
> throttling was replaced by deadline servers to boost only CFS tasks. Several
> users in the community have reported issues with RT stalling sched_ext tasks.
> Add a sched_ext deadline server as well so that sched_ext tasks are also
> boosted and do not suffer starvation.

I left some minor comments and had a question about adding @rf to
->pick_task() but the patchset generally looks great to me otherwise.

Thanks.

-- 
tejun

