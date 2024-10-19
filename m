Return-Path: <bpf+bounces-42503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA59A4CEA
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BFC1C212E6
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAC01DF72A;
	Sat, 19 Oct 2024 10:51:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667018E76B
	for <bpf@vger.kernel.org>; Sat, 19 Oct 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729335087; cv=none; b=aoorQPJDnj13f7U9T+7m2As9Xiwuv2YfFIw5GbIAk2dyLZ195vhqSzPiFAj8ntBcOwMpCt2Ob3E+OyvW1q3qWa2hW3Gd4afn1uUxaDhIc7SCSXk+5dfnT3qiQJiOQWgsknKb/ihY+r7p1yo/WumKo0w8OWgSmwwHiSs6Wcir7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729335087; c=relaxed/simple;
	bh=cWkl2H2aUkfPQ4f+MVYM3tK2aR35BWP5R4PX9TWtldU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pReLc+Svo5G7ddsk28zTTf6pvpOywXrCE6uX6FrLJ/kY1iN3XBqpwh+jPxwGQjCyDDuXLDF1uxQ4PMNzM4ClqoamYMTF9mvsVbz+SriSup5UW0bDoPFJWpSeq1d3UW4q0nqpU6HVjsKKcgruoo3D7zHjDBpDhZFv+aFuAaFnccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa904b231so313095539f.1
        for <bpf@vger.kernel.org>; Sat, 19 Oct 2024 03:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729335084; x=1729939884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGwjJGj/HWxhCPkzEgvah/3ffvHt6IGVDRr4kOEQlJ8=;
        b=X+69G46q9HcSAfUZf+4v++wvh/ZHjxiBGGA8iawvlGIIncsSntIML2CBqc3TX2w6bM
         TP0/PnMOqclQCR5sS1rI5Cl3bKcoyiQQAlZHL68jki7qIQ00mWD0DHK6sFvpIVJuJoAC
         FNjb1rIMBxY/0t+4fs+nztc+nihMV+qOdujEjnLSqhaYMir3xWpTX6lH3HWOS9oMozQe
         GfG97AqnW7l5CiiPl/dyr9HoGeoC8xeQOyWTWFM5OFpJYJ2ZmFwQTQlHWLGGQbF36GPy
         Y/THM2Jmxn3HHPRYW/wPD73heC0iqvXv0VRChqOgCUzB/7HEAYHuDUMLFF7+n5GdNIe9
         WihA==
X-Forwarded-Encrypted: i=1; AJvYcCVccCwrgr66uUD02T2BpJiupX/CSTzyxd9nVATVW6cYoWPvwIvT+8rw2m0VrVkd10LZSds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+A2bAspxu8izlNMQKnCuqOPJYF2YfkXPzs1wD8BvhSt2+VgE2
	0exV8ILc8XSQg0i8wszwGsak+JpMabk0fjZ7CZM5N5JhzLwNsehBE5m2w28wLJGtaxiruLT19NZ
	HeCHohtI3MxpTq7SH294WIAbL1Uawb7jsyy0jgNDD693B4nmB5gDm1hE=
X-Google-Smtp-Source: AGHT+IECuEt/4ypPW8j/SkvyZW5HGjDJZToorFfYWAynEcrHrdcPs822IU1bprve5s/Ci0ehlFLDn+UW7qGIiPNJVV4m3JB1nd06
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:3a2:aed1:12a6 with SMTP id
 e9e14a558f8ab-3a3f4059d87mr46011525ab.6.1729335083751; Sat, 19 Oct 2024
 03:51:23 -0700 (PDT)
Date: Sat, 19 Oct 2024 03:51:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67138f2b.050a0220.1e4b4d.0026.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in bpf_inode_storage_free
From: syzbot <syzbot+eff9059eb9bb5f59b754@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fa3030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=eff9059eb9bb5f59b754
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e937ef58569a/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1df9880ca4b/bzImage-c964ced7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eff9059eb9bb5f59b754@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (2048) and media sector size (512).
==================================================================
BUG: KASAN: slab-out-of-bounds in bpf_inode_storage_free+0x133/0x300 kernel/bpf/bpf_inode_storage.c:68
Read of size 8 at addr ffff88803db65458 by task syz.0.0/5109

CPU: 0 UID: 0 PID: 5109 Comm: syz.0.0 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bpf_inode_storage_free+0x133/0x300 kernel/bpf/bpf_inode_storage.c:68
 security_inode_free+0xe3/0x1a0 security/security.c:1727
 __destroy_inode+0x2d9/0x670 fs/inode.c:290
 destroy_inode fs/inode.c:313 [inline]
 evict+0x78b/0x9b0 fs/inode.c:756
 ntfs_fill_super+0x40f9/0x4730 fs/ntfs3/super.c:1512
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f901ab7f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f901b952e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f901b952ef0 RCX: 00007f901ab7f79a
RDX: 000000002001f340 RSI: 000000002001f380 RDI: 00007f901b952eb0
RBP: 000000002001f340 R08: 00007f901b952ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000002001f380
R13: 00007f901b952eb0 R14: 000000000001f329 R15: 000000002001f3c0
 </TASK>

Allocated by task 5109:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 lsm_inode_alloc security/security.c:756 [inline]
 security_inode_alloc+0x37/0x310 security/security.c:1692
 inode_init_always_gfp+0x988/0xcd0 fs/inode.c:235
 inode_init_always include/linux/fs.h:3088 [inline]
 alloc_inode+0x9f/0x1a0 fs/inode.c:272
 iget5_locked+0x4a/0xa0 fs/inode.c:1335
 ntfs_iget5+0xc9/0x3870 fs/ntfs3/inode.c:530
 ntfs_fill_super+0x3168/0x4730 fs/ntfs3/super.c:1335
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5109:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 __destroy_inode+0x2d9/0x670 fs/inode.c:290
 destroy_inode fs/inode.c:313 [inline]
 evict+0x78b/0x9b0 fs/inode.c:756
 ntfs_fill_super+0x3366/0x4730 fs/ntfs3/super.c:1363
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803db653f0
 which belongs to the cache lsm_inode_cache of size 80
The buggy address is located 24 bytes to the right of
 allocated 80-byte region [ffff88803db653f0, ffff88803db65440)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3db65
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff8880304073c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5111, tgid 5111 (udevd), ts 82220703988, free_ts 77769752471
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 lsm_inode_alloc security/security.c:756 [inline]
 security_inode_alloc+0x37/0x310 security/security.c:1692
 inode_init_always_gfp+0x988/0xcd0 fs/inode.c:235
 inode_init_always include/linux/fs.h:3088 [inline]
 alloc_inode+0x9f/0x1a0 fs/inode.c:272
 new_inode_pseudo fs/inode.c:1104 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1123
 __shmem_get_inode mm/shmem.c:2806 [inline]
 shmem_get_inode+0x34a/0xd70 mm/shmem.c:2877
 shmem_mknod+0x5f/0x1e0 mm/shmem.c:3573
 shmem_mkdir+0x33/0x70 mm/shmem.c:3634
page last free pid 5104 tgid 5104 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1877
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803db65300: fc fc 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88803db65380: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fa fb
>ffff88803db65400: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
                                                    ^
 ffff88803db65480: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
 ffff88803db65500: fb fb fb fb fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

