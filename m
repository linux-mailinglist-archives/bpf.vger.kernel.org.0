Return-Path: <bpf+bounces-42321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC59A28C1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F413E289A55
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442EF1DF73E;
	Thu, 17 Oct 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RX/VKosT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9B1DF727;
	Thu, 17 Oct 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182420; cv=fail; b=TERrDdLYNEGUa3s7NEHJpD0fdhBGqLRofmOS+AL2qVLmP1IX6WWD4CFMhNd/L5DeoaWfMmqESrYZDi8dIqv2z4rLycmb9NyoXkH65Qs3C1PUYmnfVrpmzMZ4K1mKaYwy7X13mGlMbR3kK17slK40BEOBbnNU4lixtmZUZ/r1bEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182420; c=relaxed/simple;
	bh=2oKqCbcTxA9FxVLXjbfiPLJfHg8pCCtBwsMNwsmZIdc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=losn0O5DeT47MNu9HQOczl6QfuQzpTAUlMwRJvTkeTBi7/ETr+kH1+7zux/hwf6DAmFWgr5YwAWorGN2/sb4P6X15HZtsvwtVe7Ag4MLCl7ua35NQKJBFHJQMSLC4OEPk1dGLzTPsO3VIbH9VV8uN8a7EVO/nAZDZdTQaxYytqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RX/VKosT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729182419; x=1760718419;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2oKqCbcTxA9FxVLXjbfiPLJfHg8pCCtBwsMNwsmZIdc=;
  b=RX/VKosT9FCTzSxKcAgtsDmaXO/nNj9zCZcKB1WgaVLNjjneAM5i6m/d
   wAeL6S5YoJlSnt2zGRJBBvcrrMMlfp1jtNsw4kANkAdBGcKnSmjPHeEJn
   KGSmYPi7oSx0ZwwKZnqzq7EQUla2XKzLxGdZG+MJ3q7ByBRiXeFrKNYVk
   YPgDDdNJuQHdwr3PAfSKP+peGaujCMxnBqpvKTSHCA+jA5WYDf0nPblSU
   nj/bs35vcKStk0+Aln6iGnJM3VDsR5KXOlms69mibJIa7uEYsvOC/wfam
   zmcucB4jSIVlKfc/w/5VZC2ERgdqyYJrAsVqLGj/R2hXZWu6FgBuIbR/v
   A==;
X-CSE-ConnectionGUID: E0we770NQIKdFL/lTDnBXA==
X-CSE-MsgGUID: vL/Ni2jcSkG/Rly7Tw/P9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32478530"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32478530"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 09:26:58 -0700
X-CSE-ConnectionGUID: ZS4rFgfDQvW9C2/kM3GC1g==
X-CSE-MsgGUID: jtp7z/2fQtS3dE3zpBKLlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78490914"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 09:26:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:26:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 09:26:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 09:26:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 09:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OufzS3Jqs9kazWvAYvsZoym8RuJJ0XKmXMpfvMamT6Xi0+e7ehbt/58Ce3R4uUWonDZsUS5lvnUy7PSl2DNpwf/84gZO8qggyTlkJdVE1y04rE67FkCbmAZDfg4N25sUx0QgCE8IEA3sfd6F3VZUk7yaPHAfbGOBL2mFREf5VVvjGVuJtjEK9w3d7kd9QDc/gPd5Icxxr9d7y062vUQTZEmnir0MMoBCINbWCvdhym501xIre8j+oXf+gScdBEPzB5C5TS7XJp3Cwh0QJNBNrhIj63CVwEgYRacB4D+N3fS/EvqAOTc2KqP2ipHMLPYb9ImjOuEgKTCpMyZYHIGnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSkn1cz0zNrQwHpHhuWl87NydZrKFOlSqhYSQSWGu9Y=;
 b=kmdU4h2MqFL5J+QR+01pZ8o2ZAYgvMfQWWDJIfElVZCWGuD6AkNzEyoGFbJsIYKqfxE8SqgVu4lqZ2cF7d6TAY8u2iHUuUcE3uj6OqubgyHqSD650Pqcox3pACtliEuwoSaDAPxcQCZYV/8tALRGFeAvmtJC92zjEW3ZEPSu4W5NJIRsmCGB49WEP+vhD4H+X9MYEDtYIK+d7rmDMCq4tIJ45rHeTcZ64whOfJLNOmzBQLVaDdDNH+qvb9p666ox5/M7Cc8Fx5TMXkeonrkkyE86By+nBBTYqKuC9haJ2m26q4khcmjIvqObknP30hCYY1QhyWdLBc8rNENEXzjPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYXPR11MB8661.namprd11.prod.outlook.com (2603:10b6:930:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:26:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:26:53 +0000
Message-ID: <1779f0d7-de2c-46d9-93ab-f73e6e09b186@intel.com>
Date: Thu, 17 Oct 2024 09:26:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix passing 0 to ERR_PTR in
 igc_xdp_run_prog()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Yue Haibing
	<yuehaibing@huawei.com>
CC: Simon Horman <horms@kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<vedang.patel@intel.com>, <andre.guedes@intel.com>, <jithu.joseph@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <kurt@linutronix.de>
References: <20241016105310.3500279-1-yuehaibing@huawei.com>
 <20241016185333.GL2162@kernel.org>
 <8e4ef7f6-1d7d-45dc-b26e-4d9bc37269de@intel.com>
 <f8bcde08-b526-4b2e-8098-88402107c8ee@intel.com>
 <672730fc-2224-d5fe-87d0-7dc9b00bf207@huawei.com> <ZxDvCoAo2puufMiH@boxer>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZxDvCoAo2puufMiH@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYXPR11MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f8fd38-ae1f-432f-70a8-08dceec882f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVhGTHN6c2VHU1JyRk1NdkJnMUZkK3NDUTM1TUpITzRxYi9sS3RVQXVObTN6?=
 =?utf-8?B?WVlhV3NPOTlsWWRYeC84SmIzMXVrSitWZnUrZWYvRCtiTEJUZE5iSWhEQS9W?=
 =?utf-8?B?QXM0aHhhNnc5QU5wUWphUEtIa1pUU0RlTWRidlNUVndhZU5ORndIM2FxbVJm?=
 =?utf-8?B?VGtIQnd6c2k5SXFUbTVEV2Y5NGpJYmFMdk9ndTMvSVM5RVc0L1VIcFVBaGVH?=
 =?utf-8?B?bXI0cENxcnV1UEs1cmxqS0c2enFPelBsc3JkdlJ4OEpYd0RTemZwaWhVY1BG?=
 =?utf-8?B?VTZybzZVT2dDM1FOaWlnYWFkamZNT2RPWVRQc0h2ZGpVaVlFTmhTa0QvSU9j?=
 =?utf-8?B?YW5LM1JBQlhhOWdNWTNGVUJJV1BLYVBrZnFaenNFdE5DUTNVbitnQVJLR1VJ?=
 =?utf-8?B?Sk52T0U4alZXNWRJS3d6TlEzbFV5bjEvZHZiTm1kam93K0VaY3FYUW5iRlJp?=
 =?utf-8?B?WXNZcTh5b1grNkp0b2hheVBZMHhtdU5WWFpWOVJWSzR5eTA2VDNhZktqaHBP?=
 =?utf-8?B?bXhxeWhoVHJHRFF6UjVZSlFQOUVWUTZwb05OYUhoTC9qVTdhdVhiYTR2b1VX?=
 =?utf-8?B?YTJnUUI1K2lsUlNrcDRCQkh2Uk9ORUIweVZpaEs0RFI1eHRIRjIwWWVSYlhG?=
 =?utf-8?B?NEJpbEpZUG5hYS9HQVRpanA5aE44a2ZKNVdPNjcrOXUyTlBPL01nVVVuMlov?=
 =?utf-8?B?dlV4QlJua2V5NHhoY2U0Zk1zUDRJZ3FrSThkTTY2QnZJbGhXQllLKzRtUTNM?=
 =?utf-8?B?V3psb1hmLzNpc2ozTjBhZFdxRlErbnNJUHl0TTJDWVFKejN2VUc3c29EY0o2?=
 =?utf-8?B?T3RhRklLd0dyUmFKR2RyMUh0ejdJRjk5NjBOZU0wK0NrM3BRWUdLYmFEbjMz?=
 =?utf-8?B?UjQ2Nm1YeC9NN1NHa1o1TlJZQTlnT0FBL3VlU2QxUVpUZU1OQk9JL045UTVB?=
 =?utf-8?B?bmRxdXRxbXRBQXB1WFI4Sm1FcHJXSHpqQjNXVy84akc2elpvVGwyZXhVV29N?=
 =?utf-8?B?Um91RS9CVEFGTy9WdTJka0pQbjdDblAyVWk0ZkxBVGtKaW1HZUxON2JZK0lL?=
 =?utf-8?B?Q2VINklxa0lsa1NCcjBRazlsMU1IT0FUQ0pzeUk0Z0ovbUNzLysvRmE0R0pu?=
 =?utf-8?B?a1orZzFQcmJBSGJaSDJqUFlYTWgrNER1Vm9vU0pOclcyRlBpVWI3cXBXM3Nl?=
 =?utf-8?B?WklrZ3dtL3lJY08zWE5jSFF6V29pNXRTZkhMTXBkZ3BEY2VxR05zVFJiSVFj?=
 =?utf-8?B?cnhVNG90a0l2d1k1bXZ4NmVwVGhhRmxrTUhmSGVrbmlIVUo0aGoxR0ZzaE4r?=
 =?utf-8?B?UTJoT0dUU2FSOVNvc0lydGpqU1ZuYU1FNU5aS3hMc3JFZXhmU1Y4b2tSYzNY?=
 =?utf-8?B?LzgyNXYycFdMNWJJMVNEQTlqeXBNYVpJdityU0VGM3hLUGdhMnFEKzZVVkFN?=
 =?utf-8?B?TVNWNmM2WVNqcmV3b2dyVVpkanVScG81M2VjTDNFTENBUlhQVU1mTlVRYzlh?=
 =?utf-8?B?WS9OKy9xSThZY2k2cnRIOXhwcUc2eG1tRXlSeXM1a3BYdnNwNG12Si9RTWFz?=
 =?utf-8?B?dEVmbmxQWk02aEorODczZGN3WWpidDVmT1doTDVBdTRuTmJVZWZ6QU5wczBh?=
 =?utf-8?B?SGg4YzN4SkxOVDFhTXBJTHA4RjZhcjRhbGdtaDJOZHhscWxpbDJpekdYbXpN?=
 =?utf-8?B?YjlUWUVoT0VicmROakJqblpkdHQ4SXFVRVJPYzVlT016MnJHaHVQYjFBWlFz?=
 =?utf-8?Q?JQU/7/lh5KtzEoBOD+B/Pe5Z1KC7ji0DE5FH9El?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpvZFdVMGRpUHNaT3BCZVhVMTJNUXZGRlZiKzZ3TFdpQlpidm5nVVdGLy82?=
 =?utf-8?B?VVh2VE5ueE1aS2RXZWxnTTlXRXlzd2xxYzIvcHNnNkxMblN1dDNwaVFwSlpR?=
 =?utf-8?B?cytLbEUzR2luUW96a1l5OUJjRTBzdW5Ka0h0TTBHZndaSktvMDNFd2tYTmZU?=
 =?utf-8?B?cUdna2x6UnhCZStqRDh6T2xnMys2UmE4UTFXNjdJMTNBaWF2UDhRajFqd1RZ?=
 =?utf-8?B?NDJLWkt0U2JpRlUwRldrZWlZMDNtcVFUY1lKZE9kdHgvYVEveWs1UXJGaGdP?=
 =?utf-8?B?T2ZzZ2pkRjVqMXR3Z3lheGJWREdFWlM4MmNqSUNaSDllZkk3Q05lNlU2blVM?=
 =?utf-8?B?dldBdWpHN0s4UDdqUjZ3b0Q5N1F4UXJHREYvbE9hSzdmZ3lSaS9tbFhjeERt?=
 =?utf-8?B?REJVSUp4cTJEOFFyQWs4dnVvQ0NSaTZoTm9UQ1FTVEhVbU91OVBVRFFxM3lC?=
 =?utf-8?B?V0c3SnRxWW1NWXk2Q1pQYnc3d2pXc3BHMWo3VDh0Q2pKVUlheElWbmNRa0Ez?=
 =?utf-8?B?d1kwVFc0Mnd5Sk01QkptZmI3ZDVFZFFBWG5oTktxK1FUTmMyUnMwZTYzTWtw?=
 =?utf-8?B?RXJ5VGljbld5VU11WFhRdm55aFBneitXRW9tUElXUWhyditSbGZ5enVlR252?=
 =?utf-8?B?VEo5UzVWb0NmeHdqbGxXeWJkYXlRQkg2dlQ2eldYOFZCbTRmdC9jaVNJdHdv?=
 =?utf-8?B?a3ZBdGFXWkZrZ2xnTDBmQlZWb1NZYjBYdm9oWEZZOWlqN25sNFZXREljVWpm?=
 =?utf-8?B?MUEvdFJSck1xdDc4TVVEaG1kSE1HMkQvQTU0ZlozVlZaRDE5enByeHdrbVN6?=
 =?utf-8?B?K2xxZ2RFRjFDL25LM1JpRnhpL0ZMeGlZSFA0SGlta2ppMWRoS21jM3k2UkV0?=
 =?utf-8?B?QjdKZUxGWUJxcFhRNkQ3eTF4YXMwMTJja2l3TGZCWUhpeHNEaE9jSDJzOURW?=
 =?utf-8?B?RE10U3NSNG5xMEtJTzN0UElEUHduSjRIUXYwWitweDh2ZmZrNDBaay9NbDJM?=
 =?utf-8?B?YzA1MjNXNVNCMzhyMlB0dGYyUUNDRktFZ0tOd3h3VWxtSzdXMGQzVHBOMnIz?=
 =?utf-8?B?SklVVS9zY0c4eXQ1bDZsSXlzbnAzUTUrSlIzY2FIUFJLK0RsNzBHRXVjbFBa?=
 =?utf-8?B?U3ZKOTQ0MEYvK3RMSys2WHRIZDhkMWV6NURCclhIVkt3dFBvdURuUndWb1VU?=
 =?utf-8?B?RWk4OHN4S3JWazB2aGFNRC96WERNSVFOTEw2OE9NVi91eGQvUEdIUTlIOExz?=
 =?utf-8?B?MmRoWU81UW9QSlFSakFIeHZqOTlFaFlrOWk3ZCtlRjUvbFpiRzNTVUpieEdL?=
 =?utf-8?B?RHVORHJhSXp0UHFtZnEyaFcveEhMdWs0VGloQno5VHB2REZ0SFZuWmtDZXBL?=
 =?utf-8?B?ajRNbWJnQjBYcnQ3R0kwRDJQWThNbk5HVnRCZFNDLytqK2VrMHZLRkhOc3ov?=
 =?utf-8?B?b0xvRSs4Z29ZNHJ4ZlFqQUQ0WUUxK2lXbkllWTRVaGVLcDIrcHVoaG41YTNy?=
 =?utf-8?B?UkF2RXUzTzJHbDRwN3pGdER3TkZyVDV5ZjJSamZnZ01TNWZKMk5tOFpOcFY0?=
 =?utf-8?B?czlrK2pNd3diVWRVS0dnVTVmV1g5NjFYYmdFdGpSNWJYYVlmODhpbFlJc1ZZ?=
 =?utf-8?B?YncyTHVpKzYya3hYVkQ0Z2VLWEozOFdqR3J5U2dUTGtDcnM3Z0twTUI0MmZz?=
 =?utf-8?B?ZmVUR2NRTW52R3Z3L0VsRmJEZkkra2FNeEtDbTFabEgzVUZ1VFlHMm9xWmRF?=
 =?utf-8?B?M0ZkMG00cFU5dit1U3RhNHA1NkVTMHdQOFhVMFFXSzdNUGFpWTBwZmx1UFhm?=
 =?utf-8?B?MExWN3Q1U3gzdVV1NGlRRzY1anorOHpmOTNQQlkvNkJFVHB1NnhrV0tYOGkw?=
 =?utf-8?B?T2NhM3NSRW1obTIzNHVEak9BYjJjNCtxdVl6Ums4dlhTb2FyWXd4U01MRGRJ?=
 =?utf-8?B?a2xTODJPK0dySmZRbHlQbTlmS2hVOUU3MWcrUDRhdFRhdVpUQ1JSZ2FLeGxK?=
 =?utf-8?B?WktBYkVVclRvQVFxNGtNQ08wbWV4MWpKaFJhK3BNalpQS2Nwb3RFbEJxN0J3?=
 =?utf-8?B?ZmlNVnVocFZoMFBFSFhIRm5ZVXJ6L0o5UHFvTnlNYmU3UDN6NTF5cVZSQnpU?=
 =?utf-8?B?MDNRTjRFUllOeUxGNlAyelc3Znp1b0FieExUUGpNaXJKWFMzeW5KOWc0TW44?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8fd38-ae1f-432f-70a8-08dceec882f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:26:53.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6O1VL48QPcP6GOZgOZDkfhN5O7iSD/O3WTwVuA7lCT7bUYk1v04jdScd8zVpEKWynALREzo9eKsXKjwvgvbOKSbJC4jTZCuIdIqo9laQPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8661
X-OriginatorOrg: intel.com



On 10/17/2024 4:03 AM, Maciej Fijalkowski wrote:
> On Thu, Oct 17, 2024 at 11:55:05AM +0800, Yue Haibing wrote:
>> On 2024/10/17 7:12, Jacob Keller wrote:
>>> On 10/16/2024 4:06 PM, Jacob Keller wrote:
>>>> I don't like this fix, I think we could drop the igc_xdp_run_prog
>>>> wrapper, call __igc_xdp_run_prog directly and check its return value
>>>> instead of this method of using an error pointer.
>>>
>>> Indeed, this SKB error stuff was added by 26575105d6ed ("igc: Add
>>> initial XDP support") which claims to be aligning with other Intel drivers.
>>>
>>
>> Thanks for review，maybe can fix this as commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")?
> 
> Yes please get rid of this logic. Historically speaking, i40e started this
> and other drivers followed, but I chose in ice implementation to avoid
> that :)

Thanks!

> 
> Kurt, if you'll be sending next revision for igb xsk support, then avoid
> the logic we talk about here as well, please.
> 
Yes, please fix this the way i40e did in the mentioned commit above.
That looks significantly better to me :)

