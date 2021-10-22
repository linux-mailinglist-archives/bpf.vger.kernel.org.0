Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC8437B42
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhJVREF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhJVREE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 13:04:04 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43BC061764;
        Fri, 22 Oct 2021 10:01:46 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t127so8351634ybf.13;
        Fri, 22 Oct 2021 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHJUHTrwjU4F/ZFIi+0+Hy9sqvSA84f2Ooi/Dw6+GEk=;
        b=L+/AHfLVAcfGzmNDDNI7rTgSxAQRkLSDtue0Jg/yxkgUpZra0JwzBnv6bZ8An6fkSq
         2lu4n87u5VnJ//VuXjlBWPZmy4Oea18w6h7HbqE7IH6kf7hZLMGNDLgCsyrNzfPE4uXl
         3DWWkIfwW2eoQIvk/K6BmRJAwu3Ug+efv859rFVQAFugKtw8wSLMZif15BgymUAPHK9T
         mLa4H/xouTzuXPdJA1V1Jt+kTIY/nSClpPmeRlLEW8hNkGLNFk2xD/O/iQetZIY9adjF
         9vi2Ght64F+df9PVxsaKbD1RfIjkRIXpEPZnU2lYGzGovm0Ssmex3Df5UZ/b9KPheuf1
         WHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHJUHTrwjU4F/ZFIi+0+Hy9sqvSA84f2Ooi/Dw6+GEk=;
        b=b1hUta4k91Nxbhht9FO9tcQ+s0YPC5sJvip/tFjeWz7y6kL55Y0NAg50o+nUjBTjg0
         tcM/woPjTzekgfDZyeR8/gDoSXnUp92Mx5pOU3PAymxNxYbFNYGn9XS/NnBd+CLfMDTl
         XjBlPDRsFC+pT6VCgLPRJkxW5KvYtN1hUr599wdTxwKP+pjlhPF4BK8SM/Jf1FEJMA/0
         xR+JokhCUKX5nLUBgQST0nf2sGne8rz2gZc1tE0SCbNiCbeEDngdZzUF3wWDSFwfHJY+
         et7YgRfFUQrdLkyR3vWrZ4jAnUbKn81SXsW758ucPFX8JKanNLkpXb3RJGJLFW3Qqt0M
         4N+w==
X-Gm-Message-State: AOAM53078GCchtdIwJ01FaJg5CRGEe/THymdh+QoAG1mGE4gKG5L78pF
        VMGGpEwXrL1XobQ+VH4HGlCQ90JEZK99VEhV1oY4ArcGlHQ9gQ==
X-Google-Smtp-Source: ABdhPJxSH59FibVzKKvY6bWyduKCQroOBHTdW1x5NX4ig7p4Asxof+9edU8MP7836+qi1EqxlmIHBhm72gzdLLSnnAY=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr869619ybh.267.1634922105930;
 Fri, 22 Oct 2021 10:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
In-Reply-To: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Oct 2021 10:01:34 -0700
Message-ID: <CAEf4BzaSC7gWJSX+s0eudy=AMm_KHd3V92Ps4YMWGOmj-VOG4g@mail.gmail.com>
Subject: Re: [RFC] bpf: Implement prealloc for task_local_storage
To:     Tejun Heo <tj@kernel.org>, Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 1:16 PM Tejun Heo <tj@kernel.org> wrote:
>
> task_local_storage currently does not support pre-allocation and the memory
> is allocated on demand using the GFP_ATOMIC mask. While atomic allocations
> succeed most of the time and the occasional failures aren't a problem for
> many use-cases, there are some which can benefit from reliable allocations -
> e.g. tracking acquisitions and releases of specific resources to root cause
> long-term reference leaks.
>
> This patchset implements prealloc support for task_local_storage so that
> once a map is created, it's guaranteed that the storage area is always
> available for all tasks unless explicitly deleted.

Song, Martin, can you please take a look at this? It might be
worthwhile to consider having pre-allocated local storage for all
supported types: socket, cgroup, task. Especially for cases where BPF
app is going to touch all or almost all system entities (sockets,
cgroups, tasks, respectively).

Song, in ced47e30ab8b ("bpf: runqslower: Use task local storage") you
did some benchmarking of task-local storage vs hashmap and it was
faster in all cases but the first allocation of task-local storage. It
would be curious to see how numbers change if task-local storage is
pre-allocated, if you get a chance to benchmark it with Tejun's
changes. Thanks!

>
> The only tricky part is syncronizing against the fork path. Fortunately,
> cgroup needs to do the same thing and is already using
> cgroup_threadgroup_rwsem and we can use the same mechanism without adding
> extra overhead. This patchset generalizes the rwsem and make cgroup and bpf
> select it.
>
> This patchset is on top of bpf-next 223f903e9c83 ("bpf: Rename BTF_KIND_TAG
> to BTF_KIND_DECL_TAG") and contains the following patches:
>
>  0001-cgroup-Drop-cgroup_-prefix-from-cgroup_threadgroup_r.patch
>  0002-sched-cgroup-Generalize-threadgroup_rwsem.patch
>  0003-bpf-Implement-prealloc-for-task_local_storage.patch
>
> and also available in the following git branch:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git bpf-task-local-storage-prealloc
>
> diffstat follows. Thanks.
>
>  fs/exec.c                                                   |    7 +
>  include/linux/bpf.h                                         |    6 +
>  include/linux/bpf_local_storage.h                           |   12 +++
>  include/linux/cgroup-defs.h                                 |   33 ---------
>  include/linux/cgroup.h                                      |   11 +--
>  include/linux/sched/threadgroup_rwsem.h                     |   46 ++++++++++++
>  init/Kconfig                                                |    4 +
>  kernel/bpf/Kconfig                                          |    1
>  kernel/bpf/bpf_local_storage.c                              |  112 ++++++++++++++++++++++--------
>  kernel/bpf/bpf_task_storage.c                               |  138 +++++++++++++++++++++++++++++++++++++-
>  kernel/cgroup/cgroup-internal.h                             |    4 -
>  kernel/cgroup/cgroup-v1.c                                   |    9 +-
>  kernel/cgroup/cgroup.c                                      |   74 ++++++++++++--------
>  kernel/cgroup/pids.c                                        |    2
>  kernel/fork.c                                               |   16 ++++
>  kernel/sched/core.c                                         |    4 +
>  kernel/sched/sched.h                                        |    1
>  kernel/signal.c                                             |    7 +
>  tools/testing/selftests/bpf/prog_tests/task_local_storage.c |  101 +++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/task_ls_prealloc.c        |   15 ++++
>  20 files changed, 489 insertions(+), 114 deletions(-)
>
> --
> tejun
>
