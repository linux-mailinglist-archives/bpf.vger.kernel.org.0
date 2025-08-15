Return-Path: <bpf+bounces-65753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E88CB27BA5
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A41780E3
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17D258CC4;
	Fri, 15 Aug 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YILBKYwO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD11EA7CC;
	Fri, 15 Aug 2025 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247808; cv=none; b=iRYzjw361CdMFG/zXWpC2dDNw30t48AG3FgrmqLyTtJDV5VK8meiAs3Y9Ug0u4RVnLrSfpabkLsmnItiF5TpoHQlxU9MxLpM+4ZV52oJL/IOaK0k0P4D5A26Q3HaIt74p4bd6XDIIJTcA7kloXY3PeifJJpapp1CqcMApzPfIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247808; c=relaxed/simple;
	bh=kfPlf93Sj5KMZI/komEcYnnrbjVcN1G2q4OnGPbOjX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLQCiy7LTbqi0cdmsLoWYe/kMGWsBeq69DmFhRQYtD/lI/zy/DPXHkAw3SQx5Wgy1uIibKVvpxQtp/KpcHNWkRMIKjNaGmG8GkZ1tZ+qplbAuD8I9/OoE3vvLaAv+S171bEisAnSqpoF+DorTN1qb0xCztjzP9TDl2X3CbYbK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YILBKYwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA6C4CEEB;
	Fri, 15 Aug 2025 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247808;
	bh=kfPlf93Sj5KMZI/komEcYnnrbjVcN1G2q4OnGPbOjX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YILBKYwOYHCHwdGFkJgc3s56PIA4f6nPB58Z/ahVuQrqRyYP0pi1fTQyxkbfBHFTX
	 TMn33JPiKuQ1orAunZC07h5+WzZqNR/Qpn5S2pu0gjBW+nQCn9aRn7YAaxeNcgOcnV
	 4x6jngqwkkAns6R3SehdAmcQmqo+9Y2vUEgbZPllpiVmIYTQaMozPZTkzmstXpWu7n
	 DSm6cTZez2SfGGjaHsiGaWIlwlVO2e1qw3TN1GJ6yhlQASoYd51sBwMPrGnLE1fwCB
	 XWJMjq19FCgFHcznppIbVl0MgEyDxSKyqKIOqzmm9e4dhNbddUB1cYFrHZ2LdPAJGp
	 yvvHjV/C2be9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2139D0C3B;
	Fri, 15 Aug 2025 08:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/10] Add support arena atomics for RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175524781950.988422.3130461067803981757.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 08:50:19 +0000
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@kernel.org, puranjay@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 19 Jul 2025 09:17:20 +0000 you wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> patch 1-3 refactor redundant load and store operations.
> patch 4-7 add Zacas instructions for cmpxchg.
> patch 8 optimizes exception table handling.
> patch 9-10 add support arena atomics for RV64.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/10] riscv, bpf: Extract emit_stx() helper
    https://git.kernel.org/bpf/bpf-next/c/02fc01adec1c
  - [bpf-next,02/10] riscv, bpf: Extract emit_st() helper
    https://git.kernel.org/bpf/bpf-next/c/d92c11a6b55b
  - [bpf-next,03/10] riscv, bpf: Extract emit_ldx() helper
    https://git.kernel.org/bpf/bpf-next/c/01422a4f2c78
  - [bpf-next,04/10] riscv: Separate toolchain support dependency from RISCV_ISA_ZACAS
    https://git.kernel.org/bpf/bpf-next/c/ec74ae56626b
  - [bpf-next,05/10] riscv, bpf: Add rv_ext_enabled macro for runtime detection extentsion
    https://git.kernel.org/bpf/bpf-next/c/5090b339eeb3
  - [bpf-next,06/10] riscv, bpf: Add Zacas instructions
    https://git.kernel.org/bpf/bpf-next/c/de39d2c4cdb6
  - [bpf-next,07/10] riscv, bpf: Optimize cmpxchg insn with Zacas support
    https://git.kernel.org/bpf/bpf-next/c/1c0196b878a6
  - [bpf-next,08/10] riscv, bpf: Add ex_insn_off and ex_jmp_off for exception table handling
    https://git.kernel.org/bpf/bpf-next/c/b18f4aae6a5d
  - [bpf-next,09/10] riscv, bpf: Add support arena atomics for RV64
    https://git.kernel.org/bpf/bpf-next/c/fb7cefabae81
  - [bpf-next,10/10] selftests/bpf: Enable arena atomics tests for RV64
    https://git.kernel.org/bpf/bpf-next/c/dc0fe956144d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



