Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA64648F47F
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 03:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiAOCsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 21:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiAOCsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 21:48:35 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE09C061574;
        Fri, 14 Jan 2022 18:48:35 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x15so9906218ilc.5;
        Fri, 14 Jan 2022 18:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVBMklvNNHSirRzSBO7rwIwZxmGwlJqNSrC/1eRQQJs=;
        b=q7Y7AyvREpRvyzJvd9mG8QpJgc4f9TKK1o8cMbl4lAfmf5iuYLlCu316JCsXv4LHga
         a4u9ZiRKc5hGLU9vQlE3S/mK2/7zUFufGqnbyKgSSTxrWcxva6k9W1/EIlT/JiOrBM2U
         x+b6gn4hnrj27rICwHUg1/r4K634+n6OexR/I3+M8Am3uh6K3zBmqyh3wOqgryxjS5WH
         GLXwMgbz1BNXEIz1XOicwvZ+lQaIh8+O/iGyo+1Gq2Vjxd4CNmUyNOT+GqzFbmrvsB8h
         Tz23etjizxbvEZ8HZZlu+ulSyifwiSe8XMNR+xpQAgVkzuGwHXzVeMl3YffqAadzcHy/
         7fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVBMklvNNHSirRzSBO7rwIwZxmGwlJqNSrC/1eRQQJs=;
        b=GfNizAjehADO8R1csjVGP6eGDut+rc/Sd3xMnJoatnIzmtEtU3RwbkLSBZnXg4/6zk
         q/BVIVhc61bBDAFgUV4W2yNkB9m9W+8+LoYasVDZ3KU7uWFPmpqRBKK+pI7x+KLZp2TE
         kkwoaRhaQkH9KZgGdHZleEdHU+xlVQ5x/JzRshxfPs6gIRW0Xv6sWHQLVaeF+OaWk4vd
         dLRMVzQlLKThNyOAIZ7BttdWmQf4VM2bm+bqz3hxkRmm7tTlHD1ygtmKIiFkQZz008O8
         CLzIM7s3nxaANhTcqSXScbAX0uV2vk0v7jdPF8cGJELFonKT963rTqYfQjBCWCa+Q7wz
         2BoQ==
X-Gm-Message-State: AOAM533nj3VrTxHDuksvj1cYj8qGDd7uUugtQBFVT9hSXwUytlvsaicV
        zWTefFxFmvWwz5iuM6TmfGWaHBkNJUlKao1fDHc=
X-Google-Smtp-Source: ABdhPJxFyLm4CFe/MTXPwN4c9TnJMNNanmFEgTHxBB97ZGoG8S85R/QwJf5XrXA/BJghPO9rt3CmkUnYzQvjwXTrB5c=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr6327576ill.305.1642214914748;
 Fri, 14 Jan 2022 18:48:34 -0800 (PST)
MIME-Version: 1.0
References: <a05a0e4fdd3c49deaa6671c14bb20a6c@huawei.com>
In-Reply-To: <a05a0e4fdd3c49deaa6671c14bb20a6c@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 18:48:23 -0800
Message-ID: <CAEf4BzayhbiWLdRed+isKQk+o9z_GHH0dQECfud8jZAYXQrz6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
To:     "zhudi (E)" <zhudi2@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 6:34 PM zhudi (E) <zhudi2@huawei.com> wrote:
>
> > On Thu, Jan 13, 2022 at 1:01 AM Di Zhu <zhudi2@huawei.com> wrote:
> > >
> > > Add test for querying progs attached to sockmap. we use an existing
> > > libbpf query interface to query prog cnt before and after progs
> > > attaching to sockmap and check whether the queried prog id is right.
> > >
> > > Signed-off-by: Di Zhu <zhudi2@huawei.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/sockmap_basic.c  | 70 +++++++++++++++++++
> > >  .../bpf/progs/test_sockmap_progs_query.c      | 24 +++++++
> > >  2 files changed, 94 insertions(+)
> > >  create mode 100644
> > tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > > index 85db0f4cdd95..06923ea44bad 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> > > @@ -8,6 +8,7 @@
> > >  #include "test_sockmap_update.skel.h"
> > >  #include "test_sockmap_invalid_update.skel.h"
> > >  #include "test_sockmap_skb_verdict_attach.skel.h"
> > > +#include "test_sockmap_progs_query.skel.h"
> > >  #include "bpf_iter_sockmap.skel.h"
> > >
> > >  #define TCP_REPAIR             19      /* TCP sock is under repair
> > right now */
> > > @@ -315,6 +316,69 @@ static void test_sockmap_skb_verdict_attach(enum
> > bpf_attach_type first,
> > >         test_sockmap_skb_verdict_attach__destroy(skel);
> > >  }
> > >
> > > +static __u32 query_prog_id(int prog_fd)
> > > +{
> > > +       struct bpf_prog_info info = {};
> > > +       __u32 info_len = sizeof(info);
> > > +       int err;
> > > +
> > > +       err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> > > +       if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
> > > +           !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
> > > +               return 0;
> > > +
> > > +       return info.id;
> > > +}
> > > +
> > > +static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
> > > +{
> > > +       struct test_sockmap_progs_query *skel;
> > > +       int err, map_fd, verdict_fd, duration = 0;
> > > +       __u32 attach_flags = 0;
> > > +       __u32 prog_ids[3] = {};
> > > +       __u32 prog_cnt = 3;
> > > +
> > > +       skel = test_sockmap_progs_query__open_and_load();
> > > +       if (!ASSERT_OK_PTR(skel,
> > "test_sockmap_progs_query__open_and_load"))
> > > +               return;
> > > +
> > > +       map_fd = bpf_map__fd(skel->maps.sock_map);
> > > +
> > > +       if (attach_type == BPF_SK_MSG_VERDICT)
> > > +               verdict_fd =
> > bpf_program__fd(skel->progs.prog_skmsg_verdict);
> > > +       else
> > > +               verdict_fd =
> > bpf_program__fd(skel->progs.prog_skb_verdict);
> > > +
> > > +       err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> > > +                            &attach_flags, prog_ids, &prog_cnt);
> > > +       if (!ASSERT_OK(err, "bpf_prog_query failed"))
> > > +               goto out;
> > > +
> > > +       if (!ASSERT_EQ(attach_flags,  0, "wrong attach_flags on query"))
> > > +               goto out;
> > > +
> > > +       if (!ASSERT_EQ(prog_cnt, 0, "wrong program count on query"))
> > > +               goto out;

I mean here that you can do just

ASSERT_OK(err, ...);
ASSERT_EQ(attach_flags, ...);
ASSERT_EQ(prog_cnt, ...);

No if + goto necessary.

> > > +
> > > +       err = bpf_prog_attach(verdict_fd, map_fd, attach_type, 0);
> > > +       if (!ASSERT_OK(err, "bpf_prog_attach failed"))
> > > +               goto out;
> > > +
> > > +       prog_cnt = 1;
> > > +       err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> > > +                            &attach_flags, prog_ids, &prog_cnt);
> > > +
> > > +       ASSERT_OK(err, "bpf_prog_query failed");
> > > +       ASSERT_EQ(attach_flags, 0, "wrong attach_flags on query");
> > > +       ASSERT_EQ(prog_cnt, 1, "wrong program count on query");
> > > +       ASSERT_EQ(prog_ids[0], query_prog_id(verdict_fd),
> > > +                 "wrong prog_ids on query");
> >
> > See how much easier it is to follow these tests, why didn't you do the
> > same with err, attach_flags and prog above?
>
> It is recommended by Yonghong Song to increase the test coverage.

see above

>
> >
> >
> > > +
> > > +       bpf_prog_detach2(verdict_fd, map_fd, attach_type);
> > > +out:
> > > +       test_sockmap_progs_query__destroy(skel);
> > > +}
> > > +
> > >  void test_sockmap_basic(void)
> > >  {
> > >         if (test__start_subtest("sockmap create_update_free"))
> > > @@ -341,4 +405,10 @@ void test_sockmap_basic(void)
> > >
> > test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
> > >
> > BPF_SK_SKB_VERDICT);
> > >         }
> > > +       if (test__start_subtest("sockmap progs query")) {
> > > +               test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
> > > +
> > test_sockmap_progs_query(BPF_SK_SKB_STREAM_PARSER);
> > > +
> > test_sockmap_progs_query(BPF_SK_SKB_STREAM_VERDICT);
> > > +               test_sockmap_progs_query(BPF_SK_SKB_VERDICT);
> >
> > Why are these not separate subtests? What's the benefit of bundling
> > them into one subtest?
> >
>
> These are essentially doing the same thing, just for different program attach types.

Right, so they are independent subtests, no? Not separate tests, but
not one subtest either.

>
> > > +       }
> > >  }
> > > diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> > b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> > > new file mode 100644
> > > index 000000000000..9d58d61c0dee
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> > > @@ -0,0 +1,24 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_SOCKMAP);
> > > +       __uint(max_entries, 1);
> > > +       __type(key, __u32);
> > > +       __type(value, __u64);
> > > +} sock_map SEC(".maps");
> > > +
> > > +SEC("sk_skb")
> > > +int prog_skb_verdict(struct __sk_buff *skb)
> > > +{
> > > +       return SK_PASS;
> > > +}
> > > +
> > > +SEC("sk_msg")
> > > +int prog_skmsg_verdict(struct sk_msg_md *msg)
> > > +{
> > > +       return SK_PASS;
> > > +}
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > --
> > > 2.27.0
> > >
