Return-Path: <bpf+bounces-19402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DA82B9A9
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CDAB22D69
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45411111A;
	Fri, 12 Jan 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYHIx+Je"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87541379
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59B2AC43601;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705027227;
	bh=bX//Mxb7t/9aNZYM7kSy4fGCnrTzB/adWNBQfR6Kgy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sYHIx+JeXT7i7LDAI70F+T9cMOs893oY7cstDcPPlmN2ktx9qiKPO3Fc/gp7Gyxfv
	 hCPB6mllyeSqEwWYaDyK/rkyW9DeiZi33ypIzC2X0pYnWRU6lesE904SwPU8I4eMMW
	 ePJCxTld8cjQuk2ANTEUssqiFl9KGgljZhfR70Kihu+2eyJ55Fd0C/FanOMgjsnl7H
	 xyFd0fPaW7AZkDk+QEsQMly7J7j5fzPpM3nXPHPXjBCkyNiwYhuTNJX0sPqTKRt+7V
	 xfRJw2VOQn4FQ+Dp+CxlYX7TZ+qnR/nkKtITNj8arV2FROPEQ4opbQF4PJEuQD6V3i
	 3IQXVpBDwg+SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41C8FD8C976;
	Fri, 12 Jan 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: detect testing prog flags support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502722726.15005.11545155266390050447.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 02:40:27 +0000
References: <20240109231738.575844-1-andrii@kernel.org>
In-Reply-To: <20240109231738.575844-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, song@kernel.org,
 jolsa@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jan 2024 15:17:38 -0800 you wrote:
> Various tests specify extra testing prog_flags when loading BPF
> programs, like BPF_F_TEST_RND_HI32, and more recently also
> BPF_F_TEST_REG_INVARIANTS. While BPF_F_TEST_RND_HI32 is old enough to
> not cause much problem on older kernels, BPF_F_TEST_REG_INVARIANTS is
> very fresh and unconditionally specifying it causes selftests to fail on
> even slightly outdated kernels.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: detect testing prog flags support
    https://git.kernel.org/bpf/bpf-next/c/ed145390380d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



