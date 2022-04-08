Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DFE4F9F82
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiDHWRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiDHWRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:17:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B913F27
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:15:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 125so12218855iov.10
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMOBfx+OgNdBgFsizQrUpmz2Ea0FlhPkFaNguHX+kHs=;
        b=BH/kX4qglD5COKqEZdVMMaJHhjarDSUitQP/Y6Ayqrac3PquJyPpkbEDQh1XGuG3Vs
         Tgm3QluX0OKHeehzlrBAkBc1OB0uv80F2ksu8H2VtYtRdMBBZKHS095T0+Tdi+Y5PCJi
         cLyanaW01iMFo4alp5oyZgKimCjiklsDDg3vWSDkJ2gHOCopRYms32z1jwKvL9AWqgdV
         sTkBOpT6uBoM9O1BVMLcS4yLLgf9nU1kA6RPlpYscrxte4fVbaMRZrvlpOWTVDAwRQAJ
         EnQmfqlZ8bXiLXUS56HyZtvj4E68Azjyhm6otHZxLNFh+B6YgNVg/tYlbzNoX5pbD+74
         MEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMOBfx+OgNdBgFsizQrUpmz2Ea0FlhPkFaNguHX+kHs=;
        b=FHoidJA842osHn6O61ryj0l5ANvzjtW0TEONzfeczlbL4jodnREaBG610TS9DO9/Mm
         jmKVsTY3kpt2QlrrMS2Vwsv3dZVxcOYwIhL7uqWaA7n97DsuR37exinpwYFYsCrlVN3A
         tj0E6kF5J4P7dYJ+mrXieRqEPEPKCiytb5hkpH8rUXWU6elWnly+5uBZzDCI5B/gQye0
         JPL5dmH2AtrGGaGlKOJq3F0TR/Axp86eSR+aum9+NJEb0OIw9W2//oq2+cXNA4OxpKZM
         HYQApWspl0EvHELdiFw/fpWisGYXJKSbRTlOV4yzLPQzzaVLBY3nX8+gJPe0O9jECFBm
         9zcQ==
X-Gm-Message-State: AOAM531SWs9UcpxjNB9TnYjHpOET45rFvrIus+lhWverc7bX69P1Et80
        58fQEXieAJZk9qaCqvfeatEJUlkHCKIa6pN/H7w=
X-Google-Smtp-Source: ABdhPJzjKIm9cg2qH2xSgkJpGx1uu7m29QKYpx1R2/fzC42g1pIs/No2kDEex0L57g1GEX4eL3WjglIM8fNd+S/LTTs=
X-Received: by 2002:a6b:7d44:0:b0:64c:ab1b:a8a6 with SMTP id
 d4-20020a6b7d44000000b0064cab1ba8a6mr9255882ioq.63.1649456133453; Fri, 08 Apr
 2022 15:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220406203655.235663-1-mykolal@fb.com>
In-Reply-To: <20220406203655.235663-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 15:15:22 -0700
Message-ID: <CAEf4BzaRZgG0+Svq6N4H1_Ru6e6254m=w5ZHjORWctmVa3KZjQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Improve by-name subtest
 selection logic in prog_tests
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Apr 6, 2022 at 1:37 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Improve subtest selection logic when using -t/-a/-d parameters.
> In particular, more than one subtest can be specified or a
> combination of tests / subtests.
>
> -a send_signal -d send_signal/send_signal_nmi* - runs send_signal
> test without nmi tests
>
> -a send_signal/send_signal_nmi*,find_vma - runs two send_signal
> subtests and find_vma test
>
> -a 'send_signal*' -a find_vma -d send_signal/send_signal_nmi* -
> runs 2 send_signal test and find_vma test. Disables two send_signal
> nmi subtests
>
> -t send_signal -t find_vma - runs two *send_signal* tests and one
> *find_vma* test
>
> This will allow us to have granular control over which subtests
> to disable in the CI system instead of disabling whole tests.
>
> Also, add new selftest to avoid possible regression when
> changing prog_test test name selection logic.
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

Unfortunately there is some regression introduced by these changes,
which is not easy to spot unless you try hard because of the annoying
lack of visibility into subtest results. But if you try running:

sudo ./test_progs -v -t bpf_cookie/trace

You'll notice that with our change we don't execute any subtest at
all. While before we'd execute bpf_cookie/tracepoint subtest properly.
Please take a look, must be some subtle thing somewhere.

>  .../selftests/bpf/prog_tests/arg_parsing.c    |  99 +++++++++++
>  tools/testing/selftests/bpf/test_progs.c      | 156 +++++++++---------
>  tools/testing/selftests/bpf/test_progs.h      |  15 +-
>  tools/testing/selftests/bpf/testing_helpers.c |  84 ++++++++++
>  tools/testing/selftests/bpf/testing_helpers.h |   8 +
>  5 files changed, 275 insertions(+), 87 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arg_parsing.c

[...]
