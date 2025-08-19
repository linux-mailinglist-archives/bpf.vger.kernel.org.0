Return-Path: <bpf+bounces-65934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2BB2B561
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 02:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7101968499
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E4157E99;
	Tue, 19 Aug 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoF41cjh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764958BEE;
	Tue, 19 Aug 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563903; cv=fail; b=fEUGbk6WzOKgsvqG5S2C0xwRLZw3094H6wvLbui6VFCpYQiMDVWJN6VgZkTywy0McURGw3FklzH/8tFk3dA11cQ3Hx0ru4dBO2o7Hl/SlYOGptTzUwhLl5q3d5rs536pafpCKEFibquQLIMUcEK31F42yODOaE83t1Ezq9JnhEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563903; c=relaxed/simple;
	bh=i54F9wiXsguaqwCN9PwyB+DIshtdvlbSlBpfG/cWcBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZ2l03R2CfYSqi6/BZZG2gTQvYKmPLvdACO95FBvkxZ2Ta+tmW4CWEY5/XrGzgi7VzlhZXrmCwYeNdlMYoQMKj2dB/hung34gxLK/DV6s+B56JfgK8yPGOhBwGYv+tySRo4jXsol0l276QkXhKuW6P68CCSRi4itP/xhLMGP12A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoF41cjh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755563902; x=1787099902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=i54F9wiXsguaqwCN9PwyB+DIshtdvlbSlBpfG/cWcBo=;
  b=EoF41cjh6yNhS9ECmPTv4Fx6aMjtGnTKDMzLH/NbCoHQZyCPrGclpOba
   epRdX57q3QTcqOzpRMELbzzrsvq1GaCeXGw0dgwhFE0KElWCu+H7s5F2y
   XxVRUp/D2W84CavXRVVX6TM8lOVZ2iZmrQ5oJoEZqkS3p9s+VxqKclHDb
   Mt3NhWd6sP6n+XKoabSIQNm5LIwPirBE4lYp6u8OpDFhIHTU0dBg5gTbe
   2c8AC3PvuXI7cozpcfnIjcficS3ksS57Ngkh0gLZNUomPk31w64LqA9js
   09UjKxiVBe9/0Sbhc7La5VQQdPOvGn9Fcl4TOlgcAt+rQf7+0XKGxQr1C
   A==;
X-CSE-ConnectionGUID: JYM++UQOTMiboisXkYlStg==
X-CSE-MsgGUID: vmekldV2TZe0R5BmOiIwmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57510564"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="asc'?scan'208";a="57510564"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 17:38:21 -0700
X-CSE-ConnectionGUID: Sn945OFkSyC+iPj1sxBKXw==
X-CSE-MsgGUID: B/5IGvlxQNWdAtJIuT1TDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="asc'?scan'208";a="191390596"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 17:38:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 17:38:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 17:38:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.67)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 17:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbSgR8QetAn9jmcZqDcGFHS5/KGOgOlfkpxUTdaGo/qgc6UCVNkH60qGegfZbnbo+tEvsnC+As6Ovn5ItsFImGlcS6TJ9x4hcXHqVU70Omx0zDQDoaJ7UcC56XhxSjCJeZiB8xG3UKYSBFkW3J+mC21A4Ran0SHTjjYBdfbJSVsAP+IWe/iU2sgRAOQJzOM5iNOflnU97bdm57SMdq2HLYUC9+QMCPInEXsnVSKlx81jMsctyfBfZ21yvgMNZA6f0HiBPDvXPYyH9e+7NkTnpgOXnr+4OMREkMdv3n5W/JQ5g3nbCoHE6KTdul1Ki7K9IipvKsuayc8oPdL/CFl7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTHWiuP4uK2/I3S3qOHMS5H+pnWvplOk1O5dTvGyw/E=;
 b=u+maJKWOk0IvWfr8FiDPQFAkw/mpBMjaZSvTblwfd+TYCGb/AasD1CvaYhjPRQspSreTKK157Zw2Cq0PSWrfU6aHKKnydIsw5ku9jHY5fsUZGPl3VnefrWKZeZAa8cEG3hD0ODOfNoV7kyX6LviC+sqmkztUBBkV+FCkeH9keCXrZQztPZ0qf9mJmuzbIdCRftJ1gw4g0Ctw1zaJBui3S2ThzQWcxK0rMiCqcwkUMT20pffzmiloMeqQSC7buUliK/GS49w6Q6/HpNFr/L8MFzLLqHIYhEw3wRRlCO3+4AB5Cwe0OifhVrN/vmOmm2dENXKZias8IbTB0KCL4F10nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 00:38:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 00:38:17 +0000
Message-ID: <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
Date: Mon, 18 Aug 2025 17:38:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
To: Jesper Dangaard Brouer <hawk@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: <maciej.fijalkowski@intel.com>, <magnus.karlsson@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<jaroslav.pulchart@gooddata.com>, <jdamato@fastly.com>,
	<christoph.petrausch@deepl.com>, Rinitha S <sx.rinitha@intel.com>, "Priya
 Singh" <priyax.singh@intel.com>, Eelco Chaudron <echaudro@redhat.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
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
In-Reply-To: <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------c0OVcBB0Z9cvCZRYATDUgy3W"
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7e92aa-f669-4b4e-8731-08dddeb8b085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bndWbEcvZEs3ZDg0blVEaXhIdXJTc0hBemFIV0pTUCthRGgyMkUvZm4yQm5z?=
 =?utf-8?B?MmFvL0JCdkpJWXp4TnIvVUVTNVAxdjRmRndEK3poZ2pVUnRuaGhsdm41TDc3?=
 =?utf-8?B?S0RKdko3U2JOTnhpb1FSLzkyS282SWFONEpaeWFqeGE1bDQ1ZVNCTE9vSXdF?=
 =?utf-8?B?MWVndVBZVlptcXBRT0UvSG1obURBdVVVblVkZU1UNmhyNVFhTmU1T2d3OUli?=
 =?utf-8?B?czBMQjZwL0RQUmZzUHhJVUF0Q3dXUUV2bkUzYVNOM1ZFNjdnWlZnMlFwcWxz?=
 =?utf-8?B?alN5S21oTkh4NytzOGlPa1ZsamsvcmRPY2Y4NklTaHY3MkFDRzhPOHhuam92?=
 =?utf-8?B?eHBrSHJTRFVWOEkrYTI4SUxaTVJQRGhRKzA0NTZINVZJaEpKNmNEV1p4SWVr?=
 =?utf-8?B?M1hDeVhDRDEwYUF4aTczSy9UcEU2Ujg5UUZjTUF4cUJ3bEY2bk9JNlluV1V1?=
 =?utf-8?B?RldJSE11WkYrUi9hVUl3dndLWjIrMGhOSTFwT09ib3BqNWU1NmJDQ2pFTDI0?=
 =?utf-8?B?OUNtc0hPaWduaGUrNlBlM1pxQVNQR3ZkdW9QV25xTzhKL0pDUVJWMHg5Q20x?=
 =?utf-8?B?azBoczRRblNnYmt5aGlnWW9JRTFtMkQ0VHErMHUvQXUyMkRITEdqdUx5bEJZ?=
 =?utf-8?B?NTVKSE81TmhHaXhOQk9HVm5ObHFDcFo1Ny9OOW9MQVJ6MUtTZ0F5QkNqTExQ?=
 =?utf-8?B?bDZadC9kaGFteDkyeFAvaElqY2ZNMFhsZXhZMUxJYnJpL2QxQVNQZ2FreVlO?=
 =?utf-8?B?UHdNY2t1UjQ4T1FPN0FLb2pnK09rYVZJL1YxaER5VTArRy80Nmw5eDg1RmlU?=
 =?utf-8?B?TXVxdWg5T2ZDbitJUS9aSTJXNDJmN2FoMncvcXF5TWROT20vNEN1aTN2WDZH?=
 =?utf-8?B?REgybkVDYkhCd1p3L21rU2g4cnJkR0JJbHgzcU9IMW1mZzFPbTlTcGQycW1n?=
 =?utf-8?B?MENGU3Q5TW5NYmNQcHRLN2pRNXYzNVlSWDlpaStEK2YvcG9jU2NBTnUreFlI?=
 =?utf-8?B?RmgwZGFoUG5icmI0NzBtcy9UYnRjNkxDdkg2alpBV0xjZzNEclJLRVlQQjl2?=
 =?utf-8?B?dE80bGtBSmU0d2hmcytva3BGU3lHMlBFTzk2c1BkR0l0dTZwcU9rRlJBVnAz?=
 =?utf-8?B?L09yUTlWb1VCdHRUU1BiVjhnK2kyekcxTXcvdlJCYWowb04rT2J0QmtRbEJ6?=
 =?utf-8?B?K3BVeFFvcHNFSnEwbWpLWlZjZ0IvR1NyOVVjeU83bHpZUVlIdDZybmxqbUlF?=
 =?utf-8?B?Yk5seVNzVXA5cTJ6eFMxSnFtelFtZkhqei84R21vSHJPdTVyT25xUElkREdz?=
 =?utf-8?B?MThKL1NPVkZvMzZUUlNFandQZUFwNHNtQ3hSclZWVXBNUVRaOTlWKzhSTWZv?=
 =?utf-8?B?dkI2cjlTd1FZaWJadFVoOUJHSUhKZmxOdHh2bHVvVlpxV2ZDRWY5eGNoMnZJ?=
 =?utf-8?B?bWVOMCtJVjRjNEZnVzNUSHNWMFlWVm9tK0d0WG5mNzA1dkdCMVA0VnIvZmxv?=
 =?utf-8?B?QldoQXRkUHZqbzl2NnVIWTlsY3IrTFArLzlkWWgvd0NsWEQxZzhMSlczUmZH?=
 =?utf-8?B?REkvVFRzSWtKM040NENndXUrNGNCTGZxR21SNkJmQjgvRTlHRzREU1FiZHJx?=
 =?utf-8?B?T3lUSUtwZUtLRzUwdzFzRU16WTRhMWRUY3pMVG5DNkVUT2Y1bXQ0a0FGTXJ4?=
 =?utf-8?B?dlhJQVcxQ2JDeHdIUGErSHVXM3pQMDdkbjFjODlneVBXb2pzMGJrM1dONW1t?=
 =?utf-8?B?cC9yV0t5aVdiTjhGTnNNS1ZVN2cyWHJCREhHWWxqSWtRV0djNmREZ1RDb0Zh?=
 =?utf-8?B?VmZMYnRzM1oyOHRabmNKeE5YNm1qbUxXVEs1bTFZR3hFbzJQZDJxOHZPM3F1?=
 =?utf-8?B?aDRMVTFRS0UwL3hKU1BYV1VmbzNqS0lVREVJOXhwM3VFT052NmV0bTRRWW9L?=
 =?utf-8?Q?dULcODnKSMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG00SWJNNDJ4OGFKSWc1NUwydmZzSWJRd05aTjNzemlVam1xeXQvOUFMa2lr?=
 =?utf-8?B?NklCbTNVbFducnJ4UGtSNEJ1WmR5cEV0OG9yQWJlQzVnZmp5SmV1YzJ6TmE0?=
 =?utf-8?B?ZHQrUHF1UTJEamtvNXdXZ250SXlpQkEybkVvWGRVT25taW9LSEVNY3diRHZD?=
 =?utf-8?B?eXoxZ2J2OTVUQjJ2b1VFeW5zMGNCclozbE9OOXN4dlhMRUdDc2NDcUtmOHlB?=
 =?utf-8?B?S1h4aG5OMVNRM2pUdlIvdTcxd1FsbjJTRUNkY2xpQmVVc2JoaStnajFmdFBk?=
 =?utf-8?B?aTMwR0pLUGJqSVR5bHRiSkQ4OGY5eDhySzNaWitqb2NvS0tkZXRMcVhKaDQy?=
 =?utf-8?B?eDg5TVp1L1Qzc2libDloZW80Y0RpdDJaQmZKdjZmL3Z2Y0NqdWlzeFk4WTYz?=
 =?utf-8?B?Q2l5ZlRqR3ZKVXUyL0d1UUVwdVJvMXNZZndaQkdwSjN1K0NicUIrMnNvdks2?=
 =?utf-8?B?aVFOU3lrMHpqVmVvNG51QUpSSFVsUG1FVkdud0lNbXJUK1ZpL3dUSXVucVlH?=
 =?utf-8?B?K1piOHRRTGM5MTN3L2dBTldUUGZmUDE5WExPQzZOVXc1R1FxbHpSTEpwZGdD?=
 =?utf-8?B?dXdFQkpzbVg0Z1dxVGtNeWczajJ1R2U5QlhlWUtpSXZaSHpWWEE4YUdGNU1Z?=
 =?utf-8?B?NC90TjJOM28zSDlVdENEZkR5cTRjOE5WeFB6MldlVEdNZ2F0bWdRNk9yd0NW?=
 =?utf-8?B?UzdOVHNPUUNiY09RYjF0cVc1VExuTGFwUHE0cmkvMGg3bGdlTUt1ZmN4djdy?=
 =?utf-8?B?eGVCOU56SmN4SUlZOEpBbGpaWWRKZDc1ZTRkbGl1WDIrVXp1SEZRcUpVcDlY?=
 =?utf-8?B?VXNXMkI0MEpjNG9ZQmFXM1NPM2tObC9Gd2NZa2NHc3J0WFRSOU5YK3BRSGZW?=
 =?utf-8?B?ZURwdGQ0ZTYxVFdUZVAzQTRETytMb1FNMERtUHdVdUFFcjUyZEF0Vmh2aGkv?=
 =?utf-8?B?UFlRT2hkZGd2dFhSbExPbDBvZ3RReEZvYWpScFpIUElxUFE2Lyt2a1pjK25j?=
 =?utf-8?B?cFZwRmJSN1NQNWFmczNGcHdtTnJzR0YzVTgrUEFtNXdHbnErdVk0aEJUaFFT?=
 =?utf-8?B?SXVwN29yS3FxU0czUXpxYzgvTGtFRFY1ckFFWlFCcjNKcXRDREJEd2VQbHRS?=
 =?utf-8?B?Zk9TVUdYZURaME0vem5yTEY1N1NFYmt2anJBRUFUVzdKQUw0d09WWHZaK2tB?=
 =?utf-8?B?aURsTmwvWlVQdG9EZzcrQ1QzQnhEcnZNQ0xtV1A1K28vRGJlem80ZmN1RFJB?=
 =?utf-8?B?ODdsZVNNUUR5eGgwODdCbnZBL1FMaHdUVWFPcmpVUG94MEdVK3hkNHAzWHBE?=
 =?utf-8?B?c3RIZ2NEbFdjbzBkYk8yUnY5WUZiTDIzd0JsYXIwZEt2VEQ4ZFZQcyt1TjVK?=
 =?utf-8?B?MlA1dDdETWhoMk1MVUVUbFBhdUZELzN2b3plN0pJVzRuTjFRVVJFcXI5Rnpz?=
 =?utf-8?B?bVBsOWZKcklqbkYrSEFvWSt1c0N4U0J2Mk1LSTJHWlJzV3k2YTNpM2V0RmdY?=
 =?utf-8?B?TjczRWZ3T1B1UFBxUUtLY1hUMlpZQklBOGQ4OS9kK25aNjMzSnd4eHZXZ084?=
 =?utf-8?B?UnN5eU1BVTZoMzhGRlo1QklXWmllL0VXaE1TN0JQb2FYVFZnVjd4VUVtK1hv?=
 =?utf-8?B?QnFvSGc1R1lXSXZJWk1pVGg1c1JmMnZXanJXWEN3N1NMbGRFZDRSd2VXbHJC?=
 =?utf-8?B?dGw1bWtvTi9ZWVFZMzZrb1hCR2NtZFQxK0E2akZ5UWVJVko3QThoTTZvYnNE?=
 =?utf-8?B?YjJaSCsvSWpadGd4bmUzNXRoNTNYVmVwdStSMldHcm5hZ0xpUm5IbHNZNXhN?=
 =?utf-8?B?RlpPbGxhSEkvazFjWFEvcUh1Z3FZdVdZdTlmUldsNFdUUGtiMWJSQTJZcDQ0?=
 =?utf-8?B?K0NGT1J2eFVhekNaN1FaazZmM2pmNzVva1BmaHFUdCtsblI1dmpqOFF5aUYx?=
 =?utf-8?B?L1VmSUc0dGlXZEQ5NHVQTE4wTXpFejlpWEozQks4OG83SnF5N3lxWmZTZ1B5?=
 =?utf-8?B?VHZWNzdMSVpaT0ozNDFPSTBCblFaVW84Y2JKVU9mU2tPVTV5UDVNSTMxakVh?=
 =?utf-8?B?MktRYzhYTCtQNnJtOGJKV0VjUVYxV2RNQVFic2pHNGd1cWZnckNQQnNqLzJZ?=
 =?utf-8?B?Rk1SQUhreHFVVHg2cTY0R2VjRXJqdmpMVldFMXArbFkvQVlKcyt5eVB3aWFR?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e92aa-f669-4b4e-8731-08dddeb8b085
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 00:38:17.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef7cdm6r4bey/mxKX8IUIUZeunE6OG6lCEqeWuE+tk0UzQJgsizcMpdN1tWFsTOp7sXmvAu4TKCe0MqEX/osZ4XxT/hyiJpwjuSshAsgyOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
X-OriginatorOrg: intel.com

--------------c0OVcBB0Z9cvCZRYATDUgy3W
Content-Type: multipart/mixed; boundary="------------m3WlUzZrrsX2elULJZFG5V95";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org, horms@kernel.org, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, jaroslav.pulchart@gooddata.com,
 jdamato@fastly.com, christoph.petrausch@deepl.com,
 Rinitha S <sx.rinitha@intel.com>, Priya Singh <priyax.singh@intel.com>,
 Eelco Chaudron <echaudro@redhat.com>
Message-ID: <dd8703a5-7597-493c-a5c7-73eac7ed67d5@intel.com>
Subject: Re: [PATCH net 3/6] ice: fix Rx page leak on multi-buffer frames
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
 <20250815204205.1407768-4-anthony.l.nguyen@intel.com>
 <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>
In-Reply-To: <3887332b-a892-42f6-9fde-782638ebc5f6@kernel.org>

--------------m3WlUzZrrsX2elULJZFG5V95
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/18/2025 4:05 AM, Jesper Dangaard Brouer wrote:
> On 15/08/2025 22.41, Tony Nguyen wrote:
>> This has the advantage that we also no longer need to track or cache t=
he
>> number of fragments in the rx_ring, which saves a few bytes in the rin=
g.
>>
>=20
> Have anyone tested the performance impact for XDP_DROP ?
> (with standard non-multi-buffer frames)
>=20
> Below code change will always touch cache-lines in shared_info area.
> Before it was guarded with a xdp_buff_has_frags() check.
>=20

I did some basic testing with XDP_DROP previously using the xdp-bench
tool, and do not recall notice an issue. I don't recall the actual
numbers now though, so I did some quick tests again.

without patch...

Client:
$ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
=2E..
[SUM]  10.00-10.33  sec   626 MBytes  16.0 Gbits/sec  546909

$ iperf3 -s -B 192.168.93.1%ens260f0
[SUM]   0.00-10.00  sec  17.7 GBytes  15.2 Gbits/sec  0.011 ms
9712/15888183 (0.061%)  receiver

$ xdp-bench drop ens260f0
Summary                 1,778,935 rx/s                  0 err/s
Summary                 2,041,087 rx/s                  0 err/s
Summary                 2,005,052 rx/s                  0 err/s
Summary                 1,918,967 rx/s                  0 err/s

with patch...

Client:
$ iperf3 -u -c 192.168.93.1 -t86400 -l1200 -P20 -b5G
=2E..
[SUM]  78.00-78.90  sec  2.01 GBytes  19.1 Gbits/sec  1801284

Server:
$ iperf3 -s -B 192.168.93.1%ens260f0
[SUM]  77.00-78.00  sec  2.14 GBytes  18.4 Gbits/sec  0.012 ms
9373/1921186 (0.49%)

xdp-bench:
$ xdp-bench drop ens260f0
Dropping packets on ens260f0 (ifindex 8; driver ice)
Summary                 1,910,918 rx/s                  0 err/s
Summary                 1,866,562 rx/s                  0 err/s
Summary                 1,901,233 rx/s                  0 err/s
Summary                 1,859,854 rx/s                  0 err/s
Summary                 1,593,493 rx/s                  0 err/s
Summary                 1,891,426 rx/s                  0 err/s
Summary                 1,880,673 rx/s                  0 err/s
Summary                 1,866,043 rx/s                  0 err/s
Summary                 1,872,845 rx/s                  0 err/s


I ran a few times and it seemed to waffle a bit around 15Gbit/sec to
20Gbit/sec, with throughput varying regardless of which patch applied. I
actually tended to see slightly higher numbers with this fix applied,
but it was not consistent and hard to measure.

without the patch:

Without xdp-bench running the XDP program, top showed a CPU usage of
740% and an ~86 idle score.

With xdp-bench running, the iperf cpu drops off the top listing and the
CPU idle score goes up to 99.9


with the patch:

The iperf3 CPU use seems to go up, but so does the throughput. It is
hard to get an isolated measure. I don't have an immediate setup for
fine tuned performance testing available to do anything more rigorous.

Personally, I think its overall in the noise, as I saw the same peak
performance and CPU usages with and without the patch.

I also tried testing TCP and also didn't see a significant difference
with or without the patch. Though, testing xdp-bench with TCP is not
that useful since the client stops transmitting once the packets are
dropped instead of handled.

$ iperf3 -c 192.168.93.1 -t86400 -l8000 -P5

Without patch:
[SUM]  24.00-25.00  sec  7.80 GBytes  67.0 Gbits/sec

With patch:
[SUM]  28.00-29.00  sec  7.85 GBytes  67.4 Gbits/sec

Again, it ranges from 60 to 68 Gbit/sec in both cases, though I think
the peak is slightly higher with the fix applied, sometimes I saw it
spike up to 70Gbit/sec but it mostly hovers around 67 Gbit/sec.

I'm sure theres a lot of factors impacting the performance here, but I
think there's not much evidence that its significantly different.
>> Cc: Christoph Petrausch <christoph.petrausch@deepl.com>
>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>> Closes: https://lore.kernel.org/netdev/CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfp=
r7dnZxzGMYoE44caRbgw@mail.gmail.com/
>> Fixes: 743bbd93cf29 ("ice: put Rx buffers after being done with curren=
t frame")
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at In=
tel)
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Tested-by: Priya Singh <priyax.singh@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_txrx.c | 81 +++++++++------------=
--
>>   drivers/net/ethernet/intel/ice/ice_txrx.h |  1 -
>>   2 files changed, 33 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/e=
thernet/intel/ice/ice_txrx.c
>> index 29e0088ab6b2..93907ab2eac7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>> @@ -894,10 +894,6 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, str=
uct xdp_buff *xdp,
>>   	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
>>   				   rx_buf->page_offset, size);
>>   	sinfo->xdp_frags_size +=3D size;
>> -	/* remember frag count before XDP prog execution; bpf_xdp_adjust_tai=
l()
>> -	 * can pop off frags but driver has to handle it on its own
>> -	 */
>> -	rx_ring->nr_frags =3D sinfo->nr_frags;
>>  =20
>>   	if (page_is_pfmemalloc(rx_buf->page))
>>   		xdp_buff_set_frag_pfmemalloc(xdp);
>> @@ -968,20 +964,20 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, cons=
t unsigned int size,
>>   /**
>>    * ice_get_pgcnts - grab page_count() for gathered fragments
>>    * @rx_ring: Rx descriptor ring to store the page counts on
>> + * @ntc: the next to clean element (not included in this frame!)
>>    *
>>    * This function is intended to be called right before running XDP
>>    * program so that the page recycling mechanism will be able to take=

>>    * a correct decision regarding underlying pages; this is done in su=
ch
>>    * way as XDP program can change the refcount of page
>>    */
>> -static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
>> +static void ice_get_pgcnts(struct ice_rx_ring *rx_ring, unsigned int =
ntc)
>>   {
>> -	u32 nr_frags =3D rx_ring->nr_frags + 1;
>>   	u32 idx =3D rx_ring->first_desc;
>>   	struct ice_rx_buf *rx_buf;
>>   	u32 cnt =3D rx_ring->count;
>>  =20
>> -	for (int i =3D 0; i < nr_frags; i++) {
>> +	while (idx !=3D ntc) {
>>   		rx_buf =3D &rx_ring->rx_buf[idx];
>>   		rx_buf->pgcnt =3D page_count(rx_buf->page);
>>  =20
>> @@ -1154,62 +1150,48 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, st=
ruct ice_rx_buf *rx_buf)
>>   }
>>  =20
>>   /**
>> - * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all frame frags
>> + * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all buffers in fram=
e
>>    * @rx_ring: Rx ring with all the auxiliary data
>>    * @xdp: XDP buffer carrying linear + frags part
>> - * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
>> - * @ntc: a current next_to_clean value to be stored at rx_ring
>> + * @ntc: the next to clean element (not included in this frame!)
>>    * @verdict: return code from XDP program execution
>>    *
>> - * Walk through gathered fragments and satisfy internal page
>> - * recycle mechanism; we take here an action related to verdict
>> - * returned by XDP program;
>> + * Called after XDP program is completed, or on error with verdict se=
t to
>> + * ICE_XDP_CONSUMED.
>> + *
>> + * Walk through buffers from first_desc to the end of the frame, rele=
asing
>> + * buffers and satisfying internal page recycle mechanism. The action=
 depends
>> + * on verdict from XDP program.
>>    */
>>   static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_=
buff *xdp,
>> -			    u32 *xdp_xmit, u32 ntc, u32 verdict)
>> +			    u32 ntc, u32 verdict)
>>   {
>> -	u32 nr_frags =3D rx_ring->nr_frags + 1;
>> +	u32 nr_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
>=20
> Here we unconditionally access the skb_shared_info area.
>=20
>>   	u32 idx =3D rx_ring->first_desc;
>>   	u32 cnt =3D rx_ring->count;
>> -	u32 post_xdp_frags =3D 1;
>>   	struct ice_rx_buf *buf;
>> -	int i;
>> -
>> -	if (unlikely(xdp_buff_has_frags(xdp)))
>=20
> Previously we only touch shared_info area if this is a multi-buff frame=
=2E
>=20

I'm not certain, but reading the helpers it might be correct to do
something like this:

if (unlikely(xdp_buff_has_frags(xdp)))
  nr_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
else
  nr_frags =3D 1

either in the driver code or by adding a new xdp helper function.

I'm not sure its worth it though. We have pending work from our
development team to refactor ice to use page pool and switch to libeth
XDP helpers which eliminates all of this driver-specific logic.

I don't personally think its worth holding up this series and this
important memory leak fix for a minor potential code change that I can't
measure an obvious improvement on.

Thanks,
Jake



--------------m3WlUzZrrsX2elULJZFG5V95--

--------------c0OVcBB0Z9cvCZRYATDUgy3W
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaKPHdwUDAAAAAAAKCRBqll0+bw8o6KVJ
AP9/JO6Aj2Hpqc4XEMCFcxGslHa+wqHLLO6ovTzu0dkCvAEAiypxDO2oN6iLMzcHg/B44rDmQ6qO
K5YDJe7a3Ca8SwQ=
=dolv
-----END PGP SIGNATURE-----

--------------c0OVcBB0Z9cvCZRYATDUgy3W--

