Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117A03A3D7E
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 09:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFKHtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKHtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 03:49:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8CC061574
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 00:47:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g38so3039920ybi.12
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D7xdoSqhR2T0FM0EDQan/IWV7y8d4tTaViEq+kXbf7w=;
        b=XUSh7Iy6rLoLWZfAVdcC/nyaNoKuvsmqyC2A4tmNo+99zGD2DIOYdgXvVewJKDBqml
         5x+Zfzzmj04PulqdccQlg98KANxWm+wlvIA9gTl/z/ASlgyVdc1e8ThzYraar4KAFwZd
         j5DofEpbLV7erxNR7LN9miFVmXdsY9CYVWvLZWB+Q3bzTHGOQS9V9vxbBlYt/OHyBY/W
         6F4HVcXBWhge/GJL3FXpQw6DS5zmUcUc9jkuU6e0483X/mSmpEAesuLoxtu5p+S5V1XG
         3UyTG2Z+pV9jQwXAY10n0stMF177TrpUDItTNYOM5PHzKmpA3F4VSSoqbL3+PVnAjhiW
         1XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D7xdoSqhR2T0FM0EDQan/IWV7y8d4tTaViEq+kXbf7w=;
        b=HX9agjBhlU1Hchc2w/Ti5xc2b7tqc0y4AEK9kKwxF33S53vAMxfLgeMJIZKJBmTpO8
         E1bSbdpgrAzVjnDrjVA0ybbqx6SDbmXUtHdkvzyqrUcF2/rixnM/pLH56Khk1o6hJBxy
         6Q2fZANZazKy/VbukS+LvnsDFI/KQ4WR4hmVGjXqCRL+Uip37WrM6hGnOoCtJhExskeg
         xk24h5UrzUVR7n7n0TOVeGtNLsh4KzWgpHiyCMt6sJLBFPT+vdBmnwFQWUD6+Miku28S
         yjNGc6aI28yIOTPDIrSy0gZygKxg60sfsjCG3hTLVTah1WABEE2RyQo5hGso6lHuw+qq
         +i6Q==
X-Gm-Message-State: AOAM532YETU8fN1TvyQburTbmSX+mh4w56OuOjV87FvO+bLNLOFu3zRo
        FOaiZvE4TmX+mEPxkwRg5uos0s0Px3+Cgy0pTdv04RXABplvN9zYf94=
X-Google-Smtp-Source: ABdhPJyGeKaTO/ep7AYe2+KE7tbz/HRDwSzMBcdE58PjrRCIg4QkYVezMzBF1lQawGPPbPk8SEpgN7ZY6LEtwY/d/qQ=
X-Received: by 2002:a25:888b:: with SMTP id d11mr4173374ybl.385.1623397657883;
 Fri, 11 Jun 2021 00:47:37 -0700 (PDT)
MIME-Version: 1.0
From:   rainkin <rainkin1993@gmail.com>
Date:   Fri, 11 Jun 2021 15:47:01 +0800
Message-ID: <CAHb-xatSY=uJQw3XSFeg2_ctd05du0p-V-1YGDKhwW4voDZ11A@mail.gmail.com>
Subject: Running libbpf + CO-RE in old kernels
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I try to run libbpf + CO-RE in old kernels (i.e., 4.19 here).
I follow the discussion in this thread
https://lore.kernel.org/bpf/CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com/
and successfully run a binary which compiled in kernel v5.8 in old kernel 4.19.

Basically, I just compile the linux kernel 4.19 source code and run
pahole -J to generate a vmlinux containing .BTF sections.
Then I copy this vmlinux file in kernel v4.19 /boot/vmlinux-xxx where
libbpf will search vmlinux.
Finally, I run the eBPF compiled binary and it works perfectly (I can
get all the data I want).

However, I find some error message shown by libbpf
e.g.,
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
...
[10] Invalid btf_info:840000ad
libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.

Although such errors do not prevent the binary running and the binary
works well, I still wonder what such errors mean.
Welcome any suggestions.

The following is the complete logs:

libbpf: loading object 'minimal_bpf' from buffer
libbpf: elf: section(2) raw_tp/sched_process_exec, size 280, link 0,
flags 6, type=1
libbpf: sec 'raw_tp/sched_process_exec': found program
'handle_sched_process_exec' at insn offset 0 (0 bytes), code size 35
insns (280 bytes)
libbpf: elf: section(3) license, size 13, link 0, flags 3, type=1
libbpf: license of minimal_bpf is Dual BSD/GPL
libbpf: elf: section(4) .rodata.str1.1, size 16, link 0, flags 32, type=1
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
libbpf: elf: section(5) .BTF, size 23717, link 0, flags 0, type=1
libbpf: elf: section(6) .BTF.ext, size 364, link 0, flags 0, type=1
libbpf: elf: section(7) .symtab, size 96, link 11, flags 0, type=2
libbpf: looking for externs among 4 symbols...
libbpf: collected 0 externs total
libbpf: loading kernel BTF '/boot/vmlinux-4.19.0-041900-generic': 0
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 14212
str_off: 14212
str_len: 9481
btf_total_size: 23717
[1] PTR (anon) type_id=2
[2] STRUCT bpf_raw_tracepoint_args size=0 vlen=1
args type_id=5 bits_offset=0
[3] TYPEDEF __u64 type_id=4
[4] INT long long unsigned int size=8 bits_offset=0 nr_bits=64 encoding=(none)
[5] ARRAY (anon) type_id=3 index_type_id=6 nr_elems=0
[6] INT __ARRAY_SIZE_TYPE__ size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] ENUM (anon) size=4 vlen=1
ctx val=1
[8] INT int size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[9] TYPEDEF handle_sched_process_exec type_id=7
[10] Invalid btf_info:840000ad
libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.
libbpf: sec 'raw_tp/sched_process_exec': found 4 CO-RE relocations
libbpf: prog 'handle_sched_process_exec': relo #0: kind <byte_off>
(0), spec is [2] struct bpf_raw_tracepoint_args.args[0] (0:0:0 @
offset 0)
libbpf: CO-RE relocating [0] struct bpf_raw_tracepoint_args: found
target candidate [17643] struct bpf_raw_tracepoint_args in [vmlinux]
libbpf: prog 'handle_sched_process_exec': relo #0: matching candidate
#0 [17643] struct bpf_raw_tracepoint_args.args[0] (0:0:0 @ offset 0)
libbpf: prog 'handle_sched_process_exec': relo #0: patched insn #1
(LDX/ST/STX) off 0 -> 0
libbpf: prog 'handle_sched_process_exec': relo #1: kind <byte_off>
(0), spec is [10] struct task_struct.pid (0:54 @ offset 1168)
libbpf: CO-RE relocating [0] struct task_struct: found target
candidate [148] struct task_struct in [vmlinux]
libbpf: CO-RE relocating [0] struct task_struct: found target
candidate [18861] struct task_struct in [vmlinux]
libbpf: prog 'handle_sched_process_exec': relo #1: matching candidate
#0 [148] struct task_struct.pid (0:61 @ offset 2216)
libbpf: prog 'handle_sched_process_exec': relo #1: matching candidate
#1 [18861] struct task_struct.pid (0:61 @ offset 2216)
libbpf: prog 'handle_sched_process_exec': relo #1: patched insn #2
(ALU/ALU64) imm 1168 -> 2216
libbpf: prog 'handle_sched_process_exec': relo #2: kind <byte_off>
(0), spec is [2] struct bpf_raw_tracepoint_args.args[2] (0:0:2 @
offset 16)
libbpf: prog 'handle_sched_process_exec': relo #2: matching candidate
#0 [17643] struct bpf_raw_tracepoint_args.args[2] (0:0:2 @ offset 16)
libbpf: prog 'handle_sched_process_exec': relo #2: patched insn #8
(LDX/ST/STX) off 16 -> 16
libbpf: prog 'handle_sched_process_exec': relo #3: kind <byte_off>
(0), spec is [287] struct linux_binprm.filename (0:17 @ offset 96)
libbpf: CO-RE relocating [0] struct linux_binprm: found target
candidate [1866] struct linux_binprm in [vmlinux]
libbpf: prog 'handle_sched_process_exec': relo #3: matching candidate
#0 [1866] struct linux_binprm.filename (0:15 @ offset 200)
libbpf: prog 'handle_sched_process_exec': relo #3: patched insn #9
(ALU/ALU64) imm 96 -> 200
Successfully started! Please run `sudo cat
/sys/kernel/debug/tracing/trace_pipe` to see output of the BPF
programs.

The following is the test code and environment:
Here is the test code:
**kernel code:**
```
#include <vmlinux.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_core_read.h>
#include <bpf/bpf_tracing.h>

char LICENSE[] SEC("license") = "Dual BSD/GPL";

SEC("raw_tp/sched_process_exec")
int handle_sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
{
struct task_struct *p = (struct task_struct *)ctx->args[0];
pid_t pid;
bpf_core_read(&pid, sizeof(pid), &p->pid);
struct linux_binprm *bprm = (struct linux_binprm *)ctx->args[2];
char fn[127];
char *filename_ptr;
bpf_core_read(&filename_ptr, sizeof(filename_ptr), &bprm->filename);
bpf_core_read_str(fn, sizeof(fn), filename_ptr);
bpf_printk("raw_tp: %d, %s\n", pid, fn);

return 0;
}
```

For the **user land code**, I just reuse the one in libbpf-bootstrap
https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/kprobe.c,
which, I think, will print all debug information.

For the **libbpf version**, I also use the same as libbpf-bootstrap,
that is https://github.com/libbpf/libbpf/tree/767d82caab7e54238f2fc6f40ab1e4af285f2abe

Thanks,
Rainkin
