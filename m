Return-Path: <bpf+bounces-66588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A22B372D1
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F371BA5A80
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446D350855;
	Tue, 26 Aug 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFOTLO+3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AD281504;
	Tue, 26 Aug 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235056; cv=fail; b=dwYGqmAuuxuvGgifljzBkyUVlJYnz5onh7XGv7vtEN7gZdvNR1tz1Vfxil8nqD+CH9WSeRVX+Zfp6TzPaf9oPHQNcNP/0FI4Q2fJ7EXGoCf77+IlUcvcXdIi6rVDJq92zdZUpH9uhhf9wMMoWAfXDY3d347nai+6ekLy17coe0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235056; c=relaxed/simple;
	bh=ipwsQbOX4wpUN5DwCZ2JVCbpRLsCyGOZomvXUnWfMtQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4d2el2QTJU8vg8ixalkY2WQXffjOwbCr+ZeasTImwKKD8JkrRRLNS9PfGX2y120u9nK43bxFqXVO5j9Q0nsfVRrbrdYH3Ut8VKjZ648QtmlCV4CwK8x2PXxex9BO8HyJl+G9GRTtk9wfPBMtbggv80SqwX8fk/uLjkQAxdN3C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFOTLO+3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756235053; x=1787771053;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ipwsQbOX4wpUN5DwCZ2JVCbpRLsCyGOZomvXUnWfMtQ=;
  b=JFOTLO+3VlCJx4L1IWMqOwXdKlJ7dH55QImi8PfyOx+wAzLIMCtYaksg
   QVNC4Qve4KpkQbD4N1W0BqXCCEtnO88fmusgeMpyDoW8WOnTJqfPBi5DA
   BA4ARpWvEoqq/D95uAzn6YuCVXArdsp2NGhimHPtzPljEYoi5UNmskVpQ
   Q4Dt6H6HDoRz7mZfkw2LeqIQfr/sMxSZV0M7rS+1Uaigt1fAn0AgZ3uGd
   I8nOGH0015h/0pcjVWkmcrrbuu/fP/vpcGV1ZPMzuIh2XwQjXAS78ESWm
   lmbtaqUZVNspu+1Oeh25kj/UdusVL3l4p0gxHtSbg3pZfsiobsPHU6HaE
   w==;
X-CSE-ConnectionGUID: yTGJvEtWQ/Cea0v/X05RiQ==
X-CSE-MsgGUID: Kn+oSYE1Sc+LsVrS7EZHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58338716"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58338716"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:03:55 -0700
X-CSE-ConnectionGUID: PAUqDsEhSHeYoXQsFvrU7w==
X-CSE-MsgGUID: sZDM8qv1RZap3GwaiWk6Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169585067"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 12:03:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:03:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 12:03:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 12:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUYwmT4nmvIL6KBwqBPEgO3ydNOf6ohs+7nt/gCtMgLIpXWGq4ladFgjg71d6pWMqoIhFmPrHw1AgoDNIxcmm6YvkXkB2JexOqvRvP5HPCvy1Ds418gX8FRHHcCCEdthV1Mb33ITVvocxSPHlonsZCkQ2T/j871kZy+n+qK3FqHAO+EEytww1YCEV4N5Y1HlFmb1yczLk2Zq5XMJRfj1BN7eerUD4pWjl9HaDnT+vk1b58tfklzfnScLo4dJTmxI0t8IpdBJvqfjCYgc/SjZans9iIezCSifXDd44aoZpKUuknfrJtF0iLbud4KdxPCzsVifJM5Yjrsq48DmKTgEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da+P4Idcq3fTX8eYbQ9BwflOY3V5CNQF9e7Si5gpxT8=;
 b=rWxKcsRciNOJzwlCMCHuzIZMwvWizbrUJLXdLaIPqfavcdBj/e8MNZM7Jf6tdKC7SQn3A3LmgZGfKU9Et3m4S+GPmnJH3ZnPv4pSm1OdGelFnzM5UiAf+3P0g2oAYVSekH8Khj4HvO6mQtg9j1h8AXOK9tefZGxTkY+BWSaikn1pwMStNSjz3m3ioyAq3S8eU0WD7PwLccgmAaiTGiE0tAQtF12NFH0+1tyNcNa8PCD9FC8WC6XQyBbs9S/YkVFTnkUFbwZehamCcTg9vB7Pz29efzwiiSIXQSZzaIC27iU9pM4aNkcoYotX2924zYHtVt6z894GIHTaSKKrvHW6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 19:03:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 19:03:51 +0000
Date: Tue, 26 Aug 2025 21:03:45 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <aleksander.lobakin@intel.com>, Eryk Kubanski
	<e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aK4FEXMHOd2MLqmC@boxer>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
 <CAL+tcoD3Kj6h=RvkEJ_9vmJPWKGVcaLj4ws=JqRbE0TiyjDDWg@mail.gmail.com>
 <CAJ8uoz0v4sdj8YwadpCKpDSpY1JrJnO_kkEfHHyv+qAFMiKOOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ8uoz0v4sdj8YwadpCKpDSpY1JrJnO_kkEfHHyv+qAFMiKOOQ@mail.gmail.com>
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: c2378443-a775-49a7-7b9c-08dde4d34b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHM5RXdzUlpGSE1uNUtoNnVLSWxuUk5wZk91Z2NlOFcvUGJYYVBiWHZ6Vy9K?=
 =?utf-8?B?VXBROFlJRzVyTXNsenRWZjdmbmFlc2p5WWpSQXdyRlBOQnVkN296cGJoK3lU?=
 =?utf-8?B?UTd2S1VDcStPOWpicitVaTlEVUhhUDVDUDlOZnEwZ1A3eENZMFpQNHhtNk5t?=
 =?utf-8?B?QVFKZzVlVGw5N0JRcjF3KzIwb1RYVFFaRHAveFIxVyttWkU3MXkwN0ltcUNI?=
 =?utf-8?B?VHQ3ay9vaElhZEJWU1FaaVY4ekpuS2ZoV2RPczNaTXVaYXJGanRWUk5jcUVx?=
 =?utf-8?B?am5rZDdXRzFhNGlvV1FDNmk5aDBocEtUNE1QTVBkZG5ja0l2RVNSOVR3V01B?=
 =?utf-8?B?YTJIc2kyNGFIemRZTUlXOUlpckxKeXFtVFZ2RDhpbytRWjZnV0ZvTXdZV2Nz?=
 =?utf-8?B?SDVqTjV2M1A5Y2JEQ1Y5cnltUGhqN2Y1emJaWGQxWWxwNk5YVGw5L2VaVzh4?=
 =?utf-8?B?ZHhTOHYyUWNkandVNk1aZFBzT2dCb1JlcHh5T0E5RVRXK0JKRkdvbHdBWXpV?=
 =?utf-8?B?dGVRaG9kcmxuOCszdzlEbEFTNnVsSEdvNlJPZXJ0MUdJN3BOY0dUQ2t1bEJr?=
 =?utf-8?B?MmdsNldXN3RsVWdGRDl1aVBFMUZKWEVsUk5XV0NKbVlCYWFUVFZsMTZiU1dx?=
 =?utf-8?B?cUI0RDEyRndGOWI2T0xzS0hxOU02ZVpYcEhNTGFoT3Jvd0lMUE00OWswWTh4?=
 =?utf-8?B?bWVFM0lBTThkRnVwRzhiblVvUm4vMHIwYlZKQlVUQkxNaGt3ejBmK0lTWnpS?=
 =?utf-8?B?bkxMU0NNZENjWkV4Q1dXZXpQK3cydEZ5R3dCM25wZzB3UGU0K2k5YllESXlV?=
 =?utf-8?B?TkVYVVNsM2J6dEhXajU1RU5SUFpQVE9lVUdVM1Y4aW1aQlI0cmNtS3VvWUVP?=
 =?utf-8?B?OTcvWG4zRi92emV6cDFxVzBDaUdneGI5ZDYzSXJUbDRBbDlCWTdLa2s2M3BG?=
 =?utf-8?B?ZzRjS29vWFQzNjhXTFlIdm02NlBscm42TTd3M0JTRTNzcTJXclRjTUU3OEw4?=
 =?utf-8?B?VTNaMDJLN0lPNENLcUpMNFZ5R0N5VXg0VnpkM09NK29pa21GQmFjK1dDL1I3?=
 =?utf-8?B?VWtyMEhFT3hNZ0xJUjNHRXY0Z25aQ0ZnNkxUd2g5Qk1CTnU2NUlhZU9vdWVO?=
 =?utf-8?B?VTBwV3NDazRFdm02NEhvT1FSRS9lRHFmbVJQcENDWlVQNWE4Qk1tc05HZUF0?=
 =?utf-8?B?RW1sVFdaQ096blBJbnZ4NGxMa2R1Wkh5MkFnUFpKdnhtOFdUV1FNME5BN2cr?=
 =?utf-8?B?UHd4aVNpazVuSmdjdXY5Y2kycXZwUTJvNTNXYzVFL2Z2LzlFY1dMaWFvU2oy?=
 =?utf-8?B?TlFqMitZV05DSTNKUzlQOStRQk1hYk52N2pDaWh5Vzg3ckxEbHBJckt2Rm5C?=
 =?utf-8?B?aTA1UTI1NmgxZkdBemF1V0VwU2xLYXJWSUU5VEQyTUd3SS9NcDhGdSt5b20w?=
 =?utf-8?B?cWRoWmc2THBLRStpdEsvd1loVFZiL1hvajFISUdVZ2VaRUtvMjBLSVNPTC9T?=
 =?utf-8?B?WjRINUc5dVMvTUZWZWJSTGJHeTZxd2tSN3VTRWdMeWo0c3Z4WFJPbUxpckMy?=
 =?utf-8?B?VDBONGlRUjhHZmN0bFg3ajJnT1NPcVZQZXRMd0U5UlRKdTVXK0ozc2pTYnJG?=
 =?utf-8?B?ZXVIV3p3MlRwQVN4MUhBZWJRNlJIWWQ2ZElTb0J4RGNLcmlMMWluUGw4a1NO?=
 =?utf-8?B?UTlEcjV1aTZGMDBlV2RMSlNydVAxNXExRDFWeWlIYjhwMTBBbDROZU9WZGsx?=
 =?utf-8?B?U3RFdGcvWUx3WGk5bDcvc2xsQXdZR3REY0tIN2VDNE4vY1ZOQUEwLzNiZ3Na?=
 =?utf-8?B?TXpWTGtpb01wbDhFc05ET1k4c2w2VWp2YS9lT1ZRdW9ZNE9odDZ0MjZ6TUVB?=
 =?utf-8?B?cWpVN1ZpLy8vTEtvRVN4VDk1ZEdzamtaa1o0VEtkWDFxcVFDZmtSdko2Z0d1?=
 =?utf-8?Q?nI547gRCYuA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1SMUNxd1lVT0dXUzYySzR5ZFBQOWlQOFpLR2Y0VXZUM1hHNDZhT3BNRHM0?=
 =?utf-8?B?d0hhRW5Yb2UrdEVMZFFsbFptY1A5Rkh2d1Fia2NMYkZlOTI5TFpSVXQ4UU1l?=
 =?utf-8?B?YmZLdjFEVnp6cldLK0hyUDd4UWJWeUlUSERZTnBQbzdLMzRWSnJKQWkveWpK?=
 =?utf-8?B?QmgzUGFGR01UbnQwczh4WlQvSzIrSmVqMld5enlONGxqK1JSZmRqUjl6WWx0?=
 =?utf-8?B?eVZQM2I0a3dIYmZjNzF1V09ieDVnZWgva0pvTlJHZ0owT25IcmZqc1FYUnNP?=
 =?utf-8?B?bERSdzg0bWJHdm9tdjFvNDFMczcwbXFNNWtWTjhFMzJLMGxsWElkc3MvL240?=
 =?utf-8?B?c0YwWVBzVWlrbHIrSS8yNFVSMmdNd0lwWS81SXBsTk5JcklHYXZnZGF0UWNR?=
 =?utf-8?B?UkJvNVVHQXZNa3l0SUtQSUJwVmZHMzF3UEVEMGFsNVh3Mjh0RllTQzd0OWl2?=
 =?utf-8?B?RU1hRitIUlJ3eGw3OEs3emJMY21ZcTgxNjRDTVdjcVhQNXkya1NJMExqSUdh?=
 =?utf-8?B?dVMrMFovWVJGNFVFZi9NcHZ5bGl3RTI4ai9LWk5GTU1QTzhtZi9sTjNYcFNp?=
 =?utf-8?B?blhRckZ4OWxyVHlKV1l5QkFpekJmQ3ErbTNqMVJsUWVKUjVWWGUycURIbml2?=
 =?utf-8?B?Unkwbit4ZlN2QzhlSHphaFpGMGZLY3VMRlc3RWNsZkdzaFZqZE9seWhrWks2?=
 =?utf-8?B?bWV2LzM5MURRbWh2OXM0M2RvM0hYRzBPcGN5YjVKMko5emhVdHFpSlVhYmIw?=
 =?utf-8?B?VndKZjB4VkVQcmQ0Vk96QzRTb0JiWVIzZG1wTmlmS1o5MFg2UnRQUURxWE13?=
 =?utf-8?B?RDNkRnIwK2YyNjRDV2FjTVRaZUtDNXUrV0VKVnBOaGw1dTVLLzNDUUdPcXZG?=
 =?utf-8?B?Vk42Wi9aQjllUEovWFJHYTJrNWJQd0pHK1ZLWHdrNlFnb25QYVB1S3B4aEln?=
 =?utf-8?B?OTFDZ3gvN1BwbW0zU3BKUnR1RXE3dDlSbU5NMjAxMEVjbkZZT3crT3E2eHZu?=
 =?utf-8?B?T1VlVXdmS2N2OFE5ZDNHNUMrQmFMc0d0RzlRNFJGVEpaZ3VMcDBzZWdYWVdt?=
 =?utf-8?B?cE14SFhlSUhMaVRnMjIyWmI2UmFha2prTUJ0ei9ZZVlxVHFNMWgxMjZjeHE5?=
 =?utf-8?B?b2NIcC8yUm5SUFp4dmFIbzJFeUVlc0QyVmJjbVhGbk5UTXkyck82V05NdHJN?=
 =?utf-8?B?Q09HT3VXZjBkWFhZcVZIZTRrQWlYMURWS3NUQm9YVzJwZVVCWVJtY3BRU01v?=
 =?utf-8?B?cnRMZ3pHempjeXU4b0lRYzVJRHlDVUxDOUt0NFhnUk1QZEhzOTMvSnhRM3lv?=
 =?utf-8?B?d2hnazZCM3VnNTlSZ1pDQ05xQ1NMWjlCYm83eUNRbERLUkN1OVorcmhUOHQ2?=
 =?utf-8?B?Y05mV3lMTDJPS0g0SlY0T2ltOUlhRVFDc1ZCYVRQOWdLZy9OZ0xYVkIzbFRJ?=
 =?utf-8?B?bFU5bG5FanVkU1lwQmQvSytTaWpFSFJSNlErQ21DcER2eHVtNDdQZWcxMkgw?=
 =?utf-8?B?K0xUbFVtVWg5NmQ3YnhiR082WmVSME81by9Ud1FxM2pWNXBhV1lOME1UbGo4?=
 =?utf-8?B?MGtHc21zQlYvUkxJaElMR2hkYmFwSld6TlYwN3FKV2x1YVNEUWlCTkhBeE9D?=
 =?utf-8?B?b29xcTNPQVB3eStrNUNobVNUdnNmSExpYmlMaW9aRjhXK1J1NmN2TVZyMmNZ?=
 =?utf-8?B?NFZ3THF0b2RiUzVzSGRkMWoxRzAzRlA1YWl3ZVVJUjUxR3FTL2hjTVUwQUZ1?=
 =?utf-8?B?RnFQUE1NRHd1Sm1oNHRlMHl6aWxBeGQyeWNnaXhsZE5sV1VJYkkxc2E2RnAx?=
 =?utf-8?B?ajZpOTRrWnByMHJuUzRYWDdjNDFhQjhkaW1mQWFXa3VIWlpOem8rYktHakZ5?=
 =?utf-8?B?VWw2eU82eDNKR2tUR2huWnUxM3U4Zm9qRlBWZFcxVDdKa2I2Rk52amN3ZUxh?=
 =?utf-8?B?cVdLRWZTek1aSDBmUFh6K0VyUCtzaDdhaXBSdDdYajZ0SGRyZWRieER4VUVB?=
 =?utf-8?B?QU5XTXBCcUc0eHBoaWhSTHQranZPM2MwYjNnUitUTE1hbjZTazFZQ1YxU2RE?=
 =?utf-8?B?Q1BQQUE0R0N6dXBaZCtsaHNuRXo5eldsanFhSEFFejJENzdveFR4QXVKZnhN?=
 =?utf-8?B?dm9aNUh0WlF2SGpHOXNOSEhzMWtLdCtYU1ErYkRHQlFsaVVyS0lWbkpQY0ov?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2378443-a775-49a7-7b9c-08dde4d34b95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:03:51.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlfNYptDPAkFxLtBJz3M4g12gSCagzsW2p+GOH/KqUlR+BvrbyVY+xLa5DdIDg87PmD34MEjkGelRQ6zxp6fCeZnf34BbZCEgQ4craOBvZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com

On Tue, Aug 26, 2025 at 08:23:04PM +0200, Magnus Karlsson wrote:
> On Tue, 26 Aug 2025 at 18:07, Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Wed, Aug 20, 2025 at 11:49 PM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > Eryk reported an issue that I have put under Closes: tag, related to
> > > umem addrs being prematurely produced onto pool's completion queue.
> > > Let us make the skb's destructor responsible for producing all addrs
> > > that given skb used.
> > >
> > > Introduce struct xsk_addrs which will carry descriptor count with array
> > > of addresses taken from processed descriptors that will be carried via
> > > skb_shared_info::destructor_arg. This way we can refer to it within
> > > xsk_destruct_skb(). In order to mitigate the overhead that will be
> > > coming from memory allocations, let us introduce kmem_cache of
> > > xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> > > system.
> > >
> > > Commit from fixes tag introduced the buggy behavior, it was not broken
> > > from day 1, but rather when xsk multi-buffer got introduced.
> > >
> > > Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> > > Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> > > Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> > > Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >
> > > v1:
> > > https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> > > v2:
> > > https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> > > v3:
> > > https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> > > v4:
> > > https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> > > v5:
> > > https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> > >
> > > v1->v2:
> > > * store addrs in array carried via destructor_arg instead having them
> > >   stored in skb headroom; cleaner and less hacky approach;
> > > v2->v3:
> > > * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> > > * set err when xsk_addrs allocation fails (Dan)
> > > * change xsk_addrs layout to avoid holes
> > > * free xsk_addrs on error path
> > > * rebase
> > > v3->v4:
> > > * have kmem_cache as percpu vars
> > > * don't drop unnecessary braces (unrelated) (Stan)
> > > * use idx + i in xskq_prod_write_addr (Stan)
> > > * alloc kmem_cache on bind (Stan)
> > > * keep num_descs as first member in xsk_addrs (Magnus)
> > > * add ack from Magnus
> > > v4->v5:
> > > * have a single kmem_cache per xsk subsystem (Stan)
> > > v5->v6:
> > > * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
> > >   (Stan)
> > > * unregister netdev notifier if creating kmem_cache fails (Stan)
> > >
> > > ---
> > >  net/xdp/xsk.c       | 95 +++++++++++++++++++++++++++++++++++++--------
> > >  net/xdp/xsk_queue.h | 12 ++++++
> > >  2 files changed, 91 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 9c3acecc14b1..989d5ffb4273 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -36,6 +36,13 @@
> > >  #define TX_BATCH_SIZE 32
> > >  #define MAX_PER_SOCKET_BUDGET 32
> > >
> > > +struct xsk_addrs {
> > > +       u32 num_descs;
> > > +       u64 addrs[MAX_SKB_FRAGS + 1];
> > > +};
> > > +
> > > +static struct kmem_cache *xsk_tx_generic_cache;
> >
> > IMHO, adding a few heavy operations of allocating and freeing from
> > cache in the hot path is not a good choice. What I've been trying so
> > hard lately is to minimize the times of manipulating memory as much as
> > possible :( Memory hotspot can be easily captured by perf.
> >
> > We might provide an new option in setsockopt() to let users
> > specifically support this use case since it does harm to normal cases?
> 
> Agree with you that we should not harm the normal case here. Instead
> of introducing a setsockopt, how about we detect the case when this
> can happen in the code? If I remember correctly, it can only occur in
> the XDP_SHARED_UMEM mode were the xsk pool is shared between
> processes. If this can be tested (by introducing a new bit in the xsk
> pool if that is necessary), we could have two potential skb
> destructors: the old one for the "normal" case and the new one with
> the list of addresses to complete (using the expensive allocations and
> deallocations) when it is strictly required i.e., when the xsk pool is
> shared. Maciej, you are more in to the details of this, so what do you
> think? Would something like this be a potential path forward?

Meh, i was focused on 9k mtu impact, it was about 5% on my machine but now
i checked small packets and indeed i see 12-14% perf regression.

I'll look into this so Daniel, for now let's drop this unfortunate
patch...

> 
> >
> > > +
> > >  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >  {
> > >         if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > > @@ -532,25 +539,39 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
> > >         return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
> > >  }
> > >
> > > -static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
> > > +static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >  {
> > >         unsigned long flags;
> > >         int ret;
> > >
> > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > -       ret = xskq_prod_reserve_addr(pool->cq, addr);
> > > +       ret = xskq_prod_reserve(pool->cq);
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >
> > >         return ret;
> > >  }
> > >
> > > -static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
> > > +static void xsk_cq_submit_addr_locked(struct xdp_sock *xs,
> > > +                                     struct sk_buff *skb)
> > >  {
> > > +       struct xsk_buff_pool *pool = xs->pool;
> > > +       struct xsk_addrs *xsk_addrs;
> > >         unsigned long flags;
> > > +       u32 num_desc, i;
> > > +       u32 idx;
> > > +
> > > +       xsk_addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +       num_desc = xsk_addrs->num_descs;
> > >
> > >         spin_lock_irqsave(&pool->cq_lock, flags);
> > > -       xskq_prod_submit_n(pool->cq, n);
> > > +       idx = xskq_get_prod(pool->cq);
> > > +
> > > +       for (i = 0; i < num_desc; i++)
> > > +               xskq_prod_write_addr(pool->cq, idx + i, xsk_addrs->addrs[i]);
> > > +       xskq_prod_submit_n(pool->cq, num_desc);
> > > +
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > > +       kmem_cache_free(xsk_tx_generic_cache, xsk_addrs);
> > >  }
> > >
> > >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > > @@ -562,11 +583,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > >         spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >  }
> > >
> > > -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > > -{
> > > -       return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
> > > -}
> > > -
> > >  static void xsk_destruct_skb(struct sk_buff *skb)
> > >  {
> > >         struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > > @@ -576,21 +592,37 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> > >                 *compl->tx_timestamp = ktime_get_tai_fast_ns();
> > >         }
> > >
> > > -       xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
> > > +       xsk_cq_submit_addr_locked(xdp_sk(skb->sk), skb);
> > >         sock_wfree(skb);
> > >  }
> > >
> > > -static void xsk_set_destructor_arg(struct sk_buff *skb)
> > > +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >  {
> > > -       long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
> > > +       struct xsk_addrs *addrs;
> > >
> > > -       skb_shinfo(skb)->destructor_arg = (void *)num;
> > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +       return addrs->num_descs;
> > > +}
> > > +
> > > +static void xsk_set_destructor_arg(struct sk_buff *skb, struct xsk_addrs *addrs)
> > > +{
> > > +       skb_shinfo(skb)->destructor_arg = (void *)addrs;
> > > +}
> > > +
> > > +static void xsk_inc_skb_descs(struct sk_buff *skb)
> > > +{
> > > +       struct xsk_addrs *addrs;
> > > +
> > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +       addrs->num_descs++;
> > >  }
> > >
> > >  static void xsk_consume_skb(struct sk_buff *skb)
> > >  {
> > >         struct xdp_sock *xs = xdp_sk(skb->sk);
> > >
> > > +       kmem_cache_free(xsk_tx_generic_cache,
> > > +                       (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg);
> >
> > Replying to Daniel here: when EOVERFLOW occurs, it will finally go to
> > above function and clear the allocated memory and skb.
> >
> > >         skb->destructor = sock_wfree;
> > >         xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
> > >         /* Free skb without triggering the perf drop trace */
> > > @@ -609,6 +641,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >  {
> > >         struct xsk_buff_pool *pool = xs->pool;
> > >         u32 hr, len, ts, offset, copy, copied;
> > > +       struct xsk_addrs *addrs = NULL;
> >
> > nit: no need to set to "NULL" at the begining.
> >
> > >         struct sk_buff *skb = xs->skb;
> > >         struct page *page;
> > >         void *buffer;
> > > @@ -623,6 +656,14 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >                         return ERR_PTR(err);
> > >
> > >                 skb_reserve(skb, hr);
> > > +
> > > +               addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > +               if (!addrs) {
> > > +                       kfree(skb);
> > > +                       return ERR_PTR(-ENOMEM);
> > > +               }
> > > +
> > > +               xsk_set_destructor_arg(skb, addrs);
> > >         }
> > >
> > >         addr = desc->addr;
> > > @@ -662,6 +703,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  {
> > >         struct xsk_tx_metadata *meta = NULL;
> > >         struct net_device *dev = xs->dev;
> > > +       struct xsk_addrs *addrs = NULL;
> > >         struct sk_buff *skb = xs->skb;
> > >         bool first_frag = false;
> > >         int err;
> > > @@ -694,6 +736,15 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >                         err = skb_store_bits(skb, 0, buffer, len);
> > >                         if (unlikely(err))
> > >                                 goto free_err;
> > > +
> > > +                       addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > +                       if (!addrs) {
> > > +                               err = -ENOMEM;
> > > +                               goto free_err;
> > > +                       }
> > > +
> > > +                       xsk_set_destructor_arg(skb, addrs);
> > > +
> > >                 } else {
> > >                         int nr_frags = skb_shinfo(skb)->nr_frags;
> > >                         struct page *page;
> > > @@ -759,7 +810,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >         skb->mark = READ_ONCE(xs->sk.sk_mark);
> > >         skb->destructor = xsk_destruct_skb;
> > >         xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> > > -       xsk_set_destructor_arg(skb);
> > > +
> > > +       addrs = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > > +       addrs->addrs[addrs->num_descs++] = desc->addr;
> > >
> > >         return skb;
> > >
> > > @@ -769,7 +822,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >
> > >         if (err == -EOVERFLOW) {
> > >                 /* Drop the packet */
> > > -               xsk_set_destructor_arg(xs->skb);
> > > +               xsk_inc_skb_descs(xs->skb);
> > >                 xsk_drop_skb(xs->skb);
> > >                 xskq_cons_release(xs->tx);
> > >         } else {
> > > @@ -812,7 +865,7 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >                  * if there is space in it. This avoids having to implement
> > >                  * any buffering in the Tx path.
> > >                  */
> > > -               err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > > +               err = xsk_cq_reserve_locked(xs->pool);
> > >                 if (err) {
> > >                         err = -EAGAIN;
> > >                         goto out;
> > > @@ -1815,8 +1868,18 @@ static int __init xsk_init(void)
> > >         if (err)
> > >                 goto out_pernet;
> > >
> > > +       xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > > +                                                sizeof(struct xsk_addrs), 0,
> > > +                                                SLAB_HWCACHE_ALIGN, NULL);
> > > +       if (!xsk_tx_generic_cache) {
> > > +               err = -ENOMEM;
> > > +               goto out_unreg_notif;
> > > +       }
> > > +
> > >         return 0;
> > >
> > > +out_unreg_notif:
> > > +       unregister_netdevice_notifier(&xsk_netdev_notifier);
> > >  out_pernet:
> > >         unregister_pernet_subsys(&xsk_net_ops);
> > >  out_sk:
> > > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > > index 46d87e961ad6..f16f390370dc 100644
> > > --- a/net/xdp/xsk_queue.h
> > > +++ b/net/xdp/xsk_queue.h
> > > @@ -344,6 +344,11 @@ static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
> > >
> > >  /* Functions for producers */
> > >
> > > +static inline u32 xskq_get_prod(struct xsk_queue *q)
> > > +{
> > > +       return READ_ONCE(q->ring->producer);
> > > +}
> > > +
> > >  static inline u32 xskq_prod_nb_free(struct xsk_queue *q, u32 max)
> > >  {
> > >         u32 free_entries = q->nentries - (q->cached_prod - q->cached_cons);
> > > @@ -390,6 +395,13 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
> > >         return 0;
> > >  }
> > >
> > > +static inline void xskq_prod_write_addr(struct xsk_queue *q, u32 idx, u64 addr)
> > > +{
> > > +       struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
> > > +
> > > +       ring->desc[idx & q->ring_mask] = addr;
> > > +}
> > > +
> > >  static inline void xskq_prod_write_addr_batch(struct xsk_queue *q, struct xdp_desc *descs,
> > >                                               u32 nb_entries)
> > >  {
> > > --
> > > 2.34.1
> > >
> > >
> >

