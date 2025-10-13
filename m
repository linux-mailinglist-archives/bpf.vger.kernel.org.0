Return-Path: <bpf+bounces-70801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A0BD211A
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7D18992C8
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441612F60BC;
	Mon, 13 Oct 2025 08:33:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FE2EB867
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344407; cv=none; b=LqYemNJkf1DvlACXEhSvMEE0Pixn/UOIr/Pbafmd7jczvnTb1Ob/fkwFPb+2/I9Lfa0Sgq8jFuh3HpIQ4/nkOaeHeIXLfQbFEtAHbr0K+PpIuH6zttDtzYIMBsO5zMDUEQW6kawcYZOu7fCRsXrSSJ4qoYp//BK3hiUMmnu34/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344407; c=relaxed/simple;
	bh=wXQZLc1odkcf6QcU9vPPSZuObkLbPZG6b5Ao9isTL/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ctH96HLLiz1AIoa1SL0IY2WN5FUbvODL1W4kC3qoRg73LiPziRge7CmLSAGMPPAhtR0jPpQcT+Yj5TSBAYbULDmm524N5bpvDQgMpXXogzzDooHbWwtAcqIVrfDGLfOx5ASJX/+Daf4WISCFZ7XV/Ti6hNRPwBT5+2Anz7knjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42d7e4abc61so129795305ab.3
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 01:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760344404; x=1760949204;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCv209PCyXrgwvMWYxejYyi6NbJpRieHlPfmxnoDizI=;
        b=URH2Vd7nbpNJrFR2c87SboOKT8jvH0YLs7z6x3uDOWg4IpaaV3xMGfouyzYb5Vovs6
         /L7zFWbSRBl/zabvcSUM/wC6kPZ1sPC4Z7a1FYkyDoxR1MWTXgvmX8tf0hhDMOPLfwmZ
         Ibw4Ofhh1RUreZqtaediK/Aw2xLDkgaqoCU6QATl0hqjqIf0w5b5rBTMPiiQbs62iYPm
         4rwL0MZgSeXdA8Oky/GbdLuTFZIf2BOnd8txu+yK+dA4gBmAhkieKu7ageQwTlJgZZX1
         v0Ec4sGcqQZ1znIPXUctBvFRNCyTsshAJ4lHpxCbV4i/O7jJj16cO3oVQcm8ji/lFh3j
         2Dhw==
X-Forwarded-Encrypted: i=1; AJvYcCX+XDTKBTLIO9Tr3JDZbknLWt3nlUQL7ofVMiu10BrIXVNXJiFMoT6eneLuHlyyoEEln5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdHC+7tG+o4r1EpvLtjJppK907QlwjPQTm/mA/PaZA4Ehzacp
	hbVG+lPzCYl4vMfJAfNLAuDbgKlzUKeVEuIJfVlUjD0wqFT/0biaN/tM/kWmnTzIcc8F6o2DZce
	srjn1wFYPgTErx1KOLvG8SMxeXYeGY8zsh1k7qiGux8mA6iBtTpFq4eGRqi4=
X-Google-Smtp-Source: AGHT+IHTMsch5aV2Nu9FAhOlJb4LF1SyaXjozUu+X+wE98mO8iFxI/LxleuilPnXweOu1amGGyU4obKifDUtObUBs73PkaPnPO08
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378a:b0:42f:7fcc:35a8 with SMTP id
 e9e14a558f8ab-42f8736c28bmr229535705ab.12.1760344404060; Mon, 13 Oct 2025
 01:33:24 -0700 (PDT)
Date: Mon, 13 Oct 2025 01:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ecb954.050a0220.ac43.0018.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] BUG: stack guard page was hit in br_handle_frame
From: syzbot <syzbot+593efacb260a29c44abc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0db4941d9dae bpf: Use rcu_read_lock_dont_migrate in bpf_sk..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107ef92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e0e0bf7e51565cd
dashboard link: https://syzkaller.appspot.com/bug?extid=593efacb260a29c44abc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/692372caac28/disk-0db4941d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5518b9303204/vmlinux-0db4941d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/606bc80ec5b8/bzImage-0db4941d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+593efacb260a29c44abc@syzkaller.appspotmail.com

bridge0: received packet on team0 with own address as source address (addr:aa:aa:aa:aa:aa:17, vlan:0)
bridge0: received packet on team0 with own address as source address (addr:aa:aa:aa:aa:aa:17, vlan:0)
bridge0: received packet on team0 with own address as source address (addr:aa:aa:aa:aa:aa:17, vlan:0)
BUG: IRQ stack guard page was hit at ffffc90000a00ff8 (stack is ffffc90000a01000..ffffc90000a09000)
Oops: stack guard page: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 12957 Comm: syz.8.2194 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:strlen+0xa/0x70 lib/string.c:417
Code: 07 38 c1 7c db e8 b6 ea e1 f6 eb d4 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 54 <53> 48 c7 c0 ff ff ff ff 49 be 00 00 00 00 00 fc ff df 48 89 fb 49
RSP: 0018:ffffc90000a01000 EFLAGS: 00010082
RAX: ffffffff8b6bd780 RBX: ffffffff8e13b278 RCX: ffff88805b39dac0
RDX: ffffffff81ca8977 RSI: ffffffff8e13b260 RDI: ffffffff8b6bd780
RBP: ffffc90000a01108 R08: ffffc90000a0122f R09: 0000000000000000
R10: ffffc90000a01220 R11: ffffffffa02017d4 R12: 1ffff9200014020c
R13: ffffffff81ca8977 R14: ffffffff8e00a0c0 R15: dffffc0000000000
FS:  000055556b813500(0000) GS:ffff888125e27000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90000a00ff8 CR3: 000000003c5ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 trace_event_get_offsets_lock include/trace/events/lock.h:50 [inline]
 do_perf_trace_lock include/trace/events/lock.h:50 [inline]
 perf_trace_lock+0xc2/0x3b0 include/trace/events/lock.h:50
 __do_trace_lock_release include/trace/events/lock.h:69 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x3b2/0x3e0 kernel/locking/lockdep.c:5879
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 trace_call_bpf+0x79e/0xb50 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x78/0x170 kernel/events/core.c:10931
 do_perf_trace_preemptirq_template include/trace/events/preemptirq.h:14 [inline]
 perf_trace_preemptirq_template+0x280/0x340 include/trace/events/preemptirq.h:14
 __do_trace_irq_enable include/trace/events/preemptirq.h:40 [inline]
 trace_irq_enable+0xee/0x110 include/trace/events/preemptirq.h:40
 trace_hardirqs_on+0x18/0x40 kernel/trace/trace_preemptirq.c:73
 __local_bh_enable_ip+0x12d/0x1c0 kernel/softirq.c:455
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 ipt_do_table+0x13dd/0x1640 net/ipv4/netfilter/ip_tables.c:357
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x53e/0x6b0 include/linux/netfilter.h:316
 br_nf_post_routing+0xb66/0xfe0 net/bridge/br_netfilter_hooks.c:966
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x215/0x3c0 include/linux/netfilter.h:316
 br_forward_finish+0xd3/0x130 net/bridge/br_forward.c:66
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_forward_finish+0xa40/0xe60 net/bridge/br_netfilter_hooks.c:662
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_forward_ip+0x647/0x7e0 net/bridge/br_netfilter_hooks.c:716
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x215/0x3c0 include/linux/netfilter.h:316
 __br_forward+0x41e/0x600 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb5/0x160 net/bridge/br_forward.c:191
 br_flood+0x31a/0x6a0 net/bridge/br_forward.c:238
 br_handle_frame_finish+0x15a3/0x1c50 net/bridge/br_input.c:229
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 NF_HOOK+0x9d/0x390 include/linux/netfilter.h:319
 br_handle_frame_finish+0x15c6/0x1c50 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x97f/0x14c0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 process_backlog+0x60e/0x14f0 net/core/dev.c:6544
 __napi_poll+0xc7/0x360 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x5f7/0xdf0 net/core/dev.c:7784
 handle_softirqs+0x283/0x870 kernel/softirq.c:622
 do_softirq+0xec/0x180 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 fpu_clone+0x53f/0xbb0 arch/x86/kernel/fpu/core.c:692
 copy_thread+0x3f5/0x9a0 arch/x86/kernel/process.c:216
 copy_process+0x18ae/0x3c00 kernel/fork.c:2190
 kernel_clone+0x21e/0x840 kernel/fork.c:2609
 __do_sys_clone3 kernel/fork.c:2911 [inline]
 __se_sys_clone3+0x256/0x2d0 kernel/fork.c:2890
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5f291c3609
Code: d7 08 00 48 8d 3d 9c d7 08 00 e8 e2 28 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007fffae254858 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f5f291459f0 RCX: 00007f5f291c3609
RDX: 00007f5f291459f0 RSI: 0000000000000058 RDI: 00007fffae2548a0
RBP: 00007f5f26fb26c0 R08: 00007f5f26fb26c0 R09: 00007fffae254987
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 000000000000006e R14: 00007fffae2548a0 R15: 00007fffae254988
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0xa/0x70 lib/string.c:417
Code: 07 38 c1 7c db e8 b6 ea e1 f6 eb d4 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 41 54 <53> 48 c7 c0 ff ff ff ff 49 be 00 00 00 00 00 fc ff df 48 89 fb 49
RSP: 0018:ffffc90000a01000 EFLAGS: 00010082

RAX: ffffffff8b6bd780 RBX: ffffffff8e13b278 RCX: ffff88805b39dac0
RDX: ffffffff81ca8977 RSI: ffffffff8e13b260 RDI: ffffffff8b6bd780
RBP: ffffc90000a01108 R08: ffffc90000a0122f R09: 0000000000000000
R10: ffffc90000a01220 R11: ffffffffa02017d4 R12: 1ffff9200014020c
R13: ffffffff81ca8977 R14: ffffffff8e00a0c0 R15: dffffc0000000000
FS:  000055556b813500(0000) GS:ffff888125e27000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90000a00ff8 CR3: 000000003c5ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	38 c1                	cmp    %al,%cl
   2:	7c db                	jl     0xffffffdf
   4:	e8 b6 ea e1 f6       	call   0xf6e1eabf
   9:	eb d4                	jmp    0xffffffdf
   b:	90                   	nop
   c:	0f 0b                	ud2
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	f3 0f 1e fa          	endbr64
  23:	41 57                	push   %r15
  25:	41 56                	push   %r14
  27:	41 54                	push   %r12
* 29:	53                   	push   %rbx <-- trapping instruction
  2a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  31:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  38:	fc ff df
  3b:	48 89 fb             	mov    %rdi,%rbx
  3e:	49                   	rex.WB


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

