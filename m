Return-Path: <bpf+bounces-8067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755A780CF6
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B832C1C215E2
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF218B11;
	Fri, 18 Aug 2023 13:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB5182B6
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 13:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1277CC433C9;
	Fri, 18 Aug 2023 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692366622;
	bh=mcW0nOegIRP7Rkka3bLiW1/6nk3ZGWuiqdXYYeIE3Bg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bonyM04OymaiOva4gyX7S9Qw+NGBMN25Myv9cNV2X7AUCiPFU6KjvXpTJDrE3wylt
	 QBgtPdE1s4DsD5qOdFFoNbBwKH2UaleCEdYNy86F+UQ2nGUg/efL7FiLQdgqA+y+bg
	 hY2/Vk5FieYDLX642Oi47T89PUN67KTir/GNE5wUJ7ioyuWAomQWcWXgsW7JEAYaAf
	 4qfsux8ZJVzocUBfhNaQKhYv8PNw5DQUtgElHdYkLqedSDwdbFuBT8EvfQZruBsZSo
	 EKu77ZizKbGYbPuqEcJ/RJI6L7SsB6PiHA9QgOtemPQdjt5JU3OJf7ftkciVt0FmBt
	 2cT/WL1y4DTiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA864E1F65A;
	Fri, 18 Aug 2023 13:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/7] Support cpu v4 instructions for arm64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169236662195.1676.7648597269343903207.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 13:50:21 +0000
References: <20230815154158.717901-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230815154158.717901-1-xukuohai@huaweicloud.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ast@kernel.org,
 andrii@kernel.org, catalin.marinas@arm.com, daniel@iogearbox.net,
 martin.lau@linux.dev, will@kernel.org, mark.rutland@arm.com, yhs@fb.com,
 zlim.lnx@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 15 Aug 2023 11:41:51 -0400 you wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> This series adds arm64 support for cpu v4 instructions [1].
> 
> [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/
> 
> Xu Kuohai (7):
>   arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
>   bpf, arm64: Support sign-extension load instructions
>   bpf, arm64: Support sign-extension mov instructions
>   bpf, arm64: Support unconditional bswap
>   bpf, arm64: Support 32-bit offset jmp instruction
>   bpf, arm64: Support signed div/mod instructions
>   selftests/bpf: Enable cpu v4 tests for arm64
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/7] arm64: insn: Add encoders for LDRSB/LDRSH/LDRSW
    https://git.kernel.org/bpf/bpf-next/c/6c9f86d3632c
  - [bpf-next,2/7] bpf, arm64: Support sign-extension load instructions
    https://git.kernel.org/bpf/bpf-next/c/cc88f540da52
  - [bpf-next,3/7] bpf, arm64: Support sign-extension mov instructions
    https://git.kernel.org/bpf/bpf-next/c/bb0a1d6b49cb
  - [bpf-next,4/7] bpf, arm64: Support unconditional bswap
    https://git.kernel.org/bpf/bpf-next/c/1104247f3f97
  - [bpf-next,5/7] bpf, arm64: Support 32-bit offset jmp instruction
    https://git.kernel.org/bpf/bpf-next/c/c32b6ee514d2
  - [bpf-next,6/7] bpf, arm64: Support signed div/mod instructions
    https://git.kernel.org/bpf/bpf-next/c/68b18191fe41
  - [bpf-next,7/7] selftests/bpf: Enable cpu v4 tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/5f6395fd0680

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



