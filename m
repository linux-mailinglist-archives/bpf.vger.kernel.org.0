Return-Path: <bpf+bounces-61326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C942AE5829
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF03B6AA5
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87A22B8A1;
	Mon, 23 Jun 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMV3yzoL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD42226D1D;
	Mon, 23 Jun 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750722580; cv=none; b=t1UWNNUE1oog/2RkI5bijZZJOSnh37i0/0H3ZaxN4mwF9jEOZStZqErqyieGbWyDW/4lMbgYrGo32+OMOkic60xg5fZa6znp9hhlugC4ks+8ygpHZtBRTst/kJz5R1TL0hmFh9+SxG4ovcM/kmht4qa00kPcOfLKnYz/F+HiC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750722580; c=relaxed/simple;
	bh=JXf4iqa6uVPdc95/3ut6i4KOOl+285/4w9IgaOmNnvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bp/J9gnGUobcORrldFFNIdb6J4dYrd16GOjaeUW1JT+73AAC6NPL8xIVktVrDWJy0ca0ED7+xazEJJ/CeAEGyLibiTomfm5oyiV0z8SXHStmtJo/d3ix9K2dBvv6KSSZyBINRT2ueQa+mYj8Yalilyjc36QMLiFLNNY9n3Oc0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMV3yzoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8356C4CEEA;
	Mon, 23 Jun 2025 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750722578;
	bh=JXf4iqa6uVPdc95/3ut6i4KOOl+285/4w9IgaOmNnvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rMV3yzoLyacUcSN7NtUwK6YaC734GZeSrR8noGhYLXAcRcGs4Dbkt8cdnfdO+Jqus
	 Gcg9FpbgjuGaHpEZJnjVGU/O372+TtdeCC6ZPlnSkYWWnde+TtuVbjdu/K38ufxLzT
	 DXyK89J9Hs3uC2GWFAH/amxN/8/WJ+8GR3pKftDSHsAH+yDlCypJyAZ76tdBcy2KtZ
	 ynkqzLD+r3IvoJO5rWtvsu8Tzjhbkkor4eG+63Dbvtqd+A4PtFmt3wzDIQd+jUqAoB
	 lBBEdEF53/DPDTJiqHxY59letbj2s0nEuJbtuTSLPGKH3Iz2x5K5Vt38cNusppO/JK
	 AUIqrpGKyGFJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB29839FEB7D;
	Mon, 23 Jun 2025 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ethernet: ionic: Fix DMA mapping tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072260577.3335826.15218857163577175458.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 23:50:05 +0000
References: <20250619094538.283723-2-fourier.thomas@gmail.com>
In-Reply-To: <20250619094538.283723-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, vladimir.oltean@nxp.com,
 csander@purestorage.com, ap420073@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 11:45:30 +0200 you wrote:
> Change error values of `ionic_tx_map_single()` and `ionic_tx_map_frag()`
> from 0 to `DMA_MAPPING_ERROR` to prevent collision with 0 as a valid
> address.
> 
> This also fixes the use of `dma_mapping_error()` to test against 0 in
> `ionic_xdp_post_frame()`
> 
> [...]

Here is the summary with links:
  - [net,v3] ethernet: ionic: Fix DMA mapping tests
    https://git.kernel.org/netdev/net/c/d5e3241c5a38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



