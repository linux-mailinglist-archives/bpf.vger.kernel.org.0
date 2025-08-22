Return-Path: <bpf+bounces-66302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41454B3226C
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FBD1CE7B59
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C22BF015;
	Fri, 22 Aug 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAUSxG6/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854719D07A;
	Fri, 22 Aug 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888598; cv=none; b=GGTe1EcKGBZ71DSa49hvsa5/WpaubfYn0RUOhaeaeHz5Myohlm8Zsc1eAyiq0HzfkcKjCRLeEFnCuwhryrzk+DEAXMGmdeT/JZkkVRkmMvsWTKPyVt1z/gUijW5y1OpktqgQpQebZ1Tey6nREMvfaB1ZAbyP1sb74dBT4rJUNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888598; c=relaxed/simple;
	bh=8JkCMpeRbDU50O8SsxDiQ1LyoPtXp+L6eRK0J6ivPV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VLRVBWnNn76fx1QOrfJS8oEqXMYqks+7C3w0W6GPbxVnsQ0casYuoxCthdqcw2xofu9bsp5zxzyWD5NTnjTMX1mv33R0y7mRUbw+udVeGK+9gb2xMqfhBLppxdDKXi0j3UK0LmQdjnH/17blCrUxbVbC6m0Pgi9drCsFTUpjjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAUSxG6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA588C4CEED;
	Fri, 22 Aug 2025 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755888597;
	bh=8JkCMpeRbDU50O8SsxDiQ1LyoPtXp+L6eRK0J6ivPV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tAUSxG6/PnOloJdyGjE4WnN5Fft+qrLBqU/aAl25yhxR2xYogF4eF47Fve07YpM8y
	 Wj1kpUb1EReb+dZ4L3b9IK7vlAeuDBcabVknoRLy/PV+ZNx03UoIXHVUAFDfKHBhkc
	 WjgIYCfBhBrz8HxR8ljGgWmZ7/7H1eUDOCwDouGzKCwu1VY1XzTpVr6vI9z2MYJUFJ
	 sQtKS/C1nVcHopLR2ZxbCSAd4Qj5TdFsEnAPB5OqDATT5oxceHYPfVTyJ5M9voTnyB
	 uPhAFuqhQCx1j6Qr/gXpbMANW2QzwR4XWmTqtABc13HvGOphdPPjzfXKeGqmoCEMYh
	 Z/naFqhzE9bHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C9383BF69;
	Fri, 22 Aug 2025 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove preempt_disable in
 bpf_try_get_buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175588860676.1932482.18282150821754176033.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 18:50:06 +0000
References: <20250819125638.2544715-1-chen.dylane@linux.dev>
In-Reply-To: <20250819125638.2544715-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 19 Aug 2025 20:56:38 +0800 you wrote:
> Now BPF program will run with migration disabled, so it is safe
> to access this_cpu_inc_return(bpf_bprintf_nest_level).
> 
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/helpers.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Remove preempt_disable in bpf_try_get_buffers
    https://git.kernel.org/bpf/bpf-next/c/4223bf833c84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



