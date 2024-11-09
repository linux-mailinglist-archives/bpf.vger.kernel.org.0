Return-Path: <bpf+bounces-44436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8A9C2F79
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 21:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EF01C2148A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BA1A08B5;
	Sat,  9 Nov 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+nhI7rz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720319F47A
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731183618; cv=none; b=G8nJ1U4GlkSvEVo0OUcI8WITszfxlH5rDsw6nnc/W/vVlvOpAuCKsl10q+SMUw2nP+cSYzb+cKK9EzYG80AyRqm4ib73jGiX4degbFtkeLPXwQ7euVwqhxsDnsvNLT03nGollJjWELONXq9+nl873E6lmrK+64g7MV2GU8LTdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731183618; c=relaxed/simple;
	bh=Xyv4vNxVl+6rLeZcF/zH7YMmEFAciCePeX8VJNAXNfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AAp173Cs/tY5sL3wWlGQmkX2DbckXLGkFuICkDVb8+S5LOruWHSPiCn1mmf9eqD+DkHUWVq41XeZ8gzkli64GMVU9oJ8Ufh9r+wTmyshm7wCb0GNL/9Wypl6Qwyti4aCR5yuxh0hWMB919M1dSQAfJXbxWHN74nJqkHnp3m54us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+nhI7rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD62C4CECE;
	Sat,  9 Nov 2024 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731183617;
	bh=Xyv4vNxVl+6rLeZcF/zH7YMmEFAciCePeX8VJNAXNfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d+nhI7rzh1c5QP27IMwc3FEAgB72kbx4XjTfp6cvpdEtsXhnjnJhBnfoRibuV7XO7
	 hsVGg6GSPZIytYpS1epsOo+W37QHZQEQH7G5QsR7oBnFkXI8QAU6b8Q3cK2fLKMCWo
	 oMMk8cvEvJxj0ul+cCKr7Y40dma/mHmE+/uOO33AwcEm+NFY7nwx6pOI7WwJXNZunQ
	 hi5zWBEJm4zFjgZyTvQMaSpm6l83QE9RbJdzkN2v+g8Aa13eieI3ENQOMglyxYx5Vf
	 ZgQ1MLyzq1jAk87dlFteNb8bSbz3GVz/u7be68Q4sVVA9bTfLSYdbBSmACsalWd1DL
	 JThqJm0GXRZNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3523809A80;
	Sat,  9 Nov 2024 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: skip the timer_lockup test for
 single-CPU nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173118362751.3006527.5328856383741198318.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 20:20:27 +0000
References: <20241107115231.75200-1-vmalik@redhat.com>
In-Reply-To: <20241107115231.75200-1-vmalik@redhat.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Nov 2024 12:52:31 +0100 you wrote:
> The timer_lockup test needs 2 CPUs to work, on single-CPU nodes it fails
> to set thread affinity to CPU 1 since it doesn't exist:
> 
>     # ./test_progs -t test_lockup
>     test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
>     test_timer_lockup:PASS:pthread_create thread1 0 nsec
>     test_timer_lockup:PASS:pthread_create thread2 0 nsec
>     timer_lockup_thread:PASS:cpu affinity 0 nsec
>     timer_lockup_thread:FAIL:cpu affinity unexpected error: 22 (errno 0)
>     test_timer_lockup:PASS: 0 nsec
>     #406     timer_lockup:FAIL
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: skip the timer_lockup test for single-CPU nodes
    https://git.kernel.org/bpf/bpf-next/c/5bfc4f22e0d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



