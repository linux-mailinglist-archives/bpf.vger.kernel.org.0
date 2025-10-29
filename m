Return-Path: <bpf+bounces-72673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D0C18006
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735CF1A61C84
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235742E8E03;
	Wed, 29 Oct 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xZp3x1fm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D124C076
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703654; cv=none; b=o01Kyu3qK+r88UHnkZ8zuKloJ6TbbsayoFEmnzlJGj929UyHRElcjdMvjGavTH4oMg6umlB3Yjb9Cp7wKNoz8NRQM0xybT22fWoyFSzF4ydMl2QExHiYaCwQy47PJ5ubkKGN0178eeeRkgHVqXBl13FwyGsRMJ2s3B2GfB/od6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703654; c=relaxed/simple;
	bh=EFi4CIjRYWouw3Fk26EOcbOpV3k1SeYqp8YCwxUMtE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B96ZRWxMskKDxVQLTR3oTBBNoHi3/7ouO7VZ27I1VnOxK4Q03SeaPtytLmaY/QO/oqT93ZsouoNBOk5Zff5fBJjGCl3s5Tb8KI4+O0iMl5vO2zdh1u0M5NyLEVbiVLRqVJyRcksaMVkdhI0F5NiLqfBiSHqfzxtrcpVaPZ6uuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xZp3x1fm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781997d195aso4789796b3a.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761703652; x=1762308452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwbAWeZOQsCnS4wFS3BFGyep219kWlTwBOi+jj07kfQ=;
        b=xZp3x1fmDbHlpr4kwmHKkILJPFPPpYiXIirWdyaHq8eeQedLPp9kz4Oec/3RqkzpVR
         hrzgnYhjdjWinsBnHOlhBNjLNZdbTkgYi+jUA4v+CKgqwsPNL3Wn3PjSq0r56iG9Zl1b
         8OHJPMKWaZEwGzuxsrX7uc55zrJXiEQB+LaQ9CvhIKCREx80+Sh+qS0faMochOmbzIYO
         E4N/f/krEQjgN7TSJBE/gfsj5jEe2H2qjaSLVCzjTOqww9yDOWkpzJsyUxePGxbgPzmP
         E2b7wRCW25QGnaKS3kXBxFzk1/ThJU04+2HNvGRY3Cqu3AnTlDUUsztCMoJS9JXe8833
         qQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703652; x=1762308452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwbAWeZOQsCnS4wFS3BFGyep219kWlTwBOi+jj07kfQ=;
        b=oNicJVXkmghRZxC6FpqCL/L0g5rM+ypXYkVbvOjL+b+gGHOi4HYCmV+Xxvs/ac2l0y
         HYXFu8h/y7KUehQlKDJF4Lw5u3iKjnz3Ret0GMRiJ3bgEVOca7GPkiRVQe4CCv9InDuw
         IvlHKfeV9bBNDUkT2s0ClwUdXxsre9ILHBAFc6ZFrWSjD/JhF7O/chTztOoA9R/F0Qvm
         KCpqskv6DqQUEiC7AZx0vk/20z0leYWn9/RYGsshk1skUidV6HkatB4jZn6UzoLYeyCj
         60MJhgxy3i54H2zQPIu5Q10NYSt00O0VLyCEs8/YaU61lBQOhx2I3HDJGFfKTMZ5CbJJ
         4jAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2OpZhqoZl+6FPhsGkOuJSs2NwBVxJFBNHktXgyJIT6PtKO+4ooRKAxYFtw/VSi1rXllM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFJstazLwU+8r9cG4snalx6eOdF/MdeL6gsfL2v2ESZMxB1N1
	VGf5ed3B67mbfVgrL3n8wQPDcvq5itHVlHIZg++f5L4QEHYBZNkM7yIXzDVUJd71JQw=
X-Gm-Gg: ASbGncuTyk6laXyifpzlbfkauWcQoytDOk+eI+XfQDerQIaAHefZsghZZ3NjJ//ndAh
	Z977gWADmj2QnGt8NlCbC56LwCv0z6lYzflITLWqY36UD1yuJEpQVPNqKU8argKkvJuZFz2NwEU
	cEu3M+IiDUTOBwuQsepmtDM8jZ+Xlm/rx2zLvPefC7wMoa3MBHaYVQ3cpnt/xKc9XlmECh1IHdT
	OVi/2kVSuKQvlGI6NSFRSoHGOjpSzv2b11+cpzWtA9vYDOqCC+rj+nQ8E44a2OSApu0ezvcMsi+
	sXSqhSyIGGlhHNFCmmrfP0bqbCIgaiLd3gQllA2rqfngFnFm5gi29qbrbtxMjPrnwk6bLp7VKCo
	WStmgkQF7yFgFprrD2oTF2QepaL7fjh8p3/ICFTOIGe5kzTWJi1sFVHCkyGThBCTOH5GKupm3ie
	SoZbHkd+hmlpuNkhfU80iscReGJtptSTNm+iTmzbngUUjwPOfAxw==
X-Google-Smtp-Source: AGHT+IHxHyk8ir4DX5MhWD7ZjQz9187JFIEmSz1NBSvx/zbXwsWKBnY2fp2LNqat2VgeWtV++KiolQ==
X-Received: by 2002:a05:6a21:9986:b0:343:8a88:2733 with SMTP id adf61e73a8af0-34653145795mr1640244637.3.1761703652354;
        Tue, 28 Oct 2025 19:07:32 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414032cabsm13256371b3a.22.2025.10.28.19.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 19:07:31 -0700 (PDT)
Message-ID: <bbab235a-826c-4051-930f-e4209da0c067@davidwei.uk>
Date: Tue, 28 Oct 2025 19:07:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-6-daniel@iogearbox.net> <aPvHQYXJ8SGA-lSw@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aPvHQYXJ8SGA-lSw@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-24 11:36, Stanislav Fomichev wrote:
> On 10/20, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> When a process in a container wants to setup a memory provider, it will
>> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
>> to try and restart the queue. At this point, proxy the queue restart on
>> the real rxq in the physical netdev.
>>
>> For memory providers (io_uring zero-copy rx and devmem), it causes the
>> real rxq in the physical netdev to be filled from a memory provider that
>> has DMA mapped memory from a process within a container.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   include/net/page_pool/memory_provider.h |  4 +-
>>   net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
>>   2 files changed, 41 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
>> index ada4f968960a..b6f811c3416b 100644
>> --- a/include/net/page_pool/memory_provider.h
>> +++ b/include/net/page_pool/memory_provider.h
>> @@ -23,12 +23,12 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>>   void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
>>   void net_mp_niov_clear_page_pool(struct net_iov *niov);
>>   
>> -int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
>> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		    struct pp_memory_provider_params *p);
>>   int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      const struct pp_memory_provider_params *p,
>>   		      struct netlink_ext_ack *extack);
>> -void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
>> +void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      struct pp_memory_provider_params *old_p);
>>   void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   			const struct pp_memory_provider_params *old_p);
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> index 8ee289316c06..b4ff3497e086 100644
>> --- a/net/core/netdev_rx_queue.c
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -170,48 +170,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>   		      struct netlink_ext_ack *extack)
>>   {
>>   	struct netdev_rx_queue *rxq;
>> +	bool needs_unlock = false;
>>   	int ret;
>>   
>>   	if (!netdev_need_ops_lock(dev))
>>   		return -EOPNOTSUPP;
>> -
>>   	if (rxq_idx >= dev->real_num_rx_queues) {
>>   		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>>   		return -ERANGE;
>>   	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>>   
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>> +	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx, &needs_unlock);
>> +	if (!rxq) {
>> +		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");
>> +		return -EBUSY;
>> +	}
>> +	if (!dev->dev.parent) {
>> +		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>>   	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>>   		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   	if (dev->cfg->hds_thresh) {
>>   		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto out;
>>   	}
>>   	if (dev_xdp_prog_count(dev)) {
>>   		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
>> -		return -EEXIST;
>> +		ret = -EEXIST;
>> +		goto out;
>>   	}
>> -
>> -	rxq = __netif_get_rx_queue(dev, rxq_idx);
>>   	if (rxq->mp_params.mp_ops) {
>>   		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
>> -		return -EEXIST;
>> +		ret = -EEXIST;
>> +		goto out;
>>   	}
>>   #ifdef CONFIG_XDP_SOCKETS
>>   	if (rxq->pool) {
>>   		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
>> -		return -EBUSY;
>> +		ret = -EBUSY;
>> +		goto out;
>>   	}
>>   #endif
>> -
>>   	rxq->mp_params = *p;
>>   	ret = netdev_rx_queue_restart(dev, rxq_idx);
>>   	if (ret) {
>>   		rxq->mp_params.mp_ops = NULL;
>>   		rxq->mp_params.mp_priv = NULL;
>>   	}
>> +out:
>> +	if (needs_unlock)
>> +		netdev_unlock(dev);
> 
> Can we do something better than needs_unlock flag? Maybe something like the
> following?
> 
> netif_put_rx_queue_peer_locked(orig_dev, dev)
> {
> 	if (orig_dev != dev)
> 		netdev_unlock(dev);
> }
> 
> Then we can do:
> 
> orig_dev = dev;
> rxq = netif_get_rx_queue_peer_locked(&dev, &rx_idx);
> ...
> netif_put_rx_queue_peer_locked(orig_dev, dev);

Thanks, that's a lot cleaner, changed in v4.

