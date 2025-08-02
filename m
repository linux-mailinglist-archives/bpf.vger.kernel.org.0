Return-Path: <bpf+bounces-64943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE7EB189C2
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 02:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF4B1C25F9E
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8C29A5;
	Sat,  2 Aug 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX1N4cFw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBE2CA8;
	Sat,  2 Aug 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093628; cv=none; b=fa9NHRpTZjzql6o74Lnefgxn0zbiHPMj31w9ZQa8z/iBMlydqLg3OawJvoRM1cp+ZdGnKG0+PYgKaS7QpPyl55gtA9PrGWQhSn7yJ/D2Bo+CruEe9m2qSerZrBcuoMRHHtJBRuxMnYH92Kwr4DdiWGUDPGy6iQickBysZ+YF5Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093628; c=relaxed/simple;
	bh=NFlXoApd3CPjEwQEtOgO8eJ9vKqvMEwqp04r+9HudI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CQGMM9JJbiIUYRySPA8xrfVMkIQOV31g5e/Bk5sYTj01zXtuPKVkDAxr1mejqz7o2/8CM5+jD3XQsxGV6KkAMfi64KM6FbVpsOLl51Y6ZPeLvYVb0rPKj6KL5YDKB7/L57vEKVwg6l9ro3NDFHfTUOL4f1dmvYYd3dru21T/Fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX1N4cFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4DBC4CEE7;
	Sat,  2 Aug 2025 00:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754093628;
	bh=NFlXoApd3CPjEwQEtOgO8eJ9vKqvMEwqp04r+9HudI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XX1N4cFwjCcMo3HhHoDw54YuTO3Dp4Vfdsg4AqLZO00b2/Nwpz1dv3j9W3UA8I0Ah
	 kSYcADiEeUb5zj63vbUUDalD14ho9fAhlbosrHwupwbUpO2vKa3CaYIMMqc1U01c/w
	 JlTJmPjpnv1A+3wnaPQOTkamRqYSGugVQdefP9cLT2agfDO9muwSSijPvtraGHkFzM
	 y7NIiygrxbo+qDFx7lAQznvMcJ+I8MHeehiYedF/ypZCVTRRbH2zs7PSmsSSz+2SMN
	 ripQxgYQ1KvCRA1EWd4Hyp1vu4ZuhNjrAHhEHH637IpaG0SpKH044fJj+bXVTdqlBh
	 M0aj0Z1ecsJiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBE383BF56;
	Sat,  2 Aug 2025 00:14:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v16 00/10] unwind_user: Deferred unwinding infrastructure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409364350.4093813.8276409208818762249.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:14:03 +0000
References: <20250729182304.965835871@kernel.org>
In-Reply-To: <20250729182304.965835871@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 jpoimboe@kernel.org, peterz@infradead.org, mingo@kernel.org,
 jolsa@kernel.org, acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 andrii@kernel.org, indu.bhagat@oracle.com, jemarch@gnu.org,
 beaub@linux.microsoft.com, jremus@linux.ibm.com,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, axboe@kernel.dk,
 fweimer@redhat.com, sam@gentoo.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Steven Rostedt (Google) <rostedt@goodmis.org>:

On Tue, 29 Jul 2025 14:23:04 -0400 you wrote:
> Jen Remus suggested some updates from v15:
> 
>   https://lore.kernel.org/linux-trace-kernel/20250725185512.673587297@kernel.org/
> 
> Those were:
> 
> - Make fp_frame into a constant
> 
> [...]

Here is the summary with links:
  - [v16,01/10] unwind_user: Add user space unwinding API with frame pointer support
    https://git.kernel.org/bpf/bpf-next/c/71753c6ed2bf
  - [v16,02/10] unwind_user/deferred: Add unwind_user_faultable()
    https://git.kernel.org/bpf/bpf-next/c/5e32d0f15cc5
  - [v16,03/10] unwind_user/deferred: Add unwind cache
    https://git.kernel.org/bpf/bpf-next/c/b9c73524106e
  - [v16,04/10] unwind_user/deferred: Add deferred unwinding interface
    https://git.kernel.org/bpf/bpf-next/c/2dffa355f6c2
  - [v16,05/10] unwind_user/deferred: Make unwind deferral requests NMI-safe
    https://git.kernel.org/bpf/bpf-next/c/055c7060e7ca
  - [v16,06/10] unwind deferred: Use bitmask to determine which callbacks to call
    https://git.kernel.org/bpf/bpf-next/c/be3d526a5b34
  - [v16,07/10] unwind deferred: Add unwind_completed mask to stop spurious callbacks
    https://git.kernel.org/bpf/bpf-next/c/4c75133e745a
  - [v16,08/10] unwind: Add USED bit to only have one conditional on way back to user space
    https://git.kernel.org/bpf/bpf-next/c/858fa8a3b083
  - [v16,09/10] unwind deferred: Use SRCU unwind_deferred_task_work()
    https://git.kernel.org/bpf/bpf-next/c/357eda2d7450
  - [v16,10/10] unwind: Finish up unwind when a task exits
    https://git.kernel.org/bpf/bpf-next/c/b3b9cb11aa03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



