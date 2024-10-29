Return-Path: <bpf+bounces-43358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31609B3FBB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B541C21ED3
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B95589B;
	Tue, 29 Oct 2024 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2Y++wlP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E242260C;
	Tue, 29 Oct 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165224; cv=none; b=MntnMpK3gZ977HEPIcqJf0JSdBf0VZazJjIoUcCtmsHTTzlUyevv18wULbiPQotLwNKLx/iRuUEelwWYEr2TzgZrf6VSiuFWsTpZZrD8roqf3CdOELIaqxtdmO8sMQVjBQZ26vYumzq0adZes7OSruwbEMoPyUmaxFtLiA6MfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165224; c=relaxed/simple;
	bh=8mwSz5VKGfD4bgBeMddVIK6cynfJlHlJWz78OhoehKo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A53qbK1toozAllgFujCYh3uodT70I4Z03sJrHKiNu9djJAmOIvdXH/y97E447GMYZewBzYtrwaoe9eZlQXzXSLkXVRHRMYdGG9doLsL4T5jfbGWH9z8qdxBlIvzOMlExlw2wUc6XGC2mbL8+WpysZHGoN53zyi7H9tUbLz7NRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2Y++wlP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ce3fc4e58bso29332526d6.0;
        Mon, 28 Oct 2024 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165221; x=1730770021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJj+3gisgH3RujK91HHuKiOjbovMXVdg65yol0jaWUE=;
        b=i2Y++wlPefe7dN4m+cgFsn6sr2bpbGe5Le3sOyLWqejS4S7TkQhlKXTwOxhAiVP3+J
         JAvvon1xugNbuKu75dF5EBxT9oEGyglPBnNHgmg/M1aIkwsMpyb0beIWp6ODFmRUDWuE
         A/rmeMMkAqwcYE7xw8MEIkmhH1gZiw38RL2fJTGDPjrMRpMc2JXfj9EzlMrkmAounVat
         /EQMpfVdw8Ly+sanfYLj/w3K7SoEi1iYZQcULfDgl8yTuWMqKy18eozpTOTI74p83bn4
         GfkyyfR8SWu22bIRvhht1ETSlxyJxhUsdL0hozZCMzKFEnyaLkGV6RP5RJr6X0Tcm404
         aPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165221; x=1730770021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJj+3gisgH3RujK91HHuKiOjbovMXVdg65yol0jaWUE=;
        b=V4ZITVhcQ5XnYlPkbzjlhMiaitvjGtUMyqr2OeFyWpYyJlFFk7vMGEzE8I9Va6uIjw
         dOZTh8Ol2Gh+x4RuzvHmunuimYjmob77zQR6Uh3LJywy96rWfyI/2GN5IgkTWFBLqe0Y
         vCtk1gNAS+wxfaJJ5WPP/WGdqb8YOqN2LtmWxaD5lOfute7lbSe7a+YllBXWzrIJVFsA
         ITiiGjUql0H6EfhpKkzyAJ9dxQqGeT84Md27CYUW3qBXmokiHW5NwLsiP8K9tusWDhVG
         A3cgVs/+vfRcL3xk5i4P7P0rUeygZo6tW7ayKova/7qFoQDh1LtKJml/9kXS5Au67yLg
         6WeA==
X-Forwarded-Encrypted: i=1; AJvYcCUtuLFQKkbJJNfx1k5EFwso7Y1zDOcY9VzRBd7tZBHXLdNj7L8rgL3qUY6/GCr2LBdxdhbjvtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4nJ4151+4f/86x4MT87tnixrglDzuPNsqTM12yYiqT+D5JGtV
	jFFrCjQj55y8sX6ZimjQZJBQyltHOC+3sXnGCT3qVfna+QhcopId
X-Google-Smtp-Source: AGHT+IE6yf8WgoSkOnpzcI2DmeGnvrCPB9jxXgIHyZkBzfrPT+ORLJTUa2hsnf9F6qPzZ2hbPkIi9w==
X-Received: by 2002:a05:6214:5248:b0:6cb:f262:aa9b with SMTP id 6a1803df08f44-6d185844723mr163853936d6.52.1730165221026;
        Mon, 28 Oct 2024 18:27:01 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991b712sm37909626d6.59.2024.10.28.18.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:27:00 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:26:59 -0400
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
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <672039e3cec10_24dce629448@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241028110535.82999-15-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-15-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 14/14] bpf: add simple bpf tests in the tx
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
> 
> Only check if we pass those three key points after we enable the
> bpf extension for so_timestamping. During each point, we can choose
> whether to print the current timestamp.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  .../bpf/prog_tests/so_timestamping.c          |  98 ++++++++++++++
>  .../selftests/bpf/progs/so_timestamping.c     | 123 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/so_timestamping.c
>  create mode 100644 tools/testing/selftests/bpf/progs/so_timestamping.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/so_timestamping.c b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> new file mode 100644
> index 000000000000..dfb7588c246d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/so_timestamping.c
> @@ -0,0 +1,98 @@
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
> +	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
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
> index 000000000000..a15317951786
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/so_timestamping.c
> @@ -0,0 +1,123 @@
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
> +#define SO_TIMESTAMPING 37
> +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWARE | \
> +					      SOF_TIMESTAMPING_TX_SCHED | \
> +					      SOF_TIMESTAMPING_TX_SOFTWARE | \
> +					      SOF_TIMESTAMPING_TX_ACK | \
> +					      SOF_TIMESTAMPING_OPT_ID | \
> +					      SOF_TIMESTAMPING_OPT_ID_TCP)
> +
> +extern unsigned long CONFIG_HZ __kconfig;
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
> +	int expected;
> +};
> +
> +static const struct sockopt_test sol_socket_tests[] = {
> +	{ .opt = SO_TIMESTAMPING, .new = SOF_TIMESTAMPING_TX_SCHED, .expected = 256, },
> +	{ .opt = SO_TIMESTAMPING, .new = SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK, .expected = 66450, },
> +	{ .opt = 0, },
> +};
> +
> +struct loop_ctx {
> +	void *ctx;
> +	struct sock *sk;
> +};
> +
> +static int bpf_test_sockopt_int(void *ctx, struct sock *sk,
> +				const struct sockopt_test *t,
> +				int level)
> +{
> +	int tmp, new, expected, opt;
> +
> +	opt = t->opt;
> +	new = t->new;
> +	expected = t->expected;
> +
> +	if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> +		return 1;
> +	if (bpf_getsockopt(ctx, level, opt, &tmp, sizeof(tmp)) ||
> +	    tmp != expected)
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
> +	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> +		nr_passive += !bpf_test_sockopt(skops, sk);
> +		break;
> +	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
> +		nr_sched += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_SW_OPT_CB:
> +		nr_txsw += 1;
> +		break;
> +	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
> +		nr_ack += 1;
> +		break;

Perhaps demonstrate what to do with the args on the new 
TS_*_OPT_CB.

> +	}
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.37.3
> 



