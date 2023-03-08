Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31F6B1647
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 00:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCHXLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 18:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCHXLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 18:11:15 -0500
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [IPv6:2001:41d0:203:375::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCB5D49C4
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 15:10:46 -0800 (PST)
Message-ID: <5a05613a-a346-1072-bbab-3494cf231961@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678317044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0XsznzVx1vA8Zg2Y7/PwRp2Nf5dYOtmemyK8LxIiYo=;
        b=QJzX+SGPhzLL1/QL2YZ1jtHV7we+9PjWlBq2it6pnuw3gQe8X61mapL9dN26XJgFsC30AL
        e9MuzLUIqXOZmXTWGz1b4s3lsX0heNMwXOC4QFcYMHSsqoN8EfEu5G+BswOZAN1KtzG3Qd
        c8qsPxflHzgdNZhtuLcLdqREcbkmVsU=
Date:   Wed, 8 Mar 2023 15:10:41 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-9-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230308005050.255859-9-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
> Create a pair of sockets that utilize the congestion control algorithm
> under a particular name. Then switch up this congestion control
> algorithm to another implementation and check whether newly created
> connections using the same cc name now run the new implementation.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 38 ++++++++++++
>   .../selftests/bpf/progs/tcp_ca_update.c       | 62 +++++++++++++++++++
>   2 files changed, 100 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index e980188d4124..caaa9175ee36 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -8,6 +8,7 @@
>   #include "bpf_dctcp.skel.h"
>   #include "bpf_cubic.skel.h"
>   #include "bpf_tcp_nogpl.skel.h"
> +#include "tcp_ca_update.skel.h"
>   #include "bpf_dctcp_release.skel.h"
>   #include "tcp_ca_write_sk_pacing.skel.h"
>   #include "tcp_ca_incompl_cong_ops.skel.h"
> @@ -381,6 +382,41 @@ static void test_unsupp_cong_op(void)
>   	libbpf_set_print(old_print_fn);
>   }
>   
> +static void test_update_ca(void)
> +{
> +	struct tcp_ca_update *skel;
> +	struct bpf_link *link;
> +	int saved_ca1_cnt;
> +	int err;
> +
> +	skel = tcp_ca_update__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return;
> +
> +	err = tcp_ca_update__load(skel);

nit. Use tcp_ca_update__open_and_load().

> +	if (!ASSERT_OK(err, "load")) {
> +		tcp_ca_update__destroy(skel);
> +		return;
> +	}
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> +	ASSERT_OK_PTR(link, "attach_struct_ops");
> +
> +	do_test("tcp_ca_update", NULL);
> +	saved_ca1_cnt = skel->bss->ca1_cnt;
> +	ASSERT_GT(saved_ca1_cnt, 0, "ca1_ca1_cnt");
> +
> +	err = bpf_link__update_map(link, skel->maps.ca_update_2);
> +	ASSERT_OK(err, "update_struct_ops");
> +
> +	do_test("tcp_ca_update", NULL);
> +	ASSERT_EQ(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
> +	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
> +
> +	bpf_link__destroy(link);
> +	tcp_ca_update__destroy(skel);
> +}
> +
>   void test_bpf_tcp_ca(void)
>   {
>   	if (test__start_subtest("dctcp"))
> @@ -399,4 +435,6 @@ void test_bpf_tcp_ca(void)
>   		test_incompl_cong_ops();
>   	if (test__start_subtest("unsupp_cong_op"))
>   		test_unsupp_cong_op();
> +	if (test__start_subtest("update_ca"))
> +		test_update_ca();
>   }
> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_update.c b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> new file mode 100644
> index 000000000000..36a04be95df5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_update.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int ca1_cnt = 0;
> +int ca2_cnt = 0;
> +
> +#define USEC_PER_SEC 1000000UL

Not used.

> +
> +#define min(a, b) ((a) < (b) ? (a) : (b))

Not used.

> +
> +static inline struct tcp_sock *tcp_sk(const struct sock *sk)
> +{
> +	return (struct tcp_sock *)sk;
> +}
> +
> +SEC("struct_ops/ca_update_1_cong_control")
> +void BPF_PROG(ca_update_1_cong_control, struct sock *sk,
> +	      const struct rate_sample *rs)
> +{
> +	ca1_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_2_cong_control")
> +void BPF_PROG(ca_update_2_cong_control, struct sock *sk,
> +	      const struct rate_sample *rs)
> +{
> +	ca2_cnt++;
> +}
> +
> +SEC("struct_ops/ca_update_ssthresh")
> +__u32 BPF_PROG(ca_update_ssthresh, struct sock *sk)
> +{
> +	return tcp_sk(sk)->snd_ssthresh;
> +}
> +
> +SEC("struct_ops/ca_update_undo_cwnd")
> +__u32 BPF_PROG(ca_update_undo_cwnd, struct sock *sk)
> +{
> +	return tcp_sk(sk)->snd_cwnd;
> +}
> +
> +SEC(".struct_ops.link")
> +struct tcp_congestion_ops ca_update_1 = {
> +	.cong_control = (void *)ca_update_1_cong_control,
> +	.ssthresh = (void *)ca_update_ssthresh,
> +	.undo_cwnd = (void *)ca_update_undo_cwnd,
> +	.name = "tcp_ca_update",
> +};
> +
> +SEC(".struct_ops.link")
> +struct tcp_congestion_ops ca_update_2 = {
> +	.cong_control = (void *)ca_update_2_cong_control,

nit. I think it is more future proof to use '.init' to bump the ca1_cnt and 
ca2_cnt. '.init' must be called. Just in case for some unlikely stack change 
that may not call cong_control and then need to adjust the test accordingly.

It also needs a few negative tests like creating a link with a map without 
BPF_F_LINK. delete_elem on BPF_F_LINK map. Replace a link with a different 
tcp-cc-name which is not supported now, ...etc.

> +	.ssthresh = (void *)ca_update_ssthresh,
> +	.undo_cwnd = (void *)ca_update_undo_cwnd,
> +	.name = "tcp_ca_update",
> +};

