Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796D0446680
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 16:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhKEP4B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEPz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 11:55:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F843C061714;
        Fri,  5 Nov 2021 08:53:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so3622480pjc.4;
        Fri, 05 Nov 2021 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Khe0I5Q1+2/UsOTg7rhV0f6H2RtwXCWMhvt//siSaDk=;
        b=pn3EYzc6w8kr6oC5ozcCwu3VCkEb8m5a+kfq5XY7ZqW1POxqtmQpp4QKBdIQcEzOFS
         1puyWo81rZSNlvhTtV2VzdrEGIbgTrozK7bvQFE7qsXvTKYax1iu6CbyMKYFm2S5hJTS
         5SFI4shOxTt7PUBZVBq7P5SDHCIN6iP2AxCRuJdWeJ/j/+zsaxIFVqMeM267CjqqKF8u
         7vJGUP0kJjmC5qL/GUCgDVnpsxV7B50gkXTeXxA87RZUDZmo5sD3bdVMJ/8MIdKuz5wJ
         MOw7hKnvdt+oZXN7o5usmeATHJqk7apwonFsXgiwWayRWY2o8AS5gI3T8JuqpdIkuSj4
         TzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Khe0I5Q1+2/UsOTg7rhV0f6H2RtwXCWMhvt//siSaDk=;
        b=QnPYEbYxq996yeQc7LSz87iuyW73kStEOXkc9QJFHFsnuqSd2TqsKJkT40xt9B44y7
         /wMhETwvxo3rUwcZBFHvmuHbBk2uTSSENNAcIG64k9ySC8+Ve0WXrUaz4Uzhvd26IeZQ
         bPKkoBp+5ykx6sBkicBcXpx8mJUNuGdTSaLM4+u/cf7rDtRzT9C4OARmVZxsHXoEWe14
         VDWPiml7Vo13iobNxNvSi3Ctsov6iR85wcRzuAaNM2QaJQ4zo800NvU3+3nawJl6O2Ow
         pe2cNgYdYlqu9hs4p4YT8n5eyDivBQc2zpar6wQb7PQuhGfrx/vsWHGkKKp6b/x7udo7
         NAYg==
X-Gm-Message-State: AOAM5335ribtGwvq8Dgw/Eu8iJgV2pcOzsliyI+9Zq9gBQE4r7rFjvXt
        1Lm2/t72k2uSF1KGIj7d4gBvVqxeLmBAX4NLqgM=
X-Google-Smtp-Source: ABdhPJysMmQYIo1h3VxoqPh1PKRxUaQ2M/1AowyMPIc49/j/epzYRmiJfssaucD64MBAjBASXL0xm8s+qHvUHjVO3Fg=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr33970309plh.3.1636127597077; Fri, 05 Nov
 2021 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000013aebd05cff8e064@google.com> <87lf224uki.ffs@tglx>
In-Reply-To: <87lf224uki.ffs@tglx>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 5 Nov 2021 08:53:06 -0700
Message-ID: <CAADnVQLcuMAr3XMTD1Lys5S5ybME4h=NL3=adEwib2UT6b-E9w@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in ktime_get_coarse_ts64
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rosted@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Dmitrii Banshchikov <me@ubique.spb.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> >
> > -> #0 (tk_core.seq.seqcount){----}-{0:0}:
> >        check_prev_add kernel/locking/lockdep.c:3051 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3174 [inline]
> >        validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
> >        __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
> >        lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
> >        seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
> >        ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
> >        ktime_get_coarse include/linux/timekeeping.h:120 [inline]
> >        ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]
>
> --> this call is invalid
>
> >        ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
> >        bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
> >        bpf_prog_a99735ebafdda2f1+0x10/0xb50
> >        bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
> >        __bpf_prog_run include/linux/filter.h:626 [inline]
> >        bpf_prog_run include/linux/filter.h:633 [inline]
> >        BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
> >        trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
> >        perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
> >        perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
> >        trace_lock_release+0x128/0x150 include/trace/events/lock.h:58
>
> Timestamps from within a tracepoint can only be taken with:
>
>          1) jiffies
>          2) sched_clock()
>          3) ktime_get_*_fast_ns()
>
> Those are NMI safe and can be invoked from anywhere.
>
> All other time getters which have to use the timekeeping seqcount
> protection are prone to live locks and _cannot_ be used from
> tracepoints ever.

Obviously.
That helper was added for networking use cases and accidentally
enabled for tracing.
