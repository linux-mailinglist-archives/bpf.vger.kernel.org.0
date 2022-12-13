Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A264B887
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 16:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiLMPfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 10:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiLMPfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 10:35:42 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD41FCD1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 07:35:40 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so2081226ioz.8
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 07:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RxT+yoEXvae8IZOVzRkgDoj7dOx8+ozRPGUkIsbuyE=;
        b=pOAGg57eqo6O6ZN/tI1aV05TgL6Y3ph8vvirHc1C3CSZLvhWqbA+PtGaeVTMiXJ/GF
         xYZDe9TSK6FZv5pQtLqYcUEfStLpyM07iwdQ4RXYoAcCgbGjzeVLkGdUkgRgKoqJVPaD
         XfMmvN7JSOagDx35YB6P8Ih+8Dx3dGFqKJK+pK37JsOxktqdzKWZyqRSBeW30bgSgxA2
         gFnDnNAfNnniMsa84AbfEwGUzp/wIPItV9SgAmNBmChRg2Jb1m0Mdrge0E0Y29PH++i3
         GOiSixaxtUu0QRr1ZQ0DvQ2LvT9XeGAJZyPoqhu41OZGEtCeBB1DA0e2RY/zAaddJg16
         VUng==
X-Gm-Message-State: ANoB5plPnIFg+KAXBSFdoNv1Ov4JWTrhsEHiENfgCmY8fLyMVDZnKY/F
        n3+qyBDCZPGW8owc1YSx9JgY7oKGocFlSqklFh0trba+M5jP
X-Google-Smtp-Source: AA0mqf6AIADVjhBFdqvCaPHcsy9o9+e0DIRyToosTovBS/F4dkhCuNCRxExzFX/gPA8yewZTXWA5pHELZ3agBShiHxls0WtKuV1j
MIME-Version: 1.0
X-Received: by 2002:a92:d590:0:b0:303:4c6:dd96 with SMTP id
 a16-20020a92d590000000b0030304c6dd96mr26682271iln.246.1670945739940; Tue, 13
 Dec 2022 07:35:39 -0800 (PST)
Date:   Tue, 13 Dec 2022 07:35:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044cc2e05efb75fc3@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in __blk_flush_plug
From:   syzbot <syzbot+27ad9fcb89d23f44ca81@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bpf@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0d1409e4ff08 Merge tag 'drm-fixes-2022-12-09' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170a308f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=27ad9fcb89d23f44ca81
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ab0143f95cb/disk-0d1409e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e574d5eaa32f/vmlinux-0d1409e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31109436b00b/bzImage-0d1409e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27ad9fcb89d23f44ca81@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in __blk_flush_plug+0x4ca/0x570 block/blk-core.c:1136
Read of size 8 at addr ffffc900031bf37f by task syz-executor.3/10381

CPU: 0 PID: 10381 Comm: syz-executor.3 Not tainted 6.1.0-rc8-syzkaller-00148-g0d1409e4ff08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 __blk_flush_plug+0x4ca/0x570 block/blk-core.c:1136
 blk_finish_plug+0x5a/0x80 block/blk-core.c:1161
 read_pages+0x7a8/0x9c0 mm/readahead.c:184
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
 filemap_get_pages+0x465/0x10d0 mm/filemap.c:2581
 filemap_read+0x3cf/0xea0 mm/filemap.c:2675
 call_read_iter include/linux/fs.h:2193 [inline]
 generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ef8e8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ef9c36168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0ef8fabf80 RCX: 00007f0ef8e8c0d9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f0ef8ee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000f03b0000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff02d3b9cf R14: 00007f0ef9c36300 R15: 0000000000022000
 </TASK>

The buggy address belongs to stack of task syz-executor.3/10381
 and is located at offset 31 in frame:
 read_pages+0x0/0x9c0 include/linux/page-flags.h:319

This frame has 1 object:
 [32, 72) 'plug'

The buggy address belongs to the virtual mapping at
 [ffffc900031b8000, ffffc900031c1000) created by:
 dup_task_struct+0x8b/0x490 kernel/fork.c:974

The buggy address belongs to the physical page:
page:ffffea00008b5a40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22d69
memcg:ffff888027c8ad02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff ffff888027c8ad02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 10379, tgid 10379 (syz-executor.3), ts 335022583921, free_ts 334826793550
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 vm_area_alloc_pages mm/vmalloc.c:2975 [inline]
 __vmalloc_area_node mm/vmalloc.c:3043 [inline]
 __vmalloc_node_range+0x9b2/0x1400 mm/vmalloc.c:3213
 alloc_thread_stack_node+0x307/0x500 kernel/fork.c:311
 dup_task_struct+0x8b/0x490 kernel/fork.c:974
 copy_process+0x637/0x4000 kernel/fork.c:2084
 kernel_clone+0x21b/0x620 kernel/fork.c:2671
 __do_sys_clone kernel/fork.c:2812 [inline]
 __se_sys_clone kernel/fork.c:2796 [inline]
 __x64_sys_clone+0x228/0x290 kernel/fork.c:2796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3529
 release_pages+0x232a/0x25c0 mm/swap.c:1055
 tlb_batch_pages_flush mm/mmu_gather.c:59 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:254 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:261
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:361
 exit_mmap+0x275/0x630 mm/mmap.c:3102
 __mmput+0x114/0x3b0 kernel/fork.c:1185
 exit_mm+0x1f5/0x2d0 kernel/exit.c:516
 do_exit+0x5e7/0x2070 kernel/exit.c:807
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffffc900031bf200: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 f3 f3
 ffffc900031bf280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900031bf300: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
                                                                ^
 ffffc900031bf380: 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
 ffffc900031bf400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
