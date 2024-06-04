Return-Path: <bpf+bounces-31368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26C8FBB70
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9C41C21BEC
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED314A4D8;
	Tue,  4 Jun 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGXIlvRK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2C149009
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525230; cv=none; b=KHkSQMQBz4jg40g/q007ajO9CErdOzOxU+dc+Z2oAVFX/DDjElEOQQnhtsKEJYKmx9SneKSVYbBeuA0vaFDp1Iq3lyQaB+kiD5Jt0mpITk1tkRaaJ0+zHMtz0Dzx/1rqDIaNCTq0UJfQRrTJhhsLzAj+6/wHXydM33FnX5SMq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525230; c=relaxed/simple;
	bh=+RlSD+r2D+c34LejZtiRWZvKarRi033IqOgpkZW3FFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iNveSRrae1GP/Lhs8n9/tLU0KquzQrrCs54RiqtcyKrDUcjfEZwnGyk/xH5izcMzAqqPL0Jyi5uStezQ6MmszJs9f9t34WZrStw8BkR+3NaRuwOktrqf6sqO5vw21n6sUS1dTyM5/kIezAhxjdXzZIW6GJm/BeeqjlPSW/xK1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGXIlvRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 530D6C4AF07;
	Tue,  4 Jun 2024 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525230;
	bh=+RlSD+r2D+c34LejZtiRWZvKarRi033IqOgpkZW3FFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OGXIlvRKXVliNw/NSnyn3FOdCiCDqBcQibD4tgeRyGy5KTQU4/eJOcsDcABstD0mb
	 10TxMgYNFnnpXZJR6KE8aqngttChI0oZiLSEfsS8AKX+YpvAA+8YGR5kcvY495AdIe
	 K07/9pWK/Ev9qV7lU4B0YUk9AvUoziPgrimGZP760eyTmqlsl1DTa7ECxamkx+gpYL
	 OgfZokqLxqsK2JDlKyNAXKZcThGQYrmMtuh2FBDgpAhmL7vLpwuCeQWy75cY8Pd3VU
	 ATcnIfy06RFPqewsO4qy3jLnTuxCotVvHMeGbYSozyhLuvxLLppdrU5U2quMlaSe90
	 bqimMN1f7sHrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C8CDDEFB90;
	Tue,  4 Jun 2024 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix bpf_cookie and find_vma in nested
 VM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171752523024.21425.9157597145574196913.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 18:20:30 +0000
References: <20240604070700.3032142-1-song@kernel.org>
In-Reply-To: <20240604070700.3032142-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Jun 2024 00:07:00 -0700 you wrote:
> bpf_cookie and find_vma are flaky in nested VMs, which is used by some CI
> systems. It turns out these failures are caused by unreliable perf event
> in nested VM. Fix these by:
> 
>   1. Use PERF_COUNT_SW_CPU_CLOCK in find_vma;
>   2. Increase sample_freq in bpf_cookie.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix bpf_cookie and find_vma in nested VM
    https://git.kernel.org/bpf/bpf-next/c/61ce0ea7591f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



