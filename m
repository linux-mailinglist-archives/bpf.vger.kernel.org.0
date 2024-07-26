Return-Path: <bpf+bounces-35748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95393D7EE
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 20:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA0B281439
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995917C7B1;
	Fri, 26 Jul 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWf2dMaI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DC3987B;
	Fri, 26 Jul 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016964; cv=none; b=Kq4fcS3DvjK8gQvhFtLJ65+tyzIVm1Qmf7CfESnfXTKommPv2k0rhbaHClK0hQedFxNEiAUIKtkyMaz7vjPkl56bODgibKfgpgmfSYU4t2+Tx9qX3BxG5nOoH3m9Bv0zmzg2NZN1yewlcHV9MnpCsfR/ALaVY+0RJmx/sm649ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016964; c=relaxed/simple;
	bh=oD9EqPyF62ydNATSRsGO0lTFgOEgSK37KY21nU7vijc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DckWqaDawfHDjjB+A0XJQ5NZYdDa4RJqlPskU+J2/FmkAahcuURJ5hsk5Oe/kqrNDl42rqgKI0px4Hpjm8P1POIwqBhl0Bbffh+QjH+8yVVXSnwSwEoW8LTABn5sZVJEz2Ro69Boe+Nk4F9YMKcrwuT6mIR6jmKB0oB2k9lu1bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWf2dMaI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so3065009a12.2;
        Fri, 26 Jul 2024 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016961; x=1722621761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwCBJ7N9/PkUBTJxf0kafZCT4oLqr+FmjI57lyx0lKE=;
        b=WWf2dMaI2ptN/PvtjCwWgMyaIVshT1cZsYLU+7FX3FOKJuGPSq2GlIncq0xNunocbJ
         NYI2xO2c7pIO65WD66ot8YdtwfvSJxR0mMDHMOGzAWUnYoMp422hK7CYwqjCV5orgnhc
         p2rQnIFJrB59osDrHHgYd+CwQRGJSebIwpnBlANMJI69V27bbnOSBDQ4KlHMjihrZD5n
         CzWGsTk9vthQG0GyLF69poWx1lVtLlXERO9EU2p4zpbGcjT6tLg2AQ+5KbTNmTh08bYR
         r2f9YyR1udTb83mHzsoW7D33GtfFuCsZZv5L9zuPPBmqf+b1/aUKj5NRWkChlha2lPHN
         334A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016961; x=1722621761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwCBJ7N9/PkUBTJxf0kafZCT4oLqr+FmjI57lyx0lKE=;
        b=Lcu9uI+U6x9yDiTZWromNjR/q7UmYl5Bdi2H+fKGoha0wTXh/ZCraHWd4CLtaf5QBx
         uYHsaKRVs/LIi+QFWAl/xg48BaqL8Tz9NfmmyR2CF4rH5nqwGj4/0z+Zqv5pLdr2Ok+A
         a8tL6SEu750+5XFn0DQ3mtAAoNQ1aeNuxIb+8huphUWqtk4CO2X0pt+Sk8rgmF2cpqo7
         kvVzvsJrv3UvhHt97vBZeC8onftgyip8SjoK997BwLEXR8ba77EQZLrdH5vviCdRLLnZ
         gfjq5hDyG2KqNiX4/oJocsMvLKHP/rAtM/lrShWLpbHtBSC0TEUqc8geX+sFZkLIPsoS
         +Pag==
X-Forwarded-Encrypted: i=1; AJvYcCXUsjSgMQYMLRH2aZXDCD4/SMhj2vFqTOw1Z7SX6EKwNKMmNeK956gLt/iRRbfoH5x8AmhSHMeo8WSuAeZCAOCQvC2tck8TpdRKhqvddVKrQ0OVVwHn8eHZdmi5ZDGQPdXc0ih1s1dQNmhdrO6MXPJmfb7otJuNBoic
X-Gm-Message-State: AOJu0YyrmxYgT5+y3RU8DWO1AQbTB6TKeIfkCXgq3OS2mzAfW6i4++V3
	xi1ZqG7Y3FnIh3mzaJ/zUn3NhnOn96QdJHYIo19kAK+tTwt4o0HKMyQIQovU
X-Google-Smtp-Source: AGHT+IFyvY6keRX/2EJSz7JyYI8z3IUIph5wluSx5gs1a7L8IkMpQifLLnYnQKqyYuYu+bmaEf1smA==
X-Received: by 2002:a17:907:9713:b0:a72:6849:cb0f with SMTP id a640c23a62f3a-a7d4019d7abmr13636366b.62.1722016960451;
        Fri, 26 Jul 2024 11:02:40 -0700 (PDT)
Received: from LPPLJK6X5M3.. ([77.254.224.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233c0sm200114966b.44.2024.07.26.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 11:02:40 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Subject: [PATCH] bpf, cpumap: Fix use after free of bpf_cpu_map_entry in cpu_map_enqueue
Date: Fri, 26 Jul 2024 20:01:58 +0200
Message-ID: <20240726180157.1065502-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cpu_map has been redirected, first the pointer to the
bpf_cpu_map_entry has been copied, then freed, and read from the copy.
To fix it, this commit introduced the refcount cpu_map_parent during
redirections to prevent use after free.

syzbot reported:

[   61.581464][T11670] ==================================================================
[   61.583323][T11670] BUG: KASAN: slab-use-after-free in cpu_map_enqueue+0xba/0x370
[   61.585419][T11670] Read of size 8 at addr ffff888122d75208 by task syzbot-repro/11670
[   61.587541][T11670]
[   61.588237][T11670] CPU: 1 PID: 11670 Comm: syzbot-repro Not tainted 6.9.0-rc6-00053-g0106679839f7 #27
[   61.590542][T11670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.1 11/11/2019
[   61.592798][T11670] Call Trace:
[   61.593885][T11670]  <TASK>
[   61.594805][T11670]  dump_stack_lvl+0x241/0x360
[   61.595974][T11670]  ? tcp_gro_dev_warn+0x260/0x260
[   61.598242][T11670]  ? __wake_up_klogd+0xcc/0x100
[   61.599407][T11670]  ? panic+0x850/0x850
[   61.600516][T11670]  ? __virt_addr_valid+0x182/0x510
[   61.602073][T11670]  ? __virt_addr_valid+0x182/0x510
[   61.603496][T11670]  print_address_description+0x7b/0x360
[   61.605170][T11670]  print_report+0xfd/0x210
[   61.606370][T11670]  ? __virt_addr_valid+0x182/0x510
[   61.607925][T11670]  ? __virt_addr_valid+0x182/0x510
[   61.609577][T11670]  ? __virt_addr_valid+0x43d/0x510
[   61.610948][T11670]  ? __phys_addr+0xb9/0x170
[   61.612103][T11670]  ? cpu_map_enqueue+0xba/0x370
[   61.613448][T11670]  kasan_report+0x143/0x180
[   61.615000][T11670]  ? cpu_map_enqueue+0xba/0x370
[   61.616181][T11670]  cpu_map_enqueue+0xba/0x370
[   61.617620][T11670]  xdp_do_redirect+0x685/0xbf0
[   61.618787][T11670]  tun_xdp_act+0xe7/0x9e0
[   61.619856][T11670]  ? __tun_build_skb+0x2e0/0x2e0
[   61.621356][T11670]  tun_build_skb+0xac6/0x1140
[   61.622602][T11670]  ? tun_build_skb+0xb4/0x1140
[   61.623880][T11670]  ? tun_get_user+0x2760/0x2760
[   61.625341][T11670]  tun_get_user+0x7fa/0x2760
[   61.626532][T11670]  ? rcu_read_unlock+0xa0/0xa0
[   61.627725][T11670]  ? tun_get+0x1e/0x2f0
[   61.629147][T11670]  ? tun_get+0x1e/0x2f0
[   61.630265][T11670]  ? tun_get+0x27d/0x2f0
[   61.631486][T11670]  tun_chr_write_iter+0x111/0x1f0
[   61.632855][T11670]  vfs_write+0xa84/0xcb0
[   61.634185][T11670]  ? __lock_acquire+0x1f60/0x1f60
[   61.635501][T11670]  ? kernel_write+0x330/0x330
[   61.636757][T11670]  ? lockdep_hardirqs_on_prepare+0x43c/0x780
[   61.638445][T11670]  ? __fget_files+0x3ea/0x460
[   61.639448][T11670]  ? seqcount_lockdep_reader_access+0x157/0x220
[   61.641217][T11670]  ? __fdget_pos+0x19e/0x320
[   61.642426][T11670]  ksys_write+0x19f/0x2c0
[   61.643576][T11670]  ? __ia32_sys_read+0x90/0x90
[   61.644841][T11670]  ? ktime_get_coarse_real_ts64+0x10b/0x120
[   61.646549][T11670]  do_syscall_64+0xec/0x210
[   61.647832][T11670]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   61.649485][T11670] RIP: 0033:0x472a4f
[   61.650539][T11670] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 d8 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c d9 02 00 48
[   61.655476][T11670] RSP: 002b:00007f7a7a90f5c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[   61.657675][T11670] RAX: ffffffffffffffda RBX: 00007f7a7a911640 RCX: 0000000000472a4f
[   61.659658][T11670] RDX: 0000000000000066 RSI: 0000000020000440 RDI: 00000000000000c8
[   61.661980][T11670] RBP: 00007f7a7a90f620 R08: 0000000000000000 R09: 0000000100000000
[   61.663982][T11670] R10: 0000000100000000 R11: 0000000000000293 R12: 00007f7a7a911640
[   61.666425][T11670] R13: 000000000000006e R14: 000000000042f2f0 R15: 00007f7a7a8f1000
[   61.668443][T11670]  </TASK>
[   61.669233][T11670]
[   61.669754][T11670] Allocated by task 11643:
[   61.670855][T11670]  kasan_save_track+0x3f/0x70
[   61.672094][T11670]  __kasan_kmalloc+0x98/0xb0
[   61.673466][T11670]  __kmalloc_node+0x259/0x4f0
[   61.674687][T11670]  bpf_map_kmalloc_node+0xd3/0x1c0
[   61.676069][T11670]  cpu_map_update_elem+0x2f0/0x1000
[   61.677619][T11670]  bpf_map_update_value+0x1b2/0x540
[   61.679006][T11670]  map_update_elem+0x52f/0x6e0
[   61.680076][T11670]  __sys_bpf+0x7a9/0x850
[   61.681610][T11670]  __x64_sys_bpf+0x7c/0x90
[   61.682772][T11670]  do_syscall_64+0xec/0x210
[   61.683967][T11670]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   61.685648][T11670]
[   61.686282][T11670] Freed by task 1064:
[   61.687296][T11670]  kasan_save_track+0x3f/0x70
[   61.688498][T11670]  kasan_save_free_info+0x40/0x50
[   61.689786][T11670]  poison_slab_object+0xa6/0xe0
[   61.691059][T11670]  __kasan_slab_free+0x37/0x60
[   61.692336][T11670]  kfree+0x136/0x2f0
[   61.693549][T11670]  __cpu_map_entry_free+0x6f3/0x770
[   61.695004][T11670]  cpu_map_free+0xc0/0x180
[   61.696191][T11670]  bpf_map_free_deferred+0xe3/0x100
[   61.697703][T11670]  process_scheduled_works+0x9cb/0x14a0
[   61.699330][T11670]  worker_thread+0x85c/0xd50
[   61.700546][T11670]  kthread+0x2ef/0x390
[   61.701791][T11670]  ret_from_fork+0x4d/0x80
[   61.702942][T11670]  ret_from_fork_asm+0x11/0x20
[   61.704195][T11670]
[   61.704825][T11670] The buggy address belongs to the object at ffff888122d75200
[   61.704825][T11670]  which belongs to the cache kmalloc-cg-256 of size 256
[   61.708516][T11670] The buggy address is located 8 bytes inside of
[   61.708516][T11670]  freed 256-byte region [ffff888122d75200, ffff888122d75300)
[   61.712215][T11670]
[   61.712824][T11670] The buggy address belongs to the physical page:
[   61.714883][T11670] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x122d74
[   61.717300][T11670] head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   61.719037][T11670] memcg:ffff888120d85f01
[   61.720006][T11670] flags: 0x17ff00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
[   61.722181][T11670] page_type: 0xffffffff()
[   61.723318][T11670] raw: 017ff00000000840 ffff88810004dcc0 dead000000000122 0000000000000000
[   61.725650][T11670] raw: 0000000000000000 0000000080100010 00000001ffffffff ffff888120d85f01
[   61.727943][T11670] head: 017ff00000000840 ffff88810004dcc0 dead000000000122 0000000000000000
[   61.730237][T11670] head: 0000000000000000 0000000080100010 00000001ffffffff ffff888120d85f01
[   61.732671][T11670] head: 017ff00000000001 ffffea00048b5d01 dead000000000122 00000000ffffffff
[   61.735029][T11670] head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
[   61.737400][T11670] page dumped because: kasan: bad access detected
[   61.740100][T11670] page_owner tracks the page as allocated
[   61.743121][T11670] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 8343, tgid -2092279795 (syzbot-repro), ts 8343, free_ts 43505720198
[   61.754038][T11670]  post_alloc_hook+0x1e6/0x210
[   61.756046][T11670]  get_page_from_freelist+0x7d2/0x850
[   61.759460][T11670]  __alloc_pages+0x25e/0x580
[   61.761428][T11670]  alloc_slab_page+0x6b/0x1a0
[   61.764199][T11670]  allocate_slab+0x5d/0x200
[   61.766122][T11670]  ___slab_alloc+0xac5/0xf20
[   61.767195][T11670]  __kmalloc+0x2e0/0x4b0
[   61.769028][T11670]  fib_default_rule_add+0x4a/0x350
[   61.770394][T11670]  fib6_rules_net_init+0x42/0x100
[   61.771731][T11670]  ops_init+0x39d/0x670
[   61.773061][T11670]  setup_net+0x3bc/0xae0
[   61.774102][T11670]  copy_net_ns+0x399/0x5e0
[   61.775628][T11670]  create_new_namespaces+0x4de/0x8d0
[   61.776950][T11670]  unshare_nsproxy_namespaces+0x127/0x190
[   61.778352][T11670]  ksys_unshare+0x5e6/0xbf0
[   61.779741][T11670]  __x64_sys_unshare+0x38/0x40
[   61.781302][T11670] page last free pid 4619 tgid 4619 stack trace:
[   61.783542][T11670]  free_unref_page_prepare+0x72f/0x7c0
[   61.785018][T11670]  free_unref_page+0x37/0x3f0
[   61.786030][T11670]  __slab_free+0x351/0x3f0
[   61.786991][T11670]  qlist_free_all+0x60/0xd0
[   61.788827][T11670]  kasan_quarantine_reduce+0x15a/0x170
[   61.789951][T11670]  __kasan_slab_alloc+0x23/0x70
[   61.790999][T11670]  kmem_cache_alloc_node+0x193/0x390
[   61.792331][T11670]  kmalloc_reserve+0xa7/0x2a0
[   61.793345][T11670]  __alloc_skb+0x1ec/0x430
[   61.794435][T11670]  netlink_sendmsg+0x615/0xc80
[   61.796439][T11670]  __sock_sendmsg+0x21f/0x270
[   61.797467][T11670]  ____sys_sendmsg+0x540/0x860
[   61.798505][T11670]  __sys_sendmsg+0x2b7/0x3a0
[   61.799512][T11670]  do_syscall_64+0xec/0x210
[   61.800674][T11670]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   61.802021][T11670]
[   61.802526][T11670] Memory state around the buggy address:
[   61.803701][T11670]  ffff888122d75100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   61.805694][T11670]  ffff888122d75180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   61.808104][T11670] >ffff888122d75200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   61.809769][T11670]                       ^
[   61.810672][T11670]  ffff888122d75280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   61.812532][T11670]  ffff888122d75300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   61.814846][T11670] ==================================================================
[   61.816914][T11670] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[   61.818415][T11670] CPU: 1 PID: 11670 Comm: syzbot-repro Not tainted 6.9.0-rc6-00053-g0106679839f7 #27
[   61.821191][T11670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.1 11/11/2019
[   61.822911][T11670] Call Trace:
[   61.823632][T11670]  <TASK>
[   61.824525][T11670]  dump_stack_lvl+0x241/0x360
[   61.825545][T11670]  ? tcp_gro_dev_warn+0x260/0x260
[   61.826706][T11670]  ? panic+0x850/0x850
[   61.828594][T11670]  ? lock_release+0x85/0x860
[   61.829749][T11670]  ? vscnprintf+0x5d/0x80
[   61.830951][T11670]  panic+0x335/0x850
[   61.832316][T11670]  ? check_panic_on_warn+0x21/0xa0
[   61.834475][T11670]  ? __memcpy_flushcache+0x2c0/0x2c0
[   61.835809][T11670]  ? _raw_spin_unlock_irqrestore+0xd8/0x140
[   61.838063][T11670]  ? _raw_spin_unlock_irqrestore+0xdd/0x140
[   61.842056][T11670]  ? _raw_spin_unlock+0x40/0x40
[   61.843116][T11670]  ? print_report+0x1cc/0x210
[   61.844527][T11670]  check_panic_on_warn+0x82/0xa0
[   61.845336][T11670]  ? cpu_map_enqueue+0xba/0x370
[   61.846117][T11670]  end_report+0x48/0xa0
[   61.846790][T11670]  kasan_report+0x154/0x180
[   61.847520][T11670]  ? cpu_map_enqueue+0xba/0x370
[   61.848471][T11670]  cpu_map_enqueue+0xba/0x370
[   61.849968][T11670]  xdp_do_redirect+0x685/0xbf0
[   61.850994][T11670]  tun_xdp_act+0xe7/0x9e0
[   61.851703][T11670]  ? __tun_build_skb+0x2e0/0x2e0
[   61.852598][T11670]  tun_build_skb+0xac6/0x1140
[   61.853362][T11670]  ? tun_build_skb+0xb4/0x1140
[   61.854454][T11670]  ? tun_get_user+0x2760/0x2760
[   61.855806][T11670]  tun_get_user+0x7fa/0x2760
[   61.856734][T11670]  ? rcu_read_unlock+0xa0/0xa0
[   61.857502][T11670]  ? tun_get+0x1e/0x2f0
[   61.858171][T11670]  ? tun_get+0x1e/0x2f0
[   61.858952][T11670]  ? tun_get+0x27d/0x2f0
[   61.859637][T11670]  tun_chr_write_iter+0x111/0x1f0
[   61.860913][T11670]  vfs_write+0xa84/0xcb0
[   61.861578][T11670]  ? __lock_acquire+0x1f60/0x1f60
[   61.862376][T11670]  ? kernel_write+0x330/0x330
[   61.863221][T11670]  ? lockdep_hardirqs_on_prepare+0x43c/0x780
[   61.864230][T11670]  ? __fget_files+0x3ea/0x460
[   61.864955][T11670]  ? seqcount_lockdep_reader_access+0x157/0x220
[   61.866571][T11670]  ? __fdget_pos+0x19e/0x320
[   61.867414][T11670]  ksys_write+0x19f/0x2c0
[   61.868263][T11670]  ? __ia32_sys_read+0x90/0x90
[   61.868996][T11670]  ? ktime_get_coarse_real_ts64+0x10b/0x120
[   61.869896][T11670]  do_syscall_64+0xec/0x210
[   61.870592][T11670]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
[   61.871595][T11670] RIP: 0033:0x472a4f
[   61.873158][T11670] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 d8 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c d9 02 00 48
[   61.876447][T11670] RSP: 002b:00007f7a7a90f5c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[   61.877944][T11670] RAX: ffffffffffffffda RBX: 00007f7a7a911640 RCX: 0000000000472a4f
[   61.879751][T11670] RDX: 0000000000000066 RSI: 0000000020000440 RDI: 00000000000000c8
[   61.881100][T11670] RBP: 00007f7a7a90f620 R08: 0000000000000000 R09: 0000000100000000
[   61.882298][T11670] R10: 0000000100000000 R11: 0000000000000293 R12: 00007f7a7a911640
[   61.883501][T11670] R13: 000000000000006e R14: 000000000042f2f0 R15: 00007f7a7a8f1000
[   61.885999][T11670]  </TASK>

Signed-off-by: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
---
 kernel/bpf/cpumap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a8e34416e960..0034a6d423b6 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -59,6 +59,9 @@ struct bpf_cpu_map_entry {
 	u32 cpu;    /* kthread CPU and map index */
 	int map_id; /* Back reference to map */
 
+	/* Used to end ownership transfer transaction */
+	struct bpf_map *parent_map;
+
 	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
 	struct xdp_bulk_queue __percpu *bulkq;
 
@@ -427,6 +430,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->cpu    = cpu;
 	rcpu->map_id = map->id;
 	rcpu->value.qsize  = value->qsize;
+	rcpu->parent_map = map;
 
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
@@ -639,6 +643,14 @@ static int cpu_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static long cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 {
+	/*
+	 * Redirection is a transfer of ownership of the bpf_cpu_map_entry
+	 * During the transfer the bpf_cpu_map_entry is still in the map,
+	 * so we need to prevent it from being freed.
+	 * The bpf_map_inc() increments the refcnt of the map, so the
+	 * bpf_cpu_map_entry will not be freed until the refcnt is decremented.
+	 */
+	bpf_map_inc(map);
 	return __bpf_xdp_redirect_map(map, index, flags, 0,
 				      __cpu_map_lookup_elem);
 }
@@ -764,6 +776,16 @@ void __cpu_map_flush(void)
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
 		bq_flush_to_queue(bq);
 
+		/*
+		 * Flush operation is the last operation of ownership transfer
+		 * transaction. Thus, we can safely clear the parent_map, decrement
+		 * the refcnt of the map and free the bpf_cpu_map_entry if needed.
+		 */
+		struct bpf_map *map = bq->obj->parent_map;
+
+		if (map)
+			bpf_map_put(map);
+
 		/* If already running, costs spin_lock_irqsave + smb_mb */
 		wake_up_process(bq->obj->kthread);
 	}
-- 
2.43.0


