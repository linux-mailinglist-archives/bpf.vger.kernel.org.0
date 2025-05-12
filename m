Return-Path: <bpf+bounces-58040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA3AB401E
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FD619E1068
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B588255222;
	Mon, 12 May 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QexmsXYM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A01D2550A3
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072197; cv=none; b=SDwhIPLNNQ7FbNFwywbmnPvMpgJq1SQjRryh3Mp1juEosBbkOmLyoRMjkiY2p3OqJccBJo2J/oLkSqel7vTvebbS7KoBIFK+Zgaooz8EEJfU/7vLhMzUL/aeq5tEz1Gp07ARmza1+N5oUxzZWwt6H1luS5RT3H7e/d93GhnnuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072197; c=relaxed/simple;
	bh=S4q4nDw1iH7472rL+wG++fjWQE0nz1FdkDJBJpJHy/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYEyikITdPt/Kw6uuW25BSMWKnkZhfotvnrPkEBHT7nNmbEXn2WwddVFCAF7TvjZhv1LiK3i4/brvuV2QIMuwdlkK9EBtgGNJ3OpkbA1wpLrMpPRam98rhi92GaPOnbhZuv08Wy/6nXQfx5TX22M+SDmj/xrLiWe9iEW1XxNx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QexmsXYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E2DC4CEEF;
	Mon, 12 May 2025 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072197;
	bh=S4q4nDw1iH7472rL+wG++fjWQE0nz1FdkDJBJpJHy/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QexmsXYMMN0jWRagA36WkakOTWHPWF5eCN3FgZWxIb+1YizncStbVFGObXGr7COWj
	 0xlPJdUJ6aZ85l8kTzHoTTlRjwgZ9G+LXv6n2ET8aGsnT2lV7ucMu8W75tSW97uv/m
	 l3VlGbA6FO7V2MPtzQChrU6ZhLD1pl3eT3m2f5BW1vIw0XEHK8kPTZtGcPkOn9sfri
	 /gAWi0KsoZkCtUFmRtVDWMieZOr7Q12Gj3QciTXOVdJDaOMSnpVFvxYRor4uPrlhH1
	 F218xwuGBhKm+WjdVMadNsfQpkwmh1S4y67vOouegTalcSgvZH/SbuBvQkjOMWUKsZ
	 ayKZJeUBzotPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3419B39D6555;
	Mon, 12 May 2025 17:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] Fix verifier test failures in verbose mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174707223500.1030716.12222750851162988689.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 17:50:35 +0000
References: <cover.1747058195.git.grbell@redhat.com>
In-Reply-To: <cover.1747058195.git.grbell@redhat.com>
To: Gregory Bell <grbell@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 May 2025 10:04:11 -0400 you wrote:
> This patch series fixes two issues that cause false failures in the
> BPF verifier test suite when run with verbose output (`-v`).
> 
> The following tests fail only when running the test_verifier in
> verbose.
> 
> #458/p ld_dw: xor semi-random 64 bit imms, test 5 FAIL
> #494/p precise: test 1 FAIL
> #495/p precise: test 2 FAIL
> #497/p precise: ST zero to stack insn is supported FAIL
> #498/p precise: STX insn causing spi > allocated_stack FAIL
> #501/p scale: scale test 1 FAIL
> #502/p scale: scale test 2 FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: test_verifier verbose causes erroneous failures
    https://git.kernel.org/bpf/bpf-next/c/c5bcc8c78127
  - [bpf-next,2/2] selftests/bpf: test_verifier verbose log overflows
    https://git.kernel.org/bpf/bpf-next/c/af8a5125a04c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



