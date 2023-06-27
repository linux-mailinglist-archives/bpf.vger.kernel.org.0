Return-Path: <bpf+bounces-3551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B373F91B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022D91C20A9C
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1119171BC;
	Tue, 27 Jun 2023 09:52:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0788481
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 09:52:15 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911835A9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 02:52:00 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-780cc4a0799so269113539f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 02:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859519; x=1690451519;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0tIqaORmJmU7z2UPPlx/oOuuumIv3OuEFInhj266iI=;
        b=LugmqWiSyxF+6kly9PNLWjc88GeUyuzj4jgUNhVakIzpUoawZf/wR1PNUElf8qXCSs
         D+jZdkjd/1Mk/IwqSTsccwY0X7I6sTBQsH3KZOiaAzjeaCfVAf/ris52LGWFlWqVVcSC
         5NOU33jSnSavb0CpXLwBZShJTqfqOGHv7oW0bnMVAHRzwPNbn8cI9ffg946IYfw/RJI+
         8DoVR71hNJdcNVsAt98Kfv6Ai3DKmDQaQc2PqrRf3HG87FKlx8M3ti/83yB2Supp0ijG
         YGh9PnSh/t3x7+LJg+ei7s27N21IjDDemOxAxtIIR6kU+uKgrnC76vyvFbgx3J/ruiW3
         x2rw==
X-Gm-Message-State: AC+VfDxQbgN7ptq5mlONqnBBwoLB0NUbZDVFvlmSmAxKZ8T3UsmDD7mV
	sj1tZeJwgg7DAflL1YLKh24A/iQYxbcYsmGw81Rt7y7vn3g7
X-Google-Smtp-Source: ACHHUZ7T3xmOxKvdS/k/j/oIoEuY5mgCte14Sxig08Mc2pMq9sOCGnE17xOsBYVcNiKIHGga2PKC26RofIyA3MqyOVygW2wD7XvG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:85c6:0:b0:429:bfc:7db5 with SMTP id
 d64-20020a0285c6000000b004290bfc7db5mr2152173jai.5.1687859519364; Tue, 27 Jun
 2023 02:51:59 -0700 (PDT)
Date: Tue, 27 Jun 2023 02:51:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001526c405ff196bc1@google.com>
Subject: [syzbot] [tomoyo?] [bpf?] INFO: rcu detected stall in
 security_file_open (6)
From: syzbot <syzbot+bb11ad7bb33b56ca4d4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    8a28a0b6f1a1 Merge tag 'net-6.4-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1335a9db280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=bb11ad7bb33b56ca4d4b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16841cc0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc6e1f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d02009a9822d/disk-8a28a0b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f33ad4ef1182/vmlinux-8a28a0b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f795a8ae7a8c/bzImage-8a28a0b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb11ad7bb33b56ca4d4b@syzkaller.appspotmail.com

imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (7435 ticks this GP) idle=b9b4/1/0x4000000000000000 softirq=8258/8258 fqs=2193
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:      160      52287         1450   ==> 52450(ms)
rcu: 	(t=10500 jiffies g=3745 q=548 ncpus=2)
CPU: 0 PID: 4453 Comm: udevd Not tainted 6.4.0-rc7-syzkaller-00194-g8a28a0b6f1a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x3c/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 66 8f 51 f7 48 89 ef e8 8e fd 51 f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> ff d2 43 f7 65 8b 05 60 61 ef 75 85 c0 74 0a 5b 5d c3 e8 9c 8c
RSP: 0018:ffffc90000007b18 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff22af18e
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
RBP: ffff888021d68000 R08: 0000000000000001 R09: ffffffff9152bdcf
R10: 0000000000000001 R11: 0000000000094001 R12: ffff888021de9440
R13: ffff88801771d000 R14: dffffc0000000000 R15: ffff88801eaedd00
FS:  00007ff685e95c80(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555b2efca778 CR3: 0000000029bdf000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 dummy_timer+0x1519/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:2002
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_const_cmp2+0x8/0x20 kernel/kcov.c:297
Code: 00 00 f3 0f 1e fa 48 8b 0c 24 40 0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 d6 fe ff ff 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b 0c 24 <0f> b7 d6 0f b7 f7 bf 03 00 00 00 e9 b8 fe ff ff 0f 1f 84 00 00 00
RSP: 0018:ffffc9000311f770 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000044 RCX: ffffffff83d0673a
RDX: ffff88807d6fbb80 RSI: 0000000000000044 RDI: 00000000000000ff
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000094001 R12: ffffc9000311f868
R13: ffff88802ad9cb00 R14: ffff88802ad9cbb0 R15: 0000000000000044
 tomoyo_check_acl+0x31a/0x440 security/tomoyo/domain.c:183
 tomoyo_path_permission security/tomoyo/file.c:586 [inline]
 tomoyo_path_permission+0x1ff/0x3a0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x337/0x3a0 security/tomoyo/file.c:780
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa1/0xc0 security/tomoyo/tomoyo.c:327
 security_file_open+0x49/0xb0 security/security.c:2797
 do_dentry_open+0x575/0x13f0 fs/open.c:907
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff685f609a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff03a42790 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000555b2d993040 RCX: 00007ff685f609a4
RDX: 0000000000080141 RSI: 0000555b2d9760d8 RDI: 00000000ffffff9c
RBP: 0000555b2d9760d8 R08: 00000000ffffffff R09: 0000000000000000
R10: 00000000000001a4 R11: 0000000000000246 R12: 0000000000080141
R13: ffffffffffffffff R14: 00000000ffffffff R15: 00000000ffffffff
 </TASK>
imon 6-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 2-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 4-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 3-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

