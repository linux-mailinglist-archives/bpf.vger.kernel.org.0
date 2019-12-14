Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC011F2C1
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 17:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNQUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Dec 2019 11:20:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34744 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNQUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Dec 2019 11:20:08 -0500
Received: by mail-il1-f200.google.com with SMTP id l13so2386624ils.1
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 08:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=T1hiEXBdS0/Iki3lXc3Ewuu/hWuzKibBkn/YRWovuxE=;
        b=AnCV/mspgnB341RpaVPpL6X4hm0Iifj5VDxt7C4FRFjG0l7f5Hu6csP2AD9MICvOsB
         8z3bdZW8I8Qq+/5CyxvmT9JQOClLMquIfAE7RyzLna1jLnCyx1hXLVZV3ujIK0osqkqZ
         p4rW1zS62vwOT8uycorkGFZJF0wEE6GVs5awBs2JgHUxhkEpqWDmlit1+/XCw9EGaHc4
         VbwKQ8bPTLieml3FPft1ji6RsXv22k/ylt+EITiYVPR271RAxCgRpeeMAj+BWBGE6ohB
         Ktq76tpDonw2BdmiF+CSwPs2FC0OpT/JdbUlfaBzqDaoY5Jy3q+2Bxt/oxJZyrv+A9q7
         sc8A==
X-Gm-Message-State: APjAAAVzDseQ9mPEwbLl18bHBr4xGMrmKugEsnPzzhV8TR4TgqoEvszg
        /Sf5gAecQ3+yheSoR5rlVCR/nWdQe+UhFr5BF8N1mwzhCSSf
X-Google-Smtp-Source: APXvYqw/Q2rdRY5+Jv4EzoPhboppRj1eT9m/lQO+8jJ/R7+yFck9Y8fEwFUI1BW6rIHxzYo/V8XKxvttd+FPL4CiAAZmzivw1hoI
MIME-Version: 1.0
X-Received: by 2002:a92:465c:: with SMTP id t89mr4917217ila.263.1576340407854;
 Sat, 14 Dec 2019 08:20:07 -0800 (PST)
Date:   Sat, 14 Dec 2019 08:20:07 -0800
In-Reply-To: <000000000000a6f2030598bbe38c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e32950599ac5a96@google.com>
Subject: Re: WARNING in wp_page_copy
From:   syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bjorn.topel@intel.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1d1997db Revert "nfp: abm: fix memory leak in nfp_abm_u32_..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1029f851e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cef1fd5032faee91
dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d9fb1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9104 at mm/memory.c:2229 cow_user_page  
mm/memory.c:2229 [inline]
WARNING: CPU: 0 PID: 9104 at mm/memory.c:2229 wp_page_copy+0x10b7/0x1560  
mm/memory.c:2414
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9104 Comm: syz-executor.0 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:cow_user_page mm/memory.c:2229 [inline]
RIP: 0010:wp_page_copy+0x10b7/0x1560 mm/memory.c:2414
Code: 4c 89 f7 ba 00 10 00 00 48 81 e6 00 f0 ff ff e8 0f e6 22 06 31 ff 41  
89 c7 89 c6 e8 23 03 d3 ff 45 85 ff 74 0f e8 99 01 d3 ff <0f> 0b 4c 89 f7  
e8 3f d8 22 06 e8 8a 01 d3 ff 65 4c 8b 34 25 c0 1e
RSP: 0018:ffffc90002267668 EFLAGS: 00010293
RAX: ffff8880a04c6140 RBX: ffffc90002267918 RCX: ffffffff81a22a0d
RDX: 0000000000000000 RSI: ffffffff81a22a17 RDI: 0000000000000005
RBP: ffffc900022677a8 R08: ffff8880a04c6140 R09: 0000000000000000
R10: ffffed101125cfff R11: ffff8880892e7fff R12: ffff88809e403108
R13: ffffea000224b9c0 R14: ffff8880892e7000 R15: 0000000000001000
  do_wp_page+0x543/0x1540 mm/memory.c:2724
  handle_pte_fault mm/memory.c:3961 [inline]
  __handle_mm_fault+0x327b/0x3da0 mm/memory.c:4075
  handle_mm_fault+0x3b2/0xa50 mm/memory.c:4112
  do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
  __do_page_fault+0x536/0xd80 arch/x86/mm/fault.c:1506
  do_page_fault+0x38/0x590 arch/x86/mm/fault.c:1530
  page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:copy_user_generic_unrolled+0x89/0xc0  
arch/x86/lib/copy_user_64.S:91
Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f 38 48 8d 76 40 48 8d  
7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d  
76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
RSP: 0018:ffffc90002267bb8 EFLAGS: 00010206
RAX: 0000000000000001 RBX: 0000000000000018 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffffc90002267c58 RDI: 0000000020001300
RBP: ffffc90002267bf0 R08: 0000000000000000 R09: fffff5200044cf8e
R10: fffff5200044cf8d R11: ffffc90002267c6f R12: 0000000020001300
R13: ffffc90002267c58 R14: 0000000020001318 R15: 00007ffffffff000
  copy_to_user include/linux/uaccess.h:152 [inline]
  xsk_getsockopt+0x575/0x6c0 net/xdp/xsk.c:898
  __sys_getsockopt+0x16d/0x310 net/socket.c:2174
  __do_sys_getsockopt net/socket.c:2189 [inline]
  __se_sys_getsockopt net/socket.c:2186 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:2186
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a909
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ec9e9ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045a909
RDX: 0000000000000007 RSI: 000000000000011b RDI: 000000000000000a
RBP: 000000000075bf20 R08: 0000000020000100 R09: 0000000000000000
R10: 0000000020001300 R11: 0000000000000246 R12: 00007f0ec9e9f6d4
R13: 00000000004c1ab5 R14: 00000000004d5f60 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

