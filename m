Return-Path: <bpf+bounces-45609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266BF9D8FA3
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7028169356
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7979E1;
	Tue, 26 Nov 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAs0Jquh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7A7462;
	Tue, 26 Nov 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732582485; cv=none; b=AXniflB0sUJoUfEoEk4Mzf6/oG/C2mL2czO1i+a+DYj3qkuT5zmqaAG9rE6zip6xy8Uq+sp5Ks1gAwT0yN29VVNuKeGxx+2AyhgWd4ytaCllK1A1S5E0e13QWJ6mcTenw7v0Uk+LJdkH6TJTb9fxVLsRbT6X6qaX0jPywKApN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732582485; c=relaxed/simple;
	bh=SU5BZz78UxctPxCuxddW3WDDPxkogRKJsNaq+0LtPwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceeIJ7Pva5Tgffc7981tttY+dkUZWsbMMiIhBytf3AYcZASEXUuRCL307WxxwLgPbi70BPrfqlOTGJDOs7HudegNTQEuBjW1C2AE0YgdW88NjvA5EnotIXCFzk9KBRtQYjIf1LIgyp2e8hcDH2UdVkZO7l6ULrY2C2q2wg7wU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAs0Jquh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ea752c0555so3913809a91.3;
        Mon, 25 Nov 2024 16:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732582483; x=1733187283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLIrXgaEU9EKAQw2lS3kqkOdTxl4MH24lpKd1qmD8x0=;
        b=DAs0Jquh5xPWykn+N+Dqzl+Njq5/PaZQIPJMuE+pnYvgVumZRmh8fcUwnMicTDOC1i
         JZyUbJYF1zulB8mcx9eqQk7/xXA7g31uFOsyvgrgJsyVjXvGxIKEICbVwae9UzkHAwUt
         ycB1sAXGLfevbdiGDRR8RN9len8lx7HKchb3Cy7B8jD0V5EoBAwpVYr/YgEvWnerplOp
         TMsYX+bQJDHbDBcramhpG22/vRw6+qWqjiU4hsNz7k3O2oIatVxdxUS69zAdvlV1KvcX
         ZaN4X0ZTvMjj6ZRNff2tYgjjd/yXhDuJ330w5Ml7+jJykY9xWnVwDcPPR5rYLaN0X++S
         Fb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732582483; x=1733187283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLIrXgaEU9EKAQw2lS3kqkOdTxl4MH24lpKd1qmD8x0=;
        b=xU3J4Kj10lSP13gOjtbnj+aCcZ+mccLxVAwscd2MOUjIov8qEEftFEcWxjH5lzZ9YL
         Gelun83yM8QpaYCTJ4nVI4oOggHN1gKbnQFOntlikJJDUBBbbCDp8ykchst7g8COJ56U
         GmPlDV6U8hQIW3y6JQ2FiCR+H1CPsYAtIWJaZa9wAckfet+Tt4nEm7q0ChLXSgaGYg1j
         ZoDQyX7CtlBimp34QxudNadCba1IYX5TQrCaub5asAJTHulzZeDNjzcQFX+JovHoIUOn
         GzZdW4kf5vttXZMuRsf+inpWxMtt7Qktm5Y1dg0vsD31gvL44pvNcxN6Mpg4r11uqdkU
         84Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUcMt0ONDvU5OQ0E/NWFEtbwWkH3kgirv2+U2QUR6GcbYzgtx75Xbt9xWQspZ5O6DgT5V91a+nWiNks1+Lb@vger.kernel.org, AJvYcCUeWMkxsJL9Ofm5kseKBISpomLcZ+4o7rGcJt1MtRPlSvf80jFlKUwg0o1dwA3vdazpcbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJ/J0ONPG9FKUD0kLlqCsXnZiD7Y/kmkO8osTJsMFM7+dydEL
	cCFZBdf74WJHIePSsT2Jj1WL5Xqtokeyi1KzqY3lcTjlsi8gVTT+Dmju2sRkydXqcn40kzBBpNz
	gB/7g7Y+u4YKua7llMmoUxdcoMSk=
X-Gm-Gg: ASbGncsmX3jYUdt3i18B5AwUAAgyQHfa0pUvrnDmChFrE4EjhWX7kLWCRN2mioj9oSb
	pTU1kU8+10GrHXogFsaX7H96F8jOwxBHCyZNK5U83pdb/q4c=
X-Google-Smtp-Source: AGHT+IEyj9I5a5SDTUp49XawMWm5SWtPIh5wPBvNlxLTOqxgbiyBVlsa37HgK8PHZeSuJr9g+kq90aZW3ePQM3+LGq8=
X-Received: by 2002:a17:90b:3ec5:b0:2ea:59c6:d6ed with SMTP id
 98e67ed59e1d1-2eb0e86a325mr19321012a91.30.1732582483006; Mon, 25 Nov 2024
 16:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6743e5ec.050a0220.1cc393.0056.GAE@google.com> <CAADnVQKEEqhhqu6qTG7qBgv3t=ouzN8U4ewvAFsLUOG_TRBR8w@mail.gmail.com>
In-Reply-To: <CAADnVQKEEqhhqu6qTG7qBgv3t=ouzN8U4ewvAFsLUOG_TRBR8w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Nov 2024 16:54:31 -0800
Message-ID: <CAEf4BzbxLH=ptTwK6LQEK=T_r0pSKJwJ8HvYRK7B_Y3xWhMKjw@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in vrealloc_noprof
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> The issue is understood.
> Commit 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()") is buggy.
>

#syz fix: mm: fix vrealloc()'s KASAN poisoning logic

> Fix is wip.
>
> Same as the other syzbot report.
>
> On Sun, Nov 24, 2024 at 6:50=E2=80=AFPM syzbot
> <syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    ac24e26aa08f Add linux-next specific files for 20241120
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14d91b78580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45719eec4c7=
4e6ba
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7d9959e6503e8=
ffc8558
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124d8ec05=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1425a75f980=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9c6bcf3605c7/d=
isk-ac24e26a.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4ce96eb398a9/vmli=
nux-ac24e26a.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/9a22aac22c90=
/bzImage-ac24e26a.xz
> >
> > The issue was bisected to:
> >
> > commit 96a30e469ca1d2b8cc7811b40911f8614b558241
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Fri Nov 15 00:13:03 2024 +0000
> >
> >     bpf: use common instruction history across all states
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D102bd930=
580000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D122bd930=
580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D142bd930580=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com
> > Fixes: 96a30e469ca1 ("bpf: use common instruction history across all st=
ates")
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x340/0x3a0 mm/vma=
lloc.c:4095
> > Write of size 2097120 at addr ffffc90004c00020 by task syz-executor132/=
5834
> >
> > CPU: 1 UID: 0 PID: 5834 Comm: syz-executor132 Not tainted 6.12.0-next-2=
0241120-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/30/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:489
> >  kasan_report+0x143/0x180 mm/kasan/report.c:602
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
> >  vrealloc_noprof+0x340/0x3a0 mm/vmalloc.c:4095
> >  push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
> >  check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
> >  do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
> >  do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
> >  do_check_main kernel/bpf/verifier.c:21939 [inline]
> >  bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
> >  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
> >  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
> >  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fae10fcf269
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffdf2bc3148 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fae10fcf269
> > RDX: 0000000000000090 RSI: 0000000020000840 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000000a0
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
> >
> > The buggy address belongs to the virtual mapping at
> >  [ffffc90004800000, ffffc90004e01000) created by:
> >  kvrealloc_noprof+0xc7/0x120 mm/util.c:747
> >
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6c=
600
> > flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > raw: 00fff00000000000 0000000000000000 dead000000000122 000000000000000=
0
> > raw: 0000000000000000 0000000000000000 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102c=
c2(GFP_HIGHUSER|__GFP_NOWARN), pid 5834, tgid 5834 (syz-executor132), ts 11=
4573563417, free_ts 25588986996
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
> >  prep_new_page mm/page_alloc.c:1564 [inline]
> >  get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
> >  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
> >  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
> >  vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
> >  __vmalloc_area_node mm/vmalloc.c:3667 [inline]
> >  __vmalloc_node_range_noprof+0x9c9/0x1380 mm/vmalloc.c:3844
> >  __kvmalloc_node_noprof+0x142/0x190 mm/util.c:672
> >  kvrealloc_noprof+0xc7/0x120 mm/util.c:747
> >  push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
> >  check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
> >  do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
> >  do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
> >  do_check_main kernel/bpf/verifier.c:21939 [inline]
> >  bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
> >  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
> >  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
> >  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > page last free pid 1 tgid 1 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1127 [inline]
> >  free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2693
> >  free_contig_range+0x152/0x550 mm/page_alloc.c:6666
> >  destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
> >  debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
> >  do_one_initcall+0x248/0x880 init/main.c:1266
> >  do_initcall_level+0x157/0x210 init/main.c:1328
> >  do_initcalls+0x3f/0x80 init/main.c:1344
> >  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
> >  kernel_init+0x1d/0x2b0 init/main.c:1466
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Memory state around the buggy address:
> >  ffffc90004bfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffc90004bfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >ffffc90004c00000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >                                ^
> >  ffffc90004c00080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> >  ffffc90004c00100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

