Return-Path: <bpf+bounces-28015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7028B4523
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 10:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53321F21EC2
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778742073;
	Sat, 27 Apr 2024 08:34:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A47376EC
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714206863; cv=none; b=qBOFiW87EDxEZboTT3t1rXeYiRJA0gwfR5FUdpOYE5vHBCMzTI79zQOuhhMVVzDhVz9fjRMqijmpKQhonjDdrXfsjaxN+JjoKMK+EQvMF/Lyrwht4icEXgir3FekEejJiQdA7x0wtHftXBbMZ8oRzbP8A/i56cS1qRDHzGyn4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714206863; c=relaxed/simple;
	bh=cSO2S2dJuN37y2idSF+/sz44TSy22LF4xPFz7e51S5g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ebOB2wBsxGAt3UMAi6i2xmkZ7UxVPpCG73ot2SgElXrMoc/wbBO0GrXGK2KFk2B9UL35Mxr8ASe7Y9uCG0qO0O8U/USyFhMkIKMgx71T/SAkLmdbcpOdk2VH+mxKt+E9Xydyas7YgrtowQcfKveUBbdSqJGrwfLMUyrelmozX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dda529a35cso315716839f.3
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 01:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714206861; x=1714811661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUTysr2v1XWCj7QjU/AZJKX+wld8PVoAJIV9qfiq2GI=;
        b=AnLtzHYau9I22U+EvcygvWryG7bcayrzDTDMjt+s+UF4OQ3UsHOXM1NEtbK0I2hSom
         wfJyaLFBSFK6KB/hg5LnuMhq/cCYzVBHw8LYtjg3DYG2PE3P8pNRPUjWT6AXyk8hP5eb
         PTH18B7AqkiKNAZBChSMYBT8f3l9zy95G8zDVsj8GEX7fld7wMgAjDYiCUPCUVBNxTF8
         rMyG9VnKEc/12ONnNT9wrjVzkLvOYWNpdaKrgUBDQBuiqyxHOgZ+OCdSYeElP218dCRs
         9K4x93X3v2T2wr2ZB6Qnk1ysIPXIgXc57z8gxkzJpBKtCKc0DqAuvcgoI7pif6aHvIbl
         IZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvDQxuBJdzR4ZlG4M/Gcdez8lQEgv3RtcxSgil2S4QcFJLSAn5NOKbEN6QgsBOyXySTSnYY3KYZiKUbuTA7nDOLkVF
X-Gm-Message-State: AOJu0YyUA7lzs0PSTtJduFo4+ZwhWajcYyJuvjnzBApA2LLsqs/maV1S
	HO3bTkwGfTq03TQQ6iEsVpoNj2Z5oO5U3jrHNKt4mTWVheB+S5D/n5QZfc5MNINLejqYV8Asy+D
	tr8d9gn205ggiHsO/G1Bi2nkwDbw+xEHpzeXIJvUETYUXAYWocja55sk=
X-Google-Smtp-Source: AGHT+IFI2OHiqMbfz0pasQdW3gF+IFIr60PkBgZ87TP4EPk84SdAObClUHvdIUvXry+eqSEdADXxuEbtI1txMh3AGEahQo9k+cXG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408e:b0:485:658c:7623 with SMTP id
 m14-20020a056638408e00b00485658c7623mr380242jam.5.1714206861211; Sat, 27 Apr
 2024 01:34:21 -0700 (PDT)
Date: Sat, 27 Apr 2024 01:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008ce5306170fe347@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_map_delete_elem
From: syzbot <syzbot+9b0b6780e063c00f1453@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16672c08980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=9b0b6780e063c00f1453
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d6807b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76771e00ba79/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c957ed943a4f/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e719306ed8e3/bzImage-e88c4cfc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b0b6780e063c00f1453@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in lookup_elem_raw kernel/bpf/hashtab.c:642 [inline]
BUG: KMSAN: uninit-value in htab_map_delete_elem+0x492/0xaf0 kernel/bpf/hashtab.c:1427
 lookup_elem_raw kernel/bpf/hashtab.c:642 [inline]
 htab_map_delete_elem+0x492/0xaf0 kernel/bpf/hashtab.c:1427
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run160+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422
 __bpf_trace_ext4_writepages_result+0x3c/0x50 include/trace/events/ext4.h:542
 __traceiter_ext4_writepages_result+0xad/0x160 include/trace/events/ext4.h:542
 trace_ext4_writepages_result include/trace/events/ext4.h:542 [inline]
 ext4_do_writepages+0x6109/0x62e0 fs/ext4/inode.c:2747
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2012
 wb_writeback+0x4da/0xdf0 fs/fs-writeback.c:2119
 wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
 wb_do_writeback fs/fs-writeback.c:2276 [inline]
 wb_workfn+0x110c/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable stack created at:
 __bpf_prog_run160+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422

CPU: 0 PID: 60 Comm: kworker/u8:5 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
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

