Return-Path: <bpf+bounces-60471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4291AD7611
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 17:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55D53B774A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFDB2DECDF;
	Thu, 12 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOEML57q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16252DECCE;
	Thu, 12 Jun 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741624; cv=none; b=KrNrGf2fyXGz2X8VlXadONpVhM8wVAjfw7hmu7OpwgTmUGXs976NY/AKcIhjo93osQZSO1icthl8GZWSUUWFrKXrC6w6VHdhPGH2M9J+IkAXuIyuE00p7qbTOmElFGgjuMsyjYRnTSU5GDDIUSrqH+b1IymjHz4EroUU+KE0AzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741624; c=relaxed/simple;
	bh=2tejiz5DVdOlRmvBqp9GHYQSovXdiM+qGs9S1837dMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KVPl3oF3GvOtkN2iMXzzTeDTRdZRKByF2eY8aJEpQsX8zrSatXQSCZhykqabTNs0HCl8bghDna/35ALzwfPWfVFwv5TXIPvGrm0mXC2zCFug5E4KIosU7Nm2GuY3zQiJbTN1OP+4JWhZyUnlbOiD3QHCtzuuDGvv3qBzuyNe6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOEML57q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE40C4CEEA;
	Thu, 12 Jun 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741624;
	bh=2tejiz5DVdOlRmvBqp9GHYQSovXdiM+qGs9S1837dMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HOEML57qYbZDGVsIJ7Q4soNuwPBNQ7k35nOmoxMHE0By94Q6gPMVPiNSy4k9kLC3R
	 UKZCjFi/inKphi8j61OAZcI+bZa0z3F08z141U91P0mqk9C9OwTkB1NPLwDeNh/F+7
	 QnExAtg8E0ipxQ6xgoyLkUO5oVvY9sF9xx0Kc8jkwyUgCuads0smeVPnY3S9othBVA
	 1PMYCsJW4xdQbASV/kIt0N9xIVKJjzkMxWuWL+a8mzo+/05Bw9Kq8khHGEtDroZ7E2
	 X4NDW3aB65dxwOziE2fyduG7NqU8X4HENQBilHrz24FR2bC0MWRpnLknCuKypEsLvU
	 jeiF4lnjEhRdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4A39EFFCF;
	Thu, 12 Jun 2025 15:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V1] veth: prevent NULL pointer dereference in
 veth_xdp_rcv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174974165399.4177214.6619707775306448053.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 15:20:53 +0000
References: <174964557873.519608.10855046105237280978.stgit@firesoul>
In-Reply-To: <174964557873.519608.10855046105237280978.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, ihor.solodrai@linux.dev, eric.dumazet@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 14:40:04 +0200 you wrote:
> The veth peer device is RCU protected, but when the peer device gets
> deleted (veth_dellink) then the pointer is assigned NULL (via
> RCU_INIT_POINTER).
> 
> This patch adds a necessary NULL check in veth_xdp_rcv when accessing
> the veth peer net_device.
> 
> [...]

Here is the summary with links:
  - [net,V1] veth: prevent NULL pointer dereference in veth_xdp_rcv
    https://git.kernel.org/netdev/net/c/9337c54401a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



