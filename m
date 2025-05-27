Return-Path: <bpf+bounces-58999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3EFAC52AF
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 18:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2429E09BE
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0C27E7EB;
	Tue, 27 May 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0fgQBgQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4B269B08;
	Tue, 27 May 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362226; cv=none; b=FAqKumfRQxtdheTe2GMebgfENQ5+NAiRS4K50YBW+4kfzQVeGc1VuQk0OMCXC+0IjAUDPNc0K4YbF5QRKhHzbLDeX/ENfHCQUAqSTKYyqHJkqpdvBX5ugpTGr24quvtwBGPbs3D0hO87hVEcCY/VM89SXt2AHLa6qB4FqrcSOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362226; c=relaxed/simple;
	bh=L0a2IxCIeRqxZGEsyOFuSQpdCJEYvGEy+T/gO+GHS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts/6pU95A9IkgVvwjyDOmC2/L4bIOdZY/Hnou5g72pXz8lxuu0Q2g0jYasMnvxTc/1hX8n2PhoZEDkHy3v0b6V0glV62iG0+uHKfGfHUTfKW8wfCQRf97CnrJJOcL86eEVfJP28mpEMDa6qp7ayEktGarISRt23w4etfkwwHdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0fgQBgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA844C4CEE9;
	Tue, 27 May 2025 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748362225;
	bh=L0a2IxCIeRqxZGEsyOFuSQpdCJEYvGEy+T/gO+GHS8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0fgQBgQjNHnfAqa4fhCcy5yshCrXhruDaGYITxVhsVJEiMfATbNcRec88o3oFbfQ
	 L/Ipn372JPPWj0eF6brlcIvMcSKJZ6rJVbBJ7vnNO7U6HsqR86GpEJvHCEslR+B1a4
	 slHgMUlLK1XPUluaurEOUfSC4Kq9QgjyShNlgj0kn9R13VHf6ikyulI90exYUe/VgE
	 T+9++4YQ432cUtjVcUkHrNXuic7XLV/2wNpyMCU6Etk58rokI0NShYvvsbrUukr1rm
	 jiylE1ECg+Q61j9M5MdNZJ2/MMp23FvrHlw1qrsB+v8RURyQjR/038S+MAySx3Jh+q
	 ZhvzJrvPnErzQ==
Date: Tue, 27 May 2025 09:10:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <20250527091023.206faecb@kernel.org>
In-Reply-To: <aC-xAK0Unw2XE-2T@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
	<1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
	<20250522155518.47ab81d3@kernel.org>
	<aC-xAK0Unw2XE-2T@x130>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 16:19:28 -0700 Saeed Mahameed wrote:
> >Why are you modifying wanted_features? wanted_features is what
> >*user space* wanted! You should probably operate on hw_features ?
> >Tho, may be cleaner to return an error and an extack if the user
> >tries to set HDS and GRO to conflicting values.
> >  
> 
> hw_features is hw capabilities, it doesn't mean on/off.. so no we can't
> rely on that.
> 
> To enable TCP_DATA_SPLIT we tie it to GRO_HW, so we enable GRO_HW when
> TCP_DATA_SPLIT is set to on and vise-versa. I agree not the cleanest.. 
> But it is good for user-visibility as you would see both ON if you query
> from user, which is the actual state. This is the only way to set HW_GRO
> to on by driver and not lose previous state when we turn the other bit
> on/off.

   features = on
hw_features = off

is how we indicate the feature is "on [fixed]"
Tho, I'm not sure how much precedent there is for making things fixed
at runtime.

