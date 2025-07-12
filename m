Return-Path: <bpf+bounces-63099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB7EB0283D
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3974A55DD
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACC1805B;
	Sat, 12 Jul 2025 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZcxmEVjm"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D78A945
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 00:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752279805; cv=none; b=emw35k5+QM2jfA8Fx9bVB85E4011eUpy0Fz2sO6ItvXRgvhbdch2O1jeODcDolxpFtJZzZ38ZOP5u16T0Rp/eJCLTDM+gc8PjjlbbcybWlTNZPyk6uSl5jbaKHUwXfH0HXowfi/Fm51mUGROamAaZJMPqfR/gffjDhrpkHQWnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752279805; c=relaxed/simple;
	bh=uQTm1LG86uMk297LYMdWRW7WqXNvMrl/Y6KgC130zF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqL4+JDVJqQoXLjAHgSgt9yylH54xzc5Uj7Hu/d1gw0UJ+PEVOVlkUOb9nEOuqx/QK0BxZPs+9vD/tfxFFhE0aIhAxqY8GHLuFkZBKgw0fTQbxKN5y6UzQluuhs0nHclPdctE8gAP7pekq+wNKy4YHIoIYLC0IPPGC/Q8xTYP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZcxmEVjm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c66f688-988f-4f55-a822-de5686178b1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752279799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV3Q6zQlbxZ47PhQT6BykyiRHOIN3lHCKTsD93l8X5k=;
	b=ZcxmEVjme3OODqmbIpKekmtZ4EBEZ5hzrbtqTa6yk9dv+eGJNno8GwOTPzrLa1mvewCBCv
	avnMyoyD7mD7YtD0jUmmR9c6SoBuVmaRKjV2iahXn+Hp4BIcQX1MejSwmotqbRMqphuKNm
	SfB/pndpkE9qfUuHwuI2kmzaWnvANRE=
Date: Fri, 11 Jul 2025 17:23:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250709230333.926222-1-jordan@jrife.io>
 <20250709230333.926222-11-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250709230333.926222-11-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/25 4:03 PM, Jordan Rife wrote:
>   
> +static int accept_from_one(int *server_fds, int server_fds_len)
> +{
> +	int fd;
> +	int i;
> +
> +	for (i = 0; i < server_fds_len; i++) {
> +		fd = accept(server_fds[i], NULL, NULL);
> +		if (fd >= 0)
> +			return fd;
> +		if (!ASSERT_EQ(errno, EWOULDBLOCK, "EWOULDBLOCK"))
> +			return -1;
> +	}
> +
> +	return -1;

After looking at the set again before landing, I suspect there is a chance that 
this function may return -1 here if the final ack of the 3WHS has not been 
received yet.

> +}
> +
> +static int *connect_to_server(int family, int sock_type, const char *addr,
> +			      __u16 port, int nr_connects, int *server_fds,
> +			      int server_fds_len)
> +{
> +	struct network_helper_opts opts = {
> +		.timeout_ms = 0,
> +	};
> +	int *established_socks;
> +	int i;
> +
> +	/* Make sure accept() doesn't block. */
> +	for (i = 0; i < server_fds_len; i++)
> +		if (!ASSERT_OK(fcntl(server_fds[i], F_SETFL, O_NONBLOCK),
> +			       "fcntl(O_NONBLOCK)"))

server_fds is non-blocking.

> +			return NULL;
> +
> +	established_socks = malloc(sizeof(int) * nr_connects*2);
> +	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
> +		return NULL;
> +
> +	i = 0;
> +
> +	while (nr_connects--) {
> +		established_socks[i] = connect_to_addr_str(family, sock_type,
> +							   addr, port, &opts);

connect returns as soon as the syn-ack is received.

> +		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
> +			goto error;
> +		i++;
> +		established_socks[i] = accept_from_one(server_fds,
> +						       server_fds_len);

I am not sure the final ack is always received by the server at this point. If 
not, the test could be flaky. Is this case possible? and is it better to 
poll/select for a fixed number of seconds?

> +		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
> +			goto error;
> +		i++;
> +	}
> +
> +	return established_socks;
> +error:
> +	free_fds(established_socks, i);
> +	return NULL;
> +}


