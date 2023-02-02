Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79A3688B23
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 00:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBBXvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 18:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjBBXvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 18:51:22 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C027D5D;
        Thu,  2 Feb 2023 15:51:14 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id bt17so183715wrb.8;
        Thu, 02 Feb 2023 15:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewHdaytvVfnqlQKmlRbhoIktyo1A9LRMYTCmiTMnw6w=;
        b=R4NzcbC6q9jW/OJfaWNwtbobUL3pS0ftwmOv2HlmcA7wUnzNom3snD8bqWNMYKOF5D
         iYR/e+5zeLyOr5SkRyzyWk9Cs4YPZ4f4TU5QYEX676MffKQot0RefNsia2lPYl1pDWd9
         MNYxWY/Vp0AlnbV3Fns5IOX0ZwLKlOOetSVM2YtNDrSrYVTmOjm2mGWWjKiFeawJlutu
         hDJobeU630SETfUV+eOUFySJpMr01Hn/TJ65pPLNDeMlRyr24ZZj3fMmDz4zyxOPGTlp
         xfplJNtek3Y2XGQ8OD82ZS4JAnqcOrEQfquV1n30CZRbJA2nvZkNsLC07u8D9pmc1Meo
         Xacw==
X-Gm-Message-State: AO0yUKXKlW5HXBupgtw5Nc2APodK5L5uX+US2N16YTzhFQVmYj0uawHh
        ORAJP56YXsRJAtbWHQea6yrSUA6DNRFg9bh+OpzOSBlx
X-Google-Smtp-Source: AK7set+xvztwvVJ6dgd8m0crQQvz0LSjsNd1124nnni+rgebUeSiioUYHF0JRKTf1bRQLphdKFHmrxjyGxSmXkpXYlQ=
X-Received: by 2002:a5d:60c9:0:b0:2b2:51aa:db8b with SMTP id
 x9-20020a5d60c9000000b002b251aadb8bmr238535wrt.576.1675381873092; Thu, 02 Feb
 2023 15:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20230202050455.2187592-1-namhyung@kernel.org> <20230202050455.2187592-3-namhyung@kernel.org>
 <Y9wcxfrL3J+nfp0P@kernel.org>
In-Reply-To: <Y9wcxfrL3J+nfp0P@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Feb 2023 15:51:01 -0800
Message-ID: <CAM9d7cjeCvRtNuMUadpftYym85FA_Ri0A8qufn40jkVm51cwmA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf lock contention: Use lock_stat_find{,new}
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
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

Hi Arnaldo,

On Thu, Feb 2, 2023 at 12:27 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Feb 01, 2023 at 09:04:53PM -0800, Namhyung Kim escreveu:
> > This is a preparation work to support complex keys of BPF maps.  Now it
> > has single value key according to the aggregation mode like stack_id or
> > pid.  But we want to use a combination of those keys.
> >
> > Then lock_contention_read() should still aggregate the result based on
> > the key that was requested by user.  The other key info will be used for
> > filtering.
> >
> > So instead of creating a lock_stat entry always, Check if it's already
> > there using lock_stat_find() first.
>
> Hey, try building without libtraceevent-devel installed, should be
> equivalent to NO_LIBTRACEEVENT=1.
>
> At this point I think you should move bpf_lock_contention.o to inside
> that CONFIG_LIBTRACEEVENT if block.
>
> perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
>
> ifeq ($(CONFIG_LIBTRACEEVENT),y)
>   perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
> endif
>
> I'm removing this series from tmp.perf/core for now.

Thanks for the suggestion.  I've tested it builds with the change.
Will send v2.

Thanks,
Namhyung
