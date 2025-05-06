Return-Path: <bpf+bounces-57503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A8AAC123
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E267B5D5C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B0277026;
	Tue,  6 May 2025 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ET6bMLj4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="saYGbNCc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140FD207DE2
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526574; cv=fail; b=tsPLAqQqRPXGW2wkcTGCnLbASErDuBXy/BaOTt1sooTkKsOM+fbL+EV0yvFXy9gbAtnw43TJMNFsaC7pJR57xkvt9795OxwsU/6ebL1jbXEvQfDDO397lvPQhH1sKkQuWK5w6h8+HO908Th2bkRzu00qQ00kiYp+huWpfR1PtFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526574; c=relaxed/simple;
	bh=MK5K1WJ8aYkSkDvA1GZUfzJUpvnuvnfumHK8+HeW+DU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTB1GQ4MpcSRLWShl06e1y0OuRTe7yKE0+jj+Q+meXBGej5x/lHxKAB33uSFq6PVsexm9KTfeOha7qEzrfoQWTj0qYLRRhqBAu+P88xDRWbM4G13CKeAd6OhJ+ILW+Qd7QmfH5JBkiLgC8gGsorUvHrStpLiFTA9yMVKhUQ84o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ET6bMLj4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=saYGbNCc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469maeX019112;
	Tue, 6 May 2025 10:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uTltqs7/Zka60TgTvCZZi5jlx9XRScd1UVWIh5WRJ6s=; b=
	ET6bMLj4pxXxpR22AigYQcE6L7PQSki5fpcUE9Qpb8M+5nT7FYpxc4vK9xdrH8hY
	8ZSw0MHIhw7qcB75R9X7l1bUZs6rEwYGG2mMkhRHwRMAICqaGYsG+HpwrcnL+x9y
	SFNDFCxTS8InwhmTEP5yzOKD3EiIuRzHaOVi4nxAYdq4LKBZXCquRcdIg1uVzk20
	6D47FDnFPv+AL5Q4HM387BBwQ2WO2vm+4I1yB0CqscNodEjFbN8dOfMKDRyeCITi
	N/nrHtwISkCxMszfoLmQNBdkNflBkYmslMi2pHNmfi2lVAvYMLTyx3bviKe0Flq1
	r7+UHruOaVSo7rBLCPwcOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fg3g01cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 10:15:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5469wtun036235;
	Tue, 6 May 2025 10:15:52 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf28v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 10:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOYup1mdfTiNmcOY6MG6k0UykwIdr3iiS4Wi85tN8dm8DUqgZZCQXzTt70f/Z0bm/T6DeuTfLnFnt3B1+h7UcmFBYYX8m85zSSYPnIUDEVmEr7rGwadQNUCFLWjZEkltDCeRqkhOiQZiNnJ0eOQF233onHlS0u/w0wFSkqqQJwvDI8CckKSz8g+EPZyZhG65KuuvO/kIqtJXZGaUJ/RL/01/lNy4qBHHSnqPRrOMyNbLljQ5upm9tzaPxxbm919CMIsdLp2tAREEsZ7ZRJT1nMFm1ZTDYp3E2WkMG+JktsDxi+NYUvy9LwwQuEtsMozmopP9mGFdt9knHJCdRKCFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTltqs7/Zka60TgTvCZZi5jlx9XRScd1UVWIh5WRJ6s=;
 b=bZOqNWfUdxnR/HtFIOab51Cr5fyLBJDfbsM6DLfJBC+CwxVOAojf99HCVikH574Y4TZf+UMmvqqQYADWDDcfhJeIGMUrdM4F8yc38qcTqGK5a+d/3qsSlkxqPAF84gJWEmoL/bT21LA2TBH4KOkaMhmu5Jtr1vBEqi457pqGNqMGxwHkPEleeGEDn6yspQ6H/Or3vHHhL1zAtKtsgdjekQzi7rTap2MBP7YyjwBHYfGaOduBRypXT1a8xbKFiXU+NrRrJjDfi+B+9NQTdParRYcAsX1UOMi4cfecXrh4oBbJ73314CPGl0+7cAREHFep5wpu57A3ZspUrc8mjqaa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTltqs7/Zka60TgTvCZZi5jlx9XRScd1UVWIh5WRJ6s=;
 b=saYGbNCcpU2w13litOMxEnPf2URv8X7e4130Dw7iQnGikPfnpXyr6lc2+45N4wL4DK3/4OOaHkAEf20CbyGu3NhJvEKwdBR1OyIlunV27+p0+XX7oOh6lIFlOq7NyCvW80e6hZwuPMqRLDroXYQ4Ux1AAsVCoigi+BzZe82S6NY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5616.namprd10.prod.outlook.com (2603:10b6:a03:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 10:15:43 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 10:15:43 +0000
Message-ID: <b8d256a2-66d4-4342-be55-6ec54d79ef96@oracle.com>
Date: Tue, 6 May 2025 11:15:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] libbpf: improve BTF dedup handling of
 "identical" BTF types
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
References: <20250501235231.1339822-1-andrii@kernel.org>
 <95dbb7e5-c2aa-4114-bdb9-9d9ea53653f0@oracle.com>
 <CAADnVQKmQKVTkf28Ex6T8Y03xDQ6-3o-rEcOM3vGZcVHGcrfSA@mail.gmail.com>
 <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZ-3ovbCEO+Jnn30xNsxE4nBnGtqL9FZ0O7JkUa=t0YuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3ec116-1fec-42b3-86ed-08dd8c86f5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unkxejk1SlB5NWM0RjZzYk0zZHlmYnRJZTVENWljYyt1MXduaStkUlh6RmJS?=
 =?utf-8?B?cG1PR0VPLzgrODdSNWlubXRpWTdjTGpQVnBOZEpnQitzNUhuWmprRHVuQlNS?=
 =?utf-8?B?bXRtQUJ4OXFSelRVZ3U1aEhCcVB2dmtXdlpneXl0ekRCcmMzcGlHSUJrWVhs?=
 =?utf-8?B?Z3ZPRDBpeXpCWUJ3RnRGaW9OdmdHamdMdk1wTkJVcklveVFEZXU3QmJKdG8z?=
 =?utf-8?B?TXFBN3pTTFdwWFdyQ2hJSzRybllGNTdyMWlMeld4aEQ1bU9rSy9ocE5wYnZX?=
 =?utf-8?B?clE3eVVIOE5pdFlpWGhtajkwTXY0NFU1czRxWDdyVUV1YkJLYVE1RlFNZzFq?=
 =?utf-8?B?MVNETVRLdnpnak8vUGN2RXlxWk9tVktxa09TSnkxSlZ4QUdxdzZJeTd5NVJs?=
 =?utf-8?B?eWNhSlFUd042UEl3TkpMTXZEV3ZXY09KbERzR3BxbG9oeCtJNWZOMHVrQlYz?=
 =?utf-8?B?UGlERVBBMmxGbmtzcC9hOXNxWFNVclAxUmxoRlpPZ25ObCttUWJhZjJlb2Ew?=
 =?utf-8?B?TFROL1M1NzBTY1prOFdxbTk5bXVlUjU1R1VreURYQW9nMXgvQXAyQldXZEhl?=
 =?utf-8?B?eTA0dkd3MEF0b3J6QkFzak5NOVVtQXQvK3RjUCtwbGRDV01sOVhDRVBJdE93?=
 =?utf-8?B?bWVMQWttRVlEZEhuN2xIRDN6T0tnOVJJRStTM1ZtcWovSjBadTQ0OW4zOTNU?=
 =?utf-8?B?dzhOcHJ0KzhkZHBIWktDSjJtS1doWTJlVG1yQmtsV2l2OU1TQmdlVENQbkt1?=
 =?utf-8?B?L3lWL1A3bmVPbTB3WnVhMXNqL3Y3SGRMaU1aOVhNUkdSMGxQOU5QZCtQbzl0?=
 =?utf-8?B?RXo4RlBKdXd2THBXbmtQZFdTam5jS0xjcDViQlNlWHdBOVNFb0pKYmZraG5E?=
 =?utf-8?B?NENPcnJTYStteS9id1ZiL01pK0orcUJBd0hFd1M4d3l3eXh0ejF6UnhwdXZa?=
 =?utf-8?B?Uk9ZbllqN2Z6TlozMTQ2UGJ4ZytyM2Q4dS9lWXRXemRNL0xrWnJkbk9WWm44?=
 =?utf-8?B?YVkvZ3pWSUpjdG1oNGFlMGFuZmtnVis2RXFibmF4YmVtZEJzUjlaZ0dNTHNj?=
 =?utf-8?B?Qm5IdnhRZHRKc3lYSkZJNFVLTGJuNVo5QUp2eEo3SHhLVGZVYmQ3bUprdHEr?=
 =?utf-8?B?bzRJUjZ4TmRYTk96ZDdxaGZqQVBJcEtVdFkxcWVOWVM2cVJLRU5rUW8vanlV?=
 =?utf-8?B?alJyZGViY3cvOFFzdGZDNUNqVU4xNGdxcGVOWno0bHlxdnhrdnZTR21CNVoy?=
 =?utf-8?B?OU5zN0ZzS3RJQUVUZDd0Z2wrSUJVdzduWlRQMFhuTHhHbFpaV1I5NHlmQzdl?=
 =?utf-8?B?Qk9NdC92YXdPOWZLTGF0TW1LVDlZMFBaTVRUb2JnTUJnY3gwNXAvZm9Fdkts?=
 =?utf-8?B?KzBJdVJjK2w0UjJVVGJhaXFUQ0FXaU03QjdmeTRZdEViZy9Gc3hNL1VnRStJ?=
 =?utf-8?B?OGUrZDJOQ0tRTFl5RkxGUFpIdUkzMDhlcG84aDJEMkwyVkk4aXhRV1d6VTRM?=
 =?utf-8?B?dXVaenEvN0kyTlpZTVBPNnlIcERGYTl0YkpaOTNOaG8xcUVzMkJOK2g0Z3d0?=
 =?utf-8?B?YXUvRHN5dnhaSlRNT0J6TWttYUQ4Tk9oSkpTMFRZOTl5ckpNMjZDNkp3WFNV?=
 =?utf-8?B?MVJkS0duUk05WE8wUjh3OGpYU0wrcDUwa2dVcVM0b3JMa0RPTTlWQlZlV2Vm?=
 =?utf-8?B?QVA4UXdnZUNLUEZqZEQzeFhLRmpFb0d0TUU5VEV5d2JJZndMaWtqemdSSVpw?=
 =?utf-8?B?eExRN0FEb2xXaUlENEhpOXJIR0U0R003YlA2RVNBaExQZzhkLzFCSjBnMG42?=
 =?utf-8?B?bE5PTXI1MzI5anFCcFYvdWY5eDFCRFBxcHR3YmkxOENKVFpZM3FHTFE1YXRG?=
 =?utf-8?B?Z0JDRkZxb1NNRXVmcCtId2RCcHlZNy9sU2xLOGY5T0wvdWdlYXdvdnBTL0Fo?=
 =?utf-8?Q?87i/Mva0NRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5ucmJpT096bW5ZMkkyN1FLUWpIWXIyK09ZajdKK0xCb3dVbEZrb3ZkRmdv?=
 =?utf-8?B?V3VNWS96S1c1Zm1vMTc0akIyNmdDV1ViSzgzMTVnbTNqUHhjMi96SjgvWHoz?=
 =?utf-8?B?RGRzYjJDdG5XWlpmTGVhaFlBakc2VkRwb09WaEJ4WWg5RVRmVitXWmVHUWVs?=
 =?utf-8?B?cEtoV2xtL0RNTWVtVmdDR2lyT09wQ3lDZkxOTitrNzdiUGJFbGd0RER3SUs1?=
 =?utf-8?B?WC9ud082SVMzcDgwajhUUFNTVmZOL25ObWw5T1NoY1VUR20vRTJWS1Z4N040?=
 =?utf-8?B?SGdCUEppcHdxS2hkeXdhMkZzM3FMaG0wZStuTHB0aFh0VlRNditrR0lMekR0?=
 =?utf-8?B?MzB0SG1qaTNuMWNiSlplQjFiLytwUE14Nmc4WkM3OXdycWFzblNLV2tuUnN3?=
 =?utf-8?B?ckV6amRabFk4ZjZNVEsrY2IxM2dGZ0tjTzROQXB0SUphYmp6UUVCMU1TVVZz?=
 =?utf-8?B?ZlB1TEJGSFVwOWZ0T0dzK2lxbDJFZDNLSGtFQ044MUVzd2JWdzVadURtZ1h3?=
 =?utf-8?B?U0FUb2JkV2ZjbnZHZWcrbVZ0RERZRDZ4OGVUcm9XYktMb1JsaWE1UE41OVRJ?=
 =?utf-8?B?Q3U0aFNJVWhZdWRxeng1OGZqTVNRR0Ywb1NwcDQvU3c3bDQydnpwTVlabWRx?=
 =?utf-8?B?SjVUVmxzWU1DaXFmbHFpekVxTUNIenBlS2ZJanVzbWNNT2hKWWhjWHkwUzNv?=
 =?utf-8?B?ZklaZnc4WCtoRmNQa0JMd3plRm9BNXB4OUZHVFZyWkg0VG90TURiMHVqY1py?=
 =?utf-8?B?N1A0UDExQmR1NWFMQ0NmUkhhRE95alU4ZjVmSUp6b25sNUpuNDBXUnB5Nkk5?=
 =?utf-8?B?djVyZmd2YVlxem93VDJjUnczc2MvZmI4c24rL2R4Q29GZTg2OUg1aml1TEpE?=
 =?utf-8?B?UjE3dk9Pb2Z0TnpVN3htQlE3Sm5jR0JXR2RwVGtKeWpaZHFFNnJaU3dNUzRZ?=
 =?utf-8?B?UzdSRlE3UUhBRG9yNUhDcWJJTy9JdjdyNzFWTWZiMUJGbUxXSW9sUjJTbC9n?=
 =?utf-8?B?b01nSmMxSkRzUUQwSzBKeWNQd3dFN01hNmhMU2plRVlnRyt1QWR5OVE0ZVlQ?=
 =?utf-8?B?MmVCTWtjajB3ZExIemtHd0dueWxWazFha1EydDcxTVByanFrcmJaQ0o3bGQ0?=
 =?utf-8?B?ekNIMENVZHhJRTViY2dzZ3NITXVwcXR0MktrTThpRGNTT25DUFJxb3RKZnkz?=
 =?utf-8?B?ODcxaDdPVGF0QzZtMlJ3S3N4aWdsOUZnSk92MUNFaHJ3OVJ6MWVWV1ZWL3dN?=
 =?utf-8?B?YVhTSEZqQnM5b3BSWHAvUm53THJXaGU2ajhxNjVpT2tONFExTHJwUkJSdWdT?=
 =?utf-8?B?a3U5dndoN3d0Tk1Ia2V5c2VNNXV6ZlhsSVFGeFRyMEFaNmp4aEQ5RHRiT01D?=
 =?utf-8?B?TGRTVmVXTWVtZGhvcE54NFRCd3pzMnFwZENjU3BzTkg5TXJ6ZUFOVTB5RU5W?=
 =?utf-8?B?YVgwQlBobmFYOE1jdE5qaytTbWxtZ3YrMFVxeGhSakFiY1BsenYrL1M0K1ov?=
 =?utf-8?B?ekhUMG5kMFZ1cEs0OWEwVmxINGhpbm1HL2MrdDdURzZJYSt0bEUwYVVlNEp6?=
 =?utf-8?B?SEExb082L0UwV3I1NHYyVEh2d2JDb2IvMjFPUi8yREdyRUhzdkFMTWZlZUx3?=
 =?utf-8?B?ejBqL0FVeWlGN09sR3dmc2FKd3lXb1hWQ1JJK20vNmo1VDZOdk9Cdm5sb2pr?=
 =?utf-8?B?WkVSM2FpVFY5K0dJSmNscU5tNi9RZGlTaHdjek9Wa2xWYUZyUTNWak5SRklr?=
 =?utf-8?B?eHhSOWtKeEdjT0NXbmtOVmlFdGhQcVFiRDFnSStsVFNrNUlFUk80TktGcWV3?=
 =?utf-8?B?SFVacWpUandTWUhYaFVkaURrODZKTjVKTFFpaDlmTXoxMzJwbDEvNUdSQjZZ?=
 =?utf-8?B?bU11cisvUWlqNW10S2JERDhZVWovR1FoTm13bFFtNXhGYnl1QS9Qc3JYM0Fw?=
 =?utf-8?B?NVRrckUrZ3VRaUN6V0xqNTJzU2xXSGtRUGIrVW5EbDFxa0w3NDlLUFNER2Js?=
 =?utf-8?B?RzNxMGlsdmZaMU5lYU11SndCVFplMWdCTUFQbmVHUk5aeXJXNUc5ZmlySFFK?=
 =?utf-8?B?ZXk0cDdxYmJkTTRSUDJNZ2s0UDE4RHhyOEdId3JWMExQb0NBNDY0aXc1K09Q?=
 =?utf-8?B?VG5NcFcvTjdLUm1lU3pNa2lNT25zdTA4WXoya2JZUlVoekh3Z2NoMkdib21i?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pkqahgPW7dhppbLENFckz3tzKg2Kaf5G7tEODAfiazO95PGF/3g0W762eMK7Jd60XDSI1fOHKaiOdg25+N/U5yuhvqW6mou8M8Moe5HERFxMGwZ4bP2xDWkRqGti2SSTcTWF1wNlW09Ft9J9nqDXNDmIZkhVz+Refxky7/F3Zm/AmFCqlCRZVIQxdBaRzhxt7P7DjUhSlC311iiABMFXLx4OS+EdQGK6E6eX7QxGQkCU/LFxUy3v6F/VfWSr1SHC+BWRQYGcu3PbvltJYvF7fQAtXnT1iDS9UrZxNv0bv7D95YcCqEma1eFlP1DYhaRjaxexS/0ESSUHvBAWnPo/Gdpefw7oloKbvWbPRWrnM3s9QyveG6+wRpIPUKyhlaXrLJh9QEgCIN+ZqLojSMqt+QE+rJIz7Gq/ayIlGWqrFtOkftTr0OxSeDbw1DAn8vCqnTRqSt5bEKTMxU8ROahWK7+O7+dXqhBYsR6kD1IdnsN+EoGVbzo0D5XaXcRB0s/GiCFenw2RNSxjT67l+BfP1DZichdQmAHwC9JytOneafU6QBqN/CyIUEuIphchq+a3ntHgrgWJ4lVALEESXVuQtQFmZTn5LeGYaKwPD6k3hpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ec116-1fec-42b3-86ed-08dd8c86f5e6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:15:43.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7WMmWxBdXvqLe+/E/BtMEXMZ6rlrCTGl9IjSki18d82lYZUjc4L6CyG4BXezHmdZnHKyTPWsQFdf6L3d6pdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA5NyBTYWx0ZWRfX4ETDJUwsJY/i Mb3cJm9br2OdRexe7a5rdtXUsrBTwLvl2YPpl/Z5grBKmKIB03jWKLmQRXzOZUulczP/Qr+VE0S 7rkFhPVJn1okonn7vN+6Y2xNoDUYNmbK/7jcVw7qddlQaQzifYAjTGz0Wbak5zin9qWZi7XcFSt
 RQWW0dzYJn54FV926evwydRPBqrLGUatboEah4f84IxA9c+NY4/9XFawBbRjHLdMMuIMBZTMMgV SiEM+3B/X8FuAlkJU2On9C3kEsuVBILc0kdVKQ0hrvzjx/KYp1EBJr1bgZMhhishE9KJL9BlhgA d1fxoMezsuJSpGCtittzAtBxvDMiY8lSq5iU6P4Fh8cF+/DJNaG7hO7iftQtSwUX7y8wuJXChvr
 K2arpIhyG2jvs/VgiVPJVFSXsmtYE9ow/8RQmqM3JHCkIFdJncfQCS5oHG+fIryuewwRUQbJ
X-Authority-Analysis: v=2.4 cv=ZoDtK87G c=1 sm=1 tr=0 ts=6819e158 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=4tu2a3NUN02yIaBJ2e0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: UlpuM4xHQkLdxQPq2RCEprwG1MuUgQuR
X-Proofpoint-GUID: UlpuM4xHQkLdxQPq2RCEprwG1MuUgQuR

On 05/05/2025 22:10, Andrii Nakryiko wrote:
> On Fri, May 2, 2025 at 11:09 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Fri, May 2, 2025 at 2:32 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>>>
>>>> On the other hand, this seems to help to reduce duplication across many
>>>> kernel modules. In my local test, I had 639 kernel module built. Overall
>>>> .BTF sections size goes down from 41MB bytes down to 5MB (!), which is
>>>> pretty impressive for such a straightforward piece of logic added. But
>>>> it would be nice to validate independently just in case my bash and
>>>> Python-fu is broken.
>>>>
>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>
>>> Looks great!
>>>
>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> Should have some numbers on the module size differences with this change
>>> by Monday, had to dash before my build completed.
>>
>> I'm curious what BTF sizes you'll see.
>>
>> Sounds like dwarf has more cases of "same type but different id"
>> than we expected.
>> So existing workarounds are working only because we have very
>> few modules that rely on proper dedup of kernel types.
>> Beyond array/struct/ptrs, I wonder, what else is there.
> 
> Well, turns out I screwed up the measurements. I thought that I used
> libbpf version with Alan's patch applied as a baseline, but it turned
> out it was libbpf without his patch. So all the measurements (41MB ->
> 5MB) are actually due to Alan's identical pointers fix. My patches
> have no effect on module BTF sizes (which is good and a bit more
> sensible, I should have double checked before submitting). So, if we
> are going to apply the patch, it's probably better to just drop that
> paragraph. Or I can send v2 with an adjusted commit message, whatever
> is better.
> 

I did see some small changes, so the fact that you've added additional
cases here definitely helps; with ~3000 modules built I got ~50Mb of
module BTF in total both before and after the change, but comparing the
results using latest pahole (with the pointer-specific fix) and your
change (the more general fix) we do see some size reductions:

$ find . -name '*.ko' -print |sort|xargs objdump -h --section=".BTF" >
/tmp/modout.base
$ awk '/file format/ { printf $1" " } / .BTF/ { print strtonum("0x" $3)
}'  /tmp/modout.base > /tmp/modout.base.sizes
# rebuild pahole with Andrii's change
$ rm vmlinux
$ make -j$(nproc)
$ find . -name '*.ko' -print |sort|xargs objdump -h --section=".BTF" >
/tmp/modout.test
$ awk '/file format/ { printf $1" " } /tmp/modout.test / .BTF/ { print
strtonum("0x" $3) }' > /tmp/modout.test.sizes

$ diff /tmp/modout.base.sizes /tmp/modout.test.sizes
198c198
< ./drivers/char/ipmi/ipmi_si.ko: 11575
---
> ./drivers/char/ipmi/ipmi_si.ko: 11539
1810c1810
< ./drivers/platform/x86/ideapad-laptop.ko: 7122
---
> ./drivers/platform/x86/ideapad-laptop.ko: 7086
1952c1952
< ./drivers/scsi/mpi3mr/mpi3mr.ko: 52625
---
> ./drivers/scsi/mpi3mr/mpi3mr.ko: 52589

So while numerically it isn't huge, it definitely validates the
principle of making the identical type handling less specific to the
cases we had encountered. If you want to resync libbpf github again I
can update the submodule commit in pahole. Thanks!

Alan

