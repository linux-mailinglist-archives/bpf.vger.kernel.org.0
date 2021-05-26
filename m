Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65C3921C0
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhEZVH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhEZVHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 17:07:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E1CC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 14:05:50 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r8so4014064ybb.9
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLtpXWWUXwiF+Y04RA6u/0Z4mcU07dXfmKf+q2aIElY=;
        b=Jt4eEV5ZHUdr4PX8P3SMitj2SNlrEFgzveLoHgEXuSAnG9TXGxo1A8kGSgCFKO73Ft
         wS4wwVjfRogPHnVDPeLthjqrQLejv0fhkrm1C38j54E+aAbYBSC5VV/iNV19R33/6Zdf
         8Z/pTtLnXHxol2nO/CXgpgoav6cqQb9g1F5JovZk3JQ55kl69+da7/ADAAJfPavvWsGb
         adOL+nc3Z7T46vSzABr20+z7St7MI0/ZJrLwmV8JC3AHcNjLEGZz6tvQM7dyPTEnrQpo
         hxvxFy4GlyPUR18I7LsbjA5UHcXWR9STkXeO2g/3ebcXfq5fGKyFVfrrqaohpSRmF6T3
         HWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLtpXWWUXwiF+Y04RA6u/0Z4mcU07dXfmKf+q2aIElY=;
        b=OvaL4Ds/YqHfHNBCfP5eFME/OXU4qOFncNHHGIB3ZyvyFMYcrKa+Y9UIpIUguJPb0y
         a38mOJ6+TXGoYrigUuzoI65eimtTbx4br+GIxQZTEsq6yTRggCA9iZvhTVSTbFYn0vFR
         RA/MOxXFP5BPk4J4khAsmiRaSTppv+CWTmeFwYekOWAO1cpStKdPWaMWAwaEYmyzskCE
         uMAQhZqIWdZuDNwFztq2YIlGJaxLO9XAQUBGPEU0QBoT6kdradfkLzpsVjBitEzGV4Ju
         gnTixmeG6k2c16pZ6QSIVDw5VheHsjaKsNUOJwyMz6JCu5EEep2/nIQBGbWKaPRKaPcd
         Snwg==
X-Gm-Message-State: AOAM532+Qh5tyo1KX+mrAUn+zOXTHLzUKAnq51cm7fBB434U169x5NzH
        2pbuKHq0NNwadeUwhngfey72CHUyT8AdFbEAL0E=
X-Google-Smtp-Source: ABdhPJwutJArJZ06f1gDxt1qxidDHwji+19r+C6Epk5mg0+rM70yaNpvfx87eHPdjHHk7frTcmGykqbhoiKj3O0cY7w=
X-Received: by 2002:a5b:286:: with SMTP id x6mr55727759ybl.347.1622063150038;
 Wed, 26 May 2021 14:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210524220555.251473-1-zeffron@riotgames.com> <20210524220555.251473-4-zeffron@riotgames.com>
In-Reply-To: <20210524220555.251473-4-zeffron@riotgames.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 14:05:39 -0700
Message-ID: <CAEf4BzZqi_PcYXKgXr=t62z2K05rMxB7vYtAkW68ucwu1mdHqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add test for xdp_md context
 in BPF_PROG_TEST_RUN
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

On Mon, May 24, 2021 at 3:08 PM Zvi Effron <zeffron@riotgames.com> wrote:
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
>  .../bpf/prog_tests/xdp_context_test_run.c     | 117 ++++++++++++++++++
>  .../bpf/progs/test_xdp_context_test_run.c     |  22 ++++
>  2 files changed, 139 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> new file mode 100644
> index 000000000000..92ce2e4a5c30
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +void test_xdp_context_test_run(void)
> +{
> +       const char *file = "./test_xdp_context_test_run.o";

please use BPF skeleton for new tests

> +       struct bpf_object *obj;
> +       char data[sizeof(pkt_v4) + sizeof(__u32)];
> +       char buf[128];
> +       char bad_ctx[sizeof(struct xdp_md)];
> +       struct xdp_md ctx_in, ctx_out;
> +       struct bpf_test_run_opts tattr = {
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
> +       err = bpf_prog_load(file, BPF_PROG_TYPE_XDP, &obj, &prog_fd);
> +       if (CHECK_FAIL(err))
> +               return;
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
> +       CHECK_ATTR(err || tattr.retval != XDP_PASS ||

please use ASSERT_xxx() macros instead of CHECK() variants

> +                  tattr.data_size_out != sizeof(pkt_v4) ||
> +                  tattr.ctx_size_out != tattr.ctx_size_in ||
> +                  ctx_out.data_meta != 0 ||
> +                  ctx_out.data != ctx_out.data_meta ||
> +                  ctx_out.data_end != sizeof(pkt_v4), "xdp_md context",
> +                  "err %d errno %d retval %d data size out %d context size out %d data_meta %d data %d data_end %d\n",
> +                  err, errno, tattr.retval, tattr.data_size_out,
> +                  tattr.ctx_size_out, ctx_out.data_meta, ctx_out.data,
> +                  ctx_out.data_end);
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> new file mode 100644
> index 000000000000..c66a756b238e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_context_test_run.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +int _version SEC("version") = 1;

this is obsolete, you can drop this variable completely

> +
> +SEC("xdp_context")

SEC("xdp") is a standard way for XDP programs, please use that

> +int _xdp_context(struct xdp_md *xdp)
> +{
> +       void *data = (void *)(unsigned long)xdp->data;
> +       __u32 *metadata = (void *)(unsigned long)xdp->data_meta;
> +       __u32 ret;
> +
> +       if (metadata + 1 > data)
> +               return XDP_ABORTED;
> +       ret = *metadata;
> +       if (bpf_xdp_adjust_meta(xdp, 4))
> +               return XDP_ABORTED;
> +       return ret;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.31.1
>
