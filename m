Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE620E0FA
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgF2UvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgF2TN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48370C08EB18
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2020 23:24:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so14284909qkg.12
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2020 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+9rONQeuHOsu3qMdgTJ+1vhBaAyS+WyXumKr7aVa88=;
        b=aOW+qVyu+cAJrEFyr2OOYQbC7EPzzBdv9SL6DONgDOkJvwNLlF+j/aL8R9V4Xn+7qb
         baxHuaH5JauKzV4CXS5ZQGNCa3IU+H0c0zqco3BNzMjKbUwT+XI2Tb9OM74XUA7/VoKl
         UHqSo/S+E1+VgoGo8ycKZok83JbcfigoiCDoTVvnKDDVntKieB/5GlaoIiN2OMcBoV5b
         acZnHvC04wAwI6vUjz0F9W0S6u22X4kBJTIAUZs7N0xTwE7Rxsn8PjWmSzVDLYPBCGFO
         VOhqMFCniSBXYmxTSOg4Mir8WLT8SQM4po04EcAbeAQVQqPHQ/ZbxP0VujyQ+7RSQ+mx
         WsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+9rONQeuHOsu3qMdgTJ+1vhBaAyS+WyXumKr7aVa88=;
        b=pxbLOe6ulT61kYw0lx5OVx8p4bwuZ+wuzDduoqCzKwzX8v5bDXFEh//dt7AwkQHPeb
         rkAHNz8Eyjbn8L6WFvxvnr9dFm6cMBjJdjLDBMa1oUk7fMjX1Qi1N6jVWNhyqBZwpYvz
         574/PA+EmvbB6n9tmwqOlvGHjNFPfNDi+cier7ps/51EgiOQ/xcv8Z3bZ3IkYZWRBY70
         5AfPx88u5onhw9IfS2sEXutwXSw93hOD3P7oqQ7qoNgyGfin9MSAFzedcMsXqjmcgMJ/
         mcnVwGFK8pJgPelX3eu341if3Wxe8OtMlNxP5HqMHQD7xN4p7p7TaYEXEqG3K8TMrk0C
         s+ig==
X-Gm-Message-State: AOAM5309POJ92qFt7P+abUmQpJA78Cc3j0nGaKBEn6bk/9wC6Co2ivOI
        ruJmPDndXSNRHMjlScEyD13UDvOR7dIcqB8iXrU=
X-Google-Smtp-Source: ABdhPJwho7K28lYagQ7QPUK2ABQvuyirg1B+ihN/tj9RD3Okt6gJv+NmY5QeLfs+v7YVcCjzC7ArDx2woJx8DV+YmHU=
X-Received: by 2002:ae9:f002:: with SMTP id l2mr2486882qkg.437.1593411860312;
 Sun, 28 Jun 2020 23:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
In-Reply-To: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 28 Jun 2020 23:24:09 -0700
Message-ID: <CAEf4BzY1FFr0qJtDZ=XREZ=YHkCJEp4ZskHamYnCXKY+Bpmkhg@mail.gmail.com>
Subject: Re: tp_btf: if (!struct->pointer_member) always actually false
 although pointer_member == NULL
To:     Wenbo Zhang <ethercflow@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 28, 2020 at 10:25 PM Wenbo Zhang <ethercflow@gmail.com> wrote:
>
> I found in tp_btf program, direct access struct's pointer member's
> behaviour isn't consistent with
> BPF_CORE_READ. for example:
>
> SEC("tp_btf/block_rq_issue")
> int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
>     struct request *rq)
> {
>         /* After echo none > /sys/block/$dev/queue/scheduler,
>          * the $dev's q->elevator will be set to NULL.
>          */
>         if (!q->elevator)
>                 bpf_printk("direct access: noop\n");
>         if (!BPF_CORE_READ(q, elevator))
>                 bpf_printk("FROM CORE READ: noop\n");
>         return 0;
> }
>
> Although its value is NULL, from trace_pipe I can only see
>
> > FROM CORE READ: noop
>
> So it seems  `if (!q->elevator)` always return false.
>
> I tested it with kernel 5.7.0-rc7+ and 5.8.0-rc1+, both have this problem.
> clang version: clang version 10.0.0-4ubuntu1~18.04.1
>
> Reproduce step:
> 1. Run this bpf prog;
> 2. Run `cat /sys/kernel/debug/tracing/trace_pipe` in other window;
> 3. Run `echo none > /sys/block/sdc/queue/scheduler`;  # please replace
> sdc to your device;
> 4. Run `dd if=/dev/zero of=/dev/sdc  bs=1MiB count=200 oflag=direct`;
>

Thanks a lot for detailed bug report. I haven't executed it, but I can
see from BPF assembly in kernel that there is a bug in a kernel. See
below.

>
> The output of  `llvm-objdump-10 -D bio.bpf.o` is:

Next time please use -d or -S, that way it will disassemble only
actual code, not all of the sections. Just FYI.

>
>
> bio.bpf.o:      file format ELF64-BPF
>
>
> Disassembly of section tp_btf/block_rq_issue:
>
> 0000000000000000 tp_btf__block_rq_issue:
>        0:       b7 02 00 00 08 00 00 00 r2 = 8
>        1:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0)
>        2:       bf 16 00 00 00 00 00 00 r6 = r1
>        3:       0f 26 00 00 00 00 00 00 r6 += r2
>        4:       79 11 08 00 00 00 00 00 r1 = *(u64 *)(r1 + 8)
>        5:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_2>
>        6:       b7 01 00 00 00 00 00 00 r1 = 0
>        7:       73 1a fc ff 00 00 00 00 *(u8 *)(r10 - 4) = r1
>        8:       b7 01 00 00 6f 6f 70 0a r1 = 175140719
>        9:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
>       10:       18 01 00 00 63 63 65 73 00 00 00 00 73 3a 20 6e r1 =
> 7935406810958488419 ll
>       12:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
>       13:       18 01 00 00 64 69 72 65 00 00 00 00 63 74 20 61 r1 =
> 6998721791186332004 ll
>       15:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
>       16:       bf a1 00 00 00 00 00 00 r1 = r10
>       17:       07 01 00 00 e8 ff ff ff r1 += -24
>       18:       b7 02 00 00 15 00 00 00 r2 = 21
>       19:       85 00 00 00 06 00 00 00 call 6
>
> 00000000000000a0 LBB0_2:
>       20:       bf a1 00 00 00 00 00 00 r1 = r10
>       21:       07 01 00 00 e8 ff ff ff r1 += -24
>       22:       b7 02 00 00 08 00 00 00 r2 = 8
>       23:       bf 63 00 00 00 00 00 00 r3 = r6
>       24:       85 00 00 00 04 00 00 00 call 4
>       25:       79 a1 e8 ff 00 00 00 00 r1 = *(u64 *)(r10 - 24)
>       26:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_4>
>       27:       b7 01 00 00 0a 00 00 00 r1 = 10
>       28:       6b 1a fc ff 00 00 00 00 *(u16 *)(r10 - 4) = r1
>       29:       b7 01 00 00 6e 6f 6f 70 r1 = 1886351214
>       30:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
>       31:       18 01 00 00 45 20 52 45 00 00 00 00 41 44 3a 20 r1 =
> 2322243604989485125 ll
>       33:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
>       34:       18 01 00 00 46 52 4f 4d 00 00 00 00 20 43 4f 52 r1 =
> 5931033040285291078 ll
>       36:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
>       37:       bf a1 00 00 00 00 00 00 r1 = r10
>       38:       07 01 00 00 e8 ff ff ff r1 += -24
>       39:       b7 02 00 00 16 00 00 00 r2 = 22
>       40:       85 00 00 00 06 00 00 00 call 6
>
> 0000000000000148 LBB0_4:
>       41:       b7 00 00 00 00 00 00 00 r0 = 0
>       42:       95 00 00 00 00 00 00 00 exit
>

There are two relocations on instruction #0 and #4, I double-checked,
libbpf correctly resolves them to 8 (byte offset of elevator field
within request_queue). This code dump also looks correct, so Clang
generates everything properly.

But if you dump loaded BPF program assembly, it becomes clear that
verifier is not doing the right thing. Here's in-kernel version dump:

[vmuser@archvm bpftool]$ sudo bpftool p d x id 3468
int tp_btf__block_rq_issue(long long unsigned int * ctx):
; int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
   0: (b7) r2 = 8
; int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
   1: (79) r1 = *(u64 *)(r1 +0)
   2: (bf) r6 = r1
   3: (0f) r6 += r2
; if (!q->elevator)
   4: (79) r1 = *(u64 *)(r1 +8)
; bpf_printk("direct access: noop\n");

Here verifier's analysis for whatever reason concluded that r1 is
always going to be != 0 and it eliminated entire if block.

It's a bit too late here for me to dig into this, I might take a look
tomorrow, unless someone beats me to it. But yeah, there clearly is a
bug in verifier branch prediction.


   5: (bf) r1 = r10
;
   6: (07) r1 += -24
; if (!BPF_CORE_READ(q, elevator))
   7: (b7) r2 = 8
   8: (bf) r3 = r6
   9: (85) call bpf_probe_read_compat#-147792
; if (!BPF_CORE_READ(q, elevator))
  10: (79) r1 = *(u64 *)(r10 -24)
; if (!BPF_CORE_READ(q, elevator))
  11: (55) if r1 != 0x0 goto pc+14
  12: (b7) r1 = 10
; bpf_printk("FROM CORE READ: noop\n");
  13: (6b) *(u16 *)(r10 -4) = r1
  14: (b7) r1 = 1886351214
  15: (63) *(u32 *)(r10 -8) = r1
  16: (18) r1 = 0x203a444145522045
  18: (7b) *(u64 *)(r10 -16) = r1
  19: (18) r1 = 0x524f43204d4f5246
  21: (7b) *(u64 *)(r10 -24) = r1
  22: (bf) r1 = r10
  23: (07) r1 += -24
  24: (b7) r2 = 22
  25: (85) call bpf_trace_printk#-150256
; int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
  26: (b7) r0 = 0
  27: (95) exit


[...]

>
>
> BTW, the llvm-objdump will core dump after output the above info:
>
> Stack dump:
> 0. Program arguments: llvm-objdump-10 -D bio.bpf.o
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys15PrintStackTraceERNS_11raw_ostreamE+0x1f)[0x7f7636d5dc3f]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys17RunSignalHandlersEv+0x50)[0x7f7636d5bf00]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x978205)[0x7f7636d5e205]
> /lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f76361d9890]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bbed3)[0x7f76385a1ed3]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21baefb)[0x7f76385a0efb]
> /usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bc0ce)[0x7f76385a20ce]
> llvm-objdump-10[0x41b78c]
> llvm-objdump-10[0x425278]
> llvm-objdump-10[0x41f502]
> llvm-objdump-10[0x41a473]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f763546db97]
> llvm-objdump-10[0x41542a]
> [1]    21636 segmentation fault (core dumped)

This is not good, though dumping .BTF section as assembly is not a
usual case ;) Maybe Yonghong has some insights on this one, though.

>
> llvm-objdump-10 --version
> LLVM (http://llvm.org/):
>   LLVM version 10.0.0
>

[...]
