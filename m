Return-Path: <bpf+bounces-64864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEDB17AD2
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 03:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596DE5A33B0
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 01:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AE13A265;
	Fri,  1 Aug 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hATgpV+3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADC78F26;
	Fri,  1 Aug 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754011795; cv=none; b=pq4z9SzasB0uddDyM2qmNrFmmAPURQdFPO9j8q5lhGQm3lCGaoAzSc2Dp14jRJWVFOfxafSEZPhXZZtSV19GHvFj/6Mx9CLIw8k7EhD7pDtLYOjo9EhR+WXt13vR+I6bXJzjnKzQa5fBSY+bNrnP28K8S4gYBejmonHOlCb+fV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754011795; c=relaxed/simple;
	bh=1BE+9oBhcTylDitTiXbzexLR2EordeI+B2H+uniTVs4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K3bg9oxjxHHl5Cjzrg0OX1PKvf/erYKGoBENuFOTt+mWwhcSHVpwTroI10snjmdHkAz4Tyk/KFweHSll0TChIxSCDBRjvVOZjC7ZfELuDBD/CHkXoGPlt9jK/YFW9IxyDd5a9u8esRQGkZQKQyGAoxlR/3agI4VfMihm008VYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hATgpV+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD95C4CEEF;
	Fri,  1 Aug 2025 01:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754011795;
	bh=1BE+9oBhcTylDitTiXbzexLR2EordeI+B2H+uniTVs4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hATgpV+3peMrAg3cQ7RKli+CYasgvWaxBqE4JUXISuIQNKF8+uIAEUfGW+hGVagbu
	 lbeQUzJiD4DsVNHyrDlM3EHA/oHR2Fc5ur1P5rGhNTYXsM9hkKbNvKEpDo/emadXUo
	 3SMYF4ImxD2uH5sOq0RoPZvFkgnI4Z2aSFgSjgWSouAU5aXYudbIm2LVA8kXk8KJRP
	 Dk+uIrXakMtyzbRiDubjnswMPyxViPEpnkZufgg6cv4XEp2705/g5O2LxiYVk/4nd1
	 9NnJMnbYl9nJt4g1EGgtftv7Q7R5LfbomONj8jihKQ4x7uSMfuU2X0sXjsqgx/bDUr
	 rz75pcXv9boWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD39383BF51;
	Fri,  1 Aug 2025 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v14 0/3] Support kCFI + BPF on arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175401181050.3387850.17837483390753961310.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 01:30:10 +0000
References: <20250801001004.1859976-5-samitolvanen@google.com>
In-Reply-To: <20250801001004.1859976-5-samitolvanen@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, puranjay@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, catalin.marinas@arm.com, will@kernel.org,
 andrii@kernel.org, mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mbland@motorola.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  1 Aug 2025 00:10:05 +0000 you wrote:
> Hi folks,
> 
> These patches add KCFI types to arm64 BPF JIT output. Puranjay and
> Maxwell have been working on this for some time now, but I haven't
> seen any progress since June 2024, so I decided to pick up the latest
> version[1] posted by Maxwell and fix the few remaining issues I
> noticed. I confirmed that with these patches applied, I no longer see
> CFI failures in jitted code when running BPF self-tests on arm64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v14,1/3] cfi: add C CFI type macro
    https://git.kernel.org/bpf/bpf/c/5ccaeedb489b
  - [bpf-next,v14,2/3] cfi: Move BPF CFI types and helpers to generic code
    https://git.kernel.org/bpf/bpf/c/f1befc82addd
  - [bpf-next,v14,3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
    https://git.kernel.org/bpf/bpf/c/710618c760c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



