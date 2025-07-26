Return-Path: <bpf+bounces-64431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631CB12879
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 03:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1631CC58C2
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 01:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240B1C5F10;
	Sat, 26 Jul 2025 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPtwdCzv"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F92EAF9
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753494083; cv=none; b=REPHWrlYXO2nLOaYgYWmjT4YCM6JAf2y6TU3K1XpjJZUbZnqglLtejImin9ZMJq/7g3Z7tb1YBaT0DAjhH1UtWHsOaXZ/DF8kE8DMbGYs3jq9xsaWDNm+dGFn60GOmTM2Fg1RGb2HR1PAtWQzxmSQgU2lU7T72mS+T6XY9S6qJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753494083; c=relaxed/simple;
	bh=qpCdU2rftv/KY1fmLwmwkvSFWGxqg2orZy45pDrkKb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFfqPFGUoAoi2dgztqnaoB72Sr3CkVZk8276/J8jpjyY7h4O+EfIosXIwXVbTjd1CsagXUg65sTHEeqkg3DsX34nS52xdXduhwxHzsBAF5RCX6QvN5VhOONLessgZl/tSrAmyVkOSVWUH8XVG0wsCtKf7PP/dUqn2nKDb/hmepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPtwdCzv; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1e0b23c5-336c-436e-a568-f2eba0cdcbbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753494073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn2igGxFd8RlUqfmWi84AiYxQrHhDBaupzp1fg9QVFs=;
	b=IPtwdCzv1Rq2X4hLWkXh9o3v2nYbXX40hdfnIpOU1h2BRy2OmAk59ecIuqnUS1CF35azNy
	eVJV8CqXZy6G8QrEhyuqfrxvwnctZoO/XbBOlDQV6libwszIpUSBY5Hvlfq+wvQDJr51mf
	nh79+EY7wRHihwdunFMloAq9k9pACa8=
Date: Fri, 25 Jul 2025 18:41:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix test
 dynptr/test_dynptr_memset_xdp_chunks failure
To: Yonghong Song <yonghong.song@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
References: <20250725043425.208128-1-yonghong.song@linux.dev>
 <20250725043440.209266-1-yonghong.song@linux.dev>
 <3c145192-122d-46fc-8567-be30a2694a4d@linux.dev>
 <74ad40ee-1a78-4a0d-8408-ff22defb632b@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <74ad40ee-1a78-4a0d-8408-ff22defb632b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/25/25 5:59 PM, Yonghong Song wrote:
> 
> 
> On 7/25/25 4:29 PM, Martin KaFai Lau wrote:
>> On 7/24/25 9:34 PM, Yonghong Song wrote:
>>> For arm64 64K page size, the xdp data size was set to be more than 64K
>>> in one of previous patches. This will cause failure for bpf_dynptr_memset().
>>> Since the failure of bpf_dynptr_memset() is expected with 64K page size,
>>> return success.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   tools/testing/selftests/bpf/progs/dynptr_success.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/ 
>>> testing/selftests/bpf/progs/dynptr_success.c
>>> index 3094a1e4ee91..8315273cb900 100644
>>> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
>>> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
>>> @@ -9,6 +9,8 @@
>>>   #include "bpf_misc.h"
>>>   #include "errno.h"
>>>   +#define PAGE_SIZE_64K 65536
>>> +
>>>   char _license[] SEC("license") = "GPL";
>>>     int pid, err, val;
>>> @@ -821,8 +823,17 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
>>>       data_sz = bpf_dynptr_size(&ptr_xdp);
>>>         err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, DYNPTR_MEMSET_VAL);
>>> -    if (err)
>>> +    if (err) {
>>> +        /* bpf_dynptr_memset() eventually called bpf_xdp_pointer()
>>
>> I don't think I understand why the test fixed in patch 1 (e.g. 
>> test_probe_read_user_dynptr) can pass the bpf_xdp_pointer test on 0xffff. I 
>> thought the bpf_probe_read_user_str_dynptr will eventually call the 
>> __bpf_xdp_store_bytes which also does a bpf_xdp_pointer?
> 
> For example, for test_probe_read_user_dynptr, for function test_dynptr_probe_xdp(),
> for this one:
>     off = xdp_near_frag_end_offset();
> 
> the off = 64928. Note that xdp_near_frag_end_offset() return value depends page 
> size.
> 
> __u32 xdp_near_frag_end_offset(void)
> {
>          const __u32 headroom = 256;
>          const __u32 max_frag_size =  __PAGE_SIZE - headroom - sizeof(struct 
> skb_shared_info);
>          /* 32 bytes before the approximate end of the fragment */
>          return max_frag_size - 32;
> }
> 
> The 'len' depends on 'test_len[i]' and test_len is
>     __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};
> 
> In bpf_xdp_pointer, we have the following test
> 
>          if (unlikely(offset > 0xffff || len > 0xffff))

Thanks for the explanation. Applied. Thanks.

I wonder if the 0xffff check can be removed from bpf_xdp_pointer() and depend on 
checking the xdp_get_buff_len(). The 0xffff check was also removed from the 
bpf_skb_load_bytes some time ago. [cc: Lorenzo, netdev]

Otherwise, it is not very useful to be able to create such xdp buff from the 
bpf_prog_test_run_xdp.

