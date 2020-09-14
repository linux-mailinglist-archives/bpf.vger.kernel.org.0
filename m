Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610F426940E
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgINRuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgINRtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 13:49:36 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C1C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 10:49:23 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id p81so483202ybc.12
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7OuUrk2Rv4hmOLo+HhThrMSF2DlmTKLjDXsgEv9LfU=;
        b=RJsfaiYD+BieUHxkpZ2X2brp3nWMIjkIZOHhTFI0iFERDdiipq3o6vBKJR1KQKQu+C
         HLmI+2CnlAFuwmJgpHoJkD2Ya03N0DLddPydgIlfuRlbb3qMKbXu0RRdE49UVEDKLb26
         VEL29mGxVHbjcs+Z2yVh7nXZHGbqxd6BB6g6l84B1tZbQes1fD+Va9rbXEOMDNuVCDqO
         MnwdZCabXtvTBK6SM1csuH0LvegMH8kpBnPc17RnjidiuBl5FOfoxkAt5ZdSGVVdKeRe
         50C1yW7ga1m8wcvPT5XnzWOoNYUNDNgIC8MyMMiS0Y4BvI/rJxkRfZPH+R9aXEM14UbV
         0sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7OuUrk2Rv4hmOLo+HhThrMSF2DlmTKLjDXsgEv9LfU=;
        b=HjKrh55RCBArjQKxem4DnxupKKurAnuK5oe8Oxa4Zet04WLt7PVyjdKEW7DBmojvKF
         FNMfYE7Xb2SC9AhYa6XQMEqS2jtckGfk9AL5dADOOCb5xrLWb9weGqJZe8lHD6mMpoSa
         MKA/GHHH84CAZE4FLTqBrM/+xLZxIKfQxirzeLYedITE91oAidI/sPoBr4ALsKnKNB+Q
         9ZAQfhEf/eDPdPIIPwIGmTOKr1yATXUMjgazixqaTepjJUBxARYWcVcplPpFYiufCNFY
         Wo5jHgL6kPR5ZWGYaXX5wkoGhcdNJFIq5iorDhNqm2yUN4LbrE66wyctXUGzGdDm4Ppi
         1hDg==
X-Gm-Message-State: AOAM530TPEKYoW1QdWMBGlyq9majm0/sLl63X+dS7b0QcWCAmToVP3CT
        ab+FVuw4jO5kGqJbp4P3q7aGzGFsuUVOaFGbloVwvTldSPpxLw==
X-Google-Smtp-Source: ABdhPJwNm8OqkRQ9DCb4FsaL8Hm3BtQxQGQE+ELACkZuweb/tOITmta/v30msqQ6TasKtctSrYeYqscLIlHZDNHwOtU=
X-Received: by 2002:a25:c049:: with SMTP id c70mr22600006ybf.403.1600105762058;
 Mon, 14 Sep 2020 10:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
 <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com> <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
In-Reply-To: <CA+XBgLWNavRQJy7uRG35RXprHjQ1uaURyB8tj7tE=Mv=EWKO+g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Sep 2020 10:49:11 -0700
Message-ID: <CAEf4Bzb4JrfmENs197d30xU2fnWwu9_1rq-=n9szaWmmxaSckg@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 12:55 AM Luka Oreskovic
<luka.oreskovic@sartura.hr> wrote:
>
> On Fri, Sep 11, 2020 at 8:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
> > <luka.oreskovic@sartura.hr> wrote:
> > >
> > > Greetings everyone,
> > >
> > > I have been testing various BPF programs on the ARM32 architecture and
> > > have encountered a strange error.
> > >
> > > When trying to run a simple program that prints out the arguments of
> > > the open syscall,
> > > I found some strange behaviour with the pointer offsets when accessing
> > > the arguments:
> > > The output of llvm-objdump differed from the verifier error dump log.
> > > Notice the differences in lines 0 and 1. Why is the bytecode being
> > > altered at runtime?
> > >
> > > I attached the program, the llvm-objdump result and the verifier dump below.
> > >
> > > Best wishes,
> > > Luka Oreskovic
> > >
> > > BPF program
> > > --------------------------------------------
> > > #include "vmlinux.h"
> > > #include <bpf/bpf_helpers.h>
> > >
> > > SEC("tracepoint/syscalls/sys_enter_open")
> > > int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> > > {
> > >         const char *arg1 = (const char *)ctx->args[0];
> > >         int arg2 = (int)ctx->args[1];
> > >
> > >         bpf_printk("Open arg 1: %s\n", arg1);
> > >         bpf_printk("Open arg 2: %d\n", arg2);
> > >
> > >         return 0;
> > > }
> > >
> > > char LICENSE[] SEC("license") = "GPL";
> > >
> > >
> > > llvm-objdump of program
> > > --------------------------------------------
> > > Disassembly of section tracepoint/syscalls/sys_enter_open:
> > >
> > > 0000000000000000 tracepoint__syscalls__sys_enter_open:
> > > ;       int arg2 = (int)ctx->args[1];
> > >        0:       79 16 18 00 00 00 00 00 r6 = *(u64 *)(r1 + 24)
> > > ;       const char *arg1 = (const char *)ctx->args[0];
> > >        1:       79 13 10 00 00 00 00 00 r3 = *(u64 *)(r1 + 16)
> > >        2:       18 01 00 00 20 31 3a 20 00 00 00 00 25 73 0a 00 r1 =
> > > 2941353058775328 ll
> > > ;       bpf_printk("Open arg 1: %s\n", arg1);
> > >        4:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
> > >        5:       18 07 00 00 4f 70 65 6e 00 00 00 00 20 61 72 67 r7 =
> > > 7454127125170581583 ll
> > >        7:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
> > >        8:       bf a1 00 00 00 00 00 00 r1 = r10
> > >        9:       07 01 00 00 f0 ff ff ff r1 += -16
> > >       10:       b7 02 00 00 10 00 00 00 r2 = 16
> > >       11:       85 00 00 00 06 00 00 00 call 6
> > >       12:       18 01 00 00 20 32 3a 20 00 00 00 00 25 64 0a 00 r1 =
> > > 2924860384358944 ll
> > > ;       bpf_printk("Open arg 2: %d\n", arg2);
> > >       14:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
> > >       15:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
> > >       16:       bf a1 00 00 00 00 00 00 r1 = r10
> > >       17:       07 01 00 00 f0 ff ff ff r1 += -16
> > >       18:       b7 02 00 00 10 00 00 00 r2 = 16
> > >       19:       bf 63 00 00 00 00 00 00 r3 = r6
> > >       20:       85 00 00 00 06 00 00 00 call 6
> > > ;       return 0;
> > >       21:       b7 00 00 00 00 00 00 00 r0 = 0
> > >       22:       95 00 00 00 00 00 00 00 exit
> > >
> > >
> > > verifier output when running program
> > > --------------------------------------------
> > > libbpf: -- BEGIN DUMP LOG ---
> > > libbpf:
> > > Unrecognized arg#0 type PTR
> > > ; int arg2 = (int)ctx->args[1];
> > > 0: (79) r6 = *(u64 *)(r1 +16)
> > > ; const char *arg1 = (const char *)ctx->args[0];
> > > 1: (79) r3 = *(u64 *)(r1 +12)
> > > invalid bpf_context access off=12 size=8
> > > processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> > > peak_states 0 mark_read 0
> > >
> > > libbpf: -- END LOG --
> >
> >
> > One suspect would be libbpf's CO-RE relocations. Can you send full
> > debug libbpf logs, it will have a full log of what libbpf adjusted.
> > Please also include the definition of struct trace_event_raw_sys_enter
> > from your vmlinux.h, as well as commit that your kernel was built from
> > (to check the original definition).
>
>
> Here is the data you requested. I can see the reallocations done by BPF CO-RE,
> but I don't understand why they would have to be done in the first place
> since I am using the vmlinux.h that has been generated using the
> devices vmlinux.
> Even if it made sense to change the pointer offsets, they shouldn't
> break the program.

Ok, there are few things at work here. I'll try to explain it and
let's see how we can fix this. This is all due to 32-bit architecture,
of course.

1. BPF "architecture" is strictly 64-bit one. This means that from the
BPF program point of view pointers are 64-bit values, long is 64-bit
as well.
2. look at struct trace_event_raw_sys_enter below: id and each element
of args[] array are longs. What this means is the following:
  - from BPF side of view those are assumed to be 64-bit integers
  - but in reality in ARM32 kernel and in memory they are 32-bit integers.

So the memory view of struct trace_event_raw_sys_enter differs quite a
lot, depending in which context that struct definition is used. You
can see that from the compiled BPF assembly output above and compare
to the actual memory layout, taking into account that long is 4 bytes.
For BPF args[0] is at 16 bytes, args[1] is at 24 bytes. But in reality
it's at 12 byte offset for args[0] and 16 byte offset for args[1]. So
what libbpf/CO-RE is doing is right, it actually relocates offset 16
to 12 and 24 to 16. So without CO-RE you'd be accessing completely
wrong offsets and reading garbage.
3. But read size matters as well. When compiling your BPF program
clang sees 8-byte read and emits corresponding BPF assembly
instruction. While in reality it has to be 4-byte read. Then later in
the verifier (see tp_prog_is_valid_access() in
kernel/trace/bpf_trace.c) there is a very simple check that all
offsets are multiples of access size, and 12 % 8 != 0, so the verifier
complains.

It's a bit verbose explanation, but I hope it describes the problem.
Basically, longs in a mixed BPF/32-bit land are error prone (as well
as pointers in kernel data structures, btw).

Now, a short-term fix for your use case would be to copy/paste struct
trace_event_raw_sys_enter and replace all longs with ints. That will
fix access size and offsets.

Longer-term and a more proper fix is probably for libbpf to be smarter
when emitting vmlinux.h and replace 4-byte longs with ints, knowing
that vmlinux.h is going to be used from always-64-bit BPF
architecture. I'll think a bit more about the implications of this,
and if there are no problems with that approach, I'll submit a change
soon enough. Pointers will still be a problem, though, and I'm not
sure how we can solve it yet. Ideally there would be some solution
that would cause Clang to emit 4-byte reads for pointers. I wonder if
anyone else has any ideas around that.

As a separate thing, it might be a good idea to allow 4-byte aligned
8-byte reads in the verifier on 32-bit architectures, given they are
allowed on such architectures. Though for you that would lead to
garbage in the upper 4 bytes of BPF register, which is equally bad.

>
>
> Kernel commit
> --------------------------------------------
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=v5.9-rc3
>
>
> Struct definition from vmlinux.h
> --------------------------------------------
> struct trace_event_raw_sys_enter {
>         struct trace_entry ent;
>         long int id;
>         long unsigned int args[6];
>         char __data[0];
> };
>
>

[...]

> libbpf: collected 0 externs total
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: sec 'tracepoint/syscalls/sys_enter_open': found 2 CO-RE relocations
> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: kind
> <byte_off> (0), spec is [2] struct trace_event_raw_sys_ent)

these logs seem to be truncated, btw

> libbpf: CO-RE relocating [2] struct trace_event_raw_sys_enter: found
> target candidate [4639] struct trace_event_raw_sys_entr
> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: matching
> candidate #0 [4639] struct trace_event_raw_sys_enter.a)

like here it actually should be something like:

struct trace_event_raw_sys_enter.args[0]

> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #0: patched
> insn #0 (LDX/ST/STX) off 24 -> 16
> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: kind
> <byte_off> (0), spec is [2] struct trace_event_raw_sys_ent)
> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: matching
> candidate #0 [4639] struct trace_event_raw_sys_enter.a)
> libbpf: prog 'tracepoint/syscalls/sys_enter_open': relo #1: patched
> insn #1 (LDX/ST/STX) off 16 -> 12
> libbpf: load bpf program failed: Permission denied
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> Unrecognized arg#0 type PTR
> ; int arg2 = (int)ctx->args[1];
> 0: (79) r6 = *(u64 *)(r1 +16)
> ; const char *arg1 = (const char *)ctx->args[0];
> 1: (79) r3 = *(u64 *)(r1 +12)
> invalid bpf_context access off=12 size=8
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>
> libbpf: -- END LOG --
> libbpf: failed to load program 'tracepoint/syscalls/sys_enter_open'
> libbpf: failed to load object 'hello_bpf'
> libbpf: failed to load BPF skeleton 'hello_bpf': -4007
> failed to load BPF object -4007
