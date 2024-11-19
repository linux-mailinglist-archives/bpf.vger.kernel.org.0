Return-Path: <bpf+bounces-45140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7F9D1F13
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 05:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FF7280E9B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 04:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839419753F;
	Tue, 19 Nov 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNY9vUA0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6E14C59B;
	Tue, 19 Nov 2024 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988836; cv=none; b=B/gv4VNxcmLnp7YGp/3nEayF4Dt9Ou0q0xidy1Z0YRtzfLmHFd8z0XiExyq7uleY3f+rcVBDt5sFvaCgzGlZ+ReV5wzb0gEqrrUNAcKDTYHe8Rvb8GJwGoTSzMR+9ySjfiDUYcH6fSE+t7eVLi+rp5Gw9VQqsN+smMLRO79GTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988836; c=relaxed/simple;
	bh=TijfzOaq6KybxUMjEqRcSvblPfHFDT57qgKacFPxN+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bt+z2MqwzUKphfBkB9dhBsGsrSiuWPM3aee2kijxq3KIcGzGqFL+yt9H0hVVO0tEquOKqNBHbbjNi3otoxfXb/UtXF6tsNmMrYlhMtTuAzVhmMxlRXC3u/7xC3wYojfAe4EtpawFX9zVTD/9TKh5zUUTk2YsnH9CncX4cy5fzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNY9vUA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604DC4DE03;
	Tue, 19 Nov 2024 04:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988835;
	bh=TijfzOaq6KybxUMjEqRcSvblPfHFDT57qgKacFPxN+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hNY9vUA0lzqtGoPVkiLIbjIN7PQgHkJwgBe2gTQY+OvibOj+a6QbwVbVImsSvx0Wh
	 KoDqBwWuYmGJiqAQPpGo68t0wR1vMfZkKN09Ahh8bpwkuNt0BO1j6wqkFcYNIm/J8i
	 b4Gtz/JeLS3O59pEebVb9laDTKzEh1yLdlyd0FRNn63Xxu6wf265moCkMFnrIBp8tT
	 pmhJScsjWV/Ut/2l9GPyI2S4SPdckoDZLHsbQyhRe80o7lpkhB7LDwzelbcmmjVBDF
	 JBgvvX+Mp6ywKDA2tZl1Z7EcSYcrGEfa23DvYAL1Hol4weeRAaA3kMW+C9shuMEI9k
	 w/Ob+XSTV22zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECA3809A80;
	Tue, 19 Nov 2024 04:00:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ip: fix unexpected return in
 fib_validate_source()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884650.97799.16137923776783908412.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:46 +0000
References: <20241118091427.2164345-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241118091427.2164345-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dongml2@chinatelecom.cn,
 syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Nov 2024 17:14:27 +0800 you wrote:
> The errno should be replaced with drop reasons in fib_validate_source(),
> and the "-EINVAL" shouldn't be returned. And this causes a warning, which
> is reported by syzkaller:
> 
> netlink: 'syz-executor371': attribute type 4 has an invalid length.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Modules linked in:
> CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-syzkaller-01362-ga58f00ed24b8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb 5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
> RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
> RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
> RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
> RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
> R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
> R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
> FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
>  ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
>  ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
>  ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
>  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
>  __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
>  __netif_receive_skb_list net/core/dev.c:5814 [inline]
>  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
>  netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
>  xdp_recv_frames net/bpf/test_run.c:280 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>  bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
>  bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
>  bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
>  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f18af25a8e9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> [...]

Here is the summary with links:
  - [net-next] net: ip: fix unexpected return in fib_validate_source()
    https://git.kernel.org/netdev/net-next/c/85c7975acd97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



