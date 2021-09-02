Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B53FF771
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbhIBWz4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 18:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347794AbhIBWzz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 18:55:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86051C061575;
        Thu,  2 Sep 2021 15:54:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id a93so6855021ybi.1;
        Thu, 02 Sep 2021 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7PS2aPWeHT9cfVvWfufHLOFrcw7bSQtzjBuCbrMdNU=;
        b=NMLz8N1DkJu5CZ2ElpmK0SWxqIvHCboX4MbCYt7y+eWk9IUcf+hs8A8IYp8kXv3xkr
         +TMLm7I9jbjm0enUHh/y5UvEZvam7S8jfCCCBPZqswvRvMYkl/fGnMA095EwGRAAcIJ9
         PWVyaoPcvhziZvnAHiQdWvk+8XJWH8j5RERJ5BBZjAecqeFMUt4c4pC+AeZAI0bUVgHi
         /9+a9HM50iOoysg79f6bmtcJ0XXufsVbZtCgoTGsELKVLy+kf8Cwxxt34Fxk+bA8qAW/
         D/nYygn2+yxIALJgjTHDOAQGIhsx361/sCy3hSrxZl5lOJyr4BI/8Oxz/wHfbVHEogcF
         X+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7PS2aPWeHT9cfVvWfufHLOFrcw7bSQtzjBuCbrMdNU=;
        b=LzOsojmnR2J3hozyC7EUjcQQvrmEjAw4ggbaqPG4C6Q7Mu5ldX9+Em+qOdHNeYh1Nc
         QgOm0piEYdMJlnugkFArMOKSfVAfs9+CWR0AeSZHJqealvj8KdWEg0w7X8bstuDhmF0S
         kPGNumlc8r9RZGwm+jUTQkQbwl5l+Co0gbvj7kypUjbeK5NAZ4eIB6etgP2CgDhi9nfv
         Wtv7uhEiC9w4DBfZF8PeDy82zJxTk83A5tb0exAensP9P+yYKO4k2mqhxrlPn0jGk1xO
         BAZbhsTqQ+ulKEOz6snC3L0ILmSMEGPax12J3td/ZUFHXi64pi8riWoAcAFar5JXfS7m
         e4hQ==
X-Gm-Message-State: AOAM531rjQDYW+KzqrvbGIp8yeif+A9fICUgVxd+fbeOYNcZ75P7oMji
        rj1UldJP5AWvdN9alGlw+JwkfYRgOxH+qenpWcU=
X-Google-Smtp-Source: ABdhPJyXdIp6z7DifLSIBycRmibhqJD40ZJEvr2Ion4azWS/KBMn2CfmFExoS8C28S1w8CSyf5gXlPrxwoJ9f2+d8z4=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr1024273ybg.347.1630623295817;
 Thu, 02 Sep 2021 15:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com>
In-Reply-To: <20210902165706.2812867-1-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Sep 2021 15:54:45 -0700
Message-ID: <CAEf4Bzb-mbZp_iEd9-Z6euMk5eYjEFJwv1QpSQx_sqSQ37xcWw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 9:58 AM Song Liu <songliubraving@fb.com> wrote:
>
> Changes v4 => v5
> 1. Modify perf_snapshot_branch_stack_t to save some memcpy. (Andrii)
> 2. Minor fixes in selftests. (Andrii)
>
> Changes v3 => v4:
> 1. Do not reshuffle intel_pmu_disable_all(). Use some inline to save LBR
>    entries. (Peter)
> 2. Move static_call(perf_snapshot_branch_stack) to the helper. (Alexei)
> 3. Add argument flags to bpf_get_branch_snapshot. (Andrii)
> 4. Make MAX_BRANCH_SNAPSHOT an enum (Andrii). And rename it as
>    PERF_MAX_BRANCH_SNAPSHOT
> 5. Make bpf_get_branch_snapshot similar to bpf_read_branch_records.
>    (Andrii)
> 6. Move the test target function to bpf_testmod. Updated kallsyms_find_next
>    to work properly with modules. (Andrii)
>
> Changes v2 => v3:
> 1. Fix the use of static_call. (Peter)
> 2. Limit the use to perfmon version >= 2. (Peter)
> 3. Modify intel_pmu_snapshot_branch_stack() to use intel_pmu_disable_all
>    and intel_pmu_enable_all().
>
> Changes v1 => v2:
> 1. Rename the helper as bpf_get_branch_snapshot;
> 2. Fix/simplify the use of static_call;
> 3. Instead of percpu variables, let intel_pmu_snapshot_branch_stack output
>    branch records to an output argument of type perf_branch_snapshot.
>
> Branch stack can be very useful in understanding software events. For
> example, when a long function, e.g. sys_perf_event_open, returns an errno,
> it is not obvious why the function failed. Branch stack could provide very
> helpful information in this type of scenarios.
>
> This set adds support to read branch stack with a new BPF helper
> bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
> It is also possible to support the same feaure for PowerPC.
>
> The hardware that records the branch stace is not stopped automatically on
> software events. Therefore, it is necessary to stop it in software soon.
> Otherwise, the hardware buffers/registers will be flushed. One of the key
> design consideration in this set is to minimize the number of branch record
> entries between the event triggers and the hardware recorder is stopped.
> Based on this goal, current design is different from the discussions in
> original RFC [1]:
>  1) Static call is used when supported, to save function pointer
>     dereference;
>  2) intel_pmu_lbr_disable_all is used instead of perf_pmu_disable(),
>     because the latter uses about 10 entries before stopping LBR.
>
> With current code, on Intel CPU, LBR is stopped after 10 branch entries
> after fexit triggers:
>
> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
> ID: 2 from intel_pmu_snapshot_branch_stack+88 to intel_pmu_lbr_disable_all+0
> ID: 3 from bpf_get_branch_snapshot+77 to intel_pmu_snapshot_branch_stack+0
> ID: 4 from __brk_limit+478052814 to bpf_get_branch_snapshot+0
> ID: 5 from __brk_limit+478036039 to __brk_limit+478052760
> ID: 6 from __bpf_prog_enter+34 to __brk_limit+478036027
> ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
> ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
> ID: 9 from __brk_limit+478036022 to __bpf_prog_enter+0
> ID: 10 from bpf_testmod_loop_test+22 to __brk_limit+478036003
> ID: 11 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 12 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ID: 13 from bpf_testmod_loop_test+20 to bpf_testmod_loop_test+13
> ...
>
> [1] https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.com/
>
> Song Liu (3):
>   perf: enable branch record for software events
>   bpf: introduce helper bpf_get_branch_snapshot
>   selftests/bpf: add test for bpf_get_branch_snapshot
>

Besides the BPF helper comment nit, looks good to me. For the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  arch/x86/events/intel/core.c                  |  26 ++++-
>  arch/x86/events/intel/ds.c                    |   8 --
>  arch/x86/events/perf_event.h                  |  10 +-
>  include/linux/perf_event.h                    |  23 ++++
>  include/uapi/linux/bpf.h                      |  22 ++++
>  kernel/bpf/trampoline.c                       |   3 +-
>  kernel/events/core.c                          |   2 +
>  kernel/trace/bpf_trace.c                      |  33 ++++++
>  tools/include/uapi/linux/bpf.h                |  22 ++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 +++-
>  .../selftests/bpf/prog_tests/core_reloc.c     |  14 +--
>  .../bpf/prog_tests/get_branch_snapshot.c      | 100 ++++++++++++++++++
>  .../selftests/bpf/prog_tests/module_attach.c  |  39 -------
>  .../selftests/bpf/progs/get_branch_snapshot.c |  40 +++++++
>  tools/testing/selftests/bpf/test_progs.c      |  39 +++++++
>  tools/testing/selftests/bpf/test_progs.h      |   2 +
>  tools/testing/selftests/bpf/trace_helpers.c   |  37 +++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |   5 +
>  18 files changed, 378 insertions(+), 66 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c
>  create mode 100644 tools/testing/selftests/bpf/progs/get_branch_snapshot.c
>
> --
> 2.30.2
