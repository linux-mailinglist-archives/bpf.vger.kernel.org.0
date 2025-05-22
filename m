Return-Path: <bpf+bounces-58770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD7AC1678
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 00:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373431B67250
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6126D4D3;
	Thu, 22 May 2025 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QayDC5Eg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193926B970;
	Thu, 22 May 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952028; cv=none; b=A+/v3Jf/REaegTvsegUzCLc7WEzxjhhe1jNW2iFI2GfEC4wlt2+GLtU4N53UQxuW9JfD9z7kdszeVbt6mkWrsx7wcfcRLDoR/Iu3NzMkY45n3OFkPjIujj1TxGTGeDetxSQzSSVAHYr62ISLGq3kj+GlCVCIqKkgbOPYJeQ9VGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952028; c=relaxed/simple;
	bh=0gNOwm+ixznGLcCYt/xPhR3d4d4LaGz5vTfy/hu3DeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgVEYI/itjKn/xWlQLfQ2NpPy/b2sc5xUjeITaPHSmdNzbF/28wKO7M1iYPDxII5+FZHj1LcfzqrOjZGjwE4ZvNg7/hYSxltcMNMuMllY2yWtoabaAmRcLnsQ+NaxLKOfKVktCOkXdWx6wV2KQJWGuNGxEqdfnJ6+NdV37l8uKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QayDC5Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE9C4CEF1;
	Thu, 22 May 2025 22:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747952028;
	bh=0gNOwm+ixznGLcCYt/xPhR3d4d4LaGz5vTfy/hu3DeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QayDC5EgTGqTHm0LyhLO+93nYto8xwaXxnmHWOcLfK9JGJs5wwNjDt8zRihB8Bsaf
	 WI0+IvnCEntuufcLV0Niu8z93wdydo3Lz1HcO7+x9qUBS7yFR9NMMhYoGnI0WF33Z4
	 Y2Okq3RJ/2dobr+h9w0/Y7z8G2WXPuv6s07o2aWzKNqx4zB2n6LgB8fhpKMm2v6fZZ
	 zWF9jyp1KxIi+4qsjfrTZAGcDwrZhufzJO5ICENGEeK/NhKfUhjnu8+LFOK3sZFkdx
	 0PjqtGz4RitRwfzkVSqXwcSgUIwwzKjhcSxt1zmR3w8JEmGNyU7S2vdAy7cyCplqqo
	 V6Gd3sU0/yn1g==
Date: Thu, 22 May 2025 15:13:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, kuniyu@amazon.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 ssengar@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH net,v2] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Message-ID: <20250522151346.57390f40@kernel.org>
In-Reply-To: <1747823103-3420-1-git-send-email-ssengar@linux.microsoft.com>
References: <1747823103-3420-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 03:25:03 -0700 Saurabh Sengar wrote:
> The MANA driver's probe registers netdevice via the following call chain:
> 
> mana_probe()
>   register_netdev()
>     register_netdevice()
> 
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
> 
> Further this netvsc notifier callback end up attempting to acquire the
> same lock again in dev_xdp_propagate() leading to deadlock.
> 
> netvsc_netdev_event()
>   netvsc_vf_setxdp()
>     dev_xdp_propagate()
> 
> This deadlock was not observed so far because net_shaper_ops was never set,

The lock is on the VF, I think you meant to say that no device you use
in Azure is ops locked?

There's also the call to netvsc_register_vf() on probe path, please
fix or explain why it doesn't need locking in the commit message.
-- 
pw-bot: cr

