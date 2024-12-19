Return-Path: <bpf+bounces-47307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6669F7565
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179DA189573D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783A3217708;
	Thu, 19 Dec 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgTK/ZXq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA3217673;
	Thu, 19 Dec 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593090; cv=none; b=YHB6H3SPSkuU9OQoA4DburBHn0f2neBu1poFxS6wwLKkrwkwQyv1SrowM8UeXOKHZ6qRTVU9Mg7eN/tTOQftpx8WvMr02ygfl6uX7V5NEkwlRs3MOpLjT7W9lwtNhcm0oS2dcVsZJfX84b0WTHcB/K9jh1my1D5RmsHHXgvShsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593090; c=relaxed/simple;
	bh=oZqFuW7QFS4Vc/TSp3AxQi8Ft5gm5pNg6tJATdW+lY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5EJvq+ewLYOqR3LA86L3TCpIfNads1NPRElFUwwxXcGmoP5dHcZPP2KsFT4cKrmh06EFTBZvLJ11zT81q0vJw2HTSeIcRusf9EAdSzQbY4V+XYBQ7zPfuJaIUosKgx7DIQolQmoE5UefgcnsAFW2r3J3a+Yd+0PpZW+17WWKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgTK/ZXq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734593087; x=1766129087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZqFuW7QFS4Vc/TSp3AxQi8Ft5gm5pNg6tJATdW+lY0=;
  b=IgTK/ZXqwLmzHFjyZeJciYszJLMkacb69QA4oAAf8m8gRa/JYKPyZWq5
   i5tgKgelct9jIFWUvgVUZCFk3XToBBNLaJTyiNdYgRBu4rQysh39e7x1X
   zZd27+Evm78M3vhFqq5D8L3/Ad/8xByhifOZwgnIRoIOJNzGNKf+/Cpla
   lzLL0NObvClR3F8d3mI2y+Qbllhpsvf83kBcMITlCqqJTX1Y10qHGdVo0
   AK6+soIj+SOkT119JdySdaTwITgPIEq2+YbUnbtzh2ppcoLAi0sdN3pdX
   AsBi4Ecu04nng32eKQ2o+0n0y4NgvR+kDEzOOP/mQHU90DrUg14DM/wIy
   w==;
X-CSE-ConnectionGUID: b5YJGz8OQiOp+0TCp7v5jg==
X-CSE-MsgGUID: OYDniWguS82TG4t2pANRXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35120986"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="35120986"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:24:46 -0800
X-CSE-ConnectionGUID: XiIO2PtrQJSFbBfzd+zw4Q==
X-CSE-MsgGUID: c207iclTSYiTooKVnU97ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98013114"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.82.175]) ([10.247.82.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 23:24:43 -0800
Message-ID: <1bc573ec-1f69-4fc6-9bb4-c0a4c38c10aa@linux.intel.com>
Date: Thu, 19 Dec 2024 15:24:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 6/9] igc: Add support for frame preemption
 verification
To: Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
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
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241217002254.lyakuia32jbnva46@skbuf> <20241217200952.000059f2@gmail.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <20241217200952.000059f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/12/2024 8:09 pm, Furong Xu wrote:
> On Tue, 17 Dec 2024 02:22:54 +0200, Vladimir Oltean <olteanv@gmail.com> wrote:
> 
>> Anyway, while browsing through this software implementation of a
>> verification process, I cannot help but think we'd be making a huge
>> mistake to allow each driver to reimplement it on its own. We just
>> recently got stmmac to do something fairly clean, with the help and
>> great perseverence of Furong Xu (now copied).
>>
>> I spent a bit of time extracting stmmac's core logic and putting it in
>> ethtool. If Furong had such good will so as to regression-test the
>> attached patch, do you think you could use this as a starting place
>> instead, and implement some ops and call some library methods, instead
>> of writing the entire logic yourself?
>>
> 
> I am quiet busy these days, especially near the end of the year :)
> 
> Maybe I can help testing the attached patch when the next time net-next opens.
> 
> Thanks.
> 

I'm a colleague of Faizal and I'd be happy to help out with testing the 
patch. I'll take care of testing it on the stmmac side and will sort out 
any issues that come up. If there are any necessary fixes or improvements, 
I'll handle those and provide feedback accordingly.

