Return-Path: <bpf+bounces-39638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E9975936
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFC02889FB
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3F1B29C1;
	Wed, 11 Sep 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB8HVMGZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83864A8F
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075229; cv=none; b=omYsZREEriJOPaBf8rxespTSVNMj8KW2+Rabg/DCGLqnMdijvGAkYd1+j3mdiu94Ivrli0Hq+q0VL/Sc/gwV4n/MXsrhpASkmqkJao7hQ7NHFPiaBT+k6/YQOVcHFO1qgpwYKQUkRC+kKxL2ZGtJZk75Hdb57BqzUbnS8vXj5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075229; c=relaxed/simple;
	bh=xLPen+rbjMKYuxqBAJdnv6DAwr6bkeAoTr88jW9LgSA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N84p0yf+lIrTSWZ7o0lCifjWyfSNQpbSL/ZPTb5AbobGM29MByZwolmx55JFL057UGSLImGgRCQjSttiLuwhhmIaGrXSVCOHU69mSMx24K5HuM2Qst70NDFfgzYfGynHkuf+K5trqVQElr5utxqnom1J9Iopxpebz09qi6sT5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB8HVMGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D56C4CEC7;
	Wed, 11 Sep 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075228;
	bh=xLPen+rbjMKYuxqBAJdnv6DAwr6bkeAoTr88jW9LgSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aB8HVMGZBzUE0I5UzSCfzV4Xy9gRU981C+BHEpVkgOlFi2E/EmdqdI0foDn6y3qth
	 q1H0yJUL+paqRZlH1KUs9u2sd32PUjoAkR/FlgGCLG1CHTBgdbyZF8a90pPR2RislG
	 AtkjDrm/Yuo34TWQYpAt1zdioGEmsDAyTUeFfQ2ScIC6bJmjPcYilblBfIpuGdZr+E
	 CHh8iDCmCQdK6PCeFNAdM3A2vzS7nb4AcDwqk8K9WI6BL3JzgD8XqxWAH5zyTJcyhd
	 nr3vWuXdxHS3TMy4Aox92Sj0GNUs7rkVkW4AzLgx3Sl8/jYEgL3IVDoBKQfC+anVxH
	 kzlJz/l1Axrdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7B53806656;
	Wed, 11 Sep 2024 17:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Fix arena_atomics failure due to
 llvm change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172607522950.991126.876331589065223043.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 17:20:29 +0000
References: <20240909223431.1666305-1-yonghong.song@linux.dev>
In-Reply-To: <20240909223431.1666305-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  9 Sep 2024 15:34:31 -0700 you wrote:
> llvm change [1] made a change such that __sync_fetch_and_{and,or,xor}()
> will generate atomic_fetch_*() insns even if the return value is not used.
> This is a deliberate choice to make sure barrier semantics are preserved
> from source code to asm insn.
> 
> But the change in [1] caused arena_atomics selftest failure.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Fix arena_atomics failure due to llvm change
    https://git.kernel.org/bpf/bpf-next/c/2897b1e2a2f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



