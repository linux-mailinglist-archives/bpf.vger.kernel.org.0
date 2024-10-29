Return-Path: <bpf+bounces-43442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFFD9B5635
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857501F23D65
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6720ADFE;
	Tue, 29 Oct 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn1gQzQ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E77194A59;
	Tue, 29 Oct 2024 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242823; cv=none; b=IpNNvw2TrHFtpdwBO2xYbDDWIN2VB3vE058dkqWyLXrWVo73i93+VuCGbLWq4zs6N91WqocPWrwVzY6zHkld76DWj45fOxfjfMcLCeaHLko/igNyv64mfIa+KDv/7l20FcqWs1f4HJlYA7FUd374I4A+rf9MnDVQELVJYA2vtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242823; c=relaxed/simple;
	bh=fgW9sRmVfYSLcJ/HYbNyUGNUz6ItUP4eiBZEZ4kS9js=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OmKEj7uhApTm1CdgLRBYVv0+e+UYttAsmPSHUv0xgnQdJxTS06FeaIA4HFqrvErbfpjQzHxt9sC4SNefvsN3VJfZMv8Kvijof6ocUbZi1HpC0w2ltnIVOa/12e00JVnPlfY54i+PbR9xX+weDklqmb4XuCqtKLiGGdTLEoy4qUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn1gQzQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50C5C4CEE3;
	Tue, 29 Oct 2024 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242823;
	bh=fgW9sRmVfYSLcJ/HYbNyUGNUz6ItUP4eiBZEZ4kS9js=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jn1gQzQ9BhlhMxHCZB/I2lt1g8udj4v6dd1tMPr4j/clVgopyr995uL3I/2r6ZZYD
	 RUXVIypKKVrA5b27BwQlPDdxrLbNK6qzKQlHI3P/rO5Lg3iMSIzZfN5KXv9wUAgKQ+
	 BSFq4ShL+7TQrhzBPURlDnXR6CJex+10o1Eo2QuDlN9+1xev97SoH8vv9TWgzFKSFZ
	 UQ68F3F8w1sTZTGL/kZKc29JaSUu3p/7QuRUKLG/8f+2xjRPq6C8qA3JNlIT59A9P4
	 aVaigm3Jpt3PgDqLFznB9hjxnYgnV0LR1eqKpIJ70g2gu6SjWFmT71oRBvKWWTGxGn
	 bArXAdW3VqBbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4C380AC00;
	Tue, 29 Oct 2024 23:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mana: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024283052.846516.7188456547494767487.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 23:00:30 +0000
References: <20241022204908.511021-1-rosenp@gmail.com>
In-Reply-To: <20241022204908.511021-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, shradhagupta@linux.microsoft.com, horms@kernel.org,
 colin.i.king@gmail.com, ernis@linux.microsoft.com, ahmed.zaki@intel.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 13:49:08 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 55 ++++++-------------
>  1 file changed, 18 insertions(+), 37 deletions(-)

Here is the summary with links:
  - net: mana: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/ae2930b0b311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



