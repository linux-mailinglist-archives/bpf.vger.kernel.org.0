Return-Path: <bpf+bounces-54808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72811A732BA
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6B1752F8
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1A214A89;
	Thu, 27 Mar 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSm49nUx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8062F2A;
	Thu, 27 Mar 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080160; cv=fail; b=REqb3Rt5UuBGOQsLaOJdkH1r9wOW1fS87sapeOdIar/MTnDerdNMSHklTDBi0qJnxZcLGD1qO2x97gEOFMIVHtVKOUzt1zJa54VvIi0MfKvY8e6rQt+egtFu9AIdJWs1Hte+D8pXF81MjTtoKYTzLCpvl/YGQShdTPsBN4WXqp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080160; c=relaxed/simple;
	bh=MtrVJyZMgKLDWIOfnZoT3Qcq0xl3N+Yz5BVoFl3fxsA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTiqnESvMe5wCfeM22S+yWW3QmuW7yUvUpl2CGh8Qzj5tCoa6FPJmoCPov0qrYK4AN97xYWEAvLiygvmzYveoofqJmVux2C1IWmCiaV+lV5cKFdh7oJjkRbfrRVUMOoo1RgOpLnY00JD5k17+nSXrDErxpBz0q0idrzxkyqlFaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSm49nUx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080159; x=1774616159;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=MtrVJyZMgKLDWIOfnZoT3Qcq0xl3N+Yz5BVoFl3fxsA=;
  b=cSm49nUx54b3n+UECvlaIFRQtuvbdKX8wPfKVYA8+D/JT0Z0fTH0w9ba
   DDuJlF2cBgCEa7vDdp4rJ4FxS4qqucXLlPVhzMJDk03o2Vdflz9RmkAVF
   /fnLgY5r4u99tG4GcN5zCyPj+TkkavNZK4MX86VDHzzK+7ETp5JoARasE
   SrQZB70T+4Yy8HUTik4HuK0bAKdpZw5m0K3xk8O5543rBBwwrjgST6i3m
   YJ2xTB2+a1o28wlyxDEvVkswOa2hpI4O8obhngs6jnRLOm1ys2Zy3Cj82
   W1wW+1PeN+Vzlcijb4OzMQj4Tke/KN8Zbd6ePpO8BHcmFsico8qOHGV8X
   w==;
X-CSE-ConnectionGUID: 1VhmJw0uRNaOt9VPlbB4TA==
X-CSE-MsgGUID: 9JYMF+wLT2uNEu3pZO/5Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55775428"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55775428"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:55:58 -0700
X-CSE-ConnectionGUID: AjLYJqFSQlmuZmOMKG9Wbw==
X-CSE-MsgGUID: aeWlYZ7ERvWgCFZP41gauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="156116679"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 05:55:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 05:55:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:55:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRyiMABBF7WE15dapsNO5h4iSVfqSQYwDNBaWVPnvrQMHq2YYavt5Bgaz1w5wMJ3J97YCkwwlkGujuWRcivWIUb2Kxtfv+GMjcicOctGUrrXnWspociGPDDkI2IGBeGcY167tllRRwcX6TzOWtTu8aJRVVHwpvzxvmTPrvCM8nYhf1hWbSvScfShQ6gBOkpJYPVup8PwUjRSJgBre2pEWXRIYkkitVfBvsg5zg7/jhsuOt2Avju/ceE8OudiK+rXEcJGNErCyhNEgHclHgoi0tpMkmzXln64oEgv0EGsu28pl/ZOZALlZr2i4QtJk/6sbNi2ziDm75Mdoty4ZkcQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WpOBF7dpd2uri7npAYpoCXT73ft+C6ZVew31x1D7mQ=;
 b=pdBOL+uNnMcJQawDXLhFPz5xnik6ii/bkwkYp+/maSawNg+zT9rO6f29f6J4w2EK3JjZ6ZaY2cEtEEO1c+gXYVY1yqW6pTpQrJnmwR7S6ZEbcbcB0T3rUnXfE/n5hhAtLluEwSFFTVr+1e1GC8Rvk2n5YtyA50j6tx+ZpNpu47TypTelsazaUjYVW5lKSVDoElbMhQSc1nFGS12snXS7jy1MvRk3+c2hwi8lI2KQ6NnJlYGkdlVFqFNoyKkuOyxwOZ6JokxBlgLn2da0SjF+BRRqm6ITl4psZh67M/0vp3gkPlUKnXpEeoc/X8u7Nktu7WyzzHOqa5dSsEdBBdIyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:55:38 +0000
Received: from CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14]) by CY5PR11MB6307.namprd11.prod.outlook.com
 ([fe80::1fa2:d2f9:5904:2a14%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:55:38 +0000
Message-ID: <f43d06d8-663c-4f3c-a12f-9f7b78ddb027@intel.com>
Date: Thu, 27 Mar 2025 14:55:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 04/14] igc: rename
 xdp_get_tx_ring() for non-xdp usage
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
 <20250318030742.2567080-5-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-5-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6307:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0c709f-6049-4771-9797-08dd6d2eac66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enR5ZERwNVdGYW8zYzZpcHNnZlM4ZXlEdFUwbEJpQWppVVd0aG91V2xYSjVl?=
 =?utf-8?B?cFRtL0x5RytWaHpnWVJnTXhEVHhienBudDlnNEhFVllrSnlRR1FNc1ZjeDBI?=
 =?utf-8?B?Tk42SmFtZU9mbG5KcGdsT1J1SlRvbUpSMkhtWUhSTHl6QXh6TG9jd2Y1TFFN?=
 =?utf-8?B?WlJ4NUJvcWRhODd1eEpoOHhtQk9PS0g3TTlKdVB5NWswRVlUbXRIWHZtblg2?=
 =?utf-8?B?ekVCUjNqRnZXQXNzd3UvVGJkVnpJUkhqdGhlbjlleTZlUkNqREZyV0RMMmM4?=
 =?utf-8?B?RkZKUGtWY0dXWW03NG1rSGZwcWRQalFzTmhORHgvTk9lQnBQMDBNbzFTL1hh?=
 =?utf-8?B?NkowYSt3MVZ0S1VBTVRETGZ0TFp6MVI0MDdERnBZcmYvbUNPLzc1Q2l4amEv?=
 =?utf-8?B?Ni9KQVNlWUtabFlvREg1STVQcFpUeFZxVzJxY01UTmhZbzlHY1c3ZVhDNzRP?=
 =?utf-8?B?OGtSN0pFVU9kcVMwbHhQczVSWXVVQ2F6TlNNQk9IQzkwODB1YjVxWVl4cXJi?=
 =?utf-8?B?ell5SDZiZnpHaVF4RE9uZkppQUhsTVFJNldCU2tvbUZza05veFgzOHZGY29p?=
 =?utf-8?B?TXB5YkNNRkxXTXEzLzdZdm5heXlaMjdxRE9IdGlkOUxvUjBkdUc1RVUrclZj?=
 =?utf-8?B?a2FmNGRCWjExN3kzd1F4YUZYeWttREtvY3Fub1ZYTmh0MUJCS29uWE4ybUFI?=
 =?utf-8?B?Ky8rc3JPdnZrNDViVk0rV2RvTzMzZ0U2OC8wanlsMGpnTzBZVEptOTdzVTlX?=
 =?utf-8?B?RXYydytFK2tpWW9PM0F6S29YL3dubVQ3ZnYyTXc2dnh3ZFdFSFdycGg3dmJo?=
 =?utf-8?B?d2VJRTVoeG4vWDFpUUJXVnVBTHhzUTNvd1VPRmtHRFp4c0dhMkNIL3VxZWpX?=
 =?utf-8?B?SUxNSC93RmNLcno0YzlPUEwvMzhNQWNEbjRIVUtpTTdrTWVGV0crUDdBNWhL?=
 =?utf-8?B?N0YveGIwQjlwUy9TWGN6N0dYSDRiMkFHSnlheFA2TGtpN0poRmxWdTRPb1VM?=
 =?utf-8?B?NGFhT05qN1paejZHNTRRSUV6NVlFVGR1S1RHNnp0cnNKbWF0WE9pdDluQk1Y?=
 =?utf-8?B?R1NrTE5wdG0rMTBiL0I0NldQL3V3cU1yUWFGaHMxbC9mSHgrZVFjY01VLzJJ?=
 =?utf-8?B?R0ZIemFoRFREaWZpaG5FaTBjSWEzeG54OWxZZ05PU0NtU3loV3p0eXppaFVn?=
 =?utf-8?B?MFQwNlp1UUY3YW4zVkM2ZWR3WnB6VDVGZlMwbWRMSHNLaE1WTHNBVFJMSUU1?=
 =?utf-8?B?cHR1Vk5TRW5uSzFac2hnVy9XTVRRM2JBMnZSelR6UUVZSVBiNXZ2Zi9tQlI0?=
 =?utf-8?B?RnMyd0J6aHh1VVpxbjVHOG1lcWxrUWZEMUR0TUgxcnI1L0ljbXNLWm9mQjRt?=
 =?utf-8?B?QlJlMU9OMTdTZlo5TFV1MUNhWWZkdFM4ZWFkczVuV1lxVVNjVzdILzZDSjBn?=
 =?utf-8?B?Rmg0YTFaSTFzMzN4OXYxaHVZTHJqam1KZWg1d1RzeUJMc241N2IwbXYraVNh?=
 =?utf-8?B?RXB2dC90MjJNQ25yU1g0QVFYQlJuL0V0SEx1NVRnaGFvL2J0QUdRVjZNMlZo?=
 =?utf-8?B?NlAzNUgvd1lHLy90UnNST29NQThlMGtYY1ZZeDNFbUNWMlZhYS9ISURkTSsz?=
 =?utf-8?B?NTFFREtnekw1dFQ5TTFVT0Y2U01VWmhSdTJ4a2JoUi9DMG1QOW45Y0hSOWlN?=
 =?utf-8?B?MUZLTDVQWGJlc3UyK0pFeHgyQUUzQUdRYWpIV0ZZSHA1djVncWxZYlE2SEl1?=
 =?utf-8?B?UWJ0bkprRytrbEZtM1RnRkxwcmNFMWJtNVhZdTEvNXNjMXFGV1FDVDRkbUt4?=
 =?utf-8?B?OG1CblB0Q05mNzcrSE9NL3pUQUFjSzNNWXFQWHJjbjNQUUJDNTFZZW5Ma2Nw?=
 =?utf-8?B?clhqVFFzY1BoMStCZWtWanI1NjUxdkE4R0k5WkpSN0FXd1ZWbnd2ckY0Mncr?=
 =?utf-8?Q?d/TA2oAnsyE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6307.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5hT1VtSFhyclNHOVVQc3VDb29VTkw4ZWZ5QTVIQmZrc0UrK0plSkl4YUl4?=
 =?utf-8?B?bDBZTXliY1VMR0RBWEd4UEdPY2JYbmtlT01UVnRIYXVaZFB4RENZNzExYTMy?=
 =?utf-8?B?b0dyaU8yeGpsWUh1dzZTY2tRcFZDZGQwZkpYUXVCd2RZc1RaTTlvM2JjbXZj?=
 =?utf-8?B?YkhQZDQ0bm5jSk5COHBBdzAvQisvUUJCemhwaXJDSXRjZS9VbXVnWVJ5cG5Z?=
 =?utf-8?B?WlJEU3JLZ0JtdE5qOEd2dDRURHZSeTJrUlRQaGIvZ2U1VlUzMUJjZmVoSytu?=
 =?utf-8?B?WUN4N281WXd2Ym1jNnVrMVMvOTNBREhMWlc5R0JjNVJoSHVYK2QzNERpeHlN?=
 =?utf-8?B?MFo2cVZiaE96SlRwZHJ3TmNSRUlZbURTTitoSmJDNjViMzFCNHp4VjE3NlVm?=
 =?utf-8?B?djhkejBubTZGcUlrTEVyV1dWQkhaOTc1WGNPSGo5U05VK1B0ZkNYOXJZakRN?=
 =?utf-8?B?U2NFT3REMy94QUhtWW1xYW1YTVp0SGtWVTRuV21CaEJSSTdXYmV6RFlHL2cx?=
 =?utf-8?B?a1JhUDdZVnJaTjF0R08xMVdjRCt1YU0ybXBDWHVLUUFrUmU0NXhxOGFreG9x?=
 =?utf-8?B?T3Z6S2RvK3F2N25KQjRsQi9lN2dSc1FSN2Nza2dKQS9NVkREbU5idElJR29J?=
 =?utf-8?B?aHhYVXNkem1tNkxDZHZWSHBaeWtLRUNjK0lZRFNCeHRvcXJCMThjc2pqbnFJ?=
 =?utf-8?B?Y3hYUnU4RklialpZMkRiUncrYzJ5QmUwWUxBMnhLOEdRMVNiNTVYdEtJUVlY?=
 =?utf-8?B?Q3RMSlU5WndJeTZGY2tURk5qQ3M0b2ZpN1hRb3pyb0pxNEo4dko1V2Y1WU9X?=
 =?utf-8?B?dnJ4OWtDSzNVeWJQQzNwaE43OTBhM0lEeG8zN1AzRkgrdG9MeEc3cFhjaFpR?=
 =?utf-8?B?RHZIeUFOc3QwWXNkZ3FCZmR1L0gwTWpRVUE1c092d3YxcURuNEZxdlRXcWMv?=
 =?utf-8?B?MHEyVG5iMVhXNWtzM1h3aDlLZ1JCTkE4R2FrUjZidGxPSjRpSHIydDkvaWFi?=
 =?utf-8?B?ZDM1Uk1Pck1JRjRhSFRYSDhvSDJkdEEzUzVScXZTTUsrN2JVTWVibG1XYmpN?=
 =?utf-8?B?aE5kWWUwRGo4U04yeXlnSEMvSEwrdTlLL0pTWG4xbnFEaVE1RnFwVmpFMUJh?=
 =?utf-8?B?ZGdtNHRVSWVrdm5uT1loSjBDWmROanZpUFRzS212Tms1UytUWWVXL0EwZ04v?=
 =?utf-8?B?UXNIWjZOUmFsVmlOZVZRL2tJT3I0clduVGRiOUJyT0ZKVWVLcGhLWmFEVG9V?=
 =?utf-8?B?eW9XM0t4MDRpbzlHVWp4aFBtbFRzU0FQZ295SHdDS0lmWllNVkJzZ0VsbTg3?=
 =?utf-8?B?U2c4YlpOOWUvRVVJZnFYb3AxS2pZWmg5bWNybHRzZlh6c2xtcHdVMGY3MS9v?=
 =?utf-8?B?dTRNT2ZSQWMwbk9tOHFSZlRzRGFOVUVQbXdrc2kvNXZwdkpoOFdJdDR6RjNT?=
 =?utf-8?B?MVBuYnhRdXU3TzF6dzU4MFFEZjQ4KzcxYmV2Uit1bkt4Smt3eHFSVmdGMUZS?=
 =?utf-8?B?NDdTOEJzMWR1Z2dpZGs0cFlRY0svQlE3WlRTbE10VysyeS9qZ2puMk4xdVpU?=
 =?utf-8?B?TUdmaHVTWUFpdVM0M1FYRWZZaitlb3UxRGR3UHJCZFpSRVR6elliaEdEb3Yw?=
 =?utf-8?B?WCtuVGlNME80YUpZb0xvaTR4UmxPWjluQnphVnhHUjBDMWh4WnpyQThZU2V5?=
 =?utf-8?B?Y3B2SzY4NWJkS0FlQ3N5c0tTTTVVc2MxWDdnazVoNTdMVldIRHJ6OVU1OXoz?=
 =?utf-8?B?dmliOEVJNkJnTzZJMy9JaEc2SzBjNC9qYTYzNW5kemVsaWxZa0FlWjB3QTRF?=
 =?utf-8?B?WkNSMHRpdU9FQmh3RUVRMFd2OFY5QWd4dDRsVjNNSm9IOUlzd2toT1Z3QnR1?=
 =?utf-8?B?cXBjbUhZNjNlTVJIUGgwZUtzOWFpYXkwZE5WNjhWOTVQRWF3Q1U2Z1F6eTFj?=
 =?utf-8?B?TDI5UURHVWZyZTkxRlZUcEFPUlNDczlkMmZjZzhqcmhQSjdUYjNONlVPKzVn?=
 =?utf-8?B?WjJnQlJ2czNySzJ4dUk3UFdzUTN4djN6b2J4VSs1RjVnZDRLdWdtamltb1A4?=
 =?utf-8?B?RjBBRXlnZndzc1g3TkE3eHM1K0UxUE9NVFdaUmlrOVFtOVFWbzVjUFczS3BW?=
 =?utf-8?B?WDEzazltQ1Q2WEJiVUJhcjc4dDlMNzQ3dndJaVBNemJMSk9BS1lFenFWV3k0?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c709f-6049-4771-9797-08dd6d2eac66
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:55:38.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuRbRDs2Z4tCWLVhZhaelb+Lk7MmdTIXlnZ3nkKSa1C39C3+2Ur2KH9KSEFC1QIxXVPho4v+2uuBrvBVgRm+9ZRcLYVxLyGeq80bTScSQ3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> Renamed xdp_get_tx_ring() function to a more generic name for use in
> upcoming frame preemption patches.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      | 2 +-
>   drivers/net/ethernet/intel/igc/igc_main.c | 9 ++++-----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

