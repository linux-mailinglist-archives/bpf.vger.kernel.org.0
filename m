Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6326272133
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIUKdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 06:33:25 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:56352 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgIUKdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 06:33:18 -0400
Received: by mail-il1-f207.google.com with SMTP id d16so10535694ila.23
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ANn/W8cefD65L0WEk2xKoOR7AQ8X98axJRQVhD3ngEg=;
        b=cW3NLNrgC3dlbIBx75A1gSfttfvP7n+vE0Nm2GBHZDR1eJIGP7Ny7kahNnOaZhJYPD
         TOKfGZT1+etFcxte+71P7z5uzu7f1VNgX6Z8B2XiHSQtB0r1yd+weyhZllboLJotuw0R
         Vo2YCOm6A4P2WHFAXbBC9ouVdErljKA976weOXjii/Naqc5CHqC0/epr6l+QrEv3roMg
         ugqQfDo9h/kgyC7Ymiz/PEB43j4ZgPbSHSPxuscKr4VAIh/H4IiB0gSfOSjhcCSF3wqM
         U9YzqDCH2r/U4ghRVMFUuGUhhI+EpNXFnzVaKc4icDRNldgFJF340mjbqbpSVkA45dPJ
         nihQ==
X-Gm-Message-State: AOAM5307JEUV78nd5KDP3QVFnVyiXMBRTfbNArPaf/Te3YcsupQ2I/zK
        AGF6XqjQnRZK3pTP8NYXqhnC3a1dG0CplJmrU64osgXe14CU
X-Google-Smtp-Source: ABdhPJyGl3Fu6WMhEKCiTG9/3nbg9Nx4V6AKJVZWxuSQImBhnaho95oaG5nHYhN9fIxuw3FdWogs2afMdLO/9FYPTUsr//BxExrT
MIME-Version: 1.0
X-Received: by 2002:a02:ca0e:: with SMTP id i14mr40438267jak.65.1600684397714;
 Mon, 21 Sep 2020 03:33:17 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec63c105afd060f5@google.com>
Subject: BUG: unable to handle kernel paging request in bpf_trace_run1
From:   syzbot <syzbot+35b2a9c256b8956a2b11@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128d4dd9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=35b2a9c256b8956a2b11
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35b2a9c256b8956a2b11@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffff520001f4806
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 21ffee067 P4D 21ffee067 PUD aa164067 PMD aa166067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6912 Comm: syz-executor.5 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__bpf_trace_run kernel/trace/bpf_trace.c:1887 [inline]
RIP: 0010:bpf_trace_run1+0x113/0x3c0 kernel/trace/bpf_trace.c:1923
Code: c7 c7 00 20 91 88 e8 ec 15 d2 ff 0f 1f 44 00 00 e8 82 07 f7 ff 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8e 02 00 00 48 8d 73 38 48 8d 7c 24 28 ff 53 30
RSP: 0018:ffffc900056d7588 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffc90000fa4000 RCX: dffffc0000000000
RDX: 1ffff920001f4806 RSI: ffffffff817f383e RDI: ffffc90000fa4030
RBP: 1ffff92000adaeb2 R08: 0000000000000000 R09: ffffffff8d0b79e7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888083309e40 R15: ffffc900056d79c0
FS:  0000000001995940(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520001f4806 CR3: 0000000057ab8000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __bpf_trace_ext4_mballoc_alloc+0x8b/0xc0 fs/ext4/super.c:6207
 trace_ext4_mballoc_alloc include/trace/events/ext4.h:1002 [inline]
 ext4_mb_collect_stats fs/ext4/mballoc.c:3541 [inline]
 ext4_mb_release_context fs/ext4/mballoc.c:4788 [inline]
 ext4_mb_new_blocks+0x2ad6/0x4720 fs/ext4/mballoc.c:4963
 ext4_ext_map_blocks+0x2320/0x61b0 fs/ext4/extents.c:4238
 ext4_map_blocks+0x7b8/0x1650 fs/ext4/inode.c:625
 ext4_getblk+0xad/0x530 fs/ext4/inode.c:832
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:882
 ext4_append+0x15d/0x370 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2765 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2810
 vfs_mkdir+0x507/0x770 fs/namei.c:3649
 do_mkdirat+0x262/0x2d0 fs/namei.c:3672
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca17
Code: 1f 40 00 b8 5a 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 2d c0 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 0d c0 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffee03b9878 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000059c04 RCX: 000000000045ca17
RDX: 00007ffee03b98c5 RSI: 00000000000001ff RDI: 00007ffee03b98c0
RBP: 0000000000000369 R08: 0000000000000000 R09: 0000000000000005
R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000003
R13: 00007ffee03b98b0 R14: 0000000000059aaa R15: 00007ffee03b98c0
Modules linked in:
CR2: fffff520001f4806
---[ end trace a7884d78e3b5aba2 ]---
RIP: 0010:__bpf_trace_run kernel/trace/bpf_trace.c:1887 [inline]
RIP: 0010:bpf_trace_run1+0x113/0x3c0 kernel/trace/bpf_trace.c:1923
Code: c7 c7 00 20 91 88 e8 ec 15 d2 ff 0f 1f 44 00 00 e8 82 07 f7 ff 48 8d 7b 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8e 02 00 00 48 8d 73 38 48 8d 7c 24 28 ff 53 30
RSP: 0018:ffffc900056d7588 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffc90000fa4000 RCX: dffffc0000000000
RDX: 1ffff920001f4806 RSI: ffffffff817f383e RDI: ffffc90000fa4030
RBP: 1ffff92000adaeb2 R08: 0000000000000000 R09: ffffffff8d0b79e7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888083309e40 R15: ffffc900056d79c0
FS:  0000000001995940(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520001f4806 CR3: 0000000057ab8000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
