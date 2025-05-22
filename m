Return-Path: <bpf+bounces-58772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520DEAC16CC
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EAC3AF286
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B3277021;
	Thu, 22 May 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obNWYMD/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9913C81B;
	Thu, 22 May 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953015; cv=none; b=GYLnYJWsIFAMH8dHRPWN7dIGpW6bwlr4/8fzwHcOpWaWwhfx+ESDSMfyrPxieHmy169/gPvLKnAfNcmkKkPDRx4QaQBwDAfRfOJMsQQjjIwtR4x9ETohykOepZPy6J+FDGAJCBxJJ1mCFxFgEELIUJdk7jrHkDHFZg6ofGMb5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953015; c=relaxed/simple;
	bh=jW9IdrEDsP9dLKs3o6gfn990nlhAFd7trNmrhCDWRIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buBPipG/P6cDADPuXYBQlTQdUkHUsDlMo+t21FYjpsHrR/geP20UlzU+W6/NNf/P+kw2vg0OU/PF3F2fI9gygkbA2x8VwHZ+IKspMBO51LWjjrCV9SYgOAjDuqa60Oh3N6BC3VXXc8Mj5t8RdxL0c82HzA6Vdtr1PbgF4ouLa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obNWYMD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE62C4CEEF;
	Thu, 22 May 2025 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747953014;
	bh=jW9IdrEDsP9dLKs3o6gfn990nlhAFd7trNmrhCDWRIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obNWYMD/5Bwx1hqCakZIHjeBBRpDNPMNTHeyi2pqJ7N2SbPNuHw9RUB7B6LCru2vP
	 z4YEHTiRuzmiDy+lXUoak1zEtryA5CKB+4ZsA+LWH+Lub14ST+gLL3jIzG9alpKyq6
	 bmp3ry8RO3vmopj8dbGHCf9CW0gW+CrfzeCnFfJnKaoPDyP18xWTB82bffDJGqxKEo
	 udFbocLtZ06ZyrX5fHE0Q8uKk3M++SMyU3H6X2pUXtFaJrtD8iacCRIpDWwwPQOmCS
	 2wFxf2ggMriYjO0Mws2AtsBVBfY/E/G8F/kir+YpjA1vDyobuNT6dpVu5GFrczS+uN
	 5M7oJ3XVbb21g==
Date: Thu, 22 May 2025 15:30:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for
 headers
Message-ID: <20250522153013.62ac43be@kernel.org>
In-Reply-To: <1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:
> Allocate a separate page pool for headers when SHAMPO is enabled.
> This will be useful for adding support to zc page pool, which has to be
> different from the headers page pool.

Could you explain why always allocate a separate pool? 
For bnxt we do it only if ZC is enabled (or system pages are large),
see bnxt_separate_head_pool() and page_pool_is_unreadable().

Not sure if page_pool_is_unreadable() existed when this code
was written.

> -	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
> -	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
> -		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
> +
> +	/* separate page pool for shampo headers */
> +	{
> +		int wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
> +		struct page_pool_params pp_params = { };
> +		u32 pool_size;

A free standing code block? I this it's universally understood 
to be very poor coding style..

