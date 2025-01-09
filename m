Return-Path: <bpf+bounces-48418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AFA07E1D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35F4163C23
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137118660F;
	Thu,  9 Jan 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TlWfPLxz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SPdO8Tc2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6F158218;
	Thu,  9 Jan 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441706; cv=fail; b=bjTi/8MuUd2PSAOEnVzKvLRtv1EyUdxB0COgPwKOrZSRwQK27fja3mVJ9Xw8CK/N76nJ0IjKhBlNv1JYRM84EOin2w2TYEjo2ipTamkvCJBMPTVXbCJ9I2jJTbzfi/vGUEeSTfF875VWM5M4yTjfBKL3blGEme8+XMhoTj6CbUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441706; c=relaxed/simple;
	bh=fWX1XQkT+lwWXn8zVa1XO0LT08WtuL3IPxBsgxplb9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFesLubxS1zQG4/QN1yJvkJIDkwckp0NSdq8rv1FIDjsvsqcKpAhSmZW13UYyrlnXg81K0hXkLDB/5ZoiAMwm5Ft8lBSsyKipxq8IaRWyd7GXLDWlMPlcYYxYWcnEedL2egTzKqSantf6U3O7ja8HTL1IhXAKsem96CnC0vZUzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TlWfPLxz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SPdO8Tc2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509GXoLT030178;
	Thu, 9 Jan 2025 16:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9JXkPtNWaPUAKZY9u7alUy1l+pCIiYeUp63sAa5rdh0=; b=
	TlWfPLxzHnBs5IS7mKieWu6j6abQ8UW6UDzJaFqJpHWeTbmpfUiukHjtpWv4UPnm
	a7IIoTCq7Vb3mpU2wc6hgRggpLNQ3+3ZiP0Fn/F7AyhYJYVO1pfgbaQ5bG4k7IGp
	XcSItz/0hGlArMiUK67WbydiSRg5YDJz5S8MaJQjh+qZHdZ3/9tv+cLX+ukY2mc5
	9Gyup86pQtbiy2wOlLFUPL9eFdef4v3gV4prTh94QPsI+Vg/DNwU4cpSlUAr8eJc
	gVPJ3ZBNbLOGx5CJjJalMtAe90TOWbum9QSpaWEu/vuySJtSY2iiV81kWN4MLos5
	Sl3N7pGAPwQIUJ9IWmuwKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk09mn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:54:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509Fp0hG019969;
	Thu, 9 Jan 2025 16:54:52 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuehpe5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 16:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPBBeO39xTwqrTprbXOpP3O/GO85a90ndR99qmTVYif85rKhvqpzWwf/eGJFYnxgI4YE6yXjMa8xl7wIxuQASFt8dw0m0nIVZ5tix/xOopo01+alUJIQHmAkLwJPH+soGBBHevJUjyjACJN/+Uh4siQjZ78NgCqBtyO9KKcqRw3byVALgiURn+E3POHQq6L4fwc1ySRaNY1zSxzhwDRyMfyJjhAv3EjwtUC738e4hUo5hgiGpETgVtGXoJzjbZzUCSnu+vkD6J2ObBKfyFNOLMwfP2ZHgqbXL9YQxkyF0y459GcPMYe5bPJ0KU+6eQt+BC98OX/C7uLoAmzvMYS31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JXkPtNWaPUAKZY9u7alUy1l+pCIiYeUp63sAa5rdh0=;
 b=jypeLIBzz87qullgIQUBB1B7xoBOQQbz270DZZDHwKxYGZwC3UWwgM4b1MMe0faVWKHRz7Q8jlzfnTlMTSUiiJAg1F078AnfIbcSKIE32CtAQaA8rS/OE9YXnrEFiyCg1VOw88M6sCddPMf7O8JeV/neuWKSWnaUGpqumobrkF6DmPiHuPfLedut87w4RFmiQaDVwAPBbEXMjRIvcjo0O/1Km08E0OVV7PiV1C+60jACHsUif/+2hnmKi1brpduVJrFx1xdxjzVJ8e+hgyteo2L6NMHrJiPjCfwbKClnPO+UvWVFuBNC9JEno+f06F3cHXvfc3NNsdCMLOmhunrrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JXkPtNWaPUAKZY9u7alUy1l+pCIiYeUp63sAa5rdh0=;
 b=SPdO8Tc2hO7u7xGjS3zm42RGY8BePLGyvMG1cjCAWCftybDAu4qI0Ci91lgYfbemJ0Vde1NWBkMRbh/L7tlTFn8pNS6SnwDIyYJsYMkq0LLh4K+FASw1GcLrUlh4b6xGQvaAeYcyTwdKJfy5RiCCwLiAXQZJtjgsnI7AvXtJxy8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 16:54:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 16:54:46 +0000
Message-ID: <6e54430a-1e3a-4858-ae88-21b52ca49316@oracle.com>
Date: Thu, 9 Jan 2025 16:54:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 02/10] btf_encoder: free encoder->secinfo in
 btf_encoder__delete
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org,
        mykolal@fb.com, olsajiri@gmail.com
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
 <20250107190855.2312210-3-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250107190855.2312210-3-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0034.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::47) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a310ab-231c-4620-ff29-08dd30ce524d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUtvT0k4bS9ja2JISXNoRG5QUkh1V2hSODVFOHg0cW0xeEZ1ZzU1Y1VOMi96?=
 =?utf-8?B?SGJ0dFVDdWtsZXpHL3hmODhSOXRkdm1lTVJXMWJGdEx0UTFvOHR6OUtXUnlj?=
 =?utf-8?B?dDJtOHl1MkdvNDA3b3NGeHBtYVJ6bFh3STFocFNvSFhNM3ZrcW92Qkgxa0N5?=
 =?utf-8?B?UHkramdFRnVzUXBIRStWZTJmbHFGMzk0NFFmK0hyb1lzUWI3cG1mczRSOUdt?=
 =?utf-8?B?MzBpbkZSVlZ1bFdUbGtHT1RWQlhSOTN3SnNlWXVra0Yzdy9rWW5rM1Q0QU0z?=
 =?utf-8?B?VUxjbnp4VDFiUEh3ZUhFU3dkSUlGYWQ3Vi9GNEVmby8yMjhCYzg3M1NXOGF1?=
 =?utf-8?B?UkpyMHI4cS9NTTFRT2w3MCtuTVU1QlhPbXoyRFVwNmdNR284a2NEb2RrWG9O?=
 =?utf-8?B?WHJXb2pBQW1EcEdVdCtXYmRLNnozai9SUXI1NUZTUWh5RlBJejJ3MU4wTTVG?=
 =?utf-8?B?dVVhY3l4WEdVOENVeU01QkpNNCtlR3ZDcFdmWklWMkxUMVN2Ri9iOUtVc3Nm?=
 =?utf-8?B?TWI5Z2dIRUpabW1nemRNNEpFQnVFWTFVWnVBR2ZhNTM2MGhmS1VZUzltRWF1?=
 =?utf-8?B?b1BoVWpDWGVENkI3dm1CTXVhWENEMUxkMy9jcDJKL1hyTTI3WldIRjJaT3Vv?=
 =?utf-8?B?MlRPU0E1VTVvUmwwaERvYlE1cnZHR0dCT1RZSExiRE5BTi9kQzMzdmNXU0l3?=
 =?utf-8?B?Y0lYanZYSmMyMmNGcXo0bUlSQWZzY0lSdmpIdGIrcUNPV0llamtVR25mMXBI?=
 =?utf-8?B?a1FsYng3RmxZdHh6UVkrWGJPdFIyeG5GZkFzeHVQZEZ2QWh5Wk5jNTdhRDZE?=
 =?utf-8?B?TUpRY1ZteDB2RXE3Umc1Q2lpbG5IQ1RpSDViTldVN0R5dnA1cmoyTDkwY2Yz?=
 =?utf-8?B?Q2tRakNEWFphMk9vYzRsMnZueWN1Vko1Qm1zSWNFVnowZjhxMlkvaGx6SzJq?=
 =?utf-8?B?QS82dURobUFDNDBTeUFxUHUwLzc4MjQyNVNsMk83ZlB0eC9ZV3NvaUpYQ01K?=
 =?utf-8?B?dDZpZ3JaYUVyMGRhSDBCcG1CRUtTNUlhdUQ3dU5USHdrczZhTWNaTlNkMDgv?=
 =?utf-8?B?dzFieU51bmJBajZsUGtoQzNYVTVJcFBLVFd3VkxheHlDWEZLOFlrMEJrTVNE?=
 =?utf-8?B?TWJ5UWJZTmFiUFVvUG93a1BLZTFQckV2NEdpVjgvMlJ4b2IzZHNxbVFpaXFn?=
 =?utf-8?B?YjZKUlhxZkc5a1ZvTC9MKzcyL1liY21wdVRsS2dDMEt0RzdTNXRpQWg2bGhG?=
 =?utf-8?B?RXA1Nit4TnRxSzN2TVBWZDRteDJ1dnc3bW5hV0Z2S2xrSW9lZDRzLzNEWXRC?=
 =?utf-8?B?MzZmUG01VEZFejJxc3BuZi9LV1NmbkRYUzU5Tko5enhkSlhtWktHUFZJd2ZK?=
 =?utf-8?B?MkMzNnpUejJicFhkYkU0SCtMWlloWFczMjNpSUhSZURIZ3F6bTBvaEZFVWVp?=
 =?utf-8?B?b21kV0xTaTRwS080ZFZOZHhvMjdVZkFoTkNpQ2lDQjhPVVkxc01xSUJFd2pQ?=
 =?utf-8?B?SnZOYzQwTUNwOEhEZVlqVzd3MFV3RDFxSDVWQWJKQVB3eTFtdlh3NFc3SzZ2?=
 =?utf-8?B?UzEzU05ka2RqZkZZb2M0YnhTMnFwbUFqUFQrVjdDQ3R3ZHNJVXBaYXlXQXp4?=
 =?utf-8?B?WHQwL0Z0S0Z5NEpaVmJaOFZmMVhGbnpRMFNIUTRhL0JON3BMRlBwNko1QXVv?=
 =?utf-8?B?R1g2M2RNTm1SQlRRVGQzSklyZkM0Wm8xeTFHTGc5Tm5TMkI1ZG90OHI1Z2Vk?=
 =?utf-8?B?eWRoeVlyN0M0c1dZclBLV09uODl3Z0VmNVJLc1AzSlZoVjFZRVNVZHA5OVNH?=
 =?utf-8?B?VXFsNHo1SnpjUWZNRnlHb2pHWW92TlJEVVVSL2grTEFtdnN2eFRtM2g5ZmJ3?=
 =?utf-8?Q?TqwXBrU59XnUI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWNLcjd2VGlEenhMenAwYy92M1B3SFduWlpmRzNWcklnQ25JZkp2bm5DYzR6?=
 =?utf-8?B?TDUxWjFtMUREMC9XL3NmSWp5ZTRmYVpXcy9IRWFSWDJMR3F5Q0xnNnppWlFN?=
 =?utf-8?B?NllUUHF6MGJCSlhGQm9Ec2w4dE9kUU9WWGt1WlhMZjRNT1VYdDViY1cwR0NW?=
 =?utf-8?B?WlV6RFNvbno4Y3FwUUdmR3VLdWhsa2IwamQ3WW03d1RwTjFESWhQaStUU1dz?=
 =?utf-8?B?Y3FhSWNUbHora21YSnRjN0o4Nkc5TUFSQnVkMUpWbkFIWG4yZkY5WUNUdTJZ?=
 =?utf-8?B?NFd5R01MVHl4elNYMkM2TEFiVjk0S3BaMjMzRzlsckkwVXo1SHMzYUlGenYr?=
 =?utf-8?B?YXpvSlBZQ2x3ajdqelkrVHVQYzJ4NGJxQlN3ZEM0eFhwam9kb040bVRMcG9Q?=
 =?utf-8?B?VXVkZHBYNDUvVTVQcmZDOWVEczdoTHBnMWVrcUpsMmd0MGprdUVsbjhsbTQx?=
 =?utf-8?B?dTYwK1R0djdMcm45UkF1M0F1R3drNkYwd1lOOGFpNG9NczN0YUxsREt5aG8x?=
 =?utf-8?B?ZlFyaHZKWUpyUXllKzBoRWg5NmtCOXEraFhNS01ZdXJyNzNOSythVHpkcDEy?=
 =?utf-8?B?R082VnJ0c0JzOWlzVCticktUS3Y5OTV5cU9SVjlrazByTEd4eWlaZ0lkdDk3?=
 =?utf-8?B?SHZDMUtiZTd4bTAzMGpZcW0rbHdXZnpldnhod25uQmE4UWRmeFRJUzE2anBu?=
 =?utf-8?B?UG9XcHkzcUNOajJGYi9RWVJYbnVPRXkvVnBtbFZYYXNwaFBrblVZcGVwTnVF?=
 =?utf-8?B?SE42dzllM0ROSkNOd2Q1cC9uQzN0d2I1d2w2TyszbkNBNHpaWFJ1emhjU0Zk?=
 =?utf-8?B?NDR4RC8vbzR0czB2MUhOcitrL212eFBJU2tTSU8vbWtqSFhVN1NEcnp5ZC9i?=
 =?utf-8?B?TlRqY0phVVRrbi80eS93S3dYM0tpWFpPQWwvVUhVdlZBK2dHZlpsV1ZscHNK?=
 =?utf-8?B?ZG1Sb2tmVC9zU3NjQjJNUWN2eGYzN3RUSllKV2VkMGQ5MWxESytKUkZXRllL?=
 =?utf-8?B?bWFpdmtLNnVVTTZQMDNQQjhGUnZFMWVYSXlQUnk4SllCenhXbkZoVDRBY1o2?=
 =?utf-8?B?czN5L2dzeTViSlNIVDJ1Vmx4OU9VZENHS3pZZWEwaldaT3dweVk0VzBuZjIy?=
 =?utf-8?B?a2Fncm5mOFdjYXFsQnBtbDV4bFZrNFdkdUxTK1JaTXBiaUxLZ280eXljZXNm?=
 =?utf-8?B?UEwxYTdzQVhiZThhVnFYajhjMkVVTFdSWXYzV1NjUWFwNWc1Vy84WWV0c0dw?=
 =?utf-8?B?enBsNVJxSkhSekNjVGNvVW9iWGJHU0dTSmZzNENqbytpNE5ObTZ0bkZIa3R5?=
 =?utf-8?B?V01wbnU4SnBvcjdyeUlBbnpFNlN1bXZ4QzYvY3I5RFlwY0hiTWJjV3ZyY3Vm?=
 =?utf-8?B?TXAwS0FUdlprTEt4dVB3bWpZdWMza2pCY2ZYakZFZThiUzdSWU52ZUlmeUNU?=
 =?utf-8?B?cVZRWGFnelRDcWNiWTZqc3FxVEJGTlkva3ZVWk02UHpObDVuQ0lmNis4SGI4?=
 =?utf-8?B?ank4MFNwVWFMcERnTG11dG9VanBNdTg1RDUyUTRnRDhFNWpHMnFRMzJaTmNy?=
 =?utf-8?B?b2JpTWpJNWFKYVJidE85MzkxaXJYQnhsTWd3eEw3bnoyVHE1aVZqdllJL1BQ?=
 =?utf-8?B?MFZBK2dIKzEvWk5yOVlITWdTZHlhaDNzaW5LZENDeHFLbXpVQzIrVG9wZXpl?=
 =?utf-8?B?dVFNNGhQSExuTStVeUFYMGM3SGlKRk5QUGJqN3c3ZXJrWjVPdHdQMFlNbTcw?=
 =?utf-8?B?dlQ1QkRPdldxOVA4U29Ob3I3dGJ4QzJQQWtRdVREVmVxN3huNmVmMmwzZlZV?=
 =?utf-8?B?RC90RDhCaVl0bFdvUHRPTGJPOVpCcUN3ZlN2Nzc5NWhycmcvK1VKUzB5VnN5?=
 =?utf-8?B?T01KQ0NTWkFWWVcwT0VFK1NXRG9ScHFKRThZdzBrdjRhS0RwYzBlc2t6b0FM?=
 =?utf-8?B?KzBaaDhncTBwNW9MakJYc21NaFhteUJWcWpEb0pjVlBERnhZV1RYTTBRRFUr?=
 =?utf-8?B?L1NRaGhMYUZXWTdKV0pTMkYrTlF3TGhpSzZIR2RnRVd6U0JmR2pOWjdzRmlH?=
 =?utf-8?B?MUxhS1hnTWZJTDRzUDJaUVd1ZHhNL2pKQ3RoODlJcEw1cUloTHR6UElxQ1Bq?=
 =?utf-8?B?YWd0Qnd4bzRSdDJYRUNEVks3VGMva000UElWYjhCaG4rR2pjWmhuaEJCa25u?=
 =?utf-8?Q?4ij6hFlg50hQOT++nWv7ljQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZlLQ+LGvdYEk96E2QQ7T35NzDYw3q6Yg0alindHR2qQK97WOdABc7JOoRp6G/p0JZq2J9OufxRoL4tRUqFRxijWsuo+xrH5zZt9fNp/hAjGGngdieYYZAlsF2egidkiD+KUIkIarszSpeO1F9eKvJzZi0icTmbtJofv6AUZi+imsCOLRYkqYp0eaMnylxtZwD66yT2QSVaxhlO8nEykm+kXly58WTQcOFR0JRG+ejTr2RcUssZVoguqgYohEllaNe8C3VUgNhhPSi5R2VuTPjI58JaH2Oxn1iSknMsxC8pCjN72ZoIg7xcXEyA2+/3RNAhYdv/GIKWYBIAyYO5n+8wo1zQZrcR/SKxrQckGZjPdosPQjuPm3hlKW7cvdferFGiuod9wHG84Ch5/PS9/C3MOefrMWXrw/C8hsYkegqLBPsKOoWFc2V7ZRtKF2bwzM7AqCcZ/1TxOwwkPRNeMJD9Rru3GyrcJnlcwoRWLhpdgzIbECk/KmEkAKBU5zWSZJh4hRO9ApaJ7XLbO6lRWy2L8eapAQX54VvIWJJnA5vJvPfib4Rn6AT76e3dqvJKFBxcThHycdIjOnFbQMVuSwJfn5aPh2j/JnlCdSHWIkIII=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a310ab-231c-4620-ff29-08dd30ce524d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:54:46.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJzCNEn6rFrQFHyHulpJLsNh7xpBED4WZ31h+8nObfNJtMtzcb0MJE3cMjuthhgEAYXJm8RpzvWjjou1l/g1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_08,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090135
X-Proofpoint-ORIG-GUID: 1H4tnDNnGmhTCbiLsguozEaTEPehJ42N
X-Proofpoint-GUID: 1H4tnDNnGmhTCbiLsguozEaTEPehJ42N

On 07/01/2025 19:09, Ihor Solodrai wrote:
> encoder->secinfo is allocated in btf_encoder__new and is
> never freed. Fix that.
> 
> Link: https://lore.kernel.org/dwarves/YiiVvWJxHUyK75b4FqlvAOnHvX9WLzCsRLG-236zf_cPZy1jmgbUq2xM4ChxRob1kaTVUdtVljtcpL2Cs3v1wXPGcP8dPeASBiYVGH3jEaQ=@pm.me/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Good catch!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_encoder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2e51afd..6720065 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2453,6 +2453,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  	btf_encoders__delete(encoder);
>  	for (shndx = 0; shndx < encoder->seccnt; shndx++)
>  		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
> +	free(encoder->secinfo);
>  	zfree(&encoder->filename);
>  	zfree(&encoder->source_filename);
>  	btf__free(encoder->btf);


