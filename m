Return-Path: <bpf+bounces-58950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09598AC4343
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876871899609
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2FD23D288;
	Mon, 26 May 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvSZdT5B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tjijh+8h"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496E27452
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279310; cv=fail; b=jJNqWlfVZbf+pjn0+le/YtGjOUuFytpMLlWZBGc/GJ6KcAopeAXe8HIBKJr48/5MFHK+i0exgRECjabVkIvGb0+YlaLBdtAIvzY5kW+JN4SE/sz9I1z+MOmesKymvEVrvQksFB8SLi8Gee8ZGCDyfqtLD5u76Zfq6mqStjGOgNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279310; c=relaxed/simple;
	bh=akQd/0o/zy7KaRxctE2yYPWjXw400F0c6zw1NE7a9xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TkOHPdEsFB/nCjbds5d9CQZxd5LLaHyuf14KyiZ1Rlgqkvrz+Qv0aVvrK4PqVMxcWLwvOT4ybbGOwdftGaczzw10h4ewm8ifJmXLavuNI7V3KT0skAOmdsw6hajhzkSUdGYreVmVn9iK29KBWGesQPdWK16GgWx+Q+s6m9uVEik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cvSZdT5B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tjijh+8h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8uKfg026614;
	Mon, 26 May 2025 17:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dZh6XrhdLZuyUJBq2oSk1NyvE4lWRwNuZb0xcIv6W2E=; b=
	cvSZdT5BwBxUqeJH3sTQOQ91I1xqakzOZRLR/PkqxC6mkenbcUicOIClLgq7wHdj
	Gi9v0jjdLgx24AfSBL1mZi4z48mH3iG9lcvwCkPfRkNSJTt7nTkYteEoAJZxUFkL
	b9Tqdw/QYL5hhXQbsVFzgYdy9eLcFhZk0xnUBMcpD2tAlens3WRQPGdwFjRoUyt9
	o2ljQ/JtuwDPWq8XLaeZH1bCTeC4Y1o9xzECWiFJYwEI5u2XSTTDeXxvRXXuf1HI
	0CHYNY9lbsZ+zKprRFpJNm7Wm40/NiLr9uhLv8+Zc8zjOQdaK/iUQleoVuh+2NYO
	tW1EBFcVAhJI8d552tIXCA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pesp7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 17:07:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QGKHW8023219;
	Mon, 26 May 2025 17:07:46 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011046.outbound.protection.outlook.com [40.93.199.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7y8q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 17:07:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1WyNTXqYRoGsZPweSPObY5mxeHw9l9tB2WIiLIcVUJ/qNEccNqIT/AT0QHkdbnF2m9H6qY/Q1uR9XLbIb3Ja3OygJPdHVd41FHU1l3MG5Y6t9/PE+uHjY3+PNQcN6Kfg3yFYj13Fs8pgqkeJaOi6Gx1wdSDYwodk79/H7lsSerWUyfkdFXd7Dazi4BXegysZi1Ymohvt86FrTfb+jYBnFmTE1WK71d1ASFBdYXPog2FEVLF72M3lnnK2uTg6cemlMInPqfCIeRQqqa68uJbah/+Ym5fWCxjhDshNO5MKHSAMnSJhtdLPeewSVoegD82wRtnCmxfKDCmPma2qDab/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZh6XrhdLZuyUJBq2oSk1NyvE4lWRwNuZb0xcIv6W2E=;
 b=TJfjjHJOQsfmn/D4df/XoSLSVtNiclGAaDjtzpqwt/kGYUgMqL94XvY3eI9MRbRqq44yXAQia7cEUP7yQ3gzjJPWEWDodyRSjxnf14cAd2vCmXyByKGHy45VfyjQ9yarQwcqlMtzSob51xQoYr82QQrbqOpKhAFPwzowhcyc5/iCEie1MrSfRDXR+a041/ACItgmhjG9vYpWAfpab2k1McZqA/GnbIRDqBJRu/tf1xuOHpXlL9TZY3vnj2C2Wkny2wxdoBDmz7x//pE/sPIc4/D7G0r3IfGmBnUOeDtHhddbAZWAE9qF0YTJ59SOOc9Mry6cs5NUa/CGCeQ75C5ruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZh6XrhdLZuyUJBq2oSk1NyvE4lWRwNuZb0xcIv6W2E=;
 b=tjijh+8ha1RYXdICInuieazWtBFN0YUmvzKWNbcUCdIlxAYWxsbONcsUBCG8DtsL49dU1Vfj+cqzweNfKMfnGK2isSBjPdcpAoaExe2znP00nksrLfcEpt8mA6p5Ny4BeksoQfGrWc/CCzwWFOYQKHu1NH4Es4ygW3dkqHVS/Hc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 26 May
 2025 17:07:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 17:07:43 +0000
Date: Mon, 26 May 2025 13:07:39 -0400
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
Message-ID: <vcshoqdv3e5wpkfagwiexcxwc7mtlsm5j2d6rwblmcdadao6i2@c4av5rmwfthc>
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
 <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
 <pzuye3fkj6fj2riyzipqj7u4plwg6sjm2nyw4jkqi57u3g2yp5@jmvn5z2g5i7x>
 <3b792576-6189-4f53-b47f-95875181a656@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3b792576-6189-4f53-b47f-95875181a656@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0463.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bea9545-13de-47d3-d941-08dd9c77d46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTA3RjM5aFozOFpMdWM5ZFFMV3ZwbFVCQXlnSk51c0NBRFROZ0dKbENZdlc5?=
 =?utf-8?B?TzJlUG5yRGtrU3Vab204czY4QkpnSU5mbVZ2ZlMyYnZYdlR2STdoNVhMZy9i?=
 =?utf-8?B?dW9Mb2xpczM5UlNtOEFMMnQvZHBZVFFrcGh3QnNCNFFZZXc1TlhDdUkxNVdR?=
 =?utf-8?B?aE5qREpxUFVQR2M0VHNISkdUenVoY0FGUUhaelZhVmhTbDNjWnRrK2FWZHhB?=
 =?utf-8?B?bnZuYk16QjhGSXZCOGJENTA3aUp0Qk9ocmtYcGhCZXNTTkJJNFd5VS85MWpY?=
 =?utf-8?B?cEovV3hDUG1obzRBY0o5TUsrOERTYnRDSW85ZG5uTm94b2YrL1dINkVIbVE1?=
 =?utf-8?B?cHJBRUhzd0wrRENiVENSTXduZ2hQSWJuMnBEZGFwU2N2N09mRjR6MFUxazd4?=
 =?utf-8?B?dDczY2xGckk4ajVKN01HK2k1VlVIQ1BkeGpFNldSb0Z3dnVpVnNYakYxTVA2?=
 =?utf-8?B?ZW92L3ZtUmlqQVlCR3FHdC9WYURNYS9XRm5XdU5CNSsxZnBxQUs5Y29KTlhx?=
 =?utf-8?B?QzRyVnp6dnhPTUQ4elpidEs2d2dIR2U1U0N3VHVvVnVBcTAzQkhaazhTZWV3?=
 =?utf-8?B?bEZXaCtubVQwdkk3cDdiM3g3MG9XMWZaTWRGd0VucmlCcE9lVEFqZDRjYWFJ?=
 =?utf-8?B?RTdNMEhVUmM5U25sWW1LeTNxTUdVSjM4VlgzdHFWZGErU0JOVFFYL09iWTVB?=
 =?utf-8?B?QjNHSTUwZ1QyS2w3MXA5eTZxVC8yTTRVRVZGc3pFME43MWp4OHE2Q3hEYVdK?=
 =?utf-8?B?SHdpSjJHTUxUbGNOaGxVa3cvKy85UnBJL0Y4UzBydVMwdHZ1d0hsdkpSdXQw?=
 =?utf-8?B?TW5CT2lsbmtGV2lTcXIzOU9CYUtUT2NnVUVjTll1N0tiNExpMmxKR3hXdDFZ?=
 =?utf-8?B?eHd0ak9kL0xzcTU2anN5MjNOV3JSbWZNTlRFVGFSR1QrcTk2MGIybkF1cVV6?=
 =?utf-8?B?NU8wMDIwRElKRjUvd05FbDRKZ0Mvc1JFeVZER2VBRWkwVngwMlhya3hCeVBT?=
 =?utf-8?B?RnJTQkdJcWwxUWZIZzB6cHUzeHZrb2dzditPZ2E3M0kxNmFvVFFGSmhGUGN6?=
 =?utf-8?B?Qy9DRUZWZk9UTGJyVzgrcGNiaFBUU1J0NnJub2w5NmxVSXJ6amRxQUZaa25a?=
 =?utf-8?B?T2xpSXFTM2xqdEpySWxlSUV1Smo2Rm13REZjdWU5K0JaZ09VajcrOGVEMFNi?=
 =?utf-8?B?N3N4ZzczNVU3YW5tK1RxZFQ0bUQrcE9hbWR0SjZwZnNNVXFmUTNJeDQrVFZG?=
 =?utf-8?B?Y2pNbWZ1UEpDL3IzWmp1S2pwYTRVMFpON01nRHVEWFhLMzRoUkdpaEN6UFBS?=
 =?utf-8?B?MWlaVWJHSVVsNldmWHVHb0gvYXpnRXdjT1JreFZadmZiazRvODRCcWRxU0JJ?=
 =?utf-8?B?QXpqakdpUGRvSFluelBJSWg5T3RMNk9nR3FVeHpiU0tUbUF1QXdRZGRNZmRJ?=
 =?utf-8?B?UlhNYm9QUk1tWWIvc1hKbUJmcTJJTm9BWS9YYXFqaC9Meis0R3ZFaFlWamx6?=
 =?utf-8?B?VllENjArdjVMeGhxVk9ORG81U2tKRFN6bkFkMlFtTGhYclZsOFp3cjVQWU11?=
 =?utf-8?B?SC9DNUNzWFROMyt5VEVOcGN4Qm81QzdkUWV3b2w1cjF6cVE2Qkx6WjYrK1hK?=
 =?utf-8?B?aFIyeFpUUHd1NitzRi9wanQwSTJ0M3FBbUVGUU9UbzFmeFVXUVRVRWNEMFUr?=
 =?utf-8?B?Z2J5OUY4MHptNWlZZlVOdlhlMkVLd0JXd2xvSGVTUG5kQW9NdEo2dVpUWGRX?=
 =?utf-8?B?MWJjb0YxSG5MMzU3WUpRQ09UbFBOcG9QeTlIM2lxM3J0S1VDc3RLLzF3SlhH?=
 =?utf-8?B?Wi9UazZuelR4dDhlVHJ1TlBiYmFPdGF5amRxNThGNVFqR0F2V1c3TlZCazE2?=
 =?utf-8?B?T2lqMkVJTkt2Nk5wOTlWS0hsY2t4Z2NWTDhnOUYvajUzdHBIeEJkcHBHMnU2?=
 =?utf-8?Q?DNCJVM8M9p4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUVyWktXZU5Qa1dJMUdZUWdicUg4VWJEZW96ZXp6MnBmN2RDdmgvNWNTZ3ZF?=
 =?utf-8?B?TnIwL3llN0RmWFpRRis4SDNUNisxdUo5Y2tUMk5XRkUrdGFKdnl3TzUvLytm?=
 =?utf-8?B?MXQrQlhSK2lNMkZSSHNQTEc2Z3A4YnB2bjcva1ZHa1FYMjg5ZnB6aDVoSHJP?=
 =?utf-8?B?MjduM2R5U2pGTjhEQWNYRU9vU3BUalFUb0NZYngrdDl4UDJZc0ZCSlUrNVQ2?=
 =?utf-8?B?bHhjRnRjdnQ2R0M3c2gvZkNRd1NudTdLeGJhcDlpSVhyY3FzUlNXNTR4ZXg4?=
 =?utf-8?B?YmV0c1JtdTVhbHhjSU9kWmdTSjhLcktGQ0xiOWJQSVBzUktyNjh6L3kzaDVC?=
 =?utf-8?B?UW5oenJZT1dQL3lrVWVHdmVZRVN3SzN3cENDc0l6TlNiSTNzWEJJTktWdW9N?=
 =?utf-8?B?NERlam0wcU02VTV0RWc5dEIrRUE3REs3c0V4TUdlcnhwbmRSQTg4cEhISUVS?=
 =?utf-8?B?T0JVTkhjemxWeXhXOXoxdlZsTEY5dGlWNTNVR3c3NlQ1R0tuU1ZHU1NFN1c5?=
 =?utf-8?B?NWpWVUFrTjF0c3I5WG9vdFRwT1d6aTBxUEVNcC9nRm5UMDVxODc3a1h2bFR4?=
 =?utf-8?B?aFF1V2JiOUhHTGM3M1NReElvUUhFRXVvYi9EUFFUTDkrbmhyWTlsNE9pRnpS?=
 =?utf-8?B?dHhwRmxKUk95U0ZLUEpLZVRIMXpwRjYveC9mcnpMZE93ZzlXdlVXbVJXWVAy?=
 =?utf-8?B?cHE5bUZiM3dnaUpzWFNhTTNDTlpySEV6Y1FNbVRkT3JYTnVwZ0VKaFFZb0Iw?=
 =?utf-8?B?UWxJUC9hdGFmMk0xdWw2dDlERklMZkh4RWt2WFNOSWs0QWM5aUVEV3hjS3pj?=
 =?utf-8?B?MFIwRUtkR2VTRktpcUlsb1FLUEpMaFdaYUFzeHIwSGJQL0lCV1U5OHB0M2xQ?=
 =?utf-8?B?Yy83RnFJcWs1dGZqdERhQmlHNmxGS2lUeU1leVFwem1wUk94cWJYWktRSHNi?=
 =?utf-8?B?YU9HaHdLT1JISmhFYWpROUJCTnoxeEpScWE5dm1KUDRpS0lsOGxFdTY5WUJ2?=
 =?utf-8?B?dXJPdDRjVUorSGxUZGp0cithc1FqRDBhUUVPVzRaL3Q1Y2pFay9zVnNyT2tS?=
 =?utf-8?B?UUt2MHpwWnN2NFBXbFpLSExqSXRVcUNBelVHOEFvWkVtdHNrempsNW1Fb1pN?=
 =?utf-8?B?Mllra1h2YXRmNk1VYVNYMDNPb0t1OFNBd3NjbHdhSElJcXR0akFSZWZpdGFS?=
 =?utf-8?B?bWN4VzhsNFh4QTR5YWlvSzNLOWkrVTRLYTdJTUc3amdhMmZ3YVhzZnZjYkZJ?=
 =?utf-8?B?UDF5K2dnTEpIRzBVOVhNczZ4T3hML05teUxuRnlSSjczeVpYY3QvNGZzNXo5?=
 =?utf-8?B?dXgrcXg1eTBVb2c3ank2Q04rYmloZ1lFRUxzNEpaa3kwU2o0WUZUMUVLbkh2?=
 =?utf-8?B?am4rVytpRU5tRUJxcUQ2S201dkpOeTcxZXpHRlJyNHRrcUFmbnBJZVdjdlhP?=
 =?utf-8?B?M2FmYUp2NzM5SUZCaXZEeE1XckIxaC9jcmp6TDEwSXBoNW5xWm4xKy9LZEdY?=
 =?utf-8?B?U3cvK0ZDRjAxdzFpdElzMDBCZ2R4Q2w3TUJ6ODJaUzBlWXJVTHhIMnhRUWkx?=
 =?utf-8?B?RUEzN0paM0xydGdaVFRFVjVsUmRFVVV5c0V1T1ZyS01CVnlDNk9nTnF3dXpU?=
 =?utf-8?B?RHJrN3ByY0dUbjU5SGg0SDgzbjFmUmttYjFyRjFDVUJjVDVJV3lXUjc2S3Fu?=
 =?utf-8?B?RWluNWZteEc5TU9pbHQ0QnpyRTlaNkZOUHI3YitaZ21Rb0YwcnhQOU4xeUhv?=
 =?utf-8?B?M0Y0OXdYVEN1NEZWc1J5R3ZiaHpwbkMwOEV1Um9WdDFjclFIVzhJVjV5SWdu?=
 =?utf-8?B?bEtMbGFUdnZNalRLWjNBZlVkY2RIdDlWcGVOWG9XZXVtMWs5Wnk2WVEzNjNy?=
 =?utf-8?B?NEdHWGU1ZGxuQ2ZTSi9DdS9URzZ3SG85SndybVJJK1pqUFZJdW4vZDUwaGRZ?=
 =?utf-8?B?N0NDaUdnUjlyeUpUNlJSTDdsdUNkU3RTcWUxSmdvM05BUlhEakJQOTFuVld0?=
 =?utf-8?B?SzgrUWNrT0pvNzVpOWJVVFZUYzh6NkFIbHN4bDZPR1pjZk5vbHk0aFZuNjFG?=
 =?utf-8?B?TUhXcndNdkt2anNlNFIwUEMrZ0pKN0l0V3hCOS8xSEZ0NEtyanlxTUhwUUV5?=
 =?utf-8?Q?ISsA/LcPAMXxCrf28EgX7uqUC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WnEFXM+rJctjWS147PB62db/jF0ZyhLh0ei1krUfVP7Vez41ZxeWMXunfOicCGksuwCIiZuzSYAgwwZwIoyqfPOSFEZM8geQrfEruj7ZuNKHeu1mJihrXSSlt3uHM379S2pse0XBOEPNpoNX44VUWh1HefBIcdNVVwMrCjxa1MF2hSiv27HMoUPkDdtp71+rjOmckn8CcbEd4E2GSu4J5YWHBDgcWNCOElwrnuvcbmD0Ye5DbV0smcL1j0Sq1RIPQ158XBpda5CZ5Tlm3Xj8f/5ITgxeeRiC6/ROgMdK/eKoxkk9qhl0JxC+QAgKqnEdLMa8sAuZTwVjXX3aMqZ9Pz5bC13UK5yugspHstqswL4evskVU/bqlZQqzi06n0WLyHka5mtBPJ9AoYhcEDHLZ1CXANxAupuVNrgjYlA0sQf/+137CgaacZmSbosO7kRv8WAhtglgpk4WadjHNbC89x9Tbp2h8w1KrA2la9AyssAv262SAqJD38uzdjcGU9X0NWL0VqTSnZwuTb8zxNbp59bJHiUUIAgLITF4IUdrZV+XiQlSVph7R/qv5oq2j74VA8qriajXTwtocf31flmE3wItFXwMQDsD79dp+1FM0vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bea9545-13de-47d3-d941-08dd9c77d46b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:07:43.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18Ljg3VUW4N9ssDW3WPL6aDGKv/VvcW65smBka1Jc5bzmr+XA2G2WMXlFt38SUJzV5DqPibnMEdePL2lqkL4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260144
X-Proofpoint-ORIG-GUID: pLeMrvWL_bES5CPepJDwE7-4-6S4bX2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NSBTYWx0ZWRfX/29N6Uopz0R4 LlUB5s2UTR/G6jLMGzIW4Y0FA3Flr8JhGkycnZJ5TJs1OTk61UIAXzFvJ2M2PEjVaX/v7M1ZRgC 8SJe0Aqgjhgku8tfkxOl9M/q6Tb5PK5N4cI2QwxaWkrkYmj6+VwLmBapcMLT7/HJAK3ZdUz4JFA
 FkNaH286nCsgccJrc9x2OkPBh0XYG1AXL0+uLqpZIIaB/r6XIiP8ovs3n7xSCCPSUCtrZ8Zy0X5 Yp1CQ+UtqbVmvP3BH/SEtWc0aJMuHOTZK0IZ6udYVcJEU8kdGzb9zFpMPEK7ez2IoPL6mnA4+5x JlnLU44yg8+eeHaz1uwawTYeba8IzZwjq+As2rKtHxtnVQPlEmgiww69wWghOXwPZtvEQULF/QB
 YO+1w1i8KWepZq3Hfzv8kuc50jXhuRaYvof9rqE3DaqhKk1dpuQvulDrH6me70VS7YuuqqE1
X-Proofpoint-GUID: pLeMrvWL_bES5CPepJDwE7-4-6S4bX2q
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=68349fe3 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=0wrxtyLKE_zZUax0LwUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

* David Hildenbrand <david@redhat.com> [250526 12:51]:
> On 26.05.25 17:54, Liam R. Howlett wrote:
> > * Liam R. Howlett <Liam.Howlett@oracle.com> [250526 10:54]:
> > > * David Hildenbrand <david@redhat.com> [250526 06:49]:
> > > > On 26.05.25 11:37, Yafang Shao wrote:
> > > > > On Mon, May 26, 2025 at 4:14=E2=80=AFPM David Hildenbrand <david@=
redhat.com> wrote:
> > > > > >=20
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > Let=E2=80=99s summarize the current state of the discussion a=
nd identify how
> > > > > > > to move forward.
> > > > > > >=20
> > > > > > > - Global-Only Control is Not Viable
> > > > > > > We all seem to agree that a global-only control for THP is un=
wise. In
> > > > > > > practice, some workloads benefit from THP while others do not=
, so a
> > > > > > > one-size-fits-all approach doesn=E2=80=99t work.
> > > > > > >=20
> > > > > > > - Should We Use "Always" or "Madvise"?
> > > > > > > I suspect no one would choose 'always' in its current state. =
;)
> > > > > >=20
> > > > > > IIRC, RHEL9 has the default set to "always" for a long time.
> > > > >=20
> > > > > good to know.
> > > > >=20
> > > > > >=20
> > > > > > I guess it really depends on how different the workloads are th=
at you
> > > > > > are running on the same machine.
> > > > >=20
> > > > > Correct. If we want to enable THP for specific workloads without
> > > > > modifying the kernel, we must isolate them on dedicated servers.
> > > > > However, this approach wastes resources and is not an acceptable
> > > > > solution.
> > > > >=20
> > > > > >=20
> > > > > >    > Both Lorenzo and David propose relying on the madvise mode=
. However,>
> > > > > > since madvise is an unprivileged userspace mechanism, any user =
can
> > > > > > > freely adjust their THP policy. This makes fine-grained contr=
ol
> > > > > > > impossible without breaking userspace compatibility=E2=80=94a=
n undesirable
> > > > > > > tradeoff.
> > > > > >=20
> > > > > > If required, we could look into a "sealing" mechanism, that wou=
ld
> > > > > > essentially lock modification attempts performed by the process=
 (i.e.,
> > > > > > MADV_HUGEPAGE).
> > > > >=20
> > > > > If we don=E2=80=99t introduce a new THP mode and instead rely sol=
ely on
> > > > > madvise, the "sealing" mechanism could either violate the intende=
d
> > > > > semantics of madvise(), or simply break madvise() entirely, right=
?
> > > >=20
> > > > We would have to be a bit careful, yes.
> > > >=20
> > > > Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, becaus=
e these
> > > > options also fail with -EINVAL on kernels without THP support.
> > > >=20
> > > > Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
> > > >=20
> > > > What you likely really want to do is seal when you configured
> > > > MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
> >=20
> > I am also not entirely sure how sealing a non-existing vma would work.
> > We'd have to seal the default flags, but sealing is one way and this
> > surely shouldn't be one way?
>=20
> You probably have  mseal() in mind. Just like we wouldn't be using
> madvise(), we also wouldn't be using mseal().

yes, I do - but mostly in terms of the language used and not the code as
that can't be used here.

Do we use the term seal somewhere that allows undoing the sealed thing?
I'm _really_ hoping we don't, but am almost sure you're going to say
we do.

>=20
> It could be a simple mctrl()/whatever option/flag to set the default and =
no
> longer allow changing the default and per-VMA flags, unless CAP_SYS_ADMIN=
 or
> sth like that.

Ah... okay, as long as we have testing I guess.  I can see that getting
confusing.

Cheers,
Liam


