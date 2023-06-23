Return-Path: <bpf+bounces-3235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D073B06A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B19528189A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC531385;
	Fri, 23 Jun 2023 05:54:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4017C2;
	Fri, 23 Jun 2023 05:54:36 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1919D;
	Thu, 22 Jun 2023 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687499675; x=1719035675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jX5Lr1tAqj4wwCuiTw/iPCwJsi56am7+vbPvNZh5aTg=;
  b=dKVK6sKgxkjudyEesWIUqT9oTnLbAWoT/YN+x5dUNlOoKktyCmju1wb7
   shSnjuDh6K/5pFzSvaKDvOtXUii9gul7tGxJR8fdQKK26e6GB7JYid5JI
   6WKQfuojrfebpVf6WLtgPluniDWhBx99oakcefGIqU2LuAuLKT9+Gy4b3
   6wItEOI3MWuqfbP3YRkPTYYgueeHgSk+vL926yU4GnuJfLUlT0CNL90G8
   y0IgN1afvArTlDwqvdCz2hfPm+UCZHPc+2p74PC+M6phM+UbLGTmPpUeL
   dbmOYsMvQK1Y7FjC+JYImnFVm23Kbfid7I9prRVWzkfGU7dZuEDO1votm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="358186446"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="358186446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828251468"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="828251468"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.215.253.116]) ([10.215.253.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:54:24 -0700
Message-ID: <52021da4-c2a5-5350-0a7c-273d76a221c6@linux.intel.com>
Date: Fri, 23 Jun 2023 13:54:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 1/6] platform/x86: intel_pmc_core: Add IPC
 mailbox accessor function and add SoC register access
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Mark Gross <markgross@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
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
 Voon Wei Feng <weifeng.voon@intel.com>, Tan@web.codeaurora.org,
 Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-2-yong.liang.choong@linux.intel.com>
 <ZJRdllrXB4bi7oOQ@corigine.com>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZJRdllrXB4bi7oOQ@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Yes, you are right. I will add static in v2. Thank you.

On 22/6/2023 10:41 pm, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 12:19:00PM +0800, Choong Yong Liang wrote:
>> From: "David E. Box" <david.e.box@linux.intel.com>
>>
>> - Exports intel_pmc_core_ipc() for host access to the PMC IPC mailbox
>> - Add support to use IPC command allows host to access SoC registers
>> through PMC firmware that are otherwise inaccessible to the host due to
>> security policies.
>>
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> Signed-off-by: Chao Qin <chao.qin@intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> ...
> 
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index da6e7206d38b..0d60763c5144 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/dmi.h>
>>   #include <linux/io.h>
>> +#include <linux/intel_pmc_core.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/slab.h>
>> @@ -26,7 +27,9 @@
>>   #include <asm/msr.h>
>>   #include <asm/tsc.h>
>>   
>> -#include "core.h"
>> +#define PMC_IPCS_PARAM_COUNT           7
>> +
>> +static const struct x86_cpu_id *pmc_cpu_id;
>>   
>>   /* Maximum number of modes supported by platfoms that has low power mode capability */
>>   const char *pmc_lpm_modes[] = {
> 
> Hi Choong Yong Liang,
> 
> It looks like pmc_lpm_mode is used in this file and, as of this patch,
> has no declaration. Should it be static?
> 
> ...
> 
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/include/linux/intel_pmc_core.h
>> similarity index 95%
>> rename from drivers/platform/x86/intel/pmc/core.h
>> rename to include/linux/intel_pmc_core.h
>> index 9ca9b9746719..82810e8b92a2 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/include/linux/intel_pmc_core.h
>> @@ -250,7 +250,16 @@ enum ppfear_regs {
>>   #define MTL_LPM_STATUS_OFFSET			0x1700
>>   #define MTL_LPM_LIVE_STATUS_OFFSET		0x175C
>>   
>> -extern const char *pmc_lpm_modes[];
>> +#define IPC_SOC_REGISTER_ACCESS			0xAA
>> +#define IPC_SOC_SUB_CMD_READ			0x00
>> +#define IPC_SOC_SUB_CMD_WRITE			0x01
>> +
>> +struct pmc_ipc_cmd {
>> +	u32 cmd;
>> +	u32 sub_cmd;
>> +	u32 size;
>> +	u32 wbuf[4];
>> +};
>>   
>>   struct pmc_bit_map {
>>   	const char *name;
> 
> ...

