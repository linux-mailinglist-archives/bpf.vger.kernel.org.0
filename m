Return-Path: <bpf+bounces-70623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D67BC6DCE
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259834EA145
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7C2C234F;
	Wed,  8 Oct 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUgm/ZTi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847442C2357;
	Wed,  8 Oct 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966208; cv=fail; b=YwvAnB9xz/hvRzQj2beAqp5cKkKykJ4cPt34nj15cKztRprQHGwUspIVlhraf8qNxJCjL3sZRkRtxCg721tCChujvSbbWqEYMF5bqNXy0hVuOhI4ezLXwvxXjovQb2GVtNyYlQ9gHqLFebFgl0IKrO9aNzXUe5DYM8bX4EfjMJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966208; c=relaxed/simple;
	bh=Oc0896r2o27qpjdAL3HCK+pu4/T3rEv/r+81WPO8X5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hwm+KfPBEB8wDI64AgXjEDNBdGI37NzLng/ovgnKunhGKPoRX+poWMx+X1GG5vih+AIVlVk5H77aGHpCQj2KWFjmLodD2W3TQRqxafSthEzeZQMwpf7UO1nw6oMWY5IHPG57U/9xuGU3WBnwAPWhKRlnOWvmRsyHYNglDgzwaCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUgm/ZTi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966206; x=1791502206;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Oc0896r2o27qpjdAL3HCK+pu4/T3rEv/r+81WPO8X5U=;
  b=NUgm/ZTikdsCvfrvjaDAOY+aTUxy37pL+i6yeDiB1ZEY/LfuiU7Sm7Ss
   AP0BmgBRp6Gt8/iz72KeZsZZjpWdSFyUUH2fH5PvxC7idmWCNHR3atfqs
   4BPCEXcxc9IYpZI4StapkkafBsZU0r+OxAzpYncauF+lHRVxJnwfLzc0D
   CRcmYGYd/ZVKCf83fnkUQAYe4dqQFN+XAe8zdBza8eeQqnhHz/n7fXnl2
   4shUd1bpNAayQDFTQseUJTPbzR54A8TKsFp4gAJ8MV5ZRHYhDknPudF4k
   d1xhQNpchr98AzxdexENZK++VQLtx0rRSyv9sjpcj14VCfIWnxhKjqzY3
   A==;
X-CSE-ConnectionGUID: VbWH5ceTQxaB3bviluucNw==
X-CSE-MsgGUID: cblAGopbRLO1qU4+DzcskQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73518273"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="73518273"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:29:58 -0700
X-CSE-ConnectionGUID: GSrEObcPRt+9XJd7IbsI2A==
X-CSE-MsgGUID: Eu3wH7NuTF6GMoeiUjGuVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="204278158"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:29:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:29:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:29:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJbBrc6pHmARYc6W+PhLNOSTxYmYJuXEIHv+Z2ZUAY6Ze5Xc1IYjA4pd/BfN3dfykw6NmWXk92AZnJj71Sb6NL/KZPBCYWcERN88XHpiL+MdZIZheI/8QSuIV4MVNR5m3A4lg5Cu7p/jeX+AfRK5xHuVOEvEQOAUkJPtSqVgg85RJXleT4Wvd4llwEfdJhEighDEexvCNLckOEBp+khYNODGkgX6yPRsVJDkXQ97Ko4bu6MqO+C17Qt5/I2EljQerQbwq+f0RAhRXOScdg+Z8QY4n/Oy/sEr2CPtdge4rWyVch9WSWZFH+6bALLz39X/kUucrDlvGSWpFH9FF9NLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTomP+zaFDI5BIsT+a0HRVbMnFOuwkDL/nWc0dR0yJg=;
 b=ISrSseY8XxzNinVKohQ5XtLGH5R+7BCF2c4Qg8qk8dk/PV8DEFP5P28ww5jOTrzcex1ir+7WVJc4DstVJarurTMQholU5ejE8GLGKOmXp1DKCQ1G//WXznr8VrqHpblKm7qEBL3gQLewTxJZXPJYEiyCgPLJpkFBvJfhZx1GhxTeeHGi8NTPkoyKoknjemBse2c/ZR3DJJBGeWVwCAOxsrtmngF2bMNf6M0s5L0c87bLCt0HdU4zC74cMUyx2dFvwBK/5/U+m+m1sbb7wuxOoDUiTWgwJHhfQ3uE4desyiKiDve43y3ppfKI6MCBBNWoNButEFDgRCEOLDsixQi+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:29:48 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:29:48 +0000
Message-ID: <4857a377-7034-4a5b-adc3-11f803496827@intel.com>
Date: Wed, 8 Oct 2025 16:29:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/9] eth: fbnic: fix accounting of XDP packets
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<alexanderduyck@fb.com>, <sdf@fomichev.me>, <mohsin.bashr@gmail.com>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-3-kuba@kernel.org>
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
In-Reply-To: <20251007232653.2099376-3-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------8NAmDEd3UmjCxZtMVsy0zkX3"
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: a857a7fd-8127-4bc1-fb3f-08de06c29264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm9sZm94RnpnbFpwMVE0cnB1NXJuZDBwSzhxV05XWXZ1eVNrOFd6c2hPUk10?=
 =?utf-8?B?My9KQWJVbE82a2s2ayswK1hpWnlJNGlRUEI4RDg5b29WYVRIM1BNV0Z2VVBi?=
 =?utf-8?B?UTNPWk1ySDVoRUVqUXhNdGlaMlhXOXJmYUs2UjY5bStzcTRudmR6SzR5RnNC?=
 =?utf-8?B?dFVkalpzK2dMS240RzZHeWVFcXRsY0paMXEyNGZuakhhWmYwbXlFdWNralNX?=
 =?utf-8?B?RENPYitYb0RIMjBLOGRMRlhLa21jakxwaFc1ZE51THJrVUpaVXRRczJwNEMy?=
 =?utf-8?B?cW4yeUJyYUNxSk82TjFiMXJQN0c5bEZmbVRrSDZkSVpZbGlkenVGZnpYTDMz?=
 =?utf-8?B?bTRyb1hWSEUyZDlseVpGY0FEM1p3SnA3djJRblZxa1NaekVybVV4Nm5ETlhM?=
 =?utf-8?B?MlZpZmpRNGo1MERJakVMNHp6WmFhYXNFWmN2ODhyOHRQa3BlZk5ZU29xSU1l?=
 =?utf-8?B?bTZKeVJGSXVYQjdqLzFnV2xFaS9KYTVTcmozV3BSMzNmTWE1MDRrNmtHWXM1?=
 =?utf-8?B?ZWNFdUhFWG4rNHY5dTBXM2NrNFdpNXdGTXFCODlDelR0Nm01TUtlSDdJZTJX?=
 =?utf-8?B?QUhsMEs5cklsOUVEK05XUGJVN2FvMUtIV1d2VEtQQ3FCN1JxSzU0ZzI4dU8v?=
 =?utf-8?B?aDV2dkxmKzd3OWdhV2diRDhBNGVicldCdVJoOFBWRVgzZlpnWHc2Q2x2WW1a?=
 =?utf-8?B?MmpYOW9YQTY5WTlXQ3d3cXNxdUErRE5PVDNJVjBLRDlYa2srSVE4aEVlT1h0?=
 =?utf-8?B?anZJVks1bGJpMEM4VWJTc2xyR0lOVG9INEozWklDVG9Kd3M4UC9WQjhoQnJW?=
 =?utf-8?B?bGNVcjliQ05jMGVEcGU1V2JpK0lnS2hzakl1bGRjZS9ydng5OU9kNVo4UGdW?=
 =?utf-8?B?Ri9ua29qczVnRUJNNThLcnF6TmdxWk9RMFJOV2FaTWdxak1xMXVCS3VidkVm?=
 =?utf-8?B?M2wzRzVvVmtzUHM0TWh0R3pWRGJHek9BeXRiNnhhNmxIYkp3aTFLNktwY2U5?=
 =?utf-8?B?QVBoMkVDVjZpeU9QQndvV0hFQjhOZmQvZVpJazMvYzdFOWVBSHFpK3FoOWtG?=
 =?utf-8?B?bGN5SzVmSlR5cXoxWGtSSHc2UU92SjBvNnhWTGVYeDR1Rmc5a2xHUXVEQkM0?=
 =?utf-8?B?UEZ6NTVKM3B5K0Zlem9ldno5RUdmMytxV2tES25ZY09LNVdsQzljWExpSVBI?=
 =?utf-8?B?US9LQlpyb2R2RVhsN1BDLytOdURjWnNSckFSY0EwODg0NlZ0Y0RabTYzR1Jj?=
 =?utf-8?B?ZFdleHpJcTlWandzOFZlN0M0bWZLUHQyZ3FGb00wakwraXlvRGgzRi9MSFlp?=
 =?utf-8?B?VWh5N1h0QmR4RDNpc0t3NVRSMjd5QnpKd3B4UFA1bG4zOFJlc1YxUXRyZlFh?=
 =?utf-8?B?UDNtbkZnVzZiZEp3QWFIVEhLUmVWanYwYUdCUHBNQ2QvOG1Fb0I0aGhieUZy?=
 =?utf-8?B?MEFNZURtUXFTM3FtcWpJdS9oNlhBNHJ1NE5oQ0tqaG9GOUNYaDZnSCtHNUg4?=
 =?utf-8?B?a0tJaElEZFJNWWkvRk1wWVc3RlRGL3VpZmRZenhpcE8xWGpiSDMvcHgwWFJF?=
 =?utf-8?B?OTlJRGpvTlBXZXE4OEkwY1ZxM3lHeUNhNTMxcXNUSmxTVUllWGxzKytaL2pG?=
 =?utf-8?B?L0NKS3kyNnlDVTNqQktkL2dUTmlxbTBRbW51bmlEaWc4Tm44d0pRSk5pa0FV?=
 =?utf-8?B?RDI4LzQ2MUlCcUtZUTNmMWI3RkxoQm5BTzdVWE5ycm1ub1NUS3ZIWXZEYTdj?=
 =?utf-8?B?NDVCSURLeDVFS1NSMlVVYkVoNFo2ZWw1cUtXaGo2NWZ4MFRxNncybVhkWW5I?=
 =?utf-8?B?VnZwTEFXYTBBYnhCSndWMkxjUzhWV245SEpwYXdsTTBGZTQvYmplbnJoeWFw?=
 =?utf-8?B?aGFZTjRJc2dWSGVnSmFRL2ZYQXJvQjBqVnVBNnRmZ2JNejkvWE1FelcrSjJE?=
 =?utf-8?Q?AeKrciv57SN6q9PiVDwrCLEQ1SJkZc6d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDFwZ1dncHhjQUJjQ3BReXZkczdIWFA4ektKU0hRckdZQnAxYmFvQ1ZDQnhN?=
 =?utf-8?B?Mi9mNjFsb2hBeUozNUxMWG1pcmdnQVBYTUgwUjRvbDZtbGMwYjhPTW9GM0VX?=
 =?utf-8?B?ZWZtQU5QK05nQ1NiV202d1ZMNnk5UU0rM1lIdCtTbHQ1UlBoM1lRMW05dTBC?=
 =?utf-8?B?Y0FCVkZzNlUrdWFpV1dPWEE5YThmcHVienlUWlVYWEh6cFBjTUhnQk9JQlM2?=
 =?utf-8?B?ait0bFJEWHloMUhaNnpJRkpoNjJiK2Nud0grTW01dXZHR3NnVXRzaHJJTlNi?=
 =?utf-8?B?dlNEUllFZ2ZOQlZSbkEwVm5PS05pS2p6SzR4VWpHRXkwQWNMNXl3U0tPOHZy?=
 =?utf-8?B?c3pWbGhmWkdGNVYySmZ1TnNhQTJGMUUrT3V2OUIvMnBldXVpbE9BOFJwaW5T?=
 =?utf-8?B?eWxOdzZtbVFyKzljaDlCcUlDS3dWQUxWUEdzWFI3ejRzelN5Rk96UVZrWjY0?=
 =?utf-8?B?MjNLcWQrQmU4TU9jOHlNdGMycm1kTjFGaVVxRVhhbHBWZ3RseU1lQStKcWFC?=
 =?utf-8?B?djQvWlhBallaZDVXZEV5Sm92eEMwUlo0SkpqcEl0YXY2UWpRWGFWb3o5VmVO?=
 =?utf-8?B?MjhTZVFsUm5hVWY4QW1ZQ09zcXBmUWtSNW80RjJlTlBwdlNFdkdFSHU0QkRW?=
 =?utf-8?B?aTE3SDlubGQ3YjZUN3F2MlZtczdJNFp1d2dwYkJTSFNFNHpYVWZQeElMOWlr?=
 =?utf-8?B?YncvQUFuQWxyUEw3VXEvV09DWnQvZGpVeEIrQVUrTDBaMHlhYXNVVEtHZVBx?=
 =?utf-8?B?UXZTb1pzczlQN0UwYzdSeUVTYzNJWnlyT2dCQkY0ZGxCc3dqdnNZR3ZrUlZW?=
 =?utf-8?B?ZVh5M1JsZEw4dnd6djBHeG5LcmJhUUFLVUFyaHN3S251aXhaK2VtaFF6S25n?=
 =?utf-8?B?SElZMVU1TkRrUTZ3RVBNay8zV2Y0RUpzRmhFaEQ2R3NKVWQvNFBCL1RISGFM?=
 =?utf-8?B?Nkpyc2dwM3BTd1EvSkJOSFpMNEM3eU9NeHZwaVpxL0ZNMEQyY244RnF6VlFT?=
 =?utf-8?B?S0hJcTNKRGdMeGlQNWVzWmVzTUJRS2ZlV2JTekhBVFFGdy8xcEY4M0F5dFBv?=
 =?utf-8?B?UGgzVCtuVEh1THNyMVZXeVpZRW5aV1ZRcytITjhEWTRiYWNZWmxsckFVeEdl?=
 =?utf-8?B?V2RRcDY3QWhJNW92Vm94MVN0UThMUFkyN0RBc0xkeHZVd28rUGtpdTVQN0Jo?=
 =?utf-8?B?cEZucFZoVDg5SC84MERWZ3V6MXozQTFYQ09jNHZaaEo2S1pIZUVTU2FNWUdY?=
 =?utf-8?B?L2hrTDN1R0x6R3U1NS9ldzEwRDlTcFo0Vi9jVlUvSEtNR3VxYkg3NElVYkF0?=
 =?utf-8?B?SVNRbUxJdzN4S1BCelJmV2NYdnIybHAzc1g2WmJDZWU0SUJrWGtlOFZYWEk4?=
 =?utf-8?B?RzcyR2YxM0JxeWxMbXFRbktkNG5mRUZPV3FEdWlUZHkzQlpYUlUyVnFNSTc5?=
 =?utf-8?B?VGdtOC82Z0pOcmQxeDFSUEV4dVRWblpvTmdJVjAwaFNqUTVsaFZsaWxINXZF?=
 =?utf-8?B?TGlGaXJ0Zjhab0cvMHN5MDFwVW1UT01qMXRrNFltS0FZNitXMG9mWUhwU1g4?=
 =?utf-8?B?clVncngxK3Jnb05YbitrY21jT1YrdmFxNnlGOFphOHc5ajM0clRpMGFJc3hz?=
 =?utf-8?B?Y0dxMjhtT0xDek5GTUsvSnZZMllNTEtJSGxEN3FKNk14WVpKOXI1SVZRTEpV?=
 =?utf-8?B?V1N2M29JMmIyOEV4OGFlK0pDQnhMVFF3UThMcDZ5MUZpRUtaZTM4bVg5M2Jw?=
 =?utf-8?B?cU5ncFNUQmMxSlRwVjgwT3pDbGRxdkVHTjhiTEtyWmJ0RitQM2pSaFpXZzA0?=
 =?utf-8?B?c3E4V3FyTGZCcWJBN1JJWXhpZkpTSWh3b0NxbmlOcFJmUTFoa3NJNnNSNlUv?=
 =?utf-8?B?NkNZQjRXQ2lvcUtLNE1YY3k1SmZZdkxObkVST3h6ZVQ2dG8yeElsUWJROVZK?=
 =?utf-8?B?MDlVT01lazZTcnRab2E0SXJwWWVHN2pFcFlhOUNNOFVyRENHcWcvNkpYQXR1?=
 =?utf-8?B?K0x6QTNrcFNwTHg0czE0aURwb2RwWkxkMElTay9WMHhZN0Z3UlMvRjFUbzc3?=
 =?utf-8?B?Y2FaeVhxdHV5ZHdhVnhWc2swRzI5dXFtV3kyY2JnM3VVRVBTNi9mejdGKzlQ?=
 =?utf-8?B?czdZTUQyR3VrdUJTWWFJQ1B2ZUU3dklheGFFeXRqWGZiUVQ2cW9OTGJHV1JW?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a857a7fd-8127-4bc1-fb3f-08de06c29264
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:29:48.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlAETiaRVe82zn0v5p6WyLhm3hbjDr16WOW8L/JituNbXBHif+7XsrLqaYlhlASG/7xlxcQ4xgVfw02cwitQyhJvzBbmgukJF6tcCJ4b+QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------8NAmDEd3UmjCxZtMVsy0zkX3
Content-Type: multipart/mixed; boundary="------------DOkrWmjvVA0Lkfgb0z0Qd0Ae";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 alexanderduyck@fb.com, sdf@fomichev.me, mohsin.bashr@gmail.com
Message-ID: <4857a377-7034-4a5b-adc3-11f803496827@intel.com>
Subject: Re: [PATCH net v2 2/9] eth: fbnic: fix accounting of XDP packets
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-3-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-3-kuba@kernel.org>

--------------DOkrWmjvVA0Lkfgb0z0Qd0Ae
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Make XDP-handled packets appear in the Rx stats. The driver has been
> counting XDP_TX packets on the Tx ring, but there wasn't much accountin=
g
> on the Rx side (the Rx bytes appear to be incremented on XDP_TX but
> XDP_DROP / XDP_ABORT are only counted as Rx drops).
>=20
> Counting XDP_TX packets (not just bytes) in Rx stats looks like
> a simple bug of omission.
>=20
> The XDP_DROP handling appears to be intentional. Whether XDP_DROP
> packets should be counted in interface-level Rx stats is a bit
> unclear historically. When we were defining qstats, however,
> we clarified based on operational experience that in this context:
>=20
>   name: rx-packets
>   doc: |
>     Number of wire packets successfully received and passed to the stac=
k.
>     For drivers supporting XDP, XDP is considered the first layer
>     of the stack, so packets consumed by XDP are still counted here.
>=20
> fbnic does not obey this requirement. Since XDP support has been added
> in current release cycle, instead of splitting interface and qstat
> handling - make them both follow the qstat definition.
>=20
> Another small tweak here is that we count bytes as received on the wire=

> rather than post-XDP bytes (xdp_get_buff_len() vs skb->len).
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Fixes: 5213ff086344 ("eth: fbnic: Collect packet statistics for XDP")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - remove now unnecessary adjustment to bytes
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------DOkrWmjvVA0Lkfgb0z0Qd0Ae--

--------------8NAmDEd3UmjCxZtMVsy0zkX3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaObz6gUDAAAAAAAKCRBqll0+bw8o6Nc6
AQCbjpTDxUTY+EJaUJbDPvR7aJYlswfbErvEhA7f/DC3ngD8Dfj3ezQTEu63hJvEr/pxkWLELkk6
k4QU2GTaW1f3Rwc=
=kyjl
-----END PGP SIGNATURE-----

--------------8NAmDEd3UmjCxZtMVsy0zkX3--

