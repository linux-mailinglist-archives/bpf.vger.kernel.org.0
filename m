Return-Path: <bpf+bounces-68655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D83B7ED96
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC56A520DAE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4510F328970;
	Wed, 17 Sep 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc+k6k0Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8431960C;
	Wed, 17 Sep 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113670; cv=none; b=Oy4kyToJpeeCS6TTf4+cz1ANel0/Q3HrlGzFoIVXC97Tv5gSc/n926j2yQBCEUp1cLv10b1UR3bTuwinmFdmhpk1NBb9mhqZgwUDLn+DhY5xpjKsdXhXq4+DIs6N6WRVKGBt8u/8INJu4yuFaQgEJgBmN7uokR7a5S+9i2QfOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113670; c=relaxed/simple;
	bh=sVMnZ/XoaVF8BFfXwYscb7C1MtSGlVlOGFmPHaCYVWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK01uIl0qbRRuw9Cc6t3w3QJ/4P9+HX6FbfXvTLaEIKY2m9vPkx6I8mX33TmAhNv2xPmU4cCUlb99SWNq4ZLEwqdJmWo4ecwaX7Csqe8PZIEJrFYpfXqzLOCNboAFB51kXB0rK6l4aQYnVnkgGZoev47fUIp+bbNxziyPyrWJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc+k6k0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91B1C4CEF5;
	Wed, 17 Sep 2025 12:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113670;
	bh=sVMnZ/XoaVF8BFfXwYscb7C1MtSGlVlOGFmPHaCYVWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uc+k6k0YFjZ75VNnNMDb4iMV60bSzPazda22/it2KlfvzclSAhbcHwFwHNgRNyaXn
	 qeOM8vF5G/yYI8BDNvoDnnfN1u7Op0x2pVORNn3RffDo7/3f5Oe7uOBEKgJJtzdP9L
	 7+oLn+1U4Qkttc+v7bXhFfotCAbvx6vyJBNUdaWRwzLFtSrVkt1gUKig/y6sNZkx/m
	 QJ1zXDh/zmwmyVrTB0FU2V0/xkk5QwcDz9MRzsz7ni5MVs7R+R2l9Y42GY6he8H5+2
	 vx8I0RabvwdwnNzkiqT/EizqlzNRzX2SCSZhO7W9JhNc35F8A37z77mepfnA3Ogoxw
	 OyU4m27kMilPw==
Date: Wed, 17 Sep 2025 13:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next V2 05/10] net/mlx5e: Prepare for using multiple
 TX doorbells
Message-ID: <20250917125423.GF394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-6-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:39PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The driver allocates a single doorbell per device and uses
> it for all Send Queues (SQs). This can become a bottleneck due to the
> high number of concurrent MMIO accesses when ringing the same doorbell
> from many channels.
> 
> This patch makes the doorbells used by channel queues configurable.
> 
> mlx5e_channel_pick_doorbell() is added to select the doorbell to be used
> for a given channel, picking the default for now.
> 
> When opening a channel, the selected doorbell is saved to the channel
> struct and used whenever channel-related queues are created.
> 
> Finally, 'uar_page' is added to 'struct mlx5e_create_sq_param' to
> control which doorbell to use when allocating an SQ, since that can
> happen outside channel context (e.g. for PTP).
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


