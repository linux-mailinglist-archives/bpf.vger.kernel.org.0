Return-Path: <bpf+bounces-4332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145C74A58D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12841C20E0F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AE154AE;
	Thu,  6 Jul 2023 21:10:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17B63BA;
	Thu,  6 Jul 2023 21:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62168C433CA;
	Thu,  6 Jul 2023 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688677829;
	bh=r0kK6Q/5EIs8ECrWV3m193nP6zDw8DILs2c7Ih39kOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lpoM5kp+XBh8FPwCD+3OLJgCWtExHyKo2Ezck5g/mkCSFGxOLt5ZjdCPrB9TL8vBG
	 8lBilZvmjnpnPJoNmOaO7rmOosKvee5fAGW6GDPIQte++EB0ejwPkfXE0+jHus5peO
	 5rLfa7FQJdu/BvJWtjJopfwKgkPoNX4+Esc47r/svBVAcMQmexQ8N/xPg3Swb7nMZ/
	 fZEmRZcK5F5I2k+1UYe8USSzEwmPpaeNCSXCM+KqV1bwePy4eYa9ThLlxgETPGNJXT
	 /lLB39c4c37h02GWle2ak3mSbFFmn/fqwYLVR0h/A/R/fq26I3jRlH2vkON2HgPBCZ
	 stgnEMr+YfSww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EBCEE5381B;
	Thu,  6 Jul 2023 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168867782925.19494.7717001810373235391.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jul 2023 21:10:29 +0000
References: <20230706142228.1128452-1-bjorn@kernel.org>
In-Reply-To: <20230706142228.1128452-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, bjorn@rivosinc.com, ast@kernel.org,
 daniel@iogearbox.net, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  6 Jul 2023 16:22:28 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
> buffer overrun if the number of syms on the system is larger than
> MAX_SYMS.
> 
> Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
> the maximum is reached.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Bump and validate MAX_SYMS
    https://git.kernel.org/bpf/bpf-next/c/e76a014334a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



