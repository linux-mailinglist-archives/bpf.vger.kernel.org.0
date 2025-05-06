Return-Path: <bpf+bounces-57554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E68AACD1B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5253B1666
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66A28642E;
	Tue,  6 May 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDZ5VgQu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AD20B806;
	Tue,  6 May 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555747; cv=fail; b=WgUlRyigqoDqh9ZvdrhaQRe6+0sMFquycOlRBAZQv1UOLz4+CodJo6yJqgqCletjKhCK+gYd+mQigTu6DMQr0Jo3h1XYF+xdanXaabxGZzWH0OpjiUDqtawnMAGxURlSmezBml66vMGGZjL1BTUHvlbB3FiB1w5F30RrlePipRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555747; c=relaxed/simple;
	bh=1pjRK5FcPhaq69Js353h58c48lk7/72ug7vaCr94lWg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aV029p8YRKhH6Y70REJfpfekUyWJzPMx1i1MfZFigRuyzm8iIBMN1C7sQ9LfFBd6Sld1uMIb7C36PqC203utr8p3kvGIiMEY1QHinKmpFfUt/YR5YgDfwc9iI/N5fkIvYXGfOHLjFbZadwTp5zrYheQ9NT0Cda2EI/sBynZeOW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDZ5VgQu; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746555745; x=1778091745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1pjRK5FcPhaq69Js353h58c48lk7/72ug7vaCr94lWg=;
  b=DDZ5VgQuWSCXgb2dKiV0FfHEc15Ka3WevsmarFK4iAyuElhxWYCsNDg9
   M9HsLQSExiX2H3zBT2u+JE2LhvnNNqboWz3W+6snuc45RrMBBhfTxrZrH
   iL+pzlZGB47Y/x/XxH5fJJO2ruXIVeGzlpR4qZatALHnqbjrYhbNNTDRP
   HRtT0mSTP34W7BOVHa/m2RlE3lD7pvv5Zs6Upayz1iayilahlzYlJo+yT
   NzOWhMdVmUWUGnNpIiiwIN8Rlz+IQ3ghBbet5B9IOK4m7A6hzSfCXgG0p
   lRAhAmFVnpr9qwq3DOs87qGBMznSb4cDIqGo/d3+sZB35ghBmLMUyOden
   g==;
X-CSE-ConnectionGUID: xvYNi9xnQpeVev+UZDEU1w==
X-CSE-MsgGUID: 3R1dc6QZTG+fvhcShki8Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="70751021"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="70751021"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:22:25 -0700
X-CSE-ConnectionGUID: OIV02ipzQGSNjl8ptjrbnQ==
X-CSE-MsgGUID: 2GzEAxGbT3q2uHvC2fQ0Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="158994714"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:22:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:22:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:22:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSS2QJQqrjMHCpLiAFAXcW5IjhLVpxPdBvkXNTfDiR/ZCSjtkQKKoXswTVwzhZnV/f8Pa4gnbR0FIXyh+DbW/GSUJa0J8HTV2HJZwKPZGbXXq54lgPynMmxNqBKhirOwu1hfLBks6JMVBocOSlxIytlT/K3Q/Vae8id2gGg3KA9d0uD8Nm9TWAwsN2IuKNEUNEkJHHjUl6xUgYCwH90e5R54qSp/11ImvpJuGBT8iSQ5bS1X9GqFcsiQHvpFnEPUGQSGaAQmZ7i+jqPFzhfYVNC1rfjHIFnC/FrSTJ0N332xHuKmDNdWssBvHbC/zgVOLbzi+k79PTYYB8N2X3Ml5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Ae/xqo8vTnF8ccaia1u51lsh7VJ3nmzVaPqCyCtr0=;
 b=BhqFyRLRoL9rPzZjvplI3NtGf6ZvA6vHDo04MfMwfPycP4Cf8rEcQCUox2OOtePZ8JOMAWz8Prv0JuWOqc5zdrLsKPSnxNmj6LXRYgJ1nxRepKsBTbnl899w8E1ZZBpD51WL9lmbFQRuFJZQ38txACBY2pDmGJE2KrlVI+vio/eZmppaVG73z4ivcmRKOczsSUS135Ur3CDV/BfEri0FU1xCRRhGaEVTRkGz4lTGHqm9HrYbL9N5Az6+ctkTLlDskfsAqy2e9Yv1RQYTarLmMMhDlRNqXGdsdPR/CG2O4rpkpDjlOqPogWppIIeosT/JJA7tutzQ+2oTM1JsI0aqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 18:21:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:21:43 +0000
Message-ID: <b0c6e2e6-b433-4ffd-b12d-956abee0a0bb@intel.com>
Date: Tue, 6 May 2025 11:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: ti: icssg-prueth: Fix kernel panic during
 concurrent Tx queue access
To: Meghana Malladi <m-malladi@ti.com>, <namcao@linutronix.de>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250506110546.4065715-1-m-malladi@ti.com>
 <20250506110546.4065715-3-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506110546.4065715-3-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2086215d-df26-4931-5a79-08dd8ccada6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjhDSFVRYUtncitLQW04V0RydXZJdUhTcnIwT1lxb2hJU3Mzdy9OckYrNmJa?=
 =?utf-8?B?TXRzZC94QkV1VE5QMGZkN3k2S0VyZFZxQlE5VHdPSWZqeGtvSTRJOWRQM2dp?=
 =?utf-8?B?TjBDWndzUWMyRmgxd0NWenB6YXF4Zm5SYnRQWXp0SWlBcFE3dERaR2JRS3Bi?=
 =?utf-8?B?eWtBbjc3a2hucWdLdWorV2wraFBuZFF6MFBLTHZNSUtBUFRHUExKNzAzeTFK?=
 =?utf-8?B?YUo3cTNMU3Q2WUkvVDM5L0NVQTdnMEpNcnFTaHlENk1hclFRbkR6aVFZYStE?=
 =?utf-8?B?MzdLYUQ4WWRabkJrcnBQNWxzeUxOcVJOMzN2bFNML2pROXp5TjJQQzRXV21L?=
 =?utf-8?B?RHRvcG1QNVdDT0ZJb3NSWjdORFQ5RmNlSUpDQjIwcHV2MEVFNFpqdUdSaGt5?=
 =?utf-8?B?MUVsY2oxSXFmQnFzU1pDNDZCOERvQ3hFTmJnRVI0NjkreVZ4aTlyQ2tsNFlU?=
 =?utf-8?B?d0kzNE5obllZK0JCNUNHcE85SUhHVHZncXZvVUZkd1FGUEM4Yk5TeVhmM0ls?=
 =?utf-8?B?a3l1a0xMYlFwVzRVeVFoaGRhcjc3ajlMYnM4OU1iYXc1YVpOampJOFh2OXNl?=
 =?utf-8?B?TnpTdndyby9WZW9hMEVHVzRGNlVQbDNiTWhpczg0VEgrZ1l6OTVKdFN2WGk3?=
 =?utf-8?B?VnVVV3FrS3BVVFBUSXRaRGQrMUNDWFZNQm5hT3owOUJsSG1OVWw5cEtkbkdD?=
 =?utf-8?B?RDN5UTRTeVFmWTBsKzZrRmFMazdxa245bVp0NjhIQjRBOW1DT2pBMTlyZzJ5?=
 =?utf-8?B?aGlhRW5EYWVRcmh5aEVWUnR1WkJSQlRUT2VISU5VSFBxMzFZbG90cStZcDZO?=
 =?utf-8?B?MVQvcERwWE1Vc3FVa05FWW5OOHJPaGJCVkpXWmVvc3hEZG9Pa0l4OXFmcFNM?=
 =?utf-8?B?a211UUllaDJ1U1BWd1dFUGVJK3huZ2RoUk1tS3A4d0tiOHlFUTNjOHZwcmRM?=
 =?utf-8?B?VW9ZTWhNR0VtdXRuRHFBYzFnMm1MY1dtYkxuVmNVdDYxSHZub3dvNXVibzBP?=
 =?utf-8?B?ZEdsZDdtVEdISzdERkF0ZnM5dDU4SlQ2UnBGNFJYM21zYlZGbFNRN3FNQUlY?=
 =?utf-8?B?SWM0VytySVN2MDlsMjZtSGU4TDBPdmlyOGVVZmgrcDRsc09Ud3dNZSs3cTEy?=
 =?utf-8?B?TDZJbFlNSGN4aVRIdGVIdzJVNXpubkxUUHBBR0wwdWNGeUJ1UGVlWFlHb2pF?=
 =?utf-8?B?RDFtQW1lcjFKbHlqQ2x1MXJlQ29BcnVlRFRRVC9XUktaRkUwVHZFVkZ3L01x?=
 =?utf-8?B?bFBEaHg2d3MyRWViR1pMOW5qa2hrdkVGVzZHamxjRnNSNGdydmJGM01OSENs?=
 =?utf-8?B?K0Z2amp0L0JndVcrd25EUWZxbFZjYjFFZ3k1SkE3bkFBUVIwRm1lSnBKcW9T?=
 =?utf-8?B?anUzUmFhV3pNREZBMlZGcm55bnNKOTBjaTNiNE1TWUVLOTNFZFNSbUYvWThY?=
 =?utf-8?B?OU1qUk1QOENtYzRwSDNIK09YdWowZ0lyNThyOGhZNk43czBuWFVFZ0RrUDV5?=
 =?utf-8?B?YjhRVE5GYzYrMGZaVHBCamxNZDlWYXdBWGQzVjdUZW43QWNJQnRtK09XRDY1?=
 =?utf-8?B?d2tsa1JGZjFmVXd3QVgzUkJYUG1CaTFndmJWanBSTTNUOFE3MG1USDR0cElu?=
 =?utf-8?B?REJoeUd4YkVvNFJRRHZ2VHpMbDNGdml1dUtGTllXbmlVdUZXQ3EyUytjWGdj?=
 =?utf-8?B?bVJZbThEK0QrbUptblRaVk5MdC90aEhTeWtvdjUwY1V2aXY1NHdlS3VKNytp?=
 =?utf-8?B?ZzRKaFZxdVlxTVNTck0wVlpqcmlhais3Ui9vZ0xHM0dUTElCYmtYdHlRSTFT?=
 =?utf-8?B?cEQwRXJ3ZXFIS1gxeEoxR3ZuRGNzMEF2eHVGeFg1OUJOZjlkN2QvdldQQWZG?=
 =?utf-8?B?UnlSQ3VYdEgwY2RhUE5Mb2VabHJWTFRGbHBsaUd6V1h4OXVVSGJObndvUmJa?=
 =?utf-8?Q?TLrZdzp/v8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01Sd2dCSk94bko5d2RFdXhqcVVPUlQ3SzJ2aHFLN2NyaTd1ajBPdWQrenVa?=
 =?utf-8?B?SDRoWWRFeE03NFZIcUNFY0h6dkY3ZTNNdzZhU1hVemFxcXpVRGluZFBWVjU5?=
 =?utf-8?B?cFNIanFRNytaMERERjhlNkF4aFhycEU0VnVqVEh3dmdnK3k1Wi81Y0xWclg0?=
 =?utf-8?B?YVFtSlRZbEIrRXcrVkFZTWxkTVAvWGVCUER2Q3dqVzZmWml1ekxnWmhCZU84?=
 =?utf-8?B?ekJqYUoyQVl6THV5dGlVNnhzeS9pQjI3cThoS1VlZWdEdkpuS3V6VVdpcXZJ?=
 =?utf-8?B?SmZIMGtrcERld2ZDYzdlM0tHL3RCNStETUZBdWdJaE9FZWtkZ1ZzNlBvQmRQ?=
 =?utf-8?B?enZWeHFNSDR4RzVmVjk4NnE0K3I5TDU0Z29qOExaL3NEbVpBelJiZU1za0lu?=
 =?utf-8?B?aENEdmxSWVZXK1p0RnlLOHNLcnh4VG9xRGZRUHZqT2J1ZHl4Ukh0NzZKSDFn?=
 =?utf-8?B?cHAzVFV4dGd1Wi9CV3Z6TjN3b2FnK0JEM09mak5jenZTcGIxdDRLanBxbXZa?=
 =?utf-8?B?eTAvQkZSWXV0bENvaWF6SDNXbzlHcGNzUUx6RE1rK2hpRU9zUFFsc1c1ZkZV?=
 =?utf-8?B?OUsxQzM1Y2NDNkFheitZNTNIblFEMzloZ2tuR1hrcmpkNXkxUjdLUDNBKzVX?=
 =?utf-8?B?Z0NVV1dua2NXM0xWWGxBcmdSRkYwNW1CSjlacDk4OHE5V1p0SnhYRFdOWXFi?=
 =?utf-8?B?TTN1Nld2bVlRSzIvWit4ZzFDZVBJVUp5SlVWN29ib1k2TVlGcFFpN0xnSHc0?=
 =?utf-8?B?YmNROWV1N0J3NnRZMkthdEk2T3FNeS9xdkRpSlFHL2FrUUU4RDZFMk9iV0Zt?=
 =?utf-8?B?bUh0azlDK0QyM1dlemJXSGo5eG1QNFA0d0RmdG8vKzlEUzcrVEljRkhyZjB5?=
 =?utf-8?B?bUZrYU5oT01jb2pOYXNHdnk3VzhVeWxNcTh0VlAvR3QrcVFtSkoxbENtTUI1?=
 =?utf-8?B?Ukh5cHhmWUZJamlZQUdSVVZSSHBCelROMEMrRDdJUmhTZU43SFppamVUWWp5?=
 =?utf-8?B?cUlLeDg1Q1NPNUNnandrYi8ycVdwVlJ2aE8xeWdwcS91aXcrb1VDTmxrNmQv?=
 =?utf-8?B?N1grTFY3ZlExOU1wcGtEMG05OU04UHpSYnpSUjVQRmxrTXlxRURPNzg1SWg4?=
 =?utf-8?B?U1FKQUNxaG4vQjljazV5ZkxqRkJrdHJnUGNqWDF4aG40WmdlS0FhMHFYTFhj?=
 =?utf-8?B?OTV5WEgyc1ZaOFNaeFplRTRIOWw2bGFNN0VBUzVCYnAzMVdFU2RlV1lEZ0Q2?=
 =?utf-8?B?a2o2ejRMQWhsTmMwU1VnZWRITzAvTG1yR3hRbnlQODM5MmtRZjZUWXFwK1lY?=
 =?utf-8?B?YURrWjBVZ2RleG1PSUdNeG1PVXFCd0tYMG5lckZlU2w3V1FKNm50bFh0OXJu?=
 =?utf-8?B?bmc1RnhjT3JmdlFSaEl1TjdQOXlvZ1RCY2JVS1RJTDdVK2pOcGxsZzRqUit4?=
 =?utf-8?B?b3dxZXZ5MTQzMmRRdE1pT2pJVVpoZzZWN0ovd3puRlA1MGQ5a1ppQkp3T2pN?=
 =?utf-8?B?bzR5OVg4cVFHZ2N4VVcvVlBvNFovTzBoTis2bERMY0JDRUpzaFRjUnFXL0p2?=
 =?utf-8?B?Vkd1cThwVVJuM1paQzZkbEZqV3FOQVI4Z3pKd1BnU1JVUnJ0Sk9aZ0NrWTBq?=
 =?utf-8?B?MmhseTBqV2s4cklpdEdyRGdCa2xmN3BsSTJXZjhkYVJBSzI5WExwZXFmZ0Nq?=
 =?utf-8?B?OVUvUWU4TFZQT284L1lORlljTXc4UG9CYUpRSHpoQ2Y4WXpYTnJBdnZmOWtC?=
 =?utf-8?B?UE1qYTZVSUxUZWJQeGZzTHNnbUptOS9hM21YaGY4NHFQcVg2dGpPZVlPRGow?=
 =?utf-8?B?YVRBcFJmR1F5T25vRkkvcys5Wks4dURvbHZEUGxybUFsa0FsZXRlZEZkVGVH?=
 =?utf-8?B?UHJOYjVleGg1NFpKUk9EL1IwbWdHZHI3YUdPOTBkNWNEUEdpbnhFK1dRdGhG?=
 =?utf-8?B?T2hvZ1RoR2pnN09Sd0R3QVVKT2h1aVlSc1N6N0JYSElNZWYwc2RjUGZ2OFVn?=
 =?utf-8?B?aHFBaFR1T3NnWXNsM09GWWhSVlg2YUlmdGhQSWJHcXBFNXZHSDNCamt5WnZu?=
 =?utf-8?B?eDduU3gxZGE2Y3JXYWZ3RGlPcUhpRVFJWVZGWmFqY2RJem50THh0YnVYdity?=
 =?utf-8?B?bGpPMmV6dVNqOU9LTkYyNTJYb01qZXZ4RGhqZUJJU2Njdys4bGxQL1FSZ2k3?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2086215d-df26-4931-5a79-08dd8ccada6d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:21:43.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWOlkq0qWBAT7TnS+RKOrHIo2C650Gz0iSlNcRzqrZtb0/V+0Ou7UkPqS+nlSe0hITFn+wV5GSeQaFTe9GrFLVWovP3TiG9+1HMENv+XC60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com



On 5/6/2025 4:05 AM, Meghana Malladi wrote:
> Add __netif_tx_lock() to ensure that only one packet is being
> transmitted at a time to avoid race conditions in the netif_txq
> struct and prevent packet data corruption. Failing to do so causes
> kernel panic with the following error:
> 
> [ 2184.746764] ------------[ cut here ]------------
> [ 2184.751412] kernel BUG at lib/dynamic_queue_limits.c:99!
> [ 2184.756728] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> 
> logs: https://gist.github.com/MeghanaMalladiTI/9c7aa5fc3b7fb03f87c74aad487956e9
> 
> The lock is acquired before calling emac_xmit_xdp_frame() and released after the
> call returns. This ensures that the TX queue is protected from concurrent access
> during the transmission of XDP frames.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

