Return-Path: <bpf+bounces-39884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217B978CEC
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FB11F259E1
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A014A90;
	Sat, 14 Sep 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bykdCWQ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72414168B7;
	Sat, 14 Sep 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282828; cv=none; b=R9BSw2qbwDTEQiZJ0tm/YpynyS5CONIHfbmDBgf7RgHbQ15XlMpBIUhwAyzOy1xUDNt/rwM2gtkf7Rzp7lPN0Rj07mDcuSZ3x4qlpaYg7QpKF9wzMf48tNogRFIxbUATVBWjZ1i+s59tCSGltUHOD5ghE18XA0YxGPRxR362aVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282828; c=relaxed/simple;
	bh=aiYZ1MG2GRMcyZjT/bTHZi/vKPgJxEab5GgBYsIlZdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JEPgidI6wT4sa1m3BgZU/sz4eDscDXWXrn+0vmBedFdoRe0D/NVlYdtP/ex6l8Akk4PVP8UTxjuOaZNtUu0bSFICO6BF0HMjQGQuodIjkvjBwmBq1DYUoaCK4EAHDgkaxD6+7bH+Jti7coPhwJJP3yITJS8AmN5JSm9qXu0zMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bykdCWQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C5EC4CEC0;
	Sat, 14 Sep 2024 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726282828;
	bh=aiYZ1MG2GRMcyZjT/bTHZi/vKPgJxEab5GgBYsIlZdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bykdCWQ/5HB+PUudUy60oL72mseFpHu12iC8RYpXmEA2vsjJ4rmxSpfLAMVeJ50cc
	 zAa6bPCmgy/UH7pSGkM2+mc5me/v7p0zVmP3tweF6+9HYwCs03Ycc+Y2naq0EkBYZF
	 ZeJJ4DN6rS1bdmYzlPlXYxacYwqY2U6RAXqVtg44x/KdoH3CbfjlIibsSpxs+IzToT
	 ou73bupaAjDQ9qTQJGw0fowRlmSFTEi/DmrruKbbgOxQODAiBBWZ9Ixqo7VOOAdQuT
	 24iI/+iZtN8b9k5JUTOoipmUhcuc+9JqVgt7K2aBfw1hNKTghQva8mwZJlPodzwaad
	 nQYTjff7BDNTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713F53806655;
	Sat, 14 Sep 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628282927.2435669.7391476062260025930.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:00:29 +0000
References: <20240912155620.1334587-1-leitao@debian.org>
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, toke@redhat.com, hawk@kernel.org,
 bigeasy@linutronix.de, vadim.fedorenko@linux.dev, andrii@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 08:56:19 -0700 you wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
> 
> [...]

Here is the summary with links:
  - [net] netkit: Assign missing bpf_net_context
    https://git.kernel.org/netdev/net/c/157f29152b61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



