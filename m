Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353DE41CC8E
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 21:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345486AbhI2TZb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbhI2TZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 15:25:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F19EC06161C
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 12:23:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so14926723lfu.2
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=W9sNmVLlK7TZdcCiAJYuzgd3MftCNkA0LO53HiwrE/M=;
        b=gKAl94tU0yWJHpgy0e+WFn+/hC3ukaYJ+m7j/DNe7d1iGOPkSiAQVnv2UD21wg3/Li
         ffFymmaFTGk0LzFUOL5PwIFSDhK7INLB+pEs7Wa93scydXA4Gex/U9STUy7ls7jr27qF
         FSuLnzwXQ+7Q3qRwSYTJdX6Vqr8xy3yPjxjW2Hxb4TWTewvrKtzhCxiXs21CP2rmklY+
         xBlQryeGOPy0r+xt5t1TviixsucyB+Mx2z7DrS/azrW28Y5gxVMiALaaybrVjf8RSxk5
         vC+Yjn0iO9CpqmXloCmlviOhWZpsExOxuQqbMfug2LP5hg5SVZP5Ri/ufJZv0yV4FGQW
         DFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W9sNmVLlK7TZdcCiAJYuzgd3MftCNkA0LO53HiwrE/M=;
        b=PbQxCwke92fgP/tffbDeHgwxpkQ9pXBq/oYC+2M2LLOar8mYY5HOmKqpxidP52oeIN
         2fKMqxFKJprp2PWhMItJXyVONv6F7BdpDGr8w4vHjCzB0QwEZRfuEHDa3Qmz5G0Dc9yQ
         Tb2Fn2TwOXaI11E6ztICMaELZX0LAuizhXoawe6eKVb7hpKSf5Q8lXZccvKefqV/os8s
         ZyWlY8bFlWB9aB+szzc94N52WOPZN5ZMmh41pqZdpy6IVnFLG57Ef8iio5yjJ4H4Wlaz
         GyxvRiAC2QXy6sRbhyRWUcj821Ns2RXaX3d4/wEVgd+yOgjpuAGFSriviFh/rGLR8brZ
         cVZA==
X-Gm-Message-State: AOAM531aSVwbsyk0YOvHP0XsIb1bxoRTdaDoEn0KFzIp6fXR00yi4QEk
        LjYEd67S9w/3QsDiEjoTsCgdjzA8TPGHJvxTdckPcrqhH38=
X-Google-Smtp-Source: ABdhPJwZYSWYapjJBLRCEYsGhe5V4SdWg57xkIaIjBBqqMnflLD1RgBHUQC6sn02aoZnptu2yYU+AADtn3iKmHCmswQ=
X-Received: by 2002:a05:6512:3e1e:: with SMTP id i30mr1311287lfv.639.1632943426947;
 Wed, 29 Sep 2021 12:23:46 -0700 (PDT)
MIME-Version: 1.0
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 29 Sep 2021 12:23:20 -0700
Message-ID: <CAJygYd1z-WCMYta2DCRJkqEi=DxNpVdKSBpTiUgYH5n3H4wmzg@mail.gmail.com>
Subject: kernel panic while running bpf selftests
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, this has come up a few times while running selftests and seems
real enough to warrant investigation.

Thanks!

[    3.680829] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    3.681300] CPU: 2 PID: 189 Comm: test_progs Tainted: G           O
     5.15.0-rc1-00386-g92da3969a45c-dirty #17
[    3.682213] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    3.683005] RIP: 0010:bpf_prog_a554d890de36669a_trace_kfree_skb+0xa4/0x9c4
[    3.683610] Code: f6 75 04 31 f6 eb 04 49 8b 76 08 48 89 75 d0 48
85 ff 75 05 45 31 ed eb 07 44 8b af d0 00 00 00 44 89 6d f0 48 85 c9
75 04 31 <ff> eb 05 48 0f b6 79 08 89 7d e8 40 88 7d f8 48 85 c9 75 04
31 ff
[    3.685251] RSP: 0018:ffffc9000015cca0 EFLAGS: 00010206
[    3.685714] RAX: 0000000000000133 RBX: ffff888100970600 RCX: ffff888081af4310
[    3.686328] RDX: ffffffff81183d10 RSI: 0000000000000000 RDI: 0101000180000300
[    3.686971] RBP: ffff888100970600 R08: 0000000000000050 R09: 2914518100000000
[    3.687588] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888108668d00
[    3.688217] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810634002c
[    3.688836] FS:  00007f7f204c1740(0000) GS:ffff88813ba80000(0000)
knlGS:0000000000000000
[    3.689552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.690057] CR2: 00007f7f204bfef8 CR3: 0000000103bd0001 CR4: 0000000000370ee0
[    3.690663] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.691243] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.691783] Call Trace:
[    3.691982]  <IRQ>
[    3.692143]  ? bpf_trace_run2+0x75/0x150
[    3.692450]  ? udp_read_sock+0x41/0xb0
[    3.692744]  ? kfree_skb+0x7e/0x120
[    3.693029]  ? udp_read_sock+0x41/0xb0
[    3.693333]  ? sk_psock_verdict_data_ready+0x4c/0x60
[    3.693754]  ? __udp_enqueue_schedule_skb+0x161/0x260
[    3.694191]  ? udp_queue_rcv_one_skb+0x330/0x590
[    3.694593]  ? udp_unicast_rcv_skb.isra.0+0x6b/0x80
[    3.695017]  ? ip_protocol_deliver_rcu+0x2a/0x290
[    3.695416]  ? ip_local_deliver_finish+0x83/0x120
[    3.695797]  ? ip_local_deliver+0x5e/0x200
[    3.696153]  ? ip_rcv+0x44/0x1e0
[    3.696436]  ? lock_acquire+0xc6/0x2c0
[    3.696767]  ? __netif_receive_skb_one_core+0x45/0x50
[    3.697207]  ? process_backlog+0xcc/0x220
[    3.697562]  ? __napi_poll+0x26/0x1d0
[    3.697883]  ? net_rx_action+0xdd/0x200
[    3.698223]  ? __do_softirq+0xd9/0x488
[    3.698545]  ? ip_finish_output2+0x236/0x960
[    3.698913]  ? do_softirq+0xa2/0xd0
[    3.699225]  </IRQ>
[    3.699414]  ? __local_bh_enable_ip+0xc4/0xe0
[    3.699782]  ? ip_finish_output2+0x25a/0x960
[    3.700152]  ? ip_output+0x6f/0x230
[    3.700460]  ? ip_output+0x6f/0x230
[    3.700760]  ? __ip_finish_output+0x450/0x450
[    3.701142]  ? ip_send_skb+0x15/0x40
[    3.701460]  ? udp_send_skb.isra.0+0x156/0x390
[    3.701840]  ? udp_sendmsg+0xa2c/0xd30
[    3.702173]  ? ip_reply_glue_bits+0x40/0x40
[    3.702526]  ? __lock_acquire+0x378/0x2730
[    3.702876]  ? lock_is_held_type+0xd5/0x130
[    3.703250]  ? sock_sendmsg+0x33/0x40
[    3.703570]  ? sock_sendmsg+0x33/0x40
[    3.703888]  ? sock_write_iter+0x95/0xf0
[    3.704239]  ? new_sync_write+0x172/0x180
[    3.704589]  ? vfs_write+0x25e/0x3d0
[    3.704902]  ? ksys_write+0x93/0xd0
[    3.705212]  ? do_syscall_64+0x35/0x80
[    3.705534]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[    3.705989] Modules linked in: bpf_testmod(O)
[    3.706368] ---[ end trace 8c7957c205f7cff3 ]---
[    3.706753] RIP: 0010:bpf_prog_a554d890de36669a_trace_kfree_skb+0xa4/0x9c4
[    3.707328] Code: f6 75 04 31 f6 eb 04 49 8b 76 08 48 89 75 d0 48
85 ff 75 05 45 31 ed eb 07 44 8b af d0 00 00 00 44 89 6d f0 48 85 c9
75 04 31 <ff> eb 05 48 0f b6 79 08 89 7d e8 40 88 7d f8 48 85 c9 75 04
31 ff
[    3.708914] RSP: 0018:ffffc9000015cca0 EFLAGS: 00010206
[    3.709374] RAX: 0000000000000133 RBX: ffff888100970600 RCX: ffff888081af4310
[    3.710005] RDX: ffffffff81183d10 RSI: 0000000000000000 RDI: 0101000180000300
[    3.710603] RBP: ffff888100970600 R08: 0000000000000050 R09: 2914518100000000
[    3.711205] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888108668d00
[    3.711807] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810634002c
[    3.712420] FS:  00007f7f204c1740(0000) GS:ffff88813ba80000(0000)
knlGS:0000000000000000
[    3.713121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.713614] CR2: 00007f7f204bfef8 CR3: 0000000103bd0001 CR4: 0000000000370ee0
[    3.714224] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.714825] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.715444] Kernel panic - not syncing: Fatal exception in interrupt
[    3.716269] Kernel Offset: disabled
[    3.716582] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
