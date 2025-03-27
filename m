Return-Path: <bpf+bounces-54815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B6A732E2
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710E87A37B8
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A7215165;
	Thu, 27 Mar 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncnTEh4v"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911318DB02;
	Thu, 27 Mar 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080651; cv=fail; b=Shtg9sw9TGaeen99jHkx5ZAAJ5pwNhTu170YRfNmgONg+Gpsb3U2A0vzWFNB1KVY3jEfybhEZEHEmHbDN2oCcFYmtfkMM+qlLAvvWsjefVffEEAA5OT0G3m3FAyaMNREVfW/cD5Xj/RHAlr1duHaS3Sc0UEusw04gUswCzikc8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080651; c=relaxed/simple;
	bh=Omj2wqpTGU3GJ7mwmUVs88whGe3eY0EamLzsXMUucEg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juB80369Qr6DeXAvT942QN9m+87GEcXi/29YPz5mguUAT/y8YewK2dcASy6KyrB682C5jeCLetr5sW2MeUMT1OmEuw4IWFS5dl6uex/CrCRONUrSUkDoB6LSV9IE81OKcFEIPeJ90MkDGARkQCzCiKVicnc8ABe/fBbxonBpz00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncnTEh4v; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080651; x=1774616651;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Omj2wqpTGU3GJ7mwmUVs88whGe3eY0EamLzsXMUucEg=;
  b=ncnTEh4vMRRhqWNO744ErUs7bxpNxq585iLO1N8Bpf98fShkQn7GB66R
   SLf2augE2F3IRSM2p23IKZN6IC8Y7xggjHLMLN+8xkFeIjDoBx/nZm4Ir
   N+QY+Xt5TSFbVjWRDtYRvRRL1I4mdIHWx9oxkeO+OQDzn+tT03WEv7Ma/
   tNt6sNdHBpwG8aZaOEp/uL82ce8+wxAg7MQWsjuLjJ7viiSaTIxods27p
   mUTUee5PGLiLN83RIsXliDHa2tfjPnwIhpjE9WeI96a9I/tre3sEa0otq
   cvdB4sHw1vo8PI9sk4DTR8ANVyW4Byjob7xzqWIRJ0fLMB7HNibcBnT6f
   Q==;
X-CSE-ConnectionGUID: a5GCvc8XT5SAYdAiP77MBg==
X-CSE-MsgGUID: TtcV5cd0QlayZzCQdrO6ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44515704"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44515704"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:04:09 -0700
X-CSE-ConnectionGUID: 0agBMVRvSDiX/UCt02h9OQ==
X-CSE-MsgGUID: 9m30lXuVSs2QiulSNKktQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="124895925"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 06:04:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 06:04:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:04:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:04:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAtGta1ifbkMMm2t59rHGCXIRfxS1Lf/EbekoN0esjpn+BM5lo2Qm0k8uQ3HB+9/J3P179+hD18FIa7FSFaqG05Fl+13Cb8XGX0PZzeEmKpT2q+5h62wPajfjC544nXd1GycN3oa+43nUhpKgcVBNlFTOo0YG0iFK/0rIZ2SmP0Bj9HASuSwptizge8h6qZs6D45fHMS7vA447PfEqB4dfsT9Uza1+h7tMiu2kmL0xx2lVET3rGU2Jctr50amsc6k1cAyNozx71VUqtLJ9H7ZwMO2G6KVxZ4eFMitoHRGngViQZvJ5EymsoUbrA4Trer2TDX47mR/4/nknAFF2aM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0XzypOy4PObHT07VdIz9nBGNS8KwV0xQRrq2H3tZcQ=;
 b=saWbvVNQvMh3Jgk84ecka1MQuxVhdd+UDSToMXnAM42QBX9F4u6HlYWjLU4OXnhZ4+aO6VGhbdbaPPbXlMbI9khBcVhs31IHCr87YOv8oZGjxvb1gvso3GDSBGm4kWZNZZ55bOQE5SThuE1kqZje/W/LqGkX6C0QiQNxbDo6hVzeNHRlexyBeX6FL5HdzEqHZerm/nGLCpqtwry6ZpTuqSk8+vYLc30b0Arfc6wll/CA8gYLxUwL1tgszsVhkunUCP8v/vaHMf1eLkzdgevngyET1bU1gTIqZTUY6dejLnaMG14whgBqhsfZnfP1ow+dLkNvMwPbu9iIw0uMCdxjCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) by
 CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 13:04:04 +0000
Received: from DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018]) by DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:04:04 +0000
Message-ID: <c0525757-b215-46eb-9ed6-95cf7429bb56@intel.com>
Date: Thu, 27 Mar 2025 15:03:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 12/14] igc: block setting
 preemptible traffic class in taprio
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Furong Xu
	<0x1207@gmail.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Hariprasad Kelam
	<hkelam@marvell.com>, Xiaolei Wang <xiaolei.wang@windriver.com>, "Suraj
 Jaiswal" <quic_jsuraj@quicinc.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Chwee-Lin Choong
	<chwee.lin.choong@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Kunihiko Hayashi
	<hayashi.kunihiko@socionext.com>, Serge Semin <fancer.lancer@gmail.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
 <20250318030742.2567080-13-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-13-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8213c8cc-49e9-45bf-158f-08dd6d2fd9c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTdHSEhBZW9yMUJ2UzJSdFBEYkZNd09TN3MvN0I3VnBrendyNjlFSnVnTXlq?=
 =?utf-8?B?bVpHUDVzQ081VTBkQVIwZTVvREJ2cVRDOG5YRU1TZzhIKzJBNk0zdW9ZYit5?=
 =?utf-8?B?SGYwcnBZWGNIVVpjNlJDdktPd0t4aU5KOFNUZE9MVldXTHpQVHdWTnUvQ3Yz?=
 =?utf-8?B?MEFncVBhbUZLdVAvcXkxeGRqUXNxdzZLTzRPb0IvTys2a1pHd2pudHYzUUxO?=
 =?utf-8?B?QVlFaHZXcHovT1ZXeTd0UVJKdUJyL0hrTGVFWHRuakJWTlV4allUdDZULy95?=
 =?utf-8?B?QW1mYVRCdk05Nzh4d05NWlFpYXdqNzRNK0wxTnlGSi9haXpZbklhakQ5Sms0?=
 =?utf-8?B?R3NWRldkZXJzSytDV1hvR1F5K0JyRTRJS2RwaittN2YvaFpEd09zN2V0Tm15?=
 =?utf-8?B?UnhlRWJlZHROVXB2TFo2cDMxb3pvS1BrUjMwempwaFJNeXV1cWdmT3RpeUxi?=
 =?utf-8?B?NXFRTDlPTG1QZlZreEtUWFpRMTJaN2dhMXlrb1Q1bEZUWFQvdXJiSzFiTUdU?=
 =?utf-8?B?WTdlcll1VXpaSm95dFYxdWcvYkVFSzluVEduMFMzWHRleG5adWwzRnR0MnNG?=
 =?utf-8?B?cFJpSFQxUmozQ1RDV1NvcHFQMFBJMUF5S0FINnBtaFRUYnpLUGNxNEl6MStX?=
 =?utf-8?B?bWh5bTlOS1NDY0l6b1BualhmQzI0d2FpQy9VQ1JKTVE2L1U4M0JUTlRMaGtF?=
 =?utf-8?B?cE56V1NoYnZIOVEvdGdMRGhkTmI1dnphUm92N25XZUo0b3B2SHJaRXZRVWRZ?=
 =?utf-8?B?WW9ZV0lMRGdXSjlTeGpTTGFreDJJcy9zcFZuR3dpcWUrVG8wejV2VEFvMnZE?=
 =?utf-8?B?VXRmZllYY2gzek1xUjdPVkF1a3ZZRlZ0dkNEekNOcHQrODdCMURoOFhVZzN2?=
 =?utf-8?B?S0NuYnIxN015ZVlMUUEveVJIZDlGSFR4amZuVTRIbmlVMzRRYzF4dk12MHZP?=
 =?utf-8?B?UXVudStVRUgyRE5WN1NDSEtKb2hhUmJJVDVFZnBBeUhoMXVLZ2F2MXZmOEZX?=
 =?utf-8?B?Wm5reEVSYUozaVY5L2RQNUM5NktNQkhkSXI5MVFJUkxyWC9XTERjRXpPTVJi?=
 =?utf-8?B?dzZlbURtcjNXWUlzRmw4Ryt0ajJkeXRCalpBZUxkLzJnM2w3OHB0VjE1MG9z?=
 =?utf-8?B?TXNVdVd1bSttUmRnQWE3bncxSWViZWlIVkxRNU9tQzgrREtwUi9aRFl0TXNI?=
 =?utf-8?B?T053eXZaUE41S3BCOWkreEhmK3VaM1BkaW9sK0s1MTJBZHI1Q1Z6YVRva1lj?=
 =?utf-8?B?TlJ3OC83NHY0MmlZK2hKVzZ2U3h6YVVvWldXaXB5WjlFZHNiWU41VzVGTElk?=
 =?utf-8?B?MndzM1doUjVueHgxaTdoSUw2bmkxbER3dU81MDR3U29FYzlYUG5US2xxTngw?=
 =?utf-8?B?c09Qb05HSS9jVDl3Zi9NNWU3TkRDYmpJV2Y3YmhQbXN0Yjcvd00yc1NYK0pY?=
 =?utf-8?B?MXhLcFNnYVlrY1A4cE8wNFd1Q3NKbStSVHQ4OC85cFlnMTBZZ1dIb3RiUzFn?=
 =?utf-8?B?WXNadjE1REtWYnZiVWJ5WlVPVzYyNjQwMlBZNzltRy96VCtFUnBQMjRweXd4?=
 =?utf-8?B?N0h6OVE4bzNWcFp1Q3V4bTdDSGpnN1dTdFNKREgwK1VBckhVVWx1emJkckRl?=
 =?utf-8?B?VFNGT3VFRXRhdm1WVzlQdGhseDlmazVKRjhHMjBYTjBhdzZ5b21pUzhqbUpM?=
 =?utf-8?B?L3VrR1lBdG5tOEhoRzVkSnpBczMxTHl4OEFHTFdzRWZ6SFEwRlR3b2RjWU1u?=
 =?utf-8?B?bWNJWVNjZW8wWjZZaXhUWTJzMXRqQkg3bXN6VENIVVZDMHRMWTZ3c2ZyTFZO?=
 =?utf-8?B?VHhaMERLZWdZV0NtdnV0Yyt0ZU5lZ05BOWVnWTUvTmpUKzl1VFBhbkxHQlFQ?=
 =?utf-8?B?VUZ2eXV3dDI0b2t2VENFRnl1U3c5Sm9TZ3Boc1ZxQ1F5SjRkSnRCQnNha2k3?=
 =?utf-8?Q?XFDHhan0cgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZ6a3ZLL0J1MXB0M092bUNxa2xpY1BkTnBVZmN1d0toQmFDUk9aclYwU0dj?=
 =?utf-8?B?c1RMNGRxWm8rOTJFS0s5L0lXUUlBNWpBWmcrWVFBOUlaSGtkUkFHeHk3U2x0?=
 =?utf-8?B?YllBSGl0S1d1OG0rL1ROUDVpSzhLdVVMd3NnYk1DUWc1NDJZNkliUVJ0c0pq?=
 =?utf-8?B?UjJaTUx0VWIzbHlZbXk5V3p0TzdYRFBNM1lXUVVnd1Y2cUdNcitZd3Qra3pD?=
 =?utf-8?B?QUJrNXdaUU5UeVRXSHlaUkJDWS9vVGhMZitKNDNKUGdVOEZVcVpMK3hLSjNN?=
 =?utf-8?B?SWFub3ZucDZqb0p5RFJja0NRQ2pLOThidkk5eFVJNWE0ZVJVM0lDdDVYTVc0?=
 =?utf-8?B?dmdIaTgvaDRYVkRrNnlZUENmYm43MlFoSDZMZm80aTJ0WGlhRjEvVDN5V2JZ?=
 =?utf-8?B?VmxTanlHWllnTlNYakFzdEFkVGFhUUt0MHAxekdYNm9YcmgvejdxcGY0UTFw?=
 =?utf-8?B?ZWtKRml1YVFOdi9XTU9OUGhVMERsU1VtTm9VY2ptRi9BTzRDREs0ZUNFZDZP?=
 =?utf-8?B?V1l6VFFDa3Z0cFM2MG9UMU9KUGFIc1dzOVRRS0ZjTmZFOUVwVkM3VUV5YkF5?=
 =?utf-8?B?YTRUL0hLVUhRTGhkMzErc1RyalFqdDlMSUF4WkdFdEpZNU42YzVhT0xZWFdk?=
 =?utf-8?B?QldKUllqeDhEUnRrSUlXaUVyTUNWdkpaZExTZER1MWhZei80andzcmRaMUo0?=
 =?utf-8?B?RXAxa3NtZmhVSXhFN3E3cHVROEM1MkF3OXR5aTRqZm5FbTJMdzNwdWlyVDlN?=
 =?utf-8?B?LzNBekF6WUk1WWlOZXdLSmdpZUU0MnZ4Y0ZGTGw1TzFnVE1TdG1yaFNtVmhL?=
 =?utf-8?B?Q1cvRmY5Qk1mSVlJK0poQ1FNdExQSkZTaDJXMnNoOTU5ekZlUkVDNGVBL3Fl?=
 =?utf-8?B?TUFtcWFrSkh3NG5OZFA1ZmxCbVBJY1N4UmxBL3FxcVl1TFV6NXRRcWJjaXRu?=
 =?utf-8?B?TG00MExqWG9UWUZlVDFHUFRTTmVwcGZSRUVLTDUwWW5CVWZZQUE5MFNBTk5I?=
 =?utf-8?B?SFlYWGZ5N2V6d2cwandEWHEzWEZXeXJmdytWUE1aT1VQQldNeHBaVXZjMnpS?=
 =?utf-8?B?VVd1WENkOW5lK2dwN0FGMkpSaGlzT2lrVmFmeWRHUktOZm1NamtPQUwxMjBX?=
 =?utf-8?B?M29XbVpmZ1ArRU9SZFZRb2p0ZGtWN2xXUWEzSkNxR0tDcUhOYWpTYnE2ekd3?=
 =?utf-8?B?TkhhcmxxSDhFQTdQdFZBaUxKY1JPRE9GS3pMNUtWMEk1c1BLV0dKaE04a0tY?=
 =?utf-8?B?bXU0L1Z1UGFLbFZ0U21BcE8rTHVMU29adldmREpjZldiOVRCNTJacXhqYWtm?=
 =?utf-8?B?MGJORTcydURISFUrSUlJcXJ0M095RmlMVXFRN0N1cVc4NnBwMTZBd05zOEN0?=
 =?utf-8?B?M3pLbVNEQUY5VVNVM2VaSVNHVm0vWllvN2pqU1dHQ3E1WHFoSVdFVVZDc1Jn?=
 =?utf-8?B?TzEwaWNOT3k2cEN0TDNsMzZIYm8vakJoSUdmeFBNelZ0TEdIazZZY0FjKzVW?=
 =?utf-8?B?ZTlkQytSSDR3WWUvQjhHc1gyR2x0QlcwRWdqSzJrY3A0T1ZEdU02Q2lNWlBz?=
 =?utf-8?B?emtTQ1ZKOW5nelUwUUxzMmU3QmZlWENORHB6VWJLL2V4UThWTDRaK1VBblFX?=
 =?utf-8?B?N3paKzkydkE2MUZJTmRuUTc0aXJqZnh3YndRK205R21Ba2VvQXg0RzdXNmZT?=
 =?utf-8?B?eWNzeGd1ZE9KVjBTVHNyV0dNT3JZcWhFUWxsR3h4Uk1naWNNQ2o2bWtTZkdn?=
 =?utf-8?B?UVM2aEhPZ3VhMXVadUNRYWh3V0M2VzlTSml4b2M1OE9iYmwvUWtrbmloWGN6?=
 =?utf-8?B?UkQyc1E2dUxHSXNvNlplZ2R6YXJYcGUrMExoN2kyUFJGTGlEY2hIN3JkdGps?=
 =?utf-8?B?ZkZGR1QxUEJHK09EQS9CalNxZlZnUVhEb3pDTWJlN1FTUnRlanBpWGdWbnEw?=
 =?utf-8?B?czk2d1JPaTFIMXVEYW94Y1dYOXVYNjIzWWVFUlJRcUpPano3cnh1djl5UXIy?=
 =?utf-8?B?M0I0a00vRWM0L2EzQ21hMExWbzN1MWgwQUNsZjdpcjlpTERsUnlFa2MzMkVG?=
 =?utf-8?B?b3Jzd3hVdnZhREJYOHpyLzEya3hPT0s4RUdMekh0UHhnMzdsamI2a25PWXB1?=
 =?utf-8?B?R0szVGFnalI4WklReHFvSUZDTnp1N2FWVlpjdnJPUTluRnUvcTluRnJsc053?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8213c8cc-49e9-45bf-158f-08dd6d2fd9c4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:04:04.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rx4IO22iAZdwGEeZHjdItCnDEI+IdZsWMYwdHHNZ11htbsnXOXLMoBoTssBMB40XXl3Xq1S8oObuNFotzcILbnH55Zrnz7dldu2By5ioqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> Since preemptible tc implementation is not ready yet, block it from being
> set in taprio. The existing code already blocks it in mqprio.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

