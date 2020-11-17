Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AA2B5674
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 02:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKQBzR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 20:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQBzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 20:55:17 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B54C0613D2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 17:55:17 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b17so22437617ljf.12
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfmeEzTzooKWiWXCjbwP20V8N58LWWLSI+WemXBqoSo=;
        b=TupcO9kkun3hFmFaHl+Hd59DU33+9i2l1KglJF0L5RdSg05j11UByYlDKCEr906/SB
         06DminEu3QjwEzyvvFnwk5AzhzWZVlLL3sleE4dH+4wlNwJ9YMZL6PCAyIhx7/LGUV8p
         pydxIu3TUTFSQf4Mdti2YUr3a+qqqtQZxjcGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfmeEzTzooKWiWXCjbwP20V8N58LWWLSI+WemXBqoSo=;
        b=CUE86rssWAP5FnGqiG6Jck4QmjPbYghwRnjqmat7ssT0/MOr/MyQi8oQJwHvsglMxd
         /oU2j1zqswfixxfUdUTGTX8DEd+s3/OtRxTAB1U3vwFSLnwAKTrl0Q3K0bfs29tkqUxD
         n8osOyfbWvUSoIDoPD63Ph/yOPC9CMyTIaLHi++aAXhmgWspxY1wmysgWKmPI+bMyrOy
         m0q/nT9Ib0mCVhlvH9VZZ2lzonYjncCf7wM//eMJbXQlolQzTIys/BEIc0j5VKmBEVJK
         rUqt314kX++RtUFkDIuL9oieA6C0gVBwff3lLhFrAYm9wUOFpH+N1iUTlPu3eNgwaV06
         qmvQ==
X-Gm-Message-State: AOAM5331+I9NH6Dv+7HYCmTBK6FkykNR/XkmcXnVqsKvRvcSlmzbdV/3
        EHik1dfsc07r+fbXK2CxU7fb56zmzN4cFhX3IInaEG8bAXlecY6A
X-Google-Smtp-Source: ABdhPJyYqclDkEPQUIluKSITU8uV0ihQHUQvxzyKDVy+syv1mcr6maPIcigji34v5DajSjRS3l6kDOnbeNwcgZPIUIY=
X-Received: by 2002:a2e:b16f:: with SMTP id a15mr896846ljm.430.1605578114448;
 Mon, 16 Nov 2020 17:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20201116232536.1752908-1-kpsingh@chromium.org>
 <20201116232536.1752908-2-kpsingh@chromium.org> <20201117004303.zpzoqluhslwbp7ce@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201117004303.zpzoqluhslwbp7ce@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 17 Nov 2020 02:55:03 +0100
Message-ID: <CACYkzJ5oisqFDW3QU_+Wuuh4UiRmrjH2mR0UM9qCm8RuCjzzeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 1:43 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Nov 16, 2020 at 11:25:36PM +0000, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The test forks a child process, updates the local storage to set/unset
> > the securexec bit.
> >
> > The BPF program in the test attaches to bprm_creds_for_exec which checks
> > the local storage of the current task to set the secureexec bit on the
> > binary parameters (bprm).
> >
> > The child then execs a bash command with the environment variable
> > TMPDIR set in the envp.  The bash command returns a different exit code
> > based on its observed value of the TMPDIR variable.
> >
> > Since TMPDIR is one of the variables that is ignored by the dynamic
> > loader when the secureexec bit is set, one should expect the
> > child execution to not see this value when the secureexec bit is set.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  .../selftests/bpf/prog_tests/test_bprm_opts.c | 124 ++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/bprm_opts.c |  34 +++++
> >  2 files changed, 158 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bprm_opts.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
> > new file mode 100644
> > index 000000000000..cba1ef3dc8b4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_bprm_opts.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +
> > +#include <asm-generic/errno-base.h>
> > +#include <sys/stat.h>
> Is it needed?

No, Good catch, removed.

>
> > +#include <test_progs.h>

[...]

> > +              * If the value of TMPDIR is set, the bash command returns 10
> > +              * and if the value is unset, it returns 20.
> > +              */
> > +             ret = execle("/bin/bash", "bash", "-c",
> > +                          "[[ -z \"${TMPDIR}\" ]] || exit 10 && exit 20",
> > +                          NULL, bash_envp);
> > +             if (ret)

> It should never reach here?  May be just exit() unconditionally
> instead of having a chance to fall-through and then return -EINVAL.

Agreed. changed it to exit(errno); here.

>
> > +                     exit(errno);
> > +     } else if (child_pid > 0) {
> > +             waitpid(child_pid, &child_status, 0);
> > +             ret = WEXITSTATUS(child_status);
> > +
> > +             /* If a secureexec occured, the exit status should be 20.
> > +              */
> > +             if (secureexec && ret == 20)
> > +                     return 0;
> > +
> > +             /* If normal execution happened the exit code should be 10.
> > +              */
> > +             if (!secureexec && ret == 10)
> > +                     return 0;
> > +
> > +             return ret;
> Any chance that ret may be 0?

I think it's safer to just let it fall through and return -EINVAL, so
I removed the return ret here.

>
> > +     }

[...]

> > +                              0 /* secureexec */);
> > +     if (CHECK(err, "run_set_secureexec:0", "err = %d", err))
> nit. err = %d"\n"

Fixed.

>
> > +             goto close_prog;
> > +
> > +     /* Run the test with the secureexec bit set */
> > +     err = run_set_secureexec(bpf_map__fd(skel->maps.secure_exec_task_map),
> > +                              1 /* secureexec */);
> > +     if (CHECK(err, "run_set_secureexec:1", "err = %d", err))
> Same here.

Fixed.

- KP

>
> Others LGTM.
