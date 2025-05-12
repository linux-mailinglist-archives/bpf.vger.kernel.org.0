Return-Path: <bpf+bounces-58070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0FAB47A6
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E033517312E
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A729A317;
	Mon, 12 May 2025 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/XvJhhW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732761DDC37;
	Mon, 12 May 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090330; cv=none; b=D7SRV+hDe6Q+gc8eT4sNi2Q21jsggFz8sn3Df2803TUXmgCxO9TaYrgvj3DYeo5aiumppZ+y3mtvQrxN9jG1vVT0avFVkN6JahVtxHmw92eHIDiYF1q/2MISOn1m2Tn2pnjjkX/DMGLGNdi+ZJS5rjbQac6fTLyKo4dJoprFOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090330; c=relaxed/simple;
	bh=+2Ms/usPX5CMzykOIhBz/ZKKaWzgUYfcwOGBn9AOMuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kygbyDaRKOMtCYiNNyY+4CxhjO5yTlOgcUgn4LO9s8eZA45teW4C21Nsd2botO9kDLOsn0ccJxZRlhHw6H+AF29qhf5ZZ6lV4RY5aKsUI3OuTrae1ie1YjmZZLRFKP9vmo11AL51kSgaIHSWdPkSH6fR5DT2R6ye8fWSGCCBhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/XvJhhW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so6566339a91.2;
        Mon, 12 May 2025 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090328; x=1747695128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpQ6ch30sti2jqkD3TIH1IFmAzIpyH5dOkHFA3Rk2pA=;
        b=X/XvJhhW9unAy2Hj9FtCI4SdPEL69B8ajC+cLRaXRmWFZrifJzBmAzdKUuYZbB1aUa
         wG0162KCk4B9jK3+6ak0bJVRP49R4b/upQZa1kQUuQ3TQEo3jwiV2Im5EYYhZ+jKWfZf
         IDvGrEVrmUXUhmGsNPpTidzyHpnwfKBPV9+K0BxiV1LN2+lh12CMN0WciyQL0A4dpDRO
         4lohTdXyXfLO+C2e3aWbUSFt01BZTKEDCWQgxani3MNFeM+wi6nWB6jlRc3NKon1Sa8S
         YWD4/1ea8PgfiOovhXpu5W2Rpn7zrhox14HuWA97pwi6rof0Hw3Fbrqjf2e5WcJuG9H2
         328w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090328; x=1747695128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpQ6ch30sti2jqkD3TIH1IFmAzIpyH5dOkHFA3Rk2pA=;
        b=f2KqUl5lvVSMZcpftF1DDNNQ/XI82FdXUl1Jw7P00mTvnRVJv//71SIX2gbmoKYoSK
         T7LseuKm0cpCZ/czSTOUbQtmCSF+OhdNe5aM66f4BmkhPr/ITrT3KQXZy/QBLReQKIBY
         qnLurrdDNECggmugu+96ZTStDrmfy4wkpL7ayzlw7jOTO5xizA6HWf1ZUSnJFzS/wVcX
         DbX0Ddgh8UL/nd/5blvl/uT9oFDYEDaPL+zcxOlPqSsd4Ap5sQd0MYSnsfZOPgU97jzo
         ft/RStBphwCsWqzg/ycwq7VhtbtH8rqabnfh+TVc30LHdI43t67adwLsUhx9yXXc+WX/
         I8gA==
X-Forwarded-Encrypted: i=1; AJvYcCW/HJZD3tBKndV3LUszXqyk+8Id/nZmYJP9Hr59lcCMx5u7Zs1Fz3jNvl+Y/AcYAFEeVSg=@vger.kernel.org, AJvYcCX0SORa3AXX6E2IDrZCr7cj0saAxM4cZXkxc0cIp7sHwyhmrn2EtSnCsuP/bxYAPId4kuZzTX4bKQtR+Txr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y0u2I1MQ2y18DZNzrrznKSS0e2DL5ftkOXsEk2EcLJ6HFoPF
	FW1u4bB3IzIg02igGnPWkCYYIqgu9W5GfECClHgZUhBvCOp7+S2E2akWHKx0qPqzndmbBZshBgK
	Eej2ZcrxqMvsm401l82btbP4t9jNCdGHnWdY=
X-Gm-Gg: ASbGncvCmbHig79PbJoxfBVc/eGZ/tdNfZiY6FDCd1i5FZ0lIwQoZg6jMdkkOzIy+gE
	JX618Z+++RZvhVvurGTWwbSfprb9aObpGIsNzSWZCW+4qTkBXxT7oQZk13jgoLT9k5lNOHghexp
	Xc4yHy+vIo2ZlqWIVxdivkCOBt7LbQ6I5KfG4jBqVKUYZNoG/X
X-Google-Smtp-Source: AGHT+IHM5McT06U4FCBX+/goPWS7Hu9V1ElAozaAaSMpdcmsWpbCi+WX+mt16dsCwed88Tjcw/ec48XgocjHMhPsZhE=
X-Received: by 2002:a17:90b:268a:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-30c3d646aa1mr22640028a91.28.1747090327660; Mon, 12 May 2025
 15:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68213ddf.050a0220.f2294.0045.GAE@google.com>
In-Reply-To: <68213ddf.050a0220.f2294.0045.GAE@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 15:51:55 -0700
X-Gm-Features: AX0GCFsW1SFAfKK_U2dGoIDXQ0WUuJ3sF82UfxfUlmfChmshRgxfclVZLOFQE3I
Message-ID: <CAEf4BzbsmHonD-G45-Jo8RQHPjDYEz-Nwx0MGtsk427tgsqGkg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in
 vrealloc_noprof (2)
To: syzbot <syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com>, 
	Linux Memory Management List <linux-mm@kvack.org>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 5:16=E2=80=AFPM syzbot
<syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    707df3375124 Merge tag 'media/v6.15-2' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b1b2bc58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D91c351a0f6229=
e67
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D659fcc0678e5a11=
93143
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd=
6-1~exp1~20250402004600.97), Debian LLD 20.1.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-707df337.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bc3944720ea5/vmlinu=
x-707df337.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7bc2f45ae23f/b=
zImage-707df337.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+659fcc0678e5a1193143@syzkaller.appspotmail.com
>
> syz.0.0 uses obsolete (PF_INET,SOCK_PACKET)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x396/0x430 mm/vmall=
oc.c:4093
> Write of size 4064 at addr ffffc9000efa1020 by task syz.0.0/5317
>

A while back I sent a fix for kasan handling of vrealloc ([0]), but
this issue came back even with my changes in [0]. Can anyone from mm
side take a look at vrealloc_noprof() and see if we are missing
anything else to convince KASAN that we are using vrealloc()
correctly?

Seems like kasan_poison_vmalloc() + kasan_unpoison_vmalloc() dance
isn't covering all cases? Or am I missing something? It's doubtful
that there is any BPF-side bug in using kvrealloc().

  [0] https://lore.kernel.org/linux-mm/20241126005206.3457974-1-andrii@kern=
el.org/

> CPU: 0 UID: 0 PID: 5317 Comm: syz.0.0 Not tainted 6.15.0-rc5-syzkaller-00=
038-g707df3375124 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xb4/0x290 mm/kasan/report.c:521
>  kasan_report+0x118/0x150 mm/kasan/report.c:634
>  check_region_inline mm/kasan/generic.c:-1 [inline]
>  kasan_check_range+0x29a/0x2b0 mm/kasan/generic.c:189
>  __asan_memset+0x22/0x50 mm/kasan/shadow.c:84
>  vrealloc_noprof+0x396/0x430 mm/vmalloc.c:4093
>  push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
>  do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
>  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
>  do_check_main kernel/bpf/verifier.c:22867 [inline]
>  bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
>  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
>  __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f649c58e969
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f649d4dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f649c7b5fa0 RCX: 00007f649c58e969
> RDX: 0000000000000048 RSI: 00002000000017c0 RDI: 0000000000000005
> RBP: 00007f649c610ab1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f649c7b5fa0 R15: 00007fff542287e8
>  </TASK>
>
> The buggy address belongs to the virtual mapping at
>  [ffffc9000ef81000, ffffc9000efa3000) created by:
>  kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x3ffd0 pfn:0x=
3efe5
> flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 000000000003ffd0 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2=
(GFP_HIGHUSER|__GFP_NOWARN), pid 5317, tgid 5316 (syz.0.0), ts 82587533383,=
 free_ts 81110216781
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
>  prep_new_page mm/page_alloc.c:1726 [inline]
>  get_page_from_freelist+0x21ce/0x22b0 mm/page_alloc.c:3688
>  __alloc_pages_slowpath+0x2fe/0xcc0 mm/page_alloc.c:4509
>  __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:4983
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
>  alloc_frozen_pages_noprof mm/mempolicy.c:2372 [inline]
>  alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2392
>  vm_area_alloc_pages mm/vmalloc.c:3591 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3669 [inline]
>  __vmalloc_node_range_noprof+0x8fe/0x12c0 mm/vmalloc.c:3844
>  __kvmalloc_node_noprof+0x3a0/0x5e0 mm/slub.c:5034
>  kvrealloc_noprof+0x82/0xe0 mm/slub.c:5109
>  push_insn_history+0x184/0x650 kernel/bpf/verifier.c:3874
>  do_check+0x597/0xd630 kernel/bpf/verifier.c:19450
>  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22776
>  do_check_main kernel/bpf/verifier.c:22867 [inline]
>  bpf_check+0x13679/0x19a70 kernel/bpf/verifier.c:24033
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2971
>  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5834
>  __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5939
> page last free pid 82 tgid 82 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1262 [inline]
>  free_unref_folios+0xb81/0x14a0 mm/page_alloc.c:2782
>  shrink_folio_list+0x3053/0x4e90 mm/vmscan.c:1552
>  evict_folios+0x417b/0x5110 mm/vmscan.c:4698
>  try_to_shrink_lruvec+0x705/0x990 mm/vmscan.c:4859
>  shrink_one+0x21b/0x7c0 mm/vmscan.c:4904
>  shrink_many mm/vmscan.c:4967 [inline]
>  lru_gen_shrink_node mm/vmscan.c:5045 [inline]
>  shrink_node+0x3139/0x3750 mm/vmscan.c:6016
>  kswapd_shrink_node mm/vmscan.c:6867 [inline]
>  balance_pgdat mm/vmscan.c:7050 [inline]
>  kswapd+0x1675/0x2970 mm/vmscan.c:7315
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Memory state around the buggy address:
>  ffffc9000efa0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc9000efa0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc9000efa1000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                                ^
>  ffffc9000efa1080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc9000efa1100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

