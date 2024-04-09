Return-Path: <bpf+bounces-26245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79689D1A2
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A01E1C2433C
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532EA51C5E;
	Tue,  9 Apr 2024 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZiotKEF7"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44486657C1
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638393; cv=none; b=Pv1wyyp48mpsHa/upR1HsOwjyZ5N1wFsZkcw1M/828ngQUDF9BMPKfW1SZz9eqaZKqcSNYlVpbx0s6jqRFLWuu1HgMJRkK8JepAMtkCtuvgf55LqEZUaFtUyOrj53E+vnHTpLe7U9TjqVCrSSTGnh1fS3o061FtuqTkf6G4m1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638393; c=relaxed/simple;
	bh=1oTZmvkwv3wXG/y5j0mzf4wR2CGmFKwW7FC7GXOtIRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMjXFpCIfqHXDRwoHUirTP2tVYLc9ZeP6OSXTlLbPyJHUNoUi88UIQ1KGb0tJhVkFmNxzPUK8fXza6CEr7Qg36pVilg/ESIHEb9R0DPaKL8L7lFTYiwMoZXH/R/3bixRQV1WNZ6dtawHsvpZn3o23v+kAsw7ZsM9I7seP29k9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZiotKEF7; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4758d992-d57d-4bd9-bd72-b4be992ac08f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712638390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJTFwx9xrpvAVvP6SSAqtYIMzyfvzJqjB98FdK+W5qQ=;
	b=ZiotKEF7h+btJa20VoE3pafumJ2rGLyIuK/Nm/5KYKeDmaqetU5WiAqCBWo7Jh9n+BsLwH
	q6HRrcGIAq5JBqJK0LwGVDDlAv88A6W3sqXgl2fT89jp/nnVFUGybcS/R7KQWW/95VuZCO
	GB4+aCAQo5SQriiROMfrzCFVy2nF9Us=
Date: Mon, 8 Apr 2024 21:52:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Export send_recv_data
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <cover.1712547287.git.tanggeliang@kylinos.cn>
 <a8153ab2b82c8cd57aca2c6d44d5d327e8c7be92.1712547287.git.tanggeliang@kylinos.cn>
 <77aac1cb0234ec0b0f7a15bf0a2212789e6b63c2.camel@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <77aac1cb0234ec0b0f7a15bf0a2212789e6b63c2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/8/24 8:51 PM, Geliang Tang wrote:
>> +static void *send_recv_server(void *arg)
>> +{
>> +	struct send_recv_arg *a = (struct send_recv_arg *)arg;
>> +	ssize_t nr_sent = 0, bytes = 0;
>> +	char batch[1500];
>> +	int err = 0, fd;
>> +
>> +	fd = accept(a->fd, NULL, NULL);
>> +	while (fd == -1) {
>> +		if (errno == EINTR)
>> +			continue;
>> +		err = -errno;
>> +		goto done;
>> +	}
>> +
>> +	if (settimeo(fd, 0)) {
>> +		err = -errno;
>> +		goto done;
>> +	}
>> +
>> +	while (bytes < a->bytes && !READ_ONCE(a->stop)) {
>> +		nr_sent = send(fd, &batch,
>> +			       MIN(a->bytes - bytes, sizeof(batch)),
>> 0);
>> +		if (nr_sent == -1 && errno == EINTR)
>> +			continue;
>> +		if (nr_sent == -1) {
>> +			err = -errno;
>> +			break;
>> +		}
>> +		bytes += nr_sent;
>> +	}
>> +
>> +	ASSERT_EQ(bytes, a->bytes, "send");
>> +
>> +done:
>> +	if (fd >= 0)
>> +		close(fd);
>> +	if (err) {
>> +		WRITE_ONCE(a->stop, 1);
>> +		return ERR_PTR(err);
>> +	}
>> +	return NULL;
>> +}
>> +
>> +void send_recv_data(int lfd, int fd, uint32_t total_bytes)
>> +{
>> +	ssize_t nr_recv = 0, bytes = 0;
>> +	struct send_recv_arg arg = {
>> +		.fd	= lfd,
>> +		.bytes	= total_bytes,
>> +		.stop	= 0,
>> +	};
>> +	pthread_t srv_thread;
>> +	void *thread_ret;
>> +	char batch[1500];
>> +	int err;
>> +
>> +	err = pthread_create(&srv_thread, NULL, send_recv_server,
>> (void *)&arg);
>> +	if (!ASSERT_OK(err, "pthread_create"))
>> +		return;
>> +
>> +	/* recv total_bytes */
>> +	while (bytes < total_bytes && !READ_ONCE(arg.stop)) {
>> +		nr_recv = recv(fd, &batch,
>> +			       MIN(total_bytes - bytes,
>> sizeof(batch)), 0);
>> +		if (nr_recv == -1 && errno == EINTR)
>> +			continue;
>> +		if (nr_recv == -1)
>> +			break;
>> +		bytes += nr_recv;
>> +	}
>> +
>> +	ASSERT_EQ(bytes, total_bytes, "recv");
> I think we should avoid using ASSERT_* in network_helpers.c, but I'm
> not sure. What do you think?

There is log_err which is used by other helpers in network_helpers.c. May be use 
log_err instead and return int instead of void here. The caller can decide if it 
expects error or not and uses ASSERT accordingly.

pw-bot: cr


