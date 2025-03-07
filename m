Return-Path: <bpf+bounces-53594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A9A56EEA
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D623AEBA9
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 17:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0423FC5F;
	Fri,  7 Mar 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwDpNqcK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAA23F40E
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368001; cv=none; b=RKZpGSfgTTzT0eEHlEt7mcbeXiUq8YuHF2X/77NWquz/0lZVevv0ZawdzNsXsnaYfI0wJuOPjh2+T42m8TuQBPs0Ov8Z+71mAe7TdfK/nfp20j4OCFRLcxBPoTWGEMufIshawAY4TBbTUaTpDeZ1D4xnsVBANlpKTRMMkZeSHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368001; c=relaxed/simple;
	bh=nQMDLj4R3pd6H0tP3ZlxgACxgU5SEreKS6aIIMWXHCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MA+jnBOB4IEiIWcCPkwvq7wu7D9LbaDmj6rV66UnaYGUAsu2CwbiRyV8wMd8UyqW6L5ACbJHKjlHfa6629Lr17crtcExjVN2oyOdnOV2XHJdGzewZ8qOT0yqAoyrlzIsgjgCKdqIUiStRG1kbQjhkGJozLqGNdSMCiAWf/MxTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwDpNqcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4595BC4CED1;
	Fri,  7 Mar 2025 17:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741368001;
	bh=nQMDLj4R3pd6H0tP3ZlxgACxgU5SEreKS6aIIMWXHCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NwDpNqcK7PDTDKPS5Zp/VW+xSeGLH23oHZMnjKO5a4DGszIMweZeCX5Mv9MhES6vc
	 EzGpSBmZcyyJKHcBOQpsPEAbvGehSBdFXE9n2RK0Pc1Htf6+1nk7EhlkVZ235YVmCP
	 Zhnf+4isj6dMiCW1Y25kOIcJL+hrMmocDleyMAexMYNL7Z0XPwBTmsc2MU4bJ2Sdl6
	 Bj8p5HC+d6bJmUXVBTBGvMZUtI99ZoKwffKLDbmOhrOCkxw0QNVwcPQgQmaUSIi4HH
	 3roeliLXoyE/E4gsmu8lKRI9hn+lnCP0I+53mHkPEVaizd38S2hTRq0l4FO9tFrnvh
	 PMt+qiiba0cxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC3A380CFD7;
	Fri,  7 Mar 2025 17:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Strerror expects positive number
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174136803477.2418947.6672474115303496706.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 17:20:34 +0000
References: <20250305022234.44932-1-yangfeng59949@163.com>
In-Reply-To: <20250305022234.44932-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
 yangfeng@kylinos.cn, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  5 Mar 2025 10:22:34 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Before:
>   failed to restore CAP_SYS_ADMIN: -1, Unknown error -1
>   ...
> 
> After:
>   failed to restore CAP_SYS_ADMIN: -3, No such process
>   failed to restore CAP_SYS_ADMIN: -22, Invalid argument
>   ...
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Strerror expects positive number
    https://git.kernel.org/bpf/bpf-next/c/7e437dcd3975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



