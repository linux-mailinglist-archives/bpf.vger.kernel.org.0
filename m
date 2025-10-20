Return-Path: <bpf+bounces-71450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C0BF3AA2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4418C4FB5
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795062EC55E;
	Mon, 20 Oct 2025 21:08:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B12E6CAB
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994507; cv=none; b=My3QS138blWENSsBJUxxPWDtecbHFXss1DSC5RI7cfwMDWL+5WTiN8O3qm9P5SUXRHeIAztPdSMixKTFqmdi7/OiDANsW+4S20w62kPMu2ZgHHRe76qxlXJSWclnzR0AvouBIffopRJZ+XN1CIjM6yS7Ik1b/88Ns3rxofTISaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994507; c=relaxed/simple;
	bh=hxhjLCBZfNBCCzqgf9QcOOR3d4nK6IBdQqW32aYBurE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nl6VRl7betdGOBHVJwDH6NOYMvG8nBE+5je2RxXCBBeJA6Y/uwW/PYB6ykN9A2MikyvssF6cDuUNVs1VPQXgcy5aVV2rOymTr8+pK/K8n1Oz2FXKY2HZyLqaoYaP2MbGndY8qsqAUoYc/3wCsfI2qJYxnShO7VE3NEmzvQb5YIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430db6d36c6so62599605ab.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994504; x=1761599304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu7UmFKZwYM7EYVrujSk24G85KpdWniCmCnGeTN1CEw=;
        b=RvpO5EpoXz3F6kS4peRS/9Mv2gLetXlI2b8Wf45TcJ412OkJri+XwIPy7YRiAAEdRI
         y44oaJbu2bZKLXwxGea/5rxomiJLT5kBUkE6Sj9nTa2jn8Me0X6ggRY4RHx/+ef6I12h
         AKVXdtvwueKNa+7sWXbUuq49wwmtPx+7QnXR8WHvc+LAS6lgZDjRRDL/EnP/WIxT5CAG
         xVYYnBrEEWpdhk+5SMn0GGJEpI06ImeXdLz9CtHMt40qRldnmw1mPvvhfLk5NDXnF6sL
         xA1NBOl/gA/4S1lnF+WKtivWHPzzMyOme3vPjMlG8gg0oy9vp6waNlJG9ntbujAYdy0m
         dKaw==
X-Forwarded-Encrypted: i=1; AJvYcCX9E/sbXGSguXgSlDd1x9QNdi+yifYAra+g2uJdREZKdf6ZKpxvrFUMOhdT9jEUQt6O5OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiDyAGHi7kdNV6p0dzuZT/fbeEY3uSvX5jSxhImOnmKH4fvV3
	wrNECXOg6vaIWWx5USGDoubqEJTpHJbjyPVk12c3I5aqN2YJxy0wWQD+pZ5dd1uMlFdQ3TaDfr5
	fsvpPRlwaHEVmISxnioVXB61F8xMLdM1iKzeXi9vLGJkeIX4iDj9yDasqj5k=
X-Google-Smtp-Source: AGHT+IHwFfnjoIwpmNlUmVtUUXMe0VJy0ObADhZw4QPUWijMCBpDpKIyDlCxEVFHJY+z7r9ICr7Ir+ld2d8LJquRMzrwpZyjcYvG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:430:af8f:1d28 with SMTP id
 e9e14a558f8ab-430c5223e4cmr232929755ab.11.1760994504129; Mon, 20 Oct 2025
 14:08:24 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	chandna.sahil@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, listout@listout.xyz, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 'off' as d..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz

The issue was bisected to:

commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
Author: Sahil Chandna <chandna.sahil@gmail.com>
Date:   Tue Oct 14 18:56:35 2025 +0000

    bpf: Do not disable preemption in bpf_test_run().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10afe492580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
Modules linked in:
CPU: 1 UID: 0 PID: 6145 Comm: syz.4.53 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
RIP: 0010:bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
Code: ff e9 ce fe ff ff e8 10 ec e0 ff e9 be fe ff ff e8 06 ec e0 ff e9 b4 fe ff ff e8 fc eb e0 ff e9 aa fe ff ff e8 f2 eb e0 ff 90 <0f> 0b 90 65 ff 0d 27 fd b2 10 b8 f0 ff ff ff e9 17 ff ff ff e8 d8
RSP: 0018:ffffc90003797840 EFLAGS: 00010293
RAX: ffffffff81df57fe RBX: ffffc90003797a10 RCX: ffff888026493c80
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: ffffc90003797970 R08: 0000000000585870 R09: 0000000000000005
R10: dffffc0000000000 R11: fffff520006f2f20 R12: dffffc0000000000
R13: 0000000000000004 R14: 0000000000000003 R15: 1ffff920006f2f42
FS:  00005555805f5500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007c04e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ____bpf_trace_printk kernel/trace/bpf_trace.c:372 [inline]
 bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:362
 bpf_prog_bfbd7bf4bf171090+0x41/0x5a
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
 bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
 bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1414
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
 __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25b0f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe036cd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f25b11e5fa0 RCX: 00007f25b0f8efc9
RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
RBP: 00007f25b1011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f25b11e5fa0 R14: 00007f25b11e5fa0 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

