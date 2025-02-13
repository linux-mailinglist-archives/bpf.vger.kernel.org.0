Return-Path: <bpf+bounces-51473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDBDA35216
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B3816A9E3
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 23:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1222D7AB;
	Thu, 13 Feb 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dP6jyFG8"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7B275400
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739488774; cv=none; b=KHeuIM8jKFCAXXxkoHK2j0oHDK/c66Utk8tccTCND/JAIP0m5610Q+ecX4GM9C1dqgXQtJlQjSwMqYNx40fyG9ZWuz4PwwbDc7PA1T9VnyPYDSOW481INNSNN4WjRLVm/NhuDOjkm/yMiiOiVpiAHWzpakMlFHjdfLcCi77u0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739488774; c=relaxed/simple;
	bh=mNuwk6eJJ3BTsUjIoxVw5EJ/v1CJeWZ3gHvSoarZpvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH7lwcMjLSpCro8x9r/nkO9drYjoYk2TGhNMKxjrdaDGaM0G+kkWTy23s1i41lCeGlHYSy8+Y3A1gMfPz0XLHVJVAC3bX3U5dkG77XKUsoI61wH/V9yxq35qjTGmf1R4nnhCS0/RA385DY6XSyu3d7vWyd8SgjQeFbVgCX11usI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dP6jyFG8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4533d108-9617-4021-b7a9-befe209926da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739488769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSXPrZoxLzPNG/Euhy17lhZtrC9rFIYBlvCtIyCZ97c=;
	b=dP6jyFG80jsnyy08pXy455fiuID36V4Dtr5F+GP8o7gohIoGF1hfeMl6WBeJeESJUwn6Il
	g/syUcKlWodHDLSRQ/sBdbsL1r1o2sHuC2vaLjY0/77XVluwijvsAwOR8TYmoi7ySKVUVK
	QRXRM1Z9CYm/yUc0Kbck9UzH56TQPNc=
Date: Thu, 13 Feb 2025 15:19:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] bpf-next: selftest for TCP_ULP in bpf_setsockopt
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com
References: <20250210134550.3189616-1-zhangmingyi5@huawei.com>
 <20250210134550.3189616-3-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250210134550.3189616-3-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/10/25 5:45 AM, zhangmingyi wrote:
> From: Mingyi Zhang <zhangmingyi5@huawei.com>
> 
> We try to use bpf_set/getsockopt to set/get TCP_ULP in sockops, and "tls"
> need connect is established.To avoid impacting other test cases, I have
> written a separate test case file.
> 
> Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>   .../bpf/prog_tests/setget_sockopt_tcp_ulp.c   | 78 +++++++++++++++++++
>   .../bpf/progs/setget_sockopt_tcp_ulp.c        | 33 ++++++++
>   2 files changed, 111 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
>   create mode 100644 tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
> new file mode 100644
> index 000000000000..748da2c7d255
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/setget_sockopt_tcp_ulp.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */

This is not right.

> +
> +#define _GNU_SOURCE
> +#include <net/if.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +
> +#include "setget_sockopt_tcp_ulp.skel.h"
> +
> +#define CG_NAME "/setget-sockopt-tcp-ulp-test"
> +
> +static const char addr4_str[] = "127.0.0.1";
> +static const char addr6_str[] = "::1";
> +static struct setget_sockopt_tcp_ulp *skel;
> +static int cg_fd;
> +
> +static int create_netns(void)
> +{
> +	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
> +		return -1;
> +	if (!ASSERT_OK(system("ip link set dev lo up"), "set lo up"))
> +		return -1;
> +	return 0;
> +}
> +
> +static int modprobe_tls(void)
> +{
> +	if (!ASSERT_OK(system("modprobe tls"), "tls modprobe failed"))
> +		return -1;
> +	return 0;
> +}
> +
> +static void test_tcp_ulp(int family)

First, the bpf CI still fails to compile for the same reason as v1. You should 
have received an email from bpf CI bot. Please ensure it is addressed first 
before reposting. This repeated bpf CI error is an automatic nack.

pw-bot: cr

The subject tagging should be "[PATCH v2 bpf-next ...] selftests/bpf: ... ". 
There are many examples to follow in the mailing list if it is not clear.

Regarding the v1 comment: "...separate it out into its own BPF program..."

The comment was made at the bpf prog file, "progs/setget_sockopt.c". I meant 
only create a separate bpf program. The user space part can stay in 
prog_tests/setget_sockopt.c.

Move this function, test_tcp_ulp, to prog_tests/setget_sockopt.c. Then all the 
above config preparation codes and the test_setget_sockopt_tcp_ulp() can be 
saved. modprobe_tls() is not needed also. Do it after the test_ktls().
Take a look at test_nonstandard_opt() in prog_tests/setget_sockopt.c.
It is testing another bpf prog in the same prog_tests/setget_sockopt.c.

Also, for the bpf prog, do you really need to test at 
BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB? If not, just testing at 
SEC("lsm_cgroup/socket_post_create") will be easier. You can detach the 
previously attached skel->links.socket_post_create by using bpf_link__destroy() 
first and then attach yours bpf prog to do the test.

> +{
> +	struct setget_sockopt_tcp_ulp__bss *bss = skel->bss;
> +	int sfd, cfd;
> +
> +	memset(bss, 0, sizeof(*bss));
> +	sfd = start_server(family, SOCK_STREAM,
> +			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
> +	if (!ASSERT_GE(sfd, 0, "start_server"))
> +		return;
> +
> +	cfd = connect_to_fd(sfd, 0);
> +	if (!ASSERT_GE(cfd, 0, "connect_to_fd_server")) {
> +		close(sfd);
> +		return;
> +	}
> +	close(sfd);
> +	close(cfd);
> +
> +	ASSERT_EQ(bss->nr_tcp_ulp, 3, "nr_tcp_ulp");
> +}
> +
> +void test_setget_sockopt_tcp_ulp(void)
> +{
> +	cg_fd = test__join_cgroup(CG_NAME);
> +	if (cg_fd < 0)
> +		return;
> +	if (create_netns() && modprobe_tls())
> +		goto done;
> +	skel = setget_sockopt_tcp_ulp__open();
> +	if (!ASSERT_OK_PTR(skel, "open skel"))
> +		goto done;
> +	if (!ASSERT_OK(setget_sockopt_tcp_ulp__load(skel), "load skel"))
> +		goto done;
> +	skel->links.skops_sockopt_tcp_ulp =
> +		bpf_program__attach_cgroup(skel->progs.skops_sockopt_tcp_ulp, cg_fd);
> +	if (!ASSERT_OK_PTR(skel->links.skops_sockopt_tcp_ulp, "attach_cgroup"))
> +		goto done;
> +	test_tcp_ulp(AF_INET);
> +	test_tcp_ulp(AF_INET6);
> +done:
> +	setget_sockopt_tcp_ulp__destroy(skel);
> +	close(cg_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> new file mode 100644
> index 000000000000..bd1009766463
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt_tcp_ulp.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */

Same here.

> +
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +
> +int nr_tcp_ulp;
> +
> +SEC("sockops")
> +int skops_sockopt_tcp_ulp(struct bpf_sock_ops *skops)
> +{
> +	static const char target_ulp[] = "tls";
> +	char verify_ulp[sizeof(target_ulp)];
> +
> +	switch (skops->op) {
> +	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
> +		if (bpf_setsockopt(skops, IPPROTO_TCP, TCP_ULP, (void *)target_ulp,
> +							sizeof(target_ulp)) != 0)
> +			return 1;
> +		nr_tcp_ulp++;
> +		if (bpf_getsockopt(skops, IPPROTO_TCP, TCP_ULP, verify_ulp,
> +							sizeof(verify_ulp)) != 0)
> +			return 1;
> +		nr_tcp_ulp++;
> +		if (bpf_strncmp(verify_ulp, sizeof(target_ulp), "tls") != 0)
> +			return 1;
> +		nr_tcp_ulp++;
> +	}
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> \ No newline at end of file


