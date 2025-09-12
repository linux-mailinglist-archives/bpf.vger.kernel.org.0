Return-Path: <bpf+bounces-68239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E1B54D15
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFF616C062
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A72314B79;
	Fri, 12 Sep 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hlcYrmxG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i9TzLeFI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5273148B8;
	Fri, 12 Sep 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678744; cv=fail; b=QuUB/v5Xn7lXTk78O5fMkJuPDi4KaGMIAo3MPJbDyLMD/j/Bc+ej4alUKQGoZkHFO+GVPbD837i7axHj1i8oW/EEI2mS6jnZOeDewcFn5F7a8dE1ah1bfK4KHOon0yHcBwPkkfL5nuaZAe3t+OoLDAxcIHPJTvT1gCbth0Poacg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678744; c=relaxed/simple;
	bh=dRUX+8Iqw6Rvh5B2odOgveXySbWYsvHQ6LduQJhfBAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dz/kASRpArya47ZEXquGBF2+BQTpnftmUHDH4jNMb6TtelrrTV2fpS+PKJJR6TpqH0yEmOgpxClrGnJG5B24atgkM044IIwgjyWrbR3tbqsBte2aQxZVFrvDg7vdWGuXznLaqwVs3BoIwIR2qr1AbJ9jni3La530IZVf1nvD21M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hlcYrmxG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i9TzLeFI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tpdU027258;
	Fri, 12 Sep 2025 12:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JQrCGHtlhOZVxT7DW0BgPAVjVonQeSi5NHz2FKmjXIE=; b=
	hlcYrmxGdfgK53Z1WZd6ur+5OTH9A7efNDmIX+8F+il+GQTMlCDX6k1+go38JaVP
	fiZNlkKgieFWJr1RBlkELlCDTxXmf0YK+30nRB/5UU++UIP5Csza67VXRJIuK8TF
	aeJ+AvDrDR25IqKSBizcG94g9hllISVdVtCzno39eHxwrrfFjDJ1/S66+o38Mhmw
	nP9GFqhLHZ2ILTXaZByDB+zvnZ9cmH1uypdzWEkbaYhNDn7X4/caTHfEJZNyDD8j
	YhT6Lpj9IrInwWbaA9bT4gE2KQIPox6fwr6TjnNwHUzBmma8QHJluzsQZf404cnj
	V77qZxMQfl1M8SJGgRn5vw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922sj008q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:04:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CAFS1d002850;
	Fri, 12 Sep 2025 12:04:56 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdmamyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwX5QXpsad6UfM3tEmDuIdzG48XtPdHLJi9OF3bECgG7H/isX5PfmQGjPD96DQ7rqvcg8N4NFkJFLYdLPo6CD1H2dnCryXTu1qtd4EFHBGPBbCUQeAnDDEzLBCPn1K9FMk0S4MYyL1Ps7s3PtVNX8dQLvEb/6I8FP1Yao7/AJ700Vqbuis8plbtlA3DIYF+A/fAGCVM25lMZ+PjgagoZB81L51cTLbVCn3QgLq/kM/Vp3E08QDevY4jU7bNHXwFLAKJXMYIdhhx92DH9O3bbPowiwkHisqHKbaz9QTJH1Rr+b+4sFPba81SHMAXNtwTtWVKAgxKYxXxvmVgrddbuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQrCGHtlhOZVxT7DW0BgPAVjVonQeSi5NHz2FKmjXIE=;
 b=wHUTL5Bo68GBdlkLIi7CQrh+7H2HPFhKGlv2NR8/Y1Wz63fsv1AxEtB3s/ryN3KLt9XyU4Rc3B4ysS870uK+12mYgFfoHN2jnbI0rmrrlH7BBZ0Zh1/E5QhkEMKFcBiUGwzSjsCxuyv18nnKWkoWoLqRziyYIj/tES5LMYWgVeIF+YLHIj02EKo5fP7vzyNKz5yof0IkJQR3cjBOZ0dfaCauec8sNIAuaR77Nsr3xLSw+GPAw2dx1GLYilwxcHlR0NO3hVZU1UFVTT1baRaYMAuUvr9gycC2QRswejeBvKTiwUv9BNZhWF828yWlMEjAookERLTNiFxrtZnxSy+Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQrCGHtlhOZVxT7DW0BgPAVjVonQeSi5NHz2FKmjXIE=;
 b=i9TzLeFIUDSjrYnSUGcz9/bgzpjHeGLpuQto9MkjBApqnqNObcMuQDtYXKwqC6HBnZjCwPBGNbuxFXGy6Tz/hKQoi/krvYdsE/qX1ObppBcUBgZlVzCO25tGt/YukNs3K4Fzi7LKCI1+aiSWwRdALry+50Nv7uWtZIKjwbs0I8k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7397.namprd10.prod.outlook.com (2603:10b6:8:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 12:04:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 12:04:53 +0000
Date: Fri, 12 Sep 2025 13:04:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 03/10] mm: thp: decouple THP allocation between
 swap and page fault paths
Message-ID: <ecda0e47-6193-45e2-981c-ac4bbf177855@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-4-laoar.shao@gmail.com>
 <0aad915f-80b1-4c2f-adcd-4b4afe5b17dc@lucifer.local>
 <CALOAHbC1QDeqoS5Onkccsf+rMWEUbb1OEdeuLOaC9sLWhk-Amg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC1QDeqoS5Onkccsf+rMWEUbb1OEdeuLOaC9sLWhk-Amg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 84193217-bbbe-4a24-d237-08ddf1f49532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW16YlhWazVwK28zcHNNNWMrSGJtbG9NdVI3KzF5MjNUZUFEMEpPMzF0M2J5?=
 =?utf-8?B?NHc2TzBtY3h5RWNMMlU1bk1SVVlIQmQzZ0wyaHNkZVBWRmticWZHWG5iSnhw?=
 =?utf-8?B?Q05MV0RTOWpHVGttdFN6WHVTMkRTczF6U2Z4Wno5TUlNTlBrUVJKdU5PU1Va?=
 =?utf-8?B?d3dvZklJaG9HWFo1S2JtWXB6c0VDbmZ3Y0FGTWYxUUVpUSsvWE8xT2ZBTDRr?=
 =?utf-8?B?NlRQenZJT1VZR25nVDlKV0xTVzFpbWFoYzVoM1piTlk2VWpJZ2ZabC9ibUpi?=
 =?utf-8?B?bjhGdFJRdXB0bkEwTnlOZCtvOVVJc1NBVnh1SHdLUFczeGYyaEVkRWt2UlJa?=
 =?utf-8?B?TlJuTkJyR29DTFVwckxBM3pWWUpjY0JCZmZSbmoxQkl2blJsZVlUU0dSMGNG?=
 =?utf-8?B?TXVIb2gvWFlRNEhpby9Tckg3c09KTlFzMnRVYU5CcTN4dmRwVUs3Q0hkeUR3?=
 =?utf-8?B?bDh6TGYwVU94VFNYMXFMUGJDZHpnOGtRMncvRm5PdXF1eXN1WmZaOTloSFdE?=
 =?utf-8?B?LzNEZnJEc3FlZ0Y3QmxGLzdNT1NxbldJV0N0dmZZbFlUKzdFSVUyYjN4akJw?=
 =?utf-8?B?WDErL2hpdlB4UUlBekRxcDB6Mm1yMmZJODhPVlB5cWZ5Snh1cXZOS3Bqam1l?=
 =?utf-8?B?ZThNdEI5YmlWUjI1RGFnQTlnNmxGdEVlVGZYaDdORm8yaEQ0YXdlMTJmYmwy?=
 =?utf-8?B?SFJDdVM1cFl4MjVqQVpLVHhXOEdQVnZRdDQzelVnaHg3a3R3RkxrV3IrbXJ0?=
 =?utf-8?B?dk9Rb1hJeXlDRmRwbWxkTjVnbmtXSWJlM1RLdEVMaloxVTNnS1ZLbWJoNzVs?=
 =?utf-8?B?c0lDV3REbHltYnpRZjVLdnlkTHc1eGtsS3JvNmRNMHFyOFJ4ZEhjNStoemxq?=
 =?utf-8?B?UUVKK0U5SHk0TDdzR3EzVXl1TG16YTlUdWFPODI5UFhHWkRjT3oyT3BFSkRD?=
 =?utf-8?B?SUJIUjhTTWFyQXIvVWZMTWFVZDVsUmU5QVhWZzAzbkhwd0ZwTHZ4VC9KQXU3?=
 =?utf-8?B?bXlCNW1kWUR3WlBhR0cya3g3bkVRazVVcGppVTJiY3ZDMkFPejZ3RjYxL1Ux?=
 =?utf-8?B?QWJEaFhnOFRHMWlMWHhWRmFkUTBYTXhBNE5mUk1meWVKZCtnUUdmSFBuZTVV?=
 =?utf-8?B?UVNST3AxbEJ2NnE0MEJjU1pSSlNhaDQ0cHhMSVFQbW43czJvZUJVSTNqVzFM?=
 =?utf-8?B?N0hwcW12dCtDRnBMUHZ6RDFJRXhteWYvdkJ0cW43OGJMSDhyTnJVKzk3bXpO?=
 =?utf-8?B?M1NmOU9DWGhDbVdHQ3VzcjJQQlVFQ1lQT3RFRTJiMXI0VFJ1WjZ1bUVFb0JE?=
 =?utf-8?B?czlsOXFTM2QzTG9FRE1ickcvTHJxM3hUVG9UU212UDluUUd5ZHRTT2N4YlU3?=
 =?utf-8?B?V2QxZEtkUTU5aWVkek5xSitheFlMTnJWRG50ekptNXMyT3ZJdElJVE5BODNo?=
 =?utf-8?B?NjFoRFBZZUUySTZNUW5CV3BwVWdMdkpING9ZaVdiZjZIRjdDbHpWbnFaV1dz?=
 =?utf-8?B?bkQ0bWtmNUJmbFpNcE1HZlN4MDlGNXV1WmU2TXdGZis3OE9sUVRqMm1uN1ZC?=
 =?utf-8?B?aHlRd0tQSG1wSDJkaE12U1FFRHBGQ2JsV0c2NXFVMVRLbUlQTytiWkdQbXEx?=
 =?utf-8?B?TCtZS1hGSzVQVDRnL3JMTWJCa1R5TUtyZmdrd0ZPUTVPWWdmWENMbHBIcFcv?=
 =?utf-8?B?TGtDYVUrb2JSeDhQZnlZTjYrUVJ3RHVyRTVVY01DN28vbGZOQTB5QW5hQTBO?=
 =?utf-8?B?VlRsLzNvR0hydlM0aTc1bndPTWw1UnQ1RDQ2aURYb2FUeW5TOGQrWnFWejVQ?=
 =?utf-8?B?UXFVd0VCbng2dFJvMTZaTDQrUjdGSnU4Z1Y4QlJNUDg0M0xmV04rYzlkTDJP?=
 =?utf-8?B?ZVF0cXhRVndYaVlGdEN6TC9xMHA2enh4MjU0T0JDWkJmSEFzKzZCVzFkRms2?=
 =?utf-8?Q?gfPP3hznrqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFBMHBjSll3bU96alFQR0NDdHFiZ3dEYlVQUzFWK0NwVjZZamtKMll0N2Ir?=
 =?utf-8?B?WEJKcE5hWE5neTFyd2NVa2p6dDZtMXNLNytoeWNIYnE0ZWpGbG5xSzhhK2hw?=
 =?utf-8?B?VUNjMTNTaktScEZHUzdiVU9QVmdxbStGcXFuOWZTUzBJRnR1TzhTdWNoeldu?=
 =?utf-8?B?MkgzQ0hlNFZWWHdiU1RweTFpVEdpbDM0REZhR3J0TjVrL0V0bHA0M3F4RExL?=
 =?utf-8?B?ME5meEYzVllpRnNVUGI5M1hYTGVXaTBNdXJYYnVVWStlMzRtdmt1YkNDdWVM?=
 =?utf-8?B?N0gyMjlsWTVZTzVETTIweExncWsrMzZvUGhsWTd1T1JFZGxoVEtIOUFZbWlk?=
 =?utf-8?B?R0piZWhlaDdGQTlYeEhIRzJzUzBINXVNT083WUhSOTRkRmt5OXZQMjY5d2g2?=
 =?utf-8?B?d2xWNzFGQ1FSWjJlUloyTkFjK1JUTlVEdDJtL1U5R2hWemphMk9kb2E0MGhx?=
 =?utf-8?B?Z0FJZ29xQ1ZqQWFwbFc5Vm53RDRYbmp1dlI2dFNzWk1Ec3g3c2JoaEtTVi82?=
 =?utf-8?B?dXovMHdPb3ZpQ0hvY1FiWERkSzdWTitxQnJXR3kzbnlJQlFiNWE0UlRvbFZX?=
 =?utf-8?B?WVhYdE9obkxGcHF4alVVTGcxWEJDSVdIUVVSQnl0NStXaTlXaDRJd0tqeTgw?=
 =?utf-8?B?OEhnRWdRYlFZSnQ4SDBSb1BFdC9tQW05NUdqbERwRUc3alZRZ2dDaWIyRTB1?=
 =?utf-8?B?VzBGMEdLM25VYmw1emlyZXhTbWl1VDBhR3JmYk1ETDVCK1YrZnNFTzB2bmZz?=
 =?utf-8?B?WlJGT3BWbHhYbUFRYno3YWVXMlRlSk9JMTdycm5aR1RRVS9aNlJSTTFRL0hu?=
 =?utf-8?B?UldGZlBUUEN4RVhQZ0w3WUJKbWNHMnVFMXVTRk1UaHptWWdBdUd6VWlSd3hy?=
 =?utf-8?B?SFcvL0Z6WmoxaEE0VS9XbXM5eVFoQVRPTnI4OHhIdkxOV25tWVFJaEI0bXhO?=
 =?utf-8?B?ZUc5ZFVXOEd0VjJWN2ZYOXZpUmV0SXgzcFpYdW9CQUxneEtJdzBBQTlkZ3pD?=
 =?utf-8?B?dUR0ekJ1dXZWWmtvSis4MWJ3Q0ZrOGVNSXlRSmZMOHROaS9hc21NMmg4RjhS?=
 =?utf-8?B?ZHdvdmxLdGZsNXhZWm5YQjdmbzVEelZjYUs0NWNmQU9ZdjlVaTQzTjlxUXlu?=
 =?utf-8?B?ZXlaY3M1eDNSYytJV3k2WWZZSnlqRTNFb3MwRTYvQjZWMzZ0TzFmYkxpZGRX?=
 =?utf-8?B?ZDQzWm91cTh1OEpTK0JPNnliU05STVc3NlRUYy9nQnhaaSs0bStibkJzSUJG?=
 =?utf-8?B?Q1F0VU85TUxtaFJiZDlKSDJ4VDNhZkIvU3htTkQ2bDcvTVIyVk5rK2J0WmIr?=
 =?utf-8?B?VUpqVksrQ20rVDhKMDEvSmdvZDlwY01jRHFQNDNNcGxkTkxnOGtFSE5FQW1v?=
 =?utf-8?B?QW0yMTA3RkF1enlHZkpxQjNWY3BuOTlZTm4zd3k2dmlGS3BIRWlUWEJLOGRh?=
 =?utf-8?B?STYxdUN3OXVsVVI4RjZOVDBvVHJGWjN1bVlPVEtocUk5WjV3NEt6clpwSXVr?=
 =?utf-8?B?TW13Njhjd0pndUlsRzFiNXdBbExDNXNMcWZocGdGdFRYZFE5R0VvMHEyMnNx?=
 =?utf-8?B?YXl1V3Nibi9rSU1EcnIzZEIzU2Q0U3hWa2VYUmRMOGF1SXM2QWYvdXZuLy9p?=
 =?utf-8?B?R2tpK1FrdXlWREVyck51V1FpZEZoNElWeExwaUFHMk5ocUs4SlBZaXVMbEpM?=
 =?utf-8?B?Mk5HRXlzZjdJSHdWUUE3Z2FJUkxyMjAxU3RDTHVueWpsWWUvNVVSL2ZiclVq?=
 =?utf-8?B?a296WXBVS0pMZXdQL1huekt4ckpqUnVBck5EMmZQdlBmYnplTVVkUmZDWHYr?=
 =?utf-8?B?UUlNKzIyWnQ2ZnVMM1d2aEJnUDFCRUZxZU5qSkZqUGZKRjNTSHQ5dzVOTUtU?=
 =?utf-8?B?eWhrTm9sL0I5WmVCOW9tRU1lWUhUNWRhVGhvN3k3ZXZmanR1MFdLT0E1SzVO?=
 =?utf-8?B?U1dSUDBHZDFmZ05QeHFETmpZVjluZks5VzlsYzkrTG91OGFaRDlmUUhYMXZR?=
 =?utf-8?B?QnEvQWxyY0JZY2xZWUlwQUdIT2lMSlg0WXRPTlh4ZDRNMFNTUVViaDlHWUIz?=
 =?utf-8?B?MFdNSjhxVFZ6ckdJM2hLVU4yUDNZWXVHSHFsSnQrSkZFdTE2akZJOHA0MytT?=
 =?utf-8?B?bzh2aE92ZWJmVVR5cmlxcjYyRVR6a1dqczlTcXR0SGljOW5mSlpPS1JmZ0V5?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LH6777jVUOBiDORGOscTSyW/LFarvwygoXkTHjhcSuFjmxWNgjDP56Y63s38K2rWulWbjzYogEKcAgF0k6EnFsqp+8u7fd1X4ShCUTg2Nsr8AmxG0m4Al1LqwtEGtEN9snEBbi/4dd9gl81T5N8iXR0tomwHY+ZMgTNR2ev1H0f0NE8kCt+ioLoG6p5HQlISADi8xlGZNapiYfxcbjZDlMz1LndVSNcAEuR3UwWnhNtHUW/HLSUiyo3Ibky1KVXZlPk0kp/ydUfgLNnlEuJUprDHqr2su4Wpk3Ae9+5FuSz3sOhXB4C47fksuX54Fws3LW1eWbm5e/Se1IaZBuJLa4CIIrPbnlLBs57+nCfJ0aZRnn6uTTRiPpHko2W7V8j8WWa2TmNGuHKDoHzbOhGZk+4CoHKNKUYLhsHBDfFxBtk/utQtlDFp3c+Gc4FMni3riEMKmDysyhJshXhv2LeW9DKO4Aq3lWuKbnTMAhlRbXQa7RbRnWWPzd1i1wB788rpQG2cyg3o5VdbEWUy/tbvPIds4aFzgfL7jqKPbuNne7zdAnn3/hNPsmCGnoQRFMS4Za5Y3t4uvPakJYj6Lst4PDXesVBpy+pvEzw2g1HANSM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84193217-bbbe-4a24-d237-08ddf1f49532
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 12:04:53.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra2IcHtyupc/jTDxubmqdHe65Hn2552LDws582AiMBkJd1HE5sxwrliejGQr2h4wZ1mUFUbeglCFcdOokO9vHNGAqkewJeQIk/4SOGVcNnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120114
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c40c69 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=8eevGG8g60yIjQ1eG3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX8ROQHB7hA0pT
 mxs3ghcKBnMYRv7NRNo/13GYe1vLMSekLIFItqcYw4BXHZO2WPQPxeilOn+Mb0rqkYAchqlRkN5
 rOuFgBqh6Nk4Xmt1pnNm6vGeZ+JdsQNG7704C722dbMORyVCKv45pdUqv5pCFicJZua+oYR0nkg
 BPFCJyOw0clqhmPCjAP5/MeKHZu9351Prt647O55HZaH+utae9tOZWOrF7ZKjxnxpdL+WMqvBcM
 6G4gZpkJQvbr2hSdOk06pVdwtydxEIyppYpH5cibaOa+RKRG9JAxgEMQKC2AL5HmyhJ8Thv8axf
 0EOs84/cp5CWbmYpSQaOZIrehCsUHDym4Yx4oKFQLVV0hZB8iE4EQPpbntH1DhuNaBjUqxK4sav
 F7Ym/UtdmU8V1+iQCwSZDDlugSgwQw==
X-Proofpoint-GUID: MO6BdNUr5AeDF2-mr1ySpHMYbDIidyop
X-Proofpoint-ORIG-GUID: MO6BdNUr5AeDF2-mr1ySpHMYbDIidyop

On Fri, Sep 12, 2025 at 03:20:38PM +0800, Yafang Shao wrote:
> On Thu, Sep 11, 2025 at 10:56 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 10:44:40AM +0800, Yafang Shao wrote:
> > > The new BPF capability enables finer-grained THP policy decisions by
> > > introducing separate handling for swap faults versus normal page faults.
> > >
> > > As highlighted by Barry:
> > >
> > >   We’ve observed that swapping in large folios can lead to more
> > >   swap thrashing for some workloads- e.g. kernel build. Consequently,
> > >   some workloads might prefer swapping in smaller folios than those
> > >   allocated by alloc_anon_folio().
> > >
> > > While prtcl() could potentially be extended to leverage this new policy,
> > > doing so would require modifications to the uAPI.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >
> > Other than nits, these seems fine, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > > Cc: Barry Song <21cnbao@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h | 3 ++-
> > >  mm/huge_memory.c        | 2 +-
> > >  mm/memory.c             | 2 +-
> > >  3 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index f72a5fd04e4f..b9742453806f 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
> > >
> > >  enum tva_type {
> > >       TVA_SMAPS,              /* Exposing "THPeligible:" in smaps. */
> > > -     TVA_PAGEFAULT,          /* Serving a page fault. */
> > > +     TVA_PAGEFAULT,          /* Serving a non-swap page fault. */
> > >       TVA_KHUGEPAGED,         /* Khugepaged collapse. */
> > >       TVA_FORCED_COLLAPSE,    /* Forced collapse (e.g. MADV_COLLAPSE). */
> > > +     TVA_SWAP,               /* Serving a swap */
> >
> > Serving a swap what? :) I think TVA_SWAP_PAGEFAULT would be better here right?
> > And 'serving a swap page fault'.
>
> will change it. Thanks for your suggestion.

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo

