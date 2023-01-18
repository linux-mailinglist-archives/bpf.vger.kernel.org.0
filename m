Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA030672B16
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjARWI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 17:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjARWI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 17:08:26 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447D5EF9A;
        Wed, 18 Jan 2023 14:08:24 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id j1so154354iob.6;
        Wed, 18 Jan 2023 14:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3zZvGJ2IF8IzLXLWgrdTpLSWoXEmzbMQIT+v+9QWxc=;
        b=adOXBSqY4JYIaYoUao9LIIVR5mStl24+fzWbE2g3FmAZ9JJOQP1voac77PdU6gQH+N
         u+vMbBskzR1roKnMEBdq3IJvCRO2t6GqgLOSyUDOIfnOxx4fsRUT+JCyHRfr5/XsBSQt
         h4Aqr6l8S8ItPeDyht5gt4RmwXYWNXstPyKFogw46v1MIn/GF6kGgY+qzJGk5gutkomQ
         hJ9mwVWO7fbNiBlTXDKkHN0+oYkyiep4uF5CLbJFipb1d+jHYY9eYUwbpZAcgJL7byk8
         4PyTCLXgBMMX6IDp1CTdNJAh/nVTwzyOAr0J125EvQeK9c3V4Fz6GpfQN0CsEgqkUzCR
         hkNA==
X-Gm-Message-State: AFqh2kp79dOLRWrCrf0NQA04/w7G2YDJmEq0Wz3peyJCzczousugADso
        GbyR9vgIDJtbzP2hRq/6fP6yScLzqibB/SXY0fs=
X-Google-Smtp-Source: AMrXdXtpXUd1nJvo/57YPaXtKZtc4K0swsmzTqx8T6h+Yw+cTrHaEA6O8ldY2zfKpvMhyayrFUPGmsx+4kGwIA3DuF0=
X-Received: by 2002:a6b:8d0c:0:b0:6e0:28f8:83a4 with SMTP id
 p12-20020a6b8d0c000000b006e028f883a4mr692956iod.28.1674079703966; Wed, 18 Jan
 2023 14:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20230118060559.615653-1-namhyung@kernel.org> <Y8fO/Tro6wstoAeo@hirez.programming.kicks-ass.net>
 <20230118194230.mqitrgfb3j73hzw4@MacBook-Pro-6.local>
In-Reply-To: <20230118194230.mqitrgfb3j73hzw4@MacBook-Pro-6.local>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 18 Jan 2023 14:08:12 -0800
Message-ID: <CAM9d7ciwC8h3pKFezQ3tLV3cDKPG4Ef6Ug4Xzjya3HVAR-_uhQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF (v3)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
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

Hi Alexei,

On Wed, Jan 18, 2023 at 11:43 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jan 18, 2023 at 11:50:37AM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 17, 2023 at 10:05:51PM -0800, Namhyung Kim wrote:
> > > Namhyung Kim (8):
> > >   perf/core: Save the dynamic parts of sample data size
> > >   perf/core: Add perf_sample_save_callchain() helper
> > >   perf/core: Add perf_sample_save_raw_data() helper
> > >   perf/core: Add perf_sample_save_brstack() helper
> > >   perf/core: Set data->sample_flags in perf_prepare_sample()
> > >   perf/core: Do not pass header for sample id init
> > >   perf/core: Introduce perf_prepare_header()
> > >   perf/core: Call perf_prepare_sample() before running BPF
> >
> > Thanks!,
> >
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Thanks Peter.
> The patches look good to me as well.
> How do you want to route them bpf-next or tip ?
>
> Namhyung,
> I'd also like to see a follow up patch with a selftest/bpf for this.
>
> BPF CI didn't have a chance to really test the set, since
> there is a build issue on s390 due to llvm upstream repo.
> We're aware and working on that.

Yep, I'll add a test case as soon as it gets the change.

Thanks,
Namhyung
