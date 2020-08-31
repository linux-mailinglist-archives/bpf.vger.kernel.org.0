Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A651257270
	for <lists+bpf@lfdr.de>; Mon, 31 Aug 2020 05:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgHaDuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Aug 2020 23:50:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38414 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHaDuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Aug 2020 23:50:17 -0400
Received: by mail-il1-f200.google.com with SMTP id m10so4182901ild.5
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2020 20:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zceVDbGcvgYbdU3lYwv7BFnU1J/ri1YdGAYmDuUho/M=;
        b=XIRJTzfWmcJIMqVCQp4r8/uQJEp97bRBYLnueRgXFNWvbvYiYx6qUVKDu/AvB5FhSF
         Pc+o+JFtUBP7oKxXixEnG3HofRT08fv9IOv4yWI1Zx7w4OPy26KFV9mrpg9mCXQXhgRh
         8h22Gc98LpqmLnNBQvplO46y96OTYgZuo/Y+Yg99wx2EQz3MRmer4tB84ForzYBUjL+6
         9iQwAVwD3Azfxv6IBQi/lvIsSRN45+1BJwaLKF6JBtdPpVH52xcA2N7f0H5txelgTnkB
         OFgP1hGfIqPDeAxFCwuyU8kFawz8xTNJH1tElk7XlmAhwh1ll0jCzMYrZvYIAYWBOApy
         wExA==
X-Gm-Message-State: AOAM531bNn2oMhjal248vgPWrZNaiO5J7dtVwQL0z6et9ByWxpbagd13
        Osw2pmuX5srMIhu1Y69sJorMulgagGcgIEOXXzU9Q+lYmrrI
X-Google-Smtp-Source: ABdhPJxEMBhRKRv0cS9IPchOQI56JjDpARFzB7aVvb8FlJUNri9MGfTKibrLvZYnWgqlmnkj0o1S2LtxgISVkzMu1CsUfBDWWChw
MIME-Version: 1.0
X-Received: by 2002:a92:2c0f:: with SMTP id t15mr3193311ile.205.1598845815317;
 Sun, 30 Aug 2020 20:50:15 -0700 (PDT)
Date:   Sun, 30 Aug 2020 20:50:15 -0700
In-Reply-To: <000000000000e5ea9e05ac9d16c1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df80ae05ae244c2b@google.com>
Subject: Re: memory leak in do_seccomp
From:   syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        keescook@chromium.org, kpsingh@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 21.940s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 21.930s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 23.180s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 23.170s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 24.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 24.440s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 25.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 25.700s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 28.150s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 28.140s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93600 (size 64):
  comm "syz-executor680", pid 6503, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
    08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba936c0 (size 64):
  comm "syz-executor680", pid 6507, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 c8 36 a9 1b 81 88 ff ff  .........6......
    c8 36 a9 1b 81 88 ff ff da fb d1 41 a1 10 39 25  .6.........A..9%
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93700 (size 64):
  comm "syz-executor680", pid 6509, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 37 a9 1b 81 88 ff ff  .........7......
    08 37 a9 1b 81 88 ff ff d9 22 de 70 43 30 b3 2f  .7.......".pC0./
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811ba93800 (size 64):
  comm "syz-executor680", pid 6511, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 a9 1b 81 88 ff ff  .........8......
    08 38 a9 1b 81 88 ff ff e4 c1 14 15 81 90 49 44  .8............ID
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb800 (size 64):
  comm "syz-executor680", pid 6506, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 b8 3c 19 81 88 ff ff  ..........<.....
    08 b8 3c 19 81 88 ff ff 87 43 ff ae fd 23 b0 15  ..<......C...#..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb740 (size 64):
  comm "syz-executor680", pid 6513, jiffies 4294951104 (age 29.390s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b7 3c 19 81 88 ff ff  ........H.<.....
    48 b7 3c 19 81 88 ff ff 0b 68 b6 93 80 9b 8d 35  H.<......h.....5
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881193cb640 (size 64):
  comm "syz-executor680", pid 6515, jiffies 4294951105 (age 29.380s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 48 b6 3c 19 81 88 ff ff  ........H.<.....
    48 b6 3c 19 81 88 ff ff b4 5e 22 0a b5 50 fa a5  H.<......^"..P..
  backtrace:
    [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
    [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
    [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
    [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
    [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program

