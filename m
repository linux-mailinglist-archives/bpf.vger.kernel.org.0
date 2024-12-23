Return-Path: <bpf+bounces-47543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6D9FAC16
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA5F7A125E
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302E192D87;
	Mon, 23 Dec 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVdK1X/i"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030A1714B4;
	Mon, 23 Dec 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946805; cv=none; b=UbmZD6WauWWgn+HO2nr6fG2cazsawTzsUwxGI19WLnjDjp+S0CPVz3FzzmFSMZfaTJEI009NtGLMoaF3L04P8KjkR74KA6kgrb50ONgplwjjUfiCTotjfSSpF+l2u/qQehyCn4Al+ozQkDKBloW+8Y/F4nHv0DdMqw5u61FXp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946805; c=relaxed/simple;
	bh=2omx7q+d9wt2CP8RSFFkgd8MZk41Pv7OsthACrhz1f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovIjpMVEsWtfuxwST79/tN2Lma9FfoBwbozDdjsJC8mnM9T37/ACbBoiEcg3IKclw3zj89FF9PFWP77A4wPhPn1kxUD/STs0Vp6O3rc/oUpr5KN58ws1R5qfWOGbeHFFSxVattKwzXMbNqfnPc8+xYEyEc0YZo2UcvSQa/4uQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVdK1X/i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734946803; x=1766482803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2omx7q+d9wt2CP8RSFFkgd8MZk41Pv7OsthACrhz1f8=;
  b=OVdK1X/ioxluwre0Z9O4Fq8aVR0zkJcp6AzYABjokVubnbmETWK//2R4
   DiMEIlG36olvm0Ng4id9YE9a9pLXQpLkR57rXEP+efc0VqTMFCmj4+OIp
   9BjezwtSo9fvtlXTGQJ9vi3DIzeZw2OK5PbjwRSzn+cH+9Ow21qZ7sTFN
   Z4xGNDE0kw8kSZkbPD2w7KYiLIrKYcPmTT0jJfb+1PGHNhTcBBLrpMbiB
   9fqbDBe1242xKwHYGPrrJVRT9an5cYacr7T6mFbHT+cwTKlJN+4noUnUE
   YGKJdmjpg/2S++f/bZrvEYB6kmD0cBGqjqZqUXLShyWhCUxGPfmvEUE9Y
   w==;
X-CSE-ConnectionGUID: ETUlHA7VTwe1YgAZj7xwjw==
X-CSE-MsgGUID: S6hmrVd+S0OTHtQQE7iIwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="35545383"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="35545383"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:40:02 -0800
X-CSE-ConnectionGUID: 29f3HbCCSKi3cAVBRgihfg==
X-CSE-MsgGUID: Pqu9tHU8T52pPNZhFPYHMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100009050"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.22.166]) ([10.247.22.166])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 01:39:59 -0800
Message-ID: <c9a5a458-6015-442f-988d-c4b830dabd01@linux.intel.com>
Date: Mon, 23 Dec 2024 17:39:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 8/9] igc: Add support to get MAC Merge data via
 ethtool
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-9-faizal.abdul.rahim@linux.intel.com>
 <20241217003501.ar3nk6utdjllqjbk@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20241217003501.ar3nk6utdjllqjbk@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/12/2024 8:35 am, Vladimir Oltean wrote:
> On Mon, Dec 16, 2024 at 01:47:19AM -0500, Faizal Rahim wrote:
>> Implement "ethtool --show-mm" callback for IGC.
>>
>> Tested with command:
>> $ ethtool --show-mm enp1s0.
>>    MAC Merge layer state for enp1s0:
>>    pMAC enabled: on
>>    TX enabled: on
>>    TX active: on
>>    TX minimum fragment size: 252
>>    RX minimum fragment size: 252
> 
> I'm going to ask "why so high?" and then I'm going to answer that I
> suspect this is a positive feedback loop created by openlldp, because of
> the driver incorrectly reporting:
> 
> - 60 as 68, ..., 252 as 260, and openlldp always (correctly) rounding up
>    these non-standard values to the closest upper multiple of an
>    addFragSize, which is all that can be advertised over LLDP
> - on RX what was configured on TX (see below), which in turn makes the
>    link partner again want to readjust (increase) its TX, to satisfy the
>    new RX requirement
> 
> But I'm open to hearing the correct answer, coming from you :)
> 

Actually ... it was so high 252 ... because I mistakenly copied the result 
from my past openlldp test that did:			
sudo lldptool -T -i enp1s0 -V addEthCaps addFragSize=3
Which sets is to 252 ..sorry causing confusion

Without OpenLLDP, with just ethtool and with default tx min frag size, it 
will look like:			
user@localhost:~$ sudo ethtool --show-mm enp1s0
MAC Merge layer state for enp1s0:
pMAC enabled: off
TX enabled: off
TX active: off
TX minimum fragment size: 68
RX minimum fragment size: 68
Verify enabled: off
Verify time: 10
Max verify time: 128
Verification status: DISABLED

When verify handshake is done with OpenLLDP, it will look like:
user@localhost:~$ sudo lldptool -t -i enp1s0 -V addEthCaps
Additional Ethernet Capabilities TLV
         Preemption capability supported
         Preemption capability enabled
         Preemption capability active
         Additional fragment size: 1 (124 octets)

user@localhost:~$ sudo ethtool --show-mm enp1s0
MAC Merge layer state for enp1s0:
pMAC enabled: on
TX enabled: on
TX active: on
TX minimum fragment size: 124
RX minimum fragment size: 124
Verify enabled: on
Verify time: 128
Max verify time: 128
Verification status: SUCCEEDED

Which makes sense, due to the rounding up 68 to the closest upper multiple 
of addFragSize which is 124 octet in OpenLLDP, as what you mentioned.


>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index 7cde0e5a7320..16aa6e4e1727 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -1782,6 +1782,25 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
>>   	return 0;
>>   }
>>   
>> +static int igc_ethtool_get_mm(struct net_device *netdev,
>> +			      struct ethtool_mm_state *cmd)
>> +{
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +	struct fpe_t *fpe = &adapter->fpe;
>> +
>> +	cmd->tx_min_frag_size = fpe->tx_min_frag_size;
>> +	cmd->rx_min_frag_size = fpe->tx_min_frag_size;
> 
> This is most likely a mistake. rx_min_frag_size means what is the
> smallest fragment size that the i225 can receive. Whereas tx_min_frag_size
> means what minimum fragment size it is configured to transmit (based,
> among others, on the link partner's minimum RX requirements).
> To say that the i225's minimum RX fragment size depends on how small it
> was configured to transmit seems wrong. I would expect a constant, or if
> this is correct, an explanation. TI treats rx_min_frag_size != ETH_ZLEN
> as errata.
> 

My bad.
I got your point, it's clearly explained, thanks :).
Just got to know i226 is able to handle any frag size for RX.
Since standard for min TX is 60, I'll use 60 then.

