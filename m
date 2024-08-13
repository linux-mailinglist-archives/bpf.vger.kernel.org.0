Return-Path: <bpf+bounces-36980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0E94FB14
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 03:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E4D1C2204A
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33B6FC5;
	Tue, 13 Aug 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO5v2hQC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A37FF
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512637; cv=none; b=or5DEvXrBgZ1UCzLjAVjsuXCmnoBB+2HMqcb9nBwcHaghsBxCZlK43Ygy7LhzjnpP6HXta5kYgwgCZ+6oS3oPBSFVPuk1KVmxM3rzXFtoyOT2ruIftyFa1ZRXJ+8Z5sXia15CRl6nUCcpo70EwPJPOdDAWF7SyB7ohYO6j4QcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512637; c=relaxed/simple;
	bh=JIeJ7XtTFGGLMUGunW+iASWTzQ9GwRoKG1UJ1dN8Vxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JcOIWStkt2wnXg5j8N3E2Dgsi/fIQJe9pfs09i3wBQ5RUyGed4H+wZN3r7cLpNcMC1r78lkPRVjc45VzmeFz6QzD+vrbTYUVb31sKaRKOXjUcZEN+beHGs0wb5dx41K9yiKgLCBQPTiI9AUGu9XUMvQxDjaxtOlkKDnnJgf0vLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO5v2hQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CB7C4AF0D;
	Tue, 13 Aug 2024 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723512636;
	bh=JIeJ7XtTFGGLMUGunW+iASWTzQ9GwRoKG1UJ1dN8Vxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jO5v2hQCp8Ib/ZM2huytJiZMp7zgFypsZ38FwgA1hxrKL3KgNerA+dk2Dpb/5Gg6U
	 GF1y1PWrs5WVPHtEQx0RvHlxfsabjbsbIOf102ZHa6tKLq8kpeedhJBNRJkK4iB7AY
	 esukcWO0dliG0/zb5UMLir4IZZe4LDpIzfssCIcLWxDfTr9bbZXIbKGHgcoFYLr0Np
	 GICaxQ8zodTQNg9yodIR2voREWh+IICexTtvHXv6Mn8ht95hoBUANhHCv25bk0mDaA
	 eEcsHYcNIPzpL4x5jrGEVZuuVkQfkRZofX3uRxVdUQVDG+JIC4yV/+v0uyO2rCd7kv
	 hQ7TrOpLGkZkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01B77382332D;
	Tue, 13 Aug 2024 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172351263572.1185382.612297994358908116.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 01:30:35 +0000
References: <20240812214847.213612-1-yonghong.song@linux.dev>
In-Reply-To: <20240812214847.213612-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, hodgesd@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 12 Aug 2024 14:48:47 -0700 you wrote:
> Daniel Hodges reported a kernel verifier crash when playing with sched-ext.
> The crash dump looks like below:
> 
>   [   65.874474] BUG: kernel NULL pointer dereference, address: 0000000000000088
>   [   65.888406] #PF: supervisor read access in kernel mode
>   [   65.898682] #PF: error_code(0x0000) - not-present page
>   [   65.908957] PGD 0 P4D 0
>   [   65.914020] Oops: 0000 [#1] SMP
>   [   65.920300] CPU: 19 PID: 9364 Comm: scx_layered Kdump: loaded Tainted: G S          E      6.9.5-g93cea04637ea-dirty #7
>   [   65.941874] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/Delta Lake-Class1, BIOS F0E_3A19 04/27/2023
>   [   65.960664] RIP: 0010:states_equal+0x3ee/0x770
>   [   65.969559] Code: 33 85 ed 89 e8 41 0f 48 c7 83 e0 f8 89 e9 29 c1 48 63 c1 4c 89 e9 48 c1 e1 07 49 8d 14 08 0f
>                  b6 54 10 78 49 03 8a 58 05 00 00 <3a> 54 08 78 0f 85 60 03 00 00 49 c1 e5 07 43 8b 44 28 70 83 e0 03
>   [   66.007120] RSP: 0018:ffffc9000ebeb8b8 EFLAGS: 00010202
>   [   66.017570] RAX: 0000000000000000 RBX: ffff888149719680 RCX: 0000000000000010
>   [   66.031843] RDX: 0000000000000000 RSI: ffff88907f4e0c08 RDI: ffff8881572f0000
>   [   66.046115] RBP: 0000000000000000 R08: ffff8883d5014000 R09: ffffffff83065d50
>   [   66.060386] R10: ffff8881bf9a1800 R11: 0000000000000002 R12: 0000000000000000
>   [   66.074659] R13: 0000000000000000 R14: ffff888149719a40 R15: 0000000000000007
>   [   66.088932] FS:  00007f5d5da96800(0000) GS:ffff88907f4c0000(0000) knlGS:0000000000000000
>   [   66.105114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   66.116606] CR2: 0000000000000088 CR3: 0000000388261001 CR4: 00000000007706f0
>   [   66.130873] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [   66.145145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [   66.159416] PKRU: 55555554
>   [   66.164823] Call Trace:
>   [   66.169709]  <TASK>
>   [   66.173906]  ? __die_body+0x66/0xb0
>   [   66.180890]  ? page_fault_oops+0x370/0x3d0
>   [   66.189082]  ? console_unlock+0xb5/0x140
>   [   66.196926]  ? exc_page_fault+0x4f/0xb0
>   [   66.204597]  ? asm_exc_page_fault+0x22/0x30
>   [   66.212974]  ? states_equal+0x3ee/0x770
>   [   66.220643]  ? states_equal+0x529/0x770
>   [   66.228312]  do_check+0x60f/0x5240
>   [   66.235114]  do_check_common+0x388/0x840
>   [   66.242960]  do_check_subprogs+0x101/0x150
>   [   66.251150]  bpf_check+0x5d5/0x4b60
>   [   66.258134]  ? __mod_memcg_state+0x79/0x110
>   [   66.266506]  ? pcpu_alloc+0x892/0xba0
>   [   66.273829]  bpf_prog_load+0x5bb/0x660
>   [   66.281324]  ? bpf_prog_bind_map+0x1e1/0x290
>   [   66.289862]  __sys_bpf+0x29d/0x3a0
>   [   66.296664]  __x64_sys_bpf+0x18/0x20
>   [   66.303811]  do_syscall_64+0x6a/0x140
>   [   66.311133]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix a kernel verifier crash in stacksafe()
    https://git.kernel.org/bpf/bpf/c/bed2eb964c70
  - [bpf,v2,2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
    https://git.kernel.org/bpf/bpf/c/662c3e2db00f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



