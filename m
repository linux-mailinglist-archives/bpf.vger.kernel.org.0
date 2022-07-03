Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB05649B5
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiGCUdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCUdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 16:33:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C953E4E;
        Sun,  3 Jul 2022 13:33:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u9so10671127oiv.12;
        Sun, 03 Jul 2022 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2PUhWfZc3p2YXMAKoio4BDMIJ06qnc6OlgAm/kn0KR0=;
        b=OfYoDLvUL4nRDDq2GmJqrjYl/uboy4OIfsOfVDj37Zrb+3yVDAqttf8SOM55V+9R49
         Cx0SY7CYKp15LIOnPNY63gpjeG5Trto/EqPWe1dUMApbNGckCD7bWa9mzhWgNW6V6E4z
         tyzlRfORsGv3o89t7hUWt6M+AtOribURsEssQqwIAlAj11MyDS4vTSLTxGOnqnDnBejn
         7mVc0Y8fAJS0GXvYweAyoFx2b3OqLOZ9Dil6GC4w8KKD4FCZ8GJYYqHmhvPssmo5ayNs
         g7koeXU17WR3LCU3pf9F21iUp9C330IksunMduBq8ixKKkpi924eBkw70jAu0e6cJq9V
         sizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2PUhWfZc3p2YXMAKoio4BDMIJ06qnc6OlgAm/kn0KR0=;
        b=zco26OQDS/tRfauZ6CtZFyvH16riPle9MuSegQKktHrVh/V1sTmIlPcJvxnjuv+PyW
         8ojaR3TObeawI2LkT6+kFVyOnuKjI+ICQehY0rWE6rfutjBvirYS2q5nbGz4hT1jIfsu
         V1S7toU9hNvogUACtXogaZMHGzVCnYlNUK02HVealJYZy88rHajXIJ89qIqmU/PVL7aJ
         tiH2WTnI8dr31GJAagT/UcIq8tFTrvee6cy45BOhRObXikmoF8ZxUclArc/s8n6yzaV1
         MyajvUpV2YsgpgKkLq+KMUGu0y9FqUY8JHODrcN/Ylp2dC1pzbdpdRXddpRv8b54s0ux
         dbZA==
X-Gm-Message-State: AJIora+u/30XikvQ5/2OCHJ7B+tLX6w9tn49RbFg+25ugjLUURe5G3uh
        GwfM0R7wjG1v+LXNoWe5WrGGT8sSwtwpmnbHKRw=
X-Google-Smtp-Source: AGRyM1vToBjxwcvpqzLIlarl+LkzS3pEYk3QPkPVF03n+JGdfCbEfTk/mBNgHJ0DTLhLaXRsiW5tUpLK5jgm3BB2BJY=
X-Received: by 2002:a05:6808:bce:b0:337:aaf6:8398 with SMTP id
 o14-20020a0568080bce00b00337aaf68398mr4632958oik.252.1656880382680; Sun, 03
 Jul 2022 13:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
 <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
 <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
 <1496A989-23D2-474D-B941-BA2D74761A7E@gmail.com> <20220703165448.7d2akxawzdvqigat@awork3.anarazel.de>
 <F7CCD284-0DEF-444F-B58F-930678EC2644@gmail.com>
In-Reply-To: <F7CCD284-0DEF-444F-B58F-930678EC2644@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 22:32:26 +0200
Message-ID: <CA+icZUXDaDM2w+YT4EDjgv5uzkh+SYTH6v3PrsLYsvYB2Gw2zw@mail.gmail.com>
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andres Freund <andres@anarazel.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Sun, Jul 3, 2022 at 7:47 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On July 3, 2022 1:54:48 PM GMT-03:00, Andres Freund <andres@anarazel.de> wrote:
> >Hi,
> >
> >On 2022-07-03 10:54:45 -0300, Arnaldo Carvalho de Melo wrote:
> >> That series should be split a bit further, so that the
> >> new features test is in a separate patch, i.e. I don't process bpftool patches, but can process the feature test and the tools/perf part.
> >
> >Ok, will split it further. Should I do
> >
> >1) feature test
> >2) introduce compat header header
> >3) use feature test, use header in perf/
> >4) use feature test, use header in bpf/
> >
> >Or should 3, 4 be split to separately introduce the feature test and use of
> >the compat header?
>
> I think 4 patches are ok,
>

Andres can you CC me on a new patchset?
Thanks.

-sed@-
