Return-Path: <bpf+bounces-59494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF2FACC2EC
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0013A59A0
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEEC2820B9;
	Tue,  3 Jun 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="t0wsoKtB"
X-Original-To: bpf@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67608271461;
	Tue,  3 Jun 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942602; cv=none; b=fXEUBiQoPuO8cccYCcEpDqyMLdSTwt1ejWbgRMX4odHL7A9UHnKyhiB7Tf+B6x7nUEp/4GtxGq83ZxtedkrxOHvx1t7bwMBkjMepaTdP6OldwfYnkxTGY70P5j4EMnOIB97/jAnbuDGokLYtfgiqj4xN25MmzVaKB2fkI7aUO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942602; c=relaxed/simple;
	bh=f1wdr64U+YYAAV0A3q+bTnD7EkymhsUJyrNJvoSnqdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8rmaNUadsV1v1US8s6kFySgt37tR2s1OR3L5M1zqx3kN7FQfV48FqRsEEDHzMHzaGuZa0vB87u7o7XOQYqxQsGrPKmGXJFNYIuJg65gY+z04Qzbdt+92LW5FT+Iz7goJn74mDzg57IwBBWGfPECWQD0awBMy8LlaBhnJzv6cFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=t0wsoKtB; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=kpNhsEEpaYakShgasw+Rs4IOzaFp5Kk2My7Haocu3t4=; b=t0wsoKtBwKT9CwUbMEuG0OPMeV
	bfboWh5elw9hgOKpjq4QoQeDr50rs2VfLs/ibdPhM987M31bXfsbQy8oV9ulX12gWhvv2gwOZeBUX
	i19Im8r/Jz1iQcqFo0Tpnw/+fRxKbCKTedoDJO4VqsZxCnS0Q0BW4qKo2BC6wrEJIH32sYhonVYnK
	lHbOj0nyX+EVUBeLB9vEct7s0xiUNQkKbfy1jTtpCydjEBGt9CNA9stxdHMguMSYjhs7c6xekV+Q7
	u4idbz2m/Q7XUl/KdAq+4armM27FudgMZB6LvRchCFHfUqvMOGwxi2ymhnO2mvp3/RiLEgJ2KMS04
	OOCU9cao5DrTS4ajyu2aD+6sFGJlXTN7InR5I90dDKTeV0L0Jc1cSfuICdaCNAgU9s2AbAkBv1PdP
	i5Us12UGeh+Y1uMKFVKIzRxt3rIGRtduXdii8BOpubPD9E6S1mbCyKgR6CLpg9El8pXylH9sF9f1V
	6oiagtxX5oANV2cxND3sx9iN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uMNrR-008gCi-1d;
	Tue, 03 Jun 2025 09:23:09 +0000
Message-ID: <3df479c7-e42f-41e1-bc5e-88f3d783c5d1@samba.org>
Date: Tue, 3 Jun 2025 11:22:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 01/18] netmem: introduce struct netmem_desc mirroring
 struct page
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250529031047.7587-1-byungchul@sk.com>
 <20250529031047.7587-2-byungchul@sk.com>
 <CAHS8izNBjkMLbQsP++0r+fbkW2q7gGOdrbmE7gH-=jQUMCgJ1g@mail.gmail.com>
 <20250530011002.GA3093@system.software.com>
 <CAHS8izNPSHR7B24Y3RZiBeZHkPyzKAKdZbQgXwqwgs01HzxDTw@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAHS8izNPSHR7B24Y3RZiBeZHkPyzKAKdZbQgXwqwgs01HzxDTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mina,

>> Do you mean?
>>
>>    struct net_iov {
>>      /* Union for anonymous aliasing: */
>>      union {
>>        struct netmem_desc desc;
>>        struct {
>>           unsigned long _flags;
>>           unsigned long pp_magic;
>>           struct page_pool *pp;
>>           unsigned long _pp_mapping_pad;
>>           unsigned long dma_addr;
>>           atomic_long_t pp_ref_count;
>>        };
>>      };
>>      struct net_iov_area *owner;
>>      enum net_iov_type type;
>>    };
>>
>> Right?  If so, I will.
>>
> 
> Yes, sounds good.
> 
> Also, maybe having a union with the same fields for anonymous aliasing
> can be error prone if someone updates netmem_desc and forgets to
> update the mirror in struct net_iov. If you can think of a way to deal
> with that, great, if not lets maybe put a comment on top of struct
> netmem_desc:

I haven't looked at the patch in detail, but to me it sounds
a bit like the checks io_uring_init is doing.

I hope this is in same way helpful here :-)

metze


