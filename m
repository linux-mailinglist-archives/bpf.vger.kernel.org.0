Return-Path: <bpf+bounces-56003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28EA8A6CB
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 20:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF51900D2D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1B2222AC;
	Tue, 15 Apr 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdAWWsUQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2C199947
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741794; cv=none; b=IYs3qz2e59U6cqedsO/iHtvgkD0dLjERbrbg+7t0WwdmUujSPVNdGoRjuVVWp2wRoOGHJxZERNO7hHs4VENSAXl/mlWngzN6Hz8zpgeoo0dPMKGlZTUM39+BJWYlp/7ybGDcJW8QpdJDQoeoRFErgEe4LkWw0MfCTtrEWeckS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741794; c=relaxed/simple;
	bh=DsnnA59gDIqUSPJvLbM4B+avf09YrtwAtjZcP4N3xkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFKBTrbCVe6nKZDOPH9yNsLlewW1OV+thN5xaIKiTHwxqTUbbS/YajLP5fff7AqQkImZiWH86+aq0aPUH2qicsz/n1KFY0jl+k3l3NhNze95rNqvxU8yDbnltYNi+6AASVGmKHSg2D7CZWncRLa64EPCnIvWjMAbTvOB+yuFpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdAWWsUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F7C4CEEB;
	Tue, 15 Apr 2025 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744741793;
	bh=DsnnA59gDIqUSPJvLbM4B+avf09YrtwAtjZcP4N3xkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FdAWWsUQZzZRHqOQn38bGunAgTHiZWYTnccQFu+NkV1NsAHDSS4PJZ8vbs+NHH2ZO
	 RCOUskCxCPRfCdd/NkPodJnexaR51RGrCPkwMsnkanVia+CYCQrwHh2XGhspy8IHKP
	 ZfBPJnyf2DT5hKC2QiJNqRK2jm0WQ72oy33VfW9oBxS5oGL3+GcW04aGXmTpZPaai0
	 +4L1oW2XlmkrLXzOBqw77MmnE/V5B/06pxZrP7qkNwmkKpMCIXlf8B0/oBmyqb7Z0z
	 f/O7O87CCNC6x0QnbrTfLS8VWzzvEu0CobEkGYh/+7W2wdcub/N+6nEdpbnkUJvnPh
	 2Y2TQjWmRKZBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3F73822D55;
	Tue, 15 Apr 2025 18:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] kbuild, bpf: enable --btf_features=attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174474183178.2735919.11515832498286721652.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 18:30:31 +0000
References: <20250414185918.538195-1-ihor.solodrai@linux.dev>
In-Reply-To: <20250414185918.538195-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 14 Apr 2025 11:59:18 -0700 you wrote:
> pahole v1.30 has a BTF encoding feature for arbitrary attributes, used
> in particular for tagging bpf_arena_alloc_pages and
> bpf_arena_free_pages BPF kfuncs [1][2].
> 
> Enable it for the kernel build.
> 
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> [2] https://lore.kernel.org/bpf/20250228194654.1022535-1-ihor.solodrai@linux.dev/
> 
> [...]

Here is the summary with links:
  - [bpf-next] kbuild, bpf: enable --btf_features=attributes
    https://git.kernel.org/bpf/bpf-next/c/21cb33c7e065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



