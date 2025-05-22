Return-Path: <bpf+bounces-58776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C247AC1712
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458B21C03A84
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F39C2BF3ED;
	Thu, 22 May 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYr9wFya"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867F255254;
	Thu, 22 May 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747954723; cv=none; b=VWVEt1J9nILq/hkqwzHf0cPID8KSUoCyxyWB829JDADMCthFAnXKM/zH029otu9ZlUh7LxGH4A1ma1A2DqA4vpWYvkLbMwWTCLWJ79yiUOar+d5hBm1DhEfVj1uevXVsTQZ1judww7oRoq/MGufkQ8bwMKzroH8/Uf9k+TVP1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747954723; c=relaxed/simple;
	bh=KTiV8wuINpXZm6lLxrZSb5n0npuwWT2t97gkmUDPrVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiUdLPdFj02RI7MCe66Py2qBdZXu/7H7RH0hR9u7HvGxlEyUNqyJDcd5ue5kQTaHcF2k2iQMCcU6DPl560mrlYcu5X1Ke19NwChpDfOpUCtzNtqqI6qbUCWZ2N7Oy4y6vQauTdTeksvxU4R8BB7JjONIL6YkrNF58YLHADcsJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYr9wFya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D700FC4CEE4;
	Thu, 22 May 2025 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747954722;
	bh=KTiV8wuINpXZm6lLxrZSb5n0npuwWT2t97gkmUDPrVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYr9wFyawOzd/VX/wU0oMKV25Yrhy6EhoASVUZbXMM79r2IaIEV9iOexaCR52hCNL
	 n4S7b3NJWp2facJ6V20XZDF+9A/K7t7BSUYHtH8U5NZzTUifLpUD0HCG8Q9XSm8Qnm
	 u6e3tdRdERNZjtHxsP+oXyv0XsNLO1gYtBypJ0FMELzQJJiMghYHGVjCc0Mo/eufCb
	 dJlvIaSMw8NFxR8xJCks8SXYZG1xdJi9DWiajLgzlmKC9hDf934iROpYOtEnUZyc7Y
	 KKbaO8rsDuAunRLGE95O+cMZAEvrvPJxzna3Gr29gNzjnrbZ3GQmY1uXrd5L1ND2fK
	 Xaqxndk1ZI59A==
Date: Thu, 22 May 2025 15:58:41 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
Message-ID: <aC-sIWriYzWbQSxc@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
 <20250522153142.11f329d3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522153142.11f329d3@kernel.org>

On 22 May 15:31, Jakub Kicinski wrote:
>On Fri, 23 May 2025 00:41:22 +0300 Tariq Toukan wrote:
>> Expose the stats of the new headers page pool.
>
>Nope. We have a netlink API for page pool stats.
>

We already expose the stats of the main pool in ethtool.
So it will be an inconvenience to keep exposing half of the stats.
So either we delete both or keep both. Some of us rely on this for debug


