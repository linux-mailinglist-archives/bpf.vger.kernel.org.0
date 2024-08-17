Return-Path: <bpf+bounces-37431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3799955958
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 21:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D01F21DD4
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD515575B;
	Sat, 17 Aug 2024 19:01:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92B83CD5
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723921295; cv=none; b=rhplcwtYlYnMGHxMe7L3N7i2NItpNMl9AWkhtsjL9ge09Rb4YwIHtlxG72fHVVoKqmjQlfarfHzuuoMGsJjxaZ8L6YmqMGISzRu72ASpMOWkWnw15CQ/bnGCoAfrwcQQxWG5ep0og5zpsvYAAaiFUVyABRfl+TjuAflS6IswwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723921295; c=relaxed/simple;
	bh=koHbXpWO3CxqZanxtLdTgu/e6n7zMxQM6gr5wya7CaU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LHKeUn1VaL8EcFipXkZVcbCM8ho64Xw0c/LrUQRoM0q2tGY1CsCJD/6hZrNCyWRXcZwvD1oqg7/DneLiVIzbf0HABKWU/3LHUqUipEAQLybxhUW1iH2572SJTXvFXOv1mDUMuC/TSoYr095bD5Bt5syT+shYu5v5o3mKalBSQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d306a36daso14107015ab.3
        for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 12:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723921292; x=1724526092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uowFCIZghpxJvoNZX8bSJ/JFrlmSFboKLdSQpoxsJ6E=;
        b=a+7SXp6pQtmssCudunkb5Y8FML8Gb912WgslkfvFw0bFvg5Q70LERqZBtaJJSIxiT7
         zVIyRirDpkQH9sRfg7CoIEgBH+7wN02Hta0AMIKdjF/VjOTzWeVg7b68caSDkyj5QXm6
         RECDgUhc7yjdKgAZl0DBgmvSk+iMkl7nqAPIsU6t18xD8brgOKH7e4XEoLcxrhQrLH3z
         9HLEebf/1w/Jr7B0sjVG4NV+VHNZLwAs6GKZuh+WBiZlWCvKoH9gduj5Xar2FWfWQ+eY
         eNbspMnPWaoLTz4aSJjEq/r1YMiF9Z12jtMGKycefOK5VxCFqYrcOUEXirn59FnJawC+
         TTKg==
X-Forwarded-Encrypted: i=1; AJvYcCU03j9Z+ZXj/gAG7XmNRLCmq7uQeJ/Vr9ILboxt2BSKNs2iq1NmQb1wVMrs+B6c9UKCCnl70T3YQ0o2csVNDBZvM+hs
X-Gm-Message-State: AOJu0YwCfTKyhimuePRVmxqCcfAjt7CWYgcoc3SXdAPzwXwTXAR2p21S
	9ZF2qQ4ZDMkkqmLVbEFbdfJFicOFQ3zVF9jiYUzGxVs6mnBT6bOtaPR9OX9hx664UKhIrk/fKlr
	hXpChkSa6BpzHs5xBST9kcBicWlYSaElQ04WOEYn7zrTpa1FS+2dmfCo=
X-Google-Smtp-Source: AGHT+IH0JoGNnWZcJv80CMdQ/6bxGMdJJcB0+IB8mo45ZavZrh09+qpoarVcdMAakw7f6ydctAH/8LZwgNyCbbsuSpevRTpa48O6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:39d:1d50:e6f9 with SMTP id
 e9e14a558f8ab-39d26d7057cmr4171005ab.4.1723921292599; Sat, 17 Aug 2024
 12:01:32 -0700 (PDT)
Date: Sat, 17 Aug 2024 12:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004432b7061fe5b45e@google.com>
Subject: [syzbot] [net?] [bpf?] WARNING in skb_ensure_writable (2)
From: syzbot <syzbot+deb196d6d40f19e8551a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=143cc2f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc88a9f65787e86
dashboard link: https://syzkaller.appspot.com/bug?extid=deb196d6d40f19e8551a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ef30d34e749/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a21c2389ebfb/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9720b12c3f99/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+deb196d6d40f19e8551a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 13062 at include/linux/skbuff.h:2738 pskb_may_pull_reason include/linux/skbuff.h:2738 [inline]
WARNING: CPU: 0 PID: 13062 at include/linux/skbuff.h:2738 pskb_may_pull include/linux/skbuff.h:2754 [inline]
WARNING: CPU: 0 PID: 13062 at include/linux/skbuff.h:2738 skb_ensure_writable+0x26c/0x3a8 net/core/skbuff.c:6100
Modules linked in:
CPU: 0 PID: 13062 Comm: syz.2.2595 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pskb_may_pull_reason include/linux/skbuff.h:2738 [inline]
pc : pskb_may_pull include/linux/skbuff.h:2754 [inline]
pc : skb_ensure_writable+0x26c/0x3a8 net/core/skbuff.c:6100
lr : pskb_may_pull_reason include/linux/skbuff.h:2738 [inline]
lr : pskb_may_pull include/linux/skbuff.h:2754 [inline]
lr : skb_ensure_writable+0x26c/0x3a8 net/core/skbuff.c:6100
sp : ffff800098f076c0
x29: ffff800098f076c0 x28: 0000000001000000 x27: ffff800098f07768
x26: 0000000000000000 x25: ffff800098f07770 x24: 1ffff000136a9e06
x23: 1ffff000131e0f1c x22: dfff800000000000 x21: dfff800000000000
x20: 00000000ffffffff x19: ffff0000c61a8280 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008055a9d4 x15: 0000000000000003
x14: ffff80008f3c0558 x13: dfff800000000000 x12: 0000000000000003
x11: 0000000000040000 x10: 00000000000004d0 x9 : ffff80009f01f000
x8 : 00000000000004d1 x7 : ffff80008044e140 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0000d24fdac0 x1 : 00000000ffffffff x0 : 0000000000000000
Call trace:
 pskb_may_pull_reason include/linux/skbuff.h:2738 [inline]
 pskb_may_pull include/linux/skbuff.h:2754 [inline]
 skb_ensure_writable+0x26c/0x3a8 net/core/skbuff.c:6100
 __bpf_try_make_writable net/core/filter.c:1668 [inline]
 bpf_try_make_writable net/core/filter.c:1674 [inline]
 ____bpf_skb_pull_data net/core/filter.c:1865 [inline]
 bpf_skb_pull_data+0x80/0x210 net/core/filter.c:1854
 bpf_prog_d22c10afa9a4a832+0x50/0xb8
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_test_run+0x374/0x890 net/bpf/test_run.c:425
 bpf_prog_test_run_skb+0x8d4/0x1090 net/bpf/test_run.c:1066
 bpf_prog_test_run+0x2dc/0x364 kernel/bpf/syscall.c:4291
 __sys_bpf+0x314/0x5f0 kernel/bpf/syscall.c:5705
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5792
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 291
hardirqs last  enabled at (289): [<ffff80008044e060>] seqcount_lockdep_reader_access+0x80/0x104 include/linux/seqlock.h:74
hardirqs last disabled at (291): [<ffff80008b1fe010>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (276): [<ffff800080030830>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (290): [<ffff800089727270>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

