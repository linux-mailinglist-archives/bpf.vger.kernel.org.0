Return-Path: <bpf+bounces-58559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ACFABD9D9
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12A71B64E97
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33FC22D787;
	Tue, 20 May 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FONd2rMO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pGNbFjhi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805022F2E
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748770; cv=fail; b=n32qKAqHRh3gwR07fphqsXn3W3E2A9hUzilxbYZkbnHGdgifFX9o39bi/wg58vQ3vxY0Db2KdgTTn4tM8knoVuGRALWNAGutEqVehuAQblqiBQldx4V6N47CQfvs2qo0oocVVp2xLhppBL7Uefw5gJy76xZ/wqaWOxhUyGxchEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748770; c=relaxed/simple;
	bh=C/Ww0jtvaHldDDxe1FyUZ5iRqKvSnWNNP4zwp/UEU+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqEvbQn7Kx7Vev7KsJZndb31jgyHlhRJKf2wpHzZIihWR2pNjlXFQs77hgVn5SZKvX+yytCAb7jNe5gT1w9XAANRYy7k+F51rxiko824WaArTjzycc5TnF40IbWi0xcHq+nogmgo6qKWwiUjsz7QjK9tVb416y0FNmu5EQIS9x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FONd2rMO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pGNbFjhi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDc2xE025697;
	Tue, 20 May 2025 13:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C/Ww0jtvaHldDDxe1FyUZ5iRqKvSnWNNP4zwp/UEU+Y=; b=
	FONd2rMOdZb9bd/naGLnRMGucLhhffcEcAsl9ZPi4N4kW3ySoWP0M1jecQofD3YN
	iH2+ddtkVMSOce28/9aszXRprfryWmiTbgq9BAaCN3PKAo0kNLpun27E2Js9nhTe
	2/SPKWfLBYol61YfNPhpkY7yZd9cI8YczWh0OjTHXlgpIlwMV+ytqmT41zjNIPTP
	v8SuAM7blcqMdKmRaQIrlEKwPC1OmRKrDCcqnZ+vaj6WsqOVJZcJ4VQJ+66dcosw
	jR7Ea1/uoD7mhg5XjtkA/Ed8p83p3ex1ORmrkE8sIunZYbugNx3Ie1hXYGER43E3
	7jZGXYukjfr2Ek8TgjOx4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rtsbr0kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:45:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCo2na015790;
	Tue, 20 May 2025 13:45:26 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7se6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWwA7sAl+buCEJXWFyMdoZ3yw3fI3J5NoEwcfKDfQ1Kn1ZQwbfzQUsPv9mToM0VlTpdkjU1v2m6vlF34r+wxbLsOb0NDYjtASVMLb/Ggm5jzg66MWvsvkpwEH6UmBiTyQCUb9lDsPexXaZi25hlPJZtgaRoKLACwoA3e/RbZoDcGaDVd+a3jtGzM4drRBqxx0wpDlLUIiGt9gecC9mpXQ1xiJyPIGyzJsXiFDhuVPMC26KChOjhvUQAVFvEIGMdjVvIehT1FlWC+TMm25E867hdmmjr+woVSEiQWHIOUIkYr6wlGcbD2Tels1DkUb2JO+zdEgjeN8mCN+7GylN35KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/Ww0jtvaHldDDxe1FyUZ5iRqKvSnWNNP4zwp/UEU+Y=;
 b=OAe/pNan8hkiBK84ohFIVrqTRayofbiG1+3QSIQ9vLRSR6YN4fMoEVdc8p4albVq0SbxKMP3m4ufHfBOOz7ISfLOwQQ2L7aSjCdVFOvyl5EZXU6u0ogaxkcWd7efMJ+1wnUD0gcufqm/Vo2T5Q4BbNKl+uAhlP7xPnyfURFcyzGfClfihbwq3zlBd3GqX1NM6IWd3tI6VEE2ZkBrkof61mumTSTrNji3G2vYyNm0SDYvgu6xvmR5bCE66Dayx2LB220emM0dFyeCANhik5Am8a/1hEjBl4sDC/vs8xPzCZLKyCtrNoWL/XpfS3Rg7w+HDr5PuJRKq7vmTLu07HBpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Ww0jtvaHldDDxe1FyUZ5iRqKvSnWNNP4zwp/UEU+Y=;
 b=pGNbFjhi+L5R7XoGHWPZaf5KfCORNLdFR3zBW6YfhIG81gPIT/uhbpRf2IwYeYM+/dzcG+NY/lQwdnU8uDTEGvAzyNvEJo5HujIkohqo06qiUSyCpYdpPQWijhYjH+wGpQiV0HxWdLfucYpOMhRM7FwueYAL3YOgYjoRGxgKsuM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7162.namprd10.prod.outlook.com (2603:10b6:610:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 13:45:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:45:23 +0000
Date: Tue, 20 May 2025 14:45:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <849decad-ab38-4a1a-8532-f518a108d8c6@lucifer.local>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
 <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local>
 <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCZRDuMtc=MpiR1FWpURZAVrHWQmDV08ySsiPekxU2KcA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 416d010b-ea08-490b-b77f-08dd97a49195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkloekQzRDdLWDNwVFdQajRid3RvaGp2bzY4b093UFdQb3h2Q2piamxtckVZ?=
 =?utf-8?B?RERZTVdOblc1d2JOSXRMLzJ1R3ptT09qeWlZQzd6L2tUQzVOSGI1YlNSeTk4?=
 =?utf-8?B?RGxOZ2RUZmJ3ckdqU3B6VEx0MmFrWktadXc5akt5YmpaUVpsNFhtM0RmdlJr?=
 =?utf-8?B?UUZyRzlwNGpiRnRhYmk5VTIvd1g2R0Zmb200c3pWcnh2NnNZYnp5aHAzMXZN?=
 =?utf-8?B?L1lqS1dubmdqQ1dPV0ZkOXJIbGJBd2NiUWNtbnVyc1ErZURqYWdkK2Rrc1ls?=
 =?utf-8?B?SjdIcXQ2cG5Fckxub2x1Qy90QkM2aW9Dbmh6R01vZ0hWQ2JaSGhxeDVYZzRD?=
 =?utf-8?B?T2J0Uit5Q1dsbXFLRnpUMHZnbGtuU2NEOEZGWkVicUhSUk9GRko3dG9kbUFI?=
 =?utf-8?B?WmxtaEFaTnRuNGVwck1QRnpkZlM5NVpNNDJmV0xQWnp2UCtuNnFRaVRKcmFL?=
 =?utf-8?B?VnVnRDB4Vk9NVmhhVEx0M2VpeHlvZjNOTTduNWYvTTJNbldFR1pHL1dmaW56?=
 =?utf-8?B?dUtod2pnRnpYRXJFV3FBaDE4NjZ6ZW9CSGE2SzgxMllaekxkdTN4S1d0azhF?=
 =?utf-8?B?WSt5Slc1QzBpdDNXc3RoSnQ5dGw2NjkxR2VXOXF3elhZTmVxMmprcUdLNTVl?=
 =?utf-8?B?UjlDVVIrSUFBME1ueW00a1BVd2syMkx2TnhjZHpCeXNyQWZIeWFVTWJpcG1S?=
 =?utf-8?B?R3VrREQ1NEVpYis4NDNyNzJibXVxRnFqdWN6bHB3ZUgrZkEwblBhWjZ2S0M3?=
 =?utf-8?B?WTVyOVpEYjFBVGhXWTZwdUMzMWhORWMxLzFQWFZJckU4bUdZWGdmTExaN1Yy?=
 =?utf-8?B?UStNUHE2SmVyeTBWMUo4cmFSUEpDcWdCQURuYk1tSjM4MUp6dlJNai9NVzlK?=
 =?utf-8?B?Yjl1TW00MGlsT0VkWDJFWk83Rzlvb1FOemt3VFpxaFpzdFVBOTVWTlRXRkZU?=
 =?utf-8?B?ZlZiNGZwSVI5Z2c2UjU1UXAyc2s3VGtOT2xWM1VYTzVLU2lWeWpWS01ZTzhX?=
 =?utf-8?B?QVc0QzJrSmQ0aXJXYlVVdlRzeGJ3Wm9LK1ROdlVpcFJ4N2x1M3NBelUzZUt2?=
 =?utf-8?B?REZjb3pTclJ1TlVnOTh5ZHhSbFNlakNNWWs0WVhpK1pEOW5Gdk1kM2NtZjFz?=
 =?utf-8?B?bDlRSy9yMzlzaEJ3Z0dGK3ZmWExlY2NGUnZEL2FPNHU2TisyNzRsOHI1aVVk?=
 =?utf-8?B?eHF5b2ROMUUzWVZtRnU5MEU0bStrcHNUazJYUUgxOEM5QjROdmducGsvSit2?=
 =?utf-8?B?ODVnL0JINm92ZTl2ckFoZnZtWmdNK05FUEpOZWR2MkR2NTdhRi9qRXlHRlZv?=
 =?utf-8?B?V3NTSWZWWWp1Y1V6L0wrZHVoN09YRHRON2JGRkVjblhvdUNPMnpWNDBBbmY0?=
 =?utf-8?B?VzlPbW05TjRpNXY0UU9EYUp0RjU2VHV6M0pzbnNpSkZkTC9ZR0ZVdTlNcTZX?=
 =?utf-8?B?R0VxMWNpMXZKK2NMYkpmL0hrTm5jZG5FUmZBZXF6Mnh2TXdOTUlXNlVidlBQ?=
 =?utf-8?B?MFpLNytVTEwzc1Z4ZVpRRndua1pIVDI3YnlpcTFXNGhpZTJRT3BhdGR3amgv?=
 =?utf-8?B?MGN3czdnbGxlaFh6OWE2RXN6R0JLdjlCM0FmaGJHL2xtby9tN1hhNGlQcUtX?=
 =?utf-8?B?QnFlaHFVWjVxT29qRUJnYS9QY0ZkK0sxaWdzMW9BWndPZndySnJpMFJLSlhN?=
 =?utf-8?B?YTJVNXd2RElOSWpFbWgrdEJaUVVhUjFWQzZuN1U3WmdkTEZodFBJTDhneGlt?=
 =?utf-8?B?bHUzTzZhcGhMSTBuRXFoR3lxSTZhakh6MkxmMGFOQStvWXB5cFAwaE8zek9t?=
 =?utf-8?B?VlBMeGhYY3VGa3hZU0N6TDYzT0FtdDRnUmRGUjlQT0ZKRFdNb3dYaDZYRENV?=
 =?utf-8?B?VDFnc3Z2N0VrR0R1NG5Kc0lUT0xsamFJSStCQURUYnpTZll0UnRsbG9ubk9V?=
 =?utf-8?Q?v1ne7tS+UF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1c2TmhsRUM3T2VNemc5c0FDTFBqVTU2SDMzVkxtcWxTKytJMEhNeERWeWla?=
 =?utf-8?B?TC9odU1rS3NoWHBWUTRDVEZHbnRldmZRUnNLeGcyM0hTdHErYVU3dFBjM25j?=
 =?utf-8?B?TzMrSytIdkIrTmYyY2M4ZFVBTFVvWUY0dS9nVW1pTUJMd0pUYkR3VFk5N09C?=
 =?utf-8?B?ck5iNEhQemMxMitGSmNGcnFmK3hlTXp5TVpHVG81Szh1ekgwOWt1Rk9YT0Nm?=
 =?utf-8?B?TU0xS3ZqS3pKdHFxd1RVa093T0ZVbkJGWjdVQ3ZPazdraFdGV0FOeGpidDJp?=
 =?utf-8?B?c3J0cjNPeE5FRExCQ090RmYwY1M2aTJHN1lmWXc1aUI0WElmY0syTEMyZ3U0?=
 =?utf-8?B?NWtmalNhS2VhNU1VY1NpWTdzVzNzWnhJVk4rb3ZlaGsxY0EwTE1uMTZFU0lT?=
 =?utf-8?B?V1A3MzVUczhyWkJKakdJS2RENWVIdkhWbUVnQ09ZVFZiTnUwdTVOWmtnb0d3?=
 =?utf-8?B?WHJpTjNhdFFWRFcyZ21IYUtMaFhqclJuNmU0eTBidGhJbWdVSXVNUndreEcz?=
 =?utf-8?B?YzI1dzhyT29iV050eHpmRUY3SjJFQmRtUnBTbUN2WDc1aTlVOCt4c2Q1UjFG?=
 =?utf-8?B?YzhUTnlXRGVYbkRHaXY5NE54Q2pER3N3SEF1enpCT0g4Q3R6VmJsNWxiYkJw?=
 =?utf-8?B?WkNoNzIzakU3bWIxMVVBTFNOdDVlaUMxaEVnejc4R1Y2cWZId2UyOHk1ZEo2?=
 =?utf-8?B?SFhiWHMrZkRPYW1JeXRweUxlb0J3OXFnNE44d2VOK2ZIaGhPTFkzNFNkb05D?=
 =?utf-8?B?ZjNJdDRMUGJjMGFDaW42WHVOMVY4UzhoMkVLY1prNSsrOEttRGFKQ2pwdHBR?=
 =?utf-8?B?d2F0VlJTRGYvcGNlOTRabUFGRUdKa0hZckxvWC9VV0UyVm91K0VxOTZEYlI2?=
 =?utf-8?B?clFPZG5BUklLTW5JK2tmNEdsZXdxenc4VlhpMjVLbG1DeWtZSC9VcmNyVkVR?=
 =?utf-8?B?a3djcE9tU3VnbnJDaGdsUXhUYUcvM05GTDBZV0lPODlLOWJSKzdTU2dTM1BX?=
 =?utf-8?B?ZDdSdGpGV2cxeXhwalk3T09EcGF3ZWVMVUluR1QzOWQ2eGdXR1BMWXFqL0pp?=
 =?utf-8?B?c2ZDZ0NJb0EwL3hMdW9vV3ZNbmhDYm53SW9yODE1WTZVQTIyMHlYSDUzQzNj?=
 =?utf-8?B?RWZtRW92aGZLYkowTTBqTE9HdlU2RW5kVkVYMnpyaGo3aFhhdllQOTNQNFFP?=
 =?utf-8?B?U1RYRURXUTYvYzI4eEZUV0xTTjlPRmxYVHdxN29nbW9YdUJNQmFCUnVUL0VR?=
 =?utf-8?B?OWVzbUxPaUprM1d2Y1JzRHIwNUZhV3ZzZklxWVpTSDJ6UmppTW5IMm44cE56?=
 =?utf-8?B?ckZ5MitXYUFkWTNQUDdDeFQ0K1pIUHBjcFdQcWFkWEVqWUFaTHBrWmVyYnNF?=
 =?utf-8?B?cXIyMTl1dmNyTVBRN25YeFBuN3gzS00yQlcvRy9HaEx1QkprOG96Vlk1a0Zn?=
 =?utf-8?B?ZVBMbHdRcUw5NkFxbHZiTmNsZ21LcGhpQ2xJcmxOTFZTZjBWb0tHL2FyTHkz?=
 =?utf-8?B?T0Z6Tk1LWjk5ZlBqY1FEMDd6ODA3ZHJVQThLcXEyV0ZSU2taOUd6L2w0ZGRh?=
 =?utf-8?B?OElOalVBQkZvcWFwc21PWmRPeFJHT2FHZDlEc1A5QVd1WDMvVHBVYVE3UCt3?=
 =?utf-8?B?QjRCTkZvQjR6Qkp1T1J5WFhOclZEM1A0NnNTSTBEc2ZKSWhlYkM1cnpjNWFN?=
 =?utf-8?B?Ym50S0RwaWRna1RrVnFWeFZLVHNzQWpnTTJyaEk5TFM1VkM4aDdRbG1XbnBL?=
 =?utf-8?B?WmMrcTNKNXM0T1FBbzE4anYrUExlV0cwSGpjcVN0OTcwR2UxeHdzSWJJOEo3?=
 =?utf-8?B?dnBOeWVZcG5CUVU0TkxlcVUzWTY5cWlkSi9rMHBGcjRzRi9yMGh2aFB0MFIx?=
 =?utf-8?B?T0g4cVFFakhKQzFVaE1XM2swWmp1bUdFUkpmWFNudEsxUHgzQTJRc1N6b01C?=
 =?utf-8?B?KzdmMld3OVViV3I2QXRlQnJNL2dNeUFXbmdoam5YeWc3VnZiTWFhMlBwNVlC?=
 =?utf-8?B?djU5TFZCRWZvVW84cEVISTZoalFFQUwwVnpBSkwrd0xXRnRHKzE5ZW5JUzVR?=
 =?utf-8?B?Q3R1NWlWRExkK3p1Nko0TWxQTzB3S2xqL1lzdTBScDRob215OUNubEFJdS9z?=
 =?utf-8?B?RStzY3RZYkJhWjBLS1hFZDUwaUtVWnpSclpadXBkN2dOZTYyUml5MHBhei9Q?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gEzKmvpq0bpxBk1S0kiCBAjFvfQur+JRloopXfKCRSi7C+1J+w2kCNBujG0Zval72Ca+3P3fwfixA2Jv56euBpAz25lUl+2PPjBHsBcxvIaoicWudQEsodbEzbuOIwD0M0Xi+yF8FVz1jD4gYDQw6OgHXOCzgt68k6/70JfgdDDRSLE8/+qAVyfqKpw6BIC/pph9DnKgM6Sh1XiPqotjyY1PMDuDn/mzI1qRWOTZnUyLPVrrYhm6Rx9249Qpc4snKfokJS4jvsL0jjFy8JXTY/EzF3FG14jzmS8wRyxoLJWiv2ze7U4qIcGLpZ84JLI5eT8wklxCdDxzd7chC2C3oGQPTGwAqP+BzeZ6xH/3hng2VTitBeLjLiTrTTkGKgaA6rFPOCCqeYuPyCunOe33FBiMWdRnNk49YFIb3i6T4oKKljqOAxG9lptvIdo1UKXTLA4Su3mqVZlUbbdCSmmt18hZSQApVfROX9HMadY80dWbbrMT+uiT9zAXK+9UVesfuOu32BZVzdlPO65V10aE0vyFLXFZWggONxgsI541eULMYxy8x9T7Jx8oHhyFOKMO4CsPCe8Z0qiStnAo3BhmpqLAuih6uw9enJD2sRbidlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416d010b-ea08-490b-b77f-08dd97a49195
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:45:23.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0Hq4ImZMjZn0SjsW6Q2e1vTURvZp9QchnAwfLJdRcw3CIM9mDj2+UySHxZ0Yf9NoekGJ9kXsIMMh07MOi4RF6I0zkxWJ+N7UXu+5BCF2Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200110
X-Authority-Analysis: v=2.4 cv=D5BHKuRj c=1 sm=1 tr=0 ts=682c8776 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_cmZ69J9DheNdRwnwkwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1lJGg6s6yFKJO1SXeeNml8BjfX2TTmn8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExMCBTYWx0ZWRfX02vCjm1HJm/u n6fGl2XlooRcQb935TW1ABBDvBA2mViZ2HXEgMlLjgKLb6PAEIy1Zp8vaGk+GTB+hffLTmzNN5x fhxfLNfB9+UT9gzkMzmhOUzl/uHOy6eUjd5OBqT08g+KZ4pFNeh8uxF+bsA8lqdrs1pivo/1IOd
 jKH+TAD21oZOrH8goCLt3BCpwx+nsq5PezWReSuyedLGvJrBDZ3KKcYIlDuOAlchVJS3t+1pGLk qZAfO+jKwT4gcRqZnI3KKycglhNxf+avBCL2RQg4Of/jFPWkRl0L9Z8f6iaLWmKac1xpUaIoVZf 4H2PWBvHkxyAPj+q/KLYeKVZuHoEl3hjL4j5VGOlutB8ibGwTTUPZ3iH78rBVc88Gveb+/8JNU/
 hWWGynC1JCDY70IEGxNomc4eT9m+CzMlq5VBc3R03Fw9EBbaphTECF/Q9rsvPaZgBkViUlPl
X-Proofpoint-GUID: 1lJGg6s6yFKJO1SXeeNml8BjfX2TTmn8

On Tue, May 20, 2025 at 08:06:21PM +0800, Yafang Shao wrote:
> On Tue, May 20, 2025 at 5:49 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, May 20, 2025 at 11:43:11AM +0200, David Hildenbrand wrote:
> > > > Conclusion
> > > > ----------
> > > >
> > > > Introducing a new "bpf" mode for BPF-based per-task THP adjustments is the
> > > > most effective solution for our requirements. This approach represents a
> > > > small but meaningful step toward making THP truly usable—and manageable—in
> > > > production environments.
> > > A new "bpf" mode sounds way too special.
> > >
> > > We currently have:
> > >
> > > never -> never
> > > madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
> > > always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE
> > >
> > > Whatever new mode we add, it should honor PR_SET_THP_DISABLE +
> > > MADV_NOHUGEPAGE.
> > >
> > > So, if we want another way to enable things, it would live between "never"
> > > and "madvise".
> > >
> > > I'm wondering how we could make that generic: likely we want this new
> > > mechanism to *not* be triggerable by the process itself (madvise).
> > >
> > > I am not convinced bpf is the answer here ...
> >
> > Agreed.
> >
> > I am also very concerned with us inserting BPF bits here - are we not then
> > ensuring that we cannot in any way move towards a future where we
> > 'automagically' determine what to do?
> >
> > I don't know what is claimed about BPF, but it strikes me that we're
> > establishing a permanent uABI (uAPI?) if we do that and essentially
> > promising that THP will continue to operate in a fashion similar to how it
> > does now.
> >
> > While BPF is a wonderful technology, I thik we have to be very very careful
> > about inserting it in places that consist of -implementation details- that
> > we in mm already are planning to move away from.
> >
> > It's one thing adding BPF in the oomk (simple interface, unlikely to
> > change, doesn't really constrain us) or the scheduler (again the hooks are
> > by nature reasonably stable), it's quite another sticking it in the heart
> > of a part of mm that is undergoing _constant_ change, partly as evidenced
> > by the sheer number of series related to THP that are currently on-list.
> >
> > So while BPF may be the best solution for your needs _right now_, we need
> > be concerned with how things affect the kernel in the future.
> >
> > I think we really do have to tread very carefully here.
>
> I totally agree with you that the key point here is how to define the
> API. As I replied to David, I believe we have two fundamental
> principles to adjust the THP policies:
> 1. Selective Benefit: Some tasks benefit from THP, while others do not.
> 2. Conditional Safety: THP allocation is safe under certain conditions
> but not others.
>
> Therefore, I believe we can define these APIs based on the established
> principles - everything else constitutes implementation details, even
> if core MM internals need to change.

But if we're looking to make the concept of THP go away, we really need to
go further than this.

The second we have 'bpf program that figures out whether THP should be
used' we are permanently tied to the idea of THP on/off being a thing.

I mean any future stuff that makes THP more automagic will probably involve
having new modes for the legacy THP
/sys/kernel/mm/transparent_hugepage/enabled and
/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/enabled

But if people are super reliant on this stuff it's potentially really
limiting.

I think you said in another post here that you were toying with the notion
of exposing somehow the madvise() interface and having that be the 'stable
API' of sorts?

That definitely sounds more sensible than something that very explicitly
interacts with THP.

Of course we have Usama's series and my proposed series for extending
process_madvise() along those lines also.

>
> --
> Regards
> Yafang

