Return-Path: <bpf+bounces-35024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB7937020
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB691C21D23
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4E80617;
	Thu, 18 Jul 2024 21:31:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05B7D07F
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338288; cv=none; b=KYjAEYKbN7THaaq5pBIp1TrW/Ap7XUlk12O8b0O309ZHCerRu+4FphNgwkR/CXHEpcArhJcGBjOoi5oU4kBUWxdT9vL96KAhu7FHn5/5k9RqLL50qIQzY75DiSEIPOANryJQjiAtZRVdcElxx3ckOVTyphzl3msB32CymPNn+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338288; c=relaxed/simple;
	bh=lfgnB7p+ysbWfx48oICHCv0nScYSUWQBPp4pTHY9XWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZpOAg2YKgDQ78WiGBdoRZ3Jei+M7nWKM+ypuZd+HfT6KXyZPMiORI9/NLtVAMY1YF1jgcY7pryqhtpSW9pTYv7WhUaOzuJ9T2QRPO+xB1bR0bgEl8Xouuo3QO3TeIES1Vxe4vzql1TLkuNTDlnTJ6s7jwMauZYxSFhAv7GqR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso198988439f.1
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 14:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721338286; x=1721943086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zo8QTXSrAqLno8qBT/oINWD+/xnlnXeqHF+x0BlH0+E=;
        b=PlbLaXSMCeYKJit1WV6sh84hVSgHRfXtcqKVr7EuwSwIeiIosvDSvpwLKVk6NSIBYs
         t0BvUxvxZ2kWqX/rdUVlRQGW/WjRlDNgus2LHTmzx38wGjcPj07X+q/0Or8ZlYEx9fm0
         rjhjWXwA/8z17gmMIcLgpYzUR6LCaWLpE3LVJKPyX79WpCpDOUzf24WbG3Pvjx2c+VzL
         bbJpGopxQdRGKUT02brx6kzka4255JcIRCPJ2awwCf6LiZ0NwFLD9DvsHKM9eb7G+vSv
         lVEjgid7hbGetMMLYsmuSi4t3bwJaCefUobVVH/joo9+CZP/LgT5j8xo+j1nKICzTYcU
         38pw==
X-Forwarded-Encrypted: i=1; AJvYcCWeCL7k3Yt9/n7IW0FapxfOsNnHPQq9kU/7xk/JNO3++3g7j8yuCRlwqSYesNGsQyAltKpvvhJ1vuU6F/UUfBVnfscF
X-Gm-Message-State: AOJu0YzbMr6Bm2256KBJjWfapTKa57zWnccYXN1CmYzV/fE/3x7ggD3a
	iSZYpS4q69ChfQz8hM524fi/5M0qndg83xdZmnlANDBtoPC/EN+6fB61YmJhWVcW6QrtVsvJIQf
	FWAhZ6FN9f+GAhEGhnfwz5mQ/bCc8RlLKgDQr2oAUZEnYsHDW7HGLlTI=
X-Google-Smtp-Source: AGHT+IE9+2/J1akDUbiOUSxXwIAe+jIv2sOE1Mt4LTNngmAtcQ3J1uVr1ADYNv6FQZuUtqsdW7/lENRiojigPrTXCSiflzrpCyzW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-3955523dd99mr5539615ab.1.1721338285734; Thu, 18 Jul 2024
 14:31:25 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f50a4061d8c4d3c@google.com>
Subject: [syzbot] [bpf?] [net?] general protection fault in __cpu_map_flush
From: syzbot <syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1bc554e009e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165f372d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e004fdd6e65e46
dashboard link: https://syzkaller.appspot.com/bug?extid=c226757eb784a9da3e8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eba440b3a1dc/disk-b1bc554e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ef97684b39f/vmlinux-b1bc554e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c465a94c9348/bzImage-b1bc554e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c226757eb784a9da3e8b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe3fffb240028e7c8: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x1ffff92001473e40-0x1ffff92001473e47]
CPU: 0 PID: 5818 Comm: syz.2.162 Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 e3 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 8d c7 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6f c7 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000007bb0 EFLAGS: 00010203
RAX: 03ffff240028e7c8 RBX: 1ffff92001473e44 RCX: ffff888027121e00
RDX: 0000000080000101 RSI: 0000000000000000 RDI: ffffc9000a39f1a0
RBP: dffffc0000000000 R08: ffffffff895d4e8a R09: 1ffffffff1f5a8c5
R10: dffffc0000000000 R11: fffffbfff1f5a8c6 R12: ffffc9000a39f1a0
R13: ffffc9000a39f160 R14: ffffc9000a39f1a0 R15: dffffc0000000000
FS:  00007feb6f7916c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c343cd0 CR3: 000000001ec24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 tun_rx_batched+0x732/0x8f0
 tun_get_user+0x2f84/0x4720 drivers/net/tun.c:2006
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb6e9746df
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007feb6f791010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007feb6eb03f60 RCX: 00007feb6e9746df
RDX: 0000000000000036 RSI: 0000000020000240 RDI: 00000000000000c8
RBP: 00007feb6e9e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000036 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007feb6eb03f60 R15: 00007ffcc6c5e298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 e3 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 8d c7 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 6f c7 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000007bb0 EFLAGS: 00010203
RAX: 03ffff240028e7c8 RBX: 1ffff92001473e44 RCX: ffff888027121e00
RDX: 0000000080000101 RSI: 0000000000000000 RDI: ffffc9000a39f1a0
RBP: dffffc0000000000 R08: ffffffff895d4e8a R09: 1ffffffff1f5a8c5
R10: dffffc0000000000 R11: fffffbfff1f5a8c6 R12: ffffc9000a39f1a0
R13: ffffc9000a39f160 R14: ffffc9000a39f1a0 R15: dffffc0000000000
FS:  00007feb6f7916c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c343cd0 CR3: 000000001ec24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 e3 d9 d6 ff       	call   0xffd6d9e8
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 8d c7 39 00       	call   0x39c7a8
  1b:	49 8b 1e             	mov    (%r14),%rbx
  1e:	4c 39 f3             	cmp    %r14,%rbx
  21:	74 77                	je     0x9a
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 6f c7 39 00       	call   0x39c7a8
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48 8d 7b c0          	lea    -0x40(%rbx),%rdi


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

