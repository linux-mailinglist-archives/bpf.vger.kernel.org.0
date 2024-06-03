Return-Path: <bpf+bounces-31204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B98D85AA
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB76F1C21D8B
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF912D755;
	Mon,  3 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT6+eTPm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6384688;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426832; cv=none; b=Wrw7Wg3sppVwPgn/UexAwAqslmfZsOD+wZnB5ZAXAQennpRMppfEXm5okszR+2STGHZtb8XSfaLTVXzThxDWzMc88QQxJA3x77DtMVqN71WI7saCN2EVNtxk/ogXSRJlvY5G4TI+f6pjU0PC6yOCLhYYXJORogW5z/cbJQcVdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426832; c=relaxed/simple;
	bh=x9/P7shtMeW26Xh3QlGPi0H9bRUzWYXDZKt8zMV07eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZcsMf+pIRKImgO6mi+k6H8AcpeyR2cKfW2k8wGfxBrJW1gxZHUWMTUtPKGiz3z4/224DQ16nPuektZiy+B7FkAJUUddPMrMUN9GnLfPyzeK3TgYgwf8tFrtHjV3p64tPMvi6tMmwyJQKie2sOPPCz0swPMGkUYwHQCBIy5f0VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT6+eTPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B34C4AF0C;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717426831;
	bh=x9/P7shtMeW26Xh3QlGPi0H9bRUzWYXDZKt8zMV07eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lT6+eTPmvta6TTTauNkGVIgB23d8R9+jEBcqhcPUvp0WvGBmHzkp/FPmvxCq4NzGt
	 dSdOf3fnhbUh4GQVKvheMVYlUfiV+JiOPeuts2ElbBu3BcGMq5yq9iAFVoXdfnl7SU
	 AblKhMtraXJlpozQAZaxrlNztDDoPza6aTRAOdM4ZHMhSp7Bx/aO2zot4ElOMPGMfS
	 E86TWl3yVvpKbZhvEN+a1+EY0+CSU0nBgpZ2jRcQPPm3QdvZcBPBGVTzOp8A2DlfrM
	 JYauQVenUQWwmZJZdliXHkt7bEZhFzNg4xMOhBhaMEbc5UHpWrLnHAw1BO6IDTkVoV
	 9LzWEs6Jfv9QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56F62C43617;
	Mon,  3 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Dead structs in tools/testing/selftests/bpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171742683133.27164.9364551031995074993.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 15:00:31 +0000
References: <20240602234112.225107-1-linux@treblig.org>
In-Reply-To: <20240602234112.225107-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, kpsingh@kernel.org,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  3 Jun 2024 00:41:09 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   Clean out a bunch of old structs in selftests/bpf.
> I've been using a 'make test_progs' as a build test.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> [...]

Here is the summary with links:
  - [1/3] selftests/bpf: remove unused struct 'scale_test_def'
    https://git.kernel.org/bpf/bpf-next/c/dfa7c9ffa607
  - [2/3] selftests/bpf: remove unused 'key_t' structs
    https://git.kernel.org/bpf/bpf-next/c/3f67639d8e58
  - [3/3] selftests/bpf: remove unused struct 'libcap'
    https://git.kernel.org/bpf/bpf-next/c/a450d36b05fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



