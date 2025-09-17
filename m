Return-Path: <bpf+bounces-68608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15AB7CA1F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F9B174570
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC22F6178;
	Wed, 17 Sep 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fesirg5k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A02F60CD;
	Wed, 17 Sep 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076814; cv=none; b=MNiY4pxQ9lGF/A4Ox80V36WM+q+fMpuFvVwIvmvdBjJ0Xu+pcuI9lTKHLZEhPYBj2+WhrJVSWPXx8FvnMD+ZDfC8R5wjTzI5S+wFXcHMD3ZS1JN/LxxcyDGL/6ebOogAcpX4Fxae1N/a5wq0n4CwhZXN2McsTtzFO2gr9eOt9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076814; c=relaxed/simple;
	bh=+jZ7a6Pk13YHDpGs8wTheZPKmacywLo2rDy2h3k/AKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCFiRUpv/QB4DR2n0hczhKg2AKk5v4LwONfD/g0vwV2xkmRYq6imfKWd3oRqoVElEgcjmo6FI+0GmigZhMmG1jWo/KHS4ko1KmLXOO+Yeo5X1UwIJONbRxTK/Cd2isNZpmMyajhQsnQxYwXQI6a8jew/1yehf8ABBDkk1m7j+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fesirg5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03AC4CEFA;
	Wed, 17 Sep 2025 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758076813;
	bh=+jZ7a6Pk13YHDpGs8wTheZPKmacywLo2rDy2h3k/AKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fesirg5kgQLTK51Yra+Cs7NyC4D0uT6CrsK2yI1aFs99mBAetN1RNUSRz2Vh1O1Xg
	 1XTCrL+eW4m6kZadXl8URTjEv8qLKY/K59bmyrcszP6EG5nmV2HMd5/2kxFO/m34Ye
	 A6TslhzP3g15MnaJhn7JpS7uYMy+qFiefQg0x8TrlLNihdDa6RvmaVxWnOxvBE6Ctl
	 moNrptV9UuZR1t81oQGI0yClpznpt0hxF4vAKlh6j0UFN1vBZLs6kPkN3Ys1/kJ5UV
	 SfODSPnYgi42iMUPcuscS8hAxZaU1QIXpAUbxCf61hB9VgYbXTrnUna1PKyVl7NuiT
	 cZYP2sc3R/ZhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6BA39D0C1A;
	Wed, 17 Sep 2025 02:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175807681449.1444719.15338254509817798982.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 02:40:14 +0000
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
To: =?utf-8?b?UmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHZlbnRhbmFtaWNyby5jb20+?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, memxor@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Tue, 12 Aug 2025 11:02:54 +0200 you wrote:
> Hello,
> 
> These patches are related to a recently queued series [1] that fixes the
> same bugs in normal code.  That series finishes with a patch that would
> have exposed the BPF bugs, but luckily it won't get merged until v6.18.
> 
> I don't know enough about BPF to verify that it emits the correct code
> now, so any pointers are welcome.
> 
> [...]

Here is the summary with links:
  - [1/2] riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
    https://git.kernel.org/riscv/c/ad5348c76591
  - [2/2] riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
    https://git.kernel.org/riscv/c/8a16586fa7b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



