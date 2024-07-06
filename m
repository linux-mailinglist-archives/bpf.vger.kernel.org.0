Return-Path: <bpf+bounces-33987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE960929142
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 08:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16A01C21702
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657E1BC44;
	Sat,  6 Jul 2024 06:21:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932AC8F3
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246886; cv=none; b=qg8ETiwxBrIoUHsZti4MMMPBDzeG0OqxSjW/Px+4RlCRgvpwYSZRVfD9ks+hRlM9dl58rtf1xHUiY8ecajjWF99siYOg1il4ITKNb1xYa8TqJ/KSzbNmgOLQ4hGhcsrKngY+SWZonTCX8yOP4dqqGAGQusrKlTt/XBCHp+dIKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246886; c=relaxed/simple;
	bh=i+YznmfnmStVata3WBXb1cgfkdx0doyoSeWA+buQSsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j1YiZdHwAkt2rT1Q/LQfke+r7Q+nAvYI4Ji7b8ysrtYoaihBVaCNDSqgK1S7OvtyXAb8JSRNvAGY8j3pUCHuqFeMA6ffy5tR+7jNTbyOFb+KlvF8WqZGt4ThGLPvBVu/ojFu1seh7KgIwkiRItbWMfHhv7GlhHtMrgUM1RkuHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f657f37e96so289985439f.0
        for <bpf@vger.kernel.org>; Fri, 05 Jul 2024 23:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720246884; x=1720851684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvF3U4FNYQ7TdKEZe0QBJjv+VB2dCsN7syqEZ5rBFqs=;
        b=LU7j95tj548DoAOzIOR6jZ93FQPmFtVBbUfX1D6Vcx/UZ4QiBdVTOcOvng/GwTmfDv
         vLgAUpvddGHoM0Ed5EbAVKYJq0TGnZheNn1q+X5y4mdw08fzKeRzfE2BAAQoyX6AqkN3
         K4TKV+YHVCORrhmeSHXSzLQpsNn9b9t+Wgy81dRpRuTQnSd4Eh7DyvjKkgv4Tioatrb+
         xHY9kzXvEtNbYnVl2V3+5Wy5LKKusx+v/2/NXiHvBRXKAalLeIgYR1TzG/uzA28sKbTO
         BiLSj4MfrAiIN8CjL/V19wgNEX/c+P3amTnJRuKlfV1vQQKPXViBVPPtNyB/dSQObGA/
         oaIg==
X-Forwarded-Encrypted: i=1; AJvYcCXnMyP1HMv36HfdsG3c9lrjCOU45FNye4hjnxuPy+TvxP8fehQgoQKlb7QMkVWCE/cQSkh2TI4G7FXf7UwUroPWldDj
X-Gm-Message-State: AOJu0Yx3FGS1WAwY6EZVEgpv5FMzyzrj9LJsq1FgHND02ngbjd+JAucg
	/ZlhdPKaF7J2WQ2oyonF7aXuR0a/KlreklbVsdxi8ksmu4IZ0HWhPpVlVlGJKaEGWWLavzfyKPO
	TBQfYFqeQhkXCMnxIwZeNmwzOTQDnRBveBQRd2SEc042z0BoI8G7oHAw=
X-Google-Smtp-Source: AGHT+IFpWxQJpIFnmxzXWBs15CP8b1VBO0TV0e8rpooFaScrwB1N3bvOKJLR8nS7xeX/LFMD/9sE3u91wfQeExUYsXz2heCWk7Oc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd3:b0:7f6:8521:fb2f with SMTP id
 ca18e2360f4ac-7f68521fcdcmr20268139f.1.1720246884262; Fri, 05 Jul 2024
 23:21:24 -0700 (PDT)
Date: Fri, 05 Jul 2024 23:21:24 -0700
In-Reply-To: <000000000000adb970061c354f06@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000767898061c8e30e8@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_redirect
From: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, patchwork-bot@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1228a3b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12512bc1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fe346e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 1 UID: 0 PID: 5101 Comm: syz-executor153 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:dev_map_redirect+0x65/0x6a0 kernel/bpf/devmap.c:1015
Code: 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 83 b3 3d 00 4c 8b 2b 4d 8d 7d 38 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 03 84 c0 0f 85 6e 04 00 00 41 8b 2f 89 ee 83 e6 02 31 ff
RSP: 0018:ffffc9000355f6e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: ffff888018b78000
RDX: 0000000000000000 RSI: 000000000355f738 RDI: ffff8880183a2800
RBP: dffffc0000000000 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff888018b78000 R12: 000000000355f738
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000038
FS:  000055557cbd4380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000078ac6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_ec9efaa32d58ce69+0x56/0x5a
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_prog_run_generic_xdp+0x679/0x14c0 net/core/dev.c:4962
 netif_receive_generic_xdp net/core/dev.c:5075 [inline]
 do_xdp_generic+0x673/0xb90 net/core/dev.c:5134
 tun_get_user+0x2805/0x4560 drivers/net/tun.c:1924
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa9a2adcf90
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 31 e1 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffd3cd09788 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa9a2adcf90
RDX: 000000000000fdef RSI: 0000000020000100 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 00007ffd3cd098b8 R09: 00007ffd3cd098b8
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:__bpf_xdp_redirect_map include/linux/filter.h:1699 [inline]
RIP: 0010:dev_map_redirect+0x65/0x6a0 kernel/bpf/devmap.c:1015
Code: 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 83 b3 3d 00 4c 8b 2b 4d 8d 7d 38 4c 89 fb 48 c1 eb 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 03 84 c0 0f 85 6e 04 00 00 41 8b 2f 89 ee 83 e6 02 31 ff
RSP: 0018:ffffc9000355f6e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000007 RCX: ffff888018b78000
RDX: 0000000000000000 RSI: 000000000355f738 RDI: ffff8880183a2800
RBP: dffffc0000000000 R08: 0000000000000007 R09: ffffffff81b5ee2f
R10: 0000000000000004 R11: ffff888018b78000 R12: 000000000355f738
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000038
FS:  000055557cbd4380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000078ac6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   8:	74 08                	je     0x12
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 83 b3 3d 00       	call   0x3db395
  12:	4c 8b 2b             	mov    (%rbx),%r13
  15:	4d 8d 7d 38          	lea    0x38(%r13),%r15
  19:	4c 89 fb             	mov    %r15,%rbx
  1c:	48 c1 eb 03          	shr    $0x3,%rbx
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 03          	movzbl (%rbx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 6e 04 00 00    	jne    0x4a4
  36:	41 8b 2f             	mov    (%r15),%ebp
  39:	89 ee                	mov    %ebp,%esi
  3b:	83 e6 02             	and    $0x2,%esi
  3e:	31 ff                	xor    %edi,%edi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

