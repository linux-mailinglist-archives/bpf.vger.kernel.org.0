Return-Path: <bpf+bounces-46661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB69ED3C2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54295283544
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799B71FF1BA;
	Wed, 11 Dec 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjvR1XSl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D861D9A6F;
	Wed, 11 Dec 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938803; cv=none; b=tbjvFBonXUcq4cbjys6K9/Bfs4+EW3Kk7TKxZrPP3o9uwuBDUaRWKKshcVbAIU2Z5G5obco3NoRDgkY2Vrf5MJWPrPS+REOczl9RxPP1TmKOhP80K3hJpoMaXBc0/SBTVdqVT0UG0EaEBYJVJRJo4h2xb7DPYAG2DGyGpa8V+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938803; c=relaxed/simple;
	bh=/xyGUmrkcxG9t1CbKV7HdZuyJPphH/PWuZceXwxMrCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI5aZS36px1WDnM/5FoGAlBr7vu2DPaKAdEClhftVn9dv4rHACRN5Vt28GwrV67VO3C/DwJpi7dT8gLpPogj7BPgDkneAg2zk+DxJTbGEY87YAAQdP7NhNJVyjhbPfL+SHKdbtT7xG9ACbpZPS0ftVjT8kqE8GkIctwrGaGkIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjvR1XSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADE4C4CED2;
	Wed, 11 Dec 2024 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733938802;
	bh=/xyGUmrkcxG9t1CbKV7HdZuyJPphH/PWuZceXwxMrCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjvR1XSlYtUUwZz/8dTtIPZMcsIHKS+UfBwd8MTcN6H3+cfjFTP5jxy3vnnXgmBMG
	 kaLj0wfI6eHDvxln6TvFW2BuaKZTz+MyUtsHC7TSR4OrI49ouCoFeTjf2RBh/X+Xw3
	 LZRT9QnNtW7b8KezP8cqETFBZFEcNjYLqxE54Gwv9f7p1UgEMbhBzAh7VQtxBGzC4F
	 s/ZOMfEY34oFxp4hHq4WLs+G3wZpK2iYEOgn6+hlEm2Ddkx2W4rDknDSq597Wch3pm
	 UtTLcsMNpWKgnBrLCOUr6wbvN+fTlcxAxD00EX2iZyO6iuaETag4X5+RcvxkWYyzoT
	 10Q1oTQid7BpA==
Date: Wed, 11 Dec 2024 09:40:00 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
Message-ID: <20241211174000.tpnavd77pyfq7hw3@jpoimboe>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211172649.761483-12-aleksander.lobakin@intel.com>

On Wed, Dec 11, 2024 at 06:26:48PM +0100, Alexander Lobakin wrote:
> Sometimes, there's a need to modify a lot of static keys or modify the
> same key multiple times in a loop. In that case, it seems more optimal
> to lock cpu_read_lock once and then call _cpuslocked() variants.
> The enable/disable functions are already exported, the refcounted
> counterparts however are not. Fix that to allow modules to save some
> cycles.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  kernel/jump_label.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 93a822d3c468..1034c0348995 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
>  	}
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
>  
>  bool static_key_slow_inc(struct static_key *key)
>  {
> @@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
>  	STATIC_KEY_CHECK_USE(key);
>  	__static_key_slow_dec_cpuslocked(key);
>  }
> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);

Where's the code which uses this?

-- 
Josh

