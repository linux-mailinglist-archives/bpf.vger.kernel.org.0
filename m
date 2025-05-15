Return-Path: <bpf+bounces-58326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BCAB8B89
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A6E4E1C20
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC521A452;
	Thu, 15 May 2025 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebyt547K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9823BE;
	Thu, 15 May 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324401; cv=none; b=a1DVhwyHwSpa2JiLxPuWSMScnnsuGLNPTexzQCEJ/QZP3kB6c7Pv93z9kMjBPDAQModLPyKQQ/88KgwEFEQSGSrRKCVus+mDI16Gghw02OWqY+mVLQjO2HpapAHRftDTmnCSM6lhfl09M30Qzh4kgmxMd8P5UOOSKN7gdAWZuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324401; c=relaxed/simple;
	bh=wgauiSBJZxz1TAwwb85yd+vzgW3Od4KEKvWLZgKnYkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc/PYMASIXYxdtn69PSx+2MuUUoUujhyW0J7oFLkhWTD6L8qzz+sICDXV+4Dma2BrlGtWNE0WBQrSvg5D1+O7HKbckQJ9jfHEMvyz7wYQvs7JCmvBWXL2S/kMdIuNzRQkHGVmc+R9elmBl1H6FWl1LlQ3TwwX6svaA8xExGpMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebyt547K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C2C4CEE7;
	Thu, 15 May 2025 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747324398;
	bh=wgauiSBJZxz1TAwwb85yd+vzgW3Od4KEKvWLZgKnYkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebyt547KixQ/RYqLdPKw0FYomWcEI32KN+KjUgmrayBXBqjjcm//TcpXaRcS1vM1r
	 ciAAprboRYq/5RWZMw7MP++D2ScZQgt0ZYBrrqenllMC/7XspiU2dd6ze0eZGZtoM6
	 L+DguB8Fky/QQTwhWrN33VDagSIlY2DbvWGUX2mKgZg4sp6FUdfc1Yf1B+YGJ+yvJp
	 a1pppBq4NupBUy7Jy9Gqk0oLW65IVGzurzhmp4b/zNQOEnTuxhWgcJ4kh3wDZqnzCI
	 vxYfL1Zqb2U3DJSRhwvPenY3umpwaZO+g2pmARHMTwSVk4lvlWzlo2mDCVek5sisnx
	 BmRI6GSKvlNrA==
Date: Thu, 15 May 2025 08:53:15 -0700
From: Kees Cook <kees@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <202505150850.6F3E261D67@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <202505150845.0F9E154@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505150845.0F9E154@keescook>

On Thu, May 15, 2025 at 08:47:47AM -0700, Kees Cook wrote:
> On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> > Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> > support more granular vrealloc() sizing"[2]. To further zoom in the
> 
> Can you try this patch? It's a clear bug fix, but if it doesn't improve
> things, I have another idea to rearrange the memset.

Here's the patch (on top of the prior one) that relocates the memset:


From 0bc71b78603500705aca77f82de8ed1fc595c4c3 Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Thu, 15 May 2025 08:48:24 -0700
Subject: [PATCH] mm: vmalloc: Only zero-init on vrealloc shrink

The common case is to grow reallocations, and since init_on_alloc will
have already zeroed the whole allocation, we only need to zero when
shrinking the allocation.

Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: <linux-mm@kvack.org>
---
 mm/vmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 74bd00fd734d..83bedb1559ac 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4093,8 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	 * would be a good heuristic for when to shrink the vm_area?
 	 */
 	if (size <= old_size) {
-		/* Zero out "freed" memory. */
-		if (want_init_on_free())
+		/* Zero out "freed" memory, potentially for future realloc. */
+		if (want_init_on_free() || want_init_on_alloc(flags))
 			memset((void *)p + size, 0, old_size - size);
 		vm->requested_size = size;
 		kasan_poison_vmalloc(p + size, old_size - size);
@@ -4107,9 +4107,11 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	if (size <= alloced_size) {
 		kasan_unpoison_vmalloc(p + old_size, size - old_size,
 				       KASAN_VMALLOC_PROT_NORMAL);
-		/* Zero out "alloced" memory. */
-		if (want_init_on_alloc(flags))
-			memset((void *)p + old_size, 0, size - old_size);
+		/*
+		 * No need to zero memory here, as unused memory will have
+		 * already been zeroed at initial allocation time or during
+		 * realloc shrink time.
+		 */
 		vm->requested_size = size;
 		return (void *)p;
 	}
-- 
2.34.1



-- 
Kees Cook

