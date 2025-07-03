Return-Path: <bpf+bounces-62278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A825AF7449
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E5164FB7
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877F2E4997;
	Thu,  3 Jul 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGMYvm6S"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5F239086;
	Thu,  3 Jul 2025 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546245; cv=fail; b=KjSF/y0M6W+du5+O46wpOZF3YVnp/OCCiXVgK8CKYbxMFG0RBzpCFH/9ktcxSSXW2fIdOh6vw/Sok8zZv/ggUxurSdw4z20E04RXD/xzIgSrrHxXJHlAn+0691i+7MjKSueXOkHTFV9RVi0XLVDucSzKlGQmiddlSFeO8sahoL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546245; c=relaxed/simple;
	bh=m/hWTiZ2wiObOMazQlEcU9QlYqHeQFYPFE2k9Ui6v3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O3V5L41cAEM5Ht0lcp5yppIW4c4+42OWADmmXKs5BgpxXGKVc9HIRerfY1HEV+bxm61hhHVbchAgVLusL6q78juHmTDNDvKYmzwJIRsJ3KhJGAXF0xOEflkxtTRcr+U9o9BBWLo9hd0W0bM70as5GvwGw4ElkfP0jCBt1GiJ2LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGMYvm6S; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751546244; x=1783082244;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=m/hWTiZ2wiObOMazQlEcU9QlYqHeQFYPFE2k9Ui6v3w=;
  b=LGMYvm6S11vE1qceUlJIplLAKN8EHpTga0rpGQ6lGyklV8VCgfZI6YH4
   u0usDtUB5IZ4APEZ98cyomh2eriPIrpfur+L+RMNe92XdWYgrcERMCg7P
   w00P2AAh3GNvUfjthEbIi/u7E86lw61VL9X41k2t6dwBqhEIR81L+/VP5
   cfwG2iLI1yCBCM2Mz/ECAkodSl9EFx7ga2y4PSiwTOH7C1hy0Jh7RYCs5
   aWCQ6bSzOz0IAUBE2/XQsRc21feHw9KRghYtJKfVw2D1wkXz9GeTwkBdb
   BD/SWagkNsokg+je6eMMmnvUKhfO6JKPa2AoHqEAc2YKrdrdc2ofd/Bj6
   Q==;
X-CSE-ConnectionGUID: IYDndCAwQ2SaCGq9IAzmEw==
X-CSE-MsgGUID: wzPTXmveTLiCN9l3e8n2DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53964427"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53964427"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:37:23 -0700
X-CSE-ConnectionGUID: Ia3c129HQpGnM5N9srhN+w==
X-CSE-MsgGUID: CWCXKun2RaiRerbT54kWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="191536561"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 05:37:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:37:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 05:37:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 05:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtEVsqj/8WsuhP7W8TuEhSlXu4X/saNAwxMZ6Zj7pqDtgHMQprRggYpIbxUuYgHGZJbfVRdkLEZlwfF5C13fwrPzaZztUDLxuvjkaWOiTh37tc+57/kOlo5RdbbzIXU0PbrIxlYx13u/FpgbiZmB3ehHR0NJBu3yMYvr7OmTMep1vsv4C+o8VqSghq1BeNkOjqI+cHfGs4Uy5eoy6sBUYqdcgPXDuaaMCBpHPWwUCMt2PDabA5J7lJCUU3VwJg9Mr3zmK5XzupJMktFvNKeO2WwCdffqDRaSXgINlXku5kL7zcvVO1jFA4JNZv6YlA2TDWofMs/u7H5Q/geMBt0L9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYDLWVv0Qd7+zQUi+K1vgvHd8p2u/Qxw7qDPmBolGO0=;
 b=e6rM6BRdkWQO6C7ZH81U+ECa1uBoJZ9Da8Ho1jmlL66ieBubL+DFp/uw5Z7hbg0Gqpy42pmx9GbeuEr85o90sUFQV68C0bm2KBg5RtXwatQxZv5Cq6VrQK8RGs8pridgpuhRXbhLzBDkJ4uL/+Yc09zg+0LKFntYV25V8Icqygec5I2+ORrZJEjQrS7idiBY/DjEbjlHmiE5JNLT5u10k7vFffTfV9dTmdyMVRClrmKr6g1ovvhN8tlf203i0GUjYkmpjLw0eKhwicndq8Z3mrXxfKJxm7a6JzdgTUDpckAm4wUJf6WLqmPdbGXjbv9VJBxcDXWM7oWwQuBHvXpDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA4PR11MB9107.namprd11.prod.outlook.com (2603:10b6:208:562::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 3 Jul
 2025 12:37:16 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 12:37:16 +0000
Date: Thu, 3 Jul 2025 14:37:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <joe@dama.to>,
	<willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v5 2/2] selftests/bpf: add a new test to check
 the consumer update case
Message-ID: <aGZ5dq5P0G8e8A/J@boxer>
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
 <20250702112815.50746-3-kerneljasonxing@gmail.com>
 <aGVYNMZEZQV1SetF@mini-arch>
 <CAL+tcoA8Yhk85mkOBE9jEx7fd1s5rAW+Y8Uf2DAaNR3-9DW0Vg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA8Yhk85mkOBE9jEx7fd1s5rAW+Y8Uf2DAaNR3-9DW0Vg@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0334.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA4PR11MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: c86e8e56-1508-4d5d-228a-08ddba2e57c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkFUSlU5SFJ5bVVrY2N2d0lNRHFvdmptUnUvTXdyOXlxdlJIU1REUFdSK1BU?=
 =?utf-8?B?d0JHT2lQaEFNWjhZRHZoL0ZGVUFQNGlYQ0FJNVFSZjRYM0dvdHRLbUhocUJw?=
 =?utf-8?B?N09sTE42bzZmU2pQL2MyMXVQKzM2dGhwR2UyRUhyNUYveDRMUExXNUE3NUdF?=
 =?utf-8?B?c28rU0RjVXdMRGROOHprZjdPSm5SVWErNk5jTXdNRXNzZU9jSWtmZGZpOGpQ?=
 =?utf-8?B?a2VULyt0WUVwWHZ5T2lBK242N1gzNitJaGhVbkR3YTYvYVc5VFpMV1AwaDVt?=
 =?utf-8?B?TmdhblhralVBeEFTYTlxdUo1TE9VbFhtbWtjVVlQZW9FOGtsUUdpQkhqdE0r?=
 =?utf-8?B?STlPaHJDYkdSWmx4WUJmcE5pcFV4Y01vSXZMbUtWRXpDY1RhSXBkYjNkOFBU?=
 =?utf-8?B?VGV6aUthTm02TDNpaTVLYUhldHppWEUvckpTRGNhT21rZ2ZjS0ZESHRxTFFp?=
 =?utf-8?B?MXR3WGNodjAzK1haOWdEeE5ncTFJMnVqT3B0Qlh4U2RhbFJkV29jaU5iWXhx?=
 =?utf-8?B?NFd4WFFqOVdEc09NK2FuY0dkUTZpR0Rqbmd1alZUKy83aDVmRE5sQ1ZRQWNN?=
 =?utf-8?B?VXJpVlZsamtJZnJVditxQmFvQ1RNM1c4WkdOMmI2TGNTNmNkdGxQREhlTWov?=
 =?utf-8?B?UjNhODY4Uk83dlhvdFgxbUFEK0tHUi9ZMzRBNGs0ZVkyb3c0RzhaOXR4YUww?=
 =?utf-8?B?T0RTdU9mK0FJTzFvcWJMcWw0TVBPelpUeTVhUW5yUmlLaXVZRkV6U240V09z?=
 =?utf-8?B?NXpCbHIwVC90N1lFTE5vNTFrVS93ajZ3NllQOEllaDUxVGNJUVkybHJYc3No?=
 =?utf-8?B?N25OQVdqa2dYWHBkZzRnMEVkQitSR3IwOHFxUExHNlZvYnBhcnloaTBtRmlS?=
 =?utf-8?B?U3VIeDRHbE03bGZCRmlma2FocjhnSmQrYXAyRnhXT05FQ2xHUG5YK0VYWEEr?=
 =?utf-8?B?MVluWEdUM0hkSDFoNWZtcExRbklWOGZIZTdMT3h6STdxL2VxYVlBQS9CQnZq?=
 =?utf-8?B?R0Q5OEFvcGFIZDY0eENhNkxMR3pLT2tSc245MGJmalFXcmxMbmdTSGtienFw?=
 =?utf-8?B?UWd3UE95aXdQcE5hOG9lY1RVZjYwakFZRVdPcU9HaFVJMXZ0ZU5CeStOM0s5?=
 =?utf-8?B?bEFrbkp2dVdrYTF0cGlxR2dKUmNkSWY4c2U3V21seE9lUzFuVEljTHpoVHh0?=
 =?utf-8?B?UERadkdCRVFXR0RYUy9idWRiU2k1MnVkK1hZRDF6WWphanlUdGVTNHJkODhr?=
 =?utf-8?B?UE9raTR0ZFMwWlZkVG9HSGpTV0VxSldteis4SzArUGE3RUlUTTliT2VVU2J0?=
 =?utf-8?B?cjBIaldzbE9vVVhHbWt6VGZvcEIyQ2NDUmRGUmZYNDEzSnd4bHJWUVBRYnV3?=
 =?utf-8?B?eFlmT0tiYzUrTmRnR1h5Z2xlRnpCSi9jeGRFMVRSNVlYNmJZNWN1N1VsSlZI?=
 =?utf-8?B?SFhxTVpRbFpsTWhrTmJnOVI5MVErZzdNTVZVTE5KbHZ1TktPMFZFWkl4Ykgr?=
 =?utf-8?B?ZzU2NGM2QUYwcTR6Zlpkd1RPdGtMLzlGRUR0aC82c1NkRVNWSmpaK0UwbWdn?=
 =?utf-8?B?NUE1QVIzNlNzSXZnUVB3dCt6UlJRZTlOMEpSelFoVy9kWWE5RklzODhGTmph?=
 =?utf-8?B?QWRMK1ZGYXF1aUVaRldlc2FmZ3NpMTdFRlIvUUthT1dXWFltU3ovZDF1VlpK?=
 =?utf-8?B?ZytrTjhmc0lTYWNXcU5FeXpJM2F5QTAwaE8yaHhXcUtrelo0dmx0OW5EendU?=
 =?utf-8?B?T0lhTEg4Ti9oUEM2SFA2T1NKQ2czQStLWFVFQUh1WStERzJMUGJja2xYblVh?=
 =?utf-8?B?RERXMTZ3djRIcE5FcnU5Tm15NWNTMmRrTU5MOVJUWFNTajNVcUcrMFNvYVd1?=
 =?utf-8?B?QkxYVlRXQzNnZzVpNDE0UDNjc2k3QUFCUXIxQnk5c2srM0Y3SWxaTTRMeS9u?=
 =?utf-8?Q?+bil75wPJzw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJFL1dkUXloOFlySVdsZmpZVFVhTi80T3dVTU8xclUrMTZuY1d5S0dRQkJU?=
 =?utf-8?B?bFFIcThyayt1Q0tldnRPc1VCczdqSVUwODdtQXZtSXdYL1U2S1dvdTRNQUpF?=
 =?utf-8?B?QmlGSXZJUWU3a3dvQWdzQ3FXaHpRNEkrR3M0b3RXcklOOXp3cCs1WWpRaTdh?=
 =?utf-8?B?S1IzOEFFZDdIZ0FxeGE4NGlhc1RZcW1qdFJIV2tFeHUyYTRZMFhxK0lpSWlO?=
 =?utf-8?B?V09PUGxsV2Izeks0UXZVYnExMWUxYmxOVlNtNTBVZUVyd1Q4M25rdHA3TXNT?=
 =?utf-8?B?Q2p0M0cwbFBvU2tFYSt2UW1mQmpncytvT0YxWENTTEFWU0VXKzRESGx5bEJ2?=
 =?utf-8?B?WGs5YUxCVUpDQmJOdWNrYmtKWnFrT3F4VFZ5cG91U1QxcTNrNFlDYlViY245?=
 =?utf-8?B?UXh4dDVFekJ1R1VKYVBBSVpaM0IrRDFLT0ozQTdJcndUVldNOURIMURkUXE5?=
 =?utf-8?B?RHNxNncrdndCNC9GU2JQbTdtZ2Z3akdKOS9nZlEyM21tRXZ4eTVBejJxUVVp?=
 =?utf-8?B?Y3MwNjdtSFBTSFh3dm1ZbDQvL2ZLWkJySVpsRFJBRlhnQzVSY1RMYXBtcm80?=
 =?utf-8?B?OVB4SlkvVUVNN3NHaktWTGZUKzNFajIvdE5VOEFObzRNc3RTOUhTZ1JFQVZH?=
 =?utf-8?B?bEhNQmJUL3hLL1JIdmErL1QxRktiVGxod1JTcElyV256ZFBtek5nZW1YK2hn?=
 =?utf-8?B?N2t4cnFINGRZNkNiWldyaDdGYTkxUzVPSjdMUDVXUFBEbTVaa2xoVmZlbXZv?=
 =?utf-8?B?VTRmdVI4V2puS0JSUmlHV2tuRE9KMUgvRlpZNW9nWDl0azRtWGF5aGFzKzMw?=
 =?utf-8?B?cWF3a2pBYzZLdGxZS1pvVnR1YzZSQ2JxY3BCVnpsZndER0dmajlPRlM3cmRm?=
 =?utf-8?B?N044dW9xejFvRmIwMENBQU9sbnBRZFVXMlE1RjRLYldxbUp6dTZ4TitFUDBB?=
 =?utf-8?B?SUhGdWRhSE45UUY1a09MRHNYeHZOeG5kVzZ3a25GQmpzd3l1dEh5MDZUY1lk?=
 =?utf-8?B?UVU2NzQ4SHpkUTQ5NUpWeGRFY0JYT092Sis3Qm9ZVTk3d2xzcG12VFNxdm51?=
 =?utf-8?B?Vk9IbmtQaUZUb1JQR1A3bHJoU3g1b1piZWg2OS9WQ001NzZTWlZOOWpaSU9Y?=
 =?utf-8?B?Nkg0cWhpSEpUd2FOVEtSV0ovUzBEZUZTeFJ4T3VyN0pLTG1OQVNwcGFnWU1B?=
 =?utf-8?B?T1p3N2hhYUM4bHg3UFR4bXR5M0FlRUgwajdBZjJYd2Y0Wkx2WWlTM0Z3Vzdl?=
 =?utf-8?B?bzdNVnNKZ0RvckMrTDIrZUdUbHJadytNS3BmdEVpNlQvRDdlaGkrY2lIdEM1?=
 =?utf-8?B?QjNid29hdTNaNms4RmI5bUc2cmpOL3ZrY2d1WWdsam4vaWNjTU1YT1N0Yis5?=
 =?utf-8?B?ZkQ2ZU1SakhRNzRaSXRRUXJ1VVJhWlk2WHU4NE80aGVYQ0x5UEJnVXZyem1y?=
 =?utf-8?B?RDZobVN5ME9nSHZGeTBaaHMvWEFyQTJ0bjdicXI1cTJMZVdQT2VOT2d1MkVw?=
 =?utf-8?B?bjhZdjZhNEY0WjBHTmJWSHFQbGpOaUFmOGtTbDJNRmNGd2sveGl6OHI2blhm?=
 =?utf-8?B?a2t6UmxoZXR4M0J0RE9BdHcwL1RScFJQRWF1eU9JR3l5S2lieE5VSGNmL1I2?=
 =?utf-8?B?cW9RRWpQU0VsZDZ2OXAyK1RFUEtlY1RCYVROZ3NmQmRxVkRidHVkTjBvWERh?=
 =?utf-8?B?WmhST2NjbzJGSHgzdjVROTRnTXhBV3ovMUZEUm82cmo1QWRySjZzTTVkRDFR?=
 =?utf-8?B?VldiZlpUbXd3a3h1cDJqeW1lUnU4VHl1amU5OWVjZFI2UE9pa3Y5Z1ZGSkxx?=
 =?utf-8?B?UFFwU3JCMFpBcDNCNTZvVlcrY2c0aEhJbVlaWWFaaU53VXJEVHpyL09DMG1y?=
 =?utf-8?B?blVsR2dqOGxpMDVKTy9xangzVGdZOElCTTJvbzJuUDAwSmlqaURxdXZyVS9a?=
 =?utf-8?B?OFJCeFY1eGpDdnpNL0s3aVZlYmhmWGlVQmRZY1RqUVpEMGVqdDJWcUdWQVMy?=
 =?utf-8?B?ZjJQeVY3TlZLeGRBKzFrVnZhNzNzblZEVkJLT0JZK3hnT3FiOU4rRkIzVmpO?=
 =?utf-8?B?SGNuMmNISXhMMXRkNjk4UHpQa2JhalJqMmdLZkZvZ1FLbkJtZ0x5OWlONWRI?=
 =?utf-8?B?V2tQZzdiUHd5NjFITGJ5U0s5MnloZ2JOaHdJRDRycjM3Nms0NDFyb2hVdkVx?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c86e8e56-1508-4d5d-228a-08ddba2e57c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:37:16.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvQhlX0r6W9Wm59Y2PPYFPdhIq2s73DNRwcuiiI5wIfrI6pwK712znFCnbBFDPm8yvxQEEJ5z9AWeR/hi0KIykRR2QW7aWTj7D66ZnefiAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9107
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 07:09:09AM +0800, Jason Xing wrote:
> On Thu, Jul 3, 2025 at 12:03 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 07/02, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > The subtest sends 33 packets at one time on purpose to see if xsk
> > > exitting __xsk_generic_xmit() updates the global consumer of tx queue
> > > when reaching the max loop (max_tx_budget, 32 by default). The number 33
> > > can avoid xskq_cons_peek_desc() updates the consumer when it's about to
> > > quit sending, to accurately check if the issue that the first patch
> > > resolves remains. The new case will not check this issue in zero copy
> > > mode.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > v5
> > > Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
> > > 1. use the initial approach to add a new testcase
> > > 2. add a new flag 'check_consumer' to see if the check is needed
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 51 +++++++++++++++++++++++-
> > >  tools/testing/selftests/bpf/xskxceiver.h |  1 +
> > >  2 files changed, 51 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > > index 0ced4026ee44..ed12a55ecf2a 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -109,6 +109,8 @@
> > >
> > >  #include <network_helpers.h>
> > >
> > > +#define MAX_TX_BUDGET_DEFAULT 32
> > > +
> > >  static bool opt_verbose;
> > >  static bool opt_print_tests;
> > >  static enum test_mode opt_mode = TEST_MODE_ALL;
> > > @@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
> > >       return true;
> > >  }
> > >
> > > +static u32 load_value(u32 *counter)
> > > +{
> > > +     return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
> > > +}
> > > +
> > > +static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *ret)
> > > +{
> > > +     u32 max_budget = MAX_TX_BUDGET_DEFAULT;
> > > +     u32 cons, ready_to_send;
> > > +     int delta;
> > > +
> > > +     cons = load_value(xsk->tx.consumer);
> > > +     ready_to_send = load_value(xsk->tx.producer) - cons;
> > > +     *ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> > > +
> > > +     delta = load_value(xsk->tx.consumer) - cons;
> > > +     /* By default, xsk should consume exact @max_budget descs at one
> > > +      * send in this case where hitting the max budget limit in while
> > > +      * loop is triggered in __xsk_generic_xmit(). Please make sure that
> > > +      * the number of descs to be sent is larger than @max_budget, or
> > > +      * else the tx.consumer will be updated in xskq_cons_peek_desc()
> > > +      * in time which hides the issue we try to verify.
> > > +      */
> > > +     if (ready_to_send > max_budget && delta != max_budget)
> > > +             return false;
> > > +
> > > +     return true;
> > > +}
> > > +
> > >  static int kick_tx(struct xsk_socket_info *xsk)
> > >  {
> > >       int ret;
> > >
> > > -     ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> > > +     if (xsk->check_consumer) {
> > > +             if (!kick_tx_with_check(xsk, &ret))
> > > +                     return TEST_FAILURE;
> > > +     } else {
> > > +             ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> > > +     }
> > >       if (ret >= 0)
> > >               return TEST_PASS;
> > >       if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
> > > @@ -2613,6 +2649,18 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
> > >                                  XSK_UMEM__LARGE_FRAME_SIZE * 2);
> > >  }
> > >
> > > +static int testapp_tx_queue_consumer(struct test_spec *test)
> > > +{
> > > +     int nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
> > > +
> > > +     pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> > > +     test->ifobj_tx->xsk->batch_size = nr_packets;
> > > +     if (!(test->mode & TEST_MODE_ZC))
> > > +             test->ifobj_tx->xsk->check_consumer = true;
> >
> > The test looks good to me, thank you!
> 
> Thanks.
> 
> >
> > One question here: why not exit/return for TEST_MODE_ZC instead
> > of conditionally setting check_consumer?
> 
> As you said, yes, we could skip the zc test for this
> testapp_tx_queue_consumer(). It doesn't affect the goal or result of
> the subtest. So do you expect me to respin this patch or just leave it
> as is?

Yes I think it would be worth respinning and skipping it for zc. see how
testapp_stats_rx_dropped() does it.

Otherwise we would probably never change it and just keep on running this
test case for zc which is not beneficial at this point.

Besides LGTM!

> 
> Thanks,
> Jason

