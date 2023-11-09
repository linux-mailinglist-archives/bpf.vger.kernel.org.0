Return-Path: <bpf+bounces-14548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B37E630F
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 06:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739EDB20CB3
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 05:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F46D38;
	Thu,  9 Nov 2023 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF39D268
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 05:10:28 +0000 (UTC)
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD57268E
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 21:10:27 -0800 (PST)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5bdd8eee498so371122a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 21:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699506627; x=1700111427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koDY5nkE+C1QA/cCqAnI5lAMsqxL+edqWn7g/LOX99g=;
        b=PjVKWIZgd6Laju5DLl+aWYMp85namb4H5YWRUrzClwEi4OkMDTJiVP6FqQ9pZCy1ma
         5+S1vKq9fLtwIw+W2f+CQM7ZG9+wtlTZyRMKrdxCxHOFrRS00WpQVVc7A34OV0li8PFd
         Z4Gw6IVb8Y3/shdpyUzPGMy5Zs2qHfUYuW+zEn3U23NhwtHkAuqPzzqUmoh/4KKMAfvU
         cVKU/b925Rn/o2bN+ZZH1pLeUB9asMcfXEyoTp4xnNP3JzYGqkK+fQ9NWcEF5exdYmRu
         w5k6ECeIlKgUvcnzA3jBEP57YNyr15tnEP7uL2DphDN98oThXTjCGx2GG8E6E6qUsscE
         tKFA==
X-Gm-Message-State: AOJu0Yyxi0+KEEv/eqVvfZDE1ehTXVFgYyTgV4OAFzP3KEkSXQEY4VBH
	L7o69r63XisQ1melnEtr4hDc2OIzeqqDv046ebSRmci72kLQ
X-Google-Smtp-Source: AGHT+IFhKhys6yM4GBn2EB+zsXnPnwQ/HhZeI/I7NGl7Th+7gbNT0vSwQVc9fcSM0Su3ZnKYFJugVIxpHoCsQk5gKNDbS4Z8xnL6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:5263:0:b0:5bd:d60d:f60e with SMTP id
 s35-20020a635263000000b005bdd60df60emr171366pgl.8.1699506627304; Wed, 08 Nov
 2023 21:10:27 -0800 (PST)
Date: Wed, 08 Nov 2023 21:10:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d078d30609b138ba@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_bpf
From: syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=158c647b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=44c2416196b7c607f226
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104da6eb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14df3787680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
Unable to handle kernel paging request at virtual address dfff800000000003
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000003] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6085 Comm: syz-executor153 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nsim_setup_prog_hw_checks drivers/net/netdevsim/bpf.c:320 [inline]
pc : nsim_bpf+0x1e0/0xae0 drivers/net/netdevsim/bpf.c:562
lr : nsim_bpf+0x8c/0xae0 drivers/net/netdevsim/bpf.c:554
sp : ffff800096c67790
x29: ffff800096c677a0 x28: dfff800000000000 x27: ffff700012d8cf00
x26: dfff800000000000 x25: ffff800096c67a00 x24: 0000000000000008
x23: ffff800096c67820 x22: 0000000000000018 x21: ffff800096c67820
x20: ffff0000d3834cc0 x19: ffff0000d3834000 x18: ffff800096c67580
x17: ffff8000805c1258 x16: ffff80008030c738 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000003
x11: ffff0000d4ab3780 x10: 00000000000000bc x9 : ffff800085ce8bf0
x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800092dee000 x4 : 0000000000000000 x3 : ffff80008030c754
x2 : 0000000000000000 x1 : ffff80009001ef50 x0 : 0000000000000001
Call trace:
 nsim_setup_prog_hw_checks drivers/net/netdevsim/bpf.c:320 [inline]
 nsim_bpf+0x1e0/0xae0 drivers/net/netdevsim/bpf.c:562
 dev_xdp_install+0x124/0x2f0 net/core/dev.c:9199
 dev_xdp_attach+0xa4c/0xcc8 net/core/dev.c:9351
 dev_xdp_attach_link net/core/dev.c:9370 [inline]
 bpf_xdp_link_attach+0x300/0x710 net/core/dev.c:9540
 link_create+0x2c0/0x68c kernel/bpf/syscall.c:4954
 __sys_bpf+0x4d4/0x5dc kernel/bpf/syscall.c:5414
 __do_sys_bpf kernel/bpf/syscall.c:5448 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5446 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5446
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: 96b3720d f94002c8 91006116 d343fec8 (387a6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	96b3720d 	bl	0xfffffffffacdc834
   4:	f94002c8 	ldr	x8, [x22]
   8:	91006116 	add	x22, x8, #0x18
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction


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

