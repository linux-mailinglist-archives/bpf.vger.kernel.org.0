Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A136C219
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhD0Jvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhD0Jvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 05:51:47 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3646C061756
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 02:51:04 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v13so117596ilj.8
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDl/UXnOxJXHbpPYkD239oBJgYN5fLw9tXUol5cebbY=;
        b=lA9Y46DE6biGEjXcRc2JhpZ0jcr+XDCHlb6R3JEq0p3iKM9oZELRw4DS+/Kb2mpnhG
         ouaoaWUh5RY/UNh1/XhM9iKh7ctmyVC31PJqQFQcUi3u39LG3nieDj20j3LleFSLC07E
         LuOXh02JA/eIjPHqPTWIhj0L34Gzt2sM58z4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDl/UXnOxJXHbpPYkD239oBJgYN5fLw9tXUol5cebbY=;
        b=UN9QU2QzkMoLz7twDbOtRgeJR/3+vhk6v1K9AWW4JnodnjcJK+2rAiZr1E9ukS3BgD
         v9ECLhvUJMUVMWCug6AFGCgnrsVF4XSbAYHplgf3diWmBSuEpkcZJBxrLemZRy3eTBkj
         98R7Dw0xdxc1EC9IEzl75FG0SdIjsUVEP485cwAjH1d7NnXfw12F8Xf3IPC6iIB4OElQ
         ibHuBNbq5jXVo6LVgHMJwN0ZGGKymo3E7vj3l0tglzSR+foyNih80Qcl4zymY1WKa6dx
         QOE0CWg1eZ6NiaYg7r6kx8x0PIEaQIlbXswv9iuHHpDBXpSMhUvWILPIJDAVsAGz48xY
         1GaQ==
X-Gm-Message-State: AOAM532d4cYlJ2g8/8zLDczkygQ2MMlMnyzJtw20/ZCs2fOvtreqp4aw
        iws79A/lC3+r6vmpDBjczumiUzwEEFbFfoOQqXMvtg==
X-Google-Smtp-Source: ABdhPJyO5xfobk05xEXt4d5x/yAsLG+beOBSh3CwzZyJGkGJVazVRDmc8upeL+ZH97GhEEnLT6EJWSkinIOOsnfUWq4=
X-Received: by 2002:a05:6e02:1caf:: with SMTP id x15mr18457508ill.89.1619517064365;
 Tue, 27 Apr 2021 02:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
 <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
 <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com> <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk>
In-Reply-To: <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 27 Apr 2021 11:50:53 +0200
Message-ID: <CABRcYmJdTZAhdD_2OVAu-hOnYX-bgvrrbnUjaV23tzp-c+9_8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 8:35 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 26/04/2021 23.08, Florent Revest wrote:
> > On Mon, Apr 26, 2021 at 6:19 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Apr 26, 2021 at 3:10 AM Florent Revest <revest@chromium.org> wrote:
> >>>
> >>> On Sat, Apr 24, 2021 at 12:38 AM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>>
> >>>> On Mon, Apr 19, 2021 at 8:52 AM Florent Revest <revest@chromium.org> wrote:
> >>>>>
> >>>>> The "positive" part tests all format specifiers when things go well.
> >>>>>
> >>>>> The "negative" part makes sure that incorrect format strings fail at
> >>>>> load time.
> >>>>>
> >>>>> Signed-off-by: Florent Revest <revest@chromium.org>
> >>>>> ---
> >>>>>  .../selftests/bpf/prog_tests/snprintf.c       | 125 ++++++++++++++++++
> >>>>>  .../selftests/bpf/progs/test_snprintf.c       |  73 ++++++++++
> >>>>>  .../bpf/progs/test_snprintf_single.c          |  20 +++
> >>>>>  3 files changed, 218 insertions(+)
> >>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >>>>>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >>>>>  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf_single.c
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..a958c22aec75
> >>>>> --- /dev/null
> >>>>> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> >>>>> @@ -0,0 +1,125 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/* Copyright (c) 2021 Google LLC. */
> >>>>> +
> >>>>> +#include <test_progs.h>
> >>>>> +#include "test_snprintf.skel.h"
> >>>>> +#include "test_snprintf_single.skel.h"
> >>>>> +
> >>>>> +#define EXP_NUM_OUT  "-8 9 96 -424242 1337 DABBAD00"
> >>>>> +#define EXP_NUM_RET  sizeof(EXP_NUM_OUT)
> >>>>> +
> >>>>> +#define EXP_IP_OUT   "127.000.000.001 0000:0000:0000:0000:0000:0000:0000:0001"
> >>>>> +#define EXP_IP_RET   sizeof(EXP_IP_OUT)
> >>>>> +
> >>>>> +/* The third specifier, %pB, depends on compiler inlining so don't check it */
> >>>>> +#define EXP_SYM_OUT  "schedule schedule+0x0/"
> >>>>> +#define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
> >>>>> +
> >>>>> +/* The third specifier, %p, is a hashed pointer which changes on every reboot */
> >>>>> +#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> >>>>> +#define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")
> >>>>> +
> >>>>> +#define EXP_STR_OUT  "str1 longstr"
> >>>>> +#define EXP_STR_RET  sizeof(EXP_STR_OUT)
> >>>>> +
> >>>>> +#define EXP_OVER_OUT "%over"
> >>>>> +#define EXP_OVER_RET 10
> >>>>> +
> >>>>> +#define EXP_PAD_OUT "    4 000"
> >>>>
> >>>> Roughly 50% of the time I get failure for this test case:
> >>>>
> >>>> test_snprintf_positive:FAIL:pad_out unexpected pad_out: actual '    4
> >>>> 0000' != expected '    4 000'
> >>>>
> >>>> Re-running this test case immediately passes. Running again most
> >>>> probably fails. Please take a look.
> >>>
> >>> Do you have more information on how to reproduce this ?
> >>> I spinned up a VM at 87bd9e602 with ./vmtest -s and then run this script:
> >>>
> >>> #!/bin/sh
> >>> for i in `seq 1000`
> >>> do
> >>>   ./test_progs -t snprintf
> >>>   if [ $? -ne 0 ];
> >>>   then
> >>>     echo FAILURE
> >>>     exit 1
> >>>   fi
> >>> done
> >>>
> >>> The thousand executions passed.
> >>>
> >>> This is a bit concerning because your unexpected_pad_out seems to have
> >>> an extra '0' so it ends up with strlen(pad_out)=11 but
> >>> sizeof(pad_out)=10. The actual string writing is not really done by
> >>> our helper code but by the snprintf implementation (str and str_size
> >>> are only given to snprintf()) so I'd expect the truncation to work
> >>> well there. I'm a bit puzzled
> >>
> >> I'm puzzled too, have no idea. I also can't repro this with vmtest.sh.
> >> But I can quite reliably reproduce with my local ArchLinux-based qemu
> >> image with different config (see [0] for config itself). So please try
> >> with my config and see if that helps to repro. If not, I'll have to
> >> debug it on my own later.
> >>
> >>   [0] https://gist.github.com/anakryiko/4b6ae21680842bdeacca8fa99d378048
> >
> > I tried that config on the same commit 87bd9e602 (bpf-next/master)
> > with my debian-based qemu image and I still can't reproduce the issue
> > :| If I can be of any help let me know, I'd be happy to help
> >
>
> It's not really clear to me if this is before or after the rewrite to
> use bprintf, but regardless, in those two patches this caught my attention:

I tried to reproduce Andrii's bug both before and after the bprintf
rewrite but I think he meant before.

>         u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
> -       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
> +       u32 *bin_args;
>         static char buf[BPF_TRACE_PRINTK_SIZE];
>         unsigned long flags;
>         int ret;
>
> -       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
> -                                MAX_TRACE_PRINTK_VARARGS);
> +       ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
> +                                 MAX_TRACE_PRINTK_VARARGS);
>         if (ret < 0)
>                 return ret;
>
> -       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
> -               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
> -       /* snprintf() will not append null for zero-length strings */
> -       if (ret == 0)
> -               buf[0] = '\0';
> +       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
>
>         raw_spin_lock_irqsave(&trace_printk_lock, flags);
>         trace_bpf_trace_printk(buf);
>         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>
> Why isn't the write to buf[] protected by that spinlock? Or put another
> way, what protects buf[] from concurrent writes?

You're right, that is a bug, I missed that buf was static and thought
it was just on the stack. That snprintf call should be after the
raw_spin_lock_irqsave. I'll send a patch. Thank you Rasmus. (before my
snprintf series, there was a vsprintf after the raw_spin_lock_irqsave)

> Probably the test cases are not run in parallel, but this is the kind of
> thing that would give those symptoms.

I think it's a separate issue from what Andrii reported though because
the flaky test exercises the bpf_snprintf helper and this buf spinlock
bug you just found only affects the bpf_trace_printk helper.

That being said, it does smell a little bit like a concurrency issue
too, indeed. The bpf_snprintf test program is a raw_tp/sys_enter so it
attaches to all syscall entries and most likely gets executed many
more times than necessary and probably on parallel CPUs. The "pad_out"
buffer they write to is unique and not locked so maybe the test's
userspace reads pad_out while another CPU is writing on it and if the
string output goes through a stage where it is "    4 0000" before
being "    4 000", we might read at the wrong time. That being said, I
would find it weird that this happens as much as 50% of the time and
always specifically on that test case.

Andrii could you maybe try changing the prog type to
"tp/syscalls/sys_enter_nanosleep" on the machine where you can
reproduce this bug ?

> Rasmus
