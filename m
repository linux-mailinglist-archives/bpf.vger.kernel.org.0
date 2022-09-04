Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5255AC69F
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiIDVV0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDVVZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 17:21:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B32A430
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 14:21:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g13-20020a056602072d00b0068825561753so3986735iox.7
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 14:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=bfA9i4x162vS453jHjvp5uGKKIgp/v13WI7O3s/baNg=;
        b=Am7l6EQHlfeIgd3yd6ScPbOjvS7mjp8Npgk8gtmorbH645A7mBO80nJafHDSoRsHPr
         rfUyKlWiThi6CfMLWNXXwnIqDFU+DYxPhjgqrFShItPngHeiCbpjrVwMmuoq/ZwfQtuB
         myhk0GfXpUi1+9Bb2+G9jU86OcU3AbheMYkwMoi11K8V9T6UhfD42NlrjA/hpcLXVto6
         M0dRYqcimNE3wP2LPlxdO+gsC1oWgx5nPdtvb4WaJpvj0Nm2vSvf0oTZDeV3FoKN8TOL
         NztLwg18XnzWwlKaPgIZ9zCjCbwbus6EhKOMSIab65ryfPvaLfkYaoo6u7bHdJD00+YC
         Ca8g==
X-Gm-Message-State: ACgBeo3LXZ7huTaKCVToO/uP3yCjeI63HvPjplrWa9zwFhxKdoobNZcE
        4Kj927w9s+VDE8ayWVIEltmCYBwczQkRSQY++DoAIfuEVPxa
X-Google-Smtp-Source: AA6agR52avkG2jl3nEHbuDgjEbqjbmYLHIP/ZWHB2s8wnxZLrkGpE+fGf0CsyXM+W7BHtdnWH1LGeqDf2R6ddQrSSCfCUGReoJo/
MIME-Version: 1.0
X-Received: by 2002:a02:c6d5:0:b0:34c:bd5:e643 with SMTP id
 r21-20020a02c6d5000000b0034c0bd5e643mr12494759jan.97.1662326483443; Sun, 04
 Sep 2022 14:21:23 -0700 (PDT)
Date:   Sun, 04 Sep 2022 14:21:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008be47905e7e08b85@google.com>
Subject: [syzbot] WARNING in bpf_bprintf_prepare (2)
From:   syzbot <syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fd22855300e Add linux-next specific files for 20220831
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e5668b080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c1a274c93753
dashboard link: https://syzkaller.appspot.com/bug?extid=2251879aa068ad9c960d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dc728b080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164748d7080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3601 at kernel/bpf/helpers.c:769 try_get_fmt_tmp_buf kernel/bpf/helpers.c:769 [inline]
WARNING: CPU: 1 PID: 3601 at kernel/bpf/helpers.c:769 bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:817
Modules linked in:
CPU: 1 PID: 3601 Comm: strace-static-x Not tainted 6.0.0-rc3-next-20220831-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:769 [inline]
RIP: 0010:bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:817
Code: ff e8 93 9f ea ff 48 83 7c 24 08 00 41 bd 04 00 00 00 0f 85 8a fa ff ff e8 7c 9f ea ff 8d 6b 03 e9 f7 f6 ff ff e8 6f 9f ea ff <0f> 0b 65 ff 0d 8e ba 71 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 16
RSP: 0018:ffffc90003cfeb70 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880219b3a80 RSI: ffffffff819186b1 RDI: 0000000000000005
RBP: ffffc90003cfeca0 R08: 0000000000000005 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000003
R13: 0000000000000004 R14: ffffc90003cfed58 R15: 0000000000000003
FS:  0000000001655340(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020003000 CR3: 0000000074d58000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ____bpf_trace_printk kernel/trace/bpf_trace.c:383 [inline]
 bpf_trace_printk+0xab/0x170 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
 __bpf_prog_run include/linux/filter.h:594 [inline]
 bpf_prog_run include/linux/filter.h:601 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
 bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
 __bpf_prog_run include/linux/filter.h:594 [inline]
 bpf_prog_run include/linux/filter.h:601 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
 bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
 __bpf_prog_run include/linux/filter.h:594 [inline]
 bpf_prog_run include/linux/filter.h:601 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
 bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
 __bpf_prog_run include/linux/filter.h:594 [inline]
 bpf_prog_run include/linux/filter.h:601 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin+0xc0/0x150 include/trace/events/lock.h:95
 __mutex_lock_common kernel/locking/mutex.c:605 [inline]
 __mutex_lock+0x13c/0x1350 kernel/locking/mutex.c:747
 __pipe_lock fs/pipe.c:103 [inline]
 pipe_write+0x132/0x1be0 fs/pipe.c:431
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x1e8/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4e5c73
Code: c7 c0 b8 ff ff ff 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffc4f3ec0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00000000004e5c73
RDX: 0000000000000019 RSI: 0000000001658000 RDI: 0000000000000002
RBP: 0000000001658000 R08: 0000000000000000 R09: 0000000000000003
R10: 00007ffc4f3ec087 R11: 0000000000000246 R12: 0000000000000019
R13: 0000000000617480 R14: 0000000000000019 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
