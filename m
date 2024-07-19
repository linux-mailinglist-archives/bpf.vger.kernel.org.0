Return-Path: <bpf+bounces-35126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE6E937E03
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D432820F2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CF7E563;
	Fri, 19 Jul 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlXm0a6w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E83A35
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721431834; cv=none; b=Aa9/qOJGbp8wyrSLZRItpR155wZKOyZ+yyk6hWk7mZK7AqBcbEfquJun8RH4bipykNxcbU2tGBcZoE1IuB1dr6EZz5DVDQUgMmSWbYYM4/Dswiu0QIRgVkRiSfawUstxXlNSi0mVWlp04CJXNLrQGVIepATlRJkmnvk4Odu60sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721431834; c=relaxed/simple;
	bh=r/GABZoqAjy34cv6ULWRg4qLzARbkFzQwRSc3FqSS1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CfyChKiwh7xR698gVxSHoPU67VzyOQZdG3n6sHV2JSyXuvmJBa5XShUHQTrQ9uvYa4dZtbkZHEhbmzFhcO9equ3+8Ego5WhGRvKB6BTDnzbZa2X1Hi2LrqC5m6E5lj6iqHLQLKKIL1hBJOrQlFoka3NXxDAR4mRerze+HBVLzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlXm0a6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F981C4AF09;
	Fri, 19 Jul 2024 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721431834;
	bh=r/GABZoqAjy34cv6ULWRg4qLzARbkFzQwRSc3FqSS1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tlXm0a6wjkwqk6joIiIR+LG9uPqt5wg/ZM/2bOczUu4FTRJlCo/3ez/PKC4L3W39Z
	 qz7zUFoLLv8f2jVnAHzYieW+usD5d0vr+Okb4mJTNGVRivchlOO9kMTp53nsXYxZ4B
	 uI3kPPB+s0b38C7VVfqDKRiFT6l7ypa6Ty+FIp+bVViUCwma7X/aIqH03R/ruYfSfB
	 uqRoN1BYCdEGJtZL/CZZVwTIjoDOtT0xcqSp4SxvXLGLG7vMIBLpxd6tSsZ8AuYqmE
	 RBkcAXG5rM0Sa8hOwS735xYwsFMOUH92XX88rfncK02Jf+6zbOoTnnvL296RlWYz2b
	 zN2Li79FpFW8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A575C4332D;
	Fri, 19 Jul 2024 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v3 0/4] bpf: track find_equal_scalars history on
 per-instruction level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172143183410.24994.4836120843832681005.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jul 2024 23:30:34 +0000
References: <20240718202357.1746514-1-eddyz87@gmail.com>
In-Reply-To: <20240718202357.1746514-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, sunhao.th@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 18 Jul 2024 13:23:52 -0700 you wrote:
> This is a fix for precision tracking bug reported in [0].
> It supersedes my previous attempt to fix similar issue in commit [1].
> Here is a minimized test case from [0]:
> 
>     0:  call bpf_get_prandom_u32;
>     1:  r7 = r0;
>     2:  r8 = r0;
>     3:  call bpf_get_prandom_u32;
>     4:  if r0 > 1 goto +0;
>     /* --- checkpoint #1: r7.id=1, r8.id=1 --- */
>     5:  if r8 >= r0 goto 9f;
>     6:  r8 += r8;
>     /* --- checkpoint #2: r7.id=1, r8.id=0 --- */
>     7:  if r7 == 0 goto 9f;
>     8:  r0 /= 0;
>     /* --- checkpoint #3 --- */
>     9:  r0 = 42;
>     10: exit;
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] bpf: track equal scalars history on per-instruction level
    https://git.kernel.org/bpf/bpf-next/c/2b7350d7ca65
  - [bpf-next,v3,2/4] bpf: remove mark_precise_scalar_ids()
    https://git.kernel.org/bpf/bpf-next/c/cb0f94d85874
  - [bpf-next,v3,3/4] selftests/bpf: tests for per-insn sync_linked_regs() precision tracking
    https://git.kernel.org/bpf/bpf-next/c/c0087d59e504
  - [bpf-next,v3,4/4] selftests/bpf: update comments find_equal_scalars->sync_linked_regs
    https://git.kernel.org/bpf/bpf-next/c/f081cd17c0bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



