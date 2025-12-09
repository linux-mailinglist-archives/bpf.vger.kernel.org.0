Return-Path: <bpf+bounces-76344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CECAF371
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 08:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF12230A303B
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FF28134F;
	Tue,  9 Dec 2025 07:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE80E27B335
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266699; cv=none; b=axE/VXUa2T9okoU+XQXMddoBqY+N7QcIP0dPj8PD/ropGDS7Nq7Ki0I/IgKTZhmjd3EMdC7X2bplPUmEEzNvLr9erDXRRlDEDahpF/Y8+WeDskTFkfgykbqVqFHYnrnlazQSpW69UN74nqcRx+JpD38FgjT3YwrYV2BLqkg8cdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266699; c=relaxed/simple;
	bh=kYPch7DLKymTVOpM9JYlal177TTHjk9q7UZl1/ms5+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=LthMD2plVZ6jhWgYt6xkTv4p+LrkdwitlPyetJb+E2Kf1BmeTULB6k+WVaqxkcKibu6MDEYZcX08XWMbQt0sDqaOHRKjYfhRDR5atECcqpicMfUYd6Z3S5ogyI1GmVM+5GsZgb6LwdXlbmXr49WplGO/TxQg2e4RyVo9MZDuaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-450c16f2bc1so6607803b6e.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 23:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765266697; x=1765871497;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNybGs1OzbcSq373a8yBGpKsoVBZmjSLPm60GHMTVE8=;
        b=ZlQC0HgDlchjqo5mAjBoioXSdqikaqCxYk69UpxyPtija31MA16Xu4KLQne6cevYTA
         UNEKuniMZJ8JR5Wvfi0eIl1/HZVcvEv/mbwZrvl+NSgaK7OLhnYozRb0LIjT7AviaMMe
         Z2Lt4bFP1AYCXGOqESrRZGU8kW+RPu7rmztLirXU4mlITwpjCUDn6QtR1KQhGdBXAXjS
         VTpiA9q38ULzGfBhjungqVNsThtV6xn/ZK6DtO5G9AyLfPW4QVrGzdodsglzbd+tQ6gy
         zTgYA5VH26wSJzAEZjo4ZFRNRqBx4e/AT6bDETLDaW2Up7WmIkkte6sf3aXGDbTEwCcd
         NvCw==
X-Forwarded-Encrypted: i=1; AJvYcCWTM+s9HaxgyL0ZytDSdcwsbqlC6eVJkekSwnkudFTRKPLnO0Zhj8XqlGSZplAJqhYNFgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5auDOirre5hvOPiTpzmALqoHaKl2r7lakNty3hv4obrHrA7e7
	BeyvZjw3HhfXS3ga2epv23bkif+bU5xdG+EWbuuh4mU/E4k0n14ohtd6QJbOPNf2GQD0+X8G+lG
	T8jCsmbMclsQ11/7o9LqJsFtILuPfxL7NRjlGVDfEGHyF5cmwBoMrQNg8c48=
X-Google-Smtp-Source: AGHT+IHj9iqMCFRGP4wOM6ri1D0rsgLCKKMTOqY5F/1uA+gb3tA0MrEPJbfVCaWq7zwEz9VQHxyFEsZmyTc2r+nGEdmIN5saQ8yi
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:622:b0:659:9a49:9010 with SMTP id
 006d021491bc7-6599a98377emr3986841eaf.61.1765266696959; Mon, 08 Dec 2025
 23:51:36 -0800 (PST)
Date: Mon, 08 Dec 2025 23:51:36 -0800
In-Reply-To: <20251209031628.28429-1-kerneljasonxing@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6937d508.a70a0220.38f243.00c9.GAE@google.com>
Subject: [syzbot ci] Re: xsk: move cq_cached_prod_lock to avoid touching a
 cacheline in sending path
From: syzbot ci <syzbot+ci28a5ab4f329a6a88@syzkaller.appspotmail.com>
To: ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, jonathan.lemon@gmail.com, 
	kerneljasonxing@gmail.com, kernelxing@tencent.com, kuba@kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v4] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path
https://lore.kernel.org/all/20251209031628.28429-1-kerneljasonxing@gmail.com
* [PATCH RFC net-next v4] xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path

and found the following issue:
BUG: unable to handle kernel NULL pointer dereference in xp_create_and_assign_umem

Full report is available here:
https://ci.syzbot.org/series/d7e166a7-a880-4ea1-9707-8889afd4ebe8

***

BUG: unable to handle kernel NULL pointer dereference in xp_create_and_assign_umem

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      0177f0f07886e54e12c6f18fa58f63e63ddd3c58
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/d327cc4b-7471-413b-b244-519c6d16d43b/config
C repro:   https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd8db8d34/c_repro
syz repro: https://ci.syzbot.org/findings/c8f7aeaf-0e2e-43dd-ae9c-ea2dd8db8d34/syz_repro

UDPLite6: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
BUG: kernel NULL pointer dereference, address: 0000000000000058
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 80000001b2496067 P4D 80000001b2496067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5973 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:lockdep_init_map_type+0x1e/0x380 kernel/locking/lockdep.c:4944
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 48 83 ec 10 89 cd 48 89 fb 65 48 8b 05 67 af d1 10 48 89 44 24 08 <48> c7 47 10 00 00 00 00 48 c7 47 08 00 00 00 00 8b 05 8c f2 dc 17
RSP: 0018:ffffc90003c07bb8 EFLAGS: 00010286
RAX: ec490cf5c114aa00 RBX: 0000000000000048 RCX: 0000000000000000
RDX: ffffffff99d16120 RSI: ffffffff8c92a180 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: ffffed102e5d7800 R11: fffffbfff1efa3cf R12: dffffc0000000000
R13: ffff8881bdeb3000 R14: ffffffff99d16120 R15: ffffffff8c92a180
FS:  00005555729bd500(0000) GS:ffff8882a9f31000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000058 CR3: 0000000172faa000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 lockdep_init_map_waits include/linux/lockdep.h:135 [inline]
 lockdep_init_map_wait include/linux/lockdep.h:142 [inline]
 __raw_spin_lock_init+0x45/0x100 kernel/locking/spinlock_debug.c:25
 xp_create_and_assign_umem+0x648/0xd40 net/xdp/xsk_buff_pool.c:94
 xsk_bind+0x95a/0xf90 net/xdp/xsk.c:1355
 __sys_bind_socket net/socket.c:1874 [inline]
 __sys_bind+0x2c6/0x3e0 net/socket.c:1905
 __do_sys_bind net/socket.c:1910 [inline]
 __se_sys_bind net/socket.c:1908 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1908
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f591eb8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce6fcef48 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007f591ede5fa0 RCX: 00007f591eb8f7c9
RDX: 0000000000000010 RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007f591ebf297f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f591ede5fa0 R14: 00007f591ede5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
CR2: 0000000000000058
---[ end trace 0000000000000000 ]---
RIP: 0010:lockdep_init_map_type+0x1e/0x380 kernel/locking/lockdep.c:4944
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 56 53 48 83 ec 10 89 cd 48 89 fb 65 48 8b 05 67 af d1 10 48 89 44 24 08 <48> c7 47 10 00 00 00 00 48 c7 47 08 00 00 00 00 8b 05 8c f2 dc 17
RSP: 0018:ffffc90003c07bb8 EFLAGS: 00010286
RAX: ec490cf5c114aa00 RBX: 0000000000000048 RCX: 0000000000000000
RDX: ffffffff99d16120 RSI: ffffffff8c92a180 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: ffffed102e5d7800 R11: fffffbfff1efa3cf R12: dffffc0000000000
R13: ffff8881bdeb3000 R14: ffffffff99d16120 R15: ffffffff8c92a180
FS:  00005555729bd500(0000) GS:ffff8882a9f31000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000058 CR3: 0000000172faa000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	f3 0f 1e fa          	endbr64
  10:	55                   	push   %rbp
  11:	41 56                	push   %r14
  13:	53                   	push   %rbx
  14:	48 83 ec 10          	sub    $0x10,%rsp
  18:	89 cd                	mov    %ecx,%ebp
  1a:	48 89 fb             	mov    %rdi,%rbx
  1d:	65 48 8b 05 67 af d1 	mov    %gs:0x10d1af67(%rip),%rax        # 0x10d1af8c
  24:	10
  25:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
* 2a:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi) <-- trapping instruction
  31:	00
  32:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  39:	00
  3a:	8b 05 8c f2 dc 17    	mov    0x17dcf28c(%rip),%eax        # 0x17dcf2cc


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

