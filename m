Return-Path: <bpf+bounces-26692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E98A396D
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176501F228A4
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D24A28;
	Sat, 13 Apr 2024 00:50:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4F1847
	for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969421; cv=none; b=DKEDrD1GPinZXLwagdoseovzqjBs5ewP178I2LvFZbR7QCtlswjWxMs8iuF+BIffSoKXY0SWmu7TSU78uBrdOOr9gYUJfARVQk0zAOQQOjNMPE3y0dLve52Owlv41szPogfPjs29SS1+0KYcaz9j2vEci765QMOqAty1iX9rA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969421; c=relaxed/simple;
	bh=2PudCH3sanltZoJWKNx8RcWc6GEEHV5v127wrS9KFuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uI43+arjFltBMz36Ue/hFrQtx3qyfMVH4IxAqHjRvKNUQGPh0rT08mvrMObq/Ezwjd7EjqpPcAh9G1YXfVFDkUB9c8JfjGcDww2Kz9Oz00dCm4nK2nbKg/g1AXouAzon0IQHMvF13w3vurD9eAxFeko/D9jnXC5CHtHif12FGgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a208afb78so16553465ab.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 17:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712969419; x=1713574219;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ty8vjrN8ixEIeO3nPvDfskedfuwplOtYXeMyscPrwNA=;
        b=X2H/QAmRvz/bXbVPn2Yz8FPbsfW3Cx7KvwY79twO9VNP0Cpcl+DqFl751MEwRsF74z
         bvmfHyWtiMDEz0U01uioOK6kZvJ46FWkywa8JsA9q3t4juTyu7NRIe7Iue9ZcWzw1t4q
         4Sasy7Hzn6fBvJERCQhmSflb6mO11mFakUkXtt5b3JFgnemhNOOJP2kfnW9c+FFCqyzJ
         D1k9sXOWo5fbvU78nibVT/uMJKUt3Cs/ZgPcaGJo6p+6m+ktzcifyz1SJfr+NZ4AKo9b
         d0llbU63tBzMYho3Q6wAn1x3KolOHpZA+NdLrIF4+RhMFmJ9lksaI0mkyAzkgRPglChu
         977Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOXVBynNKvnGJjyX0OKRvVlZXJFKBVzswfwTOWbJSCzzJn77xpQRgwOC3rkbCqEAoGwOxtmAvzsDTKh6A4GgpRtH1l
X-Gm-Message-State: AOJu0YyVOKcpLG748NXXU2lB3ZA3gJi/4Ng6npoijcwCRy+P7cbt8XPd
	Q50D6hc6QWxvZTdcgDJftKjNOsOsEpDcHkkgq2dJs1NBLoN0xPK3P7hU3B22FWjoKV/BLFbosFl
	caFwroXfVukiz6b7/ftVUcrpGA2Jfa2Cci1tDcbiC7NE9mLNxVUYVc4U=
X-Google-Smtp-Source: AGHT+IH9qLKEt7z94jqgv0U9YhvpZZQaXbG55erGuK79lSTmq0zperO6eeigT5hGR9UCU2HqYvivcHSHOKo2dnIyacWGi5sW4xo0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e01:b0:36a:190f:1c93 with SMTP id
 g1-20020a056e021e0100b0036a190f1c93mr292596ila.5.1712969419196; Fri, 12 Apr
 2024 17:50:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:50:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be1f530615efc5ca@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec50db7033e Linux 6.9-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1425a483180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b653d3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159a2cf3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc/disk-fec50db7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vmlinux-fec50db7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d02/bzImage-fec50db7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in spin_lock_bh include/linux/spinlock.h:356 [inline]
BUG: KMSAN: uninit-value in sock_hash_delete_elem+0x239/0x710 net/core/sock_map.c:945
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0x239/0x710 net/core/sock_map.c:945
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421
 __bpf_trace_block_bio_remap+0x34/0x50 include/trace/events/block.h:507
 __traceiter_block_bio_remap+0xa5/0x160 include/trace/events/block.h:507
 trace_block_bio_remap include/trace/events/block.h:507 [inline]
 blk_partition_remap block/blk-core.c:571 [inline]
 submit_bio_noacct+0x2449/0x2800 block/blk-core.c:762
 submit_bio+0x58a/0x5b0 block/blk-core.c:879
 ext4_io_submit fs/ext4/page-io.c:378 [inline]
 io_submit_add_bh fs/ext4/page-io.c:419 [inline]
 ext4_bio_write_folio+0x1e76/0x2e40 fs/ext4/page-io.c:563
 mpage_submit_folio+0x351/0x4a0 fs/ext4/inode.c:1869
 mpage_map_and_submit_buffers fs/ext4/inode.c:2115 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2254 [inline]
 ext4_do_writepages+0x3733/0x62e0 fs/ext4/inode.c:2679
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
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x132/0x320 kernel/trace/bpf_trace.c:2421

CPU: 1 PID: 76 Comm: kworker/u8:5 Not tainted 6.9.0-rc3-syzkaller #0
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

