Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779362664BA
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKQoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 12:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgIKPIW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685EC061757
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:57:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t13so9227941ile.9
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ykseYhJ90a1CbPCcoVWkcQnnJUIuSYT5dh8aD3YbFOE=;
        b=D2eebW1OrS1EsxnjO/gPjG8eT62idCz9IEXRv1DYKyJK8PvR6/k9DjbkqiItuM3R6p
         vocaqHBtsvDa0KWILYY3NhewAuLbWsZdyBMyu3T6SSJt/F252jjj6/iqRqKGJCs8Tdq2
         gzf1u9gFjNrHkJLLDZf9jldzG3mGoJwAHWlqPjMu3zGjOgIBFFJ2sRoAjUMqC5hciDvY
         h3Skykro16zLlTrLbG+l9HMae10Oa/9O2xQj4K+a+hYpyV6YjhEXyuPjPJlCkfWYV4NE
         oBPT+k47UK6d9moi/2hOZkqPWrBVBXapWPUGJVTwnyrbCM+wrBMcQaMmgLBH5U7GLlw8
         Ysyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ykseYhJ90a1CbPCcoVWkcQnnJUIuSYT5dh8aD3YbFOE=;
        b=K57h/KGRwL0F2wSXkpRrwaQjSNDUexKpD8pVo0d3u9a56ZQDzk3Bny68ETzbVdTGvY
         Rpp84L+CJSSYgDPRk4YD3gBPOfaWBIhKTWfA2R/BiGYos/fFD7SDfHHoW4RO7vZFGhDt
         b8dg4Q3tKvCvYsOxJsgmQbZESl/qqR7SQi1gAzyNSJDASXzWhj7H6n8vteJ0Sgr+bHbQ
         Ie79mzMORAFdQvagcortWBf7PXtfkOBwCDIjvR6TmVVoz+Ppsb7rp2uqsBBlrJmJv4Js
         TBJUk7DsOljAqW5ttqu4ERmpLubDE9caSGzWSeRLftnHz3GJpnhpJVBVO5+5VK6/MA/K
         Zf/w==
X-Gm-Message-State: AOAM530K/dB6ggSH/ce2JTfot7H5fXLlvTlerI9RNXJPzgwFUcQjhNgb
        NkMNuHG1tyb/miI2oVZZ0bQ7uelFh4L8sIrGymK9ZBtWF+8Lcw==
X-Google-Smtp-Source: ABdhPJy8jm85kawKVsCdI4q9H2rZ5aCR21bsoD1aH3lHeY29rFSzv/bG3y8qmxnI8f06SBgVNmm17UOzuOoT29D6aj8=
X-Received: by 2002:a92:6b04:: with SMTP id g4mr2095402ilc.203.1599836226724;
 Fri, 11 Sep 2020 07:57:06 -0700 (PDT)
MIME-Version: 1.0
From:   Luka Oreskovic <luka.oreskovic@sartura.hr>
Date:   Fri, 11 Sep 2020 16:56:56 +0200
Message-ID: <CA+XBgLU=8PFkP8S32e4gpst0=R4MFv8rZA5KaO+cEPYSnTRYYw@mail.gmail.com>
Subject: Problems with pointer offsets on ARM32
To:     bpf@vger.kernel.org
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings everyone,

I have been testing various BPF programs on the ARM32 architecture and
have encountered a strange error.

When trying to run a simple program that prints out the arguments of
the open syscall,
I found some strange behaviour with the pointer offsets when accessing
the arguments:
The output of llvm-objdump differed from the verifier error dump log.
Notice the differences in lines 0 and 1. Why is the bytecode being
altered at runtime?

I attached the program, the llvm-objdump result and the verifier dump below.

Best wishes,
Luka Oreskovic

BPF program
--------------------------------------------
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>

SEC("tracepoint/syscalls/sys_enter_open")
int tracepoint__syscalls__sys_enter_open(struct trace_event_raw_sys_enter* ctx)
{
        const char *arg1 = (const char *)ctx->args[0];
        int arg2 = (int)ctx->args[1];

        bpf_printk("Open arg 1: %s\n", arg1);
        bpf_printk("Open arg 2: %d\n", arg2);

        return 0;
}

char LICENSE[] SEC("license") = "GPL";


llvm-objdump of program
--------------------------------------------
Disassembly of section tracepoint/syscalls/sys_enter_open:

0000000000000000 tracepoint__syscalls__sys_enter_open:
;       int arg2 = (int)ctx->args[1];
       0:       79 16 18 00 00 00 00 00 r6 = *(u64 *)(r1 + 24)
;       const char *arg1 = (const char *)ctx->args[0];
       1:       79 13 10 00 00 00 00 00 r3 = *(u64 *)(r1 + 16)
       2:       18 01 00 00 20 31 3a 20 00 00 00 00 25 73 0a 00 r1 =
2941353058775328 ll
;       bpf_printk("Open arg 1: %s\n", arg1);
       4:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
       5:       18 07 00 00 4f 70 65 6e 00 00 00 00 20 61 72 67 r7 =
7454127125170581583 ll
       7:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
       8:       bf a1 00 00 00 00 00 00 r1 = r10
       9:       07 01 00 00 f0 ff ff ff r1 += -16
      10:       b7 02 00 00 10 00 00 00 r2 = 16
      11:       85 00 00 00 06 00 00 00 call 6
      12:       18 01 00 00 20 32 3a 20 00 00 00 00 25 64 0a 00 r1 =
2924860384358944 ll
;       bpf_printk("Open arg 2: %d\n", arg2);
      14:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 8) = r1
      15:       7b 7a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r7
      16:       bf a1 00 00 00 00 00 00 r1 = r10
      17:       07 01 00 00 f0 ff ff ff r1 += -16
      18:       b7 02 00 00 10 00 00 00 r2 = 16
      19:       bf 63 00 00 00 00 00 00 r3 = r6
      20:       85 00 00 00 06 00 00 00 call 6
;       return 0;
      21:       b7 00 00 00 00 00 00 00 r0 = 0
      22:       95 00 00 00 00 00 00 00 exit


verifier output when running program
--------------------------------------------
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
