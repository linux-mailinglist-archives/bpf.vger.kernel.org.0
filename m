Return-Path: <bpf+bounces-71245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC08BEB40F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DFA3AE14F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8F332900;
	Fri, 17 Oct 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1jLPdoM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460343328E1
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726425; cv=none; b=OsJto2agbQHi/79/NxlC0+KNduTB6y3H7MEHNzoHveLXIiZeAEWvXWYzU73zAcmpEu2sf7YHCUx/XXUjNYbFLzq1UPk9+2WPryFkThFoROhvo/W7WKZ1HicwzMwDfHZ51pWzkaIi/SebUqylPYZu+PQxWk7I9Fd+ldmwB+UoWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726425; c=relaxed/simple;
	bh=+X5AXvKLsz1j6nW3WNcM1y4AtcKG5Lw68oBZQzYwWzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mRJTWnT57ugNaytiZBB0FBR746w8Q1A/7f68D6eTBNJt+62sp/rPk8DAeuMahEZ6xlPpMRqA+E5ORZozcMeMxy1dvlAZyBl8FcBFtGIlJA1O4oxUZD2xSKn3NooY7Hm0KROC4CehofA/ntv4pvRZKKJwcbnhRfMTwAoLwn6PSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1jLPdoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBEC4CEE7;
	Fri, 17 Oct 2025 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760726424;
	bh=+X5AXvKLsz1j6nW3WNcM1y4AtcKG5Lw68oBZQzYwWzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1jLPdoMZa764RAezTYwIgUNQ+aaiMNCUTjNpKCMmzA3zjgoA2RheWlyapybcwt6u
	 8mWrqtM1pESze9mrHGRltDMSD9TGykt1j0cAfC5WrueL7fG07gZ+7QtOvxLSdTXIkk
	 crXlBwP53Eq49JOhTsCKPPUuGyZHM6RZ4ocQoIVOQi6VR+N/fQ+tXnPR8eSk/7d7m/
	 AQQEJ4FUfDOk4fzDuSasY7z+qdkQ+Wkp7Irg2SndyuPn3qWIvPkppNvMg+SfmyWxo9
	 QaiJjP2LFjbljVoGCHIDv7p76tuCTlRcEb4QkIKLTJCujqLDGp1Xu3SPenIyejjUZN
	 mfDJ6Nx6XRlfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB139EFA57;
	Fri, 17 Oct 2025 18:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: test_run: Fix sleep-in-atomic BUG in
 timer
 path with RT kernel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176072640850.2744744.1132852363811423037.git-patchwork-notify@kernel.org>
Date: Fri, 17 Oct 2025 18:40:08 +0000
References: <20251014185635.10300-1-chandna.sahil@gmail.com>
In-Reply-To: <20251014185635.10300-1-chandna.sahil@gmail.com>
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
 menglong.dong@linux.dev,
 syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com, listout@listout.xyz

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Oct 2025 00:26:35 +0530 you wrote:
> The timer mode is initialized to NO_PREEMPT mode by default,
> this disable preemption and force execution in atomic context
> causing issue on PREEMPT_RT configurations when invoking
> spin_lock_bh(), leading to the following warning:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: test_run: Fix sleep-in-atomic BUG in timer path with RT kernel
    https://git.kernel.org/bpf/bpf/c/7c33e97a6ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



