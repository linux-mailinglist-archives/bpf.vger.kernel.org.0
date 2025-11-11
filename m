Return-Path: <bpf+bounces-74121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D87C4B075
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172F2189A4A2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9993446A6;
	Tue, 11 Nov 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebYWnhNi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1DF344053;
	Tue, 11 Nov 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825259; cv=none; b=jUbNEfEXPvcsil1CsnLZW9/Ud1QyoXcg9ShOjy4dd92LR44nDTyZa7J0bbmObdP6gMZb/yt8UT4wFAx2EYozeNFeCPSGFZwG7wVwU5i3gNBGcfteuhQrIzQrkrNJH4wOP3av4yFHaRtnfpskIztVHPufKdMOnqJK4mML2TxQjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825259; c=relaxed/simple;
	bh=ZIm9XbZ9W1CLRLoDy9w3geovw4axzNSnEqRBpsUGwcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rf0wLxqZm275I8f0ySV+nm7JuHVtWVCdmFzFMejv42YGm2hwpDdfpPDBcy/EP6eAu/3sZOK0dRFAy/5Kagq8Jc11HjgHEg0oVtLM5aQoW6MGpkx3amHYqk9yAIIL3Rix2W7PC0KZo/Pzn9uMRnE1fq4PcWvkpIjwpINpOmnZW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebYWnhNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF94BC4CEFB;
	Tue, 11 Nov 2025 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762825259;
	bh=ZIm9XbZ9W1CLRLoDy9w3geovw4axzNSnEqRBpsUGwcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebYWnhNi6arXli903Dgwz6oY6yKe5dSR148MI9JQ+CvRxMceDQrOykubyLnVJvga4
	 ZLQBaXTdM1W6Vk45BUiP+VVL3C0/lwhXENMCCrnaP9ISGVV3AuX42gU5x5Bt8KhrwY
	 szeioTQKiGmUvZUWQHOyejt/yjMQdVdiSXrK1W/lnkiaoQHzk6fdMnhhfRwvBFphBo
	 oI3l7S/GHkBVAMiN2NbQTz4uGQEHGKX2gW/XHKXMFvkc0prMlSsW6eSLOKHDte0U2h
	 lfM7iHlkTP9BqpPMS1RlGYB2PyH/+wGKd60wbBPqb5K4/QssM9ofbE9P0AtUWrCbRD
	 27laI+0QAybpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE729380CFD7;
	Tue, 11 Nov 2025 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] gve: Improve RX buffer length management
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282522924.2843765.11992898311639277599.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:40:29 +0000
References: <20251106192746.243525-1-joshwash@google.com>
In-Reply-To: <20251106192746.243525-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com,
 pkaligineedi@google.com, ziweixiao@google.com, jfraker@google.com,
 linux@treblig.org, nktgrg@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 11:27:42 -0800 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> This patch series improves the management of the RX buffer length for
> the DQO queue format in the gve driver. The goal is to make RX buffer
> length config more explicit, easy to change, and performant by default.
> 
> We accomplish that in four patches:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] gve: Decouple header split from RX buffer length
    https://git.kernel.org/netdev/net-next/c/40fef85ceb9c
  - [net-next,v3,2/4] gve: Use extack to log xdp config verification errors
    https://git.kernel.org/netdev/net-next/c/091a3b6ff2b9
  - [net-next,v3,3/4] gve: Allow ethtool to configure rx_buf_len
    https://git.kernel.org/netdev/net-next/c/d235bb213f41
  - [net-next,v3,4/4] gve: Default to max_rx_buffer_size for DQO if device supported
    https://git.kernel.org/netdev/net-next/c/09a81a0f4fb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



