Return-Path: <bpf+bounces-52170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DEA3F2EB
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D430421965
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1821207678;
	Fri, 21 Feb 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e2MJMBcF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T21tpZg6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C62AE89;
	Fri, 21 Feb 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137274; cv=fail; b=b7L8dF4ITkj2/bJP+7B2gRFBpiAXIWff2dTgNXKfg49SqFpFLcX/GZ0ASxXGK6ucNnlkxQJn/ftZHjPWP5I9d5nLHaIA27sqzixibAD1H1W5kwFDGE7+cgljxn239vurOcKvtJXrEWTpmo3FSoi1LauDcJ2lLhouCX56hknaUxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137274; c=relaxed/simple;
	bh=/04qq1CjFPw06lerRrOQ34q3DrULKpN/Vpu1axdsJxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfeGGS6WEpGlKzYeZ5y30ZkY/o7Dkw43nb+mn/z6qGsqAIzTx8mHx4jFoFSHcRx22ZSo1BXZ/u4QVBCUAUGNP0S+4uOCoWt/fECWLuorzSdh8rMjguyAXrrB+rngKlztrSZJRjIt0GuvEXoqZwKjJ84whJVegJ6r36JlQQbXQIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e2MJMBcF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T21tpZg6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8gG1N002237;
	Fri, 21 Feb 2025 11:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=G8/LaZGLprmS3iaPq/VJ9rgyAlAMouuowjXDqJHw82U=; b=
	e2MJMBcFqzJPU3qR0fs1Uqomd9uMTKyFyGZBBu3r7N/9gNkqnwmycipABJCeflJw
	sAc4F/6kKH9eabXvX5xwcV7znAJJrVZ0Lsv6YFHfxjvuTOg7JUUn+++lh+qgxjF5
	P1aL1dpNg8sElVEPte2IbJJ+mZe/QDfNZMDXfzVJBnx5nX0/Xb5fLAGsJsTyFnsg
	DukLoiVu3igw8iGBiWrFtTMvOs5ol7CiYcQlhmfL18S+UDoZpfK2GmfHNWs6g2gZ
	z72vJ5vnWQztU7exg70AQtt2XqJGnudKkmbIR3iv+ccBS3oUQMa8GOP1szPeee/f
	d27Un81WdZN3w631T76NyA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yp3sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:27:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LB065T012019;
	Fri, 21 Feb 2025 11:27:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b5e4j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Scl0pEoP/qT11GJAnOS+2iAkfflwwm0gXo+HPQL1WqhbJgcvt5QTwxguyxGlnuGgC0UzFrgU7IpQCC/6j2qsDR/qq1nkW0q9mV+AbzioQMaZCJwTBx1ZC76Th0NApBDOLnuJqB7tdzUZFYo1i1jQa+fAxnsKkZB7a2WIztd2Hsn3LdmPYAzDy6xrJdvmKG+tEPINmIX0+yk14iOfemOgg8Oo4x6Monj2hkgzMD1Ofpg28oFCYtFx4MJTI4FKDJw2rEMpc3zjuNAscp0ta3ok1+lojvtM/DufU33WFoJ1k18lPGm9n5BmTe5mnwSqjJ7t6XC3jBDpYxlhDv5j6UUbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8/LaZGLprmS3iaPq/VJ9rgyAlAMouuowjXDqJHw82U=;
 b=WPQYBDbRTGq1mfnLx5M9nbL2RMlBCTNcpLmHLxOUFN7Tr/OAdTzM8iqvyNMlONirFqgVc9vI2ZCcHIyV2ssEV5dToflvviRWtHa5xrjFbnsLHcSykkt1l0O9Yly6UNqKcuJsYcbf/c0MnikMXDJhQQQV3nrIZEOuRiCGybup2YXvOpB3Jr483PHhcot5xJuOFxigYgeALwzjHT89OIBApDxCON3vFGjVx2M/wxBG2HIj32qeggonZf4TX6uMQui9u3jSjzedUVpegs1utQ7BpoAShtNfv0G4iUlS4cHU3nOiDD1GcXiSCXsQ9Hcn2Ky4yXJyi2tKz+jZHQkMX+EisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8/LaZGLprmS3iaPq/VJ9rgyAlAMouuowjXDqJHw82U=;
 b=T21tpZg6ZPDm3XOnM+jqoYGuQPg7ysODKcvfscgqc79gLa/+fBNNFlrOjrZDtPSia2pnVg9Z7COGN+EWbnLbDwiEQXXuM7yzpNttBeYqBp2i1zw3nZwV/YzS/HWQ6fDT5W5bQfS3QrOI70qncAo9tNAYMD6homRCaRN+pN5IXAU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 11:27:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 11:27:38 +0000
Message-ID: <cfd75328-36f9-4d8e-8cb6-430e3b4ba7a1@oracle.com>
Date: Fri, 21 Feb 2025 11:27:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for bpf_arena
 pointers
To: Ihor Solodrai <ihor.solodrai@linux.dev>, acme@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
        kernel-team@meta.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
 <959439509729b0d29c3ab48997bb8956c329f2e1@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <959439509729b0d29c3ab48997bb8956c329f2e1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0053.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::30) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d4a848-04ae-40b4-2b53-08dd526abebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjR6bzloMks5QmVNSENrZit2eUJicTFQbERBVS9lZGZLeGxHM1lBdEhqRXBv?=
 =?utf-8?B?bDBDRFZNWEZiYnV4a3o0QmMrbUdHcDV6VlNCTzZ4TnVMb1FKeEdjNW5NSE1t?=
 =?utf-8?B?VFRTeUtmWnJ3K0k3bkV4MXJPTjBLUGM2Y1lEV1RTaXAxaUc4MkFzV3RKdEp5?=
 =?utf-8?B?RFQvWmpNQzNsZHdxZE03aDlPaWd3QzlBT1FwVzNWalBXYTV6cENMeHVOSUNF?=
 =?utf-8?B?aTZ2djFLZEJvdFd1V3NXMmZ2TS9yZzdPUk5QMmw1WS9YYmpySWswZGtmUWEv?=
 =?utf-8?B?Q3VyQitFRm9VTnNDQ3d4dkJpK1M0MXQxTjJMcGxwcHVxSXBNbFJVODhmaGdx?=
 =?utf-8?B?QzJTeFlpNUdUQUkwdWZCbzQ3akhJQ251U0dnMkN4UTdicVA2WUFEeEpNclYr?=
 =?utf-8?B?WWlHTWJ5bkNocHF4cVBtQTYrNUtEY1pzNE1NWVFmNkg5TGNGdTNLcjR0dy9Y?=
 =?utf-8?B?MjhKRldKNHZIRHFSTlN0OVRvbEErc3pGek1rNG5FL1g3SURSK2VJY2dZL2NH?=
 =?utf-8?B?NTVUSVU4T0h4NG1LWGlEY2JSZXlFazh3S0hicVpTQi9xdVhWM0JSRGNvVyt5?=
 =?utf-8?B?MEhSVFNucTZpODUyM2RYR2lhRFl3TjZwb3hWbHdUanhPVnV3QmJVUzZBNkkz?=
 =?utf-8?B?ajFKNkZsTjhpam5SMHNieDRwSEpPVGNSbmxuampqc2JVemViaHBvcTZURENY?=
 =?utf-8?B?eitWM1FVT3BJVkZna1ptOHBpVTUrS1pzcjNJbjIwaDcyZmhLNWtNbjJGRWti?=
 =?utf-8?B?SHhDZGZWVWRvTzZ1R2t5dkdxR01jVWZOeUNNeEdEUmZhc0xiYkVUSkR1VXhI?=
 =?utf-8?B?c2VQckhzQitlcjBld0NmekIvK0Z5V1A5N0R1dS92UFU2REtsRnBxRlFrUU0z?=
 =?utf-8?B?NTJlZVYzMlluckNubjVlbXc0ZUxORFQ3TlpPQTF6UE9qTDJta0dLQUt1NkNY?=
 =?utf-8?B?UEY3Ymc3STJzaUNqRkw1anhKL09Zc1l6cmIzL0VOMHg3NWF3VW9sVmlxVTBW?=
 =?utf-8?B?aXZuZHA5Sm1CZG1GRnhEdEt2VTFrZW9yVDk0TkJQdE9aZ0RGeXBDUDZ4cDQ2?=
 =?utf-8?B?Wk5MWXc2eXh6YUwvR2dZc2ljTXIvdTNVREx2dnEzVnBuUXBEM09ic2lMdTN2?=
 =?utf-8?B?bGNwcjhVVWMrSE9ZNVRJOGoyKzhUeFBISlN6RHZwTjZldllSWkNaNmV5VnM3?=
 =?utf-8?B?a28xRGxvMWVyWXJxVzEyT0tvOUpJc1I5NldZRnN4MXZraVNCL01nTGNaTWVr?=
 =?utf-8?B?Sk5BN1BlSnhNQkhHQXlzSHBlRG9IVmY1TEl1MzdDdmd3OW1yM1R0RWdXM0lZ?=
 =?utf-8?B?QUpXRTdhYy9LcHpiS0c2SXM5Ly9qRnJDUVdCeksza0pHSUVhaERxZzhjVEdq?=
 =?utf-8?B?eGEzZ0s5dTJPSWNJckNsTWpCZGdLR005amU4dXNhQjFzekZxRFVOQ1oydlNQ?=
 =?utf-8?B?STFaMlp4Sk5jbVhxdU5IQjNCNkRleCtFY3dVenZYaDluZUhCelpmbkg2UCtn?=
 =?utf-8?B?QlRKSnhXR3VIR3l3aXJOSHFYYzh0TXNJOXBnSkVFZC9NaHFsWmd2ZDBWWDM0?=
 =?utf-8?B?bnRPMEdieXM5Ynk1K0FvTHNPVGhPWkFWTDIyd1lSQ3I2WGUvQ0FEbkVGWDRM?=
 =?utf-8?B?YThEWDNrLzhwTE1aam43UWhLTTh1Z2JxQzV2ZU9aaEt3b203Q01maTF3UTEy?=
 =?utf-8?B?YUZDaWxYUDBEM3hjUXFJWkNxZkQ2b1MrdHZDaGhtNjY2NkRuS2J0ODNKcVNn?=
 =?utf-8?B?bS9SR09KQnNsVkloRG84RGpkbHJtMDJ3clBXbjkvK0d4TG9wcUZrc0wrR1oy?=
 =?utf-8?B?aHVJaTNOamsxU3FCd0pHTEs5ck9jVDlUL2V0Sm1BZUhwbVMrZFB2d0lySERL?=
 =?utf-8?Q?+oq3cEX9nf9DI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUZ1UjdnaEJRT2tqZ2s5OXloNS9mMHZZNGVGZDVnZkoyTmNnMzRzTEFsOHgr?=
 =?utf-8?B?cDBZMkp1R01Qd3htRDBId1o3L01JVkNJa0hLa1FiU3ZQM01NK3FUNm1lRElw?=
 =?utf-8?B?NkFMWHl1aC9HbkdkZ1NmUmlVNzY1MG5PcUw2OFI4cWUwWmYwaGRPMjdvblZz?=
 =?utf-8?B?c0x3dmRpOWVwTmJyMjIrSCtDWW9ZRlVrT2ptOXNQU0dMWnBrTWRSQS9pZ1dR?=
 =?utf-8?B?aWNYVGNsL2p4MGNCZTlQTzNOR3pIL0VCNE50aXlmLzRyMFl1NTA5ZXdWYkJU?=
 =?utf-8?B?eWsxUlNOT2F1SytRTEJYdnFjc1dqdnJPd1ZTajVYYmdnVmJXcGNhKzZtaWwv?=
 =?utf-8?B?emZXSTVwNEdiZ0dpVmtZSENSRHpFMUtUNXpacDhLUitKZWlkblVobzExSmov?=
 =?utf-8?B?ZCt1a1kyTG1ST3QxemRRcWJ1U1dRUHRMd01zUWFXeGRQeE5BaWtuOUc0cU51?=
 =?utf-8?B?aHM0aFlQYWlmdDFoRURFWklRWVF4eXdzclMxbXVtY2NxVENEakFFWWlaRGtJ?=
 =?utf-8?B?NkJXem9IcFZvRjVKbWJPOGptVWhOZVlkY0V1Qk9XSktMeW5iTVN0M1Z0cmhs?=
 =?utf-8?B?UmUwa0VjZXF1b2w2L2h4Q3ptRzNOWno2MjRWSm5zZFBkeEdHSGdkMFJGRjYx?=
 =?utf-8?B?emd4YmpzYjgyWW0wV0tsQzhPeXU2SUtuT3dib1RON0hhZExHZWlSdHNjUXU3?=
 =?utf-8?B?WGNyN0RXSEphMS8rdnAyNWM2L00vR3NYeUFrdDRJSlpESHN1dG9iUkR6bGF1?=
 =?utf-8?B?NjZTZ1VxOGN4M2RodkZVc1R4MHAwVXhsdGVkWk9OZE1SYytvVzA4ZXc1Sk1h?=
 =?utf-8?B?Ti9UY0RjdUdtbHN2anFSazhrLzZWQmxybTFtVTZQZ0dVMmVUanNzQ3ZWSWJk?=
 =?utf-8?B?elh2ZzBtUDlyQmRFdExEbzdaQkd2cWFPMTFkWU5wSFAwZVU4Y3JXNVhWc0NQ?=
 =?utf-8?B?dDhQOWVOOVl6YzFIUG93Wm0rem55aUsrZU1iaVdKY1BnNUpaTmIvSHhUZVN3?=
 =?utf-8?B?eXBQSEJacUxQRGsya1NGYWVQY3BnV1ROajBlS2RJaU01OHczNGZmZTFIQmY1?=
 =?utf-8?B?R3lDTmQ5WTRtSjJpT0JFVytVT1BKM1k1Znd4UDJyUkFEdW9tR0doTlJlMmxl?=
 =?utf-8?B?c25YMXJybHZTMy9OL1BCd1pZVHJBTmcvWkFiZEg5VURwR2srQTBKdFQveUdk?=
 =?utf-8?B?Zk1WeUExQndjdE1GQ01uOGZBR0tnKy93Sm94cm9IYXpXemtydFkvdHg4Y1p1?=
 =?utf-8?B?QXU4bW1TMXl1bTI1YXVqRXBiVWFjREtqWjBxMFc5ZHBMYTMrcDhzNFpuNEYy?=
 =?utf-8?B?a3Y5U2FkeWtUaTBUN01yc2lMMWxQVGQyQ2tyRXRLbDNKL2V4TWpsblBGZHVa?=
 =?utf-8?B?cURZVUQ4T05oZm8wdXczQWpNTTBtOXFsMW9QS2tTcThYdFU0dFNLbThPUFhx?=
 =?utf-8?B?V0VuZUNkWU9hdVhvVWozTkYxdXJiYlRIMXUrN0srUCtPd05QTkhHOHFZTVhQ?=
 =?utf-8?B?RU1BRk01ZTN5czlNTjlNNHdqVm5aYTU1NWlJSWw4Rm9lVVpqc1BJS3Q4ejNM?=
 =?utf-8?B?eHRiZUFiN1kyTUs2Z2VTOEtYNDBDelM2bnVWc1UvbERrUVdxWXVyOUdoSEQ5?=
 =?utf-8?B?TjlnRGMrWHJRVjU1SVF5a2RJQnZBdjQwWDJvVFhTU25rOTRsbWhMZ3pFZVdL?=
 =?utf-8?B?SldYRWhVd0ZxaVMyYjE3d1I5UzBBaFNrUzRxdkduN0hISFN0Sk1PZEhmZFl4?=
 =?utf-8?B?ZzhhcWswRmRub0VnQzBjelFiRWJxQlM4bzRNUERxV0RMbVRSWG1OR2lUcXlJ?=
 =?utf-8?B?cEZ6UlpDMXVOQjNCWDZJNVFKVXVOYVRqTUJCb0JmS2drcnB0RnkrUUhlTER6?=
 =?utf-8?B?S0FKd3RVUy9HUGw1Q3o2Rjh0by9hNmZQYUxpSElnQ3plMDMwN09MMURxVmZ4?=
 =?utf-8?B?dDJ2YzlNdXJrcDRTMk9KL0FhZ0g1Q1dyVUw0S0tYWGcwbS9UU3d3ZzAzcmc3?=
 =?utf-8?B?LzZFNWFZSUFKRmRWK2hEUHBUYi9CRXRqYTlxLzF3Q0dMRXlLUmR1MHdWTU9l?=
 =?utf-8?B?U3ZKSmZoWHVscUY4eUFTVE1rNU1GMDRkNE5CYkRyZE5jL1NuZG52N2Q1TFd0?=
 =?utf-8?B?MnQ4K2V2NW9laGdKdmlRVlhpdTFVd0lpMzNGOGNDMWlRQUVoMWZMV01SUDRx?=
 =?utf-8?B?eEg1U0ZWQXN2YVdqVFZhZlBBWDRYbTNlUEZKTFNGMTlaVGNLZE9uSnI3djFV?=
 =?utf-8?B?ZFA1ZGM0aG1DRVdvV1FVLzRFa21BPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W2YcWImv2Ve5MOcGUfS0VDYp00bQIhqKqk07cYY+ga9Zdt6sSDEuHoLjiPjAdp9yiLQTwinfN6MoxsYRAtgmM+8bzf+epy9/OR1N5Xn90fAALH+rzHc+wIcDq4bxAUsdCd257lC02TikC7jqS3LQ2acJbEtI7z95du52S84JRwflViJKhwkr4XPBpH31zFBDQDNx/SGcrWvUtcr+40Y88kxGc0Hmzrp6VE54KX86s26EvmrjTDt5kAxsCktSn6uFmEXBK+eWl6alPrSU4CKcJa/WrES0ipDVIYxPnnhMwl6VeDPVCc2u6k9INHowj8V3c+RaYP22YJRdd2BuAQtiD8K5N8zXbImeuyYiOtQ7h+M+iVeELmD9tSWpBRL8MF+/8PQWyrr4NABI0VX98uZMsCAYkee9WqKu7uC4Wyflt0LvPzS9gzTrfSxdvrjL8w/7aS4pdEzTXJQ5DMhrutonsrBwDfnoPftdBlU9yhuM0UtVcK907cs7QPXIuufK9FxpAQMTy6Md7LM2Ah0xy2xZk7+T5xSxBfr/OsixPRSerSNrzSKLDeSMcncxgjJnSCqYrB52Z8hvUfkVub5BNwynpmuYslV5BTotXzqLP6eVzng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4a848-04ae-40b4-2b53-08dd526abebd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:27:38.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO6vsCvFNN/xPZ0JFx8vXQAPAxUDVgKVQlRTuPyvnGANoDZH4wesOHlsh37hPhF4J42FO97rg5HKbSjbozkO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=889
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210085
X-Proofpoint-ORIG-GUID: TQSLvU71wC-8B9Nm1h4wT1cdTfkXoalc
X-Proofpoint-GUID: TQSLvU71wC-8B9Nm1h4wT1cdTfkXoalc

On 19/02/2025 21:42, Ihor Solodrai wrote:
> On 2/19/25 1:05 PM, Ihor Solodrai wrote:
>> This patch series implements emitting appropriate BTF type tags for
>> argument and return types of kfuncs marked with KF_ARENA_* flags.
> 
> Alan, Arnaldo,
> 
> I accidentally put "bpf-next" tag in the subject instead of "dwarves".
> Please let me know if I should resend.
>

no need to resend from my side; I'm looking through the series now. Thanks!

>> [...]


