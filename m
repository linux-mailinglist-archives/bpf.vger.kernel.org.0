Return-Path: <bpf+bounces-1235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72C7111E7
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE391C20E9E
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E81DDC3;
	Thu, 25 May 2023 17:20:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0451D2A2
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3644DC4339B;
	Thu, 25 May 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685035220;
	bh=sNHh583kYdyOHk/LEWyXyMXsg8XV0ZJeXzsb9NMleD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W6M4I2ajLTpXsuGSpDu9pmMKvAQoIMuyC40F4mqS3os4kxzX+EjkAke0e8baVcnXZ
	 ULRNIYQBDTxM1HcnDkF8M7g/iOZQQGf11tOvB6fH9QDs0pA/pC/QQyUcu3ht3ubLZg
	 Acwz2kh5e5e8XNhw5Rf+MZJBCUW0x3xdqi2/RKg8XPjjGqjHdlToojkWjTv7FIDE0X
	 +3p2H+PUV2UVZ5ZdefUQUWnK/k1h8ltw9JvXmxfztEqL0a3yjR5959hcZO7bYR8vkx
	 Z4qkYsX1IH5AAnSQWOp/ZAXU/9BHY+6II9hvE5lZ6R6mc5p1TnWjswDvM2jsUGfJLj
	 mm9ZCq1Ot3epA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C59FC4166F;
	Thu, 25 May 2023 17:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] Relax checks for unprivileged bpf() commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168503522010.4912.11240829568317302879.git-patchwork-notify@kernel.org>
Date: Thu, 25 May 2023 17:20:20 +0000
References: <20230524225421.1587859-1-andrii@kernel.org>
In-Reply-To: <20230524225421.1587859-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 24 May 2023 15:54:18 -0700 you wrote:
> During last relaxation of bpf syscall's capabilities checks ([0]), the model
> of FD-based ownership was established: if process through whatever means got
> FD for some BPF object (map, prog, etc), it should be able to perform
> operations on this object without extra CAP_SYS_ADMIN or CAP_BPF capabilities.
> 
> It seems like we missed a few cases, though, in which we are still enforcing extra caps for no good reason, even though operations are not really unsafe and/or do not require any system-wide capabilities:
>   - BPF_MAP_FREEZE command;
>   - GET_NEXT_ID family of commands;
>   - GET_INFO_BY_FD command has extra bpf_capable()-based sanitization.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] bpf: drop unnecessary bpf_capable() check in BPF_MAP_FREEZE command
    https://git.kernel.org/bpf/bpf-next/c/c4c84f6fb2c4
  - [bpf-next,2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
    (no matching commit)
  - [bpf-next,3/3] bpf: don't require bpf_capable() for GET_INFO_BY_FD
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



