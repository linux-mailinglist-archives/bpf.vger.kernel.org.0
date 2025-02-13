Return-Path: <bpf+bounces-51407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31221A33F8F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7FD1887548
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D608221703;
	Thu, 13 Feb 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1T/yWN0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D567221558;
	Thu, 13 Feb 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451271; cv=none; b=RlX4LkZRL1CjKRk+rRLxhN9Z2mgrFMBCqHuEmGZPl+AF1DDySMUjWF+paZOlR9PuBTDqYPbIFo1f9/iPIBhtmaJ47OAHmuNty87vVEXY/GGhZykOCAsYWhLUD8wuxkgeYi2eobLkFVWEMdMIAlsP79T7zPVUplm4as9ULpJRJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451271; c=relaxed/simple;
	bh=UN3Y9x428Mk8h/CXSju3Mtr+T4Cd2Rs3PZKgk+wNRiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhwd0kI/NV6ty1FoewKXaMGacmgqPT5AThv5/mJHCO+ThJEnOJc0UzuehWf6ONsOscoeZ620uhiiZypjiQZGwuRZJIdcUjDQdqkxkUf8uKNx6fcrt35YfE9VcsXKqjBYXY+GJyXGIC71OBBks2HXTsFiTDjK2z28Xqwb/xqYd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1T/yWN0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739451271; x=1770987271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UN3Y9x428Mk8h/CXSju3Mtr+T4Cd2Rs3PZKgk+wNRiA=;
  b=d1T/yWN0G92sRqAYEX3xaQwqApgD/o8kSIcCuyLvRSriiL/c5oBO6YEV
   vqdDEjyC9xsS1df9nc7FCSp2iBJfDwjgyuZBWNL9d6SKfSp81k5mDYpk+
   ItkM+ja5oX2OjwC1prNg79tHMlgGk1SPf/j6NcyBPzcPopyCYAjS4pyRA
   S6XP6OwB5hkH/Fgu4RT/qBBIOky2AiFjS2Ywm4lQvCUQQfc3GLynHNtgz
   NWLiBjGmLVf1natKrFI5xbh73coLdHhGnvUffmfGWe5DYZaHJycPFIRmi
   AQcbTQJesmc6LEsCO/hPOW3CKIWwdj272ooq3/in0OmqcRA3EMomw9z0m
   Q==;
X-CSE-ConnectionGUID: 8D7kJjl+SzqGoMmApzEUrg==
X-CSE-MsgGUID: IlSqQsgsReeKAe7Kf1SKmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40266538"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40266538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:54:30 -0800
X-CSE-ConnectionGUID: hz/02A95Toi+RKP8+COzSA==
X-CSE-MsgGUID: 3oCHI4xJSWuWUpbQsVvUsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150303991"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.42.34]) ([10.247.42.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:54:22 -0800
Message-ID: <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
Date: Thu, 13 Feb 2025 20:54:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
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
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <87cyfmnjdh.fsf@kurt.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/2/2025 8:01 pm, Kurt Kanzenbach wrote:
> On Thu Feb 13 2025, Abdul Rahim, Faizal wrote:
>> On 13/2/2025 6:01 am, Vladimir Oltean wrote:
>>> On Mon, Feb 10, 2025 at 02:01:58AM -0500, Faizal Rahim wrote:
>>>> Introduces support for the FPE feature in the IGC driver.
>>>>
>>>> The patches aligns with the upstream FPE API:
>>>> https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
>>>> https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/
>>>>
>>>> It builds upon earlier work:
>>>> https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.1098888-1-vinicius.gomes@intel.com/
>>>>
>>>> The patch series adds the following functionalities to the IGC driver:
>>>> a) Configure FPE using `ethtool --set-mm`.
>>>> b) Display FPE settings via `ethtool --show-mm`.
>>>> c) View FPE statistics using `ethtool --include-statistics --show-mm'.
>>>> e) Enable preemptible/express queue with `fp`:
>>>>      tc qdisc add ... root taprio \
>>>>      fp E E P P
>>>
>>> Any reason why you are only enabling the preemptible traffic classes
>>> with taprio, and not with mqprio as well? I see there will have to be
>>> some work harmonizing igc's existing understanding of ring priorities
>>> with what Kurt did in 9f3297511dae ("igc: Add MQPRIO offload support"),
>>> and I was kind of expecting to see a proposal for that as part of this.
>>>
>>
>> I was planning to enable fpe + mqprio separately since it requires extra
>> effort to explore mqprio with preemptible rings, ring priorities, and
>> testing to ensure it works properly and there are no regressions.
> 
> Well, my idea was to move the current mqprio offload implementation from
> legacy TSN Tx mode to the normal TSN Tx mode. Then, taprio and mqprio
> can share the same code (with or without fpe). I have a draft patch
> ready for that. What do you think about it?
> 
> Thanks,
> Kurt

Hi Kurt,

I’m okay with including it in this series and testing fpe + mqprio, but I’m 
not sure if others might be concerned about adding different functional 
changes in this fpe series.

Hi Vladimir,
Any thoughts on this ?



