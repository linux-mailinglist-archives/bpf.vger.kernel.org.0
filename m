Return-Path: <bpf+bounces-46740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B15169EFD74
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BDD188F61B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECC1B5336;
	Thu, 12 Dec 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4eTuIii";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ldGDpC9d"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9A1B0F23;
	Thu, 12 Dec 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035407; cv=fail; b=Ze7ndCH/a3Tn75jTIDcMGvD/+Hm+OIKwg7eHytB0BBPB+Q3Q+nmhS9sJSJtyzp33quoCOTncBGdRJmvJq+2/zXZojB75FcM4sfI6y045mqa0/Wn+anZca7zeI18rmy+xHlZISSByPUHzWNySFOsngBsIJB8PY6Oi4bQQNMf5Z2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035407; c=relaxed/simple;
	bh=1IXPBEjkM0BwOoSWQv0D0jvQJxFXpQCFwY0gXDO37fg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afhlhyHYEcNaZ+whoW/Te3XrTdhrbb1/XEzyFARrCtQCVutjVchpbLk5SC/ppEQUB8tayTZlBfywaqnl6kbZG+YEzgEdcDVmB1pusWoqro9TQoW7H1WHW1LAz+2mAMqzPnMNTUzdbVgkLfxQ9sCt8YD77GpBl6ISN/Yx8hGZcLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4eTuIii; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ldGDpC9d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJfvwY030216;
	Thu, 12 Dec 2024 20:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QjXW+Tvc1hlD+F1RQAI1XgYZRcdpWDagixUJvOZzf4I=; b=
	O4eTuIiid2w1s2n1LkOoqLp7LiDwV2lCLg8xvoP8ThldQN9i6StGpbbhkweJSRmS
	GvQoHlUQAEO+qni0HONsiq/uF85v5KqyaXvBszy2iuGunQoS2DWBnUWa/xOiSWU9
	ni/OKzq0jHOUaOYCYXLKG6n0M7apNq/z5sC45sncl03X+yaPCq+0jlt58U33FeVi
	jHhmFPi2TU5by2G/bfF4qSnbgZArZDepOawTsPLkWQkvakABXjswo320hSuDkZim
	NaXX/IhTb/QmYqsyGWG/bDGeJqqgSN+NKyFnf6f+cHUrIfvEbTWCxezq7CLG/JoV
	xKy9kaotBxCRXCTOfiH7oQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyt40jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 20:29:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJohWL008552;
	Thu, 12 Dec 2024 20:29:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctbnrm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 20:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kksmdKhg9Yda4JGA45eZeoLbAayqG1xXPvCMN/rtnYdletZUjxVR/szacwZvizlylTMqAhBQhp+hHQ+kKp1MT0Z2HmjOi9W+CBw/vUqJH82uDixz0InVerV+FxO71dVeCz0yQBt26SpsKI6cn6RYExdkNC9JqsawHw/3RnBaKS/y6tAzNGujov/cbN8xL4rIQAfOkifeu5pCW81Q57+HcDio7j6S+1nPNnsAWOMtwOCDud1+E7IDsSfeqTrAlukTZ3U3O3dai5+efXT/Zw265cMwWUbEEtv3BygJETngfoWJX6YVKp45SW7Jxdu8qW7BE//n1jEqlvLPmINrg9gB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjXW+Tvc1hlD+F1RQAI1XgYZRcdpWDagixUJvOZzf4I=;
 b=N9jHFaUSG4Sf//Y2jLomWeWefQ63egU7/l1Cq4BrXF+WugpcX92mjNxkOoZ96/8aM43WGXcz4VRaL9PP6362TIvy558EHhCDzi25S2/97yFWd8C4FWYzqTzuqL39iog5HK9svKxya3+PTdeTiA3tUzahbHj6V33Vb98Mn6SxqPAJm5gy7sBWhEXjYd+ur5vfOwkllUCcHc62FNS1CYuZiSoWSTIb+DT3maXsxAzq/2A0KjMoAfpfGgvMtfyOKLYeW24G8uBKLEMGlgME42i/+vmNI5QDaoJDwpoI8TdS00r4VaovHkZ6PhF2ZJCCLPK1kQiohjaQ7jT828l6SDrowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjXW+Tvc1hlD+F1RQAI1XgYZRcdpWDagixUJvOZzf4I=;
 b=ldGDpC9dDFIwYIUQWE/bt5LsvKdRVTfg8vmMtCDq9Liu2fvUhRQpxN9v3GXbbbbwwqtDQa8o3xukgVIR9ZiGtXZcm0dPS72K7Y966QK567ucqShjkG1tswwsmXXhX4LOF3picttpxRvAa39PFamqAeLLhtJXQ0wZZJvQ8e/hDaw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 20:29:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 20:29:35 +0000
Message-ID: <f76a8cfa-73e7-4978-bd25-637db5d98dc9@oracle.com>
Date: Thu, 12 Dec 2024 20:29:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1 1/2] btf_loader: support for multiple
 BTF_DECL_TAGs pointing to same tag
To: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
        arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yonghong.song@linux.dev,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241211021227.2341735-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0043.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: cf047ade-70be-48ba-f5bc-08dd1aebb1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmdNNFBtQWMvUG9NM3dCQ0drVmc0dzBzdzdHMXBudkVWdFBjSE9iZlFvNmpK?=
 =?utf-8?B?cm51MFhtZXBCRHRvWmM3YjBmbjk2K1U1QWowTGozTUdyUkdCS1VFZ0ZWUkhS?=
 =?utf-8?B?Rmw5VDJYQ2FsVHoyQ1hkSTFTSnJKM3JodHJ6OVowWU9QWnpqbFdGMm12MVFI?=
 =?utf-8?B?d1RMM0xadlYvbzJ5Y3A0M2FXeE00T1FUc0tPRHZqU3pBKzBZbFZaYjJGekdR?=
 =?utf-8?B?M205ZUkxbndWMUp4UjFXSU9Kbi9RZDN1R1Q2Q0dCZ2hPZzlJcjg2SThRQkVr?=
 =?utf-8?B?bjV1bDFCZDBjQmI5eVdvTVd4RklMK09VaDlUOTRYdEhjbFhGamtyKzR2SFlr?=
 =?utf-8?B?S0g4SmhUV2VmS1k4dkNIQStHV04wcmtqeE1TZGYyOUNzS3phVmRUS0dPMWNh?=
 =?utf-8?B?N29La1BLYjczL1ErTzhQcENicWxTTERqcVlDUlY4ZUsvSE0yaitUVmlVNlFq?=
 =?utf-8?B?UTdycHZhMzRpdFc4RDRuTWZtRkEwUEF4M1pJSGQ1MW1PbXNmWCtIWmJML2M0?=
 =?utf-8?B?ZEJ3aTNHSWpDbEZXZU5PS3Znd3hFYjhBayttcTFnc3JMcVdmZzN0ZldKSXRn?=
 =?utf-8?B?SSt0d1ZEem13MVJUNm1rZU1CV2pLWHE4aDNDT3FSVkg5aHJYSzZoNTBDUzZr?=
 =?utf-8?B?bWVUbDhUek1oQlBGdm5NakU1eWRyREo1Y3QvaUtEUzkvN2ZJRUxkMkRINjJX?=
 =?utf-8?B?WFNQVnJ2NTJUdGhGTjBwNytOMnhxY1BKKzVRdTZweC9zK2dWUGhDWXdWZVBu?=
 =?utf-8?B?NkY3dU5zbWJDQXhBS1lJZ3JyNkpUOUdmMWJMcUdrU3lhajhLYTJsQ3MwUjF1?=
 =?utf-8?B?clc4QXJGbVVWajZ6TVc3QWNKZ2pWbWM0WWJMTEVrbmpiTmIxVGtzQ0dXcDRF?=
 =?utf-8?B?K2ZLUEZPQzdldEhkby96Q0hDenBONzlyOUdndjMzUE1mUG11UlViVzh3V3Z6?=
 =?utf-8?B?ZGF6a1FWN1lUV2tiS0x6SXB6cFBDc1R1OTdUbGZOQVR6Qyt1eTVsRmx5cW1o?=
 =?utf-8?B?aXFJSlg0cVFQNS9qM2d4WCsxV2RROUM1dVo0T21OTXY4Uk5IdG5KR05uajRF?=
 =?utf-8?B?ZS9MRFlCQ0EyVXJibjRFdGFNNGFaMHFCVVcramUvMkNjQmViOVJDdnc5Z081?=
 =?utf-8?B?TU8rZEZacHVsY2FsUHZoVk50bHJBRzdwZXF2bGtiaENmTGFvVEQ4KzhyaEdE?=
 =?utf-8?B?bXBkN1hFT3MvZzZRbmtGQ2x3WVI2dFFKSmpoVXVBMmUraXIzK3o3UEMvb0JX?=
 =?utf-8?B?QitsRWJzRHE3OG9BV1NEUW1IUVBPeXIzMTJ5OG5pa1V6K0VwRkNWZnkxVUg5?=
 =?utf-8?B?Z2ZaWWZuUngrdjdYUlo4aGd3UW1nbnVTN2ZLNTl3U3Z5ZjRDejVQajR0Skhm?=
 =?utf-8?B?Z3NkdXpONDliL0tyVUlRK09Uem81TmwraGptd2xFZUxEMHhWYk5PY3huWFhB?=
 =?utf-8?B?WTQvNGE1NExBb05yalBRNjlseUo4T3loWXQ3U2VzT2RBd01BN3FyZ3NKMkxT?=
 =?utf-8?B?ZFc4NWV2NFFhZGxXQ2xac2lHa3E3S0pWMmtSZnplK2VwcTlncWZwVndlNUFF?=
 =?utf-8?B?Uy9rdlhaNU9UVE9FVmR2bGtuZy9DbzArZC9kMVdxeTh4WERqSHJUU2pLM2hC?=
 =?utf-8?B?ellHMzNlS0swd3M4MktUN2EzeU5ueG5oVXRoaGcxa0FwQ2FvaUJCZDB6UzBs?=
 =?utf-8?B?blJhY283bzlWV0g5c1V1YW13QjFoUzB0cWxUNnlURjdpV1FqamN0WTZqR3Yr?=
 =?utf-8?Q?5ilTKUwYzf9HRlFVYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ry9aUzVKV2VKZ0kveVJWU0JJRFpYOU1HOXJxL2ZTMUNMVzVOMVo4Y1RxSW1n?=
 =?utf-8?B?b08zamxVZjAvc0VSQzNsUENoeDE2N2lHMnpmNUVIZEQzTHhKTWhRaG1Ea0FU?=
 =?utf-8?B?c3llWURtYWNmYlY5WTYvOFN3ZHF2TEo5ZzhNaTNBbnd2RGFtYjJaZFZRR2RW?=
 =?utf-8?B?cmNoNFI0dUM2UlRseU9aS1RmUEJ4cm9mV2pndDY5aG16MWtxM1FGVFFMSURC?=
 =?utf-8?B?cXFzVklWbTRoWGV2eXFTTDI0dHE4SjQrZlJjUEFKUlliQWtINmlkTkVXVXNE?=
 =?utf-8?B?L0k1VVdlR3VROTZ1VThmSmZBZDUwNi85OU1wUmk1TGx1N3FDM3F4RE95Smpo?=
 =?utf-8?B?cW4vb2pPdXNIRGJjVW1jQ2dzcUhueTRVVlJpL3JCTzZ2ZFVCVG9uNHVkMGZP?=
 =?utf-8?B?OEw3Q0JsTmRaSE8wWUFNNTFVMzNyYlpyaTl3R1l4WkxDQk4vWXRnaUZtWHQz?=
 =?utf-8?B?UStoOXN0QjNKakhxcFllbFUybUhsSWRQL2JwVTlnVGEwSTBpU1VtVk9RVmFI?=
 =?utf-8?B?dFd0dkdvZ24rbEdPNm91elMwMVczS0o0OWJRemQvVWU3VE9oTUVZVEE1SWhW?=
 =?utf-8?B?MlVVZzJMNXRmWEJNRnJicVA0UUpwalBjV1hyayt2SDFjc3JwTGgwd0RsUXVw?=
 =?utf-8?B?aHFjY3lheml2UWVwcXZvVDZpN2pvMTN3c2NTcjJPR1diU3ZabzZSWDVsQXdr?=
 =?utf-8?B?dThaSGJ2L29IK3d1V05ha0YyUXozaG9tWTFlRzduQjIybjEvT29RaGc4NXJl?=
 =?utf-8?B?eWFFaGNydmZoMzBuVDVMc0x6bElieDdaYWpRSUE4dE9HbDhkb3JEbkxpWVk4?=
 =?utf-8?B?ZjN6ejlDVzZmUnZVQWx1MVg0T1htRTVyUHd1ZGdJOVV0aWxnQitFQlRzSWZ4?=
 =?utf-8?B?N3Y4c2dneElYVENWbjZWZzBqenh0SHdPcEZxWmJ0TjlzaUNpMG8xc3Y0WWRh?=
 =?utf-8?B?aEtwQ2RIZ3F5UXY1WUJvL3E0NDduYVYwcDA0dHd4cURobUFydTd2QXhjanVS?=
 =?utf-8?B?UG9DL3pZNjZEVHdXaEFOc1QxSnQyY0NIWkFFd2JUNCs5bjJxWG9OdW5VTmFX?=
 =?utf-8?B?eEVLQThlcDhUOFRabUdid051TEp0MmV3YW9KbXRHY1kxbE9WYUlHODlBY0do?=
 =?utf-8?B?OXhZWmF4M1hOZldBNi8rN3BkYUdGcTRSalhUNTZCWG4yRVVEZnFzNThoRElR?=
 =?utf-8?B?ckR1U1k5dWpNV2VIVkJoWDNjWHM2eTJkeU9WTW00VXpEMWtQTXBzb25uMm9X?=
 =?utf-8?B?dFBXdW5BWmMxR3dDNG11YUxmTTlKUDgxMnNPRXNqTmlNbDl3TWVsS0Y4TUor?=
 =?utf-8?B?Q21NT3Z2U3hYQWdnM3BGbjBGNGt2bUVnMFZ0NDV6NFdrTkFmTUdLTGdJVThX?=
 =?utf-8?B?V3FHYjY5dXlBelFudnFuak9TYnJrWXBFKzhwTERSeUNHZ1o5MEx6dmljZUVr?=
 =?utf-8?B?THNXSTBPNW5HSHF1bnN1RmhzNmlpV1dYRUlscUNwU1kvT1NoaUFRWFduUVFv?=
 =?utf-8?B?MUNqdjBRbkZMd093VEJzTDIvclVWb25TQ0s4a1VaYnM4eFBYTmJOM1lCcUpI?=
 =?utf-8?B?dE9QZEhQM1ZyLytONVkyZ3g0ZVFjeG16c0ZzRUEwQ3dlQnpyNmRqa0ZYUDg0?=
 =?utf-8?B?bnZzY0dZN3lONlE5VlpDUnFSeUtCc2U4V01Ed0hDVXVCeDhtdlJ4Wi95MHpZ?=
 =?utf-8?B?cC9qWXVmT2NwSHQyVkdnZ1V3VFNxbGpFcUwrODYvU0N3Ulc5RHovTHFCTFYv?=
 =?utf-8?B?Y0hkQ0tvMGh2aGdtcGJsQkV4ZkdzSnJPNWt4WVFVaStCQzUzYXd4WC80QmJs?=
 =?utf-8?B?QUdSYTVPdURDcCs2OU5iNExBMDd6dlJaOG54MUtBVlBzTm81QlNhZ3hMaWNs?=
 =?utf-8?B?ZHE3S2E1MlpUSlVVTmtYcnhzblFKT3BmSHFtQ3ozeENYL2x5YzBJZDgybHZI?=
 =?utf-8?B?YnVJRy94WmkzbytqMk10ZExhblY5ckQ2TW1xT0hJR05sQ3Vrayt3VmUrQXhO?=
 =?utf-8?B?elJwSUpndnoyWWZZVU5EeXI1TWl2R01lZTlsUFdsSmJxdzNLbElkbTMwK25I?=
 =?utf-8?B?N21Xb2R6ei82UXBVelpPSnNnUTU3WmdudGg3dnhYbmErNk5SQ1FDTDFaZE9u?=
 =?utf-8?B?VTdiQmgzMWkyZTN0NXpzcHN2ZG5JSUplcm5DQndsa0d6VjJldThGN1pCWUN2?=
 =?utf-8?Q?05ATV+TzTINnSauP1aKPJYw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YAy70stbFlZtkYRsQmSeTinozLEWflRjoXzunqlorT/lBMBS4STsWiiOyIDV45WeYLKqE+IVkFQXJi6Tt/NNmoJnSNbFAD/EmjBF+U6cQG6at8F9VJ82LcfagC/lA0MhzAfmfaHgmY7VwfuUlzt1pG/PKXsVo9lEUOntdVKPGM3HSM0dSPLfWvARJvqbNybDPZPX5Uo6P6q8D9Ex9fohs5NKuSE4811SEzQxHf90/R/qZp8KOWZzBM19PoarNUsdTQ/iMQNZyXm4npUrQQ+Tt++bMq0cJdzoM5ld/Z6MAxxuUeDLiBlF42+PEuG1hZrqywYdsE8MOMI6JtmJSMUxPhjeQoQX68qsZ9AFRN5z+4qedGxE5TvoHPhQ1DlB6C8AI2E7kE4TumxYVzLH3wuGrlk+Z09D05zCJlH+NPsm2BwMlmI08pv4nfwN2z0CRARb1WkOsUACdUo8y0X8s6zRv2wgGqwsaJDNWpWZ6QerM3AvUeCJ/sLc5N1RMptTf46maqz0bpIqfI/Zoc47Yb8gSE0A56iljKUW60MaaBEx9GZlw5XxbJK7Ja53A/d5mQnWxUBaJ2iBXTtDmYDMpuZPadO3gYZdLHXP/TwOufV41uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf047ade-70be-48ba-f5bc-08dd1aebb1a3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:29:35.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rc5ru57TFcePE+brfQoa9VDxhY7I4yUfq8OYiGNqX/3Nf6THib95zJXPzQBqgCFA+iG973G2KnoRRst0YAD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120149
X-Proofpoint-ORIG-GUID: 31u0yqLVA43G0JWdzKLq8GQTuCpK-cSm
X-Proofpoint-GUID: 31u0yqLVA43G0JWdzKLq8GQTuCpK-cSm

On 11/12/2024 02:12, Eduard Zingerman wrote:
> btf_loader issues a warning when it sees several BTF_DECL_TAGs
> pointing to the same type. Such situation is possible in practice
> after patch [0], that marks certain functions with kfunc and
> bpf_fastcall tags. E.g.:
> 
>   $ pfunct vmlinux -F btf -f bpf_rdonly_cast
> WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
> WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
>   bpf_kfunc void * bpf_rdonly_cast(const void  * obj__ign, u32 btf_id__k);
> 
> This commit extends 'struct tag' to allow attaching multiple
> attributes. Define 'struct attributes' as follows:
> 
>   struct attributes {
>         uint64_t cnt;
>         const char *values[];
>   };
> 
> In order to avoid adding counter field in 'struct tag',
> as not many instances of 'struct tag' would have attributes.
> 
> Same command after this patch:
> 
>   $ pfunct vmlinux -F btf -f bpf_rdonly_cast
>   bpf_kfunc bpf_fastcall void * bpf_rdonly_cast(const void  * obj__ign, u32 btf_id__k);
> 
> [0] https://lore.kernel.org/dwarves/094b626d44e817240ae8e44b6f7933b13c26d879.camel@gmail.com/T/#m8a6cb49a99d1b2ba38d616495a540ae8fc5f3a76
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/dwarves/Z1dFXVFYmQ-nHSVO@x1/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Looks good to me. I _think_ we're safe enough in assuming the tag
ordering "bpf_kfunc bpf_fastcall" in the btf_functions.sh test, right?

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  btf_loader.c           | 31 +++++++++++++++++++++++--------
>  dwarf_loader.c         |  2 +-
>  dwarves.c              |  3 +++
>  dwarves.h              |  8 +++++++-
>  dwarves_fprintf.c      |  6 ++++--
>  tests/btf_functions.sh |  2 +-
>  6 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 4814f29..af9e1db 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -459,9 +459,28 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
>  	return 0;
>  }
>  
> +static struct attributes *attributes__realloc(struct attributes *attributes, const char *value)
> +{
> +	struct attributes *result;
> +	uint64_t cnt;
> +	size_t sz;
> +
> +	cnt = attributes ? attributes->cnt : 0;
> +	sz = sizeof(*attributes) + (cnt + 1) * sizeof(*attributes->values);
> +	result = realloc(attributes, sz);
> +	if (!result)
> +		return NULL;
> +	if (!attributes)
> +		result->cnt = 0;
> +	result->values[cnt] = value;
> +	result->cnt++;
> +	return result;
> +}
> +
>  static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>  {
>  	struct tag *tag = cu__type(cu, tp->type);
> +	struct attributes *tmp;
>  
>  	if (tag == NULL)
>  		tag = cu__function(cu, tp->type);
> @@ -475,15 +494,11 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
>  	}
>  
>  	const char *attribute = cu__btf_str(cu, tp->name_off);
> +	tmp = attributes__realloc(tag->attributes, attribute);
> +	if (!tmp)
> +		return -ENOMEM;
>  
> -	if (tag->attribute != NULL) {
> -		char bf[128];
> -
> -		fprintf(stderr, "WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
> -		       attribute, tag__name(tag, cu, bf, sizeof(bf), NULL), tag->attribute);
> -	} else {
> -		tag->attribute = attribute;
> -	}
> +	tag->attributes = tmp;
>  
>  	return 0;
>  }
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 598fde4..34376b2 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -513,7 +513,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
>  
>  	dwarf_tag__set_attr_type(dtag, abstract_origin, die, DW_AT_abstract_origin);
>  	tag->recursivity_level = 0;
> -	tag->attribute = NULL;
> +	tag->attributes = NULL;
>  
>  	if (cu->extra_dbg_info) {
>  		pthread_mutex_lock(&libdw__lock);
> diff --git a/dwarves.c b/dwarves.c
> index ae512b9..f970dd2 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -210,6 +210,9 @@ void tag__delete(struct tag *tag, struct cu *cu)
>  
>  	assert(list_empty(&tag->node));
>  
> +	if (tag->attributes)
> +		free(tag->attributes);
> +
>  	switch (tag->tag) {
>  	case DW_TAG_union_type:
>  		type__delete(tag__type(tag), cu);		break;
> diff --git a/dwarves.h b/dwarves.h
> index 1cb0d62..0a4d5a2 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -516,10 +516,16 @@ int cu__for_all_tags(struct cu *cu,
>  				     struct cu *cu, void *cookie),
>  		     void *cookie);
>  
> +struct attributes {
> +	uint64_t cnt;
> +	const char *values[];
> +};
> +
>  /** struct tag - basic representation of a debug info element
>   * @priv - extra data, for instance, DWARF offset, id, decl_{file,line}
>   * @top_level -
>   * @shared_tags: used by struct namespace
> + * @attributes - attributes specified by BTF_DECL_TAGs targeting this tag
>   */
>  struct tag {
>  	struct list_head node;
> @@ -530,7 +536,7 @@ struct tag {
>  	bool		 has_btf_type_tag:1;
>  	bool		 shared_tags:1;
>  	uint8_t		 recursivity_level;
> -	const char	 *attribute;
> +	struct attributes *attributes;
>  };
>  
>  // To use with things like type->type_enum == perf_event_type+perf_user_event_type
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index e16a6b4..c3e7f3c 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1405,9 +1405,11 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
>  	struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
>  	size_t printed = 0;
>  	bool inlined = !conf->strip_inline && function__declared_inline(func);
> +	int i;
>  
> -	if (tag->attribute)
> -		printed += fprintf(fp, "%s ", tag->attribute);
> +	if (tag->attributes)
> +		for (i = 0; i < tag->attributes->cnt; ++i)
> +			printed += fprintf(fp, "%s ", tag->attributes->values[i]);
>  
>  	if (func->virtuality == DW_VIRTUALITY_virtual ||
>  	    func->virtuality == DW_VIRTUALITY_pure_virtual)
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index 61f8a00..c92e5ae 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -66,7 +66,7 @@ pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
>  	sort|uniq > $outdir/dwarf.funcs
>  # all functions from BTF (removing bpf_kfunc prefix where found)
>  pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf 2>/dev/null|\
> -	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
> +	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/btf.funcs
>  
>  exact=0
>  inline=0


