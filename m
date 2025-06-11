Return-Path: <bpf+bounces-60318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CBAD5671
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C781BC4FA7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936A2749E7;
	Wed, 11 Jun 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEejDtVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B826E6FD;
	Wed, 11 Jun 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646981; cv=none; b=DdfHxRwmDNiFCm6We47toN8uFDCzADxKxQUccdbzeTnquV2IfSvhuQsHLx0qiyK2lSnzWsw5TWEEXf8+C50z5G7PO9yasxutcjgEAz0BaS33siQmRru+DZ+CgeRhwoSqbBlzg8e2UcLCaI5VPlWiZfy9G/NL0wtaBjn7FSwRSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646981; c=relaxed/simple;
	bh=Acfz1JqeLHdleEU/mUPfyIzmkEGrb5tVaxY+E7oFaX4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3WpF0j0gbxgd5Zhf/tWG5MocWl83Ab3yHVOeKguNarWTNLJ97fU5XcB7EGXrF56uxLhUoIugd7PgQGHSqwbttAcFiASf7aRQAUHWd47h67l6bBkAptfaqGzRdBO+bzAHsEnNQhlV9lrEO09flJZZm960bjmkzfSfzcOI4FJ2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEejDtVM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2fd091f826so185823a12.1;
        Wed, 11 Jun 2025 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749646978; x=1750251778; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcPiLbu+L7ytyP5aI8MDC2OToFoTTKHxHfoX0oiN0iA=;
        b=OEejDtVMIMx0prXiA3a+9110BLahFsTmXxHGBfagzr3byPyBUeh1hcdE+uM1ZVBNGx
         25VwMu87JLc9D+8oEKjPrZ3MU9zdZ5yCgsVJPUdj/ZjHQPr0Cjqo90Blo+lFHRVaaTGK
         dKWVhbm/JtC8VZWHLUPI0GZ9+2LOBl5Na3ZYgfQhAzAct2cbrQNnvnqgS8JltPFnDVvC
         kunTsA10lyNNXa7k4znTW9ybJKn7dKyE3a1jR4kqN4Wy29Dri6DdSkaicnGK2sZ2n9Mm
         ptxBJiv0aO3Qylggp6B6/CpBDMEMehBwPvUHQBgAIi2/wdVt5Iy9RXF8XfGs+xlVhViG
         RYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646978; x=1750251778;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcPiLbu+L7ytyP5aI8MDC2OToFoTTKHxHfoX0oiN0iA=;
        b=d5CnofFUp7vHvrWgsrDboY7yaNPCKluxxGdHEwlixYKITM/4V9cr60E1UFm58yuJn5
         HeSsHBKKqOWoiM0lwtStGv+04oQHpUNz5zxOXQRiP7J0EpDNFl+52XtLyQiCcmubBQJc
         hOOHwxu5WcWWiCGSectaNoDdfkNXFo4Gt3V8lm4ph7H2UuiKFyHi9j7p2zesgCDwcJcY
         KYVteBtzg0zrmajpsQoZpgo3n82wG32BDQmvxyyC4gOfFdbTJ3ZilwnQGDsVlpiJ6GrY
         TR5kC92DIQqfj4tW1CEIrgOxzB50H5WQEk8BdInXW4orHJ584tZQlAuG0cGqwes+Tkkt
         nIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU26lwwcK2RrZcj/zaEZo7ZWJT+GiMT0II56gopDm2VD1CwGORIEAv8QCN27iuAfISZ28=@vger.kernel.org, AJvYcCWmMQvuTktSKvGY4+XM2H29riluQeUelm7ak8pQm0lKar6IRIOQ7dmN4XPLsk4rwdzgfpCNJKDjexEj6uIv@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpQYr8KrEyOs9CIZ4s0OsOERMDLu9PBjAyOAHR7e9vriLbHMh
	0FdrULRXbN71Brm2VXueuWiIsTrAqZzRdo7ZRPhkTqLmftms0vrkFK+MWiL4XRKfaPU=
X-Gm-Gg: ASbGncvWLQ+nyYUWxEk7rQIo+XWxZ7wfR7HP/1/kKw6nwiLNY792bqg28wLn+Uiej97
	ib93/SB3ECTjwwdoa2Wl1CZMyTBzmomdKiYGkhcQdmeWRmgSUQZqA4hUwAHMctKCabZq4EQ70kl
	Az8fEC8WZi6AOA2vImJ4ztdbD0bZyf0jgCf34Z57or3CcsUxgyrJNonK83oM9CK37R0p/im6Pe+
	HBi/vPiAlAjKzsk2YPUkOLTZnCEC9qG2ce++2uJpDnltKrBWcX3+Q2o6kkzRkbG9B5yaDgWZyi4
	V4rPKyqs5AimgfeAgJa7eg2/+K6jnorHm3rnVpDVT5kP6OCQ7ew7uQvE/Q==
X-Google-Smtp-Source: AGHT+IE+tCMEFwCrOYPgc6aKsfUwF0lX+OYZ1Ju0x6P/3V3leHB57enyf9KbA8gKKYnfAnncz9gBtg==
X-Received: by 2002:a17:902:e551:b0:231:e413:986c with SMTP id d9443c01a7336-236416dabbdmr42876595ad.11.1749646977711;
        Wed, 11 Jun 2025 06:02:57 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcd58sm87487055ad.122.2025.06.11.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:02:57 -0700 (PDT)
Message-ID: <38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Wed, 11 Jun 2025 06:02:55 -0700
In-Reply-To: <68497853.050a0220.33aa0e.036a.GAE@google.com>
References: <68497853.050a0220.33aa0e.036a.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 05:36 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    19a60293b992 Add linux-next specific files for 20250611
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D15472d7058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D76ed3656d7159=
e27
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db5eb72a560b8149=
a1885
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e0775=
7-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16af860c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D174db60c58000=
0
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c453c11565fa/dis=
k-19a60293.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4034ded42b2e/vmlinu=
x-19a60293.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5355903cdb8f/b=
zImage-19a60293.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b5eb72a560b8149a1885@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in do_check+0xb388/0xe170 kernel/bpf/veri=
fier.c:19756
> Read of size 1 at addr ffff88801deeef79 by task syz-executor672/5842
>=20
> CPU: 1 UID: 0 PID: 5842 Comm: syz-executor672 Not tainted 6.16.0-rc1-next=
-20250611-syzkaller #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xd2/0x2b0 mm/kasan/report.c:521
>  kasan_report+0x118/0x150 mm/kasan/report.c:634
>  do_check+0xb388/0xe170 kernel/bpf/verifier.c:19756
>  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22905
>  do_check_main kernel/bpf/verifier.c:22996 [inline]
>  bpf_check+0x1381e/0x19e50 kernel/bpf/verifier.c:24162
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
>  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
>  __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7586cdbeb9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc2e683128 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7586cdbeb9
> RDX: 0000000000000094 RSI: 0000200000000840 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>=20
> Allocated by task 5842:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:260 [inline]
>  __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>  do_check_common+0x13f/0x20b0 kernel/bpf/verifier.c:22798
>  do_check_main kernel/bpf/verifier.c:22996 [inline]
>  bpf_check+0x1381e/0x19e50 kernel/bpf/verifier.c:24162
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
>  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
>  __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 5842:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2381 [inline]
>  slab_free mm/slub.c:4643 [inline]
>  kfree+0x18e/0x440 mm/slub.c:4842
>  push_stack+0x247/0x3c0 kernel/bpf/verifier.c:2069
>  check_cond_jmp_op+0x1069/0x2340 kernel/bpf/verifier.c:16562
>  do_check_insn kernel/bpf/verifier.c:19621 [inline]
>  do_check+0x672c/0xe170 kernel/bpf/verifier.c:19755
>  do_check_common+0x168d/0x20b0 kernel/bpf/verifier.c:22905
>  do_check_main kernel/bpf/verifier.c:22996 [inline]
>  bpf_check+0x1381e/0x19e50 kernel/bpf/verifier.c:24162
>  bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
>  __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
>  __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> The buggy address belongs to the object at ffff88801deeef00
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 121 bytes inside of
>  freed 192-byte region [ffff88801deeef00, ffff88801deeefc0)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1dee=
e
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801a4413c0 ffffea00006fca40 dead000000000004
> raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(=
GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0=
), ts 2954361175, free_ts 2954343552
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
>  prep_new_page mm/page_alloc.c:1712 [inline]
>  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
>  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
>  alloc_slab_page mm/slub.c:2451 [inline]
>  allocate_slab+0x8a/0x3b0 mm/slub.c:2619
>  new_slab mm/slub.c:2673 [inline]
>  ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
>  __slab_alloc mm/slub.c:3949 [inline]
>  __slab_alloc_node mm/slub.c:4024 [inline]
>  slab_alloc_node mm/slub.c:4185 [inline]
>  __do_kmalloc_node mm/slub.c:4327 [inline]
>  __kmalloc_node_noprof+0x2fd/0x4e0 mm/slub.c:4334
>  kmalloc_node_noprof include/linux/slab.h:932 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3690 [inline]
>  __vmalloc_node_range_noprof+0x5a9/0x12f0 mm/vmalloc.c:3885
>  vmalloc_huge_node_noprof+0xb3/0xf0 mm/vmalloc.c:4001
>  vmalloc_huge include/linux/vmalloc.h:185 [inline]
>  alloc_large_system_hash+0x2b8/0x5e0 mm/mm_init.c:2515
>  posixtimer_init+0x140/0x270 kernel/time/posix-timers.c:1561
>  do_one_initcall+0x233/0x820 init/main.c:1274
>  do_initcall_level+0x137/0x1f0 init/main.c:1336
>  do_initcalls+0x69/0xd0 init/main.c:1352
>  kernel_init_freeable+0x3d9/0x570 init/main.c:1584
>  kernel_init+0x1d/0x1d0 init/main.c:1474
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1248 [inline]
>  __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
>  __kasan_populate_vmalloc mm/kasan/shadow.c:383 [inline]
>  kasan_populate_vmalloc+0x18a/0x1a0 mm/kasan/shadow.c:417
>  alloc_vmap_area+0xd51/0x1490 mm/vmalloc.c:2084
>  __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3179
>  __vmalloc_node_range_noprof+0x301/0x12f0 mm/vmalloc.c:3845
>  vmalloc_huge_node_noprof+0xb3/0xf0 mm/vmalloc.c:4001
>  vmalloc_huge include/linux/vmalloc.h:185 [inline]
>  alloc_large_system_hash+0x2b8/0x5e0 mm/mm_init.c:2515
>  posixtimer_init+0x140/0x270 kernel/time/posix-timers.c:1561
>  do_one_initcall+0x233/0x820 init/main.c:1274
>  do_initcall_level+0x137/0x1f0 init/main.c:1336
>  do_initcalls+0x69/0xd0 init/main.c:1352
>  kernel_init_freeable+0x3d9/0x570 init/main.c:1584
>  kernel_init+0x1d/0x1d0 init/main.c:1474
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>=20
> Memory state around the buggy address:
>  ffff88801deeee00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88801deeee80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> > ffff88801deeef00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                                 ^
>  ffff88801deeef80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff88801deef000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---

Accessed memory is freed at an error path in push_stack():

  static struct bpf_verifier_state *push_stack(...)
  {
  	...
  err:
  	free_verifier_state(env->cur_state, true); // <-- KASAN points here
  	...
  }

And is accessed after being freed here:

  static int do_check(struct bpf_verifier_env *env)
  {
  	...
		err =3D do_check_insn(env, &do_print_state);
KASAN -->	if (state->speculative && error_recoverable_with_nospec(err)) ...
  	...
  }
 =20
[...]

Either 'state =3D env->cur_state' is needed after 'do_check_insn()' or
error path should not free env->cur_state (seems logical).


