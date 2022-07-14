Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502D57487D
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbiGNJUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiGNJUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 05:20:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B253D16;
        Thu, 14 Jul 2022 02:17:31 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bb16so1634820oib.11;
        Thu, 14 Jul 2022 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=F3oRxfi4iYMnvW/pvcTNQHegzRL7rC68EPwBmJ/EtTY=;
        b=P1NIzebve93CTfnu8RPpEKKo6CCqteR1umi8kgJ+5Lh6Jf7vF8QB6zicPZXXMm5M8j
         U9PrKCXMOhH1sbwiuNEZApnjAyy2mKp/76Adng/mCFNJ4KE3lzLFUaU2Vf8nLYif1WAw
         rUtpue1Tk7j5X0pDlcQDyueyl2Wbxxsimg1Z9fjWBGr/730d+q9mRQ7P93J+/wj4ei6U
         5GzXWXE407OK+irJDw89hbNNHeED3h/wwlRXUoRkaOGLnChsr5Y7SwhNPCpzu7UIP6KQ
         mcI6QkEnYMR9hPkuI7oQajILbisc4qvBMoFaVyHB4CduqncBEgO0h6O+5BX5w8aozLEi
         aYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=F3oRxfi4iYMnvW/pvcTNQHegzRL7rC68EPwBmJ/EtTY=;
        b=Biael0ySsp5O5xX5ylR5yew+StznwB2tltp1s6tghsaJ/hpaXc4XWqH0VojVC3nFhO
         VLdTmFcsiTKbkojWBusQZqpt+xGYKFjae49NNbBBOwBu1QmwE73c7FLJvteZZxrU3112
         RYDdCZbbDzVZFd0u/gPUfxRx5mw7XIBKuyJmW4VZtRwrKZUQR4b4qLBHNm14exwEB4Uz
         PnG6wFXB6tT5He3ggBKwVvEljBOhEm8oenhr88Emk2W90H9jS9W01z781DLwVaHHZLxr
         DhoViY2Hk/wQGDh9LcCxaDuTzN7M6d0WJ64S0MBX2gtRNHACXXZk1e0fc623E1rHGhHj
         z2dg==
X-Gm-Message-State: AJIora/DdrZi/ufTWxquyqbj8ZdtSBhgeUFxYEWuKr6LxAiYB7OFuCLV
        X0UZgytFoTCi69UERxO4m0xA9XSBj4PE9PX9L9kU2lm2nPrGkQ==
X-Google-Smtp-Source: AGRyM1voiPTRka4g6Tnhu67eX8MZfU/eH/SH2VVj9wzVWfBpH5NmvSkOa9qWywonJgFad2apZ06CdSUKqXONeHUvoDI=
X-Received: by 2002:a05:6808:bce:b0:337:aaf6:8398 with SMTP id
 o14-20020a0568080bce00b00337aaf68398mr4111400oik.252.1657790250658; Thu, 14
 Jul 2022 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de> <20220703212551.1114923-1-andres@anarazel.de>
In-Reply-To: <20220703212551.1114923-1-andres@anarazel.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jul 2022 11:16:54 +0200
Message-ID: <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <ben@decadent.org.uk>
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

[ CC Ben ]

The Debian kernel-team has integrated your patchset v2.

In case you build without libbfd support there is [1].
So, feel free to take this for v3.

-Sedat-

[1] https://salsa.debian.org/kernel-team/linux/-/blob/sid/debian/patches/bugfix/all/tools-perf-fix-build-without-libbfd.patch

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
