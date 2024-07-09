Return-Path: <bpf+bounces-34246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B04092BCF1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C801B2380D
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63B3716D;
	Tue,  9 Jul 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8k5ie5J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BC3A268;
	Tue,  9 Jul 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535429; cv=none; b=CS2cUtLL5M5reWaT3zZFw0YHL3uADa28SewdGnBfQUluo85VpXElcSqKPTMh63JytdWcf0++5/frUIPTFBpxg4TI3t0pclJcWOxMrlGD5YBENn/oKu8szuFSe7CXJg1JOXkb6abYH1A1mYIo6VZgzYK2nWIM9/vwWPoMusDAxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535429; c=relaxed/simple;
	bh=ZWxa+gd5pEVzod22OMsWJoUT+hAQJvO9+fuQ01wXAWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/2AcFU/AtU3i9alnprxMhdiXHb6KY2kweOOkgeyA+3i52vu2x933+nKcNkHHGFiqKI7yx/Kj9ntj24bzIC0XpL0Y/znHLpxcsXgqVKbfHGC4+0dOjMkPGaPutkatgjt/vhFk7UC50EWBHQnhIsDXiepeeMFQwH+vux024gJ2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8k5ie5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F07ACC4AF07;
	Tue,  9 Jul 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720535429;
	bh=ZWxa+gd5pEVzod22OMsWJoUT+hAQJvO9+fuQ01wXAWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A8k5ie5JE7c7vMbAjqvxk9kJ2wfXpLZoMM09ArkpLDEYNcF/a7glLFrf/mdXm1Lkz
	 jZr/Zv8+eM0mHnkqcZ6SBa5x65kYw3vdWEbjjUHmFdZHTMUOhyIXUYSai/MSCeD6FD
	 6d8pGW+njgm9ihYGOobc9bKCe5ZaeTQG0lAWurJfkXCghHatPgsgV+ucrsHiR/wHsK
	 lWG1nTZFXEEI7IuAjtCEMYmNqmp8MPH632D8/IMaoJBhl+hAudon6JzCCs1av1sj8J
	 cI0Oo8Rx26k6WsCSmr17B0n3isCqVnuFlqKLeOblo/QVukbdF/ktb2xL4wZhLOVCNa
	 vmi33DExy9YWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE0A4C4332C;
	Tue,  9 Jul 2024 14:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-07-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172053542890.29513.3572609329958435109.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 14:30:28 +0000
References: <20240708221438.10974-1-daniel@iogearbox.net>
In-Reply-To: <20240708221438.10974-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jul 2024 00:14:38 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 102 non-merge commits during the last 28 day(s) which contain
> a total of 127 files changed, 4606 insertions(+), 980 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-07-08
    https://git.kernel.org/netdev/net/c/528269fe117f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



