Return-Path: <bpf+bounces-13315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9858B7D82AB
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B206B1C20ED4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727A2DF94;
	Thu, 26 Oct 2023 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upWBCmgh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958752DF90
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 12:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DE28C433C7;
	Thu, 26 Oct 2023 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698323424;
	bh=csp+oM0xv4kwYcz/h952f3S7Hxy2CNLBqmvdA5uaNcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=upWBCmghHSX0dTh7S1F047c4tqrdz2vMpojzngnAsZoyWuGJc6Ohqy+xJEIwElpbm
	 MgrlG5SOEREhVj+qMlPehlMCzjDjDDmNc3E95dvPj2lhIe/UlVQm8ZDju1t/9DO6Kg
	 A/3CL9ClESv3hhQvGK14pgvvdXP+BRx1lTc0Mbx3Jj+crbeks0CGaGwiKXP0xn7bZC
	 GF42eTVEvADE7+LNJJ2gt1SVqn4VFHYjIlhlYNSMYMCv5Axz+qeZeEYHqPGiFj79np
	 2Dh5QqvFXuBCkegNAI4T+FORHMfcZpksaM1ozgQWjjZgvB9/BeSTFZCgpAx/cLMx09
	 Jggkuz5vXrQaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3AE4E11F55;
	Thu, 26 Oct 2023 12:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Add more WARN_ON_ONCE checks for mismatched
 alloc and free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169832342392.26166.17186680686988219478.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 12:30:23 +0000
References: <20231021014959.3563841-1-houtao@huaweicloud.com>
In-Reply-To: <20231021014959.3563841-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 21 Oct 2023 09:49:59 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There are two possible mismatched alloc and free cases in bpf memory
> allocator:
> 1) allocate from cache X but free by cache Y with a different unit_size
> 2) allocate from per-cpu cache but free by kmalloc cache or vice versa
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Add more WARN_ON_ONCE checks for mismatched alloc and free
    https://git.kernel.org/bpf/bpf-next/c/c421c12586b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



