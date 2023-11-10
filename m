Return-Path: <bpf+bounces-14738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9607E79A6
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 08:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655BC1C20A68
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA21FC4;
	Fri, 10 Nov 2023 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+b5O0aA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E727187B
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 07:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04410C433C9;
	Fri, 10 Nov 2023 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699600226;
	bh=jaRTX6bsXs9F+AZUVTkzNBRQgU8JrEG4tk5ozYQGWNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n+b5O0aA/GdWppgFVGYSdOg2EnyZLX/j+idTbHrTucGCDHQagzchNC3sGq3eH9yBu
	 1fAwLF8VI3y55Nq0hTbgTeUgl7s+QEGgg9SDbtrdUF+swrqW18+KBog/I1OPbYi+we
	 VXGuaR3+zlQwAY37S26Nrtz90xDYuYb+H41V6QD4kxiy9vEkv9JJFVsBCELQCrFuhz
	 kV+nIhX2tDLvBQNJLavyXhBYvbhH3MXJq1X5G/nwklUH3Kp8Xpsm+kAd3KkCpNFTWc
	 74BE/0DobNu/DYhY3XZ2M7N9npuhPdzZC7+xaMzbTX28RoOs/hgyiQArwYczLcTgcm
	 Ow/rI4qw1hVYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC9E3C395DC;
	Fri, 10 Nov 2023 07:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: fix control-flow graph checking in privileged
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169960022589.7907.16307545616666162450.git-patchwork-notify@kernel.org>
Date: Fri, 10 Nov 2023 07:10:25 +0000
References: <20231110061412.2995786-1-andrii@kernel.org>
In-Reply-To: <20231110061412.2995786-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, sunhao.th@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 9 Nov 2023 22:14:10 -0800 you wrote:
> When BPF program is verified in privileged mode, BPF verifier allows
> bounded loops. This means that from CFG point of view there are
> definitely some back-edges. Original commit adjusted check_cfg() logic
> to not detect back-edges in control flow graph if they are resulting
> from conditional jumps, which the idea that subsequent full BPF
> verification process will determine whether such loops are bounded or
> not, and either accept or reject the BPF program. At least that's my
> reading of the intent.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: fix control-flow graph checking in privileged mode
    https://git.kernel.org/bpf/bpf/c/10e14e9652bf
  - [bpf,2/2] selftests/bpf: add more test cases for check_cfg()
    https://git.kernel.org/bpf/bpf/c/e2e57d637aa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



