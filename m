Return-Path: <bpf+bounces-59176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E35DBAC6C5B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F4818851FC
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84D28B50A;
	Wed, 28 May 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4AZfwIt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE628B4E3;
	Wed, 28 May 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444249; cv=fail; b=CXk9fpZtsDr7z0ppi2v1uy0jGmqquUkTyGAdseBE96acICHHpgr6njqA0joARXGpRPnaARFh8ODhfTTgIZcjhzJxsRMADSwpSJ3vGquycvWHKsO8VrGlqoxlOKF/BpLRcV2+Pw4c/bih6TPXWN+J9Crao99y/oCpSWkqQ8Yqsd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444249; c=relaxed/simple;
	bh=Bl83uhmcxSuUda1lRbu2o4sHzRkPEVsviOvQMIJWziM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=suF96YC505aTw+yEYtNy3FNN4XG2eRL2Ri0FQ+VWOGMjjl81rcxl2UsNjXf6mnHjjSwoLNnfdmwPCvYhRcKF0I+8yh5zbRWBFRH4DPps/oXUepVSFdmUMz8SNrTalbuyirZK5vvKx6XeAknyTGXrAlb8RLnV+HjfqpoXXBeidj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4AZfwIt; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748444248; x=1779980248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bl83uhmcxSuUda1lRbu2o4sHzRkPEVsviOvQMIJWziM=;
  b=F4AZfwItwwkUQCQmZvB7NKtwZXtKW2p3+bnNvP7cX4q5g9j6ePs7JsYE
   B41wECZW1BiXwBC3BYw36fZHYIdXD0dnb5X0hRapSOqkT4Dixh949CVXQ
   XaRA15Q9MHSWFtjXjGw2bjVUSW5cMJD64gPZQa2cvxfkgf+jau+I71Mr2
   r2aUsKq5xnL7/OJDsFuPYfi/ixPcERrwwJ8khL6CHK78R+2O+D8D71YfI
   J+mQlEDAbbLuFQhYhc5s/e34W28GjArA0MEdGD2PTh+zV+l3Lceg1COZV
   CXjPZz//F33oBi4IrYq5Piwgkt5Y6urI302ecZJzeuE43XUZcW3Jek3Jc
   w==;
X-CSE-ConnectionGUID: 591p94WXQXWs03ShrBgdXg==
X-CSE-MsgGUID: /jG2adJZSKy2Whh8GPnHBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61822101"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61822101"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:57:27 -0700
X-CSE-ConnectionGUID: QAWfntBVTs+t1xkwO5HSvA==
X-CSE-MsgGUID: tLWUuTlaQMOb5BesmapexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143097277"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:57:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 07:57:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 07:57:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 07:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4hWbPTCdfb0uYR9yk+OqGbVu9m3YZItsh/QunYf736gs0NpOebuV8DQxGw4BdIT4t/1YFAS8Pg6PXCr8HqA0tCBatOIU38YkOK9Aa9aaG+liYd+VWDRH7AytkgCDoy5BmXvdBwFnDgocbGwy4GRWDlN03OlpgeKBg4w8uZDujW4chyNtBcLVXxQRUer6RWhqMIHQfFrLxBJkFZ8ZWTFj9X4eEiGDK3GgaE1DmxvYBfylOxZ6jw21pMZug7r9BGbhZndWOquTcdng0LZEJn8sUOEh6aQ6MVym0yOf2o8VXrHIR9ezCS2VNuGtH3/pBUjfaV+PiTHTANq18MgN8s5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/r4Uop447pnL5R9dak0A0vRKISgHBbv6FpMMHE5WeA=;
 b=k4gvk96Dh1U5RXV1IG7Kuw0iMS8ZTH84ZeFqd9NNViUk7O4PLcV6IMGg6OZhHwv2S6/mW0hstDLkuhHHcFmjyRD7s9QC5T8MKSwX9WAn0M5TAYzGUhh24f4rqkQRhA/eGimDAM5wvqtYzyCo8HHZmmhOwcI8CDF/ck7ZrRopShicSbVR0QVEL6RUFc7dzvwwnTRWHTAu7U5aaW9BEK9GkekMhz72T8oDWueregoOntGlXBje5jjURmJlI0fIUqG+a/lGMpQMDS7C3lWO5jqiaMWxDxaVEEt/ttrzNqYyQ52coh8wTX4JrK6ItpMzF5kfP3H3L76Fszl5ORXragaMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Wed, 28 May
 2025 14:57:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 14:57:22 +0000
Message-ID: <28b075ea-4126-4885-92a6-4633d4573f85@intel.com>
Date: Wed, 28 May 2025 16:57:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/16] libeth: xdp: add XDP_TX buffers sending
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <michal.kubiak@intel.com>,
	<przemyslaw.kitszel@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
	<bpf@vger.kernel.org>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
 <20250520205920.2134829-4-anthony.l.nguyen@intel.com>
 <20250527190309.156f3047@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250527190309.156f3047@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a9e99a-f5cc-4165-3f07-08dd9df7f34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajdDNk53c3hsWFk3VUJXeE1tRmdhTTlyL3FFNGtHanJWdDNyTGx0eHVqSmRs?=
 =?utf-8?B?cU9FNm0wb1FVTlZLSzZieDhHTm9Qd3liZzdENUNHenZ4bHh0UU9jZnFnN3hp?=
 =?utf-8?B?bVBYN3AySWlOK2xYZmFOTUdUcHlyR0Y2Rm1pYXFLekthbllLVlIyUk52L24w?=
 =?utf-8?B?QUN5SWlwL081ZFFEaWhIakg3cEh4NVNGVlBldXFyWVQwSDRhNUtPWlhCVnlm?=
 =?utf-8?B?bTBDMFRFYlFTMEJDOTBtNDNQNTU4bzExaHNLUEllY0ZZWWpwMkFBeTloK1Mv?=
 =?utf-8?B?dHVHYVZ2cFp1Y0F1dlhoRGRLeWRkZE9ycGtYVHJwRkRhd1dRaTRsMkEyVkZP?=
 =?utf-8?B?RXovNjBsZ3FpaDcxZG02V0pnYXBNdHkxanR4SExPcmRuc3NyQzVkZmM5SFU5?=
 =?utf-8?B?VGhBWU51TjAra0djOWRQMlJwYjlidm14OEczaldJemROYUlpeVVrUmNQSG5B?=
 =?utf-8?B?ekdrL2UxMHhJU2thWGU3NU01eWxkYm1KQnpmb2pJSWJxZzlHMGJuUnByckox?=
 =?utf-8?B?a3Y5ZXdQeDBiQUVIYjJmL1pHUnBsSVRpbG5XM0N5VjhjbUx3VElEYmtkR1Rr?=
 =?utf-8?B?TUtIVzNhak1GQmgvZnB1RDJDckdQeS9rU05vSnNyQkE4S1Y3UnMzUUhJakhI?=
 =?utf-8?B?dmxPY1BFVDQ1NEIzQ2NvYkVESWpIQkRNM2UyclViMVFkTWRsUU5aT2RPQWRz?=
 =?utf-8?B?RTdVOU13RkhvTFV1azNScGFwSjRzRmt1Y3RzQVNMOTdNS0w0V0c1ODRQaklr?=
 =?utf-8?B?RW5uN1NUWVJEMzBzdzJPWVhlL09VSWt2UHpFZm13Y0JrQUNBK2N4cW5GQ0ln?=
 =?utf-8?B?Q1dXdnVhTC9QWVI2THRmY1pyQVVnMjI3VHg3aDdEa3krVzhmVjRZTEJNQmp6?=
 =?utf-8?B?MjU0cFdETDNaWEkwS29weU5ySEJsR0xPR1hZMmFKUTh6TjBQZWVjZHdYSUhy?=
 =?utf-8?B?WktRekloUjgzWk13ak1KYVBrWXZnREY1am5NL2c4ZjhlQWN0d1Z1LzhnRm9C?=
 =?utf-8?B?STE3ZTNrWXhHN1BFbmpWbmQ4aVpwbkFQcE5qeFNnenZ1ckZZYkJFS29rUkM4?=
 =?utf-8?B?OUFndCtDNkcwd0dOTVoyRnlidlA5bjdFRURFZjlFWXN1aU5TRkpHL05zWGJH?=
 =?utf-8?B?aFA2WnhQK0NIZUJrTndhT0paRnR3WjlUWVZXcWdLMmo3VVJsL3lFUzdTVEx4?=
 =?utf-8?B?bWdkOEU4UnZHdnpKdmxSa0U1dEM3Mkx1SDg2R29hdTFHQVNCc2ZKSUM4emcw?=
 =?utf-8?B?ZjVrajduU05pWFR5dWNBV2ZIWVhnMXpIdWxlaDZTRkdzcHpQV1lwZC90N3Jt?=
 =?utf-8?B?YVY5emVaMFMxYlFXSEl1TURkakY3d3owM1lqamdlRnNUcVYxZUgraUFYWG1E?=
 =?utf-8?B?dnRUV1U2S0xxZ2Y1RDBDMEdMMnBFSnJMVnczdjJjS1RDaFJpYlN0eklTSktw?=
 =?utf-8?B?Y3kweitVTzYxLzh3UVVuZlozeGFZdkY3a01FOVc3ZlBJc2RlS0NYeXdPbE5v?=
 =?utf-8?B?bGVsSXVmWTBWRUhIZzF0a3dLMEVYTWtkNEVkbWk1enBYUm1pZ1J1YkxqYUdo?=
 =?utf-8?B?Q2dTZGV3aUNoamh2Um1EQlZWdXpYUnA5dVpLRjUxT0pPNWIwbGtMaWtqY1Bv?=
 =?utf-8?B?RkZoMk90L2FpaUxYbG1GWCtNTDMyNFRwSVgxMkw0S0tQaWo4b3VlK3crMC91?=
 =?utf-8?B?MXpZaThTWFZZVVVtOWQrK1BJRTA0dTRRS1JvZmo3bXBoTTQvK0t6L2lKanRt?=
 =?utf-8?B?UG1LRTZYQnV4VWpXNFpUZGVJRkRtNVZ0RFFNa3NkcWVvR3dWZi9QMlk1MXow?=
 =?utf-8?B?V1VINjZIbUtFSVFXdVpXRHRibndzZXJRa0tlcDJFRnhEa1VqbUNaREpnVnYz?=
 =?utf-8?B?SFFMNkVreDE4TkVCVDQrUDhtSDlsa2xROHFBMGtFU2VJYjhraVhBTFNLdlE3?=
 =?utf-8?Q?yaeVI+u6nj4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRycDBSbnJBSlF0elVSOFNpY1AxaEdIZC8ySXU4d1RNZUJiQlRGTWJqQ20y?=
 =?utf-8?B?MjBNMUdkR0hHL2pSR0dVKytITVdmQUFxTENjdzVPSmNrdmZTd3VWRGZ5b1I5?=
 =?utf-8?B?L28zdjZTclFBWFFPRDJJRnNxbklnaWUySTgrWk1TVjVlOGdQSERtM3B4OTZp?=
 =?utf-8?B?QXViMTFnRVd0THpObFpodXJtZkRxeGU1Tmp0NkloYlpnTmk4RUpjNnduZGdY?=
 =?utf-8?B?eTE3L2R4ellmS3ZhczJpd1RpRXZpL2JwME5Fei9YdFgyZVpHMVd0QVZCWUk4?=
 =?utf-8?B?VVc2NGdYd0FoUmNTS0JXWXhaOWtkZVc4cUE3bk9ORVNvRlFrQXoyZUhITHlV?=
 =?utf-8?B?RExNbmtKVWI2aHp1SEd0RCs1cDFCQWpZRjBmcDc3UitBaG40cDJkb3oyZlBY?=
 =?utf-8?B?bEJzWGEyMmpGMTZ2Z3ZEaG1abFgxMHFhblplZXg5c2loOEJNdXlhRFQ5eEV6?=
 =?utf-8?B?T09aSm1jaUNIZUw4MVN4VG12YXBKMEQrSGtIa0t0eGx3bGlaRk9velFhSnlF?=
 =?utf-8?B?bXZjSTljWTYvQkJZVWx0OHBDR2FZWW0yNTI1NlU0S01lOGgwN0lDN0hjL1hM?=
 =?utf-8?B?THdTNVZ1RTdTdXdWRVg5VGVreExwMUVITG94M090c3hsYjEraUFxUW5wWko5?=
 =?utf-8?B?cWFPL1d4d3RySUF2MDBEYkxoYkN0blZvZExhSm1JcTdWSUF2QnRUUlNtR3JU?=
 =?utf-8?B?Vmhrc0tjZGd1dHpRU0d2dnRvWGRsamQzbVZhemJZK29zSXFkNzFIZEJxYjRS?=
 =?utf-8?B?TWNhN0ZoUWtubG01WE8rR1U4MWFpMGFxVEQ3T24wajVrdEVMaU5GVFkzRTNK?=
 =?utf-8?B?c0lmeTFoc2lSYWFlNDdWWmZiWGN6R3BpMUpqVll2SEFtZDRBWVNtaTZhM3Fo?=
 =?utf-8?B?VDc5YmtqVDFSRTd2YjAzSnBhOHNCUURkR29LT1dscEtHTmU3TmdrKzNTS0JI?=
 =?utf-8?B?TjJ4aUozSFkxMGVYbGEvd3RqSVZaM3dwalcxbFhwNGFlQ0s5dU9FSWk5cFpH?=
 =?utf-8?B?eGp1YmpWODIzamNNTUlwM09pbG1wbklnVFZqOHhPWSs2V1ZZQXM0Nm5ab3NF?=
 =?utf-8?B?Tlg1NFU4Y2dTaGk1QWpmTHFZVTFObFZIellEMCtoMXFPbFQxUVZTWGpPVU12?=
 =?utf-8?B?QnB2ZnFMdy93TVJjS0Z4Qm5OMmN0SC9UcGdjcUxKOVBOWkR5TFUvaTBiUzF6?=
 =?utf-8?B?R3JGU0ZyUXJBcW1Uc3kvVTMrM0I2RDgyR3c3Rnk3MzJNbFV3VWM5Ky9EYVUr?=
 =?utf-8?B?K3dJT1YxbytNdHdpTWhFZXBONlcwUzhVNTlra1IzNFFOT1FFN29SMUkvaU5t?=
 =?utf-8?B?Sm1oczNYanlMMTRqZWtZL281TjljUVZYWktWUExWcm9jQjJOY0xJWTRNY3pW?=
 =?utf-8?B?R0hkMkJFNTBnL1ViR01VWUdzdm14Y05FT0FOM1l0R0hTUXpmYXJEc05GZTJY?=
 =?utf-8?B?RS9uTmEydHpFb1JTVnpKTnBuQXlQSEd2N2MyOGVvdzM4TmxVejBlMkU5dTR2?=
 =?utf-8?B?R0F1L3ZFV2hjeVo1QzJHTjRPMGlYbXRXNFE5TkdRRWdTWjM5bFlGclpCOXk1?=
 =?utf-8?B?bG1oMHM5TjczblVBQXI2a0QyUkY5Mms1c3lkRVRPM1lVSnpidUh5SnFnSXVv?=
 =?utf-8?B?aTZ5NmxoRUYvRitKWlBNMFozVzlxYUZyTlNKMjFQWDhNMXFQOVZpZVVtRzdw?=
 =?utf-8?B?eU5qUFl6aHZOdXdSQ1lkd3hiK2dlL2wvRWF4Q0lkelpDcTZHV25TZ2d6ZTM5?=
 =?utf-8?B?aDRaNnFzM0ltaWtkRnY4WmZHcXZqQXlST0U4YjRYZC8zT3RWRStjanVHTkdC?=
 =?utf-8?B?QnVHSFVoenY4eEdKWXY0QytHUGc4NVFHejdMM2lremF0V0IxUEVtQS9hVnA0?=
 =?utf-8?B?UzVyaWxSV2IxTmo1QTF6WWVWWGdCb1VXYzRad09VdjEwd3RwdXcyZ213L1Bw?=
 =?utf-8?B?NmhnMmRTY29ranlkQXFOSlNwcGQ0WGxDaThVaHNsanp1S1dRNEJkcW9xNlpa?=
 =?utf-8?B?TnRKbC9NdkRYSnRQL1V5SzFYbHEzRGx2TEhtcUc0bCtsQURMN285TkxUYjVB?=
 =?utf-8?B?WS90R1MwZUo5eCtpcGh6R1M1NG5LK1ltYXduTWRlUEMvUnBHRkdOSWRJaUc5?=
 =?utf-8?B?aDJkSndSM2dCWldXN1l6Rjk3NklwdU0vdjRESnYvcmxVbWdDNU1IMk9Pb0l6?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a9e99a-f5cc-4165-3f07-08dd9df7f34d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 14:57:22.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFBp62OVfc9iRLbCkp6f6uWQNqx3M6nlJntE7nuffXlDLqUd23uttdGLmyAarwrAcFdEzjarkqLH0709iffgjmMC/6j8xyF0zY3WXkv3MZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 27 May 2025 19:03:09 -0700

> On Tue, 20 May 2025 13:59:04 -0700 Tony Nguyen wrote:
>> +	if (sinfo || !netmem_is_net_iov(netmem)) {
>> +		const struct page_pool *pp = __netmem_get_pp(netmem);
>> +
>> +		dma_sync_single_for_device(pp->p.dev, desc.addr, desc.len,
>> +					   DMA_BIDIRECTIONAL);
>> +	}
> 
> How can we get an unreadable netmem into the XDP Tx path?

For now, it's not allowed. This is future proof. I have plans to allow
XDP and devmem to co-exist when the XDP program doesn't want to access
frags, only headers. In that case, why forbid?

Thanks,
Olek

