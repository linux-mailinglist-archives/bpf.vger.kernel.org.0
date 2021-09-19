Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B7410CB2
	for <lists+bpf@lfdr.de>; Sun, 19 Sep 2021 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhISRdM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Sep 2021 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhISRdM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Sep 2021 13:33:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FFAC061574
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 10:31:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p4so34723495qki.3
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYUbarQJT0yTtnfJmEi1rpA5dUBOkR6SLDGUXd8qF+I=;
        b=iH9qjCPTgMzYp3h1RRelF6oThGdbXyJkObO4jtGOT0fb42RhnMj0+tkyYIJk4RK8f4
         7mtm7cticclFiB+cGnV4pTuTu5gKG8B6UJg8cf8VvlzLfR38Em2yzyNnQV2+UNzuX8fc
         xlP8DbrCjB904iDOC6R10iHMuOw4cNc4Yx8B+q2kcLsjFP2mSt3rTjN5U6N8DAvn1sDJ
         oGvMflMKlNSCA79YbJ+jWBSlFbSHD0pZCpt6sc6BSr++VCqTqskH4NEpe+11CJZn4CM/
         1we0fSOY2mkt+UWQ7mbjLdfcbqvTw7jXyykrUhukl8V4zQ2hyJk4ZmXlS7lvASWXT1a8
         Ct2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYUbarQJT0yTtnfJmEi1rpA5dUBOkR6SLDGUXd8qF+I=;
        b=NdZuee1SZJFV3RmQCm6sVNhzLpQNNJTxbM7diQvy9PGsLBBjfaM8Butt9YG+1v4QlU
         BD0WvsmfuUund17zEV1zVGIA+QYr5VZp7lyxyOCktceAeMOovQJj7dEHQDx4Gqckr10a
         AedcphndAcXq9EbNMQ81crsdyKEeN6t3gWKKQefSoCeSecnAf2E52cUCe4a4xGNxfg1h
         7h9Jway1mEL1/Q5aL7AoSE9Q6p/hhkBdBOer9XDNW/U0X0AOXgF6iNsQzC6L/oyrKNsk
         /l555h08lD/m09OyhB7K3mgdfipmprDo3e2f6pJVZ1hIwUx5n/u5LpwhC4JpzLMdZHII
         mcqA==
X-Gm-Message-State: AOAM531AAkswkHWOHjQmMEPf0NjsBNrJuDRGkXDY8E67jSldnjOAvfMY
        S9eOIJ02fm9CxVozgS1aJUW3QiOoHNB9B/ppsXo=
X-Google-Smtp-Source: ABdhPJwUcBuEQmEoliwQQeAKtom0Xt7Uk5RdpcB3z5Q9HV8rTWQKKUlcu9EHNVcdXlDpe2hXhIE3MNECLodf+MtMYhc=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr24139958ybt.433.1632072706308;
 Sun, 19 Sep 2021 10:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061020.821711-1-andrii@kernel.org> <20210917061020.821711-9-andrii@kernel.org>
 <YUTP20fF5wx0LbxQ@google.com> <CAEf4BzYV1YpYojN4STU=wB9G19n_JdXoMsxFeSkM43GeS6ATMg@mail.gmail.com>
 <YUUgj5kR1XA48Z3n@google.com> <CAEf4BzYg3Tdv3KjmwNYu=81ig=KeLOGvqA+zH_nC_VmJ3M6hjg@mail.gmail.com>
 <YUUnHw3OjnTPD8Ii@google.com>
In-Reply-To: <YUUnHw3OjnTPD8Ii@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 19 Sep 2021 10:31:35 -0700
Message-ID: <CAEf4BzaPzryfEuRRLNvu2r8OcY0Noc7bbyacfZwRHzr+w0Ca4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 4:39 PM <sdf@google.com> wrote:
>
> On 09/17, Andrii Nakryiko wrote:
> > On Fri, Sep 17, 2021 at 4:11 PM <sdf@google.com> wrote:
> > >
> > > On 09/17, Andrii Nakryiko wrote:
> > > > On Fri, Sep 17, 2021 at 10:26 AM <sdf@google.com> wrote:
> > > > >
> > > > > On 09/16, Andrii Nakryiko wrote:
> > > > > > Implement strict ELF section name handling for BPF programs. It
> > > > utilizes
> > > > > > `libbpf_set_strict_mode()` framework and adds new flag:
> > > > > > LIBBPF_STRICT_SEC_NAME.
> > > > >
> > > > > > If this flag is set, libbpf will enforce exact section name
> > matching
> > > > for
> > > > > > a lot of program types that previously allowed just partial prefix
> > > > > > match. E.g., if previously SEC("xdp_whatever_i_want") was
> > allowed, now
> > > > > > in strict mode only SEC("xdp") will be accepted, which makes
> > SEC("")
> > > > > > definitions cleaner and more structured. SEC() now won't be used
> > as
> > > > yet
> > > > > > another way to uniquely encode BPF program identifier (for that
> > > > > > C function name is better and is guaranteed to be unique within
> > > > > > bpf_object). Now SEC() is strictly BPF program type and,
> > depending on
> > > > > > program type, extra load/attach parameter specification.
> > > > >
> > > > > > Libbpf completely supports multiple BPF programs in the same ELF
> > > > > > section, so multiple BPF programs of the same type/specification
> > > > easily
> > > > > > co-exist together within the same bpf_object scope.
> > > > >
> > > > > > Additionally, a new (for now internal) convention is introduced:
> > > > section
> > > > > > name that can be a stand-alone exact BPF program type
> > specificator,
> > > > but
> > > > > > also could have extra parameters after '/' delimiter. An example
> > of
> > > > such
> > > > > > section is "struct_ops", which can be specified by itself, but
> > also
> > > > > > allows to specify the intended operation to be attached to, e.g.,
> > > > > > "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not
> > > > allowed.
> > > > > > Such section definition is specified as "struct_ops+".
> > > > >
> > > > > > This change is part of libbpf 1.0 effort ([0], [1]).
> > > > >
> > > > > >    [0] Closes: https://github.com/libbpf/libbpf/issues/271
> > > > > >    [1]
> > > > > >
> > > >
> > https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> > > > >
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > ---
> > > > > >   tools/lib/bpf/libbpf.c        | 135
> > > > ++++++++++++++++++++++------------
> > > > > >   tools/lib/bpf/libbpf_legacy.h |   9 +++
> > > > > >   2 files changed, 98 insertions(+), 46 deletions(-)
> > > > >
>
> > [...]
>
> > > > > > +     /*
> > > > > > +      * Enforce strict BPF program section (SEC()) names.
> > > > > > +      * E.g., while prefiously SEC("xdp_whatever") or
> > > > SEC("perf_event_blah")
> > > > > > were
> > > > > > +      * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
> > > > > > +      * unrecognized by libbpf and would have to be just
> > SEC("xdp")
> > > > and
> > > > > > +      * SEC("xdp") and SEC("perf_event").
> > > > > > +      */
> > > > > > +     LIBBPF_STRICT_SEC_NAME = 0x04,
> > > > >
> > > > > To clarify: I'm assuming, as discussed, we'll still support that
> > old,
> > > > > non-conforming naming in libbpf 1.0, right? It just won't be enabled
> > > > > by default.
> > >
> > > > No, we won't. All those opt-in strict flags will be turned on
> > > > permanently in libbpf 1.0. But I'm adding an ability to provide custom
> > > > callbacks to handle whatever (reasonable) BPF program section names.
> > > > So if someone has a real important case needing custom handling, it's
> > > > not a big problem to implement that logic on their own. If someone is
> > > > just resisting making their code conforming, well... Stay on the old
> > > > fixed version, write a callback, or just do the mechanical rename, how
> > > > hard can that be? We are dropping bpf_program__find_program_by_title()
> > > > in libbpf 1.0, that API is meaningless with multiple programs per
> > > > section, so you'd have to update your logic to either skeleton or
> > > > bpf_program__find_program_by_name() anyways.
> > >
> > > I see. I was assuming some of them would stay, iirc Toke also was asking
> > > for this one to stay (or was it the old maps format?). FTR, I'm not
> > > resisting any changes, I'm willing to invest some time to update our
> > > callers, just trying to understand what my options are. We do have some
> > > cases where we depend on the section names, so maybe I should just
> > > switch from bpf_program__title to bpf_program__name (and do appropriate
> > > renaming).
>
> > Switching to name over title (section name) is a good idea for sure.
>
> > >
> > > RE skeleton: I'm not too eager to adopt it, I'll wait for version 2 :-)
>
> > Honest curiosity, what's wrong with the current version of skeleton?
> > Can you please expand on this?
>
> Nothing wrong, I'm just joking, but I guess we went with a different path
> long time ago where we ship .o more-or-less independently and it's hard to
> adopt skeletons at this point (where .o is bundled with the userspace part).
> We also ship several .o's compiled for different kernel versions because
> prior to BTF we didn't have a good way todo '#ifdef KERNEL_X_Y_Z' and
> some of that still lives on (but probably should die eventually).

We also have some applications with "old model", though they've used
their custom embedding logic to not distribute separate .o files. We
are working on switching them to BPF skeletons this half, though. Note
that BPF skeleton generation logic recently added a way to get raw ELF
bytes without necessarily instantiating the skeleton itself (see
<xxx>__elf_bytes()). There are also plans to add small C++
constructor/destructor shims to make it harder for C++ apps to miss
the need to destroy the skeleton, which helps with BPF skeleton
adoption in C++ applications.

>
> Maybe we should do some talk on some conference on the way we ship
> bpf to the fleet. Again, it's not like we don't like to change anything
> here, but there is some existing "legacy" infra that has some
> assumptions that might not easy to change in a short period of time.

Sure, some sort of lighting talk would be interesting. The problem is
that there needs to be a persistent and energetic initiative to break
all assumptions and switch to newer (arguably, better) ways. Doesn't
happen by itself ;)
