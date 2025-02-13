Return-Path: <bpf+bounces-51369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4BA337C2
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE28168A3B
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB520766E;
	Thu, 13 Feb 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3B6dGVa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A24A01;
	Thu, 13 Feb 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427180; cv=none; b=Vax6Fs07RbM41tJKBTUbpqQu3rELlB7bwTKTL6jJcayf0SzMGqstoy+2vsjPKH6rb63YWw5/JhltosQmTDf0CuJIXSExx6PRoZK8JVGr5DZswDPXu3aSIwss3K3Or2Rj5QPS+6V6Tm3YHKyqKyeDVNlnKsGtF4QT0NFTrtwDFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427180; c=relaxed/simple;
	bh=GEJZwnWqsIMq3HKET1mdxf8SV5zMREPN381jd4cLlhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn4RZAfOJVx1Z/nn+STINzCxIH/ROxnSXN3DctvPzulWG0dQ6PgoZus0nYbKf5JUenms/zq7dYQnJN9yLk4wR5jQQJQC2HODjrb7PegFoaHG63a8ubY+TCUrKRUmN1W6x3oqYKbXiF0F0qS1ZQ49WqbOvBRDb/ZHsIBxkm+btgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3B6dGVa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739427178; x=1770963178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GEJZwnWqsIMq3HKET1mdxf8SV5zMREPN381jd4cLlhM=;
  b=Y3B6dGVaf4XgFtsnu/SpHcDfNJF19sAkVqkorop83pyJdV0+xMg2Tu1E
   obdbhTVAHJtorV2VsusW2Jfblde7oZpQamVkmiEEnQu5sW5PfjmepNVVG
   mhgQZ9+EC89hQemYNtLl8H2/hjv5I2Z4zdu6rNzYlT3Ag3JIMspKPlO8I
   sZLgaIYBpSwGWdHMJdzmponi27jrRGLrMdet5eAV+w4SSoQnhk0RYsB81
   N1tSPmrdF1vsHlllWh3uL/JoWufAErP0AP33N/WCTrme5f4RX9yY9T2Ll
   F/yvo+s1GT779sHSZ2y1t/fq0wzL9UW+EFN0TLHfIuqT9E0TvSySAd5B9
   A==;
X-CSE-ConnectionGUID: Un/3OUz1QB2/kYlJ4JVB3w==
X-CSE-MsgGUID: LPmm1REwTSuOj3+C7ySsqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="44046217"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44046217"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:12:57 -0800
X-CSE-ConnectionGUID: bkfrU6y2QB2L4ycTkHh9VA==
X-CSE-MsgGUID: VzfZiVD2SRO52yQ6ry9WDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117156622"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.42.34]) ([10.247.42.34])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:12:50 -0800
Message-ID: <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
Date: Thu, 13 Feb 2025 14:12:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
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
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250212220121.ici3qll66pfoov62@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/2/2025 6:01 am, Vladimir Oltean wrote:
> On Mon, Feb 10, 2025 at 02:01:58AM -0500, Faizal Rahim wrote:
>> Introduces support for the FPE feature in the IGC driver.
>>
>> The patches aligns with the upstream FPE API:
>> https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
>> https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/
>>
>> It builds upon earlier work:
>> https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.1098888-1-vinicius.gomes@intel.com/
>>
>> The patch series adds the following functionalities to the IGC driver:
>> a) Configure FPE using `ethtool --set-mm`.
>> b) Display FPE settings via `ethtool --show-mm`.
>> c) View FPE statistics using `ethtool --include-statistics --show-mm'.
>> e) Enable preemptible/express queue with `fp`:
>>     tc qdisc add ... root taprio \
>>     fp E E P P
> 
> Any reason why you are only enabling the preemptible traffic classes
> with taprio, and not with mqprio as well? I see there will have to be
> some work harmonizing igc's existing understanding of ring priorities
> with what Kurt did in 9f3297511dae ("igc: Add MQPRIO offload support"),
> and I was kind of expecting to see a proposal for that as part of this.
> 

I was planning to enable fpe + mqprio separately since it requires extra 
effort to explore mqprio with preemptible rings, ring priorities, and 
testing to ensure it works properly and there are no regressions.

I’m really hoping that fpe + mqprio doesn’t have to be enabled together in 
this series to keep things simple. It could be added later—adding it now 
would introduce additional complexity and delay this series further, which 
is focused on enabling basic, working fpe on i226.

Would that be okay with you?


