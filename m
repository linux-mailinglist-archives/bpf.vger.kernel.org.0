Return-Path: <bpf+bounces-61592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00874AE90F2
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F4A174852
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316602F2C5A;
	Wed, 25 Jun 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4LLO36r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DD1F419B
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889992; cv=none; b=jL/TDuKbbuziRgBS4bZoA0KMspy5u6Qpy4CSF8dpRdq2zehEvzHzGc0IfzDCGu3RUl/vI2xQITI33PMOZqdjiLOni8C6JLtiAiqMMJcq5LKyleXAAnp9cUVvTXlRdu8AfWld7xQ+b0NOyqMAQOrqp2a1SfpGqsCIYFj8Ef4pbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889992; c=relaxed/simple;
	bh=PYrpcoeKvctKgQMhNxYkndByF1/uuISvE+wea0l4wvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Af1astxJfotsWqJkdXrmvlx7dYOz+qBk5W7i5btHI9Ufi2wQV6ty+h4K/8J4V/YRqhksA4vvDbnZsPIhOVVO3anaEowoa5d8viRdw/3Kn/74zB3bPy7+xnw+pWkWRWxtc8W1cWWpFoKlJudTBone3ZgccfU+6/HkKaBeA0uevCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4LLO36r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4589AC4CEEA;
	Wed, 25 Jun 2025 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889992;
	bh=PYrpcoeKvctKgQMhNxYkndByF1/uuISvE+wea0l4wvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4LLO36rp6BWa0NTI1ICp9uGTkAPYTcCncayy12WlR+waaTmeFtKUancqlVbQdz63
	 AmJTxi4d0FczyN9QiWHg49QCatDVlrN6SSWdBL8B+bZ3u/SpcauVFRXa1VvyUfUYJs
	 MJQVCXtc3ZLoUFRO0lE5Dq2moQjrXcwYckcDYHUMGhkUsyuguQb+cuXfBo+SJkwGtH
	 P4o88SnI0sns2mxfbqVZDvfdk5Iin0smGTA3T2J0ic1JZPPwXKyiqVpexBfV4jiLMS
	 w6sXdDzEeazF9D8+bXO0ODsLwTirD8m8ToD2FBkwe40XhQ5KD6IHYPJdey9cyDsjOq
	 HNBKtUbjismVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF263A40FCB;
	Wed, 25 Jun 2025 22:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/2] Range tracking for BPF_NEG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089001875.639228.13080727026470142909.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:20:18 +0000
References: <20250625164025.3310203-1-song@kernel.org>
In-Reply-To: <20250625164025.3310203-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Jun 2025 09:40:23 -0700 you wrote:
> Add range tracking for BPF_NEG. Please see commit log of 1/2 for more
> details.
> 
> ---
> 
> Changes v3 => v4:
> 1. Fix selftest verifier_value_ptr_arith.c. (Eduard)
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/2] bpf: Add range tracking for BPF_NEG
    https://git.kernel.org/bpf/bpf-next/c/aced132599b3
  - [v4,bpf-next,2/2] selftests/bpf: Add tests for BPF_NEG range tracking logic
    https://git.kernel.org/bpf/bpf-next/c/2945434e248f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



