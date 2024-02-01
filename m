Return-Path: <bpf+bounces-20987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF39A846208
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4EDB21E4B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2B3A1BA;
	Thu,  1 Feb 2024 20:44:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303E3B18C
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820272; cv=none; b=ZNoQXFAWRmiDmdH5KnvWq14zXgWTR2w65jbJ6v5QnwGJ9bl7UoS6rp9MWDKintAWsdtc03w+0gcsh7nM+kRgr237hNF1ufVMw8sjVxe3nM/KwrTR2+0LVN4hNYJ9acTjILF1fBcjDZUw/otQiZekTnDz7UDDRocuFR6UGNFwr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820272; c=relaxed/simple;
	bh=Mvi21yqYkpHvW15IKAFRhnUigRYgPxJrbYhCyg1rxYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rjFs8pssmw7AajgN0loi0BYCWqI/Z2RaMQtKzpd5YmCOcTDisrXOOrA4IvJ1+zj/ULKIMvaoS1fwlfopVgDxyD6AUWjt0kgjxlbtS0WxAD/Z6YliGTxNfWzSOTn0EmaxLPlDlrsald7ex/Wxo0KbMQNLCRuWrhA2WvaoHQhPHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3637fbf4d1eso11773135ab.1
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 12:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820270; x=1707425070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/oFNeBc2h/vg/VplsbvV+FmlhdDnizmFYiiNw1gpQs=;
        b=vxRpuK9PPlo9Eo/SjG1rXO657FRKOK1/YbfwI2NYYWDVSO8kaD9KbwA01PTpp7hHbi
         oOfmITmZ58op2g06IElCnYBac6d1gKo+iHA86shSUrP/ulpKawR2IdvlxX1+sYYFBZht
         Jlma1dbWbWfKX7eZdwIAZ49CSMVZDFDKJUKZowMa3YcCmswqVjSa8e5sv6kmuH1ulrEb
         WlpaT5jh7ywyW/QgsPLG7IYc7fJyDzBy16LlDXPgRURnbB4qf2kE/cwzy6ovzWaA0zUx
         bUthI7A8tHN4pyo2fzLvAp91cpQsQbb24LwFw2MvGPMul1BZ33cPM4kF0QvCy/hxtiAF
         5EXg==
X-Gm-Message-State: AOJu0YzQa3lnwixKPQKeC3nyHSAcxcrQeQi7Zyl2iwCRA95bFibSHUns
	mplnz0MzeWSW5zLwssdnMycXDX52fGh8J1PuXJPa+yLxEfoHtRergoI0zR7yjb2zcBK8m/TbHr2
	aZAu8RkvPZeGXa08B0XQdTW9PrYcvGiWr65uvzLXUN0FntAPAE6qhjaQ=
X-Google-Smtp-Source: AGHT+IFkcwU/iOgmiK7lpWN24R/CyAiTTYJbHdl1MSeCwTPZMBvQxGG+Y8Z0g9lOvDmnJqdC/8RCgWMVOy+X9IKVEFhBUKL0zJds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:363:9211:a723 with SMTP id
 i12-20020a056e021b0c00b003639211a723mr532381ilv.2.1706820270047; Thu, 01 Feb
 2024 12:44:30 -0800 (PST)
Date: Thu, 01 Feb 2024 12:44:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e447290610580f33@google.com>
Subject: [syzbot] [bpf?] linux-next boot error: WARNING in register_btf_kfunc_id_set
From: syzbot <syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, sfr@canb.auug.org.au, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51b70ff55ed8 Add linux-next specific files for 20240201
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b05288180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88d85200b6a62126
dashboard link: https://syzkaller.appspot.com/bug?extid=0e9c9f96dbdc31a8431b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2d3a98d07e5/disk-51b70ff5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d525430ddf13/vmlinux-51b70ff5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d1ec0b50066/bzImage-51b70ff5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com

greybus: registered new driver hid
greybus: registered new driver gbphy
gb_gbphy: registered new driver usb
asus_wmi: ASUS WMI generic driver loaded
usbcore: registered new interface driver snd-usb-audio
usbcore: registered new interface driver snd-ua101
usbcore: registered new interface driver snd-usb-usx2y
usbcore: registered new interface driver snd-usb-us122l
usbcore: registered new interface driver snd-usb-caiaq
usbcore: registered new interface driver snd-usb-6fire
usbcore: registered new interface driver snd-usb-hiface
usbcore: registered new interface driver snd-bcd2000
usbcore: registered new interface driver snd_usb_pod
usbcore: registered new interface driver snd_usb_podhd
usbcore: registered new interface driver snd_usb_toneport
usbcore: registered new interface driver snd_usb_variax
drop_monitor: Initializing network drop monitor service
NET: Registered PF_LLC protocol family
GACT probability on
Mirror/redirect action on
Simple TC action Loaded
netem: version 1.3
u32 classifier
    Performance counters on
    input device check on
    Actions configured
nf_conntrack_irc: failed to register helpers
nf_conntrack_sane: failed to register helpers
nf_conntrack_sip: failed to register helpers
xt_time: kernel timezone is -0000
IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
IPVS: ipvs loaded.
IPVS: [rr] scheduler registered.
IPVS: [wrr] scheduler registered.
IPVS: [lc] scheduler registered.
IPVS: [wlc] scheduler registered.
IPVS: [fo] scheduler registered.
IPVS: [ovf] scheduler registered.
IPVS: [lblc] scheduler registered.
IPVS: [lblcr] scheduler registered.
IPVS: [dh] scheduler registered.
IPVS: [sh] scheduler registered.
IPVS: [mh] scheduler registered.
IPVS: [sed] scheduler registered.
IPVS: [nq] scheduler registered.
IPVS: [twos] scheduler registered.
IPVS: [sip] pe registered.
ipip: IPv4 and MPLS over IPv4 tunneling driver
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set+0x261/0x290 kernel/bpf/btf.c:8131
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240201-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:register_btf_kfunc_id_set+0x261/0x290 kernel/bpf/btf.c:8131
Code: 16 e8 b3 fb db ff bd 0b 00 00 00 eb 0a e8 a7 fb db ff bd 0d 00 00 00 89 ef 4c 89 f6 5b 41 5e 41 5f 5d eb 45 e8 90 fb db ff 90 <0f> 0b 90 e9 22 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c da fd
RSP: 0000:ffffc90000067940 EFLAGS: 00010293
RAX: ffffffff81b7d510 RBX: 0000000000000000 RCX: ffff888016a98000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81b7d311 R09: 1ffffffff1f0b5bd
R10: dffffc0000000000 R11: fffffbfff1f0b5be R12: 1ffffffff21e0e1d
R13: dffffc0000000000 R14: ffffffff8caa77c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fou_init+0x50/0x110 net/ipv4/fou_core.c:1239
 do_one_initcall+0x238/0x830 init/main.c:1233
 do_initcall_level+0x157/0x210 init/main.c:1295
 do_initcalls+0x3f/0x80 init/main.c:1311
 kernel_init_freeable+0x430/0x5d0 init/main.c:1549
 kernel_init+0x1d/0x2b0 init/main.c:1439
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
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

