Return-Path: <bpf+bounces-34161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4D92AC20
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A6F1F224D0
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56F14F9E9;
	Mon,  8 Jul 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iYcy6ScT"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3F44C64
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478063; cv=none; b=Q4q5Jp9v09B/3wXfIl/nEoRv0zYjL1Fzra/qbg3UHBWIOTpYnml7cYTHylUEPE7ZenipStV2d76LuYlinoOGIMlPesackT9iaovlyMYRNLFC3OQ4+9I/a1PtP1ehSio9b6+LNwyG0kacjNqpA2kqQJ+kYNcDTaKDZhilGYWKURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478063; c=relaxed/simple;
	bh=z8gMdbTCowmxk1H1MU0G+KndV8b2TAZ0jfuCPxAn8jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3ji8uX9s9TiPSxaN0yIn+vfXaX1C0XkdIYC5WR9ZE+HVdqBTce0DOQvfnnBuEhckCOahnSrvjbKZqoWgqaMQX6x4qLyo7XNLQ7FIFToz5t+MUy4F6gbacZhj63dmDGbmkrHnZa0XTttmnvoP1Dd9oVXveisAkT2cNgZUAD+vFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iYcy6ScT; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720478059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJPAJl7oBWCtDHQv5Gagq9Q10p/PppSqJnm8vp0oxNQ=;
	b=iYcy6ScTc0BoFsR3/yf+Bw7zdR+tqlxc24vI96++4wURyr1lQOfLlQXavZ0361HJ4h1USy
	qrQeKv6Cl7OFS/vcW+PMnnlqrYi3XkZkEkf7VvoFoUEIyFRA2sLcn38AADGkk+LOAvACwp
	ye0FOWcfMzHlsEJtTa/cTeZA3II10+w=
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <5434fdfe-e57b-479e-9fdd-0557ef74426b@linux.dev>
Date: Mon, 8 Jul 2024 15:34:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Extend tcx tests to cover late
 tcx_entry release
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240708133130.11609-1-daniel@iogearbox.net>
 <20240708133130.11609-2-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240708133130.11609-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/24 6:31 AM, Daniel Borkmann wrote:
> Add a test case which replaces an active ingress qdisc while keeping the
> miniq in-tact during the transition period to the new clsact qdisc.

Thanks for the explanation in patch 1 fix and the test. Applied.

> 
>    # ./vmtest.sh -- ./test_progs -t tc_link
>    [...]
>    ./test_progs -t tc_link
>    [    3.412871] bpf_testmod: loading out-of-tree module taints kernel.
>    [    3.413343] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>    #332     tc_links_after:OK
>    #333     tc_links_append:OK
>    #334     tc_links_basic:OK
>    #335     tc_links_before:OK
>    #336     tc_links_chain_classic:OK
>    #337     tc_links_chain_mixed:OK
>    #338     tc_links_dev_chain0:OK
>    #339     tc_links_dev_cleanup:OK
>    #340     tc_links_dev_mixed:OK
>    #341     tc_links_ingress:OK
>    #342     tc_links_invalid:OK
>    #343     tc_links_prepend:OK
>    #344     tc_links_replace:OK
>    #345     tc_links_revision:OK
>    Summary: 14/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>   tools/testing/selftests/bpf/config            |  3 +
>   .../selftests/bpf/prog_tests/tc_links.c       | 61 +++++++++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index c0ef168eb637..c95f6f1ab74a 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -61,9 +61,12 @@ CONFIG_MPLS=y
>   CONFIG_MPLS_IPTUNNEL=y
>   CONFIG_MPLS_ROUTING=y
>   CONFIG_MPTCP=y
> +CONFIG_NET_ACT_SKBMOD=y
> +CONFIG_NET_CLS=y
>   CONFIG_NET_CLS_ACT=y
>   CONFIG_NET_CLS_BPF=y
>   CONFIG_NET_CLS_FLOWER=y
> +CONFIG_NET_CLS_MATCHALL=y
>   CONFIG_NET_FOU=y
>   CONFIG_NET_FOU_IP_TUNNELS=y
>   CONFIG_NET_IPGRE=y
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_links.c b/tools/testing/selftests/bpf/prog_tests/tc_links.c
> index bc9841144685..1af9ec1149aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_links.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_links.c
> @@ -9,6 +9,8 @@
>   #define ping_cmd "ping -q -c1 -w1 127.0.0.1 > /dev/null"
>   
>   #include "test_tc_link.skel.h"
> +
> +#include "netlink_helpers.h"
>   #include "tc_helpers.h"
>   
>   void serial_test_tc_links_basic(void)
> @@ -1787,6 +1789,65 @@ void serial_test_tc_links_ingress(void)
>   	test_tc_links_ingress(BPF_TCX_INGRESS, false, false);
>   }
>   
> +struct qdisc_req {
> +	struct nlmsghdr  n;
> +	struct tcmsg     t;
> +	char             buf[1024];
> +};
> +
> +static int qdisc_replace(int ifindex, const char *kind, bool block)
> +{
> +	struct rtnl_handle rth = { .fd = -1 };
> +	struct qdisc_req req;
> +	int err;
> +
> +	err = rtnl_open(&rth, 0);
> +	if (!ASSERT_OK(err, "open_rtnetlink"))
> +		return err;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct tcmsg));
> +	req.n.nlmsg_flags = NLM_F_CREATE | NLM_F_REPLACE | NLM_F_REQUEST;
> +	req.n.nlmsg_type = RTM_NEWQDISC;
> +	req.t.tcm_family = AF_UNSPEC;
> +	req.t.tcm_ifindex = ifindex;
> +	req.t.tcm_parent = 0xfffffff1;
> +
> +	addattr_l(&req.n, sizeof(req), TCA_KIND, kind, strlen(kind) + 1);
> +	if (block)
> +		addattr32(&req.n, sizeof(req), TCA_INGRESS_BLOCK, 1);
> +
> +	err = rtnl_talk(&rth, &req.n, NULL);
> +	ASSERT_OK(err, "talk_rtnetlink");
> +	rtnl_close(&rth);
> +	return err;
> +}
> +
> +void serial_test_tc_links_dev_chain0(void)
> +{
> +	int err, ifindex;
> +
> +	ASSERT_OK(system("ip link add dev foo type veth peer name bar"), "add veth");
> +	ifindex = if_nametoindex("foo");
> +	ASSERT_NEQ(ifindex, 0, "non_zero_ifindex");
> +	err = qdisc_replace(ifindex, "ingress", true);
> +	if (!ASSERT_OK(err, "attaching ingress"))
> +		goto cleanup;
> +	ASSERT_OK(system("tc filter add block 1 matchall action skbmod swap mac"), "add block");
> +	err = qdisc_replace(ifindex, "clsact", false);
> +	if (!ASSERT_OK(err, "attaching clsact"))
> +		goto cleanup;
> +	/* Heuristic: kern_sync_rcu() alone does not work; a wait-time of ~5s
> +	 * triggered the issue without the fix reliably 100% of the time.
> +	 */
> +	sleep(5);

It may be handy to be able to trigger rcu_barrier() to wait for the pending rcu 
callbacks to finish. Not sure if there is an existing way to do that without 
introducing a kfunc in bpf_testmod. Probably something to think about as an 
optimization.

Thanks for the fix and the test. Applied.


> +	ASSERT_OK(system("tc filter add dev foo ingress matchall action skbmod swap mac"), "add filter");
> +cleanup:
> +	ASSERT_OK(system("ip link del dev foo"), "del veth");
> +	ASSERT_EQ(if_nametoindex("foo"), 0, "foo removed");
> +	ASSERT_EQ(if_nametoindex("bar"), 0, "bar removed");
> +}
> +
>   static void test_tc_links_dev_mixed(int target)
>   {
>   	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);


