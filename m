Return-Path: <bpf+bounces-51258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B824FA3285E
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB21A167C71
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D621018C;
	Wed, 12 Feb 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdiuqqNr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08492063CD;
	Wed, 12 Feb 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370445; cv=fail; b=i/Xd7hMO3dhm3ASDbwzbeCnuNlzpX4Xn+PQ4Kx2+41WlzNHNR4qLsD4ZcwOkxwM2jkX6MFVAI8gR/DwY9nS9Sy0w2JWtIE6CSXua9e4K4ktoqGIYq0cr3v/8VTU7s2IGUQXgcHN9aXUMFlcQXjl2MSPNXYzTPwFalDJNzkWqA7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370445; c=relaxed/simple;
	bh=v9M4FMXl32DEzCvj5By3fcXxLDPkpD1NBs7TorKjjVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRnHToRtk+VkPlrahQ8oRh2lCSZ71NsuY7SZwki8c0Wgvqml2gzlItSaqeBTI+PHHXZQQp2qYNkpXNKvr1ZspCjPQderXcNytfJnZsQvlW4vxDnx9So25m2bmWULMcFrR0KAKDClbXJZimjjQYJPfHTtmaqioX8HtH6y7/ocxMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdiuqqNr; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739370444; x=1770906444;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v9M4FMXl32DEzCvj5By3fcXxLDPkpD1NBs7TorKjjVU=;
  b=GdiuqqNrR1O78Kk+CPIgzFeh8eZAVs008bveu1JeZavb89tjxQY2S4XW
   DHJoqxhMlN/ZRqpRWh+YCPCZgAtC8v+jPcpTDXJGBhD4neJ9cN+Lk09YO
   6CVfPloXY59sGyWc4pxGgU90HiLY2gJGANcCkKJfzIifc+Ah9W0R5i0JG
   jUDWFpdlei9TpK5gY67BXDKuSfHg1No+5nRQx8AvTkjBa5GxqQvDUFsdE
   VHrW2t4jE6RKsl5RTWqmV95giDTb1asBEZeyXjIO8HYbtp7RYBSJFAucw
   M/8PIhZ4mSrOyKgcDAUzvWkS1GZXfsxCtWB/wFZkJ0e3TK1qiVRZTtJ1k
   g==;
X-CSE-ConnectionGUID: XG7+9T0fT+G3EfocQ+nWew==
X-CSE-MsgGUID: 4h3UqSQvTISNMu8StxyGkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57560287"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="57560287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:27:23 -0800
X-CSE-ConnectionGUID: HEmhf0NJSxq8iqN6tma2Ig==
X-CSE-MsgGUID: J1miuQT+QgOLYFhM2MY9Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="143689616"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 06:27:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 06:27:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 06:27:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 06:27:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE+K3BkKMo9dmw7nmFUuQC8hJeijY+uDozUyN8yNd3bGj6iuzZuMxH+Epg+KoXmJ1/hCbSr5EAZzyTqSW96UzZxWzxdI2OEJD/zrd58V2T1eupkikB1KfN2Ww3TGLFoU8J6ZBGh+rX/Lhhupx9PAtzuwJQF03gPfxiPYzDkfNo04N2o6j7El6rHBpz8uUqWe/COGdfvm742g1jKQU5ZYOdRR+fj7YU2Rjhn02ELiJSNXDBLlgyEf+o69UrTj9qJf4wcSGj5J0C8MVhvU1esk7sRHoyjVgTvcZwt/fX9LUy/60HDZu+ra8BiHC13kdo4OPq5B4vNGi2VKt/nCzBtxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i5IDY5yKRMmwxzUcsdcjtu1d7X+ri9xKJk1CGKkPoM=;
 b=j6BNUeOHH8u2uyd+yHP57qKdcx3v9ed+0sX3xrQ0K46Qg3rfGE1FPt/8RXY732DCxsQ6jiLYHrW+AL9DGagYvYjYlAX1tMv8GvdZNIRjRDLGwb9gi2/JDuhtLADTp47xmqzhdi1HhZrP33kO5+DcPtgWI7Wg8zD+NGVr0XSwIlmJed4pl5rm8vbcNSfcHqWMx3TUUJ6A/n5j1dcuSoi8uOWA3hhezYsMhErc4m0bLyFNCjfBcd0vi6yJcjKwzNPwEghofP+cgtcXkyaIutBVGkPEEN63Q5Ei0jhXBrELBmbKR1BlSu0QNSw7JbDeJDDTAwbhejdzfcuK0kmvGCLIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 14:27:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:27:05 +0000
Message-ID: <0a8aac38-a221-4046-8c8a-a019602e25dc@intel.com>
Date: Wed, 12 Feb 2025 15:22:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
 <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
 <7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
 <20250210163529.1ba7360a@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250210163529.1ba7360a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0067.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY5PR11MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: aa858b3b-d91b-4050-915b-08dd4b715318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEZUWHVKRnd4VUJBNG5YU2VCLzd4aElRRmtzeXZUcDRUSEsyME5vY1hRaHYx?=
 =?utf-8?B?bUdWYk9SVHpIRkJWMXBNZ2xCa2RXc0xtZFE5MHE0NnBOR0xzdURsVzBrQnZY?=
 =?utf-8?B?SVFGN2J0aHNqL1BCTTEyZUFYMFdHMkJ0Nnc1eGFsdzcvSDN3bUxSdWNJNlVv?=
 =?utf-8?B?VjU2VEs2ZVNmQjFoR2hNYUo1YUN0ekJkREdKVkRFV0RhZ1l5SU5mNE5iaUtG?=
 =?utf-8?B?Y09FUGlMMkhYU0xOVFB4dlFZTjJVRm9yd1BhaE04WGVtTW9OcVRsNm8yN0dy?=
 =?utf-8?B?YmgvMWxGaGJlT3RjY0lkSytSOGZzellUZGpMQ0xjMHc0ZkxacU9ya2RBU09q?=
 =?utf-8?B?dEx5U3BtamVXOXl5WmV2ZWhLeW4rcEhzSzcrZ3E0VWdFOGxZenl3V2xOK2Rx?=
 =?utf-8?B?MCthMEtjZ2dLelRvaitYZjN6SDdLOFFvR2RvUmVLTWRvdDVxenZzdGxGc2xH?=
 =?utf-8?B?MHB1aGRuY1IyTGpNNE9hVTZqaWVtVlRUM3VRdExPU24vY3E4am9WV2E0UUh3?=
 =?utf-8?B?aWc2TTlNQUlkMTI2bjAzK2MxbDdiSHRZQW9kbGttUS9SS1ZFWGczQnVyaE9N?=
 =?utf-8?B?YWFGYjNVK0VncjVrM1dQdWRMOWxqS3YvYUdZVVhKUDZNclFVWFphVFZmc3RV?=
 =?utf-8?B?REZlbjhjOS9FWTBPOUdFZmhhV3I2RmorZ1FOeFVUSjRIbTdraVI1aUtONTh0?=
 =?utf-8?B?bUZyOXZpeXhaazlkV3BJZ3dSK0Jxejg4c0ZYdGZFR1JTdGczNm5SWHpEUjlw?=
 =?utf-8?B?RjliRFhvMWNZMHJYWStBMXlFclVteCtYakFFeTJwSHg0cmc1MUR5YnRMdVU0?=
 =?utf-8?B?eld1V3NTMWt0SEp3eFFlbFg1QUVLdUl6Rm95WVBEN2YwRmtDQndBKyt4ZUs4?=
 =?utf-8?B?bWJGalhjZVlqKzlHR2RIZllpV3JGSHNtUnNSWEFTaU5kbWg0N2V4eENUNmpL?=
 =?utf-8?B?YWlwWVFLMmMvZW5zVStlODJONU9yWU5BQjlKNEdsNGhoVFBVMS9uQXFnNjhl?=
 =?utf-8?B?Sk1icWxCSittWk90V3JmMHJSS3NiUWZVMHRuNzR4ZmtnNUh3YW1raURUdDh6?=
 =?utf-8?B?T05IUlNKUEN0MFRpcklrRkdCYnBMWUxXQml1aXBCS0FXWDEzcU9nZzRkVHZN?=
 =?utf-8?B?MmhOS0lOaTlNZ2tlS0ZWYWJWVGtlaW1oZG1PbFJkUUZEM29MZ0FycDc3M1JW?=
 =?utf-8?B?QjJwNWF6UXJPVm5qMW1wTlh3aHRLQ2o1ZlZqM3hnUUErVHB4VjQ5V3NNNXQy?=
 =?utf-8?B?cTBSaVFsQzNHazlVdEY5cTIvYnNGNXVjYTg2M3NqWU95dGxWTnZ2a1NLdkVa?=
 =?utf-8?B?SWQ0T0NmL0hUT2xFNzQ1TzRQMFoxYTVNT3djTnBTN0J3Vk15eTN2alBRN0tT?=
 =?utf-8?B?QWtCMG9hcnB2UVMwQmlvY1Fjd2RlNVY3Z2FxRGVFc3J3Uy96a29SZTBVS1ZE?=
 =?utf-8?B?TlA1WXkvRjJYV3VSWm15ODVxbWo4U3hxdVVpRnBXWWcwcUVITlMzdmExekNu?=
 =?utf-8?B?bEI4YmFGckp0U2lMNWhwZlNLbEhEcUtkaitFcWhXZFVKRUFkOExla3lFempP?=
 =?utf-8?B?RHpmU0djNVdxdnBwQ1dqazRha2pPMkQrTnNvaDFJMlV1OHQ3UzVKRWNlZkMx?=
 =?utf-8?B?YXhXRnRwVktGV3lubS9EOWZFNmo4VFJUR3dGdW5vNUpjTDFHZXhVZkVYZTcw?=
 =?utf-8?B?dVU5cGt0N0hNSTFLUjdkZEhkQlptV21yUVBKR21FQWdRc0FBSERMZ29jaTFQ?=
 =?utf-8?B?Y0R4ZnZ0OWp6SVA4TXh3TFM5MExuSU9SZng4SzZjdlpMcHFMT0dEMEdXY3ZO?=
 =?utf-8?B?WXFNNkhSbUt3aEw2V0dCRkU4WHZRUEE1dGI0U2IvMFp5bU04YnVqcVQ0Wlly?=
 =?utf-8?Q?obFUd+cj8WoUU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpITk1YK2ZCWXdxQ3h6cVE0MHdtb0o3eXQ1N0xvTWRmeTYxNk5KRjJTMmdy?=
 =?utf-8?B?eDFVTUUwbkp5Sklld3ZGYUpSTHREZkRyQ1NZczJXc1k5T3pmV0R4MmkrTW1V?=
 =?utf-8?B?ME4zNVEwVkIvRHZTQTE4SXVsdi93WkNueFF1M3cwY05GakpEZkpKdWdockVV?=
 =?utf-8?B?NkNFYU9sT09wN0NFRDdIbmpPenBlU3BOU2lYM3E0RVFzamdJWmlZUHQ0NVFN?=
 =?utf-8?B?S2VGdUtQcmFxQTZ2NVQ1L0FISzRJanBDZDRPN2IzYndzdXRSZVJpdDVlRitp?=
 =?utf-8?B?MjQ1WFlrMW1URm93N0xtMm1yNGMvdURnbWJxWVQ1RVVRR2k4WU1xNTRYcGJu?=
 =?utf-8?B?M09MaHpjcXdHSDI0NGZNT3NCeSt6Ui9jSG9nQytkeHJxREg4bzBaTTRGYlBQ?=
 =?utf-8?B?Mmgxb29HTGJuYmNhN1ZLYTdUcC9NZUNxRGtvQmVkV1JRTTJJK3RBeGlramJh?=
 =?utf-8?B?b05iQVdIakIwd1p4Z0JxdWE5R2VaNWpSN2NSR3VSbDlFMVovMDFsTVV2N0Ji?=
 =?utf-8?B?czNDSy84L3pPSnIxNWorU2IvNUJ3Qnc2RXgyMnY4MTRFRy9JVC9nZ2plTWha?=
 =?utf-8?B?c1pYOFBjVzRzNWRTZHIwV1BENlNRVU1JUW5YL2o4NFFGbDRMZm5WZHowRFEy?=
 =?utf-8?B?TWVZL1VSRzZkeG5NRWplc3JlQ2Jyd2pXZEpDVUl3Q2VyM1lpcDc0MHdtZ1dw?=
 =?utf-8?B?eloybndLWFhqZFViamRoREJZY3ZjYjBaaFRUTTdUQ1FRVmZnLzFrUit2MkxO?=
 =?utf-8?B?OVM1bFNLbG40RGhIcHZOc1N6c0tNUEl2SSt2cWU3R3R4VHd3RGcrelpxR0tK?=
 =?utf-8?B?aTlGaEcxNm1xLzByM0dNOGFVOGR0amkrN3Npai9XMFE3QUhRbHFEbmY5Tm9N?=
 =?utf-8?B?SHY1bmJjaEpiVHA1cTVGQTVIbDFZL241VHI2OWh6dUk5UmsrMFdCM3ZJemw4?=
 =?utf-8?B?QmFEU1EwaXM4TTdzd2VtcjdmdkRYNmJtcDNBZ2FKWjhvRzJxWHUzdG9vaXRM?=
 =?utf-8?B?WTVScTF2dUhZTSsrNDY2TE1IbU8yM3FyRG9aK1lIUW11a0lmTndhVHllQ0tj?=
 =?utf-8?B?ZWQvdmFJcTFQT1FCZTBLcUdzQXRlazROcHNBdFZSL0t1dlRoaXBRQi8rM0hB?=
 =?utf-8?B?Y0UrVmFjbndaOXdPeW1PU2p5TXhxOEI3OHJpQ1VyUEk5NWdwSWk1RWV4SDRN?=
 =?utf-8?B?dzlNSDlLU1dtcmRud2lWYk93Umswd0dBZEg2UFhKcE8vVEFIeS9rR2FaU3lC?=
 =?utf-8?B?c05MM2EveUZCL21OdkwxMnhROUdhRFhZTk5PV1BxUWR1NTNvM1dOYmRMMmlR?=
 =?utf-8?B?V0RHOXRCVWZXSkVFaFR0aEhhemZFeTRETDdMUzQyc3pkY211SkY1N0kwZTJo?=
 =?utf-8?B?ZXp5dW56bDRXcCtHeEw4LzRsaDBCTnA5TjZuWTUvSE1GNTdmekNBZkl6TTZU?=
 =?utf-8?B?ZURUMDMzak1FZkV3OEdOZWFwMHdYSXdabnpKblRHL2taNi9tUUJudDVqdzNs?=
 =?utf-8?B?azl6dXNZVGZFOUthQ3J1QWpGU0ZzaENxNHFweTF0SHJkUGpFZUNkVDA0aWQ5?=
 =?utf-8?B?cWd0TjRaOWRSdjBWOCs1QXJxUGJDc2swbHg5WkpraWppM0xZTUs2T2MxMzBS?=
 =?utf-8?B?OFhnQUtyTkhZN1IwR1M0dTdaOTIraHlkNDRxTHlGN3owcXdUZTBkaDAydGJn?=
 =?utf-8?B?VHJoNlVYaVdmTlRyNlhpT282L0lIZy9aWWlUMlF4VFp1T2ErckVrRkR2MEV4?=
 =?utf-8?B?cVNkbmZLbU53ZXBCNi91RlFLcjZ0di8rZnMwT2tQU2hFQWZQMHZ3d0pJZkFa?=
 =?utf-8?B?UkNIWDd2LzdRSGEvcVErcWVxd3NramNyeVZVNmZpVm1IVnRKN21idllqbTBJ?=
 =?utf-8?B?c3BjSmZjVGp6dkcwZ3JpWmI2a0VRTW9PdmJRcVVpZUN1dHZnWHNiRlZTcUVL?=
 =?utf-8?B?eUFWRjhhNHZTNWxOYWtSdEZPcGRWS1NWK0JNd0JmVDhwa2JsNElzbUVOaDg1?=
 =?utf-8?B?TW1VOUdJT1FwOVFhcHVObm0rWkZsbVdHVWh6R3l5Ymp0Qy9pY2xtMTlqMW9z?=
 =?utf-8?B?d01xK0NHZzNYbWl0QTNVSnl3U1h4S1RLK1cxbEJMUU1IS0JQekxnaXhEMVdL?=
 =?utf-8?B?NndmOTlzcnBHTE45azd2MkwxY01jak1oakdPYmJKZmJMQzNHdXRRSXJ6RHFj?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa858b3b-d91b-4050-915b-08dd4b715318
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:27:05.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtwTsl7cTxIP4w9/YRDClyeTGzw4QE9EZCXWt2hSyOnZE5DNTz36YMFgEDCmwtz7fRRpq58gOFRxDH8a4QDm5OVLcY/NTLjCnrLO9PBN3bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 10 Feb 2025 16:35:29 -0800

> On Mon, 10 Feb 2025 16:31:52 +0100 Alexander Lobakin wrote:
>> This was rejected by Kuba in v2.
>> He didn't like to have napi_id two times within napi_struct (one inside
>> gro_node, one outside).
> 
> Do you mean:
> 
>   the napi_id in gro sticks out..
> 
> https://lore.kernel.org/netdev/20250113130104.5c2c02e0@kernel.org/ ?
> 
> That's more of a nudge to try harder than a "no". We explored 
> the alternatives, there's no perfect way to layer this. I think 
> Eric's suggestion is probably as clean as we can get.

You mean to cache napi_id in gro_node?

Then we get +8 bytes to sizeof(napi_struct) for little reason... Dunno,
if you really prefer, I can do it that way.

OTOH you gave Acked-by on struct_group(), then Eric appeared and you
took your ack back :D

Thanks,
Olek

