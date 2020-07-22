Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EFA229580
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgGVJxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 05:53:21 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43898 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731575AbgGVJxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 05:53:19 -0400
Received: by mail-il1-f197.google.com with SMTP id y13so684010ila.10
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 02:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xge0LaNlZ4Oxls37Yc88ECtpWAmvdd2FSVpRvVk/alw=;
        b=JOoC0nITT4JaAlQrkUMeIrs7GnMicJMobZ+5hCeEppz+07f1k2lYeJCBGWznP/7orn
         dyImH6mWtZXWHKdbxZxSmCqC07BvrgITQuha9/r96cJ37fsrAgosFzQpwm4i6l4dDz/a
         pwzw6Bd1fB/jLl89hLStzv7kE0qPMCg51jrXBhFlPqYf1uqiRmqeNY/E4OSnaKkyaimR
         W6aD/f5cKvLg+daGeR7Cxkhwpv1qSCbrQr6Tj+cEek5PfKoFRE3v37bIyl7ARqJcNzSo
         ZQTOLqhzTIjV8/2zgdgeRmhOaIrfhOioQanbm89B4ecYUVTOFMnLjmeAa/p46uPrdzbI
         Iogw==
X-Gm-Message-State: AOAM533SI9j1r+dPn9uDNkD3H8m3nffULwPa8RMOdYBEHOcTLL6lRc3B
        uZBIflxAoKlrAcNCt0Ftn1jzxrlbetC+4qV+KA2NNYbli81w
X-Google-Smtp-Source: ABdhPJwmg4qg4gZ/CbZIOIM+FcXY3zGxIe6yJNGsMnC+PbxZ6a2CdOCpdwyqj7NzXeGqlrZ8rA6vY5jLXMUCrzjd+IOg6ckYlq/o
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2113:: with SMTP id n19mr29509321jaj.73.1595411598569;
 Wed, 22 Jul 2020 02:53:18 -0700 (PDT)
Date:   Wed, 22 Jul 2020 02:53:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a764805ab04b5e1@google.com>
Subject: KMSAN: uninit-value in __skb_flow_dissect (3)
From:   syzbot <syzbot+051a531e8f1f59cf6dc9@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, glider@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mcroce@redhat.com,
        netdev@vger.kernel.org, ppenkov@google.com, sdf@google.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14525656 compiler.h: reinstate missing KMSAN_INIT
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=154bb20f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c534a9fad6323722
dashboard link: https://syzkaller.appspot.com/bug?extid=051a531e8f1f59cf6dc9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13946658900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17adcb6f100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+051a531e8f1f59cf6dc9@syzkaller.appspotmail.com

batman_adv: batadv0: Interface activated: batadv_slave_1
=====================================================
BUG: KMSAN: uninit-value in __skb_flow_dissect+0x30f0/0x8440 net/core/flow_dissector.c:1163
CPU: 0 PID: 8524 Comm: syz-executor152 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1df/0x240 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 __skb_flow_dissect+0x30f0/0x8440 net/core/flow_dissector.c:1163
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1310 [inline]
 ___skb_get_hash net/core/flow_dissector.c:1520 [inline]
 __skb_get_hash+0x131/0x480 net/core/flow_dissector.c:1586
 skb_get_hash include/linux/skbuff.h:1348 [inline]
 udp_flow_src_port+0xa5/0x690 include/net/udp.h:220
 geneve_xmit_skb drivers/net/geneve.c:895 [inline]
 geneve_xmit+0xdf1/0x2bf0 drivers/net/geneve.c:1005
 __netdev_start_xmit include/linux/netdevice.h:4611 [inline]
 netdev_start_xmit include/linux/netdevice.h:4625 [inline]
 xmit_one net/core/dev.c:3556 [inline]
 dev_hard_start_xmit+0x50e/0xa70 net/core/dev.c:3572
 __dev_queue_xmit+0x2f8d/0x3b20 net/core/dev.c:4131
 dev_queue_xmit+0x4b/0x60 net/core/dev.c:4164
 pppoe_sendmsg+0xb43/0xb90 drivers/net/ppp/pppoe.c:900
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 kernel_sendmsg+0x433/0x440 net/socket.c:692
 sock_no_sendpage+0x235/0x300 net/core/sock.c:2853
 kernel_sendpage net/socket.c:3644 [inline]
 sock_sendpage+0x25b/0x2c0 net/socket.c:945
 pipe_to_sendpage+0x38c/0x4c0 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x565/0xf00 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0x1d5/0x2d0 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 direct_splice_actor+0x1fd/0x580 fs/splice.c:1016
 splice_direct_to_actor+0x6b2/0xf50 fs/splice.c:971
 do_splice_direct+0x342/0x580 fs/splice.c:1059
 do_sendfile+0x101b/0x1d40 fs/read_write.c:1540
 __do_compat_sys_sendfile fs/read_write.c:1622 [inline]
 __se_compat_sys_sendfile+0x301/0x3c0 fs/read_write.c:1605
 __ia32_compat_sys_sendfile+0x56/0x70 fs/read_write.c:1605
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2aa/0x400 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f13549
Code: Bad RIP value.
RSP: 002b:00000000ffd520cc EFLAGS: 00000217 ORIG_RAX: 00000000000000bb
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000006
RBP: 0000000020000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 pppoe_sendmsg+0xaed/0xb90 drivers/net/ppp/pppoe.c:896
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 kernel_sendmsg+0x433/0x440 net/socket.c:692
 sock_no_sendpage+0x235/0x300 net/core/sock.c:2853
 kernel_sendpage net/socket.c:3644 [inline]
 sock_sendpage+0x25b/0x2c0 net/socket.c:945
 pipe_to_sendpage+0x38c/0x4c0 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x565/0xf00 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0x1d5/0x2d0 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 direct_splice_actor+0x1fd/0x580 fs/splice.c:1016
 splice_direct_to_actor+0x6b2/0xf50 fs/splice.c:971
 do_splice_direct+0x342/0x580 fs/splice.c:1059
 do_sendfile+0x101b/0x1d40 fs/read_write.c:1540
 __do_compat_sys_sendfile fs/read_write.c:1622 [inline]
 __se_compat_sys_sendfile+0x301/0x3c0 fs/read_write.c:1605
 __ia32_compat_sys_sendfile+0x56/0x70 fs/read_write.c:1605
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2aa/0x400 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable ----hdr@pppoe_sendmsg created at:
 pppoe_sendmsg+0xa6/0xb90 drivers/net/ppp/pppoe.c:843
 pppoe_sendmsg+0xa6/0xb90 drivers/net/ppp/pppoe.c:843
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
