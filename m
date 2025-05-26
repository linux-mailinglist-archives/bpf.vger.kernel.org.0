Return-Path: <bpf+bounces-58939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C7AC416C
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD7916A836
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B249F20DD40;
	Mon, 26 May 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CF57+Haf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qM2vW3Yd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DE28EB;
	Mon, 26 May 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269841; cv=fail; b=MM6ZkYZbM7nP4ONgoIjsjwm57e+XRRTyo0ZsSHQCDvmIpmpF+5WYDnV1lGBPHtHpf94KAVQolU6rSSA9BQBtEL5Ys1LxZUVJX6BUQlPISpURnxXhuclh5d21zRaDZh0cR9Ja+wE9nR3xWYH16a0i8WDFhOPfENPGE/ErtJlWJFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269841; c=relaxed/simple;
	bh=65wbbXzdkyCut6gb/2Ww3VDWaVw54S+QlDdH3THIjBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+RB3YTGlFJKQ7IBkQOfWaUmFRvyfvlIqGKxDdywS35WH0zLHxQw1tUNzLbynMyGx1oDGMxyxWXYCqDEoruiEbBdEGncunrl/z4JVnoPMujyp88VvlAVHkb1tL5kNlPhDhFixIqfEIX10yUOnf7hml1/e50gTvi6ZnzoHbjifwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CF57+Haf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qM2vW3Yd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8twVS010856;
	Mon, 26 May 2025 14:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=owGNLm0L9j2hhe8OvxUOysjYe5Zd33g4jLat+qwVFcY=; b=
	CF57+Hafl978+0xBw04ZT40/vIF5ub9swWkCbhAGvPP3i3OivtqXBYmsvQkGPOJC
	5/RGEaW35EUr4TdhpIw1kgsDALQVhSe2jLvSjZH3ZQbVSW0vY9INt3EaFvMTbfWl
	ZpHCnS+pj3gn8E5dvKC7XV7XiVpnAjr4oUroi9rTid8qb/mB3dsvLZvaeOfS3VZ+
	acSNCNM7elnyTRomWTUpwi82owUfqnbFLj6dTyyBmWNGsE4EoXtPbqb1bvRZ3Nya
	k0G4WjgPTXv/iGC5CqpINlzW2DbJRkUBpuMbMmT+Szl4TZkJ6PMzcaZIHyGjh+4z
	2Ab6Zh6vunCe3ifz0Jio2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd1epy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:30:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QE4E0Y021122;
	Mon, 26 May 2025 14:30:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jebrg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7Yia9RwHZwHLqzqq3TEW8oenOHRhv0oYDvb4x/EtKy6AB6eV+qrGO0PiEjOHwYZygEDksyKcXPc6OCrLrB6CcfEL0XiRgtAUlrqEbSo5LLQLp+4aVeUYX87BVND5PC7LVXOKtCtKgMo+RzrVnA85ON6iKAt2VYFNS2zu1gctbkDPyZ6CG7vmulqnpJZgTP5y10XFN1/9b1KkzWYIUe93sg1fNxHtK/uvPYjLymnYQ15+z3c1zCYqi2XB73MvSVbjyM0d7YGbG0bOBmPmRnTZfn3Ivr62KQTVQtZiHLBfJ1Rlsfx6W8JCttmENgo7WiTKzwksv5SOiBTs8C43GDY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owGNLm0L9j2hhe8OvxUOysjYe5Zd33g4jLat+qwVFcY=;
 b=UuK89Kr+msrAgR3KbI0wdZ+WsSkwwbEk2ibuzHlfosDUwPtnN+Wezz3xGcnB1+IiK7a1WjlemaPv9kQdxbY/zmuwVVnX91SBmco5qEYaho9g9j9vSPpKLOPCWKC3howAcIrH+A+px5NUwdGQduGAGXexieccU4S8TMElR6XFqsfWwPo0v8CFAosKryV0GFBHIFx1XLQTYglEQQDVOgaNFYRR7i/XBFi1flPMzv0T+71OQKOtFx+DxYAHadWfAekSzxmxEzHUn9FA6h4fntLoYYGoNHvcRD/WjanKy4y9K/SDFdKUYHhl2IVQpNRUgCO4UPjFyn1sspmUT6uKjzyPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owGNLm0L9j2hhe8OvxUOysjYe5Zd33g4jLat+qwVFcY=;
 b=qM2vW3YdQskrusmYAwu1v+EbpA8NhiIfOp60fl6LsrUx/jQSD8jPg9j1oJ0W8FTP1AyxdJYtAemyMsZ0uzmpa6QwoTGjGqBY94ZAxIhVEaBjSivX3/kjnOpL+NhYv/XxU2TtVcIX9K6B4i+IKpTwED/NDxycIgmXcuIi1/XzbG8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 26 May
 2025 14:30:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.032; Mon, 26 May 2025
 14:30:10 +0000
Message-ID: <6428960b-a1a7-4b1f-8975-5a85e2b8697d@oracle.com>
Date: Mon, 26 May 2025 15:30:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Thierry Treyer <ttreyer@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        Yonghong Song <yhs@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>,
        Daniel Xu <dlxu@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
 <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
 <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
 <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
 <530F1115-7836-4F1F-A14D-F1A7B49EF299@meta.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <530F1115-7836-4F1F-A14D-F1A7B49EF299@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7816262c-81c7-4a39-68f4-08dd9c61d1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2NoTnFOZmZFeVozSnppRWJUVnpRRFpoTkdQUmlRKytVb2xPb252Z1FEV0pt?=
 =?utf-8?B?ZUJVS3hwWlJFUVNic29NQWNBbmNhZ09aQXBuMG92cTFBOUFMYmdqSWt6RWVZ?=
 =?utf-8?B?RTZkMjFRbHZPUzJtZDZvR2RKYktyZTBiRU1XMWpsZUtXSWlWL2FNZDZ1QlZB?=
 =?utf-8?B?SEpmL25pVzZmeHVudmxoWTBxY1YrVEtXU0taM1JJb2dlR1NsLzVRSVVCT0ZQ?=
 =?utf-8?B?RlJMckd5cG54bEozQlZuTTVSVyt3NXJsNjMrRURqWExFZy96V1ZCb0xDZWdx?=
 =?utf-8?B?UTZtVVREVlczWEJpd3pXTUtwN05LMjYvb05JL0FDelRGL3podkJvdFM0SWs1?=
 =?utf-8?B?Y2hGaDVUbFFjUDZlY2t0ZGU4dmRSNnAvOS8wZ0hOdDg1bHowbngvKzdoMCtM?=
 =?utf-8?B?YTA1ckk2ZG9wSXU3WlROM0daTmwyamtSRFdSZVhQbnhpZHVST3RjL3lEMjM5?=
 =?utf-8?B?WTdaM3FSODdRRVBWWnFSWXI3R21JcUI0QXUzR3kyYW5WdDlUNTRQOExwMU8y?=
 =?utf-8?B?WGtGTmhPUVVIT2dWSVpadFBtaDBZcUxwK2VUL2FqYU9EVnpsS3VleU1CMEpp?=
 =?utf-8?B?Q0o0NkxPL2RPb3l1NC9CaGZmSlk0Q0MyVEh5SXNsYXRvakkyTkhMUzBldXVY?=
 =?utf-8?B?R3lyeVA5d0NGL3JHbmlsZ3ZId09nYlNIaXdXM3IxK245eHFSKzdoZFJsSjNk?=
 =?utf-8?B?Wmo4NjdNL0xucjUrTUticUlZLytmbDNYeCtSYzZhWFEwL2NMK0l2VDJFNlh3?=
 =?utf-8?B?bnBqSWh1UFVNdUtzeDVkM2llTHQ0a0JrQy9CN1lXbTIxclZrdFNTd3VBSy8r?=
 =?utf-8?B?eW9EdEJlUFBVWW4yU0ZiQlFxVzFMSG5aaVpxYWh0K0NRemZHbWUrN2xIQjlL?=
 =?utf-8?B?ekFhMXE5RGExbm5LWHdidVZZYy80bXZKUkp4YXFEM1pxMi9aLzFIZ0Y5SE1K?=
 =?utf-8?B?bUI4b0tycXBSOStKMGNyRk1WUFlnRWRDendSN3BIeEdkY2JRUjdUaS9wUzAx?=
 =?utf-8?B?R3dOM3IxMTNLYW5Fa1RxbWhOK096QnhqNHk3cmpleWJiTFhHMlVXVlI2VjEw?=
 =?utf-8?B?b1FvQ1ZEb2diRTF4cmRKL1B0OGcxUlZTdkpXek0vTVNTN2xkdG5FYWZQb3dG?=
 =?utf-8?B?WDVxaGhiZzBPdVN3THJkTi9HamE4V2JtYmROUjdWeUJWZTQxNEFYTGhQRFcz?=
 =?utf-8?B?TWhwZFBSNDgwYjE5SkZUa3JUYVJRZ0xiTnlJK3dkaVloMTdkVFFzbjZIdWRx?=
 =?utf-8?B?ZjdBYTBqekNYN3RDcGtLTUdudXRzMlJkOFFCT0ZQQ3BIOXBTNnQ4ekxUSjg5?=
 =?utf-8?B?L0s4YTM1VzFJVkQvWFBvV3JIZysvdUQ3b0Vjc3NPYU45bnJzVEJHZXhlcTdQ?=
 =?utf-8?B?QjRvT2xpZTRqV0k3RVVlck5tdUMrS0RLTHZqNEJsbjhGek1NYUZoS1REY2h5?=
 =?utf-8?B?cjlUYTBmcTBsNFpva3hQNFBLZWRqUnFkSnNVeUg5ME5UOENaS1IrYXhpbFNk?=
 =?utf-8?B?QkVLemxzUjNHWGZlc2hQN3U3R3F1Vll3T1dQYllmcXlUbHRvNFVTRDJwa2Nz?=
 =?utf-8?B?b1ROaXo5VDF4T3pPeDBudVE3V2VZM2Zaa0xabzQzSjdybFlwMU0xMG9kS0xt?=
 =?utf-8?B?dFdPN2NaV0R3OW1taXB2SjBMQmJWclRWNW1zS2J6ZGRGM21KYk1iN01lR21R?=
 =?utf-8?B?aEZIT1M2bC9STlBPOVljdjJRSlFWeEUrN3JtNzZDSXExOVozWEh5L0hXQXNk?=
 =?utf-8?B?cmx6ZjZJTU02TEpNYy9kOUs0WUgxdkh2UnRjK0dUYUVpeWFManRON0RlT0s1?=
 =?utf-8?B?S2h3V0l5QTNTWEQzdmJyVzM5TkZXSE5lZ2hqUEVpU2d0Q2hYVE9yam83RW9m?=
 =?utf-8?B?c2dCa1pJck5FVWxuc2t1dlVxdnpsdzFWU3EyUlI3SndUVHpCVFl4M2J5UjBH?=
 =?utf-8?Q?iMDaVCrnkJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUdoZ2FCdnFjUUJBWGtJQzF2bGZDbkRsMStXNE1zcVF6NHhoMUk2aDd5SXoz?=
 =?utf-8?B?U05jY3h5cWY5V0JZbUNTV2FEekZCQkpabWp3OGlQNlFVbG4zbTRocGlJYzY5?=
 =?utf-8?B?bU5RTXpYU0xYbnRMYndJVTU1cXRiZVl5c0FrR200bWh4dFo5RkZ2Z1RtcnNS?=
 =?utf-8?B?aGJOTWxNY0djVExSVUl1WFdyeHZhQ0FZclQrSHRlSUxKT0dvM3FNZ2FOVFBn?=
 =?utf-8?B?QkRCWU4wZit4MWVOcXNpeWZidUxCaEVBNWg3eTJkM2JPeHlIeU1yN2R3anNW?=
 =?utf-8?B?QS9uM3dNejF0QTU3dUxsRHgvNjRCdGtlaVAvNTRBZVZxK082d1I4cmdVcWVO?=
 =?utf-8?B?cEljeUtjOUhwVzJteThYbk1HM1ZoMG03MWJaZU9rZHF1Vkozc3ZsZEhyOWlB?=
 =?utf-8?B?cC9XaHZYUXNPNnM0MmF4aENVRjRzbTEvY0RWMFhZY2dHZk5COHFnVmZuVWhF?=
 =?utf-8?B?eWhZNlo5SlN0Sld4MG1ZelQraW9NUm1RZy9iUVdRVWNLSjB0MlZ0ejJYdEpG?=
 =?utf-8?B?YWx2RWNGMVp4c3EzNW5NK2Vhb0F3QXVnRlpCd1dDZnptUnc2dlNtcGxrcEZO?=
 =?utf-8?B?OGgxeVVPZXloUGVOZ1RFMUFOa1JDTVhSNUxrVC9vS0lucytmbVhERG9EV1ZH?=
 =?utf-8?B?Skl1d3BSVTBsRnR4WXZJL3lwVVpobU1IY002T2xLUjU0NVFwUGRKVjhTZ2hY?=
 =?utf-8?B?Rk9LNUhzUmFJb1ZITEkzekNTYkhTR3preStvYjVGK0h1YUUrY0lvMitIOS8v?=
 =?utf-8?B?MUt4SEI0VjJlVTJmejhzMzk1R0VEZ2N3WU1YRzI3cERQOVhsbGtJbVI1Y2or?=
 =?utf-8?B?cVA0a0xjSmg4MzZtVHdHVy9PWERReGorU3JYbkxEeDE1NldjRXR5NnJQdUM4?=
 =?utf-8?B?eUNmRVJjR29tc2Njd2Fud1o5bDRRblVITXJ2R2R5OFd4MEMwLzYxc2pJeXY0?=
 =?utf-8?B?SXpiRk1NbDJ3Rzh4dnhWcnl5L0QxUU9TK3N6UThQdUcvWDN0TlRGR1ZPU2tO?=
 =?utf-8?B?UGRZL1hXc3RySU9KYVhwWXlyUzE4eHFoWklHZVJXOGlJMCtCeHQ1N2ZRVEZt?=
 =?utf-8?B?K1NPcFkraUk4WnRiRWVUd3RnQnNiR01TVmhjNWVRV0tMM043UGJ0N0ZGVGlV?=
 =?utf-8?B?Wkpsb2FpTVNVdkJVdlNGdmpYUG53SEVCUlFsUTFEQU51N1lZTUtIbjFwWUsx?=
 =?utf-8?B?SEd1MVJ6VlFSME40amVLWEQvc1V1U1BRZVZ5a1ZwZ1A5ZTR2RkVMRmZBT01h?=
 =?utf-8?B?RGsycGtrNmxFVVVrSVlKalJKMU9UTi9QQUMzZ0cwRGY5bGtCT2xwalA3Vk1G?=
 =?utf-8?B?ZnpxMisreU02elB6VzdRTFcwVU53VSszQlV6OWRSNldCUllmZ2R0V0Y0OGVY?=
 =?utf-8?B?NGpUaVZsSzVDQnFNeWN0RnNXY1Z0SEV0M1ZUUUFMOGNxSlBPN3cwbVdSMHlk?=
 =?utf-8?B?L0Q5Smh5ejRUdkNhWkRnTkpjdjhNQzBwL0hwbFNpcjRTVmYrTllDUHF3K1dV?=
 =?utf-8?B?L21WQjA3NlZHTU9PZG1ralZpY2pTakJxcmJnNWxQOUZpdzVjbmZhMTVSckM1?=
 =?utf-8?B?bkNQdmRkNlVJQm1MNlJjV2ZsU2ZLK0ZKbjFta3JCLzFob041V0Z2WkpUVEV2?=
 =?utf-8?B?VU12SnhRblhwRUJnT1F1ODNkbzBraGo0N2JYRCtPQnhKem5pYkxrQ01ScytU?=
 =?utf-8?B?MUhER0g3RjhEWEdzbHJqSGltenVETHU1NURCYzJiMUFnamhic0VuWUx1dTB4?=
 =?utf-8?B?YnFmWXV4MjBEdEN2azJCWjhLQmxsc3I1cDBaYnM2ZDAxWktSR1U5S0NNd0tY?=
 =?utf-8?B?V0tCbEdmQnZXWlAyekk3d3Yxa2ppbEsvaVJDZStzb2Vod2p6eW9hS3lkQUpq?=
 =?utf-8?B?SllieUhTclJGUk5BdHUrQytnNzd3bktHakVqdkRxNnVVZ0dOZENLOTlPTFN0?=
 =?utf-8?B?Qk1UUWF5VmtRcFZ4QWZ1UmUvS3lUb1I1d3RnSVUyUUx6V2dTU2d6Q3I3L21q?=
 =?utf-8?B?aDNVeVJMZVBCZFVUTzlra1duUE5BMHFvZkduTENTWVI3K0tVclFLUHF5ZG9w?=
 =?utf-8?B?ZVlnTjFBT3JnWXBOWjNhdEtTV2JVdFBhcGZESnVTV29VUUh0NW9kRmM0aWt6?=
 =?utf-8?B?eko0Z3Uzc3RXd2QyOC9mRm9JclF6Vk1KS1JKR1JTRHQzTTQvSkhBY3JQczc2?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MqiRf9niQQcdTc9I3UxnUy6jzIRzVlTZiR+txOWhoKNvFweWkVwAB4uwYcztF0vqVbc2yRFT6CKqSw8qlb9CrIth1kbxiKa2fTPxK/5dHD4ClJzibAn4AHx8FVwKOR7liSd1Vi/oHCtjqfu27k8fk9p0o10o6jrCC6ZCF50cYQ6ql7jCSYgJn5jowd/0zTPdBJSL98BDTbUiO7pgGHB2bVLx3TCAs/9Ohecalw4Me2GFINUlXjuSomMdPLliI0EznVQMAgYGQX+Mcwq0X8tmZcYwOi06Um0/wQQsCbq7zH9dbowcrqtILkNw4oDDS65oPpQRl0o24fAyPuu3NO1H1i33EX0eHeYEC9tPv9ujglZdbUOfU+7GSJVydrdPWEYrOsfDACNTDJ/GToMMuz6PeV1TCcL8WJOE5d34SovjIdFFa2EVs59o+XQaBa/dlPAdTqtaeYcsL8tQahPc2BsoSLGDWa6vY4e10a8DBhwwnqiBvzN4V/ED/0UmEfkIUr8O7rADHywW/pUN202dkWwUyLwBnx+AJxeEpdZ2axk/EXcCk5B+WXPI7DyM/lPVR9X0b6oADkR0cNi6XUnPIHmJlz5wksWyoLA+sMk6qIMA1Bg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7816262c-81c7-4a39-68f4-08dd9c61d1ba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:30:10.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw3IEF7Vil+KVzeg6PLy7bSE3MQZ04xg4L4z+fOolHnt8UYzc9v0fuSqYGdi2i6mL8Or922L5JoQG7lPmcjzWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260123
X-Proofpoint-ORIG-GUID: k2VKPO5tAFTK0nqOHOmFcFQzNZkSlta_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyMyBTYWx0ZWRfX1kNZ+qrdUMs9 up+waLWeEkOvALvMBrLYPLa02Kzzun9xVL/DDvLgI4HMyxH99i/sHm4X8LDlzov9V5gU1PMB9BA 9c1u32WPfjK3tbEsiMdYqRQF8DqqrVDJR4mlGh+NXv/CIwKu2q/znPD97Y13wTS44JlGlRgFi4Z
 Sx3SgFHMiROpr+/HcG97MyrzkfeES7Ppilt4gub8BQF+tqD90krhvA2AzDRW4E2PctJALOIMkIQ cxFKxL1190eWf07+BKE4bWWi+1J2WJmDOV/UfUOYDjHinwO1PpChamhuCRPAWs+4/YO3z3AIP5j kLYmudQGMApNOubw4ZH5u7pgfd3FXC67XHLbQO3kY54uowakyLIFyuQ/Ra2Cl4JIx6fHuzWlsW3
 CPjC+53izk/UTELGSrn0llfVsv6PkTCbL0dyyyliVBMpY5m0WoM/9s7kM3LT/9sn6aGQvK7o
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68347af7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=YX3hTKRaI-vc-F0v5IsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: k2VKPO5tAFTK0nqOHOmFcFQzNZkSlta_

On 23/05/2025 19:57, Thierry Treyer wrote:
>>>>  2) // param_offsets point to each parameters' location
>>>>     struct fn_info { u32 type_id, offset; u16 param_offsets[proto.arglen]; };
>>>>  [...]
>>>>  (2) param offsets, w/ dedup         14,526      4,808,838    4,823,364
>>>
>>> This one is almost as good as (3) below, but fits better into the
>>> existing kind+vlen model where there is a variable number of fixed
>>> sized elements (but locations can still be variable-sized and keep
>>> evolving much more easily). I'd go with this one, unless I'm missing
>>> some important benefit of other representations.
>>
>> Thierry, could you please provide some details for the representation
>> of both fn_info and parameters for this case?
> 
> The locations are stored in their own sub-section, like strings, using the
> encoding described previously. A location is a tagged union of an operation
> and its operands describing how to find to parameter’s value.
> 
> The locations for nil, ’%rdi’ and ’*(%rdi + 32)’ are encoded as follow:
> 
>   [0x00] [0x09 0x05] [0x0a 0x05 0x00000020]
> #  `NIL   `REG   #5   |    `Reg#5        `Offset added to Reg’s value
> #                     `ADDR_REG_OFF
> 
> The funcsec table starts with a `struct btf_type` of type FUNCSEC, followed by
> vlen `struct btf_func_secinfo` (referred previously as fn_info):
> 
>   .align(4)
>   struct btf_func_secinfo {
>     __u32 type_id;                       // Type ID of FUNC
>     __u32 offset;                        // Offset in section
>     __u16 parameter_offsets[proto.vlen]; // Offsets to params’ location
>   };
> 
> To know how many parameters a function has, you’d use its type_id to retrieve
> its FUNC, then its FUNC_PROTO to finally get the FUNC_PROTO vlen.
> Optimized out parameters won’t have a location, so we need a NIL to skip them.
> 
> 
> Given a function with arg0 optimized out, arg1 at *(%rdi + 32) and arg2 in %rdi.
> You’d get the following encoding:
> 
>   [1] FUNC_PROTO, vlen=3
>       ...args
>   [2] FUNC 'foo' type_id=1
>   [3] FUNCSEC '.text', vlen=1           # ,NIL   ,*(%rdi + 32)
>       - type_id=n, offset=0x1234, params=[0x0, 0x3, 0x1]
>                                         #             `%rdi
> 
> # Regular BTF encoding for 1 and 2
>   ...
> # ,FUNCSEC ’.text’, vlen=1
>   [0x000001 0x14000001 0x00000000]
> # ,btf_func_secinfo      ,params=[0x0, 0x3, 0x1] + extra nil for alignment
>   [0x00000002 0x00001234 0x0000 0x0003 0x0001 0x0000]
> 
> Note: I didn’t take into account the 4-bytes padding requirement of BTF.
>       I’ve sent the correct numbers when responding to Alexei.
> 
>> I'm curious how far this version is from exhausting u16 limit.
> 
> 
> We’re already using 22% of the 64 kiB addressable by u16.
> 
>> Why abuse DATASEC if we are extending BTF with new types anyways? I'd
>> go with a dedicated FUNCSEC (or FUNCSET, maybe?..)
> 
> I'm not sure that a 'set' describes the table best, since a function
> can have multiple entries in the table.
> FUNCSEC is ugly, but it conveys that the offsets are from a section’s base.


I totally agree that we have more freedom to define new representations
here, so don't feel too constrained by existing representations like
DATASEC if they are not helpful.

One thing I hadn't really thought about before you suggested it is
having the locations in a separate section from types as we have for
strings. Do we need that? Or could we have a BTF_KIND_LOC_SEC that is
associated with the FUNC_SEC via a type id (loc sec points at the type
of the associated func sec) and contains the packed location info?

In other words

[3] FUNCSEC '.text', vlen= ...
<func_id, offset, param_location_offsets[]>
...
[4] LOCSEC '.text', type_id=3
<packed locations>
...


