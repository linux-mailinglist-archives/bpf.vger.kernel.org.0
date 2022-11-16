Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907A262CB2F
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKPUiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 15:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiKPUiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 15:38:23 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C054B25
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 12:38:19 -0800 (PST)
Message-ID: <b5540340-85a7-6809-5f37-1509bbf9a142@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668631098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qf/mHgNvS0KiJWIWsV+6vSt6su8Y3b9J+AP/1lILOLg=;
        b=aH3eCZhS7JkWt0xyzO2GRbwO17pJLW2GqIYh3tKZWJEjMHXiGFgeRKejcPLBP+7YvDjkZn
        JYraBA6SdpLSoHtkw9ZoQtFxHVEWxxAKMEQc2zRMIxp9lqE1UzBn74/Ly8nI4K6vqBN7y8
        8V4YjAqrq8u2ewpyzElRZj/B1HvUufQ=
Date:   Wed, 16 Nov 2022 12:38:13 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
References: <20221115031031.3281094-1-sdf@google.com>
 <20221115031031.3281094-2-sdf@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221115031031.3281094-2-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/22 7:10 PM, Stanislav Fomichev wrote:
> LWT_XMIT to test L3 case, TC to test L2 case.

It will be useful to add more details here to explain which test is testing the 
skb->len check in __bpf_redirect_no_mac() and __bpf_redirect_common() in patch 1.

> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   .../selftests/bpf/prog_tests/empty_skb.c      | 140 ++++++++++++++++++
>   tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
>   2 files changed, 177 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
>   create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> new file mode 100644
> index 000000000000..6e35739babed
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include <net/if.h>
> +#include "empty_skb.skel.h"
> +
> +#define SYS(cmd) ({ \
> +	if (!ASSERT_OK(system(cmd), (cmd))) \
> +		goto out; \
> +})
> +
> +void test_empty_skb(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
> +	struct empty_skb *bpf_obj = NULL;
> +	struct nstoken *tok = NULL;
> +	struct bpf_program *prog;
> +	char eth_hlen_pp[15];
> +	char eth_hlen[14];
> +	int veth_ifindex;
> +	int ipip_ifindex;
> +	int err;
> +	int i;
> +
> +	struct {
> +		const char *msg;
> +		const void *data_in;
> +		__u32 data_size_in;
> +		int *ifindex;
> +		int err;
> +		int ret;
> +		bool success_on_tc;
> +	} tests[] = {
> +		/* Empty packets are always rejected. */
> +
> +		{
> +			.msg = "veth empty ingress packet",
> +			.data_in = NULL,
> +			.data_size_in = 0,
> +			.ifindex = &veth_ifindex,
> +			.err = -EINVAL,
> +		},
> +		{
> +			.msg = "ipip empty ingress packet",
> +			.data_in = NULL,
> +			.data_size_in = 0,
> +			.ifindex = &ipip_ifindex,
> +			.err = -EINVAL,
> +		},


> +
> +		/* ETH_HLEN-sized packets:
> +		 * - can not be redirected at LWT_XMIT
> +		 * - can be redirected at TC
> +		 */
> +
> +		{
> +			.msg = "veth ETH_HLEN packet ingress",
> +			.data_in = eth_hlen,
> +			.data_size_in = sizeof(eth_hlen),
> +			.ifindex = &veth_ifindex,
> +			.ret = -ERANGE,
> +			.success_on_tc = true,
> +		},
> +		{
> +			.msg = "ipip ETH_HLEN packet ingress",
> +			.data_in = eth_hlen,
> +			.data_size_in = sizeof(eth_hlen),
> +			.ifindex = &veth_ifindex,
> +			.ret = -ERANGE,
> +			.success_on_tc = true,
> +		},


hmm... these two tests don't look right.  They are the same except the ".msg" 
part.  The latter one should use &ipip_ifindex?

> +
> +		/* ETH_HLEN+1-sized packet should be redirected. */
> +
> +		{
> +			.msg = "veth ETH_HLEN+1 packet ingress",
> +			.data_in = eth_hlen_pp,
> +			.data_size_in = sizeof(eth_hlen_pp),
> +			.ifindex = &veth_ifindex,
> +		},
> +		{
> +			.msg = "ipip ETH_HLEN+1 packet ingress",
> +			.data_in = eth_hlen_pp,
> +			.data_size_in = sizeof(eth_hlen_pp),
> +			.ifindex = &veth_ifindex,
> +		},

Same here.

