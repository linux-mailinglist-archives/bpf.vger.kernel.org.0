Return-Path: <bpf+bounces-44674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C74E9C6410
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934C12848D9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6521A4D0;
	Tue, 12 Nov 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTlSTFY3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AF1FEFD9
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449428; cv=none; b=hLIH9H68D2q5PQ36Hxvf9WnI1mCeaE0hoNzuHJs+R4NCqB/256gP1fN+GObFcuYECnxLkr1jGx9omVw7xHo9uNhY+V4zpc9vZq5Ak46SYszdT4CdM5ELVvxlpKNMypXf55adq2GYT767ssp7YZ+mPFzYPx5jkmblGLu4JJ/ABqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449428; c=relaxed/simple;
	bh=EF09Z/7ooXCJrFiDFPAZLcnSCUGpObaufmfKvM1R8UQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o4JroU9W2you6Ph14E3HsQuZZZFwSzvKPWcPVVD+WPibTwPjgalHqLny/XcA3lYS3F91AuUwvccVG38GjJ5eIYpGVfB3hMBMBSV5R1d1jo36XN5rArcTrdrrWnit7HtGSPcvLp9gAa7YYnF45FLiGjYlvh1fsfr6kAGIGIu7esQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTlSTFY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4502DC4CECD;
	Tue, 12 Nov 2024 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731449425;
	bh=EF09Z/7ooXCJrFiDFPAZLcnSCUGpObaufmfKvM1R8UQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XTlSTFY3CBSZ1ChSc7r5xU1mwfYC0s9Wx4OakHIkFz3wv6HJ6socTxOGE0AtoPann
	 /pKkwrezrVxzFujqINOr/94o4WO3J07E5okhNulrCfhK4wTE4sULx1ZeWVR2LFeQMD
	 P+W78XZ1Qy42oRSGZrh2Ot4dNDoCmoKnSvRPw/wRvssTCh0HTMqG1bDFZdh8NsFci3
	 JBmfNjSdLfWVI5Fn8o4+PfmT1VQ7Ms4VKROz+wR7y4CrqwsMOchgPWsesxe6WHGWUu
	 Xgk7WEU/X/FKQ3SdRYV1cElvz22XEKxFhtodeRZhyPAwgPVXCxHm1DL3VL7roZdSLl
	 gelM6oxo6eFLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCEB3809A80;
	Tue, 12 Nov 2024 22:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next 0/4] selftests/bpf: fix for bpf_signal stalls,
 watchdog for test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173144943523.689304.3368076379065536424.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 22:10:35 +0000
References: <20241112110906.3045278-1-eddyz87@gmail.com>
In-Reply-To: <20241112110906.3045278-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 Nov 2024 03:09:02 -0800 you wrote:
> Test case 'bpf_signal' had been recently reported to stall, both on
> the mailing list [1] and CI [2]. The stall is caused by CPU cycles
> perf event not being delivered within expected time frame, before test
> process enters system call and waits indefinitely.
> 
> This patch-set addresses the issue in several ways:
> - A watchdog timer is added to test_progs.c runner:
>   - it prints current sub-test name to stderr if sub-test takes longer
>     than 10 seconds to finish;
>   - it terminates process executing sub-test if sub-test takes longer
>     than 120 seconds to finish.
> - The test case is updated to await perf event notification with a
>   timeout and a few retries, this serves two purposes:
>   - busy loops longer to increase the time frame for CPU cycles event
>     generation/delivery;
>   - makes a timeout, not stall, a worst case scenario.
> - The test case is updated to lower frequency of perf events, as high
>   frequency of such events caused events generation throttling,
>   which in turn delayed events delivery by amount of time sufficient
>   to cause test case failure.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: watchdog timer for test_progs
    https://git.kernel.org/bpf/bpf-next/c/d9d4d127e813
  - [bpf-next,2/4] selftests/bpf: add read_with_timeout() utility function
    https://git.kernel.org/bpf/bpf-next/c/03066ed3105a
  - [bpf-next,3/4] selftests/bpf: allow send_signal test to timeout
    https://git.kernel.org/bpf/bpf-next/c/3209139d00e5
  - [bpf-next,4/4] selftests/bpf: update send_signal to lower perf evemts frequency
    https://git.kernel.org/bpf/bpf-next/c/4edab4c55d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



