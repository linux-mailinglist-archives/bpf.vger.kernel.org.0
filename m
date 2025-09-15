Return-Path: <bpf+bounces-68418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018DB58498
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0974C5EFB
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889382FE582;
	Mon, 15 Sep 2025 18:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B62F49FF
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960976; cv=none; b=fdQP4lG/kIRWJj1KEQMTEEU9CGt4UM7jtIrTmGGFgY1AsxT7Yk3Lv7HajGtKSrNRMwAxNSJAB1DjSKwE91iwmbQ5hYFlsBtnr/JVA2wSSb5qbIaR3i4UPwoYdAOh5UJ1IeVjDuyiL+mwTHp5C7CAUsuOWVvGlEaZxVUksSSmgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960976; c=relaxed/simple;
	bh=D5cABf7LoEUXWN774P+0NrsSFL+snqLtJT78uiJIWrs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NcSEi6n6zmRviI0/ZkBoLvqkPwjj2IobrZyYaAjPM80PKQwsqTAQxnOe4ylMFvA14RVJsHqs3ZFNvCi93J4dNUbNtM5BWFY4YcCUEMGZYlOgH7g4Ud5qDm4SouUa9A5D/Q5xNJXK0JM8yQL15rhwhKr2yYAttnMiE64bBfRYoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-424074f3f83so31205385ab.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 11:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960974; x=1758565774;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlz6DvMfA5JM5IuX/yTSEn01bff8JeFxpsYtvIUSfkw=;
        b=mSknXQdtNbeVKy03h152zEI1m7fjv3+DHOK/bJDl4vIxGHgcvPIGpm5SPTD447/Adf
         rd9qW+Uz8Q+qEpKCt2p82X1E61EzvwelEPUNHduXxzcia/nAx/bKfuzGdeZMryQkFIUU
         yFkSJbZYse3dLnV8kAEMeGov93CXTvTd9rdg+iyVnX23qESM8rAwlyxRMnV6Ndtvj/ak
         Ck6UimgecqLHfHGoIsmew3A3oH8+gT0JEk463d6ZmwAwnmvDeFS+Ut+VmwbcxUX9FfDp
         v0XAlo72fiB57HxYnMWnG23ubXbLU9LxH1e+Nosz1KL+MROekzfDCZiKfW9V+dAdKuFu
         OuBA==
X-Forwarded-Encrypted: i=1; AJvYcCUirACARTdsHZ48I6vnq0kFZjnO87FqXADe5akqulUGkcWNmsI6S/wFCxcTUtSka1im5VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKUSaV2W3sdhyn3OHmQngvZKfdfvijS2iCxOMuMXPZDWtBKEz
	IRqm8yuLE7ISo5gNtd3jPKaFI6978XU8vSaKOk5JiSV1B5Vvcl3A4kpgLZHBDm0N4kf5kmxqKXI
	STFpaH9Q5I8bww40WDmn4WVOTobicbgKu4XBnZofXyRSyYjJS/nkL7n6NdH4=
X-Google-Smtp-Source: AGHT+IEehvelCw9k6o9gjCvd/Mewx040TiNxLCYkUtllmeQtyas/7zGwlj8YBtLqWmFRVF9RH7hfW4XAa9fHHcN0Mv8KNOaiuiyU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:424:70f:f014 with SMTP id
 e9e14a558f8ab-424070ff1b4mr42374635ab.10.1757960973803; Mon, 15 Sep 2025
 11:29:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:29:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c85b0d.050a0220.2ff435.03a5.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in do_check (2)
From: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d1947c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355f934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12170e42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8eff1302251/disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1009d8f3246e/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5ba227871658/bzImage-f83ec76b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: scc exit: no visit info for call chain (1)(1)
WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 maybe_exit_scc kernel/bpf/verifier.c:1949 [inline]
WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 update_branch_counts kernel/bpf/verifier.c:2040 [inline]
WARNING: CPU: 0 PID: 6062 at kernel/bpf/verifier.c:1950 do_check+0xe228/0xe520 kernel/bpf/verifier.c:20135
Modules linked in:
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:maybe_exit_scc kernel/bpf/verifier.c:1949 [inline]
RIP: 0010:update_branch_counts kernel/bpf/verifier.c:2040 [inline]
RIP: 0010:do_check+0xe228/0xe520 kernel/bpf/verifier.c:20135
Code: c6 05 35 d3 b6 0d 01 90 48 8b 7c 24 10 48 8b b4 24 e0 00 00 00 e8 28 8e 00 00 48 c7 c7 80 f6 91 8b 48 89 c6 e8 a9 a1 ac ff 90 <0f> 0b 90 90 e9 a8 fc ff ff e8 9a 04 e9 ff c6 05 c1 d2 b6 0d 01 90
RSP: 0018:ffffc90003b9f1c0 EFLAGS: 00010246
RAX: bb0e1817e9dd7600 RBX: 0000000000000000 RCX: ffff88802faf0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90003b9f528 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa22c R12: dffffc0000000000
R13: ffffc90000a7e0a0 R14: 0000000000000000 R15: ffff88805b1ebd00
FS:  00005555720d8500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 0000000075b7d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 do_check_common+0x1949/0x24f0 kernel/bpf/verifier.c:23264
 do_check_main kernel/bpf/verifier.c:23347 [inline]
 bpf_check+0x1746a/0x1d2d0 kernel/bpf/verifier.c:24707
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2979
 __sys_bpf+0x528/0x870 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff4c0d8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb05e37d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ff4c0fd5fa0 RCX: 00007ff4c0d8eba9
RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
RBP: 00007ff4c0e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff4c0fd5fa0 R14: 00007ff4c0fd5fa0 R15: 0000000000000003
 </TASK>


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

