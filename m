Return-Path: <bpf+bounces-64026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD24B0D77E
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CFE3A24DA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8F23F405;
	Tue, 22 Jul 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IgFOz27I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y7eh2+lj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE8C2F41;
	Tue, 22 Jul 2025 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753181179; cv=fail; b=KDy/vwD08lGd/Ap1j2b8RqbYTlPuHT4oKI03aZ9IIIjHMFXQh4toOFoXbT5qiweVeipIwpgSloLt4m7UrWm7ulBxC4um+oxuwtSB7Ijggpi02Fr6teOVjfN0K6YvCQdcearBDDdtd2sT8oobv8ENtW45W/sIR9PpMmbQJypXGok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753181179; c=relaxed/simple;
	bh=P3mV1XMCPLcfgB9axV9ayOn7WUqFTqRqzxWPhHpy5t4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcAWVQQP9cReFOoJ95ZBAM3Ms3z0sdH3skZkWGp9rEDYB9oPX5ItQTbKz6iCuwTaVXXcg8m72CZWbCmmnQt3eFqGIyIbiHi6+vYibaSMpx+A8OA9a07giswB9EXqytqwLRBScCSsinnq/kYC4NHbPO4TPm8u8C/PP8tbmL/t9Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IgFOz27I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y7eh2+lj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TDDQ011820;
	Tue, 22 Jul 2025 10:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Tvp8WDzBESPhwyedaoJwf6xS8fvYw7v28sm81bSs3mU=; b=
	IgFOz27IhAq5ezgUB9yo6HhDXoKAtT8GjpiPjhzOQLVtJp20oFNzHsLFVqt9qoJW
	7VcuBL26CLYPMO/pmEbCSw8o1vPeudzEb/scSJqvrGW9hFUF1CeH4PsL2qBu6U7M
	eNPLoOEXOyTUzO09bdkPgVEOtz0CTiHMCn6A1Tne8ZLAaO1BLj5JU89ShGLOv2pQ
	CJFww2vWQpcwXsHyARH4lmKUWRRF6L8RKvDdbi4Bx716UFEQZTWuPl/m8ilT4eTM
	A0Tr4ZrE89g02l+cl5f7q/tH/N9htw0GiptQ/c65r7wGsmrkfPGVibBJcY6Jh068
	ETHYLV7S3eXVMS6s3/7FFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ed0cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:46:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAeU9g031311;
	Tue, 22 Jul 2025 10:46:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tff3gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoDcf1fY7YNlPY8bfMU4qQ9XALhE/AYhya2umncK9C3Vmnt939ZDq1e6+sIyxYv4+mmuacDajxe+UNGvBH9s0aNwALOCNZ6VS6vGm0KLzVtn2nbKaZvuP0esP6GhG/VBi/kKlQ6W+htzpI1nIl4JocFmH8bqDohiJHbkHG81wJCAqDwn4kXO0qBjzKl0gKVa3gyJvK1dNwa8SSIJ/uLniIZspnyAK6xgeDEfx/HTCHJ/YHJE7r2PCDWOU9dR+X6ehOcB0HpfKMXncxcu0wtWfAAfrN5nZgSOaSIyMf4sB5vG/7T1ugkDNDFQnmr7ZpqPOQdODAO2UMv1jhKqeWsPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tvp8WDzBESPhwyedaoJwf6xS8fvYw7v28sm81bSs3mU=;
 b=GlyNU3tFmz2tJ0TFUVf9+daAM6Udlpo9cZbDBAtI0QzcEqx/Aoiww4BE3wA0QuxCSHNQf6tyvodgGwmX6id5LPGfR5rQjx1V6onIlab8Gua55kONNN23IgpZvrCcBpiM+44UftLDfXS8035rJKpOJ59PFl98z/XwuKIrFJlW9ynEUqgPn+NbXi0xbWjge+BcX4zrtexltmnuzT45h07kLr3zrbFWJ+j5AhlcUOGlsMcrutBZ24XOAkuFLpPqyI5Ifx0jaw6nw7/Y/bWxNz/VeXkSTWZZ7spWhP8rgbQsM437dEDYdDklAhaYKt4G5pF1uurcheNUu9gKYMbh3Z02QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tvp8WDzBESPhwyedaoJwf6xS8fvYw7v28sm81bSs3mU=;
 b=Y7eh2+lj/AFd9k37I0UZhePT61X53vNY1mdTq01J2kHE0Qk6DLddrqeXml/s0Q8j7AzhD5h/FOn/OOV0BjH08fOZPDQeTK3vyttYyUDZeKbzb8lYN4D3bpgpxy3mpEXZBOqK4Rh8OkzmDpEZa8wxX0DqaPgHhPRZKCBi0kVmLt0=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB6630.namprd10.prod.outlook.com (2603:10b6:303:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 10:46:05 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 10:46:05 +0000
Message-ID: <e88caa24-6bfa-457c-8e88-d00ed775ebd1@oracle.com>
Date: Tue, 22 Jul 2025 11:45:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC dwarves] btf_encoder: Remove duplicates from functions
 entries
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Menglong Dong <menglong8.dong@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <20250717152512.488022-1-jolsa@kernel.org>
 <e4fece83-8267-4929-b1aa-65a9e2882dd8@oracle.com> <aH5OW0rtSuMn1st1@krava>
 <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <6b4fda90fbf8f6aeeb2732bbfb6e81ba5669e2f3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:208:14::15) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 01caa436-4cea-4e27-85fe-08ddc90cf57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2hSaFJ6VTVBWlNmTWxyY2pjNW9WTVZhb1hNWGdHK0ROeG9Sc2Y5bXlMRFNB?=
 =?utf-8?B?S2QrSThscHhKMGlPNHJtU2JKd3JxZDZRMGUreTJXRWt0RkcyZmdvemVCV3BN?=
 =?utf-8?B?ZlNkcEJtMnB5ZkZZaTlQT2w5ams1WS85NjZZbzJ6YUtDTi9CL2xWeVVsZnJF?=
 =?utf-8?B?aWtidGwydEtiNEc2RUk2ZEpXVUJiczUySTIwOTB6RW53akdMdndnVWZmcUF2?=
 =?utf-8?B?cmtVTG5SMHlhZmVMK0RZWEJoVzI0Q084MW5hOE5oWUI4eEVpL3BLV2loUmox?=
 =?utf-8?B?SWIvSWd3aC9scWVCOThhN0I1RnpZQm1JdFZHUTBJbHYrMDdvZk54cDFrM2sw?=
 =?utf-8?B?dW9vYXFYRGxZSW56ZFljL1pPaGxWQkJDQ21UTUtjcEZkZW1qd0JxTis4QWU5?=
 =?utf-8?B?L0JKYkE2RmZFOS9wWEEyUmpOQ0p3d0xId1ZTYWo5enRBVWEvWUVvM0xBWnRi?=
 =?utf-8?B?d21tQVhreitscWV3Zy9hZGZSeFBZTzFhSlhkZFRBeGRkU0Q4WHNUWDZ0dnNm?=
 =?utf-8?B?dmI0eS9VMmppSjZHSTg1VXB3MWFJMzhyUlVMWkhnZUxpQ1kwdnNtc3lkL1Vo?=
 =?utf-8?B?Y2Y1SEt5WjJRNUZyRXBsZkQ1dkVXTEszMXM1bzRmcCtqVWhXVEJ0RmVwREN0?=
 =?utf-8?B?NUlkWVBzclpidm5vNUxBQVk1dlRUc29HQjEwNGdma2JKSnc3bHM4b3dCTnQ5?=
 =?utf-8?B?VXNQblpRelJaZ29Bb0VZZkMvTUt3dVBweTF3YTQwcmVhSGdXeGVzZWV2cm5i?=
 =?utf-8?B?UnMrNHpRMkw4bXBLVXlKSDBZd0pYTFVkSitsYzBZUlhyZFp1emx3K2VLbHI5?=
 =?utf-8?B?dFBwcithM3NiWUwrQUdocnVYd3J0dUN1YTRCeEYyeXRVdC91VlNib3FIVzdk?=
 =?utf-8?B?dzAvRmc1dXpCcHRSL0huSVdmcmFIbmw0NW9iRkhaOFB4NDdIaDdzOS9XR0RP?=
 =?utf-8?B?OERWb01rWHNEb3pCaWM0SVRRK2daRFNUd3lFRE13N2ZlTWRpR2lMN3ZZT1By?=
 =?utf-8?B?d0RRVVcwMjRUb1dJOE9iZXRuU1d1a3c0M0VkVkxTcGo3elMxL1lwSFBhMWtZ?=
 =?utf-8?B?Vmg3azVHT2M3VzFVenNBS1FsMFBORGQzOTZzRmoyVFZZdEpvZFYzbmdzMFN0?=
 =?utf-8?B?ajZPRWpScDJkTFZXNEM2WnFENUJxOWpzK2FyemRBcGR1WjBRRmJmTkk4b0FF?=
 =?utf-8?B?RFNpRVNxSWZRQjU0QU8zb2xnZEU0WWZNUzRXbll4eExBZEdjYklSM2N5Yy9r?=
 =?utf-8?B?QzJUVE5xbnNPaitJNnp2L05ySkNOMDN5dEZoSHFtVHRBdjFrYzRRRW9ZTXZZ?=
 =?utf-8?B?dnJBcDc3UU9sOVdwSlhlRkEzYmp3dStlTGhXVS9FNTZjMjJpOGtKd3htMThM?=
 =?utf-8?B?YnNaamJYZG0zMnJFbHg2L1YyK2szdnI4dUJneDFCZWU1cFRXV3dsM0ZQZmNN?=
 =?utf-8?B?Uzh6aUpsd0ZvdGxiWDIvQURBNE4wRjlNU29uYi82QXJnNllxRUNtUE40bjFt?=
 =?utf-8?B?VUhDRFJFK1RuajM2VGhBeGRzeS9nUW9iYkJXMFBReEsrb09Rd1ZYT1dpbjRD?=
 =?utf-8?B?SWhYaEM4V3MxM3hyL1hSMW9vRTlpQk0vaUtSNlo2dXduREkzdnEzdzFiUzB2?=
 =?utf-8?B?V2lTaFZLbm1xWHlkdkx1ZnNVN29GNit1ak4zRWFrZzB3M05oMjY1RUh0Y2Jy?=
 =?utf-8?B?NklFOGphS043ckFmTjg1cW1iWEswL1I0dVVUT3EvYXlMelV3VFRGeXZrYzlS?=
 =?utf-8?B?WDRMaE5Sc2tkMFp3N0ZzTThBYjJRSnJUaGU5SnJFbGFPYW1UcjVtcGw1dVpj?=
 =?utf-8?B?YnFMTE1saHdpNUxxTDBVZmVUUGZ4NFBHQ1VTQzhwN2lOTk9ZNHZBbFdlaWlR?=
 =?utf-8?Q?lZSRU70pMzwBk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVYM0tDYllHcXIxSkIwZURjNGZrVW9CT3QzUThZOGVMMzg5Ym50a3E0NEI2?=
 =?utf-8?B?cXVuRk1EUVU1MlptZ3kwaDBOVmJUQzIvVlphbmRBMmtPR3dhZHFFK2g0c0Vt?=
 =?utf-8?B?ZFRNZE5LajhjRmswL2ltTWJzaXAzUWsrckZySUd1TkVSV3FIRVZteFIwV3VT?=
 =?utf-8?B?V1FxRCtTYzUzTjd3SHpjYjB5c1dHenJGSzJQRCs2VEtKY3dXOWxwUlY1ZGEv?=
 =?utf-8?B?OEw5QitEQUhnejI0K0dDcXBoMDVlSXphNWVNSllieEVNNzZ0TVpXUlBLR25W?=
 =?utf-8?B?TmdZSXZRVTJ0S3ErelhpdjlmMDdTVFZENTBadDhFeklIR3RBb254dUJRaDNQ?=
 =?utf-8?B?KytGNXZGOGMzSkVhSm9CdWcrY1loOE9NV0d6Y0lLa0pLMDZ4OXh2Y3NFMjZQ?=
 =?utf-8?B?TjFGdHJsaFBZTHl0Z2kyUUlUenUwYnlqK0orNlZiRkdBa3E4OEVvN0NZN3R0?=
 =?utf-8?B?SjNIWWFoMVdCbDJXaHpjTWMyak96NjFuK1k2elpUQ0c1amZjSVRDK0NPTlNS?=
 =?utf-8?B?UjBhaDNxODk3SzFuSlhUWGFiK2JldjZ2K1VvRnJXTUJTK0pYTmFNdHEyekdj?=
 =?utf-8?B?Z2RDallaWnExeE5ITlJmL3kzUXJnNDhsams4dHpoYllTV2hjdHk5SHpZLy94?=
 =?utf-8?B?OEllT0JpOXNVSkRLR1JXSk8weFF3dkd0TWQ4eDFlOENHUWdQL2VBTW9DaHVx?=
 =?utf-8?B?TFFMdThDcG1CdXdhR1JpSVVDTmwzQUNnSkdjK29nQUgydlZHRjJaSHVQREE0?=
 =?utf-8?B?NFhHZ3RpbC9KcCswcklTeFMvOVNCb2VmTkFmWGdmR05NYXVTdEFTK2g4Mkhr?=
 =?utf-8?B?dy9QSlZRQjNVRWVXd3M5Qkxmd3NSYnN2eTZTUkVPUG0rMk1vRGRQN01lTENJ?=
 =?utf-8?B?QXJKUnorNHlqUkNMM0pVWWxEajJEYmgySWErbG96cEMrU2c4dlJJZHZhOWk1?=
 =?utf-8?B?RFc4SjB0b0ltL1p4eXB0QkZqWG82UjBsMUxQT0VWdjlyYy9VUm92R0x2ZDRB?=
 =?utf-8?B?SHFsNHRsV3RZMWpkQ3FUeTBRajJyME1vOS9RTm5JeEpPTC9zTHF4YXJ1MkVH?=
 =?utf-8?B?WjdXMXVnd0RPVmx1eHdFVld2ME13VFo0cWo0NnlsbEdwd0s1a1QxcjAvdUVk?=
 =?utf-8?B?L1lEMmxPM1pSWlkzckwvODl1MjIzbGdvb0JhQjJ2OTdrclZCNXRFRlVacmpX?=
 =?utf-8?B?UzBTc05BcFBXa0swN1RQZllMd3lwVkJZbFYxd01QMjE4OC8wUWNHcmlEam5D?=
 =?utf-8?B?THBJSnFXakc4V0pyRE81RUsydFZEWXpIV1h3VnBYVy8wWnJzc3c4TGZYanlp?=
 =?utf-8?B?eEFhNDZVWStud2NOYU13NVBVQ3VYVWxmL05RMVEyV1ZxaTZVV010am82c0ZF?=
 =?utf-8?B?SVlGWnJRRFkrY2JmZzVFSHhLWEVBSkg2RnNNWGhXNkFjQ1pyTTl4eFFmNXEz?=
 =?utf-8?B?WUNoYWM3WkVzdGdhOHh5cDlsMDQrSTlYYW5TMVVnakp5bGVlYmNmTVM5ZGpX?=
 =?utf-8?B?Sk90eVU5ZGNTek9acEtqSnZvZ1NhcEVGVHNVcEt3WEV0TTFTYnZYVkw1SXJh?=
 =?utf-8?B?L29tRm1RbGc5L0dlbFdsZkdiU0h0MnhWTjNwVjhhSmNBbXVlcytrZW1rcGV3?=
 =?utf-8?B?bHFOajcrM2o0NzRzTks3RFpmak54clp1bEplZW9zUUtoSXd2STJPMVUwZ2hC?=
 =?utf-8?B?di9kWk45cy81S1A0M2RrRER2UVAxUDJJQUoyOG9sMUNIZDhoeEdYT0ltOEsy?=
 =?utf-8?B?ZDEwK3ZXRnRPd1JxZVBZUGNCRzRuRG5DU1NRQXN1cUt4VE5zaW4vMnJKOXY0?=
 =?utf-8?B?S3RqMnhjWlVNTTJjNERLUmhkRWtuWnRDNC9MQTlQcnM2YjdSZnhmd1dJS1BL?=
 =?utf-8?B?WXJQdW5lVDNTNmZaQ2FjZ2FDTXRrNHJoTC8wNHRzc1pkU2JrVFEySUNVUGU4?=
 =?utf-8?B?L0I4b2NrTTBWa1ZYeGpLRXlWWjVpZjB2cHNMUDl0MEFzWjdzRVNwMWl2azNk?=
 =?utf-8?B?dW5vOElFS0RjOExCMUZqek5aSHc4RWN6cERVZ0hJSEFmNTVJVVA2NmxOWWtG?=
 =?utf-8?B?em1zVW5SdVdsaGRuZWwwS05Mc014aExhdDlTaitYMmQ5UDhtekJIWXZMMjRU?=
 =?utf-8?B?WnpBVDZVRFV2V3BLOTMyQUZIZkFUQjZkKzFIUkV1VVhwOVU3VENlTVBhZnNh?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8v2f3O9gxFRX97DAymTHPdbZYQIG28xfHp/O/7zqMwhp1CzTCMX6N0RWcO3vOpiSvvHrCLoiiiWx5aRgXw7QXHa2a2l+wWSnlzXY0HuBGIG6uvMdMkvl/GmCOpbT1LX9uwTaj5yFhk+PokwaYk+Y7cF+H4T3pWY09TIJrg6QUheUtAl6j2s3p2kHeGAunokoDgrhLVhmRUS8/aklZv6O/7w5gBQKEnMrSXNsjpxNx1m+ZO5TdafAAcvOrOZVp3R9TUlhvs5O5I6xO5oekRPcDwANtksOL5rqSnM4FT/tVpVFC6a50RBFhDlZe3ANIwWW3cOuzctw7NdgFLL0Uh8VHhZAAQPcsBmjgRlI/U6y2i8gKl4AeT8vjapfcWb5phgEr9+nQ3xmd386fzNCMkGVyhPhZt8+0fjeB7cT60yvZK2tNto7WEErnv7d8lOMB2k6Lqjs6Q7nNPd7fRoPNwOdwGMvfCtklrt4q80YamUoeSloo65Ab5cTqrEWmzG3rRDOursRPTD6PaEAuiplkAI24dECVthex3nGwwYuGHwx30oiN6pEzSLFGSn3F8JS0asID7+C7BjpQftXceP93AJDPWsfVIUvmcW/jFv7PKXhJ3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01caa436-4cea-4e27-85fe-08ddc90cf57d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:46:05.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMKcclrsUpSgBYpAFkMer8xnDBB2Mszc1G3rFOgfqoOGaJsHM7BlRQkDrmBZrZUpiFbi1J1Sa2sAPqQUge4JZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220089
X-Proofpoint-ORIG-GUID: 3bwCYP4cCYxcIS0f1AZKsfKSEB1Zx6Gn
X-Proofpoint-GUID: 3bwCYP4cCYxcIS0f1AZKsfKSEB1Zx6Gn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4OSBTYWx0ZWRfX9bA0GRtOCyUg
 KUn4cMI5p4Ziu02NTybn4uG1Osja1tx/xFa0ShEEc5/IZtvi/yekafFk2GlNXNzd18U8ukuOZkh
 g0gdosHCQpU7SOMex98wzfpzBAP4qWyLgxjieM92E7KQqib2b+lTpAZtJDGfofT2gs/po/6eFKt
 OCGq5wiohVot+BPXb7x53usT/EiLlSvvgzgBDeZUGRcBKczB23rrQVc3Iwy3tkUD9X1yhG5eXwZ
 2XJwRVuLhRJmsQTLMkyR9foTdNNdJTZ2YQBLfakbhLkjppTU7C/MVsc5EE1mBJ/IefeCiK9vX+/
 rxo5U7nmOkVKtdDVYhkNwZQYOxyLWkhzpFzKY6JJH7AZxakJVGGS7coTa7VWsEwfZ8OxqwNFM8M
 zPu8rblGQzfQICom9Tlipy2gt7uru1/dmYD0V4szMML0lk91kPsqHB/yPiFQNkqK8VzACLte
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=687f6bf2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8
 a=GwkmjjOTfTRTqUhc0gwA:9 a=QEXdDO2ut3YA:10 a=UYjydHh6ynBBc6_pBLvz:22
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:13600

On 22/07/2025 00:27, Ihor Solodrai wrote:
> On 7/21/25 7:27 AM, Jiri Olsa wrote:
>> On Mon, Jul 21, 2025 at 12:41:00PM +0100, Alan Maguire wrote:
>>> On 17/07/2025 16:25, Jiri Olsa wrote:
>>>> Menglong reported issue where we can have function in BTF which has
>>>> multiple addresses in kallsysm [1].
>>>>
>>>> Rather than filtering this in runtime, let's teach pahole to remove
>>>> such functions.
>>>>
>>>> Removing duplicate records from functions entries that have more
>>>> at least one different address. This way btf_encoder__find_function
>>>> won't find such functions and they won't be added in BTF.
>>>>
>>>> In my setup it removed 428 functions out of 77141.
>>>>
>>>
>>> Is such removal necessary? If the presence of an mcount annotation is
>>> the requirement, couldn't we just utilize
>>>
>>> /sys/kernel/tracing/available_filter_functions_addrs
>>>
>>> to map name to address safely? It identifies mcount-containing functions
>>> and some of these appear to be duplicates, for example there I see
>>>
>>> ffffffff8376e8b4 acpi_attr_is_visible
>>> ffffffff8379b7d4 acpi_attr_is_visible
>>
>> for that we'd need new interface for loading fentry/fexit.. programs, right?
>>
>> the current interface to get fentry/fexit.. attach address is:
>>    - user specifies function name, that translates to btf_id
>>    - in kernel that btf id translates back to function name
>>    - kernel uses kallsyms_lookup_name or find_kallsyms_symbol_value
>>      to get the address
>>
>> so we don't really know which address user wanted in the first place
> 
> Hi Jiri, Alan.
> 
> I stumbled on a bug today which seems to be relevant to this
> discussion.
> 
> I tried building the kernel with KASAN and UBSAN, and that resulted in
> some kfuncs disappearing from vmlinux.h, triggering selftests/bpf
> compilation errors, for example:
> 
>       CLNG-BPF [test_progs-no_alu32] cgroup_read_xattr.bpf.o
>     progs/cgroup_read_xattr.c:127:13: error: call to undeclared function 'bpf_cgroup_ancestor'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       127 |         ancestor = bpf_cgroup_ancestor(cgrp, 1);
>           |                    ^
> 
> Here is a piece of vmlinux.h diff between CONFIG_UBSAN=y/n:
> 
>     --- ./tools/testing/selftests/bpf/tools/include/vmlinux.h	2025-07-21 17:35:14.415733105 +0000
>     +++ ubsan_vmlinux.h	2025-07-21 17:33:10.455312623 +0000
>     @@ -117203,7 +117292,6 @@
>      extern int bpf_arena_reserve_pages(void *p__map, void __attribute__((address_space(1))) *ptr__ign, u32 page_cnt) __weak __ksym;
>      extern __bpf_fastcall void *bpf_cast_to_kern_ctx(void *obj) __weak __ksym;
>      extern struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp) __weak __ksym;
>     -extern struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __weak __ksym;
>      extern struct cgroup *bpf_cgroup_from_id(u64 cgid) __weak __ksym;
>      extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>      extern void bpf_cgroup_release(struct cgroup *cgrp) __weak __ksym;
>     @@ -117260,7 +117348,6 @@
>      extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *p) __weak __ksym;
>      extern int bpf_dynptr_memset(struct bpf_dynptr *p, u32 offset, u32 size, u8 val) __weak __ksym;
>      extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __weak __ksym;
>     -extern void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>      extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset, void *buffer__opt, u32 buffer__szk) __weak __ksym;
>      extern int bpf_fentry_test1(int a) __weak __ksym;
>      extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str, struct bpf_dynptr *value_p) __weak __ksym;
>     @@ -117287,7 +117374,6 @@
>      extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
>      extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
>      extern void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __weak __ksym;
>     -extern int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __weak __ksym;
>      extern struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __weak __ksym;
>      extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
>      extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task__nullable, unsigned int flags) __weak __ksym;
>     @@ -117373,11 +117459,8 @@
>      extern int bpf_strspn(const char *s__ign, const char *accept__ign) __weak __ksym;
>      extern int bpf_strstr(const char *s1__ign, const char *s2__ign) __weak __ksym;
>      extern struct task_struct *bpf_task_acquire(struct task_struct *p) __weak __ksym;
>     -extern struct task_struct *bpf_task_from_pid(s32 pid) __weak __ksym;
>     -extern struct task_struct *bpf_task_from_vpid(s32 vpid) __weak __ksym;
>      extern struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id) __weak __ksym;
>      extern void bpf_task_release(struct task_struct *p) __weak __ksym;
>     -extern long int bpf_task_under_cgroup(struct task_struct *task, struct cgroup *ancestor) __weak __ksym;
>      extern void bpf_throw(u64 cookie) __weak __ksym;
>      extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p, struct bpf_dynptr *sig_p, struct bpf_key *trusted_keyring) __weak __ksym;
>      extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
>     @@ -117412,15 +117495,10 @@
>      extern u32 scx_bpf_cpuperf_cur(s32 cpu) __weak __ksym;
>      extern void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __weak __ksym;
>      extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __weak __ksym;
>     -extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
>     -extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
>      extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     -extern void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
>     -extern void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>      extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
>      extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>     -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __weak __ksym;
>      extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
>      extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     @@ -117428,10 +117506,8 @@
>      extern void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
>      extern bool scx_bpf_dsq_move_to_local(u64 dsq_id) __weak __ksym;
>      extern bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
>     -extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __weak __ksym;
>      extern void scx_bpf_dump_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>      extern void scx_bpf_error_bstr(char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>     -extern void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __weak __ksym;
>      extern void scx_bpf_exit_bstr(s64 exit_code, char *fmt, long long unsigned int *data, u32 data__sz) __weak __ksym;
>      extern const struct cpumask *scx_bpf_get_idle_cpumask(void) __weak __ksym;
>      extern const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __weak __ksym;
> 
> Then I checked the difference between BTFs, and found that there is no
> DECL_TAG 'bpf_kfunc' produced for the affected functions:
> 
>     $ diff -u vmlinux.btf.out vmlinux_ubsan.btf.out | grep -C5 cgroup_ancestor
>     +[52749] FUNC 'bpf_cgroup_acquire' type_id=52748 linkage=static
>     +[52750] DECL_TAG 'bpf_kfunc' type_id=52749 component_idx=-1
>     +[52751] FUNC_PROTO '(anon)' ret_type_id=426 vlen=2
>             'cgrp' type_id=426
>             'level' type_id=21
>     -[52681] FUNC 'bpf_cgroup_ancestor' type_id=52680 linkage=static
>     -[52682] DECL_TAG 'bpf_kfunc' type_id=52681 component_idx=-1
>     -[52683] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>     +[52752] FUNC 'bpf_cgroup_ancestor' type_id=52751 linkage=static
>     +[52753] FUNC_PROTO '(anon)' ret_type_id=3987 vlen=2
>             'attach_type' type_id=1767
>             'attach_btf_id' type_id=34
>     -[52684] FUNC 'bpf_cgroup_atype_find' type_id=52683 linkage=static
>     -[52685] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
> 
> Which is clearly wrong and suggests a bug.
> 
> After some debugging, I found that the problem is in
> btf_encoder__find_function(), and more specifically in
> the comparator used for bsearch and qsort.
> 
>    static int functions_cmp(const void *_a, const void *_b)
>    {
>    	const struct elf_function *a = _a;
>    	const struct elf_function *b = _b;
> 
>    	/* if search key allows prefix match, verify target has matching
>    	 * prefix len and prefix matches.
>    	 */
>    	if (a->prefixlen && a->prefixlen == b->prefixlen)
>    		return strncmp(a->name, b->name, b->prefixlen);
>    	return strcmp(a->name, b->name);
>    }
> 
> For this particular vmlinux that I compiled,
> btf_encoder__find_function("bpf_cgroup_ancestor", prefixlen=0) returns
> NULL, even though there is an elf_function struct for
> bpf_cgroup_ancestor in the table.
> 
> The reason for it is that bsearch() happens to hit
> "bpf_cgroup_ancestor.cold" in the table first.
> strcmp("bpf_cgroup_ancestor", "bpf_cgroup_ancestor.cold)") gives a
> negative value, but bpf_cgroup_ancestor entry is stored in the other
> direction in the table.
> 
> This is surprising at the first glance, because we use the same
> functions_cmp both for search and for qsort.
> 
> But as it turns we are actually using two different comparators within
> functions_cmp(): we set key.prefixlen=0 for exact match and when it's
> non-zero we search for prefix match. When sorting the table, there are
> no entries with prefixlen=0, so the order of elements is not exactly
> right for the bsearch().
> 
> That's a nasty bug, but as far as I understand, all this complexity is
> unnecessary in case of '.cold' suffix, because they simply are not
> supposed to be in the elf_functions table: it's usually just a piece
> of a target function.
> 
> There are a couple of ways this particular bug could be fixed
> (filtering out .cold symbols, for example). But I think this bug and
> the problem Jiri is trying to solve stems from the fact that one
> function name, which is an identifier the users care about the most,
> may be associated with many ELF symbols and/or addresses.
> 
> What is clear to me in the context of pahole's BTF encoding is that we
> want elf_functions table to only have a single entry per name (where
> name is an actual name that might be referred to by users, not an ELF
> sym name), and have a deterministic mechanism for selecting one (or
> none) func from many at the time of processing ELF data.
> 
> The current implementation is just buggy in this regard.
> 

There are a few separable issues here I think.

First as you say, certain suffixes should not be eligible as matches at
all - .cold is one, and .part is another (partial inlining). As such
they should be filtered and removed as potential matches.

Second we need to fix the function sort/search logic.

Third we need to decide how to deal with cases where the function does
not correspond to an mcount boundary. It'd be interesting to see if the
filtering helps here, but part of the problem is also that we don't
currently have a mechanism to help guide the match between function name
and function site that is done when the fentry attach is carried out.
Yonghong and I talked about it in [1].

Addresses seem like the natural means to help guide that, so a
DATASEC-like set of addresses would help this matching. I had a WIP
version of this but it wasn't working fully yet. I'll revive it and see
if I can get it out as an RFC. Needs to take into account the work being
done on inlines too [1].

In terms of the tracer's actual intent, multi-site functions are often
"static inline" functions in a .h file that don't actually get inlined;
the user intent would be often to trace all instances, but it seems to
me we need to provide a means to support both this or to trace a
specific instance. How the latter is best represented from the tracer
side I'm not sure; raw addresses would be one way I suppose. Absent an
explicit request from the tracer I'm not sure what heuristics make most
sense; currently we just pick the first instance I suspect, and might
need to continue to do so for backwards compatibility.


> I am not aware of long term plans for addressing this, though it looks
> like this was discussed before. I'd appreciate if you share any
> relevant threads.
> 

Yonghong and I discussed this a bit in [1], and the inline thread in [2]
has some more details.

[1]
https://lpc.events/event/18/contributions/1945/attachments/1508/3179/Kernel%20func%20tracing%20in%20the%20face%20of%20compiler%20optimization.pdf
[2]
https://lore.kernel.org/bpf/20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com/

> Thanks.
> 
> 
>>
>> I think we discussed this issue some time ago, but I'm not sure what
>> the proposal was at the end (function address stored in BTF?)
>>
>> this change is to make sure there are no duplicate functions in BTF
>> that could cause this confusion.. rather than bad result, let's deny
>> the attach for such function
>>
>> jirka
>>
>>
>>>
>>> ?
>>>
>>>> [1] https://lore.kernel.org/bpf/20250710070835.260831-1-dongml2@chinatelecom.cn/
>>>> Reported-by: Menglong Dong <menglong8.dong@gmail.com>
>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>> ---
>>>>
>>>> Alan,
>>>> I'd like to test this in the pahole CI, is there a way to manualy trigger it?
>>>>
>>>
>>> Easiest way is to base from pahole's next branch and push to a github
>>> repo; the tests will run as actions there. I've just merged the function
>>> comparison work so that will be available if you base/sync a branch on
>>> next from git.kernel.org/pub/scm/devel/pahole/pahole.git/ . Thanks!
>>>
>>> Alan
>>>
>>>
>>>> thanks,
>>>> jirka
>>>>
>>>>
>>>> ---
>>>>   btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>>> index 16739066caae..a25fe2f8bfb1 100644
>>>> --- a/btf_encoder.c
>>>> +++ b/btf_encoder.c
>>>> @@ -99,6 +99,7 @@ struct elf_function {
>>>>   	size_t		prefixlen;
>>>>   	bool		kfunc;
>>>>   	uint32_t	kfunc_flags;
>>>> +	unsigned long	addr;
>>>>   };
>>>>   
>>>>   struct elf_secinfo {
>>>> @@ -1469,6 +1470,7 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
>>>>   
>>>>   	func = &functions->entries[functions->cnt];
>>>>   	func->name = name;
>>>> +	func->addr = sym->st_value;
>>>>   	if (strchr(name, '.')) {
>>>>   		const char *suffix = strchr(name, '.');
>>>>   
>>>> @@ -2143,6 +2145,40 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
>>>>   	return err;
>>>>   }
>>>>   
>>>> +/*
>>>> + * Remove name duplicates from functions->entries that have
>>>> + * at least 2 different addresses.
>>>> + */
>>>> +static void functions_remove_dups(struct elf_functions *functions)
>>>> +{
>>>> +	struct elf_function *n = &functions->entries[0];
>>>> +	bool matched = false, diff = false;
>>>> +	int i, j;
>>>> +
>>>> +	for (i = 0, j = 1; i < functions->cnt && j < functions->cnt; i++, j++) {
>>>> +		struct elf_function *a = &functions->entries[i];
>>>> +		struct elf_function *b = &functions->entries[j];
>>>> +
>>>> +		if (!strcmp(a->name, b->name)) {
>>>> +			matched = true;
>>>> +			diff |= a->addr != b->addr;
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * Keep only not-matched entries and last one of the matched/duplicates
>>>> +		 * ones if all of the matched entries had the same address.
>>>> +		 **/
>>>> +		if (!matched || !diff)
>>>> +			*n++ = *a;
>>>> +		matched = diff = false;
>>>> +	}
>>>> +
>>>> +	if (!matched || !diff)
>>>> +		*n++ = functions->entries[functions->cnt - 1];
>>>> +	functions->cnt = n - &functions->entries[0];
>>>> +}
>>>> +
>>>>   static int elf_functions__collect(struct elf_functions *functions)
>>>>   {
>>>>   	uint32_t nr_symbols = elf_symtab__nr_symbols(functions->symtab);
>>>> @@ -2168,6 +2204,7 @@ static int elf_functions__collect(struct elf_functions *functions)
>>>>   
>>>>   	if (functions->cnt) {
>>>>   		qsort(functions->entries, functions->cnt, sizeof(*functions->entries), functions_cmp);
>>>> +		functions_remove_dups(functions);
>>>>   	} else {
>>>>   		err = 0;
>>>>   		goto out_free;
>>>


