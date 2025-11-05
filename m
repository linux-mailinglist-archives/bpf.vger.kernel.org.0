Return-Path: <bpf+bounces-73567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E16C33DEB
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 04:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C0574F724C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3426F29C;
	Wed,  5 Nov 2025 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVxLOWa9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665023EAA1;
	Wed,  5 Nov 2025 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314051; cv=none; b=utDybDBRS9IrsWz0I72U2hH70AyDq4wjwZjsZcpFIBQgjvPql2xjkRWVqTzA83ZQB2QGysNXAktP8jyOWqD21uUzvZ6NnEDNJJjvarhZYCpeHyxeoiIPzQiYppsg/LqCsrJfEhIAIoB/4u1So09oA3jXYjLly3FTVTfqvA5h3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314051; c=relaxed/simple;
	bh=2k3J/gPApTJLYu+iz2ZFD0TSO6+5oXGGk1HB+Ih+rHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=esA0F2ipr66loATHjmtRiRV/K6tP0eGtaEiiaShdK4rpWTj0ZdoTGwfgiyxCXnpsiZ4j7zq15pg/XFYeq6XS6p+Wpw+3AEjtErPlnouOrxOEOtvezRcSGqVErB6R7Dhj60tumRGYsyA5jUAEEKZ7oAUHO9Su/jqOO6MqCG0WX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVxLOWa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022FEC116B1;
	Wed,  5 Nov 2025 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762314051;
	bh=2k3J/gPApTJLYu+iz2ZFD0TSO6+5oXGGk1HB+Ih+rHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVxLOWa99zfJDN8DYVrb7Y54aoN8b4ymIEnxcgFgKJ6zhsIBeUthHpcU/nwKSmGia
	 GJeKhWSs93XBmDon7sp24OUU2S1qMT6WVw+xTYfpzcjUF73UXnlVE7PhRfzdXtHaja
	 yOkoXxGuibQqnQ5qNhDC+tQcW5ZcodiYOmdz/0kLPr/qFwBrUTL5NxRHzQET2TEIRa
	 Pac5GBF3VK/M+Q6gi24VUaXPYyF7Yv3Md9oMdKD0FQeu4pk3RSgGBCNkpis4570d4z
	 LKx0bUogxoJZDqKL48WDqTdmenU0iqGUK5D/lWhlIVHPtQl/VrbqT+yrGjxIdbiXVZ
	 hj5nUcDehzRpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEBE380AA57;
	Wed,  5 Nov 2025 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/8] net: Introduce struct sockaddr_unsized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176231402373.3077655.16398721190198880178.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 03:40:23 +0000
References: <20251104002608.do.383-kees@kernel.org>
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: pabeni@redhat.com, kuba@kernel.org, gustavo@embeddedor.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 16:26:08 -0800 you wrote:
> Hi!
> 
>  v5: rebase and actually pick CORRECT base...
>  v4: https://lore.kernel.org/all/20251029214355.work.602-kees@kernel.org/
>  v3: https://lore.kernel.org/all/20251020212125.make.115-kees@kernel.org/
>  v2: https://lore.kernel.org/all/20251014223349.it.173-kees@kernel.org/
>  v1: https://lore.kernel.org/all/20250723230354.work.571-kees@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/8] net: Add struct sockaddr_unsized for sockaddr of unknown length
    https://git.kernel.org/netdev/net-next/c/bf33247a90d3
  - [net-next,v5,2/8] net: Convert proto_ops bind() callbacks to use sockaddr_unsized
    https://git.kernel.org/netdev/net-next/c/0e50474fa514
  - [net-next,v5,3/8] net: Convert proto_ops connect() callbacks to use sockaddr_unsized
    https://git.kernel.org/netdev/net-next/c/85cb0757d7e1
  - [net-next,v5,4/8] net: Remove struct sockaddr from net.h
    https://git.kernel.org/netdev/net-next/c/3d39d34146f2
  - [net-next,v5,5/8] net: Convert proto callbacks from sockaddr to sockaddr_unsized
    https://git.kernel.org/netdev/net-next/c/449f68f8fffa
  - [net-next,v5,6/8] bpf: Convert cgroup sockaddr filters to use sockaddr_unsized consistently
    https://git.kernel.org/netdev/net-next/c/8116d803e7f8
  - [net-next,v5,7/8] bpf: Convert bpf_sock_addr_kern "uaddr" to sockaddr_unsized
    https://git.kernel.org/netdev/net-next/c/c1a799eef62b
  - [net-next,v5,8/8] net: Convert struct sockaddr to fixed-size "sa_data[14]"
    https://git.kernel.org/netdev/net-next/c/2b5e9f9b7e41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



