Return-Path: <bpf+bounces-66972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9556FB3B91A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84A31897181
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868F3093C8;
	Fri, 29 Aug 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZVudE1z3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGTXI2zA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3A1A0BD0;
	Fri, 29 Aug 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464194; cv=fail; b=PRu+Xb2/Vib2KR/Zl8hS3DCSObYqQ+9ICUWq1JoRBK3pePo2It7lK7VpgZzomXonPQPlyxNH/W0mQ0rydVN5h3SnttO20nlet/Iofy9+1mlX5MI/5DOpCCoErraVS9BfQ7gzkAiQ0f3DGSgemvTWjNk4WQ5txLufYEUvW5jvOSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464194; c=relaxed/simple;
	bh=3zbx357e4AiMGomSeeTXBu8qWuabVfmPtGvRWjdTfck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e1GiasEPCoeksaLIkvkPDH+vXDsw0dtVxD2IweiFMNOmAAuvJ+WLR8mRf/VGk3fWSEW3VlissJUJBtsqg4JfArl8g0sNMxyPY7s7rWZSbsGzpgs4pw29EcnpIhrcMP4tYHLxHDj5vIABaoUmheDaluDyr0WUwbl9mB6HdV6z5iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZVudE1z3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGTXI2zA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAY9lF007170;
	Fri, 29 Aug 2025 10:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DQzkI4Jmnry/acYuZZBlN6a0vPGk+cIVx94SxPxmhsg=; b=
	ZVudE1z3y8wvc1bl++PYsqo5njYG/mBHnvhIZ20odTUFCKEolVdKSAmXB+Jmp8wU
	qVGn7d3S6vL6LojidnZuVlNoukVGnGgHiB7m9PF+O5/HlkQBMZ5k2bGFSW/aTNvl
	eXHiHU0UN49uZTtUSRcgATpHRT2EHnBuhy+FBfJGekFf0pw8OKOKnsqim/IEhMLt
	K+ts5gY5uBiQMOXNCqnoZmaApU5+9jYq/pEzpfxefGqlJm2q/ZKbk8kMOt/vjthX
	uv5aKBoWyzWOvjo9xHuU69mHGPimO7NqE/SsacRLSSg9DwO37CoWvZcyyqn76+WY
	SAAua17UxdCbUFrO93bQnw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jat98q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:42:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAR2i2012368;
	Fri, 29 Aug 2025 10:42:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cyeyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmKG7ro+kMMpHLG/RQ09u8r+AeRWAPuvK0tL0avb/l/lVtxwNOsojkvOBvC1dzdo3pPqTz97TXMzdOzJbkuvbZJxugC8S3Ttw6VGgKoe03zwD7S1HaxaQ0dfcYSjZLYA+c/muAQY1GoxTSPH8H+q8FfVaZE7vM8TlCCLZksRbMdWJK6bed9L88rdg2qcnDBlBYsZI5YudlKgAzocViu3GF1ZWSFTXUX0VgkJsKn16bAojduhEW6LDLumOJgYDNyblz3/6cIkHiiKhRgiEJW/VqJY16iXk6rGJ3FKmbp0OU18QUSQsI6Rwbj8wRAHe91RIpwbjhYhTg+7KW8UzRflIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQzkI4Jmnry/acYuZZBlN6a0vPGk+cIVx94SxPxmhsg=;
 b=RR2J0Qw9r/zfv2j2ZCWkRQZ+J7wgz7yg2G9b/skWr1m6LdIFsRcjY9r7Lcs2/QGu5vDscnzbwQaUtWt6FzdtRRsNXdbzVwZISuBFjZpVLIutSvpt8yTZtZtWPVvXEEhbquZF7268GW1JnP8A0voApTJtaiHp+X1iB4gRWyRp9ArhLN/Hr9Ftse9px1VaTaudj0TfQa5fcNne+1e6H7sOeGY60DvAtAMvcRSo3f67ZXYQb0NVwZlse+z7urbF2XuI0ry5HamMgmkAqkN8Nlq9BdBPf01GO2PK+NMKlcj6H31ah2JhFkRejxQJ3KUAvaBc6IJI2+TeO+TZ5iXC4ldPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQzkI4Jmnry/acYuZZBlN6a0vPGk+cIVx94SxPxmhsg=;
 b=qGTXI2zACh9P15Jq3B8L6MwzDedVriobw3SLzv9j5HTr4ZRJzOWvKeEPEFuUkF7VfXFGfaI52UTputyBooVBW6GMdLjyY70tRF43m/dzScENK7ZkfDMvGZxzDvAQwEqpFAyw4Tv3+c0KfHRBCY2B/iHdnH856LH+7E9WuFaUSR0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 29 Aug
 2025 10:42:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 10:42:20 +0000
Date: Fri, 29 Aug 2025 11:42:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <95a32a87-5fa8-4919-8166-e9958d6d4e38@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-2-laoar.shao@gmail.com>
 <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
 <CALOAHbCd4vuZoot-Bt4y=4EMLB0UvX=5u8PjsW2Nz883sevT1g@mail.gmail.com>
 <80db932c-6d0d-43ef-9c80-386300cbeb64@lucifer.local>
 <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCQucvD968pgmMzv0dcg1j5cJ+Nxz4FKaiGXajXXBcs0Q@mail.gmail.com>
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6b3ef1-c3c9-4a9d-eab5-08dde6e8bb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWlwM2lBeE9rVW1HK1ppeHlhcG42aTIxY0xRc0F4bXV0NXNwUC9KYkFWZ3VO?=
 =?utf-8?B?SkVPRlVPcXpUdE91TWQzZHB0UlVYTjhEREJFckNUYVpwK0tkTC9EdXVzWGFK?=
 =?utf-8?B?aXlWcnVJYmZidFlGM3EwYTlMRXRUaUpzWmZBcGJmaXJFemJyZ0U3eUJNUVhp?=
 =?utf-8?B?M24vQ3ZZaFYrdjJvWVp1UlBVbHJGaDQwMGE5dHB6OUJjVjdqTWIxd3hzOXUx?=
 =?utf-8?B?S3prazczY2gzeDVhSTNFcXBtUjQvczNiMkdyL1BVVXFTQTRxQ21QSTJiZy9z?=
 =?utf-8?B?aFZWc3JmY3lPNWEwMkdnUmNXeUQ1N3NHMlM5Vk12b0pvU3hXNk81cWRqeFRE?=
 =?utf-8?B?TDZOSUNrZk5iK0lDSkh2UmlZdzZQNnM0SE1wUGFRVElWR2dHZ0JUQXpiNXRQ?=
 =?utf-8?B?RUM2Y0dZVmlBamkrMWVvek1RbHZRdFM3VHd3VDB0UHM4Qmg4ZjhOUFFycXdo?=
 =?utf-8?B?N2pVK09uSGY5QUZ4QTEvNldRRjNiWkFhNkhtazV4dkJHcHIzcGJqOGhHMkVI?=
 =?utf-8?B?VWRLam9UU240eVluVmNlZEg2WFpoSUU3cEN3S0MwSFNWRnExQmJtVGdJckgr?=
 =?utf-8?B?Z1JMeHRVVHhLRXBtZHluWGFjVEdkREszV2czSnowQmdqYmdnN0tkT0U5clFY?=
 =?utf-8?B?akVscEZuMnE5YldwUk9qbkVoUERoS1lxNFVxcGNlb3lYelhUM2VjR1NTOVRV?=
 =?utf-8?B?QXhxSThtMXNtbG5vaWs1VWpML3RMVHJDSEZjakdtQ2hUdHQrblBiYzN5UHBF?=
 =?utf-8?B?SVUxeEVOdGgwK1dsRTFtYUZvTThVbkQ5YkxnZnl5NE5GU0RPaGVZWE8vZVJS?=
 =?utf-8?B?Z2czUllmS1pFRHFEeUI3NmlzNFlyVXRwU2doQ0F2MVJHLzlIWnpSV3RvUTg4?=
 =?utf-8?B?Q29xamQ1aCt0S1drSElXNy94MlJrMTV6MXBtVnp5UGNILzVBb00wWHNhZnpV?=
 =?utf-8?B?NWhpTFBSV1pQdU83VmJiMmhPN3lNRXVuWjRMR1M4QWFxNmtRSDh6elBJQnQ2?=
 =?utf-8?B?VkxXaFVUditQNU5ySTJwdEJJUGhpSWJaNnQ2WnZEMUR6bU5aUTdCeXpXMHBE?=
 =?utf-8?B?SFpjNU5HNVIzbGhmc09QeDZUckJ3U3phVXd3Uk9RcmNKamgzZ0pMeTZQZWd6?=
 =?utf-8?B?SDB0Z01wUDBpL2tVMVdKdndtMyt5QXpjbnNHUy9LUUlUV0FiSFNqOFNVTGF4?=
 =?utf-8?B?amFpVGV4dDdJYlQvZURmUzFqU2xWdlgyUjdTMnJ1SFpCOEpIUDBCR2ZMdmxG?=
 =?utf-8?B?ZmZZNWJGMVlVQ3ovenRCRDVDY3N2VGdDZ0l5TE5lMUZ2b0kxbEZLb25hQzA5?=
 =?utf-8?B?OVR4Z2VabXBFV0hZUCtBU0swRzRmTnRuYXZtUzhPS0ltWGlFS3VYSUYwcEdt?=
 =?utf-8?B?MExvUnpRYXozMmVwdDl0MjJLajkwYTB3UHRoVDNtYXQwSHZGQlJNQXlOdmg4?=
 =?utf-8?B?TXpoUmxFYy9FTG1KVHhueWw5dVFLSXpsSDRHL2dxdFBwSG81R2wyYUp4UFFo?=
 =?utf-8?B?SGpSSEFyTEJNL3A3bWVZYURaT1RvWHBkclFRZ3B2YnZCd2tKMWpUTXRUZTJw?=
 =?utf-8?B?aGExRDc2QnRjU1g1eXZNT1N1SVUwZEdiV0ZoTjMzbWdYSmpDaVNSZ1ZxM0x1?=
 =?utf-8?B?bEFvSk55dmlwTnUxYUJFUlRKS0kwZEU3NHlZbXhybUxhL1BvM015MkJDSUVW?=
 =?utf-8?B?NTNNT3F2dW8vNzRKRVh6dFNxSTg3VFVEeGttVzhnTTk2Z0RqSjJhN0c1bE90?=
 =?utf-8?B?blY4OHhYZ3BRME91NTNGSTc5S0gvWkFnSmlHUno0NkNTWnRvVFJjMlZrYnEz?=
 =?utf-8?B?WGFFZmkzczMreGI4emxLMUlhMERTN3NKdE9HcGVPK0ZqTXg1TVpXL2JjQ28w?=
 =?utf-8?B?Ky92MThRSnZyNkhrL3MzYlB6YmZ1cEtySjJldDM4cElJdzRCWEtmZm12L1Vj?=
 =?utf-8?Q?Z4Qawj1Okwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnRGb0pPZzQ3WGdJakxjNmYyQ1dPMStvZGVuWTVQMVFzRmo1aVZXU0J3b0Uv?=
 =?utf-8?B?Qk1EQVl5NFRoWXh1akVJSFM3b0RxSDUreGlVWFhKUk9TY25HdmJqV2hFMmJZ?=
 =?utf-8?B?cDlVWDNvdzNwbzh2OHV5UXlvTnA5d2tEV3Znb0Z4bFZxQlp4dGtQcXZTc0lv?=
 =?utf-8?B?YW1IbHJZM1hLNGNVb2wyNmJ4SzJBOVA0Q1RJTUtLRFMwVEVMc0dJakk4dXl2?=
 =?utf-8?B?TWdYdkU4c2lvT0drZk5ZOWVpNVZaVFpPU2dIWUpwdnN5YWRkYzJhTTBTWSto?=
 =?utf-8?B?OCtwY1NEVDhCaE5ScGpQSU5NbFB6OXNwdDd5VEFGY3laYnNRTlR5cTUwZEpV?=
 =?utf-8?B?STBNVDhyUyszRXB3RU5sUkZNTWRtb1N5S0h2UldHVWdHMXJld1puK05Gc2Iz?=
 =?utf-8?B?ZXJ5cS9kbHY0WDVHV0JTYUtYTks1K2s3S0tqTUtMVVRybHdrRXB4eGdNcFQ2?=
 =?utf-8?B?REk1dEwyMWdMN1I3N1FUaDRWNWM2YUtyMWJHckQ2cDRxak5POVl1c0hPd05D?=
 =?utf-8?B?VDMzNGFQUjVOS0VPNjVwdjB0a01nMjE0SUJsUTJkVktNcVBGcTZoRk9POHRx?=
 =?utf-8?B?VDZzQ2M5SEdyM2UrajYxRnFualpob0R6QW5iOUpVNkNxVTdyQ1d3SkZ3b1R1?=
 =?utf-8?B?R29wU01zeTRvNjlYRS9NYWkrZnNSaU1CY2dxWC81N2M5SzhKdGtsL1lRWUpJ?=
 =?utf-8?B?U3BvWjh2UnFTQXhEaU9oUGgzZitJMUZzWjR5RFlHbS9BVHF5aEpIaXV2Y2VH?=
 =?utf-8?B?TndUVGxTdXlCTkZDVC8xN0o5YXV2TmZmQVpSZXdhUWllNUlSUzNCRlVaL2Nx?=
 =?utf-8?B?WFJHSFNMend6aEtKNEttREJGd3lBTXpOOHhDUjFweWE2aGt5dDVEUHJMc0lU?=
 =?utf-8?B?N0pqV29saFZTVDA0a2JXNHJaby9ObjJqZGdEemdRNFU0eUpDcXNQeEVBcEsz?=
 =?utf-8?B?QmpDYnVackVlRk5jcGFKMXQ2TXF1TzBQOFFrWjhWZkNjdkp3bGVSVWUzaUhR?=
 =?utf-8?B?Sm9zemZzN0p5ck5PMStON0NLNUsrZm9wZ0VwRmJwYmI0VUJ1cUlQTEFBWWdQ?=
 =?utf-8?B?eUllbGZidkdaRVpRQlI2ODNNNkFHTlNFVkk5ZFpRVWdWN3hCUGQ4U3ptRVhz?=
 =?utf-8?B?Y2VQdHkzaGw1MVJocmdYTlRySVNsMFJMVlQ0S3JtZ001Zno5Unl0L0FrVjRl?=
 =?utf-8?B?RjUxRUhUVHBCUTVpdTRMRllvc3BETzhTWURFbWpEU1JSRG4ybS9Ca3R5Wnov?=
 =?utf-8?B?amxPc3ZWQmxqZm5adWlvVUJqQTFodG92Y0NMUmduV2U2WWhJWXlDeWQrckxV?=
 =?utf-8?B?UTJ3anpnNUppNStVWDJyMS9QUWo3dFR5NmxHZ1VNVnJieWsxMHRJQUpnY2ZQ?=
 =?utf-8?B?S29aRTNBZWt0QnpVS3JFNklLbmZPcW5ZRUFLVGpTMzVweGEzYTJmK2l5SU1R?=
 =?utf-8?B?TmNpQkVRV3pPVFZxOHREZDlzUlpGUitCY0U0K2xYdDYwdkR0WWJhb2lDR3pN?=
 =?utf-8?B?Z1lRSVA3eVhsWjdUblpUcldxdld2aHo5S3pXUTdXTUFFNnc3cVBHd3NsaDlu?=
 =?utf-8?B?R2RiQ1Z6eU1HWHh5RlZabXBZWDZLVjhBWEVRc2RWRmRsWmMzVmRVZTl4M1dF?=
 =?utf-8?B?aTBYNEh5cmRZVXdQejd3d29GNWp6VTU3ckJ5eCtSbldNcnRLTUJBc01ZVitT?=
 =?utf-8?B?RXEraFB0Y09vMUZjUEcvMGYxZFVVRHlMYjkrMTdUVXN1NTFFODE2bTdOMmZN?=
 =?utf-8?B?MXFWaEh1aHIyaTRxMExoYndFMkVaK3lmeHVia3NxaWJNTVkzcWV2L3kwRzJG?=
 =?utf-8?B?SEhNN0p2NzJwT1d2b3o1eDJ3UEtQNlZVelJVU0xiSmFhTEpKcjFsZVl4NkNR?=
 =?utf-8?B?Wm93VDBYbFExaWVjRHFlMjVRZC80blowRVlybjBKWGtwNDd4TTA2T0lxZjhz?=
 =?utf-8?B?eC9OV1lWa2xHZmZHQ3B3dnJMMitLZ0lDa29GVFhROFdtWW1ramxYdDZPL21P?=
 =?utf-8?B?N1cyMnJnaUJSVVhQYzU3ZTczOFdWSmN1aDc1VWpEWVd2NC96YmwzZ3I1NVRy?=
 =?utf-8?B?YnlRSURYcGJYM1VVVGZRQXVqSzZiQ3JENm1ldTM5YmtocjBpUDMySzk1R0Z2?=
 =?utf-8?B?bEdQUjU4TmovS2VUVDlzS2VMVjc3azN5bDNHUDNRT0VhQXJkNzhrZ0M4YVAy?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NbyjBaS8Ifzmpdiu5QfPrwsvMLnBd7Q6TwwXpQwb4utoTsfrKNhUCzms8N1cWAl0C1rvutmv/yLkOqzJ7OghsMv/MIs+zN5jDcx2patBUOnC6Mc+CG3QdfAReOx+UwLREM7hMlI5YwA2uYM4obB20BnHwODhuTpcPEBmQCA8aiEIjyook0a12Z06KMUkgeVvAusZYGvJ0keYh2HGP2MrOrxzQSDJhELBm1yV6k5nW96kZD0Z35MS4XlWK/MTLrA7/KkeE9Uh/rINSZxaqH8NKMMNMRT+EuFFogHUe0Aul0boQ60HV1/PsEKAWcF1rOsnr+41csFMmTHNSLf6Vsxca54DXjRgP3vLrY1WT4aBQM7OW5waldPWuoQXzBwApCR9Wroc5ZzsU3bK2QiGig7a9y892JBn1ZYZXCIhD7tHy7/1nE32LRMVIz/Ybe+TELbkFVZdBm1B/0bjt9Mt6P8xnz75Q9zq8WE6R0/SmjtYJHGvY6KvA3fX48mdvn8bEL8OiKOiEeR8qvZy7Vhf72HieJqIDCMub7/RA1h3gjBoeOh8cIoIP6S9yIAMV77+6QxAXpF8xb/otpCWdxGK67WaRXz9cyy/ra8UP9JNG+V039Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6b3ef1-c3c9-4a9d-eab5-08dde6e8bb36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:42:20.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeEcCy1u4Ml/ukjluMBb0B+g3PSei1g636rRjme6GqZZkNzoI1N64dHjb0BghGwhuuhEQfhteqhp5uE+fK5ejX/UaMtzex18iOcBfaKAMms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX69Jmd0c1h/E9
 PHtKCBz6VJVu3nYlio+SFYQ/Xbm8oMvHwsPrT6yFz0RgJOYJ/DWB9f4c4exViO05XuW1Uwkw5ti
 V2i+Njl7ZWxDyfKBkfV3r4oxQag+5boVjKNRF8bOVbeRlyCg10FUe2JVqn8IQ4PKbsQ5LevpSFt
 ytG2EPcD5shNE9VxH0tRtOJXtKHpyNNMrAPepduNqOZ79DQkNP4PpkU+9hftaE6iYe1xu3NPFkP
 0OppDrDIWdD8d6IFdeUPFzDpBBF2An/eerFHo49gNw/zHGFB99Qn01VpXJjqOgP7R5Sa75sj6gc
 sVyPSZnpfZs3K2X5D2jrf+lUPMzrMw2lv9/2jrQnKiQ+IdUmp8CnCvHEiFI3MyerXcxrI4q5LL+
 RsPo11b2JLcJTtnbYCsaMzTIi11O1w==
X-Proofpoint-GUID: 7DYcHglMg085v_dscmCNB1qMvuBr93Id
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b18414 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-yoThcwpaxpob6YaepcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: 7DYcHglMg085v_dscmCNB1qMvuBr93Id

On Fri, Aug 29, 2025 at 11:01:59AM +0800, Yafang Shao wrote:
> On Thu, Aug 28, 2025 at 6:50 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Aug 28, 2025 at 01:54:39PM +0800, Yafang Shao wrote:
> > > > Also will mm ever != vma->vm_mm?
> > >
> > > No it can't. It can be guaranteed by the caller.
> >
> > In this case we don't need to pass mm separately then right?
>
> Right, we need to pass either @mm or @vma. However, there are cases
> where vma information is not available at certain call sites, such as
> in khugepaged. In those cases, we need to pass @mm instead.

Yeah... this is weird to me though, are you checking in _general_ what
khugepaged should use, or otherwise surely it's per-VMA?

Otherwise this bpf hook seems ill-suited for that, and we should have a
separate one for khugepaged surely?

I also hate that we're passing mm _just because of this one edge case_,
otherwise always passing vma->vm_mm, it's a confusing interface.

>
> >
> > >
> > > >
> > > > Are we hacking this for the sake of overloading what this does?
> > >
> > > The @vma is actually unneeded. I will remove it.
> >
> > Ah OK.
> >
> > I am still a little concerned about passing around a value reference to the VMA
> > flags though, esp as this type can + will change in future (not sure what that
> > means for BPF).
> >
> > We may go to e.g. a 128 bit bitmap there etc.
>
> As mentioned in another thread, we only need to determine whether the
> flag is VM_HUGEPAGE or VM_NOHUGEPAGE, so it can be simplified.

OK cool thanks. Maybe missed.

>
> >
> >
> > >
> > > >
> > > > Also if we're returning a bitmask of orders which you seem to be (not sure I
> > > > like that tbh - I feel like we shoudl simply provide one order but open for
> > > > disucssion) - shouldn't it return an unsigned long?
> > >
> > > We are indifferent to whether a single order or a bitmask is returned,
> > > as we only use order-0 and order-9. We have no use cases for
> > > middle-order pages, though this feature might be useful for other
> > > architectures or for some special use cases.
> >
> > Well surely we want to potentially specify a mTHP under certain circumstances
> > no?
>
> Perhaps there are use cases, but I haven’t found any use cases for
> this in our production environment. On the other hand, I can clearly
> see a risk that it could lead to more costly high-order allocations.

So why are we returning a bitmap then? Seems like we should just return a
single order in this case... I think you say below that you are open to
this?

>
> >
> > In any case I feel it's worth making any bitfield a system word size.

Also :>)

If we do move to returning a single order, should be unsigned int.

> >
> > >
> > > >
> > > > > +#else
> > > > > +static inline int
> > > > > +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> > > > > +                 u64 vma_flags, enum tva_type tva_flags, int orders)
> > > > > +{
> > > > > +     return orders;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >  static inline int highest_order(unsigned long orders)
> > > > >  {
> > > > >       return fls_long(orders) - 1;
> > > > > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > > > > index eb1946a70cff..d81c1228a21f 100644
> > > > > --- a/include/linux/khugepaged.h
> > > > > +++ b/include/linux/khugepaged.h
> > > > > @@ -4,6 +4,8 @@
> > > > >
> > > > >  #include <linux/mm.h>
> > > > >
> > > > > +#include <linux/huge_mm.h>
> > > > > +
> > > >
> > > > Hm this is iffy too, There's probably a reason we didn't include this before,
> > > > the headers can be so so fragile. Let's be cautious...
> > >
> > > I will check.
> >
> > Thanks!
> >
> > >
> > > >
> > > > >  extern unsigned int khugepaged_max_ptes_none __read_mostly;
> > > > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > >  extern struct attribute_group khugepaged_attr_group;
> > > > > @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > > > >
> > > > >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> > > > >  {
> > > > > -     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > > > > +     /*
> > > > > +      * THP allocation policy can be dynamically modified via BPF. Even if a
> > > > > +      * task was allowed to allocate THPs, BPF can decide whether its forked
> > > > > +      * child can allocate THPs.
> > > > > +      *
> > > > > +      * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> > > > > +      */
> > > > > +     if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> > > > > +             get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> > > >
> > > > Hmmm so there seems to be some kind of additional functionality you're providing
> > > > here kinda quietly, which is to allow the exact same interface to determine
> > > > whether we kick off khugepaged or not.
> > > >
> > > > Don't love that, I think we should be hugely specific about that.
> > > >
> > > > This bpf interface should literally be 'ok we're deciding what order we
> > > > want'. It feels like a bit of a gross overloading?
> > >
> > > This makes sense. I have no objection to reverting to returning a single order.
> >
> > OK but key point here is - we're now determining if a forked child can _not_
> > allocate THPs using this function.
> >
> > To me this should be a separate function rather than some _weird_ usage of this
> > same function.
>
> Perhaps a separate function is better.

Thanks!

>
> >
> > And generally at this point I think we should just drop this bit of code
> > honestly.
>
> MMF_VM_HUGEPAGE is set when the THP mode is "always" or "madvise". If
> it’s set, any forked child processes will inherit this flag. It is
> only cleared when the mm_struct is destroyed (please correct me if I’m
> wrong).

__mmput()
-> khugepaged_exit()
-> (if MMF_VM_HUGEPAGE set) __khugepaged_exit()
-> Clear flag once mm fully done with (afaict), dropping associated mm refcount.

^--- this does seem to be accurate indeed.

>
> However, when you switch the THP mode to "never", tasks that still
> have MMF_VM_HUGEPAGE remain on the khugepaged scan list. This isn’t an
> issue under the current global mode because khugepaged doesn’t run
> when THP is set to "never".
>
> The problem arises when we move from a global mode to a per-task mode.
> In that case, khugepaged may end up doing unnecessary work. For
> example, if the THP mode is "always", but some tasks are not allowed
> to allocate THP while still having MMF_VM_HUGEPAGE set, khugepaged
> will continue scanning them unnecessarily.

But this can change right?

I really don't like the idea _at all_ of overriding this hook to do things
other than what it says it does.

It's 'set which order to use' except when it's this case then it's 'will we
do any work'.

This should be a separate callback or we should drop this and live with the
possible additional work.

>
> To avoid this, we should prevent setting this flag for child processes
> if they are not allowed to allocate THP in the first place. This way,
> khugepaged won’t waste cycles scanning them. While an alternative
> approach would be to set the flag at fork and later clear it for
> khugepaged, it’s clearly more efficient to avoid setting it from the
> start.

We also obviously should have a comment with all this context here.


> >
> > >
> > > >
> > > > > +     if (highest_order(suggested_orders) > highest_order(orders))
> > > > > +             suggested_orders = orders;
> > > >
> > > > Hmmm so the semantics are - whichever is the highest order wins?
> > >
> > > The maximum requested order is determined by the callsite. For example:
> > > - PMD-mapped THP uses PMD_ORDER
> > > - mTHP uses (PMD_ORDER - 1)
> > >
> > > We must respect this upper bound to avoid undefined behavior. So the
> > > highest suggested order can't exceed the highest requested order.
> >
> > OK, please document this in a comment here.
>
> will doc it.

Thanks!

>
> >
> > >
> > > >
> > > > I thought the idea was we'd hand control over to bpf if provided in effect?
> > > >
> > > > Definitely worth going over these semantics in the cover letter (and do forgive
> > > > me if you have and I've missed! :)
> > >
> > > It has already in the cover letter:
> > >
> > >  * Return: Bitmask of suggested THP orders for allocation. The highest
> > >  *         suggested order will not exceed the highest requested order
> > >  *         in @orders.
> >
> > OK cool thanks, a comment here would be useful also.
>
> will add it.

Thanks!

> > > >
> > > > > +
> > > > > +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> > > > > +     .verifier_ops = &thp_bpf_verifier_ops,
> > > > > +     .init = bpf_thp_init,
> > > > > +     .init_member = bpf_thp_init_member,
> > > > > +     .reg = bpf_thp_reg,
> > > > > +     .unreg = bpf_thp_unreg,
> > > > > +     .update = bpf_thp_update,
> > > > > +     .validate = bpf_thp_validate,
> > > > > +     .cfi_stubs = &__bpf_thp_ops,
> > > > > +     .owner = THIS_MODULE,
> > > > > +     .name = "bpf_thp_ops",
> > > > > +};
> > > > > +
> > > > > +static int __init bpf_thp_ops_init(void)
> > > > > +{
> > > > > +     int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> > > > > +
> > > > > +     if (err)
> > > > > +             pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> > > > > +     return err;
> > > > > +}
> > > > > +late_initcall(bpf_thp_ops_init);
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index d89992b65acc..bd8f8f34ab3c 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> > > > >               return ret;
> > > > >       khugepaged_enter_vma(vma, vma->vm_flags);
> > > > >
> > > > > +     /*
> > > > > +      * This check must occur after khugepaged_enter_vma() because:
> > > > > +      * 1. We may permit THP allocation via khugepaged
> > > > > +      * 2. While simultaneously disallowing THP allocation
> > > > > +      *    during page fault handling
> > > > > +      */
> > > > > +     if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_PAGEFAULT, BIT(PMD_ORDER)) !=
> > > > > +                             BIT(PMD_ORDER))
> > > >
> > > > Hmmm so you return a bitmask of orders, but then you only allow this fault if
> > > > the only order provided is PMD order? That seems strange. Can you explain?
> > >
> > > This is in the do_huge_pmd_anonymous_page() that can only accept a PMD
> > > order, otherwise it might result in unexpected behavior.
> >
> > OK please document this in the comment.
>
> will doc it.

Thanks!

>
>
> --
> Regards
> Yafang

Cheers, Lorenzo

