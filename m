Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E246403007
	for <lists+bpf@lfdr.de>; Tue,  7 Sep 2021 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhIGU7T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbhIGU7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 16:59:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A1C061575;
        Tue,  7 Sep 2021 13:58:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q70so1095763ybg.11;
        Tue, 07 Sep 2021 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdZdX8HNZWBONIPSP3ehd1lH1Zz1AssyA1YbfZpGmlE=;
        b=c5BFT0sgoZ19GHoibszSnG6egcaKgN8WQkb1vR7mz/t+Ywzsa89BwZ4xzt5+quoswh
         UnCWfwcC1QRi6+7HJZjbFfWaT7XVkzH5k2ofxFl0R4jtdjRo4o70SU7oaw3a3XAxiKB/
         XNg3xBrwt0M1AvB3ltQaNFdmD2NDA9ewsHBuu55Qij8amtrMs/JbH7bvAhD8Fx9cgmNl
         UoNhZogAFk59Uyfvv44vDpoWnXSHwVEWBazLsTL8JF+YTwfh5Grvrbo0Svws18Ke9rz9
         A25gxu8wBnqxmcN2YYVvkCNRZ2Kk/r8Ji5ontxSI7SXt5NhASDKbm7Crc1zbM29kZdRf
         fPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdZdX8HNZWBONIPSP3ehd1lH1Zz1AssyA1YbfZpGmlE=;
        b=kGGmi1ht1RQ3Hw5JF5sZpKsf0cQKrn/kBGqk712edAaARxIcEXI8/Ifb0faawwtq9b
         UoaapItN3DKKcx/y4wZ8xEDrGZ9OLL/+4JDLmLEIqIj81wpjMj0tiM2EYDmfLhRMg8KA
         YIFn4he11zDr8fiQHwwkYPFazvNaOSjpbT+zg8gpF7R5di1xPW9n0OmIWj42g05zKFaE
         aKwQtb++DwlzbICNV3pRTOr5GWfOkNN62IKUv8jcY8wzHIAnJrVKppBEeJ4qP+u+Sr57
         QEv1VO/qYSpaL48v+wrriNdvbr2czr35i+wQcqmS2SZX3S7opMIqnb4urw282VeRKmOQ
         UFbA==
X-Gm-Message-State: AOAM533ydvzsi9Bqb/dXsp+wlRRSN5pwVnlWKtt2NrcbT77tDvy1nSw2
        X5QGLZv9mPipgcg6FI6tbuTzAN4aAkyKpMCGemQ=
X-Google-Smtp-Source: ABdhPJxHFk6KytWC00/zkK2Tzy313YfGVw+UUZinya+mBi/OAzRZgBY941AilEVnwhBk1Ltb9ZaWaBGm5r6Q3ZfZQzU=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr467298ybq.368.1631048291306;
 Tue, 07 Sep 2021 13:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210907202802.3675104-1-songliubraving@fb.com> <F638720E-F0A7-468F-8862-907CFB19E4A2@fb.com>
In-Reply-To: <F638720E-F0A7-468F-8862-907CFB19E4A2@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Sep 2021 13:58:00 -0700
Message-ID: <CAEf4BzbxfFe7x00jqiu0Laaetomv5EjX3TfCO_zu_W33vGQLRw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 7, 2021 at 1:31 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Sep 7, 2021, at 1:27 PM, Song Liu <songliubraving@fb.com> wrote:
>
> Forgot to add changes:
>
> Changes v5 => v6
> 1. Add local_irq_save/restore to intel_pmu_snapshot_branch_stack.
>    (Peter)
> 2. Remove buf and size check in bpf_get_branch_snapshot, move flags
>    check to later fo the function. (Peter, Andrii)
> 3. Revise comments for bpf_get_branch_snapshot in bpf.h (Andrii)
>

Looks great, thanks! Looking forward to being able to use it. Please
consider following up with migrate_disable() inlining as well.

For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> >
> > Changes v4 => v5
> > 1. Modify perf_snapshot_branch_stack_t to save some memcpy. (Andrii)
> > 2. Minor fixes in selftests. (Andrii)
> >
> > Changes v3 => v4:
> > 1. Do not reshuffle intel_pmu_disable_all(). Use some inline to save LBR
> >   entries. (Peter)
> > 2. Move static_call(perf_snapshot_branch_stack) to the helper. (Alexei)
> > 3. Add argument flags to bpf_get_branch_snapshot. (Andrii)
> > 4. Make MAX_BRANCH_SNAPSHOT an enum (Andrii). And rename it as
> >   PERF_MAX_BRANCH_SNAPSHOT
> > 5. Make bpf_get_branch_snapshot similar to bpf_read_branch_records.
> >   (Andrii)
> > 6. Move the test target function to bpf_testmod. Updated kallsyms_find_next
> >   to work properly with modules. (Andrii)
> >
> > Changes v2 => v3:
> > 1. Fix the use of static_call. (Peter)
> > 2. Limit the use to perfmon version >= 2. (Peter)
> > 3. Modify intel_pmu_snapshot_branch_stack() to use intel_pmu_disable_all
> >   and intel_pmu_enable_all().
> >
> > Changes v1 => v2:
> > 1. Rename the helper as bpf_get_branch_snapshot;
> > 2. Fix/simplify the use of static_call;
> > 3. Instead of percpu variables, let intel_pmu_snapshot_branch_stack output
> >   branch records to an output argument of type perf_branch_snapshot.
> >
> > Branch stack can be very useful in understanding software events. For
> > example, when a long function, e.g. sys_perf_event_open, returns an errno,
> > it is not obvious why the function failed. Branch stack could provide very
> > helpful information in this type of scenarios.
> >
> > This set adds support to read branch stack with a new BPF helper
> > bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
> > It is also possible to support the same feaure for PowerPC.
> >
> > The hardware that records the branch stace is not stopped automatically on
> > software events. Therefore, it is necessary to stop it in software soon.
> > Otherwise, the hardware buffers/registers will be flushed. One of the key
> > design consideration in this set is to minimize the number of branch record
> > entries between the event triggers and the hardware recorder is stopped.
> > Based on this goal, current design is different from the discussions in
> > original RFC [1]:
> > 1) Static call is used when supported, to save function pointer
> >    dereference;
> > 2) intel_pmu_lbr_disable_all is used instead of perf_pmu_disable(),
> >    because the latter uses about 10 entries before stopping LBR.
> >
> > With current code, on Intel CPU, LBR is stopped after 10 branch entries
> > after fexit triggers:
> >
> > ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
> > ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
> > ID: 2 from intel_pmu_snapshot_branch_stack+102 to intel_pmu_lbr_disable_all+0
> > ID: 3 from bpf_get_branch_snapshot+18 to intel_pmu_snapshot_branch_stack+0
> > ID: 4 from bpf_get_branch_snapshot+18 to bpf_get_branch_snapshot+0
> > ID: 5 from __brk_limit+474918983 to bpf_get_branch_snapshot+0
> > ID: 6 from __bpf_prog_enter+34 to __brk_limit+474918971
> > ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
> > ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
> > ID: 9 from bpf_testmod_loop_test+20 to __bpf_prog_enter+0
> > ID: 10 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> > ID: 11 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> > ID: 12 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> > ID: 13 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> > ...
> >
> > [1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.com/
> >
> > Song Liu (3):
> >  perf: enable branch record for software events
> >  bpf: introduce helper bpf_get_branch_snapshot
> >  selftests/bpf: add test for bpf_get_branch_snapshot
> >
> > arch/x86/events/intel/core.c                  |  29 ++++-
> > arch/x86/events/intel/ds.c                    |   8 --
> > arch/x86/events/perf_event.h                  |  10 +-
> > include/linux/perf_event.h                    |  23 ++++
> > include/uapi/linux/bpf.h                      |  22 ++++
> > kernel/bpf/trampoline.c                       |   3 +-
> > kernel/events/core.c                          |   2 +
> > kernel/trace/bpf_trace.c                      |  30 ++++++
> > tools/include/uapi/linux/bpf.h                |  22 ++++
> > .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
> > .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
> > .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
> > .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
> > .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
> > tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
> > tools/testing/selftests/bpf/test_progs.h      |   2 +
> > tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
> > tools/testing/selftests/bpf/trace_helpers.h   |   5 +
> > 18 files changed, 378 insertions(+), 66 deletions(-)
> > create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
> > create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
> >
> > --
> > 2.30.2
>
