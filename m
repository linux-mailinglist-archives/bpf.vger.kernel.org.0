Return-Path: <bpf+bounces-77510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57160CE9647
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 11:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F4B3062932
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7530C61C;
	Tue, 30 Dec 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lJansbAc"
X-Original-To: bpf@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174030C614
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090050; cv=none; b=KjxbIo+ouo6DjWa22MOkVNm/fO1XjnOTG2uuS2c5XZcnAsVzflWs6NmLTBdFtj8XPyZAOPwbSmFB/pVFCIpIxqduf5L9w1GeXG92mmtWJRlltxeX4BOU1MXD+mpKJ5iJXo0m90Fbwzwya46N0UZ32aQZ+6YJ+hokEnpuE9Dfmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090050; c=relaxed/simple;
	bh=Kr7cc5aCabCFBDO9QjbkGdhWQbOsNEOAY0KJtdP3AJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiobqI/bQda1EDq0xiMuE3CljH06AvLkFNtS6OOUXhPESiEqH98WoQc7pZcmeJhofk3hBW4oTua0Oar7D5wqkr6WVTiwikzYjsDJuqE9WGAVWHmREt1oO/bgqYVj8oA1hLFNbAHC/npU7HKf8EdoMgKPWuTi2+aYSppzqxPtpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lJansbAc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gI5muXSq8HyIF1Q9vV7HGC9iy/hi/LoUdYnjx8Pws14=; b=lJansbAc3W4aKLhyiUNqPd9w9n
	ldMYxIs+bgaIG3KO176mEwZz34A/k8Pfo5zB6nmWiwRFHLZd19gH9gfZj1slxVkLNkji0kqHX0ged
	Aduuqgx8Ne4Tv3ak2xMVJesbPNSIiBjhNy7vfbkTluxvtj0EEeiS4XYc4eskusL4Wu8/61HkfKf4s
	2oLS2J8Lq3oNYylh9dh4ZWc0T2Pkk1IK3PO3kDdv3okXtIDRlJbNzPlSJjm5quLkj1KwUdb/ODpSX
	1h6VSv4Qqhd1znvn7x9YznlbFe8V9gGxqm9Rrleckng1eePtxx3nlsmGdBfYJVyFY8jrOlxdibEBZ
	uMMzQgLg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vaWqE-00ByEO-TE; Tue, 30 Dec 2025 10:20:39 +0000
Date: Tue, 30 Dec 2025 02:20:34 -0800
From: Breno Leitao <leitao@debian.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Subject: Re: [PATCH 1/2] bpf: bpf_scc_visit instance and backedges
 accumulation for bpf_loop()
Message-ID: <oonuj2yhx5zefk5hagt522lzrwz3zsmtibunpvmewuh4d4t466@2z2tab6j4nue>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
 <20251229-scc-for-callbacks-v1-1-ceadfe679900@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-scc-for-callbacks-v1-1-ceadfe679900@gmail.com>
X-Debian-User: leitao

On Mon, Dec 29, 2025 at 11:13:07PM -0800, Eduard Zingerman wrote:
> Calls like bpf_loop() or bpf_for_each_map_elem() introduce loops that
> are not explicitly present in the control-flow graph. The verifier
> processes such calls by repeatedly interpreting the callback function
> body within the same verification path (until the current state
> converges with a previous state).
> 
> Such loops require a bpf_scc_visit instance in order to allow the
> accumulation of the state graph backedges. Otherwise, certain
> checkpoint states created within the bodies of such loops will have
> incomplete precision marks.
> 
> See the next patch for an example of a program that leads to the
> verifier accepting an unsafe program.
> 
> Fixes: 96c6aa4c63af ("bpf: compute SCCs in program control flow graph")
> Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
> Reported-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Tested-by: Breno Leitao <leitao@debian.org>

