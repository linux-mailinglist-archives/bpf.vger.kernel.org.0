Return-Path: <bpf+bounces-51625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68CA36924
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 00:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BEB3AD492
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4D1FDA65;
	Fri, 14 Feb 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpJBxU3p"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9E1C84D9
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576482; cv=none; b=brtHpazyPgwxEDzooCu2Bx0qchzGpAOy4XNwfUXK2f1xzTU/E0vZfNyB34N+Pzs4+sqdQN7JGRHGHZAR0UfQSdOrvIDOfqYnDemz6AV1qMtwHs83vLklzmeitBgt1nFBeKLSYcmRGb7X3m9jPC2mUhl95L6yjqoeIelELyVtU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576482; c=relaxed/simple;
	bh=eZDnvtD5EEiosmcywRR1d0HQAGqdA9YtSfkO5QWydIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/yiOQ7YLrR2eQ+gQdnLF1EKP71RV8lTHlnc28pjFo1P/Tl+Zx6J2Kivw/ADjJFTSItHjBbqpKte3Q71Mt2zkZJIc34U7fk874CQA4XcVaIM5hU4+509oZak1B5iPSiBqBg0iVWcG/pVjaP3dCYuzTdUHwMpdy6ZEqNPrJb5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpJBxU3p; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ff9b840-9ba1-4217-a332-d5fcd1cf983a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739576475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VxyItiY5rSYldRYm3FqNOLqT6/qGoHPrGjqyT6shbY=;
	b=jpJBxU3pudHtsWMqnyaqqVRlr8FWKZD995JQFvUrZeR4AGZvwBaTxF8gAHY6m311I347Ns
	E+ooq1I421ncdvV5ms8ZahVRCoo2dlDL2OdxsrZAfz7Ytzh/dWpsIzjQ+ClZoQkbSB/T3Y
	cxXCp4o/ujxwAr+l2wvtCz1M9H9Xyq4=
Date: Fri, 14 Feb 2025 15:41:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-10-kerneljasonxing@gmail.com>
 <5f6e9e0b-1a5f-4129-9a88-ad612b6c6e3b@linux.dev>
 <CAL+tcoCYcpaBDG8GRyP1Fk8WYHAo4ic1YNhmazXEysYUWSTqxg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoCYcpaBDG8GRyP1Fk8WYHAo4ic1YNhmazXEysYUWSTqxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 3:16 PM, Jason Xing wrote:
> On Sat, Feb 15, 2025 at 4:34 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/13/25 5:00 PM, Jason Xing wrote:
>>> diff --git a/net/dsa/user.c b/net/dsa/user.c
>>> index 291ab1b4acc4..794fe553dd77 100644
>>> --- a/net/dsa/user.c
>>> +++ b/net/dsa/user.c
>>> @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
>>>    {
>>>        struct dsa_switch *ds = p->dp->ds;
>>>
>>> -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>>> +     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF))
>>
>> This change should be in patch 8.
>>
>> [ ... ]
>>
>>> diff --git a/net/socket.c b/net/socket.c
>>> index 262a28b59c7f..517de433d4bb 100644
>>> --- a/net/socket.c
>>> +++ b/net/socket.c
>>> @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags)
>>>        u8 flags = *tx_flags;
>>>
>>>        if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
>>> -             flags |= SKBTX_HW_TSTAMP;
>>> +             flags |= SKBTX_HW_TSTAMP_NOBPF;
>>
>> Same here.
> 
> Sure, you're right. If you feel it's necessary to re-spin, I will
> adjust these two points :)

That will be good. I would wait a bit to collect Willem's comment first.


