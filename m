Return-Path: <bpf+bounces-11506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E27BAFAA
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 02:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 03808282378
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7315AD;
	Fri,  6 Oct 2023 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm8yzjEV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364110E7;
	Fri,  6 Oct 2023 00:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37F79C433C9;
	Fri,  6 Oct 2023 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696552831;
	bh=oFqZXtcvFppptFRRQK616T2zS75kLFYvPUfsMrV73+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lm8yzjEV5F0dJdu6RDVB6N8buhLc49RHkhFHD/A3zXWZB0QPrbkBoHR15lS8sy7nK
	 glhN6QnURCManbr8qn8SqF9GvpY0F4MuU18W2z+0p8nezDNOTQSVuUmoEnyA1JGPYb
	 RR/J0LXIjCrGIXwaEF4G9RyYfmcWVwpvT0xjCQC3n0N/4ab0iwPTP9y59rYHeLQr99
	 iW7FKADHvG2ORw/sC/i86vhAVD8WkQwTrFCn/H7m7N8HxYe9PA7cxB0S3pbHV3pEHT
	 KrMKrvbJGh/FuXPvpiT7kmXdfvnIzktg6oG2AL3B2orrLPsnY+I2lx7ujkxbu0Glba
	 SCnRXPCfWG6zQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F7EAE11F50;
	Fri,  6 Oct 2023 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169655283112.25319.4323691266083806754.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 00:40:31 +0000
References: <20231005193548.515-1-andrew.kanner@gmail.com>
In-Reply-To: <20231005193548.515-1-andrew.kanner@gmail.com>
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, daniel@iogearbox.net,
 linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
 syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Oct 2023 22:35:49 +0300 you wrote:
> Syzkaller reported the following issue:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>  Modules linked in:
>  CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>  Hardware name: Generic DT based system
>  unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>  show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>  dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>  __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>  warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>  __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>  vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>  xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>  xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>  __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
> 
> [...]

Here is the summary with links:
  - [bpf,v3] net/xdp: fix zero-size allocation warning in xskq_create()
    https://git.kernel.org/bpf/bpf/c/90aeaa99f53e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



