Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E80494037
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356926AbiASSy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiASSy4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:54:56 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C5C061574
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:54:56 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r204so294099iod.10
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RN6gQb+bhc780RxFsJagCaRgFXwA5lHXs2nJoif1HMs=;
        b=lzdx6lCd3+w70E6FOpypdypa4J0489BdaL3cGxVEhJ8bvRZ15vKWYEg6XfuJwFxzzB
         3hS8SAEJzRKRFvAItczz+jBlTgv7aUJ9LhAjpXNWOc4jLxsOuii7QTSNs2g7xAZQe9GE
         N3aLETqEY9aKyPgYWr6+tonCYu3D7TWXOLzn9GQOMb1/QIFYZWyurWungOJO0JmFlgbY
         FsA/OYJ6zjLzJjEJfNtVrmvA3Q7R+wL+odDk11FgA6q/tuLidxHYlpYnWIGNK4GUgNr5
         dYl1h6++vf7VVfscO1JfEmdVUs60+bzjQRcMdM0I1b329Rf9giO/EmEzd3fD8JOxpeYY
         qnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RN6gQb+bhc780RxFsJagCaRgFXwA5lHXs2nJoif1HMs=;
        b=UqjAcmeiymalIKm1rLx3WNQNYz6zQSkEVnzp5OC8J9ZHsx9QeojFr3WPijSreWmPQA
         8F2xkTQ9HUb/FUUOWQwCFiocB+k2Wc+S54gyzow0QN+9uH3YjqGX3DRyRnvb6Osgf/bf
         gv9EsXqweDkLnOvdQrEUcGUyIYRr47xsXi13v3KqrR7lUuHb/Mi4mYGUUBozSrOfiZnu
         pEJf5bNCFU4hMGQPbcXix+93rhCJv/P8s4ggOo45rHP/cbbZJ/0iCroVZkcxHyr3x3QF
         u+SqD8Gjze0QYj+REe00KlwlxK5vJ0a53TUq0hb3QsG2tPQb8m3xDGSdHbSdONp78L5J
         hG9A==
X-Gm-Message-State: AOAM532S7RwVUCrSxGORJRMJ5XFxSsZ06IDezXIvt5T9xdu6mrVpdbxd
        h9WmsMaO10xBwtiSbEahP2R/Mu5Kq2kNSbQ7ke/FKXv5
X-Google-Smtp-Source: ABdhPJx31HN9nkWEkM+2PW+ckgk0hm577aULLvxXpObrnemWZ7u/mQJQ2YEGLwYbCRvDe3IZGd9XUkSwN9ChZoPZh3k=
X-Received: by 2002:a5e:8717:: with SMTP id y23mr12504885ioj.79.1642618495339;
 Wed, 19 Jan 2022 10:54:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642611050.git.lorenzo@kernel.org> <ec0dbfecc37e9900001bfbd5744d917eb48de870.1642611050.git.lorenzo@kernel.org>
In-Reply-To: <ec0dbfecc37e9900001bfbd5744d917eb48de870.1642611050.git.lorenzo@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 10:54:44 -0800
Message-ID: <CAEf4BzZVYLGHX1zexH0wuAXD_OLAA3Kv2LSi7eCQNw=VS1B0ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: selftests: get rid of CHECK macro in xdp_bpf2bpf.c
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 8:58 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Rely on ASSERT* macros and get rid of deprecated CHECK ones in
> xdp_bpf2bpf bpf selftest.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    | 43 ++++++++-----------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> index c98a897ad692..951ce1fc535d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
> @@ -12,25 +12,21 @@ struct meta {
>
>  static void on_sample(void *ctx, int cpu, void *data, __u32 size)
>  {
> -       int duration = 0;
>         struct meta *meta = (struct meta *)data;
>         struct ipv4_packet *trace_pkt_v4 = data + sizeof(*meta);
>
> -       if (CHECK(size < sizeof(pkt_v4) + sizeof(*meta),
> -                 "check_size", "size %u < %zu\n",
> -                 size, sizeof(pkt_v4) + sizeof(*meta)))
> +       if (!ASSERT_GE(size, sizeof(pkt_v4) + sizeof(*meta), "check_size"))
>                 return;
>
> -       if (CHECK(meta->ifindex != if_nametoindex("lo"), "check_meta_ifindex",
> -                 "meta->ifindex = %d\n", meta->ifindex))
> +       if (!ASSERT_EQ(meta->ifindex, if_nametoindex("lo"),
> +                      "check_meta_ifindex"))
>                 return;
>
> -       if (CHECK(meta->pkt_len != sizeof(pkt_v4), "check_meta_pkt_len",
> -                 "meta->pkt_len = %zd\n", sizeof(pkt_v4)))
> +       if (!ASSERT_EQ(meta->pkt_len, sizeof(pkt_v4), "check_meta_pkt_len"))
>                 return;
>
> -       if (CHECK(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
> -                 "check_packet_content", "content not the same\n"))
> +       if (!ASSERT_EQ(memcmp(trace_pkt_v4, &pkt_v4, sizeof(pkt_v4)),
> +                      0, "check_packet_content"))
>                 return;
>

we can simplify and make it easier to follow by not doing early
returns. Just a sequence of ASSERTs would be compact and nice.

>         *(bool *)ctx = true;
> @@ -52,7 +48,7 @@ void test_xdp_bpf2bpf(void)
>
>         /* Load XDP program to introspect */
>         pkt_skel = test_xdp__open_and_load();
> -       if (CHECK(!pkt_skel, "pkt_skel_load", "test_xdp skeleton failed\n"))
> +       if (!ASSERT_OK_PTR(pkt_skel, "test_xdp__open_and_load"))
>                 return;
>
>         pkt_fd = bpf_program__fd(pkt_skel->progs._xdp_tx_iptunnel);
> @@ -62,7 +58,7 @@ void test_xdp_bpf2bpf(void)
>
>         /* Load trace program */
>         ftrace_skel = test_xdp_bpf2bpf__open();
> -       if (CHECK(!ftrace_skel, "__open", "ftrace skeleton failed\n"))
> +       if (!ASSERT_OK_PTR(ftrace_skel, "test_xdp_bpf2bpf__open"))
>                 goto out;
>
>         /* Demonstrate the bpf_program__set_attach_target() API rather than
> @@ -77,11 +73,11 @@ void test_xdp_bpf2bpf(void)
>         bpf_program__set_attach_target(prog, pkt_fd, "_xdp_tx_iptunnel");
>
>         err = test_xdp_bpf2bpf__load(ftrace_skel);
> -       if (CHECK(err, "__load", "ftrace skeleton failed\n"))
> +       if (!ASSERT_OK(err, "test_xdp_bpf2bpf__load"))
>                 goto out;
>
>         err = test_xdp_bpf2bpf__attach(ftrace_skel);
> -       if (CHECK(err, "ftrace_attach", "ftrace attach failed: %d\n", err))
> +       if (!ASSERT_OK(err, "test_xdp_bpf2bpf__attach"))
>                 goto out;
>
>         /* Set up perf buffer */
> @@ -94,30 +90,25 @@ void test_xdp_bpf2bpf(void)
>         err = bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
>                                 buf, &size, &retval, &duration);
>         memcpy(&iph, buf + sizeof(struct ethhdr), sizeof(iph));
> -       if (CHECK(err || retval != XDP_TX || size != 74 ||
> -                 iph.protocol != IPPROTO_IPIP, "ipv4",
> -                 "err %d errno %d retval %d size %d\n",
> -                 err, errno, retval, size))
> +       if (!ASSERT_OK(err || retval != XDP_TX || size != 74 ||
> +                      iph.protocol != IPPROTO_IPIP, "ipv4"))
>                 goto out;
>
>         /* Make sure bpf_xdp_output() was triggered and it sent the expected
>          * data to the perf ring buffer.
>          */
>         err = perf_buffer__poll(pb, 100);
> -       if (CHECK(err < 0, "perf_buffer__poll", "err %d\n", err))
> +       if (!ASSERT_GE(err, 0, "perf_buffer__poll"))
>                 goto out;
>
> -       CHECK_FAIL(!passed);
> +       ASSERT_TRUE(passed, "test passed");
>
>         /* Verify test results */
> -       if (CHECK(ftrace_skel->bss->test_result_fentry != if_nametoindex("lo"),
> -                 "result", "fentry failed err %llu\n",
> -                 ftrace_skel->bss->test_result_fentry))
> +       if (!ASSERT_EQ(ftrace_skel->bss->test_result_fentry, if_nametoindex("lo"),
> +                      "fentry result"))
>                 goto out;
>
> -       CHECK(ftrace_skel->bss->test_result_fexit != XDP_TX, "result",
> -             "fexit failed err %llu\n", ftrace_skel->bss->test_result_fexit);
> -
> +       ASSERT_EQ(ftrace_skel->bss->test_result_fexit, XDP_TX, "fexit result");
>  out:
>         if (pb)

while at it, please drop this if. perf_buffer__free() handles NULLs
and error pointers.

>                 perf_buffer__free(pb);
> --
> 2.34.1
>
