Return-Path: <bpf+bounces-41522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AF997A38
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9B51F23A88
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B883839C;
	Thu, 10 Oct 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF7z0AlA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0F63D5
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524428; cv=none; b=dqOTW5MuEP4tK1okIXAfLZ5WnuwaSMciAayTXH1HZGizjTp6wX6dYRnHy2jxQpB3ZAz9QPW1aM8t1aUYtU2JcTjiX3yH1d4OHggw7RoWZIC4w3X2BHJdaRMUwc/zUDRmwZ97Q8ydqnCGT+jwUgOv17yMA4hqH1OgDdoXhpj836k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524428; c=relaxed/simple;
	bh=EFKO78LFiV8Bd0sa6akFpmbxq+bRTocn9HXQpq8XH2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G4NIhRFr6QzM6/fAbtQlIgGPvv+vS0wVOTRBC6eXM3dUeNhtDG+54/MtSdLE8RgENwgYyWntCp0Q5B8PjP3eF8JI2SvAc18x5khMWTeTWP43GJOhuIgPhAQp5K8tbkE/eVOUmdDHVoX6PaPqfpq5+ZMWDNP1dc+E2KTiEuSsmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF7z0AlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34F3C4CEC3;
	Thu, 10 Oct 2024 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728524427;
	bh=EFKO78LFiV8Bd0sa6akFpmbxq+bRTocn9HXQpq8XH2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gF7z0AlA6itBYclmlvhEEc6Bhe+15nH12Qw29bIgTPWOFzJ1+HyUQ4el5fj4hyg1/
	 Sc/1PDAu4H85LXznVma65XL7x8T0BHEZRF6AsAUyDzYoSSJdxT3MAz/SLEkkoaHgeC
	 A+eF2Z83ZUeq16QFDbsnI+sEAgWMLwdfOmLhf4nB3PwVhx7/CD5N2sSVdUxDGOOOvl
	 jYJ72mibsbiV8FpUumPT6uy0x+eLUnmK4dJLZPSf2yK7rHW1uTy/pfASM4h87Z6dhU
	 yR/0EIZ+uyVmX9JysuzHhrg1vdSsXAG+c1zMlG43Kv/KX/eA7DvYLb4F8LE3YUmud2
	 lKP/oGMUQVKdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2B3806644;
	Thu, 10 Oct 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: fix sym_is_subprog() logic for weak global
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852443198.1533554.16310448135374867711.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:40:31 +0000
References: <20241009011554.880168-1-andrii@kernel.org>
In-Reply-To: <20241009011554.880168-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Oct 2024 18:15:54 -0700 you wrote:
> sym_is_subprog() is incorrectly rejecting relocations against *weak*
> global subprogs. Fix that by realizing that STB_WEAK is also a global
> function.
> 
> While it seems like verifier doesn't support taking an address of
> non-static subprog right now, it's still best to fix support for it on
> libbpf side, otherwise users will get a very confusing error during BPF
> skeleton generation or static linking due to misinterpreted relocation:
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: fix sym_is_subprog() logic for weak global subprogs
    https://git.kernel.org/bpf/bpf-next/c/4073213488be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



