Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25E664BDD
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjAJTCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 14:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjAJTBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 14:01:55 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E4C2C;
        Tue, 10 Jan 2023 11:01:54 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id p66so6616043iof.1;
        Tue, 10 Jan 2023 11:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO5oCqwQNxlo3PsacBQG8HGR8FuKe5qev8tcfYySGtc=;
        b=SCejT9Jjziz1Rw5zHs25T3KqwBUTVHiojTOmhUxJxXUUexaaylCR/Qxsy1vYy/fCPn
         RaOr0MPoXLhMX5Cd0sxyPYk7Q+yLW3w2lwUo2otHaA94Bt4ZRWzRcZfaiAuDn0IF6pFQ
         XGo7Z47rLzblCeI0MIVn0NYCisJdPEFagXbO4HGLAwZeVWLJ2lThnED6SjITcHs+uxh3
         up8Ycg3/dSW+WduNGg6caKgyUOO+LHeY6TZtR0yoRLgU/sDPbZOqHfwg+LdRMq5yxHTl
         aizw1dfxzuXBro3ScRF5q6dNViQDpKWZbT9M23LFtWYo/TGzz+waeUxokX6KF2yZ3Cki
         3gZw==
X-Gm-Message-State: AFqh2kp00gKn549GFzstF7bwEbyqK8V8hR3m4sKlGyz4VIxqu6WTZAXB
        JnMRc1313dPn28t/LrYRTa3KnUDaEWo4dshsqMw=
X-Google-Smtp-Source: AMrXdXuaJ7As5yPR1zWPfLnl4dJ9RWgCNhmLDgmnaAW40Z8gylAKpaILAOPb5ewyT02ueudEyohZd1qiY8AId1+ll44=
X-Received: by 2002:a6b:a16:0:b0:6e3:28c5:e8ee with SMTP id
 z22-20020a6b0a16000000b006e328c5e8eemr6555797ioi.140.1673377313445; Tue, 10
 Jan 2023 11:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20221229204101.1099430-1-namhyung@kernel.org> <20221229204101.1099430-2-namhyung@kernel.org>
 <Y7wFJ+NF0NwnmzLa@hirez.programming.kicks-ass.net> <Y7x3RUd67smv3EFQ@google.com>
 <Y71ELS9GTz0hqaUt@hirez.programming.kicks-ass.net>
In-Reply-To: <Y71ELS9GTz0hqaUt@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Jan 2023 11:01:42 -0800
Message-ID: <CAM9d7cheB9_nVQoeai2_LkoofhWN7J7ejbXwjpgqTB30JpeASQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/core: Set data->sample_flags in perf_prepare_sample()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 10, 2023 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 09, 2023 at 12:21:25PM -0800, Namhyung Kim wrote:
>
> > > However; inspired by your next patch; we can do something like so:
> > >
> > >     if (filtered_sample_type & PERF_SAMPLE_CALLCHAIN) {
> > >             data->callchain = perf_callchain(event, regs);
> > >             data->sample_flags |= PERF_SAMPLE_CALLCHAIN;
> > >
> > >             data->size += (1 + data->callchain->nr) * sizeof(u64);
> > >     }
> >
> > This is fine as long as all other places (like in PMU drivers) set the
> > callchain update the sample data size accordingly.  If not, we can get
> > the callchain but the data size will be wrong.
>
> Good point, maybe add a helper there to ensure that code doesn't
> duplicate/diverge?

Sure, will do.

Thanks,
Namhyung
