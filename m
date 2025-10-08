Return-Path: <bpf+bounces-70624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0BBC6DD2
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 01:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4716E189C791
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D72C11CD;
	Wed,  8 Oct 2025 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nphGgPEA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437328632B;
	Wed,  8 Oct 2025 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966253; cv=fail; b=MbgKrWh05KEQKDZZZ5P+GoXzQATc0eDITF/dB0m+0w4lQFPPefbvHOGIVFP5eQWOT5K6RQLvDP/h13FNYKJ921N9HD6Rt02zwnjeBG/0Sr4PWi24aGtzLGgnr+5IjnNRGe1HBTLPfTkDmyav07IsHmhH+I2R6rEp1L0ZylPGu5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966253; c=relaxed/simple;
	bh=lZ0MBeO745egRfbMCn7SiLJD0uuCnXaYi9Tl1k+d554=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LNuFM2rdBZ+MO7NorB93pdmTIzsNm6sb8/MjipVTeqjBFIe+aGwPGdkgEsS29T3Hr+CQLzL6LOA9Nm+H+0jKYVFF2Of5HfvypbEBBe1ym3gnitCNvTkYFz80G5SX6GPCESnKl9stGqok1MXx8QSl+XnD+o9Nm2/s7jowgpxKW30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nphGgPEA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966252; x=1791502252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=lZ0MBeO745egRfbMCn7SiLJD0uuCnXaYi9Tl1k+d554=;
  b=nphGgPEADW7XcfngC6tZqXjtJDj8VZahXJtMRNlgf7C5rM2r3nsSwxjJ
   N1z6K8pE1i4C/h3dQ/xxijKTIXvnqE5t3Gf+sfRVQkio1n3DOUndTrbxM
   5bVSb6xYdioYfdBIdcQ560bgCEb7NLk6l1G/2XPAgmMR4Rvto3tK2Y0MO
   U5sn5Eypn+zQpWp6R/EmZ1lmNXuwGtLXc0Wi88rTsscRRX/3B8XG423qq
   wvOrO2xn/9w6skXj/EyykFnZyd/fwPW6+KQVEr+GKKJQRN7EOQkgYobtc
   o6DA5yXSZC1fRp1Zn/YdaRIPw34zMtP4SBcLN5Huypuo/2eihuNyNb8Io
   A==;
X-CSE-ConnectionGUID: Yk1Zc6O6TMOAE05+yxcz7Q==
X-CSE-MsgGUID: h8y7POoHRGGaRgebiydXaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62201829"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="62201829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:30:51 -0700
X-CSE-ConnectionGUID: Mm/IcU9zTcipfN9ooYGNLw==
X-CSE-MsgGUID: Ay5oQW8LS3+UYaSxrHPMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="185687730"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:30:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:30:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:30:49 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMZ1ANwhGzMFnWH+kJyzBCRk7LCqMb4zisFyca3LunwsjAo4DszbnM7MgyCGHwISjASX6soxNqV2t2ERlLvqJxqxbJIUiY+7vhAJWr0aC0ugdMhTbtWSysCTBea6WAeCYZ9i1SW8ErsWRWJ0/c7Oorvp65A8DAU80TJRzfBNWHpIdKK35msOEpiaDCapkLPFw2sUwa9Iw+AqrG9DVRSAP9yfbWzeTrP6eArQtO2zXndNuu9f8Bf+o1Eau/4woMuaTmX59KkaIxNg6TWObO6BtWxO3IpyutfLvcs9z49jJpTtFbU0fj5PkxlTGD3qutFQRPmdLIQvzsNtpPN9h+kD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ0MBeO745egRfbMCn7SiLJD0uuCnXaYi9Tl1k+d554=;
 b=HpxfBPpLXM8AbKkuI18cydeUe1qpPopzxvegHxQIKppk7A49r3Aa15fOEuaRTOwkqJ+OYIpw8WBvUxvqOhsRN9ppv9d5XN6innx94bEhVIq7BkZcj3gXTGoztbYigglKxiMMspMPLSw1AgK+nMJa37oBTYf5C8EyLeQy523tR+a91F35WQGyrHuJDD3EpShaQ9vw/mX65P/bkGLP5T/tUTLmZsuXA6tC8BVEMUD1rYES9yPlhtZbxMbIiNC3Ftref60ep+E6nmYjQUUWSirh/2Gkh2rmQCkMUDCFLIibvOQSJ7JoVu02twqydAEGEJhBZWMXyfxz/WIcOVRRUTLaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:30:43 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:30:43 +0000
Message-ID: <91d4b9cd-fe8f-4101-9d9b-5fda4d7ca404@intel.com>
Date: Wed, 8 Oct 2025 16:30:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/9] eth: fbnic: fix saving stats from XDP_TX rings
 on close
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<alexanderduyck@fb.com>, <sdf@fomichev.me>, <mohsin.bashr@gmail.com>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-4-kuba@kernel.org>
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
In-Reply-To: <20251007232653.2099376-4-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------J8HCBrTF0QXHUloVNOYPJ7VS"
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 231ebf58-9ec0-4c6a-dec9-08de06c2b30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVdmWFJFbTErbU8vOHV3dVhaMmFXYlBuZ1M3Y3BiYTNqZUpCZnFLTkJtMysr?=
 =?utf-8?B?OXhOcXhEUlM4cGNMR2xmUmNsNkxwMW1YbmdVRldIK0xaQ0VaL3o0TWtNaTFy?=
 =?utf-8?B?N0lOdGlpbjhGWWlBRUhJK1Zyd2NYYTZqUHhCNGVlcFdFK1U4Rkl6TFZHQjc5?=
 =?utf-8?B?dUl5QW43SGdPVnRPaGM1ZUhmbkZCc0djTzVlWEc4c0VsT21TbEtBVFJUeGJO?=
 =?utf-8?B?TVYzR05WZXJoTlJxOU9aS3laRzdWQ1RTaDU3RlA2anJDWmJUSlRlaFNWdnIr?=
 =?utf-8?B?dkgyUWVMNFVlaTJLTUVZRkk4MHk2aUlYYWlqTnpVZmVqaEk1U1BGa1VPMW5J?=
 =?utf-8?B?VUdVVlFvNFBKUGtRMVlSaUdudm9SSkgvYm5EZmhCak5UUGV2cXZFWWRBbUFs?=
 =?utf-8?B?dzJrbi9rMGZtWm9MT1RWblpVVGVLNlBSdG83Q3FmWENoWG1BRi9ydzdZa3Bz?=
 =?utf-8?B?b29DTFdHNVY5cVg1elU5ekN3dXdmbXh3cTJCMHpnc3orTTRmclNSM0J5Ym5K?=
 =?utf-8?B?bmQ4Z0drOW9vQzBFUlI0RzAzVnNDaXdlSEpDTEpkR2VZRnBlYjdidFdqRnFs?=
 =?utf-8?B?TFdOUkNjazVjWXRtbFo5QkoydTd1OXJIaEFRc2tSVmZTY2JkZUpZcEw4NnVU?=
 =?utf-8?B?YVlRL3BMK0hmQmw2WVcxMDdNdHdRYTFmemdwUUdMVTFzc3R5cXpwbmRNd2RV?=
 =?utf-8?B?K0JTZDQxbms0R3FkektGZ2tnaWg2TzBUN0hEWmQ5bmdXc28wTVM2YnBIUlB1?=
 =?utf-8?B?SktQcXNDK2tTZ3N5eG4rUFBzYTR6SE1HZURLR2hlR1RpVHdNU3B5SnJZZkRp?=
 =?utf-8?B?dlF4S01QNkhRV1VMaStmcXJJVGVsVXU3K2pIRG9Jc0d0am1nQ0RXZlFabDBl?=
 =?utf-8?B?NktNNFNEbVR0UG0wRTZEQi9qVTFTbjlEV3hRVG1Va3JpZndLV1RvNklkdnlX?=
 =?utf-8?B?RjUxdWhDTkhjNElCTHNQUU9JRzFWRjdLak1BY0pPRFNjZ0FpRXZSdnlYYUgz?=
 =?utf-8?B?QlJVZmtINmRKeHNmSWMzQmgrM2RWcC9JbGF2NEtPMERvWU8rZ1JwV2hkQ0Mv?=
 =?utf-8?B?TVlUeGZoWHFFU1dJRGVwOTNET0w1OFp1QTBHVEN4NkFqV1h0UTljMGFMNnJR?=
 =?utf-8?B?UVc3ZDRQYytqMTU2R3FtYjV0UjV6ZkR0SGJSb1E5MVZKeGxjT29YK2NDNlE3?=
 =?utf-8?B?ZUxsSzJNM1oxaFFDYk5acVhWSUlxS3RwYXJtQ0tsTTVYeWxOcnZsUTlMeVVi?=
 =?utf-8?B?NjNocWkwaE1iZmFocjN0ZzFuNUFSMnV2QXphSmQ5QjhUZ1N5U21Td01XRERI?=
 =?utf-8?B?VGVaWC9WeEY0RTVKd0MxMHV1MFBFZ2J6YldrREMwT2JISDZ6MnBCN1c5TXBD?=
 =?utf-8?B?K3BCTmxHbkFoclJ2TWtqVldsbysvMC9jVTJkNFljMzc0Q0hIRDdRZjIyTUdx?=
 =?utf-8?B?ajlpa1FVWk1IZ2lWVkJOYW5wam1aS2N0UmZXWjBCL3NRL2VLSlptbk80Y2k3?=
 =?utf-8?B?elNNMXpkaVhTTEFZNVV6VUlZVldtdzRMSVpZQUhYekg2VkVBQlA3bFpqMDlh?=
 =?utf-8?B?cDJnU1JwM3J3Nm1CaU51UDRIK1R4YU15YlBrQTR5ZFpWSlFVcjlkb3JwSG5j?=
 =?utf-8?B?eFpBSDhvVlJKOEQ0dERwVXcweUJvS21tdTZ3YktheUxoZHhPVjE2OVZyRDlj?=
 =?utf-8?B?bXZDby9tdFhkUFhya3lwWG90VWp4Zll2cTA1SG9JMXBmY3JrbkdUWlFndGQ2?=
 =?utf-8?B?M09iSitYZWlnL01HdzdTR3J0TWJQOU5wNjBTRWd0R3o2em5NckgrMnBGc09I?=
 =?utf-8?B?TXplWWlEYzdXK2pSVWpvdHBRbGg3RVplbzdaZ0F1Z3RqRU1PWldHSi9MaXNj?=
 =?utf-8?B?N3F0R2F6ZEtpekQyMEkwZGRQUjNMOTF5ZlEyVk9mdmdCd2J4MmVtOFVsNXNW?=
 =?utf-8?Q?eLKlyrGElJDclA6ViC0WBDVIOKyjGiw5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdCdnloK1NVZzAxRXNaWkc0eER4eFhRek1SNERVbGpwQndYU0hPV2NEZlhZ?=
 =?utf-8?B?S3c4bHFHUnRxUHRWZGE0VXN5TEpwNm9UWERxbTM5TFYxNXBCV1ZHTjhCb25s?=
 =?utf-8?B?WGVsNWdReGxJc2dNSWZuTFRvVDJFUHFXM0hDbGwzV2ExZE9abktUbVhUNit4?=
 =?utf-8?B?ckhTT1lUaWJnVjBpTjlPeXpHQnJ6aFY5aGQySWMzREU3TUlKWmFmclhJRS9G?=
 =?utf-8?B?N1AxSmcreDdoZFYxdmNJYzhSYkRnbDV0b1IyaStXSnNFNDIxWnJSaDh2Yytm?=
 =?utf-8?B?bjNXL3JPWndVOXI0YlhTRkM1TzFQTVVkeUZMcjJTcmFxZmFTZjl5ZTRvNUg3?=
 =?utf-8?B?bVhKeW1PK1IxbDVLZDVFTkl4QmZnQ3FKWGV5M2F2a0dTY0RSNURlTDdNZ3Fl?=
 =?utf-8?B?NzJPR3FKNzY5YzR6NFdkQTd4NWV3THRGNG9nT2NJazRoSDhGd1BvNVVWUjFC?=
 =?utf-8?B?K0ZUVjFVSmR6dlZrMzdGZmR1dG52NnBybDhxVW01SER4aEkxZFVPaWduUEp6?=
 =?utf-8?B?SEtkZlQ2ZzVmdjNmSkhnQ2ptMnpDOHY5VjlVOFR5RXZaL0NHRkxYOEFDMk95?=
 =?utf-8?B?TVFJak4wVUdjTklha0o0Nk55NTY3anh3RitJQnJOLytqTXV5N085cU5JOFgy?=
 =?utf-8?B?ajNKSkhYWXVrQ2F0V0poNnNRL0xISG1iRkpYM0FxUGZqVU44K3RtZ2k3Skp0?=
 =?utf-8?B?OTJ4U0t6UUtYNTAzZmhXNmhRQVMzalp2NU8wUWpuYS9oYzJLNzhOK2NqaEFj?=
 =?utf-8?B?NTh5Wjdpc3dDemlyV1lQcWMxTm5uTjI1N3U2Q2cwNTJLc2x0am5PVkpRc3Bp?=
 =?utf-8?B?Tis3eTFHb1NJL3JsN3JadE1LNEYydnZvSUh1eXZFSXdWZWtCcjhVSldUcEtU?=
 =?utf-8?B?V2NZVDdNNjhlMFA0MUtjTlNjZGVHVUs1RlZ1RFQ5ckRkZWh6K0NYN3M0N3do?=
 =?utf-8?B?Qi9HTVovSmdYLytTdmFTU0hVVHNrd2pTSHMramtYK0kxQ21nSmVRZC92WWVn?=
 =?utf-8?B?QmQzK1VzOWJMeHpsN3lIaU5uMyttZ3g3U0IvczAvV1lrYlZ1dVdMZHZlV1ZE?=
 =?utf-8?B?VnY1d3BrUUxsd3NNdXR0dEwrU2c5ZEgwSmNIL04vS0dWZDRObzhvZDRQSVYv?=
 =?utf-8?B?NGh1NURxcGdsRTcyQzBaMnQ2RFdUWWhIRUVqQytmendEblJudTNVa3hRMnU1?=
 =?utf-8?B?ZVdQaXFOWlE2bU9NeDNoaitYeUgyeHpZUjVhSXdBWSt2SngvUVpQT1JLMlY4?=
 =?utf-8?B?c0U0OGdRM1kvUC9qbWtjbFBoZnVyZlFqWkhscms4NFcvQUsrN01XR3dOZk9Y?=
 =?utf-8?B?c212L1NFMndQajBnVnRieWx6N21yNkxOZTVyRnVxYXpzWnB6MjNXTmZBNzda?=
 =?utf-8?B?c3hpYklqZm9qdWRQZlN1OWZ1MGlib1o0QVBseGNNYXVwRDByRmUzS05PYU1t?=
 =?utf-8?B?WEoycmJmSEpDMG94WmxESmM2anpacTRhNU5hWmhzZnIyOGNyT3o2NjhDaEdV?=
 =?utf-8?B?bllVWDFVaDhITFV6WXE4VGovNHQ0YTlLa2VjcEhIaU82UWtTbDJNYis0SkVi?=
 =?utf-8?B?dzNGUjIvVHh5by9VNmxaU1djSFlzTnVnWW1vMGg5VEpmd2tKdFRMRlQ3b0Jp?=
 =?utf-8?B?a01aemJ4RzhLSUsrc1VQck1TUUpvNWcrMitOcm8wY0VvZklYQm5ZZWs3S1Jt?=
 =?utf-8?B?aVptRHFzeFlobTdvQ0xyWCtHSEFzZG5Cd1krUHIzUDVnMnhqL04xd3ozcXE5?=
 =?utf-8?B?cE96eHlJcHh3WUpLV2NjTUdkYmZkQUFmVktDWW1OYVBLSGhzb2p5VnppOS9W?=
 =?utf-8?B?czRkVnB6VFhHNDRaa1FKYkJ2dmZvM3Z1MmU1ODAvTW9HWUwwQ3M5b3kzY2d4?=
 =?utf-8?B?bmFTczZPWHdKVmtqQmxQaElsN2VaSGNIQnl2VURKb0oxYkFmdHhORENYRGEr?=
 =?utf-8?B?WEpjbkhEUk5HeW5GbnNpR3NERFlTcE5UQm9DZkd0cEh5SEJyMGMwa0I4aVpy?=
 =?utf-8?B?enhoNVpWcmovcG9sUzJESThxdWE0ZGNkN1B3Smg5N0FpRUtTQmJqcjMvRnVK?=
 =?utf-8?B?UVpkRUh4NmI2ZUl1UFVza1BUUUM4MWV4MlYxSGs0ZDlIS0REdVAvQWdGQmRD?=
 =?utf-8?B?WHV1T1lhL0JRZkE0YXZIVU00K1UvQmNoQ01aN3ZMTGRFbHY1YkZwMnlCOFFH?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 231ebf58-9ec0-4c6a-dec9-08de06c2b30c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:30:43.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8ndPW5GqusDq8bqH/OCyO7+5iw+OaPOvU2s1rvZ6nJb5htonU1KZGXxAaCihzRSdKWCTA2U2meYmbWcHHTiv/v5jfiNwYQ+9iHuN3DCCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------J8HCBrTF0QXHUloVNOYPJ7VS
Content-Type: multipart/mixed; boundary="------------cbORNuN7ICXm85PalvGGzeRS";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 alexanderduyck@fb.com, sdf@fomichev.me, mohsin.bashr@gmail.com
Message-ID: <91d4b9cd-fe8f-4101-9d9b-5fda4d7ca404@intel.com>
Subject: Re: [PATCH net v2 3/9] eth: fbnic: fix saving stats from XDP_TX rings
 on close
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-4-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-4-kuba@kernel.org>

--------------cbORNuN7ICXm85PalvGGzeRS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> When rings are freed - stats get added to the device level stat
> structs. Save the stats from the XDP_TX ring just as Tx stats.
> Previously they would be saved to Rx and Tx stats. So we'd not
> see XDP_TX packets as Rx during runtime but after an down/up cycle
> the packets would appear in stats.
>=20
> Correct the helper used by ethtool code which does a runtime
> config switch.
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------cbORNuN7ICXm85PalvGGzeRS--

--------------J8HCBrTF0QXHUloVNOYPJ7VS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb0IAUDAAAAAAAKCRBqll0+bw8o6PSI
AP43NUaeKU0oM9F4TGdEL2mysqU9Dao2D0aqLS1i6FAbNQD+I5MxbAoKSdC4O20MW/MkTdenfZ80
02VZpBmj4mgqswQ=
=89pm
-----END PGP SIGNATURE-----

--------------J8HCBrTF0QXHUloVNOYPJ7VS--

