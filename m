Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631331D3D5
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 02:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBQBoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 20:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhBQBoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 20:44:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 678AD64E76
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 01:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613526213;
        bh=k+plf038UNY3MR6fs/9HhnmAqatc7hJExiF9OlSvZI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fVvGNRlBQOp+wIAyBoHDQ/8WeCfQwUHGmwJpmZ+X8hj7E/7Av7YPNNnTlFZ5cIliQ
         Jp6dRSyFxS8VV0pZ2YpOCpYZCkCrxCOWiAuMwYB912Ogs2erpo5jPLnjBJcln4bZUQ
         i7Slpp15rhkbhpukG1BzA1xQ1mZXpBAAozQUcdPhJQ/3p5MVdw25ZtdZMiOx28cay9
         FfrmCIHz3OI5cBg4yG96TZbydjsjnxEIQ3GzjkXw14ujZZYXpdFxUMGh4Snj/pifup
         yxHcveLyIq/jf9nTVxb9zZVlUNxjmnH++FXe5KVzEzNe0Kyxfcf1zpNayi1Ypu/3kk
         jiPpoycluI9aA==
Received: by mail-lj1-f181.google.com with SMTP id a22so14218064ljp.10
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 17:43:33 -0800 (PST)
X-Gm-Message-State: AOAM533AhqovClySulCaL+DtwnnMxgA0sDcv2Qt+pFAXeO9lzWTjz6vB
        KHrqYa82Su5l9bSALyFgpfidhBk83CkT/ilp2+Iz3A==
X-Google-Smtp-Source: ABdhPJzeQYzsWb4i0XOubWYWXtPOGtvop+c6WNMnGZbnu1vL3XYqTtdbIaDSDxn46m/rmLU6ofTdChA2n3mWQOHaMGk=
X-Received: by 2002:a2e:8ecc:: with SMTP id e12mr14363327ljl.103.1613526211685;
 Tue, 16 Feb 2021 17:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20210216141925.1549405-1-jackmanb@google.com> <80228f01-c43c-f121-0b80-bb368b530111@iogearbox.net>
In-Reply-To: <80228f01-c43c-f121-0b80-bb368b530111@iogearbox.net>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 17 Feb 2021 02:43:20 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4-QSevoMuPZ_xtYP2WK1_2MKVC1op6Y1+wTtmP_FnOaw@mail.gmail.com>
Message-ID: <CACYkzJ4-QSevoMuPZ_xtYP2WK1_2MKVC1op6Y1+wTtmP_FnOaw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 1:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/16/21 3:19 PM, Brendan Jackman wrote:
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
> [...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 16ba43352a5f..7f4a83d62acc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11889,6 +11889,39 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
> >       return 0;
> >   }
> >
> > +/* BPF_CMPXCHG always loads a value into R0, therefore always zero-extends.
> > + * However some archs' equivalent instruction only does this load when the
> > + * comparison is successful. So here we add a BPF_ZEXT_REG after every 32-bit
> > + * CMPXCHG, so that such archs' JITs don't need to deal with the issue. Archs
> > + * that don't face this issue may use insn_is_zext to detect and skip the added
> > + * instruction.
> > + */
> > +static int add_zext_after_cmpxchg(struct bpf_verifier_env *env)
> > +{
> > +     struct bpf_insn zext_patch[2] = { [1] = BPF_ZEXT_REG(BPF_REG_0) };
> > +     struct bpf_insn *insn = env->prog->insnsi;
> > +     int insn_cnt = env->prog->len;
> > +     struct bpf_prog *new_prog;
> > +     int delta = 0; /* Number of instructions added */
> > +     int i;
> > +
> > +     for (i = 0; i < insn_cnt; i++, insn++) {
> > +             if (insn->code != (BPF_STX | BPF_W | BPF_ATOMIC) || insn->imm != BPF_CMPXCHG)
> > +                     continue;
> > +
> > +             zext_patch[0] = *insn;
> > +             new_prog = bpf_patch_insn_data(env, i + delta, zext_patch, 2);
> > +             if (!new_prog)
> > +                     return -ENOMEM;
> > +
> > +             delta++;
> > +             env->prog = new_prog;
> > +             insn = new_prog->insnsi + i + delta;
> > +     }
>
> Looks good overall, one small nit ... is it possible to move this into fixup_bpf_calls()
> where we walk the prog insns & handle most of the rewrites already?

Ah, so I thought fixup_bpf_calls was for "calls" but now looking at
the function it does
more than just fixing up calls. I guess we could also rename it and
update the comment
on the function.

- KP

>
> > +
> > +     return 0;
> > +}
