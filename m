Return-Path: <bpf+bounces-58389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4FAB97B4
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5751BC64F2
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67A22D4DD;
	Fri, 16 May 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av0rKnCA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E12AE8D;
	Fri, 16 May 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384127; cv=none; b=F0Af+3okrey2OnKcI2joGyFDSEmKBf6bf/OuYVxbEuJnd1g+j/thyRlsuglyJ3kDxKeWvbCqNr4PUL874s7LSjoG8zbrOFHboBqMTtRHU3LWZSjbntb4cwB7gMzfCU7NSqOwmikGX44yXhBnjp12L6sD2C6C47TKpXfogXxEei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384127; c=relaxed/simple;
	bh=YScwtIGquvvK5uBmUhitVD00LyH92SDWUWsk5swDC4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRnE+yVU2+wqKD9Msvle7zX1JymnvZ1C7nG6PnXZ5HKjAi+cNlV0Hvb8u9gZFpvg1Lmnou3mXnWGTh6d/jcltMuNSv+53FHHwpSc7XDJ7UdZnpEAGkAs4VODFtwE7VE99Fbu6T6zdKYqy2DJQfS5mBXRTgsyXNFjy8Ky1ck9QwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av0rKnCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D61C4CEE4;
	Fri, 16 May 2025 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747384126;
	bh=YScwtIGquvvK5uBmUhitVD00LyH92SDWUWsk5swDC4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=av0rKnCAfoh9IWDyyUGpquUt99bYJqIsvKp3IcSy5SSgc9BmTXqumw9zj9wOajt3J
	 9DddRwouC7FG4GXXvohR0zc69Yt6zT+hegtgTrwiOCfz9TNcONwTFF3ur9AD0phAti
	 1A1ELq+Es+ypNdrpGi4JvMBja8Ms3VAFb2Ub2GitWhfL0wa0KluO3zmrW3Z9wHO2Vo
	 C86yy7AwlJfThTdsHFhahtZ1CvimiQWL6ATdIiK62VT0htJ8iutVYtGENhk1l0dzWv
	 BamaW8Z4uyQ1pBGFuLuDkJ3Yjrsqn+ZZ/Aaez16A8xzfxNudrRydcaDbbMWB8RZj+r
	 6gOgRyxBpM2FA==
Date: Fri, 16 May 2025 10:28:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <aCb3OTZ1tLfEJIkC@pollux>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515214020.work.519-kees@kernel.org>

On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> Hi,
> 
> This fixes a performance regression[1] with vrealloc(). This needs to
> get into v6.15, which is where the regression originates, and then it'll
> get backport to the -stable releases as well.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

