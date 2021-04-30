Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA663701AC
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhD3T5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 15:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhD3T5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 15:57:42 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1CEC06138B
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 12:56:53 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l7so9341766ybf.8
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbEmOqMF76+lIsfZxE61tYrDP/Zpn+fS34D1/jbNcu0=;
        b=FrQZFX/lpx+Wkrnpq8NIzluifqsniVo/ISshA9Hvq2LS72r/tXDZsTV/A0uFXUiY0t
         Jw0O9d66YKeqcJHJBKp7fQ126MVe0buZEqakslLEmH/r03NrGvVV46MzIEhjJf7GsETs
         tCf61vlU+brLKIICBiJq8kLB2qh+CV3WlbCtlw/ofJy28caVgvd6HzkSTuml867FAqZm
         fESqK+AzVCZzBhx0SDzQ1dlJqHpRo9lJTVBSZL6XleIClzmuwAI1WLPZcmGmdCncyIh9
         ZZiC0MSRBg8iHICwP/ipXsdERg3H0NkfrHN4+HttUnLFPSZX4GcJTGqzFtcCHGeB9wVY
         YEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbEmOqMF76+lIsfZxE61tYrDP/Zpn+fS34D1/jbNcu0=;
        b=BnevLKqMGAwiCYS8e6MorhusEqXkF9XBISgoOCRj+jFw2jATN3gpGqKKJo+uPJm53v
         ns/YNE5PZ5PUU50SAExZNfw9b5Z5p5XBJ8SslGuWEdHxZduL9Ez4ifycy6P83snXQ9Mx
         mz6cd43ArT88pcfH2lQV+HIrS5WU4W7+YxMfcaQYB5fnwlTxmVNh7dopmdwD0PZpggm7
         cELRqQZQmvUVqRd1h5GJ7/4Oy2dEX2rjJdtqhbjmr5fNbVZwmR+8onSxLCoD9KlfU3OX
         zi//+CKWYC6AYHORzV01ts7LynSBVecNykeItd1QjmXsCEhNIvOZA65zJRBg0sTSTZZu
         zdAg==
X-Gm-Message-State: AOAM5326tg7zKVQTZRjbP8CjbkiKaD+F4uhkFzYyVU7t332qHc/USl/X
        o72udEM66vOErDYie6zALooz8Q44J39YSYNdpmNshaGf
X-Google-Smtp-Source: ABdhPJzW2/h615L4bfG4mMAlw27WpC6OCUgWPcWj+Je0gRq44VAUrFmUYeru9eoP3aiGADNhnDDUwJjvhG1wnW3b2PA=
X-Received: by 2002:a5b:645:: with SMTP id o5mr10184953ybq.347.1619812612729;
 Fri, 30 Apr 2021 12:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210429153043.3145478-1-joamaki@gmail.com>
In-Reply-To: <20210429153043.3145478-1-joamaki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Apr 2021 12:56:42 -0700
Message-ID: <CAEf4BzbQPE=oQ1UUhMc8d6HOmvrpmhg7kOHUtFHENN7Ux6P9OA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 29, 2021 at 8:32 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> Ports test_tc_redirect.sh to the test_progs framework and removes the
> old test. This makes it more in line with rest of the tests and makes
> it possible to run this test with vmtest.sh and under the bpf CI.
>
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---

Aren't there any Makefile changes that need to be done as well, given
you are removing "old style" test script?

>  tools/testing/selftests/bpf/network_helpers.c |   2 +-
>  tools/testing/selftests/bpf/network_helpers.h |   1 +
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 481 ++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_neigh.c       |  33 +-
>  .../selftests/bpf/progs/test_tc_neigh_fib.c   |   9 +-
>  .../selftests/bpf/progs/test_tc_peer.c        |  33 +-
>  .../testing/selftests/bpf/test_tc_redirect.sh | 216 --------
>  7 files changed, 509 insertions(+), 266 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>  delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh
>

[...]

> +
> +#define TIMEOUT_MILLIS 10000
> +
> +static const char * const namespaces[] = {NS_SRC, NS_FWD, NS_DST, NULL};
> +static int root_netns_fd = -1;
> +static __u32 duration;
> +
> +static void restore_root_netns(void)
> +{
> +       CHECK_FAIL(setns(root_netns_fd, CLONE_NEWNET));

can you please also switch to ASSERT_xxx() macros while converting
this selftest? Thanks!

> +}
> +
> +int setns_by_name(const char *name)

static?

> +{
> +       int nsfd;
> +       char nspath[PATH_MAX];
> +       int err;
> +
> +       snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
> +       nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
> +       if (CHECK(nsfd < 0, nspath, "failed to open\n"))
> +               return -EINVAL;
> +
> +       err = setns(nsfd, CLONE_NEWNET);
> +       close(nsfd);
> +
> +       if (CHECK(err, name, "failed to setns\n"))
> +               return -1;
> +
> +       return 0;
> +}
> +

[...]

> +
> +#define SYS(fmt, ...)                                          \
> +       ({                                                      \
> +               char cmd[1024];                                 \
> +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> +               if (CHECK(system(cmd), cmd, "failed\n"))        \
> +                       goto fail;                              \
> +       })
> +
> +static int netns_setup_links_and_routes(struct netns_setup_result *result)
> +{
> +       char veth_src_fwd_addr[IFADDR_STR_LEN+1] = {0,};
> +       char veth_dst_fwd_addr[IFADDR_STR_LEN+1] = {0,};
> +
> +       SYS("ip link add veth_src type veth peer name veth_src_fwd");
> +       SYS("ip link add veth_dst type veth peer name veth_dst_fwd");
> +       if (CHECK_FAIL(get_ifaddr("veth_src_fwd", veth_src_fwd_addr)))

please no CHECK_FAIL, they are invisible in test_progs logs, so it's
harder to debug any failures (and use ASSERT_xxx() instead of CHECK).

> +               goto fail;
> +       if (CHECK_FAIL(get_ifaddr("veth_dst_fwd", veth_dst_fwd_addr)))
> +               goto fail;
> +
> +       result->ifindex_veth_src_fwd = get_ifindex("veth_src_fwd");
> +       if (CHECK_FAIL(result->ifindex_veth_src_fwd < 0))
> +               goto fail;
> +       result->ifindex_veth_dst_fwd = get_ifindex("veth_dst_fwd");
> +       if (CHECK_FAIL(result->ifindex_veth_dst_fwd < 0))
> +               goto fail;
> +

[...]

> +
> +       /* bpf_fib_lookup() checks if forwarding is enabled */
> +       system("ip netns exec " NS_FWD " sysctl -q -w "
> +              "net.ipv4.ip_forward=1 "
> +              "net.ipv6.conf.veth_src_fwd.forwarding=1 "
> +              "net.ipv6.conf.veth_dst_fwd.forwarding=1");

no SYS() and/or error checking?
> +
> +       test_connectivity();
> +done:
> +       system("ip netns exec " NS_FWD " sysctl -q -w "
> +              "net.ipv4.ip_forward=0 "
> +              "net.ipv6.conf.veth_src_fwd.forwarding=0 "
> +              "net.ipv6.conf.veth_dst_fwd.forwarding=0");
> +

same?

> +       bpf_program__unpin(skel->progs.tc_src, SRC_PROG_PIN_FILE);
> +       bpf_program__unpin(skel->progs.tc_chk, CHK_PROG_PIN_FILE);
> +       bpf_program__unpin(skel->progs.tc_dst, DST_PROG_PIN_FILE);
> +       test_tc_neigh_fib__destroy(skel);
> +       netns_unload_bpf();
> +       restore_root_netns();
> +}
> +

[...]
