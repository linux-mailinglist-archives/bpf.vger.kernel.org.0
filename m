Return-Path: <bpf+bounces-60128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0CAD2B4D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 03:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CA31892B39
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A31A8419;
	Tue, 10 Jun 2025 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RS3mEbQv"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4C1A5BAC
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518689; cv=none; b=kSpoZFNu1h+kbfZl1milggzBqr+2jpdQYrNfiqKgk39/H5Y3nN+JYt+6sit0hhNgBdGt2OIW7LVVW2Dkf9IzMq3XyI8WdC1SLgiQ0JNjEdbfxZJVIuEMfdtQzhZQqr4qpoXLbwRQrVH/x/tdr5aPYyMcq6T7hrz513Ada7wZNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518689; c=relaxed/simple;
	bh=PYmP4u53GlmdUf5gM4lS1uMCfllgzeZbdRCq42Z8z7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFFBj7+5mZy+aRUBmEXurcJShpe2g2571zcpEkw4LIP5Fw0eO10/NqThJG7M0lHFrPrhRs2CK/QaP95744LS84WZlLSeXlOlZCeNx79ggbTKQbg6axfhxGrVBfGGgmVjEztm8Ww/MSTdv3h3SBSVsU+IjMnmg8cdyQRSVTOTfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RS3mEbQv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac97119e-6f39-4f96-a755-ce0f365c7295@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749518685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZKGAiViNbmoLSTweHF4+bed5G/idAti5UykX55JloA=;
	b=RS3mEbQvfTDjLwJocWynRkbKU+KnePq1fgj8jxLsWrHrsZ2csd/pP7gLJlu57dnAO/gNbF
	jl5ifQvgSeAEHOPnG2xsUH5tkCps8z48ldw7emLQ7IyYhe67PD5DMtp2Llzhf51vIT4SFB
	cUoDSLNKVLnCW3km++ZRLu1t12t4EmQ=
Date: Mon, 9 Jun 2025 18:24:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix two net related test
 failures with 64K page size
Content-Language: en-GB
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250608165534.1019914-1-yonghong.song@linux.dev>
 <20250608165539.1020481-1-yonghong.song@linux.dev>
 <aEdmTuCtAJ2D9gam@mini-arch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aEdmTuCtAJ2D9gam@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/9/25 3:55 PM, Stanislav Fomichev wrote:
> On 06/08, Yonghong Song wrote:
>> When running BPF selftests on arm64 with a 64K page size, I encountered
>> the following two test failures:
>>    sockmap_basic/sockmap skb_verdict change tail:FAIL
>>    tc_change_tail:FAIL
>>
>> With further debugging, I identified the root cause in the following
>> kernel code within __bpf_skb_change_tail():
>>
>>      u32 max_len = BPF_SKB_MAX_LEN;
>>      u32 min_len = __bpf_skb_min_len(skb);
>>      int ret;
>>
>>      if (unlikely(flags || new_len > max_len || new_len < min_len))
>>          return -EINVAL;
>>
>> With a 4K page size, new_len = 65535 and max_len = 16064, the function
>> returns -EINVAL. However, With a 64K page size, max_len increases to
>> 261824, allowing execution to proceed further in the function. This is
>> because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
>> result in higher max_len values.
>>
>> Updating the new_len parameter in both tests from 65535 to 262143 (0x3ffff)
>> resolves the failures.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 2 +-
>>   tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> index 2796dd8545eb..4f7f08364c75 100644
>> --- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
>> @@ -31,7 +31,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
>>   		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
>>   		return SK_PASS;
>>   	} else if (data[0] == 'E') { /* Error */
>> -		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
>> +		change_tail_ret = bpf_skb_change_tail(skb, 262143, 0);
>>   		return SK_PASS;
>>   	}
>>   	return SK_PASS;
>> diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> index 28edafe803f0..b1057fda58a0 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
>> @@ -94,7 +94,7 @@ int change_tail(struct __sk_buff *skb)
>>   			bpf_skb_change_tail(skb, len, 0);
>>   		return TCX_PASS;
>>   	} else if (payload[0] == 'E') { /* Error */
>> -		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
>> +		change_tail_ret = bpf_skb_change_tail(skb, 262143, 0);
>>   		return TCX_PASS;
>>   	} else if (payload[0] == 'Z') { /* Zero */
>>   		change_tail_ret = bpf_skb_change_tail(skb, 0, 0);
> nit: this seems to be exercising BPF_SKB_MAX_LEN case. To make it easier to
> spot in the future, can we do the following in both tests?
>
> #define PAGE_SIZE 65536 /* make it work on 64K page arches */
> #define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)
>
> ... = bpf_skb_change_tail(skb, BPF_SKB_MAX_LEN, 0);

Thanks for suggestions, Will do.


