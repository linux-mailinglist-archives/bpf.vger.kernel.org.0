Return-Path: <bpf+bounces-65248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D2B1E091
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 04:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB018C340B
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86468158DAC;
	Fri,  8 Aug 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH3/wVLS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FBC7FD;
	Fri,  8 Aug 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619593; cv=none; b=RlObkz/M+dwUtLBq51RHsf0/EhCFq5aUwUTdy4UYxe9dKw+oLyKE0/3WOv97MO9HvMFkG/twCSPsOkaIYueTGrXQ+Gh/y5CZU4syZb+km8PnkVPq8Fv/7NBklIFBTRsvvDEBz2JsHXHFYzqGMRES87TRJk72lDmrCOARxwsMwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619593; c=relaxed/simple;
	bh=6cdHA0m1RrhNaeATzq8keJyMZfncYc8HaVsQUCFdN6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usx/r2SZ/lvYmE9draoylO6ghhtoAWKquKYJByzXGxGN/cgEB8QkQ5WEX1mVzoDjcLjtgnCa5kiguTK6y0DFnK6D5Ad8KLHF1IbfocLw3lHy+tHZAsbZ6o9p0AtGsKD1542HY2trW0wg4Mgh287qHN2iC1SUSQK1KO+ChQdyY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH3/wVLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88679C4CEEB;
	Fri,  8 Aug 2025 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754619592;
	bh=6cdHA0m1RrhNaeATzq8keJyMZfncYc8HaVsQUCFdN6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dH3/wVLSvF89+C6PGX8WLTBBehHxicdh6H+eiO9aFuyilLHmv6K4kpaKdM0kQ8A+w
	 E0unWqK/5I4oYsX5sostKc182H4I79mICp5bi15Aq8VGDctrhBZeairQVsobjtHl54
	 F+Od3eupJc3qnMIBglr9PkuAgvfXV6/9rDvAKJn6Ccn1uvrJLSU2kntrQwXvuiGC5U
	 CNcZJNkyBpN8KU1ILnqLFvgdpEbFwTsTse2ssm3hngSUIAPNSwKuunXBFi97g2B3O5
	 BYrvLja9z0MhZodpaEvCBMnJXcZa4SUS6S5nvPhIHhu7wdkeDK/zhfQYqVESn8VugM
	 2K4AUzr9EQVew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6E383BF4E;
	Fri,  8 Aug 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bpf: Fix kernel coding style
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175461960602.3773193.15028433526813843658.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 02:20:06 +0000
References: <20250730105019.436235-1-lijun01@kylinos.cn>
In-Reply-To: <20250730105019.436235-1-lijun01@kylinos.cn>
To: Li Jun <lijun01@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 30 Jul 2025 18:50:19 +0800 you wrote:
> 'noinlne' after 'int' cause
> "ERROR: inline keyword should sit between storage class and type"
> by checkpatch.pl
> 
> - Standardize function declaration style by moving 'noinline' modifier
> - Fix asm volatile statement formatting
> 
> [...]

Here is the summary with links:
  - net: bpf: Fix kernel coding style
    https://git.kernel.org/bpf/bpf-next/c/fa479132845e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



