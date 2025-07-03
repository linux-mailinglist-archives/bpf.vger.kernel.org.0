Return-Path: <bpf+bounces-62303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA197AF7CE3
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED689188BF7B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC40230BCB;
	Thu,  3 Jul 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Pd2QuZU1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08629222561
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557775; cv=none; b=g8EFmlymiLLdLe3L+Vp/UTT29RomH8BnIEm6hwPMlGCDmRcF/4g2pQiFXRhBzwn/0ndTCYuWRyDFHF7xMOgMtg2Q/Ll27dMYAojjfjnWtWVHYamKWP492phC0WgNx0997a+uUgbNl8BUczHCeii6T5u7MBw5BX0SQlgOBAt+MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557775; c=relaxed/simple;
	bh=Pbu91jAo6XOjU2+QOifOyswBFz0ZTG4Nn02D6OsI1Dw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b57aG95GfUyNcJltAlMHvh/TgU8YjT9Emr66WelXS1ah13NxFZfg9Z70zxke/MmwYhcNaT5JvNk0LTerMn/tw8UV8pGrv13mJVbHkHEQmpFU+C2VbQpAG5/83f2zuTY20/OnHaeeATYJgCbkVX4ZvUKv9jQhCW5iErVyOiGPUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Pd2QuZU1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso46941a12.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751557772; x=1752162572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+cLLW1mLaCAg0tguvc6K3Gl8XUp3sNkQMjrHCkTQQ4=;
        b=Pd2QuZU1X3yKREpyxvbiC4hqDq975mEUQeg3A8vv+C+3itJCx4+d38HEyV61JkjG37
         EgIPfMbTtgqYYCqS5mvyO31BBN+9lpixIoBpe0Vcew1/Oa2xttVx2fDseAzaAGNXh12L
         cdiu9f9Sga47Q/oUwE/bvjWUbtPNdfASit3hgfy9bGE7X3zghhulIbTIW5cOjaP6bnBS
         u0bVxF8it67rohxxJ+SHdr5l/OqR9+doXRftOu9uAg6NnGDGBrR0ypd+OadeFw8F/aZu
         0ADXUJEIsptLDqNbiv2zUIDBMLeAvPZZQG67mPWdXzOaDpyOQqvgrfUvkHrNuG2MAzMI
         S7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751557772; x=1752162572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+cLLW1mLaCAg0tguvc6K3Gl8XUp3sNkQMjrHCkTQQ4=;
        b=Ce/BU5S/jYWyPkT79SlroJr/fBhKNbx/R/hqT5opcxkbFvsfDAH0zX54D9nFO/Qvc9
         HiAMqPpcZasL0YBQj2Nnc0eVWrujbjJnlu1tdmNkDJ4Ue1bi35KGCzI55CA7Ejx+h99O
         NgnVOu6brLhw80iA1X2T9wBx52AMHqL014GutYr5eXyPN/s5HAM9JD3BzjOxKDBv93lB
         1PfxdXofkgMFX04jUC8DNka8zKv2S5zcBtzIKtTpBZFTlyO7JUZ9IrAv4ZvYQTTVLNCV
         cMTtkJozzKAgW3OTafaXKRsWTZzLfN6wwjfNI+F8GRTUsgfZk3p0jpXvP4xaxdCQQqyD
         QJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5j+/zKrN5ccwQY95komGBK03KBW02U7aQU87pNhWIAPv0IbAxZ6CzTRHWmWrfI2TPfrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSQA92lmwT0tel3XbNWoOerC2tnTFUcVykHb5HPP+CSxndvRC
	ep1sAgp/T2UPhDxqwjEvqfv1/cIb/zhAqkoGIpSfnm4Eg1Hh0d1nIVReUd+GxhxnVkIM7IauM8M
	zTRVbjMPBHD5UM5U11tEHYOTXDdneezGOCThCyF0lYg==
X-Gm-Gg: ASbGncuQH6uH61laEbAT17D3NUglBYfKik69r43P5T3+Rp2Y6D1l0YFplK64Qw3W4RY
	JF2v/UW8xGWG6DUybX2DcLNmWQnXQJG6xMV0XXUcbrvHP9BcuTDG0a9bK5l33KuVo5fZtexuY21
	4vzNPoUnYUq4i4vPB4awcNyaxQ/yxK7KLGAplxSJtFUpc3Krt+4AYVdq7NPja8
X-Google-Smtp-Source: AGHT+IHCKux+zvAiB43kpx/17w2PBvaZnL6xffV6dKs3jUOJFfcQwU5CmgamhmJcJcHHFkYWADFJHzM3q/ikFtS1iMQ=
X-Received: by 2002:a05:6a20:a103:b0:1f5:8eec:e517 with SMTP id
 adf61e73a8af0-222d7db5c5cmr10123864637.9.1751557772068; Thu, 03 Jul 2025
 08:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Arges <carges@cloudflare.com>
Date: Thu, 3 Jul 2025 10:49:20 -0500
X-Gm-Features: Ac12FXxcvcQ45_bPOGLs2zEp4nqydPR8313adQLdCXX86Lx3ctIguC3vFhYAFVo
Message-ID: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
Subject: [BUG] mlx5_core memory management issue
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, 
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Rzeznik <arzeznik@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When running iperf through a set of XDP programs we were able to crash
machines with NICs using the mlx5_core driver. We were able to confirm
that other NICs/drivers did not exhibit the same problem, and suspect
this could be a memory management issue in the driver code.
Specifically we found a WARNING at include/net/page_pool/helpers.h:277
mlx5e_page_release_fragmented.isra. We are able to demonstrate this
issue in production using hardware, but cannot easily bisect because
we don=E2=80=99t have a simple reproducer. I wanted to share stack traces i=
n
order to help us further debug and understand if anyone else has run
into this issue. We are currently working on getting more crashdumps
and doing further analysis.


The test setup looks like the following:
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
  =E2=94=82mlx5 =E2=94=82
  =E2=94=82NIC  =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=98
     =E2=94=82xdp ebpf program (does encap and XDP_TX)
     =E2=94=82
     =E2=96=BC
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
  =E2=94=82xdp.frags             =E2=94=82
  =E2=94=82                      =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
     =E2=94=82tailcall
     =E2=94=82BPF_REDIRECT_MAP (using CPUMAP bpf type)
     =E2=96=BC
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
  =E2=94=82xdp.frags/cpumap      =E2=94=82
  =E2=94=82                      =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
     =E2=94=82BPF_REDIRECT to veth (*potential trigger for issue)
     =E2=94=82
     =E2=96=BC
  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
  =E2=94=82veth  =E2=94=82
  =E2=94=82      =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=98
     =E2=94=82
     =E2=94=82
     =E2=96=BC

Here an mlx5 NIC has an xdp.frags program attached which tailcalls via
BPF_REDIRECT_MAP into an xdp.frags/cpumap. For our reproducer we can
choose a random valid CPU to reproduce the issue. Once that packet
reaches the xdp.frags/cpumap program we then do another BPF_REDIRECT
to a veth device which has an XDP program which redirects to an
XSKMAP. It wasn=E2=80=99t until we added the additional BPF_REDIRECT to the
veth device that we noticed this issue.

When running with 6.12.30 to 6.12.32 kernels we are able to see the
following KASAN use-after-free WARNINGs followed by a page fault which
crashes the machine. We have not been able to test earlier or later
kernels. I=E2=80=99ve tried to map symbols to lines of code for clarity.

------------[ cut here ]------------
WARNING: CPU: 157 PID: 0 at include/net/page_pool/helpers.h:277
mlx5e_page_release_fragmented.isra.0+0xf7/0x150 [mlx5_core]

mlx5e_page_release_fragmented.isra.0
(include/net/page_pool/helpers.h:277 (discriminator 1)
include/net/page_pool/helpers.h:292 (discriminator 1)
drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:301 (discriminator 1))
mlx5_core

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Modules linked in:
 BUG: KASAN: use-after-free in veth_xdp_rcv.constprop.0+0x9a6/0xc40 [veth]
 mptcp_diag
 Read of size 2 at addr ffff88b8c9eee008 by task napi/iconduit-g/681556

 CPU: 34 UID: 0 PID: 681556 Comm: napi/iconduit-g Kdump: loaded
Tainted: G        W  O       6.12.30-cloudflare-kasan-2025.5.26 #1
 Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
 Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS
HR355M_V3.G.031 02/17/2025
 Call Trace:
  <TASK>
 dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:323 drivers/net/veth.c:924) v=
eth
kasan_report (mm/kasan/report.c:220 mm/kasan/report.c:603)
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:323 drivers/net/veth.c:924) v=
eth
veth_xdp_rcv.constprop.0 (include/net/xdp.h:323 drivers/net/veth.c:924) vet=
h
? napi_threaded_poll_loop (net/core/dev.c:6377 net/core/dev.c:6363
net/core/dev.c:6967)
? __pfx_veth_xdp_rcv.constprop.0 (drivers/net/veth.c:899) veth
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
veth_poll (drivers/net/veth.c:981) veth
? update_load_avg (kernel/sched/fair.c:4531 kernel/sched/fair.c:4868)
? __pfx_veth_poll (drivers/net/veth.c:969) veth
? __pfx___perf_event_task_sched_out (kernel/events/core.c:3765)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? finish_task_switch.isra.0 (arch/x86/include/asm/irqflags.h:42
arch/x86/include/asm/irqflags.h:119 kernel/sched/sched.h:1527
kernel/sched/core.c:5086 kernel/sched/core.c:5204)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __switch_to (arch/x86/include/asm/bitops.h:55
include/asm-generic/bitops/instrumented-atomic.h:29
include/linux/thread_info.h:89 include/linux/sched.h:1978
arch/x86/include/asm/fpu/sched.h:68 arch/x86/kernel/process_64.c:674)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __schedule (kernel/sched/core.c:6592)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __pfx_migrate_enable (kernel/sched/core.c:2338)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? napi_pp_put_page (arch/x86/include/asm/atomic64_64.h:79
(discriminator 5) include/linux/atomic/atomic-arch-fallback.h:2913
(discriminator 5) include/linux/atomic/atomic-long.h:331
(discriminator 5) include/linux/atomic/atomic-instrumented.h:3446
(discriminator 5) include/net/page_pool/helpers.h:276 (discriminator
5) include/net/page_pool/helpers.h:308 (discriminator 5)
include/net/page_pool/helpers.h:320 (discriminator 5)
include/net/page_pool/helpers.h:353 (discriminator 5)
net/core/skbuff.c:1040 (discriminator 5))
__napi_poll (net/core/dev.c:6837)
bpf_trampoline_6442548359+0x79/0x123
? __cond_resched (arch/x86/include/asm/preempt.h:84 (discriminator 13)
kernel/sched/core.c:6891 (discriminator 13) kernel/sched/core.c:7234
(discriminator 13))
__napi_poll (net/core/dev.c:6824)
napi_threaded_poll_loop (include/linux/netpoll.h:90 net/core/dev.c:6958)
? __pfx_napi_threaded_poll_loop (net/core/dev.c:6941)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? sysvec_call_function_single (arch/x86/include/asm/hardirq.h:78
(discriminator 2) arch/x86/kernel/smp.c:266 (discriminator 2))
? napi_threaded_poll (arch/x86/include/asm/bitops.h:206
arch/x86/include/asm/bitops.h:238
include/asm-generic/bitops/instrumented-non-atomic.h:142
net/core/dev.c:6926 net/core/dev.c:6983)
napi_threaded_poll (net/core/dev.c:6984)
? __pfx_napi_threaded_poll (net/core/dev.c:6980)
kthread (kernel/kthread.c:389)
? recalc_sigpending (arch/x86/include/asm/bitops.h:75
include/asm-generic/bitops/instrumented-atomic.h:42
include/linux/thread_info.h:94 kernel/signal.c:178)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork (arch/x86/kernel/process.c:152)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
  </TASK>

 xsk_diag
 The buggy address belongs to the physical page:
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x38c9e=
ee
 flags: 0x1effff800000000(node=3D7|zone=3D2|lastcpupid=3D0x1ffff)
 raw_diag
 raw: 01effff800000000 ffffea00e3075c48 ffffea00e3211648 0000000000000000
 raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 unix_diag
 Memory state around the buggy address:
  ffff88b8c9eedf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88b8c9eedf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 >ffff88b8c9eee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                       ^
 af_packet_diag
  ffff88b8c9eee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88b8c9eee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 netlink_diag
 Disabling lock debugging due to kernel taint
 nfnetlink_queue xt_TPROXY
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 BUG: KASAN: use-after-free in veth_xdp_rcv.constprop.0
(include/net/xdp.h:182 include/net/xdp.h:325 drivers/net/veth.c:924)
veth

 nf_tproxy_ipv6
 Read of size 4 at addr ffff88b8c9eee024 by task napi/iconduit-g/681556

 CPU: 34 UID: 0 PID: 681556 Comm: napi/iconduit-g Kdump: loaded
Tainted: G    B   W  O       6.12.30-cloudflare-kasan-2025.5.26 #1
 Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [O]=3DOOT_MODULE
 Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS
HR355M_V3.G.031 02/17/2025
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
? add_taint (include/linux/debug_locks.h:16 (discriminator 4)
kernel/panic.c:602 (discriminator 4))
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:182
include/net/xdp.h:325 drivers/net/veth.c:924) veth
kasan_report (mm/kasan/report.c:220 mm/kasan/report.c:603)
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:182
include/net/xdp.h:325 drivers/net/veth.c:924) veth
veth_xdp_rcv.constprop.0 (include/net/xdp.h:182 include/net/xdp.h:325
drivers/net/veth.c:924) veth
? napi_threaded_poll_loop (net/core/dev.c:6377 net/core/dev.c:6363
net/core/dev.c:6967)
? __pfx_veth_xdp_rcv.constprop.0 (drivers/net/veth.c:899) veth
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
veth_poll (drivers/net/veth.c:981) veth
? update_load_avg (kernel/sched/fair.c:4531 kernel/sched/fair.c:4868)
? __pfx_veth_poll (drivers/net/veth.c:969) veth
? __pfx___perf_event_task_sched_out (kernel/events/core.c:3765)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? finish_task_switch.isra.0 (arch/x86/include/asm/irqflags.h:42
arch/x86/include/asm/irqflags.h:119 kernel/sched/sched.h:1527
kernel/sched/core.c:5086 kernel/sched/core.c:5204)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __switch_to (arch/x86/include/asm/bitops.h:55
include/asm-generic/bitops/instrumented-atomic.h:29
include/linux/thread_info.h:89 include/linux/sched.h:1978
arch/x86/include/asm/fpu/sched.h:68 arch/x86/kernel/process_64.c:674)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __schedule (kernel/sched/core.c:6592)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __pfx_migrate_enable (kernel/sched/core.c:2338)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? napi_pp_put_page (arch/x86/include/asm/atomic64_64.h:79
(discriminator 5) include/linux/atomic/atomic-arch-fallback.h:2913
(discriminator 5) include/linux/atomic/atomic-long.h:331
(discriminator 5) include/linux/atomic/atomic-instrumented.h:3446
(discriminator 5) include/net/page_pool/helpers.h:276 (discriminator
5) include/net/page_pool/helpers.h:308 (discriminator 5)
include/net/page_pool/helpers.h:320 (discriminator 5)
include/net/page_pool/helpers.h:353 (discriminator 5)
net/core/skbuff.c:1040 (discriminator 5))
__napi_poll (net/core/dev.c:6837)
bpf_trampoline_6442548359+0x79/0x123
? __cond_resched (arch/x86/include/asm/preempt.h:84 (discriminator 13)
kernel/sched/core.c:6891 (discriminator 13) kernel/sched/core.c:7234
(discriminator 13))
__napi_poll (net/core/dev.c:6824)
napi_threaded_poll_loop (include/linux/netpoll.h:90 net/core/dev.c:6958)
? __pfx_napi_threaded_poll_loop (net/core/dev.c:6941)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? sysvec_call_function_single (arch/x86/include/asm/hardirq.h:78
(discriminator 2) arch/x86/kernel/smp.c:266 (discriminator 2))
? napi_threaded_poll (arch/x86/include/asm/bitops.h:206
arch/x86/include/asm/bitops.h:238
include/asm-generic/bitops/instrumented-non-atomic.h:142
net/core/dev.c:6926 net/core/dev.c:6983)
napi_threaded_poll (net/core/dev.c:6984)
? __pfx_napi_threaded_poll (net/core/dev.c:6980)
kthread (kernel/kthread.c:389)
? recalc_sigpending (arch/x86/include/asm/bitops.h:75
include/asm-generic/bitops/instrumented-atomic.h:42
include/linux/thread_info.h:94 kernel/signal.c:178)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork (arch/x86/kernel/process.c:152)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>

nf_tproxy_ipv4
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x38c9ee=
e
flags: 0x1effff800000000(node=3D7|zone=3D2|lastcpupid=3D0x1ffff)
xt_socket
raw: 01effff800000000 ffffea00e3075c48 ffffea00e3211648 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

nf_socket_ipv4
Memory state around the buggy address:
 ffff88b8c9eedf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
nf_socket_ipv6
 ffff88b8c9eedf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88b8c9eee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
xt_NFQUEUE
 ffff88b8c9eee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88b8c9eee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
overlay
BUG: KASAN: use-after-free in veth_xdp_rcv_one+0xb0c/0xce0 [veth]
Read of size 8 at addr ffff88b8c9eee000 by task napi/iconduit-g/681556
esp4

CPU: 34 UID: 0 PID: 681556 Comm: napi/iconduit-g Kdump: loaded
Tainted: G    B   W  O       6.12.30-cloudflare-kasan-2025.5.26 #1
Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [O]=3DOOT_MODULE
Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS
HR355M_V3.G.031 02/17/2025
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161)
? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)
? veth_xdp_rcv_one (include/net/xdp.h:254 drivers/net/veth.c:650) veth
kasan_report (mm/kasan/report.c:220 mm/kasan/report.c:603)
? veth_xdp_rcv_one (include/net/xdp.h:254 drivers/net/veth.c:650) veth
veth_xdp_rcv_one (include/net/xdp.h:254 drivers/net/veth.c:650) veth
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:182
include/net/xdp.h:325 drivers/net/veth.c:924) veth
? __pfx_veth_xdp_rcv_one (drivers/net/veth.c:639) veth
? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152
(discriminator 2) kernel/locking/spinlock.c:194 (discriminator 2))
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? add_taint (arch/x86/include/asm/bitops.h:60
include/asm-generic/bitops/instrumented-atomic.h:29
kernel/panic.c:605)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? end_report.part.0 (mm/kasan/report.c:242)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? veth_xdp_rcv.constprop.0 (include/net/xdp.h:182
include/net/xdp.h:325 drivers/net/veth.c:924) veth
veth_xdp_rcv.constprop.0 (drivers/net/veth.c:926) veth
? napi_threaded_poll_loop (net/core/dev.c:6377 net/core/dev.c:6363
net/core/dev.c:6967)
? __pfx_veth_xdp_rcv.constprop.0 (drivers/net/veth.c:899) veth
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
veth_poll (drivers/net/veth.c:981) veth
? update_load_avg (kernel/sched/fair.c:4531 kernel/sched/fair.c:4868)
? __pfx_veth_poll (drivers/net/veth.c:969) veth
? __pfx___perf_event_task_sched_out (kernel/events/core.c:3765)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? finish_task_switch.isra.0 (arch/x86/include/asm/irqflags.h:42
arch/x86/include/asm/irqflags.h:119 kernel/sched/sched.h:1527
kernel/sched/core.c:5086 kernel/sched/core.c:5204)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __switch_to (arch/x86/include/asm/bitops.h:55
include/asm-generic/bitops/instrumented-atomic.h:29
include/linux/thread_info.h:89 include/linux/sched.h:1978
arch/x86/include/asm/fpu/sched.h:68 arch/x86/kernel/process_64.c:674)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __schedule (kernel/sched/core.c:6592)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? __pfx_migrate_enable (kernel/sched/core.c:2338)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? napi_pp_put_page (arch/x86/include/asm/atomic64_64.h:79
(discriminator 5) include/linux/atomic/atomic-arch-fallback.h:2913
(discriminator 5) include/linux/atomic/atomic-long.h:331
(discriminator 5) include/linux/atomic/atomic-instrumented.h:3446
(discriminator 5) include/net/page_pool/helpers.h:276 (discriminator
5) include/net/page_pool/helpers.h:308 (discriminator 5)
include/net/page_pool/helpers.h:320 (discriminator 5)
include/net/page_pool/helpers.h:353 (discriminator 5)
net/core/skbuff.c:1040 (discriminator 5))
__napi_poll (net/core/dev.c:6837)
bpf_trampoline_6442548359+0x79/0x123
? __cond_resched (arch/x86/include/asm/preempt.h:84 (discriminator 13)
kernel/sched/core.c:6891 (discriminator 13) kernel/sched/core.c:7234
(discriminator 13))
__napi_poll (net/core/dev.c:6824)
napi_threaded_poll_loop (include/linux/netpoll.h:90 net/core/dev.c:6958)
? __pfx_napi_threaded_poll_loop (net/core/dev.c:6941)
? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
? sysvec_call_function_single (arch/x86/include/asm/hardirq.h:78
(discriminator 2) arch/x86/kernel/smp.c:266 (discriminator 2))
? napi_threaded_poll (arch/x86/include/asm/bitops.h:206
arch/x86/include/asm/bitops.h:238
include/asm-generic/bitops/instrumented-non-atomic.h:142
net/core/dev.c:6926 net/core/dev.c:6983)
napi_threaded_poll (net/core/dev.c:6984)
? __pfx_napi_threaded_poll (net/core/dev.c:6980)
kthread (kernel/kthread.c:389)
? recalc_sigpending (arch/x86/include/asm/bitops.h:75
include/asm-generic/bitops/instrumented-atomic.h:42
include/linux/thread_info.h:94 kernel/signal.c:178)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork (arch/x86/kernel/process.c:152)
? __pfx_kthread (kernel/kthread.c:342)
ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>

xt_hashlimit
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x38c9ee=
e
flags: 0x1effff800000000(node=3D7|zone=3D2|lastcpupid=3D0x1ffff)
ip_set_hash_netport
raw: 01effff800000000 ffffea00e3075c48 ffffea00e3211648 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
xt_length

Memory state around the buggy address:
 ffff88b8c9eedf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88b8c9eedf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88b8c9eee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
nft_compat
                   ^
 ffff88b8c9eee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88b8c9eee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
nf_conntrack_netlink
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
xfrm_interface
BUG: KASAN: use-after-free in veth_xdp_rcv_one+0x995/0xce0 [veth]
Read of size 2 at addr ffff88b8c9eee00a by task napi/iconduit-g/681556
xfrm6_tunnel

CPU: 34 UID: 0 PID: 681556 Comm: napi/iconduit-g Kdump: loaded
Tainted: G    B   W  O       6.12.30-cloudflare-kasan-2025.5.26 #1
Tainted: [B]=3DBAD_PAGE, [W]=3DWARN, [O]=3DOOT_MODULE
Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS
HR355M_V3.G.031 02/17/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x4b/0x70
 print_report+0x14d/0x4cf
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? veth_xdp_rcv_one+0x995/0xce0 [veth]
 kasan_report+0xb6/0x140

