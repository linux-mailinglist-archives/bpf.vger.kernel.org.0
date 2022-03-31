Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19094EE191
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiCaTWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCaTWp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:22:45 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909849F25
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:20:58 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x9so497443ilc.3
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYBnbRij+qUMfnEIZOpzsVzkT0EONuIPbVdcLqrDTQg=;
        b=ISJAyboRrWTtYgh1ToOhbRiAR1gyFVMjpIZTHv03bTosqX7HrpIy3/kmWaLJxSiLyY
         LJKH/XUHtsaZAduR28Pj7ocs7sjX173qgF3KtB3BSHbKK4jzS++RtR0xQY48dFin/bdt
         45GRdz5TGjOhSXaEiBQwISEVFxgEmBw+UfZl5+ofeCy7bSu4mOaPCa+5jLOKs9EhJA16
         MBuS5itOqj/n/eWxCbeDlcwwBQL3a0wdrwMyZqbK43eJ7Jib7JO7zZFnT/dV9k7xgxHT
         K+SrAZlEp0usV9J7FLX2BHCD0Iz6QChH4i3SabAoDFjhlsCjTd8ijT5EVdG87z/vfPFY
         lfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYBnbRij+qUMfnEIZOpzsVzkT0EONuIPbVdcLqrDTQg=;
        b=bCX9TYeuiDR2O/zG0LL3Ixn/l0qeF8BFUmzWWkHswo9ROLOGeGrp6NLEhIPUXnLNgs
         RKv37b+pMvARbHW76qRY/hNZcbsOa+gAm7Eq+3B8bbA1XpRta71bxWMhzfwIjvTEUfYG
         tM1yNLjNW3Mwn/iaWTF74qy72CM1id2kBnwAShSUZtR9w7bXL+kYHC0U/pbW7tah2u7e
         R7YdP1fvOAQ41gn8zuKxvlRyPSO7bm72XMYG0rez6GHjZEEHNARL3TuVQO6wOxBZUXG0
         aD0zGRyXpHZFtutQFvBwak6Qeoc/+ADDOr9MubVKT2v2RLZyiIPyUn5b9YwfQ/Fkjxr1
         6ZhQ==
X-Gm-Message-State: AOAM532LMmjhwS1/lIkwAV1GvrZquIwEP6u+P31UDVqCg8fl/y1WruLN
        Byla9PmlgR+zi5a7Fma+skWLzdd4OOSxoBLnRgYxMR+5
X-Google-Smtp-Source: ABdhPJwOlMSbJ9sril6UhusyQJe1LSFk/oijUbt1PocPPWJTSTvyM7gY7F4WoPOEJodgA3yYYW4PbYAZUuQnN3rf/Ww=
X-Received: by 2002:a05:6e02:1562:b0:2c9:cb97:9a4 with SMTP id
 k2-20020a056e02156200b002c9cb9709a4mr8866732ilu.71.1648754457426; Thu, 31 Mar
 2022 12:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-6-andrii@kernel.org>
 <alpine.LRH.2.23.451.2203311551070.11363@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2203311551070.11363@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 12:20:46 -0700
Message-ID: <CAEf4BzYUhjJh5n9E=KwagCmkP5caVGWNr2i7GpPHAygipe0XTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 31, 2022 at 8:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Fri, 25 Mar 2022, Andrii Nakryiko wrote:
>
> > Add x86/x86_64-specific USDT argument specification parsing. Each
> > architecture will require their own logic, as all this is arch-specific
> > assembly-based notation. Architectures that libbpf doesn't support for
> > USDTs will pr_warn() with specific error and return -ENOTSUP.
> >
> > We use sscanf() as a very powerful and easy to use string parser. Those
> > spaces in sscanf's format string mean "skip any whitespaces", which is
> > pretty nifty (and somewhat little known) feature.
> >
> > All this was tested on little-endian architecture, so bit shifts are
> > probably off on big-endian, which our CI will hopefully prove.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> minor stuff below...
>
> > ---
> >  tools/lib/bpf/usdt.c | 105 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 22f5f56992f8..5cf809db60aa 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -1007,8 +1007,113 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
> >       return 0;
> >  }
> >
> > +/* Architecture-specific logic for parsing USDT argument location specs */
> > +
> > +#if defined(__x86_64__) || defined(__i386__)
> > +
> > +static int calc_pt_regs_off(const char *reg_name)
> > +{
> > +     static struct {
> > +             const char *names[4];
> > +             size_t pt_regs_off;
> > +     } reg_map[] = {
> > +#if __x86_64__
> > +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
> > +#else
> > +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
> > +#endif
> > +             { {"rip", "eip", "", ""}, reg_off(rip, eip) },
> > +             { {"rax", "eax", "ax", "al"}, reg_off(rax, eax) },
> > +             { {"rbx", "ebx", "bx", "bl"}, reg_off(rbx, ebx) },
> > +             { {"rcx", "ecx", "cx", "cl"}, reg_off(rcx, ecx) },
> > +             { {"rdx", "edx", "dx", "dl"}, reg_off(rdx, edx) },
> > +             { {"rsi", "esi", "si", "sil"}, reg_off(rsi, esi) },
> > +             { {"rdi", "edi", "di", "dil"}, reg_off(rdi, edi) },
> > +             { {"rbp", "ebp", "bp", "bpl"}, reg_off(rbp, ebp) },
> > +             { {"rsp", "esp", "sp", "spl"}, reg_off(rsp, esp) },
> > +#undef reg_off
> > +#if __x86_64__
> > +             { {"r8", "r8d", "r8w", "r8b"}, offsetof(struct pt_regs, r8) },
> > +             { {"r9", "r9d", "r9w", "r9b"}, offsetof(struct pt_regs, r9) },
> > +             { {"r10", "r10d", "r10w", "r10b"}, offsetof(struct pt_regs, r10) },
> > +             { {"r11", "r11d", "r11w", "r11b"}, offsetof(struct pt_regs, r11) },
> > +             { {"r12", "r12d", "r12w", "r12b"}, offsetof(struct pt_regs, r12) },
> > +             { {"r13", "r13d", "r13w", "r13b"}, offsetof(struct pt_regs, r13) },
> > +             { {"r14", "r14d", "r14w", "r14b"}, offsetof(struct pt_regs, r14) },
> > +             { {"r15", "r15d", "r15w", "r15b"}, offsetof(struct pt_regs, r15) },
> > +#endif
> > +     };
> > +     int i, j;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(reg_map); i++) {
> > +             for (j = 0; j < ARRAY_SIZE(reg_map[i].names); j++) {
> > +                     if (strcmp(reg_name, reg_map[i].names[j]) == 0)
> > +                             return reg_map[i].pt_regs_off;
> > +             }
> > +     }
> > +
> > +     pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> > +     return -ENOENT;
> > +}
>
> this is a really neat approach! could we shrink the arch-dependent
> part even further to the reg_map only? so instead of having the
> parse_usdt_arg() in the #ifdef __x86_64__/___i386__ , only the
> reg_map is, and we have an empty reg_map for an unsupported arch
> such that calc_pt_regs_off() does
>

That would reduce the flexibility and will save only a few lines of
code. Different architectures might have their own quirks and reg_map
might not fit all their needs. So I went for a more independent and
flexible approach, even if some loop has to be duplicated.

>         if (ARRAY_SIZE(reg_map) == 0) {
>                 pr_warn("usdt: libbpf doesn't support USDTs on current
> architecture\n");
>                 return -ENOTSUP;
>         }
>
> > +
> > +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
> > +{
> > +     char *reg_name = NULL;
> > +     int arg_sz, len, reg_off;
> > +     long off;
> > +
>
> nit but it took me a moment to notice that you had examples in each
> clause; might be good to have a higher-level comment stating
>
> we support 3 forms of argument description:
>
> - register dereference "-4@-20(%rbp)"
> - register "-4@%eax"
> - constant "4@$71"
>
> I _think_ you mentioned there were other valid arg formats that we're not
> supporting, would be good to be explicit about that here I think; "other
> formats are possible but we don't support them currently".

Yep, sure. Those examples in the comments below are indeed easy to miss.

>
> > +     if (3 == sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off, &reg_name, &len)) {
> > +             /* -4@-20(%rbp) */
> > +             arg->arg_type = USDT_ARG_REG_DEREF;
> > +             arg->val_off = off;
> > +             reg_off = calc_pt_regs_off(reg_name);
> > +             free(reg_name);
> > +             if (reg_off < 0)
> > +                     return reg_off;
> > +             arg->reg_off = reg_off;

[...]
