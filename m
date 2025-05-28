Return-Path: <bpf+bounces-59134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB210AC6337
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9973B6CB5
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCC2459D9;
	Wed, 28 May 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mODGx2LY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321951C84B8;
	Wed, 28 May 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418147; cv=none; b=Pjgxydf2c+YW7+ly/1hh9wF51jdQm040o506zfyg0LrnfRpeobx2qnc1fR2ALy8rUeURTciIykwdP2GEQJOotU6Du+bGAlH2JdJs5y/M7YylWvca1HuLMRqzutSbFYEqtmACRVfWYeMormjsNo7NMEmb78UzWm8HXSaTJH5m9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418147; c=relaxed/simple;
	bh=FBdm3zXl/J+bAroDHqYjB2GcWTFC6T1eJvlgk8gKQ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCogjLbtGVlohnDFOeX6Q0QuL9C4uXzZnuxmIdNukIq0b/3Nm8Skjmyv38/uUheoRejsCJU2X0FVwqfAEILepXNh5CM4vKu7kEPb/2OyXWlIaUj1GNxUkXqa4IzqZmdQPk38rcD4ND3FXdpFKRlWjKetnWlsYdlsggorUndYTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mODGx2LY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso7790868a12.1;
        Wed, 28 May 2025 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748418144; x=1749022944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLPcSIp/DD1rCYzGKNk0Bn8Y+IA3lzvlJ6bnzdrWQSU=;
        b=mODGx2LY+DBWGmon66D3fqRwsqxc1wMt7G5QSkHPhAejo4lMVdOiHrCIY6Abf+dQyb
         W5frfbIeFreU6u1fybJCOs7onz78KBDEH/UzfWdQqNxNn1z+wW9K4bPB0dpC1t8V/yeV
         lhZWSD1hIjBxrIyhOAz3dBVwW3sPVdyf5gMujXwer12o1lawHJeR7T/RCkaAGo6xAa4/
         fxvCc0G+KsOlbRGx5BSUX0YKCPER/iSs10WyJmRTD30rpUiPn0FsOHqrvdIjek43cNIn
         7CuQIarXLuQ4Rkw247uF/KWTzxGr92vB/mAM12idghl4zcEae4pk8CQ9g2EuDMtztT8s
         16fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748418144; x=1749022944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLPcSIp/DD1rCYzGKNk0Bn8Y+IA3lzvlJ6bnzdrWQSU=;
        b=uY4KJ/NBOfHG+9aJ4hyYxZUnVhBvfALrHGf0G4R4asj3oHF1MtD9ehbqqalJFZSJtC
         FBwTWF8vVDwBerewiJ4qqGzgG5LQJKXtBwJhrc/AYTmhC4yA2E2/rLG7gd5TUabLqJAF
         OwplAx3JWLYpm+0pST7wReyM+637xs1Gd6HUMy44QdnNWoc0R6Mj86H6qpXEFiZAeOdo
         LwvwLp+0PkcNlc54nW1m78zqnK0etWHXwDS574JUS8eXUUc68cC7YOnGAaooMm1xbnmJ
         Z+Hv2WyitCIgcZCbPOTBmHd+TbdrD89MKZ2mLBkL2sD5pXkYFEVI3ZNuQbeWjekydTrZ
         QNow==
X-Forwarded-Encrypted: i=1; AJvYcCVv1V0ZmN0T45P2wqBmV8qaYQTWwWhwi0QLsCTHJ/eAxtfN83EliWM93NnqT9g1DzQ0ZpcCF9+T@vger.kernel.org, AJvYcCW8+pOTqMxebvuGRHWN2LScJogGqiYt/6xUatN9SU7xZDOYe3eZYtCrG/+GHIUHjsF+JNEOnTPGU5Z1UA==@vger.kernel.org, AJvYcCWxCJxczQYduBz6nQXI20/OVzl68nU14MVOB9IHp0ULQuD+xyDVxKUORkIkzb5cIudzJYc=@vger.kernel.org, AJvYcCXyPCkIEgppOSBUDNAIZltWcXWNxU4ISKiD9vtCkQYlhGcm3KbuYwgyERTxSlPljBo8AXnPSyWrSD4tJDP4@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSe7HzO15vtYbvZfdYO7ZJ+vT3iNzVPn+HcaR46cIEUA9v1Cq
	1+TsoxvItqoTB838eiKR+7dh4tbMP8ZsVgM/XYHEenmBAgMhsuGKkVR8
X-Gm-Gg: ASbGnctBibmbBOqVr/vb5cm3XwzIWA2Zw99VGLnyMG5yHQjxoTIqzMIsw1joUZQvh3U
	yDUE/qoa5GJsDZMAIfs8abARE+FEYuBUVOM3qxlZlZ2Hz3k4fz0bdOry/BDEyfuc+vzeW42I2/O
	ZckDIcsTHvqGwhQvBCDYka44Kx5kqXczHBz9zRiVJYuoQdI1FVhqJC5bgJxpi/Z56quQygPMLq6
	qaqG9bbK6TgKT2ysEsSLsPgJf4XSmNLgQDI9j1hU2+K8PSA/zk/vRTxY5Nluu32getmGReyeMfe
	DdUCR2kwE93f3c5mQX5yB6FtvJthKTuuYfYuDRenFp/si0esEd7mMDG6Thz27BUXPzxrMU6aHg=
	=
X-Google-Smtp-Source: AGHT+IH8GIKLi3J19CB1X7s1vCnZGjRCWQBW0YxLPfQlCr0ZehSV3jt8AiU4iunzA8JJZOzdVmuDew==
X-Received: by 2002:a17:907:d643:b0:ad5:3055:a025 with SMTP id a640c23a62f3a-ad85b0518aemr1514904966b.6.1748418144007;
        Wed, 28 May 2025 00:42:24 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6051d5d991esm392479a12.3.2025.05.28.00.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:42:23 -0700 (PDT)
Message-ID: <4d7a307f-d595-4020-8060-f3bc2f8f72ca@gmail.com>
Date: Wed, 28 May 2025 08:43:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
 <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
 <20250528012152.GA2986@system.software.com>
 <CAHS8izMvRrG2wpE7HEyK3t544-wN_h3SC8nGabCoPWj1qCv_ag@mail.gmail.com>
 <20250528050346.GA59539@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528050346.GA59539@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 06:03, Byungchul Park wrote:
...>> Thus abstractly different things maybe should not share the same
>> in-kernel struct.
>>
>> One thing that maybe could work is if struct net_iov has a field in it
>> which tells us whether it's actually a struct page that can be passed
>> to mm apis, or not a struct page which cannot be passed to mm apis.
>>
>>> Or I should introduce another struct
>>
>> maybe introducing another struct is the answer. I'm not sure. The net
> 
> The final form should be like:
> 
>     struct netmem_desc {
>        struct page_pool *pp;
>        unsigned long dma_addr;
>        atomic_long_t ref_count;
>     };
> 
>     struct net_iov {
>        struct netmem_desc;
>        enum net_iov_type type;
>        struct net_iov_area *owner;
>        ...
>     };
> 
> However, now that overlaying on struct page is required, struct
> netmem_desc should be almost same as struct net_iov.  So I'm not sure if
> we should introduce struct netmem_desc as a new struct along with struct
> net_iov.

Yes, you should. Mina already explained that net_iov is not the same
thing as the net specific sub-struct of the page. They have common
fields, but there are also net_iov (memory provider) specific fields
as well.

-- 
Pavel Begunkov


