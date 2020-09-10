Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A53264A6C
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIJQ44 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgIJQzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:55:33 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1587C0617BB
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:47:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h206so4478277ybc.11
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V935wsuypFrL/JZaja+JmDvN5oE6qU7peeqpceG1Z2o=;
        b=ZkJ1kdxIuFUxL2ppKuNh69lkntdfXk+duNVBPpn9aLxh/oeuwZN1VArksAQ94Ud3AV
         Pxa7YnNjb0idFOVsvI4OwOjTofiCFktgEI/SXtj0nKMHWL1mFF6GTg1NPZzb1GsrXhyn
         urMaNoHdw+2tqNafxkOUqQwprGUuV3GG0Oi2iLg+/p81XAtuWnjbTGUys0Eiy3vC6yU3
         vvUp26eufbtvnzccKeljeFi5oswaJsCaTrmdK/4MXdZB00Ew9+mXPzyadGyRChnveqqx
         T9vOWFXzaM6RzpD+y54bqSLWxzBM62nQLIIg9MKLnOoQ5zsU6J7zbVpoIvxYFwdhvee3
         X8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V935wsuypFrL/JZaja+JmDvN5oE6qU7peeqpceG1Z2o=;
        b=dTQs1rydeKnSDaJV6A/f8cqoQJzGt6+pygW/Cs/cqK4Prs2foMF9xlgvPYZ292i7tA
         FRo8Ree6OTE6VuZZD8+HT9j+EfJ7C7yMl/hAc31CWN+yuGi2A3bl84q7TucXwuLfSCW5
         buoNiKg0eUF64Fx7Jp0JEGluRV7waWkHBrUUYeU8ZNyIB96bQ7PgHq9y81OK5Ke5subn
         5K0d4Y2qY/VxpO0eg+nrLH20gqe4eXoj22oQ6gMk9UhRnNQG0yCxQxuOmt8bhMabA5Zy
         hES38uWV0KENgPJjteU7lL0LoP0S0jwOMEdFuP5GlsgFNjSzJ7tZwyq9zx32KnW9yBoJ
         EPeg==
X-Gm-Message-State: AOAM530eKLy6+Twp82C2g4QooM9u53ItB4D6u11V+pQCpiS5HrsCpfxD
        Ylt0BkEXoR86G2qJUS/S5JqcxLoCC9m7JsbnVd4NqsEy
X-Google-Smtp-Source: ABdhPJwB20k2ZHT3pquG+8U7r0BrpsH8KXIMh0DEJH31rH1Wuzl1vZfIMGlgmIclqPJptUGYso0Jpt2+dx67FuhkQfs=
X-Received: by 2002:a25:cb57:: with SMTP id b84mr13933641ybg.425.1599756438097;
 Thu, 10 Sep 2020 09:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200619231703.738941-1-andriin@fb.com> <20200619231703.738941-4-andriin@fb.com>
 <ba11b067a4d9635ee4e28ccc1b2896cc9c8c5be1.camel@linux.ibm.com>
In-Reply-To: <ba11b067a4d9635ee4e28ccc1b2896cc9c8c5be1.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 09:47:06 -0700
Message-ID: <CAEf4BzZTZsQTJSY-+ex5uLSUnYMW7RRWtbMEVFRWuzd8QsnAkg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/9] selftests/bpf: add __ksym extern selftest
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Hi!
>
> On Fri, 2020-06-19 at 16:16 -0700, Andrii Nakryiko wrote:
> > Validate libbpf is able to handle weak and strong kernel symbol
> > externs in BPF
> > code correctly.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/ksyms.c  | 71
> > +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/test_ksyms.c  | 32 +++++++++
> >  2 files changed, 103 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > new file mode 100644
> > index 000000000000..e3d6777226a8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> > @@ -0,0 +1,71 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2019 Facebook */
> > +
> > +#include <test_progs.h>
> > +#include "test_ksyms.skel.h"
> > +#include <sys/stat.h>
> > +
> > +static int duration;
> > +
> > +static __u64 kallsyms_find(const char *sym)
> > +{
> > +     char type, name[500];
> > +     __u64 addr, res = 0;
> > +     FILE *f;
> > +
> > +     f = fopen("/proc/kallsyms", "r");
> > +     if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n", errno))
> > +             return 0;
> > +
> > +     while (fscanf(f, "%llx %c %499s%*[^\n]\n", &addr, &type, name)
> > > 0) {
> > +             if (strcmp(name, sym) == 0) {
> > +                     res = addr;
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     CHECK(false, "not_found", "symbol %s not found\n", sym);
> > +out:
> > +     fclose(f);
> > +     return res;
> > +}
> > +
> > +void test_ksyms(void)
> > +{
> > +     __u64 link_fops_addr = kallsyms_find("bpf_link_fops");
> > +     const char *btf_path = "/sys/kernel/btf/vmlinux";
> > +     struct test_ksyms *skel;
> > +     struct test_ksyms__data *data;
> > +     struct stat st;
> > +     __u64 btf_size;
> > +     int err;
> > +
> > +     if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
> > +             return;
> > +     btf_size = st.st_size;
> > +
> > +     skel = test_ksyms__open_and_load();
> > +     if (CHECK(!skel, "skel_open", "failed to open and load
> > skeleton\n"))
> > +             return;
> > +
> > +     err = test_ksyms__attach(skel);
> > +     if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n",
> > err))
> > +             goto cleanup;
> > +
> > +     /* trigger tracepoint */
> > +     usleep(1);
> > +
> > +     data = skel->data;
> > +     CHECK(data->out__bpf_link_fops != link_fops_addr,
> > "bpf_link_fops",
> > +           "got 0x%llx, exp 0x%llx\n",
> > +           data->out__bpf_link_fops, link_fops_addr);
> > +     CHECK(data->out__bpf_link_fops1 != 0, "bpf_link_fops1",
> > +           "got %llu, exp %llu\n", data->out__bpf_link_fops1,
> > (__u64)0);
> > +     CHECK(data->out__btf_size != btf_size, "btf_size",
> > +           "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> > +     CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
> > +           "got %llu, exp %llu\n", data->out__per_cpu_start,
> > (__u64)0);
> > +
> > +cleanup:
> > +     test_ksyms__destroy(skel);
> > +}
>
> Why is __per_cpu_start expected to be 0? On my x86_64 Debian VM it is
> something like ffffffffxxxxxxxx, and this test fails. Wouldn't
> it be better to take the value from kallsyms, like it's done with
> bpf_link_fops, or am I missing something in my setup?
>

Hm... those per-CPU symbols are not real addresses, they are relative
offsets, so I thought that __per_cpu_start always got to be 0. Strange
that you see a real kernel address instead. I guess looking up in
kallsyms would work either way, please feel free to send a fix.
Thanks!

> Best regards,
> Ilya
>
