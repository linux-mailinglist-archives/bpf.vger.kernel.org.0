Return-Path: <bpf+bounces-60618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DDAD9383
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7766D3BD35B
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18781221727;
	Fri, 13 Jun 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaQ16tuF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE062E11B3
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834604; cv=none; b=b22Zmyd0c137Ls7denUYuhasbpofusBLVvcGjSFd4JLUfGVD8pPB5FsX6V+aMqSUHMjs9okqaJ7TbUZqTu6hwszZUZyIRFuII9GwuYQNsVezVx/blq8Ky2OAE4+1/jPSMkJVIVYZFXGGUCMaDvm45IlnArMgPcMwVWH7HX0GbHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834604; c=relaxed/simple;
	bh=y8yzHD6TFNrQpmoxhB0vbhp+SJFn8rAqbFw3NdAIjQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bGFAjl0l5JeM/tWsbTXWNmFdnmoAxlyp1beYoYncUQ4RCOTz+iHu0bJ/WwQ2o+nuJ1KkEAmaz1YhPce1TC4nhxXneq7OExFcBX9sm16b3alI3ugZKnL/HOS6VgxGHhwB698nVgWLFdZE/Ks80/1QCY1vZRI5xD7t3PSm5hxDXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaQ16tuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7A1C4CEE3;
	Fri, 13 Jun 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749834604;
	bh=y8yzHD6TFNrQpmoxhB0vbhp+SJFn8rAqbFw3NdAIjQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TaQ16tuFLgkGZ5gmP9QYm5mRD3EYsQkya1Ue2ZkDJhzeFOAMtPGS9ZzqN2doUxBzZ
	 pgYrL8WtBbtiMuF7RveCH243hA4XK3aJx4SYsr6tMyxZdUJikjAiRYJNSd3e0dWbsV
	 200p3yH6Nxx4K1HApzRWNvTODdGGRePxDRw0d+qhU5Jo1bCerk2Vy8QRtjCky7O1Ua
	 9tp3mqo3V34GhK8b9cCtqt5Xv/VTtAUTVNuiGiKBEJFBoImVxSFQlDhI0j7aZMGbmD
	 vgX7NUnz6uFtgPCdfpBEP9nOroA2O5Y43ZxOfcMwZODi/AZ2b49G0TowBMa48flNpH
	 pwpD+0p8g+2mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1A380AAD0;
	Fri, 13 Jun 2025 17:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf/veristat: Fix veristat for map type
 BPF_MAP_TYPE_CGRP_STORAGE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174983463375.818370.6771258311488144753.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 17:10:33 +0000
References: <20250613050001.1058733-1-song@kernel.org>
In-Reply-To: <20250613050001.1058733-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 12 Jun 2025 22:00:01 -0700 you wrote:
> BPF_MAP_TYPE_CGRP_STORAGE doesn't allow non-zero max_entries. So veristat
> should not set it to 1.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [bpf-next] bpf/veristat: Fix veristat for map type BPF_MAP_TYPE_CGRP_STORAGE
    https://git.kernel.org/bpf/bpf-next/c/ccefa19335a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



