Return-Path: <bpf+bounces-33652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5347E9243BC
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8752826CD
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9A1BD4FD;
	Tue,  2 Jul 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBuXBQCr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D215B104
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938436; cv=none; b=GodyGHKm438seIJRRdi2fcYzv5hCa8bGy0h7FP09GAC1+1i2B0wBmhE9dMpe4CKbAiFij/lCUDjdzhCqJvTcuQzB8q+r3v6BoCHLp0E0K/V5TP+nLz40Gv/EcaWy0v05CfV22klV/7eMx4HQLA8ohhYZY3l9whxZRIRDDvZbJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938436; c=relaxed/simple;
	bh=CChBX4hw/tFKGTMBJqHljXHoxP9MsxgpfS4TB+3ZADE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SV9DKYWIng9yU4dosIM9mYSY9p1F9sQI/goJslhdkKcQo3ojQfywxGZVEuiwQMl8/YNnxY2orUyHFAvohqlyDCKA0aq3bqblMh4qVWZ0uaicH1eQbwwWTNtbI7x1vcOA3wdwVqYPOOynA/aVq0B39d1ohrITRKe1XiJbUloiOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBuXBQCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0987BC4AF07;
	Tue,  2 Jul 2024 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938436;
	bh=CChBX4hw/tFKGTMBJqHljXHoxP9MsxgpfS4TB+3ZADE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rBuXBQCrUt6Y9ndP3xa3/ZqSBxLOqNC8Xf5JSzTw+lJsQr8/Lgo3r3zuyE85KOXB8
	 jLudtxCXlfb+E9uWOMnry07N5KWldn414m01G5rXxGJaZwviT/kAQl89ExI0cVpNmL
	 UTmNzG8padfITfVFTm5pBOHwmbp1PAE0MHWuFqXZ22z/PMTd2tQwsqUAK07GhIkRPF
	 nq+7iXH93DtGRSTCc94ea50LrNDkKm2ymVF5j5KUbZ4h+wxGMZHc1chzwrSO1JXmk8
	 V1VfD19VvyLSmx7QARDnl4lrY7/mR2vKBfiVQvPbT4dsXzMfUfejJAAnh5oGl67ACI
	 YXgW5rmVBVFZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC043C43601;
	Tue,  2 Jul 2024 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/12] s390/bpf: Implement arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171993843596.14841.16552310149645928981.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 16:40:35 +0000
References: <20240701234304.14336-1-iii@linux.ibm.com>
In-Reply-To: <20240701234304.14336-1-iii@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Jul 2024 01:40:18 +0200 you wrote:
> v2: https://lore.kernel.org/bpf/20240701133432.3883-1-iii@linux.ibm.com/
> v2 -> v3: Fix bpf-gcc build issue.
> 
> v1: https://lore.kernel.org/bpf/20240627090900.20017-1-iii@linux.ibm.com/
> v1 -> v2: Add a zero-extension fix.
>           Fix wrong jump offset in the BPF_XCHG implementation.
>           Do not run the UAF test on x86_64 and arm64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/12] bpf: Fix atomic probe zero-extension
    https://git.kernel.org/bpf/bpf-next/c/df34ec9db6f5
  - [bpf-next,v3,02/12] s390/bpf: Factor out emitting probe nops
    https://git.kernel.org/bpf/bpf-next/c/d0736d8c491d
  - [bpf-next,v3,03/12] s390/bpf: Get rid of get_probe_mem_regno()
    https://git.kernel.org/bpf/bpf-next/c/9a0485872691
  - [bpf-next,v3,04/12] s390/bpf: Introduce pre- and post- probe functions
    https://git.kernel.org/bpf/bpf-next/c/89b933a20137
  - [bpf-next,v3,05/12] s390/bpf: Land on the next JITed instruction after exception
    https://git.kernel.org/bpf/bpf-next/c/a1c04bcc41f9
  - [bpf-next,v3,06/12] s390/bpf: Support BPF_PROBE_MEM32
    https://git.kernel.org/bpf/bpf-next/c/4d3a453b434f
  - [bpf-next,v3,07/12] s390/bpf: Support address space cast instruction
    https://git.kernel.org/bpf/bpf-next/c/555469cc9be4
  - [bpf-next,v3,08/12] s390/bpf: Enable arena
    https://git.kernel.org/bpf/bpf-next/c/1e36027e39b8
  - [bpf-next,v3,09/12] s390/bpf: Support arena atomics
    https://git.kernel.org/bpf/bpf-next/c/2f9469484a3b
  - [bpf-next,v3,10/12] selftests/bpf: Introduce __arena_global
    https://git.kernel.org/bpf/bpf-next/c/b6349fd3448c
  - [bpf-next,v3,11/12] selftests/bpf: Add UAF tests for arena atomics
    https://git.kernel.org/bpf/bpf-next/c/490c99d4ed99
  - [bpf-next,v3,12/12] selftests/bpf: Remove arena tests from DENYLIST.s390x
    https://git.kernel.org/bpf/bpf-next/c/69716e44a74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



