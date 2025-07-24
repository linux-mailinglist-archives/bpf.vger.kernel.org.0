Return-Path: <bpf+bounces-64300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE02B1121D
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5CE5A79C2
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6068239E97;
	Thu, 24 Jul 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/ioImqT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C4223DCC;
	Thu, 24 Jul 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388508; cv=fail; b=qfMZVTks+lhXPNA/qOu5VxyG03OHOcf00G1YRrwPeQc1oiYlGGfyBqJGPmw/qfEsS/m45pTnPh5WDect8kfUFal0IYhPdU6rW/6zdLEj51zS4QXQftQBbdDmrnZaZn320uhCl5Zkr8fUwhq9Ye+zGWJPf7mzsKK71rjZZruIArY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388508; c=relaxed/simple;
	bh=R+89Ws0MwgTSJJVMN9D9vHOfa+rY0s0XUK64vTBhkvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0ZINhcYpQVEKdFw9fMUQ3UOR+bQZkfeH5Eias8zwIMRsrFratcbLuYAF2A8+ySu3bxl0kp89/lq8oPk72zfJzs+g3/w9bOQLAYs0f0IWN455atib1i7sQr1crNebCb6tGYu1TUQCsLeKUxpm/NFM/IMvtoh32tI0oOV5QCR1A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/ioImqT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753388507; x=1784924507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R+89Ws0MwgTSJJVMN9D9vHOfa+rY0s0XUK64vTBhkvA=;
  b=g/ioImqTKhkT9HlteGtTw4lkuXIV1DIHHVVvevkPswPRL9DXWUNmbUpd
   DhDxreuR0w7FlFDj3YtCECBWmKvb8OHub/ygpPFV4RFO/pYH7/s4ZQUUK
   7FqbFGwzyZ0oz9MimexBCdq1E9buSLBPr9e7V8vYoktTP4nnCVE4Ij2L/
   k6Apiuhw7xg2qA5p7TDvSdWbg2YlTnJ9CZ6C8FxMR/oVPjqJ5MQ30zcVf
   zdMJzsPOvv7wBHg17WQbgBU9RkAi8H6buO3JeRpKzG1BAob3Aqx7goVS9
   tUaVI5iNNYLROUoVIyePnRKjGVbxJ3o3sgrvT+P4zLnSAWCX0IESmreTu
   w==;
X-CSE-ConnectionGUID: kiBXLr2iTpSu/QMeY+JoQg==
X-CSE-MsgGUID: PTdc8jpcSYyyBvpmMnv56g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55421458"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55421458"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:21:46 -0700
X-CSE-ConnectionGUID: FEhsqT4TSh+x0YvTHTCfFw==
X-CSE-MsgGUID: BhUwMbBrTMisD3ri6sUwMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160773526"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:21:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:21:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 13:21:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6JGrmYpmTsYbqnwvcTSWxpOHn3ckNRTs+Xe4cr+VZk/+fi90AkQfJ74cmJyA+265GI/dOIta819iZJlqsdk2hIzCUOcRgKhI6Iv+cRSpnCqYXDUhP92PB8GJPL3oYjR5JF+0j/ug1tfGEMAyyP3CehG4dkCyFrLz5/JypaFyFna6dWvHs5Qq5XRGqum+ZR5QvHw283j/Jjtj674cot59w78E39YeAeAACdq0i9yLOUqkrxpa2+2KSjIJVHSsBS/+IL7xx/WoGBVo9wlMqNt/ssvyAhs2Q+DabCmL6Rau+YxjkuRU7luQHjeG0PBEXCrhl04nHjrNHnmpGAyDRkGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IPF3nO/9tHyg8fS/CAEAXEkuHAGyEsqO1dXnaiLuTQ=;
 b=b8D1GnFkXjNgXyK26hm6Exp3m4LVzPA2IrJtzwoiIoHCc89PWsDNplV3hNBO2IxrbD0TXWXp1dhX1Glo4wbwVIKPjivLCHReTGkQUQgtHcanYEBMgTKpBC1ZE7WZcjbdDfKL0wHYnczVgtNckJgVzUhxAQ7eBmWG/ZkL1l6V+BAm9rpKFIObTyXn+gKpE6OhgZsID5xMbZd75HcdJuD0trRhMLQBNJZ3RhFrN99s4Q62I1/haG397QajMcCwyhWaFrsa0oeSBcEbMbDCARyodmNVnn/BsH4RM7i6DUkBByUdAS4M5oWNU0DtH49GJKMeGPYIzd5JjUYpvQC4QmJ4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS4PPFCAADA7A6C.namprd11.prod.outlook.com (2603:10b6:f:fc02::4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Thu, 24 Jul
 2025 20:21:22 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8943.028; Thu, 24 Jul 2025
 20:21:22 +0000
Message-ID: <6ecfc595-04a8-42f4-b86d-fdaec793d4db@intel.com>
Date: Thu, 24 Jul 2025 13:21:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] ixgbe: xsk: resolve the underflow of budget
 in ixgbe_xmit_zc
To: Jason Xing <kerneljasonxing@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250720091123.474-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS4PPFCAADA7A6C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a123bbf-c9f8-48d3-a510-08ddcaefa838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGc3ZWhJSmdPWkYxTUU1cHNDTTYwYmNiRTNaR0d6RmcwaitxcTlMVXQvTUlp?=
 =?utf-8?B?MGdTVFQvRFZYNjlzUk1aY2llSi9LVEtIN05iYVh0YTh2SUppekZHT05RRWMv?=
 =?utf-8?B?ODNWQ0NmN0VhNXIvajVzY2U5enRENjlkaGcwN3NMVnRuMWR1RG0rVmJ6NVRG?=
 =?utf-8?B?UmlIbkhjdlFweUJuM2VFVG03U0RHcUZsZDlyV2lLbjlWY2hkOFRGWjdCTEdu?=
 =?utf-8?B?UUErcDNFTVF6RTcvTHlzNzgyb0dwME0zUjY2QS96TXhKYmxaYjU1dmxjaXFC?=
 =?utf-8?B?S21IR1p4N1drOE5qWHNYQTBMWWN2ekR1b3dBcSt3YXVBTHlhTDA1Qno0ejVy?=
 =?utf-8?B?b296R09IcE41NDB6Um10YmJUdWpBSlhuRlJPRGlQRXJRcldEWm5JeG9RcUlR?=
 =?utf-8?B?a0VKUXhBdFpscGJwUzdwSE1QbS9RcUxzRVVZNDQxNDBtTWUwc1g2YWZSQ0sy?=
 =?utf-8?B?b3lGUkp4YmREeU5sUTA4QytBVk1JME9tSTNIZUJhQmN2VWMyN25ualNjUlRR?=
 =?utf-8?B?azNYTEFMSFFUQnBlRC9jWWdKVlFEOGlhVENzajVyVWY1YTRtQVg4OFhDQUM2?=
 =?utf-8?B?cWZ2WUN2UkRvek9yYUJZNlFkc1F2K1c1aWZqd2pkdVBMemtIWlNYSEhuSkdT?=
 =?utf-8?B?YlFTV1hkaERQZXdlSytIcGNDbitxdHQrMk5tTVIrd1cyd0YyNWlNUlcvdEEv?=
 =?utf-8?B?R1VETWxONDFrRU5XcjNUNWorZGhaZmk3MC9DMXlhZnZ0TURlcHJTU1IvME9o?=
 =?utf-8?B?MG1rbFhxejNqc3cwNVFCWC8xUzRETm05VVBHd2RnVmZxdStNMDdQMXZtOGV4?=
 =?utf-8?B?L3lIUm9oRGY1eHlOZWQ2aGJhSXBvYmFqZTgwTUdlT0lVTFNMMzdVcmpSK2t4?=
 =?utf-8?B?b3RENWphV1E3T2tISDdSK245UGxZMkRwekxXR2tERmw3MlVhWVdaMjJmRnc2?=
 =?utf-8?B?Mnc5NjIrZEMyNlUxUHpYN3o1NmlLRUZ4RUlMemJ6R2lUOXNucitoWUt5dTA5?=
 =?utf-8?B?QmlQUEdaTldkck9uTk96dHFEdmxZUTBsRlhPb1BQTWs3Si8wWHg1S1VxeGoy?=
 =?utf-8?B?aVZxVFZjQzkxTTkxQkl5ajM5UWZ1b2plZWt3NGxmaWhMRFV0SFNSUVV0STRJ?=
 =?utf-8?B?OHNIQlZja0dKb1kxSXR2L1ROWVdCNVlIaHFKYS9TS0lzRXNNOUY4dHpKbTdL?=
 =?utf-8?B?d2NOVkV6UlR4YlEzcXhHZVAzbEFHeFhyZmtEanZsZHYvQUsrSFZremlTc2Q3?=
 =?utf-8?B?a21SeFRkN1BaUUdTM0QwVGQ2V2d4cERZMnhlTDBncXVvLzlYOEhRMWJJeXB6?=
 =?utf-8?B?TkRiMTEzQlVLN3E1dytHV1FOUnFiaEkveUtpR1JtOG9RY1EzODVDK2FmUkJP?=
 =?utf-8?B?SFJBajRqY05hVWgwRnJSTXVFVnFROEZrdDZUUTB2ZUJqaTF3VkZWZFJwaEM0?=
 =?utf-8?B?bW45eStUc3VTNkwwUDg1bjJ5dDl4dVZpL2ZuUkhsNFZnb3QyL3pCSjRETHcv?=
 =?utf-8?B?eVNDYU92Yzg0ajFFeWI5K3BraU93ZmE2cHFIa2lNVGVJeittMEtuZjRTOGVj?=
 =?utf-8?B?b1hUZkd5VmY0TUJQM01zMTlPMEh5THo1a0VyVWdiYkhqSWlpNmhEVTZvaEFn?=
 =?utf-8?B?ZmhYdmtjZThXQk10Q2ozNXJBQ09oTThBVnRhdzdHRVJMRjJwelEvZ3pSbXU1?=
 =?utf-8?B?SUEvaGJHUEgyQVd3T3NjMGU2QjJuUS9ZQmF2MUJYUkEzVmpsakRGeVpNK2pt?=
 =?utf-8?B?RmxrN3BsWlRVcll3RHNnaWMxVFEvLzMyWUtCZE4vUEh4anIyNnp6V2pJUExV?=
 =?utf-8?B?cktDWE9KbVJLdjZlSkVvSjB4OHpoRWl4enlqTUk0RHRlL3d1b2FlRFYvRGRV?=
 =?utf-8?B?VUc5Qzk3cWNGNzcrY3Nmb3lCZ1FyRFFTRm5TU2Urdk9hZVNzb0FWWFZiekxx?=
 =?utf-8?B?Um1Vb2c5ZWgvbnVmeFBsQTh2Q2k1WmhUeHhOckJPRzlZMU1BUXZxQmQ1SG1j?=
 =?utf-8?B?MDU5dE9xcTdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHljUkFqNmpuTENPbmw0UUFzcEs4ZXpiTmVMVk9OTFFJUXU4VlA4U2N1dGRP?=
 =?utf-8?B?eUpGWlUrVGd2L2ZKeDdDejNYTVYrVDZFaXZoNGNEd3d0cU5jaDBtMldaQVYx?=
 =?utf-8?B?bXpkQ2dmemJ5Q0dnUHI0ckJiRVVXQ0podnVBcGoxc0ZrRzlweUFFSFpqRGxG?=
 =?utf-8?B?bGhWY01PU01ZV2N1MU4xQlRDK0IvVzFpS2ZCdWIrZC9ZOW1zdWZuRE1WZDk3?=
 =?utf-8?B?ei9XSENIMWI5Y2ZsOTFPRTB4ZnQ2bDNDQjlpaCszU0tjbTdlaUE0cEp3b0Fy?=
 =?utf-8?B?TUpmM0NrVlBhWGxtLzFWclQ1OVc3djNQRUNBZ3dadGx1S2tjWTc5UEl3eXhs?=
 =?utf-8?B?ditTSXZpWlpRY3dqNlRGU0tPdG1veGVsWkh1MnByNmZuZmw2d1VQZ0YwM1JH?=
 =?utf-8?B?WkdNSFNSeUsyOXRLbXMzbHFaNzQ4Y0xNYVRoTEw4NDVObUhnYzRldWZOZXZ5?=
 =?utf-8?B?REtBalU3eGN5bXF0L2lNQmFPSjRJT0pnNytqcDVGRmF2RTB2SHB4RVRyaXRl?=
 =?utf-8?B?bFgvenh4eDNDYll4cDNSWWJqMitmYXFJZU1wVHp3bWhTem4ySEt4U2I5TGtX?=
 =?utf-8?B?MEdhQ1FMTjM5MlB6Y29BZm5wSjdCcllSZjdRVWtaRlphNmtXcVpqeUs5YmpL?=
 =?utf-8?B?Tkc0bGNqcEZIYlhUc2pISUJ3Tk1GOUZFRHBmZm15SkloVjc3K0hONXFKWDZB?=
 =?utf-8?B?U0E1NW9Ob2V5T2lKYzNHYWpYTS9WN0pzOExZRG0zMG9LZ0hzWUZIU29OU1dj?=
 =?utf-8?B?QVRlYktJbTRIRjlqVW11ZldHeWRjZU41NGMwd3BGMzBUWUtWS3o0aFREdUlO?=
 =?utf-8?B?SHJnRWJVRU9lYWVFODBGMVVZcG5EQ0gzb05uN3plSG1McTlQeFdXTHFWT05M?=
 =?utf-8?B?NWgxR3hyaG9NZGljVFB0UEhuQURIc0xOcjQxS3dXYWM0ekxlRURuOGcrWGY2?=
 =?utf-8?B?Y0RuRDhqaGtiQjh4VGp4K01rdXYwOWJ4bmJVM3hVaFhFQlV3dlpwVlowQUwv?=
 =?utf-8?B?RW1FZEFtSXdTbjJXVDd1cEt3Qy85U0dVRUhaMmRaQW15YzJOYVE1WmI4Z3lE?=
 =?utf-8?B?TmxYdXd2R0tmc0ppaXhwd0lDNEkzUHFJUDRDTkNQaVo0ODJYdE5HeUxRYUIv?=
 =?utf-8?B?NmpGWElZTkVERHZDSkw2SVJYRXpva05BNGJEVGZDMWNLUkhob1BUSjRzeUhU?=
 =?utf-8?B?Sk9LWmpQanlLZnloR0ttdW53bEIxSkppT3o2NHJlN0NPbmcrMlhIKzVOZE5S?=
 =?utf-8?B?TlZPbW1vc0ZmMUJCRDM1MVR1aUxoWmxTMVdRTnFxNEJaZlkzSHlEeCt4U3hG?=
 =?utf-8?B?MGM2SXFsaGpRSUpSeXdyVnZPalNlNjkyWThuOXZXR0hPS3ZnR0hXcWhKTjBk?=
 =?utf-8?B?Q0JVMVhUQ2VWUUxLR0hJWnJZeWpyUjNqcHNPUU11aVdKcDRFN2VkalNwam1G?=
 =?utf-8?B?ZFd5SDBkVFZ4UThhRm1mRUxLcGF1UVhmRDJYNkpSTTZTbVhhTWlJYVJTVWdl?=
 =?utf-8?B?aEp3M1c2MmVpS1JKM05WZGZnRklMTWxmRmtXRjl0R1VONmpFdmRKNm5CWmVS?=
 =?utf-8?B?STRDenNrTldDZXA5d3RCUTd3Zm4rN3hEU0MyK1p6NURGMGZwbmlHWWVFSDlV?=
 =?utf-8?B?ZU11ek9UNm9RUjNLQmZMNnRjeWI4KzEyTjErc2xGczlUVTF1cGxZTFlWbS80?=
 =?utf-8?B?TkNMbFJOMmd2SlhnOUhIc2s1elhuamRFbGd6M2k1aHRtZHVaRW84OVJ1ZUdL?=
 =?utf-8?B?d2s0b0JEMk1pRFdFQUEyRUJUVnhoS1EyeWpBRHJ4amFTWlB5MWVoSE9MalJS?=
 =?utf-8?B?SDIyNDl4QlVKSEFnUHNXRGlQQmJKc1YwSTRocUVpNy8zekF3YmN3SFJOS09I?=
 =?utf-8?B?MkZwYXBoSnNOd1NvWDkwVWxsbC9JTXo3YTFiTEV4TlVNK3V0eVJ0SHNxdHVQ?=
 =?utf-8?B?b1ZCQTVpR1NHcWE5d3VEdWUvTVJpYkVSWWhwZFRhMFNzQVZ6Q2twdFhCTHZH?=
 =?utf-8?B?OFYxVkRMRWRGWkRVcHpoTVJBK2kwVXFZeUFWdmN3MXBQSVV2TytBdTFNUWNn?=
 =?utf-8?B?eGVvdlRwM2RvcVY1NStUNlpqbDhXTEJvTmpiUDFHTDI3SnNja1hKOUs2L2d4?=
 =?utf-8?B?THJsVktSeUJKVEhtTWxSMnNudVpreFlKbEpRWW44bGJBZU13a0d0OHdPcWdR?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a123bbf-c9f8-48d3-a510-08ddcaefa838
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:21:22.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHgcfa923xX6Gn1st01fErMVjvdO83EClRqBdr4LVT9NdSHvsQMqmS5hajJsu+B6x/Fsbz4sbwVTNe5qvfoiuJrsYVb/NZDKNyuAtSoRPHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCAADA7A6C
X-OriginatorOrg: intel.com



On 7/20/2025 2:11 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Resolve the budget underflow which leads to returning true in ixgbe_xmit_zc
> even when the budget of descs are thoroughly consumed.
> 
> Before this patch, when the budget is decreased to zero and finishes
> sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> and enter into the while() statement to see if it should keep processing
> packets, but in the meantime it unexpectedly decreases the value again to
> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
> true, showing 'we complete cleaning the budget'. That also means
> 'clean_complete = true' in ixgbe_poll.
> 
> The true theory behind this is if that budget number of descs are consumed,
> it implies that we might have more descs to be done. So we should return
> false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> polling to handle the rest of descs. On the contrary, returning true here
> means job done and we know we finish all the possible descs this time and
> we don't intend to start a new napi poll.
> 
> It is apparently against our expectations. Please also see how
> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> to make sure the budget can be decreased to zero at most and the underflow
> never happens.
> 
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")

Hi Jason,

Seems like this one should be split off and go to iwl-net/net like the 
other similar ones [1]? Also, some of the updates made to the other 
series apply here as well?

Thanks,
Tony

[1] 
https://lore.kernel.org/netdev/20250723142327.85187-1-kerneljasonxing@gmail.com/

> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 0ade15058d98..a463c5ac9c7c 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>   	dma_addr_t dma;
>   	u32 cmd_type;
>   
> -	while (budget-- > 0) {
> +	while (likely(budget)) {
>   		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
>   			work_done = false;
>   			break;
> @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>   		xdp_ring->next_to_use++;
>   		if (xdp_ring->next_to_use == xdp_ring->count)
>   			xdp_ring->next_to_use = 0;
> +
> +		budget--;
>   	}
>   
>   	if (tx_desc) {


