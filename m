Return-Path: <bpf+bounces-64575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DFB145B1
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3EB16A462
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444421D61A3;
	Tue, 29 Jul 2025 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWElieQg"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D21D5174
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751913; cv=none; b=T4yU5NsJIl7+qTLjJ2KDneHKwt4sgC1ILTYwMo09rJKQpOjOTgq4qxjXUBoocN40DWql/4+3qwJYsirv9Tp2jI6DFHgo+zFniIeAt5x3RFugq5JDNTVU0h9ygM371WlxZUQJ44m5zFs2yvvGuOekNtN5IVJxrJDrzd++xj7IX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751913; c=relaxed/simple;
	bh=Pw/EtVigOD+NLcjlMHwzQNt9j9ty2toqqs4UfYC1wN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yoe54o5qP9pkCNclLmDFEeiQUmGYB0PnQd95/vVRJtNQ9ELKhHNkehNyT1sZY2PSe4IWryEoSHkDXNh2CYDNC9gubQgbd2l1ZYBlmBwoLr6Un1t1mU0V3QfTAUHaV18/o5MpcS30JS8IM3jNT0DxaGNzSmtEIE9jXKU7f8xY97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWElieQg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <382ff228-704c-4e0c-9df3-2eb178adcba8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753751909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJl/TYfMZeObqkgjHJt86L4qFGf+eUl3AOofZqTZKuY=;
	b=iWElieQgLcGuH9OhD52M1reMM8pgtCPFp+0nQ58OPZ9Yj2F7E17JRjIJM3vvmVwOINmIZl
	hXnyo/gG1PyZ858Zz/45zxOT2SfWg+ykFAZrqMAvtiQpSG58MVJ0YEWj7qJtHYsMARQjVX
	4MImnwIgKch3c5l1di+eFEjqdOMr6no=
Date: Mon, 28 Jul 2025 18:18:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: add icmp_send_unreach
 kfunc tests
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-5-mahe.tardy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250728094345.46132-5-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/28/25 2:43 AM, Mahe Tardy wrote:
> +SEC("cgroup_skb/egress")
> +int egress(struct __sk_buff *skb)
> +{
> +	void *data = (void *)(long)skb->data;
> +	void *data_end = (void *)(long)skb->data_end;
> +	struct iphdr *iph;
> +	struct tcphdr *tcph;
> +
> +	iph = data;
> +	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
> +	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
> +		return SK_PASS;
> +
> +	tcph = (void *)iph + iph->ihl * 4;
> +	if ((void *)(tcph + 1) > data_end ||
> +	    tcph->dest != bpf_htons(SERVER_PORT))
> +		return SK_PASS;
> +
> +	kfunc_ret = bpf_icmp_send_unreach(skb, unreach_code);
> +
> +	/* returns SK_PASS to execute the test case quicker */

Do you know why the user space is slower if 0 (SK_DROP) is used?

> +	return SK_PASS;



