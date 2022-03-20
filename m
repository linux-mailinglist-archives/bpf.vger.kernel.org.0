Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839FC4E1DBB
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiCTUK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbiCTUKY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 16:10:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3E13DEB
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 13:09:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t14so8929716pgr.3
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jEbpuKHWGI2at+4mpoQD2yOjBEvPOdppyiOWfPnwQI=;
        b=QvfzJuerArXUTuDjYjLo8WSNhJNqp7QxbSzIS2KvP3UXvb5eNWXaDHqWSjmM8OUpXQ
         iWZVeBn3bvs1/HROlpdjw/+Dov+7I3mOCk5MyNi6/aJgMUiNsBGde3Bkz21x9Tr3ehNT
         JxRppBA0ReRDeKFGq0gyD7LHQRM4LKxyMjC1RB9uzg9dJUgMbuPCERgV+O9qt49hLYQ3
         vx8VqcyGUht/N9ddhY7V/1xOL/jlghBd/SG7/7Cst2j27x+YsNtVU4DjQILpzPm0WBKr
         46hAHcDn2QgjuVGD72ovrp1o7wBBd2irXZYzj8fdEAIppJp5XSGHMv/3nMCkg1qFKf8O
         +ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jEbpuKHWGI2at+4mpoQD2yOjBEvPOdppyiOWfPnwQI=;
        b=XjnQ6nI3eD0kII3m+zdrmftIBP6G3KTTx/2/foUSsEpyefa1VWECO4y/dBpx2EW/cL
         NuLD+L7G0yW+NhheQV4h9mkcL9y5G14J0JWEpr7LdR1SHLJ7LaDC6K/fhbytjTkOwxW8
         AbsOgQDdSfgAjseFaUKML/15LRNhgVKujqWV3jfFTjS7YzMJv6DkOAhHjnuWC+yQnnuI
         E8tF0ddSyiNqH+3HWMpiHME1UfrsHwvRz9yIz6YjQC3euyymdkOmwdaX2b20XpCtesMI
         ykc35v1bg1gS4kqpn9VL9cqg8WFp5Mfb38i9n8sB62MnViN4jVGCqruEYYMgWFN7hzKN
         TyDg==
X-Gm-Message-State: AOAM5330MyLhrKwrSLt5MJwXlqnunefHjibCtuV36Xaw9ckVEmaDXeP2
        oLdADp3nHwwJKy5G3v/mdH/TfNEApr/p95cqLJLCXcqLwYw=
X-Google-Smtp-Source: ABdhPJwGZjdbe/wFf1DV5xp9vbVEnyLDOfNcwnHe4g/NRO1fsAEFeB9iuOrM70f/DA65AOt4Kthvv6OFCmambf27NAQ=
X-Received: by 2002:aa7:805a:0:b0:4f6:dc68:5d41 with SMTP id
 y26-20020aa7805a000000b004f6dc685d41mr20460596pfm.69.1647806940154; Sun, 20
 Mar 2022 13:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-3-kuifeng@fb.com>
 <20220318190917.tecjespuzkegwb2k@ast-mbp> <cb3507651829d347ffdcd48678b58c323bce99d5.camel@fb.com>
In-Reply-To: <cb3507651829d347ffdcd48678b58c323bce99d5.camel@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Mar 2022 13:08:49 -0700
Message-ID: <CAADnVQJTyjDM-5Mo_R+B0_gj6tZH5zfP9k1dD48h=Nrc7p8rWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf, x86: Create bpf_trace_run_ctx on the
 caller thread's stack
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Sun, Mar 20, 2022 at 2:31 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Fri, 2022-03-18 at 12:09 -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 15, 2022 at 05:42:29PM -0700, Kui-Feng Lee wrote:
> > > BPF trampolines will create a bpf_trace_run_ctx on their stacks,
> > > and
> > > set/reset the current bpf_run_ctx whenever calling/returning from a
> > > bpf_prog.
> > >
> > > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++++++++
> > >  include/linux/bpf.h         | 12 ++++++++----
> > >  kernel/bpf/syscall.c        |  4 ++--
> > >  kernel/bpf/trampoline.c     | 21 +++++++++++++++++----
> > >  4 files changed, 59 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c
> > > b/arch/x86/net/bpf_jit_comp.c
> > > index 1228e6e6a420..29775a475513 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1748,10 +1748,33 @@ static int invoke_bpf_prog(const struct
> > > btf_func_model *m, u8 **pprog,
> > >  {
> > >         u8 *prog = *pprog;
> > >         u8 *jmp_insn;
> > > +       int ctx_cookie_off = offsetof(struct bpf_trace_run_ctx,
> > > bpf_cookie);
> > >         struct bpf_prog *p = l->prog;
> > >
> > > +       EMIT1(0x52);             /* push rdx */
> >
> > Why save/restore rdx?
>
> >
> > > +
> > > +       /* mov rdi, 0 */
> > > +       emit_mov_imm64(&prog, BPF_REG_1, 0, 0);
> > > +
> > > +       /* Prepare struct bpf_trace_run_ctx.
> > > +        * sub rsp, sizeof(struct bpf_trace_run_ctx)
> > > +        * mov rax, rsp
> > > +        * mov QWORD PTR [rax + ctx_cookie_off], rdi
> > > +        */
> >
> > How about the following instead:
> > sub rsp, sizeof(struct bpf_trace_run_ctx)
> > mov qword ptr [rsp + ctx_cookie_off], 0
> > ?
>
> AFAIK, rsp can not be used with the base + displacement addressing
> mode.  Although, it can be used with base + index + displacement
> addressing mode.

Where did you find this?

0:  48 c7 44 24 08 00 00    mov    QWORD PTR [rsp+0x8],0x0
7:  00 00

> >
> > > +       EMIT4(0x48, 0x83, 0xEC, sizeof(struct bpf_trace_run_ctx));
> > > +       EMIT3(0x48, 0x89, 0xE0);
> > > +       EMIT4(0x48, 0x89, 0x78, ctx_cookie_off);
> > > +
> > > +       /* mov rdi, rsp */
> > > +       EMIT3(0x48, 0x89, 0xE7);
> > > +       /* mov QWORD PTR [rdi + sizeof(struct bpf_trace_run_ctx)],
> > > rax */
> > > +       emit_stx(&prog, BPF_DW, BPF_REG_1, BPF_REG_0, sizeof(struct
> > > bpf_trace_run_ctx));
> >
> > why not to do:
> > mov qword ptr[rsp + sizeof(struct bpf_trace_run_ctx)], rsp
> > ?
>
> The same reason as above.

0:  48 89 64 24 08          mov    QWORD PTR [rsp+0x8],rsp
