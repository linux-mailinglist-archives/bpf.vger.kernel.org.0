Return-Path: <bpf+bounces-26576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3C8A1F73
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6451C22E07
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC43B182;
	Thu, 11 Apr 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+lXujML"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEB36AF3
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863415; cv=none; b=d4umk77uxxYiU11r+okuTn62swCKpbAChxczEyJkhukSkQYfoRNLeLfgCmzpPaSG/L8icZ6pmF3OKoH5rRy6azdRcAMrKtGxz3iyLCr8NpYkJsRUbeetkyn4BwErCm8egEsAjBB5tVRjuTkXQS6vbojUkOSH9eH4Rlu72mCEyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863415; c=relaxed/simple;
	bh=P4wCNLmtXPLsDqGfupgn4JTY+JEmagcCUnkDyIsmNW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBereLmjtl0BWsT2xdjMbSi/4PrE2bIEwl/EkPmxCFr4tFXYkGQ7b/bI752vgUbOPbSTiuHJ2lBQAIPXnE+kZYK8A3lsYTKSMHgJcIX2M0egvrtWGm8fLEm+eAPjmX/5nF2H/jLOM6qr+Ow8D2BNIzxg4NWgBj+osgN5Mfiwowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+lXujML; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0e2e9f2-9993-4c25-aace-f624986cf874@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712863410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaltdheOilOpkmrqvkPu9UV2s+iUUvoBTjYEuk47i1A=;
	b=C+lXujMLofgkOBT1Bmw6WrKHQAP9NBN26FRgHVCRdwAjwNAYRQ9mTH8HDljxR1NKbUE+97
	4u5f5WuMolcm+BLlGAM5BPZNzeg7cSZ9SMNFtUzVs0QyZbffX9UfgYSGOzvksd+4xjx7xB
	+cccVM9dHq4awF0UNyJFlUQATIsr+g4=
Date: Thu, 11 Apr 2024 12:23:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Export send_recv_data
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1712813933.git.tanggeliang@kylinos.cn>
 <5231103be91fadcce3674a589542c63b6a5eedd4.1712813933.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5231103be91fadcce3674a589542c63b6a5eedd4.1712813933.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 10:43 PM, Geliang Tang wrote:
> +static void *send_recv_server(void *arg)
> +{
> +	struct send_recv_arg *a = (struct send_recv_arg *)arg;
> +	ssize_t nr_sent = 0, bytes = 0;
> +	char batch[1500];
> +	int err = 0, fd;
> +
> +	fd = accept(a->fd, NULL, NULL);
> +	while (fd == -1) {
> +		if (errno == EINTR)
> +			continue;
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	if (settimeo(fd, 0)) {
> +		err = -errno;
> +		goto done;
> +	}
> +
> +	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
> +		nr_sent = send(fd, &batch,
> +			       MIN(a->bytes - bytes, sizeof(batch)), 0);
> +		if (nr_sent == -1 && errno == EINTR)
> +			continue;
> +		if (nr_sent == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_sent;
> +	}
> +
> +	if (bytes != a->bytes)
> +		log_err("Failed to send");

I logged the "bytes" and "a->bytes" here.

> +
> +done:
> +	if (fd >= 0)
> +		close(fd);
> +	if (err) {
> +		WRITE_ONCE(a->stop, 1);
> +		return ERR_PTR(err);
> +	}
> +	return NULL;
> +}
> +
> +int send_recv_data(int lfd, int fd, uint32_t total_bytes)
> +{
> +	ssize_t nr_recv = 0, bytes = 0;
> +	struct send_recv_arg arg = {
> +		.fd	= lfd,
> +		.bytes	= total_bytes,
> +		.stop	= 0,
> +	};
> +	pthread_t srv_thread;
> +	void *thread_ret;
> +	char batch[1500];
> +	int err = 0;
> +
> +	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
> +	if (err) {
> +		log_err("Failed to pthread_create");
> +		return err;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1) {
> +			err = -errno;
> +			break;
> +		}
> +		bytes += nr_recv;
> +	}
> +
> +	if (bytes != total_bytes)
> +		log_err("Failed to recv");

Same here.

> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	if (IS_ERR(thread_ret) && !err) {

Removed the "&& !err: check. The thread_ret error should always be logged.

Applied. Thanks.

> +		log_err("Failed to thread_ret");
> +		err = PTR_ERR(thread_ret);
> +	}
> +
> +	return err;
> +}


