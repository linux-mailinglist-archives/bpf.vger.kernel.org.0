Return-Path: <bpf+bounces-18357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59ED8196D8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E540A1C20C4F
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126358C00;
	Wed, 20 Dec 2023 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjFZsk3b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E901883C
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 02:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11F29C433C9;
	Wed, 20 Dec 2023 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703039423;
	bh=shA+6vVmD81xST8OEEufkcvJZk2974goyXt1R3S/PaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WjFZsk3bT0NtKpxOLc0y6hysDxJcDQbDyI5CEBNIVV2zI8bgCu4C2eDV6oNZV7wT4
	 V8Xo5XDAjr8hBUl6CfksVtz8e2SRC8qPwtInq142WUwEdeyJzCuOw0L/O4eDGbztCV
	 q57D+z+hpwvGiltB5rVVVt9JrTQkvKkHmGsIfvcYbz5+7UMqkP1xqCxTO3AC6q8Iga
	 mLs7GkhOgHUqBYVicjGgxBSRPksAVKP156qaWGZLFAqcn/t/097r8d9245dfdTu118
	 8L1OAO+k0TmPmnaNm2LXR4HvHMxctUIaALJC9xNNaA1IcnW2FqJw+RRPSZ2/uVJ+1/
	 BzBYJ4/iNCNQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBDF2D8C98A;
	Wed, 20 Dec 2023 02:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Close cgrp fd before calling
 cleanup_cgroup_environment()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170303942296.26103.7995929302760177863.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 02:30:22 +0000
References: <20231219135727.2661527-1-houtao@huaweicloud.com>
In-Reply-To: <20231219135727.2661527-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Dec 2023 21:57:27 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> There is error log when htab-mem benchmark completes. The error log
> looks as follows:
> 
> $ ./bench htab-mem -d1
> Setting up benchmark 'htab-mem'...
> Benchmark 'htab-mem' started.
> ......
> (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Close cgrp fd before calling cleanup_cgroup_environment()
    https://git.kernel.org/bpf/bpf-next/c/441c725ed592

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



