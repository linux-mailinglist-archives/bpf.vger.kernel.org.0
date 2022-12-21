Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46F6536EA
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiLUTTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLUTTG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:19:06 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2CA26128
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:19:04 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i4-20020a17090332c400b0018f82951826so11987479plr.20
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abBdQ92wjI/A3re+ukGH0tQJAx53soASr5LezHW33V8=;
        b=V0m31XlACbMFLytBU0lnB2nttxpgyL97IgsX3bJSoumbXNSIypEiAgSDCJBDCfqBZu
         5yVZe0pudqZPF9uXqWRNf/wC3XRZAroEsxxDyEl+SXhEtS7CCSLlxWEXQs0PCBX9TgLq
         MUr/SEi9SDRJfHVxpTDFJpLx80eRwoY35OQJQ2UQYUjR3Vypn8WWoufaGHQKf0wW62DC
         Fu/Et7FmFge8it1CaRfS9npV8c3KKnwSWL7W4h3VL7AxevNasYFxxKr7KYaxGAW562D+
         oU9My6WVlagRLnW3FzqnH0MBMajXHu0mnV2oMs9EZCwoDsqlSBZf5BOVVO8ZssdrAWLS
         IXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abBdQ92wjI/A3re+ukGH0tQJAx53soASr5LezHW33V8=;
        b=4oSkkW+hjRsawN1wDtVSxEqP7cHUuBJIqCR5aBHxar9ODNV6UECX/c8pvfQBHa2b+n
         0Iae/pjOO5mLhX5h6yxAQUigxPJ7mbbhwSYYX3A6BNJe/ILmcROK+gaPxcnPRjMvwg7R
         bTxyfNdpxw8eI3FDkSCmBZ6n8wxMq7Rx5X/Z/ybDgvQtZhTkw2LYed6Y2x4hFDqdkoX3
         p/HtIVSduw5Ka8ML4D9aE0bQm6DUKoD6NvcTjw9apEUi1rKCwGqT2vew1JtMaBX1FPPZ
         E8nQE28i069RPdXaohR+bTrye1T3fUhYPMvYKdQtnZSrtufRHswqbjMIyD3B4d4aBD8J
         pEkg==
X-Gm-Message-State: AFqh2kq+7LIX75xwIhETuvdT0kAuOJkWUhWlMAKkccCuhHHVLC52glA7
        aKqFAdnRea3MM7WdvHWrex+RhzY=
X-Google-Smtp-Source: AMrXdXt2hYsXQCFoo/LtJUV3t8bQFSgNqSezD1N2OuTeV3kUbONxQOao1d96xhfeHxie42q/WtV7gCc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:3253:b0:191:1204:367f with SMTP id
 ji19-20020a170903325300b001911204367fmr246998plb.173.1671650344372; Wed, 21
 Dec 2022 11:19:04 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:19:02 -0800
In-Reply-To: <20221221185653.1589961-1-martin.lau@linux.dev>
Mime-Version: 1.0
References: <20221221185653.1589961-1-martin.lau@linux.dev>
Message-ID: <Y6NcJjQDUE+Y/edw@google.com>
Subject: Re: [PATCH v4 bpf] selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL
From:   sdf@google.com
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/21, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>

> When the bpf_skb_adjust_room() shrinks the skb such that
> its csum_start is invalid, the skb->ip_summed should
> be reset from CHECKSUM_PARTIAL to CHECKSUM_NONE.

> The commit 54c3f1a81421 ("bpf: pull before calling skb_postpull_rcsum()")
> fixed it.

> This patch adds a test to ensure the skb->ip_summed changed
> from CHECKSUM_PARTIAL to CHECKSUM_NONE after bpf_skb_adjust_room().

> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

I'm bit late to the party:

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
> v4: Remove one 'inline' from progs/decap_sanity.c

> v3:
>    * Use ASSERT_TRUE and ASSERT_FALSE
>    * On top of 'ip netns del', also call bpf_tc_hook_destroy()
>      in case bpf_tc_hook_create() may allocate memory in
>      the future.
>    * Keep alphabet order in DENYLIST.s390x

> v2: Add test to DENYLIST.s390x due to kfunc usage

>   tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>   .../selftests/bpf/prog_tests/decap_sanity.c   | 85 +++++++++++++++++++
>   .../selftests/bpf/progs/bpf_tracing_net.h     |  6 ++
>   .../selftests/bpf/progs/decap_sanity.c        | 68 +++++++++++++++
>   4 files changed, 160 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/decap_sanity.c
>   create mode 100644 tools/testing/selftests/bpf/progs/decap_sanity.c

> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x  
> b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 585fcf73c731..3fc3e54b19aa 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -14,6 +14,7 @@ cgrp_kfunc                               # JIT does not  
> support calling kernel f
>   cgrp_local_storage                       # prog_attach unexpected error:  
> -524                                          (trampoline)
>   core_read_macros                         # unknown func  
> bpf_probe_read#4                                                
> (overlapping)
>   d_path                                   # failed to auto-attach  
> program 'prog_stat': -524                             (trampoline)
> +decap_sanity                             # JIT does not support calling  
> kernel function                                (kfunc)
>   deny_namespace                           # failed to attach: ERROR:  
> strerror_r(-524)=22                                (trampoline)
>   dummy_st_ops                             # test_run unexpected error:  
> -524 (errno 524)                                 (trampoline)
>   fentry_fexit                             # fentry attach failed:  
> -524                                                  (trampoline)
> diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c  
> b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> new file mode 100644
> index 000000000000..0b2f73b88c53
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
> @@ -0,0 +1,85 @@
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
> +#define SYS(fmt, ...)						\
> +	({							\
> +		char cmd[1024];					\
> +		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);	\
> +		if (!ASSERT_OK(system(cmd), cmd))		\
> +			goto fail;				\
> +	})
> +
> +#define NS_TEST "decap_sanity_ns"
> +#define IPV6_IFACE_ADDR "face::1"
> +#define UDP_TEST_PORT 7777
> +
> +void test_decap_sanity(void)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_attach);
> +	struct nstoken *nstoken = NULL;
> +	struct decap_sanity *skel;
> +	struct sockaddr_in6 addr;
> +	socklen_t addrlen;
> +	char buf[128] = {};
> +	int sockfd, err;
> +
> +	skel = decap_sanity__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		return;
> +
> +	SYS("ip netns add %s", NS_TEST);
> +	SYS("ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST,  
> IPV6_IFACE_ADDR);
> +	SYS("ip -net %s link set dev lo up", NS_TEST);
> +
> +	nstoken = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto fail;
> +
> +	qdisc_hook.ifindex = if_nametoindex("lo");
> +	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
> +		goto fail;
> +
> +	err = bpf_tc_hook_create(&qdisc_hook);
> +	if (!ASSERT_OK(err, "create qdisc hook"))
> +		goto fail;
> +
> +	tc_attach.prog_fd = bpf_program__fd(skel->progs.decap_sanity);
> +	err = bpf_tc_attach(&qdisc_hook, &tc_attach);
> +	if (!ASSERT_OK(err, "attach filter"))
> +		goto fail;
> +
> +	addrlen = sizeof(addr);
> +	err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
> +			    (void *)&addr, &addrlen);
> +	if (!ASSERT_OK(err, "make_sockaddr"))
> +		goto fail;
> +	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
> +	if (!ASSERT_NEQ(sockfd, -1, "socket"))
> +		goto fail;
> +	err = sendto(sockfd, buf, sizeof(buf), 0, (void *)&addr, addrlen);
> +	close(sockfd);
> +	if (!ASSERT_EQ(err, sizeof(buf), "send"))
> +		goto fail;
> +
> +	ASSERT_TRUE(skel->bss->init_csum_partial, "init_csum_partial");
> +	ASSERT_TRUE(skel->bss->final_csum_none, "final_csum_none");
> +	ASSERT_FALSE(skel->bss->broken_csum_start, "broken_csum_start");
> +
> +fail:
> +	if (nstoken) {
> +		bpf_tc_hook_destroy(&qdisc_hook);
> +		close_netns(nstoken);
> +	}
> +	system("ip netns del " NS_TEST " >& /dev/null");
> +	decap_sanity__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h  
> b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> index b394817126cf..cfed4df490f3 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> @@ -50,6 +50,12 @@
>   #define ICSK_TIME_LOSS_PROBE	5
>   #define ICSK_TIME_REO_TIMEOUT	6

> +#define ETH_HLEN		14
> +#define ETH_P_IPV6		0x86DD
> +
> +#define CHECKSUM_NONE		0
> +#define CHECKSUM_PARTIAL	3
> +
>   #define IFNAMSIZ		16

>   #define RTF_GATEWAY		0x0002
> diff --git a/tools/testing/selftests/bpf/progs/decap_sanity.c  
> b/tools/testing/selftests/bpf/progs/decap_sanity.c
> new file mode 100644
> index 000000000000..bd3c657c58a7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/decap_sanity.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +#define UDP_TEST_PORT 7777
> +
> +void *bpf_cast_to_kern_ctx(void *) __ksym;
> +bool init_csum_partial = false;
> +bool final_csum_none = false;
> +bool broken_csum_start = false;
> +
> +static unsigned int skb_headlen(const struct sk_buff *skb)
> +{
> +	return skb->len - skb->data_len;
> +}
> +
> +static unsigned int skb_headroom(const struct sk_buff *skb)
> +{
> +	return skb->data - skb->head;
> +}
> +
> +static int skb_checksum_start_offset(const struct sk_buff *skb)
> +{
> +	return skb->csum_start - skb_headroom(skb);
> +}
> +
> +SEC("tc")
> +int decap_sanity(struct __sk_buff *skb)
> +{
> +	struct sk_buff *kskb;
> +	struct ipv6hdr ip6h;
> +	struct udphdr udph;
> +	int err;
> +
> +	if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
> +		return TC_ACT_SHOT;
> +
> +	if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
> +		return TC_ACT_SHOT;
> +
> +	if (ip6h.nexthdr != IPPROTO_UDP)
> +		return TC_ACT_SHOT;
> +
> +	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph,  
> sizeof(udph)))
> +		return TC_ACT_SHOT;
> +
> +	if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
> +		return TC_ACT_SHOT;
> +
> +	kskb = bpf_cast_to_kern_ctx(skb);
> +	init_csum_partial = (kskb->ip_summed == CHECKSUM_PARTIAL);
> +	err = bpf_skb_adjust_room(skb, -(s32)(ETH_HLEN + sizeof(ip6h) +  
> sizeof(udph)),
> +				  1, BPF_F_ADJ_ROOM_FIXED_GSO);
> +	if (err)
> +		return TC_ACT_SHOT;
> +	final_csum_none = (kskb->ip_summed == CHECKSUM_NONE);
> +	if (kskb->ip_summed == CHECKSUM_PARTIAL &&
> +	    (unsigned int)skb_checksum_start_offset(kskb) >= skb_headlen(kskb))
> +		broken_csum_start = true;
> +
> +	return TC_ACT_SHOT;
> +}
> +
> +char __license[] SEC("license") = "GPL";
> --
> 2.30.2

