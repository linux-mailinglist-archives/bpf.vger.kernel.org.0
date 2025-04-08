Return-Path: <bpf+bounces-55467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA2A80FE1
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E36C8A3621
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D42229B0E;
	Tue,  8 Apr 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLxlZYQU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFE1E1C1F;
	Tue,  8 Apr 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125634; cv=none; b=msVlMXdcRr65mE7GG11arUCXk8hmWRdxrFfPNt1LplSRSzf7IpWhVYhIVPXNzziaYOMRrqEKcfJSqkXQB/Nkv8svEtcYtV7Dkhf/y8LXl0stpnLi3zTAXdD/eEl4zgMQgbGQ7hf0HbgdLXTQxy7OfF55F9DtInL441V4D6P6vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125634; c=relaxed/simple;
	bh=RjTQGPChAQJpmp4ZrVGRKNih4sfRynaA9NDzB/LSN68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E274uJcXVtjozSz7StERRQ95ICk+ZfEHjd6m02FrR/iLocu2CNTFQuhP//xfpH3Y69R5fg547D/GW8cUceHOv0CIhYrRrgfxGiEer9Qoxgs/rxN9kWG/e/AIN4EbUwMHCVKNY625S6AxXddn0z8K4mmsmhFsGoOV3ipTOvSyKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLxlZYQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2232CC4CEE5;
	Tue,  8 Apr 2025 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744125633;
	bh=RjTQGPChAQJpmp4ZrVGRKNih4sfRynaA9NDzB/LSN68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WLxlZYQUPErh2570gCzrulwWdfTJOCaEJ87ODq4eetet+gogU18zi7tKQEWYSahhu
	 3waZuFqnkVHcrmLBnYHWnO39QvUOTsKgqF4Lz5mt4+rYStCYGXA96e8vkTcfS3vXCe
	 TcxdPB/IgChCGWPhN9t1GSHBKNBtFb/trEM//u54CTAHOawVMeaylvRM5eXDSCFugZ
	 nN+tUHfDPTFROB6f0GOEE9i/7jJ4RReho/eba/xF9i01Ws4iVyVIq0emyPvpHHvZf7
	 bCthUI8TNnGT9PRq6q0YbcY5FM8MRKIR7xuT5gilOsvsuS8J35kf7KEBAwzIC7GDkt
	 CHK7JWja5UGJw==
Message-ID: <55a2ea3c-30fb-497f-b373-22394df52576@kernel.org>
Date: Tue, 8 Apr 2025 09:20:32 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
 <87a58sxrhn.fsf@toke.dk> <c908ce17-b2e9-472e-935c-f5133ddb9007@kernel.org>
 <87h62yx5gd.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87h62yx5gd.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 5:23 AM, Toke Høiland-Jørgensen wrote:
> David Ahern <dsahern@kernel.org> writes:
> 
>> On 4/7/25 3:15 AM, Toke Høiland-Jørgensen wrote:
>>>> +static inline bool txq_has_qdisc(struct netdev_queue *txq)
>>>> +{
>>>> +	struct Qdisc *q;
>>>> +
>>>> +	q = rcu_dereference(txq->qdisc);
>>>> +	if (q->enqueue)
>>>> +		return true;
>>>> +	else
>>>> +		return false;
>>>> +}
>>>
>>> This seems like a pretty ugly layering violation, inspecting the qdisc
>>> like this in the driver?
>>
>> vrf driver has something very similar - been there since March 2017.
> 
> Doesn't make it any less ugly, though ;)

in my eyes, it is a thing of beauty.

> 
> And AFAICT, vrf is doing more with the information; basically picking a
> whole different TX path? Can you elaborate on the reasoning for this (do
> people actually install qdiscs on VRF devices in practice)?

It is not common AFAIK, but it is possible. I wanted to avoid the
overhead for what I think is a rare configuration.

