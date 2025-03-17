Return-Path: <bpf+bounces-54238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610DA65FBB
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9A0177731
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87951F6664;
	Mon, 17 Mar 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKCdZIxS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A471F4179
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244602; cv=none; b=gFYRe+HH2X7d1WT0N6SgMYvb9m81gyh4bOrJ4l8lu4h16lngZGjnXDALtg0vYFUa3D5+wJauou7SH4iNX58CKlJXZ8g73EfD1/6C+/oYfvBq+PgaHG2fXaHBRSSpq4y296gKUbeYWfqbJlMzu2t0j4IXwZwAuV3uJOrrsPMCEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244602; c=relaxed/simple;
	bh=2egIspVqvgHfcuKg0n6A8PdUyvEV4/hwEqeobErNEc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hc0BZk7DTOAY6mBE3VwUgqmF3BlijPquiqXUGq+iXCnYZaD6+Thfi2fAG9dA864td9Y3g2JQhJSK/7cSKUHVoj7Ljb1EoHsFYLn6PHl6E48HWI8jjzC5lrsoYqulGjQKOey77jQ14gnd1x1kCnPs9qF+m3qAbiCKNJDZRZjzPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKCdZIxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2CAC4CEE3;
	Mon, 17 Mar 2025 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742244601;
	bh=2egIspVqvgHfcuKg0n6A8PdUyvEV4/hwEqeobErNEc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKCdZIxSm3vuCZIT1zI5rYgzwVhSE7J2tF47tTWl4161uDFlVDFJO++oyTVlmUbIo
	 nZEIJa/EVAxrFiYztmLERf3TpBT9/q5+50Nx/dqzYIHMDx9g5u21Q6oqDw++lXan9Z
	 653S5+Vsa8MjuOtk6iA/xxkElJoKBb9rTKWAU3FAzYaVWbldgnoLKqFn3EAEeVT4J7
	 sDkm3Li2Jq1ccOcj9Cmt46Kx1goRbluWbhbvZOHNLHD4s++Qt2HnF8swThCaEc7p5R
	 6oZDO6z14sLwB1UxoDQg5EDHcGts1QifMCL1Qa/Vy+hymJvfXEF8btpTh3IbhFSn+F
	 cVJfiVNMnG1QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34966380DBE5;
	Mon, 17 Mar 2025 20:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/4] Support freplace prog from user namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174224463701.3909531.2342481420951215606.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 20:50:37 +0000
References: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, olsajiri@gmail.com, yonghong.song@linux.dev,
 yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 17 Mar 2025 17:40:35 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Freplace programs can't be loaded from user namespace, as
> bpf_program__set_attach_target() requires searching for target prog BTF,
> which is locked under CAP_SYS_ADMIN.
> This patch set enables this use case by:
> 1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
> instead of CAP_SYS_ADMIN, support BPF token in attr argument.
> 2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
> bpf syscall where capable check is.
> 3. Validate positive/negative scenarios in selftests
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
    https://git.kernel.org/bpf/bpf-next/c/0de445d18e36
  - [bpf-next,v6,2/4] bpf: return prog btf_id without capable check
    https://git.kernel.org/bpf/bpf-next/c/07651ccda9ff
  - [bpf-next,v6,3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
    https://git.kernel.org/bpf/bpf-next/c/974ef9f0d23e
  - [bpf-next,v6,4/4] selftests/bpf: test freplace from user namespace
    https://git.kernel.org/bpf/bpf-next/c/a024843d92cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



