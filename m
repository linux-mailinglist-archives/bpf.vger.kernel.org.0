Return-Path: <bpf+bounces-59019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870D6AC5C03
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D6E1686BF
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83720FAA4;
	Tue, 27 May 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1bjrEL4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECE29A1
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380196; cv=none; b=IQMZE7i6f7WT7TEAx2sidpl8EBsoxE8WZOfCOLIlaszngIKIU2K2MQamRtA8LxL3YVBY81GEaQytoQSstk5Lf2TRUfoFO6ALUrl17dQ0zILzQvRhJeMf3+/Kah19BVkPBtYjVR4DmHQCoscLIXc9X0cgW+QbodTp5BmW324QZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380196; c=relaxed/simple;
	bh=bbP2fVwT6V2Psf7S593yUue4O+OYlGwROEBmWknT7Cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U9ToR4kuCB0RFXKVH5osHiTxpHKyk3GaKlKmDRQRhWPgcaJd7MHPRUD0vA8bfwbcnsLluHmgMW4oMS5DarcctNS55202v2yOW06RyNQlGNRDhmwwyUUdO9hikKTU49ITLEAqD55W/Kc/4LpkQ9cHLr7Yz11Affj+Mtjnmn+tLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1bjrEL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E83AC4CEE9;
	Tue, 27 May 2025 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748380196;
	bh=bbP2fVwT6V2Psf7S593yUue4O+OYlGwROEBmWknT7Cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J1bjrEL4+wqvCOFqoKkTrwdgu5HTakz9BzLldWYNUfpxb8hzBkMdSAlPH0DN8lC3E
	 tNUZ1T5cJ4WQ2QHQI2lfrtRApIE8bJKOMXoOEFpzr+bTZDzbzM6RXCZG3mqtabCa0z
	 NWxYcF+TXX6zUeafnTYIKd6StKXaCTXiotoGPklAyGv5dYBxLaodxjeG5Lqm5jkirA
	 b7rPAHxqjwH5OGDWydZSHbyDQAZp4emnSY0wHQaH5VQcdnb0du2MNLiQJcoWUBRlUQ
	 5J9UlW147NSPTpzAJgdQLuleGLKa6f9t2HBNg9q7EN/A992ql0bvNLnpjA0kx8k8IC
	 VIU60iNo3l0Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF0380AAE2;
	Tue, 27 May 2025 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174838023012.1779376.16342797141324451087.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 21:10:30 +0000
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
In-Reply-To: <20250524041335.4046126-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 23 May 2025 21:13:35 -0700 you wrote:
> Yi Lai reported an issue ([1]) where the following warning appears
> in kernel dmesg:
>   [   60.643604] verifier backtracking bug
>   [   60.643635] WARNING: CPU: 10 PID: 2315 at kernel/bpf/verifier.c:4302 __mark_chain_precision+0x3a6c/0x3e10
>   [   60.648428] Modules linked in: bpf_testmod(OE)
>   [   60.650471] CPU: 10 UID: 0 PID: 2315 Comm: test_progs Tainted: G           OE       6.15.0-rc4-gef11287f8289-dirty #327 PREEMPT(full)
>   [   60.654385] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>   [   60.656682] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [   60.660475] RIP: 0010:__mark_chain_precision+0x3a6c/0x3e10
>   [   60.662814] Code: 5a 30 84 89 ea e8 c4 d9 01 00 80 3d 3e 7d d8 04 00 0f 85 60 fa ff ff c6 05 31 7d d8 04
>                        01 48 c7 c7 00 58 30 84 e8 c4 06 a5 ff <0f> 0b e9 46 fa ff ff 48 ...
>   [   60.668720] RSP: 0018:ffff888116cc7298 EFLAGS: 00010246
>   [   60.671075] RAX: 54d70e82dfd31900 RBX: ffff888115b65e20 RCX: 0000000000000000
>   [   60.673659] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
>   [   60.676241] RBP: 0000000000000400 R08: ffff8881f6f23bd3 R09: 1ffff1103ede477a
>   [   60.678787] R10: dffffc0000000000 R11: ffffed103ede477b R12: ffff888115b60ae8
>   [   60.681420] R13: 1ffff11022b6cbc4 R14: 00000000fffffff2 R15: 0000000000000001
>   [   60.684030] FS:  00007fc2aedd80c0(0000) GS:ffff88826fa8a000(0000) knlGS:0000000000000000
>   [   60.686837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   60.689027] CR2: 000056325369e000 CR3: 000000011088b002 CR4: 0000000000370ef0
>   [   60.691623] Call Trace:
>   [   60.692821]  <TASK>
>   [   60.693960]  ? __pfx_verbose+0x10/0x10
>   [   60.695656]  ? __pfx_disasm_kfunc_name+0x10/0x10
>   [   60.697495]  check_cond_jmp_op+0x16f7/0x39b0
>   [   60.699237]  do_check+0x58fa/0xab10
>   ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: Do not include stack ptr register in precision backtracking bookkeeping
    https://git.kernel.org/bpf/bpf-next/c/e2d2115e56c4
  - [bpf-next,v5,2/2] selftests/bpf: Add tests with stack ptr register in conditional jmp
    https://git.kernel.org/bpf/bpf-next/c/5ffb537e416e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



