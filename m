Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E075407298
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 22:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhIJUbS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 16:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhIJUbR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 16:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3EF5C611F2;
        Fri, 10 Sep 2021 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631305806;
        bh=tapB9s8e4K/3GuaUZj6jVBHMrHfo4h0lDXNeP9TURv4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RYQW6Y2ypOH69IrsB0Hcw+Formxb+z2XnMHeYjcAbzPnrr4aaWjtAdTFiRSLoQGS8
         3sjWfLuHdnd/0R3yD2Zie+voex+3iDmOD/6rBe/oPM/tzn9EPAkH73x24jzWO+GsnP
         PLoY3WJMtN7Npb0bMRWSDZl8MWu1wXp/cFMIXWHUbznW/OnH5d+/gJxQ8FRoSDwQZn
         jZ3QRQqAn8DjqwCvk4P2Qck+XwG6wz7AVgqc95NxRJfwzYlx+uDmE4jN9QOMvDR0X2
         SCZh3yJhSdSJA3AfCE5Qi11wHu3P/rtqbH3N/ABR6yt1NCAHvqmslZD0UrtmRBbVx2
         pD0ILzcY1G7KA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 301BC609F8;
        Fri, 10 Sep 2021 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next/mm v5] bpf/mm: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163130580619.22274.4091084461293655623.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Sep 2021 20:30:06 +0000
References: <20210909155000.1610299-1-yhs@fb.com>
In-Reply-To: <20210909155000.1610299-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        lrizzo@google.com, jgg@ziepe.ca
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 9 Sep 2021 08:49:59 -0700 you wrote:
> Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:
> 
>   [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:164 find_vma+0x47/0xa0
>   [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_testmod]
>   [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        W  O      5.14.0+ #53
>   [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
>   [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 d4 <0f> 0b 48 89 de 48 8
>   [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
>   [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000000000000
>   [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>   [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 00000000fffffffe
>   [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf5c39ae0e0
>   [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf5c39ae0e0
>   [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) knlGS:0000000000000000
>   [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000000370ee0
>   [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 1411.304512] Call Trace:
>   [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
>   [ 1411.304528]  __bpf_get_stack+0x18f/0x230
>   [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
>   [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000000000000
>   [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: ffffffff977e1b0e
>   [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd43ee02c04
>   [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
>   [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf5c2ef60e0
>   [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf5c2ef6108
>   [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
>   [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) knlGS:0000000000000000
>   [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
>   [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000000370ef0
>   [ 1411.312291]  do_syscall_64+0x15/0x80
>   [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
>   [ 1411.315626] Call Trace:
>   [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260
> 
> [...]

Here is the summary with links:
  - [bpf-next/mm,v5] bpf/mm: fix lockdep warning triggered by stack_map_get_build_id_offset()
    https://git.kernel.org/bpf/bpf/c/2f1aaf3ea666

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


