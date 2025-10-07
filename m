Return-Path: <bpf+bounces-70537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40428BC2B31
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA20634DB35
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ED523D7EA;
	Tue,  7 Oct 2025 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN+3IZvG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828A234973;
	Tue,  7 Oct 2025 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870216; cv=none; b=DE9GyqAZ+PCfi4qjbIi8T2d+pi8RrTlGpV47cxEX+kfkrMYIznIq+t9M4QQUpkMABSNT2syMHKewuhp17mSzEPw7VNUytyZ4+h6944PSxL3to7reEebjpR0BQM4ymJufmLYVbJjpkMbhfmbRoblgumQIQtCgx1sX/LB+AlHSt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870216; c=relaxed/simple;
	bh=K8Gwj/eJ62BPvfIMdhUwUf0hxarnLTMxDptRw+xfF40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YUHUj8Y/9RWvsE+ZOYT5P8F/szTU9aRoB0NvfeE7orVM6PKc7y5mbdAFXdNDK6sAWeaW/d9GtB/p/8wkvDF+vry4K9aUb1ado3NQJkAkQUF8/MB0/jgHUXa7Gpm/nd0i6BRZC68EqGxXaDR+TgVXVkZqRwgMUeHd07HBUQkvpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN+3IZvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A85C4CEF1;
	Tue,  7 Oct 2025 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759870216;
	bh=K8Gwj/eJ62BPvfIMdhUwUf0hxarnLTMxDptRw+xfF40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gN+3IZvG7/pYZ36DV0VdhHeikcoTSDn4FR1JS3sLm7rlZ6CFm/vaN3hgU9CeSvys+
	 rKHizo+8EMKCha/7mGjrRs4KMViy8TIzFl4ZNVlBZUtnDhpI4aLQAv5SErjDJQCp61
	 l61/nJbj6X29fwl6LwTdTDhCF5M8XSDTtzoQX62HQLs+iPsM5U0Glk/WSyJ27NTyCZ
	 ptQqcrM6ieZJhiVPsoKxYcnCdFR+YxGKX5TEdpsJjahvPSvwwuPOe2yIKt8OTOuJgl
	 skG+mfK7BFCgUucMoVsCeMZ9yiis0YTK1Z7x3OgPVUcHB3mFFgMsR49G2CZyurzv15
	 EU8dVsnZuUR9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEE39FEB78;
	Tue,  7 Oct 2025 20:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Use rcu_read_lock_dont_migrate in
 bpf_sk_storage.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175987020501.2779563.3748034053990134861.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 20:50:05 +0000
References: <20251007074011.12916-1-wangfushuai@baidu.com>
In-Reply-To: <20251007074011.12916-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, martin.lau@kernel.org,
 houtao1@huawei.com, jkangas@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, menglong.dong@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 7 Oct 2025 15:40:11 +0800 you wrote:
> Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
> bpf_sk_storage.c to obtain better performance when PREEMPT_RCU is
> not enabled.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> v1 -> v2: no code changes. Simplify and clarify commit message
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c
    https://git.kernel.org/bpf/bpf-next/c/0db4941d9dae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



