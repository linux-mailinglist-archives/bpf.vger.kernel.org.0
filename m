Return-Path: <bpf+bounces-26455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4F8A01DC
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7A8B237A4
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BD1836CF;
	Wed, 10 Apr 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ohAS6a+1"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066E17BB2F
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784014; cv=none; b=FngUmGV7ze9+5rLhuGOBfqT6Q946lzKSgu6Rar8Tk7M5lG8wYVibDSDSFXdEC/KTKfR4rNlpkgVubopUyDjNs4lPbuVLHg1u+hx5nPuqifGfK/xrvvPHpQPq64Lx8YqNiU/9YO2+0gGgski2i8jK45OOYNubVGWB3UNYHDAF7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784014; c=relaxed/simple;
	bh=REkXgz1nvwfSQazm/q64YEAox4iA/CcshWlq42TMmc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofLtXF0cwWXy/NlMgwfntWh8kQwngGngX5Onqmqc1uFxsg9scN/0aMBeZZx6Q/NS6CzV9uC7JEYCqfbH25hW/r+Wg6LX3HOREFsGsmk0pioo6F+YqqyhsSURRIl30dXFH3mIjm6ViYyQ9wzi371WHfokGz19MaYhy5Y+X4J9Tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ohAS6a+1; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d914a95-0d79-44fb-96b8-ca0b34744455@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712784011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFQHL0dbndzxsL9DsXyf/uU+3MLrYDNeJdtA9F0MJys=;
	b=ohAS6a+1M9mFM0RnUX4olxNOHfqJU7uA3IjuWaWUNF88vOwQ3OHmP/ACXg+9NgmaGPs6gu
	V1tVKceAKEPvcHWbXFnycV1edhmje+syhvwLwYv1RjiooZKRQXvNuJ7Z4w76zK9z99yiHN
	8wIqWdfx8whlYsUOk+lhdmUaloous4o=
Date: Wed, 10 Apr 2024 14:20:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Export send_recv_data
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
 <a5cfd3271d91756deca82fafbc41f17819b6e67a.1712729342.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <a5cfd3271d91756deca82fafbc41f17819b6e67a.1712729342.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/9/24 11:13 PM, Geliang Tang wrote:
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
> +	int err;
> +
> +	err = pthread_create(&srv_thread, NULL, send_recv_server, (void *)&arg);
> +	if (err) {
> +		log_err("pthread_create");
> +		return err;
> +	}
> +
> +	/* recv total_bytes */
> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
> +		nr_recv = recv(fd, &batch,
> +			       MIN(total_bytes - bytes, sizeof(batch)), 0);
> +		if (nr_recv == -1 && errno == EINTR)
> +			continue;
> +		if (nr_recv == -1)
> +			break;
> +		bytes += nr_recv;
> +	}
> +
> +	if (bytes != total_bytes) {
> +		log_err("recv");
> +		return -1;

This is still not right. It needs to write arg.stop and do pthread_join().

pw-bot: cr

> +	}
> +
> +	WRITE_ONCE(arg.stop, 1);
> +	pthread_join(srv_thread, &thread_ret);
> +	if (IS_ERR(thread_ret)) {
> +		log_err("thread_ret");
> +		return -1;
> +	}
> +
> +	return 0;
> +}


