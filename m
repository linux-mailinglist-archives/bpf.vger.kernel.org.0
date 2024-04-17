Return-Path: <bpf+bounces-27037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19C8A825C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA67B23913
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD86D13CFAF;
	Wed, 17 Apr 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pg5mrRg6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A570AD48;
	Wed, 17 Apr 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354591; cv=fail; b=iGW7NlZAAzQ5Uc7u/ZCkyTMULmvBpz4OFYVmAXCoxrU0OzWVg2fPfidL3qNAc/LXX9Xi1g/khvD9HEB90cezqnkz1j3zSFnJensNXBhjHuiwDkEMpIUYVeZiBYYjBC4Aja2/eznvYthdmH4ctLcM4ocS07pDbEE4NFCs++ke/Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354591; c=relaxed/simple;
	bh=4XNu0eMdG28IUOjiu7H17qYbkCVQTfTuMjWyhcHwMJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoIEx7GjJxrVYTa0uPvDiTgpvCe+hNpadp6Nybd3BTPTq9nRovYGc3yWuE6CMp7yMp1QDyGgprj82vK6aCZ5bQlkZh2SybZaqy5eCHEmWpIkS8NEfq6dqYeuHJqrRzpmj89EEWTmXFCU3elmma9hzsRWPnKO96tp9TnftNCScDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pg5mrRg6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713354590; x=1744890590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4XNu0eMdG28IUOjiu7H17qYbkCVQTfTuMjWyhcHwMJg=;
  b=Pg5mrRg65jh2HRtjGPbXdyo5xGyIlW9rWCBk+lWBvja0E77FBwod2jNX
   odAqg2ZQgsFdTtDB93W6F6CEJAayXw9HEe3OjzNEUwVlmxYERjP2RMIw4
   RFIBYTTDpeMEFeCoiKv76g6+suVtztsUZQMk8TX5m9NIO4KoCo11/MtN5
   rT3PVhC4yMqfj962NjxNwkyrZcwu08i/33ZMy1fm6TEhNXZRCwclxOz09
   LqeZJIsTokQAJHrbNcMHOEyLHqZaULuhKP9MCTpJQl/H9SSw1ClqQ3wVh
   CmX7I7vaSsEhkj1kqOixaalcCaOEkCbLGNmNisCiugc3QrEIXOdj1iU9z
   w==;
X-CSE-ConnectionGUID: z2NuShuXS7K5Y9iK4p6aYQ==
X-CSE-MsgGUID: DtWeXf8PTYqFGFiF1rITcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19546973"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="19546973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:49:47 -0700
X-CSE-ConnectionGUID: OrWU6Iu/TD+/6JKpzTNa+w==
X-CSE-MsgGUID: tujkLIyNTMCgL37U5n3U7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="45897262"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 04:49:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 04:49:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 04:49:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 04:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8D05YX6NVguFpMs9CgcE24pOdNnMZWXcnflRfi3PYPDc5nrPzWojQy8vLCJyW87oTIuJq8z7wjRo20ykbheoiMKlCNMd1eRn4Tdv0uRwJ0DnqLcv7bxUyO76hnTLGHdlMhaITGOniW1KMDI98xioxnyQ6hfyducwYid+FKyc4A7cVTkMIWYpVicEDiLvr0v7v2m6V4zZyOCnNyV8SXCQHNic8PZprio7ay0QTkB2FDcIezwM5x8qwMlfnZWXyfKtx0fOEQIiYZ/RGUdsXKAgb6HXZK4RAmKxgKSzVb5ouCzoiY8AWIdOGWb2vGzb3dt9qDWBb7xFnxr2dq5OwqPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6UrEhkN183IxPF4pVePyBmHsqjqrBVnyP9hYSyQ9jM=;
 b=miwBlpq0aLqUad57wtzWEFpcPoY04nWoCqpcjvDzqxArdQkzxRptlXzk0RFmDjwKuaFM5ZvP8wrGu/DoRiDmeWLcjKywICezwBNhENjCGYjWjSDclss6c9YlSJ1E+q/wrwLAgRpfusokyKDyzgKbNzRGWrv5b/zttRCiq1qLnn7iAe8IXcEXwzwaNkpOBdG/fl8PysqynWGN3kXZ0n1RhDcnq5dNd+XVFQrNGRmKCRaMmagomngwy41Uee+VajIoCWo+FaQi9Ko6ivlwNi9HlrMrIa0XCUZvGB0ODgUO8LroNsFRlE2OGeaXCiR+3bkNCkPZPIQR5Tiq0pb32Qa2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.28; Wed, 17 Apr 2024 11:49:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Wed, 17 Apr 2024
 11:49:42 +0000
Message-ID: <8663692f-528f-4d68-8c35-136e5f1244dc@intel.com>
Date: Wed, 17 Apr 2024 13:49:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] [v2] net: ethernet: ti-cpsw: fix linking built-in
 code to modules
To: Arnd Bergmann <arnd@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, "MD
 Danish Anwar" <danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Tanmay Patil <t-patil@ti.com>, "Simon
 Horman" <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
	"Grygorii Strashko" <grygorii.strashko@ti.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240417084400.3034104-1-arnd@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240417084400.3034104-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 852f4a11-75dd-40ae-5a2c-08dc5ed47863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJlnI6JRQjvzkJxb45U2pibOp0n2od6N5ehDiXmNSI9BVya3bMm/idrjLyM1Iz/IaX2yj43W4sZBi3VV2/bDNNtXZnVoRziyssg3VGA9UZfeL/jdugi/rzp4ialQTFT5lOAULFJv6qxJl48Wsg6CA2aE9evK7HALr1oDIuG+uA6nrHJhTwIZCBfJu3WxTyvWWd3AtI8pvQP3DHTUjQb2KDkQDRBsAyfEw0CsCdj+XHAJUVQcEGcmK2kjvx1RiHBgg+KkTsZv0EBo3OGSInzMM0ALe27DszDTfG1DDPI3+Ee8r7RcVg21UbL2h0aNSskPAI7rE7u5Zh75aeszKLrmWLzj67rMzKO9Cx/k6TCUeD28h1WpeB3UNQweadVb0/ZAGHr//kZmqp60vqsq5BIxrMEG0b2DhYQyXaECZPhD9mB+4MyDG05DfjmQANR5jntrmfiuvc108sReL9DYTPOQind+1ioHb69zbrAtgkXoiOa4Qaj+8XBAD1eh6SkXfQ3KCxCCKbm8IkuvkJ64zZK+pPIuEVj/LD0cNb1pHLYcl4xhsKrjTE4zlE8WNcb2SQUUcLjVNjomqIp+o0gsN+r5SgLoN3XfCYRp9xm2M3z5Swum+NMfSFtrmltK6sYSAIICBNlIb/QtlAjHPa6DwmLbd9/QhRcVNo+Ktg05xzc7pG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRidEpmbXhwaDBTdTJvTURRcnpmUG1sMDUvd2ozeW9iMmtNTnpPcUV4eGxv?=
 =?utf-8?B?VENHWnJ5SkM2aGNyaHMveHQ0OUVYVVBIdkZ2eUxEdTdscnhFVE1STkFBWlk1?=
 =?utf-8?B?MTRhK21MT1U5M0hmYnM0cUtGaXdNWU5GcTQ2Q3o5c1AvZVRLQVlIY3VpQlFH?=
 =?utf-8?B?SkNTVUZpckJ2RXZNWVJ6QU5xb0IzYUhuK0FYaUh4Z2dEMS9ZRVNPb3dhRjZ1?=
 =?utf-8?B?SWNWOC9HejdiN3A1Z1UwRzQ4RUg2UUJWeDlsWmw1Y3ZRZkJSSGRMVXNNcWlx?=
 =?utf-8?B?SkpqdzhaQUxleVN1aEVoR3pBSWo4WkZ3bUxTeTB1MFFiSnF0MnJ1S1Iydkht?=
 =?utf-8?B?dW9ETXZDNE5mUk94bWEwODByeHVnQ294SkZncDZ2RDVCMmJtc1Y1ZzI2VXJ0?=
 =?utf-8?B?R1dWMnhFOUNENkxEdDk0RktoeldPdkQ5NXpTajlWUjRFQjFjQTFqM0QrNnd6?=
 =?utf-8?B?cG53U1hMZXlxdEtoL2NQNHZvWGpVOGhmbm1pdHo2R0NCTnlwYkoyUHhiNFJJ?=
 =?utf-8?B?UitCbWJtZ1ZmbnRKNHVXcWl4L1RJU2ZCbTl1eTZiZnFvVk1TSWI0Y0NiMDl0?=
 =?utf-8?B?Q0R2dkljeXBIcmNxKzBsRXVtQUwzejJleUFCVFljbURENVpiK2kyTnBxREYw?=
 =?utf-8?B?bHZ2eFBFRFRubHJVb0pkSWdIeG1YVzhUYWVCcDZ3d2c3R2xraXJUODBFSmJl?=
 =?utf-8?B?T1cydW44ZzJxSDBIb2wvQmFibFR4ZFhkWFFtM21VZzA4U3djY0FJOEU0TENq?=
 =?utf-8?B?bVQ4U2lLeW91cy9OYWt5TDNMOGV1dXNrS3B0bTlTZWJMclhnSnhwQlRVUCty?=
 =?utf-8?B?S1ZkUEdkckVXV2EwdFNSQ0VGTDEyWWIyQmVkeEcwb1hWTFZQWlZ1U05BL1Vt?=
 =?utf-8?B?T2JvYUdPSldDRGh3NC9sR2ZlRUNSbUdsZzNwWmNPTURtOGFQS0FYZ3BIMXE5?=
 =?utf-8?B?S25OSDY5RisvMlEzVGtUNEIvTnd2aWVNcXpHbEpVejJnQkFtUTlwMTJOdG9T?=
 =?utf-8?B?TU5IVEx2a3BSL2luMk15NDBLYXdoeFJpNGVTUUY1eEdxdVhFdzFoSytMOWc2?=
 =?utf-8?B?clJpSWNjd1J1cnBQVi9mQWp2Y3lIL3F4U1c0clJCdDNxRXhrb3FDZkx4KzFL?=
 =?utf-8?B?ejVKeGNtcDA1RmlmNTFENjhHTFNVRFZpWXh1V0Q1cGtkUGk4VTFBbWRqRkZY?=
 =?utf-8?B?aGpmU0N5SDJNcXFjbzg4TmV4YTB4a3V6N3BvOGVPekZkNDkrZnVZeXM2bm5S?=
 =?utf-8?B?VG5GTGNPc2Y1akkramYvYUl0UXhqVkM4QzVIL3d0VkFCSzBFcXlxSTMvLytl?=
 =?utf-8?B?d0lpeXB2cDIyc2VEVm0ySWYrZCtNT1c0eVk2UWszR3ZhY3JKc21wZ1FaRkxs?=
 =?utf-8?B?bFlMRlgxOFh4TzJjNGRZOXJxdUFneGZsaDByeGxUeDdLWENjcUN5R3gycE12?=
 =?utf-8?B?TG05Wnl6bmczS05naEhxTGlsNFZaMUF3aHFhSEJpaVlZREVtZmo3R3U2c1Bl?=
 =?utf-8?B?bEFFREVFSUNDK0tSclZMSnUyeTE4VnFzSDVBYlBKUWNHMjVrazlnRmxFOU5T?=
 =?utf-8?B?QzEzVjBYN2RhUWdwbzV3RUNZTHZQejhick9wZHVxZ0dtZnZWWTFPYUdlVU1n?=
 =?utf-8?B?dEZhdXNvemI1Q3Q5eUpsQW9mcE5HQUF6ZHJKNGRPc1FJYUF0OXJIcXlubkRY?=
 =?utf-8?B?NVJGNm8vL1lxUWZoZ2tSUDZjRUJjZTBrMlJXN29paTZZdDhVK2ZRV1hxMkw5?=
 =?utf-8?B?a1JSQ3EzUjBiOHhjSmpYaWZJeUxFc0NVbklScmZKTVpOMldLSGVqVTZ2VWF3?=
 =?utf-8?B?Q09sS1R2Uy9UZ01BZlh6c1p4SmY2bU42ZitBVWcyS2hvRW9TbFFVaW9VWnVM?=
 =?utf-8?B?RVpxeWNHYjRaYlpvb242b1JnYTYwN1pHWk9sajZmaUxUWlZRUkR0Z2lGL09K?=
 =?utf-8?B?ZDFpTmgzN2s0RldvVzFMYUkrNHVZTWNValNJOWhpMkgrR05EdnZGRk5hby8r?=
 =?utf-8?B?clUranlldVJnR0kzMXloZWFIbVJXeVR1SUljWTU4OHFhenZ5OGw5dXdmcHVS?=
 =?utf-8?B?M2NYT2NWN2NmWUFjOWxCU0ZSQ3l1bDBqQ25wZHl5bVpzOEpzQytvN1pobjBU?=
 =?utf-8?B?YmNlanliaTlDS0V4QWxVQllHSEd6bWtLZ09ZTXRvaHZXOG13UDR3MTJ0a1kz?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 852f4a11-75dd-40ae-5a2c-08dc5ed47863
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:49:42.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHGd84p23YsWM9DeJSMQOIQ0N3vQm+guosEdhyOXUSIwaeMvZozJFo3Gl59U/sU7nzOTy+JzWfvtqcWJam8YFnuXhKZcPXdv3D/cUaHn9tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 17 Apr 2024 10:43:01 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are six variants of the cpsw driver, sharing various parts of
> the code: davinci-emac, cpsw, cpsw-switchdev, netcp, netcp_ethss and
> am65-cpsw-nuss.

https://lore.kernel.org/all/20221119225650.1044591-10-alobakin@pm.me

:D

> 
> I noticed that this means some files can be linked into more than
> one loadable module, or even part of vmlinux but also linked into
> a loadable module, both of which mess up assumptions of the build
> system.

Thanks,
Olek

