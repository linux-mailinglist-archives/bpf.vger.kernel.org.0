Return-Path: <bpf+bounces-48597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5BA09DAB
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 23:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5A8188D772
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774F20ADD1;
	Fri, 10 Jan 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcTZ0OYu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54424B25E;
	Fri, 10 Jan 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547609; cv=none; b=APwBavluyfGun2qXzMAo2cBXWZqVj3bDbCYWzE+sCLZQfiPVTVZjhKQQMA5cAdDCUO/NeaOPnyX0F2IbmrQwK7gPff6FcigZmkSxGnPsZ6lkrR3qhUwacbXTAJhye3qgAftzhHfW4F8NpEldbKusln7AV7r3kiXmCW9LJelpQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547609; c=relaxed/simple;
	bh=TswKtRWS3U+GrEmZH00OfcLwouW9F3F+AEoTSlIlWw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IBd3DBp5uPmadtjwzcwC5mEef3+BDOoE7EdMaL75qWJNsPG0WgFZJFZL0Jkv88wEEt8s62MW6ZNm0Inrq+fBn0t9XBthElv4cKWzVMUNgS1uMpNB9uW2TOP0/cRc/T29LXaQucCbuatiWBas4YU2/HyYymP92P8986/lb2+o+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcTZ0OYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB160C4CED6;
	Fri, 10 Jan 2025 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736547608;
	bh=TswKtRWS3U+GrEmZH00OfcLwouW9F3F+AEoTSlIlWw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcTZ0OYuXsbZZekh45azPn0zdRkOiX66uZdAviGXlgxM6PHjiGaxUafYrcHwuMnWW
	 qrM8hVvom07AF0DvJfaQ+MVCahusfWBmiBr0yVMFDrVCmoJz5+ZGoTHMnYzaAeHWO9
	 XheEyR2RSWU3PwlJ1/Vr9Gw5bHzZ53T3QRh01SQ1sEyDQXC8vjSTBfDiStuZrduIQ1
	 YX4EIeyFBrrnqXaW1lAwl4sYvFkdJzfi1dAmw/z1/tYhfEdVKPBAeZNqN/Loem3oC6
	 Z2OR9ymeX5wiKSse/LweaTfrE/u38XUpG7yJlRlVBZZdtEE9DERYz8xJtk5eaQ/aWL
	 PMN3dfJNHg7qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3FC380AA57;
	Fri, 10 Jan 2025 22:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: fix control flow graph segfault during edge creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173654763080.2219667.9500604953564941465.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 22:20:30 +0000
References: <20250108220937.1470029-1-christoph.werle@longjmp.de>
In-Reply-To: <20250108220937.1470029-1-christoph.werle@longjmp.de>
To: Christoph Werle <christoph.werle@longjmp.de>
Cc: qmo@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  8 Jan 2025 23:09:37 +0100 you wrote:
> If the last instruction of a control flow graph building block is a
> BPF_CALL, an incorrect edge with e->dst set to NULL is created and
> results in a segfault during graph output.
> 
> Ensure that BPF_CALL as last instruction of a building block is handled
> correctly and only generates a single edge unlike actual BPF_JUMP*
> instructions.
> 
> [...]

Here is the summary with links:
  - bpftool: fix control flow graph segfault during edge creation
    https://git.kernel.org/bpf/bpf-next/c/defac894af93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



