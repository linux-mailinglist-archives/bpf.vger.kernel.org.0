Return-Path: <bpf+bounces-77201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB39CD1BA1
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441E9306EF6F
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7D33CE82;
	Fri, 19 Dec 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBB3IN/B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306E3396FD;
	Fri, 19 Dec 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175198; cv=none; b=JWOPPV5dH5zZGOaEuoYrmTsze/JwNCQ7RM5D+Axc2XYr9N9elqZzSE9WEbTZn4YK5QPEoB1Y6FVsLR9ewFZog/LC5dCwjxM3b+YGaLFZlPcpr0mt1XV/e/rAoFNefmHCIQL/aBWyCROCHfVU0VOrSyO1Xh+PGOUQjvqBEuoBuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175198; c=relaxed/simple;
	bh=aRwMUESpiltUQ2s00opo5VRbvw+oBsSsn0KkMj6sCz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PhbFF00qhtsltTAf+oYCvy/fct9nRbCnXtTxvPHQZIU3j5Wc+S8xMf/XcRORXwxJBGhRxa4NObUad2Ty/aUNqlOaX/P9jUbNrlM9OCMOWpH9iH2zVLCH+4u37STFsT9h0oYZVhL1KoRs8K686O9cLab+xE6kLtqEBQ/8m+1ywdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBB3IN/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB65C4CEF1;
	Fri, 19 Dec 2025 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766175198;
	bh=aRwMUESpiltUQ2s00opo5VRbvw+oBsSsn0KkMj6sCz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qBB3IN/BWyjWIhM3of5YvVNu7B/uxLto2mVzhrtEx0zo/jg9M5yuumJ2r7OkZiDfm
	 Nu1TPDoIZVFqICPzqqU3DCvcTEXKxemGWLw+Td5BPjXlA+VFC+kJA4PU0FgYjRokQp
	 0fWf5H8kAnTEP8wM6hQmvB7fK2aoK+dtYILB7pyTi+JW0cOG9COZQzVsp43uLC02vp
	 3HQQM/vWVnyyW/FW/0yEnmpLCxmF4Imf+PA4IGU4t/iqfckoepw6u0rmUYWBHz2JTD
	 kTx0C1ZHsVoTPl43yhWAYRd+jQTXPGHRKl0bjIg+aTPJx0YKx/CR6Tg9EBesyF5Ew5
	 NCumm2TLTi/KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B56DC380AAF2;
	Fri, 19 Dec 2025 20:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] riscv,
 bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176617500654.3992426.2561516989478104083.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 20:10:06 +0000
References: <20251219142948.204312-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251219142948.204312-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, schwab@linux-m68k.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 19 Dec 2025 22:29:48 +0800 you wrote:
> The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() is
> wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
> Andreas reported:
> 
>   Insufficient stack space to handle exception!
>   Task stack:     [0xff20000000010000..0xff20000000014000]
>   Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
>   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
>   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>   epc : copy_from_kernel_nofault+0xa/0x198
>    ra : bpf_probe_read_kernel+0x20/0x60
>   epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
>    gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
>    t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
>    s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
>    a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
>    a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
>    s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
>    s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
>    s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
>    s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
>    t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
>   status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
>   Kernel panic - not syncing: Kernel stack overflow
>   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
>   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>   Call Trace:
>   [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
>   [<ffffffff80002502>] show_stack+0x3a/0x50
>   [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
>   [<ffffffff80012300>] dump_stack+0x18/0x22
>   [<ffffffff80002abe>] vpanic+0xf6/0x328
>   [<ffffffff80002d2e>] panic+0x3e/0x40
>   [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
>   [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60
> 
> [...]

Here is the summary with links:
  - [bpf,v2] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
    https://git.kernel.org/bpf/bpf/c/22cc16c04b78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



