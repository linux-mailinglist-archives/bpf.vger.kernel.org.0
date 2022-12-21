Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88C652C45
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 06:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbiLUFFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 00:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLUFFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 00:05:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333AA1FCC4
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 21:05:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x22so34091546ejs.11
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 21:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k37VDpEVUXBRpyYutzqmZ5ABcUSqI88UcDbqyDTj+Ts=;
        b=G8QZOJoxLvBfJUqPZR1CJ4y2LJbJNT5TDwP4cBAsZgnx8qFuNe5Pmz3kFedNk03mMm
         8w98X2KPxAEfTVRjsuPNBTjuMtAEqJ1nUmylwRkiisSfKmZFfeGATQpVV1gO/hPSAnGh
         oGPCgERZk8s9tNQU3hhfqW42UjImsdukIQ09u7vGcuyj5nA6cBjOmu8r+J1lvo/YsO8Z
         CkDHB1e4+Iz5mrNJt4MgTKZHAsU4alLSVPnPDqEMiFCcK36ovMCYTAO3uMp7SmRK9+NV
         uwMe80THn6lhj9qtToxbImvXAiFGpvhe5VatSSPCwDRFbYyhuiphPuPbFgAcRIgxWPg5
         3IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k37VDpEVUXBRpyYutzqmZ5ABcUSqI88UcDbqyDTj+Ts=;
        b=y3/Z/hdzQLt7cwZVJlk/bwwvroo4ds+zroy5sUG3Sr1EYGWwjeTBQmXYk5u8Me/X9z
         WT1M5JAcfDfZmZNTgaMoTnQeUSWMQXJnrtlPez3YA8NRHxNtYCwzzARP+qAhsNAZ/ccL
         i05LxI2PBij3cmGONX+50Nqu46jrsQhurmloXFxhkb3Uv0hFYI10Ixhklu+K8b8elYMk
         nkAQflmg8vRfoUPXW+mEXxb6mQ7rMbLOPHdMHFVB52vkGpGQX5lS3YLJqfGOK1cbFEor
         imY+NQM3PjUnJwTWLZgNBkrL6X2DeLes//x+f/aJMjFJMPSzj3N3bcykurnzYRmQi88u
         vkmQ==
X-Gm-Message-State: AFqh2kqqs+B180IWKWnJBxYBwmzlMm1W8rXLYnMpzyT0/FXJ5GsZW51f
        EV99tYR5WTffubzFoxSU0mlnEB+Y/ohrJ/lBBTY=
X-Google-Smtp-Source: AMrXdXsFOMOeLqPDVf65ukUcq6PmPUVYO3OMXzYa63GJlcMK9he5AVts48fJWzIgoBbK45fI/oUQDYCLCtdtjfeBYSk=
X-Received: by 2002:a17:907:d489:b0:7c0:dd4e:3499 with SMTP id
 vj9-20020a170907d48900b007c0dd4e3499mr19822ejc.545.1671599130521; Tue, 20 Dec
 2022 21:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20221221014914.3543155-1-martin.lau@linux.dev>
In-Reply-To: <20221221014914.3543155-1-martin.lau@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 21:05:18 -0800
Message-ID: <CAEf4BzazRSYxkVBvfFMLEXvvL92xa8GN1We1+P6A0dKKxz+bWw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 20, 2022 at 5:49 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> When the bpf_skb_adjust_room() shrinks the skb such that
> its csum_start is invalid, the skb->ip_summed should
> be reset from CHECKSUM_PARTIAL to CHECKSUM_NONE.
>
> The commit 54c3f1a81421 ("bpf: pull before calling skb_postpull_rcsum()")
> fixed it.
>
> This patch adds a test to ensure the skb->ip_summed changed
> from CHECKSUM_PARTIAL to CHECKSUM_NONE after bpf_skb_adjust_room().
>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
> v2: Add test to DENYLIST.s390x due to kfunc usage
>
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../selftests/bpf/prog_tests/decap_sanity.c   | 83 +++++++++++++++++++
>  .../selftests/bpf/progs/bpf_tracing_net.h     |  6 ++
>  .../selftests/bpf/progs/decap_sanity.c        | 68 +++++++++++++++
>  4 files changed, 158 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/decap_sanity.c
>  create mode 100644 tools/testing/selftests/bpf/progs/decap_sanity.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 585fcf73c731..dba6c027920d 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -86,3 +86,4 @@ xdp_bpf2bpf                              # failed to auto-attach program 'trace_
>  xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
>  xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
>  xfrm_info                                # JIT does not support calling kernel function                                (kfunc)
> +decap_sanity                             # JIT does not support calling kernel function                                (kfunc)

let's keep this list sorted?

> \ No newline at end of file
> diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> new file mode 100644
> index 000000000000..2fbb3017b740
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <net/if.h>
> +#include <linux/in6.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "decap_sanity.skel.h"
> +
> +#define SYS(fmt, ...)                                          \
> +       ({                                                      \
> +               char cmd[1024];                                 \
> +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
> +               if (!ASSERT_OK(system(cmd), cmd))               \
> +                       goto fail;                              \
> +       })
> +
> +#define NS_TEST "decap_sanity_ns"
> +#define IPV6_IFACE_ADDR "face::1"
> +#define UDP_TEST_PORT 7777
> +
> +void test_decap_sanity(void)
> +{
> +       LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
> +       LIBBPF_OPTS(bpf_tc_opts, tc_attach);
> +       struct nstoken *nstoken = NULL;
> +       struct decap_sanity *skel;
> +       struct sockaddr_in6 addr;
> +       socklen_t addrlen;
> +       char buf[128] = {};
> +       int sockfd, err;
> +
> +       skel = decap_sanity__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +               return;
> +
> +       SYS("ip netns add %s", NS_TEST);
> +       SYS("ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
> +       SYS("ip -net %s link set dev lo up", NS_TEST);
> +
> +       nstoken = open_netns(NS_TEST);
> +       if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +               goto fail;
> +
> +       qdisc_hook.ifindex = if_nametoindex("lo");
> +       if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
> +               goto fail;
> +
> +       err = bpf_tc_hook_create(&qdisc_hook);
> +       if (!ASSERT_OK(err, "create qdisc hook"))
> +               goto fail;

you seem to be missing bpf_tc_hook_destroy() for clean up

> +
> +       tc_attach.prog_fd = bpf_program__fd(skel->progs.decap_sanity);
> +       err = bpf_tc_attach(&qdisc_hook, &tc_attach);
> +       if (!ASSERT_OK(err, "attach filter"))
> +               goto fail;
> +
> +       addrlen = sizeof(addr);
> +       err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
> +                           (void *)&addr, &addrlen);
> +       if (!ASSERT_OK(err, "make_sockaddr"))
> +               goto fail;
> +       sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
> +       if (!ASSERT_NEQ(sockfd, -1, "socket"))
> +               goto fail;
> +       err = sendto(sockfd, buf, sizeof(buf), 0, (void *)&addr, addrlen);
> +       close(sockfd);
> +       if (!ASSERT_EQ(err, sizeof(buf), "send"))
> +               goto fail;
> +
> +       ASSERT_EQ(skel->bss->init_csum_partial, true, "init_csum_partial");
> +       ASSERT_EQ(skel->bss->final_csum_none, true, "final_csum_none");
> +       ASSERT_EQ(skel->bss->broken_csum_start, false, "broken_csum_start");

ASSERT_TRUE and ASSERT_FALSE ?

> +
> +fail:
> +       if (nstoken)
> +               close_netns(nstoken);
> +       system("ip netns del " NS_TEST " >& /dev/null");
> +       decap_sanity__destroy(skel);
> +}

[...]
