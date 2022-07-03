Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAE564797
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiGCNzA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiGCNy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 09:54:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210AF47;
        Sun,  3 Jul 2022 06:54:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n66so787385oia.11;
        Sun, 03 Jul 2022 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=RjnBMrtfuHQRRhx/4U3UDDe42R12Gk4NKxVlso+Ig5o=;
        b=nlm9rri0/2SNXvn8rTnkl1gyOBNgfx3L9Oy6c2sRHEoeVlIpcFI3U/grg9igVFhZqt
         21OHjnlP+U8MI/p26kos9R1W/bCjFNzirwY/zA9YmaB2J5UwEMd0qn6MryG4lOhXQKgS
         tzoHhCCbpprMpq84xZUtA6Dmd0aLkXmu9UdLr9GR1j+xdHM2/DvTzgwZUaNB9lCuGD5i
         qzf8I+FzsxYU7T2dZAJF+OcCygQIc3vhEVVLePZ1fVZjJrUHG+FYqrmolxSEPklVm8S7
         9gkm3eHUY5FS67N3XN6HmsyG27l/CERDYBkpC5ZsWaxKEL+9whenpQ8g7NJIBbR7bW/U
         1WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=RjnBMrtfuHQRRhx/4U3UDDe42R12Gk4NKxVlso+Ig5o=;
        b=W4qWtJaMe3keolQLXa+yP5+tV5Ko2FsIudrlHCj9o4eQpo1ENjpkNX6H7/tPMpwLHh
         6tPl3dFPJByUamF7xt/wGG0eEcBzDmTg3CFcE0kh3dejEBofktKWCBwzKNu71sZISzYl
         is98oEYyBMn20rluyizjLOw4Zoaeqw+IdFctklCSpeDb+eTPiVjXagfcqG5H0Bz1j1kZ
         o8tnsd1jeomg6Y3Blq9IsIiMFZ8u76xlA0YYm3zhZQQ3eUHtxWDOb6sO79f8WXirf3uA
         Jv8uSl+3bjaaBLMzVLt7yh3Rna/9c5gbLqAbot1AMKXOMNmy3R1dNGFumHcVmA/bhSmE
         2iZA==
X-Gm-Message-State: AJIora+2c9qKmMkyrsThdE9Qyrs8F5NGZ6i/PyMQmVxXN2b7/UBJ7YE2
        lyy/Awqev0ICqarzUxq/IiXyz1ZXldM=
X-Google-Smtp-Source: AGRyM1uOfH2YgNUAJvWKgiRwJksiZR6thmzKqC/Gpt3afzUnoNtF+TTAek2Zm1OrwyufXpWFQwrsHA==
X-Received: by 2002:aca:38c6:0:b0:32f:2477:2ec6 with SMTP id f189-20020aca38c6000000b0032f24772ec6mr14181068oia.66.1656856496039;
        Sun, 03 Jul 2022 06:54:56 -0700 (PDT)
Received: from [127.0.0.1] (187-26-175-65.3g.claro.net.br. [187.26.175.65])
        by smtp.gmail.com with ESMTPSA id v202-20020acaacd3000000b0033326435494sm13376881oie.41.2022.07.03.06.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:54:55 -0700 (PDT)
Date:   Sun, 03 Jul 2022 10:54:45 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     sedat.dilek@gmail.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>
CC:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bperf-tools=5D_Build-error_in_too?= =?US-ASCII?Q?ls/perf/util/annotate=2Ec_with_LLVM-14?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com> <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com> <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com> <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
Message-ID: <1496A989-23D2-474D-B941-BA2D74761A7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On July 3, 2022 8:54:41 AM GMT-03:00, Sedat Dilek <sedat=2Edilek@gmail=2Ec=
om> wrote:
>On Sun, Jul 3, 2022 at 1:06 PM Sedat Dilek <sedat=2Edilek@gmail=2Ecom> wr=
ote:
>>
>> On Sun, Jul 3, 2022 at 1:03 PM Sedat Dilek <sedat=2Edilek@gmail=2Ecom> =
wrote:
>> >
>> > On Sun, Jul 3, 2022 at 12:57 PM Sedat Dilek <sedat=2Edilek@gmail=2Eco=
m> wrote:
>> > [ =2E=2E=2E ]
>> > > util/annotate=2Ec:1766:33: error: too few arguments to function cal=
l,
>> > > expected 4, have 3
>> > >                              (fprintf_ftype) fprintf);
>> > >                                                     ^
>> > > /usr/include/dis-asm=2Eh:472:13: note: 'init_disassemble_info' decl=
ared here
>> > > extern void init_disassemble_info (struct disassemble_info *dinfo, =
void *stream,
>> > >            ^
>> > > 1 error generated=2E
>> > > make[4]: *** [/home/dileks/src/linux/git/tools/build/Makefile=2Ebui=
ld:97:
>> > > util/annotate=2Eo] Error 1
>> >
>> > This is with Debian's binutils(-dev) version 2=2E38=2E50=2E20220629-4=
=2E
>> >
>> > $ dpkg -S /usr/include/dis-asm=2Eh
>> > binutils-dev: /usr/include/dis-asm=2Eh
>> >
>>
>> [ /usr/include/dis-asm=2Eh ]
>>
>> 470 /* Method to initialize a disassemble_info struct=2E  This should b=
e
>> 471    called by all applications creating such a struct=2E  */
>> 472 extern void init_disassemble_info (struct disassemble_info *dinfo,
>> void *stream,
>> 473                                    fprintf_ftype fprintf_func,
>> 474                                    fprintf_styled_ftype
>> fprintf_styled_func);
>>
>
>[ CC Andres F=2E + bpf folks ]
>
>The patch-series from Andres Freund from [1] fixes the issue for me on
>Debian/unstable AMD64:
>
>[PATCH v1 0/3] tools: fix compilation failure caused by
>init_disassemble_info API changes
>[PATCH v1 1/3] tools build: add feature test for init_disassemble_info
>API changes
>[PATCH v1 2/3] tools: add dis-asm-compat=2Eh to centralize handling of
>version differences
>[PATCH v1 3/3] tools: Use tools/dis-asm-compat=2Eh to fix compilation
>errors with new binutils
>
>Compile-tested only (LLVM-14 x86-64)=2E
>
>link=3D"https://lore=2Ekernel=2Eorg/lkml/20220703044814=2E892617-1-andres=
@anarazel=2Ede/"
>b4 -d am $link
>
>Andres, you have some test-cases how you verified the built perf is OK?


That series should be split a bit further, so that the=20
new features test is in a separate patch, i=2Ee=2E I don't process bpftool=
 patches, but can process the feature test and the tools/perf part=2E

Thanks Sedat for drilling deeper, identifying Andres work as a cure, thank=
s to Andres for that patch kit!

- Arnaldo=20
>
>Thanks, Andres=2E
>
>-Sedat-
>
>[1] https://lore=2Ekernel=2Eorg/lkml/20220703044814=2E892617-1-andres@ana=
razel=2Ede/
>[2] https://lore=2Ekernel=2Eorg/lkml/CA+icZUVVXq0Mh8=3DQuopF0tMZyZ0Tn8AiK=
EZoA3jfP47Q8B=3Dx2A@mail=2Egmail=2Ecom/
