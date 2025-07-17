Return-Path: <bpf+bounces-63579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A30B088E8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872844E1EC8
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05B2289E20;
	Thu, 17 Jul 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ufb8wgjY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WvsPPHdb"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840C289808
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743160; cv=fail; b=SHxpvP4dLizopyy2UTUuO0ond2xnIfbTXv7NWO3mnImLWyXFmzi55qZ6gIbis30MG6JuPl+DMunhCSk/F7pq3+/KjKPqSiKQxvW+puQllsmL1KnuESQWA2kVBv1RRQBzFZ3z5grKdjRFueSBbpxxOyyDf9hP2DSwn2rdbVmftEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743160; c=relaxed/simple;
	bh=ZvRka1S/K7I3nZj8SITE8qSap3xmi8D1HZjjrVdCU5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtkplJe1kZ9+2yJv1gfllDO56Nund/uu/9eWbbfeKobmZvCj9CNXe8sVo4ZRg5H3Ynp2hL04Y6Mmf4OObZZfJnVahnPvWW+qDGyj+amIdTxfO/JUlH5iMzy3B+ZU99RkU3pqd1fbsU/zfN0SJIZwrsOCLzshxiZePb+lPeXsB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ufb8wgjY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WvsPPHdb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fpRm020705;
	Thu, 17 Jul 2025 09:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gdlLvW8HstqkKJqkPINPwRBm+uEUiXxzWzFQGlPPRGY=; b=
	Ufb8wgjYdH/8tFBfRYW44cowXFwGUhcpw1Lor8w99WhL/YKsZXOAJyakZZQRyLUe
	VnORAbQPbvhPJgMWyO95+1dAAQtRmxn/n+8VcXkxCQBTKL2HtM9/BdrtmDnwsHht
	lQYBVthYFNOtD1Ea6lgP5Lip3s3PHMSifQj7N7bmOzquS5kF4ckEaNd4Hf5ksj5M
	Cu3lKMtuk3cHHyq0ebUuLZXLzh8iqpbZcCPXYZSTbYRGh9xa+hiw260t1sg9ehFv
	gchM+HflhKDOiNaNQKk6L7Znr7Ed4WgR7KT/1rzMgweQ6yG2oOTDcige0EKs3tE+
	OIRvPBqFfDLh3h/hRYtEbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4tjq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:05:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8omPY013035;
	Thu, 17 Jul 2025 09:05:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5by7fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 09:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PToz0COOlbxTn0Lz69VdfbM1KTI/DQSMyK//FInrpPBI2MeujKHrj37guLemHtV8XB+wkfH/6mA6825QGCPJzxzR3lkgNUFj/K6yhLkiIwWWNv6rl/9dbGLMvCGDDIw7YaBnFiIy3s8AamlvZHxALlG0Y8r+JRDcklE1fmwElt3TuMu3oeubK8I/ARi9jy5X8J13X7o5gRsmItN/GArXIo9Wy6YWsMNfLmf69fCB35LZKZdiSYb19wvIRxC6VSG2cdhIZs4K9lryb0MT87GLMee9/ldgZHOvkpJa8R4ihzSM6HXbbcTlNH7lFVEQZCANuzW2Auifsv99HOZ1JhDQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdlLvW8HstqkKJqkPINPwRBm+uEUiXxzWzFQGlPPRGY=;
 b=Wx/qmXJDsFzGHAn524NOWhg+4BwB9uCKBAzqu2pfZL4HsBsmDwBWaj8jqNdX5j/DtQHZ+gaaaZtvTMtCbswsEdeCwEhcMDvTQ4aFHDnWKKsMrAsaGtvG4t4tVXesCoJIPb3TkOivM/8/nNhX3+HMJdJeOhhMCKLtft5u152yGMOKZpqa9XFotViD0dekc08zlDlTHGMoXpwUEk+vY9KmdzX/0rVUeCWb4k7twUcxwEIAHDYNXUSdRjKP42bgcSdeXUlJbAYGGonuX3/SU1ZVm2gLW0hZtFhlZcFeWApONWY4biIrYvcaQ8DKx2yUjmQdOjnvhHkx3p5lZtdrusMeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdlLvW8HstqkKJqkPINPwRBm+uEUiXxzWzFQGlPPRGY=;
 b=WvsPPHdbCtb6/vn0MSr/S2aHfk8aM6qwAYT0SUF+BBwkQwHs1aomi4JPMG8nf0+4EG5xO5XNxVUaKKExTflWcYBnBeA/K5qPGFSANbTj814QiftvgyZDQhtu11DR7QLhngeLHAlUcpcEg3Pv8Fs/z7eTNsDdL8b4yvA2hAOybgo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6014.namprd10.prod.outlook.com (2603:10b6:8:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Thu, 17 Jul
 2025 09:05:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 09:05:13 +0000
Date: Thu, 17 Jul 2025 10:05:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <f0b37b7b-f352-49be-9d4a-8f5d604ccdb3@lucifer.local>
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bc57721-5287-416c-aa30-46932d605f63@redhat.com>
X-ClientProxiedBy: LO2P265CA0445.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 268f626c-c7e0-487a-0884-08ddc5110a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDNCYXVOODdQMTUvZnJ2VTFaRklMVWswWDNmV3hJWUNoS0hxVGhrZ2dTQk92?=
 =?utf-8?B?Q3NsM1BTem44NktOUE4wT3VKSThlMmhCOUFsNWttMVkrM1NJVXM0UGpKc1dw?=
 =?utf-8?B?UDF3RVgrWFhUOC9nelM2UDlkU2d2YzhKdnBsRjh0U0xaalNVMmJMY042ZXd3?=
 =?utf-8?B?eWJsRFNwRVFxdCt0YzJRN0s2WVFpd0lsbEx0RGwrUW92R3RaQ0VzaGZqNkRE?=
 =?utf-8?B?MW0xTU04cmtYcDFQRU5JQ2Rpek43QUZUQTdPcUF4MmFSQ05ub1VjamRickJk?=
 =?utf-8?B?MENZbldYdDV5SXhTMjRnR25jNTVHWXMxSUhhc2RrcysrZkR3NHkzc2wwYUJT?=
 =?utf-8?B?MmRDY0wvSmtqZFovbnVsbnBhN092dUd5S3pEcmZacW5ObnVQTjZQZHlOZlBi?=
 =?utf-8?B?MnhUaEN1bjJnU3UrcERPYmxicEVKY0tIVlM2NHlyMmc3S1RieDVzaXFkaEp5?=
 =?utf-8?B?ajFRNU44ZXNvWGZENWQ4cUYvc0xRaEFTWmZpQ2VTYW1IU095Q3dpdHcwWWtP?=
 =?utf-8?B?aFVVWGVuL052RTZ1Nnl1bGx1d3hRaERRN21sckpNKzZHNGhXNk9jZ2V5NE1O?=
 =?utf-8?B?QUR1OG1oRHdva0lpU2lXaHZoK1orTG50K0czRmJIVTZsVWNneE93amZyeFBl?=
 =?utf-8?B?UnVkQnhrejEwSGJqdGtTdjJTeVpTQ1VKTnI0SzBPTE9TcVdXUWpwY2QwS2M5?=
 =?utf-8?B?aFA0RzY0ZTlsaTdCVE8rMkd4NEJucVp2MHdvRHppUnA1WW1CUXM3bVQ3Q0RM?=
 =?utf-8?B?QW5SOWtuYmkzMTJPdk5WNHhoUTkxSDAzMko4RGdkRWdwZVUrZzJObUlEMk8v?=
 =?utf-8?B?aHh0QmtzcSsya0pBNFJiZiszUS9ZclRLYjM3ZWNtbDBLZWovcGdGaUdzeUZ6?=
 =?utf-8?B?M3R0Qkhxa1luWVVjZElGUG41ckpuNDEwaU9KT2RjVEJoSjF5Sml0MTJ4cHhr?=
 =?utf-8?B?ZTdwM3dyQStpTjNiYWttNEtHaWRoT1krTGw2MzZvSXpRbVAwcGg2S1Ezck95?=
 =?utf-8?B?TjMzb1hzRHBCeDQwRkRuMlVBQmIyWUxoeUFKU1N0K1hWNitjZjRKMTdKaW5Y?=
 =?utf-8?B?RlppY3hQU3o4M0VhMDRaTFJXOHBoZldVRjFES292L0l1QWdSbGRtTWhXMEJt?=
 =?utf-8?B?aCtrK2g2ekkzQmtKTDZYU3M3bXNsdFRwMGlKU1ZVWmxNTnV3ajhQSDBlN2N3?=
 =?utf-8?B?OUNIakVSbTVYTnRQakM3M1NTL1V4WWhXL2xoNEp1SFFQaGVtUU83WDJjbXo2?=
 =?utf-8?B?Qk5hMEltMW5BOHhMWWlKOW9XODU1QTFPVlZQR1Q0RnlFOTA2V01GL3FZL2d6?=
 =?utf-8?B?V3VZbFV3UTE5QXB1UnVaL3k5d242SG9uTmwwNVhLam8wc08yK0NTOXc5K0Nq?=
 =?utf-8?B?YjVveUh4WEx4dXVSQVZHR1dDMUg2cjloVDhXaHBzNVhiaVFjMEQrM0ZscUJt?=
 =?utf-8?B?ckowRTR0cjc1bTlValhCZDVnYUd1T3lKQjJUTFJZNEVDb2doSzFlZzA0WTRY?=
 =?utf-8?B?OE1oU2dOV2pGZzFKM3U4K05MSlNZTWt2MHRGWHF1VWNnWG5ibVBhQnY4SXhG?=
 =?utf-8?B?SDI2RkZBdkNpNEFURjlERnc0WnJHbFJSc3FuSkJ6ck5WZDhyZzFQcVdxU2w0?=
 =?utf-8?B?YkVYSk5sRnd5QnR0a0tUdTdpcTlRdGl1aDZCaVlkSEd4bHlPT1oyckhUZFVy?=
 =?utf-8?B?UllKWjVNSUxCMEJQTUpvRWpEaWhZYzJySTJQTWZQaDZkSEdid3hMemkzalBM?=
 =?utf-8?B?VlNzSXdiK3p2NklyS2Q3T2hFd0ZWK1Myb0FZQk4vV1dTUVB0U2tGL1MrNW9E?=
 =?utf-8?B?STFTZGV3YnhlQ0pveWV4cjAvcEhLUUVvVXVrUUdzK3RHNHlodUhRUFJzL0NC?=
 =?utf-8?B?OG92Nlc5SkNYYmw2ME55UVBTVkE3RVVQRDVsTjQ1NjY1elVwUHg2Z01FZ296?=
 =?utf-8?Q?t6gBp+NExZc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVhuMlp3Sm5sQWdORCtNbkF3NHFpU2tGZkhsdE40RXcwbm1OcjJCc3Q1ZHcy?=
 =?utf-8?B?YTlUTmZWaTlrS2hqaEpYS0tEUHdOQUdDbCs0U0NQTUJ5Y2kwREVTZXg3NGhw?=
 =?utf-8?B?YjdRbEVnemhOZ21tU2VVNGJlb2Nob1YwR1RLNCt2dUlMWW8yYVpwWXRKZ0Zx?=
 =?utf-8?B?OWl4NmxRTlA1aEVDWEp6aXBLa0FGQTFaN3c3RXNBaHpVM0xiTEMxNUszMEQx?=
 =?utf-8?B?THhNd2U5dndvUTZUUGpCQzNpakxrNlZSc0pMbTY5SFEvendWQ2s2dkNZUUgw?=
 =?utf-8?B?eUZTUVVPaVgzNWRyMXMvVnVYZk5WK2pwS29pSHpJYjFHZDVXL1d0R1hTUG9n?=
 =?utf-8?B?TEJDeTFHcnFlZXdvNUp1Yk95MUFjVkc1M3g5RjY4WWhLRC9PbGtBbjNuOStw?=
 =?utf-8?B?WURJdW92ZU5lS0xQS2hBLzdaWDVSWmRSUncxRkp3MjhmYmJFOGp2djdpWWdK?=
 =?utf-8?B?U1huKzFkOThidzEwS0ZKNDNCUXY5bGVuT1p5OEt2OSt3d3F4ajRCcElReTdK?=
 =?utf-8?B?R1BFVUtPUWhNdnJHVmFFQkZNL1VEU3JQM1lrMTdnb0M2citkWDBxR3pqV0RF?=
 =?utf-8?B?bm1NdUlYYlU0bkNrVTNBblJ3ZEp3RlZvc2c4MEtlQm1EYWJMRU1XY2tDOG03?=
 =?utf-8?B?bjU4M205ZjFiMy8wL2RDRDljc0xhaU1NYUpkUEZXbnd1ZlIyOWVXb3hXdjlZ?=
 =?utf-8?B?L1VnNTR1S1JiTThmWWN4U3FkSFY5djZ4UTErNmNRSzJ2OEdua3hIYnlQdWdp?=
 =?utf-8?B?WUJSRFI1eGZqR1dpVGM1TEZYMnFnUU1wQy9rU0ZIdDR3djdrUFNhTkZZclZ6?=
 =?utf-8?B?N1NNY2U5YXkwS0pGcnZTSlBvTUU3R3QxMzdRdzFQVVF1alRmbk1vbENOUGhk?=
 =?utf-8?B?SFRmTkpsU2NiQkpxM0U1MkJmTW5GL29WQWZ2dDNhNnY4amtFSEtlc2QvRzZt?=
 =?utf-8?B?YnlUMitrODBUS2dGOFI2NkdZVFlZRVpXZitZUERSNVRONHQ3MkZTLzhaNm42?=
 =?utf-8?B?clprUWZab2xVbWRYU0grM3Q2Tm5Ya1FXTjRxdnRhWnZ4dEdYWGJLR25DMElk?=
 =?utf-8?B?d3hpdVB5N0lCMEU2Ry93MEI3MDhoSks0Nk45RTVXcHFaVXFHeWEyU0xockxX?=
 =?utf-8?B?anFkaFJPZk9qcUFnYkNTQk5WeUZkS1JZMmRmZ09MNjRYZHp0dTAxREVFbWUw?=
 =?utf-8?B?VlhaNDVpa3hmbDZ1eVJJWDd3M0w3QmdqVkVHRk1sM0FlYzFINWROT05HN2pw?=
 =?utf-8?B?Rjh4QjdJelFmVjhCRytpUXBRem4zZnZjZHFlbjVaOHEvai9pa2tha2Z4Ky9P?=
 =?utf-8?B?SGtPMmw3MmtuaUJjVHF6WXVkckVRTkFWR0swTk5JY3ZIa2NKQVFCOENQdnl3?=
 =?utf-8?B?Zjk3L2IwQ2xGRFFrOWtMOW1wczA2ZFAyT3JpL3RJYnNsUExDU1hlTy9PQ1lt?=
 =?utf-8?B?YWRva1ZFK2M0SXVMVHM5dU42QUphZTd1VXFYWE80bWpaTmFHcVFhczNIOFlu?=
 =?utf-8?B?bnFEMGtCN1F1dmhmZFRKTDV6K2syQTZhYVNqN2o1RzRpNjNGcmNUT1BOTmVn?=
 =?utf-8?B?SnJBQVBqVzNuY1BFaTZHdnB6KzdxK2dIT1QxQ3RoVnN3MmxWY1FqZjJKenRL?=
 =?utf-8?B?Q1VZZG5zT29xL05pUGpKZlNIUGljM2hCMmpVUHBKWElaekdxNy9EK0dVRmJ4?=
 =?utf-8?B?dlBaRGg2U0grMmlwTDFtMjhmNnJLK1ZWOG41Tk1QMy9aNkRBa2xxYXorVGw0?=
 =?utf-8?B?SDFQc2ZtZURMNFZMWk4vWTRpb3V6OEJiMmdMeXIvOUFUNHFOOVNqalp3V2lC?=
 =?utf-8?B?ajB2QmZPRTdYQ3FuUnZWRmZZKzRXZTcwTWpwWk9UQkREU0h4SzBBWVdGZlBw?=
 =?utf-8?B?dkNWT1JuVUpjZEd0QWpCeTZ2RlR5SC8zNktMdzVhMGdFMlpVN0QxZDUvcWY3?=
 =?utf-8?B?MWVFa3ZLYWtvZEZxRjBUWjAzcDBsTDNqUytVZkRZT0ZHeDQ0TFZ1SW5abTYw?=
 =?utf-8?B?RWw1N0F4Ni9sb1FYT0JTRTNlRjRYeG5xSENCQWR4RTgwdjNoNTh5b0RoVWx0?=
 =?utf-8?B?NEFmMFFBMmZRbjBJdjJ0VGtmOU9hMVV6WXpSRlQ0WDkxMlZXVFM5NmREaHA0?=
 =?utf-8?B?Y2RnTnhrbStKN1dZOHpCNHp3RGx4ekwwWnhLUklxSnByZmsvaTI5SG9jK05a?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A6uJ31dqIPR+fvOHkaQk6sLCy0eremhXar/oVBKpaSRVO3qK2zwp/Pe6D6zsGYYe5Y8TvXtP3q9sJfNI5rL/Tz8IO3rNiuHJcUPhd1qyKB/qoznJQDfkMiFLMRGJJjVTa+pj7tvDXC9vXm9P6MrCFMe4t3if19YRl45/ehu5GrxMIXn3Ys+fkoW046ysuyOvC1wzXhj0VXU803mdGN98vHsRtj/IeidX6MHpbm5yzX63FnIgJ2ELJRNXOCjWW+zkFFnx7DYbqru/irOqVtqoLWDtZEjDRFiZ3GQo14bgJhXUKrFg/ODeBdRG05vWnXEjOrviaWiDyDbxR/AvdNu9hXhVB31fUWte9rbTyBHdQw26nd/HSbAd++VpJa9tpvEL1vJYwnYBxQ/mFQ6zcUOKctmZE5I5VtR5ZX/e3qSV+9osRsax7ncEb+7tJxmIDHNyQgxwctnBKVPdWunZwvzMbafaJj9ULVaDsu1k9y7soeiOQJTq1YSzqJxbM7wayUwMrteuwQ1ACGC2mTTBLyr+HUAJcklLdG1kwsYfs494CIy9C0yZJ+kn7sBtxX8kuUHSrb3subJ6x894eBdV+m8x/9DYtG/wBZb2P0lQzs2/pvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268f626c-c7e0-487a-0884-08ddc5110a4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 09:05:13.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YwvTP4o577+Fe990hgEsBVOnppY6/b7Y9eRnZPsjsR8JcwpjmoZfjpP3qD5oU3EFdSlUaP0DRtbOm2CtXwS6IUITrRVpVMt338sZmsusqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170079
X-Proofpoint-ORIG-GUID: 812_hhS2246DpzUIPYPyrU4FM4ytdh3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA3OSBTYWx0ZWRfX4llQ+h30CJ7q e5aLp2cQfP1SREzOGMnM8it+6Qwdqim7sP1MouxG5FWSmaf21T+/UeEe4joVmSNKq4SUxA0s1LQ bxoqq9iUsLfoo9HEOMNH8uU7SWyp4HQGmk4BfwHFWF3JScZw7BdKEJ02VP8Nw7gGtFDIpANQ9up
 ujMp7AAzDXUgxwG0uwsFs8DvYjDPHh1rCqacxm3LsTwDiDrtmHPAfmRelkWj4WGAHWNdOOBTGqi Apd9JwE0w2mQQwUuvyzPfjuFj5oGvbXKUwbxlwuRY/wg4MZ3WK2O/Iqm/qmX94bBSkgtOFiwFWS qj2LYqbUz9TTieKt6oZDgn7RYrl2DRIcFpsTUkIbAHxYcHcQAj1Ogann8ynrkOYwYdciY3STFPC
 M9pCuvRizpe5Lt7eslttj4mDwZzwqUnzcr3pcRa4IkbYmN56oYNt7rQjgvwul+Nf27+qKUhv
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6878bccd b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=juMY9MFi3l4ud0f5TJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: 812_hhS2246DpzUIPYPyrU4FM4ytdh3L

On Thu, Jul 17, 2025 at 10:52:12AM +0200, David Hildenbrand wrote:
> On 17.07.25 05:09, Yafang Shao wrote:
> > On Wed, Jul 16, 2025 at 6:42 AM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > - THP allocator
> > > >
> > > >     int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
> > > >
> > > >     The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
> > > >     indicating whether THP allocation should be performed synchronously
> > > >     (current task) or asynchronously (khugepaged).
> > > >
> > > >     The decision is based on the current task context, VMA flags, and TVA
> > > >     flags.
> > >
> > > I think we should go one step further and actually get advises about the
> > > orders (THP sizes) to use. It might be helpful if the program would have
> > > access to system stats, to make an educated decision.
> > >
> > > Given page fault information and system information, the program could
> > > then decide which orders to try to allocate.
> >
> > Yes, that aligns with my thoughts as well. For instance, we could
> > automate the decision-making process based on factors like PSI, memory
> > fragmentation, and other metrics. However, this logic could be
> > implemented within BPF programs—all we’d need is to extend the feature
> > by introducing a few kfuncs (also known as BPF helpers).
>
> We discussed this yesterday at a THP upstream meeting, and what we should
> look into is:
>
> (1) Having a callback like
>
> unsigned int (*get_suggested_order)(.., bool in_pagefault);
>
> Where we can provide some information about the fault (vma
> size/flags/anon_name), and whether we are in the page fault (or in
> khugepaged).
>
> Maybe we want a bitmap of orders to try (fallback), not sure yet.

Ah I mentioned fallback below then noticed you mentioned here :)

>
> (2) Having some way to tag these callbacks as "this is absolutely unstable
> for now and can be changed as we please.".
>
> One idea will be to use this mechanism as a way to easily prototype
> policies, and once we know that a policy works, start moving it into the
> core.
>
> In general, the core, without a BPF program, should be able to continue
> providing a sane default behavior.

I have warmed to this approach overall and I think one thing that was very
clearly positive about this that came out of the call was the idea that we
can rapidly prototype different ideas.

I think a key to all this is ensuring that we:

- Mark this interface very clearly unstable to begin with.
- Keep the interface as simple as possible.

I think perhaps the more challenging thing here will be providing the right
amount of information to the caller to make decisions.

Also precisely how we use this too - obviously we need to be _trying_ to
allocate at the requested order but should that fail allocate less but
precisely how we do the fallback is something to think about.

I think generally this is the current best way forward before an automagic
world... which is a very long-term project.

>
> >
> > >
> > > That means, one would query during page faults and during khugepaged,
> > > which order one should try -- compared to our current approach of "start
> > > with the largest order that is enabled and fits".
> > >
> > > >
> > > > - THP reclaimer
> > > >
> > > >     int (*reclaimer)(bool vma_madvised);
> > > >
> > > >     The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
> > > >     determining whether memory reclamation is handled by the current task or
> > > >     kswapd.
> > >
> > > Not sure about that, will have to look into the details.
> >
> > Some workloads allocate all their memory during initialization and do
> > not require THP at runtime. For such cases, aggressively attempting
> > THP allocation is beneficial. However, other workloads may dynamically
> > allocate THP during execution—if these are latency-sensitive, we must
> > avoid introducing long allocation delays.
> >
> > Given these differing requirements, the global
> > /sys/kernel/mm/transparent_hugepage/defrag setting is insufficient.
> > Instead, we should implement per-workload defrag policies to better
> > optimize performance based on individual application behavior.
>
> We'll be very careful about the callbacks we will offer. Maybe the
> get_suggested_order() callback could itself make a decision and not suggest
> a high order if allocation would require comapction.
>
> Initially, we should keep it simple and see what other callbacks to add /
> how to extend get_suggested_order(), to cover these cases.

Yes, caution vital here.

>
> --
> Cheers,
>
> David / dhildenb
>

