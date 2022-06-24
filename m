Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7355A370
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiFXVZs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFXVZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:25:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081054BB89
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:25:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so3969119wma.4
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1AYvBwE5jBAITANz8J/qHlbNsEpOUUiaevdBY3VAsk=;
        b=Z2Y1hNr/gfBZTmYhYlUQGdVEJ6fUq81AEQkhERnnbtCT4LRZa0j1kB87DYMKIUPG+N
         gyfPwzOAGLqX27Ittu3XWRrQrWAcFUiwiwoqvXmewCkUjjJ6cNUHFTvKGNL/k7QMVBWQ
         CCq1cVqDvqdUvfcXgoYLN3+BO++Zu9MoZs4dampFJIivudez3PY6Y8iIiPS2w7mOx95K
         sS02tHoDupMKtkwKx6bMrIzn2YdI2VKuyGesIo5jzBggYPcArUzojvrZqodXTZwf3ICJ
         jlRPJ5FbkIBXiiL7WXJHgy/9jBHOS0v7Ek3V9f5UDlN0S59Rsi9Jpm4IrRLUyNDDXg6O
         5Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1AYvBwE5jBAITANz8J/qHlbNsEpOUUiaevdBY3VAsk=;
        b=kirxXnvakGH7I7QhkrFues/vLYTdmvECQIaMU+UxmholHPj1hrGYMttNnPhn3DdhxG
         yG4dEYVpNJ6rYNIJvFj1SrsXCEX/O0STwFC7FJTwTiMgqU28Z8J40FF8Zgm9zZdGqHRy
         MCbET7ookoTBlS+SJJvnl91hwIELSDmjMetqKduWBJr9T0yEMHKDn7SfAtPB94fyRFdW
         PWQ3bkqGP7dczy3BYEFiTPnX34luxsY8P5pMxJ8JLwATbpBml2L9Zvcyx/xeG8JjzB/v
         LchNZZsDRwsBehzwCzmh2vIf5VnaeQSCu5+luNYLLBFSzoUwChni3/SuvHLyMHmyKPWZ
         um4Q==
X-Gm-Message-State: AJIora9RjzpPj4JoAx0p0hXNng0g0CLc7oMWWahAYzU9K8L7vNJu6q8+
        e2iYlPUZ6SY42oPbNe1wrz3S2e5M8zix6uGlagvZLnAOL3s=
X-Google-Smtp-Source: AGRyM1vM8MU1LE4ittgZp48V6ARpCVjv5rirpzdufMFVNcMnbhp9YdOTybYewvqUW9r6K0BSC4O+wJy7ZyYI1bTECbE=
X-Received: by 2002:a05:600c:1e14:b0:3a0:2bba:4b2e with SMTP id
 ay20-20020a05600c1e1400b003a02bba4b2emr1137991wmb.196.1656105944386; Fri, 24
 Jun 2022 14:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
 <CAJD7tkYkhg2RQWJi72Eu0UOAqLGAPYm21TxQvCVC4R74TK0vqg@mail.gmail.com> <20220624202220.bpbwozm7tjcwxcep@kafai-mbp>
In-Reply-To: <20220624202220.bpbwozm7tjcwxcep@kafai-mbp>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Jun 2022 14:25:08 -0700
Message-ID: <CAJD7tkZohZLncPqLz7vEx=oA8MxAeN+uj+JY_ZO152k=Nha_9g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 1:22 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Jun 22, 2022 at 04:00:04PM -0700, Yosry Ahmed wrote:
> > Thanks for adding these benchmarks!
> >
> >
> > On Sat, Jun 4, 2022 at 3:20 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> > >
> > > Add a benchmarks to demonstrate the performance cliff for local_storage
> > > get as the number of local_storage maps increases beyond current
> > > local_storage implementation's cache size.
> > >
> > > "sequential get" and "interleaved get" benchmarks are added, both of
> > > which do many bpf_task_storage_get calls on sets of task local_storage
> > > maps of various counts, while considering a single specific map to be
> > > 'important' and counting task_storage_gets to the important map
> > > separately in addition to normal 'hits' count of all gets. Goal here is
> > > to mimic scenario where a particular program using one map - the
> > > important one - is running on a system where many other local_storage
> > > maps exist and are accessed often.
> > >
> > > While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> > > ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> > > bpf_task_storage_gets for the important map for every 10 map gets. This
> > > is meant to highlight performance differences when important map is
> > > accessed far more frequently than non-important maps.
> > >
> > > A "hashmap control" benchmark is also included for easy comparison of
> > > standard bpf hashmap lookup vs local_storage get. The benchmark is
> > > similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> > > instead of local storage. Only one inner map is created - a hashmap
> > > meant to hold tid -> data mapping for all tasks. Size of the hashmap is
> > > hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these
> > > keys which are actually fetched as part of the benchmark is
> > > configurable.
> > >
> > > Addition of this benchmark is inspired by conversation with Alexei in a
> > > previous patchset's thread [0], which highlighted the need for such a
> > > benchmark to motivate and validate improvements to local_storage
> > > implementation. My approach in that series focused on improving
> > > performance for explicitly-marked 'important' maps and was rejected
> > > with feedback to make more generally-applicable improvements while
> > > avoiding explicitly marking maps as important. Thus the benchmark
> > > reports both general and important-map-focused metrics, so effect of
> > > future work on both is clear.
> >
> > The current implementation falls back to a list traversal of
> > bpf_local_storage->list when there is a cache miss. I wonder if this
> > is a place with room for optimization? Maybe a hash table or a tree
> > would be a more performant alternative?
> With a benchmark to ensure it won't regress the common use cases
> and guage the potential improvement,  it is probably something Dave
> is planning to explore next if I read the last thread correctly.
>
> How many task storages is in your production use cases ?

Unfortunately, I don't have this information. I was just making a
suggestion based on code inspection, not based on data from
production.
