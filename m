Return-Path: <bpf+bounces-30503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC98CE83F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEAF1F21113
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149812DDBB;
	Fri, 24 May 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeE5LjSm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D26E5ED;
	Fri, 24 May 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565829; cv=none; b=LHVpBC/RwUeXoY4uduHp5EJuqxv25xl26T6gJWYk/IGps7kNLsqAZs4MggpBC4poGP/i3mOSZ2VoiC2Mqwo8ZKcn5R5atQKqL/O98qpZ10jw3KnyIUJY4Xu3+OwnSbuS014eUlzGRIp4vNUA9aF61If6JEqfEJTHghloTlsUWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565829; c=relaxed/simple;
	bh=4jIIEb6/gXnMNCg0cderAh9wEIoOYtF0udZJb/wrl+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHIhV37leXIpUSNY+rnbq8RHG2t6NaknLLHszVziMehE6DQKmBpF0s7RbJbd4v1+gMiK8E8AviRP0UPCSemC/ZJQAUzHbfyzgA9nSdZ+f4iM+70+wE/QKCKxdA/LLQYAPEUbQ7ZfLhHCjuRD2Jczhp2VpFmsKRw5J6O0N8mEDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeE5LjSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F08FC32782;
	Fri, 24 May 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716565829;
	bh=4jIIEb6/gXnMNCg0cderAh9wEIoOYtF0udZJb/wrl+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jeE5LjSmmqOHVFQZidJJzaINJGj4SkgBwTUUkJ/px4uTN/JxeS6Xz0Sx/iUKO4dIu
	 DEh+zeP+4CheqspYZGnoqJOGl4LPVdKWsA1A7n5vuTFpGyjNtOKdaDxvBXZsTyhIA6
	 HLYUOev/CYKAadJxJGm1tY4tAGdQCJd3Cuitj8psNJkHSHh35fkkX/32OtExMZSGQZ
	 fQx0GtjhIHOHQ9gjFpBUyf48LgYiMBtNONrTi7XV9JlivuUkwYtJFUZjLXGQIYVd6g
	 AXxCPXNx9B5Cp/SV9BL6nHAQIuARL8a6VzHyNSIMfygyyjm+PKeFJQmKw4CNnNgi0Y
	 iOqdEhIh81Ejw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFC6FC4332E;
	Fri, 24 May 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, bpf: try RVC for reg move within BPF_CMPXCHG JIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171656582897.29053.8717064385202136071.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 15:50:28 +0000
References: <20240519050507.2217791-1-xiao.w.wang@intel.com>
In-Reply-To: <20240519050507.2217791-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 luke.r.nels@gmail.com, xi.wang@gmail.com, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pulehui@huawei.com,
 haicheng.li@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 19 May 2024 13:05:07 +0800 you wrote:
> We could try to emit compressed insn for reg move operation during CMPXCHG
> JIT, the instruction compression has no impact on the jump offsets of
> following forward and backward jump instructions.
> 
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - riscv, bpf: try RVC for reg move within BPF_CMPXCHG JIT
    https://git.kernel.org/bpf/bpf-next/c/99fa63d9ca60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



