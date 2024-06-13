Return-Path: <bpf+bounces-32075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E0907112
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B81F22191
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C7139CFE;
	Thu, 13 Jun 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="geT5djGt"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1D161;
	Thu, 13 Jun 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281995; cv=none; b=TmuSs1TDMPK69SvJGgDjRXiXdVP8ppYYZ81LlfGaHHFzZJyGBlqqfs3qa/Sc6h8LPdIxGaJYVzbxlOO3qeAC+AdarWBiFPWsPfCldLrYJEeb9zcbukm9XFkuT2LU/JnIxuS6Qkz2/hAE9RpRBbQjpSph1PKut5w2Vmb8BXZzivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281995; c=relaxed/simple;
	bh=6++V+QFxgN/JaMMIMKIsQMM+MoRIat1NOsVf99RZsjE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FrCCQXZp9hFq2IqVJZDuZ1wyHoDlmcQYNMCg8hqWxK1DVU7dGOKvrtL7yCt1zyrZVBju0dvTCnjVuUxv++TLxpjfoIDF6IZm6B97Sx1idMl7vPkxnHTBAr6vzI/AYHBNLyH3reaGefWiO8D3a6Hb9Zw8/jPddZdSQwk5W5EoEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=geT5djGt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Jvvsf3m+9ME+H97kyk5aPz8rec70QkK6h+jT1QfCsyI=; b=geT5djGtGvu7+XcfZg9dUY8+qW
	2+AxTFcXxolHY6MaA5FhnPa6fsGX2mUJXA5nlsc2c8yg3SkpZj6hS7TjAunR3AYDGJ95AK86CMK/N
	PhrZFIlS4GJMn9ujv3R5jKP4arJN+twubvNEbN9x7SN45DnYs62YNAXF1q8cvD0OsgVT4TwQJpP65
	Tejl4/X9+Rvt9OamcZ12HZ2fEvFaX1q1j0G/Lgc3NGRPGIIrC+IU2uaSYIV+zo8kX8JQ0NBcrU21W
	RC0sRybkPpLzNO1u/n7VuB8Op28QZRA1K9yTw0R1yU2kjQKZ/lwvc6Iq2StFZY6GSxM6O4NIdV/+d
	9CWeO3zw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHjdV-000KcC-L1; Thu, 13 Jun 2024 14:33:01 +0200
Received: from [178.197.249.34] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sHjdU-000HnC-2t;
	Thu, 13 Jun 2024 14:33:01 +0200
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240606145851.229116-1-vadfed@meta.com>
 <20240612074917.1afacc42@kernel.org>
 <895c8713-85a7-48a6-a42c-2c1ac4fe2274@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9a08dbc8-3423-99b5-3840-feab6703f84c@iogearbox.net>
Date: Thu, 13 Jun 2024 14:32:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <895c8713-85a7-48a6-a42c-2c1ac4fe2274@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27305/Thu Jun 13 10:33:25 2024)

On 6/13/24 1:18 PM, Vadim Fedorenko wrote:
> On 12/06/2024 15:49, Jakub Kicinski wrote:
>> On Thu, 6 Jun 2024 07:58:50 -0700 Vadim Fedorenko wrote:
>>> @@ -1060,9 +1062,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>           __skb_push(skb, hh_len);
>>>       if (is_direct_pkt_access)
>>>           bpf_compute_data_pointers(skb);
>>> +
>>>       ret = convert___skb_to_skb(skb, ctx);
>>>       if (ret)
>>>           goto out;
>>> +
>>> +    if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>>> +        const int off = skb_network_offset(skb);
>>> +        int len = skb->len - off;
>>> +
>>> +        skb->csum = skb_checksum(skb, off, len, 0);
>>> +        skb->ip_summed = CHECKSUM_COMPLETE;
>>> +    }
>>
>> Looks good, overall, although I'd be tempted to place this before
>> the L2 is pushed, a few lines up, so that we don't need to worry
>> about network offset. Then again, with you approach there is a nice
>> symmetry between the pre- and post- if blocks so either way is fine:
>>
>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> Could you please take a look and merge the series?

Looks good, done now, thanks Vadim!

