Return-Path: <bpf+bounces-75277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4CC7C0AF
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD0D3A6514
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E423EAB7;
	Sat, 22 Nov 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf+THsKh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331E218AAD
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772829; cv=none; b=HlF7V+aKkYRoM4NPb8OXQw9XfDyFrhtda9EufFczUNPwiekN1DYEd2NM4MMHhMbR14fdxyS3k3KgiuyDc6FDnijPLnHe6WC1mkcHFzVGYTVocjJU8wp/RUfVq1k2MTLfEH2PfevqHEuM7DGFwZCxSzChPh7do3YxbTSGMG9Bmk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772829; c=relaxed/simple;
	bh=J5h7QjhyRdpVzYFoJ/2Gt7c6roqoe/Al6Aloi963I04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tAfbvtVGgWyI6lWbP1ME84CdC4PJRPBq9zZuQiTokmxg8EGfp/Jn/ZxE0A+F5oQSp3IcJt6FpONtwXfFEpK/92vJP/ihMTzf/VWzplNiZ8PfOrr/IfGoGZdP8ySTzli0HQDmu1kb9Va7//XfgEFxauEWRQZY5Zq3NxpTSM8Waa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf+THsKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F4C4CEF1;
	Sat, 22 Nov 2025 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763772827;
	bh=J5h7QjhyRdpVzYFoJ/2Gt7c6roqoe/Al6Aloi963I04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gf+THsKhUGo7zxZ4Gkqch6QGvD6IqXmSW4UJjZ7+GLgUFwsNc2CDyqOU9GFExaRmc
	 EJTh4N84Trn1lS82anaKh9oABoZrtYlNyKXPE5IEW+543U0v2kAdBx4Dqn++NZUfPL
	 qC8kWSwFTJ2k7QiRayIo1MRuNVCGRJQCKniB7+/M54cwVd/lt3xeTtULelgAtaj5Eb
	 AYFXcTy+eU9pbLDIXYWovoZuJoY6fuSY3v4vtYHPxalk2qPQ7aEcr5VFudCT7MCiM+
	 +wVX75L33KQRSb4Q7/gxGXQtNJm1o8zrEPKJ3WsHVsu91/H/t4zs3OTVx61+5/OStV
	 Sp+xrdkB3avyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF023A78AC8;
	Sat, 22 Nov 2025 00:53:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: arm64: Indirect jumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377279149.2637800.16196683699835651319.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 00:53:11 +0000
References: <20251117130732.11107-1-puranjay@kernel.org>
In-Reply-To: <20251117130732.11107-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, xukuohai@huaweicloud.com, catalin.marinas@arm.com,
 will@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Nov 2025 13:07:28 +0000 you wrote:
> Changes in v1->v2:
> v1: https://lore.kernel.org/all/20251117004656.33292-1-puranjay@kernel.org/
> - Dropped patch 3 that was ignoring relocations for .jumptables. LLVM
>   has been fixed to not emit relocations for .jumptables, so this patch
>   is not needed.
> - Added Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: arm64: Add support for instructions array
    https://git.kernel.org/bpf/bpf-next/c/84b1c40d5b4d
  - [bpf-next,v2,2/3] bpf: arm64: Add support for indirect jumps
    https://git.kernel.org/bpf/bpf-next/c/f4a66cf1cb14
  - [bpf-next,v2,3/3] selftests: bpf: Enable gotox tests from arm64
    https://git.kernel.org/bpf/bpf-next/c/d8774a36235e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



