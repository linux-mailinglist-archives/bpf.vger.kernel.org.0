Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CBD56D0A4
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGJRxP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGJRxO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 13:53:14 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2081055C;
        Sun, 10 Jul 2022 10:53:12 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso4444182fac.7;
        Sun, 10 Jul 2022 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eSwcZesmzsEIOMZznmFtXUZFeRKLoTj+6EmfyIc9CJ0=;
        b=lukMb3WrJZnRVKi08+l/vnzxS7gK18/l3x4wMmDHbWNmHmDMY5VcmHt40eTeMDmulq
         Is6DaZ/pWaA/iZQv7rx4ohUI+as5x0Vh3Vm934TFqF/V10ZtFqQE3M4rsmLmakZr0tRB
         SV1qb7tm3RyHMZjDIrsqj5a9Qz7t/SND8kWGmbTrBONc5q+m29A1cQdi+EwA57uki6OR
         AnjgbwbNlFjAbel4NFLFfzoiP2rbp5t/0fWBtLFBFQMFGg8SdVDQauilForHInEZlPLv
         oiYFsHtt9ZxqQovj0wRPmMucscTh3hK18y325vP8/OwqojPVtttETB8d2oFY8NzK+PEA
         OJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eSwcZesmzsEIOMZznmFtXUZFeRKLoTj+6EmfyIc9CJ0=;
        b=VHvatbXaM4qGpxfvNM0GQB/2HQovFE8FUiuU6lRpDJuL9KtzEI2Tto7UStkS7Wb2Ct
         GzmyH7KHy79VhhvmPOaOTPmpd/UXeBOdkqbKrCIikZ+IFuKq010JpuUlXvqCvnAAutYF
         EjuR+JzbRAs9jfyUvkIx9Ek1U/TA3cRsGQ5sOpC/2Ezkqwq/8MbntmZhswuqK2Lk9rOt
         pnJnisuvio/sH8yr+U9KcCpV8hTkcswybFu+AteQ4F8qUKVGCrixi8Gclsr3oF4DDtLx
         oUzfdzL+TbDqfXm/n6W4sdZihbw51DtCN2SCgLWJ8ooAlUGu55e4HW/muf/y5nz15pZ5
         u9eQ==
X-Gm-Message-State: AJIora9RV0D/y0BsgjsLUyBiTp0dtxNI7TdBBI2BHiBrnxQgCrT5VYlw
        9ob2gaIYuMGx28j4Z5Z+YpEq5Bb8Wlk8P3cTdI0=
X-Google-Smtp-Source: AGRyM1tnkeq2oBx0pSKbTlrm3liHRSCnqKw+CZZmwtMuiDcKeNzy5EQR+FOOYpHycH4jYWmWlJKcfnDT+Xnm5qs0hFM=
X-Received: by 2002:a05:6870:709f:b0:fe:2006:a858 with SMTP id
 v31-20020a056870709f00b000fe2006a858mr5405754oae.128.1657475592193; Sun, 10
 Jul 2022 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de> <CA+icZUVgLh=x-mWmvuQaCBO-eH5ebnA_rTDqnb+1oJVzVO=hmQ@mail.gmail.com>
In-Reply-To: <CA+icZUVgLh=x-mWmvuQaCBO-eH5ebnA_rTDqnb+1oJVzVO=hmQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jul 2022 19:52:36 +0200
Message-ID: <CA+icZUV=dVFADBS4cEnQKWRQhy7LCVXzNQQQX92Gbd5M53c-cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
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

On Sun, Jul 10, 2022 at 1:43 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 3, 2022 at 11:25 PM Andres Freund <andres@anarazel.de> wrote:
> >
> > binutils changed the signature of init_disassemble_info(), which now causes
> > compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> > binutils commit:
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> >
>
> HI,
>
> what was the base for this patchset?
> I tried with Linux v5.19-rc5 and it doesn not apply cleanly.
>

More coffee.

$ egrep 'Auto-detecting|disassembler' make-log_perf-python3.10-install_bin.txt
15:Auto-detecting system features:
36:...        disassembler-four-args: [ on  ]
37:...      disassembler-init-styled: [ on  ]

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

>
> > I first fixed this without introducing the compat header, as suggested by
> > Quentin, but I thought the amount of repeated boilerplate was a bit too
> > much. So instead I introduced a compat header to wrap the API changes. Even
> > tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> > looks nicer this way.
> >
> > I'm not regular contributor, so it very well might be my procedures are a
> > bit off...
> >
> > I am not sure I added the right [number of] people to CC?
> >
> > WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> > nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> > in feature/Makefile and why -ldl isn't needed in the other places. But...
> >
> > V2:
> > - split patches further, so that tools/bpf and tools/perf part are entirely
> >   separate
> > - included a bit more information about tests I did in commit messages
> > - add a maybe_unused to fprintf_json_styled's style argument
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > To: bpf@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> > Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
> >
> > Andres Freund (5):
> >   tools build: add feature test for init_disassemble_info API changes
> >   tools include: add dis-asm-compat.h to handle version differences
> >   tools perf: Fix compilation error with new binutils
> >   tools bpf_jit_disasm: Fix compilation error with new binutils
> >   tools bpftool: Fix compilation error with new binutils
> >
> >  tools/bpf/Makefile                            |  7 ++-
> >  tools/bpf/bpf_jit_disasm.c                    |  5 +-
> >  tools/bpf/bpftool/Makefile                    |  7 ++-
> >  tools/bpf/bpftool/jit_disasm.c                | 42 ++++++++++++---
> >  tools/build/Makefile.feature                  |  4 +-
> >  tools/build/feature/Makefile                  |  4 ++
> >  tools/build/feature/test-all.c                |  4 ++
> >  .../feature/test-disassembler-init-styled.c   | 13 +++++
> >  tools/include/tools/dis-asm-compat.h          | 53 +++++++++++++++++++
> >  tools/perf/Makefile.config                    |  8 +++
> >  tools/perf/util/annotate.c                    |  7 +--
> >  11 files changed, 137 insertions(+), 17 deletions(-)
> >  create mode 100644 tools/build/feature/test-disassembler-init-styled.c
> >  create mode 100644 tools/include/tools/dis-asm-compat.h
> >
> > --
> > 2.37.0.3.g30cc8d0f14
> >
