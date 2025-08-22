Return-Path: <bpf+bounces-66261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA3B30A6C
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 02:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA737B62D2E
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB7019307F;
	Fri, 22 Aug 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGljiBqM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDE18CBE1;
	Fri, 22 Aug 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822625; cv=none; b=KbvruTSMetH0bHNwfPpx628wM9y6bUYQCe9nWeWAlRJWhNgitTwBtTJXtG9vmo9IFgvrljYaq0ovWsjIMMRUS9oNvaKQVPFDRAUPp1l1YSYUXKpHYqP/p4G5OMODmWnMU8npHDabEUOG6kJjTTAr1qjVaFSFzT4Um64e2jkt/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822625; c=relaxed/simple;
	bh=mNF2wKracZr6fUp494HoPz0bgjUDiQ/t131e1pMFzow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pv57g6hjWTVCqCjAPSgDo385agLvzMKGnrbuSOMNRwfSxnsVZSqMIBqRFyclMMhsqqvZ14HPLePqhoa/DZVCowg9OfLnoHnbWDNM2tHVfMrumJvKFCdsY6zx0CBSpuLD6eRhVlK0//kYzuQWREx5TP3Ij8eqsqQwWdSqivLwBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGljiBqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B58C4CEEB;
	Fri, 22 Aug 2025 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755822624;
	bh=mNF2wKracZr6fUp494HoPz0bgjUDiQ/t131e1pMFzow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RGljiBqMWe7QcGFNaUOFags5tpFp+/klxlmGcizGTHqWrOyC7RZ1+HnfWpjPLce2m
	 oHoAPJyxWbiRdZE/u69bys/lJSwEB9b68HffY9bSKRsHx6yPKX8hIveRPtArrmZD79
	 DuwwqC0ADFyCC1bjWRck6ZBQkTA/HrdVm75bcVIB7JObegfF6uCIEw+Wx16le3w8KX
	 P1wx0UK85kogzaE8nZjROhKHltbwuvL9i7XyKDimrL7WZHJUTnG2y3HwinGSvhX3Hu
	 Koz6BWgiQklHwLtD23tUioRHGEutSs55mviZFHsxzhLUX7cRNzAHxQCspv0k9kOnfa
	 ezz9gBpQgOiXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAF383BF68;
	Fri, 22 Aug 2025 00:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-08-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175582263374.1251664.16880295480809598958.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 00:30:33 +0000
References: <20250821191827.2099022-1-martin.lau@linux.dev>
In-Reply-To: <20250821191827.2099022-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 12:18:27 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 9 non-merge commits during the last 3 day(s) which contain
> a total of 13 files changed, 1027 insertions(+), 27 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-08-21
    https://git.kernel.org/netdev/net-next/c/4dba4a936ffb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



