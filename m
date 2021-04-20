Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6662365848
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhDTMDM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTMDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 08:03:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37812C06138A
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 05:02:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r5so23633349ilb.2
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol5tN6LzU4QpczLTG/xlWTHRE1wF9xYsn/S+VKMLcYI=;
        b=EB+4caDk+kG1nx5/kTcTzZotG8ZWJ+/qwnRBg7CMgjiiaeZxib+rfxp7m7SqR1MwYC
         ijoMcgoYMRn5z8tPDCIN21JPZn6LvjhulkT3htAISTZ/RHI2wrpwGEpx8DiIHnbWdPDI
         yC2OVZcC7tzqPrACQ6D556OWBxTFc8BYijKj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol5tN6LzU4QpczLTG/xlWTHRE1wF9xYsn/S+VKMLcYI=;
        b=uCCR7plETQMYWGAgm0kjTCJ1JW+zlZjfPBvNF8pjleMbGuaW7PsWo87eaIcGITm1/7
         CDwTcDBpTekqO39FpNPSiPfnzGbtVC7geNOB8fk5kcvkOLT5MRdilLsGsKvLQguakNB5
         OihwcNJKy2l/Kl/o5413T/n82ALcDn+/VpYVO7OyWVkYLhWTHN5Ik2ZT/IrUvZL+jQ+a
         zYPyUJoJWbirJ5hhRLL18xmqbm3fMAOwRz+WLgtPr5Mvgxw67Zt7TATBwm3srSPmekOu
         2X2EBvwRMXB8SSsoPR1x4SDLJ8GM0By2pia6NekRCVGtpoSKlp9K1Sau+FmD6Oe7CV15
         TB7A==
X-Gm-Message-State: AOAM533ykumkY8WRU/1u3ti5MJtKdFnTp9u5RYaKY0GHaS6wt1UxrgkP
        yZEkDBRZV+1hLjZTyUNUWw18sNjveXwgXmqwVczZRg==
X-Google-Smtp-Source: ABdhPJyrWb+OsWxva+ogTutAmy/QL7k33YF3AKIDZ9v3loaRPfMfXbpcvAbgUTvjFpQ9zZwHIDv0peNIXlMWpI0brtg=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr20869397ilq.42.1618920160504;
 Tue, 20 Apr 2021 05:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <CAEf4BzZoOVZrVz+aAnx3X3fow9tMA7YZxxe6C_uu+Xx6vy1Ofg@mail.gmail.com>
In-Reply-To: <CAEf4BzZoOVZrVz+aAnx3X3fow9tMA7YZxxe6C_uu+Xx6vy1Ofg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 20 Apr 2021 14:02:29 +0200
Message-ID: <CABRcYmL_SMT80UTyV98bRsOzW0wBd1sZcYUpTrcOAV+9m+YoWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 0/6] Add a snprintf eBPF helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 19, 2021 at 9:34 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
> >
> > We have a usecase where we want to audit symbol names (if available) in
> > callback registration hooks. (ex: fentry/nf_register_net_hook)
> >
> > A few months back, I proposed a bpf_kallsyms_lookup series but it was
> > decided in the reviews that a more generic helper, bpf_snprintf, would
> > be more useful.
> >
> > This series implements the helper according to the feedback received in
> > https://lore.kernel.org/bpf/20201126165748.1748417-1-revest@google.com/T/#u
> >
> > - A new arg type guarantees the NULL-termination of string arguments and
> >   lets us pass format strings in only one arg
> > - A new helper is implemented using that guarantee. Because the format
> >   string is known at verification time, the format string validation is
> >   done by the verifier
> > - To implement a series of tests for bpf_snprintf, the logic for
> >   marshalling variadic args in a fixed-size array is reworked as per:
> > https://lore.kernel.org/bpf/20210310015455.1095207-1-revest@chromium.org/T/#u
> >
> > ---
> > Changes in v5:
> > - Fixed the bpf_printf_buf_used counter logic in try_get_fmt_tmp_buf
> > - Added a couple of extra incorrect specifiers tests
> > - Call test_snprintf_single__destroy unconditionally
> > - Fixed a C++-style comment
> >
> > ---
> > Changes in v4:
> > - Moved bpf_snprintf, bpf_printf_prepare and bpf_printf_cleanup to
> >   kernel/bpf/helpers.c so that they get built without CONFIG_BPF_EVENTS
> > - Added negative test cases (various invalid format strings)
> > - Renamed put_fmt_tmp_buf() as bpf_printf_cleanup()
> > - Fixed a mistake that caused temporary buffers to be unconditionally
> >   freed in bpf_printf_prepare
> > - Fixed a mistake that caused missing 0 character to be ignored
> > - Fixed a warning about integer to pointer conversion
> > - Misc cleanups
> >
> > ---
> > Changes in v3:
> > - Simplified temporary buffer acquisition with try_get_fmt_tmp_buf()
> > - Made zero-termination check more consistent
> > - Allowed NULL output_buffer
> > - Simplified the BPF_CAST_FMT_ARG macro
> > - Three new test cases: number padding, simple string with no arg and
> >   string length extraction only with a NULL output buffer
> > - Clarified helper's description for edge cases (eg: str_size == 0)
> > - Lots of cosmetic changes
> >
> > ---
> > Changes in v2:
> > - Extracted the format validation/argument sanitization in a generic way
> >   for all printf-like helpers.
> > - bpf_snprintf's str_size can now be 0
> > - bpf_snprintf is now exposed to all BPF program types
> > - We now preempt_disable when using a per-cpu temporary buffer
> > - Addressed a few cosmetic changes
> >
> > Florent Revest (6):
> >   bpf: Factorize bpf_trace_printk and bpf_seq_printf
> >   bpf: Add a ARG_PTR_TO_CONST_STR argument type
> >   bpf: Add a bpf_snprintf helper
> >   libbpf: Initialize the bpf_seq_printf parameters array field by field
> >   libbpf: Introduce a BPF_SNPRINTF helper macro
> >   selftests/bpf: Add a series of tests for bpf_snprintf
> >
> >  include/linux/bpf.h                           |  22 ++
> >  include/uapi/linux/bpf.h                      |  28 ++
> >  kernel/bpf/helpers.c                          | 306 ++++++++++++++
> >  kernel/bpf/verifier.c                         |  82 ++++
> >  kernel/trace/bpf_trace.c                      | 373 ++----------------
> >  tools/include/uapi/linux/bpf.h                |  28 ++
> >  tools/lib/bpf/bpf_tracing.h                   |  58 ++-
> >  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++
> >  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++
> >  .../bpf/progs/test_snprintf_single.c          |  20 +
> >  10 files changed, 770 insertions(+), 345 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
> >
> > --
> > 2.31.1.368.gbe11c130af-goog
> >
>
> Looks great, thank you!
>
> For the series:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thank you for the all the fast and in-depth reviews Andrii! :)
