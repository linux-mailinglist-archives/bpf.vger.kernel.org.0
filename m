Return-Path: <bpf+bounces-77569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5300CEB525
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B20853009C30
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5322930FF29;
	Wed, 31 Dec 2025 06:02:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADCD282EB
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160947; cv=none; b=UxHC/SuOwwF53yOQmw28Aab+gaUYO4FnKSjyH1t3vWbncX41tkhj5PkOONmFGuZ9bn7GM94sal4EaCOSdS1HyLXnNO69NVtiZubIPhdWZNmZM3YonId9A4Yfqx9PrS6KcKllGlFa7X+8ZV+upAFrsBlpLgX9CXKTiHSUyNH4FmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160947; c=relaxed/simple;
	bh=41g0UrPy2dQNGw7AYwGDLuTbBGlGH04qfUcw+LF3pHk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XLnUOkP2YFVuPHjT29xrAavaPrJrDWkEA0Wzpo6aKSbwSNvvOTJkoGOBcD2ZGH32sPMib9SaBA+WEy0rcc79iYE4s76ttJpefpL5ZT7zHZT93ljl27S6c5/89Uvw8dZq1/BFcRaZX1t8XgcPtKLzxSp6IXahjDv/D6u/89WnmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4514cb26767so8167485b6e.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 22:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767160944; x=1767765744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oi47eUKdnBUxyEWqCpOYq6y386zm65Rw4NvnClQuY0w=;
        b=UmhJZe16F7Z4fDYJEYerv/1a9IHdYOb8m5JTPOiRpma86HAZ3p7BofkCiBraoK3rCD
         mTszMPtjAb3oLMBJ7OKNycsyxGhTiLBYmRIwbuHEsHnYfCZ7eXaytC3ouaERcPJ+8JT+
         aA9KOH8szY4oDCieENhBOwi+vrsVNY2cBmhxPa8ClzaVhMsjBBCEnwYMu6A6lPszHwGB
         PcpdoCMQrO2ZDmAUdrhDckoHlYgStZm9nX1ZgrL5vE1WBCw39uxJ4iruRAgyRGMJBZVz
         uRWSp7iAkbHiuCHpF7FZ7gqwKHjUB31ldsXNJupglXPihKQK/+uu9lS4fhsb0I/eTLob
         V0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/g3zG+lVZ4XenPlD8zJO9mIn4VzBzKPMSxJ0p+sG07szwmpZ/r7YhFHLzJ83kRWq0Adw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytTemJTtYyEBxrz2EpIuusgDn3Ix/kqnzXj1/3LfK6ukxOxG6H
	/f1urF6iZfcCIBkKNvqJH29v/khPljiVUGhVUKHNZ+KbhnTBZR3e0yVyD9+L9SxL0h/WHeGCC3a
	VSvKmKjXkh96mfcZJifs41lWguogJHcYYvmtLP2kZ+X+o8nqMKNVScXuE3dc=
X-Google-Smtp-Source: AGHT+IFXPmh+BScNc8DhOFb2u/sxb/+62Q2V0GgYXM3hFwHzPIxMiGrkIjUzma7AwrmB0iGCdiq5i5yEtRTxITnYFUa2z7uH0a4C
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4ec8:b0:65e:e522:bf0a with SMTP id
 006d021491bc7-65ee522bf77mr3188269eaf.36.1767160944242; Tue, 30 Dec 2025
 22:02:24 -0800 (PST)
Date: Tue, 30 Dec 2025 22:02:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in bpf_prog_test_run_skb
From: syzbot <syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f0e9c8cefa9 Merge tag 'block-6.19-20251226' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d784fc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3903bdf68407a14
dashboard link: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151f1b92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144f5022580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7f2d5650d243/disk-3f0e9c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/069034860f2d/vmlinux-3f0e9c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90d1c240dc1b/bzImage-3f0e9c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_test_run_skb+0x3091/0x3200 net/bpf/test_run.c:-1
 bpf_prog_test_run_skb+0x3091/0x3200 net/bpf/test_run.c:-1
 bpf_prog_test_run+0x5bb/0x9f0 kernel/bpf/syscall.c:4703
 __sys_bpf+0x873/0xeb0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6272
 x64_sys_call+0x31c3/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 pskb_expand_head+0x310/0x15d0 net/core/skbuff.c:2290
 __skb_cow include/linux/skbuff.h:3853 [inline]
 skb_cow_head include/linux/skbuff.h:3887 [inline]
 bpf_skb_net_grow net/core/filter.c:3511 [inline]
 ____bpf_skb_adjust_room net/core/filter.c:3754 [inline]
 bpf_skb_adjust_room+0x103c/0x3310 net/core/filter.c:3699
 ___bpf_prog_run+0x1297/0xeba0 kernel/bpf/core.c:2037
 __bpf_prog_run512+0xc5/0x100 kernel/bpf/core.c:2333
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_test_run+0x496/0xe00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x2377/0x3200 net/bpf/test_run.c:1158
 bpf_prog_test_run+0x5bb/0x9f0 kernel/bpf/syscall.c:4703
 __sys_bpf+0x873/0xeb0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6272
 x64_sys_call+0x31c3/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 skb_data_move+0x424/0x570 include/linux/skbuff.h:-1
 skb_postpush_data_move include/linux/skbuff.h:4639 [inline]
 bpf_skb_generic_push net/core/filter.c:3267 [inline]
 bpf_skb_net_hdr_push net/core/filter.c:3305 [inline]
 bpf_skb_net_grow net/core/filter.c:3542 [inline]
 ____bpf_skb_adjust_room net/core/filter.c:3754 [inline]
 bpf_skb_adjust_room+0x116c/0x3310 net/core/filter.c:3699
 ___bpf_prog_run+0x1297/0xeba0 kernel/bpf/core.c:2037
 __bpf_prog_run512+0xc5/0x100 kernel/bpf/core.c:2333
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_test_run+0x496/0xe00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x2377/0x3200 net/bpf/test_run.c:1158
 bpf_prog_test_run+0x5bb/0x9f0 kernel/bpf/syscall.c:4703
 __sys_bpf+0x873/0xeb0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6272
 x64_sys_call+0x31c3/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4960 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_node_noprof+0x9e7/0x17a0 mm/slub.c:5315
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:586
 pskb_expand_head+0x1fc/0x15d0 net/core/skbuff.c:2282
 __skb_cow include/linux/skbuff.h:3853 [inline]
 skb_cow_head include/linux/skbuff.h:3887 [inline]
 bpf_skb_net_grow net/core/filter.c:3511 [inline]
 ____bpf_skb_adjust_room net/core/filter.c:3754 [inline]
 bpf_skb_adjust_room+0x103c/0x3310 net/core/filter.c:3699
 ___bpf_prog_run+0x1297/0xeba0 kernel/bpf/core.c:2037
 __bpf_prog_run512+0xc5/0x100 kernel/bpf/core.c:2333
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 bpf_test_run+0x496/0xe00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x2377/0x3200 net/bpf/test_run.c:1158
 bpf_prog_test_run+0x5bb/0x9f0 kernel/bpf/syscall.c:4703
 __sys_bpf+0x873/0xeb0 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6272
 x64_sys_call+0x31c3/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6072 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


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

