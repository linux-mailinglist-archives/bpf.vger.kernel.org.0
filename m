Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F355A5558
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 22:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiH2ULU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiH2ULS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 16:11:18 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2983F20;
        Mon, 29 Aug 2022 13:11:15 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso6687950otv.1;
        Mon, 29 Aug 2022 13:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=coRosjD9gelJrEV2YoGWjrUrsYYzPD3GZ/ZhjpCdkmU=;
        b=QdPtSxl3TFO93ukfu1RexSTS9Ot2qal2NwJ0MPgNqGB5D74e+ulx5SCLTwcgUmLsSJ
         vKRJKqHj/xe9wDudalLkGP0xFea3T+5c8YgTLxXFxIRrhvmkEXCK2hYc7h86/RAYAFRr
         NYwVeeKJS+wSPMkx9aeV96zSd3EupsLyu8fm/sOA+QzOUEgsgNfVmdyHEpmshgr6Orwl
         cjFr/duhw+vzICziy5PNsXpBEDM3t7iGNw2hZObBw2PgKAKZhXw1k3CP4Kwy1eem/wqw
         N7sy80UZlmdQP8F4hMuvVIMbqKnRkVmHH0TiZ7jXzyH7kAEA/MTinNcxiZftijOSl53s
         CS5A==
X-Gm-Message-State: ACgBeo2dxHT+95Y3YQN3C1KJTzxExN8x0+ESIADM2kHOCXqfK0ibxiyV
        m/ojM1bTyq2SgVdecshsRtFb3Q++7mvNuwCTdYq+Uz4Q
X-Google-Smtp-Source: AA6agR5Bvw+RNGEMv8abZwAJt8lWnBQhR8+CSsscLfwCd/Nu4ePGjwk5nmwdDH1aAQvjjKHcOQ/qWCw/s1yE80gltk4=
X-Received: by 2002:a9d:6f18:0:b0:638:b4aa:a546 with SMTP id
 n24-20020a9d6f18000000b00638b4aaa546mr7012074otq.124.1661803874410; Mon, 29
 Aug 2022 13:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com> <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com> <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com> <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
 <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com>
 <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com> <CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com>
 <1CA3FC40-BC8D-4836-B3E7-0EB196DE6E66@fb.com> <CAM9d7cg-X6iobbmx3HzCz4H2c20peBVGPt3yf9m3WbqLb5H90A@mail.gmail.com>
 <4E6CFFD5-7048-4F64-8F16-70DD6D081ACF@fb.com>
In-Reply-To: <4E6CFFD5-7048-4F64-8F16-70DD6D081ACF@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 29 Aug 2022 13:11:03 -0700
Message-ID: <CAM9d7cgXdL6nnVXGGxtmrdnu4jSKqORCCT=AViAQqJamkpj7ZQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 12:21 AM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 26, 2022, at 11:25 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Aug 26, 2022 at 2:26 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>
> >>> On Aug 26, 2022, at 2:12 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>>
> >>> On Fri, Aug 26, 2022 at 1:59 PM Song Liu <songliubraving@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On Aug 26, 2022, at 12:30 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >>>>>
> >>>>> On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:
> >>>>>
> >>>>>>> And actually, we can just read ctx->data and get the raw record,
> >>>>>>> right..?
> >>>>>>
> >>>>>> Played with this for a little bit. ctx->data appears to be not
> >>>>>> reliable sometimes. I guess (not 100% sure) this is because we
> >>>>>> call bpf program before event->orig_overflow_handler. We can
> >>>>>> probably add a flag to specify we want to call orig_overflow_handler
> >>>>>> first.
> >>>>>
> >>>>> I'm not sure.  The sample_data should be provided by the caller
> >>>>> of perf_event_overflow.  So I guess the bpf program should see
> >>>>> a valid ctx->data.
> >>>>
> >>>> Let's dig into this. Maybe we need some small changes in
> >>>> pe_prog_convert_ctx_access.
> >>>
> >>> Sure, can you explain the problem in detail and share your program?
> >>
> >> I push the code to
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git/log/?h=test-perf-event
> >>
> >> The code is in tools/bpf/perf-test/.
> >>
> >> The problem is we cannot get reliable print of data->cpu_entry in
> >> /sys/kernel/tracing/trace.
> >
> > Ah, right.  I've realized that the sample data is passed before full
> > initialized.  Please see perf_sample_data_init().  The other members
> > are initialized right before written to the ring buffer in the
> > orig_overflow_handler (__perf_event_output).
> >
> > That explains why pe_prog_convert_ctx_access() handles
> > data and period specially.  We need to handle it first.
>
> Thanks for confirming this. I guess we will need a helper (or kfunc)
> for the raw data.
>
> Shall we make it more generic that we can get other PERF_SAMPLE_*?

I don't think we can (or allow to) get all the sample data but some
would be useful for filtering.  Currently I'm only interested in the raw
data, but ip and page size seem useful too.

So I think it'd be better to have a generic helper rather than a specific
one.  But it'd require some refactoring to get the data before calling
BPF programs.  Let me work on it first.

Thanks,
Namhyung
