Return-Path: <bpf+bounces-60077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26933AD254B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3F51890F5C
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7156B21C163;
	Mon,  9 Jun 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZBsU4f/4"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA374C14;
	Mon,  9 Jun 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492323; cv=fail; b=M6vrJjf/JnkS/zP0ALDp8b3lg+zY2COMwffP37DZz4oEt0EyjU5i+4drti3NnMwp2kQ/ZASmdcCF1wsNSgTZ3YfLfurGtwZXwkrhGUSZCbxoFL6y6vUZWSaJFpFCCS1BV6FXta1gy2W2QJahpXVzd3Am5wTh81qHqonydZpqC7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492323; c=relaxed/simple;
	bh=bVUcUfqF6XFYxN55moZt+64vLWqU86v9z1RZ5vjFexg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pio7AkpQbnaYZfNbe3di0UFgJuv7sN/OlsShn+/lQVpgIGIKOLJoa3QMYcMMTQ/z94nWTSl6ar8bnF3ODi9LRk6dKD6pWgyaALhLThprZ1CGxYHnRelRNZqKQ7gyELbyafJtt0qoT6CPJnYuFkMezDnwV1RpYDF2CV+3uMvSJ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZBsU4f/4; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOyeYARcqALW12f5c/duutLTkxSSv/Ge3uKN/Z2eq1z5jsUWl+5zpbwd1u/PlK5WaNqZVp/f1TZYSIWIeTIX/toaW5uRo2diijfF8eWzbMYzZOxX7UdZWG4Mv5AuDOhc4mM3vGb6ErkHCNe84nMfvL3sC83ded26l/waZ4QRBAaLtCwShooIY8TSmY0PxuJQdhKY+Kwx4r/sh/MIc+GmBXPQ/9wjsQ5Rwe4OVzEBwdLU6fRHD7iBXNMoe76VZ4Yv/pRx1XPFUygjmBZvbCnPaB8wxEpMHPtOcsaH84bAaYng/010glAuXEHJOi9EAZmQQKpn7OmOfwnCCSSPfvsQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAc6YzXaRsWzLTD0Y98nvnK2OJBfTKDODJPSSKlszkY=;
 b=NpRt1ZowG862sJNx/6LWSHZMgIDkALGuy9ORsihjd5TSJS9tjW2yFHw5BJNK64tJb4aJJLX+ltrlUgajETJ453kRhMC39hdUPkZ7hoUhrbejIAkQDChjAJaIUUx6F1IoqtorLetgtCWP8l0FzYHjPcUvXxJ+mlGoqHTjguN7mXKMOkTA8x82bf1qUpyyBSf5FQYr9rrfBvhAy0EP9T0OqduSfpHIpCAKk15Fb60W+QIYS7FF+z1UmYL0oAKONzXFe15beZd+TYe8xM95ftPvpkLdCvw5bhPWCspS3ytqMffa7RV4MwNv9JzKXgK2ZKs8LgzfRYwISyzyaYCSXLnn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAc6YzXaRsWzLTD0Y98nvnK2OJBfTKDODJPSSKlszkY=;
 b=ZBsU4f/4bObthESyhOnS12HPfCZqeeJVNs2oiIWFam0zyUVM4CmOaS+/RtBEyMx4CeH5y3JX1P9GcbMV7k9E5DoejE2glc7JS7tSXPzVgWQsz1H5yOWuGyUd1GgwsmHW/dct5Jf9QzKC5+LiH5mY3G8yk8+KMb7sSusosStflueJAFXUouZDp69QTrhsnIRyIP7V6UkC5J8p7axDe4CWO7yg1ioNXS7sOaf3QQaVm9duWlk0zi9BS9YvJJEzznVrCybokMH99UEvd9rZL+TU6MXnj3+ut3Fq40FZnSfM3sLYyXcs9IEyb2tP4ZPBQHXqq9x9f3Id2AC7win6vM2lnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 18:05:18 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 18:05:18 +0000
Message-ID: <cb7ed8e5-220d-41f0-8743-5a7a4627443d@nvidia.com>
Date: Mon, 9 Jun 2025 14:05:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] context_tracking: Provide helper to determine if
 we're in IRQ
To: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250609180125.2988129-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:408:ec::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f87130-7ac5-46ec-360a-08dda7803182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1lVNkdlaUpobEk5RUZ6RFBOTnNSNTd3SVF6NWhFcFlDRnFlKzh5Z2hzRjhY?=
 =?utf-8?B?eHRiVmlub1QvT3RlWmJqczVWT1NSZ1J5bkFVMldCL2haSW9HTllzR250K2tB?=
 =?utf-8?B?bzBlODAvME5rcnNheHZjR1NsT0VqdHRxZmpoTEFGb2k3eUE1bmVTUHNSOHIw?=
 =?utf-8?B?YkJGNFZYUEVBeGlHdUg5bEh1RWhkUkdpN0lKc1RkWjRzVDNkVWs2SERVY3VB?=
 =?utf-8?B?NkhVMnFCOHAyaHlZWG5LZGNYWGN6dElIN09QMTNHeFRpWHZZN2dvNGtyUTV3?=
 =?utf-8?B?ZkJEOVQ1SHpScXlDYzQyNGRxNE50TFNJQm5WK0JLWFNwQlRTOFdBWkdZWmkz?=
 =?utf-8?B?cEdmeTdhRlg3ZU50cnNFZmlvaHg3ckR2OUZoaEFSek1XNTl0QVA2VWNaUndI?=
 =?utf-8?B?TnVLZVdrN1U3dUZudGZwQkI4Sm9xVGtNS1RoTHJlcVAzTlhMR1ZqcVpVTnFz?=
 =?utf-8?B?REZ5ZGxYczhSYWR1QTZjNnE4ZXpNZVc3QzRNSk9jdTdxOTM4Z0VhRTNRZzJP?=
 =?utf-8?B?eHZlbmpRUzdYU2ZSN0lienFNVmNPSjArSHJHM2tGOFZTN3FHclNwYVRYUDFX?=
 =?utf-8?B?N0xScFFRNmVUMGRZSWFEamNveHVadk5maGdhcWNRUXloNExpK3Q0aVpmcFI3?=
 =?utf-8?B?VmpqTDMxUy9iN24rWEhWbmYwY25UdDFnanMraHk2enBHN1hpak9zbjV1SmFq?=
 =?utf-8?B?Sndrb3hqOUdBRi9GM05jb1RWNHFzb1Zna0l4VXg1T24rTEpSRVFDRlE3N1VM?=
 =?utf-8?B?eUZENkpReDhPS2lCemFYSUJZdy93SmJWenF4SWRWNjdNMTJjNVBSblYxVlo3?=
 =?utf-8?B?RWtDRDNWQlVZZG9ZOVljbTRFdU92OXROM3ZTZHI1WUhIcFpISDhIZEFrUzhX?=
 =?utf-8?B?ZkNxWVJJTHdwczZ0dXVMT2xYNXFQcVk3Yk1tY044UE9Gd1g5cE16MG0rVXRz?=
 =?utf-8?B?MVpla3cxeXBXb3BIekRqeFBwMEtWVnNUMlY3T2xEMlVZRXh5WmVBSndoZk5v?=
 =?utf-8?B?enkxckkvZGhvVnE5UFJSTG9XM1NuLzJrbG5SL1NWU1ltQm1QcTA0T0s1Qnk0?=
 =?utf-8?B?NjlvWW1nZnUxdmUvS3dsaC8wQ09CanBhRFJOaElTTjRnbGF0WDN5NXduYmRi?=
 =?utf-8?B?aG1qWFFvWTcwc1I5d0FTRmFuWjdYSU96aFl0ZnBwTnJ2WE9tcVAvQ0tQVVJ3?=
 =?utf-8?B?bDBGOGk1UWI1aXgwSFJaNFl5QkVoK2NZaThoUmlhS2EyRkNyNTFTY0x0akhJ?=
 =?utf-8?B?YTJaTFkwOXZpQXdHNXRvVklCMmZrbm1mSjJHQ3BhUUI4QXBhSk1LdHZwRXJO?=
 =?utf-8?B?ZXlFRDBUbnc5KzgzUTVEdyt5ZkgvNVZXcmduQXUyVXNLTUcrb0NJVS9tVHBq?=
 =?utf-8?B?R0p0VWNzbUNjL2tYMVhYTDQwVTB4Z2xmcm1vWlRXaFA3OCsrZ3ZZNWNWNk13?=
 =?utf-8?B?N21HY1ZDVnpkMkVwQlNBNkJIbDBWSnB5OG1lajdvRVBaZkFZMkRYekVFTUwx?=
 =?utf-8?B?bTVGRUtoQ3NTaDZoOHJFTUhsYmFLeXV3eHFvNVluMVk4MUMrYXBGSitwYXZF?=
 =?utf-8?B?WjdKMWhSVk9EMmJPOU9TQTRoeWl4UmptZmdIQzdoN1Q0OHo2WmlMa2t0d1Nu?=
 =?utf-8?B?OXdPT1dVUmdZMXMrY2xiVVdOUmhPaWxac1RVSC9OVTNpS1FvcHRlbnJxdjZI?=
 =?utf-8?B?dHFVY3lTb2trWlAzWjQ5U0hLcEhDN2gweDQwOHRudjRPYk52RHE1UjZFL2Fm?=
 =?utf-8?B?RnZRSGpzUE5JQ1hoc2N3ZzFSb3BxMG1DMUdCQ29sUmQwVTl2aUFzVVpDQ0Jl?=
 =?utf-8?B?alN0WTFyWWVRYzlUZnl0VFFORzFKT1NnVzIweWc4c0dpQ01aRGJCR0poTnNk?=
 =?utf-8?B?cGVLSnJmalhBWUlYQ2JreTA3UnRTclFqcHJ0VWtWS0ZVQTlEYWVqZHZlU0Z0?=
 =?utf-8?Q?S/OijXRB3eA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzB5T0xrM0t3WjgxbGNRLytUREJhVGVXWWR4QzR6Zy9UK0VTVzZzNUlTWGFK?=
 =?utf-8?B?NUNTT2d2MTRXS0xJLy9yTWVFYTdPVzVBcHFBbVRmMFRQMTZWZnF6N0Q0QWoz?=
 =?utf-8?B?Q2NkVHh4aWExWGE5ZHBPQ3dIZmFXRUtKZGlMNHJFS0crSEpva3hxZTRRSmMw?=
 =?utf-8?B?Y1FRRWJBYTcyMWdrY3FLZ2Jac1dhdmRPZjlld21rRmRvS041emxYVVNDRmo3?=
 =?utf-8?B?dnFGenBCY1RYV0ovMWFxbzllY1UvbmdxeklXNWVaNnB2aUtndWNTbi93dDFs?=
 =?utf-8?B?OEdST1FxTXdLNXBESTBrVWhLZ0Y1clNGcEpNbVNXNElTeEhMOUFScVdBSldR?=
 =?utf-8?B?L3RRZXh5Z2FQZ0Vtc3lxaVpiaEtRME1rYzVISnBhemFmNnViRnkwY0xwSi9Q?=
 =?utf-8?B?bk9ZY2ZzRlpkNkFEWmNkbkUzdlZqQUpNOFhxMCt3OHdCSWUvMXlIbnVFNUhN?=
 =?utf-8?B?YStSSy9iYnRMbnZrcEUrY2NacGlRTGpSMUpqaTA5WmY5TVVpR05mOUxVclJh?=
 =?utf-8?B?WC9abWRDVEkwSjg4VERmZjlpVmI1Wm16Q2dEdnVTLzkxSmgyZWZsMGpSSFBU?=
 =?utf-8?B?TnA2c3J2MEh2a2JpZnFDS2ltUEtvL3RId0NJYmZ0UFhhS0NYUnRQY2FSbnBN?=
 =?utf-8?B?aDdxRW9IbFc2U2dXTG8vbkN4enFrUWJIMFpabUZqeVhvazBYV1JtNTQxZkVV?=
 =?utf-8?B?Nmc1ZDhqc0NDWk84SU8xUWZLQTJpRDdXWkFab0pvMUNtV2tMbVNWY3NyNTBm?=
 =?utf-8?B?dDByK25TT2tEVmlmZ3J6eFVkK2pSMFZiTWpydHBKYjhXcXNrRlBHR0NNWG4v?=
 =?utf-8?B?WnpQU081ckZpL2tQY1I3UDd2NWNMdzk1UGFmTUc2N29uREJ3U1Yyd3p2R0NX?=
 =?utf-8?B?emdvNVAyNEJ1NlBaSFhZbW1OcHYwa2U4SmtrbFhhTHBoWmt1NXk2SlNiemNB?=
 =?utf-8?B?NDYwWW80TjNpdjNld3hwYXg0Y3dKUVo2ZFZ4aUluVTh2RE9iUk5IK0pFS0Np?=
 =?utf-8?B?M21CdlFraVhpMGN6R09iUCtGSS94c2s5SGxDWGpwdnFValVLOHg5UnZkMm5I?=
 =?utf-8?B?a1N4aW1NT1BiYTA2OURMWFNXNEVhTXI3Ukl6ZGoyTWJCNVEzVnRidUxDZXZh?=
 =?utf-8?B?VXd3ZEpPOTNZOGgvcVcwMU9xOFY2dzNwd0hVOHpkR2pvOTc0WFZpYmJVTDlh?=
 =?utf-8?B?RDBJQWd1S29DZ0ZjRy9rTDNIZVVtOUJkb3hsdFg0ZXdsSGV2UkhBWlZ3eEZk?=
 =?utf-8?B?TTRCU1RHVkMzVlBlTzNzU1d3alhsZDBPd0JqQXVWdEFTVk52bXVYOW12ZXEy?=
 =?utf-8?B?YUlOTU13UHMrUTJJMWdDODZIWkJMODg5elYxTm5UbHMrOGxGYnBtSXlhT3gr?=
 =?utf-8?B?YVVUYXV4bVRjV0V2REUvN2lBdHRlQjhkTHBUZ0hrQ3djRkhSTEpkSjVENHZN?=
 =?utf-8?B?cVpWekRuWURqMHZDQ015S3J0TWNnN3JXdUZCbFhXTE52d21XSUZqTmlTL1RQ?=
 =?utf-8?B?WW15Ukx5ZEpod0trV0ViZzh5cnF3Vm9SelVUT3U0RmIyU2dJMHhySWhyYzJV?=
 =?utf-8?B?Mlh3VFRXZC82U0xtcUZMOU00UDl5eHhReUZXRWNJQXVMY1IyYndlUHZCWFQ1?=
 =?utf-8?B?S2phcUdWZFpHYTk5U1o2ZTRwemZjZXdkamhQZW9Ld3NQbGVvQ3NHQkhycG5z?=
 =?utf-8?B?Q29DcGV0ZjhsZ0ZDNmVVMXNsU2RXWVozMUhrUVN5bm83UjZKZFl1RzlLdFZ6?=
 =?utf-8?B?UjFBMjhseGxtbFgvdnQyc0J1Zk5GQzVmSE03R2JmSGhVRVJsR0lMMFZObGNj?=
 =?utf-8?B?YkpjZ3pINHZ2ZVZrN002Y2ZralZnZ3M3Z28xM2RtOW9CSXJ1YzZhd1F2dWc5?=
 =?utf-8?B?MjZ1WjdkSkZ5L1N3SFBxbjhybHU1MyttS2Mwak90WHRYci9UWFJCNzN2ZTEr?=
 =?utf-8?B?RXFZSWVGelhaYkx6L3BBbTFDdmxCV3pvalVJMFFjTmU2aTZsRHZvTmlNbklX?=
 =?utf-8?B?L2ZGcjBlcDRpT1dmbWEvdWZaQitlbmtyeXY0RTN4ZjhEOHkwYThEenFNakJF?=
 =?utf-8?B?N0o2aExGbWpSV0pwUjl5alVCTFRyQ1hzY2NPYnQxQmtFV1RaOVVUczhJenRm?=
 =?utf-8?Q?iy8bVsub4WgLeTrigqcdz6qc8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f87130-7ac5-46ec-360a-08dda7803182
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:05:18.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyTK+pnL0N4w+8Rel5M5YiMiLD1qMB+WrX9fJFg9jOkA+CfFbm3GgeBt/LmZFh3yZNHiwiSjEp9GvgNWVQkpZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292



On 6/9/2025 2:01 PM, Joel Fernandes wrote:
> context_tracking keeps track of whether we're handling IRQ well after
> the preempt masks give take it off their books. We need this
> functionality in a follow-up patch to fix a bug. Provide a helper API
> for the same.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  include/linux/context_tracking_irq.h |  2 ++
>  kernel/context_tracking.c            | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
> index 197916ee91a4..35a5ad971514 100644
> --- a/include/linux/context_tracking_irq.h
> +++ b/include/linux/context_tracking_irq.h
> @@ -9,6 +9,7 @@ void ct_irq_enter_irqson(void);
>  void ct_irq_exit_irqson(void);
>  void ct_nmi_enter(void);
>  void ct_nmi_exit(void);
> +bool ct_in_irq(void);
>  #else
>  static __always_inline void ct_irq_enter(void) { }
>  static __always_inline void ct_irq_exit(void) { }
> @@ -16,6 +17,7 @@ static inline void ct_irq_enter_irqson(void) { }
>  static inline void ct_irq_exit_irqson(void) { }
>  static __always_inline void ct_nmi_enter(void) { }
>  static __always_inline void ct_nmi_exit(void) { }
> +static inline bool ct_in_irq(void) { return false; }
I did s/inline/__always_inline/ here. Will send with next posting.

thanks,

 - Joel

