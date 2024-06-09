Return-Path: <bpf+bounces-31684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F709017E2
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 20:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9AB281190
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82A4AEC8;
	Sun,  9 Jun 2024 18:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E143AC4
	for <bpf@vger.kernel.org>; Sun,  9 Jun 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717958546; cv=none; b=N1kydD5oungvoQjwmky8wuwfpT+x6d69yRHarQ1miw5cWLg2xtjtLqsRTou4QadecUk1afxtUfFUFU8VDM50Vr1aKNPytzBlF2n/ipysnYjHc8yXKSn4dDcyzx+aeXAcZUFUahhXh/RiazSI3J1qsPnpbLn30awsvVVOXHZAG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717958546; c=relaxed/simple;
	bh=F7GIGH+4JqYpVd1KxGbEJVKtLbaeDms2SF4QYc67dzg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q4f4U/61/kw5m/M4AgXTCJldPNgwsrLINM0CsxoJ+vDs3Z+sZCeiWATpUVyCq8Cz7s9Pk7aNg3sjv9SuSJRyr1gRASw3MI9n/F4HmcL/UgBGmlhVb/qVu4GvGjCSS+lb//posSg9sadRDIQIizPTIUkTRPoR723PsV9w2YW5cAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so489745939f.0
        for <bpf@vger.kernel.org>; Sun, 09 Jun 2024 11:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717958544; x=1718563344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1ss3NrQCviCzB7CF1DL9ZjeQDuVbpAJRYuPYPwddfU=;
        b=i7EdriwH9ALqZhFwATqsbxM7x0ngm+OPzGsFUgTh4uW877TCTNf9Z5A7MiKhyqIjW1
         gFbUd2MYkl/Ov+8TWvzoU7P5wczoD+CuB7WQDQWLuoa3E7PV25hn5liRK1Cfbs1SDYFC
         Sjjss8TiKxjbS16sAF3K4imBzHt+S7Z9vW/7FwnUvzG5fx69eOtRZ4ALtJ/PqXr+0DL0
         Cjk35NORdVHcN9WecfsoTnfBV6hOXvCMQhsVLTZgG9zMspC/NiR8rqVLdLWhIe4+XP33
         13XGtmIWAyDmzJz//lPwcr6Ps4FGltufS13nGtezFsa2w5vd7WlEzlUepibJ9loQRaY5
         Ke7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhmw1vpu//7YCWbpPMpN8aDClVXqvclGRookJ+qmqEWb9dCgxkTkNUaFHBEanXlSYYpS9/1zG8trkTLYLG0MMjT1Z9
X-Gm-Message-State: AOJu0Yzata1AzKsbD9ZyNVtNeGTB/BphTFsweYIamgsyUyqq3nehIPzF
	POEKnwE1H/4wWBzZC+rsZ97+nkO7qsNVYEC4H+f2mzGVdbj7RwWnXS8WqWI3l1vnomKgg0TpDva
	Og1WFNL9P+ipw62abF7rdniAhrQfz91307atScDEwurRcfkG80V+h7ic=
X-Google-Smtp-Source: AGHT+IHZuV3bsqDjnsZQIQwxJliYbuvQ+doJpSjpXInum4m7kv5jcxxM02Mee06+k7N5C6itEya37lRezSh00AXUV4Bif0mIuc+h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1544:b0:7eb:75e9:8f2b with SMTP id
 ca18e2360f4ac-7eb75e990demr14788439f.2.1717958544049; Sun, 09 Jun 2024
 11:42:24 -0700 (PDT)
Date: Sun, 09 Jun 2024 11:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1dd75061a79647d@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull (2)
From: syzbot <syzbot+d190d0aff2b3fd6ee95a@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b53022980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=d190d0aff2b3fd6ee95a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14267dfc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15402886980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d190d0aff2b3fd6ee95a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoll kernel/bpf/helpers.c:504 [inline]
 ____bpf_strtol kernel/bpf/helpers.c:525 [inline]
 bpf_strtol+0x7c/0x270 kernel/bpf/helpers.c:519
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 xdp_test_run_batch net/bpf/test_run.c:313 [inline]
 bpf_test_run_xdp_live+0x10a9/0x2f70 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0xf02/0x1a40 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4269
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 xdp_test_run_batch net/bpf/test_run.c:313 [inline]
 bpf_test_run_xdp_live+0x10a9/0x2f70 net/bpf/test_run.c:384

CPU: 0 PID: 5051 Comm: syz-executor174 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
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

