Return-Path: <bpf+bounces-33555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A491EB4E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC735B215C6
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15D172BA6;
	Mon,  1 Jul 2024 23:19:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9485626
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719875964; cv=none; b=Ktw/Y/euxLBo3BGzISo3yfVoR+/szVbeNm883/Pr2qEGzqSVz956DujpqWRc4F3tEf0JzpPywHdhUMBSuYbI3uQI9Rv7l/xK1G/tEC62pzlZvHLkDfaVKwQOIqTU3CAyYHvK9lHuPJ27ZqVMeOWvh4zuDkoUfG9Db+w9c6ol+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719875964; c=relaxed/simple;
	bh=Nn4wl21piTV59fKP9uWtPQ4iQsG/oANAJVXF/KxzmT0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OVuvcpV9ERfMUBsES4jqrg9N3OdQuoCPow0gZitrAroib7FXw49861/9vmggE3fPIuV9wQReaK2LJwiFfHfQcjMUzGlGpb0ErRtvknRF83Pj0lQ+8XBKHolieC8hHQApZ+bC82wdTls2RyXZF7H9TzUMQL0dcIOfUEWJj9+JVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f6200ad270so378135539f.0
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 16:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719875962; x=1720480762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HrcRx6Tfxw+w89glV2DY2z2LYuzg69csFaa4GorFmY=;
        b=mmFMNB/Im0IEk4CABFootGcEghriV9Z4EIC/oE8gvQW/ZKWHLHG3RXU03QkjtfMKC+
         c50Le0hxsKaYf+Clbr7aT4vTnkl3Z3vHF1Zpoqtabt6KzBM0CgyzWYNX1EDy5/jgVrXW
         LQO+W/3+rI7Qmh0aG2cfBgh35eMt2rDJW1deUtKr6p6jFBQqPESvevwEgu0kYrR3HSvF
         L+zfm0yqQYKiu/k/dF8L9oFFaFoAHB8x9ZuuhyPXrTIAsldZPZfE8liGjW9MVgydEmht
         xGPjG0RGgv/k8HzVzBa5/vToZghszhN0TNeQZ+dwBKGd06tI9eJIt2o5LoLM4EiBg/tJ
         CBXg==
X-Forwarded-Encrypted: i=1; AJvYcCVzuP+VoQqEyNPN2Ae9QSP4u+Fgw5asSx6cAClYDgSccI4xBY8CfNpeqeFt9fdMCwQ4I9Saf3jirntkcSIXdSCGlHiG
X-Gm-Message-State: AOJu0YyUYmwJZj2N7K7eJqpg7nbSmLjfJhjWuSUG/rmfDyQEJkkW2giM
	/9T4PF2vjMbrZI39Mxb8nF5h7kFjJDSMRkD1nkb2/GJbfAtKYEbfUk8AuvvifVa8eHGmlEL9FJl
	sCVOug80bpQRIy6tjNssFZWCCzeN8yoZF/FDB1mZzaFcnpCi1ILoc5Ig=
X-Google-Smtp-Source: AGHT+IFMleHcpokVPEguHmLGUq7veZ3YQSKLoTnvViBGu5hzLtbkptK5cnD3JxYOBu0eOk7CgW3QvHliAlCWxumW3aV/+f/0sATZ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130e:b0:4b0:b123:d9d with SMTP id
 8926c6da1cb9f-4bbb70abb58mr685984173.5.1719875962131; Mon, 01 Jul 2024
 16:19:22 -0700 (PDT)
Date: Mon, 01 Jul 2024 16:19:22 -0700
In-Reply-To: <0000000000008f77c2061c357383@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7ee4c061c37d314@google.com>
Subject: Re: [syzbot] [bpf?] [net?] stack segment fault in bpf_xdp_redirect
From: syzbot <syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1c5fc27bc48a Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14aeab3e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=5ae46b237278e2369cac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1673738e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9672225af907/disk-1c5fc27b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f14d163a914/vmlinux-1c5fc27b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec6c331e6a6e/bzImage-1c5fc27b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ae46b237278e2369cac@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 14042 Comm: syz.0.2930 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4544 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4542
Code: 81 c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 55 1a 99 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc9000aaf7970 EFLAGS: 00010202
RAX: 1ffff1100536be41 RBX: 0000000000000000 RCX: ffff888029b5da00
RDX: 0000000000000000 RSI: 000000000000a020 RDI: ffffc9000aaf7af0
RBP: 0000000000000007 R08: ffffffff8665e84f R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: 0000000000000038
R13: dffffc0000000000 R14: ffffc90009f63048 R15: 000000000000a020
FS:  00007f2c699ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0bea356dd CR3: 000000007a9bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_bc55b47b7a2429cd+0x1d/0x1f
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 tun_build_skb drivers/net/tun.c:1711 [inline]
 tun_get_user+0x3321/0x4560 drivers/net/tun.c:1819
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c69f7471f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007f2c699ff010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2c6a103fa0 RCX: 00007f2c69f7471f
RDX: 0000000000000032 RSI: 0000000020001500 RDI: 00000000000000c8
RBP: 00007f2c69ff677e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000032 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2c6a103fa0 R15: 00007ffd4d9d6998
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_net_ctx_get_ri include/linux/filter.h:788 [inline]
RIP: 0010:____bpf_xdp_redirect net/core/filter.c:4544 [inline]
RIP: 0010:bpf_xdp_redirect+0x59/0x1a0 net/core/filter.c:4542
Code: 81 c3 08 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 55 1a 99 f8 48 8b 1b 4c 8d 63 38 4c 89 e5 48 c1 ed 03 <42> 0f b6 44 2d 00 84 c0 0f 85 d0 00 00 00 45 8b 34 24 44 89 f6 83
RSP: 0018:ffffc9000aaf7970 EFLAGS: 00010202
RAX: 1ffff1100536be41 RBX: 0000000000000000 RCX: ffff888029b5da00
RDX: 0000000000000000 RSI: 000000000000a020 RDI: ffffc9000aaf7af0
RBP: 0000000000000007 R08: ffffffff8665e84f R09: 1ffffffff25f78b0
R10: dffffc0000000000 R11: fffffbfff25f78b1 R12: 0000000000000038
R13: dffffc0000000000 R14: ffffc90009f63048 R15: 000000000000a020
FS:  00007f2c699ff6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0bea356dd CR3: 000000007a9bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 c3 08 18 00 00    	add    $0x1808,%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 55 1a 99 f8       	call   0xf8991a71
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	4c 8d 63 38          	lea    0x38(%rbx),%r12
  23:	4c 89 e5             	mov    %r12,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 0f b6 44 2d 00    	movzbl 0x0(%rbp,%r13,1),%eax <-- trapping instruction
  30:	84 c0                	test   %al,%al
  32:	0f 85 d0 00 00 00    	jne    0x108
  38:	45 8b 34 24          	mov    (%r12),%r14d
  3c:	44 89 f6             	mov    %r14d,%esi
  3f:	83                   	.byte 0x83


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

