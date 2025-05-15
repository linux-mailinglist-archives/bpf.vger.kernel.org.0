Return-Path: <bpf+bounces-58325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05DAB8B42
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350191B637BD
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE9621884A;
	Thu, 15 May 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVYHCIi7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B2217F34;
	Thu, 15 May 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324071; cv=none; b=M8vnZ7P2QR7HnRowx2DCW8UKalXWFHYzxuU3bSXzdpd31vTp3vB1gyruT3cIsMRcZK+vYBH1wOG+JZOeiAEjkHcI2fHRhGfkqJuQPP6uUUIR1P0GCJUhmUbtbJ0E0Tsq85NyTY7N28Yfd3OWHHaTMjx+21Lqp7V6GIEe9yuMRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324071; c=relaxed/simple;
	bh=wzc8O4szYX+d4pjGzQ2Eqb1YlzSsOZl/5hIYcHCkLAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mweQPsuWO7tNKIGLBoejSJNHQGy7TEvoRqFLR4eeKf58T1FJhsJrflINUB9pNeMUsaZASlHHAd611GZykjsMkWKgorQejpdFENxVY9e0zL/yXd6Q7ZmPoYokKCZhVERMvYJSR5YPG+cV/ZcrGTxUULKBS02U3hohyJUcI/Vd5rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVYHCIi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF87C4CEE7;
	Thu, 15 May 2025 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747324070;
	bh=wzc8O4szYX+d4pjGzQ2Eqb1YlzSsOZl/5hIYcHCkLAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVYHCIi79L3pvbQL4RxYqhKi4aTXb9VVMAiZ+bOIx5jL2SnMP10DC1fI2YzwreU96
	 OppBYixNs/jB0HjE/eh9yX4V8WAvktvmZ0uBR1hUHnNPNkUTkERP2qi5LpHENTOlDz
	 ZQJH++rjOUs15rhauk5QP6EoB97c0c8Hl2Zv7N60khVeyDqdlpSDI6USqsbNkSQpSY
	 x1+iCkBR+xeibyImJ+6COtr9amU3Zi8FKF06IE4X8SzBKRb+I8VhRY9sdg/AgcdBMi
	 ovU2rG8sRl0Lq4/fKrg1dOgSMnZjeyuTA1d0kB7MBPwzHVapTllx+Hf6h8BnFF7i+D
	 l4J7ufo9ooWNA==
Date: Thu, 15 May 2025 08:47:47 -0700
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
Message-ID: <202505150845.0F9E154@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>

On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> support more granular vrealloc() sizing"[2]. To further zoom in the

Can you try this patch? It's a clear bug fix, but if it doesn't improve
things, I have another idea to rearrange the memset.


From e96a0e2519b1c5b50f45bd05bf60e6117d1132b2 Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Thu, 15 May 2025 08:43:12 -0700
Subject: [PATCH] mm: vmalloc: Actually use the in-place vrealloc region

The refactoring to not build a new vmalloc region only actually worked
when shrinking. Actually return the resized area when it grows. Ugh.

Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizing")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: <linux-mm@kvack.org>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2d7511654831..74bd00fd734d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4111,6 +4111,7 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 		if (want_init_on_alloc(flags))
 			memset((void *)p + old_size, 0, size - old_size);
 		vm->requested_size = size;
+		return (void *)p;
 	}
 
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
-- 
2.34.1


-- 
Kees Cook

