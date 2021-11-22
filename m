Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DC45963D
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhKVUsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 15:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhKVUsR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 15:48:17 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86442C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 12:45:10 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id i6so39216198uae.6
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVNTwYdTaxFdelO7hHQn2otoY9+vKkoh5SU5k0/6yFg=;
        b=FNoMNXh9WDDnleGK/WqQ3msa8Dqa6QNZu7CYUORI7kSRbDrAcHjCCnQcMjCk6NC7Pd
         p0VFJQBo3D9MV9tozh7vl3kYpQ0NMRL4e1e6agR+eEvyXSzY5cviXhA4bQwjrtrGp306
         Wn80I9Lv0heEEkbzbwNV61NgD48DMbY4IoqqU1RkxaAWivW125aP5uam+rOYRQLApj/K
         7zYHSKcvJAvLHw4QvIdEyA2jA/UD1q8ZJmulLtnfPN4YS102AjN7l9B4A091thE8gylH
         7Cv2TCfOccrf5rnD6gCUR6DYa8ClEpGW0g38ezA3JZoyR6f9AMPHKGqT/7jqrYwr4qRc
         crxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVNTwYdTaxFdelO7hHQn2otoY9+vKkoh5SU5k0/6yFg=;
        b=pse2/uP2ESRBl6s1gb19MObx5UXTZGu/K8hpVswkGW/IMBVepWfg6h2Hcg4NhIr7/l
         XHeN3aatwObok20/fZUYF7xkZl/sBAfKc4ShMkoF0rU+6xZ4hKpvpLbmNRtVLq6FnE24
         9FLUtcNOb9C3QghBwZ4n6IrvioWjDzL+EaIKkzddshXuXaF2icnyMf6fUW1tisNWa1Dm
         +x/63tW4NI9dqX+K9mcxJvn2buKrX3xaT7fDyOkQknSAnZig/fCGrUyYHe9rX3dpf6sA
         a3mYVYidZbYyWwjw8KfwLw5msIKL3M9o5GElJVcXOGMG9wUZ2xLMeDQ7I3GNw1ptrstX
         nT4Q==
X-Gm-Message-State: AOAM5309wbEMeXNlWFR6nY0ketVrL7E7NJq9RMG/9BPHiIYmR6/nrk6M
        0rsJfg11FG8RX2Tk4S4Y1474PEr65Py4lUmlNr00wVCsBEHSEQ==
X-Google-Smtp-Source: ABdhPJzpHYS9CnNy5E/jpNHaBNfyoa0RorfEbyBZhTeLB9M3Q3wETdTv7aEdkp0yBPttxcVEG1ltxbDHVWJ9VUGWt68=
X-Received: by 2002:ab0:6354:: with SMTP id f20mr89526626uap.116.1637613909381;
 Mon, 22 Nov 2021 12:45:09 -0800 (PST)
MIME-Version: 1.0
References: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
In-Reply-To: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Mon, 22 Nov 2021 12:44:58 -0800
Message-ID: <CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com>
Subject: Re: BPF CO-RE and array fields in context struct
To:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 8:19 AM YiFei Zhu <zhuyifei@google.com> wrote:
>
> Hi
>
> I've been investigating the use of BPF CO-RE. I discovered that if I
> include vmlinux.h and have all structures annotated with
> __attribute__((preserve_access_index)), including the context struct,
> then a prog that accesses an array field in the context struct, in
> some particular way, cannot pass the verifier.
>
> A bunch of manual reduction plus creduce gives me this output:
>
>   struct bpf_sock_ops {
>     int family;
>     int remote_ip6[];
>   } __attribute__((preserve_access_index));
>   __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>     int a = d->family;
>     int *c = d->remote_ip6;
>     c[2] = a;
>     return 0;
>   }
>
> With Debian clang version 11.1.0-4+build1, this compiles to
>
>   0000000000000000 <b>:
>          0: b7 02 00 00 04 00 00 00 r2 = 4
>          1: bf 13 00 00 00 00 00 00 r3 = r1
>          2: 0f 23 00 00 00 00 00 00 r3 += r2
>          3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
>          4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
>          5: b7 00 00 00 00 00 00 00 r0 = 0
>          6: 95 00 00 00 00 00 00 00 exit
>
> And the prog will be rejected with this verifier log:
>
>   ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>   0: (b7) r2 = 32
>   1: (bf) r3 = r1
>   2: (0f) r3 += r2
>   last_idx 2 first_idx 0
>   regs=4 stack=0 before 1: (bf) r3 = r1
>   regs=4 stack=0 before 0: (b7) r2 = 32
>   ; int a = d->family;
>   3: (61) r1 = *(u32 *)(r1 +20)
>   ; c[2] = a;
>   4: (63) *(u32 *)(r3 +8) = r1
>   dereference of modified ctx ptr R3 off=32 disallowed
>   processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 mark_read 0
>
> Looking at check_ctx_reg() and its callsite at check_mem_access() in
> verifier.c, it seems that the verifier really does not like when the
> context pointer has an offset, in this case the field offset of
> d->remote_ip6.
>
> I thought this is just an issue with array fields, that field offset
> relocations may have trouble expressing two field accesses (one struct
> member, one array memory). However, further testing reveals that this
> is not the case, because if I simplify out the local variables, the
> error is gone:
>
>   struct bpf_sock_ops {
>     int family;
>     int remote_ip6[];
>   } __attribute__((preserve_access_index));
>   __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
>     d->remote_ip6[2] = d->family;
>     return 0;
>   }
>
> is compiled to:
>
>   0000000000000000 <b>:
>          0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
>          1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
>          2: b7 00 00 00 00 00 00 00 r0 = 0
>          3: 95 00 00 00 00 00 00 00 exit
>
> and is loaded as:
>
>   ; d->remote_ip6[2] = d->family;
>   0: (61) r2 = *(u32 *)(r1 +20)
>   ; d->remote_ip6[2] = d->family;
>   1: (63) *(u32 *)(r1 +40) = r2
>   invalid bpf_context access off=40 size=4
>
> I believe this error is because d->remote_ip6 is read-only, that this
> modification might be more of a product of creduce, but we can see
> that the CO-RE adjected offset of the array element from the context
> pointer is correct: 32 to remote_ip6, 8 array index, so total offset
> is 40.
>
> Also note that removal of __attribute__((preserve_access_index)) from
> the first (miscompiled) program produces exactly the same bytecode as
> this new program (with no locals).
>
> What is going on here? Why does the access of an array in context in
> this particular way cause it to generate code that would not pass the
> verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
> strict?

Additionally, testing the latest LLVM main branch, this test case,
which does not touch array fields at all, fails but succeeded with
clang version 11.1.0:

  struct bpf_sock_ops {
    int op;
    int bpf_sock_ops_cb_flags;
  } __attribute__((preserve_access_index));
  enum { a, b } static (*c)() = (void *)9;
  enum d { e } f;
  enum d g;
  __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
    switch (i->op) {
    case a:
      f = g = c(i, i->bpf_sock_ops_cb_flags);
      break;
    case b:
      f = g = c(i, i->bpf_sock_ops_cb_flags);
    }
    return 0;
  }

The bad code generation of latest LLVM:

  0000000000000000 <h>:
         0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
         1: 15 02 01 00 01 00 00 00 if r2 == 1 goto +1 <LBB0_2>
         2: 55 02 0b 00 00 00 00 00 if r2 != 0 goto +11 <LBB0_3>

  0000000000000018 <LBB0_2>:
         3: b7 03 00 00 04 00 00 00 r3 = 4
         4: bf 12 00 00 00 00 00 00 r2 = r1
         5: 0f 32 00 00 00 00 00 00 r2 += r3
         6: 61 22 00 00 00 00 00 00 r2 = *(u32 *)(r2 + 0)
         7: 85 00 00 00 09 00 00 00 call 9
         8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
        10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
        11: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
        13: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0

  0000000000000070 <LBB0_3>:
        14: b7 00 00 00 00 00 00 00 r0 = 0
        15: 95 00 00 00 00 00 00 00 exit

The good code generation of LLVM 11.1.0:

  0000000000000000 <h>:
         0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
         1: 25 02 08 00 01 00 00 00 if r2 > 1 goto +8 <LBB0_2>
         2: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
         3: 85 00 00 00 09 00 00 00 call 9
         4: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
         6: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
         7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
         9: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0

  0000000000000050 <LBB0_2>:
        10: b7 00 00 00 00 00 00 00 r0 = 0
        11: 95 00 00 00 00 00 00 00 exit

A bisect points me to this commit in LLVM as the first bad commit:

  commit 54d9f743c8b0f501288119123cf1828bf7ade69c
  Author: Yonghong Song <yhs@fb.com>
  Date:   Wed Sep 2 22:56:41 2020 -0700

      BPF: move AbstractMemberAccess and PreserveDIType passes to
EP_EarlyAsPossible

      Move abstractMemberAccess and PreserveDIType passes as early as
      possible, right after clang code generation.

  [...]

      Differential Revision: https://reviews.llvm.org/D87153

YiFei Zhu
