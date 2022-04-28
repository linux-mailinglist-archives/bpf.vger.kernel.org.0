Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3F513F3F
	for <lists+bpf@lfdr.de>; Fri, 29 Apr 2022 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352062AbiD2ABc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 20:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiD2ABc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 20:01:32 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90565A146B;
        Thu, 28 Apr 2022 16:58:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bu29so11386676lfb.0;
        Thu, 28 Apr 2022 16:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rR2AHn1fOSi5hV4vrs/QaVZIY7aylHWPRMPw6poMIIg=;
        b=e4kyE2iXPupltrFo3TMETa9qW7HZ11eYOLHYnjYsk8sFymrHoC5TEf4j7likzQM3mw
         Utx8KlMxU3oAxDXgNDlmFecTkxbxAu0gJ3nKp7775qWWGKT/DCM25hjAgbMlfq+g1Thn
         Ke4PUW/1s5ah+t4yZqqcLA06XyGzJ6jXOa4PvWJB/WBCMA02Y2Sb83JZeWeHl5dc7o1c
         tsZj7i2pbkj7i4zh5e3+I2KHWj92dmZ2Boh4dRaSBrDyi3isVhu/W8e6WTrR7QGDY5jM
         9vgKIHJLQEWwZckg9iv6P+Lgv/ULA0wDUWazDqoUunXW6+QAjnKFqjAmA+2HfC24/mnU
         tCHQ==
X-Gm-Message-State: AOAM5308Qd6SymMR4JPQz17FHI6FFcHHyBUJ3WlaJFzbpsrDv5evGrUB
        TOpNcpx80uL2e0MVH8FhdVu+UVX4M7NxOLn123B4cU2u
X-Google-Smtp-Source: ABdhPJzWVQpcKMT9CQ/MN7RHeoE6kcNOnrCdNJ1v3Ux+rJIt9AEnSbqN+mLMZbSrTfW2BWrXchjsY0FaqD8eqXcTrhQ=
X-Received: by 2002:a19:6744:0:b0:46d:185f:5322 with SMTP id
 e4-20020a196744000000b0046d185f5322mr24355302lfj.586.1651190293568; Thu, 28
 Apr 2022 16:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220422150507.222488-1-namhyung@kernel.org> <20220422150507.222488-5-namhyung@kernel.org>
 <CAEf4Bzbdh-wbQQLzoXGGKkqqE=+qz19C4tCq4Ynb-_PXzRYM1w@mail.gmail.com>
 <CAM9d7chos3xgxPMOMwgSh6nCNfqk8k2tXO=0JsdL4KgN_yngCA@mail.gmail.com> <CAEf4BzZ-RwXV8NoWk4rLyLWyxJhQ6b96ieVCy0kkjLCq8cVxqw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ-RwXV8NoWk4rLyLWyxJhQ6b96ieVCy0kkjLCq8cVxqw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 28 Apr 2022 16:58:02 -0700
Message-ID: <CAM9d7ciZcsTD7oK5JQA5PJ3gDHcN+Fzon=gVoPvyRb4yLzVF7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf record: Handle argument change in sched_switch
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 27, 2022 at 12:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 27, 2022 at 11:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > Actually I tried something similar but it was with a variable (in bss)
> > so the verifier in an old kernel rejected it due to invalid arg access.
> >
> > I guess now the const makes the verifier ignore the branch as if
> > it's dead but the compiler still generates the code, right?
>
>
> yes, exactly

Then I'm curious how it'd work on newer kernels.
The verifier sees the false branch and detects type mismatch
for the second argument then it'd reject the program?

Thanks,
Namhyung
