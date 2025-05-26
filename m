Return-Path: <bpf+bounces-58941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C33AC41E3
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FFA7A8146
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247320F098;
	Mon, 26 May 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9tV5bvW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pDaqCWtE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11120CCE3
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271299; cv=fail; b=CGTgKUumb+bAdGnmvPDcF6CyOgkCnU9//tG4vd3pm4vME6d9kRhGVtZn7eIy1H9IyqvxUUmsalbAD3ZX2Rbbr5XXdfU/GgY6pV1dYpiVLTklpX86OT890aGRjN5ulrcvVDYgJlBiB8sYIuMZiVVuNfg1WKuo5KeO6QTa11NU6XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271299; c=relaxed/simple;
	bh=W2VT+ytOeGh5ZiccMzblT25j1YfNHxx480zZpOuEIdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ap1HekFii7nFmzp2gq29Qc6BMkAGakzQ+JPakW/8wIO2tNgz5mUrweyT4/nmmlvlfV+JqM69XvYCqoWkdiIDxHTtFTPi/Ok9V2+egxlPV17grPxMaiQ7ir08a0hBWCHOQB9xf9s1xZLRavmOqmDJPqMQg16n/RPUrmqD9CZpNAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L9tV5bvW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pDaqCWtE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8tvsf025810;
	Mon, 26 May 2025 14:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hSlcwY2ja9kT+Ke+c7H0IiHnt+TBgEDSBjIzI0OLgUU=; b=
	L9tV5bvWMErYkvnif5B8V6Qv7O1WGZ4nZSyljCSwsxPsf4HoDkLhoQi8LAbQtUoS
	h3VZnmNUjlxyQSNmEGm8YZkSZfCFEVZybtV3H+hMIGBcjIGNW0yp7U9eLO4bfM/a
	jBdxgXJXVHVe/NhEVinDpg2Gq0rUQgQAK38ULa7WROtTQ3XCgYGFQofatYvyBnUm
	yo58cib0e+0IDvG10Zn+T5XA5v+Vpjw+R9alCHiB/shojE6e6AojVCRPDNOU1pIS
	Hk9lL/OwqpL+5LocR9jI/kn6uzPTR8UZjJevGEsPtNSgwWqKIvTBrgxCQY7QRgT6
	Qd2TwBqQoHaXbgXH8gxFQQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pesgcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:54:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDpajX028440;
	Mon, 26 May 2025 14:54:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7wdn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXxNW6RtNHaUetDmqstX6UBD3AAMjtWLeBQW6CSepN3b6xeHabW9Q+MPQe9T/Vy0H4+uGKS1aAtkHSHPgciWTURflXasKSSixi3NUs+9urddMZYCN+2G+7lC8Cc9JPwWOBkMddA93GwR6oLbDW3oy7DXk4BNyiBEaOY4cNbI7ACBcVJYEX60WYaT7aZ3vNNyDbOaz7Nb9Vv2ZQiaMFhMKUQSCk/eMtcabkJKE3YwLm3CeBaVyuVMhEqmUv6NyzJD7HHk6d6DdGWQkEfIFv2m7G6i4U0urbH3MHAyH0TA5AbtvhS0NK2M25vpKzTwM6y8bOqRo3Ev4dUzRFzkbumHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSlcwY2ja9kT+Ke+c7H0IiHnt+TBgEDSBjIzI0OLgUU=;
 b=SRruCr1RHoWF00Jyrf7/NgCeLXw0uwFDiFFGWbTh+facGM3GL5/KAkFtZYluUNlpHgDXzgOfPbq+xzkKEVC3DUYCGPX+Cma36XIna4zyoZYc/FiPfFh5suIyQJSG3GTKtzeaGkwiBJf49wg8dKo7JGtgPnKHJh7k4DMEIVV8XloV7fur2kw4fqsPS2uoNehZog2rdtKq3vFj9PAUga+8nht7db1B9G+oQO++dL7cy+aRv67Z/YNkVNDcVzvZ+ROOUSh2hViiI3y28Q+30LpA9RhNWli/jrjeONo5lRF472/w6sAAWC98Sap7gkZEnptdmydf1+BHceBTnu78fERwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSlcwY2ja9kT+Ke+c7H0IiHnt+TBgEDSBjIzI0OLgUU=;
 b=pDaqCWtEegIxq+GkC3morqnAa5HW8HJDKSjkykRz6xO1sd4fIZolXkAHQxytI21voeLY+V3z+TyW1ft9vvh6PStGD7tABzXaNZdD3anq1YeHb7THgGQIn3JbxfgZy3GyildeJ7DEuN6Bc6nUfzoMLYtXxObKejxjEF5Gcmjg3UM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 26 May
 2025 14:54:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 14:54:03 +0000
Date: Mon, 26 May 2025 10:53:59 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, willy@infradead.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR0101CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e3667b-3a1b-4165-76ce-08dd9c652816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFBmYWtLODM2ZGVvV2h2ZGVnakRJTm1UVVhxN0MzVzZJTWNVWXB6aFp5MWx5?=
 =?utf-8?B?TGVjcXBCZVVlTmdsdEdITitVNU5hMTZsYkwzWWplS1dnRDhWN2dJUTdDZFhL?=
 =?utf-8?B?N3dJOU5JRzdya2tubXBXUDlBWTJzcVhIUElCNkNQcEdMeVdmNlY1dXpMNnlC?=
 =?utf-8?B?ZzdOL21YOFVVbHlZTmhHdlNKT3Z5dW1CS1MwU2svOS9aUzByeTg0YkdBOEEr?=
 =?utf-8?B?Z2M4TjhWMCt1NnhBUDhWQ1FFWFFNcldQWGhvSlh4Mjd4MEdCelcyQlZkK0k5?=
 =?utf-8?B?S2tsUFQ1V3NKUk1FWlFuc2RhWUs5WXRVL2lDR3MvMklINjNjZStTQ0p6bVRD?=
 =?utf-8?B?a2NpelVrc2xUQXhOTkJDTUR1bWFmb2xmYWo5eUx0R2c1ZkN2TFR2THpnbkZB?=
 =?utf-8?B?dUVJYisrQTJZSEoyVnM4aWpBcTNKZis1SkNnRVAwZ3BrRG9IRmpDYkNUWFB1?=
 =?utf-8?B?cXF6cFMzUUhzZHVmODJMQlhFWm9ETlUvb3dBS1ZpWm43d3ovRVp6ZFl1cnEr?=
 =?utf-8?B?Y2tQSUpjSkRzWVVTQXNkQnRtRS9WdUkzUXN6MDNZRFdQTHpwakN0VlM2b3pn?=
 =?utf-8?B?aHdsaEllRUVhZ1ljVVhxMDFUR01PRVdrR09VR0xpcllqdzVYRmw1MlF0WkRa?=
 =?utf-8?B?V3FpblBYRGJsUVo0RWVnb3B6dlQvYi9ERlU3UXhoQVZOc1ZjMG1McFRzMGl5?=
 =?utf-8?B?SENqRVhtQkdxWm1wYmRpVmI3TWI5aDhHUmVvKzBGNkxMVUsveFpmODdsay92?=
 =?utf-8?B?M296NHkvc0gzYS80S1ZpZWczZG9FektEdTNiRUdBNW1ONngwbkZwMTBFQ1gx?=
 =?utf-8?B?cUxpaytoUTlLbXRZV01PMTNUVGFjeG5ZQjZySmRrQ2ZxZ2sxVkY2R2YrY05w?=
 =?utf-8?B?UW1VM2RSaHo0Tm1NMmdhV3NhZE5UNkVINzZnOWJKRHh3N1hkelVBeFpuYWVG?=
 =?utf-8?B?Y2hYeVpjL0d3cW84WUxHWnhIaExIaHV1U21qS08yMW9Cb2c1S3R1clduMGky?=
 =?utf-8?B?Y25TcGtqVnpxNzJMU3l3VkFpZXAyOFZtU3BLSUJpSkdpSnliNGFTUGozZGho?=
 =?utf-8?B?OXhCMEFZVTEyZXpCM2RLSmIvTWU1TWtFSkJzWkRZRFNYZGFmU3NKYU5lMkJJ?=
 =?utf-8?B?QUtyUXlOOUFEcHAyb3JlcW80RjBSVGJnRTJyYjIyZ3ZVbVpVbEpoTjhUQThv?=
 =?utf-8?B?YmVIdE5BaU80SjBNMXlXZDAzb0k4ZGRCcnp0ZFlsTndLaVpSQ1lsWktGRnBq?=
 =?utf-8?B?a1VMbHhHNWpVNFY0NjEwWnpNN2VaTkpnUVEvSTdsaUhjTVlrZkt0ZlArMlFV?=
 =?utf-8?B?VFE5bjY1Y0hFbU1iKy9UMzFzT3c2c1lJaVozQVVTMzNCQzZYUHFwdEZzWGNi?=
 =?utf-8?B?SjNTYWdvVVlQaW5XL09UTi9rSVNHUjFZZjd3WnZmSTRnb2t5bWxTQTIwRWdZ?=
 =?utf-8?B?SW40cEhvbGZ0a3JyejJicHEzTzdmazZIayt5emxkRVlvOC9OSkJEd1Ezc01C?=
 =?utf-8?B?VGNDTTFOU3FDeGtnMjhBdWoybkYrdDVTa041bno5N0FleERGMVV0VXRKV0x2?=
 =?utf-8?B?T0Z5VStsK3NBL2ZyUWxaYmR4dzU4d2pGSWpXOC9HR1dtZStLdThOQmtFeHBo?=
 =?utf-8?B?U3QybTFCMmwxcXNvaFA2V2tTQ3FGdTUyd0NSQ29KUFdqNGIvdkNrdXFIa0U2?=
 =?utf-8?B?V0JKZ3RJOXlIMFZMdGtUeGlRSSt1Q3VBWEJ5STYwL01TNk90VEphQ0Nwcjl2?=
 =?utf-8?B?Ykl5ekR5aGF0K3J6ZmtHVXg5Y0dhZWlaNVo5UXN0WkhwK1IwVTU1MDVORzdt?=
 =?utf-8?B?aFZSQnBnWi9HdkRoSlYyUWJuRjRMa29ERkZMZnZpUWRZZnBiWG1OU0N5Z05J?=
 =?utf-8?B?UFQzSWlnNkREeHJ4NWhKWUZWWmxybXc1Q2xsQjBSYzhpMUxaeUxSZWM1RERX?=
 =?utf-8?B?T2hvQmZHSFl6N0QvYy9MRElUTi9tSVJBMmg0Vk9WcGFBNVU0YVJKcExISXJi?=
 =?utf-8?B?YjJnV1p3YnVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZsWUlaTDRMSVduYWNFWUZJNlVuaGM1dTRSNzg1bVd6TEUzNG1SUDFuUzl6?=
 =?utf-8?B?OWZhbzd1RnNGQWdUWTI4dDdERzd4RFlIc3VabkltRnVWVWZ0d0FJY1liZmM1?=
 =?utf-8?B?UEljZ1NiN1hnMW9aem5rM3FEYjBvK29weDU4N3lXMUtsdTlickQvR2J4Y0pO?=
 =?utf-8?B?U3NlZ3UyNzZreVFpNVdhZ1cybzl2ejJwM2RlYVlWb1piMWV0akhJVVgra1V1?=
 =?utf-8?B?OGwvVm1wSGRuNFZkZFN2Z3Y3U3Z3bjI0ekhKaXlvcUt5OG1VRlR2SjFXY3Vw?=
 =?utf-8?B?bjUwK3FVZ1VOZWNDcDRoYjEwWTdSMUlRWEpKOVViNVI0L1hhOEM5SzJHQnZS?=
 =?utf-8?B?TXgzc29lSFZScUdML2FDMkpKTVZ1b2JUcFBkK2hhdHFYSmRab09DRlR2NTNQ?=
 =?utf-8?B?eGpZUjdkcWU3Z0dYUVlzWEN3US96dmJ1R3RvQlVIUnVHcmpVZUVRdVR0Rk15?=
 =?utf-8?B?eEdpUnlkalhIdXNyVXdwVndNTDJuR3Yrcml4bkFlNEkwbWlhTEZIOERjNlF2?=
 =?utf-8?B?M0JPT0NkbERuVS9UQXN2aXlRVHpRTXFqTmZzbS81dkcwY0xQT1Rsa1RJNWtj?=
 =?utf-8?B?WG5kRzZaODVKaWFxNkUrK3FVVk1yUjY1RVNXY0JTT1lzS1JwK1VQUGNQSUVs?=
 =?utf-8?B?YVBrdDVzMzZ1MlVwUG1NY3dzY01nbWNOZzZ4cW9sT3FtNVVjVW9SSVp1Z3h1?=
 =?utf-8?B?TzRhYmxaNHFuR09JTGUrT3BMQzNLNnAzZElFWWNEekZUYjZuZWMwMUlwd2o4?=
 =?utf-8?B?UTUwb3FjS3dHREg0b2Q3UGo0NkhMeWdvVmtKdmpBYWpyZ1RSSHpoZTI0d1Mz?=
 =?utf-8?B?NGJYRXNCc1JvWDF0R3F3SlIvbHZhbHFVaWRpSTl5YjhOaXNMZzJiSDY1T3Ix?=
 =?utf-8?B?MXd0UWhKOGVRbk0yc3Y2bkJydkhiTHM3dHZaNGl2V2MvSGtMSDk1b0ZKMEV3?=
 =?utf-8?B?QWRFcktrbTJZQmphL0w0OXI2Ri9MaG9kUytqUGd4L05VYllEdG51WHVhQ0JP?=
 =?utf-8?B?ZnFYUi9hWGtEcjYxOHpRRjNZcVZuWFBzUWFtZ2NhcjVWUTAzRnYycWFyQjQ0?=
 =?utf-8?B?dFBmL1dCd0RrRSsvd0NzL29vcVNLYlBWelJmZ2ZvTmpJRXNjZzloQ0JkeTdx?=
 =?utf-8?B?ZGRJelZqTmwxS3ZJMCt1Q1JtbG5yWm9MSG9UMTQ4UVpmbWJVNG0wNDFnTmxu?=
 =?utf-8?B?UUNReG0vNmQyNEpHN1ZRclR1NkUxcE1BZlZ3V0xnemZQSEk3USttb21EZGhm?=
 =?utf-8?B?K3J2QWFuRFJrZjlKSzZNRnh4a2R2eXQ0SzJxYzc1UEF0N1YvOWwyQkpkRURG?=
 =?utf-8?B?SnNCM0IxM0VIYURCYmtvSXI5ZnU4Tm04Z3p6QXZtOWFFTXc0elB3MGF5dkZL?=
 =?utf-8?B?SXJPTi9YdGhaQzFqKzdwVEkwa3c5c2VZTEFBNUZBVGRIamlYNHhyYTBlUHY1?=
 =?utf-8?B?VXlJN3V2bzByY1RjYmg5L0M4R1RyODhkb1RnVHRIb2p1bFZtWDhDM0cybWc3?=
 =?utf-8?B?Unp4Y2xOZ2tMN25qRk9pMEZmRXNhTGhyZUIzdzNIY0o3LzZybXFIWGYxTXFo?=
 =?utf-8?B?OCtXR0tYVmQvS2FoQml3RWNPSDNTRFFocWhZR2tNMXJtZnJqL0VnMTBBN1JP?=
 =?utf-8?B?VWN0aWRNOWMrUG1oVnVoQ0k1UEtJSVlkN0IzNzMwUmVXblB4YmRXSjYvWVFK?=
 =?utf-8?B?NzRwNVQrY0ZqT24wOGlTQXcxbmV1VnlwUDlhU2ZYYnpkbjlabkVjdnBxTU9O?=
 =?utf-8?B?eDVTaDNtKzM1ZktPZTBNQjBBN3c3RHhLUS95UWtMb0JFTUlJTVk1S0d2cFpv?=
 =?utf-8?B?RWZZNjAxUitsM2hGdERzV2ZmallFM3NBblZpWGpDTnFJaVRKd1lYVGJqWkgx?=
 =?utf-8?B?RkNxVHlhN0xNY3FQZG90Nmw0Q3RiQUNOK1RWVENVTFJQaGNBWDhobnlLMkMw?=
 =?utf-8?B?Nkxja2lDUFcrY3VVS1BqdHRyZjdEbEE5ck1JMzJIa2JCSzA4N2ZQVDdjNkt5?=
 =?utf-8?B?NmU0VDk0VEU5eVhGRnBiaVZFeUpWUXJKRFZFVENlV3lDSEVYcFQzVkJWVytU?=
 =?utf-8?B?QS9yQzB0emtTc2s4ZTQyek9IbmpzRkdhbUdtazk3VmNwRmsxUzJZSVNERy9w?=
 =?utf-8?Q?3gWzihMuGNUHdnKATKI6WRcDr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IwRJwZHCyAatDaWdLGGi01/q6jKWJYtdkvH1c5fxpxYoFvCqWk0BhLY/mUkebh5z95WogAhly6vFyk5LxL/2J9ZXIh7OoGuTCDbu/Ks8Js4GQNunAY4W6f0/ZOlvRVBuRjQ83ADoqLoKDq0gxMovEAgASRyJvYsyyNxmvuIskITLoc/XH8eijWGZ+syK9HmrOC83COApDlZkIMCGaYdGJI97JbZ3xPTDJ1fhlMAn0l3VD+o62z7sp2HE4i9NdSZZRYiwwCHVuyiMP049AV8f3XxcPBkMPlglCa8crnC6Zp2LiihG2cHbd+cgErOu2YexbSMdTRGunK2kPNlsqq9qZ35hgKzZhPy2QjNwckZ3z/ejxyLi+fXoLLbWvKqZRasCFfnvNpzVmrPK+q3wHP2WDVguzIHz22RGSPFgH92hmq4/eu1HO8/HJkZ6y2SLb7FKbNRXcG7DMyiPnxy4xaVqS/ZtNssLuGHU3vYSUgAd9vOg8U1epFKNR1LJkwfUjvrpEYAIjOxnW/MHhQl5ZnX9EcV/eSMUfujm3v/EsRGwYQlgG8aJX9w6uYJ1ZVIkAA2+2QXSFoNA+XyiH2li94+TRAVyT5yDxCZ6U4LL2Irfe7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e3667b-3a1b-4165-76ce-08dd9c652816
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:54:03.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7vumJ3YV5ib78u8pW5GrpMLIbWzjRBbSjGL56Vztvn7v+Ocy/4S/TkbkOHVTd+8tJHq7/B1CJKxH2BYsVz2Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260127
X-Proofpoint-ORIG-GUID: t_yinLbBcesxhJxC9v-g_bHKa_8rloRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNyBTYWx0ZWRfXz78WUMzGzdEI nNfKtsJs4AgpuG+FGtsXgBi+iQNA/wkUxhRUol6zc2O8rLT31sGbV+ir32+oFnZV2oQvblIjM2F VQ5oXJe66R173gDidT+O/gm02ZaxQOc9MgZuZIBdqwik2zEnZDsltz9Z5DmMQ95UxX7BKVFZ6gC
 uBib525ApKYes3rNDWK55gCck6ow1JNq08hmxRqfZB/2CxzM3Sp4gYNLHIgY3zM3B6uVhVA7bZN OToqpade+/Glroszdunwu1LC80aVxYR0i0aALQ7002gEdKixqrAnmCjF00bfj1Y6uTo3mldsyns bYeRJE4zd1arkKb78g8bIsvupuUZKGeghSi5Ry1EmgIj/vFKUP4NSQ1MDO0d0F13HSsyroLq6s1
 zKBBv9PCv2NDSoiT4mPHQzdMY4VCT4OtHTJKHHvYg1UtVbpN9eAk5UMwBDEm+G5gkLc8JfLO
X-Proofpoint-GUID: t_yinLbBcesxhJxC9v-g_bHKa_8rloRk
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=68348090 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yOqP8JAtUofgm8aRXVgA:9 a=QEXdDO2ut3YA:10

* David Hildenbrand <david@redhat.com> [250526 06:49]:
> On 26.05.25 11:37, Yafang Shao wrote:
> > On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> > >=20
> > > > Hi all,
> > > >=20
> > > > Let=E2=80=99s summarize the current state of the discussion and ide=
ntify how
> > > > to move forward.
> > > >=20
> > > > - Global-Only Control is Not Viable
> > > > We all seem to agree that a global-only control for THP is unwise. =
In
> > > > practice, some workloads benefit from THP while others do not, so a
> > > > one-size-fits-all approach doesn=E2=80=99t work.
> > > >=20
> > > > - Should We Use "Always" or "Madvise"?
> > > > I suspect no one would choose 'always' in its current state. ;)
> > >=20
> > > IIRC, RHEL9 has the default set to "always" for a long time.
> >=20
> > good to know.
> >=20
> > >=20
> > > I guess it really depends on how different the workloads are that you
> > > are running on the same machine.
> >=20
> > Correct. If we want to enable THP for specific workloads without
> > modifying the kernel, we must isolate them on dedicated servers.
> > However, this approach wastes resources and is not an acceptable
> > solution.
> >=20
> > >=20
> > >   > Both Lorenzo and David propose relying on the madvise mode. Howev=
er,>
> > > since madvise is an unprivileged userspace mechanism, any user can
> > > > freely adjust their THP policy. This makes fine-grained control
> > > > impossible without breaking userspace compatibility=E2=80=94an unde=
sirable
> > > > tradeoff.
> > >=20
> > > If required, we could look into a "sealing" mechanism, that would
> > > essentially lock modification attempts performed by the process (i.e.=
,
> > > MADV_HUGEPAGE).
> >=20
> > If we don=E2=80=99t introduce a new THP mode and instead rely solely on
> > madvise, the "sealing" mechanism could either violate the intended
> > semantics of madvise(), or simply break madvise() entirely, right?
>=20
> We would have to be a bit careful, yes.
>=20
> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because thes=
e
> options also fail with -EINVAL on kernels without THP support.
>=20
> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
>=20
> What you likely really want to do is seal when you configured
> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.

I think this works.  Take the example from a previous thread where
containers are differentiated by allowing or not allowing THP.  If you
set a container MADV_HOHUGEPAGE (or whatever flag we used for the same
meaning), then if a library uses that call and it fails do we want to
report it as a failure?  I would reason that the library shouldn't hard
fail if its unable to use THP, so it's okay to return the failure.

Alternatively, if it is a hard requirement, then that container
shouldn't be allowed to continue in such a state and should verify the
return.  (If this is even a possibility?)

>=20
> > >=20
> > > The could be added on top of the current proposals that are flying
> > > around, and could be done e.g., per-process.
> >=20
> > How about introducing a dedicated "process" mode? This would allow
> > each process to use different THP modes=E2=80=94some in "always," other=
s in
> > "madvise," and the rest in "never." Future THP modes could also be
> > added to this framework.
>=20
> We have to be really careful about not creating even more mess with more
> modes.

Yes, and clarity would depend on the mode name, imo.  Never meaning
never, for example.

So we'd need an answer to David's question below before agreeing on
"process". If it survives across fork and exec calls, is it really a
"process" setting?

I believe you are seeing it as "setting default" really doesn't mean
setting a default if you cannot overwrite it, and if you can overwrite
the "default" then it's not going to work for all use cases.

>=20
> How would that design look like in detail (how would we set it per proces=
s
> etc?)?
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
>=20

