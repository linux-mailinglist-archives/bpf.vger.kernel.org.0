Return-Path: <bpf+bounces-37950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596195CDE1
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7341F24CEC
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3403188599;
	Fri, 23 Aug 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poN9uNTi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEB18661A;
	Fri, 23 Aug 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419828; cv=none; b=SvT25IbzqBYDRJxSu+03hmIpb7Y0wi6l5KhWqpo06lKI6/aXi+4XVeLWxWjkn9/YwnVXKvquhkZQQI+/sCNEAy/h0CZ0bNamiXT/AZG6o7HMaQzYERz/hdXHbTgs97fuwEfBCPAS0SR4frDsESfzq8bxX5VMao41kybx654MqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419828; c=relaxed/simple;
	bh=bkdymBfFZ9rhDAJVOm/k+8cplSbx+iwX219268UINok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=res1Tj1+Kx5JM22UJ5zGU5N+Q0BK6UwVARPyfcFrqjPi4HNyeit5pR11ZiwiDdtBj2fcUeOdy9rih21Ea2Z4UKe5uClL5u4O08Hf0znd+yNvNfWvvxQE/nantJrrDIrRPjuW29OU8L5MZt56ZNZmn2cv3i0FhmDqG2JQMtkmOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poN9uNTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06948C32786;
	Fri, 23 Aug 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724419828;
	bh=bkdymBfFZ9rhDAJVOm/k+8cplSbx+iwX219268UINok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=poN9uNTiF3mTKwIyilRVUOgWSdN9z/xCHEQBkBVHQ2L1LhCHHY9qZ7YwsO177MXVj
	 A710ywkQA4JjxbCgTAkJ/QSQ5Gsvcc7hYM/mqKPhqAp/a/aWB7XcvrpSL0pz5VZDwe
	 IDsROTq6aoyAfm/RlSg3UtwklxthSBMLfNY9TR7i6IsTnLa1jZglIbAeNm6H/MyLBA
	 DXzToauyonVu8C/aE9E35AVPyexsNj3nj6k51N41Hz20o2CMFp1x1uZZZD3kVOjwRr
	 C0i+1uxi65y3xK0DQBtX79u8l4sLjLOCgze/tq6LqldfXFWyMGuZALgeGJS3R6fdSR
	 6Bso7zXzqUs+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFAE3804CB0;
	Fri, 23 Aug 2024 13:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc
 response
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172441982778.2965533.12833287131080058770.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 13:30:27 +0000
References: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 21 Aug 2024 13:42:29 -0700 you wrote:
> The mana_hwc_rx_event_handler() / mana_hwc_handle_resp() calls
> complete(&ctx->comp_event) before posting the wqe back. It's
> possible that other callers, like mana_create_txq(), start the
> next round of mana_hwc_send_request() before the posting of wqe.
> And if the HW is fast enough to respond, it can hit no_wqe error
> on the HW channel, then the response message is lost. The mana
> driver may fail to create queues and open, because of waiting for
> the HW response and timed out.
> Sample dmesg:
> [  528.610840] mana 39d4:00:02.0: HWC: Request timed out!
> [  528.614452] mana 39d4:00:02.0: Failed to send mana message: -110, 0x0
> [  528.618326] mana 39d4:00:02.0 enP14804s2: Failed to create WQ object: -110
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response
    https://git.kernel.org/netdev/net/c/8af174ea863c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



