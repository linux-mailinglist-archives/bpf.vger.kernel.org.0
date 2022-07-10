Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8956CEC5
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGJLoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 07:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJLoN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 07:44:13 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD937E0DC;
        Sun, 10 Jul 2022 04:44:11 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bffc214ffso3919187fac.1;
        Sun, 10 Jul 2022 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DyMVv84vBtCM5J+ifdj0U3Vmm8grj37O/4bb4oSd5uY=;
        b=NgnvsoTklffVU3+K8LdIiTeiKLfnpJsG3gvmQEo9A1S8PLo8k1bmYDreFX1R9uasa7
         vgrstUP32/w+2hYLEX9SU7TtpBkqXCjj3ba4JZd5uBqGkLdOs4Ro/dgzeROv4SjyX2KZ
         TjvPatgwb4Vf5MMESDrcvEPWAaCtXK65XmzX+a5GgrN8g9MefmNxy7hvXV/L/y8+5Gpj
         xTkh4pihkQl3hDsdQpQSWOPW9YvZwzLjzoyUtdYcLMdvBrLN+SXDj2iAxGjDWRtZrChf
         1C2bmhbDfggb1Mzu9rJnWpd2vBSs2aKro4OmGnESkgEPPoIw82MiMSJ79HaarthG+qYI
         wKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DyMVv84vBtCM5J+ifdj0U3Vmm8grj37O/4bb4oSd5uY=;
        b=aKsUoxWuXO9E0R32ZbSzO9Hnd5fcnFLSBD7L8eruD+n0oHqRHkR8hD27Rg3M6k+6FH
         tkrkROeXpFQIBt+B/dOlRy1niufpLe9Yr9MpbSpuf3qK7dc2fj+u8+oG8Cl5OKrTmF1K
         gDZNlspZ8sFDsgwrT+c0zsAKFAS0mza6pvqU7DkSB6MzCrc2c0BfYri1avw30dMmumOI
         XfS/q4tElzUYynvI+fSgthXaNwFL9WqoPxvjHslhtwLWTm9ZYo9g4+xZBP32Q3X36IWF
         geHUfV3BnsCKAofNQ4+3wsK8lMgaztLlisthNObSgVRGsr8dDAuBo4GPo5wLf4Sz9e/d
         RtUg==
X-Gm-Message-State: AJIora/jW8BUH6bBiy66cl17VGn6PV9khY3wlgmcmO3EW1UvRZzoWOXV
        tSBFl3ldbqqooLQa0VBFnawh1sJ0VEwc8bmWKmk=
X-Google-Smtp-Source: AGRyM1vM51PtNsQAVpd8BUB3r5K2Da/0yb9ad/1kFJ8OiYhN693HqyZuafRc5SVF9H0Ur5LU5FruRU585YfeQ7muPVY=
X-Received: by 2002:a05:6870:709f:b0:fe:2006:a858 with SMTP id
 v31-20020a056870709f00b000fe2006a858mr4787453oae.128.1657453451014; Sun, 10
 Jul 2022 04:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de> <20220703212551.1114923-1-andres@anarazel.de>
In-Reply-To: <20220703212551.1114923-1-andres@anarazel.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jul 2022 13:43:35 +0200
Message-ID: <CA+icZUVgLh=x-mWmvuQaCBO-eH5ebnA_rTDqnb+1oJVzVO=hmQ@mail.gmail.com>
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

On Sun, Jul 3, 2022 at 11:25 PM Andres Freund <andres@anarazel.de> wrote:
>
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
>

HI,

what was the base for this patchset?
I tried with Linux v5.19-rc5 and it doesn not apply cleanly.

Regards,
-Sedat-

> I first fixed this without introducing the compat header, as suggested by
> Quentin, but I thought the amount of repeated boilerplate was a bit too
> much. So instead I introduced a compat header to wrap the API changes. Even
> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> looks nicer this way.
>
> I'm not regular contributor, so it very well might be my procedures are a
> bit off...
>
> I am not sure I added the right [number of] people to CC?
>
> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> in feature/Makefile and why -ldl isn't needed in the other places. But...
>
> V2:
> - split patches further, so that tools/bpf and tools/perf part are entirely
>   separate
> - included a bit more information about tests I did in commit messages
> - add a maybe_unused to fprintf_json_styled's style argument
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> To: bpf@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
>
> Andres Freund (5):
>   tools build: add feature test for init_disassemble_info API changes
>   tools include: add dis-asm-compat.h to handle version differences
>   tools perf: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Fix compilation error with new binutils
>   tools bpftool: Fix compilation error with new binutils
>
>  tools/bpf/Makefile                            |  7 ++-
>  tools/bpf/bpf_jit_disasm.c                    |  5 +-
>  tools/bpf/bpftool/Makefile                    |  7 ++-
>  tools/bpf/bpftool/jit_disasm.c                | 42 ++++++++++++---
>  tools/build/Makefile.feature                  |  4 +-
>  tools/build/feature/Makefile                  |  4 ++
>  tools/build/feature/test-all.c                |  4 ++
>  .../feature/test-disassembler-init-styled.c   | 13 +++++
>  tools/include/tools/dis-asm-compat.h          | 53 +++++++++++++++++++
>  tools/perf/Makefile.config                    |  8 +++
>  tools/perf/util/annotate.c                    |  7 +--
>  11 files changed, 137 insertions(+), 17 deletions(-)
>  create mode 100644 tools/build/feature/test-disassembler-init-styled.c
>  create mode 100644 tools/include/tools/dis-asm-compat.h
>
> --
> 2.37.0.3.g30cc8d0f14
>
