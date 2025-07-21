Return-Path: <bpf+bounces-63961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E2B0CD24
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7146F17CAF7
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457823F403;
	Mon, 21 Jul 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDveeUId"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E00219314;
	Mon, 21 Jul 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135480; cv=fail; b=OZ88esbmJcJuMjsEQmg2r4hw74GYR5Gdlqo2e6lzoRM/Be0F1zyrJv+YZpiJOjHC2LZh55rdKsXISpb9D9f1TRll0rMKxwdr2os32ZtEOcm1fr9NTZUNe8Ms+MnPm2xPVw8fKDUSPsGScNRhY5p2zkoOYD/bYK2QZmAESMPJCDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135480; c=relaxed/simple;
	bh=y2P5zPr7Zq9EQo3JgTVfhwNzntah/dOZRl491KrD16s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw+m2oHoxnJ9VnfZviSI+J0v+FNy8CSet2S8GABi/HXSp7oiXCqug4Nuy28AYXFgCR4z2lJE1guYvVgEeZ5l6wBCl3WGajJMFdN7eC507RQjvOyFebTLorNUGyKStcqkX/zs3hL7H5D188fhgrvpn4Kf26kUZ6QipH49fVO+w9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDveeUId; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753135479; x=1784671479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=y2P5zPr7Zq9EQo3JgTVfhwNzntah/dOZRl491KrD16s=;
  b=iDveeUIdW/8U8vkpznqb5RKcu3zr0TNnDVm+QPh8T+2UxqsZ25vcb8u+
   MjeCCEQjPu0QK7YIafQtNO6gKVsAyTb9WJn/LXj/6QrL8GCabgz7bNCbW
   DRRM9MLXqwA64glkl4s7zJQmfCgS4BMdSeOynJf8fSL6q3ltLuhDTByNm
   l/dKX7sI19XU7xgMeiD6W9Q4AMel5vJ0LXrQhMx2PXCOo86+9gfHS3t6t
   /elvSmh76MoAChbGY/YTdHDAX2F4Q440lZxgL27ejvwVOUFwT9X+S5bqc
   aSH/Ee6F6rFivMWLYBXO2Kym4YpPNNuCiRZVNpQP82l5OSQhSwZlz/LeH
   g==;
X-CSE-ConnectionGUID: natOu9shRH2xf/3ngzOwzA==
X-CSE-MsgGUID: yNQwaXsCTtSHfUF6oyZjhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72936506"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="72936506"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:04:37 -0700
X-CSE-ConnectionGUID: yaot9b8QQj2+uuvQb6TDVw==
X-CSE-MsgGUID: EH/a9mXRTG+t5QqRRrubnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="164446099"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 15:04:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 15:04:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 15:04:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.77) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 15:02:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pqq9mQbgAIKIVXVTV3fps8mm4yitjMXz65HBdJ2Ss97PESpvu8swXqM+CV/U7gqz7E8UTAIVwrget9CwZLuffaMzH5IcdvBLrgm9OuyMhsRmzwRMkGvrSP4c0C0jzgoQYkhrSflrPtdmKMbFPP0zeqemL8LLEijKC6w2NBjo7j+261CVoChoTd6sB/2beZF//SmwXfiEf1P4bQurZA+wYO6sLaRfFzpO3+TuDJLOZfbetF+2bvho5pjDodMmKD0pzwVWS1Qea1yF8QzwiYeUEfgrugzfj5cytvFLs1/Z2JF1dnRgha61jNRDN6VtN2WmSYOrGQlxfq/lqDZvfYz9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmGuqWzcX82YYlfSAw8flUYk/Xb892j1Xb61vhUQ9QI=;
 b=RjVh7QK56yh+7Zxu/+HW/CsbXJFerRoR0P4b9EZtRnL5d2E8APZVE56M1MrChKo/s0hmkdXz2O+C+Pv1J5ANnHWspSQOPQwUBt/s5JrTzT7ISLHJOgIA1lKsy7lMJqzgTOv6Gh/IbOgM1BOPIrlOiYZZifXuR47jz2U3jhRfOzo2nSi/GXMxgRV/9XAx9mxf9ButhuNF/OCJwOORXud+UaFZRkDx2j9iNmjBm+WTH2lawWzbn4bUcFKqFZzjR/qyOnXzwkPk87CXxIlschmEWnXDL+b2m/CqaEtu+ZxLIbbYZhb2fSAgfjOYuiHUkcbAdMnduZtoBVk+xtCCLAR2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 22:02:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 22:02:18 +0000
Message-ID: <7b2e97bf-9f9f-46ab-a159-871c2f8debf6@intel.com>
Date: Mon, 21 Jul 2025 15:02:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
To: Meghana Malladi <m-malladi@ti.com>, <namcao@linutronix.de>,
	<sdf@fomichev.me>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250721124918.3347679-1-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250721124918.3347679-1-m-malladi@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------7zqDikH8kRXTwUtWrn8vUWjD"
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f059c3d-6123-4a20-230d-08ddc8a242b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFJmUEhwc09Od0ppcCtWck1JWGkzbXVXN3R6citkdEwyVC9SWk1zNm02UWJV?=
 =?utf-8?B?R0RvRTdYNUQ4emtMcWJySTJLSW5GNkc1WjUvOG95ZnpEQUhQb0lSRXd0M3gz?=
 =?utf-8?B?SUwzRXYxR29ReEM2Ny9QeVJldjFHYmVqZTlWVE1neDFwYVI2dklrS0QzZ09H?=
 =?utf-8?B?MklaQ1BnMzdYTEhsUjFWU0pFZ3dsWVdET3dkTG5HZVRWNDBTaGhzY1duajZY?=
 =?utf-8?B?RDVFS29aZkRFS2RJR0ovZnEzUGs0cjRBTmpnZlBqNXhRck1hMXloQitEc1JK?=
 =?utf-8?B?Wjh2YmpEQzRVc3VJTnJndkIyQzdtTGhHZGZ2SmJueEQ3SWc4WWh2a3FqdG52?=
 =?utf-8?B?S1N3ZCtSOUtMQ0x1SURiK2hWb1NZWEsxTEpwRXZRdGpsNkl0eS85T3NKMmF2?=
 =?utf-8?B?Mis4QW1aNzZ5dGZ6M2RmZVhoNDJXREJMOXFWd2tCNnZuU1M4SS9zeW54c1Uv?=
 =?utf-8?B?RFFVQ200ejNDU2x4eGtmUnB2VnRsN0lURnZiVS9MT08zeDMyQ3BMcG9VOWJl?=
 =?utf-8?B?aTFOWW9TWFErQWt5MCtlNFIwUWd4OEhVSDVVRjV6Q0ZEZUI1RnN6eHZ1SmxW?=
 =?utf-8?B?WXMvUGlnc3FaZFRsU0ZLOCtnWDk3YVFnR1g4emMwSTR5VnE4MkZxYWg0Z0dC?=
 =?utf-8?B?alphL09JUW1PSFlEK0pZeDQxN0xXMHo4VmMvaElsVEdvV2ZoUm85K3RJalRO?=
 =?utf-8?B?bUI2N2pqaEZZNlI5b0pLM25YNnE0TXRsa3M3Nmx2c3VxQ2FVMCtOTzBBemJr?=
 =?utf-8?B?R3l4RmJqUldFaDU2TXMwaUxleHZsdlk5NDlpSTRqMXltcUZqOG9HV0x1TitV?=
 =?utf-8?B?ZUFJd01GSCtPY1dBYy8yZEVWM0VNSUovN3M3VUhvTkxpdkZzWnNlK1l6RHBv?=
 =?utf-8?B?R1pBR0Vwb004Yi84MnczUEpyb0MyZXN2a2NvQUEvenBuYWdCU3NqeE5ocThY?=
 =?utf-8?B?WE5YUEdYZ2JrbzNlMlRZUnJZVFdrK1RTR1VkdUVVMWl6MVdjRGJDOUhxTUxw?=
 =?utf-8?B?U045M3JMaThIa1k2QWUwclRMK2NUR0s3dzU5Y1JpUFZQNTA4RDBZbGpTWUlm?=
 =?utf-8?B?U1pEbEdHdzZ6Tm42NzN4QzJYOTBTSGdhSHNJeEN0WWxpekRFcmZZaXkxUm9E?=
 =?utf-8?B?aWpkdzI2YXh0R1h5UndNUSt5QnlKYk1qbHBhYnI4b1ZrQ1c0RjhwbXd4cWxl?=
 =?utf-8?B?Z2o0dUExOXcwdm5WdTd5NENWcVRQYXhGRDI2TGRXWlhQOFk0c2JiMzlOcWhx?=
 =?utf-8?B?N2liMzJTYkJ5Zk5JSjNZV2V4VkJzZ2FpZWs3d2dMdFNZUVdNcHcwSjVLczRV?=
 =?utf-8?B?d1A4bStDUXpLWE5seU1zc2ovbUlvbnV5elhFR3pQei9NK0NkVGpjaFVCSWlO?=
 =?utf-8?B?QjJLRnU5MEFITm5wTG03T2k0VzJGejJtbWpZV1gxMGU2b3VBZVEzSEplUDJZ?=
 =?utf-8?B?RkVCMStmemVFMi9zSHB0S2xuSmJGa3JkcXJMNkphaUFERjgzYlMyUHFSWWht?=
 =?utf-8?B?YzBwRUl3c3FVVnhLZk9VcWlKeVZjNUhFSDBkK1lQK2xQQmhqRkYzQkhxRWV4?=
 =?utf-8?B?VzZsUWdhZ1JQS29GUW1yWk9rdG1jaExpSitnOUpaOEhBUUJiQzY1M1ZaNjhk?=
 =?utf-8?B?VEV5c0p1LzBsdTZMVXRRN3NiaXpmSFdtb3FyWDlDa0xiM0JGMU4rSy9KM3VE?=
 =?utf-8?B?TGpydUllM0RwR1I4ckdMTGJQQmU4c0FLN0VMUW40RWxNZ0UyaDNTb1RUbkJK?=
 =?utf-8?B?K2NtbXhqdEswN3BwL2Q1SHpKRVQzQUVwaENKQ3YwTHV2VTIzNGlqa21HVU5O?=
 =?utf-8?B?ek00QU9aSTErTERMSVoxWVJKZHBTN2RjSEh3UGVjdmUvUTFjRURNb1NkNDBa?=
 =?utf-8?B?aHAwSkVoejhWWHdqZlY1TzFkSzE0NlYrSURpRExSQXBLRlArRUI4UXk4Szdi?=
 =?utf-8?B?K2hlbmdRWnMzOXlyc1FUNUxvbU1FVktUdmV2VTNMZXo1R3kycTllU1lUTC9z?=
 =?utf-8?B?MVREbzM0OTh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjljdVIzRDZWM2ZYNndqK3VUWWpwZy9qZ3NmNFFOalU4MFJsMVU3OWtDSGNu?=
 =?utf-8?B?Tm5XZDFrenVMRnpVbW9Cak4vMExIcUVOUUdTK0diRFQ1VzU3bEYwUUluUTU2?=
 =?utf-8?B?L3BBU2kwVisvd205L01LVi8za3cwUWJ4a0s4bFkzM1JvUWV4bHVvUG1tT2lu?=
 =?utf-8?B?MnR5cW1LTnNkcFVYaHdRaXJxVWxiYzdBRERIZmF2ZEVVc2k4SHUxcG1IRzVa?=
 =?utf-8?B?TDdRU0JkOUljampydk96T0ZFcFdvZCtlVlM1MW9tVUROOEJpaWY2THBPSWF2?=
 =?utf-8?B?QmFqWVJaU28wNXY4anpCblExbXN6R1hSbHduSnNCUjVDaTJoQTM1Q3QwVDY4?=
 =?utf-8?B?MktPWmZldTNTb09rRmxIajdLdVN4TmkvcHNCclpmTGVBczh2Y1UxM053WndM?=
 =?utf-8?B?WkhlbjVjVXhVaDFDU1k0dCt1cXF4amFERE1DTWNjTUM3TWxZNkJDWWNNQjhr?=
 =?utf-8?B?L0ZUWDlDb0Fwc2N4ZUw2ZlpMUTVyY3Q3bHhQSlk5K1JUMXViU0RLZ3pHWjh0?=
 =?utf-8?B?eFAwVXIxYW90ZmtMVDd3ZDlyU0NiVWRwYmlNd2dVVmVWRVFHeFlZcVVjU0lK?=
 =?utf-8?B?YmppdlU3ektYSHdiMkZveldNUElFd203RFozSmhPdG5zcHNNNStTYWlzUGVl?=
 =?utf-8?B?b0o2MlFwNFlWYW5PZXNXWlhsVzdQVFRvbzZybmtrMDRnTEJWck5iOHU4dTQv?=
 =?utf-8?B?NlB5enpKSVhBRTJMaTJHS0NWUlNQejZiTlo2T3JUeHhOZ3F1SjgyU29PanFq?=
 =?utf-8?B?RGkrN2VNdm1WbHF5SS9hZU5nVEV6QjFtdUVxRmpRWkdaTWVkK1gxMFU1OTNG?=
 =?utf-8?B?VjlwV1ZJZVZFUzRjaE1SMjl0REowTzZZS0E2akltd2MycC84bGYvM0hka2Qx?=
 =?utf-8?B?cENRSEpnaUtSMHZ2WGc3YjRrSjE5ZnEyWHZSajZnYU5SNnlEa05welpCMDdy?=
 =?utf-8?B?blF2ZHhIR3hEUFNrejFma1FTYk5jakY5V29vUnBPTmVlVjRCN2Z6OU5MU3Mr?=
 =?utf-8?B?UWxzaHVkK2I1dllMQ1kxaThPYUtJai8wbGxJQTZreGp3RklqVDRtOUVEcENt?=
 =?utf-8?B?U2IyaTlQZWg3RDluYUFFdU9yT1FGMlFqdGVhVkVOSGVuUHBGc1YrSndDWTFG?=
 =?utf-8?B?M2pGUGNwN0RxYlYrWHFuVnlnZVdRNnNTZTNXK3lXOVE5Q2NtM0RFUm8wYW9j?=
 =?utf-8?B?S2dERTE3cm5PUnRqTStxdmpjWHd5cFdGSVhrUW9XWTBGWDEzN3FPRjRmbjRk?=
 =?utf-8?B?YlV0eUtITnltdG41SktkMGNmWGJuQ3VCTzBXNnF6VjV3U0RNMXBsdGJFQy9L?=
 =?utf-8?B?UFloUmw2ZzBzZGJ0ckROeUhrdzFtOEgyanNJeHEyN2VnMVFTaUQzQWI1cUM1?=
 =?utf-8?B?VjZ6WjVtT2JseGJKMk5jRWorYit6MFg5VHc1YktzRHYzRjhwSFB6dWlDUzc2?=
 =?utf-8?B?UjNKQ1NvT00vTlVRRVU5Ukc1ck41ZGRlK3NiVzFEQjFmY2wwM2d3d0t0QS9R?=
 =?utf-8?B?aVRHcVprNHFSZWJVQ25VMDQ4aWMzTnJleHl5MXpveUpGTjI3Y1BWU1g4VWdJ?=
 =?utf-8?B?WUtkc1czdkJjdDdkcmc0c3JvUnRPbjNaYXFnMW5uQUk4dXdGbkFYZFlzMTVX?=
 =?utf-8?B?YnpFcXFXa09yaEFTdlJRalZJZjNZS0JyWExKTlQxeExiQTNFUyttY29NdmRw?=
 =?utf-8?B?ajkvVzBFR25oTldpS0htY2xYRGhSN2w5YnhQdDd2OGUvN3ZJak0rNUNIWU44?=
 =?utf-8?B?TzdQakFOM3VJOTJjbG1MSjlRWGJBbzVhN3hSQzE5VHFmcXVZdVlWUjgyWDR2?=
 =?utf-8?B?cEI3YVNYK09lZ2Z2aGJXUXRFWnRMQTczbTF3aWVQSVpDdk1iSTB5Qm5lNkRz?=
 =?utf-8?B?T3NxS2RibjRxTFJuVkZEYWpPMys1dXZ5MXEvbXBJOUw4WUFKLytJaWFxOVY1?=
 =?utf-8?B?MFc4WGhseFhTdUI4M25Bd0JPU2pLUEp6UW8ra2dYMWE4UDhaTWZkMzBFSFRp?=
 =?utf-8?B?ZVVEaGNjTUxnZFBWM0U1cldKRDBMdEFFejVldGdzaTY0RkUydHc1cU1oZkdX?=
 =?utf-8?B?eURGdkFoS055MHdadHFRbWhSNnVNUy9kb1ZvTzdqd1VCNm1JMXc4Ylludk55?=
 =?utf-8?B?Qkpja01XQm5HVkZwZjBXbmZYMlNLdFBIL2V5UUVhMFN2U2RSMDBsMm1xZVN6?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f059c3d-6123-4a20-230d-08ddc8a242b9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 22:02:18.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtvYIqeXsSzbyRWMc6pkODLsgkHosFx7JWLu1BE+BEmssFBdcjoA+JJ9pjrrYRydDdfFYhlTcGSuFp7iCRj4LrYy4gNNOCvN1Y8/wxMShZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com

--------------7zqDikH8kRXTwUtWrn8vUWjD
Content-Type: multipart/mixed; boundary="------------WpSAktd0n72fv05PBSKxGKNv";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Meghana Malladi <m-malladi@ti.com>, namcao@linutronix.de,
 sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
Message-ID: <7b2e97bf-9f9f-46ab-a159-871c2f8debf6@intel.com>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix skb handling for XDP_PASS
References: <20250721124918.3347679-1-m-malladi@ti.com>
In-Reply-To: <20250721124918.3347679-1-m-malladi@ti.com>

--------------WpSAktd0n72fv05PBSKxGKNv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 5:49 AM, Meghana Malladi wrote:
> emac_rx_packet() is a common function for handling traffic
> for both xdp and non-xdp use cases. Use common logic for
> handling skb with or without xdp to prevent any incorrect
> packet processing. This patch fixes ping working with
> XDP_PASS for icssg driver.
>=20
> Fixes: 62aa3246f4623 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net=
/ethernet/ti/icssg/icssg_common.c
> index 12f25cec6255..a0e7def33e8e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -757,15 +757,12 @@ static int emac_rx_packet(struct prueth_emac *ema=
c, u32 flow_id, u32 *xdp_state)
>  		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
> =20
>  		*xdp_state =3D emac_run_xdp(emac, &xdp, page, &pkt_len);
> -		if (*xdp_state =3D=3D ICSSG_XDP_PASS)
> -			skb =3D xdp_build_skb_from_buff(&xdp);
> -		else
> +		if (*xdp_state !=3D ICSSG_XDP_PASS)
>  			goto requeue;
> -	} else {
> -		/* prepare skb and send to n/w stack */
> -		skb =3D napi_build_skb(pa, PAGE_SIZE);
>  	}
> =20
> +	/* prepare skb and send to n/w stack */
> +	skb =3D napi_build_skb(pa, PAGE_SIZE);
>  	if (!skb) {
>  		ndev->stats.rx_dropped++;
>  		page_pool_recycle_direct(pool, page);
>=20
> base-commit: 81e0db8e839822b8380ce4716cd564a593ccbfc5

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------WpSAktd0n72fv05PBSKxGKNv--

--------------7zqDikH8kRXTwUtWrn8vUWjD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH646QUDAAAAAAAKCRBqll0+bw8o6H/R
AP0XmcivEfOw5Xa44ET+fBlJqJv1S73PdnEE5qggILnougEAh/DR1Jsyg3Q7M6witx9z1YSsS5O9
54iq48CyysAz7QQ=
=BEAi
-----END PGP SIGNATURE-----

--------------7zqDikH8kRXTwUtWrn8vUWjD--

