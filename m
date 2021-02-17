Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942AE31E2F4
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 00:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhBQXNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 18:13:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhBQXNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 18:13:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CB8F64E58
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613603551;
        bh=WNUZwBJ2Lg5EGkpXxIuc7t6hqOC3xm2TIvY/sblQlPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=neITDwE/uRZ63bdI+oSLjiXc89+ZnobMnRMYN1m4gmTCy2IGmww+bi2xJuSJ+0jqE
         fy/WWBxR/q2XKfbr5N87msMLTCWHQr0R4G2XCa1UOKdMwQghdTpq0ZFI1DHKBNDf8q
         PwVG2mwkW7IHqJchZKfNwGqyrt9RMCnLa1kj8E9m24yrC4w104pSOlQE562mDRrvyY
         Jhx/wKuPTWyWOvI/SMEuoaWb0b7o327BbSREjlh+K9xZpKMXQP9TrZH3pREmOXaslK
         mKlJY8QpAlwXFhQuZYJUfVeGaPMQQ4MdowIBlW4wCKRHSvUsIZy3lPZNduSg61/Rf1
         W6MQChB7ETMpw==
Received: by mail-lj1-f172.google.com with SMTP id b16so19098652lji.13
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 15:12:31 -0800 (PST)
X-Gm-Message-State: AOAM530NKYERt/BbioGpJciUZUyGhJWjN+iNms/AYHw13+Va7Xqac4zM
        XKHy9RE21kX8wgHTWrhB1JN2rpdlFzIfNSBSX0tgaQ==
X-Google-Smtp-Source: ABdhPJxu2TYejMpM2mmH72WB9X9sleCFkj+yAzw4rdCCS/S9ece5v8LkohEw4KYb/faD9UZGBNNP9dmw/RetglDhRyE=
X-Received: by 2002:a2e:2c09:: with SMTP id s9mr906029ljs.136.1613603549574;
 Wed, 17 Feb 2021 15:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20210217092831.2366396-1-jackmanb@google.com> <c20a494cfeb112093dcefe45838c63f62d781621.camel@linux.ibm.com>
In-Reply-To: <c20a494cfeb112093dcefe45838c63f62d781621.camel@linux.ibm.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 18 Feb 2021 00:12:18 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4DAzE1QZ9aioi6rAu9zZdNBa6rJ+FapZMXzwqDb5pehA@mail.gmail.com>
Message-ID: <CACYkzJ4DAzE1QZ9aioi6rAu9zZdNBa6rJ+FapZMXzwqDb5pehA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 7:30 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2021-02-17 at 09:28 +0000, Brendan Jackman wrote:
> > As pointed out by Ilya and explained in the new comment, there's a
> > discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> > the value from memory into r0, while x86 only does so when r0 and the
> > value in memory are different. The same issue affects s390.
> >
> > At first this might sound like pure semantics, but it makes a real
> > difference when the comparison is 32-bit, since the load will
> > zero-extend r0/rax.
> >
> > The fix is to explicitly zero-extend rax after doing such a
> > CMPXCHG. Since this problem affects multiple archs, this is done in
> > the verifier by patching in a BPF_ZEXT_REG instruction after every
> > 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> > can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> >
> > Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >
> > Differences v2->v3[1]:
> >  - Moved patching into fixup_bpf_calls (patch incoming to rename this
> > function)
> >  - Added extra commentary on bpf_jit_needs_zext
> >  - Added check to avoid adding a pointless zext(r0) if there's
> > already one there.
> >
> > Difference v1->v2[1]: Now solved centrally in the verifier instead of
> >   specifically for the x86 JIT. Thanks to Ilya and Daniel for the
> > suggestions!
> >
> > [1] v2:
> > https://lore.kernel.org/bpf/08669818-c99d-0d30-e1db-53160c063611@iogearbox.net/T/#t
> >     v1:
> > https://lore.kernel.org/bpf/d7ebaefb-bfd6-a441-3ff2-2fdfe699b1d2@iogearbox.net/T/#t
> >
> >  kernel/bpf/core.c                             |  4 +++
> >  kernel/bpf/verifier.c                         | 26
> > +++++++++++++++++++
> >  .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25
> > ++++++++++++++++++
> >  .../selftests/bpf/verifier/atomic_or.c        | 26
> > +++++++++++++++++++
> >  4 files changed, 81 insertions(+)
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 16ba43352a5f..a0d19be13558 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11662,6 +11662,32 @@ static int fixup_bpf_calls(struct
> > bpf_verifier_env *env)
> >                         continue;
> >                 }
> >
> > +               /* BPF_CMPXCHG always loads a value into R0,
> > therefore always
> > +                * zero-extends. However some archs' equivalent
> > instruction only
> > +                * does this load when the comparison is successful.
> > So here we
> > +                * add a BPF_ZEXT_REG after every 32-bit CMPXCHG, so
> > that such
> > +                * archs' JITs don't need to deal with the issue.
> > Archs that
> > +                * don't face this issue may use insn_is_zext to
> > detect and skip
> > +                * the added instruction.
> > +                */
> > +               if (insn->code == (BPF_STX | BPF_W | BPF_ATOMIC) &&
> > insn->imm == BPF_CMPXCHG) {
> > +                       struct bpf_insn zext_patch[2] = { [1] =
> > BPF_ZEXT_REG(BPF_REG_0) };
> > +
> > +                       if (!memcmp(&insn[1], &zext_patch[1],
> > sizeof(struct bpf_insn)))
> > +                               /* Probably done by
> > opt_subreg_zext_lo32_rnd_hi32. */
> > +                               continue;
> > +
>
> Isn't opt_subreg_zext_lo32_rnd_hi32() called after fixup_bpf_calls()?

Indeed, this check should not be needed.

>
> [...]
>
