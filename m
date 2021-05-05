Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220D937484D
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhEES47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhEES46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 14:56:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E37C061574;
        Wed,  5 May 2021 11:56:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e190so4024324ybb.10;
        Wed, 05 May 2021 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvFr8MjdTnG10e+0AkGGA+m42ZxevnjfbeEU57hfbjM=;
        b=kpcwsuV0QEC2lJSPW9DJ4P1zjk8DI+9DWQxBXRnpIh3HWcq4IueirxqgyJ5/4AvJXV
         N6jyLWGnDGD6eXuallTfg5nuasXtyutu9Rg1xErrUnXxSz6MDexmoRsVTUevB9vHfvYr
         iWvhmIJYi+YnBcFCEifpGAI/ufYXvQ0d5ZuREQJf2W2FNMNhWBJs6VGm6eoHI8WGVuft
         hP11y+WzdjaZRNwgNBT7/9gFLF1lbhoD2FSOSR0gHT5THvLWX6tvvHN0xABNVy62sLT6
         +Bms1PdKYpdGhVfkinqQx3nP0mj+9JGFCHHPSel7DGhdz/vylNLhpfPMaC2R4kkkG1Gw
         p8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvFr8MjdTnG10e+0AkGGA+m42ZxevnjfbeEU57hfbjM=;
        b=Q7Efj8DVL3I2HB7/7ihiTpewdExFX827/YKg2V1jNMHpSIVXKW117NMz7X1fI4Qs+n
         jBI6VDjzw43XjCa6+XF7bEQlKq/uo6N/MZgYYLDCxubCbuVZv85qwjhPvvfH8ShwM5aP
         7rOeG+gFD8G3rNT0TkNtukWQqdxol4hjrIlVZyxXy77gLIPa8lTEjYCI/P/i7PyGrIst
         ab+ethAPfFDSh4NLEp1IryYaEyECdGGqJ9VjPrUCGTBS65kvTp7TLziC7sNCXQOBzB2r
         kF7+0Z7L5wMIl2QrZogRSgYhLcUE+s5S9us1NLoYuREClI2UoBbRf1g5Zt5lvToUQ+wq
         SbgQ==
X-Gm-Message-State: AOAM530ORWt4JPvkcQpb9R80KTuZmha9b6h3MNPa//ok1rQJrXfFaX1H
        APv8oQNinxbX1mX6kLlGkQLwjHqcx8rBo/opiFQ=
X-Google-Smtp-Source: ABdhPJzuwWib3xbYYPmAHaE+YxXoPfRZ+T7GE26yNl5WNy9Zq9KnQzuA0VUYMuaWBHh6b58xK6Io4i/mpUkEY/JawBQ=
X-Received: by 2002:a5b:286:: with SMTP id x6mr265343ybl.347.1620240960890;
 Wed, 05 May 2021 11:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210505162307.2545061-1-revest@chromium.org>
In-Reply-To: <20210505162307.2545061-1-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 May 2021 11:55:49 -0700
Message-ID: <CAEf4BzZiK1ncN7RzeJ-62e=itekn34VuFf7WNhUF=9OoznMP6Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 5, 2021 at 9:23 AM Florent Revest <revest@chromium.org> wrote:
>
> The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
> per-cpu buffer that they use to store temporary data (arguments to
> bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
> by the end of their scope with bpf_bprintf_cleanup.
>
> If one of these helpers gets called within the scope of one of these
> helpers, for example: a first bpf program gets called, uses

Can we afford having few struct bpf_printf_bufs? They are just 512
bytes, so can we have 3-5 of them? Tracing low-level stuff isn't the
only situation where this can occur, right? If someone is doing
bpf_snprintf() and interrupt occurs and we run another BPF program, it
will be impossible to do bpf_snprintf() or bpf_trace_printk() from the
second BPF program, etc. We can't eliminate the probability, but
having a small stack of buffers would make the probability so
miniscule as to not worry about it at all.

Good thing is that try_get_fmt_tmp_buf() abstracts all the details, so
the changes are minimal. Nestedness property is preserved for
non-sleepable BPF programs, right? If we want this to work for
sleepable we'd need to either: 1) disable migration or 2) instead of
assuming a stack of buffers, do a loop to find unused one. Should be
acceptable performance-wise, as it's not the fastest code anyway
(printf'ing in general).

In any case, re-using the same buffer for sort-of-optional-to-work
bpf_trace_printk() and probably-important-to-work bpf_snprintf() is
suboptimal, so seems worth fixing this.

Thoughts?

> bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
> another bpf program that calls bpf_trace_printk again, then the second
> "get" fails. Essentially, these helpers are not re-entrant, and it's not
> that bad because they would simply return -EBUSY and recover gracefully.
>
> However, when this happens, the code hits a WARN_ON_ONCE. The guidelines
> in include/asm-generic/bug.h say "Do not use these macros [...] on
> transient conditions like ENOMEM or EAGAIN."
>
> This condition qualifies as transient, for example, the next
> raw_spin_lock_irqsave probe is likely to succeed, so it does not deserve
> a WARN_ON_ONCE.
>
> The guidelines also say "Do not use these macros when checking for
> invalid external inputs (e.g. invalid system call arguments" and, in a
> way, this can be seen as an invalid input because syzkaller triggered
> it.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> Reported-by: syzbot <syzbot@syzkaller.appspotmail.com>
> Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 544773970dbc..007fa26eb3f5 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -709,7 +709,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
>
>         preempt_disable();
>         used = this_cpu_inc_return(bpf_printf_buf_used);
> -       if (WARN_ON_ONCE(used > 1)) {
> +       if (used > 1) {
>                 this_cpu_dec(bpf_printf_buf_used);
>                 preempt_enable();
>                 return -EBUSY;
> --
> 2.31.1.527.g47e6f16901-goog
>
