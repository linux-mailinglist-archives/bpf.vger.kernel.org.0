Return-Path: <bpf+bounces-21103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C060847C57
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76F6B20BA7
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E518592F;
	Fri,  2 Feb 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWa638Ah"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163933D2
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706913027; cv=none; b=QGJRBMIFk0YgSnzhZ8hQYm223G42HP8aJjOq98BBqkBg4Y88r2g0qrNPoqn5uvKcgkqWRXwGjUMe3gdu1ghu2Z26wzizPfPM80YfL8VsGWGeBzKyO0REcKPV0xTxa4FSW9Q22uakzCb0NP2twkz/95s4xLXOmgFIWFe3r5xDsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706913027; c=relaxed/simple;
	bh=0dsBlyRNmGbIJV9rQGk93eXLuVsboa3wKLoVeGfaxLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e4YMZWOC1oKFIFKKAnj18cEPcoxy+e1R0gwZUH9P4kF2A4XntVRPTSN4hAP+fnN0Ep1WVb1B6OIdRzX+rLK6zCuNscKosJyb2GP1oTL+gHdNF+pso8dNfwOCkaIvfrsW+qk+OQFB9VOhOTUZzOkPmMAjH0WBcVZ1nku2xbjHKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWa638Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BAE2C43394;
	Fri,  2 Feb 2024 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706913027;
	bh=0dsBlyRNmGbIJV9rQGk93eXLuVsboa3wKLoVeGfaxLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GWa638Ah1mbE/qC5A89/fg8GPaRJGkJNA6EW2j0IJdztv5q9IelnP3uT7Rs/ljJiW
	 bqposjeSxIr62HZRId+N5hdJX0cIgpsWSUbR+5Bei2JTtAhoHIPvFMKIarXFZRDuoj
	 QNV/ON92umMsZiLGwXTxueV65DzOoNXtSpWyz3KM6TGwhkS06oaKgTdfTmFZcx+YIL
	 cuvcp3tdQw8sLS3PTadzl9c+lq/KS9jrRg+tqLOjeyIaePbDTJmU/T9PGYdzS/orls
	 9A+rOaUDO5wnftv0raCc9xcVep1dDS8MJsspBg7A8yqxs0zCksNxy2iX5k7XBb0l35
	 /B0KZcDaQzAaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8AB8C04E27;
	Fri,  2 Feb 2024 22:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: trace_helpers.c: do not use poisoned type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170691302694.20556.7673501343612316785.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 22:30:26 +0000
References: <20240202095559.12900-1-shung-hsi.yu@suse.com>
In-Reply-To: <20240202095559.12900-1-shung-hsi.yu@suse.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 rongtao@cestc.cn

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  2 Feb 2024 17:55:58 +0800 you wrote:
> After commit c698eaebdf47 ("selftests/bpf: trace_helpers.c: Optimize
> kallsyms cache") trace_helpers.c now includes libbpf_internal.h, and
> thus can no longer use the u32 type (among others) since they are poison
> in libbpf_internal.h. Replace u32 with __u32 to fix the following error
> when building trace_helpers.c on powerpc:
> 
>   error: attempt to use poisoned "u32"
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: trace_helpers.c: do not use poisoned type
    https://git.kernel.org/bpf/bpf-next/c/a68b50f47bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



