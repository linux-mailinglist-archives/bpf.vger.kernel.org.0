Return-Path: <bpf+bounces-42315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2E09A261F
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA5287DFE
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08EC1DE4DA;
	Thu, 17 Oct 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBpGVze8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252391DB956;
	Thu, 17 Oct 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177824; cv=none; b=RWsGPMIMNXDZVu4PnrTIOSm6jpMgk2m6bI5arNEfxxz+Ig2Fi1GEy4Myvw0wLoUE8BYstH7iUae72V14r8+D1VnZlZ42JASxEOVgKUA+zKwf/GYJ8XKwRrb5AHTyPUshNHPVlAy9FUAK8U8HpEuulvvEwzdOcoM0+8+HZRXJ+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177824; c=relaxed/simple;
	bh=hvs6/KkeeLfo/pqdhicK7HWBMyjlkj8lfbeYVi+E85w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fr8yGn5A0adM4UMKjqAmwvkCUJEO/KbZzqJsGGjAFprQIjJfNhQKDVA+bCC6WCTQCccSfHcpL9CwrDEEMnkJCfet8BKh1nwkHAHJ39RGTwuJZ3tOChgPGcrsoDgaGQIT+BGczaFBp91cgDqbK08+ZlqXVKC884Ubizsna2YBBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBpGVze8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F33CC4CEC3;
	Thu, 17 Oct 2024 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177823;
	bh=hvs6/KkeeLfo/pqdhicK7HWBMyjlkj8lfbeYVi+E85w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mBpGVze83vITnoccm1uqKS79tpMySV/jX0eTav9Z5urwp1U94OmasOPoHrRw3xPeL
	 b9WiR5VDQyOOQcEZSkvjyRUZCDSXbhiOlaypWaYskkAjdGevdGNjC1tifV9we5jz/P
	 RGMVA73P08br45YQ01NONFZ6/tS7Rto5ehMj/FX10aIkc9FAMfFyMTpoSV+7KvfZUh
	 SieevRshTF1UnQDDiPYar99am7wndpUWtjVIQk/RbidOXYcHakVlY8xYN9L98DmgLm
	 pQ2sk755QpAS4cq94TqVJY6Yl2/j6Kfg142d9HSgPkJ+jQDx/tH9pPV/hnC6BaDqPy
	 e5nJM/G8Kk5EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D023809A8A;
	Thu, 17 Oct 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, bpf: Make BPF_CMPXCHG fully ordered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172917782901.2501843.16846439136645084983.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 15:10:29 +0000
References: <20241017143628.2673894-1-parri.andrea@gmail.com>
In-Reply-To: <20241017143628.2673894-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 17 Oct 2024 17:36:28 +0300 you wrote:
> According to the prototype formal BPF memory consistency model
> discussed e.g. in [1] and following the ordering properties of
> the C/in-kernel macro atomic_cmpxchg(), a BPF atomic operation
> with the BPF_CMPXCHG modifier is fully ordered.  However, the
> current RISC-V JIT lowerings fail to meet such memory ordering
> property.  This is illustrated by the following litmus test:
> 
> [...]

Here is the summary with links:
  - riscv, bpf: Make BPF_CMPXCHG fully ordered
    https://git.kernel.org/bpf/bpf/c/98cd61955771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



