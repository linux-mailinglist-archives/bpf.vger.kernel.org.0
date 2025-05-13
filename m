Return-Path: <bpf+bounces-58136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FFAAB5A61
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717724C11AD
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379A2BFC8B;
	Tue, 13 May 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh5y1hra"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C32BEC5B;
	Tue, 13 May 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154394; cv=none; b=cH948CP+btDtkCXEdmkIyt/Xd+427aWWh/Hthg90L0KQnq0ewMfn9SIh9qkqgMbrPPNvPzkzQ0Hush1vteDtAGhddXzlaYgSorz1W904fN4gxFhmJsUYcB+/mOwgrvKAZdPd1NaNEDZmoNipT3U4AG8EHU5nhVBd7ZUGR6nch2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154394; c=relaxed/simple;
	bh=AjkYXTBFr9l5F1Xafn2ef91f99gfytyrNwf96vVqTQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UIxnJRRzPLfsdqhJSZYuQimbmpI16JWHzKEE+rkZNp55sRMDI/scXEJmITnAKw4gs8RflsJy8I+wvksnPqaG7Pctw1LBmA0HrsycJPOUQAwqeyCp0tvwzFV3ulBbR3WP01d3WsrrrVbH5kRSp21Gsmlmx4lP8RdIMbYBctHeiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh5y1hra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B2C4CEE4;
	Tue, 13 May 2025 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747154394;
	bh=AjkYXTBFr9l5F1Xafn2ef91f99gfytyrNwf96vVqTQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oh5y1hraJdvH7VfQ2mkFRg1zcYXXFAmPppkhrTTMWCHtVUhY/+ZuxhpyFoZS1DtOa
	 3hfUGlywaZsTOur9mcy4sgttTytV2JjW/+zV1A4AdyHuWp+L3R4c+s16+iTyZBk55I
	 kZ8KaViMQOOX/B9k933Fkrd+s7MTaBLIS6YWzkezptPAVXfoyfW2wapKgoNcFlXrou
	 OU6xmwhC6aZsFm38BUss1sxBoNs59PlbsAMG/yfwlZXSPcMP4rj//d58iZgiUrtjAq
	 aECWWfmThxcSxPg+VXb/+UMhZ8/g3xWcL9M08C5x2eshwuMpW6hTVqj0NKKz+1Xtua
	 Hg5KQKlZ8t9zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0D39D61FF;
	Tue, 13 May 2025 16:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix WARN() in get_bpf_raw_tp_regs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174715443176.1726492.3970535040989082587.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 16:40:31 +0000
References: <20250513042747.757042-1-chen.dylane@linux.dev>
In-Reply-To: <20250513042747.757042-1-chen.dylane@linux.dev>
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mmullins@fb.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 13 May 2025 12:27:47 +0800 you wrote:
> syzkaller reported an issue:
> 
> WARNING: CPU: 3 PID: 5971 at kernel/trace/bpf_trace.c:1861 get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
> Modules linked in:
> CPU: 3 UID: 0 PID: 5971 Comm: syz-executor205 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
> RSP: 0018:ffffc90003636fa8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81c6bc4c
> RDX: ffff888032efc880 RSI: ffffffff81c6bc83 RDI: 0000000000000005
> RBP: ffff88806a730860 R08: 0000000000000005 R09: 0000000000000003
> R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
> R13: 0000000000000001 R14: ffffc90003637008 R15: 0000000000000900
> FS:  0000000000000000(0000) GS:ffff8880d6cdf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7baee09130 CR3: 0000000029f5a000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1934 [inline]
>  bpf_get_stack_raw_tp+0x24/0x160 kernel/trace/bpf_trace.c:1931
>  bpf_prog_ec3b2eefa702d8d3+0x43/0x47
>  bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>  __bpf_prog_run include/linux/filter.h:718 [inline]
>  bpf_prog_run include/linux/filter.h:725 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
>  bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
>  __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
>  __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
>  __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>  trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
>  __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
>  __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
>  mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
>  stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
>  __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
>  ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
>  bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
>  ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
>  bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
>  bpf_prog_ec3b2eefa702d8d3+0x43/0x47
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix WARN() in get_bpf_raw_tp_regs
    https://git.kernel.org/bpf/bpf-next/c/3880cdbed1c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



