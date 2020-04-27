Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715DC1BAAA3
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgD0RDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgD0RDJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 13:03:09 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DCC0610D5
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 10:03:09 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id 190so4004755ooa.12
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=HiZl5G3VmONOomE4jiMJAeFsROdWyl23ZYyRpXb2SrY=;
        b=RCzcnrDJ30wYwG/locjoWI5wGZXjQEaOvSl6GLP1IfSQLoYmTtqnl+TG0E9P66wctb
         jyW+pMhnBV/f959tDgOD0zDSuHJWqACyT5BNqD6r+lpOfB6+2thO5e7T+yJpz0SOHupB
         YDHvidivj7BHUcuF9+cMn2Ur4uL0JZn+RdG98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HiZl5G3VmONOomE4jiMJAeFsROdWyl23ZYyRpXb2SrY=;
        b=H20pUpIuznfRgdch7GUTGmi2HBFbU2Lgkh7Ba0iNNGdjRONHwCSffbLHl/PohNymKS
         g8VQwsQVknITVqrRKjWsd4QQmA4YIo7g4OT7JrREVqsqnRuOHq2WOEUtC6GxZa41SHYJ
         QwKZxTJz5nkMy4A+Z9AZPlI3YDP+xIVdYiSZCHCW7eflyYUbup1vJwMPaSV5OBP3A31L
         rbpmhEJ26YxqA08GlOdLw0shLUt8eMxuH2vJI/DuTcRzaIqh4gXSTrxRThNVfm9geWgi
         BJN85Vh+jpbMmeSGuwkkHb8w3dDPWfGr1I4BoyV3x+6oxJ7hW+QNnZt+8ZU51C+nwQPd
         6KFQ==
X-Gm-Message-State: AGi0PubV/8bEk5Bh4MReUhS6DdPKVNwaQKC8PkvrESYWzT9r0iPSgwbp
        x86g+Q9u0fno9j+28rY7IELU+yHkOAEVLmma7iHLcMabOa9UOg==
X-Google-Smtp-Source: APiQypLwvKuY9XBTT0XpW0e0WPcZVymFDUSwVuQLmf9qNx+d9Lb8PnaSuDvAm/XfJF5F/eQbn1aEDw9Qp0vG4clu/+o=
X-Received: by 2002:a4a:a54a:: with SMTP id s10mr20009582oom.73.1588006988404;
 Mon, 27 Apr 2020 10:03:08 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 27 Apr 2020 18:02:56 +0100
Message-ID: <CACAyw98u-tGR_cZYT5paGhXRneU5pfrGdxJx+ktZYNKFVBstUg@mail.gmail.com>
Subject: Suspicious RCU usage in bpf_ipv4_fib_lookup
To:     bpf <bpf@vger.kernel.org>, David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm using BPF_PROG_TEST_RUN to evaluate a BPF program which calls
bpf_fib_lookup.
While single-stepping through the function in gdb I got the following
splat from the guest kernel:

[  137.718925] =============================
[  137.721403] WARNING: suspicious RCU usage
[  137.723520] 5.7.0-rc2+ #82 Not tainted
[  137.725429] -----------------------------
[  137.727502] include/net/neighbour.h:289 suspicious
rcu_dereference_check() usage!
[  137.731669]
[  137.731669] other info that might help us debug this:
[  137.731669]
[  137.735401]
[  137.735401] rcu_scheduler_active = 2, debug_locks = 1
[  137.737700] 1 lock held by redirect.test/2805:
[  137.739221]  #0: ffffffff8267a560 (rcu_read_lock){....}-{1:2}, at:
bpf_test_run+0x71/0x470
[  137.741792]
[  137.741792] stack backtrace:
[  137.742992] CPU: 4 PID: 2805 Comm: redirect.test Not tainted 5.7.0-rc2+ #82
[  137.744930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  137.746829] Call Trace:
[  137.747271]  dump_stack+0x71/0xa0
[  137.747838]  bpf_ipv4_fib_lookup+0x62a/0x900
[  137.748545]  bpf_skb_fib_lookup+0x66/0xa0
[  137.749209]  bpf_prog_09b9e47ddc527c6a_F+0x76/0x72c
[  137.750046]  bpf_prog_a77b2b61316c22d2_F+0x13e4/0x1df4
[  137.750859]  ? lock_acquire+0xa0/0x360
[  137.751406]  ? bpf_test_run+0xc0/0x470
[  137.751935]  ? ktime_get+0xd2/0xf0
[  137.752438]  ? kvm_clock_get_cycles+0x14/0x20
[  137.753348]  ? ktime_get+0x7a/0xf0
[  137.754413]  bpf_test_run+0x175/0x470
[  137.755645]  ? kmem_cache_alloc+0x276/0x2a0
[  137.756672]  bpf_prog_test_run_skb+0x315/0x520
[  137.757617]  __do_sys_bpf+0x8f7/0x1d40
[  137.758440]  do_syscall_64+0x4b/0x1e0
[  137.759233]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  137.760380] RIP: 0033:0x4b4f6b
[  137.761057] Code: ff e9 69 ff ff ff cc cc cc cc cc cc cc cc cc e8
2b aa f8 ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24
08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44
24 30
[  137.765025] RSP: 002b:000000c000129b50 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[  137.766594] RAX: ffffffffffffffda RBX: 000000c000040000 RCX: 00000000004b4f6b
[  137.767661] RDX: 0000000000000028 RSI: 000000c000129c10 RDI: 000000000000000a
[  137.768718] RBP: 000000c000129b98 R08: 00000000009d5501 R09: 0000000000000001
[  137.769749] R10: 000000c0002d0480 R11: 0000000000000206 R12: ffffffffffffffff
[  137.770806] R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000015

This happens on today's bpf-next. There is a comment in bpf_ipv4_fib_lookup:

    /* xdp and cls_bpf programs are run in RCU-bh so
    * rcu_read_lock_bh is not needed here
    */

Maybe this is not the case for BPF_PROG_TEST_RUN?

Best
Lorenz
-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
