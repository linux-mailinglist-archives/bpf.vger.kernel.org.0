Return-Path: <bpf+bounces-49468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E29A1904D
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D52E7A2E44
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85ED211708;
	Wed, 22 Jan 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPtfb+Yy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kVtMBzGu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFF2116F0
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544193; cv=fail; b=tn3StiMuttKAqfiZImga63Ri+VYNQEHm6pizTYyap5eitWZi1l98rlHMiyRpmZjiVICRrVe2JtZbSfAkGPOAFJO5UyJNO48jKXkrDmLSxO+JPnXX6Z1sYirTIgMh5Ceq7uWA02XkTCwZD/B9GWLOIWqx/iSsUkP3hLMUvMgIffc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544193; c=relaxed/simple;
	bh=LxC6eNOw+u3W+CyX5hhWkIx/1aC8IKzY8yRrvI4RTF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dfz4dCyKN0z7+FQkxw1qkoImUrAdlo7Cv3TmZIU0gzMZj8dg7NtcSKyQ/XoQnLFGBbJrydyb7YhotYMQat6qM1m7dmmg+LpToF9IFzFutQkC99rPAUuKp0d/Sry8Blhy3eMl5/hGynEyTo8GUlVBbGA6oAJ8gIP7C05Sz+InIh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kPtfb+Yy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kVtMBzGu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M9LXUn014384;
	Wed, 22 Jan 2025 11:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/VvCb/j5vM1V653Z0OTKrh5xGhmFBEFd1pLCwpHctBY=; b=
	kPtfb+Yy8huqSqdQJ7K+XkK3Ipb7cREzJAJFwRdcn9zuPcBljKVCQaJcHg5nCZ20
	PamvOzdgSHtCQJgXs3qkyQJdzMLEdyW+LCYsxRxDXifVvJqzjMbKYeFdJdQo+xU/
	yePwR7e7/A7m2HJ9OO2JtokISOXAS9H4rgSRZXskuaCM2r7gc9ClBUin5OwsJSmE
	XYIypp51Dl8iizsUEX7hIirXxi3nQHbUPBayTFTsPMhWBQMkkEBRzp1JuXJ85Ge5
	ibzQifPpvnn953Jc6wF4M9/v7bCs98YeEkEaz4WGawSrmhaMY4uNLUvRE0l9OH1e
	aThmd7Dnf6gL3W8Ee/1gcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh05nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 11:09:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50MB3DvW039136;
	Wed, 22 Jan 2025 11:09:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a16u9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 11:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5u7Zal26j7of3+IRHPDcYhsUkulKXVU7MAX2xSQ6Y7eEAUrjRe98zvaa606ri4kuGcVGCGy060hHfqQQ+9hHSNq8xQIYQo4W7ZJDjBij5AEEoSkyL/UQIdiJggHcNfCzlhz0l6a/8B18SY3iMYS9DSN1Xld+fZ2Xiz7R3FqdSPZ35bLdFlnDjnH4tjDwH0NIfyfPNv76KE0E3MkJYseTq85ZY2k8AWoD+1bBf91Db+wrKKtuh3AHcKsq7DQ/ilU+0zTu1NDiF3xGuDJcjGnViwAxfbRL6GEz8lJF6bJ6UELLvVXGFsrPYkpoWl2IgMrmKUhm2+xR8wwM/DiUiIMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VvCb/j5vM1V653Z0OTKrh5xGhmFBEFd1pLCwpHctBY=;
 b=GBURTH5kKQxlshWqWvTSlG+a8wJRG/zkm9wBKsCviMM57eP1h1RN9PDaeQPpTYbDIUEP6sEkbiRMRAb12eYOGGJ2k6AoGSoz2DtTG4OBqzvKy3MLFtIRHzWnCz1ioYI1CjRPBizWU9PF/+/ogtSjhYp9COsIF5BBVMS+hI5Pb17N6CKibZ6g3ZvdfcQFxAMn+SzKReyD39RLQpV4ZxG45TMT5l8fk3fDjo2Ok4zpzFQt8+/Crk3+YBQOeuKIpOrYZa1AmN7IPnP65McE8xUH7GUCJ4oE9jzaCoXi8OUU1HViJBXhIlqO3b/ue6ZV7cNoyNcDJzgPTXWEsI6mLOGAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VvCb/j5vM1V653Z0OTKrh5xGhmFBEFd1pLCwpHctBY=;
 b=kVtMBzGuBL/bk6LR/bS8S7JO61PIGvg7Z/GrnrSuA1QOP9a8+1IcFKmaOTZtC/zsGs7UJaVnsAtxed+5r6AH+ZpVra8phXMs2PExR/sjPOZFuJMuzjL75BSVfGQPor0+s17jAYhPyyIcw8R3Fzn6n+hExiyVn1Et6G4bQC5SKRY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB8071.namprd10.prod.outlook.com (2603:10b6:208:4ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 11:09:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 11:09:17 +0000
Message-ID: <6cd15fc6-3149-4898-af40-6917f713f053@oracle.com>
Date: Wed, 22 Jan 2025 11:09:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/5] bpf: allow kind_flag for BTF type and decl
 tags
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        mykolal@fb.com, jose.marchesi@oracle.com
References: <20250122025308.2717553-1-ihor.solodrai@pm.me>
 <20250122025308.2717553-5-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250122025308.2717553-5-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf6e7ca-b56c-4241-64d0-08dd3ad53617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzNYcjdTQ1JLVDdBTURleUdLQTFVQVBkaEphQy9FS3NBb3RrT3N4YkRERkpZ?=
 =?utf-8?B?Z1V2NkQxREFoc01HSWdxTzFsNGJiQ0tPU0VjMkV6cUFkRmR0U0Jhak5GQlk4?=
 =?utf-8?B?bFROMzU5M3kxVFR0YXhQR3V2UWM5VXJIMkkvZnJZMVYwVjZCZ2l3VFp6bGRl?=
 =?utf-8?B?NXNkcEYyMWp3ZUU4OEVXRXQ5bEJFR3FYZUs3MHUvNDdISjUwS3Rzc25Gc25I?=
 =?utf-8?B?ODMrTy9uUVkwZ2x1YmJIZnRVMzRNcndRZVdjNGsxSjdmZGpGRTBGWklnY2tp?=
 =?utf-8?B?SHRZbVFCeXVEWWNVWWFEaE5tWEtMZE1KQWdnSytmRG1wWWw1K1c0MDBXd0Nj?=
 =?utf-8?B?ZEdNVFo0RkRTdVBKaTUxbmVTMm9HZ3MxTlEvVnk5Y0x2eG1QSkNOWkZIYTcz?=
 =?utf-8?B?ZlU1c25GUjFrcEgreEFQVXdVUXZxRkhXdGVQaTZTSWc1VWc2TzNIcEo5NENU?=
 =?utf-8?B?VzJyWGYzVjdiRWs0cGlyM1g3MDJjdGNsRGVQOW9JTEJHYzBTa2ZFeWJiTmhK?=
 =?utf-8?B?alhLWXJhMnlOcitLb0FpSjdKdXpNeUVHOCttRlhWL04xODJOMEVaSG9ZUnFk?=
 =?utf-8?B?a29pUkRHRHRKSHNJR0VNMlBYUFZXZ0NVSTIrRWlaUytya3pSZFYvYTBvTFpV?=
 =?utf-8?B?UzUraEdValQ5bzh3bmFYcVFKKzRFVmFoMmJMSzN2dFNCSmZteWhHaE5aVkZD?=
 =?utf-8?B?M0NyZkRQb0Z5Ti9LWVZTYlNzK01lZXNrK1ZKaWNVdit1eGQ4U2hVbnd3NjlH?=
 =?utf-8?B?UkJUU2M4SklZRUxmR2tFSGpIVm5BQzZMQkJXTTl1emhBUWJjLzhVd1ZKQnBT?=
 =?utf-8?B?UnRFVlVmK1FtSTRaWjBDWGx6Q1Y4WCtXdUcrdUJZV2FQRnoyTE84V2FJUFBr?=
 =?utf-8?B?bGVTZ3p3aE9qVHVDVjZoa3IyYm1WT0pkbDdYN2FsNlN5UkxHS0tzb0h4aWtJ?=
 =?utf-8?B?MGd3bFJuSk9DZ05kSGQ5RzJUZUNNbG1FcGZ2ZmdHU1U4aWllR0c2YzFteEhi?=
 =?utf-8?B?R3AvU3kvRkRXWmpwNGFLck5RYnJISmZGTDVsRkE3TVlIdnhxYTRSdEJxR2pO?=
 =?utf-8?B?Ums0Q0tZN1NqK0hReFg3QjRMVTJUYVBxRTIraFZUYWM4SVg5ZHdaZjlDc0s4?=
 =?utf-8?B?L0o5UzlsaTE0RCtxVkY3Zm14SFJ0WEdDZEV2VVJKZzE4T1ZteDZLbzZWM3RK?=
 =?utf-8?B?YXlITjJMMm8zOEZabkZRcEp2UHNWMTdrazQrT0QyNHBNZkthVE01NzFxK3hG?=
 =?utf-8?B?Nmd1d2tMVnJoKzFWejJJK0NteWdwZUFPZUZNVUxoZU5NVDIvVzdraGRjemc3?=
 =?utf-8?B?QVJGSi9OZllVREQzM0t3SUpqWDhyYXFaazFLeldpWFlmZFdYZFVIei9YSEwx?=
 =?utf-8?B?NnZHb3owZjBLdGlDMFZIY0JTYzhRRDZvZnRtQU1aQjZuenAxZDg1bjdvT2g1?=
 =?utf-8?B?R0NpaXY0Q2lqemRTNFJrdVNSNXBKMlR1NUhDK1FhL2xadDVsbHRyS3gzeFhs?=
 =?utf-8?B?ZmpzQWk0b1J0TEtBTWRJTDZhUDEvZTM5a3hWdHJ2UVFYTUlhV1NCNFp3QlJo?=
 =?utf-8?B?bGwrczEvSEdsbGVJOE9Zb1ZyMlRib1l4SUNQUDJ0c0ZqbGpkdjVuUVhmd2Q5?=
 =?utf-8?B?OE1yTHFkQXpWZkNDY3BkNndWc1R5Q0p1c09wbW5reEltaG5KYVV1cElDUDA5?=
 =?utf-8?B?cFNyS1F2bEViUHA4ck84a3g5NGlSdGxpYU92ZWxBWUsvUjV3TzZ3cEhHYUEr?=
 =?utf-8?B?ZUM2dUlQS2gzRmpqK3pKbUg3bDV6eTBmb3MzNnEvaHJ5V0c4NnB3ejBQQ3Vx?=
 =?utf-8?B?czhYU3FwMmdqLy9Zc3RtSU5pVDUwc1l4Q1pxRHJhd0NWSXdaQno5QXZwUXZF?=
 =?utf-8?Q?YCVc7zqertefP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlRaclozWkRyWHFaMTlJcnFvQitrT3RxYTNrRHJXUGdaenFaMDJqVk4rWjNk?=
 =?utf-8?B?R0hKMWZoSWVQa0ROU09GcDBKMjVuRjl2em01V2R3N1BoNXdybjFKSTlxSXRr?=
 =?utf-8?B?czQ4dndLcGozR2hGTExFVnd5aXFXOHp2UmQvKzBla3YzaWIrVU94Wk9GbnBI?=
 =?utf-8?B?VUthV0V2VFFlQ2U5ZTZNTlRKbWdRMnRWTjhCNWdXUS92UkZIRVZuS0JzM1Z1?=
 =?utf-8?B?TnpZRk1vWktZRlk1aHNqblZ5NWlycVdMZFFqQWhTNGhmeGFWdWpoOTFFdmJO?=
 =?utf-8?B?RkhWZFc1ckYrNUtSbWRkRE5Nc1JXdEVzMUJHdzdDYlp0TDlXUFk2dk9raW9B?=
 =?utf-8?B?bWJSNjF5RzhxdDdaL1VPVlo5cGp2Z1kzMXZsb1FuVGIrUFEzc1I3Q2IwZ2c3?=
 =?utf-8?B?Sm56U08zRUxtS2hhd1plNTE0KzFYREFvM0kySUg2YXFkNUFwUkpuMUF5ZXZz?=
 =?utf-8?B?TWswVHFib3RhMDd4cmtqL2l5L3FyVGdJbTVTRHRheXVHb2d5RU5jUzRHeW90?=
 =?utf-8?B?RUIrRVUyaFRnUmJFRUtza0puYnpvYW9hRjZpNHpuV3ZxY0pCdjFMY3BLaVdX?=
 =?utf-8?B?VVNsUW1lOEUzMDI4eXYzUGVwU05SdXBsNFFiL3BJWm1XK1k1UXZHY3ZyTVk2?=
 =?utf-8?B?eWdSd3hJOUVNRVFXaEo2R0hscWp4aXV3TURiMlhDOVhQWjByVlhuWEtUeXNY?=
 =?utf-8?B?NkNyTjFRMXdkdU1Mdk1ZTldwNHZYMTM5NzNMelpkSUpmamY5MVlmRVUwQjRz?=
 =?utf-8?B?RHdVa0lydVd6aFdWL1ZyZjMwbGk2WWRBa3FPSXh6V0pjelV5Z3RRZ2JhTStn?=
 =?utf-8?B?eDJLcEk3RzY1SUxZcDJZNW5aWkE3OGRVVVhuYkFMZmVCcmcrRlQ0ODVPUTBy?=
 =?utf-8?B?YWNKTnBVOTU2UEFWU2l2bXk5NTZOVHNiQlJ0RGQzYnVkMm9mM3dlMWdJczFS?=
 =?utf-8?B?bkNPZnN3Qy8vUTBYTkRldEtWT09YTHRJU1c1UHZmZHZvNmJnQ1c1azBQL25t?=
 =?utf-8?B?Si8zWHBhVU9LUjQzUEpVS3lVakd4Rkp1UmMxRDRFSVJBTkFCTkg5QXhjYUhK?=
 =?utf-8?B?Zm5nUEVNNitReU5raEFiZnJ1TWZOVS9CZzFkWEdUaGRPbWRkTk4wOUNBTHNN?=
 =?utf-8?B?alJWWkJKWkk4WDdFRWdCWjV2LytSU2NNY3Vzemp5dDU3QXhVZXVWNC9hZTI5?=
 =?utf-8?B?YkhIbXR6dWtMcnBuc0hER0QvUklrekxYZGVIdHZLajBnYTdBRzJLQkNiaHlD?=
 =?utf-8?B?N1pVOUl1NWtNWDRYMy9IWFBEZUMveUVaMzNWdzFhanhyd0FiK3lzMU01dTFv?=
 =?utf-8?B?aWgxd1ExT0dnR09xZk5EeVZ3TWQ1dmE3RWhPY1BoMVRGU0V1OXN5bm91bjE1?=
 =?utf-8?B?Z2xoNTlCTVVoYURnTHhHeXpRWW1CeUZ4cEZTVUM3QWdUamd0bFpPNVJtOVQr?=
 =?utf-8?B?M3pWSU9vUG9TdGdnSlJYS2JGY2dTUmloMFAvTXRmRlhaQzMwVnBUUlhSbFd0?=
 =?utf-8?B?bWN3YXV3aU0zVEFRVkM4RVFjUzYzOExqc1BuWWp5Tit5VVlPVytPYUNUR3Ri?=
 =?utf-8?B?SFpiRzc0NzFNQnllMjVNRCtHclRMMlhsWFVmTHJ2c0xrZnNoV0JDRXFrUnBU?=
 =?utf-8?B?Z0U5VUN5RTJJd1hzRlFnMDhVZHZ1ZnFuY0djWnJmNDVmSmtld2dCZnB4Znp0?=
 =?utf-8?B?QXFjV3VnRnYzek5iOVVsc2pPUlhNNitOVjU5ay9CRUFFcEtuUWZmTHBRNndX?=
 =?utf-8?B?ZnZuRzlSdVlyeU05dEVxOHpZL3lRNW5EQ09BVGRZNHFOczZmZkdnY1JhbnMr?=
 =?utf-8?B?MC9oN1dHa0hyYlFMb2FiV01Ua3ovT0xIUGxHTFNQZU9vdmErMnlwcE9lTG4r?=
 =?utf-8?B?MmNMWnlIRkd2bTNOMUJCVXNKalF3T0RrVi9UdlRCWnplcmdsK3pEUk9FRUo5?=
 =?utf-8?B?L3NyQWZpYy9PNzlHQ292TUNrTEhGUXdoMkpYVkx4aXAvbm1tcW5UeTNPblNr?=
 =?utf-8?B?OWxScEtaWHJIaDUvMUlzM2o5YmVXdzVza0NoemRLTkZJVDI1K3RJQ0V3T3pa?=
 =?utf-8?B?bXlpOWt2blZUQW1KMmN5eDJKWDhUa3pPTU9lUW41Zy9PYUJSYnIzTEtYUW9O?=
 =?utf-8?B?dEoxTGdMR282UC8zQ0FQaG5MZmxoelkybktRaHV0dVRUMHJOa3FobmZCS2VY?=
 =?utf-8?Q?hwmeQBZ2sQT9pkZ/Z1dytGY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VJmK6JLZz44Cc/KhOSNeCzgzJ+8f+VBKjkcLcawS0GJVM+CVjBFE3BkcNaIcmoiMMtW6YlEtrMZXALwD/MnMYelLpzg51+loBXtGZJ2Zayg2cMxX0WkelwGkbcebLeKYRkNzAu2kqoWS570cE4ilbQJqdBQ4GmDt/Q8p51k2EVbsoHr14VixwQrxfHoUVga04TKTBOY+iIktQdkveCSZFSQPqlBSoNtx9kOxr80CO1VIbbllYId7gd8Y3yp1UlrWRwFZFeQQ4MsF3MXt4BKDE3/TuJOv4ldSH2YlDV/HmMAHxLqKOvISNjZTMWH13j/HAy3502Z8G1F1cQ0hmjlOxEpFev7rd4c3IfgvhpzeEgdG4L6a4Ig6uP4Y32mn3QAlC4hePceAUPE5ZgrlZ06ZcZeFZgTgU983ZXQtQ+onhaGbWZNX63WABcwwDfzrkJOhfk2T4oIc9RYoAFVtKpJ2jrYnhAN6aPPsbJKJoZFbxgGADUsQ4QrAQMAOJhgiiCiQynwezPbCbNwjnkhUnAdusfHEytIKih5aIFW3nGD54u463dC27oKCuHN/o6zF2dP7diKnk8QjdQsTYYecdjbhjDoEf9FzZYqk1fY0VGekVPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf6e7ca-b56c-4241-64d0-08dd3ad53617
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 11:09:16.9820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cftav43i/GJOOFshxhZWyIoUwJBTrW+WQKEkKlTpVith7wG8NcziLBB7ngTwY2LDJFa3PxeEyD2XaLda6Qz52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501220082
X-Proofpoint-ORIG-GUID: BNGhBeYZ4s3HPBPmhya0lip0C-fW_dmO
X-Proofpoint-GUID: BNGhBeYZ4s3HPBPmhya0lip0C-fW_dmO

On 22/01/2025 02:53, Ihor Solodrai wrote:
> BTF type tags and decl tags now may have info->kflag set to 1,
> changing the semantics of the tag.
> 
> Change BTF verification to permit BTF that makes use of this feature:
>   * remove kflag check in btf_decl_tag_check_meta(), as both values
>     are valid
>   * allow kflag to be set for BTF_KIND_TYPE_TAG type in
>     btf_ref_type_check_meta()
> 
> Modify a selftest checking for kflag in decl_tag accordingly.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Looks good, but I have a few questions here. Today in btf_struct_walk()
we check pointer type tags like this:

			/* check type tag */
                        t = btf_type_by_id(btf, mtype->type);
                        if (btf_type_is_type_tag(t)) {
                                tag_value = __btf_name_by_offset(btf,
t->name_off);
                                /* check __user tag */
                                if (strcmp(tag_value, "user") == 0)
                                        tmp_flag = MEM_USER;
                                /* check __percpu tag */
                                if (strcmp(tag_value, "percpu") == 0)
                                        tmp_flag = MEM_PERCPU;
                                /* check __rcu tag */
                                if (strcmp(tag_value, "rcu") == 0)
                                        tmp_flag = MEM_RCU;
                        }


Do we need to add in a check for kind_flag == 0 here to ensure it's a
BTF type tag attribute? Similar question for type tag kptr checking in
btf_find_kptr() (we could perhaps add a btf_type_is_btf_type_tag() or
something to include the kind_flag == 0 check).

And I presume the btf_check_type_tags() logic still applies for generic
attributes - i.e. that they always precede the modifiers in the chain?


> ---
>  kernel/bpf/btf.c                             | 7 +------
>  tools/testing/selftests/bpf/prog_tests/btf.c | 4 +---
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8396ce1d0fba..becdec583e00 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2575,7 +2575,7 @@ static int btf_ref_type_check_meta(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> -	if (btf_type_kflag(t)) {
> +	if (btf_type_kflag(t) && BTF_INFO_KIND(t->info) != BTF_KIND_TYPE_TAG) {
>  		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
>  		return -EINVAL;
>  	}
> @@ -4944,11 +4944,6 @@ static s32 btf_decl_tag_check_meta(struct btf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> -	if (btf_type_kflag(t)) {
> -		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> -		return -EINVAL;
> -	}
> -
>  	component_idx = btf_type_decl_tag(t)->component_idx;
>  	if (component_idx < -1) {
>  		btf_verifier_log_type(env, t, "Invalid component_idx");
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index e63d74ce046f..aab9ad88c845 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3866,7 +3866,7 @@ static struct btf_raw_test raw_tests[] = {
>  	.err_str = "vlen != 0",
>  },
>  {
> -	.descr = "decl_tag test #8, invalid kflag",
> +	.descr = "decl_tag test #8, tag with kflag",
>  	.raw_types = {
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
>  		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
> @@ -3881,8 +3881,6 @@ static struct btf_raw_test raw_tests[] = {
>  	.key_type_id = 1,
>  	.value_type_id = 1,
>  	.max_entries = 1,
> -	.btf_load_err = true,
> -	.err_str = "Invalid btf_info kind_flag",
>  },
>  {
>  	.descr = "decl_tag test #9, var, invalid component_idx",


