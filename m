Return-Path: <bpf+bounces-46276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA39E71EB
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EAF286079
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED01DFD89;
	Fri,  6 Dec 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0E8HNYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F04753A7;
	Fri,  6 Dec 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497330; cv=none; b=lL05Iu/fz/RoH3kxAHqwJDTNDkYtBl0XcKHKMx9KROu6IgRCpocrGa/t/Qy5CSs8MQHlHS0QAjtjowQdcY2ikGxR2IpqUoHxUJe61aFGYz069gj/WhrkvDUjTxBF1e8fy8IEEjdQfY3m9PfkggzHdKrU+2HHPbiv6MFyPqMz4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497330; c=relaxed/simple;
	bh=/Z1yBzC1DSfZonbRjQ4t9l+K2KWN7e+E3mrJ30gIEbE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqPiA1FdDx2RPJMu9pMGerciDgI4IuYkr73935a8vuV797vmYm6SR9He0aYZHAe4wxTiPaPp0WLbxNn/kK4tQENFtKw6rzuItGnA3x1Uvd0oNG5T0rFv4vZnJeHqcKp6nrT2OOUmLX9OWaO1dxWA14U5Ntb+qpFh94QsxNf+YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0E8HNYP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43494a20379so20878425e9.0;
        Fri, 06 Dec 2024 07:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733497326; x=1734102126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+V1Hsla4xpDr6WwzScQTBcuA4aypiL/OoQ34HkrySpo=;
        b=e0E8HNYPqHjyJWY7eK5TioGWZJ8HGhv2Zw80Ag/rmdArVFxKYRwhQ2pKyfod4JjRjh
         ZpYZcI/fuZzV0sE540FKEvmCnHb0WWzrj6Q0oViOhj+qqEW5OfgqIkxLmQPkpl07Mgh0
         5jjhBCRviBuprOY2IBc3flwCasgWf+32hN2/WBLh+TxuAYVycqnE7dMjagSBHI6jQONd
         jZFR7A8eFJa+Y3tfhIOjJleLrvIEKKLaWL7cdojHkT28ebwC8gRWlvv0X5oLkYHyT3GN
         IVkd/w61FunDU8Ai4nDycNMA3S+wFMt215pzwl9gEd2x+nJ1neLHp/wurCQateWRU+0x
         8mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497326; x=1734102126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V1Hsla4xpDr6WwzScQTBcuA4aypiL/OoQ34HkrySpo=;
        b=EpWq7spEWwdbljn9O2gtszd86OFK01W3J2YQ29cchAQd4IowNPhqSxowrWuwOb/npJ
         7/Kp9Lo76vazvkRc5NHcgmGdl+02qmXadndZG90dVmxuuMe5hPuvOZ2mqtdqokcvGsHj
         oydvKKjdA7BQXSh9EVS145zKrKTU3eVTSApSB9ff6gait48p82L7u+4bpyITy6kknyVn
         UJ4qBNOlrX1XK8+4JCh6txjLOfv7QLcX8N8nLYwn0my7bbTUPI0uXvEpqgGnk+W9AQu+
         6QMGo9eZqnrQ8b0nGtJPwdr3l23Kd78VlUF1gQWZ/iURKr7ItBb9ue/VIk/tjXPiMApe
         z0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Woki7i1NtYWMRQlcUponMFpBAAdwO8kDgo/l+phMT66D+OSxjsGYnzXVpqN35SILoxM=@vger.kernel.org, AJvYcCVJB461Ap59bvqIrDJ6ErAy4crPbAPNd3atlvvSpcLItg6yFalXLLr6DvU6cQnHNzLdj+2aE4tN@vger.kernel.org, AJvYcCWXNvakfou+ECm5+ShWNkS8+skVrMFia056yc9gEUmCaUQybxHU0NGaUo2JJIOiV8mRcoo94KMljSmknBc3@vger.kernel.org
X-Gm-Message-State: AOJu0YySrGw+PzmebKmbRw+fjSAc5SYcwpQogkkuG3wJZ6utr+BkOpdz
	Lbry5aultXXs9SRL+OKJNQyJDERiJy1DOjjbY7hjZnXqgT9ayeCt
X-Gm-Gg: ASbGncv3YbqcPHfjcyYocOIcAg3l5pDL9T4F8BPfugBGQ3+8CqpoRvmjv9WQPqlE/zl
	uQEDUx/L3ZrD6xhp7jKUgLCIDPgBKTEu7wBv6xCCgPSdpnRQjP4SSjtIE1+kPTi8S6ic3jC+YyL
	R9L6VLzlp6bQzmn/ar2LnoZx0v8kTmgSagKoPLrjMI86Clls5+rYc78Fx2yohFGO9fLbVrsRcTJ
	XLfsR5w/j/Xn87RbhBCr/gmbZNIRQ3OqXlIw3Xzs4fZDiwczpsUu8B0oJuNezakqjzuYQLTrm4i
	by1yijwjz0ut9kmiOty2TW8=
X-Google-Smtp-Source: AGHT+IF+i0vfPsnJK070XBvTi/ymBApI/1gIOZMkw037qcoVXCLaFaNKfjTLZD7EwGrodlucxw6HdA==
X-Received: by 2002:a05:600c:4447:b0:434:9c3b:7564 with SMTP id 5b1f17b1804b1-434dded7374mr27126015e9.20.1733497324584;
        Fri, 06 Dec 2024 07:02:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2698sm58617785e9.8.2024.12.06.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:02:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Dec 2024 16:02:01 +0100
To: syzbot <syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_prog_array_delete_safe
Message-ID: <Z1MR6dCIKajNS6nU@krava>
References: <67530069.050a0220.2477f.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67530069.050a0220.2477f.0003.GAE@google.com>

On Fri, Dec 06, 2024 at 05:47:21AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e2cf913314b9 Merge branch 'fixes-for-stack-with-allow_ptr_..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b5ede8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e0d2840414ce817aaac
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132a2020580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1291d0f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/487d8ef2aead/disk-e2cf9133.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/899f2234c9d5/vmlinux-e2cf9133.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ea8993a0dfd6/bzImage-e2cf9133.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 UID: 0 PID: 5849 Comm: syz-executor326 Not tainted 6.12.0-syzkaller-09099-ge2cf913314b9 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:bpf_prog_array_delete_safe+0x2d/0xc0 kernel/bpf/core.c:2583
> Code: 00 41 57 41 56 41 55 41 54 53 49 89 f7 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 ce 84 f0 ff 4d 8d 75 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 54 6b 5b 00 49 8b 1e 48 85 db 74
> RSP: 0018:ffffc90003807970 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: 1ffff92000700f38 RCX: ffff888034eb8000
> RDX: 0000000000000000 RSI: ffffc90000abe000 RDI: 0000000000000000
> RBP: ffffc90003807a48 R08: ffffffff81a1aa9e R09: 1ffffffff203c816
> R10: dffffc0000000000 R11: fffffbfff203c817 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000010 R15: ffffc90000abe000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000000e738000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  perf_event_detach_bpf_prog+0x2b0/0x330 kernel/trace/bpf_trace.c:2255
>  perf_event_free_bpf_prog kernel/events/core.c:10801 [inline]
>  _free_event+0xb04/0xf60 kernel/events/core.c:5352
>  put_event kernel/events/core.c:5454 [inline]
>  perf_event_release_kernel+0x7c1/0x850 kernel/events/core.c:5579
>  perf_release+0x38/0x40 kernel/events/core.c:5589
>  __fput+0x23c/0xa50 fs/file_table.c:450
>  task_work_run+0x24f/0x310 kernel/task_work.c:239
>  exit_task_work include/linux/task_work.h:43 [inline]
>  do_exit+0xa2f/0x28e0 kernel/exit.c:938
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1087
>  __do_sys_exit_group kernel/exit.c:1098 [inline]
>  __se_sys_exit_group kernel/exit.c:1096 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
>  x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

ugh, it's because of the:
  0ee288e69d03 bpf,perf: Fix perf_event_detach_bpf_prog error handling

I'll send the fix

thanks,
jirka

> RIP: 0033:0x7f9408276e09
> Code: Unable to access opcode bytes at 0x7f9408276ddf.
> RSP: 002b:00007fffe6c98ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9408276e09
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f94082f22b0 R08: ffffffffffffffb8 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f94082f22b0
> R13: 0000000000000000 R14: 00007f94082f2d00 R15: 00007f9408248040
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bpf_prog_array_delete_safe+0x2d/0xc0 kernel/bpf/core.c:2583
> Code: 00 41 57 41 56 41 55 41 54 53 49 89 f7 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 ce 84 f0 ff 4d 8d 75 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 54 6b 5b 00 49 8b 1e 48 85 db 74
> RSP: 0018:ffffc90003807970 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: 1ffff92000700f38 RCX: ffff888034eb8000
> RDX: 0000000000000000 RSI: ffffc90000abe000 RDI: 0000000000000000
> RBP: ffffc90003807a48 R08: ffffffff81a1aa9e R09: 1ffffffff203c816
> R10: dffffc0000000000 R11: fffffbfff203c817 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000010 R15: ffffc90000abe000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000007f382000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	00 41 57             	add    %al,0x57(%rcx)
>    3:	41 56                	push   %r14
>    5:	41 55                	push   %r13
>    7:	41 54                	push   %r12
>    9:	53                   	push   %rbx
>    a:	49 89 f7             	mov    %rsi,%r15
>    d:	49 89 fd             	mov    %rdi,%r13
>   10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
>   17:	fc ff df
>   1a:	e8 ce 84 f0 ff       	call   0xfff084ed
>   1f:	4d 8d 75 10          	lea    0x10(%r13),%r14
>   23:	4c 89 f0             	mov    %r14,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	4c 89 f7             	mov    %r14,%rdi
>   34:	e8 54 6b 5b 00       	call   0x5b6b8d
>   39:	49 8b 1e             	mov    (%r14),%rbx
>   3c:	48 85 db             	test   %rbx,%rbx
>   3f:	74                   	.byte 0x74
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

