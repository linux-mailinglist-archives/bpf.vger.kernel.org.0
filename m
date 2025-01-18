Return-Path: <bpf+bounces-49242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B216A15A98
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 01:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52093A8E5D
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F3B666;
	Sat, 18 Jan 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JNRnyQ47"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBEB640
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161242; cv=none; b=f+Jwp3VOKb2E5McI+uHq4ftn9SSMdJ4JnQc4r7beWtmg3xfiDcY9n5b75u1tlmSnIIH3Jqmfuxwhdx36OxRNi55qbwA4RxJvegv4YajEMy9BwoXkRFe8g8AbCickD3v5zmeXx/sYRVULR1vrjs8N9eIZ1zLlM9PA38nbEGrzfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161242; c=relaxed/simple;
	bh=d7Cy1HBZ7uudLln/1KJycVHjr9lgFKrdOo1NmfPV+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drzGgtSKT4+w+YeAhHSI4kp82zgXCoHd+U0dzXqbqCGXW3Ey2rcd9JBYpmCpkF2lTKiFz7KliW5CSs68H/vbkrRFuz/oPd9xD7EvL1mcnn0q3++uKrkpKzPh9SKS+S9cqH5VmO9eEy+YmHLNpujXKhMkzHeIXKG7KfchhdGtZ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JNRnyQ47; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc4dd0d9-d4ae-4601-be01-5fad7c74e585@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737161228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRREM1BEEEqOBTIHUcVG5c4TyTNaF/eaJuYWhcxyST0=;
	b=JNRnyQ47gwTfRm8VdU+ufBHAlsuiMUEj8JYFWFqYQcSK3MVBQAGJFrLU87EBbQ6anQWesQ
	Sso5AhwhzZE2/siAN+6Zee6P9U4zL7j5LGntgQ3bPbTpgeZXXmAp+DlDADgXELln9ACx4U
	4mPzIv7Cc2DSgKsLpVQPa7BwX97AWw0=
Date: Fri, 17 Jan 2025 16:46:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 08/15] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-9-kerneljasonxing@gmail.com>
 <ef391d15-4968-42c6-b107-cbd941d98e73@linux.dev>
 <CAL+tcoC+bXAPP94zLka5GcwbpWNQtFijxd0PcPnVrtS-F=h6vQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoC+bXAPP94zLka5GcwbpWNQtFijxd0PcPnVrtS-F=h6vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/15/25 3:56 PM, Jason Xing wrote:
> On Thu, Jan 16, 2025 at 6:48 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/12/25 3:37 AM, Jason Xing wrote:
>>> Support SCM_TSTAMP_SND case. Then we will get the software
>>> timestamp when the driver is about to send the skb. Later, I
>>> will support the hardware timestamp.
>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index 169c6d03d698..0fb31df4ed95 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -5578,6 +5578,9 @@ static void __skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, int tstype
>>>        case SCM_TSTAMP_SCHED:
>>>                op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>>>                break;
>>> +     case SCM_TSTAMP_SND:
>>> +             op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>
>> For the hwtstamps case, is skb_hwtstamps(skb) set? From looking at a few
>> drivers, it does not look like it. I don't see the hwtstamps support in patch 10
>> either. What did I miss ?
> 
> Sorry, I missed adding a new flag, namely, BPF_SOCK_OPS_TS_HW_OPT_CB.
> I can also skip adding that new one and rename
> BPF_SOCK_OPS_TS_SW_OPT_CB accordingly for sw and hw cases if we
> finally decide to use hwtstamps parameter to distinguish two different
> cases.

I think having a separate BPF_SOCK_OPS_TS_HW_OPT_CB is better considering your 
earlier hwtstamps may be NULL comment. I don't see the drivers I looked at 
passing NULL though but the comment of skb_tstamp_tx did say it may be NULL :/

Regardless, afaict, skb_hwtstamps(skb) is still not set to the hwtstamps passed 
by the driver here. The bpf prog is supposed to directly get the hwtstamps from 
the skops->skb pointer.


