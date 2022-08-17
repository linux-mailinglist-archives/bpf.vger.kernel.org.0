Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B5596A0B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbiHQHIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiHQHIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 03:08:19 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875465DB;
        Wed, 17 Aug 2022 00:08:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M6zb90tcqzKwq8;
        Wed, 17 Aug 2022 15:06:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgDHoDnXk_xiOOiuAQ--.23666S2;
        Wed, 17 Aug 2022 15:08:11 +0800 (CST)
Subject: Re: KASAN: slab-out-of-bounds Read in
 __htab_map_lookup_and_delete_batch
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
References: <CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        andrii@kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, haoluo@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <54b435bf-c710-a6b9-4855-9a29e099eab8@huaweicloud.com>
Date:   Wed, 17 Aug 2022 15:08:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbuxaR6cv0kXJoVnBfL9ZJXjjoUcMpw_Ogc313jSrg14A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgDHoDnXk_xiOOiuAQ--.23666S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1UJrWfAr15Gr18Gr1fXrb_yoW3ZFW5pF
        n5GrWxWr40qrykA3yxJr1kAryxZF43A3WUGr97WFyrZ3Wftw1jqr1vqr9Fgr1akr4FyF13
        ArnrtrWFvw1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/16/2022 8:13 AM, Hao Sun wrote:
> Hello,
>
> Last email was not formatted correctly, resend it here. The following
> crash can be triggered on:
>
> HEAD commit: ffcf9c5700e4  x86: link vdso and boot
> git tree: upstream
> console output: https://pastebin.com/raw/ngeVmgpK
> kernel config: https://pastebin.com/raw/3JYdi5mp
> C reproducer: https://paste.ubuntu.com/p/D2sz87PQ4k/
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user
> include/linux/instrumented.h:118 [inline]
> BUG: KASAN: slab-out-of-bounds in _copy_to_user lib/usercopy.c:32 [inline]
> BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x9c/0xc0 lib/usercopy.c:26
> Read of size 54 at addr ffff8881055c0100 by task syz-executor382/8357
Have not run the reproducer yet (due to network access restriction of our
company), just skim through __htab_map_lookup_and_delete_batch() and found that
the following code snippet is suspicious:

        /* do not grab the lock unless need it (bucket_cnt > 0). */
        if (locked) {
                ret = htab_lock_bucket(htab, b, batch, &flags);
                if (ret)
                        goto next_batch;
        }

If htab_lock_bucket() fails, it should reset bucket_cnt to zero, else next_batch
will try to read key_size * bucket_cnt bytes from keys and may lead to
out-of-bound read. Will try to get the reproducer and to ensure or pinpoint the
root cause.

> CPU: 1 PID: 8357 Comm: syz-executor382 Not tainted
> 5.19.0-13666-gffcf9c5700e4-dirty #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x57/0x7d lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0xe5/0x66d mm/kasan/report.c:433
>  kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x13b/0x190 mm/kasan/generic.c:189
>  instrument_copy_to_user include/linux/instrumented.h:118 [inline]
>  _copy_to_user lib/usercopy.c:32 [inline]
>  _copy_to_user+0x9c/0xc0 lib/usercopy.c:26
>  copy_to_user include/linux/uaccess.h:160 [inline]
>  __htab_map_lookup_and_delete_batch+0x1169/0x1cf0 kernel/bpf/hashtab.c:1809
>  bpf_map_do_batch+0x2d6/0x590 kernel/bpf/syscall.c:4498
>  __sys_bpf+0x1193/0x48b0 kernel/bpf/syscall.c:5014
>  __do_sys_bpf kernel/bpf/syscall.c:5058 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5056 [inline]
>  __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5056
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f797e7e5b9d
> Code: c3 e8 97 2a 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f797e76ad78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f797e87a2d0 RCX: 00007f797e7e5b9d
> RDX: 0000000000000038 RSI: 0000000020000680 RDI: 0000000000000019
> RBP: 00007f797e84700c R08: 00007f797e76b700 R09: 0000000000000000
> R10: 00007f797e76b700 R11: 0000000000000246 R12: 00007f797e87a2d8
> R13: 00007f797e87a2dc R14: 00000000200014c0 R15: 00007f797e846008
>  </TASK>
>
> Allocated by task 8357:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:437 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:516 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:475 [inline]
>  __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
>  kasan_kmalloc include/linux/kasan.h:234 [inline]
>  __kmalloc_node+0x1e9/0x360 mm/slub.c:4472
>  kvmalloc include/linux/slab.h:750 [inline]
>  kvmalloc_array include/linux/slab.h:768 [inline]
>  __htab_map_lookup_and_delete_batch+0x538/0x1cf0 kernel/bpf/hashtab.c:1680
>  bpf_map_do_batch+0x2d6/0x590 kernel/bpf/syscall.c:4498
>  __sys_bpf+0x1193/0x48b0 kernel/bpf/syscall.c:5014
>  __do_sys_bpf kernel/bpf/syscall.c:5058 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5056 [inline]
>  __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5056
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff8881055c0100
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 0 bytes inside of
>  64-byte region [ffff8881055c0100, ffff8881055c0140)
>
> The buggy address belongs to the physical page:
> page:ffffea0004157000 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x1055c0
> flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
> raw: 057ff00000000200 0000000000000000 dead000000000122 ffff888010c42640
> raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6756, tgid 6756
> (syz-executor382), ts 131529364832, free_ts 131498233118
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook mm/page_alloc.c:2525 [inline]
>  prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
>  get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
>  __alloc_pages+0x321/0x710 mm/page_alloc.c:5515
>  alloc_slab_page mm/slub.c:1824 [inline]
>  allocate_slab mm/slub.c:1969 [inline]
>  new_slab+0x246/0x3a0 mm/slub.c:2029
>  ___slab_alloc+0xa50/0x1060 mm/slub.c:3031
>  __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
>  slab_alloc_node mm/slub.c:3209 [inline]
>  __kmalloc_node+0x2ed/0x360 mm/slub.c:4468
>  kmalloc_node include/linux/slab.h:623 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3012 [inline]
>  __vmalloc_node_range+0x30a/0xf70 mm/vmalloc.c:3196
>  alloc_thread_stack_node kernel/fork.c:312 [inline]
>  dup_task_struct kernel/fork.c:977 [inline]
>  copy_process+0x4069/0x6660 kernel/fork.c:2087
>  kernel_clone+0xba/0xba0 kernel/fork.c:2673
>  __do_sys_clone+0xa1/0xe0 kernel/fork.c:2807
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1449 [inline]
>  free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
>  free_unref_page_prepare mm/page_alloc.c:3380 [inline]
>  free_unref_page+0x19/0x410 mm/page_alloc.c:3476
>  __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
>  __tlb_remove_table_free mm/mmu_gather.c:114 [inline]
>  tlb_remove_table_rcu+0x6e/0xb0 mm/mmu_gather.c:169
>  rcu_do_batch kernel/rcu/tree.c:2245 [inline]
>  rcu_core+0x785/0x1720 kernel/rcu/tree.c:2505
>  __do_softirq+0x1d0/0x908 kernel/softirq.c:571
>
> Memory state around the buggy address:
>  ffff8881055c0000: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff8881055c0080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>> ffff8881055c0100: 00 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc
>                                   ^
>  ffff8881055c0180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8881055c0200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> .

