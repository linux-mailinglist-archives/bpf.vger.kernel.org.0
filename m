Return-Path: <bpf+bounces-64981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD40B19AFC
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 07:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2715517594A
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859E221555;
	Mon,  4 Aug 2025 05:08:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4386328
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754284114; cv=none; b=ueyh1+Lalq9+ul1A5GY1+CQcZUjpwnCdLzzRiSfJzzVTQxIa5tzKBKxnfz5whxRma/G6KR7eFn23NAoj3YPJUE4U5GUz6YTyJH1ZiIj1qFxwAtWz6BzKYjIdjl0PKv24mVvfcBTCZyqK1FhpsS1GAUjw8P3F2+0l/IrQnyiXGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754284114; c=relaxed/simple;
	bh=ZLBP3RUIikByUa7KPtiF0g+jtRkXsaeIPURdK5TfryI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lzxvxr1csqqjpFepJyxdxxgXunBOpbwQnsd46EhVo3Tff3++fxbwQBRNp4iKyHwkfoJcuZvjbapT8nTBpD5vwkXga+35JNCD0509ItMzkAF4+Or/4JiKLlNCOUW4Ol15iZ8UAZkHxK9qVGXJCH62s4IUWWgBZ7bgEhFiZtwAPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88170a3e085so125057039f.1
        for <bpf@vger.kernel.org>; Sun, 03 Aug 2025 22:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754284112; x=1754888912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHDuSz8uOADbevwcrJx5h2+exfV1RPbCBux+vztrfZg=;
        b=jtreSrtCq46NcXXjtB5Zg+sXicZllq6yJthnKszsVBWwcd5JYrWZTjx00Qjue0+zyo
         yC/DxyMt4YzDpSxlctqCv+LzeJ4q73Rtp7EMMg0zfMxvWMFVKtHJrSKWy/QByokRk2ny
         fjnR/aONnmQzch00i3mc1gJyIsVN0ZJOXKIrdh9/GsOyLev92mON3kNGfiq1+hnYKbgO
         nvbxahGrGPCXOv4nyI14RnuDOg6sLYbWwy8avy+/9pfMNYKWypBKsBD2FTyfcrSnn1YH
         cNqyu6norEeNoPGasqCY17180rvbNCXkrvWfg6TvfIFapnDz9dpP1FlBrxMlCslb5Z64
         lDLA==
X-Forwarded-Encrypted: i=1; AJvYcCW5srUxQGH143wC+vCRtujvobvvBsT9jhYFx7AppENbHiXBoeKJBIgU1eG/HHueaOrQd2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7v4EtU0ycK0D0l6AbSFmTM4vpz+qQn0RaISFygzVj4m9RBUB
	gvokq43hXCt6b60Wb1M9L5Dp7D6DU6kE7Z/Gsmh1TRnb1Z8zVbN/2Oqji1Gd4SBWeYIQQfgeqdo
	eIuh1tI+3wHIeLktKS2ob168I1sl7PsGJtBMdI1JgDDt6x5Og2/SnGNuKSLE=
X-Google-Smtp-Source: AGHT+IEfhL5kxH+ViRn+tjSPehb7rvgtjFomaPJY2Ou1a+LpGpm0byaDKQUUxSxBQ91TiRJ+aGH7Z/6kNNBRvcF/PmYwOB1Je311
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b81:b0:881:419d:4a31 with SMTP id
 ca18e2360f4ac-8816830d61bmr1261736839f.3.1754284112354; Sun, 03 Aug 2025
 22:08:32 -0700 (PDT)
Date: Sun, 03 Aug 2025 22:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68904050.050a0220.7f033.0001.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in do_misc_fixups
From: syzbot <syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1561dcf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f89bb9497754f485
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ed3d9132939852d0df
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165d0aa2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117bd834580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-a6923c06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9862ca8219e0/vmlinux-a6923c06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/042ebe320cfd/Image-a6923c06.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: not inlined functions bpf_probe_read_kernel_str#115 is missing func(1)
WARNING: CPU: 1 PID: 3594 at kernel/bpf/verifier.c:22838 do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
Modules linked in:
CPU: 1 UID: 0 PID: 3594 Comm: syz.2.17 Not tainted 6.16.0-syzkaller-11105-ga6923c06a3b2 #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
lr : do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
sp : ffff80008936b9a0
x29: ffff80008936b9a0 x28: f5ff8000832f5000 x27: 000000000000000a
x26: f8f0000007ba8000 x25: 0000000000000000 x24: f8f0000007bae200
x23: 000000000000f0ff x22: 000000000000000a x21: f8f0000007bae128
x20: f8f0000007ba8aa8 x19: ffff80008243e828 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081b73b80
x14: 0000000000000342 x13: 0000000000000000 x12: 0000000000000002
x11: 00000000000000c0 x10: 646e0773d90f24cc x9 : 73727a981a23afd7
x8 : fcf0000007bb36f8 x7 : 0000000000000190 x6 : 0000003978391654
x5 : 0000000000000001 x4 : fbffff3fffffffff x3 : 000000000000ffff
x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcf0000007bb2500
Call trace:
 do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838 (P)
 bpf_check+0x1308/0x2a8c kernel/bpf/verifier.c:24739
 bpf_prog_load+0x634/0xb74 kernel/bpf/syscall.c:2979
 __sys_bpf+0x2e0/0x1a3c kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6137
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
---[ end trace 0000000000000000 ]---


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

