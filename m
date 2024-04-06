Return-Path: <bpf+bounces-26085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2A589AB1D
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01461C20C5E
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C0E374D2;
	Sat,  6 Apr 2024 13:44:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D846F34545
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411075; cv=none; b=np6wc9uIb5QqV+ep74KV/77hxZEjYxEUrXgbkJZC/CYQ+8Ik1z80RWhd8MbXa51GkPStBFx2os7AumKDSOEZJX3CtRQ4Ug8idR4E4OaYLYF5neCROxrHTOPgqvsKQQxD9znr4KV/1ahmSlnTkIh9RNYawH2asklLUMQ0YCAIVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411075; c=relaxed/simple;
	bh=Y0I5OOiYLrisb9MHjIy5W/BnEWOKA7BhGwsnPl6CA8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fDZKqOtiLWADV1PljFYjobLMVqAABGaqJCf8BEtUOtCTtQj/bnjBwifNI3yYEb9gitTKTBS6GAvXhuyICETeo3qtqZldgDFfax3GgYMz6ATJWbHnAu47Jf7jw30v3NtS7WHP5q3fFu3+g+C50WpfxMKBzB7CsCwDJrUxXptRo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so329763539f.1
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 06:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712411073; x=1713015873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4q0SLtk19wfhTyOo/Bn7vTE4bJX1NRQ4iTKl5rE20uQ=;
        b=vy2tY6wpmVfYe4vmlnoMs8hlghIfGj0cmZXXUx5fxZ3IES6e6MxbMDm0W/bPlP0kQU
         6/0I5WCWUFhv4oXt9XzUTGloeXX5z7WU8ppxh5p/LpXB7yUaw2eBgOe5UjfMRboICw38
         7M9uGg5oV364VFOFlnzYN8/cZ2gBPsjwo6KViuE5EqqMiu7iEMkbEmrMvleh2kOXuBbD
         G6eJad3XlIoNQWPoj8GzZIBkBbifMLIm/TBI/4ueC+B+UPUy7TSbekHcnouFWq/h9jHA
         jvPW31ZSksWbHZPj6UnXDTvZhw0F9NS15LSPf9pZI1i3jLrY0nLgILJ1aAOeflSiDaAN
         H5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUE8c/61RAYOxOsGc6PQ7lxSqz9x88oNfYD6Onx3HvU+R58GDg8rnr0EtBC4lCj8yeJA+TWEGXX59tj7RweHadP2yJc
X-Gm-Message-State: AOJu0YwCLEC1t9TWl/H8/wz1xPAdFDHk7Oadk98X6qtun6isQ1T2Xbzs
	Ss1U9QBaaXH9v/K3SBF6jgQWJQcHlCGztlDu3Vos4+XhKtYhZx5QrSr8p7xTKNEdaJZKAzVrHyx
	8yZLjqmRtm+aHEBXuhzEXsJ5mP2GomaTliCEiNfHMcNo3sezWlPaj5Rw=
X-Google-Smtp-Source: AGHT+IHwFFRTUFT4GCJ1uM+6937cBPAwnvNrp8mwKPvygIA2rlZVjp9yqDq0OP+TpMlttf+XDsP7rtsT/+9dzZlFFO41D6k5aZ7U
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891c:b0:47d:6a52:4efa with SMTP id
 jc28-20020a056638891c00b0047d6a524efamr285122jab.5.1712411073146; Sat, 06 Apr
 2024 06:44:33 -0700 (PDT)
Date: Sat, 06 Apr 2024 06:44:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b97fba06156dc57b@google.com>
Subject: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
From: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=148ad855180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in jhash2 include/linux/jhash.h:128 [inline]
BUG: KASAN: stack-out-of-bounds in hash+0x1bf/0x410 kernel/bpf/bloom_filter.c:29
Read of size 4 at addr ffffc900039f7c00 by task syz-executor297/5079

CPU: 0 PID: 5079 Comm: syz-executor297 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 jhash2 include/linux/jhash.h:128 [inline]
 hash+0x1bf/0x410 kernel/bpf/bloom_filter.c:29
 bloom_map_peek_elem+0xb2/0x1b0 kernel/bpf/bloom_filter.c:43
 bpf_prog_00798911c748094f+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
 __traceiter_ext4_drop_inode+0x76/0xd0 include/trace/events/ext4.h:265
 trace_ext4_drop_inode include/trace/events/ext4.h:265 [inline]
 ext4_drop_inode+0x20a/0x270 fs/ext4/super.c:1450
 iput_final fs/inode.c:1711 [inline]
 iput+0x45e/0x900 fs/inode.c:1767
 d_delete_notify include/linux/fsnotify.h:301 [inline]
 vfs_rmdir+0x38f/0x4c0 fs/namei.c:4220
 do_rmdir+0x3b5/0x580 fs/namei.c:4266
 __do_sys_rmdir fs/namei.c:4285 [inline]
 __se_sys_rmdir fs/namei.c:4283 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4283
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd25730cfb7
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff78ca7198 EFLAGS: 00000207
 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd25730cfb7
RDX: fffffffffffff000 RSI: 0000000000000000 RDI: 00007fff78ca82c0
RBP: 0000000000000065 R08: 0000555571b9a73b R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000207 R12: 00007fff78ca82c0
R13: 0000555571b9a6c0 R14: 00007fff78ca82c0 R15: 0000000000000001
 </TASK>

The buggy address belongs to stack of task syz-executor297/5079
 and is located at offset 0 in frame:
 bpf_trace_run2+0x0/0x420

This frame has 1 object:
 [32, 48) 'args'

The buggy address belongs to the virtual mapping at
 [ffffc900039f0000, ffffc900039f9000) created by:
 copy_process+0x5d1/0x3df0 kernel/fork.c:2219

The buggy address belongs to the physical page:
page:ffffea00007f36c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fcdb
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5077, tgid 5077 (syz-executor297), ts 73887639293, free_ts 73091924927
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
 __do_sys_clone kernel/fork.c:2939 [inline]
 __se_sys_clone kernel/fork.c:2923 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2923
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 5072 tgid 5072 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xb9/0x3d0 kernel/fork.c:919
 exec_mmap+0x69d/0x730 fs/exec.c:1051
 begin_new_exec+0x119b/0x1ce0 fs/exec.c:1309
 load_elf_binary+0x961/0x2590 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1777 [inline]
 exec_binprm fs/exec.c:1819 [inline]
 bprm_execve+0xaf8/0x1790 fs/exec.c:1871
 do_execveat_common+0x553/0x700 fs/exec.c:1978
 do_execve fs/exec.c:2052 [inline]
 __do_sys_execve fs/exec.c:2128 [inline]
 __se_sys_execve fs/exec.c:2123 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2123
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffffc900039f7b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900039f7b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900039f7c00: f1 f1 f1 f1 00 00 f3 f3 00 00 00 00 00 00 00 00
                   ^
 ffffc900039f7c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900039f7d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

