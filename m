Return-Path: <bpf+bounces-10523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A37A95E9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395211C20AE9
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92560BA4B;
	Thu, 21 Sep 2023 16:57:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCB9475
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 16:57:41 +0000 (UTC)
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08018E59
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:56:42 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-57b67c11f48so557057eaf.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 09:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315401; x=1695920201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww3vN035Zcg12MFBbqgS3GHytBFID7A4JA0YJ0J/nwk=;
        b=AM9pgWEuC3cimTSStWT/JqOM2EGt/D0SngF3s64VL/uZ0Y0BEwXqAldMSc4icdufFE
         dnaS9eapeyPIiWxOKNPaKH4lm/CNBp9NPMsBK9VXtzalGbw13vi2Demi3ABYz8g3LRvp
         7UV7+cZ9j3M0NT8UsvoKtiggsQ1aNNQWCkyG/n04Z+lE4fsaZrOtTmc8I03z+JZRjDDu
         KNLKmEoPYkN0urXHKMn7J0DvEzA7nTIQ5ahOQoq2T3b1+6xjIu56neO0JCMBgihvqcTf
         nnjVfH/a4gYZJFFDJDxPwaBiQiAcGdrtoLV2xR3b3xzsH4K62cRgvlpnByCYFA3BvLXg
         1RQQ==
X-Gm-Message-State: AOJu0YzzBXpkXHi77dIOL8L3EJAedlGIA8PzeJE1jjay0ihIba1rLQiw
	adDzGI13/1d5aFeNYEK9voM8E918YcRCaBhddR6S7olC584X+Xt48w==
X-Google-Smtp-Source: AGHT+IHbTeYpEXb5ZcMqasZzdDOda0xsCGxKjaQXWGJjZ5l/1+vN/CmuAzvLqhtikQr2cdXj4pwFkJaFHV3OkwSbBwgcSAx9pITO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1a98:b0:1d6:4b44:a3d0 with SMTP id
 ef24-20020a0568701a9800b001d64b44a3d0mr2508372oab.6.1695315401731; Thu, 21
 Sep 2023 09:56:41 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:56:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d83170605e16003@google.com>
Subject: [syzbot] [net?] memory leak in tcp_md5_do_add
From: syzbot <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1312bba8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
dashboard link: https://syzkaller.appspot.com/bug?extid=68662811b3d5f6695bcb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105393a8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113917f480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711/disk-ee3f96b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vmlinux-ee3f96b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425ad6/bzImage-ee3f96b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810a86f7a0 (size 32):
  comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1061
    [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169 [inline]
    [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.c:1240
    [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
    [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
    [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
    [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
    [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
    [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
    [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
    [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88811225ccc0 (size 192):
  comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
    22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
  backtrace:
    [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inline]
    [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
    [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
    [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
    [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv4.c:1212
    [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.c:1253
    [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
    [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
    [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
    [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
    [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
    [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
    [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
    [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

