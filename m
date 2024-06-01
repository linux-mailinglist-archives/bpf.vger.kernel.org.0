Return-Path: <bpf+bounces-31093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716D8D7035
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EF41F21E2F
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB3E1514D2;
	Sat,  1 Jun 2024 13:29:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032778C04
	for <bpf@vger.kernel.org>; Sat,  1 Jun 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248573; cv=none; b=aRIAO8d7syNt2WYv+fL4pkHa/N4fJROotgMrDeElH8uVr3Y06cZ1G4g71msHtvlhBwaUqlvt8NM54QBNvzlrooHIm3h0GgZjipa+OE+sdmeMeISZCBsN8MVs5t/uvgxjgOIJOi1IdZwQBt/Cz7WYspRVLf/jElGqgqfH3BY5TM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248573; c=relaxed/simple;
	bh=RIOHezexyxGy4jkSM3NvMXgFmuZSAIY7AM/fLRmrUpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E7huvqANROzaeS+hVb0Dk33FM96JBoaUwTdGaIA2BigIc2C1dOLM/DnB677Kl8ovHEu/BRAgWdVtWsAbzmsTum1IZaSw4HzrXnAF1K4XLMCD6OeHlnaqECu3LQa9wJmM/vEopP0mLO/EwJ/0N3e1kYmm4BO9QtDlFz5j81ijgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so378353639f.2
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2024 06:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717248571; x=1717853371;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WkwCyb5pr1tQlwMAm41RZS3OCmU8uc2oO/L8HRP1x4=;
        b=QcBl6jz2kxGF4F3ELvmlG/cQ5PchOfg63g9GA3T4yenTWrp0s3rcy2HYkFkgzXVOhw
         Hx+otLDakht0UqKyorvjH6wSixKYGnp3WYEuSyNXaqZGFI0vpxcT/KoyXw3e/AKsioQm
         mQ6I8Ld95lnTsSKVb4k9JidbnPhA/2EED78GYARayUVzC0eBzJMqTE1cw7/7hh0YrDKT
         QecsKn3s7OcHrxMWI9wXvJ+S52+KFWQE8fuEaBAnZ2GOUT7xTsuJEV+xgN3idrHPrQVP
         xRgvAR/jrxeAJIO+zJq4a6CJ2N+vho6FKffI+XKvFwINmwHaSKu5CNOczX+aRBmdRr84
         kDuw==
X-Forwarded-Encrypted: i=1; AJvYcCUSsjvviamdm4CNiscHkLKLodX19SbDgghzfXUP5BmBDzU6Bx5eblaj2EA+MeiQUCB6SI4nAIJHQ0fMD4HFwVl31F/y
X-Gm-Message-State: AOJu0Yxhsf41tnuI9y5p/Qup06sZhRKhnD8vPMzg9SjXivxNgIRast7P
	s1lQSqZX+5BhG8KfX3pxooknXV4YqhniC9ziYyy0ELD+gw9F5+DpUgtMWGWBgaZYhr9pShTuKAW
	64ib+ZySv1uiG2k9VupnxzTNY2M0+pPFMq6Wk3hOIJTtrE6gNufSbnrU=
X-Google-Smtp-Source: AGHT+IEMwnnn2n1GFS9it+8sa9OCUrwhGeNLcdSvIxSqTGtMHOQoJi8p5UN9/tSlbFWdLOaWmX2Ft0sX0WGXtdyojleeunpqAUuj
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f95:b0:7e2:b00:2239 with SMTP id
 ca18e2360f4ac-7eaffdaad64mr20640339f.0.1717248571218; Sat, 01 Jun 2024
 06:29:31 -0700 (PDT)
Date: Sat, 01 Jun 2024 06:29:31 -0700
In-Reply-To: <000000000000909ea8061969bce5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000142fcb0619d41757@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free (2)
From: syzbot <syzbot+1989ee16d94720836244@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d8ec19857b09 Merge tag 'net-6.10-rc2' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10fc5032980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=1989ee16d94720836244
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ea03b4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a4e508e8f23/disk-d8ec1985.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fe170c8d3d2/vmlinux-d8ec1985.xz
kernel image: https://storage.googleapis.com/syzbot-assets/458e50053f06/bzImage-d8ec1985.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3078
Read of size 8 at addr ffff88807a2e0310 by task syz-executor/10271

CPU: 1 PID: 10271 Comm: syz-executor Not tainted 6.10.0-rc1-syzkaller-00104-gd8ec19857b09 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3078
 bpf_link_put_direct kernel/bpf/syscall.c:3106 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3113
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b0867bdda
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffec192db80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f3b0867bdda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: ffffffffffffffff R08: 00007f3b08600000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000293 R12: 00007f3b087b3fa0
R13: 00007f3b087b3fac R14: 0000000000000032 R15: 00007f3b087b59a0
 </TASK>

Allocated by task 10272:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4152
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3858
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3905
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5729
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x149/0x360 mm/slub.c:4557
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 bpf_link_free+0x1f8/0x2d0 kernel/bpf/syscall.c:3076
 bpf_link_put_direct kernel/bpf/syscall.c:3106 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3113
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807a2e0300
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 16 bytes inside of
 freed 128-byte region [ffff88807a2e0300, ffff88807a2e0380)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a2e0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888015041a00 ffffea0000b66980 dead000000000002
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5668, tgid 5663 (syz-executor.2), ts 720987957452, free_ts 720987810239
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4141
 __do_krealloc mm/slab_common.c:1183 [inline]
 krealloc_noprof+0x7d/0x120 mm/slab_common.c:1216
 realloc_array kernel/bpf/verifier.c:1250 [inline]
 grow_stack_state kernel/bpf/verifier.c:1313 [inline]
 check_stack_access_within_bounds+0x5be/0x980 kernel/bpf/verifier.c:6754
 check_mem_access+0x865/0x1e60 kernel/bpf/verifier.c:6907
 do_check+0x8848/0x10980 kernel/bpf/verifier.c:17911
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20839
 do_check_main kernel/bpf/verifier.c:20930 [inline]
 bpf_check+0x14222/0x192f0 kernel/bpf/verifier.c:21600
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2908
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5687
page last free pid 5668 tgid 5663 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2565
 vfree+0x186/0x2e0 mm/vmalloc.c:3346
 bpf_prog_calc_tag+0x663/0x900 kernel/bpf/core.c:358
 resolve_pseudo_ldimm64+0xdf/0x16a0 kernel/bpf/verifier.c:18391
 bpf_check+0x64f7/0x192f0 kernel/bpf/verifier.c:21586
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2908
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5687
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a2e0200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a2e0280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807a2e0300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807a2e0380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a2e0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

