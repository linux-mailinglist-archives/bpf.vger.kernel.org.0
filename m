Return-Path: <bpf+bounces-17382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82480C2CE
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9B41C209C1
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE1220B35;
	Mon, 11 Dec 2023 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Q9EYIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181AED;
	Mon, 11 Dec 2023 00:12:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6d089bc4e1aso522049b3a.0;
        Mon, 11 Dec 2023 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702282334; x=1702887134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PnqHFvESeEK9z5d1ue0gcoi0JVI/7h1mNwYHL74m1o=;
        b=I3Q9EYIZJK+hJ4cN+AlEJ8sigrLPenHT8Yn3HbeiFbO0SOtPusUmvLK4K1Ia9InziN
         M6zYIt227q3ZBWSCd4k2MA/W8BLFanuQWyYgoSR8+opXI10S9y9SSFLy+e3cPFvS0hlV
         1I+6N1p77Ll++e4TLtB3eAOVQuYs3F935TZJQ4xSdmJuReN+OGSGUUUKPpJr0n7XmM8B
         9fHFrzjLT6IIDvJA/UNx0b7X8/Yto0eDixTRnvah/UxOoyf0MxF6EsG2R2WZjqashTPh
         Z44kZ7qYAb+7QwIZf4aHPYHFFm68j4WNK5mULfH5pCVLeqxXjybrOstXODtlvjIkJN9p
         G9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702282334; x=1702887134;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PnqHFvESeEK9z5d1ue0gcoi0JVI/7h1mNwYHL74m1o=;
        b=IXKW9NuSc/4zkDhvfWPrlIJAlLdNSUz7ThplNtFbjRVa4TMRBXWO+rLBJZYAfHt60Z
         RuBQv7AWF3HinHcFmknLmh7uCDkuo7+RjMHH04R88yxayGhb9ppx+J2uenhgmRC8BJM7
         57ijscl6dtDky7rysnYa8zaEwRXDMzBuMAwW4q0adphWTDp6+eEQ+0KspktAh+ZhlE11
         N9a6ITFgoHZNdQb3bs+W0J8dhWG+3g0jeAmZAeO182I9fKQHkAhAHM+fQvaKeH8KC++V
         6Q0TeHgWLRkzFeVg5phTXLFA27TNqrDH/8q3OwoSrhbZ4yRBHQI1co43AuVcgpmV5U31
         FgiQ==
X-Gm-Message-State: AOJu0YzWwElltd8e9zXLZ+P6L9FnAJL27Jewb48M02zBWra+cK5ahPed
	iXv6cXYvILOGPozImDqHCnO/T1Bsex1NBZru1VkIIRfBHRrB7pmT
X-Google-Smtp-Source: AGHT+IEDlIVmTwtbyD2Gl7jy6EjJbVGJbj0Hmj5C91L32SfbOKyiq29lnHf7p3C/0zHULU4sNB5JXon8fRxxI7YldWQ=
X-Received: by 2002:a05:6a00:1747:b0:68f:b015:ea99 with SMTP id
 j7-20020a056a00174700b0068fb015ea99mr4382341pfc.10.1702282334260; Mon, 11 Dec
 2023 00:12:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 11 Dec 2023 16:12:01 +0800
Message-ID: <CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com>
Subject: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
To: ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for containing HTML part, repeat the mail
Hello I found a bug in net/bpf in the lastest upstream linux and
lastest net tree.
WARNING: kmalloc bug in bpf_uprobe_multi_link_attach

kernel: net 28a7cb045ab700de5554193a1642917602787784
Kernel config: https://github.com/google/syzkaller/commits/fc59b78e3174009510ed15f20665e7ab2435ebee

in the lastest net tree, the crash like:

[   68.363836][ T8223] ------------[ cut here ]------------
[   68.364967][ T8223] WARNING: CPU: 2 PID: 8223 at mm/util.c:632
kvmalloc_node+0x18a/0x1a0
[   68.366527][ T8223] Modules linked in:
[   68.367882][ T8223] CPU: 2 PID: 8223 Comm: 36d Not tainted
6.7.0-rc4-00146-g28a7cb045ab7 #2
[   68.369260][ T8223] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/014
[   68.370811][ T8223] RIP: 0010:kvmalloc_node+0x18a/0x1a0
[   68.371689][ T8223] Code: dc 1c 00 eb aa e8 86 33 c6 ff 41 81 e4 00
20 00 00 31 ff 44 89 e6 e8 e5 20
[   68.375001][ T8223] RSP: 0018:ffffc9001088fb68 EFLAGS: 00010293
[   68.375989][ T8223] RAX: 0000000000000000 RBX: 00000037ffffcec8
RCX: ffffffff81c1a32b
[   68.377154][ T8223] RDX: ffff88802cc00040 RSI: ffffffff81c1a339
RDI: 0000000000000005
[   68.377950][ T8223] RBP: 0000000000000400 R08: 0000000000000005
R09: 0000000000000000
[   68.378744][ T8223] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000000
[   68.379523][ T8223] R13: 00000000ffffffff R14: ffff888017eb4a28
R15: 0000000000000000
[   68.380307][ T8223] FS:  0000000000827380(0000)
GS:ffff8880b9900000(0000) knlGS:0000000000000000
[   68.381185][ T8223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   68.381843][ T8223] CR2: 0000000020000140 CR3: 00000000204d2000
CR4: 0000000000750ef0
[   68.382624][ T8223] PKRU: 55555554
[   68.382978][ T8223] Call Trace:
[   68.383312][ T8223]  <TASK>
[   68.383608][ T8223]  ? show_regs+0x8f/0xa0
[   68.384052][ T8223]  ? __warn+0xe6/0x390
[   68.384470][ T8223]  ? kvmalloc_node+0x18a/0x1a0
[   68.385111][ T8223]  ? report_bug+0x3b9/0x580
[   68.385585][ T8223]  ? handle_bug+0x67/0x90
[   68.386032][ T8223]  ? exc_invalid_op+0x17/0x40
[   68.386503][ T8223]  ? asm_exc_invalid_op+0x1a/0x20
[   68.387065][ T8223]  ? kvmalloc_node+0x17b/0x1a0
[   68.387551][ T8223]  ? kvmalloc_node+0x189/0x1a0
[   68.388051][ T8223]  ? kvmalloc_node+0x18a/0x1a0
[   68.388537][ T8223]  ? kvmalloc_node+0x189/0x1a0
[   68.389038][ T8223]  bpf_uprobe_multi_link_attach+0x436/0xfb0
[   68.389633][ T8223]  ? __might_fault+0x13f/0x1a0
[   68.390129][ T8223]  ? bpf_kprobe_multi_link_attach+0x10/0x10
[   68.390731][ T8223]  ? __fget_light+0x1fc/0x260
[   68.391206][ T8223]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   68.391812][ T8223]  __sys_bpf+0x3ea0/0x4840
[   68.392267][ T8223]  ? slab_free_freelist_hook+0x114/0x1e0
[   68.393032][ T8223]  ? bpf_perf_link_attach+0x540/0x540
[   68.393580][ T8223]  ? putname+0x12e/0x170
[   68.394015][ T8223]  ? kmem_cache_free+0xf8/0x350
[   68.394509][ T8223]  ? putname+0x12e/0x170
[   68.394948][ T8223]  ? do_sys_openat2+0xb1/0x1e0
[   68.395442][ T8223]  ? __x64_sys_creat+0xcd/0x120
[   68.395945][ T8223]  __x64_sys_bpf+0x78/0xc0
[   68.396393][ T8223]  ? syscall_enter_from_user_mode+0x7f/0x120
[   68.397040][ T8223]  do_syscall_64+0x41/0x110
[   68.397502][ T8223]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   68.398098][ T8223] RIP: 0033:0x410ead
[   68.398498][ T8223] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
0f 1e fa 48 89 f8 48 89 f7 48 88
[   68.400432][ T8223] RSP: 002b:00007ffdbabd7098 EFLAGS: 00000246
ORIG_RAX: 0000000000000141
[   68.401271][ T8223] RAX: ffffffffffffffda RBX: 00007ffdbabd7298
RCX: 0000000000410ead
[   68.402063][ T8223] RDX: 0000000000000040 RSI: 0000000020000340
RDI: 000000000000001c
[   68.402864][ T8223] RBP: 00007ffdbabd70b0 R08: 0000000000000000
R09: 0000000000000000
[   68.403649][ T8223] R10: 0000000000000000 R11: 0000000000000246
R12: 000000000049be68
[   68.404786][ T8223] R13: 0000000000000001 R14: 0000000000000001
R15: 0000000000000001
[   68.405574][ T8223]  </TASK>
[   68.405890][ T8223] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   68.406611][ T8223] CPU: 2 PID: 8223 Comm: 36d Not tainted
6.7.0-rc4-00146-g28a7cb045ab7 #2
[   68.407453][ T8223] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/014
[   68.408386][ T8223] Call Trace:
[   68.408723][ T8223]  <TASK>
[   68.409023][ T8223]  dump_stack_lvl+0xd3/0x1b0
[   68.409484][ T8223]  panic+0x6dc/0x790
[   68.409884][ T8223]  ? panic_smp_self_stop+0xa0/0xa0
[   68.410408][ T8223]  ? show_trace_log_lvl+0x363/0x4f0
[   68.410947][ T8223]  ? check_panic_on_warn+0x1f/0xb0
[   68.411458][ T8223]  ? kvmalloc_node+0x18a/0x1a0
[   68.411955][ T8223]  check_panic_on_warn+0xab/0xb0
[   68.412453][ T8223]  __warn+0xf2/0x390
[   68.412855][ T8223]  ? kvmalloc_node+0x18a/0x1a0
[   68.413334][ T8223]  report_bug+0x3b9/0x580
[   68.413778][ T8223]  handle_bug+0x67/0x90
[   68.414195][ T8223]  exc_invalid_op+0x17/0x40
[   68.414651][ T8223]  asm_exc_invalid_op+0x1a/0x20
[   68.415150][ T8223] RIP: 0010:kvmalloc_node+0x18a/0x1a0
[   68.415693][ T8223] Code: dc 1c 00 eb aa e8 86 33 c6 ff 41 81 e4 00
20 00 00 31 ff 44 89 e6 e8 e5 20
[   68.417651][ T8223] RSP: 0018:ffffc9001088fb68 EFLAGS: 00010293
[   68.418279][ T8223] RAX: 0000000000000000 RBX: 00000037ffffcec8
RCX: ffffffff81c1a32b
[   68.419090][ T8223] RDX: ffff88802cc00040 RSI: ffffffff81c1a339
RDI: 0000000000000005
[   68.419884][ T8223] RBP: 0000000000000400 R08: 0000000000000005
R09: 0000000000000000
[   68.420678][ T8223] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000000
[   68.421474][ T8223] R13: 00000000ffffffff R14: ffff888017eb4a28
R15: 0000000000000000
[   68.422287][ T8223]  ? kvmalloc_node+0x17b/0x1a0
[   68.422780][ T8223]  ? kvmalloc_node+0x189/0x1a0
[   68.423270][ T8223]  ? kvmalloc_node+0x189/0x1a0
[   68.423769][ T8223]  bpf_uprobe_multi_link_attach+0x436/0xfb0
[   68.424372][ T8223]  ? __might_fault+0x13f/0x1a0
[   68.424860][ T8223]  ? bpf_kprobe_multi_link_attach+0x10/0x10
[   68.425462][ T8223]  ? __fget_light+0x1fc/0x260
[   68.425951][ T8223]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   68.426545][ T8223]  __sys_bpf+0x3ea0/0x4840
[   68.427005][ T8223]  ? slab_free_freelist_hook+0x114/0x1e0
[   68.427583][ T8223]  ? bpf_perf_link_attach+0x540/0x540
[   68.428133][ T8223]  ? putname+0x12e/0x170
[   68.428564][ T8223]  ? kmem_cache_free+0xf8/0x350
[   68.429079][ T8223]  ? putname+0x12e/0x170
[   68.429519][ T8223]  ? do_sys_openat2+0xb1/0x1e0
[   68.430029][ T8223]  ? __x64_sys_creat+0xcd/0x120
[   68.430536][ T8223]  __x64_sys_bpf+0x78/0xc0
[   68.431000][ T8223]  ? syscall_enter_from_user_mode+0x7f/0x120
[   68.431623][ T8223]  do_syscall_64+0x41/0x110
[   68.432099][ T8223]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[   68.432708][ T8223] RIP: 0033:0x410ead
[   68.433117][ T8223] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
0f 1e fa 48 89 f8 48 89 f7 48 88
[   68.435240][ T8223] RSP: 002b:00007ffdbabd7098 EFLAGS: 00000246
ORIG_RAX: 0000000000000141
[   68.436087][ T8223] RAX: ffffffffffffffda RBX: 00007ffdbabd7298
RCX: 0000000000410ead
[   68.436898][ T8223] RDX: 0000000000000040 RSI: 0000000020000340
RDI: 000000000000001c
[   68.437697][ T8223] RBP: 00007ffdbabd70b0 R08: 0000000000000000
R09: 0000000000000000
[   68.438499][ T8223] R10: 0000000000000000 R11: 0000000000000246
R12: 000000000049be68
[   68.439305][ T8223] R13: 0000000000000001 R14: 0000000000000001
R15: 0000000000000001
[   68.440115][ T8223]  </TASK>
[   68.440773][ T8223] Kernel Offset: disabled
[   68.441251][ T8223] Rebooting in 86400 seconds..

=* repro.c =*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)     \
  *(type*)(addr) =                                                   \
      htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
            (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

uint64_t r[1] = {0xffffffffffffffff};

int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  intptr_t res = 0;
  *(uint32_t*)0x20000140 = 2;
  *(uint32_t*)0x20000144 = 3;
  *(uint64_t*)0x20000148 = 0x20000200;
  *(uint8_t*)0x20000200 = 0x18;
  STORE_BY_BITMASK(uint8_t, , 0x20000201, 0, 0, 4);
  STORE_BY_BITMASK(uint8_t, , 0x20000201, 0, 4, 4);
  *(uint16_t*)0x20000202 = 0;
  *(uint32_t*)0x20000204 = 0;
  *(uint8_t*)0x20000208 = 0;
  *(uint8_t*)0x20000209 = 0;
  *(uint16_t*)0x2000020a = 0;
  *(uint32_t*)0x2000020c = 0;
  *(uint8_t*)0x20000210 = 0x95;
  *(uint8_t*)0x20000211 = 0;
  *(uint16_t*)0x20000212 = 0;
  *(uint32_t*)0x20000214 = 0;
  *(uint64_t*)0x20000150 = 0x20000240;
  memcpy((void*)0x20000240, "GPL\000", 4);
  *(uint32_t*)0x20000158 = 0;
  *(uint32_t*)0x2000015c = 0;
  *(uint64_t*)0x20000160 = 0;
  *(uint32_t*)0x20000168 = 0;
  *(uint32_t*)0x2000016c = 0;
  memset((void*)0x20000170, 0, 16);
  *(uint32_t*)0x20000180 = 0;
  *(uint32_t*)0x20000184 = 0x30;
  *(uint32_t*)0x20000188 = 0;
  *(uint32_t*)0x2000018c = 0;
  *(uint64_t*)0x20000190 = 0;
  *(uint32_t*)0x20000198 = 0;
  *(uint32_t*)0x2000019c = 0;
  *(uint64_t*)0x200001a0 = 0;
  *(uint32_t*)0x200001a8 = 0;
  *(uint32_t*)0x200001ac = 0;
  *(uint32_t*)0x200001b0 = 0;
  *(uint32_t*)0x200001b4 = 0;
  *(uint64_t*)0x200001b8 = 0;
  *(uint64_t*)0x200001c0 = 0;
  *(uint32_t*)0x200001c8 = 0;
  *(uint32_t*)0x200001cc = 0;
  res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000140ul, /*size=*/0x90ul);
  if (res != -1) r[0] = res;
  memcpy((void*)0x20000000, "./file0\000", 8);
  syscall(__NR_creat, /*file=*/0x20000000ul, /*mode=*/0ul);
  *(uint32_t*)0x20000340 = r[0];
  *(uint32_t*)0x20000344 = 0;
  *(uint32_t*)0x20000348 = 0x30;
  *(uint32_t*)0x2000034c = 0;
  *(uint64_t*)0x20000350 = 0x20000080;
  memcpy((void*)0x20000080, "./file0\000", 8);
  *(uint64_t*)0x20000358 = 0x200000c0;
  *(uint64_t*)0x200000c0 = 0;
  *(uint64_t*)0x20000360 = 0;
  *(uint64_t*)0x20000368 = 0;
  *(uint32_t*)0x20000370 = 0xffffff1f;
  *(uint32_t*)0x20000374 = 0;
  *(uint32_t*)0x20000378 = 0;
  syscall(__NR_bpf, /*cmd=*/0x1cul, /*arg=*/0x20000340ul, /*size=*/0x40ul);
  return 0;
}

=* repro.txt =*
r0 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3,
&(0x7f0000000200)=@framed, &(0x7f0000000240)='GPL\x00', 0x0, 0x0, 0x0,
0x0, 0x0, '\x00', 0x0, 0x30, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0}, 0x90)
creat(&(0x7f0000000000)='./file0\x00', 0x0)
bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000340)={r0, 0x0, 0x30, 0x0,
@val=@uprobe_multi={&(0x7f0000000080)='./file0\x00',
&(0x7f00000000c0)=[0x0], 0x0, 0x0, 0xffffff1f}}, 0x40)


See aslo https://gist.github.com/xrivendell7/15d43946c73aa13247b4b20b68798aaa

