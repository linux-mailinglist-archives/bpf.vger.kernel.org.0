Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4645AB30
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhKWSWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKWSWy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 13:22:54 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53CC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:19:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v7so92211ybq.0
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBfKxrGQeJXS9J/dE4N41R9gdbfSYdgG2ZNjCxdXLJU=;
        b=qD1G+14sbPSO0aQZyo8pmhfHKVt6glta2XSxXVLQsOoN/HgC7bEw54D0F98/SQo8kD
         lq1MNLznq+Wryg2tRchQdkVKUuDXAkMBeY5rs8EO1JCe3z/bzGY194sdQugMtXpRmkZs
         HPbWlizXBiQhzSH73Y6EOzr2rYpnSUpT8baPqCeqviMGVn32JoGGc7LkrP+Wvb+Wf81l
         BhcndxaWrVBij1IX2/rUK9bR+fCkPr4Ur/QTWIR2wLo7LoKgbZQKaoMHxQO7fKQajJcy
         5sA825chsMvaaFCWjydPt5J29r7JYjqVel5hwhTBusTLbzPZ9bd5jrulF+2+iC6hGhAL
         5JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBfKxrGQeJXS9J/dE4N41R9gdbfSYdgG2ZNjCxdXLJU=;
        b=kap0iCLVT5DYpWa9PszJpTvUB2F+ddc9266FgZRN9yxwIttWwtV7bDTKS+BHaM/kEt
         +kXe46cOPg2KzO5uR9sgyxr1ET00Ru4j0jC+iJpCdhbUnJNNjdWJJw1bMIP4oZBdczRB
         6rbmYFkgfH3cteeDJGLMuYdg/jn7ib65mSkQ2LoByFFCwOTIbsRK2YV8HIkB7r2jSvN8
         gnyi+Tpg/lCKC9ytsJ3VY7SMQXwOB5+8VKBWdSOLd+1E/T/u3GCrieuIsKO2IVtntflO
         5N2mzOB+NbzvaDqxqdKA0TlpaUFTTkYzsKz+UijlnoEQ+0547HKVIDeodRsrVMOKcv9v
         LavQ==
X-Gm-Message-State: AOAM5305vsNh+aJR+McMIS2HiBULcbbi8Xcg5Th8SjKLiH74Fd5UBnaB
        ebY+7lnaVgr7tBcfleUXS0gdcr5mOqxvAIuMth4=
X-Google-Smtp-Source: ABdhPJzgy3nB9e19jsNp4vBwQpd/NtA8g/GxDAg2HEihTSV4gSG4Ua/mvKueZT3zxKKbF0qV4cDkN8acvQ9wdE1gd60=
X-Received: by 2002:a25:d16:: with SMTP id 22mr8421600ybn.51.1637691585620;
 Tue, 23 Nov 2021 10:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
 <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
 <CAADnVQLZASm0tUfLALeLmZbdmfUZq4umRpRDBT06a1cF1aJWhg@mail.gmail.com>
 <CAEf4BzYb6Cb5-g77rX6Unz29EYwRCHbGgaGJWZnpp2vhh8Z56g@mail.gmail.com> <CAADnVQ+-2=8-zd7dOrHbceke26repHC7_xgbf3cKGSmVHMi3vA@mail.gmail.com>
In-Reply-To: <CAADnVQ+-2=8-zd7dOrHbceke26repHC7_xgbf3cKGSmVHMi3vA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Nov 2021 10:19:34 -0800
Message-ID: <CAEf4BzbLRBCToDzztAFTBQ66p_uYKyc8zKN_2MXXCYq_+MN=kg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 9:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 7:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 7:15 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 5:44 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > >
> > > > > > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > > > > > a possible candidate.
> > > > > > > Then wire the result into bpf_core_apply_relo_insn().
> > > > > > >
> > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > ---
> > > > > > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > > > > > >                    int relo_idx, void *insn)
> > > > > > >  {
> > > > > > > -       return -EOPNOTSUPP;
> > > > > > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > > > > > +               struct bpf_core_cand_list *cands;
> > > > > > > +
> > > > > > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> > > > > >
> > > > > > this is wrong for many reasons:
> > > > > >
> > > > > > 1. you will overwrite previous ctx->cands, if it was already set,
> > > > > > which leaks memory
> > > > > > 2. this list of candidates should be keyed by relo->type_id ("root
> > > > > > type"). Different root types get their own independent lists; so it
> > > > > > has to be some sort of look up table from type_id to a list of
> > > > > > candidates.
> > > > > >
> > > > > > 2) means that if you had a bunch of relos against struct task_struct,
> > > > > > you'll crate a list of candidates when processing first relo that
> > > > > > starts at task_struct. All the subsequent relos that have task_struct
> > > > > > as root type will re-used that list and potentially trim it down. If
> > > > > > there are some other relos against, say, struct mm_struct, they will
> > > > > > have their independent list of candidates.
> > > > >
> > > > > right.
> > > > > Your prior comment confused me. I didn't do this reuse of cands
> > > > > to avoid introducing hashtable here like libbpf does,
> > > > > since it does too little to actually help.
> > > >
> > > > Since when avoiding millions of iterations for each relocation is "too
> > > > little help"?
> > >
> > > because it is a premature optimization for a case that
> > > may or may not be relevant.
> > > If 180 sk_buff relocations somehow makes the loading too slow
> > > 180 relocations of 180 different types would produce exactly
> > > the same slow down and hashtable cache won't help.
> >
> > Likelihood of using 180 different root types in real application is
> > very small. Using 180 relocations (either with explicit BPF_CORE_READ,
> > field accesses in fentry, or just through always_inline helpers doing
> > either and being inlined in multiple places) is very real in
> > real-world non-trivial applications. And the cost of optimizing that
> > in the kernel later is very high, you'll be waiting for a new kernel
> > release to get everywhere to rely on this optimization. The cost of
> > further optimizing this in libbpf is much smaller (and libbpf still
> > did the optimization from the get go and I stand by that decision).
> >
> > If you think I'm making this up, we have one security-related BPF app
> > with 1076 CO-RE relocations across 11 BPF programs. It's using 22
> > different root types.
>
> I suspect you're talking about selftests/bpf/profiler* tests.
> bpftool prog load -L profile1.o
> [  873.449749] nr_core_relo 106
> [  873.614186] nr_core_relo 297
> [  874.107470] nr_core_relo 19
> [  874.144146] nr_core_relo 102
> [  874.306462] nr_core_relo 258
> [  874.692219] nr_core_relo 410
> [  875.329652] nr_core_relo 238
> [  875.689900] nr_core_relo 9
>
> 8 different progs with a bunch of core relos.

Nope, I was talking about real production app here at Meta:

Section            Reloc cnt
------------------ ----------
.text              80
kprobe/...         217
kprobe/...         2
kprobe/...         4
kprobe/...         83
kprobe/...         261
kprobe/...         163
kretprobe/...      1
kretprobe/...      174
raw_tracepoint/... 82
raw_tracepoint/... 9


> On a debug kernel with lockdep and kasan it takes 2.3 seconds to load
> while kernel bpf_core_add_cands() is doing that loop
> more than a thousand times.
> libbpf takes 1.7 seconds.
> So it's an extra 0.5 second due to the loop.
>
> I haven't found the bug in lksel with core_kern.c + balancer_ingress yet.
> But just doing balancer_ingress (test_verif_scale2) as lskel I get:
> 0m0.827s
>
> while verif_scale2 is 6 seconds!
>
> Turned out due to attr.prog_flags = BPF_F_TEST_RND_HI32
> without it it's 0m0.574s.
>
> So 0.25 sec is spent in the add_cands loop.
>

Not sure whether you agree it's unnecessary slow or not :) But we have
teams worrying about 300ms total verification time, so there's that.

> > >
> > > > BTW, I've tried to measure how noticeable this will be and added
> > > > test_verif_scale2 to core_kern with only change to use vmlinux.h (so
> > > > that __sk_buff accesses are CO-RE relocated). I didn't manage to get
> > > > it loaded, so something else is going there. So please take a look, I
> > > > don't really know how to debug lskel stuff. Here are the changes:
> > >
> > > Looking. Thanks for the test.
> > >
> > > > > If we actually need to optimize this part of loading
> > > > > we better do persistent cache of
> > > > > name -> kernel btf_type-s
> > > > > and reuse it across different programs.
> > > >
> > > > You can't reuse it because the same type name in a BPF object BTF can
> > > > be resolved to different kernel types (e.g., if we still had
> > > > ring_buffer name collision),
> > >
> > > well and the candidate list will have two kernel types with the same name.
> > > Both kept in a cache.
> > > so cache_lookup("ring_buffer") will return two kernel types.
> > > That would be the case for all progs being loaded.
> > > What am I missing?
> >
> > if there are two matching types with the same matching field but field
> > offsets are different (and thus there is ambiguity), that's an error.
> > So the correct (by current definition, at least) program has to result
> > in one of such two incompatible ring_buffer types and only one. If
> > there are multiple duplicates, though, (like task_struct and
> > task_struct___2) they will have identical sets of fields at the same
> > offsets, so both will remain possible candidates and that's not an
> > error. But for actually two different types, there can be only one
> > winner.
>
> I'm not proposing to cache the result of refined bpf_core_cand_list
> after bpf_core_apply_relo_insn() did its job.
> I'm saying the kernel can cache the result of the add_cands loop across
> vmlinux BTFs for all progs.
> The bpf_core_apply_relo_insn() will be called with a copy of
> bpf_core_cand_list from a cache.
> I'm thinking to keep this cache in 'struct btf'

I wouldn't start with that for sure, because the next question is
garbage collection. What if someone just did some experiments, used
some obscure types that are not really used (typically), potentially
lots of them. Now the kernel will keep these extra cache entries
forever. You are basically talking about a lazily-built by-name index,
it might be useful in some other cases as well, but it definitely
comes with extra cost and I'm not convinced yet that we need to pay
this price right now.

But then again, I don't see why it's so hard to build a local hashmap
or rbtree for the duration of program load and discard it after load.
You haven't provided a clear argument why not.
