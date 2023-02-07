Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3214468E365
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 23:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBGWUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBGWUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 17:20:52 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D45402F1;
        Tue,  7 Feb 2023 14:20:38 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-520dad0a7d2so213673127b3.5;
        Tue, 07 Feb 2023 14:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OBgEG4l01lhqajOHblxU1C+eiQQ6UiZVRxQ4THUYV8=;
        b=7QRHga+cHibGix3DXCjpIuQ0IwZZep4aftHBkSo9R3qJ04W2KEO1e65zhUazD6mPhI
         cAwMrUQ17oWymxFO9ZjDiW46FgbGudUL+VoD/bfKx+E7oqv1rmhC0PWa9Um3Wt+PO8XU
         hDsJsY/I3dqESdgCd6IUAkT3ovPVCDQkTAx9bWQoJ5DjbAET3nizxW/9hOc4QnSaJCo2
         1tF9ZQJOZpja6Q3LDrftUPSR7ofLlAqtYVjZ/4H1CGi57a5Izs87FOZRCJoWKVOlMByS
         /z6hLMaGW/U/Zq4pxP6Hp1fEfB3IefqX/jJMvY2qX9ddSw0SYq6ALooXmejo+DgIygAt
         6gUQ==
X-Gm-Message-State: AO0yUKVd6jJtnxarXTo0bR3hJResEwAUGIKkroF1lUdFI4vaG3Avflty
        yfQGVCeLgX/wcwsP02oI6fD7GiaO4CVCMZ6xRsqDDakh
X-Google-Smtp-Source: AK7set/cxwex6mwPyNRHHtnaVTXqiNJ1UGJxRliLiUmTAM1G33g8S2TkpqMsoeAvAUi4vvttpzPbutWX2zcZgfr8MvI=
X-Received: by 2002:a81:6dcc:0:b0:526:c7d5:dddd with SMTP id
 i195-20020a816dcc000000b00526c7d5ddddmr516406ywc.401.1675808437584; Tue, 07
 Feb 2023 14:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20230207002403.63590-1-namhyung@kernel.org> <20230207002403.63590-3-namhyung@kernel.org>
 <Y+JqNuGA5tavdPce@kernel.org>
In-Reply-To: <Y+JqNuGA5tavdPce@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Feb 2023 14:20:26 -0800
Message-ID: <CAM9d7ciLYdbH=K78cwy9L7Ppo0rhAsqKuJkpzfYExpNMk6FQwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf lock contention: Add -o/--lock-owner option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
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

Hi Arnaldo,

On Tue, Feb 7, 2023 at 7:11 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Feb 06, 2023 at 04:24:02PM -0800, Namhyung Kim escreveu:
> > When there're many lock contentions in the system, people sometimes
> > want to know who caused the contention, IOW who's the owner of the
> > locks.
> >
> > The -o/--lock-owner option tries to follow the lock owners for the
> > contended mutexes and rwsems from BPF, and then attributes the
> > contention time to the owner instead of the waiter.  It's a best
> > effort approach to get the owner info at the time of the contention
> > and doesn't guarantee to have the precise tracking of owners if it's
> > changing over time.
>
> Having this in the documentation as limitations of the approach helps,
> but I'm not seeing this on this specific patch, where I think it should
> be.
>
> Furthermore probably its a good idea to have this as a warning on the
> actual output of the tool, no?
>
> Generally having cool commit log messages, as this one has, is great,
> but people have difficulty looking at docs, imagine expecting them to
> read commit log messages... :-)

I see.  I'll add this limitation to the doc and tool output.

Thanks,
Namhyung
