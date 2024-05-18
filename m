Return-Path: <bpf+bounces-30014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A38C924F
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F247B1F214DE
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9C6A8CF;
	Sat, 18 May 2024 21:05:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7898F4A
	for <bpf@vger.kernel.org>; Sat, 18 May 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066339; cv=none; b=BqBmxnNCsu+jHBhNwel3f8kMHhIWDhIptNL10PGafaCKoGJfFjSCsxYb0ZilnxhFHW4j2Eg1uBKh2udBJ5mofxFlzqNPgY4/eCI8P2RPEcm/kf34ymFYO3HVv+/LXQXMvG16aS95IUsJrhkAMzYqFobuYwtlgNoqxHHP4cGA61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066339; c=relaxed/simple;
	bh=NRgjkBMK4sXVRHAhM0KdWy2Ma87HvsqtCepIc1Mmf+U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oh0Nj0x3RWF+9soxky/UbHiWfh9STOR1OhvHxcIcPDbxBN55A9l4OquwuFolnT6o+EtP3j23gt9VNgBX2efyBu/V3AhCWsfBkOU5A2pyCZ5vPP579E7rfUVZ6wB+dRbVc9iYcqyR/tAUb5MMHTT0Z7iNgfiRQVfXcKD2Lk1C6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7dabc125bddso1197354339f.1
        for <bpf@vger.kernel.org>; Sat, 18 May 2024 14:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716066337; x=1716671137;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfFjo3BhTE67D3mQ9xMB8FDVigkkGBSudUTv3+vJeFs=;
        b=stCyPVaQ3WGvOmCDs7MmzejcjmoKqS6KJijEDzmDnPEaIFonwCdr7Wkgeam+TfdAMj
         MwNa6SMucPUNp/oSJT10R11xKGtdDU2aNSU49J3llVVUvcAluZW1DEItd0iEBDOELgUc
         3qoVdMUlT2zoamIp9WS563ySyc41ErroKG0aqx2UJ6aI0sHa7Cnu4SPGX1fjwbg1sb9l
         g8sNoScaJDigG0pCcQ2i1ppMiOFR4LiOKMMlPbFwLTMVnr644SAUu/oec266uEbhrNUc
         a+y4bLF+suHWqPcXwnJU/ki3IvjptzIXxnFb4Qtl01/T60tHMTj7/EosbxfitVwL0UDH
         5WPA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBVaiJ/NN4VECWkdKKHlRr+2OYePICXcjbU4a1GkZofrb9HkrhLWEa9Kjf260EMLbx3Ekf7Gj0ZXCIM4z8MB7l4NA
X-Gm-Message-State: AOJu0YxCTBE7/TEH9X2gHN9m4z5rKuo+S8hGXsa4WbILhJrT63YqX6XM
	vji3eo3ldNjOYr98McvO0qQdKbk5spc6kcAuWSfFtwkManXV5vX/pUfUzfsJP2QOZB7a56pyl9R
	9/HUb8bpHnWDfhpBRvd+qq7hhJNR5pr6jKe3xDemLywQlhIth/yxMi2E=
X-Google-Smtp-Source: AGHT+IH81JS2t4EuaWyDfkKkvdQ+OWubY5WcSldbCKOiadcOGy+6xA3E/2fR+hWaPT/Rs30P1O4E7tnxWdz8RrhitmSScCVpPKsK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr1771843173.3.1716066336941; Sat, 18 May 2024
 14:05:36 -0700 (PDT)
Date: Sat, 18 May 2024 14:05:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cbc570618c0d4a3@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
From: syzbot <syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1429a96c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=80cf9d55d6fd2d6a9838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a53ae4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113003d4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __dev_map_hash_lookup_elem kernel/bpf/devmap.c:270 [inline]
BUG: KMSAN: uninit-value in dev_map_hash_lookup_elem+0x116/0x2e0 kernel/bpf/devmap.c:803
 __dev_map_hash_lookup_elem kernel/bpf/devmap.c:270 [inline]
 dev_map_hash_lookup_elem+0x116/0x2e0 kernel/bpf/devmap.c:803
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x37/0x50 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2eca/0x6bc0 kernel/sched/core.c:6743
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x13d/0x380 kernel/sched/core.c:6838
 ptrace_stop+0x8eb/0xd60 kernel/signal.c:2358
 ptrace_do_notify kernel/signal.c:2395 [inline]
 ptrace_notify+0x234/0x320 kernel/signal.c:2407
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0x14e/0x3e0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x135/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422

CPU: 0 PID: 5042 Comm: syz-executor593 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

