Return-Path: <bpf+bounces-46400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8B9E9945
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935742820DA
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 14:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD11BEF82;
	Mon,  9 Dec 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTNe6vh8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A21B042A;
	Mon,  9 Dec 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755551; cv=none; b=Yd8yNJfk8ugIyhB2IsMEqQaZvDxcHPsl78RYyqCSMXqplioTAU0PJ5OfDP6wAg738pR96ROA7dgOhNi4atjzTwxpRzTAV8Sykqx9KfWw+WNz7/O/jgSxpvDH0WXW9bw1iO4u9djLjuroi/j+FFoTylHh8t76czuVhjApax/Xh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755551; c=relaxed/simple;
	bh=avW6uQ9edUq1Vb3/64A1RMKy4WNNMe1+iVqEK+Q8j8I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jzwCJbwWycnVWLJPtKd7bzoxi0Oab10dUKIxnILnopICjXnUpwz9fWRj/tKLY7y+r/BN56/0F/bZ1Nwk2t4qKE7pZVVLds6QIWNvs/uAZ61LTxk1atN8zHfZo2oi4rjQgt9l1Ij0E1XIBkkncfNQYIHr2tG6cy/4GZgLzTIJUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTNe6vh8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6c36490e5so143868385a.3;
        Mon, 09 Dec 2024 06:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733755548; x=1734360348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF8O+mUb4olYXL6r9MnyhYJGerpX3lWeXxxNozzLp1I=;
        b=OTNe6vh8SHgBEfwbOVUMVfhuGeqcs6Tsd+2BvFNnoRMpJYcy9aiV2PftvaG/pQ2vX2
         juFoyXodiX1JGxC++lJG5Am9gmWK9QAK6QWExgM55VTdWs1rcBREHuucZSRJBfFyMCOU
         oaGKx6H9PErCIwYRwCxPaSR5fZVBXKDWdVGgCOvgq7PZ9pVrw8sXv8SM7lbhQcqvlI9P
         oZYeBg4yk6NYWxrf6E3NLvdaJHtwe5oUE8a+sgzOmhUxnqs1z+ILVBQejd7exy4hXsRA
         NjkI3ZGd4iNaV5L4jGGKb0JtG89wDUBhhO7nxCTpnQAqgYMXcG+ZCEEm/OSP6GuyPwAh
         36Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755548; x=1734360348;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SF8O+mUb4olYXL6r9MnyhYJGerpX3lWeXxxNozzLp1I=;
        b=rTQDgP12Gho3fhkd41Yei+bsQ4sTFMQ5H4gCsp6VSV5LYAhy4c3OHi1h7LhJWebp8z
         V2UDyChtxR2ByQEEWRLB2kaiJqUyoD0aI3l/1sXYtaXu/bcIXA4NSOtgm349eHHAp7XJ
         rKRXKp54Y41HrOhvAurb+DoqiXKKB/j+FEJR3spAj6q+lRFxB/VhGKkr9ERIdbrvmuOa
         jFbgBY6CI3FOOzYCf/WJCkwX0asYuuQXIGyHLu7lWGOnhhkSaXzQrcfKAPGCMYuztJ0T
         wjRmCJdCQh3j3/YWy3Rgm1grwy1tgY018DpXk8QAVzRbyhMSqc6LnCOWKFlznmd/pkJ1
         BdxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+qrqY8SYfE3KNv5cKDRybJsK8T92h+GyKX5X7N378diD/SfJFpTOdcgk51yWKBNzGyA/oHzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8tIyawte8ZXvWM0SYjbsf7bA6+mLG+c9Akk4NCEh1of6JH/l
	8mwPoLjZm4huCo+0GCE4Twq6mRvagFe4kxCAGtUb+p/jBuvjifrA
X-Gm-Gg: ASbGncvTSPpL3ndoOsHMZPpYWkPdkQX9eplQfjwCXKATzL0dOMKRjybE1kMLWRorS0z
	uapSSuePm4AshAd2IDEX79RFdv5Eluu16/cwpk2R7THULDQrxSNOeOmb7RHSerMWZ8HOngF0g+s
	uLAd5nqlwkU4T/zDNr5VSPRyhdE0plGE/PpBvEXha48UyBGO7fBlYmbrlTcR5eiwkuW0DcDuhPJ
	Ec4Oal9fw8gsYaD54QF+cK/UeP1nvULU52CfAUM9lvL2uvPMECN4UYmLedP2fZT/3RSmt7a/9UG
	VKugM+6ZXmMN0gY8M1qFSw==
X-Google-Smtp-Source: AGHT+IHRJ6TBrWxesuAWSHWGLTYewAlS3qDITnWf4G8KugG2OfF+QQjYFTj3dkDQsMrp07qyjuS0uA==
X-Received: by 2002:a05:620a:2b99:b0:7b6:d63a:ae8f with SMTP id af79cd13be357-7b6dce3b050mr115665085a.21.1733755547740;
        Mon, 09 Dec 2024 06:45:47 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66db7csm49558616d6.23.2024.12.09.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:45:47 -0800 (PST)
Date: Mon, 09 Dec 2024 09:45:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6757029acc193_31657c2947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241207173803.90744-12-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-12-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 11/11] bpf: add simple bpf tests in the tx
 path for so_timstamping feature
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>

in subject: s/so_timstamping/so_timestamping
 
> Only check if we pass those three key points after we enable the
> bpf extension for so_timestamping. During each point, we can choose
> whether to print the current timestamp.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  .../bpf/prog_tests/so_timestamping.c          |  97 +++++++++++++
>  .../selftests/bpf/progs/so_timestamping.c     | 135 ++++++++++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
>  create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
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
> +		return false;
> +	}
> +
> +	bpf_map_update_elem(&hash_map, &seq, &timestamp, BPF_ANY);

Maybe enforce that you expect value to be found for all cases except
the first (SCHED). I.e., that they share the same seq/tskey.

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
> +	}
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.37.3
> 



