Return-Path: <bpf+bounces-68653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E24B7ED99
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E245416D6C1
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69BB3161A8;
	Wed, 17 Sep 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShOaqYbb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BF31619D;
	Wed, 17 Sep 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113632; cv=none; b=JWlfvvttPZBjMCSnFjWfZYcnZHiZ9NwGKm2/mc0L8lUbD/vHiferV0Eu1zCgMcd7ExFTG5P4p0ZqJdRcUtALfMRgZMGTGyZRg7gQspM5yzQRxiOjD7A9YDWcJtNMyGQUKiE0iQN4LGds+yAgwvyz8Ux/lm44WIf6BUaLMu4Sc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113632; c=relaxed/simple;
	bh=AYqrijFFPyOg6oTn1oHffDdanbDNoSAhEnePUl8ItdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da5oix5aFpf/AfDvkZzDs+ZCGvqe3mflGUekhYOdEs19kbepz4dInrE2LkL69CmA3Ndbn7+S7zBtxt6HO+8ux3PXDp63BMF8EyvtTrgRBb3RRzx2lJVaXKRnQ+SmZs0517P0OPB4f9ZlPLZVoGlX+ZlwjKja4d+622x6GSRaj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShOaqYbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E8BC4CEF0;
	Wed, 17 Sep 2025 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113631;
	bh=AYqrijFFPyOg6oTn1oHffDdanbDNoSAhEnePUl8ItdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShOaqYbbqmk5e5akA4q2e2Xkei7t3KSsGI2knYNQKz/8gHiYse+MUUyjwpyHzQ5+N
	 9fSUp9EJFwQWbo9WljLYcvAsRbQWcHpRSUCM5MK+/AA+F2c3y6H9bgPMBryfsdjnCM
	 87oy58EyxolShT+x7iQy5LDZuqFv0dsKM9nwNeX4VMs85evwAF/VI81irLx++AUp1K
	 PgzdNd9fK9UlM3t+yTzyTArNeOWeTe+4HbFW3v/UOsX9nflfMHl1raVDWS3Bb/Dhv0
	 fbEJ3o8qHf0ijqOznZ0jUwEVeRKTyaOSSfQ2NIrdhDAZgfkkoQvq0MQBp4kvkgIbQA
	 CRqWn0aZJHLfg==
Date: Wed, 17 Sep 2025 13:53:45 +0100
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
Subject: Re: [PATCH net-next V2 03/10] net/mlx5e: Remove unused 'xsk' param
 of mlx5e_build_xdpsq_param
Message-ID: <20250917125345.GD394836@horms.kernel.org>
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
 <1758031904-634231-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758031904-634231-4-git-send-email-tariqt@nvidia.com>

On Tue, Sep 16, 2025 at 05:11:37PM +0300, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> This was added in commit [1], but its only use removed in commit [2].
> The parameter is unused, so remove it from the function parameter list.
> 
> [1] commit 9ded70fa1d81 ("net/mlx5e: Don't prefill WQEs in XDP SQ in the
> multi buffer mode")
> [2] commit 1a9304859b3a ("net/mlx5: XDP, Enable TX side XDP multi-buffer
> support")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


