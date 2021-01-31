Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5E309D90
	for <lists+bpf@lfdr.de>; Sun, 31 Jan 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhAaNw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 08:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhAaLg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 06:36:58 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6AC0613ED
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 03:14:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 2so6812889qvd.0
        for <bpf@vger.kernel.org>; Sun, 31 Jan 2021 03:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=M6FYv2E9knGDI0iH5735540Zhg7wHmzZM3kiJ0bDwD8=;
        b=kdAJi0ttpQ2n0qnKhIK0PLMC+m6DJUNgxjpcbTKjTE6lM3zj0UL7zhRVEwgIAm4G34
         ENbHTaggz1X9MPXhlyoGaH8PVPS9s1JMoE3nVw9Ez/Nf0GAdWmFy7VIeQs+LyAtED47U
         amEOHoXcK6qp/aEU3+9zbeLnjXedMYDHOj6+nA53IgrEHIV+xzZE9LI/MaEvCZBQAOBQ
         dX1I1bKCqcOAHPcCbf3mmwVUS3qXbG2kBzltodoEiaQ17i2N5LjyONOAVVPw92BOu3fF
         Y4n73EDxa81fXu2KoFaf0DTwopN9dj9SoVNDzbnbRyPi2DCnoAzxi6njPL3Zn7Z+qy9p
         GyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M6FYv2E9knGDI0iH5735540Zhg7wHmzZM3kiJ0bDwD8=;
        b=nzQSntETNDtaRcdqwkUisw1GRBBpyBgRHaLLG1zpuhd2mqR0HP6ce8SnjzwYMqLtCh
         FxRXLtQ/j/spbJU/eH3q4lGEHjw3b+u5ffyzA3/pxgRNmUQIwO/RnT4oZJoKf7Kz3i8b
         juLbXshMitOzNrMYClflfYjsat8hTr3hxR8fI778Aj/mFHNanc62N/tTSgiOAaF71vHp
         c14fItPGExLPJeg4W+LOEg3ouYOQ2cQ3omAflT5q0o1f1QdB/DeJOn11RMexUIWeOhOg
         GfilqwCqwrvbYfxinR3MDy4PBZDayjpd0e5RggR27MFH4BLQotdgttBbiTv9/qWebno1
         1C+w==
X-Gm-Message-State: AOAM53171V+eq8LY2BdxA/tY0hq8KPiem3A1gSHHgejIg8goQadYLfAZ
        e802HI3Ar1sA3+oLn8XzlkN566Sty3l+yl6aelw7Zw==
X-Google-Smtp-Source: ABdhPJzAOYh6Z+vnGrWEgn3eJO0QOVKZGIK+91A/+wCbtzCZpJMtO2ghtP9/7nfcXhMpvwMO9YniWvCQcfbLsrKHuVE=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr11269583qva.18.1612091653636;
 Sun, 31 Jan 2021 03:14:13 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 31 Jan 2021 12:14:02 +0100
Message-ID: <CACT4Y+a7UBQpAY4vwT8Od0JhwbwcDrbJXZ_ULpPfJZ42Ew-yCQ@mail.gmail.com>
Subject: extended bpf_send_signal_thread with argument
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@davemloft.net>, kpsingh@kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I would like to send a signal from a bpf program invoked from a
perf_event. There is:

// kernel/trace/bpf_trace.c
BPF_CALL_1(bpf_send_signal_thread, u32, sig)

which is nice, but it does not allow me to pass any arguments.
I can use a bpf map indexed by pid to "pass" some additional info, but
it's messy and slow (and may cause some synchronization issues, I am
not sure yet).

Signals allow to pass additional arguments, it would be nice to expose
this to bpf programs as well. Any objections? Do you see any potential
issues with this? On the implementation side it seems to be almost
trivial to add something like this:

BPF_CALL_2(bpf_send_signal_thread_ex, u32, sig, uintptr_t sival)

However, siginfo_t is way larger and allows to pass a whole lot of
info, and the latest user-space APIs pidfd_send_signal just directly
accepts siginfo_t (and rt_tgsigqueueinfo as well). But I am not sure
how to expose it according to bpf rules. Could we do something like
(pass whatever you want, it's your business)?

BPF_CALL_2(bpf_send_signal_thread_ex, u32, sig, char siginfo[sizeof(siginfo_t)])

Does it make sense? If yes, what would be the best way to expose this?

Thanks
