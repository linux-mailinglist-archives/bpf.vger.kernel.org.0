Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22732ACB62
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 03:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJC6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 21:58:17 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39730 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJC6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 21:58:17 -0500
Received: by mail-io1-f71.google.com with SMTP id z18so7231488ioz.6
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 18:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=a8B//BV5zEcerbhvwZ2YuT/pPrEXCPnHFOZRoZbm028=;
        b=CEfeNAH4E4Xp6I3INj6KNWYe0CS7MObUstaddUUenBi/rQFa0P5y6A/358hqpDtW+M
         CjdnR5YxRR1B/nbrY2Mg8CsstQ6RMujHbqJMMN0CDZoRAqCAKUaDtjQPSVTP3IqHJo+g
         o7BxDwuOT7sXJAr2tPD1bpaiefn03Ub04L99Gh2f+NjUmuRbn6+h7LaLdQtDxDwcWzpU
         jY+RQzYTubEaNo0sJX0uuHfggwG8FltrIAwGfw8S/v8mV/+f/y9xNgil4DmkdTXpmk06
         9cwrDWpwrgQVU9pZnA4V9LDF/54cIYo6iSRWJ8ozHNZt3RnJUv/hlnqs6SRIkX+AzeGc
         lMXg==
X-Gm-Message-State: AOAM532psXLLFL5Eajp9Xq/cVX1rDWzJ+l6wk7GzNTfxRILkx1XIdAr3
        Wjkpuozed+ZLRABn0gW8Hd7gcaOY5mEbXbjGvpieYrrj4WCP
X-Google-Smtp-Source: ABdhPJxTWyNtV01BAQDZLTmS0JXnr34mHj0GWvN6ciRMB6cYXw/neLMgNAU+eUwANSoIbXKQUUvZBAQ8gdBEfqq/miwD51TfUWlr
MIME-Version: 1.0
X-Received: by 2002:a5d:8b4c:: with SMTP id c12mr12348486iot.167.1604977096620;
 Mon, 09 Nov 2020 18:58:16 -0800 (PST)
Date:   Mon, 09 Nov 2020 18:58:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b782e305b3b7d9f6@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in bpf_trace_run1
From:   syzbot <syzbot+3cab841567b697b80981@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
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

HEAD commit:    4e0396c5 net: marvell: prestera: fix compilation with CONF..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11697b82500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=3cab841567b697b80981
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3cab841567b697b80981@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __bpf_trace_run kernel/trace/bpf_trace.c:2045 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bpf_trace_run1+0x3b0/0x3c0 kernel/trace/bpf_trace.c:2081
Read of size 8 at addr ffffc900019c3030 by task syz-executor.2/3268

CPU: 0 PID: 3268 Comm: syz-executor.2 Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __bpf_trace_run kernel/trace/bpf_trace.c:2045 [inline]
 bpf_trace_run1+0x3b0/0x3c0 kernel/trace/bpf_trace.c:2081
 __bpf_trace_block_plug+0x8b/0xc0 block/blk-core.c:716
 trace_block_plug+0x138/0x280 include/trace/events/block.h:470
 blk_mq_submit_bio+0xcf2/0x1770 block/blk-mq.c:2219
 __submit_bio_noacct_mq block/blk-core.c:1026 [inline]
 submit_bio_noacct+0xa27/0xe30 block/blk-core.c:1059
 submit_bio+0x263/0x5b0 block/blk-core.c:1129
 iomap_dio_submit_bio+0x293/0x360 fs/iomap/direct-io.c:76
 iomap_dio_bio_actor+0x4b3/0xf00 fs/iomap/direct-io.c:312
 iomap_dio_actor+0x89/0x550 fs/iomap/direct-io.c:389
 iomap_apply+0x2a3/0xb50 fs/iomap/apply.c:84
 __iomap_dio_rw+0x6cd/0x1220 fs/iomap/direct-io.c:517
 iomap_dio_rw+0x31/0x90 fs/iomap/direct-io.c:605
 ext4_dio_write_iter fs/ext4/file.c:552 [inline]
 ext4_file_write_iter+0xddc/0x1400 fs/ext4/file.c:662
 call_write_iter include/linux/fs.h:1887 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x57d/0x700 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fab24ef9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000003ac00 RCX: 000000000045deb9
RDX: 0000000000248800 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffdb0e8a67f R14: 00007fab24efa9c0 R15: 000000000118bf2c


Memory state around the buggy address:
 ffffc900019c2f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900019c2f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc900019c3000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                     ^
 ffffc900019c3080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900019c3100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
