Return-Path: <bpf+bounces-57992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437BBAB2CA3
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 02:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3103ADA57
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88D125D6;
	Mon, 12 May 2025 00:16:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6CE3FE7
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747009004; cv=none; b=DPAN29jv4qiuOlZWWzo8STifa4W/hlXJSL0hKPaCXt6AH/7pQbCPPuBgoPUnlolIsH04vhqL6+zz5cRb0zagxDI5wQgcnwWqRQKtELDqS65drjOsQuECifY5/Sul9joJVYIKiVTHhLvIeRVDYnrfzKghYKP/+OfJR6BVADPpY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747009004; c=relaxed/simple;
	bh=xoV09mdiQJSToCePrGZnn9SYnxsl083jo5NzXoR2244=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dEKaqkVPRy6oCVjgChIKc78eSaCZgDhiH2dsPfKdq2L0ahlpKvYydDjZrE0Rrsq4SuHdGEN4bmCHSDWJ3IGUc4nTAPHzXu4R3CQUYTLOneVaWXykGWYuKxeH6z/eaheKgppaxtksoAEqeMiYzhyDtPubn03/8buFAVleRu4RFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b5878a66cso1102481839f.2
        for <bpf@vger.kernel.org>; Sun, 11 May 2025 17:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747009001; x=1747613801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvNDd4D87Qu8SBZrDX1Vdq9qCFaVvE0XZZ5qAOi2pIw=;
        b=RayTWaaeSfsXfvcdlD2j84IKIdim6gBFeAFrxELJYQt6B0F1gjUhjg49KxuHbQLpFh
         6ayMNFa1sjkSxaeqnJegbAPCb+HVJpdyLJIkd04hZnPJ6dkqnhcQ8DB7xsUB1u5Xhxzx
         JkJDpmEstU+LKL4YO2RGBSTCjplj2ATwEufo9qpiIn/0WF+Q/MrJmlUGf0+P3zDCcPzq
         pQrSPbD9hvcKHaACZNi9b0S3EOYEbfEh9VAOa0ui3oyRi46usN0oASgM7kpMtcRuMQkf
         MEYqvTB74j9Bu64VV8C0miVIzoY/WnkZKFrDTcbKbEwRj17SyG9VFhKb3bSqCJLH1U2K
         IPjA==
X-Forwarded-Encrypted: i=1; AJvYcCXEgqZnxB+TjXvYD5cH5Z0wO8XzOuGFshfVcFc98yYtzoyFxe68rbGaULnMi9dAqZ/ABvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwNkx6kzw4GsDXWhlBb4PGF3/3AI5YrTbh7BqqMyeuvvHHvJ+
	O711i8GHqNZbmjo8sGT1ArEGxVlN1o4XhlT0ljGg1Z16bTPAT52Z+IkJyzcluXfvvT9kZZwExyX
	58V/Dmq/JV0EJc9Q4fRqxpd8AdIquAt9bYaFXityNRiuGBlZNk77uMj0=
X-Google-Smtp-Source: AGHT+IE8NHeYIwBO7AS5qW1vcN+PVxIw0m9CJiI4wLq9szZsj+L7gndcKEfJOkwoIeMcUxlDPOlUh+fopj9+g/XNczzSVaz5rJvp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148d:b0:864:a3d0:ddef with SMTP id
 ca18e2360f4ac-86763580dfdmr1341569039f.6.1747008991296; Sun, 11 May 2025
 17:16:31 -0700 (PDT)
Date: Sun, 11 May 2025 17:16:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68213ddf.050a0220.f2294.0045.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in vrealloc_noprof (2)
From: syzbot <syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b1b2bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c351a0f6229e67
dashboard link: https://syzkaller.appspot.com/bug?extid=659fcc0678e5a1193143
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-707df337.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc3944720ea5/vmlinux-707df337.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7bc2f45ae23f/bzImage-707df337.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com

syz.0.0 uses obsolete (PF_INET,SOCK_PACKET)
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x396/0x430 mm/vmalloc.c:4093
Write of size 4064 at addr ffffc9000efa1020 by task syz.0.0/5317

CPU: 0 UID: 0 PID: 5317 Comm: syz.0.0 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x29a/0x2b0 mm/kasan/generic.c:189
 __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
 vrealloc_noprof+0x396/0x430 mm/vmalloc.c:4093
 push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
 do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
 do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
 do_check_main kernel/bpf/verifier.c:22867 [inline]
 bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
 __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f649c58e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f649d4dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f649c7b5fa0 RCX: 00007f649c58e969
RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
RBP: 00007f649c610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f649c7b5fa0 R15: 00007fff542287e8
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000ef81000, ffffc9000efa3000) created by:
 kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x3ffd0 pfn:0x3efe5
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 000000000003ffd0 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2(GFP_HIGHUSER|__GFP_NOWARN), pid 5317, tgid 5316 (syz.0.0), ts 82587533383, free_ts 81110216781
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
 __alloc_pages_slowpath+0x2fe/0xcc0 mm/page_alloc.c:4509
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:4983
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2392
 vm_area_alloc_pages mm/vmalloc.c:3591 [inline]
 __vmalloc_area_node mm/vmalloc.c:3669 [inline]
 __vmalloc_node_range_noprof+0x8fe/0x12c0 mm/vmalloc.c:3844
 __kvmalloc_node_noprof+0x3a0/0x5e0 mm/slub.c:5034
 kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109
 push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
 do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
 do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
 do_check_main kernel/bpf/verifier.c:22867 [inline]
 bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
 __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
page last free pid 82 tgid 82 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 free_unref_folios+0xb81/0x14a0 mm/page_alloc.c:2782
 shrink_folio_list+0x3053/0x4e90 mm/vmscan.c:1552
 evict_folios+0x417b/0x5110 mm/vmscan.c:4698
 try_to_shrink_lruvec+0x705/0x990 mm/vmscan.c:4859
 shrink_one+0x21b/0x7c0 mm/vmscan.c:4904
 shrink_many mm/vmscan.c:4967 [inline]
 lru_gen_shrink_node mm/vmscan.c:5045 [inline]
 shrink_node+0x3139/0x3750 mm/vmscan.c:6016
 kswapd_shrink_node mm/vmscan.c:6867 [inline]
 balance_pgdat mm/vmscan.c:7050 [inline]
 kswapd+0x1675/0x2970 mm/vmscan.c:7315
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffffc9000efa0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000efa0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000efa1000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                               ^
 ffffc9000efa1080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000efa1100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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

