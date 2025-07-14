Return-Path: <bpf+bounces-63269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12452B04AA9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE5B4A2C69
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604127C154;
	Mon, 14 Jul 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ffCpTw+i"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2B2777F1
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532170; cv=none; b=rubOvCPaUrUaUM0QrF4EKVEKfUFmNwUsayCCb0B9EBh0mnIZkd+7z5SdjDIixY9KqSFDUZ5Vt2f+VJvW3vSWtPI1eA4yU6qFxz7OfUVKW8B1Zg/BtT+zWqaXq/0cI3z8O8tIzOh+HbLou2xtDOla+3o+1tYPWHS+/xm0vK9Y0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532170; c=relaxed/simple;
	bh=pJnm9Oj99nS8XPVmx+Sv6KI3a8fGfJkUedosPujfQ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxvgnJGwMHSd3gPIPSTDa7eSVwa73NxHXXMEbyWYzZgzo6hCu2NWML/hrz3/rVYcR1y3oRz37rUDJSRSFhWT0abu95PEi3ErOVqrlOwoVeYSpNngG57/jvAV+4EYNsSemILYc/7+JzN1tAHsbLgX8/c0tXIhylgt19pJjRx0wmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ffCpTw+i; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d109f0de-c857-46f6-9560-a7bd93b59bef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752532155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0LwTTo9xIG1xQG6uvghVnGDmMDc4C6/jvkxhw5/uY0=;
	b=ffCpTw+ialmLq8C2vkn6EWsLUKW/RqvNggj3D6DXHng+/3Mcrf3N9S/wGJBpJlHlpJ948g
	bWF+uJIVAZaH1Sf8gEdbiOWd0uJQR9Tz7O4Ufa9PG8daB57/ZwIGn/ClKpj6u8YW4roc5M
	Jx70NECbzv5qh58cNHW+SfjUKKTo5b0=
Date: Mon, 14 Jul 2025 15:29:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 10/12] selftests/bpf: Create established
 sockets in socket iterator tests
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250714180919.127192-1-jordan@jrife.io>
 <20250714180919.127192-11-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250714180919.127192-11-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/14/25 11:09 AM, Jordan Rife wrote:
> +static int *connect_to_server(int family, int sock_type, const char *addr,
> +			      __u16 port, int nr_connects, int *server_fds,
> +			      int server_fds_len)
> +{
> +	struct pollfd *server_poll_fds = NULL;
> +	struct network_helper_opts opts = {

A nit. I removed "opts" and just passed NULL to connect_to_addr_str.

I also carried Stan's ack from v4. Applied. Thanks.

> +		.timeout_ms = 0,
> +	};
> +	int *established_socks = NULL;
> +	int i;
> +
> +	server_poll_fds = calloc(server_fds_len, sizeof(*server_poll_fds));
> +	if (!ASSERT_OK_PTR(server_poll_fds, "server_poll_fds"))
> +		return NULL;
> +
> +	for (i = 0; i < server_fds_len; i++) {
> +		server_poll_fds[i].fd = server_fds[i];
> +		server_poll_fds[i].events = POLLIN;
> +	}
> +
> +	i = 0;
> +
> +	established_socks = malloc(sizeof(*established_socks) * nr_connects*2);
> +	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
> +		goto error;
> +
> +	while (nr_connects--) {
> +		established_socks[i] = connect_to_addr_str(family, sock_type,
> +							   addr, port, &opts);
> +		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
> +			goto error;
> +		i++;
> +		established_socks[i] = accept_from_one(server_poll_fds,
> +						       server_fds_len);
> +		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
> +			goto error;
> +		i++;
> +	}
> +
> +	free(server_poll_fds);
> +	return established_socks;
> +error:
> +	free_fds(established_socks, i);
> +	free(server_poll_fds);
> +	return NULL;
> +}


