Return-Path: <bpf+bounces-31207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F78D85C9
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FE51F233C1
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B01304B0;
	Mon,  3 Jun 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr8drdox"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A6B2566;
	Mon,  3 Jun 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427429; cv=none; b=ZvWkmpOgYUjJwGgZpPRxW2wPV6rnroHNZ1TvctlQy0ujiJy+e2eujf9xlktDjbIMm/kjdgAuqeQQu1UXX+Hm3tXR0999no5oz83gQRO50FXKpDf2DOq+iocRvmiUJOqbnnv9nUpwTd2mW1/Gtbexu/DkeOh3xMVt9a8lU4ciFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427429; c=relaxed/simple;
	bh=GlNOvuQUEAdDAvBr6ZbKOOB9bgYoYbx3+leL6mWg5h8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m09D97HOy1hVtAHUZQfI/QrLEDo/3PxhVBDHAmmo8im8jCX3lEBRoa/XPkcrgrD5pamA6ZaZnXKTfForUNhemu+EPO2OGNXhd98sW+aHyx6cdFvmozMpLDNh/96BxvgIObMr7mCopo1wsVr3XJ16bDbfIWnBKfM+ltSdnKOOkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr8drdox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C149C4AF07;
	Mon,  3 Jun 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717427428;
	bh=GlNOvuQUEAdDAvBr6ZbKOOB9bgYoYbx3+leL6mWg5h8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tr8drdoxFouaCbs7cc9FMdaaJLkzs7Z+gGB54fjJATuiTzZcJq/Tajpze+U+MGgOF
	 17uMMAYQQnqX8LsBxQxSBXf4qGt3osRynrKjf2DjH05ZejSyXgWrmSa580SWW1RVVW
	 JsOcJtUTdVgV7r0wHHfmTVY9GGoBN7zFVUavES7Hn2WXE6+inlNlnLZse/OlZ9D4Bh
	 5kBFIdp428lpSULzVhlwFChRoZ8eNL7FhxbZWhwtEcCv3n3wOcKAY24eTm3vKO8WFm
	 h0yxnuJz/aLuWn84LyzreCzjVEhBHnzZwIcYa9T42QTUKqKbgjlrV2RdBbrVQVwZNr
	 FPAZa7a2twAug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82B06C43617;
	Mon,  3 Jun 2024 15:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, devmap: Remove unnecessary if check in for loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171742742853.507.2337578817446243881.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 15:10:28 +0000
References: <20240529101900.103913-2-thorsten.blum@toblux.com>
In-Reply-To: <20240529101900.103913-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 29 May 2024 12:19:01 +0200 you wrote:
> The iterator variable dst cannot be NULL and the if check can be
> removed.
> 
> Remove it and fix the following Coccinelle/coccicheck warning reported
> by itnull.cocci:
> 
> 	ERROR: iterator variable bound on line 762 cannot be NULL
> 
> [...]

Here is the summary with links:
  - bpf, devmap: Remove unnecessary if check in for loop
    https://git.kernel.org/bpf/bpf/c/2317dc2c22cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



