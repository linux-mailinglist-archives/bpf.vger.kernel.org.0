Return-Path: <bpf+bounces-57311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6908AA83CB
	for <lists+bpf@lfdr.de>; Sun,  4 May 2025 05:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB1179052
	for <lists+bpf@lfdr.de>; Sun,  4 May 2025 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFAC146D65;
	Sun,  4 May 2025 03:47:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77DAD24
	for <bpf@vger.kernel.org>; Sun,  4 May 2025 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746330449; cv=none; b=ebZIefFqaF0N80iJsZgu+3lHGUShlIYEvBzTOdhyPAxGZg+JnA+fMVnxELrp5MTlJX6p2vYb7Y3yVBeyEtnWeR5XMcwXc/W6RH5Ou9gwZlaY0kAYi7IIdDziVKzSTua0gD62jnvOBi8+EAIK28y8Z7BJb24jXD644KpsdFneebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746330449; c=relaxed/simple;
	bh=VVHbpS+aW41BhtWvQG0K5cKf1+fGMGKPO5Uk3Njlb8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eLwRnJOgvln1LDd4XjMB+JesjhTcqC93Sib5TLLNoIurlIhHolpWs/VdzPL4rW+iLrPPtaMV1vACIgBCahEGJxwx89ySbhvV13jucTqz9T7rD6llhTMGgMS6H4E5grygkD/zXBTqsrT+CU3iPkbWqJZX5/6RIBbRP0Uy86yCu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d9099f9056so48538545ab.2
        for <bpf@vger.kernel.org>; Sat, 03 May 2025 20:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746330446; x=1746935246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2qKXyJva4LTr+e08+BalZ6zbfJm13uIF15vWKahR20=;
        b=YHpGlA9Gx9ZYYV54PI9SHIRxBdMg6VKHod0NR2bvhQJuNUHRfFBgKjpkIoiPIM5kcT
         cXQxVCjhWUvOlN/R/wDFrp/+9yUJrSChtnD1cIMLe8TQF2EPI5WUelxAI5PAZ/b9Q+Lh
         h005IFAoBLjr5a2pvfOXwDskKwq62DWifmLwdRqRcfor3Kxd/Fw+iWH2V/55ktN5arJA
         /VDKVP4SQgtZEE0uXuuHEk53/wm57ZBoVPwg+cWbyrxl8Tn4AGHhzx1htcoXopRriUDi
         vq+PeMPYi52ZJWKwvG4fW1Yarvoq6jQzJbuXHM5tNB/DmC+SL8/drcW19706iKiIeZjm
         Kd/w==
X-Forwarded-Encrypted: i=1; AJvYcCUFgqiF2K1hG8gtYvxPL3zjds8dtq7SU8LDnyPc1Ug+DsAh33fkPU8Ubvre2qjO3WXIntA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CYvl5sfDs5UmB7D4EQyMpJuNJMidYRDCe3Qg57PazklNBOhy
	3WhbOPEATlZsK1o7ekIfZUvCr77pJkAJq9Cltxx8QiS7Ag3Gp0vC5tzXvr2N6EaWCrAVFqhrLdF
	/xgZPiawBlMuDZvnPDx475U6OY4K+uKblXoI7NALWxxzCN1dtzI11ak8=
X-Google-Smtp-Source: AGHT+IHp2dsJUruiVcjG+lkcJTYcLayX6++Adsb6kx/CiFEu+bs7FetM/ZQWeB2w811RtI8R8S4q8IvHgC7BQzRzH6dhS3B0g3AP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3d9:6485:39f0 with SMTP id
 e9e14a558f8ab-3da5691c069mr41746445ab.9.1746330446641; Sat, 03 May 2025
 20:47:26 -0700 (PDT)
Date: Sat, 03 May 2025 20:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6816e34e.a70a0220.254cdc.002c.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in __bpf_prog_ret0_warn
From: syzbot <syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f03774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
dashboard link: https://syzkaller.appspot.com/bug?extid=0903f6d7f285e41cdf10
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1550ca70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d10f74580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8bac8898.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f7c2d7e1cd1/vmlinux-8bac8898.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77a157d2769a/bzImage-8bac8898.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
Modules linked in:
CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
Code: f3 0f 1e fa e8 a7 c7 f0 ff 31 c0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa e8 87 c7 f0 ff 90 <0f> 0b 90 31 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90
RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
 tc_classify include/net/tc_wrapper.h:197 [inline]
 __tcf_classify net/sched/cls_api.c:1764 [inline]
 tcf_classify+0x7ef/0x1380 net/sched/cls_api.c:1860
 htb_classify net/sched/sch_htb.c:245 [inline]
 htb_enqueue+0x2f6/0x12d0 net/sched/sch_htb.c:624
 dev_qdisc_enqueue net/core/dev.c:3984 [inline]
 __dev_xmit_skb net/core/dev.c:4080 [inline]
 __dev_queue_xmit+0x2142/0x43e0 net/core/dev.c:4595
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
 __ip_finish_output net/ipv4/ip_output.c:313 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
 ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:459 [inline]
 ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:129
 iptunnel_xmit+0x5d5/0xa00 net/ipv4/ip_tunnel_core.c:82
 geneve_xmit_skb drivers/net/geneve.c:921 [inline]
 geneve_xmit+0x2bc5/0x5610 drivers/net/geneve.c:1046
 __netdev_start_xmit include/linux/netdevice.h:5203 [inline]
 netdev_start_xmit include/linux/netdevice.h:5212 [inline]
 xmit_one net/core/dev.c:3776 [inline]
 dev_hard_start_xmit+0x93/0x740 net/core/dev.c:3792
 __dev_queue_xmit+0x7eb/0x43e0 net/core/dev.c:4629
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0xe98/0x2020 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
 ip6_finish_output+0x3f9/0x1360 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x1f9/0x540 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:459 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 mld_sendpack+0x9e9/0x1220 net/ipv6/mcast.c:1868
 mld_send_initial_cr.part.0+0x1a1/0x260 net/ipv6/mcast.c:2285
 mld_send_initial_cr include/linux/refcount.h:291 [inline]
 ipv6_mc_dad_complete+0x22c/0x2b0 net/ipv6/mcast.c:2293
 addrconf_dad_completed+0xd8a/0x10d0 net/ipv6/addrconf.c:4341
 addrconf_dad_work+0x84d/0x14e0 net/ipv6/addrconf.c:4269
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

