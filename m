Return-Path: <bpf+bounces-60130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00026AD2B5D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 03:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCC53AC587
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE001A239A;
	Tue, 10 Jun 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzKSPaih"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20B10A3E
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749519123; cv=none; b=kwWXeLUTkr1Hm3NVaDIJHDFTEJvcgFBVSWZvRmFcRef+25rOlx2GV9RWev4g5fXUHqFWFJFeFnsnLG2mQgqqNHKynpBA+RCLSU//NdA6Pt44W31awFn81ltGkaRtGmZlsNFqYoB3HyE1Qt1yUSNfLLlcQib1stCcf/auhAvAJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749519123; c=relaxed/simple;
	bh=15GEsVd2UM5CG42FclNCfNLcYdqLEKKFMwGeQhKHXX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKbEtdgGmu9KTsjesxBqGkuUA5hqy/XKJcgnZ2ulZkqHR2+P6LLQr6qBRh2jZOmm2NJmWGNrbqgGi/cT92XLqZ/sA3DKLW5aP4b9ZJ2OKnTJawwZPhMJq5TEnjhpkYKJGvAJLxtj6lKdfy2oWOmzJF1IvPCKhMXgjHE7ZsOYAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzKSPaih; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d9db233-05de-4cbd-bd80-e61cb7151f0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749519119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEjPCgYfqw1uH3oZV/OL5nkFnepTcLT5IhrI4/9SsTk=;
	b=wzKSPaihDI2OF6Quk74eol7yPeTtsHjZzYs2NGxbDHdqE+FCK5EyHrjWZPqra4J7aa7Sr+
	cOeGncvYWSwhkJICTkp+YpMbummFGVGw5a2Z49+J7ot0Gu4e1tmUag++3kmisaZ8VFQ26d
	d2p+g86462XkfVNTzBq05BZ6rtKvGyg=
Date: Mon, 9 Jun 2025 18:31:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an issue in bpf_prog_test_run_xdp
 when page size greater than 4K
Content-Language: en-GB
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250608165534.1019914-1-yonghong.song@linux.dev>
 <aEdj7n6e1Pb0WSBP@mini-arch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aEdj7n6e1Pb0WSBP@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/25 3:45 PM, Stanislav Fomichev wrote:
> On 06/08, Yonghong Song wrote:
>> The bpf selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow failed on
>> arm64 with 64KB page:
>>     xdp_adjust_tail/xdp_adjust_frags_tail_grow:FAIL
>>
>> In bpf_prog_test_run_xdp(), the xdp->frame_sz is set to 4K, but later on
>> when constructing frags, with 64K page size, the frag data_len could
>> be more than 4K. This will cause problems in bpf_xdp_frags_increase_tail().
>>
>> Limiting the data_len to be 4K for each frag fixed the above test failure.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   net/bpf/test_run.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index aaf13a7d58ed..5529ec007954 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -1214,6 +1214,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   	u32 repeat = kattr->test.repeat;
>>   	struct netdev_rx_queue *rxqueue;
>>   	struct skb_shared_info *sinfo;
>> +	const u32 frame_sz = 4096;
>>   	struct xdp_buff xdp = {};
>>   	int i, ret = -EINVAL;
>>   	struct xdp_md *ctx;
>> @@ -1255,7 +1256,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   		headroom -= ctx->data;
>>   	}
>>   
> [..]
>
>> -	max_data_sz = 4096 - headroom - tailroom;
>> +	max_data_sz = frame_sz - headroom - tailroom;
> I wonder whether we should do s/4096/PAGE_SIZE/ here instead. Have you
> tried that? If we are on a 64K page arch, we should not try to preserve
> 4K page limits.

The user space test_run input looks like below (in prog_tests/xdp_adjust_tail.c):

	buf = malloc(16384);
	...
	topts.data_in = buf;
	topts.data_out = buf;
	topts.data_size_in = 9000;
	topts.data_size_out = 16384;
	err = bpf_prog_test_run_opts(prog_fd, &topts);

Allowing s/4096/PAGE_SIZE (64K) will have the test failure for the above
user space input. I think I can increse buf size data_size_in/data_size_out
properly so in the kernel we can do s/4096/PAGE_SIZE.


