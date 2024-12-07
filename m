Return-Path: <bpf+bounces-46346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECED9E7DB0
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 02:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C8828463D
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D107BE4F;
	Sat,  7 Dec 2024 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTFOpAdc"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214B33DF
	for <bpf@vger.kernel.org>; Sat,  7 Dec 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534399; cv=none; b=t8hwsFFMWMLj77zyN9hBBLGsk/4kTL0RbryiHFkuLlN2mkkSifR9uGtJNcrKoA5G4OVQdYVCY63GuwC1OEpPCsYyf/Qdkj7p4W8skW732K3gxju0gq278321QxztDTn/O2H5C7esBzngTwLVTxgM8LDJv6/xNMGnzaqCzRszKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534399; c=relaxed/simple;
	bh=ZukOdbFvqasZZ3raYS3UoqCZujhq4RIJwfsY74HV72Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B65zu4DbVxUjGI9IWfIOwTq3ptqcAffek2BrqA6WuUDu5tKelWC9MC+op+sfkmgkAYZNDBfvVMLO/lrEjq5qHui9HdNL4p9n9ahslzluCY+izPs6DBzxd7hNrL3QGbQblV/OCnnsRf1QTuzITZi5NzkGdc+yG/Y5d76OwFy04bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTFOpAdc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9c9074c1-a079-42aa-b1c0-a3fd5523e9f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733534385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uNOUD5sUn4ce0l5tkusY9QEAAd1axiX1bAYXIZx728=;
	b=bTFOpAdc9qgYckcfW/FXYYyH0X8YZcu0ITbbplcG7JaVg2gPW0uslJuCuWpcUgTvZWMqEc
	1eNy5B9s9OltQEWkZ0kgF3FU5RIddwMumVreSENBbJD/1WE490ANBlYlSaVuyMT4Yxk02/
	BDpmAzWqW4LkPK/y8atgPByoS0q9rVY=
Date: Fri, 6 Dec 2024 17:19:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Migrate test_xdp_meta.sh into
 xdp_context_test_run.c
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241206-xdp_meta-v1-0-5c150618f6e9@bootlin.com>
 <20241206-xdp_meta-v1-2-5c150618f6e9@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241206-xdp_meta-v1-2-5c150618f6e9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/6/24 12:12 AM, Bastien Curutchet wrote:
> +void test_xdp_context_functional(void)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
> +	struct bpf_program *tc_prog, *xdp_prog;
> +	struct netns_obj *rx_ns, *tx_ns;
> +	struct test_xdp_meta *skel;
> +	struct nstoken *nstoken;
> +	int rx_ifindex;
> +	int ret;
> +
> +	tx_ns = netns_new(TX_NETNS, false);
> +	if (!ASSERT_OK_PTR(tx_ns, "create tx_ns"))
> +		return;
> +
> +	rx_ns = netns_new(RX_NETNS, false);
> +	if (!ASSERT_OK_PTR(rx_ns, "create rx_ns"))
> +		goto free_txns;
> +
> +	SYS(free_rxns, "ip link add " RX_NAME " netns " RX_NETNS
> +	    " type veth peer name " TX_NAME " netns " TX_NETNS);
> +
> +	nstoken = open_netns(RX_NETNS);

close_netns(nstoken) is needed.

> +	if (!ASSERT_OK_PTR(nstoken, "setns rx_ns"))
> +		goto free_rxns;
> +
> +	SYS(free_rxns, "ip addr add " RX_ADDR "/24 dev " RX_NAME);
> +	SYS(free_rxns, "ip link set dev " RX_NAME " up");
> +
> +	skel = test_xdp_meta__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
> +		goto free_rxns;
> +
> +	rx_ifindex = if_nametoindex(RX_NAME);
> +	if (!ASSERT_GE(rx_ifindex, 0, "if_nametoindex rx"))
> +		goto destroy_skel;
> +
> +	tc_hook.ifindex = rx_ifindex;
> +	ret = bpf_tc_hook_create(&tc_hook);
> +	if (!ASSERT_OK(ret, "bpf_tc_hook_create"))
> +		goto destroy_skel;
> +
> +	tc_prog = bpf_object__find_program_by_name(skel->obj, "ing_cls");
> +	if (!ASSERT_OK_PTR(tc_prog, "open ing_cls prog"))
> +		goto destroy_skel;
> +
> +	tc_opts.prog_fd = bpf_program__fd(tc_prog);
> +	ret = bpf_tc_attach(&tc_hook, &tc_opts);
> +	if (!ASSERT_OK(ret, "bpf_tc_attach"))
> +		goto destroy_skel;
> +
> +	xdp_prog = bpf_object__find_program_by_name(skel->obj, "ing_xdp");
> +	if (!ASSERT_OK_PTR(xdp_prog, "open ing_xdp prog"))
> +		goto destroy_skel;
> +
> +	ret = bpf_xdp_attach(rx_ifindex,
> +			     bpf_program__fd(xdp_prog),
> +			     0, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto destroy_skel;
> +
> +	nstoken = open_netns(TX_NETNS);

Same here.

pw-bot: cr

> +	if (!ASSERT_OK_PTR(nstoken, "setns tx_ns"))
> +		goto destroy_skel;
> +
> +	SYS(destroy_skel, "ip addr add " TX_ADDR "/24 dev " TX_NAME);
> +	SYS(destroy_skel, "ip link set dev " TX_NAME " up");
> +	SYS(destroy_skel, "ping -c 1 " RX_ADDR);
> +
> +destroy_skel:
> +	test_xdp_meta__destroy(skel);
> +free_rxns:
> +	netns_free(rx_ns);
> +free_txns:

nit. test_xdp_meta__destroy, netns_free, and the to-be-added close_netns can 
handle NULL. Init the variables to NULL at the beginning could save a few goto 
labels, probably only one label is needed.

> +	netns_free(tx_ns);
> +}

