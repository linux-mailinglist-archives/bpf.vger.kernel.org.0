Return-Path: <bpf+bounces-56151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F51A92413
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EED19E75B2
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3D2561D3;
	Thu, 17 Apr 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRBYNKWH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0A14F90;
	Thu, 17 Apr 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911144; cv=none; b=ZizAsx7Snx7RogUR0ZZj/VJj+RkNWOCfbMrQ/4mNJP0ka8wxa+k6LHqRJ3ku5dSUsr8yh7+pf/ahiYRSZbmVk4a3R+j1hncWnzkieHgHO7MlFJ1QQDaMgJYmuLR49VLZwoi8qsWxOiYb8rHzdBRvg2yEZJKbtakb/raow94X/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911144; c=relaxed/simple;
	bh=3HieAJd+Bp6NRNDwlaAxbVsSPYae9PxpEBpH/m5aAVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUfp1Mn7CadjDzRtfPIqFoFVCLPu3WasfLMX5ORoNeWm28EMKDEjt04n6pGoYpOME6cevfjugsr9a5h11/JgKIE0lzVZ67w4hSrrB3DTb8OlHAL6Em4zUj6QdV8qV7ZEl9k78HS4q3RUXwtvmCWykTYQ1x0o5u4fOf/gGxM2ihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRBYNKWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3393C4CEE4;
	Thu, 17 Apr 2025 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744911144;
	bh=3HieAJd+Bp6NRNDwlaAxbVsSPYae9PxpEBpH/m5aAVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRBYNKWHJlmXH8352XuKGolXa6DZiP7QXNdjzvlJJCPZC2V+wy4OEUxT/+Y2vceaW
	 gbhTfAunTOeVbJvc9zB7DrYzcKHUMVptBoUtgbrLLmQCBf0XpUXpCTHCZXJdKh8Dhe
	 CYr2Rx1qpJ/Lz4A4sDMUnjmaah15IaadR96mKiCHVq27r1w/z/aEqf9/6peP6KYb2O
	 moyI/Mq3QZK8NJr9JmRMFVEddptdQbVhys6E8Y8qPT5a66wkH0HAjzZ5WN1Bb/uylt
	 W8dttsmjfduI1EexMmuGljAv+uJbU90BpdPN9v0cKIVyxqx3wEld8w2khtK3niu+Fz
	 Gm44R7fbSigVQ==
Date: Thu, 17 Apr 2025 07:32:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, joshdon@google.com, brho@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] rename var for slice refill event and add helper
Message-ID: <aAE7Jmqb5-ep7D2S@slm.duckdns.org>
References: <20250417080708.1333-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417080708.1333-1-jameshongleiwang@126.com>

On Thu, Apr 17, 2025 at 04:07:06PM +0800, Honglei Wang wrote:
> SCX_EV_ENQ_SLICE_DFL gives the impression that the event only occurs
> when the tasks were enqueued, which seems not accurate. So rename the
> variable to SCX_EV_REFILL_SLICE_DFL.
> 
> The slice refilling with default slice always come with event
> statistics together, add a helper routine to make it cleaner.
> 
> Honglei Wang (2):
>   sched_ext: change the variable name for slice refill event
>   sched_ext: add helper for refill task with default slice

They look fine to me. Changwoo?

Thanks.

-- 
tejun

