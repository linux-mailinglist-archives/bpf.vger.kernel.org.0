Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B065966D7B1
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjAQINN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjAQINK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 03:13:10 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1A51E9DF;
        Tue, 17 Jan 2023 00:13:09 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4c24993965eso405670997b3.12;
        Tue, 17 Jan 2023 00:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+0mtXWox6f/NnnSWyWGALB0u87thJNG7mMvXmuR94U=;
        b=jVv02TO18xqJueJSpfPMI3vdvKYnqgActdlCSTTeRg8tML0zLxVOASEEebExnVAFSK
         x+AkVv99/gX/UpvsNEZV/L2sXJffKgXb344ullBC4R/TZNjw1d+EfgrSBx/XRnNgGu+d
         ksxgeSHpxzsLArI1/pqAxFZTfO+wHi+QftoKX27TeaFt/e3lBok3DorzbJEVS+dRz07J
         ochGDGZJUukytIA21gYpkMJ/yDK8YNZRXfIEJVMfKMNgkXfhc9qcWXdMXDnzgmW7Cz9r
         +O2pm6RONrbOshH56w9qV0TVDQuHxsZ/zmfzSdTdRBnjE1hVYxMR3hXJZSBFFENrFnPn
         4Pfw==
X-Gm-Message-State: AFqh2kqCHVkC1cNzai9NHnaMY8Twyyt3YkhvxdZsHPrlbqRMJbi58/Be
        LFCs0g8tqdXydGcPpdfqA30mkyqlUlh26xOUeZM=
X-Google-Smtp-Source: AMrXdXtOYuSh6lqMHf4lazcedbF7svOOcUxTDPnHOBqqLdxedW9YyZez9tERqvrD0JpJAkJzmP2fnEf/We8Ybn+ecHE=
X-Received: by 2002:a81:1609:0:b0:4db:694e:f2be with SMTP id
 9-20020a811609000000b004db694ef2bemr280998yww.390.1673943189034; Tue, 17 Jan
 2023 00:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <Y8Fb45iZ5yp3TUDD@krava>
In-Reply-To: <Y8Fb45iZ5yp3TUDD@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Jan 2023 00:12:57 -0800
Message-ID: <CAM9d7cjUAOhME8jf=sRbzWFcaGssaXRhhL9rwkBxSLjdPaZg8w@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
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

Hi Jiri,

On Fri, Jan 13, 2023 at 5:26 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 01:40:07PM -0800, Namhyung Kim wrote:
> > Hello,
> >
> > The perf_prepare_sample() is to fill the perf sample data and update the
> > header info before sending it to the ring buffer.  But we want to use it
> > for BPF overflow handler so that it can access the sample data to filter
> > relevant ones.
> >
> > Changes in v2)
> >  * the layout change is merged
> >  * reduce branches using __cond_set  (PeterZ)
> >  * add helpers to set dynamic sample data  (PeterZ)
> >  * introduce perf_prepare_header()  (PeterZ)
> >  * call perf_prepare_sample() before bpf_overflow_handler unconditionally
> >
> > This means the perf_prepare_handler() can be called more than once.  To
> > avoid duplicate work, use the data->sample_flags and save the data size.
> >
> > I also added a few of helpers to set those information accordingly.
> > But it looks some fields like REGS_USER, STACK_USER and AUX are saved in
> > the perf_prepare_sample() so I didn't add the helpers for them.
> >
> > After than we can just check the filtered_sample_type flags begin zero
> > to determine if it has more work.  In that case, it needs to update the
> > data->type since it's possible to miss when PMU driver sets all required
> > sample flags before calling perf_prepare_sample().
> >
> > The code is also available at 'perf/prepare-sample-v2' branch in
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> >
> > Thanks,
> > Namhyung
> >
> >
> > Cc: Song Liu <song@kernel.org>
> > Cc: bpf@vger.kernel.org
> >
> >
> > Namhyung Kim (8):
> >   perf/core: Save the dynamic parts of sample data size
> >   perf/core: Add perf_sample_save_callchain() helper
> >   perf/core: Add perf_sample_save_raw_data() helper
> >   perf/core: Add perf_sample_save_brstack() helper
> >   perf/core: Set data->sample_flags in perf_prepare_sample()
> >   perf/core: Do not pass header for sample id init
> >   perf/core: Introduce perf_prepare_header()
> >   perf/core: Call perf_prepare_sample() before running BPF
>
> lgtm, I ran the bpf selftests on top of that and it's ok

Thanks for your review.  I'll add your Acked-by and Tested-by
in the v3. :)

Thanks,
Namhyung
