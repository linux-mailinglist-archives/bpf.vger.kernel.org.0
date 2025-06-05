Return-Path: <bpf+bounces-59788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF1ACF790
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB9218900F4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAD127BF7E;
	Thu,  5 Jun 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwdWznFz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515327AC4D
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149999; cv=none; b=EcCUCNEls2hboc83RpuRHvubVdjkypUOso9ZLFc1TOkUO7kUEo3Q8JgwLIW2c2k9iJLCx2SA18NBz+pprIewTyo6eTA0mpGkOE8eAtfpxOvHM38xTPBbMOUSCvogJ0gGQcO+EjgRGuTtoJry70zuDjoHXNbWnA5dMb1JWEjOZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149999; c=relaxed/simple;
	bh=FvHg20u59vST+m7bU4Q31Hjt/39H/Mh2RDJjemuzriM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gKsdzj9PhNNxZJty6iX1QClqOlSWntLmq8ET6Pskb/RSgl8TGUDFBHbCEpSLqUW86WHQyRoiprMJuOa+63qlYgGoIRkCWqC41AJm/pkVU1BZnIQopVORq90QpsotJBXI5NcVVD2ITdATg7sPPX8+CSqq+l3hp75fx+g3Ym0zPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwdWznFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C46C4CEE7;
	Thu,  5 Jun 2025 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749149999;
	bh=FvHg20u59vST+m7bU4Q31Hjt/39H/Mh2RDJjemuzriM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TwdWznFzgAuxL7aAKDBqsxtbmLxS2n5+tvWIui/jxR7i8HfaoAznenDd6tkCkS4V6
	 rW2gAF/Z1jFhkzFJ5IGjXxzem5qC4hU2J6XoqdXzKb+Xlc2fC+hhCrp/QZhpLVrdUm
	 hkmcgzwoEEwgxAJ6csfcQ8uyQd/Mujv+zfB8eeAArgyb/hIQ0fBaX8sQP/P4cheJV9
	 BkLqL2flGX9VjxnEH8wqlOIDDUTE3NpyZmMgHj0uh1VwPFi06rrSfe3WDf+vBpgKZv
	 nmwd3CXLZRnnaL90d2IkruEf4cDBGJQKiymFMuErtwYVU6XCQI4d+clbV4h6LhtuWB
	 B4fksCApb8gOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7120D39D60B4;
	Thu,  5 Jun 2025 19:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: correct some typos and syntax issues in usdt doc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174915003126.3199825.5114096952222938900.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 19:00:31 +0000
References: <20250531095111.57824-1-Phoenix500526@163.com>
In-Reply-To: <20250531095111.57824-1-Phoenix500526@163.com>
To: Jiawei Zhao <Phoenix500526@163.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 31 May 2025 17:51:11 +0800 you wrote:
> Fix some incorrect words, such as "and" -> "an", "it's" -> "its"
> Fix some grammar issues, such as removing redundant "will",
>   "would complicated" -> "would complicate".
> 
> Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
> ---
>  tools/lib/bpf/usdt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - libbpf: correct some typos and syntax issues in usdt doc
    https://git.kernel.org/bpf/bpf-next/c/919319b4edfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



