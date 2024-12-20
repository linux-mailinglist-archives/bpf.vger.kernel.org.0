Return-Path: <bpf+bounces-47388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB339F8ACF
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 05:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D4B16B75D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 04:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422313D53B;
	Fri, 20 Dec 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StmbYoDV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C16F073;
	Fri, 20 Dec 2024 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667219; cv=none; b=G4RyuzM4vreW0RYe/UTJYytIvvHlus5mGxvNWjyTBmGOyV4SDx8ZiIgaYKNs2PE4Mj6EK04vxDG3Jmn6/T6XBtkMnUhnwMMuXbRUFN9hItYn1SWtyxcWxZS3KMsD8CaPNHHkuyJqAD/51yQ+/HRrr/Io239XQk4NWZg/RWdmzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667219; c=relaxed/simple;
	bh=rTnpdSUeWtBzWEOGceVMofkudgLJ9uiqKEpqOWdOYjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J5oX/ahOxojtTfNy5d17zfwG+9jn3U9uD8DvFb7XSe6Nkm4zIN8xycL/9yG6glNt0ZQIbgslmSaO0esN6Cq/5+Y8dG+tNt9h901RjaKZ8cpaa3S+6kDfZtI2BcMl5HcF1GW6Z2DCWVfGwX4E3Zy6cG1UO4wecNxMDjPK9nCVd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StmbYoDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A754C4CECD;
	Fri, 20 Dec 2024 04:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734667218;
	bh=rTnpdSUeWtBzWEOGceVMofkudgLJ9uiqKEpqOWdOYjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=StmbYoDVSTN/gdtu5TfXyVEFBL2GQXFu/QVEr7FDxhBE2d15rtmljyHSOYoMuaCI7
	 bwXTeCIxdc+/V+9kA4jL4nF93L/Xs5EAXZSbwJ9hN2/6W3/Emgn+d0gJ6z+GUD6XTf
	 P1sjc+1nKc5tDPwaZ3DneIKvreTEBgkhT4QcXO8VshDVKMCDAG/zLu3BK74WoktmuR
	 p9Kt2dZw0Vbs8Y3jMNOU2Cpd7GCYWp/fFJesqNAorrwK479vPJwXfzOSH9xTk+9Qnr
	 hs6i2kbWp3UQcSi80p8BenqGEz/8JcD4LWU5bFsleylnAnGcW3bbJ3xSmsZ9PvMt2n
	 twBnZBJslUoqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7117D3806656;
	Fri, 20 Dec 2024 04:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] xdp: a fistful of generic changes pt. III
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466723626.2467402.11977533281368650113.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 04:00:36 +0000
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
In-Reply-To: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, jose.marchesi@oracle.com,
 toke@redhat.com, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 przemyslaw.kitszel@intel.com, jbaron@akamai.com, casey@schaufler-ca.com,
 nathan@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 18:44:28 +0100 you wrote:
> XDP for idpf is currently 5.(6) chapters:
> * convert Rx to libeth;
> * convert Tx and stats to libeth;
> * generic XDP and XSk code changes;
> * generic XDP and XSk code additions pt. 1;
> * generic XDP and XSk code additions pt. 2 (you are here);
> * actual XDP for idpf via new libeth_xdp;
> * XSk for idpf (via ^).
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] page_pool: add page_pool_dev_alloc_netmem()
    https://git.kernel.org/netdev/net-next/c/a19d0236f466
  - [net-next,2/7] xdp: add generic xdp_buff_add_frag()
    https://git.kernel.org/netdev/net-next/c/68ddc8ae1768
  - [net-next,3/7] xdp: add generic xdp_build_skb_from_buff()
    https://git.kernel.org/netdev/net-next/c/539c1fba1ac7
  - [net-next,4/7] xsk: make xsk_buff_add_frag() really add the frag via __xdp_buff_add_frag()
    (no matching commit)
  - [net-next,5/7] xsk: add generic XSk &xdp_buff -> skb conversion
    https://git.kernel.org/netdev/net-next/c/560d958c6c68
  - [net-next,6/7] xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
    (no matching commit)
  - [net-next,7/7] unroll: add generic loop unroll helpers
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



