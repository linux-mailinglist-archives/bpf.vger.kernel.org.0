Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246BA321AC8
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 16:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhBVPHL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 10:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhBVPHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 10:07:08 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CCAC061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 07:06:26 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c5so1455739ioz.8
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDAEQiEfF7L2tCxDgnr5xaqsnOZcGFRdfo/3o6ryN3E=;
        b=sSu3gE3VrpTkjb3loC2FwzxKeW0C+XAXXEoNOWA1Hj+L3yNkTXr5oTg1GZZqC3rsva
         PsR4CByseI99VgLkyHBZNjYVq5x9udvBNJoLii6nwGxZAebc/f5MWwVap7BSj/Fl3gj0
         BS0Q8Y6Iq3M35+N+NQSPq5A6aWs0vHqWErH+qtkETa7REUZqsVhAYkg/LwO6ojBjog6H
         bzB4WOFDoim9Bm72HT8roZM8mcFQkWeK6SzrRMXTzuAucQ+ISlZu01EC9DooNz4haboY
         F1cjzXD0UYvpmTcH+KkY5iAIvNgh0lDBfoKSwVpTw0EbBB4//4YvlRsCwbk7/tGq6J0+
         Bc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDAEQiEfF7L2tCxDgnr5xaqsnOZcGFRdfo/3o6ryN3E=;
        b=EAinUqHyu5Vh8b/1lCXhasWy5Dy/rn6N6WIEBofNfvETU6jFLa7x6tcDDVjELi/RZf
         kCBGSsMX4lHUCCTQgdQykC7jZriIlE6YKsCPV/AJSCQBAFv1uLrpTDuC2OW5eyRgpxpk
         sMHokqQR3UKn4ZZs18ByR1F4ZElorqK4Lw3aAnpUP9k+VSPynSxONF2/299jQovWyrcd
         0I4L82dACua0PjV+XaehBjw0VcSmZSHQCmx6KNo3c0skMPPmiT/0ZSFdpmYJY/dOUqtd
         Lh6RWKf82KRMk9VRM5zG1POMg0X2hXeLIfk3UQ5qkPGv8MXNRXtQ3z2bDpEaLnoeAeSY
         J8pA==
X-Gm-Message-State: AOAM531+N3wNhoynMHcyqoqxaHlpf7V/zndLG8sBE2T4PfgwT7UdJKBc
        tocYOmzkGaa67bXSaIRRIs+V4AB9X/Lo1BNkxZ7PFYf57CaAJ/OK
X-Google-Smtp-Source: ABdhPJxzJykIvLC4pul9qFFpQcE4OhBArUHUe41NJK5gTO4UAAsy3KJkDJ92A/cKcrf9x4dzotIbR06W1OVVg9DJYFs=
X-Received: by 2002:a02:1909:: with SMTP id b9mr16381799jab.141.1614006385446;
 Mon, 22 Feb 2021 07:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20210217092831.2366396-1-jackmanb@google.com> <c20a494cfeb112093dcefe45838c63f62d781621.camel@linux.ibm.com>
 <CACYkzJ4DAzE1QZ9aioi6rAu9zZdNBa6rJ+FapZMXzwqDb5pehA@mail.gmail.com>
In-Reply-To: <CACYkzJ4DAzE1QZ9aioi6rAu9zZdNBa6rJ+FapZMXzwqDb5pehA@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 22 Feb 2021 16:06:12 +0100
Message-ID: <CA+i-1C0JFW4qyN4XNhG-sX-rspmbTaV2g_eYNjtnjg8WB=XUEQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     KP Singh <kpsingh@kernel.org>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 18 Feb 2021 at 00:12, KP Singh <kpsingh@kernel.org> wrote:
>
> On Wed, Feb 17, 2021 at 7:30 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Wed, 2021-02-17 at 09:28 +0000, Brendan Jackman wrote:
> > > As pointed out by Ilya and explained in the new comment, there's a
> > > discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> > > the value from memory into r0, while x86 only does so when r0 and the
> > > value in memory are different. The same issue affects s390.
> > >
> > > At first this might sound like pure semantics, but it makes a real
> > > difference when the comparison is 32-bit, since the load will
> > > zero-extend r0/rax.
> > >
> > > The fix is to explicitly zero-extend rax after doing such a
> > > CMPXCHG. Since this problem affects multiple archs, this is done in
> > > the verifier by patching in a BPF_ZEXT_REG instruction after every
> > > 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> > > can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> > >
> > > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >
> > > Differences v2->v3[1]:
> > >  - Moved patching into fixup_bpf_calls (patch incoming to rename this
> > > function)
> > >  - Added extra commentary on bpf_jit_needs_zext
> > >  - Added check to avoid adding a pointless zext(r0) if there's
> > > already one there.
> > >
> > > Difference v1->v2[1]: Now solved centrally in the verifier instead of
> > >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > > suggestions!
> > >
> > > [1] v2:
> > > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> > >     v1:
> > > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> > >
> > >  kernel/bpf/core.c                             |  4 +++
> > >  kernel/bpf/verifier.c                         | 26
> > > +++++++++++++++++++
> > >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25
> > > ++++++++++++++++++
> > >  .../selftests/bpf/verifier/atomic_or.c        | 26
> > > +++++++++++++++++++
> > >  4 files changed, 81 insertions(+)
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 16ba43352a5f..a0d19be13558 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -11662,6 +11662,32 @@ static int fixup_bpf_calls(struct
> > > bpf_verifier_env *env)
> > >                         continue;
> > >                 }
> > >
> > > +               /* BPF_CMPXCHG always loads a value into R0,
> > > therefore always
> > > +                * zero-extends. However some archs' equivalent
> > > instruction only
> > > +                * does this load when the comparison is successful.
> > > So here we
> > > +                * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so
> > > that such
> > > +                * archs' JITs don't need to deal with the issue.
> > > Archs that
> > > +                * don't face this issue may use insn_is_zext to
> > > detect and skip
> > > +                * the added instruction.
> > > +                */
> > > +               if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) &&
> > > insn->imm == BPF_CMPXCHG) {
> > > +                       struct bpf_insn zext_patch[2] = { [1] =
> > > BPF_ZEXT_REG(BPF_REG_0) };
> > > +
> > > +                       if (!memcmp(&insn[1], &zext_patch[1],
> > > sizeof(struct bpf_insn)))
> > > +                               /* Probably done by
> > > opt_subreg_zext_lo32_rnd_hi32. */
> > > +                               continue;
> > > +
> >
> > Isn't opt_subreg_zext_lo32_rnd_hi32() called after fixup_bpf_calls()?
>
> Indeed, this check should not be needed.

Ah yep, right. Do you folks think I should keep the optimisation (i.e.
move this memcmp into opt_subreg_zext_lo32_rnd_hi32)? It feels like a
bit of a toss-up to me.
