Return-Path: <bpf+bounces-31205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372DC8D85AB
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E511C21DBC
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490C12D75A;
	Mon,  3 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiNcT0Ug"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6002566;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426832; cv=none; b=ghR/KaTWDcKQmDLUArDNyeAZEaaGBH6/JCEphJTCqlLndlGQNWMMNo8zRf95buDOgVgMqWMBp1yeOWikhZxbGSYJoQo1veoye+iQymA0mTHuS3YvUsS+d9DTxXU3wfO4FwrJco+6bl0byTf840U1e74ZZTb1gYT36SmEtkwbxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426832; c=relaxed/simple;
	bh=nQ/ZC0HkSNtdKvXFuFNnWNPgedzKv4BHuHlR+3NHmXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qqbM/LcOPscOodjLz7obmc28ZG39GNmkdRSyDBhOn8nGV9PUB8Cz7kESgjsp8BJU6BtXgay522zHG4NLEQCWPL9dEZZt0C9tdlm0oLBmiCMu2CJZ9r1XkoVP2Tn0sptK+7kwDWnxZeStPmoDa6KvwIdMK0z9PstQ+ENoycl3Hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiNcT0Ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D262C4AF0B;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717426831;
	bh=nQ/ZC0HkSNtdKvXFuFNnWNPgedzKv4BHuHlR+3NHmXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HiNcT0Ug3FVpzNp4ucjQksj1coDpSMGHh1erHFHb9zwSNDrEHCGXpNmQmxwQFdnIh
	 C2ZjLq1gJUa+hkGkoEBJdfaAFrgkgt4nSV5WyaaFYvPTLkExvKangYEYbJ8HG/40xf
	 Qc3tJRJDF4we6kINiCC5Isp6tzEn39bSLuIgQUms9IrYLUzr4KJA5HQ/E5Y5thJVIa
	 2kWEb8DBUVdEAh/C2BhWAm+u+A2S6zEpBK1qnAUS8gsO2F0lF/hIEybTeRbM2wj+66
	 +pMGDWvDnsDGFyVEDnj49oBFAPbyZzFlH0HZRqEgqaTXznYGftjKrpSx/+OE4f2Gd6
	 L3gIt5BwUnqeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66D18CF21F9;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/bpf: matric typo erro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171742683141.27164.14897538327066785184.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 15:00:31 +0000
References: <20240602225812.81171-1-beaujardswan@gmail.com>
In-Reply-To: <20240602225812.81171-1-beaujardswan@gmail.com>
To: Swan Beaujard <beaujardswan@gmail.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  3 Jun 2024 00:58:12 +0200 you wrote:
> Corrected typo in bpftool profiler.
> 
> Changed all instances of 'MATRICS' to 'METRICS' in the profiler.bpf.c file.
> 
> Signed-off-by: Swan Beaujard <beaujardswan@gmail.com>
> ---
>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - tools/bpf: matric typo erro
    https://git.kernel.org/bpf/bpf-next/c/ce5249b91e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



