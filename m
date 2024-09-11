Return-Path: <bpf+bounces-39653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25C975BC3
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558B7287402
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02F91BA894;
	Wed, 11 Sep 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhubHLa9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798B1B9B46
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086632; cv=none; b=b6xco69QLlEGZqN7EuS+wQ1zB2XfFIGLzE+8cCnB6X5nRbHltr7sKJrcpajuD0aSC6ZpC/j7eEs4B6LlSz4K8cinGhLo2SwPdOJlJjo+Ft0uGkkcX08pff3c4wxmiUycZk6RvCRiHckPQm80jHNc+DB42Ipfzy9PQ17OdmejBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086632; c=relaxed/simple;
	bh=sKArP0iv7ydz3yZZcqe+lyIpwBxjqgB2ECOMgi8C0lA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVqU2rMiFlJu8jBg3gr8QEFkjiUJXnA4zVIf4jdRvWnNTgNYzEp76VsjSjEcaR0D3M6HNtdWYgrb6hu1PzVcas9ghR9Ns+AwHhM3JUHWpsNo2Sb7Ubw4F6e3SAFYe5Caz3ryKpt6zQKj0j/c7mnf6K45ySNae7z7PxCcLQjYJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhubHLa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF5C4CECC;
	Wed, 11 Sep 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726086630;
	bh=sKArP0iv7ydz3yZZcqe+lyIpwBxjqgB2ECOMgi8C0lA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IhubHLa9nvR0Usny3SFEDAzsaOgS009CLeU7K0/TE8EyPK4++qLuLGWy8gshOnWR4
	 C+9hbOmn+iDyJRpaL1EX/hN6354swkLFw5yvlXpu/UHvHF7E6EZ60rsCQidOF/gQhC
	 xPN23d71xaQAzcTlrn8DhxsDAdaJyVTNkPSsaVQFHwI6M2GU4zxHxCTqDjdcWxYaNi
	 aWzxAkr1vPhaeBS31+v0NKfeiFqmFsdYU+20r6znyNxaBPAA1YKctlfGNociK2sZwf
	 v0z+5NyJwZZ8SL4H4TedxzOskOCh2z4FjUlBvYc1ZUyFwGyfxJEYwPUB/Zcy6PpoVU
	 +TxvhsJE0mBnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0043806656;
	Wed, 11 Sep 2024 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172608663176.1037972.15071231307249153305.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 20:30:31 +0000
References: <20240910214037.3663272-1-yonghong.song@linux.dev>
In-Reply-To: <20240910214037.3663272-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 salvabenedetto@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 10 Sep 2024 14:40:37 -0700 you wrote:
> Salvatore Benedetto reported an issue that when doing syscall tracepoint
> tracing the kernel stack is empty. For example, using the following
> command line
>   bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack\n"); print(kstack()); }'
>   bpftrace -e 'tracepoint:syscalls:sys_exit_read { print("Kernel Stack\n"); print(kstack()); }'
> the output for both commands is
> ===
>   Kernel Stack
> ===
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Use fake pt_regs when doing bpf syscall tracepoint tracing
    https://git.kernel.org/bpf/bpf-next/c/376bd59e2a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



