Return-Path: <bpf+bounces-75109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A5C710EA
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 21:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9AE242B369
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 20:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4288362127;
	Wed, 19 Nov 2025 20:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEA2698AF
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585077; cv=none; b=YueB2+J/hkxWhD4x85uHh4jNbF1wOzsIfE6gtGSabMtrEsoutzMDeQGnl5ryL3TAHEb6897BWIi5nC2NpIaUvtgALL08ETrxOQMTo6ty+n6pu5x21wAxaQoYuUMBlh8gm79MfwdCH/FXVI43z7ZLfwnZTxHoVeuyz9GF3HQ86Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585077; c=relaxed/simple;
	bh=+Z3+bLESk/0SzMVGNvnp7w2sq7gFUw5i0Gc58/GPqxM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qZsf/A7YaOaD75VNtoL+iI50HinFEO2+hQ3Ievk/aMprpvYfbmwlZw5EcXCX69jC0FVGyAD2xV+5FrUQMI50qoH5Y9siIIYP7B5tEvS/1H6aslo9hLpj1yEntO5OWRRKM4yCuSSzKhIqYLz+/FkqSSWl+/BXD1xORpW3ZLFIE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-433783ff82aso2557715ab.1
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 12:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763585075; x=1764189875;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVDtu/Rp+lPQNYcCVr4DUn+/8TyqiaxBRWusv82tbVI=;
        b=fXAHCn0d1ai/mQ5hpfdIl1glq3q0fH9BN76BX2wozhieliknqwOuRUuFxSJzb7SBYW
         XSnVIM13bQFNOpi/sLVvCId6PIOlRhBeyCvYHoXVDI5Ua20T4/cSsa3plT2sKrehbiEi
         eYEnF6hmyjm2ZAuZUQLWA/btW1/OcJotk1AjWyepE42ZuJbUXcBbTjnZRhlIWhfi/dZW
         o/MjVb/qXHVd7HyhBNpTYPPJ/qV0jhvtcmnua3xKKXitGkuas5ND/6Qxt7SwYFaYWgDF
         emA8DFqS34sZC8A4x/mA1dNhoJLm4nAHgd0aTB69wEEhwmosR0H8x2ghK+JJia5k+KY8
         N/4g==
X-Forwarded-Encrypted: i=1; AJvYcCX3XjEjH1ULPjoTk+Xoi2980iJTkUPigeS49WSlHtDQJaVdLyR/pANwgkb+audRAfRBGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7zdXyIOEmTsZL6IzIAFE85ev54gAAfRXwN29aYkzWtwoQ50w
	V1PZAatXVFEwDdAMgHYXeiVH9gJGgOQi7ilBOfRq5orxxTPoYLx+l+UyFtzHNHN17fltQMcOklJ
	fgHHitus4MlFP0oNFl8I8+LKDcitQD4AUKGl3jRMaLM1/RVVgS9im7DdNtw0=
X-Google-Smtp-Source: AGHT+IGVn8GrEjKOPtV7FodlXsB1sfK4h090hAQK7DfVmBw3TNv7l6Tq/saj5WGXrhy3MxwrfIft9sd32Xh0dIijXWi6yrZ0cXHV
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:433:7f29:929e with SMTP id
 e9e14a558f8ab-435a9e19c61mr3797525ab.31.1763585074928; Wed, 19 Nov 2025
 12:44:34 -0800 (PST)
Date: Wed, 19 Nov 2025 12:44:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691e2c32.a70a0220.2ea503.0020.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING: kmalloc bug in bpf_prog_alloc_no_stats
From: syzbot <syzbot+d4264133b3e51212ea30@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0c1c7a6a83fe Add linux-next specific files for 20251117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12c86692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78555cc0f7025c00
dashboard link: https://syzkaller.appspot.com/bug?extid=d4264133b3e51212ea30
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30639e6c3546/disk-0c1c7a6a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88fdcd914c22/vmlinux-0c1c7a6a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/087028e72d0f/bzImage-0c1c7a6a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4264133b3e51212ea30@syzkaller.appspotmail.com

------------[ cut here ]------------
Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0 mm/vmalloc.c:3937, CPU#1: syz-executor/6076
Modules linked in:
CPU: 1 UID: 0 PID: 6076 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:vmalloc_fix_flags+0x9c/0xe0 mm/vmalloc.c:3937
Code: 81 e6 1f 52 ee ff 89 74 24 30 81 e3 e0 ad 11 00 89 5c 24 20 90 48 c7 c7 a0 db 96 8b 4c 89 fa 89 d9 4d 89 f0 e8 85 8d 6c ff 90 <0f> 0b 90 90 8b 44 24 20 48 c7 04 24 0e 36 e0 45 4b c7 04 2c 00 00
RSP: 0018:ffffc900043cfb00 EFLAGS: 00010246
RAX: a51e1d8e991b0100 RBX: 0000000000000dc0 RCX: ffff888031d2bd00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc900043cfb98 R08: ffffc900043cf827 R09: 1ffff92000879f04
R10: dffffc0000000000 R11: fffff52000879f05 R12: 1ffff92000879f60
R13: dffffc0000000000 R14: ffffc900043cfb20 R15: ffffc900043cfb30
FS:  0000555589c86500(0000) GS:ffff888125b74000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa89645c470 CR3: 0000000079642000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __vmalloc_noprof+0xf2/0x120 mm/vmalloc.c:4124
 bpf_prog_alloc_no_stats+0x4a/0x4d0 kernel/bpf/core.c:106
 bpf_prog_alloc+0x3c/0x1a0 kernel/bpf/core.c:153
 bpf_prog_create_from_user+0xa7/0x440 net/core/filter.c:1443
 seccomp_prepare_filter kernel/seccomp.c:701 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:738 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1990 [inline]
 do_seccomp+0x7b1/0xd90 kernel/seccomp.c:2110
 __do_sys_prctl kernel/sys.c:2610 [inline]
 __se_sys_prctl+0xc3c/0x1830 kernel/sys.c:2518
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa896590b0d
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffe0659e8d0 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007fa89662cf80 RCX: 00007fa896590b0d
RDX: 00007ffe0659e930 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 00007ffe0659e940 R08: 0000000000000006 R09: 0000000000000071
R10: 0000000000000071 R11: 0000000000000246 R12: 000000000000006d
R13: 00007ffe0659ed68 R14: 00007ffe0659efe8 R15: 0000000000000000
 </TASK>


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

