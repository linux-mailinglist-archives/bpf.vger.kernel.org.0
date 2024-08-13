Return-Path: <bpf+bounces-37066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6080950B76
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6E1F23CB6
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E31A2C19;
	Tue, 13 Aug 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F31dSPHb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5E18C3D;
	Tue, 13 Aug 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570229; cv=none; b=ZzfzK8NSGnEovkLK2igdAWfbPppqKNrXFkx4pxQQbtA33XM2i3HRPoSZVEdjAAQ/xe8pVQr3kRo3GPS1WQSjRAEF1JNVP80z5Ixu3B5Y221Bqz23FtWdnXrlNCWIzNhDl4QDm5F+C1iu2QjpDxKk85B5MB2OGXAPab7vDM74kC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570229; c=relaxed/simple;
	bh=dFV1+Z8zUpHV/JRQ7S5XaE8x/1h1tJx0+CLa22IsB5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R7WN38OD4UVTP08ZIv4KMzG+2LuXGiKQMYF80QpVrBCv/D8kJ6CLY++928xvbCVcQhg3Kmsb3QCQzf7mP1SQ4N0bBeq3JOS1Uad6VVQjbi4rwrIeeD6Qq81exG1upO9LhmuTB9Bm6n738FV/hDJ/TOSyEhLy+GESpFOWNuLK1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F31dSPHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32A0C4AF0B;
	Tue, 13 Aug 2024 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723570228;
	bh=dFV1+Z8zUpHV/JRQ7S5XaE8x/1h1tJx0+CLa22IsB5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F31dSPHbtiHrpV5QybwuB4rPIMbalhQVVXF/F4hvuXmcx88SiT8FJox5YmQjg8nDn
	 4T/6/Nea8YeUF8ENHU8B2DRSFCmybEDU9JSpQMmFbPxbGfbO93N+e+JPZFAofoTnDC
	 u/Fp1RUTmMtba0HczEgLMBFWyD5lwTxBPgy+YJAcx3rfHtJbd5abECUOr1xUZq4kfB
	 V2wrYLYQuy4tyj0lO3A19r2j1QZfgXOzN0o5S+3swtTviANYGuFqVpttIN30nGu6wB
	 cMfX1Z+7MSXdKY3VDCqH+limqPNfNnBawECtTz2Uz+V0CxxcGTrRruRJW/PwJylhQm
	 3n/wKDfG5ffAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0123823327;
	Tue, 13 Aug 2024 17:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] perf/bpf: Don't call bpf_overflow_handler() for tracing
 events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172357022776.1707128.14984881703439045875.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 17:30:27 +0000
References: <20240813151727.28797-1-jdamato@fastly.com>
In-Reply-To: <20240813151727.28797-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, peterz@infradead.org, andrii@kernel.org,
 mhiramat@kernel.org, olsajiri@gmail.com, me@kylehuey.com, khuey@kylehuey.com,
 andrii.nakryiko@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 Aug 2024 15:17:27 +0000 you wrote:
> From: Kyle Huey <me@kylehuey.com>
> 
> The regressing commit is new in 6.10. It assumed that anytime event->prog
> is set bpf_overflow_handler() should be invoked to execute the attached bpf
> program. This assumption is false for tracing events, and as a result the
> regressing commit broke bpftrace by invoking the bpf handler with garbage
> inputs on overflow.
> 
> [...]

Here is the summary with links:
  - [v2] perf/bpf: Don't call bpf_overflow_handler() for tracing events
    https://git.kernel.org/bpf/bpf/c/100bff23818e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



