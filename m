Return-Path: <bpf+bounces-47436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762299F95EF
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BE016250D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D70219A64;
	Fri, 20 Dec 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxTpWwC3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A861CAAC;
	Fri, 20 Dec 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710395; cv=fail; b=Wp28Om7xIePfAF5guGcsU97zh3Wgt/1RRsPJHkBt7q7EyI2LB/usdOXJyq35mCCUMeQOJ9Tdc7HplvJDysHCGl65qtoFvHyY4N5qCHWEqqPA8VSvTeF+SOd44CB5ipY3+mLJweAJfXZqnt3dTTj7T9r8xhuj2PfW5QBzmhFbCDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710395; c=relaxed/simple;
	bh=qKdzxWvru5yX5jMUTaXPZGOHk1Vw8GrCRw9KkYsxw4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+lRlUNo7EvrNXf8iP3ZTUN6/vXsddnYOORHYG41+7sR4sj06rXy/v/yAv5ssANsql5v0eKahUdOVXSOq1j4Q3cxnP+Nv5CdxWuGSdG2T/geNG8yvelooZqnm0mbhALVMZAA3F0LQ3eN4Ao6NaXIoDWHZIk9KhkWjIOm9GIR++4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxTpWwC3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734710394; x=1766246394;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qKdzxWvru5yX5jMUTaXPZGOHk1Vw8GrCRw9KkYsxw4g=;
  b=fxTpWwC36JGwq6OiXq/2V0jXJRjG2HaCQaWIEGfuZYt1TVp3tqkLoiJP
   a0UsoNYrf7MjN/u0QIX8gvgc/RcXi8mhsqQu/6UxWprqA0fDGZ5oz54Ho
   vxBEPjHpi/uRKfxA+7Dypn1ThZg0Fd9/zpnIqD3VF2ptp6SHM6Kv4RVAq
   Q6euNPX3do8JmJgBjopJMdfFDHKPYqC/Rlg5NBI0Fc9/Z8IYCAfa09Wyc
   //mdGsHOR8K0jUtp485CtuDiaEvegUvuJ3+o4ndTRcvoxvoJ8tn8308BW
   ErEqleBBX/q8YKJfpdKtC6e7Z4Sgu8qSmx3mcOvE7QTYgb3VYDRAlNkBv
   g==;
X-CSE-ConnectionGUID: eLEx0r36S6+wXbGlwWNizg==
X-CSE-MsgGUID: mt/vqttBTTmu35GvKajcpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46270091"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46270091"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 07:59:53 -0800
X-CSE-ConnectionGUID: zyiJMuc9S9K3P3GVhLV5mg==
X-CSE-MsgGUID: IxWtKh83Q16tgTQIvwpqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="103523618"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 07:59:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 07:59:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 07:59:52 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 07:59:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xguMZjM20sW2U0rXLeCg3xKWwkGuXHahRinN+8wqPNt143G5Jro38TD/0OXh8tspjVvRPg2fKtC9z4gjAU9vJvGyJ7tlvgRUPyOh5sJAtVbzT6Dl1oqMJ4Nx232xT/e+YUgLPacU9AO639TKXLkCcDtUJyKGVvgEaXidxqULAucXLW9IunjmAV86CPi/RxdXIyOj5wYkFL0pgWXZqPAACoHQsJabp6IKZXbAaT1NgM4MjtifVmBWAXRLCLODBObFfqHejM8sTmucsLRrwgzmRlJDvzhVugiGvahCXMybitDuO2m9MSTFKUfK1lGKwzCbmTfYbuLtGTgU6RRDXDH1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTsbYLOJq7Ze5VBRr0zo3SjJd9Esl3mgpRz8usjvyVo=;
 b=Qn2nCZvQe24SHlioEu/GQmYQt7ZXTxbuv7/6dlfU/3jaTikXbF+/e4VdMdN0N5bT7QjJrRE4OUBONQ71gxoqwZP2yvUdvOtNs9ax8oqp36gDxSPRnwKZuWNoT0yaE0k2HycOVOgZ2fTPD5TZL9kTErYMjPWi73xZzofLcIQqnNUfwss1yafGpc8uBodZQiY8cbCmpTnmQJzUEMtgpfyY45MrX/IzYuGolQiS51SLkT8xHI/ZCmL1O8YFrR/OKBF8BJiIFg5YFGAWumND8esTWauHvqJeyRNBwsCS+UcWwroORA8YSgIiaV8PZoHPb6sOX0FwX5GjDXS+rDH7aTfgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 15:59:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:59:46 +0000
Message-ID: <388fe411-d06f-4cb4-b58a-a2b9b5eb08ce@intel.com>
Date: Fri, 20 Dec 2024 16:58:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
 <20241218174435.1445282-7-aleksander.lobakin@intel.com>
 <20241219195058.7910c10a@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241219195058.7910c10a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0087.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6eca1e-a297-419c-6d57-08dd210f52f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWl4b0wvSVZjWHFoUjVFaUZybWpPQ3JycVk0QWl0eUJRSCtxRTVTcEtuY3RL?=
 =?utf-8?B?RUk5QzN4bTdMYzRXbjhTWjRyUVRHNmcxeWZrcFQ3NTV1bGlHWlZpaXdSSTl4?=
 =?utf-8?B?RGQxSzhOZFg3Wms0NmN6dkQ3aVRBMlRxemZ5dFhLNGRpM3NKR3o3MERxaDhV?=
 =?utf-8?B?KzJyRzViWjNXK3k5N1ZTT1RFL2ZOKzB5QTFiUnp3TmhmSENua0FsSzFwNERx?=
 =?utf-8?B?elRPN21sMHlXS0hvZmVqOGNQa21iM3BtOVBZQU1vUzlCUUp0YUxCUGZpTFVk?=
 =?utf-8?B?MTVJV1QxS0c5YTdxSTlLQ1V2cExIbkhOcFdVVEhkSWZoaHhaZHNXSzRvdWhI?=
 =?utf-8?B?ZjhDaEZ4cG9JVWN5K1EydkM4bHhlUjRHbmpkc3FES05tMFV6VzFXTmphZjZB?=
 =?utf-8?B?V2QwU1piMG5IVnFIVWxadGRZdlhvYmUyN2FHSk9PZWdkWDdCNjNGc3RXeU1w?=
 =?utf-8?B?M28zM0VWb2p6aHBmMDJCR1JiOHgyQ3JXRVY1YzNSR2xROEdsTWl4MW1sTjdS?=
 =?utf-8?B?S2Q2azlEMmVDTFVENVhEZmpOeWc2OFF6WVZDMTMyQ3ZVUndibXJ3SFV4TnlM?=
 =?utf-8?B?ZGxXVmtDd2E3R0RScXhMV3lVaFJJQzAyd3R2a1J4N2FBNURqbFVHaXhYY08y?=
 =?utf-8?B?NEZ2K0trK05rY2dXZ253bWJiVFF5MlV4eGVxZzE0YTB1NnQ4ODNGME5YSytj?=
 =?utf-8?B?NFNsYnhLYk02akVERTJnUUVkU2thOFRjTGp3eHlGVjkrZzNKczhzVjdnaGNr?=
 =?utf-8?B?aDI1M3lNUjFxVlVCM0tySmZkL25UMDF2WHNaZ1Bselcxd1UxazduaHpwRkVk?=
 =?utf-8?B?VGJOSXY2d1o1VzI5SW5NcVFxaFdxRUJ1MTZHanpqR1ZhYTlaMVpBcDFxWllJ?=
 =?utf-8?B?TkRsbm9DS3pieVlhd0ttTTdydmdvUlJqZEJqSWtrWm56aTBmUytjZFZZZmNw?=
 =?utf-8?B?YkxoUFRnSkgvRlVpejlMT0tmSy9ZZ1cxemJsYnh5ejFnVFV4MzJaZ3BNUTlV?=
 =?utf-8?B?Y0tBdTk5eGp6aTZPL1E5SllMYjhaYUNCa3I1QjBBQXN1VkhMM2NHT2pvNnk2?=
 =?utf-8?B?UDNKcmExRUFrN0xiMjNhWC9vMGc2MTQ4SEQ2VU1EUGxGZmdtQWt1cFY4R1Rw?=
 =?utf-8?B?eU80cG9zdFpxRjMrSXN6Z1BDSWQ3bmFQY3duYjBSUnFFbFhOMFFYZ1M0RW1i?=
 =?utf-8?B?RDYrWnJxRDBWS2tkWVdUckh0WHNpdlg3ajFwdFYvYnZqZlNmdm1DdXZ5WlFR?=
 =?utf-8?B?YlN2VmJYZ0l1VDlwWlR4Z01zMFgvSzNMMisxeEczS2pMK2swQU9iYlViVGhk?=
 =?utf-8?B?c1I1K3dhK0phYllta084SjhqdGk4QTJaQngrVmJuT0VKTEtkMktydUVLTkgv?=
 =?utf-8?B?MWpTWlVLcDdTY2ZMc3MvdUFmQVdEbnorWVJ2VjAxYjg1eTY1VHQ3NWdUbzlv?=
 =?utf-8?B?VmZOTjlYL2liVU1LZlh1OWt2M1QwZ1RiN3VDQS93Z09mNXJOQmxkYitNbVlp?=
 =?utf-8?B?c21iNDBBamhWb0tkWlQ4VlFlajEzOElnQ2xlR0ptZnVIeTNybHZpaldJZmo5?=
 =?utf-8?B?clZxcVk0T3NyVkZwTUR5YkNIdFI3UzZMcmVnRml5Z0hDRGNxaENNYXFncStX?=
 =?utf-8?B?OElhVFVIVnBGcE5ocDk4N25vZWJYTlE4VEtSNVNyT0k4dlNEUXZzMGh4NjZT?=
 =?utf-8?B?TzBGUDZscXdFRkNMcGFrMy81eVA5M25IcTRiWm9mMzA0WDRXM0ZsY21JMUx0?=
 =?utf-8?B?K1ZCNG9ybzhVeGEzYU9LSmpaNGdEVDVjL0g4WFpOK3VOTCsrV05xT1FyNUpT?=
 =?utf-8?B?enAwRURsRmcvbE5xT0UwODdrTG5Ebyt0RUliYkpncmpPQlM5VWlRRHBUSTdQ?=
 =?utf-8?Q?RtHVQS9zVMtAC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2Y4bVRjUE1vVTRMbDc5WThHcnlpN1pOUlVGVXBkUFkwUHpPdE54QmlaK3lH?=
 =?utf-8?B?R3ZmWHg3V0RRdmxlUjZBRUdObHVpbUNETmFod3ovTU1aci9RZ1F2Rm51ZjF0?=
 =?utf-8?B?TXNYNGhEUkJXaFVMK3RDc1Q3ZHRMYmpUYXVBZ0RjTlNsVWNKM3pWK2UzTVRq?=
 =?utf-8?B?aTVGVE5lWE12dkZwUDdCd3orVS8zWmcyYXRtcERvL1RkYklSWjFrQTZlc2g4?=
 =?utf-8?B?Nk83c01NcWU3TlRnN1UzQk80OFBoTmJ6Y0hVbmtvbXJrSWdQanQraVdCK1ls?=
 =?utf-8?B?Z3l2dnFnTkRHQmhrdEoxTkNrZTVaR3BaQUg3d1FJYkRUR1dmQ0h1Rm9HQTZO?=
 =?utf-8?B?bzg2TTFjZTZ5QWlPczJ4ZTFuQ2UyUXBXOCtzSHRadFprQkY5SmVPZGFMK1Zi?=
 =?utf-8?B?SENxRE9ZTE5NSHMxZjlqWmozc29RTmJKcVVBdzVsMFlZbzBOYW9XdWs4Yy9i?=
 =?utf-8?B?ck5RVkJOVENSWHlTanJiSTQ2QVpiMW9UT0ZlRGpjWUxvSmdmV1RNV3hvc01z?=
 =?utf-8?B?MEZhdkpsMmxVSzJFaWE1MG0vQ0pwN24vcjdPblhtV1lVOXNRdDFvNlB6SXpy?=
 =?utf-8?B?Q1VxNWdsTTNSU0NlQ2g5QmFkdnl3MmorRS9mbVNKUXRXNlUybUs2WU5KY3hQ?=
 =?utf-8?B?MjkrRVNtUFBNQkpjSGxXV2sxU2ZCVmVaandSTmJLRVZDYjEyZjVVNVlwZkdp?=
 =?utf-8?B?QVcvTHVyRVdsRkltUHNpOFVRSWFpcTNnTVViKzJBeTVGY0RGM0JvOU82U3hL?=
 =?utf-8?B?cXc0WlUvc0plS1lDRU93alIrd3BqZzZGZ1FpVm5EZlZJc0x5eElDZFVRL0RH?=
 =?utf-8?B?YVpCWFgvbmVCUnlsaGRzQU1HbUZvRS9OcXB4L0FLRUw0Zk9jUlJ1ZUV4QzVx?=
 =?utf-8?B?RW5kQVRhZ0VPMVBpUk9yU1F6MG9FSnFscWcrd0tTeHpDV2dDTE5vM2pabGhS?=
 =?utf-8?B?d0lBd3JHTDFQM3NJT2tDZ24xOVp4Z3EwVm1yZGpNY0JmOW9kWUZteFNJRHlp?=
 =?utf-8?B?VTVLZWhsamFpVDVuM3VuQXI2d09PNU5tSEdSMUVzNGRkQ29SVkswaDFVcHpi?=
 =?utf-8?B?bkg4aU1WRmtjOGl4a3NRc2dvd1ZES2lLeXJQOUlpaC9EbUhNeGRkRk51RUQ4?=
 =?utf-8?B?WUxYUmZjSkxWSVpmeUg0ZXg2YlJEUnVIenBWeENVblcyMUZlUHoraGordFY5?=
 =?utf-8?B?RksralZzTzB6OEpLMlVaSWhvUWZNVTdDN1NGRFZIVnNCWjdRVXhkNmRlNGVj?=
 =?utf-8?B?V0g0L0tsVnUyVXN4VCtuakM4Uk16SjhVVlRrbnZpWnF3SFlBNWlTUlFZc3dh?=
 =?utf-8?B?d2QzTk1IVlU0WWZWM1ZFZE1ZaDFGTGw0SEZDenpIT1dETHNDYlJzdkxEc1Vv?=
 =?utf-8?B?WklWeExOd21qUHVnUEM3WEpUZlZHK2kyTjVZaU14Q0FJeUplYkhrUitoUGhB?=
 =?utf-8?B?M0l0T0x0OVF4NTUzWkFGZit3YWhkcnA3NDRxRXhaSllOWk84NFUvajhaZFFB?=
 =?utf-8?B?UVpVaVNSU2h2S2JlSCtETTI0UzJJdCt4TE1LdWdKQTZpYVlWRjUwVWRMRlky?=
 =?utf-8?B?ZUNDZS9WYkR1eVBoL2ZCN001Q1hpQzJMSU90S0NXOWtRc1lydWhrM0JQdjRF?=
 =?utf-8?B?T3RrcHBoNkhObUtySW5wM0hid3U5OSswNWxoUWN6Nkl3cm9YdlRSNjJvU29m?=
 =?utf-8?B?YTFOSmwxM3c4UEF5bGxkekpVTWI0YmFKK3YwQllkTGhYeHVPRUlQSEV5dVAw?=
 =?utf-8?B?Njl0SDM2Q1lCQ2Y5VHBzOFpBd0RzZjJvRTgxRUlnanBkTHBsKzE5MWRNUDFU?=
 =?utf-8?B?ZDl1Q2VNajZaZy9MU212cncwWFhNaTlxZ29pcGwxNGdoaWxZaUJFSFBTMEdq?=
 =?utf-8?B?dGFXWlFUWUV2OXRpQTkvZmdZY09pQS9KdlhGanZBUkdkeTcxNE5sOWhJVHBp?=
 =?utf-8?B?SGpoa3dURitHR0VRbnJXWCtDRVJWSTRBMzQrKy8wcytpV1JZZ2M0YjJKTTlh?=
 =?utf-8?B?ZXpJczZqUHlTNUticzdha0orQjFNMnhObjMzWC9oZ3JFUDZDM0RqUmV5ZW4r?=
 =?utf-8?B?dHhuai9kZUZtRFlSOFpEOHc3VHk3dXFyYng1ZXY5dGVyZGk3ZGdnemU1c3pZ?=
 =?utf-8?B?S0FPWW1YTWFKVkd6R2RxTUc2VkRiK3o2dmVvcGZRSGpGTWxLZnVTRjU5K1pG?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6eca1e-a297-419c-6d57-08dd210f52f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:59:45.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4McEPqsA4gqPk/xWPo/17mXx36OB+KHkxgEAXPU4SLhZnl8FTyZi8nRxwYXIRPfAxB+XrUBa8vmtgFHudKKaAxL3N3CKKgOygNuf8mASWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 19 Dec 2024 19:50:58 -0800

> On Wed, 18 Dec 2024 18:44:34 +0100 Alexander Lobakin wrote:
>> +	ret = (typeof(ret)){
>> +		/* Same logic as in xp_raw_get_dma() */
>> +		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
>> +			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
>> +	};
> 
> This is quite ugly IMHO

What exactly: that the logic is copied or how that code (>> & ~ + & ~)
looks like?

If the former, I already thought of making a couple internal defs to
avoid copying.
If the latter, I also thought of this, just wanted to be clear that it's
the same as in xp_raw_get_dma(). But it can be refactored to look more
fancy anyway.

Or the compound return looks ugly? Or the struct initialization?

Thanks,
Olek

