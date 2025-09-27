Return-Path: <bpf+bounces-69900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32104BA5E5D
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E313A8D92
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415B27F4F5;
	Sat, 27 Sep 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui3EqAoD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044802848AD;
	Sat, 27 Sep 2025 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972613; cv=none; b=jrN952ak9iM33v54vjGyRS0YkJqGU4jMsrFiILbvRoR5aXQ2NqHNTls/v75B1YjKtYIWStYpo+TYZREi3nXzEDRF+V+XjLSWowev4+U4hxNnytKl+75oMyGNctumt1KyjkDskkj1LYblU3PCCltGVFjlRh9pnOf+dqsGPcPgMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972613; c=relaxed/simple;
	bh=OCHOz5W/2MukeeJ9QBgt3V3YC3mMSGhXm4jlQHCNFSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YvMgkRaqFEGlRPA1qinoRox9UTQ3RGfQ0WrYXT8croewBxicCTfYvSJidNlHFXgrRFxwAt24d/3oBCdbycVVTESNQnAKEILur1i9LD0BcsyM47uZ88LXYC8a5xuCs9JLIEhDAd0vh5fpfQk5Eb2GA6k+pPW+YILihNCmv9kakeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui3EqAoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92651C4CEE7;
	Sat, 27 Sep 2025 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758972612;
	bh=OCHOz5W/2MukeeJ9QBgt3V3YC3mMSGhXm4jlQHCNFSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ui3EqAoDeUraX49Xb1ue7J1Rmcm6trgz0Nsuw2Fy0/MWf3PzM/cpg8EvH8XkvOxYV
	 ucZBcNhCn/n6SikzPxDtVaFCuE3dDGlh9c0P5YgZti0GZaJ8njUUMsua0jFEwChcEe
	 WUTavhscAVQcY1ZxYZry0aYPncdPWHwjgrsfhHdn7/YjeyJHaGyQsnwxWVUWYOPKSO
	 FvBXn0c2+oTjLxbWwwx6XjI2J7TrCqoTuAuE1qLgIXXU7vTz46RJtpAjwVtYS+4z7Z
	 MXn8hsimNxh0eEMCP7xZVrNe45Yfuusfti+tMGU+BP77Q1gNThwSq1Fp0/oEcMIPpe
	 Jyo5q6wqlg1fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF9839D0C3F;
	Sat, 27 Sep 2025 11:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next v2 1/2] bpf: Remove duplicate crypto/sha2.h header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175897260752.228897.11178776166648300229.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 11:30:07 +0000
References: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 26 Sep 2025 17:52:39 +0800 you wrote:
> ./include/linux/bpf.h: crypto/sha2.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25501
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Combine two patches into a single patch series.
> 
> [...]

Here is the summary with links:
  - [-next,v2,1/2] bpf: Remove duplicate crypto/sha2.h header
    https://git.kernel.org/bpf/bpf-next/c/87608c2a7718
  - [-next,v2,2/2] bpftool: Remove duplicate string.h header
    https://git.kernel.org/bpf/bpf-next/c/4b2113413e76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



