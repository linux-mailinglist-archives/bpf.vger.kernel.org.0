Return-Path: <bpf+bounces-22256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B285A3DF
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5961C21552
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B831A7E;
	Mon, 19 Feb 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeTog9vN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137F2E835;
	Mon, 19 Feb 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347234; cv=fail; b=M4AKJWth/g32BcHNCqFybPt6zLjWPoBEQtRQ3zYYsFvJRPBgFfdeByxMXpPHned9w+C7d59K8CTrk3G+Es5Rs+JLY4x2o4ck0Lzao223/GNP5DtB9ee1kGzfxgsAXcARZVv8txAOE3G/0a7TQJQbTJhcwtXguljRbzp/8F5+INc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347234; c=relaxed/simple;
	bh=o1aVrOnHkwsDh4/lGtkdRQOrhinGI3AWBJaJzYacEt4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXKLt671ik5zE/Ikh64iZO2j37au91w9Iam0TofV370QHO/vYP9hUVu4yLZ5Tmh0UdSXqFwCJWxte7p0O4rIYTvE3uXZjawjxEhUhibiNRndPb4sRUxE0ytkmKHARVjSrJD8/oEGrD6GdmFswL2CsPXBgjZHN35hACr/5uRGTSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeTog9vN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347232; x=1739883232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o1aVrOnHkwsDh4/lGtkdRQOrhinGI3AWBJaJzYacEt4=;
  b=GeTog9vN8rCu2BFTaGleI97IH9GsmjIl+Ie47p8lklK8kdjoOqQ67A6P
   C5WxkYyI1gwA1VZGi14hie8kOkMVoPzxTH0n2R5kpvw7MFKC0vrgz9qt3
   6h0WHGVV48Qay97qxqHee6045vCuk9YazL1gyvxmJ21m/QX5dTrFsC8bP
   C7lM3WAyK4uM+igdH9zLKbck+19RWxTpTy/jDIANndTaROREwE8+oac1a
   k9RWvaYB6pIaTKhXR1EO6C+3uA5BYE7SdZ+9lydSVJMgnHDijvRoziY+J
   mCaPWJxSy+KJAA7/P4vN/t+4fgaZgVqpFbxgigEAmKj2DEkUUZVyL6IXg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="24882635"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="24882635"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912870661"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912870661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 04:53:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 04:53:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 04:53:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 04:53:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUhUXMzvycUvRl+jYqcGI27kMb7p3+hVo/6WQ9sUOjQCXV1EWvPJ5Q8QGruobiH0Qg+ffwHu4WMKmWDn01vlnbK1/MNhSK7WpRGaTdWICLaLxgP8sTfBEw+61aH/cTauSBTcpWEryWiYQ+e5M4Fu9HpQF1M1ns6hkI51nwNC70F0ehYDL48QMUe0PpuVsomP0uKOpvxYi67KdQjWER2os8MPId85Qhd0N+A6SZ7Wfp+/Ourcp5v9CUeRO4VKZQBNCh7owU21GjK1A8KmE90iUz14PBpt0vGMdVBaWn0/1LA9wIoJRL1gN2Wf88a8EJBuQhVc+5rB0cXikwwX8H8GIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyuaqdqH4PrtacIjOik+8EMcx0RAArA2BvXG4gvBQZQ=;
 b=Lw3T9cyrhx4bNgORJ80rqp2qVO9G8uq5NxnuE5CjijePK6rEP/KO20VwnjZEVeF7gHd4xWkww5exKxwW2bCdvsEQqsSLOJYcVPm9M5HNo9om+nAv/TSCmpIxAgIP7WUaIEvl+ZZJLJ5S/wWcIKIgpG4Ex3Pk7f3iLPM8DlBQT4ae7YK7oPACuAf9fNORN2r0UHgk79EiBHbpMpno/FvpRYiPzqDJbu/g/gCrgKZuoynT33/u4NWEUgnFHGRFQMbBvCXMFdq1YJSXqDq83ASsNh1ADOsZiuStTCc/ij+anZoCy6F3y9d8AV8cpuINIQQr/Y30GiZSdBlwF9L2/MpCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB8166.namprd11.prod.outlook.com (2603:10b6:610:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Mon, 19 Feb
 2024 12:53:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::93d9:a6b2:cf4c:9dd2%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 12:53:41 +0000
Message-ID: <6b003271-cd83-4091-89c6-bb37da62afef@intel.com>
Date: Mon, 19 Feb 2024 13:53:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls when
 not used
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-2-aleksander.lobakin@intel.com>
 <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <893ad3a4-ba24-43cf-8200-b8cd7742622d@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR05CA0022.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea1d434-bc1a-4c31-0689-08dc3149cccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vq2xnJBXXGgxcwwZA3JdeRiMh29D1+uSvfpBRSQ5eMwB8NxFyyD2nFaQYRxFbmAi96/keCenBDxf7hTrrBQhgZ4bvOpMUa+W1ckxyMGK/x858BPyD+hwiGPkEPXE6uPtPjaayuTlCGjudoI+1KwvRtcHK0L/DYlMjsPNss6oedjaWDziNgUjMiPQoGFPc/UcJygzmPpA10ppCWBVXYJNHTd8k6bJKODq0azsYCQcttuv42Xk6kR3Z3YWZEkeh4HpVt0PxXXPYiuI3BXYiLNsQfAXEqPcJi20c9pCNOzM7Mtgp2a5Zi6b5yndIwvgIC3pTmBLGJY0sZm3CiIdbGYAaulzRiXASLNkerabwXoGFiXEg7Kd3SH/tjke05zfnGbHEwg1edu3VxOiD2/5r/Mw2uAAhHLAIBfS+z4kcSIskoMueGBOZDqTaTgoMjGU46b9+AjwVpqHmrTJB3tIzIYCM1SMNGgbMg3gbRNHzauWzagg8dyhDFw7MfT8XMm6hmmABqUV7j3ZlGJDukkAkDRGQ0nb8ZNtyf+o2MveDHq4YaLUvJLsjZnsjdRgZ6Pa3Xm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2J0MW9HSmRXWlc5WWVoaktSRUhING1RYUhmRTVLbjRhTkpqL1lYQUc4RVVF?=
 =?utf-8?B?Z2U5LzRac0lYRFFCNGhvTHJsM084ekhTZkJIRXJHaWF4eFRkdTVFS0FTM0F4?=
 =?utf-8?B?akR1OHBCVm44dGpXMk11bnVWMnVRQldWSlM4WGc4bFFYVGpzTktpWmRTZWFi?=
 =?utf-8?B?b2lYU3pJZmRnd0xCREJLMzAvSmN3K2RlSWNYU0RFNkRScEJZNEdrZDQvME1L?=
 =?utf-8?B?K3M0NkhGR0cyeVQvMC8rWlVEano3VTE0bHQxZWZ3RXhFWm93Z213ZW9NY0Q5?=
 =?utf-8?B?eWdtZlF4V1ExMEgzM3pnZ3Y5Z0l1dXpsdHowVnkrMmY0MUhscjdpMEo0TC9R?=
 =?utf-8?B?aU40MG9FME5aaUQyTFI3M1N0WnYxQnNpeWs2NzFsRG5wSklndXZUR0VLSnpz?=
 =?utf-8?B?QW01Ym1FbndzaTR5UisyekdmQlFoVS9zRFRxa1M2Q0hFQ0lKUWZ6Y1kzWXBa?=
 =?utf-8?B?a2dMOWxkYU9ZTUZnRlpNLzIwZWlIOUpRNThTZjBXMmZERzYzRFdMMy9ON3lt?=
 =?utf-8?B?NmY5STJtbzRqaThENjhQanhaL3ZyZFp1eXNBcUZIMGcxKzhJMXVvdmQ2emI5?=
 =?utf-8?B?V3VCSXFzdjg5RkcrRko1Y0ZSL0Uvd0taMGJCakNxM2NKU2huZ29QcE5TNnp2?=
 =?utf-8?B?bC9hRkZmOXBkbm00QXg1S2Q1Nnh4dTJLbGpQc3E0MERnY2ZDMzFzNHZLUDRv?=
 =?utf-8?B?aVJodnhmbjlxYWpUSFlFYjc0S1ZVN2V2NzRUNEVjREtzZGU3WWpQcW5yVCtt?=
 =?utf-8?B?T3VabjlIbDNZVWRPZWNPV2tSWkZmbnkyZCtJV0oyNzJJbWIvZzNwU2JUWk1K?=
 =?utf-8?B?YmNzc0t0bktMV0FGYnpsamtqS0s3MTRKdGpHL29tbWNTUXQ5Sk9ZVVpYVW96?=
 =?utf-8?B?K3o2UzZvdHB5RWF3YlZqOWhCc083ZkNkNSt0OUtvVVp5NTlSUUxDengyY040?=
 =?utf-8?B?MVkwcXhmUTZteVU4Mlg3aEhCQysxbjJmblFHbnFKSWttQTRpcjFab0JaQlU2?=
 =?utf-8?B?NEN2ckZoaVA5U1JWRVZtbDNEdm5kbTRieWEwZDMyVmNHNVluTHhQSlJSckdC?=
 =?utf-8?B?dU00V3MwNG4vNWFINlVMaEptM05MSmR5b0dOZEJEUTRpeWRuQjlsU0ovSzBu?=
 =?utf-8?B?NG1ibEowRmtsMGd6ZEt6cXRxTW5GcjNxbUpkOStrM0JadExRekR0SmQwb0Ir?=
 =?utf-8?B?Zi9mbzI1K1NGUVArbXlCQzUyNWdwZ2VuVE1xT3orZ2xCQWJ6aVhFV0Y0WnZQ?=
 =?utf-8?B?M2p4aGhOQ2RFTkVyeFBlM01yakhvemtKRE45djVPMUJCUjNtNzZVaWRjU1RM?=
 =?utf-8?B?eFZic25uWUFNUFlvcGsyMXhCR2pMRGxZNm01Rm9JbkFLbnMvNW91OUZ3SDR0?=
 =?utf-8?B?d25hSXBjMzVQaDFXV3VKRHgySU9ndXkxMTZqakRQaG92NjZKM0QxdVUrMUlQ?=
 =?utf-8?B?SDJoSzMyellVcisxdEdwZnVyeWwyaFpHOXRTZkxHSFZ4OUlaSjBVa0ZwSWNp?=
 =?utf-8?B?YnJlKzY0UGl0cU5WdDBGeUlNM0ZSVnlyT1FZSzVjZ2FidUdSTld3c0dneE5u?=
 =?utf-8?B?bVNVd2V0L0FGejhLbmx6ZmxGc0NFVmFmQzNRRjZmWEk5c1FhbjR6a3JzL2xV?=
 =?utf-8?B?REExMDB0bGVPRDBkZTYwUHM1bVp6eHpEdEQ4U1NVWG9VQTNZSXRuaEt2eU1m?=
 =?utf-8?B?QWJVcU1sWUc0dzRndTk0U1BRUHV4RjdtZDdPYW1kMmd5QUVSUkh1dkxNYk1I?=
 =?utf-8?B?ZDlqOWNSRXNPbTFBNTdUVndSOEdzNjd0YXRPVWVTeFlTbElpcFVBTFZJZ0My?=
 =?utf-8?B?N2REU0M1S2kzV3p3TXVuWFFycjM5OC82Qm9Pa0lHc05PVFJRbEtKbGdkcHNj?=
 =?utf-8?B?d2ZjaEl3VXJBTGlaMjg1dXR2d1pZMmt4TThSeXlGNDUwMDIvd1dLUkU3cTVa?=
 =?utf-8?B?VEVzRUFZT2w5cDNJS3BDTS9xTExqOHBmOG5wK2pzcjBmTmxKZXgvSHhCUmFa?=
 =?utf-8?B?dTBOYTZtdWJxWmtEMXBVZXdRc243WmNTT2RLbGF4dHRRbWx1a1RRV0xTZzBI?=
 =?utf-8?B?eFA0RFQ1RWVibUV1ems4NG5UZDd5RjNrY2V4VHRzSzIwZ0svL3VmYzhJYzdo?=
 =?utf-8?B?SGhrQkx6M0pyVFFTUUs1R2R1bzdoMTUxa3llczBmendMZktMSVFtREw0dCsy?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea1d434-bc1a-4c31-0689-08dc3149cccc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 12:53:41.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfgHYHXCr8urgYRz7uJLKE99SHcd93zSJl03gOVR/BK/tePAyUm1ejcesmSA0DU5sTippcCrUDm97isyfLp+TLeaOrfiQB6jb7CX/sfU/EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8166
X-OriginatorOrg: intel.com

From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 14 Feb 2024 17:20:50 +0000

> On 2024-02-14 4:21 pm, Alexander Lobakin wrote:

[...]

>> -static inline void dma_sync_single_for_cpu(struct device *dev,
>> dma_addr_t addr,
>> -        size_t size, enum dma_data_direction dir)
>> +static inline void __dma_sync_single_for_cpu(struct device *dev,
>> +        dma_addr_t addr, size_t size, enum dma_data_direction dir)
> 
> To me it would feel more logical to put all the wrappers inside the
> #ifdef CONFIG_HAS_DMA and not touch these stubs at all (what does it
> mean to skip an inline no-op?). Or in fact, if dma_skip_sync() is
> constant false for !HAS_DMA, then we could also just make the external
> function declarations unconditional and remove the stubs. Not a critical
> matter though, and I defer to whatever Christoph thinks is most
> maintainable.

It's done like that due to that I'm adding a runtime check in the second
patch. I don't feel like touching this twice makes sense.

[...]

>> @@ -348,18 +348,72 @@ static inline void dma_unmap_single_attrs(struct
>> device *dev, dma_addr_t addr,
>>       return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
>>   }
>>   +static inline void __dma_sync_single_range_for_cpu(struct device *dev,
>> +        dma_addr_t addr, unsigned long offset, size_t size,
>> +        enum dma_data_direction dir)
>> +{
>> +    __dma_sync_single_for_cpu(dev, addr + offset, size, dir);
>> +}
>> +
>> +static inline void __dma_sync_single_range_for_device(struct device
>> *dev,
>> +        dma_addr_t addr, unsigned long offset, size_t size,
>> +        enum dma_data_direction dir)
>> +{
>> +    __dma_sync_single_for_device(dev, addr + offset, size, dir);
>> +}
> 
> There is no need to introduce these two.

I already replied to this in the previous thread. Some subsys may want
to check for the shortcut earlier to avoid call ladders of their own
functions. See patch 6 for example where I use this one.

> 
>> +
>> +static inline bool dma_skip_sync(const struct device *dev)
>> +{
>> +    return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
>> +}
>> +
>> +static inline bool dma_need_sync(struct device *dev, dma_addr_t
>> dma_addr)
>> +{
>> +    return !dma_skip_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
>> +}
> 
> That's a bit of a mind-bender... is it actually just
> 
>     return !dma_skip_sync(dev) && __dma_need_sync(dev, dma_addr);

Oh, indeed ._.

> 
> ?
> 
> (I do still think the negative flag makes it all a little harder to
> follow in general than a positive "device needs to consider syncs" flag
> would.)

I think it was in the original Eric's idea and I kept this.
I'm fine with inverting it.

[...]

> Thanks,
> Robin.

Thanks,
Olek

