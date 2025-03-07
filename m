Return-Path: <bpf+bounces-53522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC2A55CC5
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 02:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FA2188469F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A041487DD;
	Fri,  7 Mar 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M45pXKE9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425213D89D;
	Fri,  7 Mar 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309931; cv=none; b=Nv5MSQs1oKW433uzyZi+jwcbxK8b29U85LbflSJjT+E/Dki/MqCjhinCZzWNWT2m+1nDjyue2MmGGd1TNUZv3A8PRWKP17XmWN/4pOZmBbmHoOP4jF6GBBJ+aI+jjqiAueYm2GCBWPk4NYt9cucq5xYKm7I2HzNsjwqo1VP4aMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309931; c=relaxed/simple;
	bh=iAkkgLRwGib7vQ+FD30A942Pd09V5NCtDsEeMhpAUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvQe3JOIPxxJ+AWIHFfwMObQzuCCK1FVRO1icHmXpRsTPpxue2PdCKGjdYGwhswiTwmr8M2KEdLAxeC+5inW7/IJkUfgujKiWV2/JgcVChBcs1NPLajwH3t3OqnF7AiWqES2NUdSe8xJwhVD1apUdGRBhrmaBqooJpHcpafPdD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M45pXKE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030B9C4CEE0;
	Fri,  7 Mar 2025 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309929;
	bh=iAkkgLRwGib7vQ+FD30A942Pd09V5NCtDsEeMhpAUqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M45pXKE9zkU9gssiyoTXRtcCF8zxbGnEPxAzZgZxm2OqPKSreW0X3H5MGGZLMMfHK
	 OStf429IO4RVa+Qkqg54dpGCfKVeYYobcgRrckZsKfbuASUxX0OTzSOfL9jEDJ4djg
	 ndQWb8LBx9QltWQZlFB6VM83sQmBC163rVLR7DIGuhcHqf2LE4F8IIU3C/DCIUWOhT
	 KqMzL1REFctMOmR7oJ/4JyRqaH0bjzCgFsDFm4YrIhhTL2G9TYZtz9utBUorEfddfw
	 O9D16dCJHua+bv9bvT0tWtvLVHJ/FqnHTwip6ANCaUK47B8nTiiqEI4OFUTddfWPYb
	 tlIA+06s+XYMg==
Date: Thu, 6 Mar 2025 17:12:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak
 <michal.kubiak@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/16] idpf: prepare structures to support XDP
Message-ID: <20250306171208.3162eb97@kernel.org>
In-Reply-To: <20250305162132.1106080-12-aleksander.lobakin@intel.com>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
	<20250305162132.1106080-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 17:21:27 +0100 Alexander Lobakin wrote:
> +/**
> + * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
> + * @vport: vport to check
> + */
> +static inline bool idpf_xdp_is_prog_ena(const struct idpf_vport *vport)
> +{
> +	return vport->adapter && vport->xdp_prog;
> +}

drivers/net/ethernet/intel/idpf/idpf.h:624: warning: No description found for return value of 'idpf_xdp_is_prog_ena'

The documentation doesn't add much info, just remove it ?
-- 
pw-bot: cr

