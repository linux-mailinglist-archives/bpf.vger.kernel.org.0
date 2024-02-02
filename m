Return-Path: <bpf+bounces-20994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC4846633
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0271C239CD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E257CA69;
	Fri,  2 Feb 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZZiWmmc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E74C2CD;
	Fri,  2 Feb 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842875; cv=none; b=FkHQgC7oo5vNWBsqtZf8DhEaUWYRmvNsDwd+07X8JQ18laTDqa9PVSTfi5gRzYc3Y4xY8nTXKpJPliPhMtOekE4BGvBDjKQWu1NJc9RVCegfGI2Bf7JtPHm7k5YkHMlQ327BcrF5pcHA7d9mHHtawnCAoVvvVwcd9fEIAt1sD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842875; c=relaxed/simple;
	bh=QphI2QaFh5i8mpq3LXJuXnOJcGXvW8OtRDIwjhj/MoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRpWGmIOoJnRV+FWDdiKkNv3f+pz0YjcKt/xPsLJ9NTXNPN7JFqsvZTSWhSer+tYrdLjGmg/giSxS0HwwIrAGoA+0z8RcyXGwW0iMW20VIQq510Szq7WXcXeHhGChJxNVbq9YEtirXLVshVwLLUvp4mZfUAfim+Gz9DEETdvSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZZiWmmc; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706842873; x=1738378873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QphI2QaFh5i8mpq3LXJuXnOJcGXvW8OtRDIwjhj/MoM=;
  b=EZZiWmmcBpSq9tmUcL4yWi4pqMcGsklJrCIcNQ4aY5gzu+RaPRHW2sSK
   lKy8nTR+A/W8oZ3PyYrXetwL6sLD+DbPv5kOOKmMVhtoKcMmyiU8SCubr
   uTClcNYMFL4AuaDx+Cq6c4/B2zFT/UQavHBmuH2nlfQMlCfsxuFCSRLBF
   8VojYry5uGu5a8TKckVGZgAiL5blbft9eFG7omIhdLpKja6+fAeJS1ixN
   swZ6sy+sDiiEZX8aOwLpMO5+RCgqm+vrqJvRJRvJauOmxYDDgpaC3nLA9
   09gjNHI2h3ggZWH91XZxXGaSUguGATp2ktUuaKzU6lFrpggZzyZvnEcq9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="401187693"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="401187693"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="257260"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.22.55]) ([10.247.22.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:01:00 -0800
Message-ID: <2ad1f55c-f361-4439-9174-6af1bb429d55@linux.intel.com>
Date: Fri, 2 Feb 2024 11:00:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/11] net: stmmac: resetup XPCS according to
 the new interface mode
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Andrew Halaney
 <ahalaney@redhat.com>, Simon Horman <simon.horman@corigine.com>,
 Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>,
 Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
 <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
 <ZbjNn+C/VHegH2t7@shell.armlinux.org.uk>
 <9e23671e-788c-4191-bdb4-94915ff7da5a@linux.intel.com>
 <ZbtYaXkNf2ZF1prE@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZbtYaXkNf2ZF1prE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/2/2024 4:38 pm, Russell King (Oracle) wrote:
> Note the "This must not modify any state." statement. By reinitialising
> the PCS in this method, you are violating that statement.
> 
> This requirement is because this method will be called by
> phylink_validate_mac_and_pcs() at various times, potentially for each
> and every interface that stmmac supports, which will lead to you
> reinitialising the PCS, killing the link, each time we ask the MAC for
> a PCS, whether we are going to make use of it in that mode or not.
> 
> You can not do this. Sorry. Hard NAK for this approach.
> 
Thank you for taking the time to review, got your concerns, and I'll 
address the following concerns before submitting a new patch series:

1. Remove allow_switch_interface and have the PHY driver fill in 
phydev->possible_interfaces.
2. Rework on the PCS to have similar implementation with the following 
patch "net: macb: use .mac_select_pcs() interface" 
(https://lore.kernel.org/netdev/E1n568J-002SZX-Gr@rmk-PC.armlinux.org.uk/T/).

Kindly let me know if there are any additional concerns or suggestions.

