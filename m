Return-Path: <bpf+bounces-51060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF9A2FD8E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 23:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57923165CE8
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D5253F2B;
	Mon, 10 Feb 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RGlsLEGe"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3A253F17
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227195; cv=none; b=fB5JBj6jbD0GwDAHhYL/8NolAa1dBhb3LuNnGWMG0vuwP/3SSM/T38sJnTDrqa7s+DcZShm+7kB917C4R98enFKaoDTperCpwMsRYaqzKvdW8usYygp0QKfA1L7YtnWqi/FrkunZedKBjN1uKX4A2vvVnrUDzh9skKL9mxEiMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227195; c=relaxed/simple;
	bh=0P72uV3pB6pL+48smtl0CFdO6pvz1q048WmjWhaF7qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZUkqHccugeUr53x8I6h5S54zNxX1jmkeotxXe5tFeyllQbkTTQWxpT6I1tWWqTg6J7Zfy5aZRzSKYqmJiK0fIdT0KMxlwFMfKZcYzLmqoSEEcS1m8keDihQV8iM9IJBQYe5GQVWALTNMcxIZddjGDOdZB172HcrjXe617DzZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RGlsLEGe; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6f2c489-85a9-436e-8d05-4b3063c133fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739227191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7w3YMgpbpcGG8afYcxZb7YRFBy/TyESQsnHPgNHSTkE=;
	b=RGlsLEGeTnWUkDTC9wQAypdqYsh8qtet+1va35o9zoMOBuawDjwC8mqQd23mYwzZHqCAbU
	23geRR9gDZeJ/fjszBBCoaY19udtJnuD89hrxP+aOVBN5di1J23JOg58tbZ6rgjNpnsMSk
	WDs450dJTfGwCgWBKgEf1u3id+7TSz8=
Date: Mon, 10 Feb 2025 14:39:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 08/12] bpf: support hw SCM_TSTAMP_SND of
 SO_TIMESTAMPING
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-9-kerneljasonxing@gmail.com>
 <67a3878eaefdf_14e08329415@willemb.c.googlers.com.notmuch>
 <CAL+tcoAH6OYNOvUg8LDYw_b+ar3bo2AXqq0=oHgb-ogEYAeHZA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoAH6OYNOvUg8LDYw_b+ar3bo2AXqq0=oHgb-ogEYAeHZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/5/25 8:03 AM, Jason Xing wrote:
>>> @@ -5574,9 +5575,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>>>                op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>>>                break;
>>>        case SCM_TSTAMP_SND:
>>> -             if (!sw)
>>> -                     return;
>>> -             op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>> +             op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
>>> +             if (!sw && hwtstamps)
>>> +                     *skb_hwtstamps(skb) = *hwtstamps;
>> Isn't this called by drivers that have actually set skb_hwtstamps?
> Oops, somehow my mind has gone blank 🙁 Will remove it. Thanks for
> correcting me!

I just noticed I missed this thread when reviewing v9.

I looked at a few drivers, e.g. the mlx5e_consume_skb(). It does not necessarily 
set the skb_hwtstamps(skb) before calling skb_tstamp_tx(). The __skb_tstamp_tx() 
is also setting skb_hwtstamps(skb) after testing "if (hwtstamps)", so I think 
this assignment is still needed here?

