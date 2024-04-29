Return-Path: <bpf+bounces-28207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6C8B6628
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C51F220EB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9D194C7C;
	Mon, 29 Apr 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc9oAzJX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C4177983
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432831; cv=none; b=eQqVAPZQ+yjy6+h3/woFAUZX8zSihqiYpkkm1GQORNSv8rzwhmbTSsNS6UhRJ3OPHZMeDs4q7RdeLBZN2y6jykzw2ZD78RHswsboTt+7YeL7KpmHyJqm9PkkwdarqtoCj+GZYbghkOLLfqDdlhKe/3tagGn0bzCGOhnUNio0tZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432831; c=relaxed/simple;
	bh=aMbXvQ9pL0wyHSaPEYfZLrE/9Eq9+BWGlCblioYsTDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kxQpJPm9c0H/IBs9GxIpDSVFiCv+kY7Cwg75wV+uEJn8kvPU5RqHjX7Upu1t8kJ29vluEusbOvZk0Ecb+GF5nlNadXpKM0QDlP4vVnlKuW8kLHXsKTjAj78gOmrnak63bl7ce5OUPiYspuHOKbUZ2jP7RB6bUWdNiAl7nv3857U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc9oAzJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9199FC4AF4D;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714432830;
	bh=aMbXvQ9pL0wyHSaPEYfZLrE/9Eq9+BWGlCblioYsTDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mc9oAzJXdguqtVEtn98QDOViABvfmnA5cu7caU0snUY9vCdqLohDmZG1Xfw+afD6O
	 3TjYbk27KzM1HP9FHVyAFFZVtkFm6uZJVB4Yv3wJJ25x51v3JJTFkBB1zWs2QX66vI
	 gX21yTAr+rZywE0x7rGylU0YJIN8BgoAigy8+/vDVAjNZleGwTVLzC9PMMdcROpUPk
	 6M3gBgRkSoRHoU7qlD9L/GZ6tmfglcom8UTbfU1JBwKKW2nHMh/qLwvUSkVjCZ1wql
	 pIqxxMCJ8z0kkhnL/5rycNrQNOz/EuYYaIx351o2D/0Tb5dp300Y9CxaNT7br+iaYK
	 n3PlKZWdRQtcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84248C43613;
	Mon, 29 Apr 2024 23:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: run cgroup1_hierarchy test in own
 mount namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171443283053.1398.6063083961990796968.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 23:20:30 +0000
References: <20240429112311.402497-1-vmalik@redhat.com>
In-Reply-To: <20240429112311.402497-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, laoar.shao@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Apr 2024 13:23:11 +0200 you wrote:
> The cgroup1_hierarchy test uses setup_classid_environment to setup
> cgroupv1 environment. The problem is that the environment is set in
> /sys/fs/cgroup and therefore, if not run under an own mount namespace,
> effectively deletes all system cgroups:
> 
>     $ ls /sys/fs/cgroup | wc -l
>     27
>     $ sudo ./test_progs -t cgroup1_hierarchy
>     #41/1    cgroup1_hierarchy/test_cgroup1_hierarchy:OK
>     #41/2    cgroup1_hierarchy/test_root_cgid:OK
>     #41/3    cgroup1_hierarchy/test_invalid_level:OK
>     #41/4    cgroup1_hierarchy/test_invalid_cgid:OK
>     #41/5    cgroup1_hierarchy/test_invalid_hid:OK
>     #41/6    cgroup1_hierarchy/test_invalid_cgrp_name:OK
>     #41/7    cgroup1_hierarchy/test_invalid_cgrp_name2:OK
>     #41/8    cgroup1_hierarchy/test_sleepable_prog:OK
>     #41      cgroup1_hierarchy:OK
>     Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
>     $ ls /sys/fs/cgroup | wc -l
>     1
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: run cgroup1_hierarchy test in own mount namespace
    https://git.kernel.org/bpf/bpf-next/c/19468ed51488

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



