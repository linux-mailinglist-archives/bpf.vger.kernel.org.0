Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE548F406
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 02:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiAOBS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 20:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiAOBSZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 20:18:25 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48EAC06173E;
        Fri, 14 Jan 2022 17:18:25 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h23so14357735iol.11;
        Fri, 14 Jan 2022 17:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXEATilqjAJHLxRKGFo0bawDLxVl2H1RZHKug2e9tEw=;
        b=oi5EPxSLPHxSp0z1O2dpwatQowkKC9dX58ELnJWxBQu/F3zGxYgytfEf+iiix+yZxK
         YWgI0s6yoNEhkJIfqUfUCRq3bprgj1E2Env6m/pgOFQu6+tUmcJJTCEu+mHF1MsRxvYx
         KUyVglS8WE2/14q/j87A335WHSgAHULve7BCj3A6Rx3X0g8Z+npwMwf29Z1ha6LLn1OM
         t1yIY7CEgNy7/cSe9g27lnt/2BDfxQP7o3cvb6chOMgH8ag8ipJVcff0P8s3LQ1NnHRl
         XphquqSFPlrbXGe1FXXeBq7bdaqXaXncvLmeAa5RQwhHWWUO34lHicOIZqUQ6wG8QNIQ
         DHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXEATilqjAJHLxRKGFo0bawDLxVl2H1RZHKug2e9tEw=;
        b=aqscXm2L8T0d3/Wof9qHUlXZzX0aASc/M+jnZds55lGpOiRawkGxy0h0+Oxb8p+Trj
         P5QshotTkG5DCZ+M8gB7WYzrOI3Obx1q3/5AxAgh2TA6KyPyzaRZTZSwWrAgwrGo66PA
         pZy0E3Mz8psVU7RhkrM5uTrB/CEbf8HSiCYwtzsSZ88u2jD2AgQC5iD+IMT3nv0Tjv6c
         qI1zMcELgPqIkueF6tGsShJp+O7Bvl1OXGsrOc9lELUTevhm++ruIvtKC0Yxtfdt+n/s
         6iveRyziWlCCBNHJstl5p/87gYSKtYW4BI0qsY56u0T2ev0hV1mLS0qwwgk/mBYrGt1j
         vNzw==
X-Gm-Message-State: AOAM5314JfIUp+W6MH73AX64bTcFlJwD1S5c8+6pAWGrCkJRrNyq2KN/
        03q0PNV1A1zBOdII3W2gHLdQcQbi6jbjk5591A8=
X-Google-Smtp-Source: ABdhPJxl/Q9EatHWxtATUKdxXRzHCvDyO+ZaPi5ikEf9zh5evVLedYtv6zW17L5IBtIazIluvZW0kHXv1xAHT1CJWTw=
X-Received: by 2002:a05:6638:410a:: with SMTP id ay10mr5483098jab.237.1642209505103;
 Fri, 14 Jan 2022 17:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20220113090029.1055-1-zhudi2@huawei.com> <20220113090029.1055-2-zhudi2@huawei.com>
In-Reply-To: <20220113090029.1055-2-zhudi2@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 17:18:14 -0800
Message-ID: <CAEf4Bzb5QArDia5HarAJEsHp6+HHHk0H3vZ5ZBcAZkgwEJLdmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
To:     Di Zhu <zhudi2@huawei.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, luzhihao@huawei.com,
        rose.chen@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 1:01 AM Di Zhu <zhudi2@huawei.com> wrote:
>
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 70 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_progs_query.c      | 24 +++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 85db0f4cdd95..06923ea44bad 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -8,6 +8,7 @@
>  #include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
>  #include "test_sockmap_skb_verdict_attach.skel.h"
> +#include "test_sockmap_progs_query.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
>
>  #define TCP_REPAIR             19      /* TCP sock is under repair right now */
> @@ -315,6 +316,69 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
>         test_sockmap_skb_verdict_attach__destroy(skel);
>  }
>
> +static __u32 query_prog_id(int prog_fd)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       int err;
> +
> +       err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "bpf_obj_get_info_by_fd") ||
> +           !ASSERT_EQ(info_len, sizeof(info), "bpf_obj_get_info_by_fd"))
> +               return 0;
> +
> +       return info.id;
> +}
> +
> +static void test_sockmap_progs_query(enum bpf_attach_type attach_type)
> +{
> +       struct test_sockmap_progs_query *skel;
> +       int err, map_fd, verdict_fd, duration = 0;
> +       __u32 attach_flags = 0;
> +       __u32 prog_ids[3] = {};
> +       __u32 prog_cnt = 3;
> +
> +       skel = test_sockmap_progs_query__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_sockmap_progs_query__open_and_load"))
> +               return;
> +
> +       map_fd = bpf_map__fd(skel->maps.sock_map);
> +
> +       if (attach_type == BPF_SK_MSG_VERDICT)
> +               verdict_fd = bpf_program__fd(skel->progs.prog_skmsg_verdict);
> +       else
> +               verdict_fd = bpf_program__fd(skel->progs.prog_skb_verdict);
> +
> +       err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> +                            &attach_flags, prog_ids, &prog_cnt);
> +       if (!ASSERT_OK(err, "bpf_prog_query failed"))
> +               goto out;
> +
> +       if (!ASSERT_EQ(attach_flags,  0, "wrong attach_flags on query"))
> +               goto out;
> +
> +       if (!ASSERT_EQ(prog_cnt, 0, "wrong program count on query"))
> +               goto out;
> +
> +       err = bpf_prog_attach(verdict_fd, map_fd, attach_type, 0);
> +       if (!ASSERT_OK(err, "bpf_prog_attach failed"))
> +               goto out;
> +
> +       prog_cnt = 1;
> +       err = bpf_prog_query(map_fd, attach_type, 0 /* query flags */,
> +                            &attach_flags, prog_ids, &prog_cnt);
> +
> +       ASSERT_OK(err, "bpf_prog_query failed");
> +       ASSERT_EQ(attach_flags, 0, "wrong attach_flags on query");
> +       ASSERT_EQ(prog_cnt, 1, "wrong program count on query");
> +       ASSERT_EQ(prog_ids[0], query_prog_id(verdict_fd),
> +                 "wrong prog_ids on query");

See how much easier it is to follow these tests, why didn't you do the
same with err, attach_flags and prog above?


> +
> +       bpf_prog_detach2(verdict_fd, map_fd, attach_type);
> +out:
> +       test_sockmap_progs_query__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>         if (test__start_subtest("sockmap create_update_free"))
> @@ -341,4 +405,10 @@ void test_sockmap_basic(void)
>                 test_sockmap_skb_verdict_attach(BPF_SK_SKB_STREAM_VERDICT,
>                                                 BPF_SK_SKB_VERDICT);
>         }
> +       if (test__start_subtest("sockmap progs query")) {
> +               test_sockmap_progs_query(BPF_SK_MSG_VERDICT);
> +               test_sockmap_progs_query(BPF_SK_SKB_STREAM_PARSER);
> +               test_sockmap_progs_query(BPF_SK_SKB_STREAM_VERDICT);
> +               test_sockmap_progs_query(BPF_SK_SKB_VERDICT);

Why are these not separate subtests? What's the benefit of bundling
them into one subtest?

> +       }
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> new file mode 100644
> index 000000000000..9d58d61c0dee
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_SOCKMAP);
> +       __uint(max_entries, 1);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} sock_map SEC(".maps");
> +
> +SEC("sk_skb")
> +int prog_skb_verdict(struct __sk_buff *skb)
> +{
> +       return SK_PASS;
> +}
> +
> +SEC("sk_msg")
> +int prog_skmsg_verdict(struct sk_msg_md *msg)
> +{
> +       return SK_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.27.0
>
