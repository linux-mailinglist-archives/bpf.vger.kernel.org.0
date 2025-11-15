Return-Path: <bpf+bounces-74637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CFC5FEEE
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C223BF4B6
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB21221F20;
	Sat, 15 Nov 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJOLXYcU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6141212564;
	Sat, 15 Nov 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175226; cv=none; b=MVqMzhL2zPuRVkxaMeiZKjlRtWMxX879UhbF1jYgDLob74QxiIdALG8+WxYQd05txD8WsZ/jvbt8VYsQCL87jtjFICp86H2g07TL2FrErNi1kS5UuVFQTGx0zpT/O3W4vuoLLJcQPqeinq4QbgVdr1ywhPxzj4m82UdCPZ2HXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175226; c=relaxed/simple;
	bh=bEWngead4vV42VljuEyHO4FgNrvs7GZEMJrLcUf0mJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPxCxU1JlEAD6rZcLbX61yaABv6UiMFVK4VELfegyIofE4H1yNP9oGLqFza9FkoQUEDdhWA6Y0X5b0BoZwEd5ZwTUs8jVdkFJ1qx2nknu0t2yDyl0ioaYFHTECXFBmpPZHYEOyxbRml0pkwpHtkh4cUO8rMrp4usZ3iP4f27Vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJOLXYcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63771C113D0;
	Sat, 15 Nov 2025 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763175226;
	bh=bEWngead4vV42VljuEyHO4FgNrvs7GZEMJrLcUf0mJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iJOLXYcU2awW+uHZjuIEOVqID5K3OYzEULmyiBmLV5XryG9eDOgERTG5IFLCF70w9
	 vPFqoll82C14oRVT/f416WkQvtpi1gJI3fi8yJY45WN9+iCEi8BDHXQahxD3Ga/hrN
	 WNb2uoGrSitVm9eSSfn5FIpC4gdgE8XhddrW7+T2mwEtetaMkZCILt7En10q/E29vB
	 A35zGerQ2NaoQbLzJjWakdAVlcvhqyWsng5N5iVKAGDzeUUOIjsCMNnj6evFmUc5AM
	 C+66S/4jZxGoZuIzC91vskyzNktIgI8rG0u6wPPBzMvVbHmS4kquh5B1yfHHXQsDWY
	 WhvNO1uldYpNw==
Date: Fri, 14 Nov 2025 18:53:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, William Tu <witu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Alex Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net-next 2/6] net/mlx5e: Use regular ICOSQ for
 triggering NAPI
Message-ID: <20251114185344.6d355ea6@kernel.org>
In-Reply-To: <1762939749-1165658-3-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
	<1762939749-1165658-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 11:29:05 +0200 Tariq Toukan wrote:
> +static inline enum mlx5e_lock_type
> +mlx5e_icosq_sync_lock(struct mlx5e_icosq *sq)
> +{
> +	if (!test_bit(MLX5E_SQ_STATE_LOCK_NEEDED, &sq->state))
> +		return MLX5E_LOCK_TYPE_NONE;
> +
> +	if (in_softirq()) {
> +		spin_lock(&sq->lock);
> +		return MLX5E_LOCK_TYPE_SOFTIRQ;
> +	}
> +
> +	spin_lock_bh(&sq->lock);
> +	return MLX5E_LOCK_TYPE_BH;
> +}

Conditional locking complicates code a lot. Very odd to see it in 
a series which is about improving performance of the control path.

Could you please provide some data to justify this construct?

The in_softirq() optimization is a hard no, pretty sure core
maintainers complained about drivers containing context-conditional
code in the past.

The rest LGTM, FWIW I think the XDP redir behavior changes is fine.
-- 
pw-bot: cr

