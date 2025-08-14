Return-Path: <bpf+bounces-65617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73208B25E79
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AD11BC1D52
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F932E7199;
	Thu, 14 Aug 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1OvAMrc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206B22D78F;
	Thu, 14 Aug 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159103; cv=none; b=RcJ2N5nsOmEkc2aVP7dxVGS9eI8bGJc5aUHnsZ8QPlV1vgIe7qXcHkr48XV8/xruPyrspw2PvSZdJagEsmEnTDikidcyF8I8Qldd86+zkFmYXla0EsGIktE5C3C8q5SrFlUh1mHw9QdDOFDYGyg6OepTnyimmyxYRR8JGnjXwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159103; c=relaxed/simple;
	bh=/nwd1vSYgyNJx0ptVJqmjDnn54Z2UmVCME9EuIdCn7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/Ep2PRSyV92HrE71EJ6KOx+N7Oip0gZma5scGeaE8nzI3VPQONgr/B37yBUe4OKkqN9I2zhHCGRu1m0ZRpPVuL9/7BQ9ibmZgU1QVDaIydTdJtDO9eQJMJYZCe4x1N1eQPtz0UfW0NZU8XAP4oQXJw9MarWgalZCtRej25WjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1OvAMrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50843C4CEEF;
	Thu, 14 Aug 2025 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755159101;
	bh=/nwd1vSYgyNJx0ptVJqmjDnn54Z2UmVCME9EuIdCn7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b1OvAMrcC1lq1iNLaygGi5yimNb6OChZenTmMCZCgggivJWGcbDZIfyXhGsL5z+wf
	 cpu8ClVNwUFnNxYJmJfVjHWyhrzU9LVGoW0ualz2hgYPvB6n5KHg4dd7s3ADsyYRJH
	 5zNOTdqKWYDfFLc3Ra6lPb9dPNSKgDEb6h6Y5CCL4eUYDLTj9WF86XrMf/V2Pqt0ZT
	 84njqmDOwdMa5mo9I59VlhDso1K4ByhDIxg3SC3XOlpFHuLAkS1aGK6A1l56CzFKP5
	 Y2Aj/fN2aF6FPHm+WxIRZ2DjXD+gNQ3q6nFqTy9YUUluwD8qoZ8lVpY4p83AMev14m
	 0reXZEhZGhZ+g==
Message-ID: <902cf005-7731-4a20-9cb1-287318ab8a9a@kernel.org>
Date: Thu, 14 Aug 2025 10:11:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo@kernel.org, toke@redhat.com, john.fastabend@gmail.com,
 sdf@fomichev.me, michael.chan@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com, tariqt@nvidia.com,
 mbloch@nvidia.com, eperezma@redhat.com
References: <20250812161528.835855-1-kuba@kernel.org>
 <46470d2b-4828-48ad-a94e-9d874de1b2fc@intel.com>
 <2ba29c9f-a44f-4be6-bd3a-eb9cdb34ac8a@kernel.org>
 <20250813144439.71a09e9a@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250813144439.71a09e9a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/08/2025 23.44, Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 10:43:21 +0200 Jesper Dangaard Brouer wrote:
>>>> Does anyone prefer the current form of the API, or can we change
>>>> as prosposed?
>>
>> I like the proposed change.
>> The only thing that confuses me was that the u32 flags is named
>> "skb_flags" and not "xdp_flags".
>>
>> @@ -314,7 +313,7 @@
>>    static inline void
>>    xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>>    			   unsigned int size, unsigned int truesize,
>> -			   bool pfmemalloc)
>> +			   u32 skb_flags)
> 
> It was matching the helper names: xdp_buff_get_skb_flags()
> 
> If we rename it to xdp_flags here do you want me to keep
> the helpers (xdp_buff_get_flags()?) or access buf->flags
> directly in the caller?
> 
> The idea was that the helper could filter / transform
> the flags to whatever the update function takes. And the skb_
> in the helper name was matching the skb_ of the arg.
> 

It makes sense to have a helper, as you argue.

>>>> Bonus question: while Im messing with this API could I rename
>>>> xdp_update_skb_shared_info()? Maybe to xdp_update_skb_state() ?
>>>> Not sure why the function name has "shared_info" when most of
>>>> what it updates is skb fields.
>>>
>>> I can only suspect that the author decided to name it this way due to
>>> that it's only used when xdp_buff has frags (and frags are in shinfo).
>>> But I agree it's not the best choice. xdp_update_skb_state() sounds fine
>>> to me, but given that it's all about frags, maybe something like
>>> xdp_update_skb_frags_info/state() or so?
>>
>> Yes, function is only used when skb_shared_info have already been touched.
>>
>> Performance wise it can be expensive to touch the cache-line for
>> skb_shared_info, so the code carefully checks xdp_buff_has_frags() (flag
>> XDP_FLAGS_HAS_FRAGS) before deref of skb_shared_info memory area.
>>
>> Calling it xdp_update_skb_state() seems misleading. As Olek says, this
>> is about updating the "skb_frags".  The original intent is that
>> xdp_buff/xdp_frame is using same skb_shared_info area as SKB, and when
>> transitioning to a "full" SKB then we need to do some adjustments.
>> (Looking at function code, it is of-cause confusing that it doesn't
>> touch sinfo->frags[] array, but that is because we don't need to, as
>> non-linear XDP and SKB have same layout.).
> 
> Let's go with xdp_update_skb_frags_info(), then.

Fine with me. It was Olek's naming suggestions (and I liked both).

Thanks
--Jesper


