Return-Path: <bpf+bounces-67485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318AB44511
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42277542A5E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8443341677;
	Thu,  4 Sep 2025 18:09:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E75341646
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009340; cv=none; b=kcKaDosYu+A1aJ9C/Vv8H8xCEc2UM57gl8elWg5skL9xy28o6dBgCzOucW+GKS4gQ2gC9sfM04TKnvpBy/Drc9gLKYXv23j5AonM56GkNz3phZvmHUJBdXOj73/0zYHLTKtgk2/oAFIZIXQVHzRkp3RZG08Ak9ShfmOMrrlEkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009340; c=relaxed/simple;
	bh=6Ph8xSjy9WXYTEvvT8h/a37jTJLfY5M6n6ZWTIg9Ksc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GjwHKI8zV5gQUrpDRbYNXTIhqpIfL9+/RCHcfX5nGYbSwQo7Yrkdf+JkFZOWqEesewMo8M55NSR0uc0jt6A3WLrsJdFKzTa2lhkmZt5hHgX3xiZQL+vuOHa5SRPPvmmlc1Ex8P4C0f1j/hufPwB4Zrl4a9Qwe+GSvvXg0tYIJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed0f07fca2so16077375ab.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 11:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757009337; x=1757614137;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0agGiPnZbnYPb8vc4IQFaCcTHMOWq1oT47RqpjAUkw=;
        b=Z2rQDVHzaCbf/E/dotSKzjakhjqrY4R5qUhexnW4P2IqdOQJBVc/ZAqNEDhk3EWIZI
         lrhQw1JyuA3pOnfaCZrtVr0P2R317D9Xk/4fr2UpuYRIFjYrv+jKTsyNp8gFJfVSzvtx
         H1Y8o3E4wLHy7W5HlWLt4s+BKMDLfYu7nxEMi5eI0dciC/6Kd4DdYL6U5R72uyYjWgZc
         5f52kdwyoapSYIi4z4Vp0XhcU2mSTPvVe6WFQbkcndvP/ROyd8E8wmmfhrWo82CrFkR7
         iYxk4A7a1BSC4Q4aTeP4n8jkZIqWa5vDQSNjWNngO4cOYZO3TVPHxpgrLh5mA4p0lK5O
         tN/w==
X-Forwarded-Encrypted: i=1; AJvYcCVzoK07aq77ZfLmdnmXgV0A/aRMJlpOoJmZCV0IgLziWOo2l94D87UZ4de/95VgzIv79LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVAL/ojQy9TXfUQkvFUCZ8AmwxrEkDUri4QPZlpF8Wd28ECVZM
	hG0NIA5me5266HcNL68N6mqG3Qqqk9eRl4qaJj3Pu0sZyUUOuxA9i1wtgSg5cj6N2UKCfVYlSl9
	tiPxinnks9HGzTYRO5jLENwZg6QK6DaNM+75LDDF8waGu7OdTJe8SSzpp97A=
X-Google-Smtp-Source: AGHT+IH/fK/WZ+kwKGJ90N1g7HISJurlUwX+eTV9eW0mRbR8aCgl20lOU2P1oRc4chrA6VmnOuOZxo8o8/8cGlqN9+3cPnhLo85e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b22:b0:3f2:a7ef:bd88 with SMTP id
 e9e14a558f8ab-3f3ffda32femr290258005ab.5.1757009337703; Thu, 04 Sep 2025
 11:08:57 -0700 (PDT)
Date: Thu, 04 Sep 2025 11:08:57 -0700
In-Reply-To: <cover.1756983951.git.paul.chaignon@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b9d5b9.050a0220.192772.000d.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Support non-linear skbs for BPF_PROG_TEST_RUN
From: syzbot ci <syzbot+ci75ba48ec8cca7f1b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, paul.chaignon@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] bpf: Support non-linear skbs for BPF_PROG_TEST_RUN
https://lore.kernel.org/all/cover.1756983951.git.paul.chaignon@gmail.com
* [PATCH bpf-next 1/4] bpf: Refactor cleanup of bpf_prog_test_run_skb
* [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
* [PATCH bpf-next 3/4] selftests/bpf: Support non-linear flag in test loader
* [PATCH bpf-next 4/4] selftests/bpf: Test direct packet access on non-linear skbs

and found the following issue:
kernel BUG in bpf_prog_test_run_skb

Full report is available here:
https://ci.syzbot.org/series/94d30edd-8375-4788-b43c-b4f85290f7e8

***

kernel BUG in bpf_prog_test_run_skb

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      c9110e6f7237f4a314e2b87b75a8a158b9877a7b
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/f23c9149-2bb8-4751-96fa-a1ef3b28cee2/config
syz repro: https://ci.syzbot.org/findings/4d88c169-3df8-4aac-b20a-ff80d8b2eff5/syz_repro

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:23!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6005 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__phys_addr+0x17b/0x180 arch/x86/mm/physaddr.c:23
Code: 50 cf fa 8d 48 89 de 4c 89 f2 e8 10 9a 8a 03 e9 4d ff ff ff e8 66 25 4b 00 90 0f 0b e8 5e 25 4b 00 90 0f 0b e8 56 25 4b 00 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90002c0fba8 EFLAGS: 00010293
RAX: ffffffff817486fa RBX: 000000007ffffff9 RCX: ffff888107c99cc0
RDX: 0000000000000000 RSI: 000000007ffffff9 RDI: 000000001fffffff
RBP: 00000000fffffff9 R08: ffffffff8fa38037 R09: 1ffffffff1f47006
R10: dffffc0000000000 R11: fffffbfff1f47007 R12: 0000000000000000
R13: 0000000000000000 R14: 000000007ffffff9 R15: dffffc0000000000
FS:  00007fae773f76c0(0000) GS:ffff8881a3c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31a63fff CR3: 000000001f48c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1180 [inline]
 kfree+0x77/0x440 mm/slub.c:4871
 bpf_prog_test_run_skb+0xceb/0x16e0 net/bpf/test_run.c:1179
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4590
 __sys_bpf+0x581/0x870 kernel/bpf/syscall.c:6047
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae7658ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae773f7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fae767c5fa0 RCX: 00007fae7658ebe9
RDX: 0000000000000050 RSI: 0000200000000080 RDI: 000000000000000a
RBP: 00007fae76611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae767c6038 R14: 00007fae767c5fa0 R15: 00007ffe5431da58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x17b/0x180 arch/x86/mm/physaddr.c:23
Code: 50 cf fa 8d 48 89 de 4c 89 f2 e8 10 9a 8a 03 e9 4d ff ff ff e8 66 25 4b 00 90 0f 0b e8 5e 25 4b 00 90 0f 0b e8 56 25 4b 00 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90002c0fba8 EFLAGS: 00010293
RAX: ffffffff817486fa RBX: 000000007ffffff9 RCX: ffff888107c99cc0
RDX: 0000000000000000 RSI: 000000007ffffff9 RDI: 000000001fffffff
RBP: 00000000fffffff9 R08: ffffffff8fa38037 R09: 1ffffffff1f47006
R10: dffffc0000000000 R11: fffffbfff1f47007 R12: 0000000000000000
R13: 0000000000000000 R14: 000000007ffffff9 R15: dffffc0000000000
FS:  00007fae773f76c0(0000) GS:ffff8881a3c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31a63fff CR3: 000000001f48c000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

