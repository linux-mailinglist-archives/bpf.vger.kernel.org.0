Return-Path: <bpf+bounces-77290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D9CD6114
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7269306221F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4952C235E;
	Mon, 22 Dec 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KO3vfM7A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BF2C0F8E;
	Mon, 22 Dec 2025 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408116; cv=fail; b=RBVVp+KshbOpfjcyG+m1YAhzQsGERjD7o7UC4A5D9HDuqh/7ni7uHKVLSkefZX74dIgeU6E9Y1+4jDGVr7+zR3KzjbgDel/TRxN9JuD6A47GyHPFIhQVec0wjvleW+YXDK98sIZrHjKStIk2Bex6wjtVEZQNKC4GvW8qMMFTnI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408116; c=relaxed/simple;
	bh=Va6zn5yIg99OT03DBqRHST6fEEZpvUigfUIMZjXxPOk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjnujx2Pemw3JKrPq0HuCa6h+1wnPBHm5iws1/1xv4vs7XHuFNJ83a6adbyVnWsPBcRybjnaYLRL4m33VVLMHdezrPnWjX+Vq2aTycDEuHSSSJHKcuZMuvutlhszI2vThFcLfOPPS4XS4+y87E8aOC/rBjOGaZ4XyXN6qT+Ff1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KO3vfM7A; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766408115; x=1797944115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Va6zn5yIg99OT03DBqRHST6fEEZpvUigfUIMZjXxPOk=;
  b=KO3vfM7AwqoAQNwzyjxtoHS1CTIHaWyVAnM+c96BfVT5kqcwDqoVotbt
   hWFVMsqyXsFQU7uA3rxZRQTGWIaVbOD2nhdUMgyhlgMbt/dCO3Kv/+4xr
   qAMsN+7GLS9X2YSd6GqFuMkxoxTvAD6SPOLKpBvotVNt3sE3qOhvqkGCv
   PsqkawJKxx4dWdDQkOqBFjxGNOrcu7j+ku75aoaj0xb5MKK8aAnwanN54
   AS1YTAaXPhAYfr7Jn7B4ZfiJLxhURHMOi18B1CqMawURykXL86gfWg8MH
   1h0Q9zgcJ8mPuhci5n1Gi5Y6a0j+evMqTwD1ZgoOVgmxXq1GRqnkqTQZS
   w==;
X-CSE-ConnectionGUID: wrRMCOoxTmaZw51FkkLJcw==
X-CSE-MsgGUID: t/VmpLt1RkCFLgnbu1PFhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="78581654"
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="78581654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 04:55:15 -0800
X-CSE-ConnectionGUID: TUehp7gWTBCjK7oFHV9/sg==
X-CSE-MsgGUID: whZ0dY2bS8OQ2b8mpbt7og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="200023109"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 04:55:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 04:55:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 04:55:12 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 04:55:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFm6bM2j3QVs3XCLDvVdQq+nbE9RL4IbOU+V7uXCAWwVQYf2+zRYCG1GIncVBLTWLFxK/kAGudXvrZF1uGgF3ties2h+HmAmcLXtrv0E1Ng0I6ATUPFgcQC72XT/mfu12w7fWQiPzCM/sBf+CmsM8Vy071e96OBqK2ivUvbilMW/nITD+5mnG94u6JnMsqxzUqpEoCupS7M7uTZvEm1RzG6wwRDYQHilLNuFJ2Hu1wiCxIctIhw9SmHBoFPdfS+ECjOuiw8Tu3Ht2XmujGUjlumIZ4nHS8IsBuSHIhgpBhaCyRmfXnRSwX2Q+mfThRIxAVIQxj1iC01qr9jWPOBW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtWSgWBJimk0jPvkDAHXD4i5kVD+wOWyMJfVFk63yjM=;
 b=A7sWbkQ5WHE5qp4ovI9j58gpml8bSn4hRYBjjMEWVNxQ4XHgm1d7nlUMdcoWc0BqWwxmhZOBrW1cfluPByXp/duoJwVY5EK079AFFpkwdDpY5daAJGFScgv/VE0f5C6O4PsBRUCP33WbkNoeTJr8wbVqO3sH2OwhGWesVyel1c2uNFHoe1bMiLqU0zq0ivZgASILWhdkRxWJnHt+wOwLI/aKw586/G2LHZOVEJzXJMcJ3z355l/toDvUKFfoXr517xujGElyZr2obidTcbn3Tc3p/dIEYgAv6sy1kQjtN2aOpWjhu8PeUqtpItMFHv1vUw8TTGnWEYls5NWmN1PskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:55:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 12:55:10 +0000
Message-ID: <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
Date: Mon, 22 Dec 2025 13:54:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20251219202957.2309698-1-almasrymina@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251219202957.2309698-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aded85-edf3-4c81-310a-08de41595748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWRiNzNTL1hpOThHUkczdjg5SHcxekIzRVZNQTVtTHpNRENqYzh3SUhJMXFu?=
 =?utf-8?B?NmNtZUh2Z2d0UXBMbnhLNFBETFJSV25TQWNLTFVZaHFIVExwaTducnE4OUgw?=
 =?utf-8?B?ZDhHc1p4bFBUV29vaDVJb1ZyOGhwTmdTSWRISms0K255QmRIYUZhd0dZeTZE?=
 =?utf-8?B?SHJSQkg5akptTWJHOU53ODBZMXNZNEM2Sk5idzA5Q3NkTHFOSG5ycHNEVFh1?=
 =?utf-8?B?NWYydVdPb01KMjN1Q0Q1RU5XNVV1Sk9qSmRyVGdFdTFXc3VFWlpNU2l5UHov?=
 =?utf-8?B?LzVaSUxwL0dqNjA3YXFZQ0s5VlZJYkFQMFZ5MWpLajJIRmlIWVlxcWFlUW45?=
 =?utf-8?B?VmRhOWYxbW5ON1ljZ2ZHbFdjSTFTSWlQN2JpOTMvb3lYb1p1WUV6RThUeGdj?=
 =?utf-8?B?cGhwSTZ1dFZGQnlSckhrR01UMHl1YW1vemxvSEZ5SnU2OXlHdkpqbjdwVXJ3?=
 =?utf-8?B?V3RTeml0aTRRTTFQdGZ4cFJxdm84Q3k3TnZjSEZvUXlDTU1mN2hxY2VtZEVx?=
 =?utf-8?B?WE1vMXFscGFuYVhSNWRHZ1hocEhibUJDYXNLT0gvc3lQdkZ3M3BqaVlPdkd1?=
 =?utf-8?B?RjB1NllERitDbThuMDNqYnFtUUhjWkpKWEwydHVLZ21uLzcxWDErSVhVNU5s?=
 =?utf-8?B?U044ZVVqcjVlcUNtVnZ0THp1d2M2NHErYzVQUVZkZUExdW5vS0ZMM1NUbmgw?=
 =?utf-8?B?TzNMSTRCbXpLdnNIVlZZZHZRM1dVY2Z5VUhTbm5JVDkxUVhDdVdiVE44Tm13?=
 =?utf-8?B?VW1xNGJvaFZUNDRMU0I0bFFMVlhDeDFpRU1EaFJUZEZjTHlwV0ZsZDNPVkRo?=
 =?utf-8?B?L21pUXV6MllPYXhxNVdML1NoalVNZEljVGZmMXFjeHJRYkNZMmM1ZmxCNXdm?=
 =?utf-8?B?K2lKcHRNU0xVbVE2N2FNSG82Wm1UZzRsYmhSTmg2ck52UXN2M3VlZkRUK25k?=
 =?utf-8?B?NGFIaTBTTTB1Q0Z0UTM5WHVaL3lVUkdkbXJnQ1NqWU9WeTFEeG5xZE50aUg5?=
 =?utf-8?B?V1dYUzd4WHNRRXJjWkVYZWRlc3A2bXFEbFExais0a1E5V0VMZTJ4MlM5Q0NN?=
 =?utf-8?B?R3Z1QjREVzdMek5wTDdOY0RmY1pYV2xiRUFSaFU5Z2VtTXpWaXZpbEdIOHQ4?=
 =?utf-8?B?YkNCS3dnOCtPOFg5SDFGdFNjZkM5dWg4SjNIQXgyNVFzUXR5VXZtVXRnUmxn?=
 =?utf-8?B?WkNpRktMTytidytXSS9HbWFDZXV2WVhPZzhxV1BRWG5OcStHNktlWU5CU21H?=
 =?utf-8?B?ZHhlbFk3V2p4c3Y3Sm43OWZxNFg1MnZTZXJzV25tZ2tFQ21ROTdWRDFWZmFB?=
 =?utf-8?B?NnU5ZnNmVXNTdDJGbS9WdmdxaTN2ZHZLNlpOTXd3L3BlMEFCNmVMZ3prWlRZ?=
 =?utf-8?B?UDh2TVE4OGJUaUdERE8xSFBpSzRlTVNXL3Ayb0VsWWVZSHludDJsaFZreGtF?=
 =?utf-8?B?aU9XcG92aWN5eU5oZmVycjYvOHFzbXUwcFE5R21BZy9obUtnNGFBeTBSdUZL?=
 =?utf-8?B?dWMyOGNrZHVWSTR3TUpjdnBha0R6bnFLNmtEdWpZeitteGptVHBaQ2Rrdytr?=
 =?utf-8?B?dW5pM2NPSldLWkw3WlRDTjJSTEZaVmlDaCtDdTR3c2lXOExFUlNtL295akYy?=
 =?utf-8?B?OVpVWDM3SlhzV01IcXo3R0l3UlJhNE9ZMlpBRnFyeXMzK0VTZ0EyU28zSHp4?=
 =?utf-8?B?ai9jK004M2JRcjl3Q0tPQ0t4Z2RyOWNtSStrVmcxSHBnL04yWTJZK2p2N3hv?=
 =?utf-8?B?aTRkNHJyS2lTSzkxUDdSM2xWQmJ3THJFUVRZRG5ZQ0FFdFo5bExJS041NHo0?=
 =?utf-8?B?elR1MmxqbFlsbElobG9qOEpwU2lueDB2TmdjREZQdkkzQ04rV0NkV1J2R3dU?=
 =?utf-8?B?MGMxRi8vbUJ5bWVPOFVWME11cnN6TFhvckhVcStSSWZ1RTdDdzZkOE5vN01Q?=
 =?utf-8?B?N2dOdFYxWm50UlRRaEVLcW9OWE9JNzFhRjhGTDBtL05WVGxuUElnaFVaVFFU?=
 =?utf-8?B?T3htMERRWlV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDQydks4OHoxRFFkTVVJMHRmNGhyQk1zdHNrNFh6bGRVMEVBWEEyejFNTHht?=
 =?utf-8?B?clBvdkFuYm5ZV1M1UGtTUjdvZUFpNUxNQkNuTWozelJGL3NjeEFaS3ErMmJD?=
 =?utf-8?B?V3JRUGc1MUVkVTZORnYwWm91L2RuNTlXYUFlZEVTTXh6ZG5hZmREN0ZLYTRU?=
 =?utf-8?B?T3UyaTRBRGxuV004S1hTRG5Zbnh1VDRhUUllb1ZNTVIzZzY2bVpuMW8zRTcx?=
 =?utf-8?B?RXZaSEE3eFRlU3RkZWJZeUZSY3B0NS9EZkFkdFMwazIybWpHbzVkWGgzVDZR?=
 =?utf-8?B?VVVvSTh5V2p4ajg2NVNCaGNuNWFLTmU1U2phRXFOSC9xT1U3Wi9NNEpMMk1V?=
 =?utf-8?B?Qkd5UW56TnZPemRIS1VBU2VKMEdVSmNub3BiTU16a3E4VkZSQ0EwTlVlbkor?=
 =?utf-8?B?cTV2ZWt3c29wOTNGTkcvZHlsMlNXQVdvbmdUY3p5WDBlQ0NrYk1ZdWozWWY0?=
 =?utf-8?B?R2FicFNTcDV3V2V3bEw1dWZ3ckxSR0lCTGZoV0NsV2Ywb1pDZXk0eFE4YU1C?=
 =?utf-8?B?aTRWeG9qYnY0dVFVVHZsMVNqbjgzNWVQK05OeW1FMGMram4vZGM3Ky9sL01q?=
 =?utf-8?B?Qm1lY0J3WHhSZWdSY3lOUmhKMWUwaVZPMTFqL2Y1SlNaNGVTV1lnOFBtclBt?=
 =?utf-8?B?VTJiRlFZYzF4ODQ0aCtoVnlsN3JuY2NWcmVQeEMyZWI3bnA3L2JKeU9FR2RS?=
 =?utf-8?B?TVRHVEM0SWxodmJORmN4OFNmcW1ub0hnUUZUT0JvQlVmaW95dFZxdThoQzV4?=
 =?utf-8?B?dnpLbytKVjJhYzd1ZDJ5NHJteSs0L0ZaWVRtTEVDNE9rNWRoQzFNbDE5VHpL?=
 =?utf-8?B?S1ZqTUVvU05HTkw2UmQyZVc1KzM2V1RBaU5EU1FXeUUyYTZGS1NkK3J4V2pW?=
 =?utf-8?B?YmF0Q2hPTHdnN2xtc2h3RWhrY3YyazJtWis3K3NmL2hqcmpCSHFJK3BPc2JB?=
 =?utf-8?B?K1VMK3FrWGJLdFFpTHV6SjMxRW5KSnVRamtza2ZzeVpEUEpYQTVMdlVZdnV4?=
 =?utf-8?B?WHRGRjNjT0hBWStiRVJNUVh4c1FHSUt1WHd5NGZVWnNEY0d4eU9PRklENE1X?=
 =?utf-8?B?NnhPZFJNVFVUbzhjU2RDMnZ4MkdVOGV6eW5pYkdjL0E5NktkMThWdTA3WlNZ?=
 =?utf-8?B?OGIySks4U2dXSEl0aEI4YlpoM3B1TWNPYW8wN2VNMEhZdy9GRnFlQmkvQU1Q?=
 =?utf-8?B?NlVQK2tsVHVvMUVjV08rVnR5SENwTjFwTTZlZ0tPN3J6OVBneTdvLzJEVkhk?=
 =?utf-8?B?QjNYQURuRzQzelc3dHgwRGhTMktpdVpDLzY1S0VPaGxUTzNKNEZEcUFsTXJN?=
 =?utf-8?B?TCtIYllrbmhLY3RIc1F2c0Faa0hzV3lZY2pUMnRvSVg2Nkp5TnJlb0NUbFBV?=
 =?utf-8?B?dTY4ZnE4bnRDaHBmM0xlb3ljNTlOR1dOMWtNeFd4bWpmWW92a1NCMWF4c0Z0?=
 =?utf-8?B?Q1RuS1dQM2dtQ0hjTzZDOXBjNVcrc2dWT3pTQ3VwaFVUd3dHdHN3aDU3MSt0?=
 =?utf-8?B?S0Rvb25VNjNwV2J2L3BUQ1VxRVlmKzVIVUZ5WnQrUUlrUE4zMFZaQjhrWTZP?=
 =?utf-8?B?UWI0ZysyL0xiZk1LV2tNTGkyOWoweEhsV1hQSFVERWUzTVFiMTVORmR3bTRF?=
 =?utf-8?B?MnVmY2J1bzNpYTVTSkw2SVViRVhLWE9OTzc0K09hQTRJc08yMUQ3cEZRZkxw?=
 =?utf-8?B?cTEycm1oTWNBMkxyU1NkR3lBTEpvZFN1emgxMTEyOWV3b0J5Z1Y3TUpTUFNM?=
 =?utf-8?B?RElTL2Y5a2FMeUZsZHBFL3YwK21yeFdXeFpVRWpLUGt4MnRBcllBcjRkeVY1?=
 =?utf-8?B?bzJuR0tJd0ZBd0pMYXZkbldpOWJOWE5YNVgraktJZTZydTVQc1V0SXpaYVBs?=
 =?utf-8?B?R0E0ZTAxbElQNXhwUXVKRVpWazhLOHlobFI1SW41RERzejQ4WjdCNXdCUGph?=
 =?utf-8?B?VFdUbEsxUzVKdVl4blk5c3R3SWJKUk8weml4eFltZEhqK3FjUVp5VVZ6Z3I4?=
 =?utf-8?B?ejAzNWFxMi9yOHB6YitWN2Z5RDUyQnNDbG1nYU56Rk1iWEVHZ1pTcVdxNmQ3?=
 =?utf-8?B?TFkvVWdlejZaeHNXQ1FqWU9ibDc4aFNZaThJYjFWbGxBSFNqbjVSOHpxbUky?=
 =?utf-8?B?b1dzaHg4R0F5RTJackQrMG5Bd2lHNlFFWXNKOHNSVzcrVG9IWTdub2VSMVE3?=
 =?utf-8?B?dmIwb2ZzYlJjTTJWSE1Qd2poR0NwREdQOXFnNURBc0xFNm5ibmc2S3YyckVP?=
 =?utf-8?B?b2NYQk5CQ1ZJc2Q5K255K0MxQndaQjZYNDNTdytQOXdkSStVWEVwZ3ozdStO?=
 =?utf-8?B?U2ZmSFdVam5YMFViMjRHbFozZlZXSldVNkk2ZlBuN3pxVlJVQllvZEZKZldV?=
 =?utf-8?Q?O8uN2z8nncYz2QUg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aded85-edf3-4c81-310a-08de41595748
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:55:10.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45BjpFujQHHdCdsEzvBWlPc0RTvm7mV5s+Hjm5q36/5k6o/qay20A1aDy6K2z4aQkOZuhNdbyNPCW86gaYwktq7tfG0P4M0YIii2mYKHE2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Dec 2025 20:29:54 +0000

> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
> 
> v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina@google.com/
> - Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
> - Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
>   (AI)
> 
> v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
> - Fixed alphabetical ordering
> - Use the xdp desc type instead of virtchnl one (required some added
>   helpers)
> 
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/xdp.h | 22 ++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index 958d16f87424..0916d201bf98 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "idpf.h"
> +#include "idpf_ptp.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
>  #include "xsk.h"
> @@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  				    pt);
>  }
>  
> +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
> +	struct idpf_xdp_rx_desc desc __uninitialized;
> +	const struct idpf_rx_queue *rxq;
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> +
> +	if (!idpf_queue_has(PTP, rxq))
> +		return -ENODATA;
> +
> +	idpf_xdp_get_qw1(&desc, xdp->desc);
> +
> +	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return -ENODATA;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	idpf_xdp_get_qw3(&desc, xdp->desc);
> +
> +	ts_high = idpf_xdp_rx_ts_high(&desc);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*timestamp = ts_ns;
> +	return 0;
> +}
> +
>  static const struct xdp_metadata_ops idpf_xdpmo = {
>  	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
> +	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
>  };
>  
>  void idpf_xdp_set_features(const struct idpf_vport *vport)
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index 479f5ef3c604..9daae445bde4 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
>  	aligned_u64		qw1;
>  #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
>  #define IDPF_XDP_RX_EOP		BIT_ULL(1)
> +#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
>  
>  	aligned_u64		qw2;
>  #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
>  
>  	aligned_u64		qw3;
> +#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
>  } __aligned(4 * sizeof(u64));
>  static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>  	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
> @@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>  #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
>  #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
>  #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
> +#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
> +#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
>  
>  static inline void
>  idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
> @@ -149,7 +153,10 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
>  	desc->qw1 = ((const typeof(desc))rxd)->qw1;
>  #else
>  	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
> -		    rxd->status_err0_qw1;
> +			((u64)rxd->ts_low << 24) |
> +			((u64)rxd->fflags1 << 16) |
> +			((u64)rxd->status_err1 << 8) |

I'm not sure you need casts to u64 here. Pls rebuild without them and
check the objdiff / compiler warnings.
It's required for buf_id as we shift by 32.

> +			rxd->status_err0_qw1;

Why did you replace the proper indentation with two tabs in all 4 lines
above?

Even though...

>  #endif
>  }
>  
> @@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
>  #endif
>  }
>  
> +static inline void
> +idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
> +		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
> +{
> +#ifdef __LIBETH_WORD_ACCESS
> +	desc->qw3 = ((const typeof(desc))rxd)->qw3;
> +#else
> +	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
> +		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
> +		    le16_to_cpu(rxd->l2tag1);

...here you use the correct one.

> +#endif
> +}
> +
>  void idpf_xdp_set_features(const struct idpf_vport *vport);
>  
>  int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
> 
> base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131

Thanks,
Olek

