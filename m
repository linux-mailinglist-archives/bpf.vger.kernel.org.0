Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCD6535B3
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiLUR6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUR61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 12:58:27 -0500
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9724BD3
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 09:58:26 -0800 (PST)
Message-ID: <88ee2720-3a3d-589b-3866-deaaf19fa895@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671645504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1S+iRdXxfwemRDy4yrq7A37ufCLMsuGmDi9JRO0Q+a8=;
        b=LDIOSEd561LKsE1CYiWiSyrDJya0Ql011RX0rYOxKkbaTuaasM8D2D4TfXsF3WW2gNEW5k
        WuUdf2az3goxsnXsU/Zy2DsW6BNHqAXl0VFGm7dFGH6XUMnq/rB2hg5ZfKcfXiDQOwBcpE
        32aawAW9sZqFllFGbMu+561YKOC05zY=
Date:   Wed, 21 Dec 2022 09:58:19 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf] selftests/bpf: Test bpf_skb_adjust_room on
 CHECKSUM_PARTIAL
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Jakub Kicinski <kuba@kernel.org>
References: <20221221014914.3543155-1-martin.lau@linux.dev>
 <CAEf4BzazRSYxkVBvfFMLEXvvL92xa8GN1We1+P6A0dKKxz+bWw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzazRSYxkVBvfFMLEXvvL92xa8GN1We1+P6A0dKKxz+bWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/20/22 9:05 PM, Andrii Nakryiko wrote:
> On Tue, Dec 20, 2022 at 5:49 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> When the bpf_skb_adjust_room() shrinks the skb such that
>> its csum_start is invalid, the skb->ip_summed should
>> be reset from CHECKSUM_PARTIAL to CHECKSUM_NONE.
>>
>> The commit 54c3f1a81421 ("bpf: pull before calling skb_postpull_rcsum()")
>> fixed it.
>>
>> This patch adds a test to ensure the skb->ip_summed changed
>> from CHECKSUM_PARTIAL to CHECKSUM_NONE after bpf_skb_adjust_room().
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
>> v2: Add test to DENYLIST.s390x due to kfunc usage
>>
>>   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>>   .../selftests/bpf/prog_tests/decap_sanity.c   | 83 +++++++++++++++++++
>>   .../selftests/bpf/progs/bpf_tracing_net.h     |  6 ++
>>   .../selftests/bpf/progs/decap_sanity.c        | 68 +++++++++++++++
>>   4 files changed, 158 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/decap_sanity.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/decap_sanity.c
>>
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
>> index 585fcf73c731..dba6c027920d 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>> @@ -86,3 +86,4 @@ xdp_bpf2bpf                              # failed to auto-attach program 'trace_
>>   xdp_do_redirect                          # prog_run_max_size unexpected error: -22 (errno 22)
>>   xdp_synproxy                             # JIT does not support calling kernel function                                (kfunc)
>>   xfrm_info                                # JIT does not support calling kernel function                                (kfunc)
>> +decap_sanity                             # JIT does not support calling kernel function                                (kfunc)
> 
> let's keep this list sorted?

Ack.

> 
>> \ No newline at end of file
>> diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
>> new file mode 100644
>> index 000000000000..2fbb3017b740
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <sys/types.h>
>> +#include <sys/socket.h>
>> +#include <net/if.h>
>> +#include <linux/in6.h>
>> +
>> +#include "test_progs.h"
>> +#include "network_helpers.h"
>> +#include "decap_sanity.skel.h"
>> +
>> +#define SYS(fmt, ...)                                          \
>> +       ({                                                      \
>> +               char cmd[1024];                                 \
>> +               snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__); \
>> +               if (!ASSERT_OK(system(cmd), cmd))               \
>> +                       goto fail;                              \
>> +       })
>> +
>> +#define NS_TEST "decap_sanity_ns"
>> +#define IPV6_IFACE_ADDR "face::1"
>> +#define UDP_TEST_PORT 7777
>> +
>> +void test_decap_sanity(void)
>> +{
>> +       LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
>> +       LIBBPF_OPTS(bpf_tc_opts, tc_attach);
>> +       struct nstoken *nstoken = NULL;
>> +       struct decap_sanity *skel;
>> +       struct sockaddr_in6 addr;
>> +       socklen_t addrlen;
>> +       char buf[128] = {};
>> +       int sockfd, err;
>> +
>> +       skel = decap_sanity__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
>> +               return;
>> +
>> +       SYS("ip netns add %s", NS_TEST);
>> +       SYS("ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
>> +       SYS("ip -net %s link set dev lo up", NS_TEST);
>> +
>> +       nstoken = open_netns(NS_TEST);
>> +       if (!ASSERT_OK_PTR(nstoken, "open_netns"))
>> +               goto fail;
>> +
>> +       qdisc_hook.ifindex = if_nametoindex("lo");
>> +       if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
>> +               goto fail;
>> +
>> +       err = bpf_tc_hook_create(&qdisc_hook);
>> +       if (!ASSERT_OK(err, "create qdisc hook"))
>> +               goto fail;
> 
> you seem to be missing bpf_tc_hook_destroy() for clean up

It will go away with the 'ip netns del' at the end of the test, so not needed.
I will add a comment at the end of this function to make it clear.

> 
>> +
>> +       tc_attach.prog_fd = bpf_program__fd(skel->progs.decap_sanity);
>> +       err = bpf_tc_attach(&qdisc_hook, &tc_attach);
>> +       if (!ASSERT_OK(err, "attach filter"))
>> +               goto fail;
>> +
>> +       addrlen = sizeof(addr);
>> +       err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
>> +                           (void *)&addr, &addrlen);
>> +       if (!ASSERT_OK(err, "make_sockaddr"))
>> +               goto fail;
>> +       sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
>> +       if (!ASSERT_NEQ(sockfd, -1, "socket"))
>> +               goto fail;
>> +       err = sendto(sockfd, buf, sizeof(buf), 0, (void *)&addr, addrlen);
>> +       close(sockfd);
>> +       if (!ASSERT_EQ(err, sizeof(buf), "send"))
>> +               goto fail;
>> +
>> +       ASSERT_EQ(skel->bss->init_csum_partial, true, "init_csum_partial");
>> +       ASSERT_EQ(skel->bss->final_csum_none, true, "final_csum_none");
>> +       ASSERT_EQ(skel->bss->broken_csum_start, false, "broken_csum_start");
> 
> ASSERT_TRUE and ASSERT_FALSE ?

Ack.

Thanks for the review.

> 
>> +
>> +fail:
>> +       if (nstoken)
>> +               close_netns(nstoken);
>> +       system("ip netns del " NS_TEST " >& /dev/null");
>> +       decap_sanity__destroy(skel);
>> +}
> 
> [...]

