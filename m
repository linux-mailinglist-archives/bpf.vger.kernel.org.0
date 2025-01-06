Return-Path: <bpf+bounces-48010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA835A03236
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355E01885CFC
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640B81DCB0E;
	Mon,  6 Jan 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9RM00ri"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98A198832
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736199610; cv=none; b=pSfzV1hdT4Qq3tM3gYjnhUteJkAQx2mct/Z31cCGxKyaw+Y74tPssbzAUwap2HsA64B1ohq28d2g894pl9fRK8zn4EeT1f937RmlAfmX+cKhhYRxqD7rH7apHCZF5seFeQJ5xJJDf9czg20u6G739LVotC8yf+od4T+TOqWjSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736199610; c=relaxed/simple;
	bh=lY6m81fNkL74YPPcjK7lYcT2XXto0qbCkehHb07/GCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JdqjrtvAnjqLYnyuiFCc/MfQb/zuO34PMaNWmBA6AOwNLBg5ZfeY/OWjIQzEbS+Yuca9fOvlx5fte1NdO6+71UPAPKociVQflTF8reuogvp3+GemkXzLjNo7Eo1BZw2u/U3OntGG4HLgw1C/wiS0mzstpEG7Q+8MH55d8Io2ZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9RM00ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0C9C4CED2;
	Mon,  6 Jan 2025 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736199610;
	bh=lY6m81fNkL74YPPcjK7lYcT2XXto0qbCkehHb07/GCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9RM00ritvTFSafDEfd4wHOY1dVmBmXY/lUJRElynRUDxnU+lb0ZYpUcuAg+EYdb2
	 9I0p6IUV8ZC2yf5EAB63O1He+BxSeY0rvl7hXQOXBgLcDF9tE79yCiFuXXkpHkX2kJ
	 etivxv2Xqfmhd+rhJDg4wwg5jBSsJnyLT4Y5sp1Nf8Re587vUmrsk2VJOVffWF6VQL
	 exTyJ67Q1i3sxZG/Az5fxqHXlFQc75lBJai3WsMO1o4WkF+H0Qs1KTMREgIossvUFE
	 37KYm1/akeGFToFq6x98ebXleDF2xI7gcx4pNnJG/vjSAN6eEJpdM49U1nFUKBVy9o
	 4885Q8L/asoZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8B0380A97E;
	Mon,  6 Jan 2025 21:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add -fno-strict-aliasing to
 BPF_CFLAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173619963152.3625985.12863478049124051672.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 21:40:31 +0000
References: <20250106201728.1219791-1-ihor.solodrai@pm.me>
In-Reply-To: <20250106201728.1219791-1-ihor.solodrai@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 jose.marchesi@oracle.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 06 Jan 2025 20:17:31 +0000 you wrote:
> Following the discussion at [1], set -fno-strict-aliasing flag for all
> BPF object build rules. Remove now unnecessary <test>-CFLAGS variables.
> 
> [1] https://lore.kernel.org/bpf/20250106185447.951609-1-ihor.solodrai@pm.me/
> 
> CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: add -fno-strict-aliasing to BPF_CFLAGS
    https://git.kernel.org/bpf/bpf-next/c/f44275e7155d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



