Return-Path: <bpf+bounces-30768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB18D24A2
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1D5281EBE
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF07172769;
	Tue, 28 May 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PiXETvYR"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B14CB4B
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924650; cv=none; b=OztyMYqguQ9FE1UoGb1DfuM55DEpud6Y11ixJ/jOuTZ8gh60IKSxT//EWebzyf34WidZFwnV2LQABAY0ctczQ1PaUcxxTuT6FhmigqaQ6cD+Yufs0gwx/ow+FZtBwnxt56WLXsn1qkvhdNnD7etddpGtThpwLjM+P4gWlLF51uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924650; c=relaxed/simple;
	bh=fI4YZIUdESe+KXQcRqR67vysxo0zhiFA5TgqGIaSsnk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iwWyXlCzNe2DTtc5rG9HmTqe27yd1P2uTSf81jM2/91rIH9D5XZjN4c/CPMUtQYsAFzBfxLILbvMAepMxAqlYzm7vkV222XWvp5kbuHV49kIGUEZuCCA928n9vhL2lSo31d4HiJFU6dF46z4feEFVrUgViJmtGC+P1a+7CGWGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PiXETvYR; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willemdebruijn.kernel@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716924646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz3k3DiyCGoMOQPg4X/3emTcMizgWP/27mI/YhTD5m0=;
	b=PiXETvYR6IRMfXEe4gOpDNS9DV3O6W5Gp/M9XzKmFpHzF3IzhEUJabyVl4aKIkY6A9mOQT
	iWn91fhLI0re1yqfYGa1lq6hNJCm5Y1NbaEitw8hyImb02S6L8FGAx+V9l0wb/W4Td4y6C
	M5NLDgB6mMCoLSKpQhDcsOYZygSBmig=
X-Envelope-To: quic_abchauha@quicinc.com
X-Envelope-To: kernel@quicinc.com
X-Envelope-To: willemb@google.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: ahalaney@redhat.com
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: bpf@vger.kernel.org
Message-ID: <d1c18889-ef48-4cb8-8b81-474b3b7ddd81@linux.dev>
Date: Tue, 28 May 2024 12:30:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v8 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
 <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
 <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
Content-Language: en-US
In-Reply-To: <665613536e82e_2a1fb929437@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/28/24 10:24 AM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
> 
>>> +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
>>> +						    ktime_t kt, clockid_t clockid)
>>> +{
>>> +	u8 tstamp_type = SKB_CLOCK_REALTIME;
>>> +
>>> +	switch (clockid) {
>>> +	case CLOCK_REALTIME:
>>> +		break;
>>> +	case CLOCK_MONOTONIC:
>>> +		tstamp_type = SKB_CLOCK_MONOTONIC;
>>> +		break;
>>> +	default:
>>
>> Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn.
>> So i think this might result in unnecessary crashes.
>>
>> Let me know what you think.
>>
>> Logs which are complaining.
>> https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000
> 
> I received reports too. Agreed that we need to fix these reports.
> 
> The alternative is to limit sk_clockid to supported ones, by failing
> setsockopt SO_TXTIME on an unsupported clock.
> 
> That changes established ABI behavior. But I don't see how another
> clock can be used in any realistic way anyway.
> 
> Putting it out there as an option. It's riskier, but in the end I
> believe a better fix than just allowing this state to continue.

Failing early would be my preference also. The current ABI is arguably at least 
confusing (if not broken) considering other clockid is silently ignored by the 
kernel.

> 
> A third option would be to not fail the system call, but silently
> fall back to CLOCK_REALTIME. Essentially what happens in the datapath
> in skb_set_delivery_type_by_clockid now. That is surprising behavior,
> we should not do that.

Not sure if it makes sense to go back to this option only after there is 
breakage report with a legit usage?


