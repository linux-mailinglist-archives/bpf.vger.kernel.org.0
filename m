Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05722525F5
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 06:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgHZEAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 00:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgHZEAh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 00:00:37 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18C0C061574
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 21:00:36 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p191so215017ybg.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 21:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4X2B5L0J4WHReDW+VPi9tfwpo5CGDC0KzQUvX/vrGcg=;
        b=J974dshzXZ1XGEhKllxBulWB9FkLCR63QBModZKQs2rT78xFHTpkVXLk5eRcCmoM9N
         Z4rqQytgAbaai78R2+nPVrq/YEvV7Qhh1w9a7fGzXoyPifWwUwz7qj2JZRfJ6LLMi06b
         nK7M64tmvTD3xS3Ed4C+ctOD7C5rQYJFrvTIUWJoTAV27l2CAfnCzxr4yQxvqGS27Zse
         PtCwO0sgVfr95XvhYSYHkPqFulR7lJ9eSDgbsLxZSjky0vEt7J5mkGAwQB8DuJPYh7W7
         zXnlUptUiLTubGT9/nDzHjWEtwhhD1LBfgdea1F3egz+VnA4tzmF2OoAHO6lL9wXRAhB
         FdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4X2B5L0J4WHReDW+VPi9tfwpo5CGDC0KzQUvX/vrGcg=;
        b=Dg1MympJkRUMy4FRu6fvbpvGVw3rMgWuM//LIbqRY6ukFC+yCVXAY2BLjvMsnQSr9/
         IDQjXH4x1ekpB3hUE16B5lynd2uLm+2q1umKbcMrhNAbgcm8df7YLJCxJV8QTbyadQnH
         BxtNbHNRcYXuIbKcmu60bdQeu2QKwh9pr/WEF/YO3hr+mcf+Y+rCrohY8yzBFpzkgibK
         JtDsg0OtsktFLNe7gHm6x6GE4zVtPubRdjwXXDxALwpTZbFIu6TTadH9UIPFcBtSkfLB
         PldkNVFr2+jAChsZCByLywAYZ5aYOzE4OaouGkaiL1MySIBxCT0oZ894eYFquQLk1TUh
         TrCw==
X-Gm-Message-State: AOAM530lHak8l8MAG/dREqwnjlzfdlqx9Il4nOrdY1SdGZeO1si7x03g
        e9Sje1bEo/D6/fgjkeNW+VPjh21FwyU6LC1+Ec8=
X-Google-Smtp-Source: ABdhPJxldmnOw8lPmrr1y84OItbOI8MgrlM4S3558/Abnltkhnrqrn7Bdowap9/hYuNthPrBrMyb6qEuL0a/A2F6GLA=
X-Received: by 2002:a25:824a:: with SMTP id d10mr19261508ybn.260.1598414435886;
 Tue, 25 Aug 2020 21:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <788b0e49bd5dfc292b71a57f21cbf010821a0aca.1597915265.git.zhuyifei@google.com>
 <e0946350-9829-09b3-0a60-4b45ed918d93@fb.com>
In-Reply-To: <e0946350-9829-09b3-0a60-4b45ed918d93@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Aug 2020 21:00:24 -0700
Message-ID: <CAEf4BzahcdM2W8YwmWdoVwYENXmKjkgvru4Qj_uCN8BddKnoJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Test bpftool loading and
 dumping metadata
To:     Yonghong Song <yhs@fb.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 3:03 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/20/20 2:42 AM, YiFei Zhu wrote:
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > This is a simple test to check that loading and dumping metadata
> > works, whether or not metadata contents are used by the program.
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile          |  3 +-
> >   .../selftests/bpf/progs/metadata_unused.c     | 15 ++++
> >   .../selftests/bpf/progs/metadata_used.c       | 15 ++++
> >   .../selftests/bpf/test_bpftool_metadata.sh    | 82 +++++++++++++++++++
> >   4 files changed, 114 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/metadata_unused.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/metadata_used.c
> >   create mode 100755 tools/testing/selftests/bpf/test_bpftool_metadata.sh
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index a83b5827532f..04e56c6843c6 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -68,7 +68,8 @@ TEST_PROGS := test_kmod.sh \
> >       test_tc_edt.sh \
> >       test_xdping.sh \
> >       test_bpftool_build.sh \
> > -     test_bpftool.sh
> > +     test_bpftool.sh \
> > +     test_bpftool_metadata.sh \
>
> This is mostly testing bpftool side.
> We should add testing to test_progs too as it is what most developer
> runs. If you add skeleton support for metadata, similar to bss, it will
> both make user interface easy and make testing easy.
>

I concur. It also seems that program code can use metadata variables
just like .rodata variables (e.g., for debug logging, etc), so we need
to add tests exercising that ability as well.

> >
> >   TEST_PROGS_EXTENDED := with_addr.sh \
> >       with_tunnels.sh \
> > diff --git a/tools/testing/selftests/bpf/progs/metadata_unused.c b/tools/testing/selftests/bpf/progs/metadata_unused.c
> > new file mode 100644
> > index 000000000000..523b3c332426
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/metadata_unused.c
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +char metadata_a[] SEC(".metadata") = "foo";
> > +int metadata_b SEC(".metadata") = 1;
> > +
> > +SEC("cgroup_skb/egress")
> > +int prog(struct xdp_md *ctx)
> > +{
> > +     return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> [...]
