Return-Path: <bpf+bounces-12207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0D7C9119
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 01:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4545E282CB5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE102C84F;
	Fri, 13 Oct 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU871qmM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C224DF
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EAEAC433C9;
	Fri, 13 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697238025;
	bh=kJnbQgXK7RKgNaW35oPGIpdwdf8c5n/5J9m3sbU+gzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AU871qmMcCw7kFnj+GnkjDRSVZ60j7Fnbo+mvT5F2MINycf1o7g2ARjooyzurT7PS
	 uD3c+Usu/Mo/pnGHYSJRzgSXIQ5fWxXgw6M0kDqsjk6+Kdu4VIgHvM9Vxs2NPbc7Ye
	 UWkaYG7RPjHkg1YSwqTzynyHySYrdXs4H0JXOdlLA6bO77uliqNhMQHke13Uk6nWX6
	 X4GILBpSy+HcRolTdFHb55PgdF47lEVw0JEx1VivIDNzH8OKStnQLGPeb8iXC5ixLB
	 cXB4IXpXFXigj882CqewwhM89KYH/VC6AAnM9QPnIsnmvmtQWmYC71Zg4StNCert3e
	 LNqYoqZcdekLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C4F3E1F666;
	Fri, 13 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 bpf-next 0/5] Open-coded task_vma iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169723802511.13796.5689188744998758174.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 23:00:25 +0000
References: <20231013204426.1074286-1-davemarchevsky@fb.com>
In-Reply-To: <20231013204426.1074286-1-davemarchevsky@fb.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Oct 2023 13:44:21 -0700 you wrote:
> At Meta we have a profiling daemon which periodically collects
> information on many hosts. This collection usually involves grabbing
> stacks (user and kernel) using perf_event BPF progs and later symbolicating
> them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
> remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
> those cases we must fall back to digging around in /proc/PID/maps to map
> virtual address to (binary, offset). The /proc/PID/maps digging does not
> occur synchronously with stack collection, so the process might already
> be gone, in which case it won't have /proc/PID/maps and we will fail to
> symbolicate.
> 
> [...]

Here is the summary with links:
  - [v7,bpf-next,1/5] bpf: Don't explicitly emit BTF for struct btf_iter_num
    https://git.kernel.org/bpf/bpf-next/c/f10ca5da5bd7
  - [v7,bpf-next,2/5] selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
    https://git.kernel.org/bpf/bpf-next/c/45b38941c81f
  - [v7,bpf-next,3/5] bpf: Introduce task_vma open-coded iterator kfuncs
    https://git.kernel.org/bpf/bpf-next/c/4ac454682158
  - [v7,bpf-next,4/5] selftests/bpf: Add tests for open-coded task_vma iter
    https://git.kernel.org/bpf/bpf-next/c/e0e1a7a5fc37
  - [v7,bpf-next,5/5] bpf: Add BPF_KFUNC_{START,END}_defs macros
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



