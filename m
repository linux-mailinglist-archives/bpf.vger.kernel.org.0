Return-Path: <bpf+bounces-31500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733208FE84A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D27E1C242E8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212319644F;
	Thu,  6 Jun 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLy04ucr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F72BAF1
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682430; cv=none; b=Tox00PJh4bDSN04AX21jyeaZ6qjrKGXxhOK3+nt7ZcI69lF9YTVhR5dcs6Nf4EXprbTjL5rNSW1SX9b5ojrKF//5t31D8ZrzBHZzYDo0XJZx2kds+R8kigwofZlEvshZZKMMMpgfIuEWDVMuz/E54sPWrBTFKHojEbSzKFtd2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682430; c=relaxed/simple;
	bh=rDVGg93LXbmMuI2u8GQ3HmpI06W++huougJuRHCDd4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b9NpwCeleeGiDOmDQ4JZ452kMKo1MiYKTBhGtF5PQx+z7AekKYO2A7L6Br5+X0f7u2cyeEjS1lK8owPQPWNKlQ9z2rceNMI8cEEbBwgX06HxKiF19Lc9u0pEoVNEkkReU8d9RRfn2La/SnhEP9xq+9y8rOJ2DiBvaKW95n4I6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLy04ucr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9B5AC4AF08;
	Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717682429;
	bh=rDVGg93LXbmMuI2u8GQ3HmpI06W++huougJuRHCDd4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gLy04ucrLGOTKI2kKcbMOHF3ulGKj9ysZsyaP0XApsLYpNvc02L25t/bVn+mJPGKG
	 1E+/d0r+kiL1Eaw4QT3z+x/avkyjngm2b9/q5UnSiB0QbReumfai7wBcldkR6YVnNv
	 /ANQSIK1gzKCePvSwvQxIZzgXFw3MIYY+s2aT0A9SFtEKNGMIJjY9GpfSVkBFbYoMR
	 XZ63prW8zxm2iOgyxb/jnDd//t02cwir51FTt3Yg9fKdKHzOxVeoy7oS+1HJ8Qj892
	 N/LmpbMkffEABeWap7f2pJw2OjdXyT/yGRVAt80ptLjIEhOlZW8kUaUO2u3AR2e1bd
	 qVrMUrVUdbImQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6F3BD20380;
	Thu,  6 Jun 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix send_signal test with nested
 CONFIG_PARAVIRT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171768242968.31397.12693861726199260419.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 14:00:29 +0000
References: <20240605201203.2603846-1-yonghong.song@linux.dev>
In-Reply-To: <20240605201203.2603846-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  5 Jun 2024 13:12:03 -0700 you wrote:
> Alexei reported that send_signal test may fail with
> nested CONFIG_PARAVIRT configs. In this particular case,
> the base vm is AMD with 166 cpus, and I run selftests
> with regular qemu on top of that and indeed send_signal
> test failed.  I also tried with an intel box with 80 cpus
> and there is no issue.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix send_signal test with nested CONFIG_PARAVIRT
    https://git.kernel.org/bpf/bpf-next/c/7015843afcaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



