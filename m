Return-Path: <bpf+bounces-52042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2430A3CFD7
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 04:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2623B742E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C511DDC14;
	Thu, 20 Feb 2025 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXFXm8vb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743A10FD;
	Thu, 20 Feb 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020946; cv=none; b=b4M8NYXSaSPYmV88FlfPYEtbvPCc1wamaFc8HiW7S6SBNWmGEFhf8NWB4zAZDPMHcI3OUyeUqat9DswQxHAX4Y201sRTQwKfpzZY5tpA/hDj09SDpdzRGwb2nCe0wo/uTPdlPByld8JO1sahDYGNuZKUPhLPdVgslu1dM59zVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020946; c=relaxed/simple;
	bh=6Om/YQ9BDTJoSdcjeVlNE5mx2TxHgQH+HygQWJDZxTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn7m0ZVvwBcnYEEK5RxbkezoS4MmUTdjnETfVXCYvb81u7DRq22dr4BjPo05wIPgQz24adKU77iNIIMuCOBMkg00SmdSdXbJVM1IowH+P9CzPgbdUJ9/2V6eD0Z7XEdlAtRDTgZK4/8gDRBJabqo8R8xvgLP3kV3HIQNAEw0DlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXFXm8vb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740020944; x=1771556944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Om/YQ9BDTJoSdcjeVlNE5mx2TxHgQH+HygQWJDZxTI=;
  b=WXFXm8vbeEQMlJ5dlpZo3xIcEZEntVRPy3q8yUwyKukTQv5EQX/9VjuQ
   7gMFmQLwmeMbUaKEO64sPLUjHS3uT/0hx+A+48xCJpPh5k/9Idg8Nw/X5
   W59N8FrzdbbwhofL4MSxwz270WiXYeIU7bt9w4TVlFdA2ALWSC0b9yk6V
   b1ETkEOCNDTbFrJNy59soe4Dx9hkEvNfyVFeUDVJnKCslnsg/3TntdsCK
   BZHijUhLxEe7yetixVOcozdwHC+jn/cZx6rtIamH92Ur8l8/aeaKrONuD
   lU3+8jKX6boWH/KAg7nvwlygZFqKDfsEbFnOegs4WfsUXYZr61CEdzJU+
   Q==;
X-CSE-ConnectionGUID: PZlqgtoCSZS426YTQ3aStw==
X-CSE-MsgGUID: YKqVST2OQguKSEEXHlKCgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44433446"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44433446"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:09:03 -0800
X-CSE-ConnectionGUID: NtSLS7/pTki0JlkmiayN3A==
X-CSE-MsgGUID: phFnrHBBQ4u+5LiD6T/d6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114892383"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.77.104]) ([10.247.77.104])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 19:08:56 -0800
Message-ID: <72c1a698-ba1e-44f6-a52f-ef03c7acba06@linux.intel.com>
Date: Thu, 20 Feb 2025 11:08:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/9] igc: Add support for
 Frame Preemption feature in IGC
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
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
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <SJ0PR11MB586651473E7F571ECD54B13BE5FF2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <SJ0PR11MB586651473E7F571ECD54B13BE5FF2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/2/2025 4:59 pm, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Vladimir Oltean
>> Sent: Wednesday, February 12, 2025 11:01 PM
>> To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
>> Alexandre Torgue <alexandre.torgue@foss.st.com>; Simon Horman
>> <horms@kernel.org>; Russell King <linux@armlinux.org.uk>; Alexei
>> Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
>> Jesper Dangaard Brouer <hawk@kernel.org>; John Fastabend
>> <john.fastabend@gmail.com>; Furong Xu <0x1207@gmail.com>; Russell King
>> <rmk+kernel@armlinux.org.uk>; Serge Semin <fancer.lancer@gmail.com>;
>> Xiaolei Wang <xiaolei.wang@windriver.com>; Suraj Jaiswal
>> <quic_jsuraj@quicinc.com>; Kory Maincent <kory.maincent@bootlin.com>;
>> Gal Pressman <gal@nvidia.com>; Jesper Nilsson <jesper.nilsson@axis.com>;
>> Andrew Halaney <ahalaney@redhat.com>; Choong Yong Liang
>> <yong.liang.choong@linux.intel.com>; Kunihiko Hayashi
>> <hayashi.kunihiko@socionext.com>; Gomes, Vinicius
>> <vinicius.gomes@intel.com>; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-stm32@st-md-
>> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
>> bpf@vger.kernel.org
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/9] igc: Add support for
>> Frame Preemption feature in IGC
> 
> Please start commit title from slam letters:
> Igc: add ...

Hi Aleksandr,

I haven't updated this in v5 yet. Could you share any reference or 
guideline for this?

 From what I checked, the recently accepted patches in igc seem to follow a 
similar commit title format as my patches:

$ git log --oneline | grep igc
b65969856d4f igc: Link queues to NAPI instances
1a63399c13fe igc: Link IRQs to NAPI instances
8b6237e1f4d4 igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
484d3675f2aa igc: Allow hot-swapping XDP program
c75889081366 igc: Remove unused igc_read/write_pcie_cap_reg
121c3c6bc661 igc: Remove unused igc_read/write_pci_cfg wrappers
b37dba891b17 igc: Remove unused igc_acquire/release_nvm



