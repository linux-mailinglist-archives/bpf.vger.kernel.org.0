Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC145AC85
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 20:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhKWTgf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 14:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhKWTgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 14:36:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE73EC061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 11:33:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso102031pjo.3
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulHWkf+lolmo1zxVwMnWyyM1E4ME9ARXr+8ysI7pe70=;
        b=RtfhPSK7nSudag2PfyDr7IngZW2U+VBFSYR8mlPoLctBgcdKIxN6bIaEgXjtWw1CAJ
         xYSE1aPg0q9tg2v/oyzyLqP/0SskyouwK/vIAEqBAoX3PC/Wpxko3XoYK/3D1oOzjYED
         eIVZ3KqVSmzvhfrqArSRoNE4lIrVimTRQHURbIhMuUyzJhLqTai/SKYqBwbEa3X2V8pX
         ZIUJzpu6UMAnPbc4D4x6nW2Fv5icd2tDrb5425mavhB+uz75WXwTYwoxEg3H2YGchytE
         DscTVpt+Byhw+iy9baT3V6RGuQqoQ0VdVVlTVcfHHSouPiN83wSpLyTFgwv9NRy8Ltux
         IR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulHWkf+lolmo1zxVwMnWyyM1E4ME9ARXr+8ysI7pe70=;
        b=ZB/CdWSw+7p+CU9bxs/zyck9F8C4E+Id697VSUi4DfumOEpLZ/+MLM7JmDgaa6XP9I
         fFRUf3+2buGE4fKiUQSjneBqIaegm4xs1LiQxOFdKoHKVjpvs+Jt6169w9Ot0RKZcm/k
         wNmzBzjBLzDvJ276qVlVAOw6N7vMif3GI76bnLl6r6k9ZnVXa6LU1ktMC2eCy2H/wDqM
         hRoF+fW8/IfMlG9nZc+hFfZnnLBEz7JZSCw6gIKGflBrFGbqr2CmHyaxM803hG0BGZAB
         f1T+dTjBdf+cU5v/AxUpfPKLIHJuy3S87VTVePk2Clg6ho/PEm1GMFDhMQAPCFpAalsa
         /UoA==
X-Gm-Message-State: AOAM533jJh56sohO4ac3zZ+3ELSsNDJ4pN7oRZ7zWJZxr8/HWF+8UgPu
        92nomT/5HlDxhIQwTNZMAw9ZE0PfZj7sPAIinCo=
X-Google-Smtp-Source: ABdhPJwuh6s8ltghVMrVKfsPnRMmXZ2hBZU9h06eWcEvyCVc5D53N3czmh7h3y2b9MavmhUCWyFXhsuFWYjdtPVrN6o=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr6326444pjb.62.1637696003159;
 Tue, 23 Nov 2021 11:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-7-alexei.starovoitov@gmail.com> <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
 <CAADnVQJ6Nt1v05dSjq4touYddPSjihMNZAPZMsux8vHBMu9WDg@mail.gmail.com>
 <CAEf4BzbzQR22NsWu_aRJu705ehsP3nL47ZW9MBygonna8KbNEw@mail.gmail.com>
 <CAADnVQLZASm0tUfLALeLmZbdmfUZq4umRpRDBT06a1cF1aJWhg@mail.gmail.com>
 <CAEf4BzYb6Cb5-g77rX6Unz29EYwRCHbGgaGJWZnpp2vhh8Z56g@mail.gmail.com>
 <CAADnVQ+-2=8-zd7dOrHbceke26repHC7_xgbf3cKGSmVHMi3vA@mail.gmail.com> <CAEf4BzbLRBCToDzztAFTBQ66p_uYKyc8zKN_2MXXCYq_+MN=kg@mail.gmail.com>
In-Reply-To: <CAEf4BzbLRBCToDzztAFTBQ66p_uYKyc8zKN_2MXXCYq_+MN=kg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 23 Nov 2021 11:33:11 -0800
Message-ID: <CAADnVQLZMW7T5A1eu9o_pe5PHYj5Pr5NdiWwQZsP=k-mgroABg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:19 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 22, 2021 at 9:04 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 22, 2021 at 7:44 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 7:15 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Nov 22, 2021 at 5:44 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 22, 2021 at 4:43 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 22, 2021 at 3:47 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > > >
> > > > > > > > Given BPF program's BTF perform a linear search through kernel BTFs for
> > > > > > > > a possible candidate.
> > > > > > > > Then wire the result into bpf_core_apply_relo_insn().
> > > > > > > >
> > > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > ---
> > > > > > > >  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > > >  1 file changed, 135 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > >
> > > > > > > [...]
> > > > > > >
> > > > > > > >  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
> > > > > > > >                    int relo_idx, void *insn)
> > > > > > > >  {
> > > > > > > > -       return -EOPNOTSUPP;
> > > > > > > > +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> > > > > > > > +               struct bpf_core_cand_list *cands;
> > > > > > > > +
> > > > > > > > +               cands = bpf_core_find_cands(ctx, relo->type_id);
> > > > > > >
> > > > > > > this is wrong for many reasons:
> > > > > > >
> > > > > > > 1. you will overwrite previous ctx->cands, if it was already set,
> > > > > > > which leaks memory
> > > > > > > 2. this list of candidates should be keyed by relo->type_id ("root
> > > > > > > type"). Different root types get their own independent lists; so it
> > > > > > > has to be some sort of look up table from type_id to a list of
> > > > > > > candidates.
> > > > > > >
> > > > > > > 2) means that if you had a bunch of relos against struct task_struct,
> > > > > > > you'll crate a list of candidates when processing first relo that
> > > > > > > starts at task_struct. All the subsequent relos that have task_struct
> > > > > > > as root type will re-used that list and potentially trim it down. If
> > > > > > > there are some other relos against, say, struct mm_struct, they will
> > > > > > > have their independent list of candidates.
> > > > > >
> > > > > > right.
> > > > > > Your prior comment confused me. I didn't do this reuse of cands
> > > > > > to avoid introducing hashtable here like libbpf does,
> > > > > > since it does too little to actually help.
> > > > >
> > > > > Since when avoiding millions of iterations for each relocation is "too
> > > > > little help"?
> > > >
> > > > because it is a premature optimization for a case that
> > > > may or may not be relevant.
> > > > If 180 sk_buff relocations somehow makes the loading too slow
> > > > 180 relocations of 180 different types would produce exactly
> > > > the same slow down and hashtable cache won't help.
> > >
> > > Likelihood of using 180 different root types in real application is
> > > very small. Using 180 relocations (either with explicit BPF_CORE_READ,
> > > field accesses in fentry, or just through always_inline helpers doing
> > > either and being inlined in multiple places) is very real in
> > > real-world non-trivial applications. And the cost of optimizing that
> > > in the kernel later is very high, you'll be waiting for a new kernel
> > > release to get everywhere to rely on this optimization. The cost of
> > > further optimizing this in libbpf is much smaller (and libbpf still
> > > did the optimization from the get go and I stand by that decision).
> > >
> > > If you think I'm making this up, we have one security-related BPF app
> > > with 1076 CO-RE relocations across 11 BPF programs. It's using 22
> > > different root types.
> >
> > I suspect you're talking about selftests/bpf/profiler* tests.
> > bpftool prog load -L profile1.o
> > [  873.449749] nr_core_relo 106
> > [  873.614186] nr_core_relo 297
> > [  874.107470] nr_core_relo 19
> > [  874.144146] nr_core_relo 102
> > [  874.306462] nr_core_relo 258
> > [  874.692219] nr_core_relo 410
> > [  875.329652] nr_core_relo 238
> > [  875.689900] nr_core_relo 9
> >
> > 8 different progs with a bunch of core relos.
>
> Nope, I was talking about real production app here at Meta:
>
> Section            Reloc cnt
> ------------------ ----------
> .text              80
> kprobe/...         217
> kprobe/...         2
> kprobe/...         4
> kprobe/...         83
> kprobe/...         261
> kprobe/...         163
> kretprobe/...      1
> kretprobe/...      174
> raw_tracepoint/... 82
> raw_tracepoint/... 9

I think the profiler test is a trimmed version of it.
Few short kprobe/krerprobes were removed from it,
since they don't improve the test coverage.

>
> > On a debug kernel with lockdep and kasan it takes 2.3 seconds to load
> > while kernel bpf_core_add_cands() is doing that loop
> > more than a thousand times.
> > libbpf takes 1.7 seconds.
> > So it's an extra 0.5 second due to the loop.
> >
> > I haven't found the bug in lksel with core_kern.c + balancer_ingress yet.
> > But just doing balancer_ingress (test_verif_scale2) as lskel I get:
> > 0m0.827s
> >
> > while verif_scale2 is 6 seconds!
> >
> > Turned out due to attr.prog_flags = BPF_F_TEST_RND_HI32
> > without it it's 0m0.574s.
> >
> > So 0.25 sec is spent in the add_cands loop.
> >
>
> Not sure whether you agree it's unnecessary slow or not :) But we have
> teams worrying about 300ms total verification time, so there's that.
>
> > > >
> > > > > BTW, I've tried to measure how noticeable this will be and added
> > > > > test_verif_scale2 to core_kern with only change to use vmlinux.h (so
> > > > > that __sk_buff accesses are CO-RE relocated). I didn't manage to get
> > > > > it loaded, so something else is going there. So please take a look, I
> > > > > don't really know how to debug lskel stuff. Here are the changes:
> > > >
> > > > Looking. Thanks for the test.
> > > >
> > > > > > If we actually need to optimize this part of loading
> > > > > > we better do persistent cache of
> > > > > > name -> kernel btf_type-s
> > > > > > and reuse it across different programs.
> > > > >
> > > > > You can't reuse it because the same type name in a BPF object BTF can
> > > > > be resolved to different kernel types (e.g., if we still had
> > > > > ring_buffer name collision),
> > > >
> > > > well and the candidate list will have two kernel types with the same name.
> > > > Both kept in a cache.
> > > > so cache_lookup("ring_buffer") will return two kernel types.
> > > > That would be the case for all progs being loaded.
> > > > What am I missing?
> > >
> > > if there are two matching types with the same matching field but field
> > > offsets are different (and thus there is ambiguity), that's an error.
> > > So the correct (by current definition, at least) program has to result
> > > in one of such two incompatible ring_buffer types and only one. If
> > > there are multiple duplicates, though, (like task_struct and
> > > task_struct___2) they will have identical sets of fields at the same
> > > offsets, so both will remain possible candidates and that's not an
> > > error. But for actually two different types, there can be only one
> > > winner.
> >
> > I'm not proposing to cache the result of refined bpf_core_cand_list
> > after bpf_core_apply_relo_insn() did its job.
> > I'm saying the kernel can cache the result of the add_cands loop across
> > vmlinux BTFs for all progs.
> > The bpf_core_apply_relo_insn() will be called with a copy of
> > bpf_core_cand_list from a cache.
> > I'm thinking to keep this cache in 'struct btf'
>
> I wouldn't start with that for sure, because the next question is
> garbage collection. What if someone just did some experiments, used
> some obscure types that are not really used (typically), potentially
> lots of them. Now the kernel will keep these extra cache entries
> forever. You are basically talking about a lazily-built by-name index,
> it might be useful in some other cases as well, but it definitely
> comes with extra cost and I'm not convinced yet that we need to pay
> this price right now.
>
> But then again, I don't see why it's so hard to build a local hashmap
> or rbtree for the duration of program load and discard it after load.
> You haven't provided a clear argument why not.

because libbpf's approach to use hashtab for narrow use case is inferior.
we could remove it from libbpf and no one will notice.
The generic cache that works across progs will speed up the loading
a tiny bit across all progs instead of a single case of profiler*.c
that has a bunch of relos only because it's using an outdated
always_unroll approach to loops.

btw the following diff removes the bigger part of the loop overhead:
+
+               if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
                        continue;

                targ_essent_len = bpf_core_essential_name_len(targ_name);
                if (targ_essent_len != local_essent_len)
                        continue;

-               if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
-                       continue;
-

from 0.25 sec it goes to 0.1 sec.
Not saying it's ok to waste this 0.1.
On non debug kernel it's probably even less noticeable.
The point is that the loop can be trivially made faster for
all use cases.
Whereas complicating kernel code with custom hashtable for
a narrow use case is just odd.
You've said it yourself: it's 22 different root types.
With libbpf style hashtable this will be 22 x sizeof(vmlinux btf)
iterations every time. And if this is a typical use case indeed
then more complex progs in the future will be doing these loops.
Either the loop should be fast enough (I think it is with above
strncmp move) or the kernel needs to be optimized for all use cases.
