Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356B245AD27
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 21:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbhKWURt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 15:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbhKWURs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 15:17:48 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B94C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 12:14:40 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id l24so362366uak.2
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 12:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoNIPqXg61N617kqWxfc5JhXuUg+q4V7i0FtwAKemk4=;
        b=kofzFbJmFh5xIjxHGgVFhlO5FAUxvqpK0ffaEryOpGmwJzy3UP6GU6DuORqq7j/OIF
         OwrJGEHK/BTqCpThFTitH5lXKV6GIjPjWuJ9eZFas3BpfqqwJEDFJwuQwQLf2t+KbzGj
         dkuw25Yidb/04Zp1ioCPP1wMPWjVj9/Oeyw98tmlhaAmIyZGlbAGb8gB78dx20HY24uL
         eo6dK1hDkplc/sK1bFEagv4eOCus4hMfzFMVpbn9I6yZcTxK+9tySVIp5rwivZ4pgp9X
         C941PkBz8naeKYSkFEp2GnDRPJb6RGZq2LGA51sZfqlXqInZfz3dWyZDadr+prQb9MeI
         Ybvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoNIPqXg61N617kqWxfc5JhXuUg+q4V7i0FtwAKemk4=;
        b=I7A4x89VkmWC7McyF4crINPaVD27UEypv+zIr2uLD63tfFuiwApTNPEa4kI9nKkmxk
         TpT2nM0D5xPELX84QvD8xlhn8tS6jhgEk9T8YB1aQkYQb1NP1RtMdnvvYfAXhJDjA1jK
         CZdx7IpeXuQwcL4A5vWLyZxIUUvsAUpDoLg7lYTi269uKZ+d/pfVz3cJeDI0fCESAQ42
         edT4kiijo+FL4MI/cjsGd+4dwIGX0L4jRfcBM4qhwlwyuh7ynPxGPcryPM8EVqJzy/wC
         cURNyrEGhqZZCtHbtGCf+cDGwZ/RohxL41LxI9YyvmL7kJkdoKdMk7GU/9uR8RyyYVv3
         iZLw==
X-Gm-Message-State: AOAM530TTQOQ5WmTy2y471dkDr+8dHAo9MTPuK7l9ZEUq5oZwLHr3LZC
        tRuQ0NUT6qo8WSwWM7tOziUsev16qmzy0PGGF/DIQ5TEOlA=
X-Google-Smtp-Source: ABdhPJytp3KNei97Wm/AiPpsFFkc3pGjCUR0Y8jqVdPHSzEJO710EjWQ5CRc3im6s/8ozDcrerVF+EawwGbUn5+3ybQ=
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr13349226vsq.44.1637698479168;
 Tue, 23 Nov 2021 12:14:39 -0800 (PST)
MIME-Version: 1.0
References: <CAA-VZPniKnO4ZkYztkt0uL0s5TdKuwTRvoz5KORJg+MY-bVcHw@mail.gmail.com>
 <CAA-VZPmxh8o8EBcJ=m-DH4ytcxDFmo0JKsm1p1gf40kS0CE3NQ@mail.gmail.com>
 <c3c0922e-28b3-ff6d-3877-4fe869776004@fb.com> <CAA-VZP=JK21mEObrWNWkb=Q-3oKrQMPfVbtA2LpeHDkJVysvsA@mail.gmail.com>
 <8ea7650f-e863-2648-cc3e-254ee9f6c0ae@fb.com>
In-Reply-To: <8ea7650f-e863-2648-cc3e-254ee9f6c0ae@fb.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Tue, 23 Nov 2021 12:14:28 -0800
Message-ID: <CAA-VZPnSQTHf-PERo-=-Zzw9tcwiduRUm=t_On_xoSDOWXVSjw@mail.gmail.com>
Subject: Re: BPF CO-RE and array fields in context struct
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 12:08 PM Yonghong Song <yhs@fb.com> wrote:
> On 11/23/21 8:15 AM, YiFei Zhu wrote:
> > On Mon, Nov 22, 2021 at 4:24 PM Yonghong Song <yhs@fb.com> wrote:
> >> On 11/22/21 12:44 PM, YiFei Zhu wrote:
> >>> On Mon, Nov 22, 2021 at 8:19 AM YiFei Zhu <zhuyifei@google.com> wrote:
> >>>>
> >>>> Hi
> >>>>
> >>>> I've been investigating the use of BPF CO-RE. I discovered that if I
> >>>> include vmlinux.h and have all structures annotated with
> >>>> __attribute__((preserve_access_index)), including the context struct,
> >>>> then a prog that accesses an array field in the context struct, in
> >>>> some particular way, cannot pass the verifier.
> >>>>
> >>>> A bunch of manual reduction plus creduce gives me this output:
> >>>>
> >>>>     struct bpf_sock_ops {
> >>>>       int family;
> >>>>       int remote_ip6[];
> >>>>     } __attribute__((preserve_access_index));
> >>>>     __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
> >>>>       int a = d->family;
> >>>>       int *c = d->remote_ip6;
> >>>>       c[2] = a;
> >>>>       return 0;
> >>>>     }
> >>>>
> >>>> With Debian clang version 11.1.0-4+build1, this compiles to
> >>>>
> >>>>     0000000000000000 <b>:
> >>>>            0: b7 02 00 00 04 00 00 00 r2 = 4
> >>>>            1: bf 13 00 00 00 00 00 00 r3 = r1
> >>>>            2: 0f 23 00 00 00 00 00 00 r3 += r2
> >>>>            3: 61 11 00 00 00 00 00 00 r1 = *(u32 *)(r1 + 0)
> >>>>            4: 63 13 08 00 00 00 00 00 *(u32 *)(r3 + 8) = r1
> >>>>            5: b7 00 00 00 00 00 00 00 r0 = 0
> >>>>            6: 95 00 00 00 00 00 00 00 exit
> >>>>
> >>>> And the prog will be rejected with this verifier log:
> >>>>
> >>>>     ; __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
> >>>>     0: (b7) r2 = 32
> >>>>     1: (bf) r3 = r1
> >>>>     2: (0f) r3 += r2
> >>>>     last_idx 2 first_idx 0
> >>>>     regs=4 stack=0 before 1: (bf) r3 = r1
> >>>>     regs=4 stack=0 before 0: (b7) r2 = 32
> >>>>     ; int a = d->family;
> >>>>     3: (61) r1 = *(u32 *)(r1 +20)
> >>>>     ; c[2] = a;
> >>>>     4: (63) *(u32 *)(r3 +8) = r1
> >>>>     dereference of modified ctx ptr R3 off=32 disallowed
> >>>>     processed 5 insns (limit 1000000) max_states_per_insn 0 total_states
> >>>> 0 peak_states 0 mark_read 0
> >>>>
> >>>> Looking at check_ctx_reg() and its callsite at check_mem_access() in
> >>>> verifier.c, it seems that the verifier really does not like when the
> >>>> context pointer has an offset, in this case the field offset of
> >>>> d->remote_ip6.
> >>>>
> >>>> I thought this is just an issue with array fields, that field offset
> >>>> relocations may have trouble expressing two field accesses (one struct
> >>>> member, one array memory). However, further testing reveals that this
> >>>> is not the case, because if I simplify out the local variables, the
> >>>> error is gone:
> >>>>
> >>>>     struct bpf_sock_ops {
> >>>>       int family;
> >>>>       int remote_ip6[];
> >>>>     } __attribute__((preserve_access_index));
> >>>>     __attribute__((section("sockops"))) int b(struct bpf_sock_ops *d) {
> >>>>       d->remote_ip6[2] = d->family;
> >>>>       return 0;
> >>>>     }
> >>>>
> >>>> is compiled to:
> >>>>
> >>>>     0000000000000000 <b>:
> >>>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
> >>>>            1: 63 21 0c 00 00 00 00 00 *(u32 *)(r1 + 12) = r2
> >>>>            2: b7 00 00 00 00 00 00 00 r0 = 0
> >>>>            3: 95 00 00 00 00 00 00 00 exit
> >>>>
> >>>> and is loaded as:
> >>>>
> >>>>     ; d->remote_ip6[2] = d->family;
> >>>>     0: (61) r2 = *(u32 *)(r1 +20)
> >>>>     ; d->remote_ip6[2] = d->family;
> >>>>     1: (63) *(u32 *)(r1 +40) = r2
> >>>>     invalid bpf_context access off=40 size=4
> >>>>
> >>>> I believe this error is because d->remote_ip6 is read-only, that this
> >>>> modification might be more of a product of creduce, but we can see
> >>>> that the CO-RE adjected offset of the array element from the context
> >>>> pointer is correct: 32 to remote_ip6, 8 array index, so total offset
> >>>> is 40.
> >>>>
> >>>> Also note that removal of __attribute__((preserve_access_index)) from
> >>>> the first (miscompiled) program produces exactly the same bytecode as
> >>>> this new program (with no locals).
> >>>>
> >>>> What is going on here? Why does the access of an array in context in
> >>>> this particular way cause it to generate code that would not pass the
> >>>> verifier? Is it a bug in Clang/LLVM, or is it the verifier being too
> >>>> strict?
> >>>
> >>> Additionally, testing the latest LLVM main branch, this test case,
> >>> which does not touch array fields at all, fails but succeeded with
> >>> clang version 11.1.0:
> >>>
> >>>     struct bpf_sock_ops {
> >>>       int op;
> >>>       int bpf_sock_ops_cb_flags;
> >>>     } __attribute__((preserve_access_index));
> >>>     enum { a, b } static (*c)() = (void *)9;
> >>>     enum d { e } f;
> >>>     enum d g;
> >>>     __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
> >>>       switch (i->op) {
> >>>       case a:
> >>>         f = g = c(i, i->bpf_sock_ops_cb_flags);
> >>>         break;
> >>>       case b:
> >>>         f = g = c(i, i->bpf_sock_ops_cb_flags);
> >>>       }
> >>>       return 0;
> >>>     }
> >>
> >> This is another issue which actually appears (even in bpf mailing list)
> >> multiple times.
> >>
> >> The following change should fix the issue:
> >>
> >>    $ diff t1.c t1-good.c
> >> --- t1.c        2021-11-22 16:00:13.915921544 -0800
> >> +++ t1-good.c   2021-11-22 16:12:32.823710102 -0800
> >> @@ -5,13 +5,14 @@
> >>      enum { a, b } static (*c)() = (void *)9;
> >>      enum d { e } f;
> >>      enum d g;
> >> +  #define __barrier asm volatile("" ::: "memory")
> >>      __attribute__((section("sockops"))) int h(struct bpf_sock_ops *i) {
> >>        switch (i->op) {
> >>        case a:
> >> -      f = g = c(i, i->bpf_sock_ops_cb_flags);
> >> +      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
> >>          break;
> >>        case b:
> >> -      f = g = c(i, i->bpf_sock_ops_cb_flags);
> >> +      f = g = c(i, i->bpf_sock_ops_cb_flags); __barrier;
> >>        }
> >>        return 0;
> >>      }
> >>
> >> Basically add a compiler barrier at the end of case statements
> >> to prevent common code sinking.
> >>
> >> In the above case, for the original code, latest compiler did an
> >> optimization like
> >>        case a:
> >>            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
> >>        case b:
> >>            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
> >>      common:
> >>        val = load r1, tmp
> >>        ...
> >>
> >> Note that reloc_offset is not sinked to the common code
> >> due to its special internal representation.
> >>
> >> To avoid such a code generation, add compiler barrier to
> >> the end of case statement to prevent load sinking in which case
> >> we will have
> >>       val = load r1, reloc_offset(...)
> >> and verifier will be happy about this.
> >>
> >> The commit you listed below had a big change which may enable
> >> the above compiler optimization and llvm11 may just not do
> >> the code sinking optimization in this particular instance.
> >>
> >> I guess the compiler could still enforce this. But since it does
> >> not know whether the memory access is for context or not, doing
> >> so might hurt performance. But any way, this has appeared multiple
> >> times internally and also in the mailing list. We will take a further
> >> look.
> >
> > I see, thanks for the explanations. What is interesting is that prior
> > to that commit reloc_offset(i->bpf_sock_ops_cb_flags) is generated
> > only once. The disassembly matches that of
> >      case a:
> >      case b:
> >            tmp = reloc_offset(i->bpf_sock_ops_cb_flags);
> >            val = load r1, tmp
> >
> > Whereas with the compiler barriers, both compilers generate (no common code):
> >
> >    0000000000000000 <h>:
> >           0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
> >           1: 15 02 0a 00 01 00 00 00 if r2 == 1 goto +10 <LBB0_3>
> >           2: 55 02 11 00 00 00 00 00 if r2 != 0 goto +17 <LBB0_4>
> >           3: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
> >           4: 85 00 00 00 09 00 00 00 call 9
> >           5: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >           7: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >           8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >          10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >          11: 05 00 08 00 00 00 00 00 goto +8 <LBB0_4>
> >
> >    0000000000000060 <LBB0_3>:
> >          12: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
> >          13: 85 00 00 00 09 00 00 00 call 9
> >          14: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >          16: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >          17: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >          19: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >
> >    00000000000000a0 <LBB0_4>:
> >          20: b7 00 00 00 00 00 00 00 r0 = 0
> >          21: 95 00 00 00 00 00 00 00 exit
> >
> > Did the linked commit create the special internal representation so
> > that they cannot be common code sinked, or is there some other issue
> > going on, or am I misunderstanding something?
>
> Yes, the linked commit added a special builtin with additional
> ever-increasing argument to prevent reloc_offset from sinking.
> This is to ensure the relocation related codes won't be separated into
> different basic blocks. But this won't be able to prevent the issue
> you described in the above.

Ah. I see. Thanks for the explanations. Looking forward to see the fixes!

YiFei Zhu

> > Thanks
> > YiFei Zhu
> >>> The bad code generation of latest LLVM:
> >>>
> >>>     0000000000000000 <h>:
> >>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
> >>>            1: 15 02 01 00 01 00 00 00 if r2 == 1 goto +1 <LBB0_2>
> >>>            2: 55 02 0b 00 00 00 00 00 if r2 != 0 goto +11 <LBB0_3>
> >>>
> >>>     0000000000000018 <LBB0_2>:
> >>>            3: b7 03 00 00 04 00 00 00 r3 = 4
> >>>            4: bf 12 00 00 00 00 00 00 r2 = r1
> >>>            5: 0f 32 00 00 00 00 00 00 r2 += r3
> >>>            6: 61 22 00 00 00 00 00 00 r2 = *(u32 *)(r2 + 0)
> >>>            7: 85 00 00 00 09 00 00 00 call 9
> >>>            8: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >>>           10: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >>>           11: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >>>           13: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >>>
> >>>     0000000000000070 <LBB0_3>:
> >>>           14: b7 00 00 00 00 00 00 00 r0 = 0
> >>>           15: 95 00 00 00 00 00 00 00 exit
> >>>
> >>> The good code generation of LLVM 11.1.0:
> >>>
> >>>     0000000000000000 <h>:
> >>>            0: 61 12 00 00 00 00 00 00 r2 = *(u32 *)(r1 + 0)
> >>>            1: 25 02 08 00 01 00 00 00 if r2 > 1 goto +8 <LBB0_2>
> >>>            2: 61 12 04 00 00 00 00 00 r2 = *(u32 *)(r1 + 4)
> >>>            3: 85 00 00 00 09 00 00 00 call 9
> >>>            4: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >>>            6: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >>>            7: 18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
> >>>            9: 63 01 00 00 00 00 00 00 *(u32 *)(r1 + 0) = r0
> >>>
> >>>     0000000000000050 <LBB0_2>:
> >>>           10: b7 00 00 00 00 00 00 00 r0 = 0
> >>>           11: 95 00 00 00 00 00 00 00 exit
> >>>
> >>> A bisect points me to this commit in LLVM as the first bad commit:
> >>>
> >>>     commit 54d9f743c8b0f501288119123cf1828bf7ade69c
> >>>     Author: Yonghong Song <yhs@fb.com>
> >>>     Date:   Wed Sep 2 22:56:41 2020 -0700
> >>>
> >>>         BPF: move AbstractMemberAccess and PreserveDIType passes to
> >>> EP_EarlyAsPossible
> >>>
> >>>         Move abstractMemberAccess and PreserveDIType passes as early as
> >>>         possible, right after clang code generation.
> >>>
> >>>     [...]
> >>>
> >>>         Differential Revision: https://reviews.llvm.org/D87153
> >>>
> >>> YiFei Zhu
> >>>
