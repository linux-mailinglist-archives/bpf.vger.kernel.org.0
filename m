Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754D564736
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGCLzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCLzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 07:55:19 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBB6385;
        Sun,  3 Jul 2022 04:55:18 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10be7325c29so2345357fac.0;
        Sun, 03 Jul 2022 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=37BxPAvRpgzAahfLr9eYj1uTgiO8CqHg56N7QtGc68w=;
        b=LQI+d58sh0nRT3/F5wsYXx7/C7lJK1H3ixr1NvYY8aLHoYrAP1vs9tijIPZ8455vds
         MqfhXZXvWWx+QAZVVDKvOZ9oARyB6ug8CJqaSj7H/YI/i4q3BHuFDkz8AMTzUsx1V4IR
         W8aV1hwvumoPhfJ5YeqbRNf82/QButc2T5UWpCtOJds589EYrOLo1NqjWhuQM9SPZwb3
         GzO6p9kgRpnwL6JVkoz1gYy6QhPQ7dMpi58mvMjGIVfuFnxowE/VvdvuFYUKSi4K8ytr
         rlMzDdAmjUoroYSmuU5gdg51TPHymS0k7MVoYuFQakhD1BqTh8H19HHnic7LrIvgfQw/
         zH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=37BxPAvRpgzAahfLr9eYj1uTgiO8CqHg56N7QtGc68w=;
        b=t7++k3/CCpevQJ1BlL2DWBWS3ZOlxHLZTNE0/33QrXtQl6Y8E44r31yMgLMyrLLJ27
         bQfVYzqKN+TkrNVdtX4xOWCHzCLplV8WItRr/+swnfxVJ6/oSMvtGn/24+kYp95ZhU7U
         n8TrOCfgz8hWvpsA3Nxn2sbaX0y7jfib4UdPLUS6fGOZ3Gc40wBWAu28bC5nOSMF/P4g
         rw4sLiRszgX4/W6cBeRkBu0eJL3pTBV20ipfJ49WaN4IleKbLDHXGOzwrJcEpemeO73b
         JIewybpp4v0sw+UxB6SD3RroUON78YlIkBAskEYrrYcpfbWMA/H7CQQIjU/E+32Skyu8
         R1FQ==
X-Gm-Message-State: AJIora9rt7sL5VzldtRhN31iJi6qBVrgW3y5+HXcsUh/fDCrRyiwuptO
        WX0BdNTovxR1qmbkA8082c10m4YMiJPh24dK4gM=
X-Google-Smtp-Source: AGRyM1taASuXYGInEDySzLnL7JzrXZR1a5hNDkrbI5YYGJQ5H16JM6gjhDlLx5h8Z2mqh/jm02bm3Kis/TzQzLTeKLo=
X-Received: by 2002:a05:6870:7a9:b0:10b:f5ef:5d27 with SMTP id
 en41-20020a05687007a900b0010bf5ef5d27mr625571oab.252.1656849317715; Sun, 03
 Jul 2022 04:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com> <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
In-Reply-To: <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 13:54:41 +0200
Message-ID: <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

On Sun, Jul 3, 2022 at 1:06 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 3, 2022 at 1:03 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sun, Jul 3, 2022 at 12:57 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > [ ... ]
> > > util/annotate.c:1766:33: error: too few arguments to function call,
> > > expected 4, have 3
> > >                              (fprintf_ftype) fprintf);
> > >                                                     ^
> > > /usr/include/dis-asm.h:472:13: note: 'init_disassemble_info' declared here
> > > extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
> > >            ^
> > > 1 error generated.
> > > make[4]: *** [/home/dileks/src/linux/git/tools/build/Makefile.build:97:
> > > util/annotate.o] Error 1
> >
> > This is with Debian's binutils(-dev) version 2.38.50.20220629-4.
> >
> > $ dpkg -S /usr/include/dis-asm.h
> > binutils-dev: /usr/include/dis-asm.h
> >
>
> [ /usr/include/dis-asm.h ]
>
> 470 /* Method to initialize a disassemble_info struct.  This should be
> 471    called by all applications creating such a struct.  */
> 472 extern void init_disassemble_info (struct disassemble_info *dinfo,
> void *stream,
> 473                                    fprintf_ftype fprintf_func,
> 474                                    fprintf_styled_ftype
> fprintf_styled_func);
>

[ CC Andres F. + bpf folks ]

The patch-series from Andres Freund from [1] fixes the issue for me on
Debian/unstable AMD64:

[PATCH v1 0/3] tools: fix compilation failure caused by
init_disassemble_info API changes
[PATCH v1 1/3] tools build: add feature test for init_disassemble_info
API changes
[PATCH v1 2/3] tools: add dis-asm-compat.h to centralize handling of
version differences
[PATCH v1 3/3] tools: Use tools/dis-asm-compat.h to fix compilation
errors with new binutils

Compile-tested only (LLVM-14 x86-64).

link="https://lore.kernel.org/lkml/20220703044814.892617-1-andres@anarazel.de/"
b4 -d am $link

Andres, you have some test-cases how you verified the built perf is OK?

Thanks, Andres.

-Sedat-

[1] https://lore.kernel.org/lkml/20220703044814.892617-1-andres@anarazel.de/
[2] https://lore.kernel.org/lkml/CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com/
