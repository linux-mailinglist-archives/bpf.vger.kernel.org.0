Return-Path: <bpf+bounces-28962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E68BEEDA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A021C228C0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148B7640E;
	Tue,  7 May 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmm3zw1j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ADF54BDE;
	Tue,  7 May 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117041; cv=none; b=UFWTpCSQGHlKm28lA1dus5COagioblgfSPzoVpYz8Bu91Cl7gWkHEu6vZtMRm0z+Lf4t684hzvcOjQfE87j8DB+F5AIeeuGJLxcK/ABxUOG59l0IvCtpnOJSg5dM0a1FbH2mfduuCvs5SXlthyPzR9LA7Wj/yHn/4Q3HlnShGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117041; c=relaxed/simple;
	bh=gHxenK9oFnjBBNe7xiJcX97vzG4UeNjrtQ74Ck2Nayo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5bRnFe6DI3ybmPVJTTPF5mgUpPNoahPmNCn6lj+36NOxuSRFNM0EHttiI5Zw73jhTZTH7YHastChG9GM5eaR35uQpR41NHSHoRa5DiKn+PSQjiCI2R91z3L4W9jeCHoebwItlYp21um3iVF4JuMvtBnmWpIj7Vus1Zb5F8PwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmm3zw1j; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599eedc8eeso835224866b.1;
        Tue, 07 May 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715117038; x=1715721838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PbU2voJtIywQzYBhvYuy69wh7N762cGnMz8SYka9WU=;
        b=Dmm3zw1jEXiRKuuvqLXe2fSekaXsrbhj4fop/hmV8csNeZSRQ76JrinFcssTgHyEYR
         uqCGLeo5qWB2V8IAZ9BnqpL2sXPXLuZWf4lg2r72S0Fs7S1rkyl3jFIUEOwQVIXoNnWJ
         jM9Vk2EZY5s0zrsdElNv0x2qofCgkqCTlyar0qDbWLhApv21NaHXXVM80jVDTDAyg/W9
         XMxqFiUZPBA2JgBGRyMNvrBtQSouVx/nDOBvRDioubSBh2TXBzdznJC7HP34dBe1C06F
         GCosLq0dxRISuepaZL457VsANSyZpTkn+IRlqdQlqW7FNR9nJIEByRJf80s8bvZyBIYN
         y8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715117038; x=1715721838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PbU2voJtIywQzYBhvYuy69wh7N762cGnMz8SYka9WU=;
        b=vxB3GIMxy5l7UEKI4F1NDX2caKHNxE96MO6/cJM6YEiyCqdLXDoISY2uHjSeTB6VmI
         vniRGRKPAkxJo7JnwRhPNuxTJutWGryOfGiGk4Oagrals5YBNWSXbBUTStvmREHm+Bih
         gKzTH+wRFAAZ52bFx6BIUcdeDzhBEi9uUqaKLVM3IZ1tEZmDRhfqaCpU5+Ui8+Phb3LX
         bhB3V9bryAWHzje1QE3gUk4TotTytILvroY+djEDW4G58nzU/TbXWqCukKkxUy5d2yEX
         Ln55GoaXgU2iLWP5O/AsqlMkJB8vILmNZB3iXDI2Gj8lYUOHhT402h8ZbZ4Ksen8aRSS
         +qAw==
X-Forwarded-Encrypted: i=1; AJvYcCUt7smWtZfc71gRBPxzoALe4oWiKIXFSvCar6RRm2dWCQCQ1p+fqYKye6dnKl5d9G/abr9bnqhKbwCU5azKJxjWilPwBgo98j6wZzVgx1LpuqnpsfwLXq3Y/4xpbsRLk/s89DtreLdMbBYRYVJT9O1hi0uKPgA0Awt3LtAMQ0mGkasPOUf16mIbsCpIn2AeDDhJBv+VdIOfd+o9dXju
X-Gm-Message-State: AOJu0YyUq7pZiHargyEQ8NDl4sVEWHe4I94z5242FqjyAhH+6deUFNeo
	d42A3JYNjmYcboKBsjgpqUTiUiZHifmPtAPYO7tuS2iQ8BISgPDxaSCTuxchghrcH2S5H42Jhgs
	MXnAD1tOiUCmg+rGsIABwco158Sg=
X-Google-Smtp-Source: AGHT+IGLh7IxykwVsUVdlTgKX8FUthW8+ktRPntXeDDqVTJasNCWflUPIPP2uUFXay56jdWOzd3IOltI3DW4QwA/fGA=
X-Received: by 2002:a17:906:ae8e:b0:a59:ee81:fd68 with SMTP id
 a640c23a62f3a-a59fb9d1f5emr36774766b.71.1715117037810; Tue, 07 May 2024
 14:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fda0400617b73b57@google.com>
In-Reply-To: <000000000000fda0400617b73b57@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:23:41 -0700
Message-ID: <CAEf4BzaBxnEV0X5bOHkza1XbxtM+d06aRVoUHmOfoRFWiZHk=A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] general protection fault in bpf_get_attach_cookie_tracing
To: syzbot <syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 9:13=E2=80=AFAM syzbot
<syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a9e7715ce8b3 libbpf: Avoid casts from pointers to enums i=
n..
> git tree:       bpf-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D153c1dc498000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De8aa3e4736485=
e94
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3ab78ff125b7979=
e45f9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17d4b588980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16cb047098000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a6daa7801875/dis=
k-a9e7715c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0d5b51385a69/vmlinu=
x-a9e7715c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/999297a08631/b=
zImage-a9e7715c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] PREEMPT SMP KASAN PTI

I suspect it's the same issue that we already fixed ([0]) in
bpf/master, the fixes just haven't made it into bpf-next tree

  [0] 1a80dbcb2dba bpf: support deferring bpf_link dealloc to after
RCU grace period

> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5082 Comm: syz-executor316 Not tainted 6.9.0-rc5-syzkaller-01=
452-ga9e7715ce8b3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:____bpf_get_attach_cookie_tracing kernel/trace/bpf_trace.c:1179=
 [inline]
> RIP: 0010:bpf_get_attach_cookie_tracing+0x46/0x60 kernel/trace/bpf_trace.=
c:1174
> Code: d3 03 00 48 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 7=
4 08 48 89 df e8 54 b9 59 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00=
 74 08 48 89 df e8 3b b9 59 00 48 8b 03 5b 41 5e c3
> RSP: 0018:ffffc90002f9fba8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888029575a00
> RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000000000000000
> RBP: ffffc90002f9fbc0 R08: ffffffff89938ae7 R09: 1ffffffff25e80a0
> R10: dffffc0000000000 R11: ffffffffa0000950 R12: ffffc90002f9fc80
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000555578992380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002e3e9388 CR3: 00000000791c2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bpf_prog_fe13437f26555f61+0x1a/0x1c
>  bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  __bpf_prog_test_run_raw_tp+0x149/0x310 net/bpf/test_run.c:732
>  bpf_prog_test_run_raw_tp+0x47b/0x6a0 net/bpf/test_run.c:772
>  bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4286
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5700
>  __do_sys_bpf kernel/bpf/syscall.c:5789 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5787 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5787
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f53be8a0469
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdcf680a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffdcf680bd8 RCX: 00007f53be8a0469
> RDX: 000000000000000c RSI: 0000000020000080 RDI: 000000000000000a
> RBP: 00007f53be913610 R08: 0000000000000000 R09: 00007ffdcf680bd8
> R10: 00007f53be8dbae3 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffdcf680bc8 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:____bpf_get_attach_cookie_tracing kernel/trace/bpf_trace.c:1179=
 [inline]
> RIP: 0010:bpf_get_attach_cookie_tracing+0x46/0x60 kernel/trace/bpf_trace.=
c:1174
> Code: d3 03 00 48 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 7=
4 08 48 89 df e8 54 b9 59 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00=
 74 08 48 89 df e8 3b b9 59 00 48 8b 03 5b 41 5e c3
> RSP: 0018:ffffc90002f9fba8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888029575a00
> RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000000000000000
> RBP: ffffc90002f9fbc0 R08: ffffffff89938ae7 R09: 1ffffffff25e80a0
> R10: dffffc0000000000 R11: ffffffffa0000950 R12: ffffc90002f9fc80
> R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
> FS:  0000555578992380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002e3e9388 CR3: 00000000791c2000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   d3 03                   roll   %cl,(%rbx)
>    2:   00 48 81                add    %cl,-0x7f(%rax)
>    5:   c3                      ret
>    6:   00 18                   add    %bl,(%rax)
>    8:   00 00                   add    %al,(%rax)
>    a:   48 89 d8                mov    %rbx,%rax
>    d:   48 c1 e8 03             shr    $0x3,%rax
>   11:   42 80 3c 30 00          cmpb   $0x0,(%rax,%r14,1)
>   16:   74 08                   je     0x20
>   18:   48 89 df                mov    %rbx,%rdi
>   1b:   e8 54 b9 59 00          call   0x59b974
>   20:   48 8b 1b                mov    (%rbx),%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 30 00          cmpb   $0x0,(%rax,%r14,1) <-- trapping in=
struction
>   2f:   74 08                   je     0x39
>   31:   48 89 df                mov    %rbx,%rdi
>   34:   e8 3b b9 59 00          call   0x59b974
>   39:   48 8b 03                mov    (%rbx),%rax
>   3c:   5b                      pop    %rbx
>   3d:   41 5e                   pop    %r14
>   3f:   c3                      ret
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

