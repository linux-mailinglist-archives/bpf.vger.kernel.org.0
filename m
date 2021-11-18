Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF14551CB
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhKRAke (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 19:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhKRAkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 19:40:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC06C061767
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:37:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x6so7263413edr.5
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 16:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHmkZszPR6EELtxyc0tZ5ImEP6GCMXNuKUoNO1WLl4A=;
        b=G+Az4leoYHWjXC176OT/xR8EoiNodE3UlIl9ddIYba1/nV7CORra7HBL4DptBg3QUq
         NQlFUVejndDpvLty7d7Y4RcDcpHvTbW1v7DnxyzRovMW+0YIbEspfZSRLWm2omOMY9qc
         HAF2aebOm9RxOWip8Q0KjhFqmJLXYB5d8//Asua/4C7ZC5vLsCLyryEoleJlsMlZ7dRz
         ylVcglAE2EsGVjRPzcSKPmtJOh9HcKD6S4gdoW18AFzzikJhLefle9XYW7rHu7NQuLER
         ZVGAW8frokLTzFAA6CclBHmM9iz9n0+9unpWLnA0WBwsH0w9XP8gaZKsQoR6NI5w6ecr
         TjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHmkZszPR6EELtxyc0tZ5ImEP6GCMXNuKUoNO1WLl4A=;
        b=IeySBbtpH890b0Fnb2hoL/FH5RM/FmHttbzl95fED0KdA2kG3w7HGHzgTYGqUdO/uL
         dYSQ6t7SfBNRlbwtbhyJDsFrGRHqxsjh3bMkxDk4WQdZeuOFAmyrFJ1RqbLA0sL/DLrE
         2ilM0U8gIP7QLmGd2L6BHLqR8c3aPPswYhVI1KhGnpxZhCWwiiTGoBt0JZfuZtGMKoa2
         jH4CorhgR707hC5DHGM5RuGusJv7Haq/ldLBlZ1T69BAl+HRXiF9A6LVrasgLQxItxWB
         DCpetAnXB0zXUXXxpmC2UWrcD/izHwvfu8S8SfoRuZsF5HGgZ8dTwaP3vQFoELqB4xTS
         NVsw==
X-Gm-Message-State: AOAM530XR1CVBHYUVMjoLwfrWwxLc10EwOT0IGDUqW0RtPwGvkaiweA4
        +48AdgpwU9P4t31wqLhaO/SQ7byUe2WyZ5Iu+AY7wQ==
X-Google-Smtp-Source: ABdhPJxYJytp1pKphdFW2jBHyU5wMlXwFvI1+mIFO9dA4MYHB84eYMqVfc/KNHGNV9du6PqVFrN9mH2uwzEDhLGEmA8=
X-Received: by 2002:a17:906:8699:: with SMTP id g25mr27232161ejx.271.1637195852821;
 Wed, 17 Nov 2021 16:37:32 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
 <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
In-Reply-To: <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 16:37:21 -0800
Message-ID: <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 3:24 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 17, 2021 at 1:54 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The SA_IMMUTABLE change was to deal with failures seen in the seccomp
> > test suite after the recent fatal signal refactoring. Mainly that a
> > process that should have effectively performed do_exit() was suddenly
> > visible to the tracer.
>
> I think this basically shows that the conversion from do_exit() to
> fatal_signal() was just wrong. The "do_exit()" wasn't really a signal,
> and can't be treated as such.
>
> That said, instead of reverting, maybe we can just mark the cases
> where it really is about sending a synchronous signal, vs sending an
> explicitly fatal signal.
>
> It's basically the "true" condition to force_sig_info_to_task(), so
> the fix might be just
>
>   @@ -1323,7 +1323,8 @@ force_sig_info_to_task(struct kernel_siginfo
> *info, struct task_struct *t, bool
>         blocked = sigismember(&t->blocked, sig);
>         if (blocked || ignored || sigdfl) {
>                 action->sa.sa_handler = SIG_DFL;
>   -             action->sa.sa_flags |= SA_IMMUTABLE;
>   +             if (sigdfl)
>   +                     action->sa.sa_flags |= SA_IMMUTABLE;
>                 if (blocked) {
>                         sigdelset(&t->blocked, sig);
>                         recalc_sigpending_and_wake(t);
>
> Kyle, does that fix your test-case? And Kees - yours?

This fixes most of the issues with rr, but it still changes the ptrace
behavior for the double-SIGSEGV case (yes, we have a test for that
too). The second SIGSEGV isn't reported to the ptracer and the program
just skips straight to the PTRACE_EVENT_EXIT. This is visible in gdb
as well (only the first SIGSEGV is caught).

- Kyle
