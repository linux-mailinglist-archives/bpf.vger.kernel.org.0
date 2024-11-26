Return-Path: <bpf+bounces-45606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122199D8F89
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 01:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B0828539E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1083C14;
	Tue, 26 Nov 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilKKNhHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136B2F56;
	Tue, 26 Nov 2024 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580841; cv=none; b=qXNL+7717y8U0BL4Fts0YEzTYPQtXQ8vCZ1djAdltI3ca2qERjvHvzcYU8SeDandz4Xbd2e6Def8ZTV5QUHbsZUJFzIP0VqPaPxTm9I3p/bRrCNI6YvYWTHf8+nFKXW1lr6vSpIrwyv89aTLDwUIvq6fx6oSqj1stEaLUZJw9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580841; c=relaxed/simple;
	bh=2ETn0hXoW43JbW/rVdjhgFRnd+tyGGv3zkVzeiIKMAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4FLpJIsNqDJrybbN1sRlqayNIw5reHGnJokJvITM4JHfrFIBGL52yHyHcddtrvXsAYoHCoAvZKO0mu5wUZ0t/jvWK4mGL4f2danieXg7EN9K6jrSN47tC6b0tE2ySQ7Sh2ULKmASVnLgkxbkiSiGpGs+DGgFDGVbc5BdRWw2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilKKNhHo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a10588f3so10385455e9.1;
        Mon, 25 Nov 2024 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732580837; x=1733185637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J7TWIGeu/Z7AN0jwLNtpE9cw3m+Ow46mLkTGDhL7iM=;
        b=ilKKNhHo7jub/8gPV/6PTVFjZIs2M5izT7CRnxXHlUY+byW0rJDhFF3yruaGPVwduq
         Wqpaviwedns0d9yohHFNhKFKXtL/HHvun2c/tWIOl6xh33DeeqNlM8jnj5HLpdkCxJEn
         oimfwBJ44rJ4hPo+lcXAXgSgQvKKuHyY/cfJBeLn+Ag9Cw0ipl17DzJHRIHWHVycEBXc
         MNBpHAIEGJeWrHRrNfRTK5ylRcN1+O46Rf2UalcHqS4uO4/rvfehb/LE4jFNQFHCH65a
         mPxMcpQ/g6hrrJkJNgCOnqRudYj6BAqdubsMFABYMHMCBwOf07KifY7cjetokxKDvG/G
         bm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732580837; x=1733185637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J7TWIGeu/Z7AN0jwLNtpE9cw3m+Ow46mLkTGDhL7iM=;
        b=ayGrGYBA3EjbZPij5APWswZbFhWMDiLJSLKxCCXuY0Tn+ZBTWQ/dt87pkexIAyAae+
         oJ5KSLcEXqASomysF5Z8fuMSs7m0mkC9FLqduG0926mP1jVqJxOa6sAm+U972r6/2mRM
         PeUNoheCZKcVg/qhRlzmvYnbY5DaZmRSsJ53Xbuc+D156nULSyJsbWt2wACWTMuaJxmw
         XbZAWzdW0mXD8rPRIOy97lMW86kf2A+AAO52sfRjS1NGyOiyW6+1u3Mf2ZONX+i16+35
         xy3jxhwBIGWc4QX+9fe+Z4KeOm6InmYbNmyh9ZgrTrDyRlxzPXSZaC3mUulUX4bULPuF
         61oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn9hC1v01Vqf6LJlYDZhiYV2jySs5CLFaeUFVL3PWmHhetBL36+zUzLL6PTOeISwyUSWI=@vger.kernel.org, AJvYcCWcU7O0Q7nd/UWMyk0RPlqzC2VG1MbUxMDL3QzDh/5agEYfZeIIiU+MFVPf9s3AEcyN+ZXOeOKu6MqSwbjx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TuRbBEjj0gyu/kQ7fAtIk1LAkzoQTqZpOKtfSc2hKFiAuXYH
	hmyxhWFe3Txt9wGCJU/6M/CDcxx2P+RA3/+N7H/SpgMzDauP5TRnWjahU9HSsM+tUoE0epO+Trc
	agkMhF2iFfUajwP4b0dynbaLnwgU=
X-Gm-Gg: ASbGncu/wppQwJSlPlFD5QTej4O1/vkU7Ya61wS0Fyx13KPhQQciA9+j9aHgUlsLPbp
	OQumljyLuukfKgPDQp5uWxvbsRUiZebLo7Uyyqp/R1b5lY7M=
X-Google-Smtp-Source: AGHT+IF2Wv2K5Pxvlr4n6ZUbtjCgykfGSRFkxUgt+35bBhuW/Q1kDvbCm1FOBcoVzJ3hcNfvPMnVcSfy5sbhoZAXrns=
X-Received: by 2002:a5d:6d8c:0:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-38260bce4a4mr13344657f8f.45.1732580837011; Mon, 25 Nov 2024
 16:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6743e5ec.050a0220.1cc393.0056.GAE@google.com>
In-Reply-To: <6743e5ec.050a0220.1cc393.0056.GAE@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Nov 2024 16:27:05 -0800
Message-ID: <CAADnVQKEEqhhqu6qTG7qBgv3t=ouzN8U4ewvAFsLUOG_TRBR8w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: vmalloc-out-of-bounds Write in vrealloc_noprof
To: syzbot <syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue is understood.
Commit 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()") is buggy.

Fix is wip.

Same as the other syzbot report.

On Sun, Nov 24, 2024 at 6:50=E2=80=AFPM syzbot
<syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ac24e26aa08f Add linux-next specific files for 20241120
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14d91b7858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D45719eec4c74e=
6ba
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7d9959e6503e8ff=
c8558
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124d8ec0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1425a75f98000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9c6bcf3605c7/dis=
k-ac24e26a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ce96eb398a9/vmlinu=
x-ac24e26a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a22aac22c90/b=
zImage-ac24e26a.xz
>
> The issue was bisected to:
>
> commit 96a30e469ca1d2b8cc7811b40911f8614b558241
> Author: Andrii Nakryiko <andrii@kernel.org>
> Date:   Fri Nov 15 00:13:03 2024 +0000
>
>     bpf: use common instruction history across all states
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D102bd93058=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D122bd93058=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D142bd93058000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7d9959e6503e8ffc8558@syzkaller.appspotmail.com
> Fixes: 96a30e469ca1 ("bpf: use common instruction history across all stat=
es")
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: vmalloc-out-of-bounds in vrealloc_noprof+0x340/0x3a0 mm/vmall=
oc.c:4095
> Write of size 2097120 at addr ffffc90004c00020 by task syz-executor132/58=
34
>
> CPU: 1 UID: 0 PID: 5834 Comm: syz-executor132 Not tainted 6.12.0-next-202=
41120-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/30/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:489
>  kasan_report+0x143/0x180 mm/kasan/report.c:602
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
>  vrealloc_noprof+0x340/0x3a0 mm/vmalloc.c:4095
>  push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
>  check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
>  do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
>  do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
>  do_check_main kernel/bpf/verifier.c:21939 [inline]
>  bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
>  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
>  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
>  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fae10fcf269
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdf2bc3148 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fae10fcf269
> RDX: 0000000000000090 RSI: 0000000020000840 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000000a0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
>
> The buggy address belongs to the virtual mapping at
>  [ffffc90004800000, ffffc90004e01000) created by:
>  kvrealloc_noprof+0xc7/0x120 mm/util.c:747
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6c60=
0
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102cc2=
(GFP_HIGHUSER|__GFP_NOWARN), pid 5834, tgid 5834 (syz-executor132), ts 1145=
73563417, free_ts 25588986996
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3667 [inline]
>  __vmalloc_node_range_noprof+0x9c9/0x1380 mm/vmalloc.c:3844
>  __kvmalloc_node_noprof+0x142/0x190 mm/util.c:672
>  kvrealloc_noprof+0xc7/0x120 mm/util.c:747
>  push_insn_history+0x16c/0x6a0 kernel/bpf/verifier.c:3571
>  check_mem_access+0xf30/0x2240 kernel/bpf/verifier.c:7267
>  do_check+0x7d97/0xfcd0 kernel/bpf/verifier.c:18703
>  do_check_common+0x1564/0x2010 kernel/bpf/verifier.c:21848
>  do_check_main kernel/bpf/verifier.c:21939 [inline]
>  bpf_check+0x19380/0x1f1b0 kernel/bpf/verifier.c:22656
>  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2947
>  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5790
>  __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2693
>  free_contig_range+0x152/0x550 mm/page_alloc.c:6666
>  destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
>  debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
>  do_one_initcall+0x248/0x880 init/main.c:1266
>  do_initcall_level+0x157/0x210 init/main.c:1328
>  do_initcalls+0x3f/0x80 init/main.c:1344
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>  kernel_init+0x1d/0x2b0 init/main.c:1466
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Memory state around the buggy address:
>  ffffc90004bfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90004bfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90004c00000: 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                                ^
>  ffffc90004c00080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>  ffffc90004c00100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
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

