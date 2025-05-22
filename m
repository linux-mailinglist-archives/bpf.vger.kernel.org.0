Return-Path: <bpf+bounces-58738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F881AC1109
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C481C0093C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEC28C875;
	Thu, 22 May 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6TVzgvA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57623C510;
	Thu, 22 May 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931402; cv=none; b=ucjagqH4u6pgM5msf9vjbmEFWvpjuH+RTCP8Y6NzhEO5wXeX68cypzWO6hnb68WyTv8uTF5b65+cScOZeiMS0020/ufFfX1etuqEjmoyW4gc9yE+fj0ARv6oN16gg207rUq5+tsFyEEIC6TqL80PRJt4Kyzc+nogwZhUzO1UI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931402; c=relaxed/simple;
	bh=QauHD26f0xVLSJ2R78w8tIAsbID5M+Dr2BROMlraE/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iabQ4+ySi5TZsBb7Nc/FW/abgMtYRAvsw14wzyDzSuSBqyz5hiNt6PnC/MnD/yxedbLh4WhWKDQPMvbD3lUji5w4w3n9CnfjPS1JxpkAWP/g1E2GcttU4UCZ7jHP8FUjCus67gUWX3vi4l+jHk7AfY+ipOtqrnOgrD+6lM6s7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6TVzgvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B38C4CEE4;
	Thu, 22 May 2025 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931401;
	bh=QauHD26f0xVLSJ2R78w8tIAsbID5M+Dr2BROMlraE/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V6TVzgvAVW7k4qchP56bP0HtsYvO1J/m4eA/vIA4PFum5z/HSdgPM3XVJ6STN88Hc
	 GlLM6ZcGcyajLLz6y11aG7bsuTyodV7xQzYkZE37WbovUNUAp3tqWBfm70FWcaFe3Q
	 BSs68FjZcJSyc5w9DLLjW7dEwRZyQWyaxttMG0VENubzpfnq1sPWublTirIaORJBVA
	 gJjaF7p1MhwetcY9S+gAIu/1fGzUQhKhiUVPKQmS0G9zcS8ypFWzs9Xl2AwqYjIFLU
	 vw+m/5HeIhR+fyi5qaOHiU5SjMZylvqYzHqnBKZ4x+0wbLvVtIWMrbb9VuR0zkt6nC
	 1dY/RtsftCopQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710DD3805D89;
	Thu, 22 May 2025 16:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/mlx5: Convert mlx5 to netdev instance
 locking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174793143726.2938999.16490486121028128951.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 16:30:37 +0000
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 saeedm@nvidia.com, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, moshe@nvidia.com,
 mbloch@nvidia.com, gal@nvidia.com, cratiu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 May 2025 15:08:57 +0300 you wrote:
> Hi,
> 
> This series by Cosmin converts mlx5 to use the recently added netdev
> instance locking scheme.
> 
> Find detailed description by Cosmin below [1].
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] IB/IPoIB: Enqueue separate work_structs for each flushed interface
    https://git.kernel.org/netdev/net-next/c/5f85120e7462
  - [net-next,2/5] IB/IPoIB: Replace vlan_rwsem with the netdev instance lock
    https://git.kernel.org/netdev/net-next/c/463e51769697
  - [net-next,3/5] IB/IPoIB: Allow using netdevs that require the instance lock
    https://git.kernel.org/netdev/net-next/c/fd07ba1680ba
  - [net-next,4/5] net/mlx5e: Don't drop RTNL during firmware flash
    https://git.kernel.org/netdev/net-next/c/d7d4f9f7365a
  - [net-next,5/5] net/mlx5e: Convert mlx5 netdevs to instance locking
    https://git.kernel.org/netdev/net-next/c/8f7b00307bf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



