Return-Path: <bpf+bounces-41840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9199BFC4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66928334D
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2113D62F;
	Mon, 14 Oct 2024 06:07:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11E33998
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886050; cv=none; b=q6vBvmkrlR5CwfYWvKUq45eY0OFS1C45F8V8QpP06hMoqEaLCrNA5tmbPOCoPImlyYTdU6vW3xtME2PhSv6CA2XTp0rfyZbDhghtPHvmvSGZQirvJWgzheNtr/t57eEk9Jh95Ptkno9yvbXaQpngj/6DypW02ZZ03YhwrLX7YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886050; c=relaxed/simple;
	bh=rVM3f+e8DUAY/SAHTBIRHsqYfhj23ZEGnIPV6EVppA4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qWREtITm2kNzwPkimdBgTLGzF5jys5Eb2hqy5Rxfdn04BUMlM/TgGz9FldXGvloRoD2yZDsCakBWRJsjXdt5gc83Tb3+TkZSaLygbpNDklrNXdQXnS8szNSjw6n/bVhZXqo/ze7vfjGWA5PH+76vKyBAfomfaVsrwzupPQRVTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-837f97fcc95so213651439f.3
        for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 23:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886048; x=1729490848;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=La2ZS7cTpq8ZFy5JLjmB577+h4tJu+TdVzV6UaYHKP4=;
        b=WzxD8rBhzRf5vRjV92gqXYMexZiqUKTvpAdXDTbsbxbEkt4hWjA15dZtS5G2lFloEw
         svA0FX2V64KiN6U19G1aHydeTVAa8IbiEmmsJcTn/7TPO+0gAgufDDmoOugS979wf7kt
         tZ3MUqst9KnpMijSvWXpYOz5ASOLHQII/SvwHQMPWPwCqTZKuS/eseFlMueKRjxIs9yw
         okB/zwy50Xf6uXdHZ0OTdOwZ1OZBDGN5eISVu2HLVm84qHauwHM7vNKykSaUstPCfgFT
         i3xTALkTQm//o02HaCDxcFxCV7uqy+P65AfhkhrrloCAOMIRh9BIZfcY1Orv+c75ejHF
         Rk/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKljFdXYRHDT0Ap5LVTJSw1+dS+F+55mkWtThCY57jI3ffX45WoutXK/vYgOREgkTdw48=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpcfv9NPZ+8ngP1tacjTtihTPieXAic5RPh2y3/mshSNZPshaN
	Rcvujz/hIRfygwc015lTbiHph+/HjbQPQmw/vX/pYHmWXrhuEEXlaKHD30sit+SKcz6k9MiG5PA
	9DewwiJynktpiBiyy0wbecWJeOi2PLpQvUxXYCL1qFwKxdnVE2+VBiVE=
X-Google-Smtp-Source: AGHT+IHKBuQFlMiLYh11Hx/Rf7z8ZA3zD9cUDj0yeQ6Gq3rhH2SyoLWZ1w9INhjy81LWJEmDls/KmisD0xs5R7bwGXY+8JyFf2RW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a3:76c3:fcb0 with SMTP id
 e9e14a558f8ab-3a3bce16c4fmr39353735ab.26.1728886048035; Sun, 13 Oct 2024
 23:07:28 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:07:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb520.050a0220.4cbc0.0041.GAE@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in __mod_timer / kvfree_call_rcu
From: syzbot <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148ae327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
dashboard link: https://syzkaller.appspot.com/bug?extid=061d370693bdd99f9d34
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79bb9e82835a/disk-5b7c893e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5931997fd31c/vmlinux-5b7c893e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc8cc3d97b18/bzImage-5b7c893e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu

read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
 schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]
 kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
 trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
 bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
 bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
 __sys_bpf+0x2e5/0x7a0
 __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
 x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
 __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
 add_timer_global+0x51/0x70 kernel/time/timer.c:1330
 __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
 queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
 kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
 worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound kfree_rcu_monitor
==================================================================
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state


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

