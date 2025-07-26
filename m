Return-Path: <bpf+bounces-64450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9877B12C0F
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3098C542DFD
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 19:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCC28A1DD;
	Sat, 26 Jul 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKxjKAJH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44121288525
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753558195; cv=none; b=tzg+en6tb5HD0Z2DyclW+WyAKKIksDvrWDRWIWz9LmW4y5AjH1euB+S3NzLHimJl5oLLivt1zqC+ZvmTqd8EJ+LDdyNNui5vPN1+cZ1t1zI+WF/AWsCjWSKoWh6tb2oT3Ju0u/NJjH9Q1n+48GF4ZAp9J2t3GUyCwMuTynAvCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753558195; c=relaxed/simple;
	bh=jHQ8FXCqCm/mwTFZklZfeShCB+wAxLWEgPz9+SjJi0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdbpFtybUzCEKg6yMEJyIkqEjApdZAzIkTGaMXLRQkZ359/F4wdJJF/SwUEfSUJqZXu0VyO1R5Ps/TeQD3ey4ry+YCPXPFTBBOVQQvRBAKgOsbynVPxcmpIdJHKmPD64i/wGB4zQ9xOe0BajZSUj+wTwtu0wcjBxPLoEvnqR8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKxjKAJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1274C4CEED;
	Sat, 26 Jul 2025 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753558194;
	bh=jHQ8FXCqCm/mwTFZklZfeShCB+wAxLWEgPz9+SjJi0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HKxjKAJHkqpdOP2EIVcve/wwo22ih7yw1WpE9WkunVZNt1HBkgoj3TYYli2Zk9tEh
	 O3v+unYr89MQkJAfQt/qy5zZLkuOQDlqY3gPOKwqM5CYi8Is9+5Y8hIRRL+mnMmM8a
	 xUhqSQz3PtKLg+7npqjW3mdW5w8ELkJQZR3ty9SmdnQO/j1GETU6UG7p5XFEFoaqa8
	 4xFCN5VbJrdyl3ErsITAphqw91yK6EATxkSP24tmrEe8OEb+4XoWdD8uMX42vjr2Fh
	 lGwAB1c18FxbEgryVoYnXcssK7t1JPLgY7AGRWlSBBZDzLyxE+lL8qu69n/K1ArF1l
	 5ESYcxd1J/2Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339B2383BF4E;
	Sat, 26 Jul 2025 19:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Private stack support for arm64 JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355821175.3674813.4718048770088195151.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 19:30:11 +0000
References: <20250724120257.7299-1-puranjay@kernel.org>
In-Reply-To: <20250724120257.7299-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 mykolal@fb.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 24 Jul 2025 12:02:52 +0000 you wrote:
> Changes in v1->v2:
> v1: https://lore.kernel.org/all/20250722173254.3879-1-puranjay@kernel.org/
> - Divided the patch into 3 patches (Yonghong)
> - Fixed a warning in what is now the second patch (kernel test robot)
> 
> This set enables private stack in the arm64 JIT. The Jited programs use
> access the stack with the BPF FP (arm64 R25) and SP (arm64 SP). When
> using the private stack, BPF FP (arm64 R25) is set to point at the top
> of the private stack and SP is replaced with arm64 R27 and it points at
> the bottom of private stack.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] bpf: move bpf_jit_get_prog_name() to core.c
    https://git.kernel.org/bpf/bpf-next/c/3ba58312e656
  - [bpf-next,v2,2/3] bpf, arm64: JIT support for private stack
    https://git.kernel.org/bpf/bpf-next/c/6c17a882d380
  - [bpf-next,v2,3/3] selftests/bpf: enable private stack tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/e9f545d0d336

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



