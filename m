Return-Path: <bpf+bounces-32750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC82912CDB
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE8D1F23F1F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5116A95B;
	Fri, 21 Jun 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGU+Rkep"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDC4EB51;
	Fri, 21 Jun 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992834; cv=none; b=C+SAXY5CHljGo2SWQV/kqjwzJ/UlTDYewHWh70gXlRITniu2m92nnJcNWaC5GhduMD2Gyk1HMsLGxSUW2FOkZLimJNARdbKjhU5cUvxcd+Qsq8jzxo90P5zfMO15g8TCRb5smGONIebGu1oapIsK606i9j2jrrZlKLV3yYazfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992834; c=relaxed/simple;
	bh=/TfYzbRrMR59VoxhCrhlR0D3drg+JbEwqctR3YOyN98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=irdoCg7XYcSdaQsJ7aC6CWHaYPCsiWuR1yxtvHwOd80hDfXM3mI56GJoQQF5UODv+Eb/rMgzZ7hXA/Rdno+LUIsr4IYparaSbMUSB0mUtkWIcvCPr5ujdCnUDc8rlnVQLO8dmGcq1gYXxFDATDA09WXJd/QuD18qSZjtarcH4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGU+Rkep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C305BC4AF08;
	Fri, 21 Jun 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718992833;
	bh=/TfYzbRrMR59VoxhCrhlR0D3drg+JbEwqctR3YOyN98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGU+RkepAUh49R/R4ktjsmct2EComSzCJyAb/i0YzaInwmvZJNO4PNZsNcCOrJnmI
	 r7AR9656eJVl0bdWKUWCsUMYxjvORpje08oV/IRDkUwFhWwxzVVpSSAtsUiT6klS8h
	 lmcHjhgqMwYymLtcpF+jvCk895wrUzqCH/qLdMG4aWAAMnptbNTZ77LOcOXsNWwIPk
	 hpx+tOGkQtHd3w31iEZR2/3w/Q2S704aFleb2Ru0EMO62bpXtwGgD3qO8jFdrsgvP6
	 11Jz/HKc0VYXy4AhHRZEzuttfGi+VKB1d4KJBT1VmROn4EqP4FMu+i8cQkjwRbvz7a
	 P4b9w0gj9N83Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE9C1C4332D;
	Fri, 21 Jun 2024 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: add security_file_post_open() LSM hook to
 sleepable_lsm_hooks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171899283370.11208.7190626414627047538.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 18:00:33 +0000
References: <20240618192923.379852-1-mattbobrowski@google.com>
In-Reply-To: <20240618192923.379852-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 linux-security-module@vger.kernel.org, roberto.sassu@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 18 Jun 2024 19:29:22 +0000 you wrote:
> The new generic LSM hook security_file_post_open() was recently added
> to the LSM framework in commit 8f46ff5767b0b ("security: Introduce
> file_post_open hook"). Let's proactively add this generic LSM hook to
> the sleepable_lsm_hooks BTF ID set, because I can't see there being
> any strong reasons not to, and it's only a matter of time before
> someone else comes around and asks for it to be there.
> 
> [...]

Here is the summary with links:
  - bpf: add security_file_post_open() LSM hook to sleepable_lsm_hooks
    https://git.kernel.org/bpf/bpf-next/c/6ddf3a9abd9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



