Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB8513B68
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiD1SW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348985AbiD1SW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:22:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FDBC844
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:19:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e3so3631122ios.6
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF0nIfXJ6Sz4whzIRMHo5qW2fKTEAjXy4xvjao8nAXI=;
        b=lH81/H6oblrlgWu0nAiPLWzURUu+MDKdrCow9d5D7S5k2qnXc8ZkNzxGZRbivFdcEw
         sYtCAr7I1V2x2rs1KsZcsS+g5z1H+x5bjUz4F2822PcP3jmXLhnq/1UdRVnuhIeaoA7N
         Vp8XOTpJCWl5utBNTiOzM8ZNX/qNJJ+9z8EWsyWS1WkO4FRI1s9h0HON/TzDAThlZcdI
         4m2tOh8LlUvIL7SVTLAGOQioLsH7j9vo5Q2i9ekPzjvPAN6d7mzmZqv61i98/W5WBjvV
         u/rnSP+IFfoZNheJur6miDnezG1gz07IRzcN/Efd8wEj2yVh43oFjnk0JYkoO/ev/VVV
         B6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF0nIfXJ6Sz4whzIRMHo5qW2fKTEAjXy4xvjao8nAXI=;
        b=yrWY+X+jAopcpWIpsOIEXJxv8+BJ0uQmoCapUQFqIkjzN5OerIdN4KnYAR07n/MSiI
         ojCaUU3LbtKn5QCB63cn10iGzLfDAsmQ3YBtzlG4WXmS/x+GoxUVbQRVX2MfOlPqIsmQ
         CKYDUPjxibJ0KmQ4XATuR9V567N3em8ejWgcQGb0m+lyJJIfWrOuf6rFPq4jaav5INDy
         ienGYUs+AYxVz7qsBk+lhBCgPFoRpiMWhDCEPTasFPeb6UqKAA53UWOr6dchYPFQWVas
         jd7OowAmxr1M+xyIWqrpEUm39EQhnbjshYWlzqnGT/PPcXBKo2CyFHGwZ7Kf9ixg8LfL
         ZNHA==
X-Gm-Message-State: AOAM531pRss4xziTr+7UxF25uMNkdFr+UcyHLkBZWQnSguaRjB0dPM/E
        2nw+fdwrAWHaX8yMY2cr/QZ/BP4qXHtuIaZwCZY=
X-Google-Smtp-Source: ABdhPJxZQsxn8mMQmwAgh4QzjEgqbVU8e+tywBtu6XiJlSPjXG69VU/9ZNU+TP05MV4JQEvHInFKEfTis7zTQeNZw+c=
X-Received: by 2002:a05:6638:2104:b0:326:1e94:efa6 with SMTP id
 n4-20020a056638210400b003261e94efa6mr15708338jaj.234.1651169952761; Thu, 28
 Apr 2022 11:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
In-Reply-To: <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 11:19:01 -0700
Message-ID: <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> uprobes work by raising a trap, setting a task flag from within the
> interrupt handler, and processing the actual work for the uprobe on the
> way back to userspace. As a result, uprobe handlers already execute in a
> user context. The primary obstacle to sleepable bpf uprobe programs is
> therefore on the bpf side.
>
> Namely, the bpf_prog_array attached to the uprobe is protected by normal
> rcu and runs with disabled preemption. In order for uprobe bpf programs
> to become actually sleepable, we need it to be protected by the tasks_trace
> rcu flavor instead (and kfree() called after a corresponding grace period).
>
> One way to achieve this is by tracking an array-has-contained-sleepable-prog
> flag in bpf_prog_array and switching rcu flavors based on it. However, this
> is deemed somewhat unwieldly and the rcu flavor transition would be hard
> to reason about.
>
> Instead, based on Alexei's proposal, we change the free path for
> bpf_prog_array to chain a tasks_trace and normal grace periods
> one after the other. Users who iterate under tasks_trace read section would
> be safe, as would users who iterate under normal read sections (from
> non-sleepable locations). The downside is that we take the tasks_trace latency
> unconditionally but that's deemed acceptable under expected workloads.

One example where this actually can become a problem is cgroup BPF
programs. There you can make single attachment to root cgroup, but it
will create one "effective" prog_array for each descendant (and will
keep destroying and creating them as child cgroups are created). So
there is this invisible multiplier which we can't really control.

So paying the (however small, but) price of call_rcu_tasks_trace() in
bpf_prog_array_free() which is used for purely non-sleepable cases
seems unfortunate. But I think an alternative to tracking this "has
sleepable" bit on a per bpf_prog_array case is to have
bpf_prog_array_free_sleepable() implementation independent of
bpf_prog_array_free() itself and call that sleepable variant from
uprobe detach handler, limiting the impact to things that actually
might be running as sleepable and which most likely won't churn
through a huge amount of arrays. WDYT?

Otherwise all looks good and surprisingly straightforward thanks to
the fact uprobe is already running in a sleepable context, awesome!

>
> The other interesting implication is wrt non-sleepable uprobe
> programs. Because they need access to dynamically sized rcu-protected
> maps, we conditionally disable preemption and take an rcu read section
> around them, in addition to the overarching tasks_trace section.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  include/linux/bpf.h          | 60 ++++++++++++++++++++++++++++++++++++
>  include/linux/trace_events.h |  1 +
>  kernel/bpf/core.c            | 10 +++++-
>  kernel/trace/bpf_trace.c     | 23 ++++++++++++++
>  kernel/trace/trace_uprobe.c  |  4 +--
>  5 files changed, 94 insertions(+), 4 deletions(-)
>

[...]
