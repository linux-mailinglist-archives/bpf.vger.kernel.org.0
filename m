Return-Path: <bpf+bounces-59984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B55DAD0AF9
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AA83B2C8B
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A1259CAB;
	Sat,  7 Jun 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkkiyVrV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886B258CED
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749263402; cv=none; b=FgLxxmaYQIA1MjbKPIggmaoio1scm8iZyoKc1DZajPcnUZaNGkDk+h8OecSk+9gJHdJzZ/H4qqjxmlv9265seWjlaeJ0xSxz/V3iHQr4wj15mHeIxNM2BRTtgFVYjWGnG98O4gN38DaAJ7D5a6Ohk0wDPaQQ2mBjM/kprSbb5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749263402; c=relaxed/simple;
	bh=PvwPmkGYBvaBNKWQCbjkp4fya8NfXtklQQVpnoASOOQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etDG2UrvpmjhsGm6keTQxMnhkGCvy1XHhbBvARDjJgA0IEDUEG4Zgs8yvlSbm8wHZ8yXONiuk58bpx4QTUnIBfEcxnt6t743xQyIcKsm1BocjW5o7xzlIVgWbQyKog1A9uldOgrHbdodLK5aWvyHmmlSnzek4z+aZa7ACFwklmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkkiyVrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A33C4CEEB;
	Sat,  7 Jun 2025 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749263402;
	bh=PvwPmkGYBvaBNKWQCbjkp4fya8NfXtklQQVpnoASOOQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QkkiyVrVfk3kUuqMRADWUlhn9cxrFBtGLgFEeg0MOdtVAQX/f05D7cfx9Vnu0tRre
	 W8P58io0Ztn8pSH8LBhUOjqhGKXDuT8PxBNZfWE8pY3fYUIPah0Hw7gZ1aK2PHVM3Q
	 YOTxRgQgGRTuI31uC8cE/pPp0uRJOHgu9HKt1UoM+MrV8WIPUGEMavlMauak3y8FU4
	 yiVnZQ06As1kcrFEd1mVR04OQ5rapPKHClarOegA4iFDJjtH+YeRLygQO5A/iWwR9q
	 e2L9LpdXrax3Skc41KMoPgz+qtCFbkt0smlXG5L0zBcl69F4xZ4hRGAXam4x25p6i3
	 LwS9H/EuqKHFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB13806649;
	Sat,  7 Jun 2025 02:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/4] selftests/bpf: Fix a few test failures
 with
 arm64 64KB page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174926343400.4065959.16518552978353161599.git-patchwork-notify@kernel.org>
Date: Sat, 07 Jun 2025 02:30:34 +0000
References: <20250607013605.1550284-1-yonghong.song@linux.dev>
In-Reply-To: <20250607013605.1550284-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  6 Jun 2025 18:36:05 -0700 you wrote:
> My local arm64 host has 64KB page size and the VM to run test_progs
> also has 64KB page size. There are a few self tests assuming 4KB page
> and failed in my environment.
> 
> Patch 1 reduced long assert logs so if the test fails, developers
> can check logs easily. Patches 2-4 fixed three selftest failures.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/4] selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
    https://git.kernel.org/bpf/bpf-next/c/ae8824037a0a
  - [bpf-next,v4,2/4] selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
    https://git.kernel.org/bpf/bpf-next/c/377d3715900c
  - [bpf-next,v4,3/4] selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB page size
    https://git.kernel.org/bpf/bpf-next/c/8c8c5e3c854a
  - [bpf-next,v4,4/4] selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
    https://git.kernel.org/bpf/bpf-next/c/bbc7bd658ddc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



