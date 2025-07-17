Return-Path: <bpf+bounces-63656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0BAB09486
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D5B1C44107
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4392D1F7E;
	Thu, 17 Jul 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMAUCkuq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B120B215
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778725; cv=none; b=K20ZPsD2l9cUCd8ucgOzWMtyn+vz2Mlu3Nzo8quxvJ9bwkFKrth6usYMZUKEha/T2THDnGShqL2hb2WjvZDApf9CYl7EHBoBMcU3u+qW6knNEoTSJnHDglsLppIK2xBhpZJCfn0XmxAIi4kkvJ8Qh/ecFZz4rNE1S57w0ExfC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778725; c=relaxed/simple;
	bh=z/s+Nd+w7cZR3Up0kGfFnOTHzWQtLnqFkRxSRfJyj+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WvojTwqLV4jCWhC5elCag26sfGKCrIQwg3WzeN0hpaXj0wUSU7xmvonsbY8kPured8Njz3uX5yYKDl87sgrHfIw8o8mP4olmSjG4s0QZ7HXbbzt3GIG8qqHobmgcsuyQr9imXDv1aZLYZ8xg6KDMfBPL3Juojz9P6LMhlmLIXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMAUCkuq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2382607509fso8683175ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752778723; x=1753383523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyuipq8yz+na9vKhmstqOdMfH5o7gJKHRjnIEguNlxI=;
        b=zMAUCkuqElYLzqJZNiMmKDJLi3GkMXjhj/DwVD32egFlDdm2gWiNajMKb+1fGbXUnl
         h9ouBAW7l3BHW8/runMHXEtuXovWUXygT48nbrcP2vYlilVNsJjemOzegpvlv/J/fPKx
         wT+SmCpYTGqR38JtC86JfjAftAGhkRhHZLkIXjxwiJ90qiaLOVDIxYvy8qjunnW4AKqO
         whxaOsiAImpM8J/OmQQV1KAy29UGKjpWusGtzvIIkYA0oKwUqLgchCBiAv6OuYit/QI1
         jMyNMyJJNfoxiBdFrQLMqmrdh0Fr50GkNbotgi9qOokb9p9O3v23a67YW6RmY6egD5r3
         Kp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752778723; x=1753383523;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyuipq8yz+na9vKhmstqOdMfH5o7gJKHRjnIEguNlxI=;
        b=o8X0cZQ0tBGu/Fadv3wwGyLKJqIf7EqM3rBoZF1PAqZUP1ulUTHthMda/ND3kfgvPR
         SHg4R7/NkcEHReRnWmWR8/aJqErv8fB8xJQgYH/bxXuozEtR9/MyB6IbVapshjOhXzWN
         kIP5rc7y2YFP+ssbXuVK08NjKO7WzMmXJP3CUy9YnI++3Wq5bLvZxVEW+cNQC5IOwIUQ
         L6WmbxCubgkUpzmPrQDgbZ/v1h7CwWXJtISpHhAyi1xpV9otyjDVKrgFYk4MO/1umlpD
         f1cQLfKc/qlCe65DuxJvtzJUs9mKQ1PlhxF/3EbDyShSAXimP9q1pmh7xiirC4MzXalH
         piSw==
X-Forwarded-Encrypted: i=1; AJvYcCXuvfX49DteonNmlJb2y8Y9kIMR00Bu+5FkdX+eNMLP/e+G/O0HzSEKo1JJKe3T6MPdbCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANx2FfnjLpJFd+V+cN0JlN0XURfUEQgMgTdGAS+hyOuzFFKSN
	7n4t2Xbr95Wxz8S4a+G5JJ/yVCQJQpwC7PgvTsZfrisAyTMfE7QrgEn/yHk4Jt/qJVWoX+3t0BV
	74EY+OA==
X-Google-Smtp-Source: AGHT+IGapn6EU0fiE/Sefd+N/+nfRpkumvW1GYXlG1+tdhFN+OxF0MZC73N1khjs3KC5LtIjKZsVXK7RXII=
X-Received: from pjbta7.prod.google.com ([2002:a17:90b:4ec7:b0:30a:31eb:ec8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a84:b0:234:8a4a:ada5
 with SMTP id d9443c01a7336-23e24f59832mr114385265ad.37.1752778722812; Thu, 17
 Jul 2025 11:58:42 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:58:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717185837.1073456-1-kuniyu@google.com>
Subject: [PATCH v1 bpf] bpf: Disable migration in nf_hook_run_bpf().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported that the IP defrag bpf prog can be called without
migration disabled.

Then the assertion in __bpf_prog_run() fails, triggering the splat
below. [0]

Let's call migrate_disable() before calling bpf_prog_run() in
nf_hook_run_bpf().

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

Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
Reported-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6879466d.a00a0220.3af5df.0022.GAE@google.com/
Tested-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/netfilter/nf_bpf_link.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b0848447003..dffe4cd6f4b0b 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -16,8 +16,13 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
 		.state = s,
 		.skb = skb,
 	};
+	unsigned int ret;
 
-	return bpf_prog_run(prog, &ctx);
+	migrate_disable();
+	ret = bpf_prog_run(prog, &ctx);
+	migrate_enable();
+
+	return ret;
 }
 
 struct bpf_nf_link {
-- 
2.50.0.727.gbf7dc18ff4-goog


