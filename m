Return-Path: <bpf+bounces-6755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13C76D941
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEFE281DCF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FF9125BC;
	Wed,  2 Aug 2023 21:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F101111AD;
	Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A16EDC433C8;
	Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691010621;
	bh=U6fwEY6CTug5r3b9WDLABmO5cBrj/XDZhdVoueKrQtc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y2kTcAN3AYkOVOEGiwmAZkCCdIQ9M9IKrP+EDBGrQD9Ej//4M9AwTvVAUQCnYXhQM
	 NvD/5tevUYJM9WqfvhkC2cseOVDORAh+RnmFQk/8fjlRXlWSSFuwERNeelqnojK8nQ
	 OEBHMgdDM/L8ih49+XTb6rrSyTqsKZbHdFMoBl2uxdGaOwK9KtBxnTjkdvxTLhAV6r
	 oTH7B3n5fAnpJ6x1m8nBpst8c3n9MHn6ZOKsaIOisT5nQyNeU4TdcAB1RVFyxazsXZ
	 mjdsWBCVY9KRtdvFhBbuu/dKs+RuXGWZY1TZ/7ahklfVevr3SPanEy8/KLCmrneEFj
	 +8QDeN634tY6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E99E270D3;
	Wed,  2 Aug 2023 21:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv,
 bpf: Adapt bpf trampoline to optimized riscv ftrace framework
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169101062152.23031.14952859291909120655.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 21:10:21 +0000
References: <20230721100627.2630326-1-pulehui@huaweicloud.com>
In-Reply-To: <20230721100627.2630326-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@kernel.org,
 palmer@dabbelt.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 guoren@kernel.org, suagrfillet@gmail.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Jul 2023 18:06:27 +0800 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
> half") optimizes the detour code size of kernel functions to half with
> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
> is based on this optimization, we need to adapt riscv bpf trampoline
> based on this. One thing to do is to reduce detour code size of bpf
> programs, and the second is to deal with the return address after the
> execution of bpf trampoline. Meanwhile, we need to construct the frame
> of parent function, otherwise we will miss one layer when unwinding.
> The related tests have passed.
> 
> [...]

Here is the summary with links:
  - [v2] riscv, bpf: Adapt bpf trampoline to optimized riscv ftrace framework
    https://git.kernel.org/bpf/bpf-next/c/25ad10658dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



