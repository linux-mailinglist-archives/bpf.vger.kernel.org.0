Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802E141E157
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbhI3Slv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbhI3Slv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 14:41:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A4C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 11:40:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id w19so15430221ybs.3
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGm+SSnenx5/E7tUbxpxcJVYUX+QvfUe8stE4mmpmR8=;
        b=APXHpMiqeincmknSbNQOnQzdJrSCeR+j6CM7Pk3c5obvVBAJpN3wKmmj7Byn+bNiI5
         7OIZVWHrlCGoGJxgRvIddg0/x0Q44/ulclQsr9yDUzdKvCIhg9/8aDE11RwwBWdW9pY0
         SdBrGIvaNCQfU7o5gJEUlPd8hBkdDlJt1yJlxIGFJql/fmkyeQ/lUHRUPEcPhgWWhRWS
         yPQ2p/+x1Od5QiM5x4kmi2XOhM8N82ZOitpuXHBCd67H5oCBg+uemEeUCyEeuxk3kO/x
         uVs1T1Rfuo22JXx5N5jRosB4uVdOfqDJ9U0TjGgd4k3qRAAdr2SJMMpDNhMY46/+GoqM
         2KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGm+SSnenx5/E7tUbxpxcJVYUX+QvfUe8stE4mmpmR8=;
        b=n3HXKBgIqTQKhAfpBm6J9bB6Py2NJLbl/QlH1QOzcGAK2VsK/x1aESZ6EUVTDX2ywQ
         7rYBwh4Z4AXkEGc6oG2Ke1n0RQP6TtUnawwIZ/p0C75GeCSLhB6jxmJIsylQ7ZKdAKAG
         m8OW/iHeNKmd+HdiTmEByP+SSoqMujgY+ktDfLcE3L06cRXUWxreWxFm1Xf56G3QYh8y
         CpjOBqeBqYwj2XYBIxhk9BwZfh99b9LafqthGNNFrUZzEuD7KesfKMB3i8ahByKt7ry4
         KtI59v23jDz5ogc0RV1mvRUgZTEVAoGSuYuyO6qYOxskFNqf6GltJZU5JYI/Eg/XVASm
         o/FA==
X-Gm-Message-State: AOAM531dZ9BOIMtsS2NE5kBdfYydnjH8Dy1SZcLUAeYednwxpMLhWSzq
        AuHA4YEth1Xmvb+uw/7LW+9GxTPM4wEtTpunR/fZXQH/qWM=
X-Google-Smtp-Source: ABdhPJyzrFWjOYOTwclVF8r56jUyIpaHLlonYJCjjJG5PN5CYHEZnSExJOz0yG4nlBMjEsLTurtDxO/PcB7mvxe7n9A=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr777572ybj.433.1633027207554;
 Thu, 30 Sep 2021 11:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210905100914.33007-1-hengqi.chen@gmail.com> <20210905100914.33007-2-hengqi.chen@gmail.com>
 <CAEf4BzZnKxVRtkaGUbzCmi0SDsR4_KM=uqdgP+Q6seAygkst7g@mail.gmail.com> <52bd9e85-4b5f-d260-8ef0-b5685654ae62@gmail.com>
In-Reply-To: <52bd9e85-4b5f-d260-8ef0-b5685654ae62@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Sep 2021 11:39:56 -0700
Message-ID: <CAEf4Bzbni1-M=9S=R_xygOYKOFwuOJjcNtJVqQVdTOLjR6512Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF map creation using
 BTF-defined key/value
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 30, 2021 at 9:05 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 9/9/21 12:29 PM, Andrii Nakryiko wrote:
> > On Sun, Sep 5, 2021 at 3:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Test BPF map creation using BTF-defined key/value. The test defines
> >> some specialized maps by specifying BTF types for key/value and
> >> checks those maps are correctly initialized and loaded.
> >>
> >> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >> ---
> >>  .../selftests/bpf/prog_tests/map_create.c     |  87 ++++++++++++++
> >>  .../selftests/bpf/progs/test_map_create.c     | 110 ++++++++++++++++++
> >>  2 files changed, 197 insertions(+)
> >>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_create.c
> >>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_create.c
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/map_create.c b/tools/testing/selftests/bpf/prog_tests/map_create.c
> >> new file mode 100644
> >> index 000000000000..6ca32d0dffd2
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/prog_tests/map_create.c
> >> @@ -0,0 +1,87 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/* Copyright (c) 2021 Hengqi Chen */
> >> +
> >> +#include <test_progs.h>
> >> +#include "test_map_create.skel.h"
> >> +
> >> +void test_map_create(void)
> >> +{
> >> +       struct test_map_create *skel;
> >> +       int err, fd;
> >> +
> >> +       skel = test_map_create__open();
> >> +       if (!ASSERT_OK_PTR(skel, "test_map_create__open failed"))
> >> +               return;
> >> +
> >> +       err = test_map_create__load(skel);
> >
> > If load() succeeds, all the maps will definitely be created, so all
> > the below tests are meaningless.
> >
> > I think it's better to just change all the existing map definitions
> > used throughout selftests to use key/value types, instead of
> > key_size/value_size. That will automatically test this feature without
> > adding an extra test. Unfortunately to really test that the logic is
> > working, we'd need to check that libbpf doesn't emit the warning about
> > retrying map creation w/o BTF, but I think one-time manual check
> > (please use ./test_progs -v to see libbpf warnings during tests)
> > should be sufficient for this.
> >
>
> Hello, Andrii
>
> I updated these existing tests as you suggested,
> but I was unable to run the whole bpf selftests locally.
>
> Running ./test_progs -v made my system hang up,
> didn't find the root cause yet.

This is strange. Do you know at which test this happens? Do you get
kernel warning/oops when this happens in dmesg?

But overall, the development and testing workflow for people working
on bpf/bpf-next involves building latest kernel and running selftests
inside the QEMU VM for testing. We also have vmtest.sh script in
selftests/bpf that automates a lot of building steps. It will build
kernel, test_progs and other selftest binaries, and will spin up QEMU
VM with the same image that our BPF CIs are using. You just need to
have very recent/latest Clang available and similarly pahole (from
dwarves package) should be up to date and available through $PATH.
After that, running ./vmtest.sh will just run all ./test_progs
automatically.

Either way, our CI will also run your changes through the tests
(except there are some intermittent issues right now, so we'll have to
wait a bit for that to kick in). You can monitor [0], or the link will
actually appear on each of your patches (e.g., [1]) in "Checks"
section, once everything is up and running properly.

  [0] https://github.com/kernel-patches/bpf/pulls
  [1] https://patchwork.kernel.org/project/netdevbpf/patch/20210930161456.3444544-2-hengqi.chen@gmail.com/

>
> Instead I just run the modified test with the following commands:
>
> sudo ./test_progs -v --name=kfree_skb,perf_event_stackmap,btf_map_in_map,pe_preserve_elems,stacktrace_map,stacktrace_build_id,xdp_bpf2bpf,select_reuseport,tcpbpf_user
>
> >> +       if (!ASSERT_OK(err, "test_map_create__load failed"))
> >> +               goto cleanup;
> >> +
> >> +       fd = bpf_map__fd(skel->maps.map1);
> >> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
> >> +               goto cleanup;
> >> +       close(fd);
> >> +
> >> +       fd = bpf_map__fd(skel->maps.map2);
> >> +       if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
> >> +               goto cleanup;
> >> +       close(fd);
> >
> > [...]
> >
