Return-Path: <bpf+bounces-26109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBBE89AEBB
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 07:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D993A2835F0
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 05:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562E1876;
	Sun,  7 Apr 2024 05:59:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82FF9F5
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469558; cv=none; b=qlLLr1eHp6onWj8xo6UwKnY9DaWP2n+Rq5wG5EJRhHhOHBWFUGVKO6TPR5c96KX3PaXvheZsPXAdohKcnWsY43S2enssS2JSlzsveGy7Za7UagLZtUBOWG2oA7fxoXHwjPSUkQMiSm6+XCawyyYH42+pY2gRyzMTMiHy3M9T5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469558; c=relaxed/simple;
	bh=SQvC3t1tYE6Nsw7OKT8wvePTK46iGC72XDpd3nUyP8I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b+w4hu7AJ2iAwnyJCO2CfujjOjqCbQDJlQgObb+nMznokSOtX/K0vAjxQ15llkyfcHov1lmApQ/cdrzCIq1hZO6H+9tVcALlWUQdnXKfdnSQqlXDv3JC2OU+szSqp7IwLYGgxaWXOIv8KAq3OexkPxQuEOGKWtSdMBrhmUIUmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36660582091so39823175ab.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 22:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712469556; x=1713074356;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QrHHeznjplGnWd4t+TxFLv/UdbP8518qccfKdaod4s=;
        b=KHLORRQz1A9tX+IRKtRv0XkS6AWc7/PExbALpIQWG4RCLfiaExF4uRgM7kUDfevhMJ
         J8UzrtpzEDzP2yScqIkRZErD73wqt1ZeIl0IcTUAYAYBlGlEYzdTjK+D9L1W4KgBu8kC
         MOVx60x9jJ4FqHpMnyoPYBBKzGDV2mClW43uZY/qMC1tggHzqKIuZ0i1nX/VqbClmSfu
         ePp7U8dXueXA3RYo3tZogqp4ibmZLc+hDu8YlpQzFz5Pb1nrXp0T796igam/kvy/VbCx
         U14Ef5E3ePAsxBF5bHSk/bGisXmOsP3VruMggy1naUm9p4wfxu5bRfnNqp/dKtXVeLrq
         RqTg==
X-Forwarded-Encrypted: i=1; AJvYcCUxBlSwWqLTIxErmJKyFPeDVxL5gY4++pOvedcpLu4/Kemgy/l89+QC6+O3f9uieLy1dVEhvt+gfZ9iBP5geqoXqWbi
X-Gm-Message-State: AOJu0YzW5I9Px6hMrRmjCxF5fKV3l6qgH68SKoz29P1Ur25nttVQmVYJ
	QUNDTlQlzMxSIT9v+U+NiJUfjsoB2ALaPQKFiUxX142GA+DWuhoyCNMfo32YLlPxzcOCn2z91HJ
	vUF5t/JuvOzILb5/t+n8rgq2CR5tC8JNgKo/EYWb0kQAuG2lmL3onqjI=
X-Google-Smtp-Source: AGHT+IFfc/aeNEo0/n7C0M6rmG8q0oWvaw13RQjxNAntHMpL2PMGkraLujUupCGq64DmsUlthQVY3G5XBKMLnDjFRZ3fIK5XMauM
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220e:b0:368:d130:a718 with SMTP id
 j14-20020a056e02220e00b00368d130a718mr436494ilf.0.1712469555911; Sat, 06 Apr
 2024 22:59:15 -0700 (PDT)
Date: Sat, 06 Apr 2024 22:59:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091ad3106157b63e6@google.com>
Subject: [syzbot] [bpf?] BUG: unable to handle kernel paging request in jhash
From: syzbot <syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105e88a9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6592955f6080eeb2160f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c0cad180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11faf09d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in __get_unaligned_cpu32 include/linux/unaligned/packed_struct.h:19 [inline]
BUG: KASAN: stack-out-of-bounds in jhash+0x200/0x740 include/linux/jhash.h:82
Read of size 4 at addr ffffc9000a42eb20 by task kworker/u8:8/2470

CPU: 0 PID: 2470 Comm: kworker/u8:8 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __get_unaligned_cpu32 include/linux/unaligned/packed_struct.h:19 [inline]
 jhash+0x200/0x740 include/linux/jhash.h:82
 hash+0x339/0x410 kernel/bpf/bloom_filter.c:31
 bloom_map_peek_elem+0xb2/0x1b0 kernel/bpf/bloom_filter.c:43
 bpf_prog_00798911c748094f+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x2ec/0x500 kernel/trace/bpf_trace.c:2426
 __bpf_trace_jbd2_handle_stats+0x47/0x60 include/trace/events/jbd2.h:210
 trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
 jbd2_journal_stop+0xd3d/0xdc0 fs/jbd2/transaction.c:1869
 __ext4_journal_stop+0xfd/0x1a0 fs/ext4/ext4_jbd2.c:134
 ext4_do_writepages+0x2d24/0x3ca0 fs/ext4/inode.c:2692
 ext4_writepages+0x204/0x3e0 fs/ext4/inode.c:2768
 do_writepages+0x3a4/0x670 mm/page-writeback.c:2553
 __writeback_single_inode+0x155/0xfd0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0x8e4/0x1220 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2012
 wb_writeback+0x45b/0xc70 fs/fs-writeback.c:2119
 wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
 wb_do_writeback fs/fs-writeback.c:2276 [inline]
 wb_workfn+0xb7c/0x1070 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

The buggy address belongs to stack of task kworker/u8:8/2470
 and is located at offset 0 in frame:
 bpf_trace_run8+0x0/0x500

This frame has 1 object:
 [32, 96) 'args'

The buggy address belongs to the virtual mapping at
 [ffffc9000a428000, ffffc9000a431000) created by:
 copy_process+0x5d1/0x3df0 kernel/fork.c:2219

The buggy address belongs to the physical page:
page:ffffea0000a37d80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28df6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 60, tgid 60 (kworker/u8:4), ts 12699826929, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 alloc_pages_mpol+0x3de/0x650 mm/mempolicy.c:2133
 vm_area_alloc_pages mm/vmalloc.c:3135 [inline]
 __vmalloc_area_node mm/vmalloc.c:3211 [inline]
 __vmalloc_node_range+0x9a4/0x14a0 mm/vmalloc.c:3392
 alloc_thread_stack_node kernel/fork.c:309 [inline]
 dup_task_struct+0x3e9/0x7d0 kernel/fork.c:1114
 copy_process+0x5d1/0x3df0 kernel/fork.c:2219
 kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
 user_mode_thread+0x132/0x1a0 kernel/fork.c:2874
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:172
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc9000a42ea00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000a42ea80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000a42eb00: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00 00
                               ^
 ffffc9000a42eb80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000a42ec00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

