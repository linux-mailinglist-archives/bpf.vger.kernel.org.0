Return-Path: <bpf+bounces-13349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D77D8848
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 20:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A211C20F80
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AF2F51A;
	Thu, 26 Oct 2023 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830403AC19
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 18:32:31 +0000 (UTC)
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866901AA
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:32:26 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1e9b6561650so1450940fac.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345146; x=1698949946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uH0iaPQL/qY+pxogylBAOj8akK6lTqnPteM1oOd1ZeE=;
        b=hueT1Mg1atYwb2TnqTdTGPssDFmT78JncgAnzkwzMB8K18qn4ZElTm6fMLqEbHDfUC
         0QOIIf4LFwjXa/D22aRV6HeOMNrt7LPaNEG5Wnih4OeyqQXwFiIEzTN7ugZKu2k4M79L
         HtdEy1eeS+cubWU302Ot0jyxsp/nHoDHXfYtEI5w7wSDIDtqADrFlkbzkLUIq3YqGZMD
         6oDTBhpQRQGH4vEKQAeG2VyipiHbw72RbdzHNHdrUQrVZLc0PyTSRJvdvLkuf7a6mbb8
         w2jn4cPyg5ivpGCgDhdS2UjoDz6yIFjt3KjmibOmd6mSToiJvRf1lQWhLOebujMwuMA/
         QrDw==
X-Gm-Message-State: AOJu0YxS+J3DQyZA0Ag3ujGyyl1g1waGvBp98D4+svWV6jFQLPA37jJo
	NO9XUCk9rYChoY5RE6d895hSq1B2PfGrUXC+jyMBMlf6KKqk
X-Google-Smtp-Source: AGHT+IG0IozWYG8xiBxwgrSIIItH3/pnmPY/Mdpl4/1kn9EY9N/kPmT4/H3gH1Pl0OxbqgaTi6lH3J+eYvR4I02eqssZUwudUZ76
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1cf:b0:1e9:bebf:3813 with SMTP id
 n15-20020a05687001cf00b001e9bebf3813mr208395oad.9.1698345145893; Thu, 26 Oct
 2023 11:32:25 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000208dc20608a2cbb4@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_msg_recvmsg
From: syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cf4bea77ab6 Merge tag 'for-6.6-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b76415680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4436b383d761e86
dashboard link: https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1780cabd680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157c04fe680000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-7cf4bea7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8097f65801fe/vmlinux-7cf4bea7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1824f0c42bd6/Image-7cf4bea7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000097c38006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  Access size = 8 byte(s)
  SSE = 0, SRT = 3
  SF = 1, AR = 0
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000046851000
[0000000000000000] pgd=0800000047e00003, p4d=0800000047e00003, pud=080000004684b003, pmd=0000000000000000
Internal error: Oops: 0000000097c38006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3098 Comm: syz-executor448 Not tainted 6.6.0-rc6-syzkaller-00045-g7cf4bea77ab6 #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : page_kasan_tag include/linux/mm.h:1801 [inline]
pc : lowmem_page_address include/linux/mm.h:2172 [inline]
pc : kmap_local_page include/linux/highmem-internal.h:185 [inline]
pc : copy_page_to_iter+0xb0/0x150 lib/iov_iter.c:479
lr : sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
sp : ffff800082b43940
x29: ffff800082b43940 x28: 0000000000000000 x27: fdff00000526c000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000040000000000 x21: ffff000000000000
x20: 0000000000001000 x19: ffff800082b43d50 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffdf150998
x14: 000000000000012a x13: 000000000000012a x12: 0000000000000002
x11: 0000000000000001 x10: b5bbc95fda8a2138 x9 : 9908e50d67e0cf7a
x8 : f6ff000004f48f88 x7 : 0000000000000000 x6 : f9ff000004e6ed40
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff800082b43d50
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 arch_static_branch_jump arch/arm64/include/asm/jump_label.h:38 [inline]
 kasan_enabled include/linux/kasan-enabled.h:13 [inline]
 page_kasan_tag include/linux/mm.h:1800 [inline]
 lowmem_page_address include/linux/mm.h:2172 [inline]
 kmap_local_page include/linux/highmem-internal.h:185 [inline]
 copy_page_to_iter+0xb0/0x150 lib/iov_iter.c:479
 sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
 unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline]
 unix_bpf_recvmsg+0x13c/0x4f0 net/unix/unix_bpf.c:50
 unix_dgram_recvmsg+0x30/0x4c net/unix/af_unix.c:2457
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg net/socket.c:1066 [inline]
 sock_recvmsg net/socket.c:1062 [inline]
 ____sys_recvmsg+0x1d0/0x268 net/socket.c:2777
 ___sys_recvmsg+0x90/0xe8 net/socket.c:2819
 do_recvmmsg+0xc8/0x2f4 net/socket.c:2913
 __sys_recvmmsg net/socket.c:2992 [inline]
 __do_sys_recvmmsg net/socket.c:3015 [inline]
 __se_sys_recvmmsg net/socket.c:3008 [inline]
 __arm64_sys_recvmmsg+0xd0/0xec net/socket.c:3008
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x40/0x114 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
Code: 8b160320 d346fc00 8b0032a0 d503201f (f9400323) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b160320 	add	x0, x25, x22
   4:	d346fc00 	lsr	x0, x0, #6
   8:	8b0032a0 	add	x0, x21, x0, lsl #12
   c:	d503201f 	nop
* 10:	f9400323 	ldr	x3, [x25] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

