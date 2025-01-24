Return-Path: <bpf+bounces-49704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770EBA1BCD5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA93A3555
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3E2248B0;
	Fri, 24 Jan 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jqtl3xJu"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514114D456
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746555; cv=none; b=bUCYB7WQzbajVcB2NLOZ5LhAtnBOEc1K16ssSrUYkRJp+fS889T8VssT33Fdv1qdB5zmUl/ozTeZkPs10ANz5q8a1dSLMA0aTWhqBv7jD9ldavvww0ljnXnJGmEyg4YZTTEVodgT4F4oK64cXs8ElP0OLJivDo6muaqpJ7VrwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746555; c=relaxed/simple;
	bh=i/TDGybsH4dySGKqlZyMKcvvI/ahjOvK5u6lr+fsny8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc2tR306SWo9Z80ZIW0rU4ZHyKsVgRSWgKqobrjj4G3/ZZTyYZ6g7bJtgdz9XmjpxeqavAYSWFsdGC2YelEPS30NgMlVbKlcqVP+YNNqu41vdstz5zgSP9uGTIVq/O6mRt72rssykF2/l7wlq3QknjREaCgGCTwjhek4yUv7hFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jqtl3xJu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35e5479b-420c-4fd9-80d9-c04530ef1dc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737746545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJFY4cd+T8Vq2jb64D2lTIqAXeuV2PtwHcbgnffDQjA=;
	b=Jqtl3xJumbkujZTJ1WVBRW+GgTXP4A0VPQ4EHI4sx+SKdw8VWaV+Isv2r6ZenltbMUXVER
	I/2nECM4cQ8sgn/4K4yvrsWO28z/JHkOJZW/hRg7DEE/Y1Zv0Zozc217lPE0DTKgY+k+j4
	Fl1h70O2b9eAmrnoRVTE3w9ymtOi5vM=
Date: Fri, 24 Jan 2025 11:22:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
To: Shigeru Yoshida <syoshida@redhat.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121150643.671650-1-syoshida@redhat.com>
 <20250121150643.671650-2-syoshida@redhat.com> <Z5KWE6J8OtRVCFDR@mini-arch>
 <5e342fea-764b-48a0-afda-4adfb504bd46@linux.dev> <Z5L-ubBI7z1J6IDi@mini-arch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <Z5L-ubBI7z1J6IDi@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/25 6:45 PM, Stanislav Fomichev wrote:
> On 01/23, Martin KaFai Lau wrote:
>> On 1/23/25 11:18 AM, Stanislav Fomichev wrote:
>>> On 01/22, Shigeru Yoshida wrote:
>>>> The function bpf_test_init() now returns an error if user_size
>>>> (.data_size_in) is less than ETH_HLEN, causing the tests to
>>>> fail. Adjust the data size to ensure it meets the requirement of
>>>> ETH_HLEN.
>>>>
>>>> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>>>> ---
>>>>    .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
>>>>    .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
>>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>> index c7f74f068e78..df27535995af 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
>>>> @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
>>>>    	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
>>>>    	/* send a packet to trigger any potential bugs in there */
>>>> -	char data[10] = {};
>>>> +	char data[ETH_HLEN] = {};
>>>>    	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>>>    			    .data_in = &data,
>>>> -			    .data_size_in = 10,
>>>> +			    .data_size_in = sizeof(data),
>>>>    			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
>>>>    			    .repeat = 1,
>>>>    		);
>>>
>>> We should still keep 10, but change the ASSERT_OK below to expect the
>>> error instead. Looking at the comment above, the purpose of the test
>>> is to exercise that error case.
>>>
>>
>> I think the bpf_prog_test_run_opts in this dev/cpumap test is to check the
>> bpf_redirect_map() helper, so it expects the bpf_prog_test_run_opts to
>> succeed.
>>
>> It just happens the current data[10] cannot trigger the fixed bug because
>> the bpf prog returns a XDP_REDIRECT instead of XDP_PASS, so xdp_recv_frames
>> is not called.
>>
>> To test patch 1, a separate test is probably needed to trigger the bug in
>> xdp_recv_frames() with a bpf prog returning XDP_PASS.
> 
> Ah, yes, you're right, I missed the remaining parts that make sure
> the redirect happens

Thanks for confirming and the review.

Applied the fix.

Shigeru, please followup with a selftest to test the "less than ETH_HLEN" bug 
addressed in Patch 1. You can reuse some of the boilerplate codes from the 
xdp_cpumap_attach.c. The bpf prog can simply be "return XDP_PASS;" and ensure 
that BPF_F_TEST_XDP_LIVE_FRAMES is included in the bpf_test_run_opts. Thanks.

