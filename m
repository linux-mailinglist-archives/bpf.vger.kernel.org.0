Return-Path: <bpf+bounces-54816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DAA73304
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8518318966FC
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218D21517F;
	Thu, 27 Mar 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDZcdC/E"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3720215061;
	Thu, 27 Mar 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080667; cv=fail; b=VbRySysiL7YwTFUHOeatGNCqDGDaw8f53DCSLy5ds/CMiowvTSlUY6ZEdqyWSSYxwWQIwrP8N6eVf+ae9HXl6e4ImUigSBJ1/mBuMUooVT3IBYTZQOaVmjQnLeV5HrjSRlZ2N9OtkWkrhivVxNqmH9JwLO6aVnAffmyMvZ9FUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080667; c=relaxed/simple;
	bh=c1zFnvZhHkTHVbisLWw4vBJ9KKauqgXfq4S5F45Bj3I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e/lfXSo/XTD8qGrvxatHglRsvHFX8G5DX3OpxK+psBkEqM/B3o5EUD0k2Njmk/Z0P6vGgEOBtccSmyjfHgTI8d/oCdRcQZIrCFzPWPQuHNq+EwF+hlAf+g/NMLbmyNctGOmHthDsrGjZe1nS9XbgTm7Y0y3UZzPFOZ3NopAZpuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDZcdC/E; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080667; x=1774616667;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=c1zFnvZhHkTHVbisLWw4vBJ9KKauqgXfq4S5F45Bj3I=;
  b=ZDZcdC/EvXPuUNNS9jDH5C4YE5eAQshk1cNTx5yqXEkcvzyMm/0Io4k7
   QdtwkUWK2w7ldrcOuT/BLKe1LpUg7Vvi/Zt7N3zktvpgd+HFhr4ihg37c
   urR4LasadqgWIBsWuiYVxEHSV7umYMy/QlvGpFJZ4XP6dj0qTwf6HwdV0
   +9V+okPTHritbBZxdGYw5luTNQ1I9dJbRwZhcIwDMI1NYpcDwoeUgsiUo
   3u6GGw/e18/uKsJS4VlxiU3KmlrCdJM/K/uWGJNzjRT99n6+tr7Bu1+cz
   DtSdTFP/0awGOSJhjmoXD75JNbe09lEkTRKmLdPxHBXD+1ACNDUjRpyrw
   w==;
X-CSE-ConnectionGUID: 8d2c/bprTHuHbrs/gHAJew==
X-CSE-MsgGUID: DcFiUdBBRyqFq1A88BOfrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48194106"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="48194106"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:03:17 -0700
X-CSE-ConnectionGUID: 2Jgw7M47TZKbOSdOdqp6vg==
X-CSE-MsgGUID: mxznbKB1SHeQZDvoGm9rog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125055065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 06:03:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 06:03:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:03:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkOk/2E5R5289y2OqwD+Oc5tLJ2Hpzl+31ppTKdS1Gc+lV3mNYpTrLjTMiIySRZaJm0jKURkcKQj5+0Th6XzxPhArE0fuiz1rPjMw5fOzHoS+VwrPW+qP7RarOxmY47j2AvaSZjdo+e94WT6/wOhODnnhO1bjGdrK09az8rlpDBt/eTdrNwqNM1LODvBGhhz+02DPwzo+Q1YUHBhjvqLqnqKHKveeqLsB9RQyjttKD6lMSDsFldCmtSRLj7wB5v0gFTJsibHHAW6YiYNpSQMPY1qU2ydM0Qe39jKeT1E8soyPOp3UPzvGhVKIZYzZb0jFw0Wrg/QdNlcpKD/dRDAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjsNDjO5ta0vSXfK4WXiZg2OAduFjgyjYRjzbuiQ4fI=;
 b=vDNPv8yKWnirjPAjeV5lrFSBZB+WKASyzxrJ+Ms2wonC7HZPKBYXkk5ESM7ITwOjOqawl3ZblKXe9wHUVY/zrqRqDUYtf20fKFZTio85g0k/yRbSY6RoITgr2n9dseyOiak5my7a8NFhlWCB6Q69JDzv2lu6nuTJriGggZUsUYkp7jcXDPgRUTtpyVt/GexWZZVviHEu39wZ2sL80WtXzp0EByAsCxuQPw1fNCLfzRsyuIu7IDUXEULbl3GqQljphfgjlHr1bdMxkf9ZoSqbZxZQk24eKU7krzCaYs+zlAGafurXgY59uDAqPB6kgIosN5qxXrqD/Hy0reFuVr9gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) by
 CH0PR11MB5217.namprd11.prod.outlook.com (2603:10b6:610:e0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 13:03:11 +0000
Received: from DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018]) by DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:03:11 +0000
Message-ID: <233486fc-edda-4398-9913-834db9047de6@intel.com>
Date: Thu, 27 Mar 2025 15:03:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v10 11/14] igc: add support to
 set tx-min-frag-size
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
 <20250318030742.2567080-12-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250318030742.2567080-12-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_|CH0PR11MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dd007e-dc98-4173-dc14-08dd6d2fb9dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWtzclVjOTkvd21XODNoNnlWZlI0YTBmSWJuMkx3cWxteDJjeGFpQjV5dlg3?=
 =?utf-8?B?WDUxKzEycGhDVXY3K1h3bW02Y056ekpQWDY4N1hpQ2lWVkQ0UzZUMkdCMmJE?=
 =?utf-8?B?YlpFMWZqN0Z0VWNYMUhnQkRNUXoxZEVHTGdQQ090am1DTkNwbFlPRU11ekVB?=
 =?utf-8?B?bW4rRmh1TDZzYmV6aTBTR3BNN2NQSGZCUWo2eEZYRU9DOHVDUno4TE9XTTEx?=
 =?utf-8?B?OVJvdGZzNWlWRm1taCs5VDdXRUk2Mk82SlU3cXdMWG9UUVR6dDZscnRROHlp?=
 =?utf-8?B?ZXNoMGdHMlJDbCt6R3JvbE0xNHY4alZHaEFQekkwYXpBMFp2YnZFbnpMZkJx?=
 =?utf-8?B?WUJyQXZRTEp1cVJVWXk5RDU5UXAwaVIwMjh1U1FGZmZZY0RHdlk3MG5xaEdp?=
 =?utf-8?B?T0JoYzJpZDRwVGJjRnBlZ2NybS9wRHlWOGdzR3hCNjIvczJFWGhiTjZPTEVp?=
 =?utf-8?B?emVIeTl5cWdyS2xUSVV4dXhhWExPMkxPVFpPWndOS2lTWjJsd1AxTFZXWnhk?=
 =?utf-8?B?Z29ubGp3YlJsUE9Fdm1COHhJM2h3NWxjaWo5OE5iRGxKV0dDNjhLRittMkxo?=
 =?utf-8?B?Z3NnWjluWWpiOERaak5uMUV0a1o3QjgwVFk4djFCM05BTU0zYjdzbUl5M1VK?=
 =?utf-8?B?VkdOZ3FxK3pWT25FQnpCeUZVQnpid2RYUkFNU3dVZWNmL1dUWnFyUWtCWUI3?=
 =?utf-8?B?bXFFd3VrY2gvL0Rwaysva2w2dmpoWE12YVZxaFZZOFhiM3RKZDRXT3hPVUpu?=
 =?utf-8?B?ZWYyamQ4TktXNXo4M2IrMWhLRDA3MFpXSVo1MkJKaVVwZE5KMW80OGUyb1dp?=
 =?utf-8?B?OG5WTWxQZ0ZjYVg0VmtwTkJaTUZLZnB1OFhuRzQvZFR4M3ROSEk5dyswejZO?=
 =?utf-8?B?R0FlajUxSUxiS3BDZXd4cy93K3pRLzNSL1psTGVjcDltcmpUS0hSM2ljKzNW?=
 =?utf-8?B?ZytZeHFIajVVTm96M29DMlZEZmVVUlBvcGVPNkdMN1ZUdWdaQWI3dCtFQ3Zv?=
 =?utf-8?B?MmRDMVdxTXFuQmNPN2hhQS9wSVU4QmlSYnVTU3A3bkJ2KzVFUzRlT2lFeXp5?=
 =?utf-8?B?N0hZNWxqSTNDdG9ZUlk2ek81akRTMnEyK2d1RVRDdTNQVXdtVkNBTFVlNlVo?=
 =?utf-8?B?SnpmLy9ENWhIeFJTYnVvTDIwWEZ0WDdUVjQ5eXZ1cWVaMDBldHhlRW9PaGlV?=
 =?utf-8?B?K2dXMVB6K3p5RU1zbkxLZzlCVWJDOEFkVlhGSzB1OUhZRU1rMjJJVE81K1lW?=
 =?utf-8?B?Wmx6S1Y4aU9jY2lJQTgrVmZmMUpCbTBDL1dOQTBBSy9Hajk4OVJ6YmNJdnY2?=
 =?utf-8?B?eG15dDV1V21VQ01aZ1BHUGdsaWxsQ3VNSjVvdE1CajZydGVtWGhNOUcyRDV0?=
 =?utf-8?B?ZnYySmJsOWJXWkNyTU11dS8wRXA4U2ZDakVXVXU0R1NyVHh0NTNQbVZUS3Zy?=
 =?utf-8?B?aVdCREpWWU5SZENDbW9UT1FVelBUR3VpUy80eWVnRXJaeHlrclVFZHgvazZI?=
 =?utf-8?B?N3pjTHFIUVEvQlBRWEl2TnBQRndZbWl1c2RlNDZvaDI1M3lWZ1FmRzBXYjFt?=
 =?utf-8?B?R3ZBT0k1UmlSZDhPOHVTSEdXSjBqZ3FEbDg4dFlsekxlTlE1TTl3dWhTUktT?=
 =?utf-8?B?WEQyQm16alVXbXhpYU1wbXBLbUFJN1lveE5QMmtpZjlXd1J1NkRtaDFPSmR5?=
 =?utf-8?B?RTFOaDBiYS9qZXFzU3dvc3hPREwvOWpjSWh2SWMvSERWc2M2N3JSNW8vOEcx?=
 =?utf-8?B?T0tqbHFEejB0N3B3NGVhTEVPbEJhODB0Z2dhWUIxZEQ4WnhjMXo0aXFoejBs?=
 =?utf-8?B?VlFvMWNpejIveFhWeDZwLzAvbTlCbHZkQTYxWms5Q1owbkx3L2hJNTdmOUpa?=
 =?utf-8?B?TmRzMVA3YTZJU3pBNDEvVTZlTFBSSW9hVndnSG05eXVsY0c4T0FWTTZqYnBx?=
 =?utf-8?Q?Q6PSV80GPF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1l0VkgyaVBJWGJpb0dEcEd0YlI3L0VzY0JabXhWV3ZqTGJjVnc3Q1o3M1gw?=
 =?utf-8?B?QUJzTmpoOUp2c3hjcU8yb0ZrS3pQWVIrZG1yMHVMUjE1dGthUnFtbThPLzVM?=
 =?utf-8?B?QS9DT3RRbktvQnFQMmRobjVjQ1hnN2VYSTlCSUJ4Q0RYWE9Ka0xISXRRdGE4?=
 =?utf-8?B?L01XWlNHUFg2bzk3WjlkMnNkc1BTaXNRYU8yOW9rcVdDdWUrWnRSUEFSTnJD?=
 =?utf-8?B?R2toalR6cHBITndDQWFTcVVyU0pTeWVYdGhmdEFBQjgvaFRjRU85QnVYcnhy?=
 =?utf-8?B?QmFwR0w2M2UwTjhGdElrN2FFLzN6enpSWGlLbE05dWlpTTc4anlhZ2dLZjg4?=
 =?utf-8?B?ZlZtMEk5cVdYK1JlSml3NUdXRzc4WEpFbnZra0MwZHkzOGgyRWhSU1BZY2Z0?=
 =?utf-8?B?RktuQU1McHV5TDdoS1JYZFpYWU9HNkcvdTVsOFpmNE9XWHZhMnZYTEJpbU5W?=
 =?utf-8?B?cldKT1BnVjI4dHh5K1BNWHhWNHdSOTFNeG80T1FxUGZpZ1FzQkpNL0N6b1BV?=
 =?utf-8?B?TmlUVEFPcEEveFhycG5QcmcxSmZpYkFodEpLd1ZYcnZxcmpxbk9sZU02dkE3?=
 =?utf-8?B?QXBqSUM1aVl4bDI4UlA1ZVhNUUN6ZngvL3NCRGxqczFvK2hUdSthaEhLelBO?=
 =?utf-8?B?WlZkWHVJNENFWEFIci9xdUNRZUwraWlDVHlGcFNYMitPcjB0ZUIrUS9DS2dv?=
 =?utf-8?B?UjBVc210Uk5sZFN3U2U4ZVhnYkJPRnJvMWIyL3hrb1dPTGVVdC9ERXhlQkJT?=
 =?utf-8?B?RS9hVndMUXRPa1o0UEtKWW5mRkhlRDFRL0FlRzREWm8rODB6dHRRc3ZHNVRT?=
 =?utf-8?B?OGUxVUgrTTNjbk1BWmhoODdBTmJsTHJwR2doai9XcjlCVWtxRm9POW5UbStm?=
 =?utf-8?B?bmtuMWt5Tk5GOG4yQmQ2Q1oxUEpwUlFRTmZlbVFjM3orM1pPQldrVVJ4Wi93?=
 =?utf-8?B?K0JWUkY5YmZTTmQwQnNaU1UxL2lFdXQwNVIrMEdDa01sdnB1N3kyY1lQUmtD?=
 =?utf-8?B?TGFicC9NNHp2N3dQc1NKNXRLNGVoMFdkeitKMXVYeWRQMzhnbFRWTGJsblhy?=
 =?utf-8?B?ci9rL2dDdmFNL1NTcHBQM0ZDTmJ4R0hXRXRXYlhienBWYXZONGpwYW5tamNl?=
 =?utf-8?B?cFBMelJ2Tk5yaEFjRW9oUmFKdmg5VTRWZmRCMHM1blljUzdTNzlUWWZyK0l4?=
 =?utf-8?B?cWFpcU5ML2dadlRSUThLRzBQYjJyN0wzczQzU1MxQklTVmdTV1R4L2FSOGR3?=
 =?utf-8?B?L0dtMDduTGlaYnA3VDk1VGFQdzlBWFJYTmZ0NmJtdHpyMUxTUDVKMVdaMHBp?=
 =?utf-8?B?cmNOZ2U2cHFmYllPWVMwNTh6SkNJQXdmUy9VcFhhall3OGVQaHE1cS9venN6?=
 =?utf-8?B?c3FTaXVTTDJlQ0IxbXo1Z2tOWUJoTHo2ZllyUE1XMGF3TnhZd3ZJYzFNRmE1?=
 =?utf-8?B?ZWpYSmYrR2pBY1pQckp4QTUxeTVRbjZjd1RlaTNWOEhCQmZDeWszaVpxUEpT?=
 =?utf-8?B?Qk9KQWtUWXNFSkIvN3BCcWpYRkkrdFZzeWpWMS9FWkZIZWd1TW9vUTA2am1G?=
 =?utf-8?B?NHVrcGtBKzcyUVVCOU4zM09IQWdBcEw4OWJudGlqT1JTZ2RLS0c4bmVkSmR1?=
 =?utf-8?B?RzZxWUljNHVoMFByQndidTVyb2tabWg1bGtVY1cxeEFzeE9RTGdRL3g3M1g3?=
 =?utf-8?B?VHdrYkY3Vko5T1o4Wis1N0d0RUtZNHlwdXFyYjFsL2l0aXhsS0dCUStBRWhj?=
 =?utf-8?B?YjVyOXQvY2tUQ1pLQTRzemx5dk11RW9RNjVKNXhqMVZiT0ZNMEtZVzhaVkNw?=
 =?utf-8?B?eFlFU2VVYUZiZVZUWFRndmgxTzJQUzB0ZUprSWVSVi8wSHE4blQyS2t4V1FM?=
 =?utf-8?B?Z3ZGWTJ6akg0aDJUeFJWMlFFWlJxdittdFNScVFYeW9MQ1hvUld0T05jdnlO?=
 =?utf-8?B?cW9kc2VJZlYrSWl3NFhIbllyNG9wcllEeUdBU1JDQ0EySHAwL3hCN1RJdDlK?=
 =?utf-8?B?MGVLUkd3K2dpVGVXZU12RXRIaXFoZHRPRzloakEwNW0xTnFXWnd1RmtGUnZT?=
 =?utf-8?B?dnMzbTd4Uk56eFNLaTQranhhMTBpODc2ZnhhS1M4ZE5RQnE3T1BnUEtjcnRy?=
 =?utf-8?B?QlJzaHR2ZFQ3Ump3bklIMmdMZUdVRzVIb1RQRWM3bngyN2RkbHJyNkkrVE5K?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dd007e-dc98-4173-dc14-08dd6d2fb9dd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:03:11.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9V1eLrHtsCjlwCJPGSNu8KFZPaQRCZy1ii6hZq7nGGKwfL1obOGmEg+o1S2KkSkhkqaCuuc3q09z4ne76ddG7TCVv+PCR431ibdfRPMyHAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5217
X-OriginatorOrg: intel.com

On 18/03/2025 5:07, Faizal Rahim wrote:
> Add support for setting tx-min-frag-size via the set_mm callback in igc.
> If the requested value is unsupported, round it up to the smallest
> supported i226 size (64, 128, 192, 256) and send a netlink message to
> inform the user.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  1 +
>   drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c |  5 +++
>   drivers/net/ethernet/intel/igc/igc_tsn.c     | 38 ++++++++++++++++++--
>   drivers/net/ethernet/intel/igc/igc_tsn.h     |  1 +
>   5 files changed, 43 insertions(+), 3 deletions(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

