Return-Path: <bpf+bounces-13522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32ED7DA3E9
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 01:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38001B216BA
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DFD405E3;
	Fri, 27 Oct 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmObXsUl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAF38BAC;
	Fri, 27 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDF53C433C8;
	Fri, 27 Oct 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447624;
	bh=1vCryom6GZioUXQgQpwS8N09MO5fhO+1s6azUOtxNqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AmObXsUld4MOhFMqlht+eBpULM/jbvfgVbMuTzV1hO6NNMj/5ALp0fcjBwTMvqzrO
	 72SCIBJU5OW/o+XcOxvPXpJv0MIoyUIuhQu5UmHbG2n7QB/MnGKBqMsp1G5gsrNYDF
	 hbSWlQex5UPnrDJxZAoCnJfEbQ0xgtdl8BUKqYtQ22nfoI/ZzwDMt66Y8LgbxavaZ3
	 QVxxLBz5sM3v6uO5wLlaDUPgx93oGkyQnuR1pPvh2UUeiOZjmcKdizVC+fvmYJMjJG
	 Pw6RhsTwbiVDwR+gE+DwK6l9yqIfY6sxBJ2zGbGS7IHAs2lofI5ZaE1pSfPhptoRBP
	 y1IUxYVnlsqdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF617C04E32;
	Fri, 27 Oct 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bpf: Use sockopt_lock_sock() in
 ip_sock_set_tos()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169844762477.22694.16622849880566679221.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 23:00:24 +0000
References: <20231027182424.1444845-1-yonghong.song@linux.dev>
In-Reply-To: <20231027182424.1444845-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
 edumazet@google.com, martin.lau@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 11:24:24 -0700 you wrote:
> With latest sync from net-next tree, bpf-next has a bpf selftest failure:
>   [root@arch-fb-vm1 bpf]# ./test_progs -t setget_sockopt
>   ...
>   [   76.194349] ============================================
>   [   76.194682] WARNING: possible recursive locking detected
>   [   76.195039] 6.6.0-rc7-g37884503df08-dirty #67 Tainted: G        W  OE
>   [   76.195518] --------------------------------------------
>   [   76.195852] new_name/154 is trying to acquire lock:
>   [   76.196159] ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: ip_sock_set_tos+0x19/0x30
>   [   76.196669]
>   [   76.196669] but task is already holding lock:
>   [   76.197028] ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_listen+0x21/0x70
>   [   76.197517]
>   [   76.197517] other info that might help us debug this:
>   [   76.197919]  Possible unsafe locking scenario:
>   [   76.197919]
>   [   76.198287]        CPU0
>   [   76.198444]        ----
>   [   76.198600]   lock(sk_lock-AF_INET);
>   [   76.198831]   lock(sk_lock-AF_INET);
>   [   76.199062]
>   [   76.199062]  *** DEADLOCK ***
>   [   76.199062]
>   [   76.199420]  May be due to missing lock nesting notation
>   [   76.199420]
>   [   76.199879] 2 locks held by new_name/154:
>   [   76.200131]  #0: ffff8c3e06ad8d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_listen+0x21/0x70
>   [   76.200644]  #1: ffffffff90f96a40 (rcu_read_lock){....}-{1:2}, at: __cgroup_bpf_run_filter_sock_ops+0x55/0x290
>   [   76.201268]
>   [   76.201268] stack backtrace:
>   [   76.201538] CPU: 4 PID: 154 Comm: new_name Tainted: G        W  OE      6.6.0-rc7-g37884503df08-dirty #67
>   [   76.202134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   [   76.202699] Call Trace:
>   [   76.202858]  <TASK>
>   [   76.203002]  dump_stack_lvl+0x4b/0x80
>   [   76.203239]  __lock_acquire+0x740/0x1ec0
>   [   76.203503]  lock_acquire+0xc1/0x2a0
>   [   76.203766]  ? ip_sock_set_tos+0x19/0x30
>   [   76.204050]  ? sk_stream_write_space+0x12a/0x230
>   [   76.204389]  ? lock_release+0xbe/0x260
>   [   76.204661]  lock_sock_nested+0x32/0x80
>   [   76.204942]  ? ip_sock_set_tos+0x19/0x30
>   [   76.205208]  ip_sock_set_tos+0x19/0x30
>   [   76.205452]  do_ip_setsockopt+0x4b3/0x1580
>   [   76.205719]  __bpf_setsockopt+0x62/0xa0
>   [   76.205963]  bpf_sock_ops_setsockopt+0x11/0x20
>   [   76.206247]  bpf_prog_630217292049c96e_bpf_test_sockopt_int+0xbc/0x123
>   [   76.206660]  bpf_prog_493685a3bae00bbd_bpf_test_ip_sockopt+0x49/0x4b
>   [   76.207055]  bpf_prog_b0bcd27f269aeea0_skops_sockopt+0x44c/0xec7
>   [   76.207437]  __cgroup_bpf_run_filter_sock_ops+0xda/0x290
>   [   76.207829]  __inet_listen_sk+0x108/0x1b0
>   [   76.208122]  inet_listen+0x48/0x70
>   [   76.208373]  __sys_listen+0x74/0xb0
>   [   76.208630]  __x64_sys_listen+0x16/0x20
>   [   76.208911]  do_syscall_64+0x3f/0x90
>   [   76.209174]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>   ...
> 
> [...]

Here is the summary with links:
  - [net-next] net: bpf: Use sockopt_lock_sock() in ip_sock_set_tos()
    https://git.kernel.org/netdev/net-next/c/06497763c8f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



