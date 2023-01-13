Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA57669897
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjAMNdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241733AbjAMNc5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 08:32:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DC354DB0;
        Fri, 13 Jan 2023 05:26:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id v6so9297962ejg.6;
        Fri, 13 Jan 2023 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znAinhBfXuM1PISXQH/gsHh7kwfzvCgAHP3IxVk6mKM=;
        b=G9sCQ/DnPbVL6zMG7KlNzChe6PyOiJ9BhyAxo2aiw+1Ar0GSuj3HPMN5Q4YGWlC1ol
         PDOi53YUaFxveXreTEsUWmTxSlKth/wjwkYdPvxSsRhKc98KwbTEAj6JaHQ2MCyMCnvs
         94+gZ8E4HO6qxpFigiENCAaXGySqTCoH+lE0ydAU/3gM6KpgQ3bFSt97ODAHqUQItzO4
         sdbUF7aU8Z62V9h58cZ1ZUR0AFOkx2k5a8bXUD7F1f0smNc5wl4x0g7/uumMcB7YLotV
         zSceJeABLqvsqtBcVnS0c7VNBL3P22+R7LrjN+O5Um1mEeptgzj01QlydbgKsRO3+3mo
         GX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znAinhBfXuM1PISXQH/gsHh7kwfzvCgAHP3IxVk6mKM=;
        b=PkywSAw3TY1u+GFVOICRdClBDlM/6tbi8GfEa7fMM3Fau1BKCP3/dCmd42ClROTbxj
         gPmkRmqHbZOMKFUIWNctI6JlaR6g0ooJ8exD47BV0IU8q9cBeiQx3+NHCljSziB4DwHS
         O6tw6RY72J4J/hTweEYb77a2yEbmQELe309bIVxnBg+gDBI44HTs37mvnMl6jFRkm3jg
         ts9MyJPrOGE8CN1q0JeujoAQi95bMdoqqH4QFtaXosfwm+y/q2bcsd4b/Q/+ZLxXcVss
         6qF5nMm3NsJMiqt1uQ/JeuT92fk2l+Dq+5luv0t9c9pFUPOruoxexAjhjGcQUzz35ID0
         11sw==
X-Gm-Message-State: AFqh2kqlVMUhZUDMpCstDziLt49x/T+3jI1qBZ/18zMMWSuID0yCv5v0
        81F2+AWb9iKiec+PuTCLHKE=
X-Google-Smtp-Source: AMrXdXsbVOH2RORnpbb+Q2BiTjPZ828ljVBVvUB/EGL3gD39yELq5LCD2xSuXPygZEPBrcHSi+6wAw==
X-Received: by 2002:a17:906:f6c1:b0:7cd:ffd:51f2 with SMTP id jo1-20020a170906f6c100b007cd0ffd51f2mr84180214ejb.57.1673616358808;
        Fri, 13 Jan 2023 05:25:58 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090676c100b007c0d4d3a0c1sm8568288ejn.32.2023.01.13.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:25:58 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 13 Jan 2023 14:25:55 +0100
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf/core: Prepare sample data for BPF
Message-ID: <Y8Fb45iZ5yp3TUDD@krava>
References: <20230112214015.1014857-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112214015.1014857-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 01:40:07PM -0800, Namhyung Kim wrote:
> Hello,
> 
> The perf_prepare_sample() is to fill the perf sample data and update the
> header info before sending it to the ring buffer.  But we want to use it
> for BPF overflow handler so that it can access the sample data to filter
> relevant ones.
> 
> Changes in v2)
>  * the layout change is merged
>  * reduce branches using __cond_set  (PeterZ)
>  * add helpers to set dynamic sample data  (PeterZ)
>  * introduce perf_prepare_header()  (PeterZ)
>  * call perf_prepare_sample() before bpf_overflow_handler unconditionally
> 
> This means the perf_prepare_handler() can be called more than once.  To
> avoid duplicate work, use the data->sample_flags and save the data size.
> 
> I also added a few of helpers to set those information accordingly.
> But it looks some fields like REGS_USER, STACK_USER and AUX are saved in
> the perf_prepare_sample() so I didn't add the helpers for them.
> 
> After than we can just check the filtered_sample_type flags begin zero
> to determine if it has more work.  In that case, it needs to update the
> data->type since it's possible to miss when PMU driver sets all required
> sample flags before calling perf_prepare_sample().
> 
> The code is also available at 'perf/prepare-sample-v2' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Cc: Song Liu <song@kernel.org>
> Cc: bpf@vger.kernel.org
> 
> 
> Namhyung Kim (8):
>   perf/core: Save the dynamic parts of sample data size
>   perf/core: Add perf_sample_save_callchain() helper
>   perf/core: Add perf_sample_save_raw_data() helper
>   perf/core: Add perf_sample_save_brstack() helper
>   perf/core: Set data->sample_flags in perf_prepare_sample()
>   perf/core: Do not pass header for sample id init
>   perf/core: Introduce perf_prepare_header()
>   perf/core: Call perf_prepare_sample() before running BPF

lgtm, I ran the bpf selftests on top of that and it's ok

jirka

> 
>  arch/powerpc/perf/core-book3s.c    |   3 +-
>  arch/s390/kernel/perf_cpum_cf.c    |   4 +-
>  arch/s390/kernel/perf_cpum_sf.c    |   3 +-
>  arch/s390/kernel/perf_pai_crypto.c |   4 +-
>  arch/s390/kernel/perf_pai_ext.c    |   4 +-
>  arch/x86/events/amd/core.c         |   6 +-
>  arch/x86/events/amd/ibs.c          |   9 +-
>  arch/x86/events/intel/core.c       |   6 +-
>  arch/x86/events/intel/ds.c         |  24 ++--
>  include/linux/perf_event.h         | 133 +++++++++++++-----
>  kernel/events/core.c               | 207 ++++++++++++++++-------------
>  kernel/trace/bpf_trace.c           |   6 +-
>  12 files changed, 236 insertions(+), 173 deletions(-)
> 
> 
> base-commit: 9fcad995c6c52cc9791f7ee9f1386a5684055f9c
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
