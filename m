Return-Path: <bpf+bounces-37800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC09695A8FE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E81F248D7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06ABA42;
	Thu, 22 Aug 2024 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFGuB1H2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC7AD2D;
	Thu, 22 Aug 2024 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287235; cv=none; b=EACwVwuM5EPwFvYe/cREaJfXoEJ+k2hr8XdyZD+hr4qh5paQYQhLWNR4NR0YEZCyFHDd053k27Gy5CPkOlD0pu353PS9o/ITmDVKCof8nDDjVKu2KuyepTIclWQ8cit29YHTGKUsqbx9NLiYAl7fuwXJL9+rqhRuzuLz5MlahSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287235; c=relaxed/simple;
	bh=rgJMzhgOWPDL8wGbADZqtAwyLYBiUfykkLs9IwOySyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PG580sXoxJgvY5ZIaBUyGYWTTNgXKreJ51nL0k6IB+D1MNY5UAa1z4IxXJ9JdMBUyXDl9lvNF/lKUkCpWmoX6+78dNkWu+GhT20i+x6+4fXMh3qJgXs5Ethtx4egI7P4gR4BAqr5EGW2LUZJM8HXHOWJ+K0vUNrnrQsbDDui+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFGuB1H2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232BDC32781;
	Thu, 22 Aug 2024 00:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724287235;
	bh=rgJMzhgOWPDL8wGbADZqtAwyLYBiUfykkLs9IwOySyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qFGuB1H25ie45U0Tuh3EGBDJrEM7pX3OIv1NngqK+gdOkBEZi/cdI6V3HTBxi1EF7
	 kF12llZDUAe2Eocu27oGfMz4OCkSNbF2hWi/QUH3p7cvZp4Mr/RTEf+UrSn07CLhyU
	 cRz7mocKnZs6t5SBg74Mu+xtBnnb5qQ6b4rKqcTG2aDj6Hu+v4SYu7lm0FhXuTNlkW
	 aqpZhFHmbUPhiExOHYxQmGgHba199/IH3r8lKnDEb/n6FDhq8C+ZZXb3YLvrllFLpX
	 aGg9UVAnzICiiZJG1hoprEaiUs5tSaZrj6OCFcecLcEBh8RhfPEoaglYiSzWWd4cKY
	 FjD847UQeOA4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE923804CAB;
	Thu, 22 Aug 2024 00:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix double DMA unmapping for XDP_REDIRECT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428723448.1872412.3610952969560387706.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:34 +0000
References: <20240820203415.168178-1-michael.chan@broadcom.com>
In-Reply-To: <20240820203415.168178-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org, hawk@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 13:34:15 -0700 you wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> Remove the dma_unmap_page_attrs() call in the driver's XDP_REDIRECT
> code path.  This should have been removed when we let the page pool
> handle the DMA mapping.  This bug causes the warning:
> 
> WARNING: CPU: 7 PID: 59 at drivers/iommu/dma-iommu.c:1198 iommu_dma_unmap_page+0xd5/0x100
> CPU: 7 PID: 59 Comm: ksoftirqd/7 Tainted: G        W          6.8.0-1010-gcp #11-Ubuntu
> Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.15.2 04/02/2024
> RIP: 0010:iommu_dma_unmap_page+0xd5/0x100
> Code: 89 ee 48 89 df e8 cb f2 69 ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 ab 17 71 00 <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9
> RSP: 0018:ffffab1fc0597a48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff99ff838280c8 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffab1fc0597a78 R08: 0000000000000002 R09: ffffab1fc0597c1c
> R10: ffffab1fc0597cd3 R11: ffff99ffe375acd8 R12: 00000000e65b9000
> R13: 0000000000000050 R14: 0000000000001000 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff9a06efb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000565c34c37210 CR3: 00000005c7e3e000 CR4: 0000000000350ef0
> ? show_regs+0x6d/0x80
> ? __warn+0x89/0x150
> ? iommu_dma_unmap_page+0xd5/0x100
> ? report_bug+0x16a/0x190
> ? handle_bug+0x51/0xa0
> ? exc_invalid_op+0x18/0x80
> ? iommu_dma_unmap_page+0xd5/0x100
> ? iommu_dma_unmap_page+0x35/0x100
> dma_unmap_page_attrs+0x55/0x220
> ? bpf_prog_4d7e87c0d30db711_xdp_dispatcher+0x64/0x9f
> bnxt_rx_xdp+0x237/0x520 [bnxt_en]
> bnxt_rx_pkt+0x640/0xdd0 [bnxt_en]
> __bnxt_poll_work+0x1a1/0x3d0 [bnxt_en]
> bnxt_poll+0xaa/0x1e0 [bnxt_en]
> __napi_poll+0x33/0x1e0
> net_rx_action+0x18a/0x2f0
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix double DMA unmapping for XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/8baeef7616d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



