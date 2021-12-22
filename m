Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F347CAA3
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 02:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbhLVBGG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 20:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbhLVBGG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 20:06:06 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E309C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 17:06:06 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 131so830941qkk.2
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 17:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URvwdgBa4iT/HxTcqN5UHt4bzLe//3fi8I/mIeMv9Sk=;
        b=UoUxNws9Q7R6gv/F49dAK1CX+7jFX8d+2BCyaQOn4MeK3cUbiQPUUGE+3j+giskwlO
         C5RsrSe+i+YIXy+gkcl+uo94l7k/Qg9ixMKJ+FBiIadMsOeM+sTS5JVpT4lgM/WjA0rv
         /KdM4nRSeZn9qntV/FgJAombYCkglxUyKnYRxYna62DVa3LWEJ3eyGaJujsT9cDILKfW
         CBL7at2+tGVlAxrWL1pjt8tzJufQHbbaD+7i1pIYdQT8D3IWe281iCwhX0WUeeObZQYf
         PXXdGVS2gQodj/a6VLOO4mHB4SMgPKUooMT5tk3bnpFHTM8ywtJEZ4ocTFvjS0m0IA3Q
         R8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URvwdgBa4iT/HxTcqN5UHt4bzLe//3fi8I/mIeMv9Sk=;
        b=j1k4fUHTeXY8OR2CL0SmK/nEZuFwhogSD4vntz8lebZW+wosvroou1BOb3rX9QHzto
         ZMftSldldrebUU10RsMPQRrF7HHwJFnTLdxrgMTRWE3IeH7qP3oRV7zK6SkLO3mPPC7g
         xJwxC9BKSVr34w+DZJyyYHfGWKzYOyWnKrELrw3sJxUXTAqdgnB8eXO7WtT5EGnAAjXY
         6oI+Vt4HO4ysIMW+UFTBs/497uzVV3aIs5gB1iAeHeDSxtApegtMBOi2+32j23+A7lRK
         +RXlrjrrlJfcI5LT0YPq0hPIuj16NZ9kBsVJCXkkPso7Q4eoz25d1/rGOs/Y4iDBA3SB
         j9ow==
X-Gm-Message-State: AOAM5325lzHO5rDjS1bV+qsqSl0hZdEnxDzircnQiyS9GnqwOTkwee51
        F3wxD1ESwS0raQighHmBVtXPgjH6R8S5SEIOFvmItg==
X-Google-Smtp-Source: ABdhPJzF/zejOTH8faPcsQzwdpE17eCL3I6vNfyg9I3WoQ4lwofeib8/E0q7IUdgxxYtZg6/z0w8pNnVY1algKacdVc=
X-Received: by 2002:a05:620a:454d:: with SMTP id u13mr676312qkp.221.1640135165088;
 Tue, 21 Dec 2021 17:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20211220201204.653248-1-haoluo@google.com> <cd32b6d2-bbca-7442-419a-653f0fb5c3c7@fb.com>
 <CA+khW7iVPr-AWZwD61MkZHUhPowOVK98qMPnkhAh-GCRncSJEA@mail.gmail.com> <CAEf4BzY6s0hh52dn4QB9uFkk7HsxAfebkaKP6GxmUEds_4nU6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY6s0hh52dn4QB9uFkk7HsxAfebkaKP6GxmUEds_4nU6Q@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 21 Dec 2021 17:05:53 -0800
Message-ID: <CA+khW7gtxOqDJzL+VbFQkPv3XQXnEndFNUZeVg2p5LQBm1J48g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Test bpf_d_path on rdonly_mem.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 21, 2021 at 4:24 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 21, 2021 at 12:16 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Dec 20, 2021 at 8:28 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > >
> > > On 12/20/21 12:12 PM, Hao Luo wrote:
> > > > The second parameter of bpf_d_path() can only accept writable
> > > > memories. rdonly_mem obtained from bpf_per_cpu_ptr() can not
> > > > be passed into bpf_d_path for modification. This patch adds
> > > > a selftest to verify this behavior.
> > > >
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > >   .../testing/selftests/bpf/prog_tests/d_path.c | 22 +++++++++++++-
> > > >   .../bpf/progs/test_d_path_check_rdonly_mem.c  | 30 +++++++++++++++++++
> > > >   2 files changed, 51 insertions(+), 1 deletion(-)
> > > >   create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > > > index 0a577a248d34..f8d8c5a5dfba 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > > > @@ -9,6 +9,7 @@
> > > >   #define MAX_FILES           7
> > > >
> > > >   #include "test_d_path.skel.h"
> > > > +#include "test_d_path_check_rdonly_mem.skel.h"
> > > >
> > > >   static int duration;
> > > >
> > > > @@ -99,7 +100,7 @@ static int trigger_fstat_events(pid_t pid)
> > > >       return ret;
> > > >   }
> > > >
> > > > -void test_d_path(void)
> > > > +static void test_d_path_basic(void)
> > > >   {
> > > >       struct test_d_path__bss *bss;
> > > >       struct test_d_path *skel;
> > > > @@ -155,3 +156,22 @@ void test_d_path(void)
> > > >   cleanup:
> > > >       test_d_path__destroy(skel);
> > > >   }
> > > > +
> > > > +static void test_d_path_check_rdonly_mem(void)
> > > > +{
> > > > +     struct test_d_path_check_rdonly_mem *skel;
> > > > +
> > > > +     skel = test_d_path_check_rdonly_mem__open_and_load();
> > > > +     ASSERT_ERR_PTR(skel, "unexpected load of a prog using d_path to write rdonly_mem\n");
> > > > +
> > > > +     test_d_path_check_rdonly_mem__destroy(skel);
> > >
> > > You shouldn't call test_d_path_check_rdonly_mem__destroy(skel) if skel
> > > is an ERR_PTR. Maybe
> > >         if (!ASSERT_ERR_PTR(...))
> > >                 test_d_path_check_rdonly_mem__destroy(skel);
> > >
> >
> > Ack. Will change that.
>
> no need, __destroy() handles NULLs and ERR_PTR just fine, the way you
> wrote it is totally correct (that's a deliberate nice feature of
> libbpf's "destructor" APIs)
>

Yep. That's also my understanding.

> >
> > I don't know if it's only me: I find it confusing when figuring out
> > what ASSERT_ERR_PTR(ptr) returns. Is the returned value 'ptr'? or 'ptr
> > != NULL'? or 'err != 0'? I used to think ASSERT-like function/macro
> > returns nothing.
> >
>
> You haven't looked at many other selftests, I presume. All the
> ASSERT_xxx() macros return true/false depending whether the assertion
> holds or not. ASSERT_ERR_PTR() checks that ptr *is* erroneous (which
> is NULL and ERR_PTR). If it's not, it returns false. So
>
> if (!ASSERT_ERR_PTR(ptr, "short_descriptor"))
>    /* do something if assertion failed */
>
> is a common pattern.
>
> Note also "short_descriptor", it's not supposed to be a long
> descriptive sentences, it's sort of a "codename" of the particular
> check. It's not illegal to use space-separated sentence, but better to
> keep it short and identifier-like.
>

I see. Thanks for the explanation.

> > I noticed that xxx__destroy has a check for NULL, so I put the destroy
> > function unconditionally.
> >
> > > > +}
> > > > +
> > > > +void test_d_path(void)
> > > > +{
> > > > +     if (test__start_subtest("basic"))
> > > > +             test_d_path_basic();
> > > > +
> > > > +     if (test__start_subtest("check_rdonly_mem"))
> > > > +             test_d_path_check_rdonly_mem();
> > > > +}
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> > > > new file mode 100644
> > > > index 000000000000..c7a9655d5850
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
> > > > @@ -0,0 +1,30 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2021 Google */
> > > > +
> > > > +#include "vmlinux.h"
> > > > +
> > > > +#include "vmlinux.h"
> > >
> > > duplicated vmlinux.h.
> > >
> >
> > Thanks. Will fix that.
> >
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +
> > > > +extern const int bpf_prog_active __ksym;
> > > > +
> > > > +SEC("fentry/security_inode_getattr")
> > > > +int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
> > > > +          __u32 request_mask, unsigned int query_flags)
> > > > +{
> > > > +     char *active;
> > >
> > > int *active?
> > > It may not matter since the program is rejected by the kernel but
> > > with making it conforms to kernel definition we have one less thing
> > > to worry about the verification.
> > >
> >
> > Because bpf_d_path() accepts 'char *' instead of 'int *', I need to
> > cast 'active' to 'char *' somewhere, otherwise the compiler will issue
> > a warning. To combine with your comment, maybe the following:
> >
> > int *active;
> > active = (int *)bpf_per_cpu_ptr(...);
> > ...
> > bpf_d_path(path, (char *)active, sizeof(int));
> >
>
> why not `void *`?
>

'void *' works. Just haven't thought about that.

> > > > +     __u32 cpu;
> > > > +
> > > > +     cpu = bpf_get_smp_processor_id();
> > > > +     active = (char *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
> > >
> > > int *
> > >
> > > > +     if (active) {
> > > > +             /* FAIL here! 'active' is a rdonly_mem. bpf helpers that
> > >
> > > 'active' points to readonly memory.
> > >
> >
> > Ack.
> >
> > > > +              * update its arguments can not write into it.
> > > > +              */
> > > > +             bpf_d_path(path, active, sizeof(int));
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +char _license[] SEC("license") = "GPL";
