Return-Path: <bpf+bounces-65582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65104B256E0
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3416E3BDC5F
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589AA2EBDEC;
	Wed, 13 Aug 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA9RP58h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8B2F7446;
	Wed, 13 Aug 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124794; cv=none; b=oE2O+OeZgOJ9SRikdVttykHzvJUCXjK7XLC6WsVdboOK/dRARuG1/v43ntSbP1NxBEXgU7bQu0tN66XtHLF7MGN3r05LHzV8QxiXaQCIMjuAHc8TNrvPT1j0aKZYVccLjJUYJSIkwBjoRfhf0Tg4Jeju47oKVoiR/C3XjJjS/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124794; c=relaxed/simple;
	bh=VA/RXwqMPZsc2LBnK1g6+A05KsxC9gFEUc00fxvm370=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P+/yPDMI6KWVufggwelgMtC9pldrjfWQB67ohGCysVM7UaOZvcTqEj58j17pTqlXgnjZQzN6y5iW1LTqUkiqL9MPYoykV7HOWy2SrVodOnMTM9J9aJ0eNAT+rLAF2v32SBy+QdHilb9msnM6qkE8onB20AbxbOwsD0fzmcdqcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA9RP58h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAC1C4CEEB;
	Wed, 13 Aug 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755124794;
	bh=VA/RXwqMPZsc2LBnK1g6+A05KsxC9gFEUc00fxvm370=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uA9RP58h+B/AlWgLQZxp+4TPMwVTdQkwAAVdrCVSNORFnApGNqjpPoeGWZWCTYDV/
	 UyR+nJjBs307x60sdR4PnVQEMk5NqGKop1kWsGF5aKETZk+eExAIgDCvDbVkj//MRC
	 FZMLbVP4zve1JxHv+sDhU6Keh6oYGwWCkd20M/AhZmgYnB/EXGLvuA5TSTDPFYCLC7
	 QnGHxHnLELSdHdDRfLYnl9sn0SuPzvTnSVG2/pEPKZnj7NsdCPEqXUGYe8N6HVBjE9
	 oYnbr0SzpKZFGdbg/fCKP7e9f/kHDqFc5z0YmKC6xpFPRAkoeV03ySDO1Ntyol6cq6
	 kfQ2ej5C4zpPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 232CD39D0C37;
	Wed, 13 Aug 2025 22:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Don't use %pK through printk
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175512480611.3801203.14823846312394914170.git-patchwork-notify@kernel.org>
Date: Wed, 13 Aug 2025 22:40:06 +0000
References: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
In-Reply-To: 
 <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Aug 2025 14:08:04 +0200 you wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Here is the summary with links:
  - bpf: Don't use %pK through printk
    https://git.kernel.org/bpf/bpf-next/c/2caa6b88e0ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



