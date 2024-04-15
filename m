Return-Path: <bpf+bounces-26868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D458A5C20
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946441F24224
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA4156871;
	Mon, 15 Apr 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V8hx5W2y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D471B50;
	Mon, 15 Apr 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212318; cv=none; b=V84p/uVMWhsCVD0Ngx8csolozaB/XAgs0jx7Itdv1+DWSjp02N14MU58OCgtwf9YE2NRNzDqGqLuXeIXDrr6a1Hpk9DfCKIxCtjom0ukw65ACDFZ7KnKJZIkXL3Pg99LSikOwogoxnt5IYz/oAJRctYRlcjHkOGDbR5XuVVJ6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212318; c=relaxed/simple;
	bh=S8oJBdMX/629ukkjWH0ejp39M4hmY1Iw0ybCXRKw0tw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UfM1xclt9F334mzLdVe0QE4ZyH9wMms+SxE3Ih1ZBHfpvJuNzdsQOZFlQASXTE3av5ZvHPFZfCvI9ZfgIUxmM1nB1cOhlzaduKh2U0GW9WTKRb91/RR7WDEmievCMK+2AZzYLNc92Vl3/I8APcHXSwoBnyWZh5bKsyhpfDaq2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V8hx5W2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CA0C113CC;
	Mon, 15 Apr 2024 20:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713212318;
	bh=S8oJBdMX/629ukkjWH0ejp39M4hmY1Iw0ybCXRKw0tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8hx5W2ydEHFUgYGx6cc4XJKYTXEu2PCH6P/ZVTaYhsxhdCjXmkomQQIlhXWazyBp
	 Lr2zvnnLPEeK7VyEx3HIk/Y53iqk9O5QuD/Ogx9kYHUjHVfgbvG8aLkc9opBhjoUEQ
	 M5U0U52D/qtII2CS/iafSry5pB2++6yNaEdnKngs=
Date: Mon, 15 Apr 2024 13:18:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
Subject: Re: [syzbot] [mm?] KMSAN: kernel-infoleak in bpf_probe_write_user
Message-Id: <20240415131837.411c6e05eb7b0af077d6424a@linux-foundation.org>
In-Reply-To: <000000000000fe696d0615f120bb@google.com>
References: <000000000000fe696d0615f120bb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(cc bpf@)

On Fri, 12 Apr 2024 19:27:25 -0700 syzbot <syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fec50db7033e Linux 6.9-rc3
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16509ba1180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
> dashboard link: https://syzkaller.appspot.com/bug?extid=79102ed905e5b2dc0fc3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a4af9d180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12980f9d180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/901017b36ccc/disk-fec50db7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/16bfcf5618d3/vmlinux-fec50db7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dc9c5a1e7d02/bzImage-fec50db7.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+79102ed905e5b2dc0fc3@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  __copy_to_user_inatomic include/linux/uaccess.h:125 [inline]
>  copy_to_user_nofault+0x129/0x1f0 mm/maccess.c:149
>  ____bpf_probe_write_user kernel/trace/bpf_trace.c:349 [inline]
>  bpf_probe_write_user+0x104/0x180 kernel/trace/bpf_trace.c:327
>  ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>  __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
>  __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
>  trace_kfree include/trace/events/kmem.h:94 [inline]
>  kfree+0x6a5/0xa30 mm/slub.c:4377
>  vfs_writev+0x12bf/0x1450 fs/read_write.c:978
>  do_writev+0x251/0x5c0 fs/read_write.c:1018
>  __do_sys_writev fs/read_write.c:1091 [inline]
>  __se_sys_writev fs/read_write.c:1088 [inline]
>  __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
>  do_syscall_64+0xd5/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> Local variable stack created at:
>  __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
>  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>  __bpf_prog_run include/linux/filter.h:657 [inline]
>  bpf_prog_run include/linux/filter.h:664 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>  bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
> 
> Bytes 0-7 of 8 are uninitialized
> Memory access of size 8 starts at ffff888121ec7ae8
> Data copied to user address 00000000ffffffff
> 
> CPU: 1 PID: 4779 Comm: dhcpcd Not tainted 6.9.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

