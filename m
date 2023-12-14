Return-Path: <bpf+bounces-17777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE6812600
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E74CB20C6F
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DF186F;
	Thu, 14 Dec 2023 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCUCWiSE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFA93;
	Wed, 13 Dec 2023 19:40:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so150881b3a.1;
        Wed, 13 Dec 2023 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702525220; x=1703130020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aEKOSge/hHdPwni+MLpXmsbRXBwIGAeAkdwDfsnV6NM=;
        b=LCUCWiSEjKXQ85nf4vt76gA2BXUnPlz77ldT7k3Ut8bLk3DtyFFZa+ory2AOAn0Obs
         zX5ULYbig23dKI8ZJ88PsJwyEdUEMEwNiAZPsAapHGYQuNA3LmMHNvv/OXrwr7BQ2TmP
         NBZYvtNDBW6TaHzViYJ9LahTh1c+rloME+4l4+LPklWGg/unbNcA3el103/oYHNKRB36
         3bXjVlgYo7etm5u8nYII5/KHfh0fNTYu06ovlujh9I5eKhuxruuxRE16HW6dfQNB+fq/
         dBp8Cwbm5sg3DFfDAlI2CZgsnSwFT59p7Utr5PU2LaeZe07Gyi31DPh7ZbmI79yOWRIr
         31FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702525220; x=1703130020;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEKOSge/hHdPwni+MLpXmsbRXBwIGAeAkdwDfsnV6NM=;
        b=TWoLNzGfkQKXuWQaQ4OwwzL3E6I2uncHUiq4D0ngJJ4jx+BFj8EcpA3tR/tugp4jaM
         wZDXSDYHSnAIXmIpBzYmyQIlQw5yPdFs73ZMSy/D+OnAjI2hvA5P61Rq9wuYG1l8BDWX
         KTcHgQVjrReF9yMAdlaQzOgEzZxtSc8bBIJH/bDEdaSlAARkePf2K83ZJzg4ErPZLoOS
         jD2IGJnyWu+HIbv/miGh139dGHR+MPS0dZf72gHX9DfF5WQl/JzIpzgaEA++Aqec9w/y
         hk14YmpYJVXxqFpOWYMGbffH9bNADDwj7ukS85LGwQ09aCNjI5P9muVmCFKmHONyd6ZO
         mlXg==
X-Gm-Message-State: AOJu0YwL/b4fJYa0Z0C6NyNMJFKxQlc601jfhoSLrM1WuBZaxWi+G+jG
	vh2y4KELXheMbmnfovHllcoZMOkN9h2zTAOpgg4=
X-Google-Smtp-Source: AGHT+IHpMqACgq9LHTiNZAwoi2J+cQEbi29OE/OcCzx7PB8GPG+1KZONttunx1czLApQqXingL0j6olWVkJimBVDRYc=
X-Received: by 2002:a05:6a20:728b:b0:18c:5178:9649 with SMTP id
 o11-20020a056a20728b00b0018c51789649mr9914980pzk.14.1702525220260; Wed, 13
 Dec 2023 19:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 14 Dec 2023 11:40:07 +0800
Message-ID: <CABOYnLynjBoFZOf3Z4BhaZkc5hx_kHfsjiW+UWLoB=w33LvScw@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in bpf_probe_read_compat_str
To: song@kernel.org
Cc: ast@kernel.org, jolsa@kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello I found a bug in net/bpf in the lastest upstream linux and
comfired in the lastest net tree and lastest net bpf titled BUG:
unable to handle kernel paging request in bpf_probe_read_compat_str

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei Lee <xrivendell7@gmail.com>

kernel: net 9702817384aa4a3700643d0b26e71deac0172cfd / bpf
2f2fee2bf74a7e31d06fc6cb7ba2bd4dd7753c99
Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=b50bd31249191be8

in the lastest bpf tree, the crash like:

TITLE: BUG: unable to handle kernel paging request in bpf_probe_read_compat_str
CORRUPTED: false ()
MAINTAINERS (TO): [akpm@linux-foundation.org linux-mm@kvack.org]
MAINTAINERS (CC): [linux-kernel@vger.kernel.org]

BUG: unable to handle page fault for address: ff0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD cf7a067 P4D cf7a067 PUD cf7c067 PMD cf9f067 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8219 Comm: 9de Not tainted 6.7.0-rc41
Hardware name: QEMU Standard PC (i440FX + PIIX, 4
RIP: 0010:strncpy_from_kernel_nofault+0xc4/0x270 mm/maccess.c:91
Code: 83 85 6c 17 00 00 01 48 8b 2c 24 eb 18 e8 0
RSP: 0018:ffffc900114e7ac0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900114e7b30 RCX:2
RDX: ffff8880183abcc0 RSI: ffffffff81b8c9c4 RDI:c
RBP: ffffffffff600000 R08: 0000000000000001 R09:0
R10: 0000000000000001 R11: 0000000000000001 R12:8
R13: ffffffffff600000 R14: 0000000000000008 R15:0
FS:  0000000000000000(0000) GS:ffff88823bc00000(0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600000 CR3: 000000000cf77000 CR4:0
PKRU: 55555554
Call Trace:
<TASK>
bpf_probe_read_kernel_str_common kernel/trace/bpf_trace.c:262 [inline]
____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:310 [inline]
bpf_probe_read_compat_str+0x12f/0x170 kernel/trace/bpf_trace.c:303
bpf_prog_f17ebaf3f5f7baf8+0x42/0x44
bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
__bpf_prog_run include/linux/filter.h:651 [inline]
bpf_prog_run include/linux/filter.h:658 [inline]
__bpf_trace_run kernel/trace/bpf_trace.c:2307 [inline]
bpf_trace_run2+0x14e/0x410 kernel/trace/bpf_trace.c:2346
trace_kfree include/trace/events/kmem.h:94 [inline]
kfree+0xec/0x150 mm/slab_common.c:1043
vma_numab_state_free include/linux/mm.h:638 [inline]
__vm_area_free+0x3e/0x140 kernel/fork.c:525
remove_vma+0x128/0x170 mm/mmap.c:146
exit_mmap+0x453/0xa70 mm/mmap.c:3332
__mmput+0x12a/0x4d0 kernel/fork.c:1349
mmput+0x62/0x70 kernel/fork.c:1371
exit_mm kernel/exit.c:567 [inline]
do_exit+0x9aa/0x2ac0 kernel/exit.c:858
do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
__do_sys_exit_group kernel/exit.c:1032 [inline]
__se_sys_exit_group kernel/exit.c:1030 [inline]
__x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x41/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b


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
 *(uint32_t*)0x200000c0 = 0x11;
 *(uint32_t*)0x200000c4 = 0xb;
 *(uint64_t*)0x200000c8 = 0x20000180;
 *(uint8_t*)0x20000180 = 0x18;
 STORE_BY_BITMASK(uint8_t, , 0x20000181, 0, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x20000181, 0, 4, 4);
 *(uint16_t*)0x20000182 = 0;
 *(uint32_t*)0x20000184 = 0;
 *(uint8_t*)0x20000188 = 0;
 *(uint8_t*)0x20000189 = 0;
 *(uint16_t*)0x2000018a = 0;
 *(uint32_t*)0x2000018c = 0;
 *(uint8_t*)0x20000190 = 0x18;
 STORE_BY_BITMASK(uint8_t, , 0x20000191, 1, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x20000191, 0, 4, 4);
 *(uint16_t*)0x20000192 = 0;
 *(uint32_t*)0x20000194 = 0x25702020;
 *(uint8_t*)0x20000198 = 0;
 *(uint8_t*)0x20000199 = 0;
 *(uint16_t*)0x2000019a = 0;
 *(uint32_t*)0x2000019c = 0x20202000;
 STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 0, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 3, 2);
 STORE_BY_BITMASK(uint8_t, , 0x200001a0, 3, 5, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001a1, 0xa, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001a1, 1, 4, 4);
 *(uint16_t*)0x200001a2 = 0xfff8;
 *(uint32_t*)0x200001a4 = 0;
 STORE_BY_BITMASK(uint8_t, , 0x200001a8, 7, 0, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001a8, 1, 3, 1);
 STORE_BY_BITMASK(uint8_t, , 0x200001a8, 0xb, 4, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001a9, 1, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001a9, 0xa, 4, 4);
 *(uint16_t*)0x200001aa = 0;
 *(uint32_t*)0x200001ac = 0;
 STORE_BY_BITMASK(uint8_t, , 0x200001b0, 7, 0, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001b0, 0, 3, 1);
 STORE_BY_BITMASK(uint8_t, , 0x200001b0, 0, 4, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001b1, 1, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001b1, 0, 4, 4);
 *(uint16_t*)0x200001b2 = 0;
 *(uint32_t*)0x200001b4 = 0xfffffff8;
 STORE_BY_BITMASK(uint8_t, , 0x200001b8, 7, 0, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001b8, 0, 3, 1);
 STORE_BY_BITMASK(uint8_t, , 0x200001b8, 0xb, 4, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001b9, 2, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001b9, 0, 4, 4);
 *(uint16_t*)0x200001ba = 0;
 *(uint32_t*)0x200001bc = 8;
 STORE_BY_BITMASK(uint8_t, , 0x200001c0, 7, 0, 3);
 STORE_BY_BITMASK(uint8_t, , 0x200001c0, 0, 3, 1);
 STORE_BY_BITMASK(uint8_t, , 0x200001c0, 0xb, 4, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001c1, 3, 0, 4);
 STORE_BY_BITMASK(uint8_t, , 0x200001c1, 0, 4, 4);
 *(uint16_t*)0x200001c2 = 0;
 *(uint32_t*)0x200001c4 = 0xff600000;
 *(uint8_t*)0x200001c8 = 0x85;
 *(uint8_t*)0x200001c9 = 0;
 *(uint16_t*)0x200001ca = 0;
 *(uint32_t*)0x200001cc = 0x2d;
 *(uint8_t*)0x200001d0 = 0x95;
 *(uint8_t*)0x200001d1 = 0;
 *(uint16_t*)0x200001d2 = 0;
 *(uint32_t*)0x200001d4 = 0;
 *(uint64_t*)0x200000d0 = 0x20000200;
 memcpy((void*)0x20000200, "GPL\000", 4);
 *(uint32_t*)0x200000d8 = 0;
 *(uint32_t*)0x200000dc = 0;
 *(uint64_t*)0x200000e0 = 0;
 *(uint32_t*)0x200000e8 = 0;
 *(uint32_t*)0x200000ec = 0;
 memset((void*)0x200000f0, 0, 16);
 *(uint32_t*)0x20000100 = 0;
 *(uint32_t*)0x20000104 = 0;
 *(uint32_t*)0x20000108 = 0;
 *(uint32_t*)0x2000010c = 0;
 *(uint64_t*)0x20000110 = 0;
 *(uint32_t*)0x20000118 = 0;
 *(uint32_t*)0x2000011c = 0;
 *(uint64_t*)0x20000120 = 0;
 *(uint32_t*)0x20000128 = 0;
 *(uint32_t*)0x2000012c = 0;
 *(uint32_t*)0x20000130 = 0;
 *(uint32_t*)0x20000134 = 0;
 *(uint64_t*)0x20000138 = 0;
 *(uint64_t*)0x20000140 = 0;
 *(uint32_t*)0x20000148 = 0;
 *(uint32_t*)0x2000014c = 0;
 res = syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x200000c0ul, /*size=*/0x90ul);
 if (res != -1) r[0] = res;
 *(uint64_t*)0x20000540 = 0x20000000;
 memcpy((void*)0x20000000, "kfree\000", 6);
 *(uint32_t*)0x20000548 = r[0];
 syscall(__NR_bpf, /*cmd=*/0x11ul, /*arg=*/0x20000540ul, /*size=*/0x10ul);
 return 0;
}

=* repro.txt =*
r0 = bpf$PROG_LOAD(0x5, &(0x7f00000000c0)={0x11, 0xb,
&(0x7f0000000180)=@framed={{}, [@printk={@p, {}, {}, {}, {}, {0x7,
0x0, 0xb, 0x3, 0x0, 0x0, 0xff600000}, {0x85, 0x0, 0x0, 0x2d}}]},
&(0x7f0000000200)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
0x90)
bpf$BPF_RAW_TRACEPOINT_OPEN(0x11,
&(0x7f0000000540)={&(0x7f0000000000)='kfree\x00', r0}, 0x10)



See aslo https://gist.github.com/xrivendell7/7bb1f0a30ccc2899fe7ea34bef882067
I hope it helps.

Best regards.
xingwei Lee

