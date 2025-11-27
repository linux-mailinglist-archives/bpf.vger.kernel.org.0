Return-Path: <bpf+bounces-75634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77906C8DBDB
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E98D634DD28
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3359329C55;
	Thu, 27 Nov 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXEGxVoD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hAoG+IkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC8307AC6
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239187; cv=fail; b=otmBYu6vWfNpIRFiDBM2eZ+N7AnsSlyNqZAqmUjXvGOeluddcqNEJsfGZgePHGxHMK/wb7Aeo9pZtXPDq/R56nJcCcOTZg2lYRNYwt5WnvCOUxChdKjPZYbEUR8ZHhpEyG49elsRHev7SH97dE/eRUY9IR1+0cmoO3EAywARFMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239187; c=relaxed/simple;
	bh=4GRZbu41rT7ZTykXdxxj/51WfNFJRYwgiQlXTYgBkWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EjsUUP00wrS38B2bi6EnK1H45jI5RCLFsGHePtOicLhcIU9WvbSl3CPYdXdt3F18LU8YPE7mitMagbs2Up+NJlD3ZdxJqBNnskWDQoNWqvKhoUC+eg3zMOsIXf/h0vY+7ORLL0tPYIBX6qz86+T9KaAoxyYEjNHJTaBpg8FECQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RXEGxVoD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hAoG+IkZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9fSaq298320;
	Thu, 27 Nov 2025 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pXPIUdSML75EC3HYafgMtfp0/18alXwG5a1I1x5LtWw=; b=
	RXEGxVoDprJH+IzIq0t7nnjPX7bScji9N1NSq8WnD9rp8hlvTkbGkMUu0W6joOPA
	RgdhuenoZYhBDLaS1rliQSO6OH4MwaIwVYYY3VweAGBuB5/L1ixjuAczMSFu0KEs
	qdxt3qd8u4tKTlbK5pZQFpYdsBOdXVNYNYqK5a792L8o+LL2U5owQ8VazcimcDlV
	vfo9/bc/tg1WhooX/k0JKT+kyD7QYxPlWGNu/MlJLpU4JWysUx4yuKpgEjf7+C90
	J4FYhn602bU0NjDlxgqxcA10jMO1ZxhIHC7cSAbwDiDRTS1iXoOrEbCWk5IKOW8D
	jMcUX/fopbYOV7cCOFWgSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4apm7vg2d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 10:25:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR8HHTb022502;
	Thu, 27 Nov 2025 10:25:54 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mp6utt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 10:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwAaUJe4zTsYq/bUQdozHbNeb/J4/qUIQyYJK+caVIxYLDcn+nHr8DD3tsGwYVNxmw5SZXyU+pHLAn14xplQ9lZyWdVdnAijIm5DNU0qEaUbjVh4ZxpV8Qym7+BvnvEwFBMP/hBkdcNYPdW/Z0yNM8qlwlTFlBGNYmCvMV/TxUqB7tyFoTJtSStGCq4uAxWC6iCJECcySFfj6epnDEKA4YoWnd3ea8doM9cDSVjBvDQBCPXzcxbX09wTsTRZ1g96l5eauxV6OvukxrUYpGs6hjNNEG0P254hd7RdoYQvM5Lsb7fFFQnFoJD2DXF+dPdEGvLnKv7apT7+q2dFAAkAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXPIUdSML75EC3HYafgMtfp0/18alXwG5a1I1x5LtWw=;
 b=CHTB8etduM2D6TFO+3vEiCqVzmFWn69/lBZbvPBgZivbHXpkLmGYFe1Ga2GWeV78PeJcaW89tLTn7z1+CxUEkOKUamAmRiCJppVkBj9z4tPbNRazvcsoKeXMoC2PBDGuC907TYGkQSd+xDFU5kimQW0admazmAFisli/CeCLnpLCd7ST/KHqaUUee4AbUxDKI6DqsnfAx64DJhhDnEp2lYBWlCULiBKNiueWVZmw6VV0nLy21hAshKHkSZBDx6/kTEbSGh1VoLhOp3igLkT8V+oEv3nJZG99Rou6/M1O8GWzQJsmOL46SoRda0Yk2X2UQ/5dd+QhfHimYcwiEvnxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXPIUdSML75EC3HYafgMtfp0/18alXwG5a1I1x5LtWw=;
 b=hAoG+IkZ5enf/qNLzWkLLC1k8CQ7X6FG8jBbqwb0rgrMVEUC1NIWtL5fRxwshaYGgdG7bjQ3e3bmSFlOmNNSDDVz1oZ7EnDfq2GyUfjtBVcY9kuLIKVgSe95vrnlkxZYX4uudxxQI/oLeaLsEzrKmdeE2BBZsp7PFo0tfQp8tDw=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH2PR10MB4213.namprd10.prod.outlook.com (2603:10b6:610:7f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.14; Thu, 27 Nov 2025 10:25:52 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 10:25:51 +0000
Message-ID: <a4199316-fe85-4145-b69c-f97e881ebbcc@oracle.com>
Date: Thu, 27 Nov 2025 10:25:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: Add debug messaging in dedup
 equivalence/identity matching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20251120224256.51313-1-alan.maguire@oracle.com>
 <CAEf4BzaDx52argxexyaG3AbvsfQzjmftqrT=xWNuRqfvORM9-Q@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaDx52argxexyaG3AbvsfQzjmftqrT=xWNuRqfvORM9-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH2PR10MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9b1e5b-24f5-4175-7380-08de2d9f56f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0VGYzRRd1ZmdmYwSTdnV21UWVV5MWozeWR5T3ZlWDlONlJ0R0ZGMFJTblZ2?=
 =?utf-8?B?YkdQbDlvbFNoK05RWm9EUWJlSFlSaDdpbDV1YXg2YlI2NmI0K21rL0pvbzZu?=
 =?utf-8?B?Z25FTjZGRFd2Z3hIQnRSQVpMckNTOFlwdmJKNHVkRnVTSERQdTlhTGRoaFcy?=
 =?utf-8?B?NGtoemtnWTF0VUFROXdaYS9QVjcxYlJuQSs5Rk10aE0rK2o3MVdObDVNaDNR?=
 =?utf-8?B?bGVHMHNoTHNWVHZiTEQ2WTZvc3R2bk5NOWowYWg2MHF3OWo3bkh1MUUwZ3B6?=
 =?utf-8?B?VkdTMm5ZaEYwUVNySzhYQlhXZDdGRnFEVlVjNU5KV3hRQWxrVFFnWGZkSnc5?=
 =?utf-8?B?WlRySlRwTUhIZVJSU0tUbUdaNFMwajlSdnN2eE1BaVB3bWMycWNucDhsT3F0?=
 =?utf-8?B?REplWHR1cUEwcGdOeWlpOTExZUZZRVhYd1JjWkhEaEt4QzIvVHJzQnZURGcx?=
 =?utf-8?B?ZXp3YUIybExzM01zVCtndTlTSzZTeHJJTDZuVHRYa0hBeVhUT3RxenVnKytT?=
 =?utf-8?B?Q0JXc2V3aG85cDUyTk4xQWpuSnRsdEZ0aGpFQTZEVVBQQXNtMDBRRHRydXRw?=
 =?utf-8?B?Y3FZUnJhZi8vUVU5Zm9PVkhxN1pqWFRsTkxad1VHR3hNNzc0S1FZZDhHSWlr?=
 =?utf-8?B?alBldGRUUnFHWWMvNTVDWnI2YnUxY2dXMzQwb1dPdWJzTWVhQzIvOHlrTkdC?=
 =?utf-8?B?cjJ5Qnd3RS9vNXdBZExrMDdzM3plMU5hQ2tUSjI4aDFOQzZNOWVVZC85dFB0?=
 =?utf-8?B?SGpQRGJQUnRHL3BLSVNiMDFzVjc5T1VkM294OE5UQlRwL3o0R3N4Z3g3ZFEv?=
 =?utf-8?B?TzdsRStuNXM5WFh6Skltd3N3ZnR1NzRUZW5WRGVVeU5hYnZNRzcwb3gxanN0?=
 =?utf-8?B?MVh1bHN5QUlHSjJITDAxeXoyMUF1QjlyRWp3RnJMRDJzVm5QcVcya0NYTFE5?=
 =?utf-8?B?Y1RvWVZIOGs0K1pJNjBkQ0h3UnhBbWpYSUkzZ0QzQy81cldWdlYxbHFIbFZH?=
 =?utf-8?B?R01QZHVlNitiUXJ5bHBhYkg5ajVuVkd5dHRiZW0xMlVpekZSaGZQUzhHbG42?=
 =?utf-8?B?WTkxdUJaakhiTGRoaXI5ZEkvY21neXRHMHVFMmxlQnM1UTVlR1YxWU1XWERK?=
 =?utf-8?B?MlIwMElMWk9oOXV4QkpzajU3b3RPc3NJVGtlZkl0L2lZM2c0cGJyOGJqYWNV?=
 =?utf-8?B?K3AvNkZ4MXBDajFWOVRZQjRNM2laZXNRTG0vOTN0ekpYMEtMRlluZ0tlQzZl?=
 =?utf-8?B?UURndktjb1kvcllZYndVd253TDhjY1d4VEFOaEZZc1U2dkREeE9QZGpCVWcx?=
 =?utf-8?B?eTlyQ0t0T1pRRlYrVDFZT3BvbndySjE2c2pvYUdWRVpoSlh1RW5Nam40RTJt?=
 =?utf-8?B?STgxK2RyODVUQk5yUVVNdG56RklSM3U5MnJTbnBGeVg4T0s4TGd0K2FlczIy?=
 =?utf-8?B?dlRlQjR4V2F2d0JjVjA5MDA4WUZIYUk3RGQ5NkdJd0dZUll6ekI2OVM4MlFB?=
 =?utf-8?B?VjE0Wk0wMzY0Rm1JNk1KZmh3bEpyVjdaclJ3U3dEYS80clc2bFZOSExsQTZZ?=
 =?utf-8?B?YVVjcG9yazNmbUtmcS96MmhpVDlodGVNdU9lUThSemdBeVBUbWVPK09BMmRY?=
 =?utf-8?B?dCtIUzJwYmdrbVBvai9QdUMyYmNQZ0hVcjZONGdLc0RCbThDNlp2UEJTSDJI?=
 =?utf-8?B?bEtCOVJud2VkblRXL2I4SDZCNk94ZlYzQ1lEREJEc1poTzFXSE9idWNDUEdt?=
 =?utf-8?B?VmNYeWlhSUpZK0I2aFJPUk9hZjUvSGtPRjk0L0NEYTdtblV5RzRqWEZNUG4w?=
 =?utf-8?B?Rnl5M21KTURRV0Iza0FWQkRCTzN2TEoyU095S1pWQ2h6ZUJYdkhnSHBCem9k?=
 =?utf-8?B?UkhRNjBPbk5oUWtZZUZNWEtFcXZ4TlZoQ3hvbWpvRkhYLzJ2aEgrQ0hESkRN?=
 =?utf-8?B?RlkvVWZKelZsTnUzSWwzL1Z2aXF2UVEzK1dZcmNQd1R6aEZSbklhc1RxcWpD?=
 =?utf-8?B?WXJrb0kwN3d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXF2SEtHWXZ4UCszOFIxZkpZakp2Rkp4QVZMdXYrYUlEcWR4SkZFMU1ibzhX?=
 =?utf-8?B?Um9uS2YyZjJrRTRGQTVKOW9IbWM0SFVBR21DMWoxZjhzS2cvZjJ4NXMxWU4r?=
 =?utf-8?B?TmVNNVNsVEhTaGJHT3ptalllYzhxbjQ1Yno1eloyT3lrbDFBUzErSlN1U0o3?=
 =?utf-8?B?d0pPMzk1c1pNRUJiT0M5Zm4zWGdxVkFraHV6aHRSRlNwRkFNNk1qOWZOWkJD?=
 =?utf-8?B?YzFMK0NZUHFMOWtySTdXNDhhVnZtRUhtT2piOTlxWDlhMkh6aGtEWTlRUkJj?=
 =?utf-8?B?UTF3ZWh0bUw2UGtxZ2RsT3dDY0hOczFFdFJlbXI2VGFJRGdxdmM0M3o3cW01?=
 =?utf-8?B?Y25GQ0NzZk9GMk52dTBzdkxsYzEvQktYQW16am5tVWo2REZMc2ljZi9zcXNo?=
 =?utf-8?B?QmNKZGphM1pmLzJMbE9UTFJZOVNGVjF0MGM4VjUxTDNxZnIwcXV1WG1XbzVP?=
 =?utf-8?B?cFMxZFpEaVhhRXpCVWFmRkJWNFNzc3VSbEtyR05Ic1Bqa290eFZSWEpPZVFi?=
 =?utf-8?B?am1CZldVU0RKenZmK1k2TG8zQ2VNRkdBL0VJVzVHaTlwa3RDMkZ3azNXcThD?=
 =?utf-8?B?MlZFOXRXMHlEdG1mMDIySDRZVkFudjhPZDhDMUNYUEJaZU52NEYwOWRjYWhQ?=
 =?utf-8?B?bkVodnFiY0w4aFFQSnFKNjlPK0NCUC9QVy9wck1zNkd2UkFPMGdFaDdlVzdR?=
 =?utf-8?B?RWFVWWhBYkhQN0xIWFZOWXNBSWMwUlNCTXkwWHdzeW9BQzdDSmFwNHdubzFQ?=
 =?utf-8?B?OGNqUEpteUlET29qaWRQeE5pUTNTaUdrOFlOQkpIcVRxY0c1ZlVvZmJhcWo4?=
 =?utf-8?B?S3Q5RU5vdU9HUGU2cmZ3emt4UkRiWWhUZEhNcHBVS0d6WnljMDNGNW9RTFBV?=
 =?utf-8?B?cG0zUUZ2ZVg1ODZmdWh2MnY2bDVJc3JCRTFIWGk3cWZPUGZUMHNGdG45U2M4?=
 =?utf-8?B?UEFpY3B4SUFEWnNCRC9GVEExeCsvTFk2YWZzb3ZhYU5VZWlkcWRmaVNBRVI5?=
 =?utf-8?B?LzN3bTVkNWpZNkNKdk03M1NLdDhaT3ZaMmp0Vjd6Rnk4NVdtRWhxbHM3L01U?=
 =?utf-8?B?R1lSalZVQmZxbEVzYUJ5NUIwRUgrNlRwVVM2SXJncUdjcVVRdGV6OTIyaThD?=
 =?utf-8?B?bHczUlFCRVRBd0wyZ1R3eE5OZm5pd1ptdkxURlZTL1kvcE1Vb2lqWWlrYit0?=
 =?utf-8?B?elBsZC9tVEFVb000enN0Z3M2OERJZWI5TjBGYUlFVnZXQ3NqYkRhNktMRU5W?=
 =?utf-8?B?Kzh3UUNHeG8wblNSTTkvVVVaMnBhMjBYVUNUeWFDTHVZZjJHamU0bUdwaHM3?=
 =?utf-8?B?emtCMldBdTFYRW5SU2FuaHRSTHpidkVoc1ZGKzkxVGRxc2dSaWhqVG1JTkZl?=
 =?utf-8?B?em9UaVVyYWpKd2RFcjN1L0R6clBFa1BBRzN6VDNoYVVJbG1IUVBCRkxUakJK?=
 =?utf-8?B?OVNvZmFlMGJMS2hTcTZuSm5XSk1OdnQzU0Z0T0xqRWxHaXVlYU1pQmVramFT?=
 =?utf-8?B?MC9mWWdkY0tGaVdwZm51Vmp1SVpoU1RtUmlpSVRUNzFoYVZtSi9wNGNqT3VO?=
 =?utf-8?B?OTNZU29zZlNvOU9EZWZ3L1dVc1VrTC9ZeGZYZ1JJems1S3k3UThvak1GcVRW?=
 =?utf-8?B?OVRrN2M5enAyanlVenIvcDBQNGplWDV2S0FkdDFJd0QvY1Fwc1h1VmxFVi9q?=
 =?utf-8?B?VUEraC9NR2RMclRXNGNRR0Z6MXlxYTZKQUltVXF2aFNmTG96TDlzMnIrT2ZP?=
 =?utf-8?B?SmpaaXhrTWduQnRtZzM4SGhNdFMrOFdSbDRjcXBVR2s0WnFoOFBuNkEwUHBs?=
 =?utf-8?B?UnArdU9GRUVQQVNqdk1Fck5pQ1MrNDlzNGFVUUVKTTVYME9MalpSTUFGalYr?=
 =?utf-8?B?WHkyNzNUSk9EckxMSEtoTmczTWNFL2JwV2gydTVPMTBUNzIvSHgrUzJsajVD?=
 =?utf-8?B?aDVnTk9FdFJpRU5NbWt2cU1tQWxLZUpFL1ozMVM5M2tjakJkOFBnby8xcDgr?=
 =?utf-8?B?ZlN5Vm1MRjhsd1FZckdEbU1KWmNOSm9TQ1ZEeXBmcWNJNW1oUWNYRlA3eEky?=
 =?utf-8?B?V2JVNCttelZZQ2tRd1JNaHpqNks3c2NGZnllQjl0V1IvOTNlSVo3UW1WK01w?=
 =?utf-8?B?cmt0U0lZVHRZWEpmcUVGWXI3T3lvT2lOTzZ5cXp3T3VDcHhHUklBT2dEejVD?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3dHcOe0h4T/JQ84e2qcsjAZ07pKy3w2xU0LgZPMphfFFgjJJzqYQX7yaGxm3Sc9KT5JJgBUbi1OBCBu8BB4O1MS28ynhRDORocMnbJ8wTK8NVG5JO0vNhwZWbDjsYWH1KgQvGUiK2u13BnVSpMqQK24fphLGIAiZgRnTMU1orAXJajTzxgDfvBKsODJX8YNpnyqmnO3Pj7Dig0tiJW3w3ppqLWvLb/3gRgEdhbAz/7mtKyhNjoc1xTZpSZkVLPVM7oQTDGcQNdnapecXFaNOPLHiPJkAz1yHMW3RESFuak2C5gyeCvjmBpk2dvCXIrRcN/rBSLo/Y1wHX3infzEDobLObMp8z9r+eZwjC23K1L1jml9EC9H2sIDg3gNbuLWP6fMaSxY4j4wEBOyqtTu260N3ig18mjyctF1Jih1oE2xSlDXaePYWzv5zRjULFS6jiNuLrxvdPgL2op/9iBzGmWK7irbUZIQWi6b6LOlbNzbGqJkDBAg2oNcAKlg8HMsFqBNV2XhFwpVLYQS8qoCftb6gsGx0vjXZ6hsGIEr/o8tJ5qIt7nQPhsVZaXpo/V+kltt9XrTAuVYtI7p5ePql1iLJBqiyqRPkqikejK+/g7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9b1e5b-24f5-4175-7380-08de2d9f56f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:25:51.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJampG+aboFK+Rj8b1Dy71fOoi7Qc+K4I5tRgvsgBCIrfloyck7QUgzygzuOPb5GRZCHJ9HxeH/WeacnEcDiww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511270076
X-Proofpoint-ORIG-GUID: F1FR5-LAjygsGHfdRpdyEjxu9XpHYjfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NiBTYWx0ZWRfX1qQVnM7SHbuz
 3OdXjrkGkHsEQ4C7vF7gH04Mpz9oXbdhjWYiSQwzS5cs4Ue+5fQUzjVxq8xQM0AwuSczNU8BQYu
 e0owgAhjYB0pZjC5W0h0ImZlTZcI4fYWND2hfNGcOznvLQLrmBgvK+IK4JCwIaDaAvE8n9s585Z
 IPQXkUH73VJdwubDejFJz3TnW9hpFM3RQZLlYQu5/0Q4WDMWVfr4RStiYTFhuCe2jTMYFLPlncW
 INdTMQ5QJg+AM9CDVhdAKmXbbgySUz5sbcUk1zjjuyc/u9dpii1eQZ/+i0W1b5v8w3A0AnzNYH2
 pmOA+HhT2OE0nznuNqvETb8f/5bJR+lnzuynKu9pbDDyR7A8fOvSAcwZhS8VyRnCWnQ+uvSHCeR
 gaWg+lvIwygvCk5XLl84z+v///xcjw/tAdtWBAKzvjmEvCZQ8p8=
X-Authority-Analysis: v=2.4 cv=A9Rh/qWG c=1 sm=1 tr=0 ts=69282735 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=sRwy5Z_C85H1dg-BWOkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13642
X-Proofpoint-GUID: F1FR5-LAjygsGHfdRpdyEjxu9XpHYjfh

On 25/11/2025 23:00, Andrii Nakryiko wrote:
> On Thu, Nov 20, 2025 at 2:43 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> We have seen a number of issues like [1]; failures to deduplicate
>> key kernel data structures like task_struct.  These are often hard
>> to debug from pahole even with verbose output, especially when
>> identity/equivalence checks fail deep in a nested struct comparison.
>>
>> Here we add debug messages of the form
>>
>> libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0
>>
>> These will be emitted during dedup from pahole when --verbose/-V
>> is specified.  This greatly helps identify exactly where dedup
>> failures are experienced.
>>
>> [1] https://lore.kernel.org/bpf/b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com/
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 36 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 84a4b0abc8be..c220ba1fbcab 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4431,11 +4431,14 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
>>         struct btf_type *t1, *t2;
>>         int k1, k2;
>>  recur:
>> -       if (depth <= 0)
>> -               return false;
>> -
>>         t1 = btf_type_by_id(d->btf, id1);
>>         t2 = btf_type_by_id(d->btf, id2);
>> +       if (depth <= 0) {
>> +               pr_debug("Reached depth limit for identical type comparison for '%s'/'%s'\n",
>> +                        btf__name_by_offset(d->btf, t1->name_off),
>> +                        btf__name_by_offset(d->btf, t2->name_off));
>> +               return false;
>> +       }
>>
>>         k1 = btf_kind(t1);
>>         k2 = btf_kind(t2);
>> @@ -4497,8 +4500,18 @@ static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1, __u32 id2,
>>                 for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
>>                         if (m1->type == m2->type)
>>                                 continue;
>> -                       if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1))
>> +                       if (!btf_dedup_identical_types(d, m1->type, m2->type, depth - 1)) {
>> +                               /* provide debug message for named types. */
>> +                               if (t1->name_off) {
>> +                                       pr_debug("%s '%s' (size %d vlen %d) appears equal but differs for %d-indexed members '%s'/'%s'\n",
> 
> Honestly, reading this message in the commit description above I was a
> bit confused about what it actually means... "appears equal" refers to
> shallow equality check passing, right? Given this is for debugging,
> just use consistent terminology here, maybe? It's for you, me, Eduard,
> Ihor, maybe a few more people, so we don't have to invent UX-friendly
> allegories here :) Just say "are shallow-equal" or something like
> that, maybe? As for "%d-indexed", IMO, "field #%d" would be
> unambiguous.
> 
>  Also, I saw you reply to Eduard, but I still think that if I were to
> debug this I'd like to know original type IDs of structs involved to
> be able to look at raw BTF dump and dive deeper? We have consistent
> "[%u] %s" pattern for referring to BTF types, let's use that here to
> identify two structs/unions involved?
> 

Sure; how about this format:

libbpf: STRUCT 'task_struct' size=2560 vlen=194 cand_id[54222]
canon_id[102820] shallow-equal but not equiv for field#23 'sched_class': 0


> Also, is size/vlen really useful? I bet you'd still be looking at raw
> BTF output to check details about the struct/union, and there the
> size/vlen is readily available. Just curious if it's really that
> useful to have it here.
> 

In the above form we can basically take the

STRUCT 'task_struct' size=2560 vlen=194

and grep for those details. Useful if we have name-conflicted types. In
a dedup failure we could potentially have such ambiguites where CUs have
different views of structs with different fields compiled in, so while I
didn't strictly need it this time I suspect it will be helpful in
clarifying exactly which object we're talking about.



> pw-bot: cr
> 
> 
>> +                                                k1 == BTF_KIND_STRUCT ? "struct" : "union",
>> +                                                btf__name_by_offset(d->btf, t1->name_off),
>> +                                                t1->size, btf_vlen(t1), i,
>> +                                                btf__name_by_offset(d->btf, m1->name_off),
>> +                                                btf__name_by_offset(d->btf, m2->name_off));
> 
> field names will be identical, guaranteed by shallow-equal check, why
> logging twice?

yep, good point, will remove.

> 
>> +                               }
>>                                 return false;
>> +                       }
>>                 }
>>                 return true;
>>         }
>> @@ -4739,8 +4752,21 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>                 canon_m = btf_members(canon_type);
>>                 for (i = 0; i < vlen; i++) {
>>                         eq = btf_dedup_is_equiv(d, cand_m->type, canon_m->type);
>> -                       if (eq <= 0)
>> +                       if (eq <= 0) {
>> +                               /* provide debug message for named types only;
> 
> please use more "canonical" comment style
> 
>> +                                * too many anon struct/unions match.
>> +                                */
>> +                               if (cand_type->name_off) {
>> +                                       pr_debug("%s '%s' (size %d vlen %d) appears equivalent but differs for %d-indexed cand/canon member '%s'/'%s': %d\n",
>> +                                                cand_kind == BTF_KIND_STRUCT ? "struct" : "union",
>> +                                                btf__name_by_offset(d->btf, cand_type->name_off),
>> +                                                vlen, cand_type->size, i,
>> +                                                btf__name_by_offset(d->btf, cand_m->name_off),
>> +                                                btf__name_by_offset(d->btf, canon_m->name_off),
> 
> same question about field names, can they be different here ever?
>

My read of shallow equality means name equivalence is guaranteed; will
remove.

Will send a v2 if the above proposed format looks good. Thanks!

Alan

