Return-Path: <bpf+bounces-50213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74545A23E3B
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 14:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00BF162B27
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542A11C3C00;
	Fri, 31 Jan 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afMC8phQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4a/Npkg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDB1C2DA2;
	Fri, 31 Jan 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329314; cv=fail; b=iSQygqwiGN/ILRDad7ZWhiw9unJ7oTOlN6umLLcOYRnlkoe5pD6eBwWoxJn9QhNSee6B9JhuWvDUpoWJo2uYM+Z7cHTt62T/QH7FQ6upc2A/Z+Xm+2n93wFik7f71c8Cka+vZ5iSgatvxeIajc+a18sKZkvG9bn4lVtx2jZ9xh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329314; c=relaxed/simple;
	bh=WWp4mg5/rAA1QBZZ9Yika0TlLNoC+nFfmHh7wZuCpIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYFIAbqAir/aHs60hTeewSnX//FvdzQ84GYXa8Z30k5K9VzgBZQxWrghX8yoCdItwbbM+WhwDTOM6NiYGiA+kmYMNyzRmTebG1IaR+EhhwTOQ2eil3DO23k4BRUKfYYU4lHW7O2TMxQ/SQKQcOmvnMRZDOs92rDl2zbbQw7E1J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afMC8phQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k4a/Npkg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VCtrYZ003197;
	Fri, 31 Jan 2025 13:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jwceq7K6wihJmfLumXksgiLPJKicTRj090GOcrM8ETA=; b=
	afMC8phQLEoQveFhDDfcguGAh2SiPYqMzoiDqS/eEjMkZYNp8rKayGfL+P+fF6qj
	7rd2xlE8zkyjeRRjxozIzAdhSCp7OTzqB1FVB4hDnWQ4O6UlZRJvLyDwPgCr4Ufz
	N5deyXG28Cu0patZa8fM6VhsH+RkvPCExKGcQHroydK0WW/RfIAkWT/M+/yy4v0f
	DP6lXS2ujUmY57ikkNojG/7SJoat+fUCW5Yu48hE/38i50jmwn01sIzahrFTy61a
	bo5TF1TVisv6CdoCwbBDX19Cfa7yGNtIBjDGnrUl1KqRUPaW3uzhGoL0TlRwnXUe
	woCQp8JOpvHufdNbo+HKQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gw9m85jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 13:14:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50VB3R9Q009045;
	Fri, 31 Jan 2025 13:14:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44gg1gc161-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 13:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC534IbcISpzYCyQCxODuOqGUd9PLRpUDx6KoC6f6qqrRZwkEYRW2J7e2dM0NQFlew4myex4ZQzMh3GyTITh57GqQRxzmYW2Qi2DJioljiID/93umrIs2v8t8gMCtpzK8eFm8xw39qTidqoN+l8qknv3US5Tn4Len0H8avJK5Vy7x13ujWNC7XoY+2WGUQtG0lUcibwxg6FaVxUc+NEkLcT/PnszY88YguUwN+lgyHX1j4sMnsK7K0axLjlThAHDsyKU8QRrlNybJukXMlMwjpl/sucLZG1io9AaTwtCicKEvWy9kARIog3eWTgGVzb054qzRQG9NrcFAIn0cyejkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwceq7K6wihJmfLumXksgiLPJKicTRj090GOcrM8ETA=;
 b=lNiNePfH1bxf036eA2kLPzu8UuXr0Gn8Yd7wS3j2L98Vsh3TFWm2Qad7Zsw5EVSweD+uwGQcR4yfaDoUNWKJSMS5KJqsC5BPQzpDHz8pjEjeYDJi5DjQ47mjpWCxl2t87IT+u+HPiNGk1U2s8Ud8lcozSf7wbf+dE4D90+uWaSqm/4q6GftbfLf0RLsCFPihh5oA4MJ52xihMbNKdhycQxbPIOgzBrrJ4Aob/aOhDgJDZHsO0a8KKuO/XxzZc1BFKfwFvTE/1Ss4HfZLIc2Fkk40AJrE6DjNNyg7D5t32xDKB1cMos6y9XbU/7gAtqaI3BsrnHf7goS2HyHPhiNS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwceq7K6wihJmfLumXksgiLPJKicTRj090GOcrM8ETA=;
 b=k4a/NpkgEoCErZZ5A+rhhn/LKbRIr9pK0VPpXE7GDvvlkcOJagXNFY422lTwaYFOBZjQktnaukzd1ix1ceFd/qOLgZStF+7oK0nOzMhkuM4jdLvK53oiep8Ws16R50QFhwq2L1Jktx6hjorntS1VB7TyjJdKKRdHFCG3MKmEm8s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 31 Jan
 2025 13:14:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8398.021; Fri, 31 Jan 2025
 13:14:53 +0000
Message-ID: <c52fcd63-c85f-41a6-ade4-a42c24c8cef8@oracle.com>
Date: Fri, 31 Jan 2025 13:14:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: fix memory access bugs
To: ihor.solodrai@linux.dev, acme@kernel.org
Cc: eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
References: <20241216183112.206072-1-ihor.solodrai@pm.me>
 <8bb182c6a5f7a7ac3668297bca5a31467fac93de@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <8bb182c6a5f7a7ac3668297bca5a31467fac93de@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::24) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ba7fdc-eaac-4fe5-b398-08dd41f9400e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3RKNC85Z3JHc091UE5Qdk1VcDRNam0wMlM1ZnBSNFZvRDFGL0VDdVl0TjhW?=
 =?utf-8?B?MHY1U1RmVjVDU3BYcGpEOEhLa1JFM3pkWHpqdzdBMW5FRVpOMVZkS3NrZlRs?=
 =?utf-8?B?dVh1dlhISmxZZklKazFxajUyc2dvRFhRWlJUVmpHS2w5UnlKWXFOdjR2RDBN?=
 =?utf-8?B?NDFkSnRrYVlDeVBVaS9KNlFoT3VSVWVzWW1DWTlKMisybHRRMmR1T2tQU1U0?=
 =?utf-8?B?UEJmYXBHSDMxUm1iVXI0anA4MGdObUtqMmdtSXgrSXVNZEw2ODlQV1I4RFJx?=
 =?utf-8?B?VUF2Z0VhOVRBWG1nS0F2b002cUpqV01kam5jcVRxTUxNVlZEZEhOVTVqUzBI?=
 =?utf-8?B?a0QxdFlZOElPeGtUems2TGNhUHJzU2ZYZUNBV1pIUk9yOVdMWDJ2VXRxQUs4?=
 =?utf-8?B?NHN0cTkyVlM2aU1ON2pQSG0vVFN6dUtNUFNiYU53cFJlOXlXaEkySzMzZDQ0?=
 =?utf-8?B?U091VnlXaWJpSUJHMTgyc0VadUMyKzNSUHJHMzA4QzFLdlZRSkYvT0pSN0RT?=
 =?utf-8?B?VFd6ZDNudWE2cm5Lb25tTXc5TmtEL2UzWmR0aUdFZTVzc0ZrMnNPM0pQS3FD?=
 =?utf-8?B?akNZbkRaTjcvaTBpQk1ITyt3UjVnaXljNVhvVHVkZUpWZUg1SjJYWUJObEwv?=
 =?utf-8?B?ZVRoT3ZUVWkwVWRGdVVGUjFpQS9JbXBpRVNmb0poUGc4dE9KUnFjRmRqbjU2?=
 =?utf-8?B?SHpHcTZSQTJ2aEM1N1Q1UzRyZit5WVNxOThBUkNLSFg5QnErbU0wWVVuZTdD?=
 =?utf-8?B?UkhQNGxyT1pQeFhPb0xLNzFyT1RBcktMbHllRzNIQWc3SHJneW93WVJSdXp2?=
 =?utf-8?B?bVdhY3VPWkNvTEo3YUlHMDZKL1gxZGJXMzlWSnBqSVhDdXJhazVBRmtXUmFF?=
 =?utf-8?B?dkpsVjVwajBFRzZtUk1tTHhjT0lDeHZoWFJybFVvMjU4eHE2WkZpb25ZSW02?=
 =?utf-8?B?bUZ0bVlqMDBRK0MwUlA4b3Q2ME1XOHVrZWN3NU5XeTl4aVBNZFh0ZWJySzFq?=
 =?utf-8?B?dFdrb3hhWFNIV0RDd2RlV01YQk1vVWMrM2dUQ3VhWWVUSk8rQWRFbjJibGFy?=
 =?utf-8?B?YW0wWDFwQld0S2xVZmFtSDZmYmMvY0RjTERiOXFEcmVqZUVaTy9lcHBXK2tO?=
 =?utf-8?B?Sk5mUXRxNktsVTlVY3VDNlBDZFB0V1A4a1I0Lzd5MVpaZFFaNG1DZ2NnVlAw?=
 =?utf-8?B?SmZNK0x2U1lybWhKeEVkN0M2OG9VaTZ1Rzg4TTJ2ZnVhOWhsMjdzdUZqdUFZ?=
 =?utf-8?B?UjFreHZRSVdZUlRjdlRhS21hdzR4Q05pRU11cEltQUlBRjFXeG1kQjFqM2JH?=
 =?utf-8?B?MFJFR0E0Ujl1T2ZxK21pVnUwUzR4d21GMS9HY3luQTY4YUc5ckY5TExrWnBq?=
 =?utf-8?B?TU1GMHF1a2RkTFpkMnI3T1Q2RzlxNkllL2ZhNDJ0MTRCeUdmZG54WWV2Sk9m?=
 =?utf-8?B?aTB2cWhkUFZlTjJoNDRoWW5Ca3FoRjZIVUx1eHhiUWkrM1ZJWHNOamZoT1VT?=
 =?utf-8?B?UlRLYjBDQXNiZHhmWTU5eFBVMnRjOHFieTJqVUo0RXA1OEVucjQwdHdlVEp6?=
 =?utf-8?B?QlVUT0kvczFXYTN3ZDBiTVVmZ09HaC9zaGUyTUdpUGlaM1VzdzBIWTRxeXRN?=
 =?utf-8?B?TnVKcllxeExSbGV3aklCNlRiTC9WSEk2T1VrK2lwUzhlVkpVa2F0VzdvSFFY?=
 =?utf-8?B?MDlNcEExdXRDL2JNRXdHeHlVRXNKZDZ5cE54WlAyU25kQnh3My9ZZGg4RUtE?=
 =?utf-8?B?bm9MWVJzcVBIKzFIYzBBSC9wUCs1MzVqODg5Y3RvUUFJc1lvNUxNRGJ5aFNE?=
 =?utf-8?B?d3R0QkVwSWZRT3U3WER2SnVwUWhqaksxaEg3SU81eXBqTDhCNGhINVdQUW5w?=
 =?utf-8?Q?kQ5we6vP/k3qd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1DQWJlWkJpVVNvajRPbFI0WHNmN2llNzhSdzlBRHVvazVybHpWcGZBVGxp?=
 =?utf-8?B?KzU5Z0l5SGRCY04vSHQyNDZ3ckdMV3ZyN3BjaXc2MldmZTVac3Fid1g2c29F?=
 =?utf-8?B?T3UzV0hOMVhWSUtuUnY4eFNZREM5TW45MmNpYTBIZ1Q4ZzlhTWFHaWFjVW9X?=
 =?utf-8?B?K2hpZ2RzVHA0ZlRiT0ZmUDdnNVlHdzZ6cUZQNmtUSWhqQ3NKK1FSYndjdXVV?=
 =?utf-8?B?eWJLSkE5clR5K2FLVi9nd1UzQ1hxbEtvdzMza0JtTDdMdG5kVlZxVmtCdGRE?=
 =?utf-8?B?QXBTNWRwOGw5RzdwbUxzT3RmTzExV2ovSWxmZ1JKZEdBWnM5QnQ4QmhSSkdG?=
 =?utf-8?B?RVpvTXpTYlUrOURwamZGY3MrK0RmQnkwT3hkVWN2VVNnMVEzNEtFcGdKRFJm?=
 =?utf-8?B?VGVhZ0FjQUxSb2pqaEVZcnZZclp5dDM5dUt3UTRhZXBUcnhTOGkvMFdrRThB?=
 =?utf-8?B?ODNHL2NFam9PVmpKUGxkYVlDMVRMNzVkUnNJdzhmdzdyc1Uyc0JLbGxwazVo?=
 =?utf-8?B?eTRaOUErZHh1eW1tSUtaZUlvWTBuRjFxYWYzUW5lOXJxN1kwMStxa0piWUZl?=
 =?utf-8?B?SndKRE4zOWNvZFNkSWxnWS8wT1BlU1k4OFBDNUZ2NVphaE9XbGZWOGk0cU5T?=
 =?utf-8?B?alpBRXNxa1IxVjJOdDdHYkxyWmZCbElxZGNtaEk2TWI4bkF2ZmZjK2tIVzZN?=
 =?utf-8?B?WTlDWmxRVDB6bllpL2Z3UnVrYnJMQnhkcnJlVlhJK0xjeWNzdVR6RlZNTkZI?=
 =?utf-8?B?RkloSnV6RDlyMVBEeDYyamhFczlBQUZYOTFTVVlTNElxM3dlY2tSTzhGMHBM?=
 =?utf-8?B?bmpZQXJKUVRqWDlTWHRVZHBFRUxydkE0LzBHZi9WbnpFRUFoQ2s3ZjBtY3gv?=
 =?utf-8?B?bnUvZU4rTWJiWGRwQjlpS1VUMjU0YW40S29Jd3ZReThEVmdyWFVNR0x5K1Bm?=
 =?utf-8?B?Qnozdk5DajJMNkYrdHhZQkhDakNtNDN0YmRmTkZNajJWYW9QM2cyMnZtcW5k?=
 =?utf-8?B?N0RjMWpiTXI3UmczK3p1SFBEVUV2Ylg1VjkrREhMY1JCUGRBbmlNdHc3bE9F?=
 =?utf-8?B?NWpHcUFISFFnSm9waDJLUXovYkpNeFVieUpTS21hUDJSakVWSEZqWUdvSy9Q?=
 =?utf-8?B?RkdiRUtrUExQOFFuTm1jK0o4c1pvZVNya1U2RXlwYU1SVjViV0QzanJIL0tl?=
 =?utf-8?B?ek1TeEo2T2YrSjR2YVg3NGZFZnpEaEF5eVNyUHlRa2UrZS9MQllXcDk2K3JG?=
 =?utf-8?B?bGJoUXB2aG9RRXA4ZTk0b1l3bU1VeVlrcC95OFZ2alZlb3pVWEQzUzR6aklt?=
 =?utf-8?B?b1REaENyUW1KMkYvUDEzUU5HSXRFdkpQTjhtU2lHL3JVS0dXYktzNVFKYlg1?=
 =?utf-8?B?L25PS2JzaERkTWxPSXg0d1pxb2h5TEhKT05oM0JBeFZac2ErNXZQNFhDeVd0?=
 =?utf-8?B?TVlNNmt4ZjBJR3hNZCtGM0xjNFUwN1NLMFExbjF4MjdzekJZOG9kb3VFYmZY?=
 =?utf-8?B?ZC9ZdHd4cXMvbW82N0h1QVozVUZTc2JCMzhSaW1MWFUwMmFxcWtRVHZnOGZZ?=
 =?utf-8?B?UTJTQnZZOCt1eGNyYkIyZENtRmxrUDVsTEpEMDNoajhQTDloZE9LeFZUa1RX?=
 =?utf-8?B?R2hMZ25nQ29YaWJjSGFpM1NyR2pJYldLbCtWeDYycU9KYW5MaGg2WE1DNExn?=
 =?utf-8?B?NUNTYUZkMHlnT21GamhHNUlWOGZwY1dFSkxmYjcrMmp4QUo4YWpXWkt6UFNm?=
 =?utf-8?B?Q1lvL2NkN2pmb040OS9ZR0J0QTcwRlFIdlhIUHpNYkJYdmFSUXdkd2owZU1z?=
 =?utf-8?B?OWNDUjAvd2lyZHFXZlI3UzBCUXJoSzJaQmx6b1VacytnVVJKR1g5VWVqOGNG?=
 =?utf-8?B?TW5TRnZ6dDlGVDg0bnpEYzk2Y1hVMVdaNUlkWGpEU1R4Vkd6WDlIVlhnWldx?=
 =?utf-8?B?b1dJUDcyL2hxejJ6QlVWZXI4bS9ieS9aa0R4WXFvNDlka3MySHVIbjduZEpZ?=
 =?utf-8?B?WFN6YkxidytLTjFXaDZ6aWx2T1Z2SW1tcmNCZ3FBV2FjQ2FLbVAxcXhKQXov?=
 =?utf-8?B?THFUZzI5aDdhcTM3SEI5SW14VUQzQkhaQUJPVkVKZzlRdkdZaEZyUDZibjYv?=
 =?utf-8?B?R3ZQQnFhdjEyWDErZ3d0cEtmdUMwakFnOFU0bTlqWkkxbUlsOEt1dG9aZmVK?=
 =?utf-8?Q?YWeln8avgdog6ywf4qfSFxA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mv1Qcm7ylJHbscfVtlShUcAhOTY17e6TGlSH2zTwg/HWVvRDWH169PHN9FqXp5iaDqBQk1AFZuZQDgs0ArvLQpj1tdTzxdqclStPMz82UBuezdY47mDIK/9jImhIL2vNn9yr6ztud+vZc7SOYxM6d03/MJ0mjsKeFXcsTQKnjNhZmwBkBnZjAL/HMuhcfpDFR4iW9e27/cLk2iBHNSu1vHybxVxhDLcusGXmVqSQhZJNbITnXp+jChCbamYSbpZBHLfnUARwzKES8ZP+GBSxAeTJcE33TA5IU4n5a8YFkG3hzdOKOyluksDs5S+Vy0Tqj74UUX1XiUGYZJm1P9dSL0gCl+Z51X3UHuDEK35ivcwUiIhnWzzT3YIc7hXJBbRv/MLDfwh18unbXWUX0s/2kb1VfgT0wttcukP1efVJdg8vdlUtMEv4Neq4CAYl0FL13p/Vg+vE6dN+VomMCcwInthODyAanCpoRjxPBoMkQ/SdoZUNPh0QCFRDVb4u9M5FC9/1yojERgEg6b0xuFs1d17chLxyOnAJb3R2PpXYCpI0acJx1gNXn4M+nly9HIjORE3M+fs8yAF3OCwW2KY20F0tKCWTdrBntndkd7qm4Sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ba7fdc-eaac-4fe5-b398-08dd41f9400e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 13:14:53.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl6/rW57Nv1lV8P10JgirfMQLLhgK2rTZX4/SCPkxi+Nw2KTKlkCM+G1i7PyVWneVdyISpRqwLdXiK9ja6PtFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501310101
X-Proofpoint-ORIG-GUID: kMUKCAVD8jePk6oq6NA79ADtEzv0peRi
X-Proofpoint-GUID: kMUKCAVD8jePk6oq6NA79ADtEzv0peRi

On 28/01/2025 00:03, ihor.solodrai@linux.dev wrote:
> December 16, 2024 at 10:31 AM, "Ihor Solodrai" <ihor.solodrai@pm.me> wrote:
> 
>>
>> When compiled with address sanitizer, a couple of errors were reported
>>
>> on pahole BTF encoding:
>>
>>  * A memory leak of strdup(func->alias), due to unchecked
>>
>>  reassignment.
>>
>>  * A read of uninitialized memory in gobuffer__sort or bsearch in
>>
>>  case btf_funcs gobuffer is empty.
>>
>> Used compiler flags:
>>
>>  -fsanitize=undefined,address
>>
>>  -fsanitize-recover=address
>>
>>  -fno-omit-frame-pointer
>>
>> v1: https://lore.kernel.org/dwarves/20241213233205.633927-1-ihor.solodrai@pm.me/
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>>
>> ---
>>
>>  btf_encoder.c | 11 +++++++++--
>>
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
> 
> Alan, Arnaldo,
> 
> This patch hasn't been applied.
> Just a reminder in case it fell off the radar.
>

Thanks for the reminder; we'll make sure this one gets applied shortly.
I wonder if we should add the -fsanitize flags to CFLAGS for RELEASE mode?


