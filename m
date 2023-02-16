Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3D69A262
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 00:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBPXao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 18:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjBPXaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 18:30:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294ABBA6
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:29:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t16so8949250edd.10
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 15:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unOtewAFT6ENQAU2U2iVQDjcXrq0mI5/eRnzjgzGF5E=;
        b=JYY9S3BHWq2u+qkO9RDJS/gR/6bb27LHkYGoJkJY6UFcXbFVEZ9kP59ip/jo+s0ePP
         Uss7/scnbR7f2BVE7y2UUOx+bUFiH9UPFZp06lkXXp5qfFv7+YjQPCW8gHvhA8C3c33W
         Co7dZOsjSHjKx4JES7IbKkhJjpAcKNp6Hxi9wL0GCNd3fmfabYSUa1W1LfAnAYpTg/4X
         dvU0Vq+3+vRLxM2eudOAXXUsOOQ1CIcgzPe8WHOdYXQFlWs6OJA2/8xtmcADT9+Atiyy
         f3PKuUnPRtex146elDitYOBXf/L/nNrEabTLIzmR5WIsgAH/9Sj8SLitwx2OUes1cNPy
         0+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unOtewAFT6ENQAU2U2iVQDjcXrq0mI5/eRnzjgzGF5E=;
        b=DwJHeTdTnJuUR/yBqJDe/0gB8YX855YQ2l8iJx29XDtmmEARtV9mEfzjNlxvm66pJE
         rlLa39T0CdGzuxnu2/77Q4/3fTUMwSRNBEYw+IxlaD14X5l4RCvma6xuQIXb/j8Xi7VJ
         ZyTE3zVIxQGfjBYh36Z0Tr5NZVAe5cHzS+UIIcybrjXaXlzelbdya3p6woQelHkeE0dI
         pREyVodv3cg6XOjjMONF+vT7lcSmF/4N7C+S4vEMJgj3K0uV2WogH3AD9Xn/SN03trX+
         UABInqECe0m4uhrh+AZTvizzH8JySc0K2JHwRZaXRKc2eaLXulCm9gchtD5HlD0Qm2CG
         o8dA==
X-Gm-Message-State: AO0yUKUPtsPQwjr8he5p5938q5KjEyS1pWJ09L8Te8uUcMS195d0bQNJ
        PZJb1u1/BorwKhwhtppLQFpSCZx+aDQ7nH+UIXk=
X-Google-Smtp-Source: AK7set+mLtCMrXwR0KG2H+yYFWCGG3mxV5gTgzfj9Z4e2/Jfu/wM2/q6w5M1+mDsdINheCsDWNoouByeoSVUENprD2Q=
X-Received: by 2002:a50:a695:0:b0:4ac:b626:378e with SMTP id
 e21-20020a50a695000000b004acb626378emr3963942edc.5.1676590189681; Thu, 16 Feb
 2023 15:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20230214231221.249277-1-iii@linux.ibm.com> <20230214231221.249277-9-iii@linux.ibm.com>
In-Reply-To: <20230214231221.249277-9-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Feb 2023 15:29:37 -0800
Message-ID: <CAEf4BzaBme9+-X1R6pzHxgsctzyFih6B7y_z-U9VwznRSDP1DA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 8/8] selftests/bpf: Add MSan annotations
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Tue, Feb 14, 2023 at 3:12 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> eBPF selftests produce a few false positives with MSan. 3 of them have
> to do with sending uninitalized data via a socket. Another one is
> PERF_EVENT_IOC_QUERY_BPF, which is not known to MSan. Silence all of
> them using libbpf_mark_mem_written().
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c      | 3 +++
>  tools/testing/selftests/bpf/prog_tests/send_signal.c     | 2 ++
>  tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 4 ++++
>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c     | 3 +++
>  4 files changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index e980188d4124..c75a3357cd06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -4,6 +4,7 @@
>  #include <linux/err.h>
>  #include <netinet/tcp.h>
>  #include <test_progs.h>
> +#include <bpf/libbpf_internal.h>
>  #include "network_helpers.h"
>  #include "bpf_dctcp.skel.h"
>  #include "bpf_cubic.skel.h"
> @@ -39,6 +40,8 @@ static void *server(void *arg)
>         ssize_t nr_sent = 0, bytes = 0;
>         char batch[1500];
>
> +       libbpf_mark_mem_written(batch, sizeof(batch));
> +
>         fd = accept(lfd, NULL, NULL);
>         while (fd == -1) {
>                 if (errno == EINTR)
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index d63a20fbed33..11e91fc7a67f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include <bpf/libbpf_internal.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
>  #include "test_send_signal_kern.skel.h"
> @@ -58,6 +59,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
>                 ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
>
>                 /* notify parent signal handler is installed */
> +               libbpf_mark_mem_written(buf, 1);
>                 ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
>
>                 /* make sure parent enabled bpf program to send_signal */
> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> index 770fcc3bb1ba..727898e905fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include <bpf/libbpf_internal.h>

libbpf doesn't install this header system-wide, so we should use ""
syntax, like all the other places in selftests do

>
>  void serial_test_tp_attach_query(void)
>  {
> @@ -66,6 +67,7 @@ void serial_test_tp_attach_query(void)
>                 if (i == 0) {
>                         /* check NULL prog array query */
>                         query->ids_len = num_progs;
> +                       libbpf_mark_var_written(query->prog_cnt);
>                         err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
>                         if (CHECK(err || query->prog_cnt != 0,
>                                   "perf_event_ioc_query_bpf",
> @@ -115,6 +117,8 @@ void serial_test_tp_attach_query(void)
>                           "err %d errno %d query->prog_cnt %u\n",
>                           err, errno, query->prog_cnt))
>                         goto cleanup3;
> +               libbpf_mark_mem_written(query->ids,
> +                                       query->ids_len * sizeof(__u32));
>                 for (j = 0; j < i + 1; j++)
>                         if (CHECK(saved_prog_ids[j] != query->ids[j],
>                                   "perf_event_ioc_query_bpf",
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> index 5e3a26b15ec6..e6334f254675 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
> @@ -14,6 +14,7 @@
>  #include <net/if.h>
>  #include <linux/if_link.h>
>  #include "test_progs.h"
> +#include "bpf/libbpf_internal.h"
>  #include "network_helpers.h"
>  #include <linux/if_bonding.h>
>  #include <linux/limits.h>
> @@ -224,6 +225,8 @@ static int send_udp_packets(int vary_dst_ip)
>         int i, s = -1;
>         int ifindex;
>
> +       libbpf_mark_mem_written(buf, sizeof(buf));
> +
>         s = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
>         if (!ASSERT_GE(s, 0, "socket"))
>                 goto err;
> --
> 2.39.1
>
