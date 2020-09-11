Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263026681E
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgIKSOM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgIKSOL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 14:14:11 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD3C061573
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 11:14:11 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id k2so4389613ybp.7
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Dj/oiJbiDekdNciwuUGfGVBtikbPOcO3vY7csAetLM=;
        b=N5A57KpkDu6u6/OBWXTBPmRiZLrARSOy4drokHNcKThGO9yhaK1sfkdwP8CVHye8+r
         t+n2dhi7et4ePt2L2CADsenyElqBEjYKZ8Q4iUEc1Gpg6IFYgm92vCgaRXiN4yuZl5lb
         I/gV6UNCO1dJkrVzreXjW1y5TzAcSt0YhT+mYY4ZAbN6FXGcrrwkwzWq1aOtXSfCT6ym
         71DWuN1bNydLVt1hs1MPq0K5MJkoCanEUI0Tz6jeiMGrbwm4fYcU/LVMkXqMO5hwH4dk
         URFemm8LesVreJybuMuh5Ek+d6uUoGCnekfecuAjAYy9sltf0PgXObZQqZaPrwb9V58j
         JbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Dj/oiJbiDekdNciwuUGfGVBtikbPOcO3vY7csAetLM=;
        b=iPfoA/Joabf/SPTWUAfDpV7peMonbNpJHxTrEM36KN7g6V07hh8UIusjJ7qmGnhVGr
         dhnh5wNNnjLyB7p2MraLpNxiLzkovcVoxC/ZJeydbgXwbhyQ/qe+aakrUm6Atfp3jLgG
         EJKj/vqHBTquX57rhyoz4x5wFljsWtnJYcImQ7CIDHelQ3dxC2C1jMXJFcgG4wSm4j/n
         t+MRv8qTOGmeRHd/BCJnlMsUAi7MbG/amDSgxsoOd9wGb6l9VzKqf4h0W+giSnnUcOYl
         P2uVV25vK1jTmbmCRJbiDKstPs2E5ShbvkR59YzkCAVGjlN+sbEVc2mo/ww0riWGtMm1
         6IQQ==
X-Gm-Message-State: AOAM532sU6iSvu7zX1FIfXkgcDqVxEuB76X0/4dSttbmNSh+7ERpEczh
        aa6xYsBhzDNklDjf/m7yd76FR+h7l4bsxBfD51Zu5k4qPek=
X-Google-Smtp-Source: ABdhPJzaj7Zx+IjThdlQJhRGX1EsdhkgMHgf4A25Dl0PWCFnD6KJfwlhJqKwzLCAzuHQWWRJ9rCVUHNT6eb/LYRm9nE=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr3765572ybm.230.1599848050105;
 Fri, 11 Sep 2020 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
In-Reply-To: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Sep 2020 11:13:59 -0700
Message-ID: <CAEf4BzZvXvb7CsnJZkoNUzb0-o=w-i9-CHecq0O+QcCKpeuUKQ@mail.gmail.com>
Subject: Re: Problems with pointer offsets on ARM32
To:     Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 11, 2020 at 9:45 AM Luka Oreskovic
<luka.oreskovic@sartura.hr> wrote:
>
> Greetings everyone,
>
> I have been testing various BPF programs on the ARM32 architecture and
> have encountered a strange error.
>
> When trying to run a simple program that prints out the arguments of
> the open syscall,
> I found some strange behaviour with the pointer offsets when accessing
> the arguments:
> The output of llvm-objdump differed from the verifier error dump log.
> Notice the differences in lines 0 and 1. Why is the bytecode being
> altered at runtime?
>
> I attached the program, the llvm-objdump result and the verifier dump below.
>
> Best wishes,
> Luka Oreskovic
>
> BPF program
> --------------------------------------------
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>
> SEC("tracepoint/syscalls/sys_enter_open")
> int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
> {
>         const char *arg1 = (const char *)ctx->args[0];
>         int arg2 = (int)ctx->args[1];
>
>         bpf_printk("Open arg 1: %s\n", arg1);
>         bpf_printk("Open arg 2: %d\n", arg2);
>
>         return 0;
> }
>
> char LICENSE[] SEC("license") = "GPL";
>
>
> llvm-objdump of program
> --------------------------------------------
> Disassembly of section tracepoint/syscalls/sys_enter_open:
>
> 0000000000000000 tracepoint__syscalls__sys_enter_open:
> ;       int arg2 = (int)ctx->args[1];
>        0:       79 16 18 00 00 00 00 00 r6 = *(u64 *)(r1 + 24)
> ;       const char *arg1 = (const char *)ctx->args[0];
>        1:       79 13 10 00 00 00 00 00 r3 = *(u64 *)(r1 + 16)
>        2:       18 01 00 00 20 31 3a 20 00 00 00 00 25 73 0a 00 r1 =
> 2941353058775328 ll
> ;       bpf_printk("Open arg 1: %s\n", arg1);
>        4:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
>        5:       18 07 00 00 4f 70 65 6e 00 00 00 00 20 61 72 67 r7 =
> 7454127125170581583 ll
>        7:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
>        8:       bf a1 00 00 00 00 00 00 r1 = r10
>        9:       07 01 00 00 f0 ff ff ff r1 += -16
>       10:       b7 02 00 00 10 00 00 00 r2 = 16
>       11:       85 00 00 00 06 00 00 00 call 6
>       12:       18 01 00 00 20 32 3a 20 00 00 00 00 25 64 0a 00 r1 =
> 2924860384358944 ll
> ;       bpf_printk("Open arg 2: %d\n", arg2);
>       14:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
>       15:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
>       16:       bf a1 00 00 00 00 00 00 r1 = r10
>       17:       07 01 00 00 f0 ff ff ff r1 += -16
>       18:       b7 02 00 00 10 00 00 00 r2 = 16
>       19:       bf 63 00 00 00 00 00 00 r3 = r6
>       20:       85 00 00 00 06 00 00 00 call 6
> ;       return 0;
>       21:       b7 00 00 00 00 00 00 00 r0 = 0
>       22:       95 00 00 00 00 00 00 00 exit
>
>
> verifier output when running program
> --------------------------------------------
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


One suspect would be libbpf's CO-RE relocations. Can you send full
debug libbpf logs, it will have a full log of what libbpf adjusted.
Please also include the definition of struct trace_event_raw_sys_enter
from your vmlinux.h, as well as commit that your kernel was built from
(to check the original definition).
