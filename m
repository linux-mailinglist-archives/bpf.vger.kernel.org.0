Return-Path: <bpf+bounces-47065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9989F3B06
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E5616D37D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31D1D47C3;
	Mon, 16 Dec 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2DW4THH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85D1D45EF;
	Mon, 16 Dec 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381614; cv=none; b=p8v9WwYZ57iy8Cww+qdmgT0Y+F/tUISAWOLyJf1LCaMQaqqPmtCHmmQFpdRjmL7+fzbwF2mhu4GnaTNFqs4d2OyF5krOvm5fjnov14ewNgU9iZu8GrUwh2yVj2j3Xd6WbJelLvcUN3NUrL4yowWnCZ310e+qRKqdPe5oPPWAdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381614; c=relaxed/simple;
	bh=YFGqhpyVPnOYQpDyIgSWoLGeRmyVo9fNbmzrRfMbe+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TbQKUCTeYVpQ1pTKE52Qgx6sA8DZNVN1QCEArKqMVRSaY1Cxws5YuhLjb64MlUvRSZIOj7XsFr54AUZneDoeR0ZCkHmINfIVUYsFAypGEKkkNaB55cmhUrujlGn3RjBQP5ueatj2/kWi99yM08NY6xmJt7qxctdzpeBcBiCorYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2DW4THH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD712C4CED0;
	Mon, 16 Dec 2024 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734381613;
	bh=YFGqhpyVPnOYQpDyIgSWoLGeRmyVo9fNbmzrRfMbe+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J2DW4THHw5BrCyjm4CqZmvYPXm1hBoHhtPuhB04ic2zCN1ioU4EhTo0Z0OU1zN5tQ
	 QpDWMmLvelX8aKl2FWUSmK1EiNC+aey2+sSp/9zlHWkmW8JOXWlMgBBxid9S/zuZ8p
	 /b28W9AlI/wdT03TA21Hp01+I+v996ZoLkwMCnAfU8M/jpYR7/43YiLDzC+G5i+xKq
	 QhjBnF2Tuto3kxT5arliD2RO4eDaDzPWVyFF3n3rJu9piFSVISs9+uPhzD8EdwxCOa
	 v7ClX4M6V081zGWB7AMexEU+onxEAdBycaE5i3UYTQROceAudR8VIpdU8n0w1kYR72
	 Twvh1k+OM2fYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344043806656;
	Mon, 16 Dec 2024 20:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: lsm: Remove hook to bpf_task_storage_free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173438163084.338924.11471264348219299930.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 20:40:30 +0000
References: <20241212075956.2614894-1-song@kernel.org>
In-Reply-To: <20241212075956.2614894-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, kpsingh@kernel.org, mattbobrowski@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 11 Dec 2024 23:59:56 -0800 you wrote:
> free_task() already calls bpf_task_storage_free(). It is not necessary
> to call it again on security_task_free(). Remove the hook.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: lsm: Remove hook to bpf_task_storage_free
    https://git.kernel.org/bpf/bpf-next/c/58ecb3a789fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



