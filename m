Return-Path: <bpf+bounces-53563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE901A566AE
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E611188AB5A
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945C218587;
	Fri,  7 Mar 2025 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfT9wrkP"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43862215197;
	Fri,  7 Mar 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346779; cv=none; b=HHjWnkRB64hxc1Pm2jjOhi2mTaAizYXENtZvSig5rG65dqQqOikY3qL9RJL7iucJldJbI7LYI7fCKGGm2Qw4ZzA4Df/VyF1/kxK5GKHJELa55QcOoEvenJ0XCmUOsbo8Qm/Kl+SppX9fjocApfFdY6zROptpZFjI19jxV0wb8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346779; c=relaxed/simple;
	bh=IRGd/73/547JbPgxOPTPAv9MDN91O+zWBBkgec1T5PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV3jb9j4dq4OEfQ++/gJPOXeB/H119/sps9vo+ZXdgNZpoB/ALF4OzLBov1cpOUYK8LjnG1UAyC9q8pcK/9PYlfPxi7+EXrDmRurgZQ3hs1p48BbKoCKipQV99c0i+nRumSDa+RS4D4i8CfZyjW2B5ewlUAk7x0axFs783eeL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfT9wrkP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741346778; x=1772882778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IRGd/73/547JbPgxOPTPAv9MDN91O+zWBBkgec1T5PM=;
  b=ZfT9wrkP7yX8TH16Ym4ahcJ/BP5iWSetMCIK7Uf3qtoxyXFnZJ+R56g4
   E93Gide/UGHNTF18fQWov90qYU62Q37FDzEI+cIV0qK8idhini/W5f3uB
   qoLAAG3iqC6rxkuZnNldPq5h4ZBYwggONqpRnoSaooYt7ol6wD9H9juK4
   JeNROQDgV6Nk05pfSWwIXuuvv8f2zy0J+XymV3gCVnLBLzEMDtrTa1bkw
   ugT+WK5UMXiPjNtvgRaYgjwLD8t4exCk/xG/sQlsv/MaKQtlNnzjEIf1C
   sFBDyJ9nk15KghGhkvm5L6OEttg2JeLhnC+hYUGgFYhXrWpFxaU3SvUf6
   Q==;
X-CSE-ConnectionGUID: YobadY4ITa2bLyH1scJmEA==
X-CSE-MsgGUID: uBF00zRXTk2GoIhuGCt6MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52598946"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="52598946"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:26:15 -0800
X-CSE-ConnectionGUID: MhGzflfcR5uwjOmgTHfi1w==
X-CSE-MsgGUID: RXDB3iloTN6BhM+AbCLNOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="123891784"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.100.177]) ([10.247.100.177])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:26:08 -0800
Message-ID: <152e48f6-e68d-4de4-8170-3f35df1ddd1d@linux.intel.com>
Date: Fri, 7 Mar 2025 19:26:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v8 08/11] igc: add support to set
 tx-min-frag-size
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-9-faizal.abdul.rahim@linux.intel.com>
 <20250306004301.evw34gqoyll36mso@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250306004301.evw34gqoyll36mso@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/3/2025 8:43 am, Vladimir Oltean wrote:
>> diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
>> index ad9b40034003..4c395cd949ab 100644
>> --- a/net/ethtool/mm.c
>> +++ b/net/ethtool/mm.c
>> @@ -153,7 +153,7 @@ const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1] = {
>>   	[ETHTOOL_A_MM_VERIFY_TIME]	= NLA_POLICY_RANGE(NLA_U32, 1, 128),
>>   	[ETHTOOL_A_MM_TX_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
>>   	[ETHTOOL_A_MM_PMAC_ENABLED]	= NLA_POLICY_MAX(NLA_U8, 1),
>> -	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]	= NLA_POLICY_RANGE(NLA_U32, 60, 252),
>> +	[ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]	= NLA_POLICY_RANGE(NLA_U32, 60, 256),
> 
> Please make this a separate patch with a reasonably convincing
> justification for any reader, and also state why it is a change that
> will not introduce regressions to the other drivers. It shows that
> you've done the due dilligence of checking that they all use
> ethtool_mm_frag_size_min_to_add(), which errors out on non-standard
> values.
> 
> To be clear, extending the policy from 252 to 256 is just to suppress
> the netlink warning which states that the driver rounds up the minimum
> fragment size, correct? Because even if you pass 252 (the current
> netlink maximum), the driver will still use 256.
> 
I originally changed 252 to 256 because our internal validation failed when 
setting 256 via ethtool. The test case was based on our old kernel OOT 
patches code, but this run was done on the upstreamed FPE framework plus 
this series. After thinking about it, it doesn’t seem right to change this 
just to accommodate the i226 quirk in a common layer when the IEEE standard 
and other devices use 252.

So, we’ll update our validation to use 252 instead. The driver already 
rounds up to 256 anyway. I’ll drop this change in the next revision.

Also, noted your point about being cautious with changes that impact other 
drivers.

Thanks.

