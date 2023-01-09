Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696B6633EC
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 23:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjAIW0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 17:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjAIWZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 17:25:59 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201C25FA;
        Mon,  9 Jan 2023 14:25:56 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id n63so5278821iod.7;
        Mon, 09 Jan 2023 14:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEEX2OO6+70H54rsqQSU+me7VFu4QpBB8JmfXrf15IY=;
        b=ArNpYxYwHhkGpcVD2RhXUxUhTcU4TPA4CF0tHfW6Kofrn4LQTH5ZyPLgHvQVE90MxN
         tJ0uQroqoAEOm0K5Qhz4YlME3NFIRNHzm6sxdJOk8Bl9tS3BZiQDBgmj8SeLs0pQyK5n
         S4GC+a+3oWzqa9z604gvZfFKuJYja/5IN2mTI02+1DxB2hRuv8yfsGcVE6R4tSk7lJZH
         rWRudOETGtR/iSlhT5GFpQxTym57yFM3C+mE7nWajKEEstxLXU4qrfT2z2BTPcaAVB3I
         htjSjOEMJkf7xYBjCICRwRbJ3Zb5iJ2LAHD+6QCebXxi3VJIMqeU9KEGz0VlbPpIF4nL
         QvBA==
X-Gm-Message-State: AFqh2kp2A0hJX/5ibZrVD/qJr1aghJcFAVFIqyPPXZsBsSzr+Xv6iGim
        eLnkGOT/UDxa9Nmdi/uNV0OJNGqnFY8EqxRm4MzgG69q
X-Google-Smtp-Source: AMrXdXsQGJBigtsFjGIb9dghSTj2ojgb72PfOcU9NAEI1nPF7NS5I4clq6yxEkpQrrPkNr8Yq28RMfKFxTdPbdjZYic=
X-Received: by 2002:a02:6005:0:b0:38a:3421:f2cb with SMTP id
 i5-20020a026005000000b0038a3421f2cbmr5353588jac.308.1673303156063; Mon, 09
 Jan 2023 14:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20221118190109.1512674-1-namhyung@kernel.org> <dea8c3c5-0739-58c1-9a88-b989878a9b8f@linux.dev>
 <CAM9d7cjk_7-ALzW1kT961TRLpO9Wt8gNX7+rH4ay4N92g1TYkg@mail.gmail.com> <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
In-Reply-To: <7ec772fb-2108-5945-a308-4bb46fcf0090@linux.dev>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 9 Jan 2023 14:25:44 -0800
Message-ID: <CAM9d7cgb=NjRLt9i00RaOmseLytOF4WMRAXyFiH3LnuVnGHCZQ@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 1:23 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/9/23 12:56 PM, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Nov 21, 2022 at 9:33 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 11/18/22 11:01 AM, Namhyung Kim wrote:
> >>> We could fix the task local storage to use the safe BPF allocator,
> >>> but it takes time so let's change this until it happens actually.
> >>
> >> I also got another report on the kfree_rcu path.  I am also looking into this
> >> direction on using the BPF allocator.
> >
> > Any progress on this?  Are there any concerns about the change?
>
> Yep, I am working on it. It is not a direct replacement from kzalloc to
> bpf_mem_cache_alloc. eg. Some changes in the bpf mem allocator is needed to
> ensure the free list cannot be reused before the rcu grace period. There is a
> similar RFC patchset going into this direction that I am trying with.

I see.  Thanks for the update!

Namhyung
