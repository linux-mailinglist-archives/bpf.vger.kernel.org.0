Return-Path: <bpf+bounces-22709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF38668DA
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 04:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B46281FE4
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 03:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6771AACC;
	Mon, 26 Feb 2024 03:49:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360D17BCB
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919357; cv=none; b=J0dJtKaoEx1LRtH7vR6dBPPSQ++mllT3XE953k0687z8xdZKT+6BgCs23FUdbGv3+r8ifw+XE9B90OqaeRmVITfXjawrzgGzn1USVz3NXp0FjsHVRcD9yXWdG/Kg9QW6NUCDSdU5MlwBTMqVWQgUml5SFXk1gqx/vt8rqcwZROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919357; c=relaxed/simple;
	bh=Kv/9ghpnZXPQShU9ARicBKeEcvIWW8nIOrSAkXJtrQY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A6pBcgk2Vy3NK6UZHXIarzezw2oh5JZ4/gy2bL5HZF9Z4XInJBHUVWsOv8O/bxIzbXqniVXC3a+jpDrbeTZf6nmdnKOKraDjIN+B5tK4NVz+zBvo48kfyTUL1twMSAs1B/0TgbDpzciAl7ApXAN5odnBeCwuWSi4vkixFca+ga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7229e855bso240385339f.0
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 19:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919355; x=1709524155;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0zDGz1LWZDnj7pbq9vHRQdQrSo5fq2Jh5AL7Ztrk2A=;
        b=JMGw7coQJHo0Wx2odT/7RSFv5QQlb+1ya29IPi/EOPUCXQ3+APajbZoQdZeUGFITLZ
         EPEzrzZJM/MFc4veWzmxSF0s5BnMYmrZoXjqqGAVftQoyaI2XmRirquH7U+wE1zhaXwz
         Gq8YHjLWvp9LUiOly36covnfxOFNUNrUKas79cxfobT2LsDxQsQYHD5EEEz538z6tRQo
         ej3+JxVZ/64eJaq2QTkX6P/t1BPV8hjeIhXnvI+eIeZaJAmGZAPr46XF2TepFcsBVWq1
         7jTYGUIP/a+OvtPPt7SEPK+aIIgDlIV9v2N0tEvZwBCHJDnVQ1sJ9nw2RLLqTxjATVi3
         PbBA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+CyZuK+H82Ho2a1TdBi+pyna304sHPmtF9yKJ4rIEHm3Jq8BXSLHFLF9t0RabyvslaPL9UuoodcnSIyMR11NXX83
X-Gm-Message-State: AOJu0Ywns+rsoMPFM4ctmlEW7UNevy7nqjx7HlUO+B/ZOWm/ZRpJhlVw
	fRsWPkKnQl5JnldojLhMk8DXu5gvYzJQzRQaaKxvaEfB5DJeUfuZaymXYHD52hsUZA3JmCrUdxz
	RJTSxsDKOooZo+7sVdiEgZtBwvRJXoDFAJkJvAAuBy3Pr+eVsmQdAyt0=
X-Google-Smtp-Source: AGHT+IHFVt7LsA6twkpn6/boz58rkQDQVkGx3V25ZV4MR7zZ40ZPzM8o8MC8I8+EfFjMh2OG5QAJBELsBDYfa3M6tanwS/3nz5U4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349f:b0:365:7607:3f4b with SMTP id
 bp31-20020a056e02349f00b0036576073f4bmr472012ilb.2.1708919355150; Sun, 25 Feb
 2024 19:49:15 -0800 (PST)
Date: Sun, 25 Feb 2024 19:49:15 -0800
In-Reply-To: <000000000000ed666a0611af6818@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d1939061240cbd7@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in dev_map_hash_update_elem
From: syzbot <syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    70ff1fe626a1 Merge tag 'docs-6.8-fixes3' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1762045c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cf52b43f46d820d
dashboard link: https://syzkaller.appspot.com/bug?extid=8cd36f6b65f3cafd400a
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110cf122180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142f6d8c180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-70ff1fe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc398db9fd8c/vmlinux-70ff1fe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d3f8b72a671/zImage-70ff1fe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000010 when read
[00000010] *pgd=8423f003, *pmd=fe0d5003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 2983 Comm: syz-executor360 Not tainted 6.8.0-rc5-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __dev_map_hash_lookup_elem kernel/bpf/devmap.c:269 [inline]
PC is at __dev_map_hash_update_elem kernel/bpf/devmap.c:972 [inline]
PC is at dev_map_hash_update_elem+0x90/0x210 kernel/bpf/devmap.c:1010
LR is at get_lock_parent_ip include/linux/ftrace.h:977 [inline]
LR is at preempt_latency_start kernel/sched/core.c:5843 [inline]
LR is at preempt_count_add+0x12c/0x150 kernel/sched/core.c:5868
pc : [<803e5f34>]    lr : [<8027b29c>]    psr: 60000093
sp : df96dda8  ip : df96dd68  fp : df96dde4
r10: 00000000  r9 : 828f71c0  r8 : 8417bb10
r7 : 00000000  r6 : 20000013  r5 : 8417ba00  r4 : ffffffff
r3 : 00000000  r2 : 00000010  r1 : 00000000  r0 : 20000013
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 84656480  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: NULL pointer
Register r2 information: zero-size pointer
Register r3 information: NULL pointer
Register r4 information: non-paged memory
Register r5 information: slab kmalloc-512 start 8417ba00 pointer offset 0 size 512
Register r6 information: non-paged memory
Register r7 information: NULL pointer
Register r8 information: slab kmalloc-512 start 8417ba00 pointer offset 272 size 512
Register r9 information: non-slab/vmalloc memory
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdf96c000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Register r12 information: 2-page vmalloc region starting at 0xdf96c000 allocated at kernel_clone+0xac/0x3c8 kernel/fork.c:2902
Process syz-executor360 (pid: 2983, stack limit = 0xdf96c000)
Stack: (0xdf96dda8 to 0xdf96e000)
dda0:                   df96ddc4 00000004 00000000 1b98af0a df96dde4 8417ba00
ddc0: 824aeaf0 843ef140 8442a040 8365a9c0 00000004 8417ba00 df96de14 df96dde8
dde0: 8038c0b8 803e5eb0 00000000 00000000 80884220 8417bab8 8365a9c0 8365a9c0
de00: df96dec8 843ef140 df96de6c df96de18 8038d040 8038bec8 00000000 00000000
de20: 8027b44c 00000004 20000140 00000004 00000000 8442a040 20000200 00000000
de40: df96de6c 00000000 00000020 df96dea0 00000002 20000200 00000020 00000000
de60: df96df8c df96de70 80392aa0 8038cdf8 8088300c 81856650 00000000 841ee000
de80: df96dee0 df96dfb0 df96dea4 df96de98 80884220 df96dee0 df96dfb0 80200288
dea0: 20000200 00000000 00000008 00000000 00000008 8041ad98 841ee000 ffffffff
dec0: df96df2c 80200b9c 00000003 00000000 200000c0 00000000 20000140 00000000
dee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df40: 00000000 00000000 00000000 00000000 00000000 00000000 df96df94 1b98af0a
df60: 8134e0a0 ffffffff 00000000 0008e058 00000182 80200288 841ee000 00000182
df80: df96dfa4 df96df90 80394ea4 80392830 20000200 00000000 00000000 df96dfa8
dfa0: 80200060 80394e84 ffffffff 00000000 00000002 20000200 00000020 00000000
dfc0: ffffffff 00000000 0008e058 00000182 000f4240 00000000 00000001 00003a97
dfe0: 7e973c70 7e973c60 000106cc 0002e810 00000010 00000002 00000000 00000000
Backtrace: 
[<803e5ea4>] (dev_map_hash_update_elem) from [<8038c0b8>] (bpf_map_update_value+0x1fc/0x2d4 kernel/bpf/syscall.c:202)
 r10:8417ba00 r9:00000004 r8:8365a9c0 r7:8442a040 r6:843ef140 r5:824aeaf0
 r4:8417ba00
[<8038bebc>] (bpf_map_update_value) from [<8038d040>] (map_update_elem+0x254/0x460 kernel/bpf/syscall.c:1553)
 r8:843ef140 r7:df96dec8 r6:8365a9c0 r5:8365a9c0 r4:8417bab8
[<8038cdec>] (map_update_elem) from [<80392aa0>] (__sys_bpf+0x27c/0x2104 kernel/bpf/syscall.c:5445)
 r10:00000000 r9:00000020 r8:20000200 r7:00000002 r6:df96dea0 r5:00000020
 r4:00000000
[<80392824>] (__sys_bpf) from [<80394ea4>] (__do_sys_bpf kernel/bpf/syscall.c:5561 [inline])
[<80392824>] (__sys_bpf) from [<80394ea4>] (sys_bpf+0x2c/0x48 kernel/bpf/syscall.c:5559)
 r10:00000182 r9:841ee000 r8:80200288 r7:00000182 r6:0008e058 r5:00000000
 r4:ffffffff
[<80394e78>] (sys_bpf) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf96dfa8 to 0xdf96dff0)
dfa0:                   ffffffff 00000000 00000002 20000200 00000020 00000000
dfc0: ffffffff 00000000 0008e058 00000182 000f4240 00000000 00000001 00003a97
dfe0: 7e973c70 7e973c60 000106cc 0002e810
Code: e595210c e1a06000 e2433001 e003300a (e7924103) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e595210c 	ldr	r2, [r5, #268]	@ 0x10c
   4:	e1a06000 	mov	r6, r0
   8:	e2433001 	sub	r3, r3, #1
   c:	e003300a 	and	r3, r3, sl
* 10:	e7924103 	ldr	r4, [r2, r3, lsl #2] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

