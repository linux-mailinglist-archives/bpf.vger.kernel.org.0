Return-Path: <bpf+bounces-61479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBAAE7416
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFE517FBBC
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759D136672;
	Wed, 25 Jun 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGNrJh1z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245B347B4;
	Wed, 25 Jun 2025 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813779; cv=none; b=j+29xUKZGvQ4Tn7WKLO9Lhw3V5HdG53eQzXzvBpBWuJ2TYpLyVMQS82khaX3whBTQonvDyIOWplSORaZPCTub8P5MpUwiVXESv9otC0Wo6dbjARyd12r703ExFfwnliBFX7ji3Rp5da9q78VQEqCRG1ckANyqjBbG3AXdKS8jD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813779; c=relaxed/simple;
	bh=ZsvfSJ6ncx3+0Tez5j+qCZFZeyhCDFZJrU4gsWWe9U0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RNOQfcFHqc05euXlbW+0aLkucURfgL3kD/kECK3JPnG7eM29IRkrunWxYB/z9uMkBK6m1SIPqQi5UvEVaNwbiJ8rxSeE/1JRyIW4cJErIHqxXkhWDhZQ/Y86TnfuHAbFTpL0N49DrWz40Anai8UzgrVSlwhe9uUfD/VlH/NwDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGNrJh1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66C4C4CEE3;
	Wed, 25 Jun 2025 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750813778;
	bh=ZsvfSJ6ncx3+0Tez5j+qCZFZeyhCDFZJrU4gsWWe9U0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AGNrJh1zVV/tMvhTqI17QotPLLiL+X0AktHnvCfoxCFNRgKQTxORSrZGRCzYmMvNI
	 AeJ2gUL0rb1Iq9f2Gsitdo1yqT7RLmIvPoUuYM9MlHLAqo0OI34G0AoB7D0/5Xp3hi
	 BKuSYox5a/qoVNV9Xjou4uCYJus5eyfu38bFxfySun2Ls1RkzX7ZVs4swkeAPVFEO9
	 eGjms126m7Ga9mVmEnmpSdvf0WDrdwn+9oiAG2bWNbThVpnXNYPESdnh3myIU6hnE+
	 P318oBPPMmU+tAuRGjzEpbOZTrLNlsnPotE6GuCxP9TuiXwoBbfnSJt1v33YZm2iow
	 AbcHTpKYN0sbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2739FEB73;
	Wed, 25 Jun 2025 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt: properly flush XDP redirect lists
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081380550.4090877.5607568768954736372.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 01:10:05 +0000
References: <aFl7jpCNzscumuN2@debian.debian>
In-Reply-To: <aFl7jpCNzscumuN2@debian.debian>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 09:06:38 -0700 you wrote:
> We encountered following crash when testing a XDP_REDIRECT feature
> in production:
> 
> [56251.579676] list_add corruption. next->prev should be prev (ffff93120dd40f30), but was ffffb301ef3a6740. (next=ffff93120dd
> 40f30).
> [56251.601413] ------------[ cut here ]------------
> [56251.611357] kernel BUG at lib/list_debug.c:29!
> [56251.621082] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [56251.632073] CPU: 111 UID: 0 PID: 0 Comm: swapper/111 Kdump: loaded Tainted: P           O       6.12.33-cloudflare-2025.6.
> 3 #1
> [56251.653155] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
> [56251.663877] Hardware name: MiTAC GC68B-B8032-G11P6-GPU/S8032GM-HE-CFR, BIOS V7.020.B10-sig 01/22/2025
> [56251.682626] RIP: 0010:__list_add_valid_or_report+0x4b/0xa0
> [56251.693203] Code: 0e 48 c7 c7 68 e7 d9 97 e8 42 16 fe ff 0f 0b 48 8b 52 08 48 39 c2 74 14 48 89 f1 48 c7 c7 90 e7 d9 97 48
>  89 c6 e8 25 16 fe ff <0f> 0b 4c 8b 02 49 39 f0 74 14 48 89 d1 48 c7 c7 e8 e7 d9 97 4c 89
> [56251.725811] RSP: 0018:ffff93120dd40b80 EFLAGS: 00010246
> [56251.736094] RAX: 0000000000000075 RBX: ffffb301e6bba9d8 RCX: 0000000000000000
> [56251.748260] RDX: 0000000000000000 RSI: ffff9149afda0b80 RDI: ffff9149afda0b80
> [56251.760349] RBP: ffff9131e49c8000 R08: 0000000000000000 R09: ffff93120dd40a18
> [56251.772382] R10: ffff9159cf2ce1a8 R11: 0000000000000003 R12: ffff911a80850000
> [56251.784364] R13: ffff93120fbc7000 R14: 0000000000000010 R15: ffff9139e7510e40
> [56251.796278] FS:  0000000000000000(0000) GS:ffff9149afd80000(0000) knlGS:0000000000000000
> [56251.809133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [56251.819561] CR2: 00007f5e85e6f300 CR3: 00000038b85e2006 CR4: 0000000000770ef0
> [56251.831365] PKRU: 55555554
> [56251.838653] Call Trace:
> [56251.845560]  <IRQ>
> [56251.851943]  cpu_map_enqueue.cold+0x5/0xa
> [56251.860243]  xdp_do_redirect+0x2d9/0x480
> [56251.868388]  bnxt_rx_xdp+0x1d8/0x4c0 [bnxt_en]
> [56251.877028]  bnxt_rx_pkt+0x5f7/0x19b0 [bnxt_en]
> [56251.885665]  ? cpu_max_write+0x1e/0x100
> [56251.893510]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.902276]  __bnxt_poll_work+0x190/0x340 [bnxt_en]
> [56251.911058]  bnxt_poll+0xab/0x1b0 [bnxt_en]
> [56251.919041]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.927568]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.935958]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.944250]  __napi_poll+0x2b/0x160
> [56251.951155]  bpf_trampoline_6442548651+0x79/0x123
> [56251.959262]  __napi_poll+0x5/0x160
> [56251.966037]  net_rx_action+0x3d2/0x880
> [56251.973133]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.981265]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56251.989262]  ? __hrtimer_run_queues+0x162/0x2a0
> [56251.996967]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56252.004875]  ? srso_alias_return_thunk+0x5/0xfbef5
> [56252.012673]  ? bnxt_msix+0x62/0x70 [bnxt_en]
> [56252.019903]  handle_softirqs+0xcf/0x270
> [56252.026650]  irq_exit_rcu+0x67/0x90
> [56252.032933]  common_interrupt+0x85/0xa0
> [56252.039498]  </IRQ>
> [56252.044246]  <TASK>
> [56252.048935]  asm_common_interrupt+0x26/0x40
> [56252.055727] RIP: 0010:cpuidle_enter_state+0xb8/0x420
> [56252.063305] Code: dc 01 00 00 e8 f9 79 3b ff e8 64 f7 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a5 32 3a ff 45 84 ff 0f 85 ae
>  01 00 00 fb 45 85 f6 <0f> 88 88 01 00 00 48 8b 04 24 49 63 ce 4c 89 ea 48 6b f1 68 48 29
> [56252.088911] RSP: 0018:ffff93120c97fe98 EFLAGS: 00000202
> [56252.096912] RAX: ffff9149afd80000 RBX: ffff9141d3a72800 RCX: 0000000000000000
> [56252.106844] RDX: 00003329176c6b98 RSI: ffffffe36db3fdc7 RDI: 0000000000000000
> [56252.116733] RBP: 0000000000000002 R08: 0000000000000002 R09: 000000000000004e
> [56252.126652] R10: ffff9149afdb30c4 R11: 071c71c71c71c71c R12: ffffffff985ff860
> [56252.136637] R13: 00003329176c6b98 R14: 0000000000000002 R15: 0000000000000000
> [56252.146667]  ? cpuidle_enter_state+0xab/0x420
> [56252.153909]  cpuidle_enter+0x2d/0x40
> [56252.160360]  do_idle+0x176/0x1c0
> [56252.166456]  cpu_startup_entry+0x29/0x30
> [56252.173248]  start_secondary+0xf7/0x100
> [56252.179941]  common_startup_64+0x13e/0x141
> [56252.186886]  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] bnxt: properly flush XDP redirect lists
    https://git.kernel.org/netdev/net/c/9caca6ac0e26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



