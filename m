Return-Path: <bpf+bounces-72660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE30C178AC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C62B534FB3B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609592877CD;
	Wed, 29 Oct 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFmNR1nA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C2184E;
	Wed, 29 Oct 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697748; cv=none; b=a8VCfWCBPIp2U3Nxc0rqUEmI7Bf0XJ8MkcjwoOEBBR02rBA9RswjWVItctCrKKUJ02SApAhIrgsLejADO9mKR30NvWE0E+URtMSykVEfzYvnEGyUhR9KnL69r2mQ0xPaedFFTOZXqx7PkguXm9T4FwRhBcXSjfL7X5SlZIsiEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697748; c=relaxed/simple;
	bh=M03iNkhqUK8u64+QLZzfM81QbZXupUck+hpb72cxnYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMjUK2imevykNzIhOJc2IUraC3ETrveaLlj68AmNqdtUtlhaWgrSjhUf98/Zp/q4To2LiOI5CfYAcv9NYBUFdKRbyG2YqwSzfBoLsCVCZjkvGN/Bo1Dgo8yyaTfhZnn/Ylzn9xu9WcewnaCNXQ4V8ypXnJ9bVym4dYtlzRm9pOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFmNR1nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782F2C4CEE7;
	Wed, 29 Oct 2025 00:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761697745;
	bh=M03iNkhqUK8u64+QLZzfM81QbZXupUck+hpb72cxnYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GFmNR1nAl6K53O+R6YI4PB5vqnzHwpV6pMcE3WOIJshYVpqVQocTTk9xZYzhSr00A
	 Crs5VHVseCNhRQ1fqEsD116aDgpVgx7fA/ZCwIsnRrCjZYxkibu44z1Wgbu/TzqOZ4
	 sZc5gbv2hJR4D5GOVfpnCKzFBsZjvzFNvVF+xgQph6SSNFAurrdhdUwdVj+lLm0AaK
	 d4hNA+OtswpEJ8RFHIEUC9OuBph2Pg11h64JxMGhQtpzT1npqacRKQuQMsMgukU+Mw
	 Njuuek5+fQeGSSIh4a8omH+nf3jNweAJNlK3gniud1xmbC6+6xiu+YU+boM0yaXOTe
	 bWXzqTIbe+fWA==
Date: Tue, 28 Oct 2025 17:29:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool
 is not shared
Message-ID: <20251028172903.677f46ba@kernel.org>
In-Reply-To: <20251025065310.5676-2-kerneljasonxing@gmail.com>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
	<20251025065310.5676-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Oct 2025 14:53:09 +0800 Jason Xing wrote:
>  static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  {
> +	bool lock = !list_is_singular(&pool->xsk_tx_list);
>  	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_lock_irqsave(&pool->cq_lock, flags);
>  	ret = xskq_prod_reserve(pool->cq);
> -	spin_unlock_irqrestore(&pool->cq_lock, flags);
> +	if (lock)
> +		spin_unlock_irqrestore(&pool->cq_lock, flags);

Please explain in the commit message what guarantees that the list will
remain singular until the function exits.
-- 
pw-bot: cr

