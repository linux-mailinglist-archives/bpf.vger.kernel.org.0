Return-Path: <bpf+bounces-75260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87726C7BD2F
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68C714E17B9
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAE3074A2;
	Fri, 21 Nov 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEMAuXM8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g2V2jcUE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BA306B02
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763132; cv=fail; b=c2zTOcAjHun9uvfrcQWg/o2uADINs9WuVWBYGm9b7lD89/ko/MMQbx/YeHz6lqDgPofkuunJNe0derum/p8G48w3yxNfz134cRhP353vdY4sDur4Eu7N+nRhv+OSb5VyYza+nzKNI5MEkgUWIA6k2qmrbQnFzOm26kOJ2lYUWKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763132; c=relaxed/simple;
	bh=SPjrQvl51JYfSGtUtXlESVAB/Sl/E6avn9WEBJgJgj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DMW5QF3qVtiHOAi0ODbhRGZ4LPI8iH8zVlvGLFGlwW1yfDBXumT4LXIzTx9Nj0WOyNtZrrLOiDxmamyKF14z/R+GgQiBKlUbvWfbe6eMsOXVoZe2s8kC973GlETj4BgI6YqJRlPwffDRJdI0hP982Ztvm3H6qNov6ZUMmfz4R2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FEMAuXM8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g2V2jcUE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALKuHLh019360;
	Fri, 21 Nov 2025 22:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QrupO9dI1IV12Gpch2YKW0HED53TZAG1+Ia+sen9mHI=; b=
	FEMAuXM8RobF9ujI5CesxcvqHubCxPg6Em/kbdGeOcCoWhbYK0ee2VXerZygYZHV
	nMyFPs9ZAONCn0TLZuo/Nsw5qplqRLyRCgn7DoBxpWpkTnyVrGWO/tClqCrYyDeL
	CXsSmQLmhYNdh2khySFoiuaMYsDXaD24m0og3MPgZKyiQYh9WK1ldlJNHrRv5gEl
	F8IuFtocuOeg+VOoQxJBSfGKZ13xI77q3p0q+C/HhCUlmQdeKdPAIWG/4kBvbSYn
	bNYEcFRO2S0qrUWV6tc586ypJJCwJDcT6VFelKw8xwJpT40piu39GL9WTdrxZnJh
	cxc6RfAd/YXoOHbhgRZpUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbn25v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 22:11:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALK0ar0035995;
	Fri, 21 Nov 2025 22:11:42 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyrfmn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 22:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhXUqMwUXX9kdyHIRQIztgqbFbkIg85Ots5y1zuHHF1nXqriBeaT2YJ+kYtSF7VUUF6D9yh20CzuMHzITvHhkpjltp5znu14QZRL24rOHOxKkhbQtL1udQSRKcs9mYa/n2PXAJesPm/rKbuYXDmzhNVOjOTRzL+yMRaSwg11xn9/B7EbWudCCMMeacu0soHyzn308DdPhwdO/NVkKp9HkpTMkBu33f3BLyQhyLZKD6Bj1dDxyInnzP0qXBxH5JUkC4un+kUz7lf1h1lQR+s3KW+0045WpcnkFtRG4iX5PvLFbyx3wVKKOXfjx5me+6Vd/Kih7+E9Y2VFRlr8ZgAC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrupO9dI1IV12Gpch2YKW0HED53TZAG1+Ia+sen9mHI=;
 b=Zd3vpeQpkWyv3Z/rFn4929tjrGlVE1XrgL2DM/6Jfj0lACQX+i5JQuMYSZnoF2jIxrQ3yZUufstUaxvNX/o/dDJvoCouTRaDSV98JGPkUzjpADRP4s2vGSYjcAxT8ql3v0fhTcPBtXGZuC2LYqc9JIEpqDi8PeqglgA2Glgrp0WW/BqjaH3EdhfFlQdeRy5oFruX0ZIYYzJdOLuCXAygb8oJqFt/Xfo9wBYzrFsPIkqmvWnkR/QU90fGKtfSBtjeWmdnuuXD0S/I+QM85sGgmXnKx0Yx10ObIL1UP/rQe12PGVE+1crNiIXjaJKQSD1DE7ojR2HxowD9GmN1CAZ1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrupO9dI1IV12Gpch2YKW0HED53TZAG1+Ia+sen9mHI=;
 b=g2V2jcUEVYnm4Qu50bekbNYLS6NfCXT09OjZfSngH6jVbwRIV6x7Us+Rozf0o8eHTtkC+MzIvh81THJO6vuLSvz2Mqz009fJfc+4wmB+Lq2paYkMDs4mRmQOjn1unonIrKtdiOT1LdXx6vzZojsHdfx0R9eIWKaRMr4J1blyCI0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA4PR10MB8423.namprd10.prod.outlook.com (2603:10b6:208:55c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.14; Fri, 21 Nov 2025 22:11:37 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 22:11:37 +0000
Message-ID: <6a41d047-762e-4c03-8959-73f497445535@oracle.com>
Date: Fri, 21 Nov 2025 22:11:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
References: <20251120224256.51313-1-alan.maguire@oracle.com>
 <37e74a8b398b8fc69797ddf16b21f21282ab0a3d.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <37e74a8b398b8fc69797ddf16b21f21282ab0a3d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA4PR10MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1577fe-41a1-456e-9380-08de294af071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGo2WnlDVjFKYUg2Q1o2ZnhFdHFveDRiT3NvQXd5cldsT2lRdGJlM24xbkpB?=
 =?utf-8?B?UXBXZGR1eWR3VDZ5Um1Nd25aeDA4bnlRdkNWb1dSMlJhSzduTlQzQXdFVVRs?=
 =?utf-8?B?elVTZ1I2Z0VEMjJNT3lxSHVoMXBqRWlXZm5JUE9uYVlOeEptNUZvTUFTWnVr?=
 =?utf-8?B?L3RoM0lWR2hCQXF2bWtLdzdzZS9YbWErc2Y0QkRTMWFldVJyYlBNR0h0OUpK?=
 =?utf-8?B?MGtNUUVrN1NJMzAzbFE2VW9WZEdQMno1T3BwTEgzQzZET1J2ZEZlVEJPUVR3?=
 =?utf-8?B?RWNpREpJRnh4N0o1RE8vSEE3THk0ek9QTWNiY2YwYlNRWGhlVjJaVnFvZ1Ru?=
 =?utf-8?B?OTJ4cGdFYUFkVGkrRTZxWGwxVmVIbkE4dWpWVmlzQmdQN3J1MXFCdU9kTjVl?=
 =?utf-8?B?RkNmZTZEck9SUUhoMXpYR2JLYmpsR0o5QlBGN1pjUEx5SVZLNFBPRTdKbWJV?=
 =?utf-8?B?K25nU2FOSEVkYVUyR3F4VWQ1alZRdGEyVFZ3ek9ZdEQ5UXFBbWVvSW5CL1NO?=
 =?utf-8?B?R2QyL01SMWt6VXBLUVBxL0pic0tQZDlMVm9SUkhPcjU3NWRzSEs3Z2JQRjRL?=
 =?utf-8?B?ZGVkNFFmaThENVI0WERoU0trdy9PWno3VkphaE9mL1RFVWtyMTR6b0xJNFdk?=
 =?utf-8?B?YXE3Z3hob3B4MnpHaGNzdDZKdVAzWHl1Vk9XU3hyNDNWd0NJVHZIb1pYdW5E?=
 =?utf-8?B?TU1McWNTaDZEeGFxMXYvb2ZXOXJSYkRld2ZKdXY1cEVvclJrWTh3RnQxNlVY?=
 =?utf-8?B?bWZWcjd4WUNlNFBsLytyWmZsWXlOOGY4K0tWeS9PSVk4Wlg0eDY0MzFQenJZ?=
 =?utf-8?B?cXJaQkhjSVM5VXcxbUFScFJBSkRPRFo3K2puTis3YTBLSkdXT3dUYnZTakxq?=
 =?utf-8?B?Z211aFZHK2RJVXN5dWlHL0d5dnpvajVBalVXaXZXSzc2Rkx6WEk0Q3JqVTNZ?=
 =?utf-8?B?NTdFL2NhMDRlNWRma0gzblQvWXhyNkMwcWpqOEVPZ3g4ZVJNVURSZ1pSZUd2?=
 =?utf-8?B?SWc1MlRTeUV0ZmtpaURBNmg2bHRIQ0hiZnhIRjRGd3VieC92akNmaGxwOUwr?=
 =?utf-8?B?M2R2dHNISkhHeDBGRWpZUFo1b21aa1FJN2l1Yy9reVdpSTFGem1LSDBEc09o?=
 =?utf-8?B?c1hjcmdGcFBNc0JFNk1TNlpycGNaUDlTZTEwajNiNXhsYXI4ZTFjUEZMc1po?=
 =?utf-8?B?SWI4clVYUVB3M1hnMHhDWVR3Q3lXaHNVYU1uSjlCeGYvTFF5OFZPQkErZ0ZB?=
 =?utf-8?B?S0hHVjhoOG5YeXg3SlpzNEI5M3NES3AwMXR2RzRHejZVZzEzalFUdTkvV0RL?=
 =?utf-8?B?QkxuWW00MmZtY215ZXQxUFh6S0hqZnlEajUwT2twWlBIQUY2YmNCMTF1UHM3?=
 =?utf-8?B?RFU3RERjbWcrQldneDFVQXZDOGxhWmxzQTlLVXFyd2VTUUF2eUoxeW02RWJL?=
 =?utf-8?B?YWQxSzNEUDJOMS83bmVRYWZjY01Pa21NQVpiV1ZvTURaOVJzM0lFRlZPUU9N?=
 =?utf-8?B?MW1rVkRBbnlvbDFwKzF6S2NMUW9LVVhaMkVCekJjbnQ1alV1L0NrL1ZtMFBL?=
 =?utf-8?B?MmlnMVVBcTd6SU1pa21mRFp4L3JaMFphL1NrWmVQV0p4aXM1SFVpYlV0SkxJ?=
 =?utf-8?B?VHZkK0RZTDB1ZWgwVDYydVgzVjlJOEgzWUM3a0ViellvT2d1a2dzelgxOU1L?=
 =?utf-8?B?VkY0ckIyU2N2Mmo0UHlQVVFSZ3hRQTd4TDBicEFPRmVDY1BMZ20xd3Q4TFBp?=
 =?utf-8?B?L2lvLzhxQkptYWJEeUJnS3YwSGNJU0pMODJNL2hJaUhJMzIwOXNtTUtNd0Jl?=
 =?utf-8?B?aGlIY3Y4OUFZSldnYzYxS1BQM0c1T0ZoVk1UMXk3UlFkdWNPOFlJbTZnOXNo?=
 =?utf-8?B?L3JteUpUTVhQM0Z0OW44Y1ZuUXVJUmV4c3pUUkVBZEg1L1V6Vjk1cm5ObGYv?=
 =?utf-8?B?Ymx1bUJMdG9CSjhXR1Zwa0M0d1FQaUpwaEo5eGpMQ3YrNVA1ZUQ4bjR4NWJZ?=
 =?utf-8?B?N05HRUFQNDFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEVpVjBGZk4rYlZqazVRaWs4NlkwYUpSQXFMRGhvZm1RdnZuY3BSekdnN1Nm?=
 =?utf-8?B?Q1RNejhic25zSkozY3FabzRnbE50elVGYm94YnI0cGdLK2pnNWs2YjZwb2Zr?=
 =?utf-8?B?WlZ3SkxudEU3SmRjUWJXaUxBaVMwNG0rN0w0ck5UbnhtM0NXSTRtTHp2all1?=
 =?utf-8?B?aGU0VUxkL0hVd1NMSzkyQkprWlBFa1hkYk05TWxVZDBwbVl4eGVkanlXbDhv?=
 =?utf-8?B?OHJscVczNlROQjBUL25NdjFwcFVzUjRuZWQvQngxTjdna2NOUTUzeFFBbWtk?=
 =?utf-8?B?dTNEeVBnc1hyc1ByeDhXbXNyeTRwS1BHUmIxeEFNWXdVcWk3ekk4c0p1eUpp?=
 =?utf-8?B?WGY2ZWsxeThvZVdjdnIrcDE0Q20yS3AyVzNkYmZ4cVhmemlVeklZWXFrbEgy?=
 =?utf-8?B?Tjdsa1VSd1dYR3FWSlprL2R5aktZN3gxSzZ3UmNWRkJWVkNRcGg2Z0k5R0NU?=
 =?utf-8?B?U3hNZ3hhbmUvelRBM3BnOVhWVG5yYjlxQ0pCcUdZSStxZHQwVWZvbDhwK01t?=
 =?utf-8?B?VVlMQmVyaGE0MlJEOUx1QnNWU0VMdDA1M2JyeVQxS3JQMlZIcDlGUmtrb1F4?=
 =?utf-8?B?YVVRNzF3NjlIZjRheklTU29nYkllOS9TNmhVTitydlgybmpQQnFva3IwMWNx?=
 =?utf-8?B?M0ZmYzRMWGtIWS9ZYVh6ZnpRUFE4N3lGZTFvdG1CZUc2VWJzbElVNHMxZHQv?=
 =?utf-8?B?UFg2R3dJWnpTZUxvSFJGczZZWGxZbExvS0ZNVVBBRno5MnlCZVgzdGQxZWpE?=
 =?utf-8?B?SWNwOGhUaWlZN2RSR3RWR3JKN2JBVTJzWTU3RnVXNzROQXhkeTA5c2tzZTB3?=
 =?utf-8?B?VWNiVkVBWFo5UXV3ME5RSVpmemFuS2U4clN4QjcyUk13dWp5ekc4Q0RpTEFN?=
 =?utf-8?B?enVnSVkvY3hMYmh5dW40YW5zT01xTlNGWWF2Znp2a3JXS2RuU2dVQ0d5ZzUv?=
 =?utf-8?B?TWNjRURTNnFRcUZFREw3UXYzME1TYm5VZkNaL2I1OVFjYXV0NkJyeDZzRElj?=
 =?utf-8?B?bGZTeGQ0ejU4VURURHZWYWhBaDhEQ2lpakt4ayt6VktYb0wzSUdtWXpwcUsz?=
 =?utf-8?B?a3AvZzV6Mjg5Q1lCTEJPdW5Ra2EwRnFRTFd4M3FUNWErWU9RazA2RVpuVnl6?=
 =?utf-8?B?ZTdtWGRQSlRXTFZOQVIrUDBIZVFpTG52QkVLcVNyQ05DczRKRHorOWhoVTZa?=
 =?utf-8?B?TFVwTWNEdld4VlErakttK3pVV2VpcGR5eEpWNmtYT01IZGt4bmx2NXpqUjRx?=
 =?utf-8?B?ZkRiaFcxTU9valFCQTNvbkZSS3JVSWVGQ2o5dnlDVWxUYnBmb3hXdDhWUGNQ?=
 =?utf-8?B?eU1vK1FXdmpJOW1pbEY2aktucDhtUWZ1OUQ2RklleGtMZmI2QnpYeWRyUXZk?=
 =?utf-8?B?YW9GR2tjcTgzUHZPcnpTZ0RsV09HdWhabGMrRFZaNjRaWitsUmdnNFZSZWxI?=
 =?utf-8?B?bjR3UitoVDkyQkhmb05wUEtXSXlTcHpTbHBzRWJlNkxwWER3ZmJQRktaNWY2?=
 =?utf-8?B?eUlUaDJIOHUrQ0g5d0k0SE94S2dNTTBqWDNabm5NNGpBTXoreEg4RzZwZU15?=
 =?utf-8?B?ZVVBSVdlY1FQNVE2OEZZZDB0V2g1NVR4TGJJRUF3K0dFSFlpNWN1cmZYMnlQ?=
 =?utf-8?B?T0hnYUQ1WVM1TnplcFB2YU5nK0FDaTZtdHdkc0pBQWR0ZWpSM0FvbDFRYkxB?=
 =?utf-8?B?bTRsdWFRUmFYM2pqZWdQbkJQS2lBbHJudnpSTnFkUkwwSmltLyswRVVyZTdY?=
 =?utf-8?B?Vk1oVEZ2dmZseG9nc2FwUHZZenRiUEN0dFFOcHFLbnRxUmdDczRPUWgxWkFD?=
 =?utf-8?B?YXJMYWpOQXBndjB0Q3FwUXFiZWJZYW9TQ29JVWJtRk9nVTdlSGhyNmJvNC8r?=
 =?utf-8?B?TzZRaFgrU3gwQS9rZStmZGpTd0hSSlZ1ZmNhKzZTMlg5WjBYNURsZ0dJbm1I?=
 =?utf-8?B?ZENhb1NWckxEOGFmN0NYczMzU0Q1c0gzKzRuYlpiQ3VoOE10bUg2WkZNcnFa?=
 =?utf-8?B?aDdXVDBvYktMQnE5RGNKUSthOWwxOWVQbFNEYzU0Yi82eHpPbzZXQU45Y3pL?=
 =?utf-8?B?dTBmRGM5aVdrcHo0TmlKWFViQWZNZXFpaFZPOW02bWtqWlNuSXY3elp4RTJQ?=
 =?utf-8?B?QTlDL1QxdnFJMitwSHVadmg3ZmVUcVhVRUFDSGJ1K09WczFwd3ZpdTR5K3Yv?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oDPnu0Gvk+7633RHjt+64X4DxbIHiHS3qFYVGxQ0iyhkr+VP43zBGEChxe9APPoIABkTT6JzkUU6bAHl3bshi4J9LIwgRigDeQWZSia+FcW6ZIb0tX1sfBoODCxDAJ2XwM11brUUwlaef1OiSlR57MxfWMAQlPc+EVVElXy2v+CwmtDt+JTxMDuVkBfZmNeYz9kA5hh0Jx8F4b/pbhD8PcwGxGywRlRCAmuOaT3DDbZ59o1pJMDo9SiNjonYXMiJ9W2p+nNMLL8dnOwnfK2pD/5cxbtx/+YFnAvuo4oVUhHeIHJeBmyGafXVnf40CAFuyoD2A0aQ5ARUVVA8FdWZJriEPy9lpbbtYwl7KmNK7BbGIQ2M/2Ij1z7gbE/5dNi3rk1sZ/xCFCRIx5XATMeEW+O659/4Kzdt1Yv5QCXVcBRBQyYlwaVovaP2Cjpt1lketygWQM2ki4MSKlfCWayDHet5dS15Z28z9qkl+VkYPr0eBm2pQdwnlKxqcRl63D7iAdU35LDeXZYzcsmMGzLOQT4lQlDBL8+yGTtdAlqpO3t/Uu8od4aP6rr+yjQ8HYgWUqKV5+kNfIGv3aJzWSmE05E+udk1coYoagXk5+n1CwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1577fe-41a1-456e-9380-08de294af071
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 22:11:37.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rI54yy43nsD9F1gnn1i5Rsl0u6aireS6O8qD27LGLdJ/MmTHR5Z8wisC1dxfzV89Awmc9GzjHp04e0vhQQwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_06,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210170
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=6920e39e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=K6DjihvPzinK78YEPrMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: 05wXKVX5NPWo0sTfQZRs4BB3i5JQuD1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+rMg1h1McQaW
 +Oj3ZX3195cbUoky/hOcavYU18X30AZ9dCj0MLKX6PVMclpGc56rAxz/eHy2Ii+K+PqecjgP7rZ
 P9qAay+o0zXqn9N//j+YCYZ2C8/F1BlACeOqZ0emgj0I4vHY8nefaci6JSRmDWZlg8QQW5wcWug
 QQeVnthiHAybHNCbx+wt4tjuvGOllwMPlzwqJC6oHjGWrC7biD4Aa1KcZrR1nE2SovL9AZd6owA
 dSkXbX+5oxytJLnyTVb1bNSiPsCQxJkF0kdK0sE10mNCnXPs9DibOwMomAeKivbGDDoWPBWpNeD
 +edbzgADB2/7o2UdffDHVhwrq5AbZra0S/FSDDtfusmoiv5tss5lBnS3DdRS1mTfd5D2/yA9bIB
 FfgFa1IJB+4kv2uG/MGCyBip1bn60BQJVHcWTlL0ETOz0d6tuYI=
X-Proofpoint-GUID: 05wXKVX5NPWo0sTfQZRs4BB3i5JQuD1T

On 21/11/2025 20:52, Eduard Zingerman wrote:
> On Thu, 2025-11-20 at 22:42 +0000, Alan Maguire wrote:
>> We have seen a number of issues like [1]; failures to deduplicate
>> key kernel data structures like task_struct.  These are often hard
>> to debug from pahole even with verbose output, especially when
>> identity/equivalence checks fail deep in a nested struct comparison.
>>
>> Here we add debug messages of the form
>>
>> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but differs for 23-indexed
>> cand/canon member 'sched_class'/'sched_class': 0
>>
>> These will be emitted during dedup from pahole when --verbose/-V
>> is specified.  This greatly helps identify exactly where dedup
>> failures are experienced.
>>
>> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com/
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> Lgtm, but maybe also add id1/id2, cand_id/canon_id to the print out?
> 
> [...]
> 

I experimented with that originally alright; problem is the ids at the
time the message is generated don't really relate to the final ids in
the (mostly) deduplicated BTF. As a result I figured it was best to
stick with type/member names. Thanks for taking a look!

