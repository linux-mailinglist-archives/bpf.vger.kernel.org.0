Return-Path: <bpf+bounces-74919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57DC67C7B
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DEA3B2A0E8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571132F25F4;
	Tue, 18 Nov 2025 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgifm/Zw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4C2F12D6
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448641; cv=none; b=FIupfI1+QHep7MPlbetJT2QYVoR64OFxSU8Mx0E4AMgGURvlLi9fRd6MM4FdAB+DJ5gokDN6GtTvv3z6YmMbkwLixV1gG+jk65iG5+c8oNrRBuAOZRsWcLTWEb0y5a+55L9lRuNoYxkkpuN3EpIdP3d3hjNcPlYJuSZw8lILlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448641; c=relaxed/simple;
	bh=HrvtrBzbt9CQPzqKrVcQlnk1ake4KwJD3UP9y8fegGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pHAVeyRCP/7Np57nSY1gy47olARVpIM9V945VvR31F/lrt6BHMCnvCzIYDmXAsxL0ny8MgxiGPJOTdNRSp0I6iLyD7IWqCoGCW/GUFphtdDgX+hIBPzewetHHSOAXM0XGeOzFC0O+uylvkBBcOM5L/9imQvJZesIFvq2xjCIlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgifm/Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C8C2BC87;
	Tue, 18 Nov 2025 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763448641;
	bh=HrvtrBzbt9CQPzqKrVcQlnk1ake4KwJD3UP9y8fegGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rgifm/ZwrJpO3a80C1aU2TdT5pt5SOENVVk1oeg5EgE+lXIlr2mfkEH4wcX8gxrXK
	 jCXa1wpyVu2O3LRuxZyv9b2IC0eC4STEtNeCGYR33/E9ZIUpHXBuLBVqc1rrzg1/Rk
	 eDD6P6w3AMhuR06ZjKiP6NT6TYtiUMWcjYTTF/4VtiHfXglUG9w6XYTnbXnKk7DKmX
	 LMMDsxA2iSP3tGO0Jz+uvXMeKMH+tEKLIYobvTkfqWd6wu+O2CaWGXrYz+XK9af3lV
	 aO8NIHJpf3I2TO/W0CQsd23f971HL31iRbu1IMU/xnseYBUogSlpbRZmtOac4ep2uA
	 c75Ivk+TwtqkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB03809A25;
	Tue, 18 Nov 2025 06:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5] bpf: Fix invalid mem access when
 update_effective_progs fails in __cgroup_bpf_detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176344860602.4005798.7745346893729698245.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 06:50:06 +0000
References: <20251115102343.2200727-1-pulehui@huaweicloud.com>
In-Reply-To: <20251115102343.2200727-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alan.maguire@oracle.com, pulehui@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 15 Nov 2025 10:23:43 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller triggers an invalid memory access issue following fault
> injection in update_effective_progs. The issue can be described as
> follows:
> 
> __cgroup_bpf_detach
>   update_effective_progs
>     compute_effective_progs
>       bpf_prog_array_alloc <-- fault inject
>   purge_effective_progs
>     /* change to dummy_bpf_prog */
>     array->items[index] = &dummy_bpf_prog.prog
> 
> [...]

Here is the summary with links:
  - [bpf,v5] bpf: Fix invalid mem access when update_effective_progs fails in __cgroup_bpf_detach
    https://git.kernel.org/bpf/bpf-next/c/7dc211c1159d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



