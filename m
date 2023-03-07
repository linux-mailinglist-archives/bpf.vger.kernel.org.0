Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B526AE76C
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCGQ5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCGQ45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 11:56:57 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F795615B;
        Tue,  7 Mar 2023 08:53:09 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id v101so12069489ybi.2;
        Tue, 07 Mar 2023 08:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/gBRXb85me+1FkZga1hHDiW80ClQBScKHoPc4rOx7U=;
        b=QFW4hRUoZL8060muDNaB9ki4SvmVpZe77FKBLsjxJp2lZJVko8Y6pQu2h91eRPaQJg
         kbjOaomx15eHuYpghlokmPbrhaONQvbjvjuHIA8AYoUJOt1oQ5XC67qb8KLCu/7kHGuV
         D2S/a4ECdOhzwPkllKvNfVojozs982xNKFi1X6RlsSSlt6nHmo6M+BA9vsAWaa/yaUcC
         tcVP/tMAM59X9zRMu43b2/FRmt/AIqajiH1UdP9VyKX+9b3CxKeJ9KQWlZA5RUR4cyjz
         fcNiWxodUNHXF6iCmQYrEC+FoGMHVbA3oP+YDLu8zSQ4UAo4QuOffQdpmVCymrB+SNRF
         cJ0g==
X-Gm-Message-State: AO0yUKVuBaZ5gVxykzg7zAhKAIkNgMgNO5JtX/kM9qdMl1mlOmM4B9/2
        cV4wfJeVTld2lDiNfzREPf6b/cfgBfx4teeSOQM=
X-Google-Smtp-Source: AK7set8tfjwpzQZQScNYBcN4iSNxac+Y9AyRsU8j+6uBk2WxKvaFCooRfM+pMbzRDq0D2AUizmGWvySr43aDph3iyXM=
X-Received: by 2002:a5b:384:0:b0:a65:8cd3:fc4 with SMTP id k4-20020a5b0384000000b00a658cd30fc4mr8914549ybp.5.1678207988110;
 Tue, 07 Mar 2023 08:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20230307032117.3461008-1-irogers@google.com> <CAM9d7ci6FWx2oYAbqhVW2-tjB4p8ji3w87n-ndwxidMov+kVZw@mail.gmail.com>
 <CAP-5=fUQNimNSKjwZaCASyikjXJXBZdw7Z=APYEB4RyX-dXMfQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUQNimNSKjwZaCASyikjXJXBZdw7Z=APYEB4RyX-dXMfQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Mar 2023 08:52:57 -0800
Message-ID: <CAM9d7ciO8EYQ_5GoNzRiR=-HWK6K0ihceL+pA4En1N0bhL3TVA@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Fix builtin detection
To:     Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 6, 2023 at 9:56 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Mar 6, 2023 at 8:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Mon, Mar 6, 2023 at 7:21 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > __has_builtin was passed the macro rather than the actual builtin
> > > feature.
> >
> > Oh, I missed it's a macro define in tools/lib/bpf/bpf_core_read.h file.
> >
> > Looking at some BPF test codes, it seems you also need to check the
> > clang compiler version.  Please take a look at the file below:
> >
> >   tools/testing/selftests/bpf/progs/test_core_reloc_type_base.c
> >
> > Thanks,
> > Namhyung
>
> Hmm..
>
> tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c:
> ...
>        /* Support for the BPF_TYPE_MATCHES argument to the
>         * __builtin_preserve_type_info builtin was added at some point during
>         * development of clang 15 and it's what we require for this test.
>         */
> #if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
> ...
>
> I'm not sure we need to worry about development clang builds and just
> the __has_builtin is cleaner. Perhaps the BPF folks can chime in.

My understanding is that __builtin_preserve_type_info is supported
before.  But clang 15 added BPF_TYPE_MATCHES which is used for
bpf_core_type_matches().  So just checking the builtin would not work.

Thanks,
Namhyung
