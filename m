Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6B941CD37
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbhI2UND (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbhI2UND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 16:13:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B9C06161C
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 13:11:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so15756161lfu.5
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rqnSG7v+IJdX0mhLBUQ0FklBOa0HgkbZHBEW5Ms8rEY=;
        b=OOLuTGeKleRI5YYFO0je8UQUAQJDmUky/Dbu94taljq2IGZIrQbW2/9O+EaVaFN0Kn
         s7ByCumRbVzrVxZiaZHqsvlkcmmcDbHAj+rN49Yy1tRzIhLIqySW5B7vXb/8W7UN7FZv
         cPaD+GLOMu71InG1Z2QlfMHiiJNjoxw2xLYwmq2lwQszMs331yfu8xhK9HOX58ptX+KD
         tHs5MiZr1OJt5jYbFhstuffeF89rWeC39x3epgIoduBGdsjuXWG6eYe5FTH7JRNYI6ql
         5qcqBJTLLJEjM6bKr81nLk9CXSbfmv+nyPLfXE/sTJ9TJMtfTdcHbGBD/9nnurMqMH6A
         1gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rqnSG7v+IJdX0mhLBUQ0FklBOa0HgkbZHBEW5Ms8rEY=;
        b=pgetUZB43IMajNI2KO2vGVsd+d9mXWvuAOzDmFZX+0fdsaQgRu+SUiwmPJF6F35VnI
         afdM4blaUPLTdBRD2MgY9i2n7yiL9pGbePET/7yKaVOquaiDBG+eyMB8f2JlYqTHYjom
         VSV/srZ8O3azceR59djYCsSm3qJo21MaAGo3P38J2gXM/75+40khq6obEiNqhu2CjcSB
         xY6YP6YHw/sbmFKIMAOg9CDoEnhxS1jwFw/k3j7seMNyi/+fAd8j6Max+bwvwymY53dG
         4lTxvwKvBYDyRc4loaVeF46kl+VUcWTq0iqfA+W0k3QUvAjUD5+Ql5prWmPpo1xZOFyN
         Ue2g==
X-Gm-Message-State: AOAM530JurCzVF8zL/4hPqaOyIPqQMcv9B4nCDFL7JCeYfto0hCGJ1OI
        X+w9eWb7oG5aeVBRD6ik8yvlGtvkpnMC/0kJjg+KGkcmhl4=
X-Google-Smtp-Source: ABdhPJx+d95k08OyZy2qm5y3TBjJku4lMsI1F051ghSVrZHTDPkzlRpaLbunmOUoM9xSZodBj357MeRKe0Dnvx9XHjk=
X-Received: by 2002:ac2:508b:: with SMTP id f11mr1612649lfm.239.1632946279066;
 Wed, 29 Sep 2021 13:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJygYd1z-WCMYta2DCRJkqEi=DxNpVdKSBpTiUgYH5n3H4wmzg@mail.gmail.com>
In-Reply-To: <CAJygYd1z-WCMYta2DCRJkqEi=DxNpVdKSBpTiUgYH5n3H4wmzg@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Wed, 29 Sep 2021 13:10:52 -0700
Message-ID: <CAJygYd21wgH0FMV4SfhjXXLc3B-g4DYg9OdGSA3EWBiawuP9xA@mail.gmail.com>
Subject: Re: kernel panic while running bpf selftests
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My observation is that this could be triggered by running
stacktrace_build_id_nmi together with other tests, that suggests some
bpf/skb code is not handling NMI correctly.

On Wed, Sep 29, 2021 at 12:23 PM sunyucong@gmail.com
<sunyucong@gmail.com> wrote:
>
> Hi, this has come up a few times while running selftests and seems
> real enough to warrant investigation.
>
> Thanks!
>
> [    3.680829] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [    3.681300] CPU: 2 PID: 189 Comm: test_progs Tainted: G           O
>      5.15.0-rc1-00386-g92da3969a45c-dirty #17
> [    3.682213] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [    3.683005] RIP: 0010:bpf_prog_a554d890de36669a_trace_kfree_skb+0xa4/0x9c4
> [    3.683610] Code: f6 75 04 31 f6 eb 04 49 8b 76 08 48 89 75 d0 48
> 85 ff 75 05 45 31 ed eb 07 44 8b af d0 00 00 00 44 89 6d f0 48 85 c9
> 75 04 31 <ff> eb 05 48 0f b6 79 08 89 7d e8 40 88 7d f8 48 85 c9 75 04
> 31 ff
> [    3.685251] RSP: 0018:ffffc9000015cca0 EFLAGS: 00010206
> [    3.685714] RAX: 0000000000000133 RBX: ffff888100970600 RCX: ffff888081af4310
> [    3.686328] RDX: ffffffff81183d10 RSI: 0000000000000000 RDI: 0101000180000300
> [    3.686971] RBP: ffff888100970600 R08: 0000000000000050 R09: 2914518100000000
> [    3.687588] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888108668d00
> [    3.688217] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810634002c
> [    3.688836] FS:  00007f7f204c1740(0000) GS:ffff88813ba80000(0000)
> knlGS:0000000000000000
> [    3.689552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.690057] CR2: 00007f7f204bfef8 CR3: 0000000103bd0001 CR4: 0000000000370ee0
> [    3.690663] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    3.691243] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    3.691783] Call Trace:
> [    3.691982]  <IRQ>
> [    3.692143]  ? bpf_trace_run2+0x75/0x150
> [    3.692450]  ? udp_read_sock+0x41/0xb0
> [    3.692744]  ? kfree_skb+0x7e/0x120
> [    3.693029]  ? udp_read_sock+0x41/0xb0
> [    3.693333]  ? sk_psock_verdict_data_ready+0x4c/0x60
> [    3.693754]  ? __udp_enqueue_schedule_skb+0x161/0x260
> [    3.694191]  ? udp_queue_rcv_one_skb+0x330/0x590
> [    3.694593]  ? udp_unicast_rcv_skb.isra.0+0x6b/0x80
> [    3.695017]  ? ip_protocol_deliver_rcu+0x2a/0x290
> [    3.695416]  ? ip_local_deliver_finish+0x83/0x120
> [    3.695797]  ? ip_local_deliver+0x5e/0x200
> [    3.696153]  ? ip_rcv+0x44/0x1e0
> [    3.696436]  ? lock_acquire+0xc6/0x2c0
> [    3.696767]  ? __netif_receive_skb_one_core+0x45/0x50
> [    3.697207]  ? process_backlog+0xcc/0x220
> [    3.697562]  ? __napi_poll+0x26/0x1d0
> [    3.697883]  ? net_rx_action+0xdd/0x200
> [    3.698223]  ? __do_softirq+0xd9/0x488
> [    3.698545]  ? ip_finish_output2+0x236/0x960
> [    3.698913]  ? do_softirq+0xa2/0xd0
> [    3.699225]  </IRQ>
> [    3.699414]  ? __local_bh_enable_ip+0xc4/0xe0
> [    3.699782]  ? ip_finish_output2+0x25a/0x960
> [    3.700152]  ? ip_output+0x6f/0x230
> [    3.700460]  ? ip_output+0x6f/0x230
> [    3.700760]  ? __ip_finish_output+0x450/0x450
> [    3.701142]  ? ip_send_skb+0x15/0x40
> [    3.701460]  ? udp_send_skb.isra.0+0x156/0x390
> [    3.701840]  ? udp_sendmsg+0xa2c/0xd30
> [    3.702173]  ? ip_reply_glue_bits+0x40/0x40
> [    3.702526]  ? __lock_acquire+0x378/0x2730
> [    3.702876]  ? lock_is_held_type+0xd5/0x130
> [    3.703250]  ? sock_sendmsg+0x33/0x40
> [    3.703570]  ? sock_sendmsg+0x33/0x40
> [    3.703888]  ? sock_write_iter+0x95/0xf0
> [    3.704239]  ? new_sync_write+0x172/0x180
> [    3.704589]  ? vfs_write+0x25e/0x3d0
> [    3.704902]  ? ksys_write+0x93/0xd0
> [    3.705212]  ? do_syscall_64+0x35/0x80
> [    3.705534]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    3.705989] Modules linked in: bpf_testmod(O)
> [    3.706368] ---[ end trace 8c7957c205f7cff3 ]---
> [    3.706753] RIP: 0010:bpf_prog_a554d890de36669a_trace_kfree_skb+0xa4/0x9c4
> [    3.707328] Code: f6 75 04 31 f6 eb 04 49 8b 76 08 48 89 75 d0 48
> 85 ff 75 05 45 31 ed eb 07 44 8b af d0 00 00 00 44 89 6d f0 48 85 c9
> 75 04 31 <ff> eb 05 48 0f b6 79 08 89 7d e8 40 88 7d f8 48 85 c9 75 04
> 31 ff
> [    3.708914] RSP: 0018:ffffc9000015cca0 EFLAGS: 00010206
> [    3.709374] RAX: 0000000000000133 RBX: ffff888100970600 RCX: ffff888081af4310
> [    3.710005] RDX: ffffffff81183d10 RSI: 0000000000000000 RDI: 0101000180000300
> [    3.710603] RBP: ffff888100970600 R08: 0000000000000050 R09: 2914518100000000
> [    3.711205] R10: 0000000000000001 R11: 0000000000000000 R12: ffff888108668d00
> [    3.711807] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810634002c
> [    3.712420] FS:  00007f7f204c1740(0000) GS:ffff88813ba80000(0000)
> knlGS:0000000000000000
> [    3.713121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.713614] CR2: 00007f7f204bfef8 CR3: 0000000103bd0001 CR4: 0000000000370ee0
> [    3.714224] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    3.714825] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    3.715444] Kernel panic - not syncing: Fatal exception in interrupt
> [    3.716269] Kernel Offset: disabled
> [    3.716582] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
