Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95084663226
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjAIVCh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 16:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237778AbjAIVCM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 16:02:12 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019B15FE4;
        Mon,  9 Jan 2023 12:56:25 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id v65so881250ioe.4;
        Mon, 09 Jan 2023 12:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIKIeVI9cDZK3UUYwVf3OoJq2XGVCB5nNRQ8JkzNuQM=;
        b=cf5Q4LN3IYQ+v7ajNK+z1qKxX9vG6G3BZNW6kcrn5JWse3/VNgC17O+D7WY5l7FTve
         SeX/g7158E7s8ifmTPiQPgEQAxi3K7YGGeZ0AOyqU/L9/wlJ4/P+gmI9gUckYo2pbfqS
         U2g2CRVfIU3XaqCDCRsLJ4eUCImD5DBBXxXg66abtpts3xgRsDSIPP9YrZb1ygFHc2QJ
         lEWgq9IhAUBQlnN1Lx0xhYXGCOrDE8n+/25+UkVDdIwcaFEsSJrSwbhWq2Qrwbe6g/Ea
         lHSi+eSdawwHJBwzzp/AYQ5h1MJy4dRe/6Sg4apJaXXXNsIHWQ7Hw/mYYLWhCOohua4v
         39LA==
X-Gm-Message-State: AFqh2krWDrJoRmiaH+A6djJbdXCUC381jK9umzTqN/yYJONv34nLYNoK
        OGz9/iT4nxJ+bdCZPQhUyVVXM32lYy2gtu/se9so+d4Y
X-Google-Smtp-Source: AMrXdXsVpcGYb1XHLH1CCAVOfRotPj7giSU5a20NxVXHvT7S9HQeLTbocY4BdK8zg9InqdWbnr2OFD8Z/o4qN1NLQHk=
X-Received: by 2002:a6b:e717:0:b0:6bb:e2f0:d5e9 with SMTP id
 b23-20020a6be717000000b006bbe2f0d5e9mr5067419ioh.119.1673297784251; Mon, 09
 Jan 2023 12:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20221118190109.1512674-1-namhyung@kernel.org> <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
In-Reply-To: <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 9 Jan 2023 12:56:13 -0800
Message-ID: <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Do not use BPF task local storage
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, Blake Jones <blakejones@google.com>,
        Chris Li <chriscli@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
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

Hello,

On Mon, Nov 21, 2022 at 9:33 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/18/22 11:01 AM, Namhyung Kim wrote:
> > We could fix the task local storage to use the safe BPF allocator,
> > but it takes time so let's change this until it happens actually.
>
> I also got another report on the kfree_rcu path.  I am also looking into this
> direction on using the BPF allocator.

Any progress on this?  Are there any concerns about the change?

Thanks,
Namhyung
