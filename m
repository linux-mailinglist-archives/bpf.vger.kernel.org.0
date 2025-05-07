Return-Path: <bpf+bounces-57668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EF9AAE741
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB83AE0CB
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284D28C00F;
	Wed,  7 May 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJPnpSSa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE072628;
	Wed,  7 May 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637190; cv=none; b=jBlGGZ7j5th6lMVRJpnxbXoxCbPtVpnvEYDigyuYjy5UpbN2kiwQmGeS7d79aprsPMUp0ZCKU8H1ENnlEQhS6NSEJHfEgILdMqZS4VuWnBUOgajU5P3DnCqr3pYEw9GaM161ipQeSyHbcT4/YJ7Jx6olmf7s9LWyl/RxVlYzF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637190; c=relaxed/simple;
	bh=/5+ia+kF6i2GSblmiqs+jdYsBGeEkQH/2hYno8lDbV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAO6hCJv0PzxuehAb/Kjs+Bun48T6AikbhNfXsm9nWMNhLUbN+81wVbNJyFQQcAdJmJXwH6jIRZ3QVZ6XXwVUG8lRuMVFSvzABiVHqIrYsz3UyZeU76HXLZJhwMeSwUzBvEPSEN5mw97/FanfAlAuE+ci0/JcP41kE1izfs1v90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJPnpSSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EA0C4CEE9;
	Wed,  7 May 2025 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746637189;
	bh=/5+ia+kF6i2GSblmiqs+jdYsBGeEkQH/2hYno8lDbV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJPnpSSaSQih6tNYmtVGiU1OQsgIN6O8S6zthqwjk8uJcYWde6CVtRTq/yCbYFtfK
	 IQs0FJWKPCgU8eQDsklhhd3Ll8zj0HBKb8kC0vh3h7YtXU/a1DeBkc3xfQ0hStXGCl
	 LNROMlrM1IWW+whURZVAc8CZxlU9YPrLBA+Co88B1RHaM14SUAg+ntQhKpXI64IZjq
	 4TsvXApFWTsg57L9dyWAvC01Twpl7n4kXCfmVzOZrJN63yn/wFMN47qk6sCGog9Hmb
	 TEHH5GKUHv5mhfiqhHIBU0LQulB7v9VPsM20mEyVfJKCA+UJwf6gPsBYNghDdbOvco
	 PsyIyNovaw31w==
Date: Wed, 7 May 2025 06:59:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, joshdon@google.com, brho@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/2] sched_ext: rename var for slice refill
 event and add helper
Message-ID: <aBuRhMtQa-ogEv57@slm.duckdns.org>
References: <20250507011637.77589-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507011637.77589-1-jameshongleiwang@126.com>

On Wed, May 07, 2025 at 09:16:35AM +0800, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. So rename the
> variable to SCX_EV_REFILL_SLICE_DFL.
> 
> The slice refilling with default slice always come with event
> statistics together, add a helper routine to make it cleaner.
> 
> Changes in v2:
> Refine the comments base on Andrea's suggestion.
> 
> Honglei Wang (2):
>   sched_ext: change the variable name for slice refill event
>   sched_ext: add helper for refill task with default slice
> 
>  kernel/sched/ext.c             | 36 +++++++++++++++++-----------------
>  tools/sched_ext/scx_qmap.bpf.c |  4 ++--
>  2 files changed, 20 insertions(+), 20 deletions(-)

These patches already had been applied back in mid April. If there are
updates to be made, please send incremental patches.

Thanks.

-- 
tejun

