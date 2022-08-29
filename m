Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF465A554B
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 22:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH2UIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2UIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 16:08:49 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8B90C4B
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 13:08:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id h27so6921563qkk.9
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qbFnYh6+yxExljXv7kC6ED4iDTkPIabJD2w6r78FSkQ=;
        b=Gtf1g/NXxYZTaLMDW1gcFmpDCBO7bmirrujsGt82JUvmWp7Y1l2zK7QOCmSZwnJcoY
         bOfhEL5HKvYzYnSdH6PUx0/+IDQ5DnR5jCCdMCOc90OfqgE12xC7wOlWBiMxhT5xbTSA
         kDz22UDaG0jqo5VhkBozq3hOuahHSOyrg5fDBJ5Y99esy/ZFF649pHGKRR0hQOLehzQh
         Etmm7LtzVwr78luRpifIl/a6iDgAgxhP5dyBnXKjQbTOdU7tQJ5PqljPi3fBJSN5uS8Z
         ZWa0GWtVL9/dRfVBpaWhEx8Y1qY7aBbnvmSQg5oK8oSEoeuZmVFZuTFhHJXGMonruDRG
         b9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qbFnYh6+yxExljXv7kC6ED4iDTkPIabJD2w6r78FSkQ=;
        b=mv0vn1fmJtcukOLJ6pi0QOumiwuf8d9GvUMldDEoITinklCGFZtMwxG0XiAA/ZbH8t
         VclK4uWAE/LZV9TTibUMlAJl91JIwEVV214fiTdL6lsRJFrgrVu6PfD8LJ6YsxNHYuhI
         PLOD92kPwFVWQr7TpeT3wh6rPxNHcqZmVjwv7fk9fUozSBTT7GJ+PcRuROKVL5JvH4BD
         2yjW+1wekqKv71g+J72pQiP1VUeUHN5mmvCwNSkmF48iCPShYvYrM9/JFCpzG7R+dUmB
         WZYB7HGJ8sSYBINGvrDXt1i8IQQVqo5Xh+SHgq68ix0jrMHx05naaI7+QpwiJG7EgW1m
         tlxw==
X-Gm-Message-State: ACgBeo15+2q2aSEWM6InJjWJlws6rsvvZEgsienFo2It9m9VFKYHxd5N
        ALrIoBxp9Si9oXtxbWxb4Aa5YD5boLU6su+jVBqblbEtsN0=
X-Google-Smtp-Source: AA6agR7AJf9AOAAtuDFL/SEeBpsglgsS3c78XCsHe+mZR6Ycv5JsqxwDnoulWonFip+nUJqMiv9nqp+8v3nbJaDxNwE=
X-Received: by 2002:a37:e118:0:b0:6ba:e5ce:123b with SMTP id
 c24-20020a37e118000000b006bae5ce123bmr9555944qkm.221.1661803727353; Mon, 29
 Aug 2022 13:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
In-Reply-To: <20220826230639.1249436-1-yosryahmed@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 13:08:36 -0700
Message-ID: <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> The cgroup_hierarchical_stats selftest is complicated. It has to be,
> because it tests an entire workflow of recording, aggregating, and
> dumping cgroup stats. However, some of the complexity is unnecessary.
> The test now enables the memory controller in a cgroup hierarchy, invokes
> reclaim, measure reclaim time, THEN uses that reclaim time to test the
> stats collection and aggregation. We don't need to use such a
> complicated stat, as the context in which the stat is collected is
> orthogonal.
>
> Simplify the test by using a simple stat instead of reclaim time, the
> total number of times a process has ever entered a cgroup. This makes
> the test simpler and removes the dependency on the memory controller and
> the memory reclaim interface.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---

Yosry, please tag the patch with the repo it should be applied on:
bpf-next or bpf.

>
> When the test failed on Alexei's setup because the memory controller was
> not enabled I realized this is an unnecessary dependency for the test,
> which inspired this patch :) I am not sure if this prompt a Fixes tag as
> the test wasn't broken.
>
> ---
>  .../prog_tests/cgroup_hierarchical_stats.c    | 157 ++++++---------
>  .../bpf/progs/cgroup_hierarchical_stats.c     | 181 ++++++------------
>  2 files changed, 118 insertions(+), 220 deletions(-)
>
[...]
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> index 8ab4253a1592..c74362854948 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Functions to manage eBPF programs attached to cgroup subsystems
> - *

Please also add comments here explaining what the programs in this file do.

>   * Copyright 2022 Google LLC.
>   */
[...]
>
> -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> +SEC("fentry/cgroup_attach_task")

Can we select an attachpoint that is more stable? It seems
'cgroup_attach_task' is an internal helper function in cgroup, and its
signature can change. I'd prefer using those commonly used tracepoints
and EXPORT'ed functions. IMHO their interfaces are more stable.

> +int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
> +            bool threadgroup)
>  {
> -       struct task_struct *task = bpf_get_current_task_btf();
> -       __u64 *start_time_ptr;
> -
> -       start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
> -                                             BPF_LOCAL_STORAGE_GET_F_CREATE);
> -       if (start_time_ptr)
> -               *start_time_ptr = bpf_ktime_get_ns();
> -       return 0;
> -}
[...]
>  }
> --
> 2.37.2.672.g94769d06f0-goog
>
