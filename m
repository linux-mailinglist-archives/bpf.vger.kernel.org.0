Return-Path: <bpf+bounces-53305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50804A4FEA9
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FBD7A555E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6514424502F;
	Wed,  5 Mar 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLrVVClc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F073133987;
	Wed,  5 Mar 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178047; cv=none; b=d8Cz9fsUcTCaWtTkQayrOFTbJrzL2MfkNwh+b8hP9XvrPb6RFQapIVgcuvASjjoLryAVmwb6T4XqIXY07EvgMRVT2buNmnmQzPB+lSYQseX4Ue4LJKxj7nfsnCyk9m9OAwR7VxCh7Kv4y4FHsNN+X7H2+KKUyj+6Ksu8VuNhn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178047; c=relaxed/simple;
	bh=KXz7qN+UCvg/zXe/kDPAg/cy+msMPeJPVH/lqPdGHTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ55wi2Gm/t4nrSDsS78f2AdvWH+HoXQ5QRsh8xUt5Ly0Ynrrrw3N4xSWDzfdrKU/WbPfh2W1H4aVd8tSgpznRhZ9EN6oaNS6ZicjP7Zi7ivmEcpNjEbU9YyOhDQDwtZlTKbxe4b9BFwYeHhhVS0sIzTeypupJFvH7vBh0p9Pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLrVVClc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741178046; x=1772714046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KXz7qN+UCvg/zXe/kDPAg/cy+msMPeJPVH/lqPdGHTo=;
  b=bLrVVClcoy9z6vn3AvQfNDWHz6TlGLBX5Xi02/RIsj93kC7Cg80ZdtMJ
   QRCRahzkmZ6E5sPNioVeJZNMh+cNyOeC4YPmmICGwlxXTK30a4xxBFdP0
   Hvc6N6mnIgtvEKU2Z/IvPCaLkxc+jJhBFNVkfNk23eSG1XzwiagLpFGWe
   EVCucO21LIypBMlGLFqXy/mS7SpcJGnX1ESYaznf9Lk74j0s0xYdzhpjr
   cKEEyTMffiqUek0wrRx0bd9oog4yRd/AyxBN1L0g2Ez1pPepPH36EVSwC
   cq8Q6+QsO2nQlJmeHGebnpTz29eBGBotOPB/2x9eTJLWLnDD/kBjXOwo4
   w==;
X-CSE-ConnectionGUID: GP1ghgVVSB6dFWu866pgpw==
X-CSE-MsgGUID: THJlhIFHRze8D5E+f6Kgvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46064865"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="46064865"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 04:34:05 -0800
X-CSE-ConnectionGUID: N7Xoy4TzQJysW2kMb1XEUQ==
X-CSE-MsgGUID: eBSnBMUbTKa2RR8mn5mMOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118829798"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.123.55]) ([10.247.123.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 04:33:58 -0800
Message-ID: <4882bd5b-1a64-4ac7-ba51-66143d029e8a@linux.intel.com>
Date: Wed, 5 Mar 2025 20:33:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v7 5/9] igc: Add support for frame preemption
 verification
To: Vladimir Oltean <vladimir.oltean@nxp.com>, ",chwee.lin.choong"@intel.com
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
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
 <20250303102658.3580232-6-faizal.abdul.rahim@linux.intel.com>
 <20250304152644.y7j7eshr4qxhmxq2@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250304152644.y7j7eshr4qxhmxq2@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/2025 11:26 pm, Vladimir Oltean wrote:
> On Mon, Mar 03, 2025 at 05:26:54AM -0500, Faizal Rahim wrote:
>> +static inline bool igc_fpe_is_verify_or_response(union igc_adv_rx_desc *rx_desc,
>> +						 unsigned int size)
>> +{
>> +	u32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
>> +	int smd;
>> +
>> +	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
>> +
>> +	return (smd == IGC_RXD_STAT_SMD_TYPE_V || smd == IGC_RXD_STAT_SMD_TYPE_R) &&
>> +		size == SMD_FRAME_SIZE;
>> +}
> 
> The NIC should explicitly not respond to frames which have an SMD-V but
> are not "verify" mPackets (7 octets of 0x55 + 1 octet SMD-V + 60 octets
> of 0x00 + mCRC - as per 802.3 definitions). Similarly, it should only
> treat SMD-R frames which contain 7 octets of 0x55 + 1 octet SMD-R + 60
> octets of 0x00 + mCRC as "respond" mPackets, and only advance its
> verification state machine based on those.
> 
> Specifically, it doesn't look like you are ensuring the packet payload
> contains 60 octets of zeroes. Is this something that the hardware
> already does for you, or is it something that needs further validation
> and differentiation in software?

The hardware doesn’t handle this, so the igc driver have to do it manually. 
I missed this handling, and Chwee Lin also noticed the issue while testing 
this patch series—it wasn’t rejecting SMD-V and SMD-R with a non-zero 
payload. I’ll update this patch to include the fix that Chwee Lin 
implemented and tested. Thanks.

