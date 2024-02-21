Return-Path: <bpf+bounces-22459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC9885E948
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BADB230E6
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96DF86AE6;
	Wed, 21 Feb 2024 20:55:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68B83CDF
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548925; cv=none; b=mSLIINdYn/JWarKSXxXjyWHme5nppl5jxyazzqnCuMF1MhPAqhaPdvIKREWhyqp5HJW3ilcYWTA/lLtSNu/XjW7OVZ8cXhVG4bs9mTnhuuBYF1pLUuM9RP70q+MKftMplUzvgowvuiK3nSzRMHQN0QZdgSI++Dqc++My6gytSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548925; c=relaxed/simple;
	bh=3xWo9OXap1/7Igo6PPyi+8XOlRZUosZbHTYR2SoSuVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WI6Ahj4tNbm9rEcFxw0aSYzEdiyfexvc1dp4ntW7o+fptWW5a1Rdb3aTWA6dROSG1Si5128pmobSd9ZivNRi5M+1u5HsR3Z0HCdHZDGfnmOzNoatmStYwHdXj5zOpkFbIAltKdMo8/4RT9yOCuleWk1IjmpPU4oe0beNsmz4dAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c751a35ee1so325422139f.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 12:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708548923; x=1709153723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SE3W7bfnzpiUUQo5IfTU/PS+pfJ8lCAQz7tmlPrY30=;
        b=M9W4iqwTJApm29IqYAmFVcuaNxHMFY/k3z3wA1HPffjEWaTfVk6ahJ75u5kuBcPpSP
         GiZSShdZYOr9t6U7A+DxTFfLgo0/YcNArpx9PregVuFDpzEAuWtIUfrXDtcXldPkS0Ks
         nNmzvYuo+vt7tj+v5a0u7Hq/6q+jJDF/K1WeqWQxAfIuRpK3iS0PG5nwh6Lv4wSDGijl
         ZAtL7gZg/VQhRKwmy76FXUZhFnzXcPcbOvo2Pa/z5cl7vyRtxG8juAVlWM5FSnvW4GD5
         4c5jQu5G9khGZN9LwMMVNsey29PHThZsrnfR9WwHYoCmLda/rMJsielWTT3aAbdJsYz6
         5lxA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ENLOXLA7jjlKLfpnwOXYNdSm9tOMHsxeQT0ONLISZbuaknjgBSk/K2zKrCv4whM6tLRh0rWSlBrmO/J0qMH8hUd0
X-Gm-Message-State: AOJu0YxnLwk5bl/Y7vr1sxe7Z2CsbBhPUK53Qii3Dvk9zCQ8M/cdgEj1
	Di2IAX4w69agSwuAUGhm9v9hIDGkFgBCWBCG+rFYE7kyj0PWyBCEWSlhSShp5UygBe86MbKf/FE
	nA1DIIvdeTYIDY9N7fOTlUWnV7mwazQmaIsV5KMNidQ8H8Xd2OEWp3EU=
X-Google-Smtp-Source: AGHT+IGNkZGXRjOUt9bPzkc1fm5hctYD/L2+rKOJZiYk3FEG+0k0qAjSMArIisyk3a029PqxRNrwbp1tVXi5WFkAIyLdhf9POXIs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2385:b0:474:366c:f459 with SMTP id
 q5-20020a056638238500b00474366cf459mr88270jat.1.1708548923138; Wed, 21 Feb
 2024 12:55:23 -0800 (PST)
Date: Wed, 21 Feb 2024 12:55:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a52c320611ea8b82@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in bstr_printf
From: syzbot <syzbot+f0d29b273acdcd3a2562@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ca10ceffbb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e7f5f0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
dashboard link: https://syzkaller.appspot.com/bug?extid=f0d29b273acdcd3a2562
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83d019f0ac47/disk-c1ca10ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49e05dd7a23d/vmlinux-c1ca10ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68ec9fa2d33d/bzImage-c1ca10ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0d29b273acdcd3a2562@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 bstr_printf+0x19df/0x1b50 lib/vsprintf.c:3334
 ____bpf_snprintf kernel/bpf/helpers.c:1064 [inline]
 bpf_snprintf+0x1c8/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
 bpf_prog_test_run_flow_dissector+0x6f4/0xa20 net/bpf/test_run.c:1359
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 bpf_bprintf_prepare+0x138d/0x23b0 kernel/bpf/helpers.c:1027
 ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
 bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
 bpf_prog_test_run_flow_dissector+0x6f4/0xa20 net/bpf/test_run.c:1359
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991

CPU: 1 PID: 8904 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00331-gc1ca10ceffbb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

