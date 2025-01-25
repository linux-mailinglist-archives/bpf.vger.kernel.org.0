Return-Path: <bpf+bounces-49754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D790FA1C07D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C813C188EBD2
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B6C41A8F;
	Sat, 25 Jan 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PgzxJoXf"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CD4A0C
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737772633; cv=none; b=fnUOAnl8QWVnFTkPWL19zvO30l47wyaVL9vTjuD8To6yMrUyJ1+x0SMlwu3riGdOnk+vok6wI9HDaBMAahoH6tS1qEkS3fJu97Ah/qDuFTcQIxRRXkj0uXf35frnIKOK0icHKY/3LpAQIicFC2BpNmyj9J3BVgPFMO+g2LE9lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737772633; c=relaxed/simple;
	bh=/EwTh95JkZoqDpEO1YKgOkQmeAFxmldgcbsp4VFIv9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxrvauaxSEgFI/EnHKiANeOalqoHvjsCozxj6SFm28/u9Oy10JPlwHpVL8FEEXyLqK6oo+IGKr0uQ8LJdKsDGg9nVq92YKNT30iARabaegDOUfkvl+eSm7RRUrYOvKCLMmU7popWlaJf/09PEI3Y/sa9eNX7z0toGTuf6AgpISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PgzxJoXf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bf7110c-b978-45b8-9f74-4a37d6e98d5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737772627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6iLXzzDkmBVt4OLxXu7H0CDJXdKde9nVZhravGadgs=;
	b=PgzxJoXfOymHj0LUJvgEiriKiMxP/LQhEMAwLFjTFnHy68tvcH489/B5TKs9cDg6ee21uV
	xKPS5uskwq/rxbrF8QMX8zOIfhKYzq0jVAFgMnazh9aUrq2KnTFhnWWHBdZZExrmyPvNzg
	zhIjEwUCPMc+SdA40hsV3KkM/zXvRkE=
Date: Fri, 24 Jan 2025 18:36:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com>
 <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
 <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com>
 <3a91d654-0e61-4da0-9d09-66a82a24012a@linux.dev>
 <CAL+tcoBVtqNA_7dN3vpG9VqagjM=VaRKKxDBUiUK-DHPA5Mg=A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAL+tcoBVtqNA_7dN3vpG9VqagjM=VaRKKxDBUiUK-DHPA5Mg=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/24/25 5:35 PM, Jason Xing wrote:
> On Sat, Jan 25, 2025 at 9:30 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/24/25 5:18 PM, Jason Xing wrote:
>>>>> @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
>>>>>                 op = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
>>>>>                 break;
>>>>>         case SCM_TSTAMP_SND:
>>>>> +             op = sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_HW_OPT_CB;
>>>>>                 if (!sw)
>>>>> -                     return;
>>>>> -             op = BPF_SOCK_OPS_TS_SW_OPT_CB;
>>>>> +                     *skb_hwtstamps(skb) = *hwtstamps;
>>>> hwtstamps may still be NULL, no?
>>> Right, it can be zero if something wrong happens.
>>
>> Then it needs a NULL check, no?
> 
> My original intention is passing whatever to the userspace, so the bpf
> program will be aware of what is happening in the kernel.

This is fine.

> Passing NULL to hwstamps is right which will not cause any problem, I think.
> 
> Do you mean the default value of hwstamps itself is NULL so in this
> case we don't need to re-init it to NULL again?
> 
> Like this:
> If (*hwtstamps)
   if (hwtstamps) instead ?

I don't know. If hwtstamps is NULL, doing *hwtstamps will be bad and oops....
May be my brain doesn't work well at the end of Friday. Please check.

>       *skb_hwtstamps(skb) = *hwtstamps;
> 
> But it looks no different actually.
> 
> Thanks,
> Jason


