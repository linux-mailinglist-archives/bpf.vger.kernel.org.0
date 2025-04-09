Return-Path: <bpf+bounces-55605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A66A834AF
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94FA1B61B13
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B109A21D59C;
	Wed,  9 Apr 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEw2Qz0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7F21C18A;
	Wed,  9 Apr 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242015; cv=none; b=e+yAd7BKRjOMyfR4g4z27qelnTNUJubGRRMLq+DWxlQi/jx9b7qA2psG+dVmS34AdGVy/gb+YJVLrsAEqnCo5nxecCZdV3enHsEfOAmmUwfQXMyRYKN215G0ZUDAKRXAbBDLytC9l6grnO9hfiX+TuYK2awUsg8KSRhfkPLYTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242015; c=relaxed/simple;
	bh=14PKKDLENZFH1SGpMbnvyTFTgJJEJGfeGEhIALWz2MA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJHHWsdd8w8wrFaqt2kysGrZkjEQlHQ7Cp2DQIk/OVVC27ActM4U6nIHlLrMIWxf8AWK3Lx08LzCJONnZKZ/GsWiWT8A4My9+LU1RxRRA8Pq2A5zBrpGCWdHqPVZ0Yl54SjwSpvmqIo8k+PV5bvrAUQorRvMJlUVyRpYFbSxY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEw2Qz0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8E9C4CEE3;
	Wed,  9 Apr 2025 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242015;
	bh=14PKKDLENZFH1SGpMbnvyTFTgJJEJGfeGEhIALWz2MA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kEw2Qz0sEE8+fCWYaisJKKDs7lAxeLrCF2dRRdh+K1znaJBMvMK7Kc1SZb2Ku7rMr
	 ciBtIOMdg8iC5SA4Py3R6vRaxOc2UEiGJUzC/A5dH0YzFUWgZx+k0T1M6gv/DgYcfe
	 Jj5eSoLkUQoM+Dkntiy2EHSWKJ5QSalACKKKFIDB3r0O9iEUaEmfFepPLvio75znjg
	 sJRTgDT+hqy02rsxOJslMzw85yem8AyWJ24MHuGj8CaS/j8Rmyi8Z7qHjblK74gZxC
	 a4S+59uCJI6rOtnSRSA3n4KOEWkbYrx8N6hv2p9QYrO6q36ibl2vtE45uat2coa5+M
	 ZcSidx5xw0Nkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFE38111DC;
	Wed,  9 Apr 2025 23:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Check link_create parameter for
 multi_kprobe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424205228.3077267.12250129138735203026.git-patchwork-notify@kernel.org>
Date: Wed, 09 Apr 2025 23:40:52 +0000
References: <20250407035752.1108927-1-chen.dylane@linux.dev>
In-Reply-To: <20250407035752.1108927-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, laoar.shao@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon,  7 Apr 2025 11:57:51 +0800 you wrote:
> The flags in link_create no used in multi_kprobe, return -EINVAL if
> they assigned, keep it same as other link attach apis. Perhaps due to
> their usage habits, users may set the target_fd to -1. Therefore, no
> check is carried out here, and it is kept consistent with the multi_uprobe.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Check link_create parameter for multi_kprobe
    https://git.kernel.org/bpf/bpf-next/c/243911982aa9
  - [bpf-next,v2,2/2] bpf: Check link_create parameter for multi_uprobe
    https://git.kernel.org/bpf/bpf-next/c/a76116f422c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



