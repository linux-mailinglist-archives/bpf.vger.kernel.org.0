Return-Path: <bpf+bounces-50359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91273A269F7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092791657DE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D086321;
	Tue,  4 Feb 2025 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzy0DhDO"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A3179BD
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634568; cv=none; b=nIGbQK2NLpTGCpuEYgPt2pET+9TQ+SJqtT7+WvHUhIbtsEAGmXO9AJ+zMPI08jqkF0jkYUHsqaI9FQaBX7oxmSjgbqSvufpcrlSX+Qq4AchpTW8en6vRyMulStDmZJiYwLQ3Ga8hz9dTUos9guKLTT2kqqeIx/uZfb7UIvijGn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634568; c=relaxed/simple;
	bh=CTf50sZ65VKVQOiVxmfdArtO2DclDc6JuFdzkp7V6D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUvYcWjH2SmbTSB0qQ5bXEQDbQpUGD28abzSc0AF8p6EhSvBndk5Oog+igyKb0gMl+h3WsS6OuNsjRK9AffNgswwGjy7RBeBLKcJpPEDLtef0HpqQzOKHfATHHZe1fT79jYpSA0LS+4NIkgS6ap1Ow6bUmBSDy02dm2UOVpvhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzy0DhDO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d62bd77-6733-40c7-b240-a1aeff55566c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738634557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNa4eWSgPRcgSKOOwayigpR/3LC1/pX8LH12+/kFsOQ=;
	b=wzy0DhDO3PzsfWKQA5wQZBkQZReVCSTQBFMJ0WNWGsyHJkdOE3p0W/c4/8wqmcxty+qQ1U
	bAoNIW7py+81onNBlJ2KednXB7fH4sGtKQsSCmefbLSRMQs3fTGFMQ29bobmPl2tp1knSP
	fj/IiiqkCqkouZ7Y9xIJAzREAyDPzFM=
Date: Mon, 3 Feb 2025 18:02:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 13/13] bpf: add simple bpf tests in the tx
 path for so_timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-14-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-14-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
> Only check if we pass those three key points after we enable the
> bpf extension for so_timestamping. During each point, we can choose
> whether to print the current timestamp.

The commit message also needs to be updated...

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   .../bpf/prog_tests/so_timestamping.c          |  86 +++++
>   .../selftests/bpf/progs/so_timestamping.c     | 299 ++++++++++++++++++
>   2 files changed, 385 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
>   create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> new file mode 100644
> index 000000000000..ee7fdc381609
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> @@ -0,0 +1,86 @@
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <linux/socket.h>
> +#include <linux/tls.h>

tls.h?

> +#include <net/if.h>

I suspect most of the above #define and #include are not needed. Please clean up.

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

nit. cg_fd does not need to be global.

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
> +	if (!ASSERT_OK_FD(sfd, "start_server"))
> +		goto out;
> +
> +	cfd = connect_to_fd(sfd, 0);
> +	if (!ASSERT_OK_FD(cfd, "connect_to_fd_server"))
> +		goto out;
> +
> +	n = write(cfd, buf, sizeof(buf));
> +	if (!ASSERT_EQ(n, sizeof(buf), "send to server"))
> +		goto out;
> +
> +	ASSERT_EQ(bss->nr_active, 1, "nr_active");
> +	ASSERT_EQ(bss->nr_snd, 2, "nr_snd");
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
> +	struct netns_obj *ns;
> +
> +	cg_fd = test__join_cgroup(CG_NAME);
> +	if (cg_fd < 0)

ASSERT_OK_FD. The existing setget_sockopt test should probably be fixed also but 
that will be a separate patch.

> +		return;
> +
> +	ns = netns_new("so_timestamping_ns", true);
> +	if (!ASSERT_OK_PTR(ns, "create ns"))

cg_fd is leaked.

> +		return;

goto done;

netns_free() and so_timestamping__destroy() can handle NULL.

> +
> +	skel = so_timestamping__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skel"))
> +		goto done;
> +
> +	if (!ASSERT_OK(so_timestamping__attach(skel), "attach skel"))
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
> +	netns_free(ns);
> +	close(cg_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/so_timestamping.c b/tools/testing/selftests/bpf/progs/so_timestamping.c
> new file mode 100644
> index 000000000000..a893859ffe32
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> @@ -0,0 +1,299 @@
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#define BPF_PROG_TEST_TCP_HDR_OPTIONS
> +#include "test_tcp_hdr_options.h"
> +#include <errno.h>
> +
> +#define SK_BPF_CB_FLAGS 1009
> +#define SK_BPF_CB_TX_TIMESTAMPING 1
> +
> +int nr_active;
> +int nr_snd;
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
> +	const struct sock *sk;
> +};
> +
> +struct sk_stg {
> +	__u64 sendmsg_ns;	/* record ts when sendmsg is called */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct sk_stg);
> +} sk_stg_map SEC(".maps");
> +
> +
> +struct delay_info {
> +	u64 sendmsg_ns;		/* record ts when sendmsg is called */
> +	u32 sched_delay;	/* SCHED_OPT_CB - sendmsg_ns */
> +	u32 sw_snd_delay;	/* SW_OPT_CB - SCHED_OPT_CB */
> +	u32 ack_delay;		/* ACK_OPT_CB - SW_OPT_CB */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, u32);

I just noticed there are two tcp connections in the test. One v4 and one v6.
Unlikely to collide on seqno, still better to add a sk_cookie to the key of the 
map, like:

struct sk_tskey {
	u64 sk_cookie;
	u32 tskey;
};

Use bpf_get_sokcet_cookie(ctx) to get a unique socket cookie.

> +	__type(value, struct delay_info);
> +	__uint(max_entries, 1024);
> +} time_map SEC(".maps");
> +
> +static u64 delay_tolerance_nsec = 10000000000; /* 10 second as an example */
> +
> +static int bpf_test_sockopt_int(void *ctx, const struct sock *sk,
> +				const struct sockopt_test *t,
> +				int level)
> +{
> +	int new, opt, tmp;
> +
> +	opt = t->opt;
> +	new = t->new;
> +
> +	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> +		return 1;
> +
> +	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> +	    tmp != new)
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
> +static int bpf_test_sockopt(void *ctx, const struct sock *sk)
> +{
> +	struct loop_ctx lc = { .ctx = ctx, .sk = sk, };
> +	int n;
> +
> +	n = bpf_loop(ARRAY_SIZE(sol_socket_tests), bpf_test_socket_sockopt, &lc, 0);

There is only one SK_BPF_CB_FLAGS optname to test, so no need to bpf_loop. 
Directly do one bpf_setsockopt and one bpf_getsockopt.

We can see if there is a need to refactor this timestamp test back to the 
setget_sockopt.c test later if loop will be needed after adding the UDP support. 
The setget_sockopt.c does use a loop to test many options at once which is 
probably where this piece of code (bpf_loop) is borrowed from.

> +	if (n != ARRAY_SIZE(sol_socket_tests))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static bool bpf_test_access_sockopt(void *ctx)
> +{
> +	const struct sockopt_test *t;
> +	int tmp, ret, i = 0;
> +	int level = SOL_SOCKET;
> +
> +	t = &sol_socket_tests[i];
> +
> +	for (; t->opt;) {

Same here. Directly do one bpf_setsockopt and one bpf_getsockopt instead of looping.

> +		ret = bpf_setsockopt(ctx, level, t->opt, (void *)&t->new, sizeof(t->new));
> +		if (ret != -EOPNOTSUPP)
> +			return true;
> +
> +		ret = bpf_getsockopt(ctx, level, t->opt, &tmp, sizeof(tmp));
> +		if (ret != -EOPNOTSUPP)
> +			return true;
> +
> +		if (++i >= ARRAY_SIZE(sol_socket_tests))
> +			break;
> +	}
> +
> +	return false;
> +}
> +
> +/* Adding a simple test to see if we can get an expected value */
> +static bool bpf_test_access_load_hdr_opt(struct bpf_sock_ops *skops)
> +{
> +	struct tcp_opt reg_opt;
> +	int load_flags = 0;
> +	int ret;
> +
> +	reg_opt.kind = TCPOPT_EXP;
> +	reg_opt.len = 0;
> +	reg_opt.data32 = 0;
> +	ret = bpf_load_hdr_opt(skops, &reg_opt, sizeof(reg_opt), load_flags);
> +	if (ret != -EOPNOTSUPP)
> +		return true;
> +
> +	return false;
> +}
> +
> +/* Adding a simple test to see if we can get an expected value */
> +static bool bpf_test_access_cb_flags_set(struct bpf_sock_ops *skops)
> +{
> +	int ret;
> +
> +	ret = bpf_sock_ops_cb_flags_set(skops, 0);
> +	if (ret != -EOPNOTSUPP)
> +		return true;
> +
> +	return false;
> +}
> +
> +/* In the timestamping callbacks, we're not allowed to call the following
> + * BPF CALLs for the safety concern. Return false if expected.
> + */
> +static int bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,

nit. The return value is true/false. Stay with "bool" as the return type.


> +				     const struct sock *sk)
> +{
> +	if (bpf_test_access_sockopt(skops))
> +		return true;
> +
> +	if (bpf_test_access_load_hdr_opt(skops))
> +		return true;
> +
> +	if (bpf_test_access_cb_flags_set(skops))
> +		return true;

Thanks for adding these negative tests.

> +
> +	return false;
> +}
> +

