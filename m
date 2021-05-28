Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17F5393B00
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhE1B3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 21:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhE1B3s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 21:29:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A3C061574
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 18:28:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g38so3317913ybi.12
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XekqbD2m5LWuShYUIXUbeU8c5ic97BQWnX5CjSmBjRE=;
        b=EVB7nHVxre9Qi/VdgYBhxb81XDbT1KpA/soEEGvYiPOroMjEXY5oPkcfVE17RzErD+
         w4138IikPcmCl/WLIPBMg77D1Z+Od6Yse8KPZABlwF1pnb0GIM4Gakcp/JhMz0Gqulsy
         EwCUMY7e+ag2q9RK5ejeSVIxiTmg1eYM3Mj2MCUEH1XKLuDWHVyurteqIQbC9ISbr+Mr
         HPsPkkH6F6yQUA7PluJHMX7XqKPNCG/pG6kU877bDuigIlXzGdW7wnGtzWLp6vLQ49I3
         hLaMFRxmNK7K4WsXAAC864KaI3vAtTCkFRlHT6Q47R1ybwcH6CFKllndqFkfg4HIX8aT
         INAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XekqbD2m5LWuShYUIXUbeU8c5ic97BQWnX5CjSmBjRE=;
        b=tE6+rwmwthgHW090GUofkKMSwxavG7xx37Z/0DbzEU8vzLhDV+tG21TjsBi0MYHA/r
         bMzDVo7J1/rjaR+gjBJmvdyKC8OZErDIqoI+J/Ad3kdVApg7U/RkRAFZ/P3a6mIhkdfs
         cdGY5iSgvGAkk+3G+iNtQVIbwdEou8kEFV8CvLF6gG8YqeIoL9Tb4vDMFpkHx4xexJWn
         j6wk8ALrKGGQ9HOf/vPn80o0yeTmvjHpvFVySrSy5IBZZyq6nvh/eiGsDXdoyXmRApaG
         TtPKp1XLPc1XpFqwuPvXju/OwLefSOoykVlROaxeHXrZEB3ej3cP1CAh3fU/4tPsbH8s
         El+w==
X-Gm-Message-State: AOAM531LEMwOv7Dg/OqmQErFFrG3vDmLFN4IajhWNdyL5G3pSkma62dQ
        JST7l3TiLx4BWTkvZbfxpsDX4kIio32QoHnnc5M=
X-Google-Smtp-Source: ABdhPJwcuqjobmFXeWhSdVuS8RrjMNlGwtVqPLVyKMnnfdczOfjKGmkG5c0sct3WipZKxURzr/M6eXTWfQNVhltF1nU=
X-Received: by 2002:a25:9942:: with SMTP id n2mr9347388ybo.230.1622165294046;
 Thu, 27 May 2021 18:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210527201341.7128-1-zeffron@riotgames.com> <20210527201341.7128-4-zeffron@riotgames.com>
In-Reply-To: <20210527201341.7128-4-zeffron@riotgames.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 18:28:03 -0700
Message-ID: <CAEf4Bzb=ECAtJAikaeSLomQCcwNC7JnwZxPc=j3=YnPjnfaycg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add test for xdp_md
 context in BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 1:14 PM Zvi Effron <zeffron@riotgames.com> wrote:
>
> Add a test for using xdp_md as a context to BPF_PROG_TEST_RUN for XDP
> programs.
>
> The test uses a BPF program that takes in a return value from XDP
> metadata, then reduces the size of the XDP metadata by 4 bytes.
>
> Test cases validate the possible failure cases for passing in invalid
> xdp_md contexts, that the return value is successfully passed
> in, and that the adjusted metadata is successfully copied out.
>
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> ---
>  .../bpf/prog_tests/xdp_context_test_run.c     | 116 ++++++++++++++++++
>  .../bpf/progs/test_xdp_context_test_run.c     |  20 +++
>  2 files changed, 136 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> new file mode 100644
> index 000000000000..f6d312005b7c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "test_xdp_context_test_run.skel.h"
> +
> +void test_xdp_context_test_run(void)
> +{
> +       struct test_xdp_context_test_run *skel = NULL;
> +       char data[sizeof(pkt_v4) + sizeof(__u32)];
> +       char buf[128];
> +       char bad_ctx[sizeof(struct xdp_md)];
> +       struct xdp_md ctx_in, ctx_out;
> +       struct bpf_test_run_opts tattr = {

see LIBBPF_DECLARE_OPTS, please use it

and please call it opts, it's not attribute

> +               .sz = sizeof(struct bpf_test_run_opts),
> +               .data_in = &data,
> +               .data_out = buf,
> +               .data_size_in = sizeof(data),
> +               .data_size_out = sizeof(buf),
> +               .ctx_out = &ctx_out,
> +               .ctx_size_out = sizeof(ctx_out),
> +               .repeat = 1,
> +       };
> +       int err, prog_fd;
> +
> +

extra empty line

> +       skel = test_xdp_context_test_run__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel"))
> +               return;
> +       prog_fd = bpf_program__fd(skel->progs._xdp_context);
> +
> +       *(__u32 *)data = XDP_PASS;
> +       *(struct ipv4_packet *)(data + sizeof(__u32)) = pkt_v4;
> +
> +       memset(&ctx_in, 0, sizeof(ctx_in));
> +       tattr.ctx_in = &ctx_in;
> +       tattr.ctx_size_in = sizeof(ctx_in);
> +
> +       tattr.ctx_in = &ctx_in;
> +       tattr.ctx_size_in = sizeof(ctx_in);
> +       ctx_in.data_meta = 0;
> +       ctx_in.data = sizeof(__u32);
> +       ctx_in.data_end = ctx_in.data + sizeof(pkt_v4);
> +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +       ASSERT_OK(err, "bpf_prog_test_run(test1)");
> +       ASSERT_EQ(tattr.retval, XDP_PASS, "test1-retval");
> +       ASSERT_EQ(tattr.data_size_out, sizeof(pkt_v4), "test1-datasize");
> +       ASSERT_EQ(tattr.ctx_size_out, tattr.ctx_size_in, "test1-ctxsize");
> +       ASSERT_EQ(ctx_out.data_meta, 0, "test1-datameta");
> +       ASSERT_EQ(ctx_out.data, ctx_out.data_meta, "test1-data");
> +       ASSERT_EQ(ctx_out.data_end, sizeof(pkt_v4), "test1-dataend");
> +
> +       /* Data past the end of the kernel's struct xdp_md must be 0 */
> +       bad_ctx[sizeof(bad_ctx) - 1] = 1;
> +       tattr.ctx_in = bad_ctx;
> +       tattr.ctx_size_in = sizeof(bad_ctx);
> +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +       ASSERT_ERR(err, "bpf_prog_test_run(test2)");
> +       ASSERT_EQ(errno, 22, "test2-errno");

by the time you are checking errno it might get overwritten. If you
want to check errno, you have to remember it right after the function
returns

> +
> +       /* The egress cannot be specified */
> +       ctx_in.egress_ifindex = 1;
> +       err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +       ASSERT_ERR(err, "bpf_prog_test_run(test3)");
> +       ASSERT_EQ(errno, 22, "test3-errno");
> +

[...]
