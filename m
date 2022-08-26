Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738345A30D6
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 23:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiHZVNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 17:13:09 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A5E58A3;
        Fri, 26 Aug 2022 14:13:08 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11e9a7135easo1122458fac.6;
        Fri, 26 Aug 2022 14:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=exgbzKr463Q9s30OYFv8bOmIUD5a1Cxa1f8CavAdtto=;
        b=xBLS/5XHp0du2rpBZ4AywkGWUf3qY+9sIJxQ/8p8FfnNNqCu8aznZrB5KJxghWhL7O
         32KUXDG4A701OoA0MTMwHzvQ1t7jvFO/hjt18qGr0kBSQlOgRsZ/aVvrm3ET7s7P7ygg
         rsoLyeYzt9KeDJ90pS2L2MGqlvb2y/sYiYeOgdVoNrzbsb3pjP6RtajWjk/Pa+90xT10
         byWk2tXHT7MBWYhZuvb0hfdV2disK2r0suRrWGSmu7FNey5hpboewEQQ9XcJz9HL6wj7
         sc6OaVmqJulRxvZHSU1mG1nTmPjdz1WtOcUSenyDa+4NcqjONfp9EXyfUUm0sYuGGkn9
         F45g==
X-Gm-Message-State: ACgBeo1QhWkkW+YAEIiZ3KACgrKUIOfw9KVcxuKEDhaRfWEkASsdW/z5
        xwlG0xPD62kNNTznIGkPPzFcMzcuBgfLKQ5HdYk=
X-Google-Smtp-Source: AA6agR63woA+bAEOlrtqCm2q6aMLtZaoj7yIO7JULzx1FwdY/ColEkTwiUX8lcmxNzJI8DJ1gHiwuH1RN4qPK0qRym8=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr2779792oab.92.1661548387360; Fri, 26
 Aug 2022 14:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com> <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
 <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com> <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com>
In-Reply-To: <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 26 Aug 2022 14:12:56 -0700
Message-ID: <CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 1:59 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 26, 2022, at 12:30 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:
> >
> >>> And actually, we can just read ctx->data and get the raw record,
> >>> right..?
> >>
> >> Played with this for a little bit. ctx->data appears to be not
> >> reliable sometimes. I guess (not 100% sure) this is because we
> >> call bpf program before event->orig_overflow_handler. We can
> >> probably add a flag to specify we want to call orig_overflow_handler
> >> first.
> >
> > I'm not sure.  The sample_data should be provided by the caller
> > of perf_event_overflow.  So I guess the bpf program should see
> > a valid ctx->data.
>
> Let's dig into this. Maybe we need some small changes in
> pe_prog_convert_ctx_access.

Sure, can you explain the problem in detail and share your program?

>
> > Also I want to control calling the orig_overflow_handler based
> > on the return value of the BPF program.  So calling the orig
> > handler before BPF won't work for me. :)
>
> Interesting. Could you share more information about the use case?

Well.. it's nothing new.  The bpf_overflow_handler calls the
orig_overflow_handler (which writes the sample to the buffer)
only if the BPF returns non zero.  Then I can drop unnecessary
samples based on the sample data by returning 0.

The possible use cases are
1. when you want to sample from specific code ranges only
2. when hardware sets specific bits in raw data

Thanks,
Namhyung
