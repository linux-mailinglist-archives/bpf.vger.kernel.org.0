Return-Path: <bpf+bounces-17926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A54813F2A
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A08B21D40
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFFB806;
	Fri, 15 Dec 2023 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgiZGt0A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3FA34;
	Fri, 15 Dec 2023 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso1659955e9.1;
        Thu, 14 Dec 2023 17:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702603558; x=1703208358; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/hJJm52MBFm1RnFEsgCA51xIZiTAloRw8NnyztRRSXE=;
        b=mgiZGt0AMDYqyBAtrrNSx0QFeH94+t5CkpL8N8JifQVY94MZx0Rg1GiKG3gwaHNeNq
         SgEmj8NCNQFb9Axywo5uyap3eZJB+n4fsLEoApk9zQJw3TmBv2Vn927iyIPfU2Sfe94Q
         4K+NWsCTgg1aEBgubbDfjnl3U3eEBwWWeRCX/yptsBvtK9CGiwA7Q4x3YFRcZUqCs6xs
         /y4iQmkiPLahBa3Uk685F5gLHILUx5IjK0+VJ0BJ3ZKv/v4UbpvMrVS0JeiqIrkwWGlq
         kBz7fxdwRizI/FvJPleSGWznoDvy292K9vXjYym5exGvGW8mM83GnX6ehZ7Twz9L+8Bf
         axrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702603558; x=1703208358;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hJJm52MBFm1RnFEsgCA51xIZiTAloRw8NnyztRRSXE=;
        b=eNGOydHXxxHvdgqU0ZuFR/kx6hEN3lwNEJD6I5kzTP/Oma+tihMpNKdh9ahEDWpVFn
         jVD7nWYeoSW3a53cZmDanbX4z+WXJKkBcp/5tkHHAkp0iSbkzOsE2M19Pi5fUd9trG2Q
         ESgzyl/xMXB/+VEOeNfffBp0NPwrxzarxjk6AzqJJWZezS9PurjMGzsc0pJlRXtHpgqd
         codea51y/IzZtwvUdnywTM8vpNS2j2QCiCJcWfBTIjWVROoz1ghyoE9HX6YgtUKguqlF
         B+yqKmIepd6ZfUalOQNM2FOVwUFwinsAqL6m1ScjtsKrQzTpKLOY3/QI9IbJFML5+YKN
         OmyQ==
X-Gm-Message-State: AOJu0YyqRrhmTRMOZCv1I4fjtfxJUsH8BfA6/87zac1NdNGzWEzSF/h3
	Kkcuzbc1rNjKqCyfQt3q3LBH8LVs2T5LVO/W3ZkQJDTvGUE=
X-Google-Smtp-Source: AGHT+IF0cJCGEEvFZ8T+hEfheOEqHUndf12/Tq+fyIEkiVOHYSYuwTDAufH/8PeOITnZN8ev5GQ4r39lAi6MpcCfCFg=
X-Received: by 2002:a05:6000:b81:b0:336:4912:d47d with SMTP id
 dl1-20020a0560000b8100b003364912d47dmr1191973wrb.36.1702603557868; Thu, 14
 Dec 2023 17:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 17:25:46 -0800
Message-ID: <CAADnVQ+dPML0DW=Miuq=n7nC8m4gcPj7Dk_nhedzs9zTE30arw@mail.gmail.com>
Subject: [bug] splat at boot
To: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

just noticed a boot splat that probably was there for lone time:

[    1.118691] ftrace: allocating 50546 entries in 198 pages
[    1.129690] ftrace: allocated 198 pages with 4 groups
[    1.130156]
[    1.130158] =============================
[    1.130159] [ BUG: Invalid wait context ]
[    1.130161] 6.7.0-rc3-00837-g403f3e8fda60 #5272 Not tainted
[    1.130163] -----------------------------
[    1.130165] swapper/0 is trying to lock:
[    1.130166] ffff88823fffb1d8 (&zone->lock){....}-{3:3}, at:
__rmqueue_pcplist+0xe80/0x1100
[    1.130181] other info that might help us debug this:
[    1.130182] context-{5:5}
[    1.130184] 3 locks held by swapper/0:
[    1.130185]  #0: ffffffff84334888 (slab_mutex){....}-{4:4}, at:
kmem_cache_create_usercopy+0x47/0x270
[    1.130197]  #1: ffffffff8437aad8 (kmemleak_lock){....}-{2:2}, at:
__create_object+0x36/0xa0
[    1.130207]  #2: ffff8881f6c37c18 (&pcp->lock){....}-{3:3}, at:
get_page_from_freelist+0x8be/0x2250
[    1.130215] stack backtrace:
[    1.130217] CPU: 0 PID: 0 Comm: swapper Not tainted
6.7.0-rc3-00837-g403f3e8fda60 #5272
[    1.130221] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    1.130224] Call Trace:
[    1.130225]  <TASK>
[    1.130228]  dump_stack_lvl+0x4a/0x80
[    1.130234]  __lock_acquire+0xd5d/0x34e0
[    1.130244]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[    1.130248]  ? __lock_acquire+0x906/0x34e0
[    1.130254]  lock_acquire+0x155/0x3b0
[    1.130258]  ? __rmqueue_pcplist+0xe80/0x1100
[    1.130263]  ? lock_sync+0x100/0x100
[    1.130268]  ? secondary_startup_64_no_verify+0x166/0x16b
[    1.130274]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[    1.130279]  _raw_spin_lock_irqsave+0x3f/0x60
[    1.130284]  ? __rmqueue_pcplist+0xe80/0x1100
[    1.130288]  __rmqueue_pcplist+0xe80/0x1100
[    1.130293]  ? lock_acquire+0x165/0x3b0
[    1.130300]  ? find_suitable_fallback+0xe0/0xe0
[    1.130306]  get_page_from_freelist+0x91c/0x2250
[    1.130314]  ? lock_release+0x219/0x3a0
[    1.130317]  ? __stack_depot_save+0x223/0x450
[    1.130322]  ? reacquire_held_locks+0x270/0x270
[    1.130328]  ? __zone_watermark_ok+0x290/0x290
[    1.130332]  ? prepare_alloc_pages.constprop.0+0x173/0x220
[    1.130337]  __alloc_pages+0x188/0x390
[    1.130342]  ? __alloc_pages_slowpath.constprop.0+0x1380/0x1380
[    1.130347]  ? unwind_next_frame+0x1ee/0xe10
[    1.130354]  ? secondary_startup_64_no_verify+0x166/0x16b
[    1.130358]  ? secondary_startup_64_no_verify+0x166/0x16b
[    1.130362]  ? write_profile+0x220/0x220
[    1.130366]  ? policy_nodemask+0x28/0x190
[    1.130371]  alloc_pages_mpol+0xf0/0x2c0
[    1.130376]  ? mempolicy_in_oom_domain+0x90/0x90
[    1.130381]  ? secondary_startup_64_no_verify+0x166/0x16b
[    1.130387]  __stack_depot_save+0x36f/0x450
[    1.130393]  set_track_prepare+0x79/0xa0
[    1.130396]  ? get_object+0x50/0x50
[    1.130400]  ? kmem_cache_alloc_node+0x222/0x3b0
[    1.130404]  ? __kmem_cache_create+0x167/0x5e0
[    1.130408]  ? kmem_cache_create_usercopy+0x17c/0x270
[    1.130412]  ? kmem_cache_create+0x16/0x20
[    1.130415]  ? sched_init+0xf8/0x780
[    1.130420]  ? start_kernel+0x13c/0x390
[    1.130425]  ? x86_64_start_reservations+0x18/0x30
[    1.130428]  ? x86_64_start_kernel+0xb2/0xc0
[    1.130431]  ? secondary_startup_64_no_verify+0x166/0x16b
[    1.130436]  ? strncpy+0x33/0x60
[    1.130441]  __link_object+0x21c/0x4c0
[    1.130447]  __create_object+0x4e/0xa0
[    1.130452]  kmem_cache_alloc_node+0x222/0x3b0
[    1.130457]  ? calculate_sizes+0x2eb/0x320
[    1.130462]  __kmem_cache_create+0x167/0x5e0
[    1.130467]  kmem_cache_create_usercopy+0x17c/0x270
[    1.130471]  ? cpupri_init+0xe6/0x100
[    1.130478]  kmem_cache_create+0x16/0x20
[    1.130482]  sched_init+0xf8/0x780
[    1.130486]  start_kernel+0x13c/0x390
[    1.130491]  x86_64_start_reservations+0x18/0x30
[    1.130494]  x86_64_start_kernel+0xb2/0xc0
[    1.130498]  secondary_startup_64_no_verify+0x166/0x16b
[    1.130506]  </TASK>
[    1.133575] Running RCU self tests

Looks to be stackdepot related?

I haven't debugged it yet.
Wondering, is this a known issue?

CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

