Return-Path: <bpf+bounces-46025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172549E2E6E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD3B33E82
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A29205E1C;
	Tue,  3 Dec 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcLQnY6Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE42500D3;
	Tue,  3 Dec 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257718; cv=none; b=KsKfSbAwjg6qrryd8lR7whasGTb1TqwAy9Ag0DSmU7KBJobepRGsZW59RmrVHX2lIXwUFJEBqbJzqjvzAV9/tI9ckkzBf1UZvHx2juVpf+Jz4SdBOpzH8jPGOf5Viba1nnCaPEUb40ulkPnEVji8mEn9xIR5BHQTjTocjZWv3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257718; c=relaxed/simple;
	bh=BEX7Kxvtvd4L1WIdBYb0kjHAXUavUgl4UJxK6TD4XkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDjnjGvtf5DxQRglo1QAKHyHxnSJ9OTr8s4yt2ND5i6VPJLDAE7Yq7WIXXw9mF5JP+N5FXQDBPdDUD7beeTzvPucPN1vUmSq3oM+Hl+IJC0tE0n/SKGWP1FtDwmn+kxptxGYvsv3eEuSIFBnjGicfiGlehVpt6NYspWl5EVVSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcLQnY6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE29C4CECF;
	Tue,  3 Dec 2024 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733257718;
	bh=BEX7Kxvtvd4L1WIdBYb0kjHAXUavUgl4UJxK6TD4XkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcLQnY6QIjBSDQezhlXcnZoJE7epPYszOztDr0QavO8N+xFQLXMWJAmch56InNnKo
	 N6oFkEeqkN2zzSzq2G6XWUohsp8mCNzh2+Fh76ugPzi67jjoMzmxD3i2JPrNBAxil0
	 kqDqCqUS6CFGWY8tt9Pg+TkWbnCHixBc8SDnC72q7h3Ibaa5uOhHB5bnSoAYWpRiMT
	 6+VkhXcG0KkGRuWdwYwPXncvxHyj1O2SSzE7FVQ+bL+dcSWtrfuWm8p2VpTTUyRzUr
	 rcwe9XUXNKK55sBhcYBI4rPnxW48tw0rn/aJhdcXR49GMFrj5gYWQEv1egglfMItUR
	 0EhkPpEVG8ArQ==
Date: Tue, 3 Dec 2024 10:28:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Honglei Wang <jameshongleiwang@126.com>
Cc: void@manifault.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, haoluo@google.com,
	brho@google.com, joshdon@google.com, vishalc@linux.ibm.com,
	hongyan.xia2@arm.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Add __weak to fix the build errors
Message-ID: <Z09p9BhM6ZGGd3zP@slm.duckdns.org>
References: <20241129091003.87716-1-jameshongleiwang@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129091003.87716-1-jameshongleiwang@126.com>

On Fri, Nov 29, 2024 at 05:10:03PM +0800, Honglei Wang wrote:
> commit 5cbb302880f5 ("sched_ext: Rename
> scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()")
> introduced several new functions which caused compilation errors when
> compiled with clang.
> 
> Let's fix this by adding __weak markers.
> 
> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

