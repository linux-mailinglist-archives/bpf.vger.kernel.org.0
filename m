Return-Path: <bpf+bounces-58565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2CFABDDCD
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE90D4E3993
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B624418F;
	Tue, 20 May 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kmC7t8S2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T6bt5tPe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054D2CCC9
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751798; cv=fail; b=GBMCnXzAE9dmAVBJrwKx6vMdQOMwrTj1lhK1V82igSJMJE29jB6DjF6EdPLo0qE9ZSbk5sgLE2btLVEKFMM2DnYkcPiSk3NR1Nd/OK3xr9uecxy55c6MTn8CWHGA7N1tmAEwrBin/UwExu74NPXoL64hfouSJq1VLSx4/hbAZFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751798; c=relaxed/simple;
	bh=rU0ta6oF7beddFyjSQbZ82M1QpM8ZD1UfbLveVu94ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTgOpjF/dQZ3esA+dundWLLAhqiPtkpZoQSPFXHpeax2nlhijV4F3gDYcVHag6v7kWhWd3Rrn6HetfbUE8ghx9tReuyySkPDorc2l36eWNHm8ZzNaimTl1LXVhYGrMnKeK+taounot55RLYirncvxLLKVZO9AlT0U77AfQGwM8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kmC7t8S2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T6bt5tPe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDbLSc024203;
	Tue, 20 May 2025 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rU0ta6oF7beddFyjSQbZ82M1QpM8ZD1UfbLveVu94ys=; b=
	kmC7t8S2Y9LVP/KMWnjQQn73RNqiKA//04n8Ptwo9GcGXAJSyMelEL1TNNBAPxag
	qH/NAVaQGEHgAd6Y2UVQeFhWv3pFKGy+yi6Rdmnv9TFPjWXWbPbDrLukdKtp/2yI
	zWdx9273WBFgDlKAYsNnFnkq8Fpqx/+qc8R5Eigfc40eJSAxKqomkYsiwdTTfkM0
	vpZFRKtyKzHLN1DGmHL5rVm3j4jZasCac4FwpjyG51Mb2RoBaoQk6m6Lomfd/MVw
	GtZF6KE5OAS8Wx9cO3OQKWwNq74f3wrkdMSBB8YMI1L3ckTD7SNCPWqaaBIsNc9n
	7qHSKTSODFDxeVAPjXt3ig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rtsbr5nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:35:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEDlqx002414;
	Tue, 20 May 2025 14:35:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7uutj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNlqYIfsd01k3KXm/iT5yd6k6TnDksmmdtog/NROXl1u8Cl4ztD8pjLT9eSaRKFQmTBZepOOtOZeAm0TPypDigX6GXTa+e7voM3qVzrFur2vYBm4FBjhSfzi90UvFUS64PtPMTLCtbsRJveZZxwlKEYH1307rx1VuliedGGejMqY/l7f0hLGiherqqc+nVgKpRT9qZqYNb+2xyd37O/p7PMP3gNiwYwCQqLXRYojA9FO1VMagA+YgS8G8zJ2NLrC0Ocg7Ci3OBCAHLxL10fp1Hd8Suh+L/QsT42mADbPjOoSVScCjXaG/tIRgZNDHuEPJTYIJ7BKiMS36YH5h2eE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU0ta6oF7beddFyjSQbZ82M1QpM8ZD1UfbLveVu94ys=;
 b=oJK40HRgWRFopHdKJAY/y3gdQccfkgOi9oAABHsP6yuV5hQZWPO3L3dxMMu2DlwG9D3vNsCrbr52IpcA8X9yPELuUw8G1NnB99n2mZdHooxVRZjgMvJLzb5joN6Ma9it2RwvjZkN6/5xpop6mALEtJ33In5Mw4piOpnqBLLyuuh8byyPj86QbzcyjtBs5rNRuLahEEENFu97+Wf/EcD+jnkWULUnQbT7kLX/oiDTIjPU2zQIvsvumOLVVKRtQyOVqXMCl4JhmrCSUW5nDI+sVkScApGvAeeKIy7nOgU7JZYDy+2uN3977H7cr6bFPhgLxcVAeRLembu95eoWz1JlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU0ta6oF7beddFyjSQbZ82M1QpM8ZD1UfbLveVu94ys=;
 b=T6bt5tPegaOYhMRaDCMfq1dViN69ITJdsWJY/YN2TegWiqmxqf0U3drzCF7IQHnaPG1GS0K8lxs1JtOD/29cz+DuGaolsFbWwXCCpC74rRuggewDNqyWigt0hwKtJofR0fCGPQVL4/t5OnCoNgCMmlnjaKuPf+8xPNnKC1XQvzM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 14:35:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 14:35:51 +0000
Date: Tue, 20 May 2025 15:35:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Nico Pache <npache@redhat.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
 <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
X-ClientProxiedBy: LO2P265CA0479.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: a59170b4-867f-480b-b3d6-08dd97ab9eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzRFbWMzSWZtOXA2ZnI5NDI3TXgzM0h6ZFIxelNaaVhtNXhhMTgvRTc3Y2JD?=
 =?utf-8?B?RFM4WEhWVWIxWmxEM2M5QTROWkU0cEc3UFFIK1pwWG9wWS9XYUJiZVlLN3lM?=
 =?utf-8?B?U25ubzB1SHBSRWpWRUtQd1FkVStiZVdJRHdQU2IrWVZtdjJZUlAyQUVoYnZL?=
 =?utf-8?B?YVZKbUI4MkVtdjFIUTNRN0JwSEY3UjJoSlFOc2dtaGI2ZmxUamZPbjJNK0NZ?=
 =?utf-8?B?WW5YYW81ZCtsdUNCRUJGRmZYSExFYTQ1aGRTdWk5STlBT3RIbGgyMCsrajZJ?=
 =?utf-8?B?UlhubTlQYzdXcEptbzRiYXAxSlgyQitOUkk0TmxucDBWT2ZrbEpldjNtQndM?=
 =?utf-8?B?azRMOWJNbDdxNVhXSm1FZUtBdnhsWmlvc1IzMTl1bXY4dlZSazRNN2h2QWhy?=
 =?utf-8?B?YVFBeEcyZXphejIxR21nbEowYXhBMTJkZ2tjbDdUWWRhS0FDamVnN1VQaVhG?=
 =?utf-8?B?N21RZkVaM0dPSU1oYVdSTFJkNTVXcmpSNHN1NGZtV0JvZEVsNnJtcFJmNVhY?=
 =?utf-8?B?VHliZXhqZ3pUUC9oMW1rRWdzMWptZ1prbGpsR253S1U3a0FtRjAvWnh5OW5i?=
 =?utf-8?B?S3VZWEhzbjdMV0dDUUxiVzhBMkZuVFliWit2aHhDSUFSazcrMGZMVmFHTjdY?=
 =?utf-8?B?Mm82ajAycG5kWEZKbjJZbnVNNHViVXJyUmJ5WDNUWkJ2MnVQV0IzMnRmbXc1?=
 =?utf-8?B?QXJYU2pYbmJmZVVLbGpIK3puZUwwdlZyeDI3QUJCOEFRdks0cGVJQkJvMEIr?=
 =?utf-8?B?LzRQeFdGZlg5eG1wa05hQldBVHFxM1RncklRNHhRQVNPNmR0dUEyUm0weERh?=
 =?utf-8?B?Q3dtOVQ4ekh3TmE0SGxsWFJwb0JscjdYamNYWDBONUxFS3lNaU55VTF1UUd6?=
 =?utf-8?B?S3d4cnc4NHZoNG5HeGtHRTB1VEIweXhMcnBFeFRucHg0L1g5UENBOW5OMzdh?=
 =?utf-8?B?OTg0Z3Zra3VzdDZnM1o4eGx2b0YyRFk1MS9UU2MzdVVOQkZDL0FGb3dOQlFE?=
 =?utf-8?B?TStyTTc5OUxVRDFpa0lSYVBJWGtVT2wrYkFCdHJWQVBscnloV1RVMlRJUUxG?=
 =?utf-8?B?L2F6bDkxbGREeFU1dTJvbzlIMlYyK1pxeE5TTCs5NGpRM1c5cFRnTitlMmtJ?=
 =?utf-8?B?VjhPeGlzMUF3T2pscWhOQmxaUXNDWkZMSFE4VkUxd0VwT3lIcysxbWF1cHd3?=
 =?utf-8?B?L3pZcWJLUE12MkhNNWpiMzEydllwazI2a2FmendETThMbGhVZTZtT08xNmhY?=
 =?utf-8?B?ZHpJWDBzVnNTMDNJQmE0MjcyK0cvemgwL3BRMkVuTHQwSmQ0aHZ0TXpwcHpZ?=
 =?utf-8?B?bkFFWGJJVGtsK2wxMnY3VzQxRUs1dzVxbUgvMUwrSENCOHBMMHZuNTlRZnJu?=
 =?utf-8?B?TjF1YVZmQVJyQXBZYXc0cEgyZDFUZVRHRUdJdFpvVTdDOFRSbWFkUkNnNm9M?=
 =?utf-8?B?Q3dreEpPaHp3T0ZMQWNXaTRpaEwyWGtFOHc1LzlDNmNIelFKYXFrSkszUWtX?=
 =?utf-8?B?Z2w4STlpU3UzM2d2bmRCMzJxMEhwQVI2cDIwaEkwKzVDL2VCdkZiUFF3bGE1?=
 =?utf-8?B?c21RanErbnFFcFNDRFJPVzdyV0Vxck1DNW1FeG53Nng4ZDlRV2pXaDU0bWlw?=
 =?utf-8?B?OHVnL0dvamRQcW0zT2FjMjdLbkpITGpzV2tlVXZkUVFHQUVIQjc0d3hESzA4?=
 =?utf-8?B?WExJZjBuSXI3encwbVpKQjJPV05qNlZrYm5oWVozSFUzeUFqcmdsWCtHamdq?=
 =?utf-8?B?V3V5bkJja0NsVmVMK2thd2l3d3MwQVpMNFYzQnBkZmhzOEgyeW9VeTJBQjdM?=
 =?utf-8?B?cGJVNVRaajg5eFVGSGFPb3BJWDY1elNIazdXRHRtWjdIMzNXeWExSjMrYWdy?=
 =?utf-8?Q?3xMtSBHJEy/7e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3FvOTZnUEJBdnh4YWsxeVN0V0RVV01ESFN1UzVjdkRZekFLU3JLbVNVaUZK?=
 =?utf-8?B?RlEyRzFVcmNUL0VBZi9WTDhTTnpNR3BSVlJtcWE2S1VXTDhtVlAyblV3Slkv?=
 =?utf-8?B?disxWnZOT2o0emUvbFVUL1RxOFEwNWtMREovVGcxeG44MmxPNFlWQStrcFMv?=
 =?utf-8?B?a3NYalNYREkyalZpb0FhU21DZlB0NmtXbnQ2dlBRdnR4cnhmbFRDYWJoc0VT?=
 =?utf-8?B?OHJFTXJBdkdvanZPQVY2bVFtZzJTT2JkbnVZbExyWURmR3QzRGpTT08yZ1VZ?=
 =?utf-8?B?RWZvWDhweE1hc2ZsSDVmbkhwQlpKd0VycW03R0RoaDZRTFBrZThwUi9pdTBh?=
 =?utf-8?B?TS8vcXI0R0xTWXdxY2h6QklJY3p0eERMbFNJUzFaVlgvZ2t2aGV3TW54dUt6?=
 =?utf-8?B?a0RLbHl2emQxSFdrL0VXblpNVFZGTkpwV0JyZU9BNWVsLzVaZVNYT09GK3dC?=
 =?utf-8?B?YitxeVFFUURKVjB5RmREajB1ZTB0ZTZKMzUxL0QxV0Z0K3c0NkY5RjZSYnh6?=
 =?utf-8?B?OEhXZFJNTHpXR0dGeVB0RHlKLysvVEFQcFQzNzF5NDQyV1JpVHhTcFJuNjNy?=
 =?utf-8?B?WGR0eGtndlluLzFJQ0VuVGZuQklZbldoSVFCSWJEM1lRK1lRdUpzTmkzendr?=
 =?utf-8?B?ZGUyTkw1V2Z4K2tYb1U2ZllXWWRiZWYwTkh5QkoyWEFJaytFN1pwZVMwRTZ6?=
 =?utf-8?B?UXZqZi8rMm9VRFBEUUUwd1cvZ3hVdDFNd3dGQjQvTmN1dm1XVmt4QjJSYkxY?=
 =?utf-8?B?Q3NmcUI3T1RVUzRIK0FLcXBMd1NHRTU0Q0ErRWpzamNVTmpnRy9DNDZPdktD?=
 =?utf-8?B?T05aUjZCSFZEVUtQU0poTGgvZEJYK0pDY0tSUWJtUjE2YnRLMWlLWHNuaUsy?=
 =?utf-8?B?NHdwck44TkNzelRJNEt3VHlWMTg0ZkYrS054MldtSm1uNUxRNGE1ZE5jSTVJ?=
 =?utf-8?B?eUVQWTFRUy9MazhOMUFEZ1FsMmw2MmU5Rm9jSG9CUmtsNndLVDRNN2JmaUwy?=
 =?utf-8?B?R0FvVUoyZTN1RGVlRGdzakFkY1JiczBsUUQ3T3B5NjFZUDJBQ005U3B2QldC?=
 =?utf-8?B?a24rK0IxS08yOTdQT0tBTUFiREt6SWdjWW96eUZHeWs5OVdQelFMRy9HdW9W?=
 =?utf-8?B?WXFJK0Y2ZUp6ZXFOaU5ZWEY1WGtHcXlzdzNLL1dMR0xGdWhxQzUyY2ZxNHNj?=
 =?utf-8?B?dzRTTkZBVStYR1RkVWM5OTdDTUw2MDI5bitaUURPUXA3cVYvTUtxcGRmYVVK?=
 =?utf-8?B?QU9SU2p2MldPYmJIOXMvbXp0Z3phMENpQnZaZDEzVUFDUUZEL2hMYzkwbkRa?=
 =?utf-8?B?TjFTLzMzRVFuYXhSZFk3R2hMRktrUXdqdjJYUFVCN2Fka2JwQW5XK1M2RkRE?=
 =?utf-8?B?TjhvWllCVnpnTkFyOFFNbXBwWUpPNFVIUHgrNDJCTCtseTUrWFp3azE2T2lJ?=
 =?utf-8?B?eUZ1RUlNNFlaMXNRblRxTC9UWGhiWHF3cmdHeTU3dzlFNy93dW04TGdZNXFC?=
 =?utf-8?B?eTNkeXVVUmY4NjFFMk00VFBwcVhIQVJMUlZhUXI2SHlKT2lnS0xZU0lDUk1Z?=
 =?utf-8?B?eHE3VUpQRXFnT0IxOGpQbks3UElWc3RsaHZmaytNeUJOWVd2VUJ3V1hNOU5W?=
 =?utf-8?B?STliZTJUaEYwUG92WVIwMVhWckdNZ1VYTy9NSG9XYi9vdklqMHdNQlMxbEhw?=
 =?utf-8?B?eGttSGtORDBEUlhmaHlvODMxbUJoSjJFV21WK2tPU2V0ZExhT0ZkY0xUM2k5?=
 =?utf-8?B?aDVMZEEyQ3lWbEhaN2ZteWFxSnp1ZllLbERpN3FnYTdSVE5FM0NRdnhjZ25X?=
 =?utf-8?B?MFloMmhwR1ZRZW4ySW1TUG5zNE05bmxqT0JMRVh0VVlUbnI1TXdxVzZPVk54?=
 =?utf-8?B?TFB2Y0VXcjYxRHBidHN6Vk9ERkdpRmJGVUtSdEdoZ2NZWGVFU3Q2Nmd1MzNq?=
 =?utf-8?B?SG8rZ2xFajBpZ0k0bVg3dlZzc3FIbmFteHozdHF6OVhKZGc0aFBmR2tRWksr?=
 =?utf-8?B?dUxaaEpIWG5WU1RvUnAzeTVoNHNjVXlQbDlyUnR2Y3NENTJSRnpZdkdNRk5p?=
 =?utf-8?B?L3JwQkJwOTRYODhpMnZIM1lob0JodS9VVU1UYXdsbkV0RXhEVHhtVFNoVDY4?=
 =?utf-8?B?V01UL3BqSDd0aXFOcjZlNmhzdkpscmF4Y0RrZ2ZjMkFkQzM3MHVyOHhmbUhO?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WciC9z+gFtnKeFl+LBhDoaxZcxhujViM8xbN1mxBDBK00zlBbnHVT4l+Pxbg0U5giJPf193oFAgUTOd9JpaZp8SUGhvHnAU/tG8nfs23Rcl3PNJsOB/fMlH5MzTMSiXR61ZCJZU/VXMFXOXuqCguBfnEedMTvueHwrqmUKGolnugbXJd5v7o9IPb62o+o17fUG6pm0z1VCekPB7AUM1XCt8zEz7+O59EAkFUO6PDVKmkdaj1taYB6SfYw3TBFVNgQF7lI8rYYGBWRzKjOnRWQo7vw0I/Z4Z7Kw2WcsJ1sMfh+n/r+eHrhgF7sKmv0b+p9WLZAFbIALNDaXTcEy03729pE0Qs7UOYv+WsdRHKMYsn3+Y+WkfDWYY92RgGNnG16gK0JsXt8xyUHgw4jWINKfp6KC9WztCSMBt/2Zp1zuTjcTG0bTwogpMGnjN5exi5j34bNjOQn5jHvTVtnz//suI7pk7nhYc3s9uphnfTZdd6a+eB/S/GaCcyRNlYHBFlH/4W3iTNeXHZSdQAf8ixlgAGfrKaHrYhMps2cadH5e4kwtJteForXuGSjc6G9uvZfRNS08LE0zUGcBMeaqVf7l/XSns14baB2Cb8sSQ4hdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59170b4-867f-480b-b3d6-08dd97ab9eb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 14:35:51.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXIZZDNqiu/W+wASRlj24z9poFQ4sP/Tr0B0SRXnX7zKRSrxZPXn2NwYXSWgdd9IO9zMsC9BhAL4LWAn6uyhBc6f5YmXKdAUlZXvrpLTtM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=721 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200117
X-Authority-Analysis: v=2.4 cv=D5BHKuRj c=1 sm=1 tr=0 ts=682c934b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ufHFDILaAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=LxWZk83ZILaRK9Zl0hQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: vsJNTo4qNLiiOFuO457PoJMHIEnw0Och
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExNyBTYWx0ZWRfX8xok2VofyWMG eyAKxi7k/dJNoEClfUbJT+FqtkLwZgdCziGxfYHxUO5TjyiISkhfBKTp3aZ7hgjoLyzCxbu5XVh XgEEVjLAPinYhy2zjf6zsxKr+3DyCaYxx4foyJISshtBLTfpZFcSZiOCfEMhR1ExVS02UzSDMG8
 v9wzNvPet0Xxb6Wqe5n+FYLd1Xkd2zksaXvm9137TzKOh69NNrfQDAcCMY9hvc2Cg9cVbTQMVMQ TGBh1zUhfczhazD2hZ8Sad2qHuzXg67hIumImVco3o5ZVT6g+qVDNt09KEJAPhx0LKcLXC23Zqk FPsvOc9uTzQimXhcZGLhchke7RJEMv7O+PlFKg8kNTEmsg2UctqBsDShypHl7qJbz5DiToFIBG2
 csBZ/DxVYszfzdPDE68x9rXyWxK/yt1Drl7UWSvx3bAo3zelJhmvKoriCz2LJduosRJFuuXA
X-Proofpoint-GUID: vsJNTo4qNLiiOFuO457PoJMHIEnw0Och

On Tue, May 20, 2025 at 03:32:16PM +0100, Usama Arif wrote:
>
>
> On 20/05/2025 15:22, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 10:08:03PM +0800, Yafang Shao wrote:
> >> On Tue, May 20, 2025 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>>
> >>> On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
> >>>> The challenge we face is that our system administration team doesn't
> >>>> permit enabling THP globally in production by setting it to "madvise"
> >>>> or "always". As a result, we can only experiment with your feature on
> >>>> our test servers at this stage.
> >>>
> >>> That's a you problem.
> >>
> >> perhaps.
> >>
> >>> You need to figure out how to influence your
> >>> sysadmin team to change their mind; whether it's by talking to their
> >>> superiors or persuading them directly.
> >>
> >> I believe that "practicing" matters more than "talking" or "persuading".
> >> I’m surprised your suggestion relies on "talking" ;-)
> >> If I understand correctly, we all agree that "talk is cheap", right?
> >>
> >>> It's not a justification for why
> >>> upstream should take this patch.
> >>
> >> I believe Johannes has clearly explained the challenges the community
> >> is currently facing [0].
> >>
> >> [0]. https://lore.kernel.org/linux-mm/20250430174521.GC2020@cmpxchg.org/
> >
> > (Sorry to interject on your conversation, but :)
> >
> > I don't think anybody denies we have issues in configuring this stuff
> > sensibly. A global-only control isn't going to cut it in the real world it
> > seems.
> >
> > To me as you say yourself, definining the ABI/API here is what really matters,
> > and we're right now inundated with several series all at once (you wait for one
> > bus then 3 come at once... :).
> >
> > So this I think, should be the question.
> >
> > I like the idea of just exposing something like madvise(), which is something
> > we're going to maintain indefinitely.
> >
> > Though any such exposure would in my view would need to be opt-in i.e. have a
> > list of MADV_... options that are accepted, as we'd need to very cautiously
> > determine which are safe from this context.
> >
> > Of course then this leads to the whole thing (and I really know very little
> > about BPF internals - obviously happy to understand more) of whether we can just
> > use the madvise() code direct or what locking we can do or how all that works.
> >
> > At any rate, a custom thing that is specific as 'switch mode for mTHP pages of
> > size X to Y' is just something I'd rather us not tie ourselves to.
> >
> >>
> >>
> >> --
> >> Regards
> >>
> >> Yafang
> >
> > What do you think re: bpf vs. something like my proposed process_madvise()
> > extensions or Usama's proposed prctl()?
> >
> > Simpler, but really just using madvise functionality and having a means of
> > defaulting across fork/exec (notwithstanding Jann's concerns in this area).
>
> Unfortunately I think the issue is that neither prctl or process_madvise would work
> for Yafangs usecase? Its usecase 3 mentioned in [1], i.e.
> global system policy=never, process wants "madvise" policy for itself.
> Will let Yafang confirm.
>
> [1] https://lore.kernel.org/all/13b68fa0-8755-43d8-8504-d181c2d46134@gmail.com/
>

Yeah I really object to that case. I explicitly said on your series I
object to it, I believe David did too.

Never should mean never.

It's a NACK if that's what this is about unless I'm missing something here.

I agree global settings are not fine-grained enough, but 'sys admins refuse
to do X so we want to ignore what they do' is... really not right at all.

