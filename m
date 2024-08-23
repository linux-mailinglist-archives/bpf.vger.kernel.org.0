Return-Path: <bpf+bounces-37960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65795D063
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F4D1F2316A
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E11885A8;
	Fri, 23 Aug 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih/kWiQX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355311DA5E
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424631; cv=none; b=r6RK8o238R8AnE/ouMEQ+25tVwuoSKMNfwE1cIsUeVnM609tSWH1/KXV+7qNFbEbeimAo9uV8w2ldbIH1M11NtIP7DNFRPA6U7b/ScGsgVVTTbE/rfm8ilOE64IUHqWQEDFVzZyXiYOCpSFG6/mNdNfvM2bm4WNojr/5XB465mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424631; c=relaxed/simple;
	bh=R1i4h6Nh+izZ8pQQ82IHbPLscsfbmcwhydm3WCXJSxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X7DHWkBszFsxespidT+XzkGPYi+KNleV1sWnmO51vGNZYc3Rz8EZoVwvz8EQsGsyMSYZb3JnL3mBc4RYR2ADKAdmssC9YmspqKskMetQYIO/tDpb+GzsKsh2bCqOnaMvZlWmFgJPNnIJxD7d1aFaODlmur6N+Pt8Xbt895L9yKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih/kWiQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA3CC32786;
	Fri, 23 Aug 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724424630;
	bh=R1i4h6Nh+izZ8pQQ82IHbPLscsfbmcwhydm3WCXJSxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ih/kWiQX3cGjjYCpQvF/bfMH2hroVsAxShM5f1eiurn/KYs5OUaEBePGf1RgRS+9v
	 jr/+Otj3osP6R+R8GnKGm1lLKWnamPLS3MPR2AzGGX9VT4oqz4y+CLjWU4zU+jme/f
	 Gf/lcdkKdLkyj/GvdCDR9FXxejz7TeAAxlk6hTDBRjNUhOQlTTA6kEMxsjNfyAzybw
	 jgZeXBy5F/z8kQfsfMLxgp0nLQ7CsOB+LCsPQ0VTZZ8QZsmPnj4O3oHoAnNEOb3oGK
	 Mp/nhkKVoxAJtrqHY4aYItiCAVeN6/+YaQbQICH3g909ul7QyIpWEM7kCBRNUd4CPB
	 U8fqaBpYRVNQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD123804CB0;
	Fri, 23 Aug 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl if
 available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172442463053.2988900.4775670735739732722.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 14:50:30 +0000
References: <20240806230319.869734-1-andrii@kernel.org>
In-Reply-To: <20240806230319.869734-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  6 Aug 2024 16:03:19 -0700 you wrote:
> Instead of parsing text-based /proc/<pid>/maps file, try to use
> PROCMAP_QUERY ioctl() to simplify and speed up data fetching.
> This logic is used to do uprobe file offset calculation, so any bugs in
> this logic would manifest as failing uprobe BPF selftests.
> 
> This also serves as a simple demonstration of one of the intended uses.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl if available
    https://git.kernel.org/bpf/bpf-next/c/4e9e07603ecd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



