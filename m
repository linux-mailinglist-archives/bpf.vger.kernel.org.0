Return-Path: <bpf+bounces-52214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A23CA40099
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 21:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C80C863D27
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 20:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F5253F0E;
	Fri, 21 Feb 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFTVcZbh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABE25333A;
	Fri, 21 Feb 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169065; cv=fail; b=snbB1G/B0ojqmfR5TXvjbcISjUn/AbPtBvJo2UrMhF9cGtd9Qkh8abydBSrC+rFTGq+Sa2Gdy6lnTOPywzTIh88g4yE+dEpDbSW0MFeOteAErMK9gy+itrS44XOuF6odDSPEdy5l5A9XcvVpkcL27uE3qMKgS8wb4z6mGx1R7Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169065; c=relaxed/simple;
	bh=r5GqJI2/SjCrop/KjA0FMJA/GgJ6rh/ifyJ8svQTB3g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gw/uA4HXw9Xg2w4w2y1pkDb3PrjyVRJxIPXKJ1jTqDc53rHAAcA6CJOmuSipzXfIQvtvsKR1mfXAlFgtwz8SJ7NOnGNhiZT/qhyfvJafgFYGPywyEcFnHbgJiBA93dznj1M/0V+r2VNazyYZmLeJshtmZ4VsHbcDhfLlTk1UrwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFTVcZbh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740169064; x=1771705064;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=r5GqJI2/SjCrop/KjA0FMJA/GgJ6rh/ifyJ8svQTB3g=;
  b=mFTVcZbhCAzfNiyWPSK+QLfEJL3o92qhDszkf65b3oNyrXWzz8dGqjPo
   ZDsVHQVP0eOQkJUoJ3Zdg5ClYUg9cvjE3i9mwZt1z9YqYpTM/4ckrVl6d
   6zjaS9lIIQGJA849S0Vx7QeT9UQmyi77Ozn27e1FFpOkeDumDpVQ/ip+s
   ktIdaZHGZ83h+gPdhZEE8uK2TIMkw4s7OjS5LA4sEYrl08JDPx0Xsyvpt
   2qdSUbeSqa/UXUaWa5jlUouhJdbF+apdY6rXalAYb0hu9n7d/hb0MK9S7
   mZ49i81Y0GhFZe0RfrFHvJ6/ew+Ypg1MZjEjgHlMz9FTXHEwxLtqmNAKc
   w==;
X-CSE-ConnectionGUID: 3NbeAVZvTdeageRU1JJiwg==
X-CSE-MsgGUID: UFEwOuLeRl6vYylGCAAC4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="51626331"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="51626331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:17:43 -0800
X-CSE-ConnectionGUID: /iXKlTjSTMazYP1JLRJs6w==
X-CSE-MsgGUID: tQRWUxbnSoG8rvDPyXh5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120092595"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:17:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 12:17:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 12:17:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 12:17:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY6XQcaprqcwZgeXzAiTKS3KQGMB1Dpic+oXCmtNsp17rneAf7BHeoHfjgwWoMQGloe0SjW5LaU/YWpAp+2TaRhka9RgaLFU9fvuy1VoX75h29FfORRrdbfaykqDwvQ+rxrEjSFZq2yokK+MrurO6l9PtG+pPExGVmV0gBdNqQHDvYvODUwCSCq68NCCa1lysHm+NzWltmfwoag2hGLWRKX78x6kBGW0l5jzduYJEuYz7yjcEaxlAZ7kQerTZyKNYlD5qZoW3dd7sultiDknni1FK5ZywBbXZAtncd0+oq5HNAiF7Leg9ow2bsb4dbSB6gv43PTSkbCyyHuxv+z7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvdrY70M98MIZVr6ClGshrf9TodE0gskBhsyucaRD2Y=;
 b=mxG13qrqMoUi/VXuz3ivkwTufqlKt+vwaC4ZLUfaxVagGKUWWBDFeizjhWGvlGX2h7OL8EXZKa+8gHT+BiSrDkBymDCLpwEPPW9nzvTxLq5HW/yAy4W6AQcNivFfAua+BYCSlV+hygVKFjdEAnV3zdqWfhevB2YtXgNVl0qNKJ+DfTGbnr6wXvRmiFvqOHZdOE52hKWbgLFZM77qv0QTrMALjTxFmTndjEJesKee5MsdsmFnko4tF7YPz3WEVUSDO1x29AEbi3dzU+MgOvoB2FOwZjA/gLMZrKQ0K54A7QW2ZijAJQwYG+FCz2wuzhr7st6w8LsdMldd8sHFEfxiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8038.namprd11.prod.outlook.com (2603:10b6:510:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 20:17:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 20:17:39 +0000
Date: Fri, 21 Feb 2025 21:17:33 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Amery Hung <ameryhung@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: add kfunc for skb refcounting
Message-ID: <Z7jfXXQ06MrlallF@boxer>
References: <20250220134503.835224-1-maciej.fijalkowski@intel.com>
 <20250220134503.835224-3-maciej.fijalkowski@intel.com>
 <0e66379b-3b37-4bbd-9e9d-1f934cb1fdc8@gmail.com>
 <Z7iUMK1XePvptYc5@boxer>
 <CAMB2axNJjsytoFrYF=PdsOOWE-bbficZa-54C9YHT5JFu5PFBQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axNJjsytoFrYF=PdsOOWE-bbficZa-54C9YHT5JFu5PFBQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:803:64::40) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cd73aa-3a51-41de-41d7-08dd52b4ca20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmExL1gzWk5yYlRRYVRYTXVTTE5iK0EyTElwZE5DYmRFWE4yVXE4ckR0bGRI?=
 =?utf-8?B?Q2FnamhhQ3Jnd3pGZVpYNCthdXBSN05MMnduaXZWWVVERFUrY2VlNHBNdERL?=
 =?utf-8?B?QW1sOTV0M1R4c1NwR0pwR1pWQ1VPTkZNWEJ2WkVNRVN3S2Z4V2pvTEsxQUtI?=
 =?utf-8?B?Q1JuL1NPamRHSlpPL0VhdDBrZnhqb0FDaDA0ek9kSjJscUNMSmpqV0ppRVll?=
 =?utf-8?B?VHlEZnZYVDB0THZMdndXbUhSLzJQUTIzUGhEcmJJN1RFbHgzR0FjMkRiT2pD?=
 =?utf-8?B?UFV5ZUFmRmo2Q204S3dTajc3N2R2VFJDQS92ZnNWK1h2N2NhWHJPQ3BSaGYy?=
 =?utf-8?B?SXI5ejE4Sjdxb3F4eUsxK0ZtZXMyT2Q3OS84b1VSVnV4cTRRRGltWnB4WDZP?=
 =?utf-8?B?L09FaE1oV1FOdTZkZWpESWs2bXBSU0xkZk1PckU0RW9FVEZVUHdRTE5POGY0?=
 =?utf-8?B?c2dSWWNCRjlmejRMZGZFNEdXMEFpU2lUVWxtcVFMQXAwOUEyUGN5V2VIUFBL?=
 =?utf-8?B?R2gybnViRkRtVmZsL2ZiTnczY0l4WVJkTm93UytHd3FTbVFjcmhBS3UrWk9w?=
 =?utf-8?B?a3prYThyZG1LVmdzOFlGZjFaVm5UaktRaElZWUs3OHY2Qit6TTJUZkxXWjhY?=
 =?utf-8?B?TmFYdTh5RThwMFhLYzJOeUJXYTcxaXRVYnB5Q3RDUXkzbTJxM3d6M0taSlVO?=
 =?utf-8?B?a2hzdDcwcjJONFZVN0ZJdEFkRkdleVFsQlBjbTVHN3FvbnR4SzIvQTB4N3J2?=
 =?utf-8?B?WVMxa3F3T04rRk5XMlh6V0FMck1ocTNHcHpVS1NCK2tFMGU1V3RpVVRHNk1T?=
 =?utf-8?B?QjlTVzRMY2NLdzNyRWc0NWZSWGFZZlVxd09ycTduN1FTV1RmZXNzQmNBWmh2?=
 =?utf-8?B?Mk5ocTdMbFUrQnlGaHF5TTNVWWRieHlMdXJPNlRWYjhjVDg4WTByQ1JEbS80?=
 =?utf-8?B?KzJtRlYzbE9UdUV6WFJNbTRxMVBGZFBpYkcwTGxsSGd5ZHk4V3BJaWlSWTVl?=
 =?utf-8?B?dGRwbDVnUGhRZk14dWk1ajE1eFRsN2pXcm5NYTZ0aEg1SnVkdzJJU1lBaWRV?=
 =?utf-8?B?Nm5KN0xOaEFUVCtOU1o5eEV6bUVtdHluNEEvSzJ4RXFPR1dtV2NsTStRZm5C?=
 =?utf-8?B?OXBrMCtwZTBSWFhqNG1IdmZCVkVXb3l5c0dmMmVQQUxSYWQzUURzaGdOOFYz?=
 =?utf-8?B?VVc4OWhqT1pQSVY3L05KNFBrNDZmbDllZUhCSk9MT0R3eGFXYW9XcURpTndl?=
 =?utf-8?B?eU8zVGZyMjhZdlFhK3krTnEyaG5NdElGRzBMRjhpNVlyQ2dtK083SFRZc1pZ?=
 =?utf-8?B?MEgrYVAvbmtjcUVldS9RL0RCdWkrRnZ3c0VxODd1dVlxQ3U0MFRRQ0QycW55?=
 =?utf-8?B?amp2REZha3pRczd0Z2pkRTRvZWxPV2tuMWxEMzhqeDNtM2Y3bXI1Vkwxcldw?=
 =?utf-8?B?YmpsWDUyYjZUYlc3QXZFZHcwdEc4bVdJTUc2ekd4SlhqUnJOazJSbU1jY0Fq?=
 =?utf-8?B?d0dPTDNodm9EdVV5QVgvUkxtd0tabVFBeVBWbGprTWdCWVZPNVZ1STVKM3ZB?=
 =?utf-8?B?TnlDQ3ZpL1hpS084NlRrdy9DcDZtYzVLYW8xZGFuaDNuKzA0K2ZocERCc3hz?=
 =?utf-8?B?Rm43Q3JFSlQ4ZFFJN2UvWk0wWHEzT2ZMekpQY3VQdVk2SUdOcEcxSWR4Zi84?=
 =?utf-8?B?aSt4a1NxMVdmTUlvRU5uanBDOGVjVVQ4Q1NDN242M2dGR05JOXNXdGNlSTRu?=
 =?utf-8?B?TENqS292RWQ5Y2xPSnlTbDZMWkN4czE1MjdqRHFDS09jcG0wazd3RFM3d2VM?=
 =?utf-8?B?bHd6aXlrMWJLbHFGUFNlZXdMVXI4d0NyWGloR1gwNHB6ZkJSOHNzQ0RGaml6?=
 =?utf-8?Q?dPzBkg5sh1Mm7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUExYlFEaVdPMEVOT0huYTY2ZDBUaTJkR3FYYkFFcHNWTVZvU0hEUzkxbHFo?=
 =?utf-8?B?bkJjVytiR1p2cExLUllvZXhQcGJhMXFRMVQ2Q2VDTGVnekkvSDR0TDV3SEdm?=
 =?utf-8?B?amY0aS9SNUhXYUlhZ0R1dlZvUGhPS3Q3Tzc4SmZyR0VXeWNEc3gzTXJqYXIr?=
 =?utf-8?B?L1lFZmUzUERza1lCamZieGc4UXZkTWgzN045SDdqZWlvNmxaZkRic1FNZkd5?=
 =?utf-8?B?b3JvMk5BSDZ1b0VGWmZiYXJJaGdFRFM4NzN4dHp6dTUwNHhCMm5IaDYrWFFp?=
 =?utf-8?B?VWpicFFsUE9HanNwTkJlRitIRnZvSnZ3aXFWNjhRVzdiMktJeWNUQThKT2k2?=
 =?utf-8?B?TkJaaUI2T2pOVjg1bitHOWdkVzIwaEE2R2lRcVVRR2w1TC9zdHlFQ003aFlD?=
 =?utf-8?B?WHBTRDBwc0l6aWdzNk9LTGxEbS9kTGFIekoyWmZGYmgyazBtcVJ3UXJ1cE9B?=
 =?utf-8?B?R200azFzWmVlOGRxQ1FmdjlyblNhdTZnekZyS1Y0YzIwL1FVQ3MrZGxlWEdP?=
 =?utf-8?B?VmJFVHpML3dobE1VelZEZk5UR1RLZEZLMWptU0xKcnhpa1V6cHg4VW1HVlA2?=
 =?utf-8?B?ZnNFTFBNTmdpU0swb01EandiVDhlQ0ZDYWg1OHV4ZU91UFJVSlB1ZnNWVHFa?=
 =?utf-8?B?TVNKSHRGdmloc0FBRUx1VEhSSklzQ3BaS01XVlBya0hraUtwaFU4N2o3eFRq?=
 =?utf-8?B?OEUxSVJlZUJLWWtvbGtMd1RqZ1VUM2NGVSs3ZktyU3g2TnlHUG9rTEVJcEtv?=
 =?utf-8?B?Mk0yaEthZE1tV2pPTSs4bEQ2YzZSQUpyMk9qNDkvUFJlMWQzOWIxSzhMcjlS?=
 =?utf-8?B?TzVKMUFQZHRlZGZUcWsxWnFXSHJTdVQvZTFzT1ZaOWFVMEIza2szb3lZN2Vy?=
 =?utf-8?B?OEU2WTMvSS8zY2JyREUxRmI2aUFKNHdHVTlrdkl6amtlbXJ5QmVsb2RoSVNZ?=
 =?utf-8?B?WUhPVHJhdlI2U3pEUzJlUnhHVktCTzBKaFNSZFcwdVo1eVpDUHFETXdETGJ1?=
 =?utf-8?B?aW5NdHBHUkxGc1ZPOVdYcjNKNGt2ZUNwelU5RmtKcTZDc1hRL09xYnlOV0NE?=
 =?utf-8?B?Qm4xajhud0ZRZmxTbThHRUpIUFpBQ2ZQcUlZMkoxTThFZzFhcDJCbkhaemw4?=
 =?utf-8?B?QnYzRm9PcXAvYjkyd2Z0Y3VGV084ZVI3elpudS8ycDFXWHVPR3pmd2FCS2Y1?=
 =?utf-8?B?MzlrT0dib2Iybm1PRWRUOXZ1Mzg1SWd5cDBuRDFVV3BUeDVkUyt2c1VHbXJT?=
 =?utf-8?B?eG01ekJsRmVLWkVMRW9vTWFzMVdRdTR0Unczc3N5QWczbUtSOGcxdjFlZEhU?=
 =?utf-8?B?c29PMEdab2tDekxNeWM3SmE4TWMwVDRXa3FVbUhVQ0tGQ1c2d2tvbytjNmR3?=
 =?utf-8?B?ODJzZHpLM1k5SzhRQlFSWlZaVnY3ODN5K0ZZYW4xWXc3QkcyRGtGL0ZrSU45?=
 =?utf-8?B?NEpwTXZ1dnFrYUlRaE1lMmxMcS9Sc3dYVllnaStpMTN2cEdyU25DdzVZL2w1?=
 =?utf-8?B?aHJxQ3pFbnM0cnpkWDAySlZmdlFQblFyd0FqRW9PSUN6TGx6WTNQU3l6cUx3?=
 =?utf-8?B?Tzc0WXphejU5RWM2VXk5WlhWMHl2ajFGT3Fpd2dOZkxqSUtLNVpJcXJYSTl1?=
 =?utf-8?B?bEpITTZxWml5Q3pLcUsrdDlIMXZ0Q0pkMU1sYlBVZml0alIycTY5QVRoSjdR?=
 =?utf-8?B?VFpqTjE5b0RyMk0rYks5NzBqVUMvUExYc094MGRYLytTdDUrOGp3elBBQlJI?=
 =?utf-8?B?b3RSejJHbENXMjJ0U1hvRGQvUEorekVNNUpRdFl2ZG50Ty9OMWw0Mm01VkpN?=
 =?utf-8?B?ODZQT0p5WldJK0sxRzFKLzk2a20zeHdzenJoZHFvbG5LTkZ5dUlDMTcxd0Js?=
 =?utf-8?B?S1gvMlRYREJES3U3VTBCVHlZMVRlVk5INXRWMlBpbEVDcHk2Qk0raEppTUlk?=
 =?utf-8?B?bG5PcTAyTXE2dGpkV0ErTUsvTnhyM0htM0JIblhiVmZMV3M0WThMZFdKUUcy?=
 =?utf-8?B?QkNwLzBmOHZiTkt4NG1QWnZncDRxdllFTk1GUUhyaFFEdWZxTkw4cDg5UHBF?=
 =?utf-8?B?MVFweldvdVl5VzRYdUxVR2dwTy9zUHNmLzRjVFNzUjZBcWFmWThBdzVlT2k5?=
 =?utf-8?B?OGhDUHFHSmYyclVpK0pEODRoeWg1QnVvUlQ5RU5LekdSQnJ0YUs5TjU5RWlJ?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cd73aa-3a51-41de-41d7-08dd52b4ca20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:17:39.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYQXZiXArLYbleNBPX7/eZGNMb5EPYKicJYYWsZ0AfiucUwTtbg+8bw+0qYfMVCm6lBd3ZunrYlGGLVK2LHVDB0ah59Bi8WKOmg7+Py+Mw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8038
X-OriginatorOrg: intel.com

On Fri, Feb 21, 2025 at 11:11:27AM -0800, Amery Hung wrote:
> On Fri, Feb 21, 2025 at 6:57 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 03:25:03PM -0800, Amery Hung wrote:
> > >
> > >
> > > On 2/20/2025 5:45 AM, Maciej Fijalkowski wrote:
> > > > These have been mostly taken from Amery Hung's work related to bpf qdisc
> > > > implementation. bpf_skb_{acquire,release}() are for increment/decrement
> > > > sk_buff::users whereas bpf_skb_destroy() is called for map entries that
> > > > have not been released and map is being wiped out from system.
> > > >
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > ---
> > > >   net/core/filter.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 62 insertions(+)
> > > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 2ec162dd83c4..9bd2701be088 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -12064,6 +12064,56 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
> > > >   __bpf_kfunc_end_defs();
> > > > +__diag_push();
> > > > +__diag_ignore_all("-Wmissing-prototypes",
> > > > +             "Global functions as their definitions will be in vmlinux BTF");
> > > > +
> > > > +/* bpf_skb_acquire - Acquire a reference to an skb. An skb acquired by this
> > > > + * kfunc which is not stored in a map as a kptr, must be released by calling
> > > > + * bpf_skb_release().
> > > > + * @skb: The skb on which a reference is being acquired.
> > > > + */
> > > > +__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
> > > > +{
> > > > +   if (refcount_inc_not_zero(&skb->users))
> > > > +           return skb;
> > > > +   return NULL;
> > > > +}
> > > > +
> > > > +/* bpf_skb_release - Release the reference acquired on an skb.
> > > > + * @skb: The skb on which a reference is being released.
> > > > + */
> > > > +__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
> > > > +{
> > > > +   skb_unref(skb);
> > > > +}
> > > > +
> > > > +/* bpf_skb_destroy - Release an skb reference acquired and exchanged into
> > > > + * an allocated object or a map.
> > > > + * @skb: The skb on which a reference is being released.
> > > > + */
> > > > +__bpf_kfunc void bpf_skb_destroy(struct sk_buff *skb)
> > > > +{
> > > > +   (void)skb_unref(skb);
> > > > +   consume_skb(skb);
> > > > +}
> > > > +
> > > > +__diag_pop();
> > > > +
> > > > +BTF_KFUNCS_START(skb_kfunc_btf_ids)
> > > > +BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_RET_NULL)
> > > > +BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
> > > > +BTF_KFUNCS_END(skb_kfunc_btf_ids)
> > > > +
> > > > +static const struct btf_kfunc_id_set skb_kfunc_set = {
> > > > +   .owner = THIS_MODULE,
> > > > +   .set   = &skb_kfunc_btf_ids,
> > > > +};
> > > > +
> > > > +BTF_ID_LIST(skb_kfunc_dtor_ids)
> > > > +BTF_ID(struct, sk_buff)
> > > > +BTF_ID_FLAGS(func, bpf_skb_destroy, KF_RELEASE)
> > > > +
> > > >   int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> > > >                            struct bpf_dynptr *ptr__uninit)
> > > >   {
> > > > @@ -12117,6 +12167,13 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
> > > >   static int __init bpf_kfunc_init(void)
> > > >   {
> > > > +   const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
> > > > +           {
> > > > +                   .btf_id       = skb_kfunc_dtor_ids[0],
> > > > +                   .kfunc_btf_id = skb_kfunc_dtor_ids[1]
> > > > +           },
> > > > +   };
> > > > +
> > > >     int ret;
> > > >     ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
> > > > @@ -12133,6 +12190,11 @@ static int __init bpf_kfunc_init(void)
> > > >     ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
> > > >     ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
> > > >                                            &bpf_kfunc_set_sock_addr);
> > > > +   ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &skb_kfunc_set);
> > > > +
> > > > +   ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
> > > > +                                            ARRAY_SIZE(skb_kfunc_dtors),
> > > > +                                            THIS_MODULE);
> > >
> > > I think we will need to deal with two versions of skb dtors here. Both qdisc
> > > and cls will register dtor associated for skb. The qdisc one just call
> > > kfree_skb(). While only one can exist for a specific btf id in the kernel if
> > > I understand correctly. Is it possible to have one that work
> > > for both use cases?
> >
> > Looking at the current code it seems bpf_find_btf_id() (which
> > btf_parse_kptr() calls) will go through modules and return the first match
> > against sk_buff btf but that's currently a wild guess from my side. So
> > your concern stands as we have no mechanism that would distinguish the
> > dtors for same btf id.
> >
> > I would have to take a deeper look at btf_parse_kptr() and find some way
> > to associate dtor with its module during registering and then use it
> > within btf_find_dtor_kfunc(). Would this be sufficient?
> >
> 
> That might not be enough. Ultimately, if the user configures both
> modules to be built-in, then there is no way to tell where a trusted
> skb kptr in a bpf program is from.

Am I missing something or how are you going to use the kfuncs that are
required for loading skb onto map as kptr without loaded module? Dtors are
owned by same module as corresponding acquire/release kfuncs.

> 
> Two possible ways to solve this:
> 
> 1. Make the dtor be able to tell whether the skb is from qdisc or cls.
> Since we are both in the TC layer, maybe we can use skb->cb for this?
> 
> 2. Associate KF_ACQUIRE kfuncs with the corresponding KF_RELEASE
> kfuncs somehow. Carry this additional information as the kptr
> propagates in the bpf world so that we know which dtor to call. This
> seems to be overly complicated.
> 
> 
> > >
> > > >     return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> > > >   }
> > > >   late_initcall(bpf_kfunc_init);
> > >

