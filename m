Return-Path: <bpf+bounces-48493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC5A083CA
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FA016801B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DECC2107;
	Fri, 10 Jan 2025 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4UNZoYb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBED621
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467530; cv=none; b=cTi20YCvFNIO9k6C2rTD42i478W/HodRG5vDYwS1mH0jY7HVPK/Mu5oV8H2dmx724Ac5p26gFZapdJyyTv71fm84rg4P7NhpqspcMI8iAP9z3oYtPdy9E40wbo5716TbDlyNEp3COCJv7vqnP+n4C/GPbLUKoel4TjHsksUQU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467530; c=relaxed/simple;
	bh=cPb91kdKltJuHbzmH4Nyi7r+xtbsyr+G0tlSic8XaUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMXfq4k0YqFHswYmXQHARssd674+LYEyM2gqiNoh/lEmKbH+3/QdF215JGKY7LgxDf+at4B6tIPdsRiYIKeGv1sQkOiRiBPBbyrOWy0BgXRwvsd18oyD9xbBp/YsGoq6AJGqyoMeWE3gNHEitMw0F3UxjabCvovlRMpCvKB55Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4UNZoYb; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <88e9291e-cd67-4fa2-8a91-d475e29ab832@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736467526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kMqH7y65kuer8GqW8vK5M8fKsAcphbaVfUJaBITA9s=;
	b=X4UNZoYbSBd6ifQRKhE/vi6qwzU++fObglY8WfQskkSPpblFMk6P2FyewCPdqC5I5rvSlL
	xm4YqA+KUlQBNAo1qW+Pan+qr9i4bI1gTz4ynqOhD0xQUXCfpBOG/6NbXRtZsMB1tQoo3g
	nb4mO6onb3xH0+Y2NqdZuCJEl2o882M=
Date: Thu, 9 Jan 2025 16:05:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 13/14] selftests: Add a basic fifo qdisc test
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org,
 sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-14-amery.hung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241220195619.2022866-14-amery.hung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/24 11:55 AM, Amery Hung wrote:
> +static void do_test(char *qdisc)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
> +			    .attach_point = BPF_TC_QDISC,
> +			    .parent = TC_H_ROOT,
> +			    .handle = 0x8000000,
> +			    .qdisc = qdisc);
> +	struct sockaddr_in6 sa6 = {};
> +	ssize_t nr_recv = 0, bytes = 0;
> +	int lfd = -1, fd = -1;
> +	pthread_t srv_thread;
> +	socklen_t addrlen = sizeof(sa6);
> +	void *thread_ret;
> +	char batch[1500];
> +	int err;
> +
> +	WRITE_ONCE(stop, 0);
> +
> +	err = bpf_tc_hook_create(&hook);
> +	if (!ASSERT_OK(err, "attach qdisc"))
> +		return;
> +
> +	lfd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_NEQ(lfd, -1, "socket")) {

nit. ASSERT_OK_FD.

> +		bpf_tc_hook_destroy(&hook);
> +		return;
> +	}
> +
> +	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (!ASSERT_NEQ(fd, -1, "socket")) {
> +		bpf_tc_hook_destroy(&hook);
> +		close(lfd);
> +		return;
> +	}
> +
> +	if (settimeo(lfd, 0) || settimeo(fd, 0))
> +		goto done;
> +
> +	err = getsockname(lfd, (struct sockaddr *)&sa6, &addrlen);
> +	if (!ASSERT_NEQ(err, -1, "getsockname"))
> +		goto done;
> +
> +	/* connect to server */
> +	err = connect(fd, (struct sockaddr *)&sa6, addrlen);

Instead of socket/getsockname/connect, "fd = connect_to_fd(lfd);" from the 
network_helpers.c should do.

The above settimeo({lfd,fd}) is not needed also. The helpers from 
network_helpers.c should have already set the default timeout.

> +	if (!ASSERT_NEQ(err, -1, "connect"))
> +		goto done;
> +
> +	err = pthread_create(&srv_thread, NULL, server, (void *)(long)lfd);
> +	if (!ASSERT_OK(err, "pthread_create"))
> +		goto done;
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1)
> +			break;
> +		bytes += nr_recv;
> +	}
> +
> +	ASSERT_EQ(bytes, total_bytes, "recv");
> +
> +	WRITE_ONCE(stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	ASSERT_OK(IS_ERR(thread_ret), "thread_ret");
> +
> +done:
> +	close(lfd);
> +	close(fd);
> +
> +	bpf_tc_hook_destroy(&hook);
> +	return;
> +}
> +
> +static void test_fifo(void)
> +{
> +	struct bpf_qdisc_fifo *fifo_skel;
> +	struct bpf_link *link;
> +
> +	fifo_skel = bpf_qdisc_fifo__open_and_load();
> +	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		bpf_qdisc_fifo__destroy(fifo_skel);
> +		return;
> +	}
> +
> +	do_test("bpf_fifo");
> +
> +	bpf_link__destroy(link);
> +	bpf_qdisc_fifo__destroy(fifo_skel);
> +}
> +
> +void test_bpf_qdisc(void)
> +{

Run the whole test under its own netns. Use netns_new("bpf_qdisc_ns", true) from 
the test_progs.c should do.

> +	if (test__start_subtest("fifo"))
> +		test_fifo();
> +}

