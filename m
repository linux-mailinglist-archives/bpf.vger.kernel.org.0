Return-Path: <bpf+bounces-45608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369A9D8FA0
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7834FB218B6
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D078831;
	Tue, 26 Nov 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af+f6eek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615A46B5;
	Tue, 26 Nov 2024 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732582454; cv=none; b=eYQXfN0QIjyk5uCyGJeqd1E66H+TnR6r8ZrYIBj91EmhOGoQdwB08UwZJh7YG43cMZ8vEDoyFQtLpkLRXAO0N9L+DMuy44Es1oxepvjF+7FleVm1/BvrMDWC09biOdUfJi96MkaZl8g51OPxDlCnVaoZH/ozlER17YR4X0e5+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732582454; c=relaxed/simple;
	bh=Cmv1DtId6QAYVh1r9dPvs3Ffq7sOzLKYDr7/6t6xTkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj7/kAUFGYmCcbhtyGgUvtyu5GLxB22gXqqF4yJrIPci+a6IAZ8uxEdDHlDf9O9q2cDQDCDbZ2BOUzvwQi8jkk7tny25Moq8lMRQvYzyXJnlOd6Xk2IvL9sRqakRnSmJJlBI7id/Xfkl30uhRR4PCc+n8H6q9BSLNCEjd5wNEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af+f6eek; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea379ef02fso4001502a91.3;
        Mon, 25 Nov 2024 16:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732582452; x=1733187252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM77DFDgD8ynh/aHXUUu2VOnCkU+TwHKStRlJgPFBTc=;
        b=Af+f6eekJ8bhqlC0QR+MZJXUvW7Pp6Zly97RC/V6HTV8Rnv6xG3g6o3V19ejp6+Ys7
         fOEVh1qwEy9b2KMyFYaYY5Fcn23GnnDYlug/y0n/EU9vcoZuNJdASsPg53ieSyZscV6f
         J1YG2R87AB74z99hT1pS43UWiwFZjnX6QXkJPplkonqik+zJu5cnfJMW8kabiFuWj7pB
         szN7DnXWpF9Fv4LHmWbNAgyAgw+gzCU3CufBYK/Caky/ULCsZmd26MfVe9udEL3hjnpL
         ZN0RC/viT0T3TbHW6yujeBwJwf8rpT9AySWo+Boymz4X1XqCoR8wp/Sl9mJrDH5BPf9i
         Vicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732582452; x=1733187252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM77DFDgD8ynh/aHXUUu2VOnCkU+TwHKStRlJgPFBTc=;
        b=W3rt91O0hsYZGl2qbjSeQujz+XOdktSdrMeY3K1C36ttDBnJyDBVqFFxsVfa9GQCdl
         y59lrLB4TqnHaKvwhX0QoVUPeWhtRiSZeDI9Vc1Av4BGyKoZ13Dt6FAN+a9M7GaVvONn
         tgNY3evtp1A5ufVjQl308uPNSmwtzLkqbVinloWGU9+5gf7PPG2B2CXdossZx0umaC72
         VJjI++YrNkd92akiXOJn2WOgpbf+HmHsJRfSZf0pY0m2ncG1EKbaC+BM+4j1BsBcYWGp
         prKBATispgcOAScmPakzTzooK/T9uj61OxYOX0mH91o3ypq3ONOI/e82u+4YkNmJrLW8
         PILg==
X-Forwarded-Encrypted: i=1; AJvYcCU087OP+9Yqy00lAuIbNl4aClxXPnY3gbPG71K0mUC4izdPgNP24MoDw7yxfsZ7QHZWZwjjvLcmScDLlhOx@vger.kernel.org, AJvYcCX3wb3QK8Dr4I5AeJA+AQ1x39ImUGWjEfRJ4d7N/baZ618zWqJgwLneHYSbrufeWH2wi5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDE3IKTXRknvsrVvc4kQpLXlSGTzTT9qU9rq2IOWs2II3k2rxI
	njAPWpjY3Ucw3m7hAtbk+MBuaWUcP9pEScaTrkoPGRu8LWHlxdxEfCw4/PBgYgnfLy0I5fYubPF
	xPDtrmn5XmEko0ECjOKKfORZ2Wf0=
X-Gm-Gg: ASbGncuqI73PMLBtu7/s+u3t1ZpoxGuurK/2WCNJXaETZDAWsLlRSyLUcgy8DwXDTEU
	tlDOXDKdWOzd7kIy+OB4VV9Ipo23cvbVJhI/aLv2+BvBgnGE=
X-Google-Smtp-Source: AGHT+IEMvv+bBW74gapG6USwgksq/6t9Kjm3KIBA54jUWjfF9xIP05/vHTwEhz35ek8idcx2WuCqnbLAQgRF3ew0mlw=
X-Received: by 2002:a17:90b:4b05:b0:2ea:5083:6b67 with SMTP id
 98e67ed59e1d1-2eb0e526e1cmr19768084a91.20.1732582451882; Mon, 25 Nov 2024
 16:54:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67450f9b.050a0220.21d33d.0004.GAE@google.com>
In-Reply-To: <67450f9b.050a0220.21d33d.0004.GAE@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Nov 2024 16:54:00 -0800
Message-ID: <CAEf4BzYn_XcWLWBQNxHre4Tqjk51EE6fEEc+jRiz=BOHkMausg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in push_insn_history
To: syzbot <syzbot+5ca500b6e0bdb0d11dbc@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:00=E2=80=AFPM syzbot
<syzbot+5ca500b6e0bdb0d11dbc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11e13ee858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db193f152f0257=
905
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5ca500b6e0bdb0d=
11dbc
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e4af736be07e/vmlinu=
x-9f16d5e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8b23128a7c9e/b=
zImage-9f16d5e6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5ca500b6e0bdb0d11dbc@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: vmalloc-out-of-bounds in push_insn_history+0x615/0x690 kernel=
/bpf/verifier.c:3579
> Write of size 4 at addr ffffc90002db9010 by task syz.0.4094/25926
>
> CPU: 3 UID: 0 PID: 25926 Comm: syz.0.4094 Not tainted 6.12.0-syzkaller-09=
073-g9f16d5e6f220 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:489
>  kasan_report+0xd9/0x110 mm/kasan/report.c:602
>  push_insn_history+0x615/0x690 kernel/bpf/verifier.c:3579
>  do_check kernel/bpf/verifier.c:18594 [inline]
>  do_check_common+0xb78/0xd540 kernel/bpf/verifier.c:21848
>  do_check_main kernel/bpf/verifier.c:21939 [inline]
>  bpf_check+0x77c2/0xc9b0 kernel/bpf/verifier.c:22656
>  bpf_prog_load+0xe3f/0x2670 kernel/bpf/syscall.c:2947
>  __sys_bpf+0x5677/0x57a0 kernel/bpf/syscall.c:5790
>  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
>  __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5895
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf740e579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90=
 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f50d555c EFLAGS: 00000296 ORIG_RAX: 0000000000000165
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000200017c0
> RDX: 0000000000000048 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> The buggy address belongs to the virtual mapping at
>  [ffffc90002d99000, ffffc90002dbb000) created by:
>  kvrealloc_noprof+0xfc/0x150 mm/util.c:755
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880741c=
9e88 pfn:0x741c9
> flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: ffff8880741c9e88 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2=
(GFP_HIGHUSER|__GFP_NOWARN), pid 25926, tgid 25924 (syz.0.4094), ts 1129383=
943138, free_ts 1129046992178
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>  __alloc_pages_slowpath mm/page_alloc.c:4286 [inline]
>  __alloc_pages_noprof+0x6a6/0x25a0 mm/page_alloc.c:4764
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
>  vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3667 [inline]
>  __vmalloc_node_range_noprof+0x724/0x1530 mm/vmalloc.c:3844
>  __kvmalloc_node_noprof+0x14f/0x1a0 mm/util.c:680
>  kvrealloc_noprof+0xfc/0x150 mm/util.c:755
>  push_insn_history+0x2ac/0x690 kernel/bpf/verifier.c:3571
>  do_check kernel/bpf/verifier.c:18594 [inline]
>  do_check_common+0xb78/0xd540 kernel/bpf/verifier.c:21848
>  do_check_main kernel/bpf/verifier.c:21939 [inline]
>  bpf_check+0x77c2/0xc9b0 kernel/bpf/verifier.c:22656
>  bpf_prog_load+0xe3f/0x2670 kernel/bpf/syscall.c:2947
>  __sys_bpf+0x5677/0x57a0 kernel/bpf/syscall.c:5790
>  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
>  __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5895
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> page last free pid 29 tgid 29 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
>  rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>  rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
>  handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
>  run_ksoftirqd kernel/softirq.c:943 [inline]
>  run_ksoftirqd+0x3a/0x60 kernel/softirq.c:935
>  smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffffc90002db8f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90002db8f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90002db9000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                          ^
>  ffffc90002db9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc90002db9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:   10 06                   adc    %al,(%rsi)
>    2:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
>    6:   10 07                   adc    %al,(%rdi)
>    8:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
>    c:   10 08                   adc    %cl,(%rax)
>    e:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
>   1e:   00 51 52                add    %dl,0x52(%rcx)
>   21:   55                      push   %rbp
>   22:   89 e5                   mov    %esp,%ebp
>   24:   0f 34                   sysenter
>   26:   cd 80                   int    $0x80
> * 28:   5d                      pop    %rbp <-- trapping instruction
>   29:   5a                      pop    %rdx
>   2a:   59                      pop    %rcx
>   2b:   c3                      ret
>   2c:   90                      nop
>   2d:   90                      nop
>   2e:   90                      nop
>   2f:   90                      nop
>   30:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>   37:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>

#syz fix: mm: fix vrealloc()'s KASAN poisoning logic

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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

