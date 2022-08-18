Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAE598FB5
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiHRVkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiHRVkR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 17:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18632BD296;
        Thu, 18 Aug 2022 14:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A97BC61651;
        Thu, 18 Aug 2022 21:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BC8EC433D6;
        Thu, 18 Aug 2022 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660858815;
        bh=o2e7CPTj7J+nXPLNymiXrYmrdkMuZznovk3LLLNOUrU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oO9gi9XlnRUBfIVXqMasLZAGq8RgMfkrP23Xzr6o1PoTgubH64zXB1pI0f60eXvL1
         bl23n0cPXVrT1akUA8DyLiP2gc1fCKTGj3z9iQX/XKBOWPZjU26UfEdI/i6Ga+djTd
         e27u2wlrxWHt3GPVWcPoZanfLg7UN0sbmg9yBnZ+e5dL4uejIGEUL3D8XnKgM57VRD
         ymo3lbkjuUR8t4Qe/Qq6JoHqeADdWCwPnTZyttVl307hhjhgVK8H3u4FQ1zSr8h0D3
         BGQsq2lHLOAvtLCCpqiRLosCQEWVPotq7lPbKyTGEp+OJ2UPgSHYXVHJJGs9VbgI9F
         7YiS9kXE/Fm2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4689E2A051;
        Thu, 18 Aug 2022 21:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix kernel BUG in purge_effective_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166085881493.3032.8925945016556357236.git-patchwork-notify@kernel.org>
Date:   Thu, 18 Aug 2022 21:40:14 +0000
References: <20220813134030.1972696-1-pulehui@huawei.com>
In-Reply-To: <20220813134030.1972696-1-pulehui@huawei.com>
To:     Pu Lehui <pulehui@huawei.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        tadeusz.struk@linaro.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        jean-philippe@linaro.org, haoluo@google.com, jolsa@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 13 Aug 2022 21:40:30 +0800 you wrote:
> Syzkaller reported kernel BUG as follows:
> 
> ------------[ cut here ]------------
> kernel BUG at kernel/bpf/cgroup.c:925!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 194 Comm: detach Not tainted 5.19.0-14184-g69dac8e431af #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__cgroup_bpf_detach+0x1f2/0x2a0
> Code: 00 e8 92 60 30 00 84 c0 75 d8 4c 89 e0 31 f6 85 f6 74 19 42 f6 84
> 28 48 05 00 00 02 75 0e 48 8b 80 c0 00 00 00 48 85 c0 75 e5 <0f> 0b 48
> 8b 0c5
> RSP: 0018:ffffc9000055bdb0 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffff888100ec0800 RCX: ffffc900000f1000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888100ec4578
> RBP: 0000000000000000 R08: ffff888100ec0800 R09: 0000000000000040
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100ec4000
> R13: 000000000000000d R14: ffffc90000199000 R15: ffff888100effb00
> FS:  00007f68213d2b80(0000) GS:ffff88813bc80000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055f74a0e5850 CR3: 0000000102836000 CR4: 00000000000006e0
> Call Trace:
>  <TASK>
>  cgroup_bpf_prog_detach+0xcc/0x100
>  __sys_bpf+0x2273/0x2a00
>  __x64_sys_bpf+0x17/0x20
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f68214dbcb9
> Code: 08 44 89 e0 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff8
> RSP: 002b:00007ffeb487db68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f68214dbcb9
> RDX: 0000000000000090 RSI: 00007ffeb487db70 RDI: 0000000000000009
> RBP: 0000000000000003 R08: 0000000000000012 R09: 0000000b00000003
> R10: 00007ffeb487db70 R11: 0000000000000246 R12: 00007ffeb487dc20
> R13: 0000000000000004 R14: 0000000000000001 R15: 000055f74a1011b0
>  </TASK>
> Modules linked in:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix kernel BUG in purge_effective_progs
    https://git.kernel.org/bpf/bpf/c/7d6620f107ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


