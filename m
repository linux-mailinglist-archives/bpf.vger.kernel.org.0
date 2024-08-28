Return-Path: <bpf+bounces-38323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CE963526
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A41C21765
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7FF1AD3FB;
	Wed, 28 Aug 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iTgJi/X3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B154157A72
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886116; cv=none; b=PlupDB9XTIkkAFrE74jzpFnUkuZtbzF7UDfHBBCuDJByMRrujlOQ4gvf4q+knlCS8eacBmnPR9dmN7K5Sh2jnqlG+/oYv0BwkhZuCaEd/nBrocKhl+XK4FijDwcnOhR+BQK6jErzgEoQZJbFiHmcScRr2LndpzvMH02gIZayn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886116; c=relaxed/simple;
	bh=UiMFwUy71IJuRqIqRUPJG2titO3LLf4vKDPDtPF+7Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdJDhUff6d57zPpL0ZIQMFk78UslSGpxlkb0o6CERjlTj0NTAD0quUYSEdGXvnXqCUUkMKSIZ0SEyEsO0819NqgLdDdPQMdaqQAgwDDVKd2607JL+shEuMhwZBM01ddqAMK2KT2IG7HMzmrG0QS57HYwEe1SwfK7BGrLWbXy9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iTgJi/X3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4567ec27dd7so2581251cf.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724886113; x=1725490913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDthbzviFOTDqYmLCxwhvZK3COmlxDU0Vy7Bv/81kYc=;
        b=iTgJi/X3ifg+PrkziLd8UEEZLACMLaSlUDcWO2e110wgDVPKvXqjMp0f+gMgahFW1/
         OmjhvGF9Mj8Q0TYfN2CE/W7deYHfXtZgwjMd/wnGRRpc1y2Q6f9YHzRWDHREnm1J/S+X
         AgPh161vVvLUKJ3AKoNbD4wbmhJBD1VW5PlyiMnCgOcyOjPbkUC9z3cKGWVsMekfTI+n
         7D91zdPP/COiAemeA8XluQoY1sq50jBd6eaXmvFKwyK+cZ+BmYNhwwm0OGPQSMPsDkpw
         HCCmtVZ2dOcolT61C7JzCWJWHNbL57nVBRiJ8hY6ZGNV5rRDeZ++e53PzXrwo+IoR4il
         5BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886113; x=1725490913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDthbzviFOTDqYmLCxwhvZK3COmlxDU0Vy7Bv/81kYc=;
        b=iThiTwC0Zgt3I5yFlMRsBgtnFHE6kRHRxtG89MxCBnN7Rl63T04rWbrhCvJ0uHKEO+
         4casou8rE+PPVsnOYxuglC941r0H+cxgAG/nwBHR40glsjtSi9HMyQhvDMtCNs1XLVY3
         nYV3F/W76pkYXsU5w9zNaDCUStVRpcvCZj3mvitebswDTPwiO+eA4pv1jLpKlSZedSaB
         XWz4ge3t8Emkj++PdT4fbvAylKHjqXOcjkbMHC/TCrtJJfMyofXEswOj88gvJ2BquySK
         gzw7eGqHr9T3jVtafJ7dn2gHxwLMjzqsav/voLMSseGIudgvYY/DJgYj92PYtnmS3tBc
         CUbg==
X-Forwarded-Encrypted: i=1; AJvYcCUxz5EXCL4f4OQx+2UCdaAWD47u1ba8W/52akFnpJnBgwJJsw2Q5eNt3ztFgg+8/DECkbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyC5sinhl6Rb8kdCyiOxvc0SaBOe47L1C0SzEvM688mcri1tTR
	DRBO4QSotdL4TGWYaK+78F/Ds6xitnHdl+AgFoHrZuEkRBfNlnGZZyiebTeXUZc=
X-Google-Smtp-Source: AGHT+IH12C1dleNEfg0k8DA3QyenYs85sO25nr4qBUUG2E5xd8OCFV289M7RXQwqZJIma92O25VGZA==
X-Received: by 2002:a05:622a:2444:b0:454:f3b2:aa8d with SMTP id d75a77b69052e-4567f6ecd88mr10859481cf.64.1724886112913;
        Wed, 28 Aug 2024 16:01:52 -0700 (PDT)
Received: from [10.200.138.138] (ec2-52-9-159-93.us-west-1.compute.amazonaws.com. [52.9.159.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196d10sm65928541cf.71.2024.08.28.16.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 16:01:52 -0700 (PDT)
Message-ID: <955cb3be-1dc4-4ebf-b0de-75c25f393c1e@bytedance.com>
Date: Wed, 28 Aug 2024 16:01:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: tcp: prevent bpf_reserve_hdr_opt()
 from growing skb larger than MTU
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 xiyou.wangcong@gmail.com, wangdongdong.6@bytedance.com,
 zhoufeng.zf@bytedance.com
References: <20240827013736.2845596-1-zijianzhang@bytedance.com>
 <20240827013736.2845596-2-zijianzhang@bytedance.com>
 <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <5186a69b-c53d-4afa-b3be-e6bd272d264f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 2:29 PM, Martin KaFai Lau wrote:
> On 8/26/24 6:37 PM, zijianzhang@bytedance.com wrote:
>> From: Amery Hung <amery.hung@bytedance.com>
>>
>> This series prevents sockops users from accidentally causing packet
>> drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
>> reserves different option lengths in tcp_sendmsg().
>>
>> Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
>> reserve a space in tcp_send_mss(), which will return the MSS for TSO.
>> Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
>> again to calculate the actual tcp_option_size and skb_push() the total
>> header size.
>>
>> skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
>> derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
>> reserved opt size is smaller than the actual header size, the len of the
>> skb can exceed the MTU. As a result, ip(6)_fragment will drop the
>> packet if skb->ignore_df is not set.
>>
>> To prevent this accidental packet drop, we need to make sure the
>> second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
>> not more than the first time. 
> 
> iiuc, it is a bug in the bpf prog itself that did not reserve the same 
> header length and caused a drop. It is not the only drop case though for 
> an incorrect bpf prog. There are other cases where a bpf prog can 
> accidentally drop a packet.
> 
> Do you have an actual use case that the bpf prog cannot reserve the 
> correct header length for the same sk ?

That's right, it's the bug of the bpf prog itself. We are trying to have
the error reported earlier in eBPF program, instead of successfully
returning from bpf_sock_ops_reserve_hdr_opt but leading to packet drop
at the end because of it.

By adding this patch, the `remaining` variable passed to the
bpf_skops_hdr_opt_len will be more precise, it takes the previously
reserved size into account. As a result, if users accidentally set an
option size larger than the reserved size, bpf_sock_ops_reserve_hdr_opt
will return -ENOSPC instead of 0.

We have a use case where we add options to some packets kind of randomly
for the purpose of sampling, and accidentally set a larger option size
than the reserved size. It is the problem of ourselves and takes us
some effort to troubleshoot the root cause.

If bpf_sock_ops_reserve_hdr_opt can return an error in this case, it
could be helpful for users to avoid this mistake.

