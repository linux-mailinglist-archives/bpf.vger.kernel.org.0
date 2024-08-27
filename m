Return-Path: <bpf+bounces-38131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E55BF9604B6
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42208B2379D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF3198E89;
	Tue, 27 Aug 2024 08:43:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46987197A66
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748204; cv=none; b=sU9M+1ZXpjnT3C7/MdrKMuv3/Se28WykCwcmYKonsBL0k4vQdXfS0Bm7RTWp3IwkBqjOZWqwigaUpUXnCF5z0rhIM41CC4/iGfkpeNkuoUqHz9To+OFlRJOP3/QFi1nm198fLqld+NHHppJI8t/rfasm8l4t0EqLFTytb+pnZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748204; c=relaxed/simple;
	bh=uqXQ09OZG+mGGBfN1F682nY06fkqom9Qm8QtVUIDzaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cg3WOyImzSqXg7e+DaZ62Ci0vIJ/Fsj2ER6D7ZibvYRQH3tCeon854/7ViB7gp9qeAxAMj9lgWk8bmZS23GCvmQBP/kXyAg8hLgp3Gklki/NXYAUb25IVAxgz9VxwRN5VSCFVyo4b6aVbq5ZRlgQ4M5xLWNrFcJlvhWmjC5LsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fa42463so430487939f.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748201; x=1725353001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWhGELMHbMK2mB/lYhoJt+wxjNr36ERFlN6hsd1zl1U=;
        b=fNRBlcCmdsPberdd2vvX5MG0DFIXnu3vG1hYTQPJogTxTVJoiaxPiARc4BeVPh105P
         aHv2/eg1x3xtI8wSTnO02oYoCwPsOe2TBoj8RhbjnwWztwREBBqA637//oTB0VJeYcUl
         wTnHYqdAgEniY3ihLeEAFqso7Qo8Kl+bnX6zz4W6HnqCJnI+JXcNhygyxgruvWDr5+bu
         c9t1Ic2FShBL9ZogRd6TEbscK9GkdN8cRa0cxPMLSm08wg9AzqRRvv5d4Tlqrnizo1Mx
         a0tnXhDsXmICU1RC3Or+0+ZtylPGm0U64XcuAzva0CaTHzLkDhgdlyRMoB73ypAjhIOR
         8OGg==
X-Forwarded-Encrypted: i=1; AJvYcCW3g1q1+4TigftwU+xzIhZAoQdrMKQ1Or9z15TZYKjvYlrlpf3PYFE3lF1OO2LtDBlcC3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG8m69Cvl//pHaqBsWr4Da7CzS+WJ2XC1bTCJnuv9Ohf27EmG
	0me47e8q4R8JCRzgHVUminNguoDXx9Iki6Hmy0jjUVulmte9fRnI2WYtFO6XX7Frsy1L8gu3L/x
	5J2qlxYWvRinmQygvZ9hRmSeO3T1m3iGCQ4kvQc9/Gwzk90gY3hpTgKs=
X-Google-Smtp-Source: AGHT+IF9OTQp2cy1NHfX7EuSzFZv2knlruThxP9d1hWTJ4SmCBKolG1dxR19zYlDyvYoWJM4dmbyNTrv8sS5v8phEHp85FdxPWdK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6404:b0:81a:2abb:48a7 with SMTP id
 ca18e2360f4ac-829f14698b0mr3598039f.1.1724748201413; Tue, 27 Aug 2024
 01:43:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df5f630620a63b03@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in tcp_bpf_sendmsg
From: syzbot <syzbot+7449cfb801474783f727@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb61cc674ee Merge tag 'input-for-v6.11-rc4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1415747b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eee190eab0ebaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=7449cfb801474783f727
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-7eb61cc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da1f81d9a714/vmlinux-7eb61cc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18292fa70148/Image-7eb61cc6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7449cfb801474783f727@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=0000000043fd4f00
[0000000000000000] pgd=080000004882a003, p4d=080000005bba7003, pud=080000004a4bd003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 23032 Comm: syz.0.5798 Not tainted 6.11.0-rc4-syzkaller-00222-g7eb61cc674ee #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : page_kasan_tag include/linux/mm.h:1816 [inline]
pc : lowmem_page_address include/linux/mm.h:2254 [inline]
pc : sg_virt include/linux/scatterlist.h:404 [inline]
pc : sk_msg_memcopy_from_iter+0x134/0x1e0 net/core/skmsg.c:389
lr : tcp_bpf_sendmsg+0x1f4/0x8d0 net/ipv4/tcp_bpf.c:541
sp : ffff800088013720
x29: ffff800088013720 x28: faf0000010f136c0 x27: fcf000001bb93200
x26: 000000000000018c x25: fdf00000242bc400 x24: 0000000000000001
x23: 0000000000000000 x22: ffff801000000000 x21: 00003e0040000000
x20: fff0000000000000 x19: ffff800088013da0 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000020001100
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: f8f0000008d11ce0 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff800088013af8 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000000 x4 : fdf00000242bc440 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 arch_static_branch_jump arch/arm64/include/asm/jump_label.h:46 [inline]
 kasan_enabled include/linux/kasan-enabled.h:13 [inline]
 page_kasan_tag include/linux/mm.h:1815 [inline]
 lowmem_page_address include/linux/mm.h:2254 [inline]
 sg_virt include/linux/scatterlist.h:404 [inline]
 sk_msg_memcopy_from_iter+0x134/0x1e0 net/core/skmsg.c:389
 tcp_bpf_sendmsg+0x1f4/0x8d0 net/ipv4/tcp_bpf.c:541
 inet6_sendmsg+0x44/0x70 net/ipv6/af_inet6.c:661
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x54/0x60 net/socket.c:745
 ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
 ___sys_sendmsg+0xac/0x100 net/socket.c:2651
 __sys_sendmsg+0x84/0xe0 net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: d346fed6 1a9a92f7 8b163296 d503201f (f9400001) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d346fed6 	lsr	x22, x22, #6
   4:	1a9a92f7 	csel	w23, w23, w26, ls	// ls = plast
   8:	8b163296 	add	x22, x20, x22, lsl #12
   c:	d503201f 	nop
* 10:	f9400001 	ldr	x1, [x0] <-- trapping instruction


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

