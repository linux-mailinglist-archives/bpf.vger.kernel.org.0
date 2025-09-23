Return-Path: <bpf+bounces-69305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D126B93D3C
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B618966C0
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D01F1302;
	Tue, 23 Sep 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWtndbIj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC411386B4;
	Tue, 23 Sep 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590529; cv=none; b=JyKqdOOoI5gOJqNdt9R9Ud9GXqcGpP/zk8BCYwbA6VR9xO0SAyYO277K3XqN40COZItOvbfqO64N1IdjM83nyBjlbUcl6s356xeRKe0hidArYsWZqhXx7hpMz5wcsgFFxY1mxoH5K/lZrGSJ76Dd0t5PJBfh3zZT+JpC1awfbeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590529; c=relaxed/simple;
	bh=lK9XsHuQsnplJwxlc7eNhK47sKfffyqPYZUyHElo0aI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWWSQVvUFjOk8DWgPv2dN3SAp0T2GNt3TtxRv8wDLoB0tAr6Nc3yf7Ts44eLB8LyaQOGetplh8jpjC5PINUA16X3t6amNeb11k2yuyJK6w3Wy3e5zfPLlt+dSlOss2Xmzs/oQxsGxB18ALwiJlsAcbBLrqoY+b9cenBEimL0M0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWtndbIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B863AC113D0;
	Tue, 23 Sep 2025 01:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590529;
	bh=lK9XsHuQsnplJwxlc7eNhK47sKfffyqPYZUyHElo0aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWtndbIjHVAA6g0COjFYRQDhU8zIfXqr6Bv0HbgHwWXqAiZQ99GtfsX2IN8vQmf1L
	 bs6FlmwGzjuKFVUaAHE9+L3GcgnoaXB1CLOBL9J6Edosdz29PsmxGfyozMuO1TMUFG
	 x35fq3Vpv/RIfxZwYLc9BOLD1HZnFzNSJlQsyzz1obuYyB+pWw0t/t22cOP6PJlrTB
	 /p5gf1Ru4CvaR2ze1i7yi88hBeJNVVx1qlDQ5A+ELSvIyQZZVvqQNlAI3DgrC/mSJs
	 V5lEpxmergUzNOAn8fyldMY20tCBT7XZC5O8Oum/43wbjgZ0SIZ+KEGIbCdtjOhSMr
	 FUXjnTnRGtvHA==
Date: Mon, 22 Sep 2025 18:22:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 02/20] net: Add peer to netdev_rx_queue
Message-ID: <20250922182207.1121556a@kernel.org>
In-Reply-To: <20250919213153.103606-3-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:35 +0200 Daniel Borkmann wrote:
> +static inline void netdev_rx_queue_peer(struct net_device *src_dev,
> +					struct netdev_rx_queue *src_rxq,
> +					struct netdev_rx_queue *dst_rxq)
> +{
> +	dev_hold(src_dev);

netdev_hold() is required for all new code

> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);

Also please avoid static inlines if you need to call a func from
another header. It complicates header dependencies.

