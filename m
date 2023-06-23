Return-Path: <bpf+bounces-3236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893073B074
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 07:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54B12817D8
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5481115;
	Fri, 23 Jun 2023 05:57:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98960A3B;
	Fri, 23 Jun 2023 05:57:19 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706F9E46;
	Thu, 22 Jun 2023 22:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687499838; x=1719035838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y/CKVqWgLHa+Q3CB7q4KwhnuffZiwcoExTpZS7D9MfY=;
  b=AcZUW7B6CKZXWZJinViGaRvbds73pNDjIKIhuvVyiSsSRYhFgoTmocPi
   kPZsKcNWDTNT/Pas41YP/93/gM2GS5zMawvgxt2224B1+v+e8aB5+dKLi
   M1rqLnei2pO+rS1Zk6Wa2ofderi+Bjmo1eIjVfuNvcns+pWiMUh2eOn7C
   GS3aaJdlENB7yPkzVU96jVffGWrS+kW7EpLxsWEQ+ddhIllF6YiqH9WAS
   nZlonafZTByU0lQRp1UFSNVyiXv8zDHD7cLAAZyFI/bb206XC4DOyaC+P
   WdROpJWZTZuVnoJDlJvVWOBqE24GO9cHsmmpmdWhD/R06oOBmroKnDNGA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="358187298"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="358187298"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828252631"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="828252631"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.215.253.116]) ([10.215.253.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 22:57:07 -0700
Message-ID: <260499f9-4746-d06b-4fac-a01f29365704@linux.intel.com>
Date: Fri, 23 Jun 2023 13:57:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 3/6] net: phy: update in-band AN mode when
 changing interface by PHY driver
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
 Voon Wei Feng <weifeng.voon@intel.com>, Tee Min
 <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-4-yong.liang.choong@linux.intel.com>
 <ZJReJ2yxqKGQx1BU@corigine.com>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <ZJReJ2yxqKGQx1BU@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

I will update it in v2. Thank you.

On 22/6/2023 10:43 pm, Simon Horman wrote:
> On Thu, Jun 22, 2023 at 12:19:02PM +0800, Choong Yong Liang wrote:
>> From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>
>>
>> Add cur_link_an_mode into phy_device struct for PHY drivers to
>> communicate the in-band AN mode setting with phylink framework.
>>
>> As there is a mechanism in PHY drivers to switch the PHY interface
>> between SGMII and 2500BaseX according to link speed. In this case,
>> the in-band AN mode should be switching based on the PHY interface
>> as well, if the PHY interface has been changed/updated by PHY driver.
>>
>> For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
>> back for SGMII mode (10/100/1000Mbps).
>>
>> Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
>> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> ...
> 
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index 11c1e91563d4..c685b526e307 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -756,6 +756,8 @@ struct phy_device {
>>   	/* MACsec management functions */
>>   	const struct macsec_ops *macsec_ops;
>>   #endif
>> +	/* For communicate the AN mode setting with phylink framework. */
>> +	u8 cur_link_an_mode;
>>   };
> 
> Hi Choong Yong Liang,
> 
> Please consider adding cur_link_an_mode to the kernel doc
> for struct phy_device - which is above the definition of struct phy_device.

