Return-Path: <bpf+bounces-46798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C620C9F01BE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B03287701
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 01:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987E522338;
	Fri, 13 Dec 2024 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPvJVffr"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8412114
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052472; cv=none; b=O5RDjnRvw1GLaHdzotgnuBV9z3r2+MJ3vTII7pd6SzNkT3WHJ0Z8N2ScPqWwewXawGZWP9ajEuNiHF5YCzhEJ3S6FdIq9cP44aUUewWz/GZukI32uBz5Biig4q5xRiNNko1YSrH0nT67XCvNVGARP40TVcYSZ1FkqPEvUGP/gU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052472; c=relaxed/simple;
	bh=Z8NZU10lqxCjMNIMYlB4+pTlmXi8SnoozYRhLLasBcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwnMN1EhfhjRZqcDquwCk0F8TjqogAjyrYoOqBsnj5vVXyDDICnAeQonmE8V3nq4+/jMtN8FvwJZhRYOCXv8LF4atTKwu/iOJ7tc3HSYOcIzqI5WDNrZYK15uHgEcIqoEMvxRc/YuYGtRNj78N4rt/4mFzMu3WfeaSdXwnR0RF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPvJVffr; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65a83b0e-5547-408a-a081-083ffd9d1c91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734052457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnv4HruEQX6MfZNU3lmvh1Od5gfd8xReBtQY46lrXCs=;
	b=FPvJVffrEUsdZ6D/7AWwFnN1TeBDWsQaZXprKduXuIdZMP0XDkc60cOrQdmJZcLZa6t7s8
	+ku6hvEamFKdXfLCt30gpX8j2cOqfC09Vr14FWMKJWitEciWYrsKOrtyU6BwzRMxnlaqaA
	hP1LdifARK/yEUG8QrQlOsLCcbjnAgo=
Date: Thu, 12 Dec 2024 17:14:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241207173803.90744-12-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/7/24 9:38 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only check if we pass those three key points after we enable the
> bpf extension for so_timestamping. During each point, we can choose
> whether to print the current timestamp.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
>   .../selftests/bpf/progs/so_timestamping.c     | 135 ++++++++++++++++++
>   2 files changed, 232 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
>   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> new file mode 100644
> index 000000000000..c5978444f9c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Tencent */
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <linux/socket.h>
> +#include <linux/tls.h>
> +#include <net/if.h>
> +
> +#include "test_progs.h"
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +
> +#include "so_timestamping.skel.h"
> +
> +#define CG_NAME "/so-timestamping-test"
> +
> +static const char addr4_str[] = "127.0.0.1";
> +static const char addr6_str[] = "::1";
> +static struct so_timestamping *skel;
> +static int cg_fd;
> +
> +static int create_netns(void)
> +{
> +	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
> +		return -1;
> +
> +	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void test_tcp(int family)
> +{
> +	struct so_timestamping__bss *bss = skel->bss;
> +	char buf[] = "testing testing";
> +	int sfd = -1, cfd = -1;
> +	int n;
> +
> +	memset(bss, 0, sizeof(*bss));
> +
> +	sfd = start_server(family, SOCK_STREAM,
> +			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
> +	if (!ASSERT_GE(sfd, 0, "start_server"))
> +		goto out;
> +
> +	cfd = connect_to_fd(sfd, 0);
> +	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
> +		close(sfd);
> +		goto out;
> +	}
> +
> +	n = write(cfd, buf, sizeof(buf));
> +	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
> +		goto out;
> +
> +	ASSERT_EQ(bss->nr_active, 1, "nr_active");
> +	ASSERT_EQ(bss->nr_sched, 1, "nr_sched");
> +	ASSERT_EQ(bss->nr_txsw, 1, "nr_txsw");
> +	ASSERT_EQ(bss->nr_ack, 1, "nr_ack");
> +
> +out:
> +	if (sfd >= 0)
> +		close(sfd);
> +	if (cfd >= 0)
> +		close(cfd);
> +}
> +
> +void test_so_timestamping(void)
> +{
> +	cg_fd = test__join_cgroup(CG_NAME);
> +	if (cg_fd < 0)
> +		return;
> +
> +	if (create_netns())
> +		goto done;
> +
> +	skel = so_timestamping__open();
> +	if (!ASSERT_OK_PTR(skel, "open skel"))
> +		goto done;
> +
> +	if (!ASSERT_OK(so_timestamping__load(skel), "load skel"))
> +		goto done;
> +
> +	skel->links.skops_sockopt =
> +		bpf_program__attach_cgroup(skel->progs.skops_sockopt, cg_fd);
> +	if (!ASSERT_OK_PTR(skel->links.skops_sockopt, "attach cgroup"))
> +		goto done;
> +
> +	test_tcp(AF_INET6);
> +	test_tcp(AF_INET);
> +
> +done:
> +	so_timestamping__destroy(skel);
> +	close(cg_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
> new file mode 100644
> index 000000000000..f64e94dbd70e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Tencent */
> +
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +#define SK_BPF_CB_FLAGS 1009
> +#define SK_BPF_CB_TX_TIMESTAMPING 1
> +
> +int nr_active;
> +int nr_passive;
> +int nr_sched;
> +int nr_txsw;
> +int nr_ack;
> +
> +struct sockopt_test {
> +	int opt;
> +	int new;
> +};
> +
> +static const struct sockopt_test sol_socket_tests[] = {
> +	{ .opt = SK_BPF_CB_FLAGS, .new = SK_BPF_CB_TX_TIMESTAMPING, },
> +	{ .opt = 0, },
> +};
> +
> +struct loop_ctx {
> +	void *ctx;
> +	struct sock *sk;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, u32);
> +	__type(value, u64);
> +	__uint(max_entries, 1024);
> +} hash_map SEC(".maps");
> +
> +static u64 delay_tolerance_nsec = 5000000;

If I count right, 5ms may not a lot for the bpf CI and the test could become 
flaky. Probably good enough to ensure the delay is larger than the previous one.

> +
> +static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
> +				const struct sockopt_test *t,
> +				int level)
> +{
> +	int new, opt;
> +
> +	opt = t->opt;
> +	new = t->new;
> +
> +	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int bpf_test_socket_sockopt(__u32 i, struct loop_ctx *lc)
> +{
> +	const struct sockopt_test *t;
> +
> +	if (i >= ARRAY_SIZE(sol_socket_tests))
> +		return 1;
> +
> +	t = &sol_socket_tests[i];
> +	if (!t->opt)
> +		return 1;
> +
> +	return bpf_test_sockopt_int(lc->ctx, lc->sk, t, SOL_SOCKET);
> +}
> +
> +static int bpf_test_sockopt(void *ctx, struct sock *sk)
> +{
> +	struct loop_ctx lc = { .ctx = ctx, .sk = sk, };
> +	int n;
> +
> +	n = bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sockopt, &lc, 0);
> +	if (n != ARRAY_SIZE(sol_socket_tests))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static bool bpf_test_delay(struct bpf_sock_ops *skops)
> +{
> +	u64 timestamp = bpf_ktime_get_ns();
> +	u32 seq = skops->args[2];
> +	u64 *value;
> +
> +	value = bpf_map_lookup_elem(&hash_map, &seq);
> +	if (value && (timestamp - *value > delay_tolerance_nsec)) {
> +		bpf_printk("time delay: %lu", timestamp - *value);

Please try not to printk in selftests. The bpf CI cannot interpret it 
meaningfully and turn it into a PASS/FAIL signal.

> +		return false;
> +	}
> +
> +	bpf_map_update_elem(&hash_map, &seq, &timestamp, BPF_ANY);

A nit.

	*value = timestamp;

> +	return true;
> +}
> +
> +SEC("sockops")
> +int skops_sockopt(struct bpf_sock_ops *skops)
> +{
> +	struct bpf_sock *bpf_sk = skops->sk;
> +	struct sock *sk;
> +
> +	if (!bpf_sk)
> +		return 1;
> +
> +	sk = (struct sock *)bpf_skc_to_tcp_sock(bpf_sk);
> +	if (!sk)
> +		return 1;
> +
> +	switch (skops->op) {
> +	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> +		nr_active += !bpf_test_sockopt(skops, sk);
> +		break;
> +	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> +		if (bpf_test_delay(skops))
> +			nr_sched += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_SW_OPT_CB:
> +		if (bpf_test_delay(skops))
> +			nr_txsw += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> +		if (bpf_test_delay(skops))
> +			nr_ack += 1;
> +		break;

The test is a good step forward. Thanks. Instead of one u64 as the map value, I 
think it can be improved to make the test more real to record the individual 
delay. e.g. the following map value:

struct delay_info {
	u64 sendmsg_ns;
	u32 sched_delay;  /* SCHED_OPT_CB - sendmsg_ns */
	u32 sw_snd_delay;
	u32 ack_delay;
};

and I think a bpf callback during the sendmsg is still needed in the next respin.

> +	}
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";


