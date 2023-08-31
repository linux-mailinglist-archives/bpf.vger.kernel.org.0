Return-Path: <bpf+bounces-9091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB478F40E
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F10F1C20B38
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144C1AA6F;
	Thu, 31 Aug 2023 20:30:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F21AA7A;
	Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D5ADC433CA;
	Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693513823;
	bh=pqDP+zEjFuzOiOs+tgYZ2bf6Znca1Xga7yBy0aQPi+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ooVFYbMxXlHYHm4YaqNS1xoSE9JBmMv8jqfJKHpQZIO6cDiE3SZrJ2aXUX6wnNDRD
	 eQvkSy5aBlXCzLl/ATveA1MahYzTx4L2vVR0o3WhoKUdYgN8uKfAqjaPm7g3144mf9
	 LkclpeW72riSzwlZ2ZlS2b0upGgf6IKGC5hm2hLPmqusx1YFJDQruep/MKu8jnnpRc
	 POfwMFqDjDcOb/4hdhpyc2G5q2Mfl7NDR2qezaRZppw4u72nbuy0yQphcsvLtuBOTe
	 LNaa74fo9QWQxdAHDGrC8DOpzMVr6VhMreUk/CCZN7Ambaq4iCIcP2aPImHxTJslcg
	 8aDq6hMNektfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 617A1E29F33;
	Thu, 31 Aug 2023 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Include build flavors for install
 target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169351382339.13181.6255269847761617623.git-patchwork-notify@kernel.org>
Date: Thu, 31 Aug 2023 20:30:23 +0000
References: <20230831162954.111485-1-bjorn@kernel.org>
In-Reply-To: <20230831162954.111485-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, bjorn@rivosinc.com,
 ast@kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 31 Aug 2023 18:29:54 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> When using the "install" or targets depending on install,
> e.g. "gen_tar", the BPF machine flavors weren't included.
> 
> A command like:
>   | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/workspace/kbuild \
>   |    HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 sgx" \
>   |    -C tools/testing/selftests gen_tar
> would not include bpf/no_alu32, bpf/cpuv4, or bpf/bpf-gcc.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Include build flavors for install target
    https://git.kernel.org/bpf/bpf/c/be8e754cbfac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



