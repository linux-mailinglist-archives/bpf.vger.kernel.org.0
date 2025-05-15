Return-Path: <bpf+bounces-58366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E37AB91CF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E487AC2DC
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2993284B4B;
	Thu, 15 May 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9y3q0MK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC21922C4;
	Thu, 15 May 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344983; cv=none; b=RnMQgi7ItnGEP24TwfeKMB3Qk+yeb5Wm7VOEz+gNb4Z52lmKVZn9bJ/XGHbfWsWBPt0GpSmpms1iGY+yMfnVSmpUf78pwl94wJ5k14BkoAeJSZGs8PEyzZJQGLZReckhkDQejby5K6AhVhTLckKw/1yVogpdU4Fjw0G2RjrAfZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344983; c=relaxed/simple;
	bh=SeYwRuis/az6deX8AL3u4+LQM8L5xEuFWIqWaKOTXMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR3weyH+vSXjpZwb8SzZcF3wC8kZBwq6kCZHNthLUgiuZ32aesbAhKISYxBlquzv81VxSyHjXsPsriRiT/T49rY/QGTHfBGtPQ3dmSYRZZnALrfds/HDRgQ7VXhdrn0NTjxCD4/wEmg731A7cmuBSC8kuLqhp1oCZ3tmjO8S2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9y3q0MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BCCC4CEE7;
	Thu, 15 May 2025 21:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747344982;
	bh=SeYwRuis/az6deX8AL3u4+LQM8L5xEuFWIqWaKOTXMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9y3q0MK/zbiEU/HAxlbPGU73uzBL5vYTiUT+rCbyxgIL9AuxVykDRbstUpE6XU7x
	 RXlB02xpxW3eJJI6gj0q9SIZYYH6RwHimPp/9mJEPL7A+co9VxQkSSBHQCNFfMrU/D
	 shHcTlTkawpaTvtS5i6WngH3uaFb5Qz8qFAX7JAe8x+d9wlOc11hg5xeEARkIhBMM/
	 pF0mbwrjXD2QExW3Vq5qISkPQ/jNbE+AiaXpVR4ZJlqpT5B6sWf/6Enn7nvhF4gvQm
	 1IUJbVpRx6O71EaqR7GVFI6MychgN6K8wbin3rOOEV1hMFmujOdhwMj802ggKl3luU
	 ps01aja+qBRig==
Date: Thu, 15 May 2025 14:36:19 -0700
From: Kees Cook <kees@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <202505151435.ECC98E09@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <202505150845.0F9E154@keescook>
 <c36245a48149a12180ec710c65d317a12cdfa020.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36245a48149a12180ec710c65d317a12cdfa020.camel@gmail.com>

On Thu, May 15, 2025 at 11:31:09AM -0700, Eduard Zingerman wrote:
> On Thu, 2025-05-15 at 08:47 -0700, Kees Cook wrote:
> > On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> > > Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> > > support more granular vrealloc() sizing"[2]. To further zoom in the
> > 
> > Can you try this patch? It's a clear bug fix, but if it doesn't improve
> > things, I have another idea to rearrange the memset.
> 
> I tried this patch on top of the commit 82f2b0b97b36 ("Linux 6.15-rc6").
> W/o the patch I observe the slowdown, test times out after 120 seconds,
> with the patch test finishes in 3 seconds.

Well that's pretty definitive! Thank you! I'll send out a properly
formatted patch. May I add your Tested-by?

-- 
Kees Cook

