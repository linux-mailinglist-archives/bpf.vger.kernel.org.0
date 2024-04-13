Return-Path: <bpf+bounces-26706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F38A3CBA
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC0A1F21FB0
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0D3D56D;
	Sat, 13 Apr 2024 12:45:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289E17588
	for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713012338; cv=none; b=k8Rq0R5g87rti3giXQNny5iTETIRNogpJKIIWSDPD4j5+/VFsCcXkimPOiPe4WXGP03frtWkJC/RnjBnsma+a/xb9W7BOe+XRpwXO/ayxTbhLyLcMrvXLi6uncR3UIcL0m0oF7yL5u2pDPcuzQZBGkeBL+vaJ9UKa6IwRXUuImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713012338; c=relaxed/simple;
	bh=2VfjC1Jh70C5CRfeYOzzcvjfqjgDDeA5zooKPXsLlPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=enj2JNm+W984ZYhfk1nCtujziUo3U8fP2Iw1duSEunl9b4/yuxreUKndqM8PeCXzdHE5iM15WBGVLQc8a6Z98VEmVR7V0g1V47JegWGaJhhHJB+4ySgWah3NsMgd63OGqIM3dYD8GJU/kC2g2x8dsxOv/yf1gYAm5agHN8trxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d096c4d663so224733539f.2
        for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 05:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713012336; x=1713617136;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwsdBCZ0wFnlnmfXUwnR0R9ZcbDlEKuSRdRUY8bB3P4=;
        b=ZMZAHij5K0T4Bct/1QrrQmZAdhsoWlY9r4P7EEgbiK68zwpzq7J7E0RtuuBoBwdxpj
         m9L95czVP8wwg/RmKDH9oTcve70gNDmO6ekrtuYq0aS4ORjUApmyKosVPTQR/a2pagBn
         CcjWLeFlX/iI2Scx1lupRCzBftIaLFKoTEwFWsROvVcsOeUlO4xBrFvaPZW8OnoCTtOc
         Ygj5F3LIzOqpkQSw7PRBPMkgHqGNzJPpXsOm+kowJwv7u8Ao0QzEE70f8Vap1ZKlScR9
         nw4jZZXvm9MzAh/yE8LJW7NpskUjenM6DnMCFEgpLsAa+jh591UN/xF6ba4deYzJXOgb
         YZmw==
X-Forwarded-Encrypted: i=1; AJvYcCWYUAgMnFKzzqGnt9dJjfU3VvblxDrlJ1STR0B/d68u4w2LuRCyJcpgtlYrH03sB893lD9tvH7eEn1hNNysw9LHm/VO
X-Gm-Message-State: AOJu0YykPAapd955+kF0sySX/kaH7QpijIQ1jz1/vWRFkLWrlpzTc5MF
	aVvqvv5aixYfT6vWDsByZVR5dHq7C54CGCE2UEUKd7vdjNYaSoP4xV1hcdQp4XvWE3dpPYeJSyL
	mHDfRqG49ENoua+Y01r2gXZBG9XmoHBtAglk3cpC4WZV0MYJWsLFnWrk=
X-Google-Smtp-Source: AGHT+IHiFEQAgefixNHwhaLq0jpMmFfA52hQ+CoDXfzAeHpZjP6Ma4cwxpwjQBAVC4m7RvmgbHQLs6yeXEBjJ36RfMPAv2os/iY7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:36a:a6c4:b4c3 with SMTP id
 dt12-20020a056e021fec00b0036aa6c4b4c3mr381080ilb.0.1713012335791; Sat, 13 Apr
 2024 05:45:35 -0700 (PDT)
Date: Sat, 13 Apr 2024 05:45:35 -0700
In-Reply-To: <00000000000092c8da06154be4f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c561210615f9c3c7@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free
From: syzbot <syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com>
To: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	nogikh@google.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126eafeb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=b3851d693eb8edda5c7d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131da293180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc649744d68c/disk-9ed46da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11eab7b9945d/vmlinux-9ed46da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7885afd198d/bzImage-9ed46da1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3065
Read of size 8 at addr ffff88802c1ba010 by task syz-executor.1/10495

CPU: 0 PID: 10495 Comm: syz-executor.1 Not tainted 6.9.0-rc3-next-20240412-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3065
 bpf_link_put_direct kernel/bpf/syscall.c:3093 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3100
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53a7e7cd5a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffcb2194010 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 000000000000000f RCX: 00007f53a7e7cd5a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000e
RBP: 0000000000000032 R08: 0000001b33560000 R09: 00007f53a7fac05c
R10: 00007ffcb2194160 R11: 0000000000000293 R12: 00007f53a7a029d8
R13: ffffffffffffffff R14: 00007f53a7a00000 R15: 000000000003fe92
 </TASK>

Allocated by task 10497:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2b0 mm/slub.c:4109
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:775 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3845
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3892
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5706
 __do_sys_bpf kernel/bpf/syscall.c:5771 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5769 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5769
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kfree+0x149/0x350 mm/slub.c:4514
 rcu_do_batch kernel/rcu/tree.c:2565 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2839
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3102 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3206
 bpf_link_free+0x1f8/0x2d0 kernel/bpf/syscall.c:3063
 bpf_link_put_direct kernel/bpf/syscall.c:3093 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3100
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802c1ba000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 16 bytes inside of
 freed 128-byte region [ffff88802c1ba000, ffff88802c1ba080)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c1ba
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff8880150418c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5104, tgid 1807949953 (udevd), ts 5104, free_ts 194993482569
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1474
 prep_new_page mm/page_alloc.c:1482 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3444
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2259
 allocate_slab+0x5a/0x2e0 mm/slub.c:2422
 new_slab mm/slub.c:2475 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
 __slab_alloc+0x58/0xa0 mm/slub.c:3714
 __slab_alloc_node mm/slub.c:3767 [inline]
 slab_alloc_node mm/slub.c:3945 [inline]
 kmalloc_trace_noprof+0x1d5/0x2b0 mm/slub.c:4104
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:775 [inline]
 kernfs_get_open_node fs/kernfs/file.c:525 [inline]
 kernfs_fop_open+0x800/0xcd0 fs/kernfs/file.c:693
 do_dentry_open+0x907/0x15f0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5198 tgid 5198 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2607
 vfree+0x186/0x2e0 mm/vmalloc.c:3338
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3259
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88802c1b9f00: fa fb fb fb fb fb fb fb fb fb fb fc fc fc fc fa
 ffff88802c1b9f80: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
>ffff88802c1ba000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88802c1ba080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802c1ba100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

