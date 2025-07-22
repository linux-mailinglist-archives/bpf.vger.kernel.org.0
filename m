Return-Path: <bpf+bounces-64120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32430B0E691
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4925B6C5D1A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F193289344;
	Tue, 22 Jul 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpUEnoGh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB227FB30
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224045; cv=none; b=pswM9flWfX/4BMM4OeFvDO/ZgWohHK2ukxvzzh0RH01cPevqpDaSPAZU3EIn8awwVZZ02QuUUyH0WYjQxgPFvkrqhCZC+bwdOcyuL68IXAXj4LYp+nTetQPEzK1/HkjdlnT5WuKrKlJDqo8/JEzmP5x+qyQhElbjvgpJbxFnao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224045; c=relaxed/simple;
	bh=+42H/9YBeHAzHaoQNt10QggjJXigV7J/rguSjxxDZz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nNkYPVw7i+brDm5YDP/6WojXrQ2FvrH2jldUcyz8NtskL1Dg8hORz2fUVIV5xd40zJT94ABG0s4rDoJ3hr0/Vg52dJyG1Uf4Rerqbo+aseJ/rHFB7xaru2nZ2KxQm6Z47+3uIq0TyDAQv56sC/H/iTWUURaPsd064s7XrbFIGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpUEnoGh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234a102faa3so50733555ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753224044; x=1753828844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wKtcXMxj2OGpCwkPzjUbbWqW4CzJw89SXcZLChO/bm8=;
        b=DpUEnoGh19srQpsjZhckH4lz+AU4VtYQSxZWBaQ60fXG+D0Ri4vmmKGEM+3f9ut1fn
         qcC4gyXR4JnoV2XM+R27K2saP8AR9HagXtD19zEtlhdBzNCvD9M2W5QXImwBWq9RCE8E
         zObYJ380WfClBgmpBZGDT32cxmBAO5SRkoo6PqSzaYYstOOeSQICrHfxyWhvJ8P2J6d4
         EKwo1vQe6Uwn0HrnbBOp5A3nxPkkuUhI30lFUbRU0O/+6A//9M1HfQFFuC0HBgT0sG3N
         t+fAgc48oenuE+GFE6hM/nHdMqgpH5pk7bC5ZpP4FVn/fNB/kpAFiSxBwBVIh+ObTp3i
         9sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224044; x=1753828844;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKtcXMxj2OGpCwkPzjUbbWqW4CzJw89SXcZLChO/bm8=;
        b=s4R56NrzhhpSCntwY6Svt96w5eMZfHnU9RsuCNE3JN+HyDtmYJEwW8k+Oza7Uoh3F2
         sg9ImueYfBL80RSVjEPcrxBT5DtNV2b31n5jwlS8huL9S3GCv+xv25XvvBsxL1nbFbJG
         afM7g8Y4HKe8Xngu0GbwxVweS6WwIwXW3yVDZ61WqtoIM3bZfwvkDdgAYonLa3cD84Q/
         P2Kh2h708t+aBgZrkRdRjqn8aEZzIKpYbLVjCKJ7LXbM2YouUVELTz+g69Fw0++4U+KO
         EcuLyFC7fI+Em7m999EeLX+vy60W60Lp50/W4JZQ4H7L/GfbQX9Vq37RaO5NZxOoON7n
         tiZw==
X-Forwarded-Encrypted: i=1; AJvYcCV77NxXx4Kg4Atf6FqHOD5x1RxPck5Rvgnkv1Gw13GOm8l8XnQJL5hlNVOUHhH6zQPQBSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+94d9GIh8wqc5vhpxh/ZuC3+1ciQ46BdcnU30uLadR96cSaHa
	S0fitWVgfICV9mK7grH7+g3xODesL8468zMMMewf366GpQcPf9Yks4OWePN/iadzPwoDk+k+K9F
	qGMfZUg==
X-Google-Smtp-Source: AGHT+IEsypI3rYx6n4459N9W8IgNPRYtXYo2OzxtHcUkEBKajYj3FwY/w6yphT5g1epzz0g3C/aE4kYcOtA=
X-Received: from plbjj13.prod.google.com ([2002:a17:903:48d:b0:234:2261:8333])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:234:a139:11fb
 with SMTP id d9443c01a7336-23f981bb968mr8242035ad.27.1753224043640; Tue, 22
 Jul 2025 15:40:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:40:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722224041.112292-1-kuniyu@google.com>
Subject: [PATCH v2 bpf] bpf: Disable migration in nf_hook_run_bpf().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported that the netfilter bpf prog can be called without
migration disabled in xmit path.

Then the assertion in __bpf_prog_run() fails, triggering the splat
below. [0]

Let's use bpf_prog_run_pin_on_cpu() in nf_hook_run_bpf().

[0]:
BUG: assuming non migratable context at ./include/linux/filter.h:703
in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 5829, name: sshd-session
3 locks held by sshd-session/5829:
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x20/0x50 net/ipv4/tcp.c:1395
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x69/0x26c0 net/ipv4/ip_output.c:470
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: nf_hook+0xb2/0x680 include/linux/netfilter.h:241
CPU: 0 UID: 0 PID: 5829 Comm: sshd-session Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 __cant_migrate kernel/sched/core.c:8860 [inline]
 __cant_migrate+0x1c7/0x250 kernel/sched/core.c:8834
 __bpf_prog_run include/linux/filter.h:703 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 nf_hook_run_bpf+0x83/0x1e0 net/netfilter/nf_bpf_link.c:20
 nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
 nf_hook_slow+0xbb/0x200 net/netfilter/core.c:623
 nf_hook+0x370/0x680 include/linux/netfilter.h:272
 NF_HOOK_COND include/linux/netfilter.h:305 [inline]
 ip_output+0x1bc/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:459 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1d7d/0x26c0 net/ipv4/ip_output.c:527
 __tcp_transmit_skb+0x2686/0x3e90 net/ipv4/tcp_output.c:1479
 tcp_transmit_skb net/ipv4/tcp_output.c:1497 [inline]
 tcp_write_xmit+0x1274/0x84e0 net/ipv4/tcp_output.c:2838
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3021
 tcp_push+0x225/0x700 net/ipv4/tcp.c:759
 tcp_sendmsg_locked+0x1870/0x42b0 net/ipv4/tcp.c:1359
 tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1396
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x4aa/0x5b0 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c7/0x1150 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7d365d407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP:

Fixes: fd9c663b9ad67 ("bpf: minimal support for programs hooked into netfilter framework")
Reported-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6879466d.a00a0220.3af5df.0022.GAE@google.com/
Tested-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Use bpf_prog_run_pin_on_cpu()
  * Correct Fixes: tag

v1: https://lore.kernel.org/bpf/20250717185837.1073456-1-kuniyu@google.com/
---
 net/netfilter/nf_bpf_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b0848447003..25bbac8986c22 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -17,7 +17,7 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
 		.skb = skb,
 	};
 
-	return bpf_prog_run(prog, &ctx);
+	return bpf_prog_run_pin_on_cpu(prog, &ctx);
 }
 
 struct bpf_nf_link {
-- 
2.50.0.727.gbf7dc18ff4-goog


