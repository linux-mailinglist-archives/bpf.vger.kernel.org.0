Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1D47C828
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhLUUQq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 15:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhLUUQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 15:16:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB06C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 12:16:46 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kj16so349903qvb.2
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jgn+Q9M5IoGJPp/mNQn5jvRI24f2+L4co3MgmLoIur4=;
        b=sRyoq01ohQZDxqEZd8vi2BpALdp+Cha7YoRPGusuPEoKV7RCdY+d/9q+MRxVmCNxsZ
         g784IZNkZZdU7TRJDhO7I7gMVf83c6QNulCavk2TP7jyc/NunF+whBHL+ucFpi+YSDPZ
         7KkUFoRQ4V62xeSmxtA4AYp1VjWmyGGrnRUcqYEKO2LtHrcn4ICdHm9N5E6LW869xCvu
         8HWt74uFFIIVI4IIvcNdiMWSyQbJE2RjNb5psLRqKSfblBWEUz0oi1ac4Yaye8rRKL5x
         41UbizhpQlXSGDainwQQZCujzFbYmV9IIKNZpvYuN974HjUMjn6dfPlJiXP0rPafK3kE
         3xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jgn+Q9M5IoGJPp/mNQn5jvRI24f2+L4co3MgmLoIur4=;
        b=yqixKKD7QFwUcyrqC9UGz9cbx+uu/9xi+yXNHynA+R/kN0YFvO7y4dRCqJY+FZKg85
         7OvR7AdK40FLlqmflA6++LSa5ZiC4ENi15sR5cF0tBiWGXTE8yI+UlfmRqkLh5HfR9iY
         Z8dA2zNdeVQe/XGLufZn2pD1OtdrUhf+HJavrloBnqxDbEBYQFFNFFIx52JpMuT6cSWw
         nVAzp0L5Ag2wUsjk8JJeAkti4QyFFE0iF47Rff4XOm+wRKbKadcWDKcouxhdT/fbKCir
         dkgHlUHB2d8wkzPl2PS0bJw/s2EOa6bSP8SqE/L/Ffhv3t57a3g92TRn0mEdTuBVG0TS
         wxGA==
X-Gm-Message-State: AOAM5308O+RY6lHG3UiASlXS67kTz5BZo1KK86T9WfCInkOkzNUKcFwI
        CWmg/zfnpEBuzFIja0A+Cq4F/cn5MEIjDn8NKU3jJQ==
X-Google-Smtp-Source: ABdhPJxvYWLiamdm7LPNMWzdvHq32UhWY/owc0aMhUsi5daIceK1ZKK+Ei4OGHP5ODxCfiTw+XimVRtkM8VsHkbJMR4=
X-Received: by 2002:ad4:5aa5:: with SMTP id u5mr3985976qvg.35.1640117804887;
 Tue, 21 Dec 2021 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20211220201204.653248-1-haoluo@google.com> <cd32b6d2-bbca-7442-419a-653f0fb5c3c7@fb.com>
In-Reply-To: <cd32b6d2-bbca-7442-419a-653f0fb5c3c7@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 21 Dec 2021 12:16:33 -0800
Message-ID: <CA+khW7iVPr-AWZwD61MkZHUhPowOVK98qMPnkhAh-GCRncSJEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Test bpf_d_path on rdonly_mem.
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 20, 2021 at 8:28 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/20/21 12:12 PM, Hao Luo wrote:
> > The second parameter of bpf_d_path() can only accept writable
> > memories. rdonly_mem obtained from bpf_per_cpu_ptr() can not
> > be passed into bpf_d_path for modification. This patch adds
> > a selftest to verify this behavior.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >   .../testing/selftests/bpf/prog_tests/d_path.c | 22 +++++++++++++-
> >   .../bpf/progs/test_d_path_check_rdonly_mem.c  | 30 +++++++++++++++++++
> >   2 files changed, 51 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > index 0a577a248d34..f8d8c5a5dfba 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > @@ -9,6 +9,7 @@
> >   #define MAX_FILES           7
> >
> >   #include "test_d_path.skel.h"
> > +#include "test_d_path_check_rdonly_mem.skel.h"
> >
> >   static int duration;
> >
> > @@ -99,7 +100,7 @@ static int trigger_fstat_events(pid_t pid)
> >       return ret;
> >   }
> >
> > -void test_d_path(void)
> > +static void test_d_path_basic(void)
> >   {
> >       struct test_d_path__bss *bss;
> >       struct test_d_path *skel;
> > @@ -155,3 +156,22 @@ void test_d_path(void)
> >   cleanup:
> >       test_d_path__destroy(skel);
> >   }
> > +
> > +static void test_d_path_check_rdonly_mem(void)
> > +{
> > +     struct test_d_path_check_rdonly_mem *skel;
> > +
> > +     skel = test_d_path_check_rdonly_mem__open_and_load();
> > +     ASSERT_ERR_PTR(skel, "unexpected load of a prog using d_path to write rdonly_mem\n");
> > +
> > +     test_d_path_check_rdonly_mem__destroy(skel);
>
> You shouldn't call test_d_path_check_rdonly_mem__destroy(skel) if skel
> is an ERR_PTR. Maybe
>         if (!ASSERT_ERR_PTR(...))
>                 test_d_path_check_rdonly_mem__destroy(skel);
>

Ack. Will change that.

I don't know if it's only me: I find it confusing when figuring out
what ASSERT_ERR_PTR(ptr) returns. Is the returned value 'ptr'? or 'ptr
!= NULL'? or 'err != 0'? I used to think ASSERT-like function/macro
returns nothing.

I noticed that xxx__destroy has a check for NULL, so I put the destroy
function unconditionally.

> > +}
> > +
> > +void test_d_path(void)
> > +{
> > +     if (test__start_subtest("basic"))
> > +             test_d_path_basic();
> > +
> > +     if (test__start_subtest("check_rdonly_mem"))
> > +             test_d_path_check_rdonly_mem();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> > new file mode 100644
> > index 000000000000..c7a9655d5850
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2021 Google */
> > +
> > +#include "vmlinux.h"
> > +
> > +#include "vmlinux.h"
>
> duplicated vmlinux.h.
>

Thanks. Will fix that.

> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +extern const int bpf_prog_active __ksym;
> > +
> > +SEC("fentry/security_inode_getattr")
> > +int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
> > +          __u32 request_mask, unsigned int query_flags)
> > +{
> > +     char *active;
>
> int *active?
> It may not matter since the program is rejected by the kernel but
> with making it conforms to kernel definition we have one less thing
> to worry about the verification.
>

Because bpf_d_path() accepts 'char *' instead of 'int *', I need to
cast 'active' to 'char *' somewhere, otherwise the compiler will issue
a warning. To combine with your comment, maybe the following:

int *active;
active = (int *)bpf_per_cpu_ptr(...);
...
bpf_d_path(path, (char *)active, sizeof(int));

> > +     __u32 cpu;
> > +
> > +     cpu = bpf_get_smp_processor_id();
> > +     active = (char *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
>
> int *
>
> > +     if (active) {
> > +             /* FAIL here! 'active' is a rdonly_mem. bpf helpers that
>
> 'active' points to readonly memory.
>

Ack.

> > +              * update its arguments can not write into it.
> > +              */
> > +             bpf_d_path(path, active, sizeof(int));
> > +     }
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
