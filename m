Return-Path: <bpf+bounces-65795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AEB288EB
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8D5E4CF4
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B7283FF4;
	Fri, 15 Aug 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk1L9gAA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D68EEAB;
	Fri, 15 Aug 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301795; cv=none; b=erlv3gMPtJ4JuZ3r/b1GMrPdrUs7hESkEwl641oU0Qm8EPKZj3+EEtahDhtF+E0ndgJ7Ipch75tvDQAidG9u9OApZwSNjRxG8RqX3sOQ+iZWawS7rz81UV87T1aHEq5pFtzmnCbLcrt5Hz9640BysQWbxtrXzoLP0i2/22q5K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301795; c=relaxed/simple;
	bh=lho2GXN+NFhJNZdZMJYB5RafrXPERVjeLKyMmyzoK0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qa3dL60b6K59HGZLjGsAcqYXF0THModmYcVN/I9OHQ3Mpy+D2GV6yGq186uniHH4s6QC6sRisC62xhlfx+m7JuCl3wvewhBszI++KPoYwIUUPNBommAXFvqB00CzUnWSt+M4EfRN8v9qHIttA/Ouz5nOe0zA79vjL8rP4WXhS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk1L9gAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E74C4CEEB;
	Fri, 15 Aug 2025 23:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755301795;
	bh=lho2GXN+NFhJNZdZMJYB5RafrXPERVjeLKyMmyzoK0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uk1L9gAADANSaY+p4muVA++1KSzfw15sm0lFtmpnfwfGJq/kK0kH3f9guw+LvzXQp
	 OIgpBG9AXeYcP739+cEn9R63zgsqsE5tri/E0Kh+SkOZUCiZYxRue03uQK52fxvE/A
	 DIHYfsqReazVuUHiDCMT43SK+4t/n4h8KiIQeluHqhwXQ/hsQlO0XOjJ/NihJUkoev
	 NusDyjU9sQCYaqvPYDqPHSeTS+/67Qs4up7CHnY+do9DLbKSjB7JrzTw2luXYxd6uZ
	 Rjao8aepLkX+z1coH0dDJSUXaEKT2QfcNxovJU/GB+GMvQK1/hmifF1O7xb1e1yyAD
	 J4qO7Gdvfy4+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3400939D0C3D;
	Fri, 15 Aug 2025 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: Remove migrate_disable in
 kprobe_multi_link_prog_run
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175530180603.1311304.15839903815773107101.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 23:50:06 +0000
References: <20250814121430.2347454-1-chen.dylane@linux.dev>
In-Reply-To: <20250814121430.2347454-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Aug 2025 20:14:29 +0800 you wrote:
> Graph tracer framework ensures we won't migrate, kprobe_multi_link_prog_run
> called all the way from graph tracer, which disables preemption in
> function_graph_enter_regs, as Jiri and Yonghong suggested, there is no
> need to use migrate_disable. As a result, some overhead may will be reduced.
> And add cant_sleep check for __this_cpu_inc_return.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: Remove migrate_disable in kprobe_multi_link_prog_run
    https://git.kernel.org/bpf/bpf-next/c/abdaf49be542

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



