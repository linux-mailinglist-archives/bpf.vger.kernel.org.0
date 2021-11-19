Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3C4578FC
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 23:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhKSWs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 17:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhKSWs6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Nov 2021 17:48:58 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA06C061574;
        Fri, 19 Nov 2021 14:45:55 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id u60so32218237ybi.9;
        Fri, 19 Nov 2021 14:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rr7GosNridUgCichnRpqxfdlmu9o3h8VXM4z78MLYXI=;
        b=n80/74gs/8IzC5NV4oK8MbGUyyyNxHPlXZ/s1Z4WCrJHYx7BPhs29b/jo1GITbq9IN
         A7XJXA2FnuTtDysbauy/CuA13CEjCeb1PD8+Gc5Xk3jvefKQVX9rYqllUqUB0aPZ67o+
         EryDYyLdpNayTjUr0NiJe7aXB6oGuZ6xA/ObBHXHhHXzTo2kDvAOJnH2GyOdmNQLz/Fx
         IaLQTw0fUQ7ciQv08DhfcG6PlfovrQeQEyMz5uzYn3Wt4HacTdCfO1/ge6GoBqFKUC5S
         RN0XqzNblfVc+1mvRUpUytGmWZ4tb3AuhEhedB/RD+t0VpPs7kExKTI7/ttSvOiUPMaa
         bBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr7GosNridUgCichnRpqxfdlmu9o3h8VXM4z78MLYXI=;
        b=QGcgkjGXo9C5GrT03jtOR0JNqF64BAIim/2Y8Wa6JD9nFKa9koT3bScKti0/wPe35W
         7+d+iqpxU5CiCvAwHMvUkW9RFx3oC9hug/643sp71OfYVslJ1Q/rmxHmdtdgBZTCK+Po
         jQpYhl6LG6Lj1vjml75Sfi8a02JKjoAbodVL6kb8Tqg23lwdYx22UkwZfPnNLfdEyA+i
         aNzz++P93aJ3vvvq+QFTbFPqtMnG7Mzl4rfHnl7nGSFfnnD6znD5BWHIu7X6lm/+YhWs
         Z2jS/1MNzTsH1uLyiMhRQOYaYzwCKwY1pUIxGezDmqwCxobPhJrC24OMVw8G/piZU4Zy
         BKnw==
X-Gm-Message-State: AOAM5333Z5R3ZajLO5CkfXhQAgcx3dqfQI74+L1ldYpvJgLcd19YogOC
        RESYiA8JpmEFTtOLhMqmHc9iqHN7nnfQEalQgOE=
X-Google-Smtp-Source: ABdhPJzz12bhH990y5fPJOLeKkBTx0wvXzv5HEg5GxMJitU46sVTSZcwSdanNzal4QgCxIWPPuZz46VxJIC61R+oaBg=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr41689748ybe.455.1637361954220;
 Fri, 19 Nov 2021 14:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20211118130507.170154-1-kjain@linux.ibm.com> <CAEf4BzbDgCVLj0r=3iponPp81aVAGokhGti8WLfWKhHuTLdA8w@mail.gmail.com>
 <ce150f51-ef50-de85-fc52-0f2ee3a3000f@linux.ibm.com> <859f8b57-7ae2-3c68-5642-93bec7a59a20@iogearbox.net>
In-Reply-To: <859f8b57-7ae2-3c68-5642-93bec7a59a20@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Nov 2021 14:45:43 -0800
Message-ID: <CAEf4BzbP0hAJYr-dahNZqKe9wyYL6hD9FayS-qdQV+Lmyi_VTQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Remove config check to enable bpf support for
 branch records
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kajoljain <kjain@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        KP Singh <kpsingh@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        rnsastry@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 8:08 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/19/21 10:35 AM, kajoljain wrote:
> > On 11/19/21 4:18 AM, Andrii Nakryiko wrote:
> >> On Thu, Nov 18, 2021 at 5:10 AM Kajol Jain <kjain@linux.ibm.com> wrote:
> >>>
> >>> Branch data available to bpf programs can be very useful to get
> >>> stack traces out of userspace application.
> >>>
> >>> Commit fff7b64355ea ("bpf: Add bpf_read_branch_records() helper")
> >>> added bpf support to capture branch records in x86. Enable this feature
> >>> for other architectures as well by removing check specific to x86.
> >>> Incase any platform didn't support branch stack, it will return with
> >>> -EINVAL.
> >>>
> >>> Selftest 'perf_branches' result on power9 machine with branch stacks
> >>> support.
> >>>
> >>> Before this patch changes:
> >>> [command]# ./test_progs -t perf_branches
> >>>   #88/1 perf_branches/perf_branches_hw:FAIL
> >>>   #88/2 perf_branches/perf_branches_no_hw:OK
> >>>   #88 perf_branches:FAIL
> >>> Summary: 0/1 PASSED, 0 SKIPPED, 1 FAILED
> >>>
> >>> After this patch changes:
> >>> [command]# ./test_progs -t perf_branches
> >>>   #88/1 perf_branches/perf_branches_hw:OK
> >>>   #88/2 perf_branches/perf_branches_no_hw:OK
> >>>   #88 perf_branches:OK
> >>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >>>
> >>> Selftest 'perf_branches' result on power9 machine which doesn't
> >>> support branch stack
> >>>
> >>> After this patch changes:
> >>> [command]# ./test_progs -t perf_branches
> >>>   #88/1 perf_branches/perf_branches_hw:SKIP
> >>>   #88/2 perf_branches/perf_branches_no_hw:OK
> >>>   #88 perf_branches:OK
> >>> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
> >>>
> >>> Fixes: fff7b64355eac ("bpf: Add bpf_read_branch_records() helper")
> >>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >>> ---
> >>>
> >>> Tested this patch changes on power9 machine using selftest
> >>> 'perf branches' which is added in commit 67306f84ca78 ("selftests/bpf:
> >>> Add bpf_read_branch_records()")
> >>>
> >>> Changelog:
> >>> v1 -> v2
> >>> - Inorder to add bpf support to capture branch record in
> >>>    powerpc, rather then adding config for powerpc, entirely
> >>>    remove config check from bpf_read_branch_records function
> >>>    as suggested by Peter Zijlstra
> >>
> >> what will be returned for architectures that don't support branch
> >> records? Will it be zero instead of -ENOENT?
> >
> > Hi Andrii,
> >       Incase any architecture doesn't support branch records and if it
> > tries to do branch sampling with sample type as
> > PERF_SAMPLE_BRANCH_STACK, perf_event_open itself will fail.
> >
> > And even if, perf_event_open succeeds  we have appropriate checks in
> > bpf_read_branch_records function, which will return -EINVAL for those
> > architectures.
> >
> > Reference from linux/kernel/trace/bpf_trace.c
> >
> > Here, br_stack will be empty, for unsupported architectures.
> >
> > BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
> >          void *, buf, u32, size, u64, flags)
> > {
> > .....
> >       if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
> >               return -EINVAL;
> >
> >       if (unlikely(!br_stack))
> >               return -EINVAL;
>
> In that case for unsupported archs we should probably bail out with -ENOENT here
> as helper doc says '**-ENOENT** if architecture does not support branch records'
> (see bpf_read_branch_records() doc in include/uapi/linux/bpf.h).

Yep, I think so too.

>
> > ....
> > }
> >
> > Thanks,
> > Kajol Jain
