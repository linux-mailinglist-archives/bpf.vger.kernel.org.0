Return-Path: <bpf+bounces-19993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE66835BF8
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEEB28826F
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DD168A7;
	Mon, 22 Jan 2024 07:46:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE16416
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909582; cv=none; b=Ir0n3WTAEJ6ltnMhHhJQzNlDVTpGmi4C+809hXxKRs2zXb0sp/e1vbROO3V8gTHPQbTGc6DVm4q+H7lPRuFmN6/W3P//JiSnW3TkK2aE+3f+vR0uW/0anYim+uuAijb+urSDCg6QoxmawhHyDHFbFn/oc7pexW+i/c7BTq9fAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909582; c=relaxed/simple;
	bh=1HWLd6cjnAiSE/YB5UYmIsvsAzIoN1hxyldr9FPzPqw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ogZV8d2nXD1blskk+9/1Nx0N4jqaSPHM+e2VV3S79NWKsKGdjDTpO3kuoGehGN0PaLt/vmheiO8fvH4NSGcqJZePB67IsQ4gfGPQs73z9gS/C+GOvnF1+iovl3fGNI/d+4wYmsMRmMrSp2pL7w2a/yFA0+eu6Xd2vKMo1WFOM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3627d99cbe5so7638765ab.2
        for <bpf@vger.kernel.org>; Sun, 21 Jan 2024 23:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909580; x=1706514380;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjeBalkypix5uZnv6/78S45Th9Z+D06qXD3yIf7OfY4=;
        b=UMkvuYzcKcoaJ7ztsqOdaKXubqrpyFQvVWotf3z2RXI9OpgR37ES2S1amd+maXWaCk
         8hQ7DE2WjAYiW8A7A26w0zgxvBx2eMkCteYjZIKKDekpuFnwtgPfvaGBv1dpDtCh9oE9
         EtDCzo+ykGfFVM4KAUgYJgUAoLBjDYvSLm+MsyS4nlwY970+DUAVb+7XMliEbO1yiJ6Y
         jPWJiAfYg/wP1ClqWHkDF7l7lfsCAuS2vISlM+ynY2ASt702Ei6gnW+m/prSoaOintro
         2yMCIVoK8Hl6vvN9Tj2YO3nGpGu2wipHwwN9WjN15oW8HxWlmy1ChsBZYCYvRQfeAxaB
         kkJg==
X-Gm-Message-State: AOJu0YxhE+GoRUa72x9kY9++o46WuXv9tXrXsHkKqk1RvXEfTxcA83Ee
	zzM3J8TMsJJqB+pR2Xq9kopKTqPDX5NPzghTMIMU29uFCT6Nb8h3CjzukL3Y25bTKV6LWHynHCa
	tUp+96xHjvS7+nTQwObvgpUHTu1tq+oVZllAhqsYGqHewMitbitXVPk8=
X-Google-Smtp-Source: AGHT+IGDeiT4cYa7qy6TL+jNU2foUYiDtAN/raMgagLIOwAy6tiJrqYuiFXsmgM1zsSG8rY5E6u72oz9hGAMgXb+rFd4QF0uhBEY
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:360:d7:186b with SMTP id
 h8-20020a056e021d8800b0036000d7186bmr495290ila.0.1705909580012; Sun, 21 Jan
 2024 23:46:20 -0800 (PST)
Date: Sun, 21 Jan 2024 23:46:19 -0800
In-Reply-To: <000000000000dea025060d6bc3bc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000893270060f840665@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in ___bpf_prog_run (4)
From: syzbot <syzbot+853242d9c9917165d791@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1493fa3de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139d21e7e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6066fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ___bpf_prog_run+0xa766/0xdb80 kernel/bpf/core.c:2037
 ___bpf_prog_run+0xa766/0xdb80 kernel/bpf/core.c:2037
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 ___bpf_prog_run+0x8567/0xdb80
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run512+0x45/0xe0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423

CPU: 0 PID: 5010 Comm: syz-executor315 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

