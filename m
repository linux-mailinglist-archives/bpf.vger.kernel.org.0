Return-Path: <bpf+bounces-65586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3719B257BF
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 01:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F596177FFF
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0181301481;
	Wed, 13 Aug 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa6iEQeo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2D2BD5B0;
	Wed, 13 Aug 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128929; cv=none; b=Xj3yfabvwUuD9cLLLEtyurNdMapuUtpR7msqQH+/c7wGcx9/RFHcriSuiwpahRw2OE9i8An4N25IROpipcSGMgMcHrwrlANPF/74puSf+9dx5A20EfGqS3Ay8Lfc67c1CN0wbW3O6X74rGQCqOnK09ifAuboqWuPmnjR27GIC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128929; c=relaxed/simple;
	bh=eS3xL90Y3tS+K19RMUEzHgxObEqUmzm3La4nnxzcm8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIyuJ3jcQs206ynbi6IVnoFjwLHpvnYJNvMPfvhvgLLI1EPeSsO3BeuqglTA4sT+JoToesl8dV3Il5qg1O5GmMrYu2qhE1txbC9wOYAHllPZjRFmw3sS79Rq39YYWc/LleZTpy7qxvvChCXB3xN+BfYW706aS5zb9yfteoUMJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa6iEQeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7433C4CEEB;
	Wed, 13 Aug 2025 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128928;
	bh=eS3xL90Y3tS+K19RMUEzHgxObEqUmzm3La4nnxzcm8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oa6iEQeodc92Y6V40cf92rpkiCb2j717T4lLJaGT2jz8XDaqm2ME3dHvfP6QIuNvJ
	 B5tFZHSsodpWrEWiY4V9OHSN2xSOARFMyTIzfarrknVwGE18ff47LlzzXGFAFFwWnD
	 B1FabfTrq/XcCIgcLPjvlQ3CEOowucksU53BrknlwV3od3SX1KtN7Y8+U1EduRRUW9
	 mbNquYKrcIhHQDHjs7zq58bz+CkR0mDPdmiDXar7KJG+M7VO4xZYasq1MHRC05Et0c
	 h2fyNvCtmu1O4sX3c5nhQKSxW9jUpc7xyfs2WPj8LVuYhTz1uHzDC1t9ijMDVY0CTs
	 qjfl/sKe6ZTKw==
Date: Wed, 13 Aug 2025 16:48:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: horms@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
 ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 shirazsaleem@microsoft.com, rosenp@gmail.com, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v4] net: mana: Use page pool fragments for RX
 buffers instead of full pages to improve memory efficiency.
Message-ID: <20250813164847.62ade421@kernel.org>
In-Reply-To: <20250811222919.GA25951@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250811222919.GA25951@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 15:29:19 -0700 Dipayaan Roy wrote:
> -	if (apc->port_is_up)
> +	if (apc->port_is_up) {
> +		/* Re-create rxq's after xdp prog was loaded or unloaded.
> +		 * Ex: re create rxq's to switch from full pages to smaller
> +		 * size page fragments when xdp prog is unloaded and
> +		 * vice-versa.
> +		 */
> +
> +		/* Pre-allocate buffers to prevent failure in mana_attach */
> +		err = mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD
> +			    (extack,
> +			    "XDP: Insufficient memory for tx/rx re-config");

This weird line breaking is not necessary, checkpatch understands that
string can go over line limit:

			NL_SET_ERR_MSG_MOD(extack,
					   "XDP: Insufficient memory for tx/rx re-config");

> +			return err;

I think you already replaced the bpf program at this point? 
So the allocation should happen earlier. On failure changes
to the driver state should be undone.
-- 
pw-bot: cr

