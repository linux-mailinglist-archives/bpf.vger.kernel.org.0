Return-Path: <bpf+bounces-45881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF19DEAD5
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 17:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6493E282794
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783D19F104;
	Fri, 29 Nov 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOUtq4Ho"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255FD14AD3D;
	Fri, 29 Nov 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897217; cv=none; b=nuaoLYoIX+3tVUHGiDD8WTeW+IglESyr69XQ0xsNcgOHWGT+6de/+sM1xnRoJ7g8fEaxtiA77jyx/oP6MOvZYbjFarFrWRw1p+La+dPR1HRgvtCWpnivwia1Th6BMgbb10sKx5yLVmqZuj1nzu0c23RPWH7jxfaRqydVbiNKreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897217; c=relaxed/simple;
	bh=euN+eAhlu9UIjsZJy6+2NNI8i9i1qM3tGs8d5y8GE9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tQWO/eZj69pQcZr93kZgY8i2joSloC85BhE1jK+VfytmyUdmCqAd2QDvJlv+tOUZZMYRbae7KJ4b07biAvQD5QizLvMKv12t1/3aznFY0GDZVnya9RCat1iNQE7VNyceJe/D/znJQF8UyasnewgP5UhEzOcRmKr2Esh2vvKE9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOUtq4Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC7C4CECF;
	Fri, 29 Nov 2024 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732897216;
	bh=euN+eAhlu9UIjsZJy6+2NNI8i9i1qM3tGs8d5y8GE9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vOUtq4HoFWjFonhi/D+d+uFXfo5g9tWybrvvz8U5M3uRSm8hKeRshXzM/t+R8sS+b
	 AAKWamZ4vuPsJUg/LFB7Lu5m02yk1MdsQeD2cArQfng9dptMbfOQGhFn+CTjuu4FjI
	 ES5k6tsf1XeJnz7K/NbQctCewXqfAVcUsnx5EREY9T6gQyM6dmpWI8yVXzemPMnJ3o
	 mPPtwGymJzwFNioSfCxnoQBq5u+/JWTJ0vKcg2VKEe1eYVahwtVFt9kO/jBK+2DMlQ
	 8hg5mjfvXexsYX3XcFuwAHod/ww0j+rPZlplWKVvsoORo4qD4pLRjaTvxmh59jTgGJ
	 VJwLDGUqLpWaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4F380A944;
	Fri, 29 Nov 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if defined,
 but empty
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173289723001.2112878.15562925301764191816.git-patchwork-notify@kernel.org>
Date: Fri, 29 Nov 2024 16:20:30 +0000
References: <20241127101748.165693-1-bjorn@kernel.org>
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
 alexghiti@rivosinc.com, acme@redhat.com, jean-philippe@linaro.org,
 qmo@kernel.org, andrii.nakryiko@gmail.com, bjorn@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 davidlt@rivosinc.com, namhyung@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 27 Nov 2024 11:17:46 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] tools: Override makefile ARCH variable if defined, but empty
    https://git.kernel.org/bpf/bpf/c/537a2525eaf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



