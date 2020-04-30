Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3591BF445
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgD3JjQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 05:39:16 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50367 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgD3JjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 05:39:15 -0400
Received: by mail-io1-f71.google.com with SMTP id q5so676105ioh.17
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 02:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vIIPXuZlrFp+xo9o1bYGQn743Cw7J0PFty6YB+csSAs=;
        b=PcfL6I+sBiBbkCtSvOkTgDO+wykQ6WVU3swewLq1ugNfaVz+Lyor8Ykc7ikDiApXZD
         vNh1YT82WLGfNfcdll7fmBQt+l3h0GN7fIfa+3l6RHg/7RvKCReIu1d1rJcA/2cMz6LK
         JcrzxgYDsOocI+JQxcC1IISLUzME8Ioix0Q0Trh0Bf9uRMosRKzlRo4bVhh+rHWcnGXN
         40VKewsI+iLCrOfgpBCIpbs17MUgavJCtMQ9enhfAq0JhDpfQ2/ypYroW9n6hsqxCLfw
         tq+vUGuPbiGCK1MLvK3CHuNe4YTqZrkvM1luJnyOO4sSu/aJ7vPgNosCDGrJZGaKofpR
         s3mA==
X-Gm-Message-State: AGi0PubHf+nlyAVGr+6Z1dcNgAURLcd0JgXb743U8YzvoNWRS0tRHzUs
        KfX2zVaZvCsTRxSGTsaDgoOe/4cfxsoc5Se9HM+y+DeEVNaw
X-Google-Smtp-Source: APiQypKKYdthYXw0O5GkI1I7af5y5d0o9AL7tkFs1a//unSQ2oRtOdcpPA8GxmMlfAy2fOhW3czeZfzNNjviHCduO1HO2K9C6QZP
MIME-Version: 1.0
X-Received: by 2002:a5d:96c5:: with SMTP id r5mr936809iol.41.1588239553493;
 Thu, 30 Apr 2020 02:39:13 -0700 (PDT)
Date:   Thu, 30 Apr 2020 02:39:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006780dc05a47ed632@google.com>
Subject: KASAN: use-after-free Write in bpf_link_put
From:   syzbot <syzbot+39b64425f91b5aab714d@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    449e14bf bpf: Fix unused variable warning
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109eb5f8100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16d87c420507d444
dashboard link: https://syzkaller.appspot.com/bug?extid=39b64425f91b5aab714d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+39b64425f91b5aab714d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic64_dec_and_test include/asm-generic/atomic-instrumented.h:1557 [inline]
BUG: KASAN: use-after-free in bpf_link_put+0x19/0x1b0 kernel/bpf/syscall.c:2255
Write of size 8 at addr ffff8880a7248800 by task syz-executor.0/28011

CPU: 0 PID: 28011 Comm: syz-executor.0 Not tainted 5.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 atomic64_dec_and_test include/asm-generic/atomic-instrumented.h:1557 [inline]
 bpf_link_put+0x19/0x1b0 kernel/bpf/syscall.c:2255
 bpf_link_release+0x33/0x40 kernel/bpf/syscall.c:2270
 __fput+0x33e/0x880 fs/file_table.c:280
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fc891a66469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fc892156db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: fffffffffffffff4 RBX: 000000000042c4e0 RCX: 00007fc891a66469
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 000000000000001c
RBP: 00000000006abf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 000000000000004f R14: 0000000000415473 R15: 00007fc8921575c0

Allocated by task 28011:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc mm/kasan/common.c:495 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:468
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 cgroup_bpf_link_attach+0x13d/0x5b0 kernel/bpf/cgroup.c:894
 link_create kernel/bpf/syscall.c:3765 [inline]
 __do_sys_bpf+0x238c/0x46d0 kernel/bpf/syscall.c:3987
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 28011:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 cgroup_bpf_link_attach+0x2bc/0x5b0 kernel/bpf/cgroup.c:906
 link_create kernel/bpf/syscall.c:3765 [inline]
 __do_sys_bpf+0x238c/0x46d0 kernel/bpf/syscall.c:3987
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff8880a7248800
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff8880a7248800, ffff8880a7248880)
The buggy address belongs to the page:
page:ffffea00029c9200 refcount:1 mapcount:0 mapping:00000000a3d4ec31 index:0xffff8880a7248700
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024ceac8 ffffea000251d3c8 ffff8880aa000700
raw: ffff8880a7248700 ffff8880a7248000 000000010000000f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a7248700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a7248780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a7248800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880a7248880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a7248900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
