Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25901315549
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhBIRkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 12:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbhBIRiz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 12:38:55 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEDC061574
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 09:38:15 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m76so19009872ybf.0
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Usl6b+HUjssVblSSya1WqP3qza289e9FVoOKdH23FnU=;
        b=ac+OUNXut/2lrAut6+nT3keT51KiZ43Xi4ChZvCV4BzuFoBo9JzHNnR36nH21R4sgn
         oWB1knSTnNBrlkiXdCEwEl0J0zCEvkD4musqrETuvKKWqxPQ0YCuChcUJPrESnz+cIjb
         5aQfDmdxDEPJCqhK+jjYQf2aws9BbqHAKMQ3D89eglDf0DtGowTMpILfuDzbFj9Iyko0
         i92u+znA0dzjKgL0bhhqVSaSnOceZuK37ZALXx2ZwZNX6+XA+KeDq9dOdfmTG61q2N7C
         Ph4LeAMDf8lJ+LFFTLIOVfzwqFTr5NeaZ2pUBSBgLj9XPniFRz8xYMMVF4zHEqonKnYz
         cZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Usl6b+HUjssVblSSya1WqP3qza289e9FVoOKdH23FnU=;
        b=s/XbhxzBNmcQM3ea1JzQA84jvQFE9RSllgumzTEP8yRkmVxE1bPoig2MhI/o4bg6Fh
         3G7G5YV7z0ug12QxmooXFaJ7CrQ2Xa13j6vh+m1vY5mGqYXAB0Y8gXqjJw2u8G9LRdSJ
         4Pat1ZbjDYOyePT9HGTVmpUXyNoUvtTk/rO0CWgVJOxAGjhudeGzBTlFsU6xl9X4oars
         yBJH4MVySJaf1MK0ahEGkNmBYf+QJIBHEwCDvtu1GOMQERwoxAOoNbNCouB3/I/VpzhD
         /zzl3zzDRn0Rjm6TQ3I1GX0JUa7RO1VckW0ZXWmo9eHclWKzPGu6gkJeA8j7JWK/4snq
         PsxQ==
X-Gm-Message-State: AOAM533nqr8Np7TCheQURec8xviTWwMUtg2zTFb8Rse+9+OIlAouWQT2
        qSYmbp3m/X1EUGXHbibEAepoW+a/ev9i8GbcJd4=
X-Google-Smtp-Source: ABdhPJwZt/NBKf/pmGv1Oqy0t7nMKlFfrSp3EeLB6qtj7HjymQ+cQUX1KuqVBUOGc9/d0qRJZQ6VheYnmZyYohM9Y4w=
X-Received: by 2002:a25:9882:: with SMTP id l2mr32200888ybo.425.1612892294963;
 Tue, 09 Feb 2021 09:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20210204234827.1628857-1-yhs@fb.com> <20210204234836.1629791-1-yhs@fb.com>
 <CAEf4BzZoLT1vtS--mfZ4XJQ-HRwhbY3pxzN-2xci9FUkPqRwqg@mail.gmail.com> <b2c9f636-c2c2-52fe-1e4c-127dd32084eb@fb.com>
In-Reply-To: <b2c9f636-c2c2-52fe-1e4c-127dd32084eb@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Feb 2021 09:38:04 -0800
Message-ID: <CAEf4Bzbps0O6ACwLr64KxHwYP=V3DE8OosWFiDpoEtH9orTOSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: add arraymap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:50 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/8/21 10:35 AM, Andrii Nakryiko wrote:
> > On Thu, Feb 4, 2021 at 5:53 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> A test is added for arraymap and percpu arraymap. The test also
> >> exercises the early return for the helper which does not
> >> traverse all elements.
> >>      $ ./test_progs -n 44
> >>      #44/1 hash_map:OK
> >>      #44/2 array_map:OK
> >>      #44 for_each:OK
> >>      Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/for_each.c       | 54 ++++++++++++++
> >>   .../bpf/progs/for_each_array_map_elem.c       | 71 +++++++++++++++++++
> >>   2 files changed, 125 insertions(+)
> >>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
> >>
> >
> > [...]
> >
> >> +
> >> +       arraymap_fd = bpf_map__fd(skel->maps.arraymap);
> >> +       expected_total = 0;
> >> +       max_entries = bpf_map__max_entries(skel->maps.arraymap);
> >> +       for (i = 0; i < max_entries; i++) {
> >> +               key = i;
> >> +               val = i + 1;
> >> +               /* skip the last iteration for expected total */
> >> +               if (i != max_entries - 1)
> >> +                       expected_total += val;
> >> +               err = bpf_map_update_elem(arraymap_fd, &key, &val, BPF_ANY);
> >> +               if (CHECK(err, "map_update", "map_update failed\n"))
> >> +                       goto out;
> >> +       }
> >> +
> >> +       num_cpus = bpf_num_possible_cpus();
> >> +        percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
> >
> > formatting is off, please check with checkfile.pl
>
> Sure. will do.
>
> >
> >
> >> +        percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
> >> +        if (CHECK_FAIL(!percpu_valbuf))
> >
> > please don't use CHECK_FAIL, ASSERT_PTR_OK would work nicely here
>
> Okay.
>
> >
> >> +                goto out;
> >> +
> >> +       key = 0;
> >> +        for (i = 0; i < num_cpus; i++)
> >> +                percpu_valbuf[i] = i + 1;
> >> +       err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
> >> +       if (CHECK(err, "percpu_map_update", "map_update failed\n"))
> >> +               goto out;
> >> +
> >> +       do_dummy_read(skel->progs.dump_task);
> >
> > see previous patch, iter/tasks seems like an overkill for these tests
>
> Yes, will use bpf_prog_test_run() in v2.
>
> >
> >> +
> >> +       ASSERT_EQ(skel->bss->called, 1, "called");
> >> +       ASSERT_EQ(skel->bss->arraymap_output, expected_total, "array_output");
> >> +       ASSERT_EQ(skel->bss->cpu + 1, skel->bss->percpu_val, "percpu_val");
> >> +
> >> +out:
> >> +       free(percpu_valbuf);
> >> +       for_each_array_map_elem__destroy(skel);
> >> +}
> >> +
> >
> > [...]
> >
> >> +SEC("iter/task")
> >> +int dump_task(struct bpf_iter__task *ctx)
> >> +{
> >> +       struct seq_file *seq =  ctx->meta->seq;
> >> +       struct task_struct *task = ctx->task;
> >> +       struct callback_ctx data;
> >> +
> >> +       /* only call once */
> >> +       if (called > 0)
> >> +               return 0;
> >> +
> >> +       called++;
> >> +
> >> +       data.output = 0;
> >> +       bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
> >> +       arraymap_output = data.output;
> >> +
> >> +       bpf_for_each_map_elem(&percpu_map, check_percpu_elem, 0, 0);
> >
> > nit: NULL, 0 ?
>
> We do not NULL defined in vmlinux.h or bpf_helpers.h. Hence I am using
> 0, I should at least use (void *)0 here, I think.

yeah, this NULL problem is annoying. Let's just add NULL to vmlinux.h,
you are not the first one to complain. We can do that separately from
this patch set, of course.

>
> >
> >> +
> >> +       return 0;
> >> +}
> >> --
> >> 2.24.1
> >>
