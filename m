Return-Path: <bpf+bounces-51890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0914DA3AF1C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B3C18918FA
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 01:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC62913AD05;
	Wed, 19 Feb 2025 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vf5gzDRm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844733E1;
	Wed, 19 Feb 2025 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929732; cv=none; b=bGn2olSMZ3DFJQd2bCyMdwxEOJLPeqAmunWOcjGtTB6XxUetZouwMr2hYjnbJIRsh23lzE7urjZuk1S/ddn0QLwh1Wp4IrABH4N0jc0e1eJAJCYwzP05tLXOYGyhDMytM28vubNwr87uC/6YIIi5vNt8IT99qxRYu6lLgPcn5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929732; c=relaxed/simple;
	bh=/6YPLRHm6H9wPjnB667+gK6xaD7arKiwsNiLpHXnheg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVbLiJcBHlJx4RGqJXTLyriEtNbhfZQYcYzsQp6qeOJU89exROIkzZgUOunzZGUjXCYl5W6SL+4W6F0HiTrl4zkn9DjfqpEUsQJZDy6hkZxDGyMN+eifVxYDO4UpFtrX5l7i/C6SMHZQ4cCyfz4myXncqShz00yz4sEnipUZjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vf5gzDRm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739929730; x=1771465730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/6YPLRHm6H9wPjnB667+gK6xaD7arKiwsNiLpHXnheg=;
  b=Vf5gzDRmBVgZMyxxzzBdRiNBQjWVE7xYyrPkKp4FrgJnOeUa+k+HKNPj
   nOu89oBVys7Y/hNEekUgiK4Btf1Eb2qIr3WwG6EF65XiyyNGr0t4r56ac
   1363ExTQnLDdJrVVx/e3uLgG3/pvqvjL9/fB2xjpa/zzS8Ng+ynovAYEc
   cD03Gr1JLUWJhjCTYz/RpDMg8WpytR6Axvyz+G7fpoDOJYr0PJNZhF/fQ
   njyxJa16ryhcS6STv8O4sA6umKXH58X72lhCRT5jzzDqzLCE6QYH867N1
   p5agbLBDIxgp/zBOkBy2X7MAEfA0Bkcne9nZYpsLEorif51yCejikhA8V
   w==;
X-CSE-ConnectionGUID: BIEKtzqLQte2h9cdDVWmzg==
X-CSE-MsgGUID: djNeu0+4TXmQoHl1KlmEKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="66006868"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="66006868"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 17:48:49 -0800
X-CSE-ConnectionGUID: 3tCnTqP2SCm9n+J0hFQeZw==
X-CSE-MsgGUID: pUBD94G+R3qLe0pCfMzcOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114748406"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.64.179]) ([10.247.64.179])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 17:48:36 -0800
Message-ID: <b3e02516-d59c-4ed4-b59d-afa72c23d04b@linux.intel.com>
Date: Wed, 19 Feb 2025 09:48:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 5/9] igc: Add support for frame preemption
 verification
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-6-faizal.abdul.rahim@linux.intel.com>
 <20250217113113.GK1615191@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250217113113.GK1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/2/2025 7:31 pm, Simon Horman wrote:
> On Mon, Feb 10, 2025 at 02:02:03AM -0500, Faizal Rahim wrote:
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> 
> ...
> 
>> +bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc)
>> +{
>> +	u8 smd = FIELD_GET(IGC_TXD_POPTS_SMD_MASK, tx_desc->read.olinfo_status);
> 
> olininfo_status is little-endian, so I think it needs
> to be converted to host byte order when used as an
> argument to FIELD_GET().
> 
> Flagged by Sparse.
> 
>> +
>> +	return smd == SMD_V;
>> +}
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
> 
> ...
> 
>> +static inline void igc_fpe_lp_event_status(union igc_adv_rx_desc *rx_desc,
>> +					   struct ethtool_mmsv *mmsv)
>> +{
>> +	__le32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
> 
> It looks like the type of status_error should be a host byte order integer,
> such as u32.
> 
> Also flagged by Sparse.

Thanks for spotting these, I'll update them.


