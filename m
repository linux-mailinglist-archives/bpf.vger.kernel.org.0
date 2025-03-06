Return-Path: <bpf+bounces-53438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCCA53FF1
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FD16A2E9
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 01:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688715FD13;
	Thu,  6 Mar 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6cK7mcX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D5224FA
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224598; cv=none; b=D56RWReLjCJRczrvWzVF7FPXUa6aYepPo/E8tnk3pxP6nVZt/BxgXqyNqXcSO674e5TLBQXCaqd7hMdgAq3PIpWRmDF/gziec+5JjRjUaP228fDee3bq1dAOfsdCCD1+zvDMzjW4JXYkFtofstkHYiU2jpQmRzugU7zCEusH/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224598; c=relaxed/simple;
	bh=0nZXSmUryJPxJXJ7Ynws+Py3svll6bjzB1lHr66NaBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fb/Jhru2cZn0zzMVe/nTpE+I1n6iNsjPwHiwbDQfTvgwrCJk8dnCVl8SerPM0drG1PKTScx9+u+qEnEYEzEB2hRzABYe5sSricveFsJvlhOhQsrgbQEree43UrMVIm23Z3HzQ+NbwZMO2jWeiGmKJ9qMOXiqloD80BrddpIYt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6cK7mcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8860AC4CED1;
	Thu,  6 Mar 2025 01:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741224597;
	bh=0nZXSmUryJPxJXJ7Ynws+Py3svll6bjzB1lHr66NaBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6cK7mcXcmEhdZxz8V1Sk5WagkpKzohC5gTnS0qgfjG7xdRMGxuuG+eH4nFRwr4CT
	 MjbQwYRCk0U48iVp0s5s+z7KntZtzRCjEB804EqA6o/l7aKw+NHFTJXEA4gHn7r2yx
	 CRT1EDYuVWv1yZWJR5552EyV5jPr3rqpHNQAzeWRLmL/jvSelAvDA+PGhw5GCMLxs0
	 I2QcYvyZpdnf9jUzJPHnGiii72qDDI1B3z1vyR7zPsQPviNG/yUUjDqbENQWU6iJqm
	 4BDFDrkOEEpsuEgz2dddYGBMuy7CJK2bzdy7VXQgMpNyqkGkMe3Ciz/4pOMcNsF/J1
	 l8iUSexCQ8GPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8D380CFD5;
	Thu,  6 Mar 2025 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] bpf: introduce helper for populating bpf_cpumask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174122463076.1088218.16223857286520093233.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 01:30:30 +0000
References: <20250305211235.368399-1-emil@etsalapatis.com>
In-Reply-To: <20250305211235.368399-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com,
 houtao@huaweicloud.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Mar 2025 16:12:32 -0500 you wrote:
> Some BPF programs like scx schedulers have their own internal CPU mask types,
> mask types, which they must transform into struct bpf_cpumask instances
> before passing them to scheduling-related kfuncs. There is currently no
> way to efficiently populate the bitfield of a bpf_cpumask from BPF memory,
> and programs must use multiple bpf_cpumask_[set, clear] calls to do so.
> Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid
> BPF memory with a single call.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] bpf: add kfunc for populating cpumask bits
    https://git.kernel.org/bpf/bpf-next/c/a6db20f88a63
  - [v4,2/3] selftests: bpf: add bpf_cpumask_fill selftests
    https://git.kernel.org/bpf/bpf-next/c/66be130f8bf9
  - [v4,3/3] bpf: fix missing kdoc string fields in cpumask.c
    https://git.kernel.org/bpf/bpf-next/c/f3839e9749b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



