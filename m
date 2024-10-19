Return-Path: <bpf+bounces-42496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B99A4AF2
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 04:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1921C21B3A
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E11CCB25;
	Sat, 19 Oct 2024 02:27:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC519340C;
	Sat, 19 Oct 2024 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729304829; cv=none; b=VLXzDWvK8qzD1+wfheaqC07YbIS+mVi6cuw5Zi9hgocpp4Q+Mywcfym+juQ5InFfdVX16UHYlcvu8MQXY5KVjehoW4uOi20jdCl+ZKIvru9d+FnlXVXafRvz8BCTL8DG59yXSftCSrOKO4g8b6oCVOsLiy7WyYcjDUM2YcBJm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729304829; c=relaxed/simple;
	bh=PuM8/dPucQeciYJoLXX4gm5o9AZ6J+GwyBcWEyxid9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GdI4zg2KgSapqx+4bw6MKM89JNLSqMb96yKDgLWVRFnOPvIc4L8KAeXed++udGmoQBKm3Y+D/+sMnHVbNjR4jbyaUQXJ7CD3gdmRTjzDAk+H8+fiOYK1IBJyQ+S2mv7j105Sm4RvFWXZ1xBXT35NBmVN92UhHRqPUUecOXn2mqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVlmV2sZ5z1j9q7;
	Sat, 19 Oct 2024 10:25:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CF55C1401E9;
	Sat, 19 Oct 2024 10:27:03 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 10:27:02 +0800
Message-ID: <efb013ff-a9dd-07a7-e4e7-87aa19b559ac@huawei.com>
Date: Sat, 19 Oct 2024 10:27:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 net 4/4] ixgbevf: Fix passing 0 to ERR_PTR in
 ixgbevf_run_xdp()
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <vedang.patel@intel.com>,
	<jithu.joseph@intel.com>, <andre.guedes@intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <sven.auhagen@voleatech.de>,
	<alexander.h.duyck@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20241018023734.1912166-1-yuehaibing@huawei.com>
 <20241018023734.1912166-5-yuehaibing@huawei.com> <ZxJTUKmZBAktfWik@boxer>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <ZxJTUKmZBAktfWik@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/18 20:23, Maciej Fijalkowski wrote:
> On Fri, Oct 18, 2024 at 10:37:34AM +0800, Yue Haibing wrote:
>> ixgbevf_run_xdp() converts customed xdp action to a negative error code
>> with the sk_buff pointer type which be checked with IS_ERR in
>> ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
>> plain int return value.
>>
>> Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
>>  1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> index 149911e3002a..183d2305d058 100644
>> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> @@ -732,10 +732,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
>>  				    union ixgbe_adv_rx_desc *rx_desc,
>>  				    struct sk_buff *skb)
>>  {
>> -	/* XDP packets use error pointer so abort at this point */
>> -	if (IS_ERR(skb))
>> -		return true;
>> -
>>  	/* verify that the packet does not have any known errors */
>>  	if (unlikely(ixgbevf_test_staterr(rx_desc,
>>  					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
>> @@ -1044,9 +1040,9 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
>>  	return IXGBEVF_XDP_TX;
>>  }
>>  
>> -static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
>> -				       struct ixgbevf_ring  *rx_ring,
>> -				       struct xdp_buff *xdp)
>> +static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
>> +			   struct ixgbevf_ring *rx_ring,
>> +			   struct xdp_buff *xdp)
> 
> ditto

yuehaibing@localhost:~/code/net$ ./scripts/checkpatch.pl 0004-ixgbevf-Fix-passing-0-to-ERR_PTR-in-ixgbevf_run_xdp.patch
total: 0 errors, 0 warnings, 0 checks, 67 lines checked

0004-ixgbevf-Fix-passing-0-to-ERR_PTR-in-ixgbevf_run_xdp.patch has no obvious style problems and is ready for submission.

> 
>>  {
>>  	int result = IXGBEVF_XDP_PASS;
>>  	struct ixgbevf_ring *xdp_ring;
>> @@ -1080,7 +1076,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
>>  		break;
>>  	}
>>  xdp_out:
>> -	return ERR_PTR(-result);
>> +	return result;
>>  }
>>  
>>  static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
>> @@ -1122,6 +1118,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>>  	struct sk_buff *skb = rx_ring->skb;
>>  	bool xdp_xmit = false;
>>  	struct xdp_buff xdp;
>> +	int xdp_res;
>>  
>>  	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
>>  #if (PAGE_SIZE < 8192)
>> @@ -1165,11 +1162,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>>  			/* At larger PAGE_SIZE, frame_sz depend on len size */
>>  			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
>>  #endif
>> -			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
>> +			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
>>  		}
>>  
>> -		if (IS_ERR(skb)) {
>> -			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
>> +		if (xdp_res) {
>> +			if (xdp_res == IXGBEVF_XDP_TX) {
>>  				xdp_xmit = true;
>>  				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
>>  						       size);
>> @@ -1189,7 +1186,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>>  		}
>>  
>>  		/* exit if we failed to retrieve a buffer */
>> -		if (!skb) {
>> +		if (!xdp_res && !skb) {
>>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>>  			rx_buffer->pagecnt_bias++;
>>  			break;
>> @@ -1203,7 +1200,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>>  			continue;
>>  
>>  		/* verify the packet layout is correct */
>> -		if (ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
>> +		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
>>  			skb = NULL;
>>  			continue;
>>  		}
>> -- 
>> 2.34.1
>>
> 
> .

