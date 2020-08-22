Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5770F24E614
	for <lists+bpf@lfdr.de>; Sat, 22 Aug 2020 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHVH1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Aug 2020 03:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgHVH1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Aug 2020 03:27:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D8FC061574
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 00:27:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so5202185ejr.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 00:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDR0zrvaETchAvJrcviqkk7cP258seKos1RRZO2tCNY=;
        b=WD1y4zXxFKdPhrJDo7FZF18V8FXHdZAuQzKOqvwg5t4cC+zK1OJ0lfC/t6NmK+O6GG
         NWICiBh3SfaXsrWidpT/L8d81C880rZzPxlK3xjlS6gvz8POZsgYaj1nm5h7681zVqSV
         SaLXPjSsR0MQQbKtVGF/UuK00EXO3tq9Z/BrHW4scNC3phcxBiqQTa+lRN2e+V9gs4H1
         Yh0+8sRw+4LfFgKuIyivx/UOICrzE7utfUuUFiRTd9EMaBWno18Zrmjq/MLKR0zOFkuv
         /2SWots2svp9DZ+wH63o3IPnu84631NxD5XC0nxh1ZI8AtBGWMS0XSZwKSEVmSpYiYil
         LnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDR0zrvaETchAvJrcviqkk7cP258seKos1RRZO2tCNY=;
        b=uKn8yL3OxxzMaZJqn8fjAxTbypXgkL+CPEABGzU7k6cYH+TnKHNnpGcsCB1372NWNS
         OlZI8dnSKtgME9RR42f0Q/gFGrluXRnJrtye5DPdkhMA+zzF2RfKCWnM1DrOm6WsWaTp
         m19FRZVXRZeJJpE6Nc/d9NMq/t5MgFK+m5wUaECelswh7IeiJZjHhDkaGV/7xLjFNXUV
         AEPt/bhxFtY6pj7nvd8ZtF1eNC7EJJC2bQgzlDoVY7f+paODBqYzLSzB59dsl8g6fKv4
         rMdCtHcIRrljwCYtjdal0sSejCp0uTIJMfzJd59udKD+SH5xTYNcPS37OEWX8AH10KYa
         lWkg==
X-Gm-Message-State: AOAM533GA1aTLi2X/C7BLBilTfdB516iJ4MeCxW9uYq8eCNcd2GkbO6e
        bLTnykxYhUKDXCuMzFIdNLgYVFP0HLfkSqYKfUjcZA==
X-Google-Smtp-Source: ABdhPJwqITtid7OZmHUh//eLVchaGbXrP+3xlPPoyAXWuYCMSciXM8P9U/0GBYjVHb5ptGJivZ8In0FV5V+vGZBpmgc=
X-Received: by 2002:a17:906:5902:: with SMTP id h2mr6586238ejq.423.1598081228742;
 Sat, 22 Aug 2020 00:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-6-haoluo@google.com>
 <29b8358f-64fb-9e82-acb0-20b5922afc81@fb.com> <CAEf4BzbmOnv1W4p2F6Ke8W_Gwi-QjtsOW8MFSifVoiaRY8jNVg@mail.gmail.com>
In-Reply-To: <CAEf4BzbmOnv1W4p2F6Ke8W_Gwi-QjtsOW8MFSifVoiaRY8jNVg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Sat, 22 Aug 2020 00:26:57 -0700
Message-ID: <CA+khW7iLW-KsrfBS2a+OOMU4i72sHiNeSzkAnXoidW7gwaMaLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf/selftests: ksyms_btf to test typed ksyms
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Networking <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 4:03 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 20, 2020 at 10:32 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 8/19/20 3:40 PM, Hao Luo wrote:
> > > Selftests for typed ksyms. Tests two types of ksyms: one is a struct,
> > > the other is a plain int. This tests two paths in the kernel. Struct
> > > ksyms will be converted into PTR_TO_BTF_ID by the verifier while int
> > > typed ksyms will be converted into PTR_TO_MEM.
> > >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >   .../selftests/bpf/prog_tests/ksyms_btf.c      | 77 +++++++++++++++++++
> > >   .../selftests/bpf/progs/test_ksyms_btf.c      | 23 ++++++
> > >   2 files changed, 100 insertions(+)
> > >   create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > >   create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > > new file mode 100644
> > > index 000000000000..1dad61ba7e99
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > > @@ -0,0 +1,77 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2020 Google */
> > > +
> > > +#include <test_progs.h>
> > > +#include <bpf/libbpf.h>
> > > +#include <bpf/btf.h>
> > > +#include "test_ksyms_btf.skel.h"
> > > +
> > > +static int duration;
> > > +
> > > +static __u64 kallsyms_find(const char *sym)
> > > +{
> > > +     char type, name[500];
> > > +     __u64 addr, res = 0;
> > > +     FILE *f;
> > > +
> > > +     f = fopen("/proc/kallsyms", "r");
> > > +     if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n", errno))
> > > +             return 0;
> >
> > could you check whether libbpf API can provide this functionality for
> > you? As far as I know, libbpf does parse /proc/kallsyms.
>
> No need to use libbpf's implementation. We already have
> kallsyms_find() in prog_tests/ksyms.c and a combination of
> load_kallsyms() + ksym_get_addr() in trace_helpers.c. It would be good
> to switch to one implementation for both prog_tests/ksyms.c and this
> one.
>
Ack. I can do some refactoring. The least thing that I can do is
moving kallsyms_find() to a header for both prog_tests/ksyms.c and
this test to use.

>
> > > diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_btf.c b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
> > > new file mode 100644
> > > index 000000000000..e04e31117f84
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_ksyms_btf.c
> > > @@ -0,0 +1,23 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2020 Google */
> > > +
> > > +#include "vmlinux.h"
> > > +
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +__u64 out__runqueues = -1;
> > > +__u64 out__bpf_prog_active = -1;
> > > +
> > > +extern const struct rq runqueues __ksym; /* struct type global var. */
> > > +extern const int bpf_prog_active __ksym; /* int type global var. */
> > > +
> > > +SEC("raw_tp/sys_enter")
> > > +int handler(const void *ctx)
> > > +{
> > > +     out__runqueues = (__u64)&runqueues;
> > > +     out__bpf_prog_active = (__u64)&bpf_prog_active;
> > > +
>
> You didn't test accessing any of the members of runqueues, because BTF
> only has per-CPU variables, right? Adding global/static variables was
> adding too much data to BTF or something like that, is that right?
>

Right. With some experiments, I found the address of a percpu variable
doesn't necessarily point to a valid structure. So it doesn't make
sense to dereference runqueues and access its members. However, right
now there are only percpu variables encoded in BTF, so I can't test
accessing members of general global/static variables unfortunately.

Hao
