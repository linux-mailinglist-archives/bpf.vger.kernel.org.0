Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1905D268696
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 09:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgINHzZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 03:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgINHzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBF9C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 00:55:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id u18so1378458iln.13
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gH9g6lbCJBR1+C4YOewnymvFMebl2xfKbPgyTtX6Bw4=;
        b=F9FocHYgH/xsTCO41YKgEjaXQo/t6FEtNj3l3QZM7fCUFYssT+pncVmSJh6hmAKcLk
         Yl2KdOVnzhx82OLtO5wVYEkLGbGTlro+lK9Eht02VdW8SoTOpq9inII3ho6qW08+wpQN
         StsYBQV8zRrucdXEyC0WncZLWWN/+t8SM29xv7Qfp8HbFpyNgUmnH12+TWXLvJL4VYvb
         EkFVCA4j2YI4ZmfWRxWmd6mDySN3w1TTbXCdK/8cxnnt+DLebpBTcBbbIVVlk6ET7EAL
         DXze9jJUpQ14uf3j0Hotu6mtRklSFQ0IZ4EaURzPFSF8Je5V5bzi/XmQTno8OfEEzoB8
         kCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gH9g6lbCJBR1+C4YOewnymvFMebl2xfKbPgyTtX6Bw4=;
        b=A1EcF/+gGHOrGWA6my8aFzy90KjmjTEbVRH9R/cyJKUfqojxi73caV0uSdO3fUZzi8
         0ZR+b2hexZizn7AK4OTkTCPM2XvlabxNWKN5KnEJM0ZSfVf8botgEWmTFVfvdOmURThc
         mQN1DL1IbvSwPv9mlZEgAaTX/ypS1jT1cqPUBfUP5hNbMSTYqmRHaZ/BIemdMou/Tvlh
         roczRXE7Y4iaFWDhdBn+iB5rikAC16BDrZBc17U86c+FAD7FbV+RWogj0LVTrE1WkOk/
         E6QqPj8iU1yES7u+PLCVjRtr5GMjAn8Nq4M4iOlPUDCcZABVZgjN2udfES3Q8Ce6kWx0
         +8ig==
X-Gm-Message-State: AOAM532OKv/0FNZBC9iscKmXsr8Z3FffZtS/V77vNqcrJDbhPfRvdFKv
        HlCfB095Hv1mg9iNPf0/mtB0YIYWUQImYyEd9AeABQ==
X-Google-Smtp-Source: ABdhPJxgeyEvOOZuC9bSZAo22ZPpH63uh2nGWKgMDMqR2Ju6k//Ue/bOkBZV+Tz3OLMEmeEzjM0IzjZmxYURjFBQ72o=
X-Received: by 2002:a92:290d:: with SMTP id l13mr11524990ilg.114.1600070119532;
 Mon, 14 Sep 2020 00:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
 <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
From:   Luka Oreskovic <luka.oreskovic@sartura.hr>
Date:   Mon, 14 Sep 2020 09:55:08 +0200
Message-ID: <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 11, 2020 at 8:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
> <luka.oreskovic@sartura.hr> wrote:
> >
> > Greetings everyone,
> >
> > I have been testing various BPF programs on the ARM32 architecture and
> > have encountered a strange error.
> >
> > When trying to run a simple program that prints out the arguments of
> > the open syscall,
> > I found some strange behaviour with the pointer offsets when accessing
> > the arguments:
> > The output of llvm-objdump differed from the verifier error dump log.
> > Notice the differences in lines 0 and 1. Why is the bytecode being
> > altered at runtime?
> >
> > I attached the program, the llvm-objdump result and the verifier dump below.
> >
> > Best wishes,
> > Luka Oreskovic
> >
> > BPF program
> > --------------------------------------------
> > #include "vmlinux.h"
> > #include <bpf/bpf_helpers.h>
> >
> > SEC("tracepoint/syscalls/sys_enter_open")
> > int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> > {
> >         const char *arg1 = (const char *)ctx->args[0];
> >         int arg2 = (int)ctx->args[1];
> >
> >         bpf_printk("Open arg 1: %s\n", arg1);
> >         bpf_printk("Open arg 2: %d\n", arg2);
> >
> >         return 0;
> > }
> >
> > char LICENSE[] SEC("license") = "GPL";
> >
> >
> > llvm-objdump of program
> > --------------------------------------------
> > Disassembly of section tracepoint/syscalls/sys_enter_open:
> >
> > 0000000000000000 tracepoint__syscalls__sys_enter_open:
> > ;       int arg2 = (int)ctx->args[1];
> >        0:       79 16 18 00 00 00 00 00 r6 = *(u64 *)(r1 + 24)
> > ;       const char *arg1 = (const char *)ctx->args[0];
> >        1:       79 13 10 00 00 00 00 00 r3 = *(u64 *)(r1 + 16)
> >        2:       18 01 00 00 20 31 3a 20 00 00 00 00 25 73 0a 00 r1 =
> > 2941353058775328 ll
> > ;       bpf_printk("Open arg 1: %s\n", arg1);
> >        4:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
> >        5:       18 07 00 00 4f 70 65 6e 00 00 00 00 20 61 72 67 r7 =
> > 7454127125170581583 ll
> >        7:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
> >        8:       bf a1 00 00 00 00 00 00 r1 = r10
> >        9:       07 01 00 00 f0 ff ff ff r1 += -16
> >       10:       b7 02 00 00 10 00 00 00 r2 = 16
> >       11:       85 00 00 00 06 00 00 00 call 6
> >       12:       18 01 00 00 20 32 3a 20 00 00 00 00 25 64 0a 00 r1 =
> > 2924860384358944 ll
> > ;       bpf_printk("Open arg 2: %d\n", arg2);
> >       14:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
> >       15:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
> >       16:       bf a1 00 00 00 00 00 00 r1 = r10
> >       17:       07 01 00 00 f0 ff ff ff r1 += -16
> >       18:       b7 02 00 00 10 00 00 00 r2 = 16
> >       19:       bf 63 00 00 00 00 00 00 r3 = r6
> >       20:       85 00 00 00 06 00 00 00 call 6
> > ;       return 0;
> >       21:       b7 00 00 00 00 00 00 00 r0 = 0
> >       22:       95 00 00 00 00 00 00 00 exit
> >
> >
> > verifier output when running program
> > --------------------------------------------
> > libbpf: -- BEGIN DUMP LOG ---
> > libbpf:
> > Unrecognized arg#0 type PTR
> > ; int arg2 = (int)ctx->args[1];
> > 0: (79) r6 = *(u64 *)(r1 +16)
> > ; const char *arg1 = (const char *)ctx->args[0];
> > 1: (79) r3 = *(u64 *)(r1 +12)
> > invalid bpf_context access off=12 size=8
> > processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > peak_states 0 mark_read 0
> >
> > libbpf: -- END LOG --
>
>
> One suspect would be libbpf's CO-RE relocations. Can you send full
> debug libbpf logs, it will have a full log of what libbpf adjusted.
> Please also include the definition of struct trace_event_raw_sys_enter
> from your vmlinux.h, as well as commit that your kernel was built from
> (to check the original definition).


Here is the data you requested. I can see the reallocations done by BPF CO-RE,
but I don't understand why they would have to be done in the first place
since I am using the vmlinux.h that has been generated using the
devices vmlinux.
Even if it made sense to change the pointer offsets, they shouldn't
break the program.


Kernel commit
--------------------------------------------
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=v5.9-rc3


Struct definition from vmlinux.h
--------------------------------------------
struct trace_event_raw_sys_enter {
        struct trace_entry ent;
        long int id;
        long unsigned int args[6];
        char __data[0];
};


Libbpf debug output
--------------------------------------------
ibbpf: loading object 'hello_bpf' from buffer
libbpf: elf: section(3) tracepoint/syscalls/sys_enter_open, size 184,
link 0, flags 6, type=1
libbpf: elf: found program 'tracepoint/syscalls/sys_enter_open'
libbpf: elf: section(4) .rodata.str1.1, size 32, link 0, flags 32, type=1
libbpf: elf: skipping unrecognized data section(4) .rodata.str1.1
libbpf: elf: section(5) license, size 4, link 0, flags 3, type=1
libbpf: license of hello_bpf is GPL
libbpf: elf: section(12) .BTF, size 986, link 0, flags 0, type=1
libbpf: elf: section(14) .BTF.ext, size 252, link 0, flags 0, type=1
libbpf: elf: section(21) .symtab, size 936, link 1, flags 0, type=2
libbpf: looking for externs among 39 symbols...
libbpf: collected 0 externs total
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: sec 'tracepoint/syscalls/sys_enter_open': found 2 CO-RE relocations
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: kind
<byte_off> (0), spec is [2] struct trace_event_raw_sys_ent)
libbpf: CO-RE relocating [2] struct trace_event_raw_sys_enter: found
target candidate [4639] struct trace_event_raw_sys_entr
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: matching
candidate #0 [4639] struct trace_event_raw_sys_enter.a)
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: patched
insn #0 (LDX/ST/STX) off 24 -> 16
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: kind
<byte_off> (0), spec is [2] struct trace_event_raw_sys_ent)
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: matching
candidate #0 [4639] struct trace_event_raw_sys_enter.a)
libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: patched
insn #1 (LDX/ST/STX) off 16 -> 12
libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Unrecognized arg#0 type PTR
; int arg2 = (int)ctx->args[1];
0: (79) r6 = *(u64 *)(r1 +16)
; const char *arg1 = (const char *)ctx->args[0];
1: (79) r3 = *(u64 *)(r1 +12)
invalid bpf_context access off=12 size=8
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

libbpf: -- END LOG --
libbpf: failed to load program 'tracepoint/syscalls/sys_enter_open'
libbpf: failed to load object 'hello_bpf'
libbpf: failed to load BPF skeleton 'hello_bpf': -4007
failed to load BPF object -4007
