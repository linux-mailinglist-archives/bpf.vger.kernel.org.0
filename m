Return-Path: <bpf+bounces-56131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA03A91C1A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C37A3ADBC6
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED324EAAD;
	Thu, 17 Apr 2025 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChFCDvaz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4524BCE8;
	Thu, 17 Apr 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892799; cv=fail; b=M0Wb7KB05kyLRTBwpdktsp/qMbkrKS8tTJ/zX0mguIhnpognNnV1I2LYcXK0+I2xHWQkCXNFmBoFpQLJYBbZybehMkr9bM89xiUV3JyvpeKeG7StlfxAhsFfYsBrGwBNNaRHW56N1WCdcPkfm0YHDOfJNQhgg/lO3YrOgNkpdtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892799; c=relaxed/simple;
	bh=bZG1aDFSSknOpeiX+BR3dma4LMxblV9okFeoSGu3VlY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2FAGwrTUyFq7PLS4ETqxuUnV2i9et85eLpOGZIOrLnDeWEautztb1HJ3tdMoYqMHdUeaSxJas1InHhgb/PbY/Fr6WoIb4wIMXz4X/Rwl2AWj0LZnVYfrd2C//wPoda6sAA/gB1X6sFNcpP1nAmFjqeGtt6n0VmvTeuk+fsC9oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChFCDvaz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744892797; x=1776428797;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bZG1aDFSSknOpeiX+BR3dma4LMxblV9okFeoSGu3VlY=;
  b=ChFCDvazuzWnic96jAQByxFhHK9o5/eGbhLke+SN7DOYE0t68nvi/ST0
   9lpD7+UsGyiRhIFZTk+Yh7xihi370Ws8B+tyNLfJKu+SpabHkq0BJjyih
   JIY/Z+e8d7xPY9Lm6TOHy0SA2rro1ojs6R3Tj1Kxi9saErriLGewlYSe0
   WRQFuq/Z0O8x/rvwisxQYCTYo9u2cYnq7nU0VNK0Kf2nXeTEs8+HR1Wf3
   05kzLEqoXB93rHTmdhKKUnvNSFs9NFnvP1SqTZTEA+MmpzYJGz8xQamX8
   5Gz+meI+LAP040ywwaD2HJWEPv5mo3nnw5Cy4XMGIBMynLEprSo16l5ZI
   A==;
X-CSE-ConnectionGUID: CMli8WOxSjeRr70CNggWhg==
X-CSE-MsgGUID: IRTgaVs4SquIOZ/BdCFirA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57118855"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57118855"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:26:36 -0700
X-CSE-ConnectionGUID: q/1XnIwjTPyI10buwRz4Vg==
X-CSE-MsgGUID: kU6lSEacSba2IZ0Xm9g0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="153971918"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 05:26:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 05:26:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 05:26:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 05:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqaCgppE1tcif9yhzSXGl5kdV8jQiLVfO9c3op+RfQW4622IJM7K+B12jflBBcLtlxPpy84HojCYSuQeupoiAn13xlRhXEf3hNP5O6j/Crb2S8yaeZBjPcU11qEc0U0vgEqlU7gh6RGoNCKGm1TQgFnWjRvSYuC3XB4Cj7XfWstZNyFxGg3hzievD9x5C2V7twrCnPvKrZ8KjOMW75kknHFK/UjgswAljCWi8l8tY/VUsULy0BL7HnCw68fQiWf4RRx6t47BA6RC1DejQdf/ppYgbwMju+Nzjo3vB05EhKjSumQPxKcjJYToT/+jn1Pn4iSCliJfCW3tdSrgLjW+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/vxAFREwLiPa3uK/sBTN3jdTrZANpTuAUTsGXD3nw8=;
 b=Rhq+jUW812h8PgXmGpEflrfheEfNPOxiXIl1ZrEUK/W6yPju/FeHhNoyrIjUff3S505aerM66c+7ZTi/ooia191LCbXidJ8H4H/cJOFeMSrPMGa25S25y6Tovx5HGtrU4VLSVaf0pu+Cw9zw1QnBJn797VQKFZrO53n7yyvP7n9b84FIuoNHwmfuLu9cH2Z5+Thde/tVqLlI6sojFTIrMgsxhx+eru1SwiNY0pRAC4QyEL6zaIf3P6h7htHD1oI6SyfkrDj67lhD7O0n+z7PKSq1xqzdjpzYvSbA3E8msuHq6B2LZTXcjLfSXjZ2oUYSRX9+jyzDKF4Im0dIuOa4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 12:26:31 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 12:26:31 +0000
Message-ID: <782f499f-e151-4e36-af6c-ae935c990d9a@intel.com>
Date: Thu, 17 Apr 2025 14:26:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 01/16] libeth: convert to
 netmem
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-2-aleksander.lobakin@intel.com>
 <SJ0PR11MB5866A2B6D3DD4BF861DADB2BE5BD2@SJ0PR11MB5866.namprd11.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <SJ0PR11MB5866A2B6D3DD4BF861DADB2BE5BD2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|SJ0PR11MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 575741e1-b2a4-4a87-557f-08dd7dab1330
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVsQnh3NzRremcvK0wrR1B2MU0vVHgxUW5FYWJQTndxa3M3dThHem1wUHpX?=
 =?utf-8?B?MU9JOTYzWTJzTjNKNWJETmxYRGowdVQzL3hCWUJTOFNmOTRPSWoxRCtXRmdU?=
 =?utf-8?B?VXk1K1EwSU1lZ0lDNENCbTBmM2tqQUswcm9kWktzZVBja3NSU2ZGa0c2eVpT?=
 =?utf-8?B?cTN0Vjhtc3MvK3A5dXp1UUZwcjBBTjZtQmhMQ3JodDRpTHJraXBzbUJRdVBS?=
 =?utf-8?B?SVNVa3dPelRZeDBLaGQrUjZ0UG5yZ3FUR3BIUzZxYWNaOGVObWxRRFN6QkdJ?=
 =?utf-8?B?d0liMk4raFpMZEtVYkt1QkdnN0ZJWXVEenpvK3kxa2dmazBmWXUrRzZoa2I5?=
 =?utf-8?B?a09zdWV0UXNXdGsrWXdPSzZuZFhMdHFQUkdibG0yMkUyOVIrOEtIclJ2cXBu?=
 =?utf-8?B?Uzh0VVUvL2N6WHo3dGJSRmprM0RWSWF2MEtxOFhMdWptYzZibjd5cGxpM0Rr?=
 =?utf-8?B?SkQ3OVVBb0JGQWJNcGhEZnlQQzFlc1NLS0RlRzJUbUllTzA4ejh4OGtIZm05?=
 =?utf-8?B?clRpMERYQmJvdHBOblJxalZNd0xObVhiKzNINTcyWjI0US9IU2tUVHFxSjY3?=
 =?utf-8?B?ZHN1VGhQcndycVVZWkZXNm1GaExpejIzeEdtNnpFTUdUc0tBbXp6V085d2dJ?=
 =?utf-8?B?cUsrOGFiMGdqMVhnaFRFTkJSUkd5emZPZHk2bnoyb09aQlNFbjRTdlcvV2ts?=
 =?utf-8?B?Nm1zcjR1bGtrOWlGZzV3dzE0UFpuaVVObHpjQzJBL0JIME5JSlBNeWpFV0d4?=
 =?utf-8?B?WEZDRWs4c0E4ZWxUMy9FQUdtZ1BqY3FMWndHYmVOblJCd1dzTnBvb21RdFUx?=
 =?utf-8?B?WjRmTTBXb3pEQU4wb3pyNnMwWkV6ekhNaFREazNXU0FyTzVTQ2Qwb2ljQTBp?=
 =?utf-8?B?SU8rZDM0VFRZMlpSeHduaG1CV3pGZDNoVG5NemJKTE9pZGpuY0lCREhhVlZ3?=
 =?utf-8?B?YzFQbWZONENkVVowZkdjcUx4a2xXcHN2ZXpMWDFuZmdRT0w3a09iL0RLQXFM?=
 =?utf-8?B?eW0vTnVXUXArOEcwREM1OWVYcG9XdU1wb2RxY3cwSjQ4dDdwcGNHN3Q4Uldh?=
 =?utf-8?B?S1lVSTB6Z3hUT25PRlZlazB5UlBlS01uNVV5OUh6a05SQk13cjVibE1vNGQx?=
 =?utf-8?B?N2M2ZEdlSkRjOUkyTlF3S2owZ3c2SjlhekVBYjVBMVk1dnFxV2srZjNrNHhD?=
 =?utf-8?B?WkJUYW9wci9sZ09aejNlbVBIRUJjQzE5ZEpybHZJSXkwVWI4bTBvUXhtRWNS?=
 =?utf-8?B?QXJkSXlhc3pld2VPU1FzaklDbTNqeWFJdHRZT1dsOUlhOGZWNysyNzUzTEhU?=
 =?utf-8?B?YmU3RnpFbHkxcWJhMVlXbVhZM0VVOWlLR0ZCOWJZcThGSkp4ZUw3dktwYmoy?=
 =?utf-8?B?bkhzUituZ1FBREx6NWE1K0l0V1F0Z3h6VEFqNDRZTS9sZXczUENpa3N3U0hS?=
 =?utf-8?B?TTB2bVptaVE4Q2p4VjlEcDZXL09kdUN3MFlkL3B0M3pXYWM1aHdaUkRoRmFr?=
 =?utf-8?B?SWpvSGlaQkloVExpMG9sWDU0OW1rZ2tPWmFUTDM2eWxLTUdkeW0xcWZFb29x?=
 =?utf-8?B?WGJ4MitmbVFCVEJLd3NXdlRpWGtuTURXQldmSlhpOU1ROHpqY1BMTVBMMkNi?=
 =?utf-8?B?bkxHVzlPNHNQUzBWZGN0ZWNTN084aTVNNDlhT1RIMjd5TGhGamRTc0VnYldv?=
 =?utf-8?B?R1hDWHZuSDljWEtpRWFPVytyYnVxQnlaMFFqWkp1UjhJVUxDNDhUejA1bHMx?=
 =?utf-8?B?aEhOaHhxbXJPMnVRVDFSc3p0WE5QNlRRd2lQbjlWd2RIY0VBRXg0QnVib3Zx?=
 =?utf-8?B?bXlwdVB3Tkg1Yk9IajArUzN6OXUvTnVoT002ekE0ZGdOUDJZQVdYRWpnUkJD?=
 =?utf-8?B?NEJTSk5VUElSc2ZpMmJaZkxIUDZSQjhoSVJXTmMzb1RnN0VzMWNZNHVWbmpm?=
 =?utf-8?Q?tzc8TC1gqEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlDZ0xlTmsrOW0vSlFNdFVqL25wMHR5dFd3SUh4TU1uTktEMFByQmFSenVl?=
 =?utf-8?B?YjNsSmo5TllTZXRZY0NtM1psY2M3aERwbE9GWTE2akhiQ0hYL0IrRE1sNmdL?=
 =?utf-8?B?SFBBcjlnMFJ2MGU0RjhvTnpBY3JteG04dzJwakJBWHZZeUt6N3VVVCtmVWZD?=
 =?utf-8?B?L0RKaWt5eDA3UGQ4VXR5SE05VTBuQkdEci9yOUV1UFNTQUtrMldsbnpoWVdG?=
 =?utf-8?B?b3JPcUpJa2ZCbmZaUlp4NDhvUkZpUkdlM28rSGZyWUx0S3pncjdRUU0vVUVz?=
 =?utf-8?B?eWZNRnJVbTlzMXVObFphL05DcnlvNUZPb240aklPVjFQMUFqOHowVkZHaTRF?=
 =?utf-8?B?NnlTSXlSWUpZUVhRcHFRYXBtZmVIQjZsd29CcnN4M0JtNUkvRlRaWHRIbVVx?=
 =?utf-8?B?ZHVGQ1ZSdjNLVW5BaHVMK09VTWY1OHV4cW5tNUNhZiszME1ab1VPYUtxUjhu?=
 =?utf-8?B?RGRjelFDdDhZN3BNYnE5OVk1K250SHhPaldsWDYyemhwYXQwakR3LzE4a1A1?=
 =?utf-8?B?RGJsa3U4UFQ3a01ZdEt5WTNiZ1hxcDdyTDJFc0k2YlBzUGNBekdoUE9PSnJB?=
 =?utf-8?B?aG1Jd3JZai81Kysrb0ZRRmZNN2hMZTFzQ001NHBuQ0JDMHhON2k4QnV0QmZl?=
 =?utf-8?B?WDRKREhMS3RoZE5udGRqeEY5NWJxQkV5NVpMV0x6eFNoWXhDWk1uZVhPbFJl?=
 =?utf-8?B?ZXNTTENvSk9RV2o3UmU5YXd4WFFBYU0zdWphK1hqL0RrckdZSnpHelEzZGYy?=
 =?utf-8?B?ckNyaUdrMHRHU3ZVVlBZb0NQd3k4OVJ6SE9KMVRMYWJ2azNyRDNJZE1xeVVP?=
 =?utf-8?B?d05OdnNpTlBEM2dxc1JXejJRMXQ5MThaSGdkY3Rka2NmeXRYTnZRVm9SSHZo?=
 =?utf-8?B?NnhnZFA0RDVEMGc4MVhpUlpaS21JZTdYckVCZms4YldPKzh6TWV1b1lGWERR?=
 =?utf-8?B?VEkvZVBzM0QwRjYvK0Z2RTJqdUZpVW0xSURvV1l4K3ZoZ2ZrYm05QUdRL0Qz?=
 =?utf-8?B?Z0czM1NHN3JJNFYydzIzS09qR2tFYVdOMFlBaWFJQXR0WHc5VGF2QVBMRzQ0?=
 =?utf-8?B?SUttbi8zS2wwTEowbE9iTVBDMFlMcnlkbFVmOG4yQWFSMFlncnpzQkF2N3pj?=
 =?utf-8?B?WDN6MXRPcDRvWVJhdk9ZQ1hSbzhFRkFMUkw5M2xIVHV0RnIraXBkcUJqTTVi?=
 =?utf-8?B?Tkh4cXVhbDdqYnpVWGFHSHFZMkc3RXcraVUvSWxyTHdmeklkR2VNMlJlc3BH?=
 =?utf-8?B?akdXUmJyVlZwZ0dNa084SjNKZ0kySWpidC9SbFllMWlDNG5PTUc1MyttREdC?=
 =?utf-8?B?MWdNMHViL1labTRBdFV1NWczL0JKQ3F1S2MyeTJZaFByZVh3ZEpDNktjaHht?=
 =?utf-8?B?Qmo4bXdTVitsS2t2YUZYcmhEbE0rVEJGRDhtODZXVDBGVmdkNGl2WW55QUFk?=
 =?utf-8?B?ZEw1a3JSb1M0aDBqdEd1enM4NjRnVG5QOU9SaTYxSUc5NERYc0pEU2JlNllh?=
 =?utf-8?B?UURDQ1ByTXI5eVFIdngyZ0JPNTdSR2J2cUVNaU1FOEhOWkJCUW9UZXZTQm4v?=
 =?utf-8?B?T01mcThxL0JaM1BMN2l6bWZhQ1ZBL25UVWl3Tk4rbEN3Mm4raGFWdEhOWGF0?=
 =?utf-8?B?WFpSTUgwWFVXOFdsM1M1djh6UW1FTVlIMlZ6Y1pwUUFkcjBabGdKbzIrc3lP?=
 =?utf-8?B?Vnphd0ZIM2k1WVFsRis1aUZhR3lSWG9LZGN0SHVFNk9oZjdIdExZS0trbkpW?=
 =?utf-8?B?YW41R1J6dmtaNjRKNGo4bUFId0VRSVlSeXRqOGNnTzhPdDhrNmxMNXdTVlRP?=
 =?utf-8?B?ci9lVjJYM042Y2tCQngzbEJLYU0wdmZoY0hsVjVKdC93a2pLN0IwSE04bWgr?=
 =?utf-8?B?WGR3bkpJaWVHOTVFQTJjV1krbDdIQ1RJRFdJcHM5OExtNzhPQkJQU0ozVnVG?=
 =?utf-8?B?UE5QVE9SSnFwRVZ0OG9JcUdleVVsU3dTa1NYaWhwTTZsc09LNFJVQzEwTWdF?=
 =?utf-8?B?Vmo5M0tRWUlXK2pWV3BZa1pvN3cxcjhXTTA2WTNmWUQ2TUpsY1JrZFdrM05p?=
 =?utf-8?B?Y3oyaE15UmN5eGZKZ0o2Z0puSHVzRldyM1oybHlUbTFkdU9VbzJ4RXc3Mktl?=
 =?utf-8?B?eExza01FdlhOeENIQVE4cldnYWViODFuZk96UkZnamMyekVTWllzRWlVK2wr?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575741e1-b2a4-4a87-557f-08dd7dab1330
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:26:31.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQj7Pv0EGonDuAoOSjqWLIG75on0v0CFty9F8LNY1aCAe3e8+6TzkYVLrtlP8yUEDBzLhQXYaFiKD4UddtYeOKkUM6lErbEtO2ulLYnGXB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Date: Wed, 16 Apr 2025 08:54:39 +0200

> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Alexander Lobakin
>> Sent: Tuesday, April 15, 2025 7:28 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Kubiak, Michal
>> <michal.kubiak@intel.com>; Fijalkowski, Maciej
>> <maciej.fijalkowski@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S. Miller <davem@davemloft.net>; Dumazet, Eric
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
>> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
>> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Simon
>> Horman <horms@kernel.org>; bpf@vger.kernel.org; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Mina Almasry <almasrymina@google.com>
>> Subject: [Intel-wired-lan] [PATCH iwl-next 01/16] libeth: convert to netmem

[...]

>> +	memcpy(dst, src, LARGEST_ALIGN(copy));
> Can you avoid 'unstable' API __netmem_to_page()  usage? For example:
> 
> - dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
> - src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
> - memcpy(dst, src, LARGEST_ALIGN(copy));
> + dst = netmem_address(hdr->netmem) + hdr->offset;
> + src = netmem_address(buf->netmem) + buf->offset;
> + memcpy(dst, src, LARGEST_ALIGN(copy));

Those underscored versions were introduced by me to avoid redundant
overhead when it's known the buffer is backed by a page -- for cases
like this one, so your propo makes no sense to me.

> 
>>  	buf->offset += copy;
>>
>>  	return copy;

Thanks,
Olek

