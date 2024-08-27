Return-Path: <bpf+bounces-38137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA139607C8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945881C225FF
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841119EEA2;
	Tue, 27 Aug 2024 10:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEF199EAB
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755582; cv=none; b=EWtRbTGMbBPtymSCOLb/pv3/4KOff2AVKm7r7IkTj5mvI2PqZVk53DiGbXGPXiYpBDV0UOYhqr0gg/VIKRhJB1BAbJ87fHYtJ1G9DTM3FwVzWbl+qGPOleHLw5Auwtwx3x+tBTcE/2r2nV0DlBQgcqs4KdjbvXLV6knCjCaTP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755582; c=relaxed/simple;
	bh=ioLMtO1uV6E+wOlliXhu/h0TzikjSqbv4EkMAV6HY3c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k9Jj+LmUMu1ibAV8muEmfW8yGZf9ky7wKHoJNAS9C1QKxd9swpfCDwJODiqxlaDISU3LczSbl7WYSnLToFf+nmErLQxYKgfSYJlyNOyXyvdHGwPD9l4N79ms8KRScKjJF0OSviRy6Um5Oqc4PHzD5GDnAGRS+LQgjy+9gBD4v9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223c3509a9so585972239f.3
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 03:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724755580; x=1725360380;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEsqrN6JXpRhKvyS0G3BoDB6KETJ8oXuGoavYOdY5mg=;
        b=ZO1ZJskNwD1jxNkfzeqKW42NniLe1xT8gLtzAywQaPmKfq2DczKSe3w9ZuWEOZaqmi
         KUGxNL7M0Y+lXzf1QgL2VEibWj1bxqlKYdRRM1cT0beIbib2qwaKxH3MIHM7aSTOFl8O
         xhbsbDnAArTjdjz/SID09mv+wQ7xXkeWY1Z0PA1YHhB5gGQuPWBv70K1RHqxZySG7L8Q
         gGAJcxvXyep5FSCXo+ugPlRfgq3iAt7Tu8QLgferW/P/jQhIblJCypUR69yVfnYVA6CM
         53U9xbJTrZqGrrnAZ6klEh5hY90Bo7YV4jqTnYHivO2jdR0UPSbly7GrAylDbXkHP3FJ
         6Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCXqUwHbAe44TfCscSixj8tnexOth98H8Lnv8Rf0Iota2zbqGC48Z/HsQdOGjVTn9e0s8hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqFqx5SIOodcI4+xRMvEiwsTUZduPUzHLgHIFUpE5+YjqXsgj
	50C3xNPNzCLuGap3Ret2um2zp0O/qyaHUtOX+juyLv1kpDi9r0h0HtnXuUosxUPexZ9nnhHeIgJ
	cjT4mWNPu6T+Qc4EUYItQQCaT6bfWoHcf++riAoxEIAZVQZC4CjIqC/Y=
X-Google-Smtp-Source: AGHT+IEMkEFZATCCD7hiF97ykdv/qIMrSe/LWTBkCP5i2eRJhVcoDQW/D4IJjKBzuYjNVJuhEE6W4FaDowjgEpQX/DzOzKK+S7Zx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a9:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4ceb5322612mr87411173.5.1724755580014; Tue, 27 Aug 2024
 03:46:20 -0700 (PDT)
Date: Tue, 27 Aug 2024 03:46:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abe6b50620a7f370@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9e7fc0aeda7 igc: Fix double reset adapter triggered from ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11d20e55980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11293675980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cbac55980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4d43db0316d/disk-b9e7fc0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20e1491e28bb/vmlinux-b9e7fc0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e45d41229fa/bzImage-b9e7fc0a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 12 at net/core/sock_map.c:1663 sock_map_destroy+0x286/0x2b0 net/core/sock_map.c:1663
Modules linked in:
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-syzkaller-12642-gb9e7fc0aeda7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: krdsd rds_tcp_accept_worker
RIP: 0010:sock_map_destroy+0x286/0x2b0 net/core/sock_map.c:1663
Code: 48 8b 1b 48 83 c3 38 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 a8 f8 5b f8 4c 8b 23 e9 7a ff ff ff e8 2b c0 f4 f7 90 <0f> 0b 90 eb 9f e8 20 c0 f4 f7 48 89 df be 03 00 00 00 e8 b3 35 11
RSP: 0018:ffffc90000a17fd8 EFLAGS: 00010246
RAX: ffffffff899ec335 RBX: ffffffff95305938 RCX: ffff888017ad5a00
RDX: 0000000080000102 RSI: ffffffff8c0ae720 RDI: ffffffff8c606920
RBP: dffffc0000000000 R08: ffffffff90179daf R09: 1ffffffff202f3b5
R10: dffffc0000000000 R11: fffffbfff202f3b6 R12: ffffffff899ec0b0
R13: 1ffff110050e87ad R14: ffff888028743d40 R15: ffffffff899ec0d2
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd6b18c398 CR3: 0000000077166000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 inet_csk_destroy_sock+0x15b/0x380 net/ipv4/inet_connection_sock.c:1292
 tcp_fin+0x14a/0x520 net/ipv4/tcp_input.c:4581
 tcp_data_queue+0xf12/0x76c0 net/ipv4/tcp_input.c:5267
 tcp_rcv_state_process+0x17cc/0x4570 net/ipv4/tcp_input.c:6935
 tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1932
 tcp_v4_rcv+0x2dbd/0x37f0 net/ipv4/tcp_ipv4.c:2344
 ip_protocol_deliver_rcu+0x22b/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6108
 __napi_poll+0xcb/0x490 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6963
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
 __dev_queue_xmit+0x1763/0x3e90 net/core/dev.c:4450
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x18b4/0x6a10 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3014
 __tcp_close+0xa76/0xdd0 net/ipv4/tcp.c:2871
 tcp_close+0x28/0x110 net/ipv4/tcp.c:2962
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 rds_tcp_accept_one+0x1b3/0xbe0 net/rds/tcp_listen.c:234
 rds_tcp_accept_worker+0x3f/0xa0 net/rds/tcp.c:531
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

