Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A951FEDB
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 07:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEPFqP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 May 2019 01:46:15 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:41299 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEPFqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 01:46:06 -0400
Received: by mail-it1-f199.google.com with SMTP id y62so2287574itd.6
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 22:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tgc7GEi/p8to8+1uRafrubdbYu2TMmvglM0eA+RoSWQ=;
        b=DuKiCrXw2L6MXjgqGeQyw/fHSbwnf8PwNwf59zY0AiBLFRQlc6+xoGn/hMXHRmd7Bg
         oOZvDaYQOW68vKAdop1Y39YVp7DlpxpbTuWSMqeTcH6csb8+crYrgOjlsOhEwlQnkMhz
         iiET107bgI6FUaXKsP1OnwYXotBKDMU5oV/My4j3ncsY4to8QHBMbJ1bdE4pAJDwaj5+
         1cKkvhwUTCxmijBxR5f/qXklrHXHROtCP/UW0zLGNCMUcxG/wjmBQI1zSslIwPc4d+bq
         rbsloGbeaowZSd8C3k3LksFM3oCVjtc7/cMprhUSFa6h+YQ/m9r43aoMWSGJe0SiJz8u
         jNxw==
X-Gm-Message-State: APjAAAXKYjCuMRczaxufLUe5xnWGz8i91iv8aIL1cuDVcNi7bgC7475L
        68W64VyX9m/KCthYlyvKhf42mtjr6gIPmFPMhfQ0zuaQC0ma
X-Google-Smtp-Source: APXvYqxdnOLPNI4SPCg8kAAc4Imf3dgIaZgeX3CzvLXOlPKTDwXGEropBQJBQyY6HpcG8WVv6rtv/62aUZVwHw8wIyiroxq8mp2G
MIME-Version: 1.0
X-Received: by 2002:a24:9906:: with SMTP id a6mr10464843ite.52.1557985565578;
 Wed, 15 May 2019 22:46:05 -0700 (PDT)
Date:   Wed, 15 May 2019 22:46:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033a0120588fac894@google.com>
Subject: WARNING: locking bug in inet_autobind
From:   syzbot <syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    35c99ffa Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e970f4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82f0809e8f0a8c87
dashboard link: https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 32543 at kernel/locking/lockdep.c:734  
arch_local_save_flags arch/x86/include/asm/paravirt.h:762 [inline]
WARNING: CPU: 1 PID: 32543 at kernel/locking/lockdep.c:734  
arch_local_save_flags arch/x86/include/asm/paravirt.h:760 [inline]
WARNING: CPU: 1 PID: 32543 at kernel/locking/lockdep.c:734  
look_up_lock_class kernel/locking/lockdep.c:725 [inline]
WARNING: CPU: 1 PID: 32543 at kernel/locking/lockdep.c:734  
register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1078
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 32543 Comm: syz-executor.4 Not tainted 5.1.0+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:566
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:180 [inline]
  fixup_bug arch/x86/kernel/traps.c:175 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:273
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:292
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:972
RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:734 [inline]
RIP: 0010:register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1078
Code: 00 48 89 da 4d 8b 76 c0 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 23 07 00 00 4c 89 33 e9 e3 f4 ff ff 0f 0b <0f> 0b e9 ea f3  
ff ff 44 89 e0 4c 8b 95 50 ff ff ff 83 c0 01 4c 8b
RSP: 0018:ffff88806395f9e8 EFLAGS: 00010083
RAX: dffffc0000000000 RBX: ffff8880a947f1e0 RCX: 0000000000000000
RDX: 1ffff1101528fe3f RSI: 0000000000000000 RDI: ffff8880a947f1f8
RBP: ffff88806395fab0 R08: 1ffff1100c72bf45 R09: ffffffff8a459c80
R10: ffffffff8a0e47e0 R11: 0000000000000000 R12: ffffffff8a1235a0
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff87fe4c60
  __lock_acquire+0x116/0x5490 kernel/locking/lockdep.c:3673
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4302
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2917
  lock_sock include/net/sock.h:1525 [inline]
  inet_autobind+0x20/0x1a0 net/ipv4/af_inet.c:183
  inet_dgram_connect+0x252/0x2e0 net/ipv4/af_inet.c:573
  __sys_connect+0x266/0x330 net/socket.c:1840
  __do_sys_connect net/socket.c:1851 [inline]
  __se_sys_connect net/socket.c:1848 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1848
  do_syscall_64+0x103/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458da9
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f695f8b6c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458da9
RDX: 000000000000001c RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f695f8b76d4
R13: 00000000004bf1fe R14: 00000000004d04f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
