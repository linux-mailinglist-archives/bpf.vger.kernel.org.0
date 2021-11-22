Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4E4592DB
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 17:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhKVQWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhKVQWf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 11:22:35 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F397C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 08:19:29 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 70so2179330vkx.7
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gdnNJR6wkAzwUfPnw63+/GwaZjHzbgs1CkqFwe3ACNk=;
        b=r7D4JcgSuLwJMroemOdSRmbjIxqKlFXKMXJdNShL0d1pPArLO50z10/asUvEc8G8hS
         fn4efCbt+/qH5NTbujHIlTUlg+LoFimvO1Mxagvcz8nre1KHb0OQiTgnmZg+iFpkbSv7
         o4wEAW0ZziCxtrmz9Kc1IubqdjQ6LOlnDx84DzESKEwSuwjWXqFFt1hMzTPPHdXRLAoI
         nPJ6x6B3nUYqo1hJB5urCSP6c2uaBQ1gq5OA0k8AEW0l1WYAreOA18JhZ2v/b+kQefNF
         ht7qI6PIjuK2wvwQrSMeqv/asYgKXJyfLty088tZgs85bAHYeUzVbDkfrTnYkHHh+WiP
         wvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gdnNJR6wkAzwUfPnw63+/GwaZjHzbgs1CkqFwe3ACNk=;
        b=pDBHgpyV3dvotvSN//a8yy5bx7EGGJwoan89Szy0p5dYusf6xE8jgaUypx6yKhVkzt
         a9+LYecSMoEDZiIrLzufvZH4UP1oi890y5a89Omf7aqilqPseTwqc1Jady1RzSYz5HDy
         F5N0GzuA0IQii6qpjpwwKNSAUxEsCasJ+DFHY17HX1wF+gqwaJvMa+lGbnhGWDNM5xWw
         0AjmJnAJrGfIYWHPjEWASNohDehATDoEMDhMccmMavTjXU3KoXinhF/2B1jjznS6kbKU
         fi7p8LsYcpHi+Tdm4oKmy+6G4CZQy2+RM8/IwuTsOn7HWPvcnmqwGLBN7eyZhDY27RJN
         nh9A==
X-Gm-Message-State: AOAM530wwM0Xa4jeUKYSpXWM1nE0+03JCCZ963WA+JFbawCAXhuXHH5i
        ugWxYq5BsJGbWOngTbPbCp08vsse3cWEkIw7IjWBJmU0tq2tJA==
X-Google-Smtp-Source: ABdhPJy21Rj++hBF87iQjEqtYvirWCT40k3YXfDddQb6LuLy9fSKdIzPntEhZG9RzxGa7KeWJwffqiqbOeVB0rgxOVs=
X-Received: by 2002:a1f:20c2:: with SMTP id g185mr159151870vkg.25.1637597968140;
 Mon, 22 Nov 2021 08:19:28 -0800 (PST)
MIME-Version: 1.0
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Mon, 22 Nov 2021 08:19:17 -0800
Message-ID: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
Subject: BPF CO-RE and array fields in context struct
To:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi

I've been investigating the use of BPF CO-RE. I discovered that if I
include vmlinux.h and have all structures annotated with
__attribute__((preserve_access_index)), including the context struct,
then a prog that accesses an array field in the context struct, in
some particular way, cannot pass the verifier.

A bunch of manual reduction plus creduce gives me this output:

  struct bpf_sock_ops {
    int family;
    int remote_ip6[];
  } __attribute__((preserve_access_index));
  __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
    int a = d->family;
    int *c = d->remote_ip6;
    c[2] = a;
    return 0;
  }

With Debian clang version 11.1.0-4+build1, this compiles to

  0000000000000000 <b>:
         0: b7 02 00 00 04 00 00 00 r2 = 4
         1: bf 13 00 00 00 00 00 00 r3 = r1
         2: 0f 23 00 00 00 00 00 00 r3 += r2
         3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
         4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
         5: b7 00 00 00 00 00 00 00 r0 = 0
         6: 95 00 00 00 00 00 00 00 exit

And the prog will be rejected with this verifier log:

  ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
  0: (b7) r2 = 32
  1: (bf) r3 = r1
  2: (0f) r3 += r2
  last_idx 2 first_idx 0
  regs=4 stack=0 before 1: (bf) r3 = r1
  regs=4 stack=0 before 0: (b7) r2 = 32
  ; int a = d->family;
  3: (61) r1 = *(u32 *)(r1 +20)
  ; c[2] = a;
  4: (63) *(u32 *)(r3 +8) = r1
  dereference of modified ctx ptr R3 off=32 disallowed
  processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0

Looking at check_ctx_reg() and its callsite at check_mem_access() in
verifier.c, it seems that the verifier really does not like when the
context pointer has an offset, in this case the field offset of
d->remote_ip6.

I thought this is just an issue with array fields, that field offset
relocations may have trouble expressing two field accesses (one struct
member, one array memory). However, further testing reveals that this
is not the case, because if I simplify out the local variables, the
error is gone:

  struct bpf_sock_ops {
    int family;
    int remote_ip6[];
  } __attribute__((preserve_access_index));
  __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
    d->remote_ip6[2] = d->family;
    return 0;
  }

is compiled to:

  0000000000000000 <b>:
         0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
         1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
         2: b7 00 00 00 00 00 00 00 r0 = 0
         3: 95 00 00 00 00 00 00 00 exit

and is loaded as:

  ; d->remote_ip6[2] = d->family;
  0: (61) r2 = *(u32 *)(r1 +20)
  ; d->remote_ip6[2] = d->family;
  1: (63) *(u32 *)(r1 +40) = r2
  invalid bpf_context access off=40 size=4

I believe this error is because d->remote_ip6 is read-only, that this
modification might be more of a product of creduce, but we can see
that the CO-RE adjected offset of the array element from the context
pointer is correct: 32 to remote_ip6, 8 array index, so total offset
is 40.

Also note that removal of __attribute__((preserve_access_index)) from
the first (miscompiled) program produces exactly the same bytecode as
this new program (with no locals).

What is going on here? Why does the access of an array in context in
this particular way cause it to generate code that would not pass the
verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
strict?

Thanks
YiFei Zhu
