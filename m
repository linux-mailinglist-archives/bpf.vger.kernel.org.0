Return-Path: <bpf+bounces-59011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DBAC58DA
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D621BC2E2C
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E0280330;
	Tue, 27 May 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNZ1Fw5l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C10280322
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368198; cv=none; b=A03U57nP3CgihBtbGnwg6Vy/YH4kBXNKaJnrbsKADhX4Y6GyT2bvrZ1QU6R3CKzASXWKcC9smQqAXVchFw6nELYR+FIY6u6nZwlj3zUUGaZVWSz2MrX6A+pmQLfd5TirHYB2mkXa/eR4vLPXydYaNY7KIetDuugYwd81Ke13tH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368198; c=relaxed/simple;
	bh=bX/R8BPVDjONA5yi2cO1wPtMghqkhUg+TW66zXEJ+vA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dlknh6v1A/sZ7rEWa9geqHGl3YUr4lZy0/gdBjnWNm807amkHS15hcBH1EJyf3AalwlK5AuFBUAwxe2x20IfSw4ypnK9sf5SVpC0kk7IlAcsnHVsqWtzsn9IlOf0anRDZRe+mAA8ZRqfJxC8U8ZfvE9CiC0scdGixrlBJ05PBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNZ1Fw5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F105C4CEE9;
	Tue, 27 May 2025 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748368198;
	bh=bX/R8BPVDjONA5yi2cO1wPtMghqkhUg+TW66zXEJ+vA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mNZ1Fw5lAuW4jE9G+UVZGJelEXlIoLt57mJG3Bx9lcYMdza+zZYoitMXi3IzaB/9Z
	 qntL815aYRS5YCvfZCX9LNPBZfvCb/pQ0/AxJDghbCvjQ04bX051xEH/yJHqPxHBWf
	 a/Se+fukRnlh0IoEGa56WaYtYZo8YiK79rwyeAjrS1hfbctGTrEjKA2vtrgAVb/5jg
	 ejt8v6gGHy4EdBI8yrC3DLwF7kjbVaYw+xEDnLvyMSImSnd65cx3g/Q3hl+GYD6vLn
	 rhcjJs7ngMwH7JmPGyrn8gkrhtS2y6lMgJqs2GqPfcnNfbNjZsAwDOzFk9Au6Gy6Ws
	 e3x7ndiKJfdeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDB380AAE2;
	Tue, 27 May 2025 17:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Check rcu_read_lock_trace_held() in
 bpf_map_lookup_percpu_elem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174836823200.1725298.10199388427709310337.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 17:50:32 +0000
References: <20250526062534.1105938-1-houtao@huaweicloud.com>
In-Reply-To: <20250526062534.1105938-1-houtao@huaweicloud.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, haoluo@google.com,
 yonghong.song@linux.dev, daniel@iogearbox.net, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org, john.fastabend@gmail.com,
 houtao1@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 26 May 2025 14:25:34 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_map_lookup_percpu_elem() helper is also available for sleepable bpf
> program. When BPF JIT is disabled or under 32-bit host,
> bpf_map_lookup_percpu_elem() will not be inlined. Using it in a
> sleepable bpf program will trigger the warning in
> bpf_map_lookup_percpu_elem(), because the bpf program only holds
> rcu_read_lock_trace lock. Therefore, add the missed check.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()
    https://git.kernel.org/bpf/bpf-next/c/d4965578267e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



