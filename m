Return-Path: <bpf+bounces-10555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B497A9C9D
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB205B23D24
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E274A53C;
	Thu, 21 Sep 2023 17:51:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2414A532;
	Thu, 21 Sep 2023 17:51:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4987A7EA02;
	Thu, 21 Sep 2023 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318647; x=1726854647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xzUHdYuTPX8UEPkN1RU7vl2/b1DAaw7BomhJXS2mn5U=;
  b=C1x6IMkzybQYgmnhFfnSwg+lFuiSlzY1GJQk9HodNkYa1ZktK+/YHZf8
   W2bJECY5Ud5E0lG6KryKrZYdD7i1iZHqFZMUz0aoquzOTcHnMhCme/MSI
   tizhZQQK+6+qy5XCfivaUwFI6YB0kCDwPg8Yu0XRQvrvRtxTeH7Au7Xmt
   3Q6/FGLy+13lpm0/tRI75f8Ir51AixXOghoBu6/bPwDxlvNoPoSAO2S1k
   QiFPVxbVasxcP4+i1SSft6rqUNPdnZQ3nDSJ3Mxfp0Xu6Q3/y62pbtT5O
   NdJFrOP5679r0BSJohoHDE98baNq+WG8wdJuzRsdKloCGmOrzlMHbAyr3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384344978"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384344978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776399273"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="776399273"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.215.240.199]) ([10.215.240.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:25:29 -0700
Message-ID: <f9b21a9d-4ae2-1f91-b621-2e27f746f661@linux.intel.com>
Date: Thu, 21 Sep 2023 20:25:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2 0/5] TSN auto negotiation between 1G and 2.5G
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <kabel@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Wong Vee Khee
 <veekhee@apple.com>, Jon Hunter <jonathanh@nvidia.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 Andrey Konovalov <andrey.konovalov@linaro.org>,
 Jochen Henneberg <jh@henneberg-systemdesign.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
 <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <5bd05ba2-fd88-4e5c-baed-9971ff917484@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 4/8/2023 8:04 pm, Andrew Lunn wrote:
> On Fri, Aug 04, 2023 at 04:45:22PM +0800, Choong Yong Liang wrote:
>> Intel platforms’ integrated Gigabit Ethernet controllers support
>> 2.5Gbps mode statically using BIOS programming. In the current
>> implementation, the BIOS menu provides an option to select between
>> 10/100/1000Mbps and 2.5Gbps modes. Based on the selection, the BIOS
>> programs the Phase Lock Loop (PLL) registers. The BIOS also read the
>> TSN lane registers from Flexible I/O Adapter (FIA) block and provided
>> 10/100/1000Mbps/2.5Gbps information to the stmmac driver. But
>> auto-negotiation between 10/100/1000Mbps and 2.5Gbps is not allowed.
>> The new proposal is to support auto-negotiation between 10/100/1000Mbps
>> and 2.5Gbps . Auto-negotiation between 10, 100, 1000Mbps will use
>> in-band auto negotiation. Auto-negotiation between 10/100/1000Mbps and
>> 2.5Gbps will work as the following proposed flow, the stmmac driver reads
>> the PHY link status registers then identifies the negotiated speed.
>> Based on the speed stmmac driver will identify TSN lane registers from
>> FIA then send IPC command to the Power Management controller (PMC)
>> through PMC driver/API. PMC will act as a proxy to programs the
>> PLL registers.
> 
> Have you considered using out of band for all link modes? You might
> end up with a cleaner architecture, and not need any phylink/phylib
> hacks.
> 
> 	Andrew
Hi Andrew,

After conducting a comprehensive study, it seems that implementing 
out-of-band for all link modes might not be feasible. I may have missed 
some key aspects during my analysis.

Would you be open to sharing a high-level idea of how we could potentially 
make this feasible? Your insights would be greatly appreciated.

By the way, I've submitted a new design that not exposing phylink's AN mode 
into phylib. Please help review it to determine if it is acceptable.

