Return-Path: <bpf+bounces-35506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0093B0AF
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FC01C2087D
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09724158D64;
	Wed, 24 Jul 2024 11:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF815748D
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821521; cv=none; b=THxaDNinixXqk63Q8INJFKRv8wi2FEcDEnBzTD7WfoDjvAZ8DmIvYeRVcMUauvzu1YyhWVRpn+/k1QWPEZIYhe4CpE9NfAymGgURJR2oRzNGKX8DY5wP/aXuEKTz1fUqf17Z1frYLpnfzII1WYii0mT/wf1XQBOaziNwS3DSQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821521; c=relaxed/simple;
	bh=wb3VlPAZu/8KJHmcJT9f5nyFbxv0j84sk/ugoTpnrUA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bRLegtaui1bZ0FJZO4NtKr9SPBGuxUQapNSVi1DfCNduojZqKqPKaP3/QVcoH6yNzpYgJnJkUt0vphEIanIEL5jUgTi605ODIEcl0ByqXEC8U+wMNyxwQD6iY/UbIham97B+ZZ/k8bZHODNYMaHeuswEHrA2kHkL1sQTC8nC2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso1100942839f.3
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821519; x=1722426319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob0VFukh3Hee8onVi5JuQ10r5B1QmZdqH/VPwHjuR70=;
        b=sfbokWxL29kj8TNxZTcxVT92GpppxYLJnzmEKpPhOR6nF/Oc6tJ2uaoj0cdhz7bNhb
         w6OlD0Lu9iDyrWk8U275g9kHmx8vUrvnFIkaZVuqM98ZqgtvznAmOhR8eGyPy3XLYtHN
         aNJpVQsClvN5y2ku5SnrkQecDH7Q1dxqMPwqTCWfGO81jbYZEV3kRiY9L5dP9oFojxGz
         jCWG4Ih56oboESTkVLm/TTJhqeQIMf0LkESAo8bXhOfVET4UGXAHgRAobnmTqJRMCIoh
         L8cIltLwl7/mwI1pR0VtP9Gq/kOGLfhy7/TzRtiaXn0/NhIAxB3iUJLpRlK3p72OojyS
         GWqw==
X-Forwarded-Encrypted: i=1; AJvYcCUillBYfxv3sdeFW7dF92y3+xG8mHjal5l5koz2eOyci+i1gK+nY1sA5qHZ0wlJKGqVttlsyEhJ70e0troyQDCOxGJ3
X-Gm-Message-State: AOJu0YxKxsePg7vwGAhg6b0dhBQx17/zn1/3Ip8UxaJVRoFqxG7OVTaq
	IHlSS7nty61mDIidAjOjUPAH0QqFKB0QTx7skOtyIDAPSYhxGXdJpITp+jLRUo1Za6RoLGOeRes
	U5QosXSJGP2/gG+PcR/55f4D1CYWV0u/y0I4Q88pVQoHeVE3alqtHbkM=
X-Google-Smtp-Source: AGHT+IH7dm3oj1KL51abMHq9FzXLX639QuSbRtEMAONp+YpvnZJg3TyROuN/DQrLoAGuLxd6Sqkw36kS8Eb6JGv8a3gEyh4NE84u
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39a194fcb1cmr1200105ab.4.1721821519181; Wed, 24 Jul 2024
 04:45:19 -0700 (PDT)
Date: Wed, 24 Jul 2024 04:45:19 -0700
In-Reply-To: <0000000000000f50a4061d8c4d3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000048a4b061dfcd02a@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __cpu_map_flush
From: syzbot <syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ec6ec93f2c1 Add linux-next specific files for 20240724
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e71ca1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83e9d0906fa0e2bd
dashboard link: https://syzkaller.appspot.com/bug?extid=c226757eb784a9da3e8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c0f8e3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151b9919980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0ab2da24b1f/disk-9ec6ec93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da6faf16185f/vmlinux-9ec6ec93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ad900571155/bzImage-9ec6ec93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe3fffb24002e6fe6: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x1ffff92001737f30-0x1ffff92001737f37]
CPU: 1 UID: 0 PID: 11878 Comm: syz-executor412 Not tainted 6.10.0-next-20240724-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 13 8c d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 4d 12 3e 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 2f 12 3e 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010202
RAX: 03ffff24002e6fe6 RBX: 1ffff92001737f30 RCX: ffff888074dc8000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc9000b9bf800
RBP: dffffc0000000000 R08: ffffffff896d3b5a R09: 1ffffffff1f5f375
R10: dffffc0000000000 R11: fffffbfff1f5f376 R12: ffffc9000b9bf800
R13: ffffc9000b9bf820 R14: ffffc9000b9bf800 R15: dffffc0000000000
FS:  0000555592677380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd44da640f0 CR3: 000000001ea68000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:207
Code: 40 d7 03 00 65 8b 15 10 0c 70 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 <83> fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc
RSP: 0018:ffffc9000b9bf8a0 EFLAGS: 00000246
RAX: ffffffff81410dcc RBX: 0000000000000000 RCX: ffff888074dc8000
RDX: 0000000000000000 RSI: ffffffff8b942412 RDI: ffffffff8b942328
RBP: 1ffff92001737f30 R08: ffffffff81410c60 R09: ffffc9000b9bfa70
R10: 0000000000000003 R11: ffffffff817f7030 R12: ffffffff90294810
R13: dffffc0000000000 R14: 1ffff92001737f30 R15: ffffffff90d0fbd4
 unwind_next_frame+0x67c/0x2a00 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 __dentry_kill+0x497/0x630 fs/dcache.c:629
 dput+0x19f/0x2b0 fs/dcache.c:852
 __fput+0x5f8/0x8a0 fs/file_table.c:430
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd44d9ed9c0
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d e1 76 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007fff7a1e95b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fd44d9ed9c0
RDX: 0000000000000e80 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007fff7a1e9600 R08: 00007fff7a1e95e0 R09: 00007fff7a1e95e0
R10: 00007fff7a1e95e0 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 13 8c d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 4d 12 3e 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 2f 12 3e 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010202
RAX: 03ffff24002e6fe6 RBX: 1ffff92001737f30 RCX: ffff888074dc8000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc9000b9bf800
RBP: dffffc0000000000 R08: ffffffff896d3b5a R09: 1ffffffff1f5f375
R10: dffffc0000000000 R11: fffffbfff1f5f376 R12: ffffc9000b9bf800
R13: ffffc9000b9bf820 R14: ffffc9000b9bf800 R15: dffffc0000000000
FS:  0000555592677380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd44da640f0 CR3: 000000001ea68000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 13 8c d6 ff       	call   0xffd68c18
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 4d 12 3e 00       	call   0x3e1268
  1b:	49 8b 1e             	mov    (%r14),%rbx
  1e:	4c 39 f3             	cmp    %r14,%rbx
  21:	74 77                	je     0x9a
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 2f 12 3e 00       	call   0x3e1268
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48 8d 7b c0          	lea    -0x40(%rbx),%rdi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

