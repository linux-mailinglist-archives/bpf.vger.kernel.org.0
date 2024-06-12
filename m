Return-Path: <bpf+bounces-31925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9269053C5
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4221C20828
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F211117D8B5;
	Wed, 12 Jun 2024 13:25:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AD17A930
	for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198722; cv=none; b=Ss0jhM/2iziCqE2INaTPlt8GD9T33jrZa048uk8oJLAcgGLMu+DAeBV51JLWtu7MsaylIw8sfMMR0d1VbseYkbA5Cnpi4qgW11IsPzPL8k6Slgln5ncS2lcHCj7HpCcv6qPhDDcnOeTua1TdEdKxjwuKr3hADTj+iW5LNfhhxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198722; c=relaxed/simple;
	bh=VPOqqS4+wOGLU7jmDE0seMq1mz8cDLv49DDOYT883l4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZMWt3dZvIuA6CHGzQyJ2L5NrzhHohoCSiJeUAnPMAbuF0V8zPKE19wbSdWj9tFMJJN5kyGoFh+bvilnf9VdB4cfxnIRwWy/tAqugsUaP3mSgCbz+hJgaqeiviZpm4WVjggKNOF5hpxHEfosJRXz0mJC+KdIkCfNFw0HbMZ6Rooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb5f83ae57so70520139f.0
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 06:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198720; x=1718803520;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD04lBoOJxudqkvWH8fxwqiduFEx1F0N9CMuesTzvDc=;
        b=rPf139xOacZGeFcGPDAj8z53zetd3F9jDheOHLvras9WlGTGfPawvx6oPrJH8wWB5O
         90YRvTtmzRqBp9Wa8mkf6GNZBeauq2wjH+L6ZOPZvdDYmNrpaUBBocKMFK3KxaUfU7qP
         YR5vhZ/dC4vkWelNBYNYLsNPNqY7Eyg+i7KXgUKW6SrAv7qKsmhYxs2TO6/Qr02SkLWT
         EYLGKhuA13l63MA9auwBwNOFvHUooZhRgpeEunN956rZ+Rizz3Spr9ZSqRuR0tSSNyZe
         0H/TR3ZXn8SYJOQxCQVDYM5KcXLjDECPo1eCIs+gZphnLa0LoRNOvOfPsLSGCo+7F2G2
         dZeA==
X-Forwarded-Encrypted: i=1; AJvYcCWK889FFmzNWXJs3SWBmksqdew2LtI0Bx8fG8vgrB87DjrSNt+eB30eKIj+ipgMYfyT72QOyE+C10cjXPhHYWDGeT7W
X-Gm-Message-State: AOJu0YzT3PRv+AvSe3W6bPap0MwWhdpBLSB7qHrx+z/xrWe6XnHAKmvh
	cvOI/iIE8VmVPDFRXDMIh+lL0Fd3iqjZ6T98KD/tMXylS8/q34A0EobdZG/m9rYZO18414PKCm8
	rcTfalmMBsq2YgCSMDBmdKPJ9XJPmDzL9KJXEmsrmyqOaND3CMWkj1VY=
X-Google-Smtp-Source: AGHT+IFSNQkKWkFJTX+qDqCce0fRek0A/f7BNr00ipCNjedh+2PQ1ooLHxPILATPgL6zPGXMXwoF2KQFd4FOsYejKqj03Uu2dUY/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:36c:4c63:9c93 with SMTP id
 e9e14a558f8ab-375cc9adebemr2049465ab.3.1718198720347; Wed, 12 Jun 2024
 06:25:20 -0700 (PDT)
Date: Wed, 12 Jun 2024 06:25:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000614f9d061ab1504e@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem (2)
From: syzbot <syzbot+57c04b477de48032b4d4@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=104e0b1c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=57c04b477de48032b4d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a6eb32980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f3a364980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57c04b477de48032b4d4@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_ext4_sync_file_exit+0x2c/0x40 include/trace/events/ext4.h:958
 trace_ext4_sync_file_exit include/trace/events/ext4.h:958 [inline]
 ext4_sync_file+0x121c/0x13a0 fs/ext4/fsync.c:179
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2811 [inline]
 iomap_dio_complete+0xb58/0xf00 fs/iomap/direct-io.c:126
 iomap_dio_rw+0x134/0x170 fs/iomap/direct-io.c:753
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x26ee/0x3450 fs/ext4/file.c:696
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 1 PID: 5048 Comm: syz-executor240 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
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

