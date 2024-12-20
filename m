Return-Path: <bpf+bounces-47444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747CE9F9798
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE683188C107
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6DD21A44E;
	Fri, 20 Dec 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBErDNdN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD1A1853;
	Fri, 20 Dec 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714634; cv=none; b=JU/BO37hTQKgTjr3mDifBkaCtwY70zXGrEMT8klPVWG+BT2hOkiNapZgeXKVJYltDTWOMQpFA7tGoG+UfkPpi2vx85VzWznQyfmpb7UsCBx0XximCbicXlChcCa/5vX6CxLRERFk3haGE5iUJUudyKIdB7LqLASiTjFn0j2Ggkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714634; c=relaxed/simple;
	bh=iRB3aKJv5G523s1zwbwd4wwS2L1EKgPok+Q/Vt7ZDUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/XJbCuXDX/AMzO00LVgQQ9uuZiC+qMHQ37mp2H6IIHPhmWakWF+UexT7qXVR4qJ18T+KADnDUVUCekKpl+ArE5ZizI30iGBV8/sgSUiBGILgpGmBMwdsnI+iZq47xNMI50xKSDXpqXr8TabPmCHcMPQpEsFx6HVEFTo6CMATr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBErDNdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C1C4CECD;
	Fri, 20 Dec 2024 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714633;
	bh=iRB3aKJv5G523s1zwbwd4wwS2L1EKgPok+Q/Vt7ZDUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cBErDNdNHqgXSEkQ19BHXGcR4ARks1fbajzHIQJ/B4Ccpw/CIt08RNKwHx3nsSBM/
	 d0caMrFB7kQ93Mh1DBFlgekQcfc/El6qzV1xb92CWyifub5B8nON5XVpDgISHwsWf4
	 JHQytkyKwCZb4xe5mPUylVlWeS2gbyhNDM+MK1tYDaspqS4II1p7Axi++HSYv1rYIf
	 m9KZtBDwhBV8m4M9LnZrym4zi4IjAd0JmLjgN6+EFbQVQsMnyIKDUanAg8wkDDv6cK
	 +rOLEjkC2ymyFNUuUqv8DHVFqq6kCvJ4LuhSx42LVV/n7jI4JcYwAWtgrJaHIhPhDa
	 tay51HuTqw/uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2513806656;
	Fri, 20 Dec 2024 17:10:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf 0/2] tcp_bpf: update the rmem scheduling for 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173471465149.2963436.10634845833925071160.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 17:10:51 +0000
References: <20241210012039.1669389-1-zijianzhang@bytedance.com>
In-Reply-To: <20241210012039.1669389-1-zijianzhang@bytedance.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 10 Dec 2024 01:20:37 +0000 you wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We should do sk_rmem_schedule instead of sk_wmem_schedule in function
> bpf_tcp_ingress. We also need to update sk_rmem_alloc in bpf_tcp_ingress
> accordingly to account for the rmem.
> 
> v2:
>   - Update the commit message to indicate the reason for msg->skb check
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()
    https://git.kernel.org/bpf/bpf/c/54f89b3178d5
  - [v2,bpf,2/2] tcp_bpf: add sk_rmem_alloc related logic for tcp_bpf ingress redirection
    https://git.kernel.org/bpf/bpf/c/d888b7af7c14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



