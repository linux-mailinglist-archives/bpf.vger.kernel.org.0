Return-Path: <bpf+bounces-30754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D151C8D2194
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B6284D0F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540B172BC9;
	Tue, 28 May 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9edovFX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDE172BB6;
	Tue, 28 May 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913459; cv=none; b=fez0pdU+Wc8rgQ8bD25v2RKsEeSgVtKdtbaXxFAMRe1oO7fleptSQzsOIduw9VVDBoF3LJYrsgrB4rp7m8vpJJewgFHa+Cp8v93K+mKSS3Tz5mJ9pJMUB6ZuLnKFYOwN0j/kj5uEaDQubNoXd6jaPBY3MMbNfBFLVI7Eq4pqupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913459; c=relaxed/simple;
	bh=WLd1fNoyV0qscNR0eATu/TrJhszfKjt5pkqMvU46p+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfpeRhN2lhP+ghrsicqLedJLLiOWhaNTSlv7BMYb940vUKQFHK9CyBAKmstsEpalhaBlGjqnY/8MnKbyiTMsN5r2ZsL7451syvJtDThy/IT6vLoQK2F/gv4vzHsXTBs8r07JIT8XDCmy1TupVcSww4wIy5VjOgd25NE5wPHYL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9edovFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59868C32782;
	Tue, 28 May 2024 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716913458;
	bh=WLd1fNoyV0qscNR0eATu/TrJhszfKjt5pkqMvU46p+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9edovFXg1O5HxxFxP/IaPwEyvndQKaY6uMgBqFBhN3ZKXPby5qkEifWAGsQcbd2H
	 +apzK7nJHIIcWckZDrXokE/v6mX1Rw70nrO5Mg6C03i0rpYDSSUt3gYEgc8hAwLuAb
	 YIgH4oJ772W9mPzMDpRfdZTztKWj+/z59vu/4Wz6FOnX4Ceec38RMU3t7pGWGmbmA0
	 XEEcVBiax+i4QBd80MGEt3Vin+m8B+maJMH6qKGOVDgV7WuwoCN2BvrtE8RSznribB
	 rUI0nii+hcawX5ogIIhUVToklCyE0bN5oAdyyv8BGUjeHZldXd8zVgNa/5kE6xiUCm
	 zhZBExpkKX3LA==
Date: Tue, 28 May 2024 19:22:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [Patch v2] vmalloc: check CONFIG_EXECMEM in
 is_vmalloc_or_module_addr()
Message-ID: <ZlYExtHSa8aafrzO@kernel.org>
References: <20240528160838.102223-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528160838.102223-1-xiyou.wangcong@gmail.com>

On Tue, May 28, 2024 at 09:08:38AM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After commit 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> CONFIG_BPF_JIT does not depend on CONFIG_MODULES any more and bpf jit
> also uses the [MODULES_VADDR, MODULES_END] memory region. But
> is_vmalloc_or_module_addr() still checks CONFIG_MODULES, which then
> returns false for a bpf jit memory region when CONFIG_MODULES is not
> defined. It leads to the following kernel BUG:

...

> Fix this by checking CONFIG_EXECMEM instead.
> 
> Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6641be0ca80b..94e1d2dbdec0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -722,7 +722,7 @@ int is_vmalloc_or_module_addr(const void *x)
>  	 * and fall back on vmalloc() if that fails. Others
>  	 * just put it in the vmalloc space.
>  	 */
> -#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
> +#if defined(CONFIG_EXECMEM) && defined(MODULES_VADDR)
>  	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>  	if (addr >= MODULES_VADDR && addr < MODULES_END)
>  		return 1;
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

