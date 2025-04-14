Return-Path: <bpf+bounces-55834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE9A87696
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84B63B21F3
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 03:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65F19E971;
	Mon, 14 Apr 2025 03:52:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61319539F
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744602753; cv=none; b=KJIOJ6xH6VGcxdX9Tm771uqYmEAZADA+HM/67mmpulIeaepowPOIGHxA5ocVVbjRJo62VIQ0ZP19rYGlaeLYLrMjnJpMACB5ekYf+satM1UlxGFBf5lGiZPRI/AGoVOdcUj4sJKy+1AuP76386uWg6MPvAxMSej7F3FXj8+1lhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744602753; c=relaxed/simple;
	bh=XVwDcAEiYeJPSRKRhxnWs+iE9GLlQGh60EoL7fXPtNA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H8/fl85wHq8LQAYxYzp1SZLB+TQhhXgWK73+SdP/5hjbL/SiL4YpKWENElOHiGTmr8XJIO7AJ+SqwHkqmA6w+vegOy0Q640WUivtzZF9Clf0UJo+45+oe0kGFilJ1/SqKeFoz9K8QISo4Gp0BTlxyKs8tEIcW5+8tfeOPoSh9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d43d333855so30831715ab.0
        for <bpf@vger.kernel.org>; Sun, 13 Apr 2025 20:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744602751; x=1745207551;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4ofJTsYjACcwFNdnN4T1b9Qb1iA3eXa6RaUP9UE9Sw=;
        b=Ec3422HG0AJAFiestGxIsidxgpM658/hc5N9EP6BBWtpy1JrgwR4+A55TgEz2qyDSm
         xlCiUN/gV9rsG40IigwhZshEr7P0hplSzQJIlzzqwQTE0HJv42ucy5Lpj37/Tprc+mKZ
         usf8SKN4ijB6cxg23cmE5dn1K262Zcu8TOSfnQMpohix8TxZCQBC7xKQDcYxzOovhPu5
         d5YLTKFcpguWpf5UMqZKUyNcEhe07qd+VlrdJq+8XtqsXMgxHWlJd3MofxC51E4Aqvgb
         KGgC/5ccoEbWR7aoD+lK6jfCGBgFch+aoMyfAqpBA3j5/RRbD2R4YVG0xLwR3mOV9/Nt
         SeQg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfA93cwDoczeGw51GeLVsqywyhqWK1loWIGkqfFUlSLjFI32YUzfolNRZcLR6KnvBnCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmSPE6VCyCYp3yqPvFjrtB70MvXHWcR3p5iuroapA/aq/78Wa
	WXojp983ZjrX6IRRo3WN9AFNFBtJpgYX8wXkZJHOhEbjdvJh0qu8HcrkIKT+OtDyIlDuyDHqzEi
	wfFEvbaEsOVdRCLZnqoSX/puXhh2r4X/N5hTc6naW4ylM/OnvZFma8xY=
X-Google-Smtp-Source: AGHT+IE2kHDWEk+9Czb/Bn6XO2ZdybEoOcL+OFcO7jwto5GoDRPRfYJqLsmsbQa9cztf4P/M/TDJAgE+S6eS2adjS9NW3TWIlkMA
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1582:b0:3d4:414c:6073 with SMTP id
 e9e14a558f8ab-3d7ec1fd045mr117519705ab.8.1744602750917; Sun, 13 Apr 2025
 20:52:30 -0700 (PDT)
Date: Sun, 13 Apr 2025 20:52:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fc867e.050a0220.2970f9.03b8.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_get_local_storage
From: syzbot <syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d872d51bc9d Merge tag 'x86-urgent-2025-03-10' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128e67a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71f17a9b92472b2
dashboard link: https://syzkaller.appspot.com/bug?extid=e6e8f6618a2d4b35e4e0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1385b074580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1785b074580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4d872d51.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ca94bd3aed2/vmlinux-4d872d51.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da3cc5389139/bzImage-4d872d51.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6e8f6618a2d4b35e4e0@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5934 Comm: sshd Not tainted 6.14.0-rc6-syzkaller-00003-g4d872d51bc9d #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:____bpf_get_local_storage kernel/bpf/cgroup.c:1587 [inline]
RIP: 0010:bpf_get_local_storage+0x17b/0x260 kernel/bpf/cgroup.c:1569
Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bb 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 a6 00 00 00 48 8b 1b e8 13 90 73 09 83 f8 07 89
RSP: 0018:ffffc900006c0120 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81e40b82
RDX: 0000000000000000 RSI: ffffffff81e40c38 RDI: ffff8880356f2ca0
RBP: ffffc900006c0140 R08: 0000000000000005 R09: 0000000000000015
R10: 0000000000000015 R11: 0000000000000005 R12: ffff88802ae052c0
R13: ffffc90000d36002 R14: 0000000000000000 R15: ffff88802ae052f0
FS:  00007fb06dfb0d00(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000001c40 CR3: 0000000025fd8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 bpf_prog_3647604f6c8667e9+0x2e/0x41
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_prog_run_save_cb+0x11f/0x330 include/linux/filter.h:938
 bpf_prog_run_array_cg kernel/bpf/cgroup.c:68 [inline]
 __cgroup_bpf_run_filter_skb+0x470/0xe60 kernel/bpf/cgroup.c:1425
 sk_filter_trim_cap+0x234/0xac0 net/core/filter.c:147
 tcp_filter net/ipv4/tcp_ipv4.c:2144 [inline]
 tcp_v4_rcv+0x28fd/0x4380 net/ipv4/tcp_ipv4.c:2332
 ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:469 [inline]
 ip_sublist_rcv_finish+0x2c1/0x620 net/ipv4/ip_input.c:578
 ip_list_rcv_finish+0x559/0x720 net/ipv4/ip_input.c:627
 ip_sublist_rcv net/ipv4/ip_input.c:635 [inline]
 ip_list_rcv+0x339/0x450 net/ipv4/ip_input.c:669
 __netif_receive_skb_list_ptype net/core/dev.c:5936 [inline]
 __netif_receive_skb_list_core+0x755/0x950 net/core/dev.c:5983
 __netif_receive_skb_list net/core/dev.c:6035 [inline]
 netif_receive_skb_list_internal+0x753/0xdb0 net/core/dev.c:6126
 gro_normal_list include/net/gro.h:518 [inline]
 gro_normal_list include/net/gro.h:514 [inline]
 napi_complete_done+0x218/0x940 net/core/dev.c:6493
 e1000_clean+0xa28/0x2700 drivers/net/ethernet/intel/e1000/e1000_main.c:3815
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:7188
 napi_poll net/core/dev.c:7257 [inline]
 net_rx_action+0xa94/0x1010 net/core/dev.c:7379
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 do_softirq kernel/softirq.c:462 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:449
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x8b0/0x43e0 net/core/dev.c:4676
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xc34/0x2180 net/ipv4/ip_output.c:236
 __ip_finish_output net/ipv4/ip_output.c:314 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:296
 ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:459 [inline]
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0x1a8d/0x22d0 net/ipv4/ip_output.c:528
 __tcp_transmit_skb+0x2b39/0x3ec0 net/ipv4/tcp_output.c:1471
 tcp_transmit_skb net/ipv4/tcp_output.c:1489 [inline]
 tcp_write_xmit+0x12b1/0x8560 net/ipv4/tcp_output.c:2832
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3015
 tcp_push+0x221/0x6f0 net/ipv4/tcp.c:751
 tcp_sendmsg_locked+0x290f/0x37c0 net/ipv4/tcp.c:1326
 tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1358
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 sock_write_iter+0x4ac/0x5b0 net/socket.c:1137
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x207/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb06db16bf2
Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff72e409a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007fb06db16bf2
RDX: 0000000000000034 RSI: 000055e211330970 RDI: 0000000000000004
RBP: 000055e211339400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055e1e6312aa4
R13: 000000000000002b R14: 000055e1e63133e8 R15: 00007fff72e40a18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:____bpf_get_local_storage kernel/bpf/cgroup.c:1587 [inline]
RIP: 0010:bpf_get_local_storage+0x17b/0x260 kernel/bpf/cgroup.c:1569
Code: 48 8d 7b 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bb 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 10 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 a6 00 00 00 48 8b 1b e8 13 90 73 09 83 f8 07 89
RSP: 0018:ffffc900006c0120 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81e40b82
RDX: 0000000000000000 RSI: ffffffff81e40c38 RDI: ffff8880356f2ca0
RBP: ffffc900006c0140 R08: 0000000000000005 R09: 0000000000000015
R10: 0000000000000015 R11: 0000000000000005 R12: ffff88802ae052c0
R13: ffffc90000d36002 R14: 0000000000000000 R15: ffff88802ae052f0
FS:  00007fb06dfb0d00(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000001c40 CR3: 0000000025fd8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
   4:	48 89 fa             	mov    %rdi,%rdx
   7:	48 c1 ea 03          	shr    $0x3,%rdx
   b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   f:	0f 85 bb 00 00 00    	jne    0xd0
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 a6 00 00 00    	jne    0xda
  34:	48 8b 1b             	mov    (%rbx),%rbx
  37:	e8 13 90 73 09       	call   0x973904f
  3c:	83 f8 07             	cmp    $0x7,%eax
  3f:	89                   	.byte 0x89


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

