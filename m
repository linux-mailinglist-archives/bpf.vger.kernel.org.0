Return-Path: <bpf+bounces-19489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D681282C65D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15A51C22AE7
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711C168B4;
	Fri, 12 Jan 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU3sWvh2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FA168AD
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 20:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBCE0C43390;
	Fri, 12 Jan 2024 20:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705091425;
	bh=bPcd/yV8dQ08NwYuFo3WaBX+BINw0owuR6TyzpCU3ZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iU3sWvh2fIH7RFKAX580G/XNDYK7httBOiHhzz8UHyCyWz0uLvCVLJeWS/MrY2Pex
	 SN4WSRCd+h4wJZHw5gtWiEJJ+UYfl1ZkTwP89NtCx5wERbsXdwk4zo0pKmSOD93BWr
	 NaDyMqrMd0RzgD6UlwunpNJg86OkIR83l/wF4Q2e6SYFjxgsCXLShytcBAl5Kd6s8j
	 DtuyxW04ZsVDGJQl/ZEZDShKjmaibUAYdNfoN2hLrXAyc5+t10j2KjQ2CuC/YXlUll
	 IQvG25KfDyekDkxFuzSm9Z2/5vx+8+qJkA+3vypv7c0Ektz8gupzTmGPLJY+LFob4K
	 sUIHl90BOGsBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A02B5D8C96D;
	Fri, 12 Jan 2024 20:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track aligned st store as imprecise
 spilled registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170509142565.8964.750077660588376018.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 20:30:25 +0000
References: <20240110051348.2737007-1-yonghong.song@linux.dev>
In-Reply-To: <20240110051348.2737007-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 kuniyu@amazon.com, kafai@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jan 2024 21:13:48 -0800 you wrote:
> With patch set [1], precision backtracing supports register spill/fill
> to/from the stack. The patch [2] allows initial imprecise register spill
> with content 0. This is a common case for cpuv3 and lower for
> initializing the stack variables with pattern
>   r1 = 0
>   *(u64 *)(r10 - 8) = r1
> and the [2] has demonstrated good verification improvement.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: Track aligned st store as imprecise spilled registers
    https://git.kernel.org/bpf/bpf-next/c/17e25d8e59f2
  - [bpf-next,v4,2/2] selftests/bpf: Add a selftest with not-8-byte aligned BPF_ST
    https://git.kernel.org/bpf/bpf-next/c/536dfcbad359

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



