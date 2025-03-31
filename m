Return-Path: <bpf+bounces-54924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ED4A75E50
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 06:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019171682CA
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 04:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89981531C8;
	Mon, 31 Mar 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzOlrh4w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F03FFD
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743393597; cv=none; b=nwlLi5y9zx11Y+rDflLc6FeLWpb96wzhh6NKYvudr+KVIv6i0o5IeswqtuvWqzlNkPgEnrlHu6jly4bvxY5XcQyWGhMyz5PKavJfCC5upZCJvy0rh1X1J6xEekSWR6Q6UVvVDmSPDSuMgybhXGWh3q/hxT5nUXFUKReurPkbCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743393597; c=relaxed/simple;
	bh=n2k5TIeMiJPPE85EhmGLwIPw/of/yrJvYsnRcc2mGgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSl6L/p73vDy/8XYa6spmXeIPu11UgHYx0A0YJPZm6SrrQOuQPzW3qNUgtN1wqhLfPoTWP4nBt01OxxwbFaJ7uqv9+FxiOtxo0Aq6Rh8X+P+o9b5UA3SA5muHeJmnx6DIXp4Fmx5UY4QG7+rVi9UXZ0YZAA853268hXGo1HHMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzOlrh4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B389C4CEE4;
	Mon, 31 Mar 2025 03:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743393596;
	bh=n2k5TIeMiJPPE85EhmGLwIPw/of/yrJvYsnRcc2mGgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pzOlrh4w226t2sl5dFfI5NxTugmhihOKCyZFN+18nQvO4h8CyeydlYve1pMLkW4cp
	 B2yARrPaul4BsDWXSMMxH9nRwmziMZpvOJrvWdFnJt03ltfiIQTD6sBYrfD1Y8P8pz
	 ze6wsYMI60XTFv/5Hk0CEdsKDyPgMQY2aSpyXu71lYUGqdY1g7ldi7xMBZIgp0uO7y
	 k6mxPqoFCXhigpygOxH/1DrSHeanhP36wO4dh+mTiog4SzG7afslgb+b9bk9hDiSuJ
	 kBoKVER1+PSERjiw1KCDvmsZPSovn8N3mKJFYnlRyD2gXxgUMyb/RzGhWwlONHzwIT
	 myfNUOgdR5hOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71004380AA7A;
	Mon, 31 Mar 2025 04:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix verifier_private_stack test
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174339363328.3671970.15555565857872714950.git-patchwork-notify@kernel.org>
Date: Mon, 31 Mar 2025 04:00:33 +0000
References: <20250331033828.365077-1-yonghong.song@linux.dev>
In-Reply-To: <20250331033828.365077-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 30 Mar 2025 20:38:28 -0700 you wrote:
> Several verifier_private_stack tests failed with latest bpf-next.
> For example, for 'Private stack, single prog' subtest, the
> jitted code:
>   func #0:
>   0:      f3 0f 1e fa                             endbr64
>   4:      0f 1f 44 00 00                          nopl    (%rax,%rax)
>   9:      0f 1f 00                                nopl    (%rax)
>   c:      55                                      pushq   %rbp
>   d:      48 89 e5                                movq    %rsp, %rbp
>   10:     f3 0f 1e fa                             endbr64
>   14:     49 b9 58 74 8a 8f 7d 60 00 00           movabsq $0x607d8f8a7458, %r9
>   1e:     65 4c 03 0c 25 28 c0 48 87              addq    %gs:-0x78b73fd8, %r9
>   27:     bf 2a 00 00 00                          movl    $0x2a, %edi
>   2c:     49 89 b9 00 ff ff ff                    movq    %rdi, -0x100(%r9)
>   33:     31 c0                                   xorl    %eax, %eax
>   35:     c9                                      leave
>   36:     e9 20 5d 0f e1                          jmp     0xffffffffe10f5d5b
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix verifier_private_stack test failure
    https://git.kernel.org/bpf/bpf/c/07be1f644ff9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



