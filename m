Return-Path: <bpf+bounces-32065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA0906AD8
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 13:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413A6B224B7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A9142E95;
	Thu, 13 Jun 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gJNCVWSl"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB713C9C0
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277491; cv=none; b=L/Yw8HiET4IHLXVmF8+Jcwb7/8UEPYPv1ECxW7SZBXI1e7zw5aAlibzkhQgsmCmCl3RAlxtU3UMrgBTLrnq1ZMSC7gj4CFI1Gs8s+u5TjMxAFCPpaEeHmGmpMJWZM86e+nfL7W8+WPaxilEjdQosB+A2cQGNAmxQd1uZO+SO4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277491; c=relaxed/simple;
	bh=PwRQ1jcic2GeGuDoKYKK7A1oVIRwq+S2s7y2dByeUfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3FU4UfL14M9Uwd5zHl418CW+0wTOK7VrDFp2LeQ/NuU3N7ZLqHstZqaOTE2OhsgWSm1t22TQ7wKHpe+86/BqTWYCDnGg2+0jqyscHH0lTm4mGF1j8brIeE7Tg0IRa+vTl6VG2Llmp0nD3Jl0ccrloDRSvQey6v2XhNJjSyDpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gJNCVWSl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718277487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxwpkH10a/Qqq116CU6pqkq3h1coQ0GMCVQ+GwfzBoU=;
	b=gJNCVWSlwCB66c3mMfMwwSIlZ+Dn+9K5Ab3O7Ifk6HsOfAdryY3xLHhZMw2coIzx4lr2Jb
	yHqQ6LhbvPi6If/wus2bXC9iyiy+ORxzqbok0tbedacSqxUjDLkJuOo5QxatOjVx3Y4xqR
	XoPlnjyO1LuS4Zb2xwCf2Hk3sqALKng=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <895c8713-85a7-48a6-a42c-2c1ac4fe2274@linux.dev>
Date: Thu, 13 Jun 2024 12:18:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240606145851.229116-1-vadfed@meta.com>
 <20240612074917.1afacc42@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240612074917.1afacc42@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/06/2024 15:49, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 07:58:50 -0700 Vadim Fedorenko wrote:
>> @@ -1060,9 +1062,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   		__skb_push(skb, hh_len);
>>   	if (is_direct_pkt_access)
>>   		bpf_compute_data_pointers(skb);
>> +
>>   	ret = convert___skb_to_skb(skb, ctx);
>>   	if (ret)
>>   		goto out;
>> +
>> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>> +		const int off = skb_network_offset(skb);
>> +		int len = skb->len - off;
>> +
>> +		skb->csum = skb_checksum(skb, off, len, 0);
>> +		skb->ip_summed = CHECKSUM_COMPLETE;
>> +	}
> 
> Looks good, overall, although I'd be tempted to place this before
> the L2 is pushed, a few lines up, so that we don't need to worry
> about network offset. Then again, with you approach there is a nice
> symmetry between the pre- and post- if blocks so either way is fine:
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Hi Daniel!

Could you please take a look and merge the series?

Thanks,
Vadim

