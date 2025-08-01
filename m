Return-Path: <bpf+bounces-64876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD7B17FEB
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5249A1C20B42
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810F233155;
	Fri,  1 Aug 2025 10:08:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186C1C3306
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042918; cv=none; b=rppHmodkUI3pjRppa1S7IDGj32pBw5PhcB92WcUF98abpSWdyrmSHRhRd07dBdD/72L9Dj0rcC4e7ApIhuj19QwbRwmSESCho5gsAr5DAibjMyIOa2XcW4g//2Ir50krW+IXIEkCMkxvKI55euhP/AjSNIjcSRVahlYK2h4z/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042918; c=relaxed/simple;
	bh=k00Wu+AKjQQdOE/pjpz5y5D2HK7NNRH2IVBzpOeN6yo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J8wh4UHKnmy29O5/nNMQv5nYg24ygAhns5IIuS99nwoiJFAXzpw8baREQ+89IWi80CG8V8H/fGnOTA0DW2sApu76JczZWqG+PUSADRpc/IEksc7DZ+xXRs69p/m2lCKm0bq6Jrgg7/0zXZHfmYKuFDQ1DXG5CGdscaVJ5cKtxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c7aacf746so107334839f.3
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 03:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042916; x=1754647716;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w7rtn71IA3v6fWvnpRTNyOOQWiNby/MER9Gaoys718=;
        b=eN13Vr0X492xHT0tJ5cZ7ZMwrGm16dJEKBDBkIGO+Ko23vZ3LvwDo3Cx7LBWMusq+v
         +XnSgqRuHpaL/FJvUljZFUCFR2TDqD4wtwOlEUr198L4EmKBt9cOCZXzVf4Lu54ppvVE
         u4OXK1KufH7wuskQWXuub6srgXL0uF7Jy+Obr7oG8yK3j4IeXFNYN5jW2TiRVrwfW/lO
         IXb02qf+UDj8y43G6FuhKqmoSUNzhyPC6qUkmbrsf/N3Sx1thYpZjzvVAbzLca+dOl0q
         7SVCgZ3GfFyaCC73ZApcwa3Moll7fojPn88As9UK7j+HgUyrPRkLojl7+nt7EFqwR9UT
         w4yA==
X-Forwarded-Encrypted: i=1; AJvYcCW4B8YfZTXO/RrJv9MZqVr4QSX+5xCwqWwdSfcEg9Y8valgzjd0EFlqA5L1hZwJI0GrPQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETbQd7yu6XjDOcqbA9SrBYEZxW3M6r8et4xuR05Moj+ChQxlZ
	+6IohcdlALnMAPSnBXj06dWq6aVsd2Xxqk43uEIQBBGfWZEz38ivBx0BAvHqng2NO439D4/Lvfq
	ABSfXiV7eNOnrIz2v3B4fPeGIXYkzkdw7VfzxN5zG0B1SKDl+BJJuxBIImS8=
X-Google-Smtp-Source: AGHT+IEcCOZ1M5lbEw3vt0apHj5RxEq0/i9/RDLxOMwkyUCYyuVOVJgI+Nmoj/lU+criLegiKyakG8fk/nWWAYPgvsN+vbwhBNEW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:3e3:fd04:5768 with SMTP id
 e9e14a558f8ab-3e40d65443cmr40280935ab.5.1754042915829; Fri, 01 Aug 2025
 03:08:35 -0700 (PDT)
Date: Fri, 01 Aug 2025 03:08:35 -0700
In-Reply-To: <688b8332.a00a0220.26d0e1.0044.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c9223.a00a0220.26d0e1.0068.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in trace_suspend_resume
From: syzbot <syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, david@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, rppt@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f2d282e1dfb3 Merge tag 'bitmap-for-6.17' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11709cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c686e0c98d241433
dashboard link: https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e0e2a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a439bc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-f2d282e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25cab46afcee/vmlinux-f2d282e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77cd04442f1b/zImage-f2d282e1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4155 at mm/highmem.c:622 kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 UID: 0 PID: 4155 Comm: syz.1.17 Not tainted 6.16.0-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Call trace: 
[<80201a24>] (dump_backtrace) from [<80201b20>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:8281f77c r5:00000000 r4:8224bc00
[<80201b08>] (show_stack) from [<8021fb00>] (__dump_stack lib/dump_stack.c:94 [inline])
[<80201b08>] (show_stack) from [<8021fb00>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<8021faac>] (dump_stack_lvl) from [<8021fb40>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82a76d18
[<8021fb28>] (dump_stack) from [<80202624>] (vpanic+0x10c/0x360 kernel/panic.c:440)
[<80202518>] (vpanic) from [<802028ac>] (trace_suspend_resume+0x0/0xd8 kernel/panic.c:574)
 r7:804be014
[<80202878>] (panic) from [<802548c4>] (check_panic_on_warn kernel/panic.c:333 [inline])
[<80202878>] (panic) from [<802548c4>] (get_taint+0x0/0x1c kernel/panic.c:328)
 r3:8280c684 r2:00000001 r1:822326d8 r0:8223a0a0
[<80254850>] (check_panic_on_warn) from [<80254a28>] (__warn+0x80/0x188 kernel/panic.c:845)
[<802549a8>] (__warn) from [<80254ca8>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:872)
 r8:00000009 r7:82266338 r6:df985d14 r5:840d5400 r4:00000000
[<80254b34>] (warn_slowpath_fmt) from [<804be014>] (kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622)
 r10:00000000 r9:ded86c30 r8:deb6caa4 r7:00a00000 r6:00000003 r5:840d5400
 r4:ffefd000
[<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (__kunmap_local include/linux/highmem-internal.h:102 [inline])
[<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (move_pages_pte mm/userfaultfd.c:1457 [inline])
[<804bde08>] (kunmap_local_indexed) from [<8053ace8>] (move_pages+0xb1c/0x1a00 mm/userfaultfd.c:1860)
 r7:00a00000 r6:00000000 r5:8490d6ac r4:ffefb000
[<8053a1cc>] (move_pages) from [<805c401c>] (userfaultfd_move fs/userfaultfd.c:1923 [inline])
[<8053a1cc>] (move_pages) from [<805c401c>] (userfaultfd_ioctl+0x1254/0x2408 fs/userfaultfd.c:2046)
 r10:8425d6c0 r9:df985e98 r8:00000001 r7:21000000 r6:00000000 r5:20000040
 r4:8486d000
[<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (do_vfs_ioctl fs/ioctl.c:552 [inline])
[<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (__do_sys_ioctl fs/ioctl.c:596 [inline])
[<805c2dc8>] (userfaultfd_ioctl) from [<8056c4d4>] (sys_ioctl+0x130/0xba0 fs/ioctl.c:584)
 r10:840d5400 r9:00000003 r8:8572d780 r7:20000040 r6:8572d780 r5:00000000
 r4:c028aa05
[<8056c3a4>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf985fa8 to 0xdf985ff0)
5fa0:                   00000000 00000000 00000003 c028aa05 20000040 00000000
5fc0: 00000000 00000000 002f6300 00000036 00000000 002f62d4 00000938 00000000
5fe0: 7eb28780 7eb28770 000193dc 001321f0
 r10:00000036 r9:840d5400 r8:8020029c r7:00000036 r6:002f6300 r5:00000000
 r4:00000000
Rebooting in 86400 seconds..


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

