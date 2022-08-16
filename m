Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF7595817
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiHPKYF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiHPKXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 06:23:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED9116EE6;
        Tue, 16 Aug 2022 01:13:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d16so8523400pll.11;
        Tue, 16 Aug 2022 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=HaNa5Lj7TflIsF441E038f4wpAfhumsnkH45RU607sM=;
        b=Ww0bVrST1e5NUEUTrrq+iIFizUm7dif9ZWs/qC/0+v0oYqNsPQgUzmHmengaPvV1/s
         JIBIzjKY729iRHUZMD7mivMzVkjgF4p6SyVWQFs9UFGeOh41T15QyQ4izQR9Ihn3H5FD
         NyxpBtwQgCV+UL6wGus1uFHVaZ6Mi0HR0CGki6oJqqVF2CJJyQtyTDFUpBjBCapCjBYK
         c/7jh+DTayooy/abN6tPsz98QnZ8vQOe4iKeKV+AD4VRCX9sNkwiRjwr9QIrmftu/DXM
         /9Ffo9O8sq9oDuvYw9Vnx6Q0+oy9xTIRkZF2Tf2Siuqhmtv48BphvxP7ooDLwp3GgTtA
         2F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=HaNa5Lj7TflIsF441E038f4wpAfhumsnkH45RU607sM=;
        b=yTjdAh58GdVxgq9lOKpv23YBVfhsfkrhdTFN7FA2KGgYXsC39+3/vuEJkxM5/B0Qi9
         ytk2Q7rlU5lAis7p+sivX+SHQZ/9a3nFEyY4hxu0zfQ7+5UCpzclLw/vXa8euND32NMm
         bd8VOXYaatYqfY7n7qaUxxAmH+TPXPkwt5LOoNPRLjhcgqKtyl9WD/RRebsO/0t/8Bg3
         Z1on0Gds35vDvwRS9aIF4suTOrYKz7+Z4PSj96Aw0jRTj/jSJX0YiJOx1JbkSCS6HhXE
         3Z7klCHuX5gY+lnal8fHbG0EPiCj4l3hu699e6qJpfOz+9zr9q7I32GqXu8yYacJpZV4
         Dkug==
X-Gm-Message-State: ACgBeo31MGM+S/fZNPD4ZLTza7D3tixJ4g/LrBFA8iPsNTMUD1Du+S2c
        qHR5m7RJ8iaqhwUa8Lr6ORq7Eb4pisrtgYq3fVRD1Uu7v//9gW4=
X-Google-Smtp-Source: AA6agR7yu8H4/ggphVQvnzGDYaE0m6ytOr7ga/16iVCtxT7N/L8vPgzY1qvU0c8CdIJkIaxTn6om5QAkBJ3RjCObDmY=
X-Received: by 2002:a17:902:720b:b0:16d:2c4c:b52a with SMTP id
 ba11-20020a170902720b00b0016d2c4cb52amr20409714plb.155.1660637633487; Tue, 16
 Aug 2022 01:13:53 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 16 Aug 2022 08:13:42 +0800
Message-ID: <CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in __htab_map_lookup_and_delete_batch
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Last email was not formatted correctly, resend it here. The following
crash can be triggered on:

HEAD commit: ffcf9c5700e4  x86: link vdso and boot
git tree: upstream
console output: https://pastebin.com/raw/ngeVmgpK
kernel config: https://pastebin.com/raw/3JYdi5mp
C reproducer: https://paste.ubuntu.com/p/D2sz87PQ4k/

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user
include/linux/instrumented.h:118 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user lib/usercopy.c:32 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x9c/0xc0 lib/usercopy.c:26
Read of size 54 at addr ffff8881055c0100 by task syz-executor382/8357

CPU: 1 PID: 8357 Comm: syz-executor382 Not tainted
5.19.0-13666-gffcf9c5700e4-dirty #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x57/0x7d lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0xe5/0x66d mm/kasan/report.c:433
 kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13b/0x190 mm/kasan/generic.c:189
 instrument_copy_to_user include/linux/instrumented.h:118 [inline]
 _copy_to_user lib/usercopy.c:32 [inline]
 _copy_to_user+0x9c/0xc0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:160 [inline]
 __htab_map_lookup_and_delete_batch+0x1169/0x1cf0 kernel/bpf/hashtab.c:1809
 bpf_map_do_batch+0x2d6/0x590 kernel/bpf/syscall.c:4498
 __sys_bpf+0x1193/0x48b0 kernel/bpf/syscall.c:5014
 __do_sys_bpf kernel/bpf/syscall.c:5058 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5056 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f797e7e5b9d
Code: c3 e8 97 2a 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f797e76ad78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f797e87a2d0 RCX: 00007f797e7e5b9d
RDX: 0000000000000038 RSI: 0000000020000680 RDI: 0000000000000019
RBP: 00007f797e84700c R08: 00007f797e76b700 R09: 0000000000000000
R10: 00007f797e76b700 R11: 0000000000000246 R12: 00007f797e87a2d8
R13: 00007f797e87a2dc R14: 00000000200014c0 R15: 00007f797e846008
 </TASK>

Allocated by task 8357:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc_node+0x1e9/0x360 mm/slub.c:4472
 kvmalloc include/linux/slab.h:750 [inline]
 kvmalloc_array include/linux/slab.h:768 [inline]
 __htab_map_lookup_and_delete_batch+0x538/0x1cf0 kernel/bpf/hashtab.c:1680
 bpf_map_do_batch+0x2d6/0x590 kernel/bpf/syscall.c:4498
 __sys_bpf+0x1193/0x48b0 kernel/bpf/syscall.c:5014
 __do_sys_bpf kernel/bpf/syscall.c:5058 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5056 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8881055c0100
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff8881055c0100, ffff8881055c0140)

The buggy address belongs to the physical page:
page:ffffea0004157000 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x1055c0
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 0000000000000000 dead000000000122 ffff888010c42640
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6756, tgid 6756
(syz-executor382), ts 131529364832, free_ts 131498233118
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2525 [inline]
 prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
 get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
 __alloc_pages+0x321/0x710 mm/page_alloc.c:5515
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab mm/slub.c:1969 [inline]
 new_slab+0x246/0x3a0 mm/slub.c:2029
 ___slab_alloc+0xa50/0x1060 mm/slub.c:3031
 __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 __kmalloc_node+0x2ed/0x360 mm/slub.c:4468
 kmalloc_node include/linux/slab.h:623 [inline]
 __vmalloc_area_node mm/vmalloc.c:3012 [inline]
 __vmalloc_node_range+0x30a/0xf70 mm/vmalloc.c:3196
 alloc_thread_stack_node kernel/fork.c:312 [inline]
 dup_task_struct kernel/fork.c:977 [inline]
 copy_process+0x4069/0x6660 kernel/fork.c:2087
 kernel_clone+0xba/0xba0 kernel/fork.c:2673
 __do_sys_clone+0xa1/0xe0 kernel/fork.c:2807
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x410 mm/page_alloc.c:3476
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:114 [inline]
 tlb_remove_table_rcu+0x6e/0xb0 mm/mmu_gather.c:169
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x785/0x1720 kernel/rcu/tree.c:2505
 __do_softirq+0x1d0/0x908 kernel/softirq.c:571

Memory state around the buggy address:
 ffff8881055c0000: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8881055c0080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff8881055c0100: 00 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff8881055c0180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881055c0200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
