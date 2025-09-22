Return-Path: <bpf+bounces-69245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6371B92290
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284CF3B98A1
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E6311595;
	Mon, 22 Sep 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QFOm30+V"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B82C0297;
	Mon, 22 Sep 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557717; cv=none; b=XDL1xYbH+3hmxSn/TvsLXWUUbS2uyVLgd+vFUPIC1MtN3B/qK6gBBxWTkxUneyigaWA2NtFL7gKBm2CwadEb5rDaHx+jPJDoEzhwbfEltThF7JyBWBzyMKa4JRm/1dtBUCgZdNs84ly2y/3w58tjoE0fYFLw9wMWhm+NaNB+GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557717; c=relaxed/simple;
	bh=qUJSPm8DiaD2CuexSbbo4EyeNJEm9ysp5nWrCCxDAXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI50ulQvifqGrUsi/N7Wk3zqBcJrRzNOAoX7bOdJyhmAhD7YW+NJ4B7AA0B14X3uh5PHBfLJjnc87RL16iWL/uGFz0jd0IhMs6FpTmK8bi8obSjTph5SeX8WRjHf/gTpxsj1JTpCOQfor2Eui2NaIksGDeTekKNHiSINX6Aqv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QFOm30+V; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Lj18gndnKjV/lioDLiQhqrxeFzrIk6ZTH6FXErwMvOI=; b=QFOm30+VhZRoo8f5PzgfQK0VC6
	El+1uQi31NSMrJgyi1VHSb10mmHCzffYh63T3LDdSOIxKvB2uIysu2hBqE8yeJ3pI+K/GDIJWVdJ5
	LRm3kRg4wPA920PTHLwTUSekwmwdWrQAi9BbJKKXWzMAU42B+RYMCV30FgUtSgdr4bdbYgqVw+Dkk
	MgRGkKUP5CMise7g7iu3mrG8vX7cz7HUUeWrifoXQ2GxwG8CQ5cm3s6bK/3Cj9EPyBxVeBc3UUHQB
	FJySR5/tMZaRILB1YA4p9FI8qjCIkbyszPMrO9KvFuroe7BJ6d8bAqHzHWnIVuYW6ueZ3i0d8Wm8o
	WPWuBk/A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v0jBx-000D9B-1i;
	Mon, 22 Sep 2025 18:15:05 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1v0jBw-0004lN-0j;
	Mon, 22 Sep 2025 18:15:04 +0200
Message-ID: <15740fe5-65bf-46fa-adbd-a87eb703d6b4@iogearbox.net>
Date: Mon, 22 Sep 2025 18:15:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/20] xsk: Move pool registration into single
 function
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-11-daniel@iogearbox.net> <aNFywr++x9VIgT7W@boxer>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aNFywr++x9VIgT7W@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27770/Mon Sep 22 10:26:19 2025)

On 9/22/25 6:01 PM, Maciej Fijalkowski wrote:
> On Fri, Sep 19, 2025 at 11:31:43PM +0200, Daniel Borkmann wrote:
>> Small refactor to move the pool registration into xsk_reg_pool_at_qid,
>> such that the netdev and queue_id can be registered there. No change
>> in functionality.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Co-developed-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>   net/xdp/xsk.c           |  5 +++++
>>   net/xdp/xsk_buff_pool.c | 16 +++-------------
>>   2 files changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> index 72e34bd2d925..82ad89f6ba35 100644
>> --- a/net/xdp/xsk.c
>> +++ b/net/xdp/xsk.c
>> @@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>>   			      dev->real_num_rx_queues,
>>   			      dev->real_num_tx_queues))
>>   		return -EINVAL;
>> +	if (xsk_get_pool_from_qid(dev, queue_id))
>> +		return -EBUSY;
>> +
>> +	pool->netdev = dev;
>> +	pool->queue_id = queue_id;
>>   
>>   	if (queue_id < dev->real_num_rx_queues)
>>   		dev->_rx[queue_id].pool = pool;
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 26165baf99f4..375696f895d4 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -169,32 +169,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>   
>>   	force_zc = flags & XDP_ZEROCOPY;
>>   	force_copy = flags & XDP_COPY;
>> -
>>   	if (force_zc && force_copy)
>>   		return -EINVAL;
>>   
>> -	if (xsk_get_pool_from_qid(netdev, queue_id))
>> -		return -EBUSY;
>> -
>> -	pool->netdev = netdev;
>> -	pool->queue_id = queue_id;
>>   	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
>>   	if (err)
>>   		return err;
>>   
>>   	if (flags & XDP_USE_SG)
>>   		pool->umem->flags |= XDP_UMEM_SG_FLAG;
>> -
> 
> IMHO all of the stuff below looks like unnecessary code churn.
Ack, will drop it in v2, thx!

