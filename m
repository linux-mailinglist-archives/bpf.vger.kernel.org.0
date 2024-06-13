Return-Path: <bpf+bounces-32110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E4A907B16
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21151C23560
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3514B955;
	Thu, 13 Jun 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etqqb0He"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848612FF87
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302830; cv=none; b=ED3wcDFUaK6lCMsF7ol7l3VX3se86mHLRH+Kq6ZXIJzCciuy0gaI1/A5894b7uAmGuZgBDAxBbe4yB6Z0yzd/hYRsZ0it+gXnfJUzN39+f1PCAHrs2K0iee3Ktte6/1gbWw9SMX8dgcZv0IJGwzB1Tze1T7mFR9tROuMo7AtnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302830; c=relaxed/simple;
	bh=JHBFY/by1tRf6zw3KUmXgQnjogzTPQmIwZLQkJE/tyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K+yjSEwpMc7mzo2PzLUs59ZO9q9kPHe+NtAgkmDCbWodXEJKXPIk7eSUttXNApo9F9H2Q0Fnl/p2xeiVde9d2d2QvPVF35uXYp8R/Vhdp/EEvWUIVKAw0/hc7aw6UIXk1fbflwNx3h9VYAC5v6TxjaJRn+PXj3xYSR+mP8MvCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etqqb0He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 850E1C32786;
	Thu, 13 Jun 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718302829;
	bh=JHBFY/by1tRf6zw3KUmXgQnjogzTPQmIwZLQkJE/tyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=etqqb0HeF1WIDI6hDylSMXNQxXdOISMXcTcvfgN0R7gn9z2sKOLFfj+O2FtuaomuT
	 15uVLVPPVtQNp9QWeojNVG2hYlW2NOJAptESaPWOYZShvFMgfmrhpjnRwsKv6H8Tg0
	 47RVispU1PFrUv1PZ7kxS6F69ZYwv6U3zzZHlRscl3vU4KeFEtSzJgKGLxzYnDt1AK
	 3lDSoKSNT2Ej0kHHgMxmkTXnkIGQ/6eRxA159dg0nWW1xlJ3Qlx/fhH3vpwCTkrqAg
	 TLXqI/OrsWG0q9fbVocdeP8+l757GICMWiDuXYPICQWqHNkONb6QzGPKaVd80xkt8V
	 5cwa7iQRdgEQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 738EBC43619;
	Thu, 13 Jun 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/3] bpf: Fix reg_set_min_max corruption of fake_reg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171830282946.12313.2297195471793695064.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 18:20:29 +0000
References: <20240613115310.25383-1-daniel@iogearbox.net>
In-Reply-To: <20240613115310.25383-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com,
 jjlopezjaimez@google.com, andrii.nakryiko@gmail.com, eddyz87@gmail.com,
 john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jun 2024 13:53:08 +0200 you wrote:
> Juan reported that after doing some changes to buzzer [0] and implementing
> a new fuzzing strategy guided by coverage, they noticed the following in
> one of the probes:
> 
>   [...]
>   13: (79) r6 = *(u64 *)(r0 +0)         ; R0=map_value(ks=4,vs=8) R6_w=scalar()
>   14: (b7) r0 = 0                       ; R0_w=0
>   15: (b4) w0 = -1                      ; R0_w=0xffffffff
>   16: (74) w0 >>= 1                     ; R0_w=0x7fffffff
>   17: (5c) w6 &= w0                     ; R0_w=0x7fffffff R6_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
>   18: (44) w6 |= 2                      ; R6_w=scalar(smin=umin=smin32=umin32=2,smax=umax=umax32=0x7fffffff,var_off=(0x2; 0x7ffffffd))
>   19: (56) if w6 != 0x7ffffffd goto pc+1
>   REG INVARIANTS VIOLATION (true_reg2): range bounds violation u64=[0x7fffffff, 0x7ffffffd] s64=[0x7fffffff, 0x7ffffffd] u32=[0x7fffffff, 0x7ffffffd] s32=[0x7fffffff, 0x7ffffffd] var_off=(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x7fffffff, 0x7ffffffd] s64=[0x7fffffff, 0x7ffffffd] u32=[0x7fffffff, 0x7ffffffd] s32=[0x7fffffff, 0x7ffffffd] var_off=(0x7fffffff, 0x0)
>   REG INVARIANTS VIOLATION (false_reg2): const tnum out of sync with range bounds u64=[0x0, 0xffffffffffffffff] s64=[0x8000000000000000, 0x7fffffffffffffff] u32=[0x0, 0xffffffff] s32=[0x80000000, 0x7fffffff] var_off=(0x7fffffff, 0x0)
>   19: R6_w=0x7fffffff
>   20: (95) exit
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/3] bpf: Fix reg_set_min_max corruption of fake_reg
    https://git.kernel.org/bpf/bpf/c/92424801261d
  - [bpf,v2,2/3] bpf: Reduce stack consumption in check_stack_write_fixed_off
    https://git.kernel.org/bpf/bpf/c/e73cd1cfc217
  - [bpf,v2,3/3] selftests/bpf: Add test coverage for reg_set_min_max handling
    https://git.kernel.org/bpf/bpf/c/ceb65eb60026

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



