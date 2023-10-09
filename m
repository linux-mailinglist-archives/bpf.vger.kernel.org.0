Return-Path: <bpf+bounces-11768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132B7BECF2
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616CD281F4A
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C6141E26;
	Mon,  9 Oct 2023 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCk3Bgdc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866041E20
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 21:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF51C433C8;
	Mon,  9 Oct 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696886424;
	bh=sKVXctHEh62JJk3vAH4XnrG9P6djuHmpEHt96khoJ9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qCk3BgdcSQI+q6NsahWBwtVfYMV1x4ZCHzyFTKTZNBk7oXEg3KPKBk47NTYfoVs2J
	 /Y5L1GmR4WOLuBiKPHnAk0hmGaFNSpS4HgalKedJ2VI3AncH5BLzqZ22JrX0mgB1HV
	 1HmSmATn0bTgvYkf2e81aHzRAtZJBDxmH4f592OQRSHStclvgEQhz8ohqWHHxA6bhy
	 +Qj9L12V52GVgSSgjBjcwIqZY3/SQMFurktusMkw1bIMHHbBR8CETYth+VvTi7ABNk
	 Rcljl6DBarIwbO934qxp6raP3FDCzO2qeqjPOVdd50vQ7YpSuqrLTS73fhDhkFo9BR
	 Y1TY7BLVjBjNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4D58E11F47;
	Mon,  9 Oct 2023 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix verifier log for async callback return
 values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169688642465.32608.1593187002988701901.git-patchwork-notify@kernel.org>
Date: Mon, 09 Oct 2023 21:20:24 +0000
References: <20231009161414.235829-1-void@manifault.com>
In-Reply-To: <20231009161414.235829-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  9 Oct 2023 11:14:13 -0500 you wrote:
> The verifier, as part of check_return_code(), verifies that async
> callbacks such as from e.g. timers, will return 0. It does this by
> correctly checking that R0->var_off is in tnum_const(0), which
> effectively checks that it's in a range of 0. If this condition fails,
> however, it prints an error message which says that the value should
> have been in (0x0; 0x1). This results in possibly confusing output such
> as the following in which an async callback returns 1:
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix verifier log for async callback return values
    https://git.kernel.org/bpf/bpf/c/829955981c55
  - [bpf-next,2/2] bpf/selftests: Add testcase for async callback return value failure
    https://git.kernel.org/bpf/bpf/c/57ddeb86b311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



