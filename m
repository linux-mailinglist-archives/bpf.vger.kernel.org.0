Return-Path: <bpf+bounces-53501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CAA5550C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96A71695FB
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306626D5C5;
	Thu,  6 Mar 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkZFoPr5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69FE26B2DB;
	Thu,  6 Mar 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285926; cv=fail; b=mli7L9R8lirxWHk1J8ipLO1C26AzKJc3Cz+PqevS2Vn8UKypMWGzy6jdIgm9Oe1RJBEcpYPb3iArkgb0elhPjnptSEWeXKMZ4XWXAlgRMpywZJjuXJgsIxmhkPkbSUkKf28t2oiLuE77eIEBEp1RDLWKyvnH7+sb9ht2uVU8XoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285926; c=relaxed/simple;
	bh=cf+anBwDJECXIVjJTG8R4wigsdpACg6gz7capsdV+ec=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ce8pJCylxq9Bj/z7MV4trHipoM5kqGA9nDYC39NJ3XsMdi+FjtP5unaQ6UyVF74piEkXk8BkYEOaZKZ0mB/RmbfSho9HnQ4BAJE/pEPosudurbnZoAM/D065PVKRkaLGpca9/8YAR/bhlLHGY8vKVzPZwa+0ee0m6iqc7LJux3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkZFoPr5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741285924; x=1772821924;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cf+anBwDJECXIVjJTG8R4wigsdpACg6gz7capsdV+ec=;
  b=SkZFoPr5uCZxoqgBsTev3vfjJ6QaEkZwdq1HpkFpT1oN768Z1JCVJC/W
   Qarky5jKNShguwb8niKAbQe8ip9KrAUx99iJG2/v6qhLr1zvpLWKOweZ5
   SxrCQK+S81FsHCF4kSaOheB+LV4dxB/mVaJJ9nM0vpcktReJGGq+X6Jcw
   pmDODOBu+rE3dr9U3iL+8OlkcHdXyIMGReyIVDSCPfAQMDnv14yZgmjM0
   bo/1XDXg7MGus7wLsgDOtt8jOtfp+lklvqEB18XjeHDL5L6d7vWWuwuJp
   eovxqd6RqHoGjYkcvAXymK08bHOAL1opeMvKNa9a7Nyl7VJs0OdyFz2vB
   A==;
X-CSE-ConnectionGUID: 0KE75UrUS3e61Xtfwh/7+g==
X-CSE-MsgGUID: 5gO234r0RbeqtlfaR1+HFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46087038"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="46087038"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:32:01 -0800
X-CSE-ConnectionGUID: 6lWtCpKFT5euuxOdSWNUmg==
X-CSE-MsgGUID: 7iyuvDYBSyG1EYGq2aB2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119286767"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:32:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 10:32:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 10:32:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 10:31:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmbIJU6TL3cjDMuPbgEPyMOQrIzptjnPEXvII8FuPBa/IxhEUNX4OOYsTTG62vCMmjLc+lJR+0zgMQdTv49AkGt02UDQkQoyo75kg+eiAYLXPnD2qNWJHF+AN3FrlYydOMzePiCTUYlTK3cvu1ew5l6lCRC3RIpzmcgNCbCfo8joS5LH6gGOJUc4oRgJ8WgzzVPOODn1QjftVHC/qzq/M7VtqTI74QozWSlvvk8H3SkqlPcCtYC/KABVYl2VRsLhhF9WC8WfFU4PGDKUDYC7A+vJS+HTuAx6Sx/XonGlH6DdVN2y8/C8nOgsECVygxQW+d0ufE1TXswUMkOJyMVAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwUBc61iK8tP/Rd1JO2R833VurViFc39ETZBepF9Vwg=;
 b=OdvwVDH12x7iIM4SkP5emSC0GOcuhro3xSp+wcO+YgYrf2ppGkyvRE1VcNVZ1vqgAi/naffoToxY3y+3O/BDjLdHRTkX3dzsY1aYBD5Nz3h5d3tPMLnr23UE997yK2GfOJ5JKvv/2JF3eWF7vZegIkI/JFGYA7nsGyZh/pqZrGcyuMgPKQKrgpZmU6OrolRzWR1ZMxFAB16IU7C93m+uCA/5qb4jDaAjCMhl9ugtaGrs2b4293Ig0nxuH+v+WCiXXgb3mqEJi+/VtUwnFIaQrVreu3xV2zFlotQ3RY5BZlWwsyzHjmkGl9t20iwyv7FFn/hThCiYiHLE9ADEPMfLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 18:31:55 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:31:55 +0000
Message-ID: <9ddf6293-6cb0-47ea-a0e7-cad7d33c2535@intel.com>
Date: Thu, 6 Mar 2025 10:31:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
To: Joe Damato <jdamato@fastly.com>, <florian@bezdeka.de>,
	<netdev@vger.kernel.org>, <vitaly.lifshits@intel.com>,
	<avigailx.dahan@intel.com>, <stable@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20250305180901.128286-1-jdamato@fastly.com>
 <796726995fe2c0e895188862321a0de8@bezdeka.de> <Z8nRNJ7QmevZrKYZ@LQ3V64L9R2>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <Z8nRNJ7QmevZrKYZ@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0311.namprd04.prod.outlook.com
 (2603:10b6:303:82::16) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b9d3ef-2572-43a1-4cff-08dd5cdd2c04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVKY2RxTjdTTnZBVElSSjRtNm9OQ01IMU1RT2JFbnhjdUMya3JCT3FHLy9h?=
 =?utf-8?B?MU12OFZ6eGJkMUd0eGN4Z1ZIK0dUVzcwajhCMFVoOGZPN1dRTXcwbWI3enRh?=
 =?utf-8?B?SWxxN1pXUGlsNW50M0dFaWZ5ck5USXlWR3BKRUVxa2VMS0RyU2xpUkpnN3Ro?=
 =?utf-8?B?VFFjb2pJOURnQllua09CRzJLWDR5eFh6WkpxRWY2OTZPdEZDOWRKWUpiQ2c5?=
 =?utf-8?B?MHJ6TmgxRGZzQUF2OXFtajJEYURnTkFONnpTQXhlVHhDZFFoSzdnQ3dMU1lV?=
 =?utf-8?B?TDRiSGhyV3FZS1RQZE42KzB6NFBYVnpiQ0FadGJabTF1WVpIckZmSkcrbFBY?=
 =?utf-8?B?QUlLV0t0VndXOTBxeEVvbUFtaG51WC92bTZuTGp0Yzg1K25mczluNDJNUno4?=
 =?utf-8?B?QXFCa3F6WjFtYmlJS2orU3lMRDJ3TGxPUEVFT1dvUys5Y0FUY0hyakEyU2lp?=
 =?utf-8?B?S2pHRGFkbktMT2RBeVNZVFBPREZwOE9sUDlsakpJclpMS3lrUlF1YllUU0ZN?=
 =?utf-8?B?L2NybFQzVldQbDYrb3d5SzFURllVZXl0UTgyUGlIdmowdVpCdmFpazlnYXV0?=
 =?utf-8?B?N3FYamUzaWlYTDJzRW4wU0s5MXloS1lCQk1Eb05HdEpaSXZ2ZjNseHYxd3F4?=
 =?utf-8?B?L3ZBa25PSzVVN2ZNU0xKRTFERHVQaDIyYmlEVGJ5dUk0aW5RNXZza3IwNk9a?=
 =?utf-8?B?bzNRS0srdG5hNW9NN3NKTjgrdHFLeHVhd25GcnNMU29HekZ3N05XOEtoalRT?=
 =?utf-8?B?TmRTUG04eHF5NVFTWmFlU3JYWDF2VWxoVUhDb0EveFduZnN3Rm9pTTkwNFNY?=
 =?utf-8?B?QmlSVW5aMk1xR1ZYdStQekp3VFRVZTVsUGRqTzNtbFJOOE5WN2hrS29WRzRB?=
 =?utf-8?B?WVRiT3FiL3NUNk8rYnU5M0xzWTY5S0pkdmVhNit5aHIrMldmSlpRbVZINlR0?=
 =?utf-8?B?UWRRQytJM3BTSUYyL3IzZ3dYMTA2WFpzaWRScWRNUFNOcXpsc25UeXpIVXc4?=
 =?utf-8?B?eVk2Z2VCTWZveE9ZaitVcU1wYzNGSXFkUEZzcy9OS1FsbkdBSU9KVXY0TENz?=
 =?utf-8?B?dEs1Sm1OZXVvMEFpbEgvMUxTTllvaGNJZjlHREN3RENhYVRGR3FtaVo4bXJj?=
 =?utf-8?B?U29GeWhadWZJVW9DUFFrTW9YUzRKeDQ3TWtKNTdlZSt5MXVreTRLeGlZaEo4?=
 =?utf-8?B?YUpsMHcrVzRZd0czQmN4dWN6eXFCRURkVDFEMWd6amw4TDhENVNGRFpyWGVo?=
 =?utf-8?B?RmZpeGdZcE9hZldxQzd5aXpNdnBPQVZOSEl0RXFDRmhraGcyQVJLaHdySngw?=
 =?utf-8?B?cFFpRWVmaFRzTjhDeVNMaSs2ZUIwRkNFSnlHeTBmaDNwUFkzdFFPMlVDWkVp?=
 =?utf-8?B?UzdmL2hBcTNoNWtsZktOVnFwQ3dhRS9FWmtXbUs2QjlLc1JvRGZvbWZBVW1V?=
 =?utf-8?B?VDlLQkIyVFVSYlBRay9ESzBkOXNOUmZTQnRzWFN5WDNIQnlNOEpJVitCYVRS?=
 =?utf-8?B?NE8vUFpmTENaeWJacnR3c3AzMlNINy9wcExuQjVZYmVjOGNPSUhORXBITDNL?=
 =?utf-8?B?VDJzbTlHSlUrL0JhVTlDakNNK1JSdEpDYmM5SXVjelVFRHkxbysyZEI4ajJp?=
 =?utf-8?B?UnBtdzQ3UEI4MHpZeVpMTS9iTG9ZeGduMGpWU3pualBJMWFIRW5KYUljUnF2?=
 =?utf-8?B?aFVYMWhuRkZBMmhOeEFmTnQxRzRTSlAzM3hBcm9ZMVdLQ1pHbmFIUWNldS9x?=
 =?utf-8?B?N0NHaENwRHE0V3ZIbFBraXl6RzlhSkZjOEhLaFphbFhsZFdibG45bDhBY3BC?=
 =?utf-8?B?bWtuK0RHTnJKaGV0TWxyS01uRm9Qc1ZuYkVmNVRFR2t2QVVXdnkzdXZGb1pG?=
 =?utf-8?B?SHVRTFdHRkM3WVd5MW1WSDlVU1psNlJrdGdjeCtPRXorTDJHcG5HaGswajVp?=
 =?utf-8?Q?IXydLv9cjzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFA0MHhBTTlrWVdRUmZiRlN3OTFhQUkvRzgra2FpY2hrQjJrd0ZEVDFBVGRZ?=
 =?utf-8?B?RVhMdUJSdlJhTVJDYTRaUDEreTRzR05kbFRoL3RHeU0ySmUxWitBQzNqek5v?=
 =?utf-8?B?Z3MyMnhlMlRZeU9PSDQwS2F3NUZDNlJib1AvcWRGN2xVS2hWV1V5NTg3M2Fx?=
 =?utf-8?B?M3dxcWJPYy9XQnU5TjZHTExwdTIybkE0a285OG9RVFhoR3I5SHFLR2I2dVBI?=
 =?utf-8?B?U0doNyttNkQ5T2Z6VGkzQk44V0tWbk0rTXdJZUVLeUYzbkE4d2IyTEo4bmZD?=
 =?utf-8?B?Z3pjS3dtWXFlUVZvMzRUeDBIamE0V0JLMk9QMkhRcklNd3hqZTMrbUtCTEFq?=
 =?utf-8?B?QzhYRDRRTWc3aDdLRGc2RkluM0RWdkFWNGhyeVZXT2J2SVNtZzJEY2x6Z1Yy?=
 =?utf-8?B?RE9UblhYT1gwcVBEeW5KVDM1WWlvTG1XY0J2TkV5b01DZS9vK2tRL0lRK3Vr?=
 =?utf-8?B?QnFiNkVCcWJlOTNoaE9YNGZ0OGVvUDhqNE5vOE1qZWJhTnRaOS9ubWs4dDRt?=
 =?utf-8?B?cm9ieUdRK01nR1VLS1crZlhOK20wcDdyb3g0bDhxMmVFNVJCZUMzOXZOT1pv?=
 =?utf-8?B?YjYwMEdpMjZlRFhCMkxzS3pKQmVIU1g3ditUclZmYmhJakVIMDUyNTBwZXhP?=
 =?utf-8?B?UEtqWWhVRHViaVllMjBTVWJtWks3OGFLU3RMaEJzcVNtNXpkYlJFMmgzOE5j?=
 =?utf-8?B?eWRHck8ySXJ1Q2tCZEV6N3hEd3d3VTR4UHFoREkrSzVrS1lzYmpHd2lZU00y?=
 =?utf-8?B?S3VhbkErY01TTG9FUDFTd2tDMytYQXphMFlGSFB2WTBzWU13OUVMcDNiOTdr?=
 =?utf-8?B?MHJmYzJhTWJ2SDRTWllHK1ByaDdmeDNpeUhSSVpIUWJ0cUllU1dFaHhldmNy?=
 =?utf-8?B?Tnpkck03cnBEVGVWNmFWOFlaL2p0NENtbnFXT0owWkt5dUVTWXJjdzYxai9G?=
 =?utf-8?B?MmtXL3E1QVpZK2V5SFcrL0xRdXRkYmx6aEhqY2ErZzNIZjB5UzhIMys4NVBD?=
 =?utf-8?B?MjBFdzVLUDQyVjB4ZkhmMHo1RVJibjBoZ1dDbHZYTWQ3eHI2eExzVi9IVzVC?=
 =?utf-8?B?a0x4VzZTUHovK1ppejBRZXBKM1NYYk10c2MzWmRlWkJQWUNiWDY4WFFXVDl3?=
 =?utf-8?B?MDVaajk2TmpMdW1hd3A0akRJSm1PTTJrM3R1amJpdWdRTW5nZ2ZxVzhubUpH?=
 =?utf-8?B?YlcvdVU5RmZEaFYzV2llT1dldUU3cXpXdUFySWtlQTBNSlFkZXdwYlJTeW1a?=
 =?utf-8?B?OWo2STV1Q0hMWTJzRTNRcUVKbzFCaU8ybTJyeTNUamRaRWR6TlVVZkZ6clM2?=
 =?utf-8?B?SzE1M24yTXRtaWoyY2JSaHFSTTRpSHBsTmQ1SWtWV3Y3VGRRaXQ2N2pXTUtu?=
 =?utf-8?B?VVFtenZuTXNORHJPb2dvNy83bkNrZEJMSHFHTWpPOEJXdUM3NTMvV0kzeHFU?=
 =?utf-8?B?UzZiWFpWUWw4QlZ3WWZIUzZWVG9CVHk2TWVFWTRadXZWNzg5RHQ2WjJpY0xO?=
 =?utf-8?B?L2lCaU1SQUtYT01LVmxSOGRBNndac1NMK3pidDJUVWphUS9Ga0s5b0VZSnU2?=
 =?utf-8?B?L3o5c1FvYkQ3bWl1amtVRWh0QmFSWmczNFZHejZHNUlESVo3OGlETWw4ZXZo?=
 =?utf-8?B?cDVUbzcvU3VOWnE0K1hrRzMveTZQTmJJSTJ2bWVCbEdBdjJlUitQNXloSWNH?=
 =?utf-8?B?VUluckdoWEhScTR3WlN0ci81WEVlYkVIQ3IreXFMU0NMQ2tDZGNqWnd1eFYy?=
 =?utf-8?B?eUFybW5MUVFNQ0pjSUU3ajh2NlJCbmM4bjdZRWE2d0taWitjNnBvRy9qVmNp?=
 =?utf-8?B?b2pKNjUzTjRuZ2NkZjFVa3VDWUNxTjJWaEZBcSt2dlRiaUIrdzZVNlZ4WG9Y?=
 =?utf-8?B?Y29yYVNHQmZUVVlObGkvUkI0czhXb2RGdVp1ayt0NmN4L2FWa2l5eENJNmk4?=
 =?utf-8?B?QldiSjh6M05iKzlPZUJYQ3FzS3B2bVYxNVFiUVdwY0ZLeEFjb1ZWUTdzalRi?=
 =?utf-8?B?YXJ2ZDZNVWQ0ZXVPYzNvVU9EMDd6NldGdTM4Y1R6aWdPWmFiaUJqeXVxTmpx?=
 =?utf-8?B?OVZRV0dhQ3BnYnpqd2orZno2aEp4Z01RYmxyRDgyM3BQT1lHYlNEUXF1dkkw?=
 =?utf-8?B?Z3lmVWRqdExpM1NnbGFnR0NTUHJreXZWR2lHcUJXS1ZIazlURyt5RHNvVUZ1?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b9d3ef-2572-43a1-4cff-08dd5cdd2c04
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:31:55.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry1PXD5o/MYJtjKMX7yvuBbrx4u7qYzahHwRsgNCGcTA93deXmGnz+eeLJ/gBVOkGA12CQT83CxMHN4uFBUsHEhdFPG6axGVIMh9OHKTTdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com



On 3/6/2025 8:45 AM, Joe Damato wrote:
> On Thu, Mar 06, 2025 at 05:27:38PM +0100, florian@bezdeka.de wrote:

...

>> Btw: I got this patch via stable. It doesn't make sense to send it
>> to stable where this patch does not apply.
> 
> Maybe I made a mistake, but as far as I can tell the commit under
> fixes is in 6.14-rc*:
> 
> $ git tag --contains b65969856d4f
> v6.14-rc1
> v6.14-rc2
> v6.14-rc3
> v6.14-rc4
> 
> So, I think this change is:
>    - Correct
>    - Definitely a "fixes" and should go to iwl-net
>    - But maybe does not need to CC stable ?
> 
> If the Intel folks would like me to resend with some change please
> let me know.

Seems like the only change needed is the omission of stable. If so, no 
changes need. I can take care of that when sending on to netdev.

Thanks,
Tony

