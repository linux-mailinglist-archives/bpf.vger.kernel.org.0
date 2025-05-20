Return-Path: <bpf+bounces-58540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2568AABD3EA
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C9F7A972E
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13CD268686;
	Tue, 20 May 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hM2lnp8W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BpHh6/qj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345C261568
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734629; cv=fail; b=eqJx9zl82RC7zGmlCfClSoRg4042jXn6jrl2gnVETZnIhIhIxiRwhGK+b9DssnIUPS/mE6XgKUKtDWd3sDo1hgOGOw/yD90gVAninkSKiB9ZRL9eCy9BfV16g1TXKKGbeoUZn8CtLIOX7/te6rAoTKAwZtLORewOM09fZMa8Se8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734629; c=relaxed/simple;
	bh=QeMwEjOfW7jHP5O8ecx5z2+GZd4wBZN7+t441YRYYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QzNU/IHVTsDIRJ1FYAvUwrhNB+rN6Nzu7GbOKn872QVeDZSMM6Q1rh/1FflNl78jRAJncOEJGUPtdvvOISt7Cr741m5jz7An/5w0smTKjlc1WrLOPtyha5CGNNz4v5WHbyr6KZosWbLpEP9a7sUcTGbZWYgpk4ANZmQyGvGf+Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hM2lnp8W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BpHh6/qj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9MvFa029146;
	Tue, 20 May 2025 09:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QeMwEjOfW7jHP5O8ecx5z2+GZd4wBZN7+t441YRYYWI=; b=
	hM2lnp8WWtEdDd2q+LydWzqfGNEnPEOrwj5lhNNk8MB3lvXV3Q7ZPT88zrR95Bk1
	qah6hyekGP7+uGnhbyY0/nqX47nBgUSYWuhWCFnePX/CbBxL+sA2kgklD0Ardhtt
	9VJS9uirQXt227Pw3xEXAeIgysyvD7Zzldn5c8lP8ytyhCALc7/hQ4iXxLzGx1rk
	dFdOhcKoabP6pDg7PPwGcYwik3h1rInZxRLhnjz+PcTzDpA55s5bAj5QvnhFc/2U
	NS7z2Zk+BXY2lgGv78TX8GLnYYwUGtrFlrMu8E6tHH4YVw07MILHax5YTQTKL1Az
	Z+aLMU9feDPXb96TdNZLJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pk0vw0j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:49:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K82jEx017396;
	Tue, 20 May 2025 09:49:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw81a1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 09:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOKKtS6QcIR+RzLaaikESr0ucycqW0KUNwk+GXSx1QsibIfYK3S095s53PKYtdkoGFSCLXHfdZn0G5ym0+dnqB1E3DVORYdZEpeBuZcWWyTVuD8EB1JTYIIQrCturVdXxvdQgktBixPdyishY8iI/nn+gMV5EEggLb11fN+INu+QeCATmDOm+BmMPAh6A9/bJ52sJs5rkJ3aNF3KfOWUC7kDYTAgTwVV/Rkz0dnMqWOeXqB+vFSHwqZk0OC6smEg7YRss0H4gNOo4IHn8YG87kUef7WhVoQwDzlb9Jn7rcblWe57GhMCSxX/O6nV986UqV41CwzEr91BzjzH9gJACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeMwEjOfW7jHP5O8ecx5z2+GZd4wBZN7+t441YRYYWI=;
 b=vUVCWvbguaLt6rkFgMg/DD6cKTopKn6uAH8e/bguOepa90XqpTaTAFZvJ4XAgBAr1+dGe+2nM/3au8hY++zj6Z8GBMYM8qkMi2v1V6RnLlc9Pbmh53I4/OYtCAGGooKgd4rLCJYO33bUDIeKr9fwyuXVvSRzA9lLBKHQrzurnjwxkps7tZxramjEeNGP0Uo8vyfGMnjrRyZVcX02uqwK3uneuNna2pgTTEdRYaKbcs7NNyvv1aq9VLxaa8qUX5Zq+D2RN0Pr7K5bk1TArUeo3BNSmth4meFRPVpzfAydna09+YvQfKohRL2ZJwfwTdEfJCupygkzB8HUt5cq29CyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeMwEjOfW7jHP5O8ecx5z2+GZd4wBZN7+t441YRYYWI=;
 b=BpHh6/qjlFSKn5G6N+qKAAbdsz25h7m87FKaTbT8bFFoK2Lg8nYyFxyYpOp7O3cKdpYxtC9bk9yzRIa2mazepvHG/VeoWDzoH0SdLR+vgd9BfuHIn8k1OkvtmVOMFktVjBxzwAAFFfhGAOtezibbR8n0osJJ29YexCu8FKWlkH4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:49:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:49:42 +0000
Date: Tue, 20 May 2025 10:49:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <c77698ed-7257-46d5-951e-1da3c74cd36a@lucifer.local>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <746e8123-2332-41c8-851b-787cb8c144a1@redhat.com>
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb4013f-f0bf-4d2d-f3a2-08dd9783a4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXh4TXU2QWVka0NXUGorMHVqbE4zUWJDbWkvVHU1SldVR0J4d0NBTmdxMHBU?=
 =?utf-8?B?YjJ5bkdDQ2RqQ0had3J0NUlXbC9QWjhtSDBzUmlqakV1VHNLRFZ0OHoreVdL?=
 =?utf-8?B?aVUwVjgxTkV2bEtQcXAvT3JTSjYxU3U4RHlGd3ZyYUZ5WXJTSEQrOWkrOFNl?=
 =?utf-8?B?ZDRqVkNvYUo1a3pHQURuMXhnQ1VIZUtWUVdrYk95TERnYURrL29MOEhYZlM5?=
 =?utf-8?B?Y0NMWHBzQWR5Mm9jbGxKSy9wREMrMnFab3RhcmdBOExOdDNWSUwxMStXdm90?=
 =?utf-8?B?YWFKTkZ3aTE2OFFRdlV2U1JOeFdQenE5N2dicFhJYVMyN3pyRFdsY3dwNUkz?=
 =?utf-8?B?TXo5WU0vR2xGWGxScUpiOEdoRGNJZVdvMkk1cmlFYWNlQUt5dmNnQmtleG9x?=
 =?utf-8?B?eUxWNy9xa1dBaUFuNG8yK1lhS0k0SFpDRTJ4Qm1kNkJWQTNHeVBDWFVQZE5n?=
 =?utf-8?B?NHBrYjJWeGN5d0FPZEVXQ2s4ekpkR3MxbVRhYVZ4USt0M1pEUWtvbmVCbGZk?=
 =?utf-8?B?a3NhcVV6YlorNllzZXloZlI4Snc3R2hPY3dEbnBYMjVWb210L0JnSmhkUlFP?=
 =?utf-8?B?UjRtdktXL01oQjZHVmNna1p2K3M1ZUMzdEVVQWtkUVZRR1ozcFhzcngxWExt?=
 =?utf-8?B?Zy9zaHVQSU9IelArUDVDZE00bUxPNWszN21GTHBBZWErQWo0TStmUlB3alhE?=
 =?utf-8?B?YkFCSlkxaWxhQjMvOFlhckkyYVRUdWFUa1BZblhhZ3pRb09YVGRDZnVHTFZz?=
 =?utf-8?B?ak1RMFVsOW1wZFhQZ2wraGI0a1Fua3RiUGk5eUp4Njh5VlY4NFRzckZNZWlO?=
 =?utf-8?B?VW05OFFZc0ZXUGNvUS9SSkVlNXYvTklCM3FRQ2xxL3pPVlVpNjNLRUdjQlhW?=
 =?utf-8?B?QlU1RzZoVFcxQWVqOVpSWDI4Y1BKRWJUWHRsRWFzZ3kzQ3JaSk1uZmMySmVp?=
 =?utf-8?B?MXd4RUJ3K0hDaXBJN1M1VFJpRmd2bi9vTUhiWmhSZXpRaTBSZzJvZzlPalZy?=
 =?utf-8?B?cFd5eGIxYnlUSnRjWEM2MjBFdS9QT0V2VHoxaHNNSXBwT1o2WFMzT3ExSzNy?=
 =?utf-8?B?OHpIMFI4KzhmeHRqaXVBMFRwTUJHak9ETU4zZEh0R1dnTGZqNXpnUTIxVDhp?=
 =?utf-8?B?ZWpWZGFsMUdwWlExQjdxVzJlN2YrY2lhTTczNFNUSEc1NTJ2eWRRVnJuNTlJ?=
 =?utf-8?B?SzBzSHczT1FzUGxFM1dUcTVlV2UzZTBTNmVEcXZ2K09veS9jeG5WWEdnSElJ?=
 =?utf-8?B?Uk8wK2dMQnRXQ2xsdTg1OTVPd1N4U0J1cmtoTDYrT1VMRmh2eW9UYVZKUXFq?=
 =?utf-8?B?ZE0rTXM4QWZqZHd2MmF1ME9qdFk0SnRxNjVPMXl4eTUvKzlMUjU3TDFoK1R4?=
 =?utf-8?B?bDZQbW4vRHgwT3BMVFlyM3UzRUdFb2pDQ0lpT0dnWDh3ZkJrZjJyMCt4cXZ4?=
 =?utf-8?B?bzA0SjdTRVZzQzBhbDUxUlNMb1JyOExnY0Rxdmh5NUdjVVdhUnQ1WlZnVi94?=
 =?utf-8?B?V2ErbGMrNUxyMUlDV0c3dmk4QUlpMzU2VTZpVWtlQ3ozai9XbWN0UXhyUlVL?=
 =?utf-8?B?YlJYa0tRbHhvaXVJWFRhdGZuVWM4NFZIc2NJK1pBVmM4VktIRmFPemRWZXRC?=
 =?utf-8?B?cHRxSTVwUmthZFRRWTdGMjIxT3kxcVVHbHBHY2w2ZlpPdkZQRGpuWHM1R0s0?=
 =?utf-8?B?ek9IeW9LZ3BlSVcrbXkzMW14L2JZSUxlNEthYW5DdDU5UHRTa1czb1hMVlNM?=
 =?utf-8?B?K1Nnc0ltaUZXd1htT2pQV3lBTCs3OFNmOTRTUDd4VWV2MW8xbDJnd2RMZ0Jo?=
 =?utf-8?B?cGZOM2VlTUtiYW1Td2h3QkhYR2F0dEVzQzdnc3I0Y3VBUFZXNjV5ajZuRndR?=
 =?utf-8?B?MFdQRFlxYWRQYndJc3pHYXM5N0swQys2djh2RGlLQ0N0akk5dlFLUXVyOEY4?=
 =?utf-8?Q?uo6/0PtVr/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWNlODJ6M05JREJQcGJ1UllIL1oyY3dtdTltd2VLUVI4dzF1TG1lOURqVUpS?=
 =?utf-8?B?dFhyTnR4L0VJU3QvUm9HZFJFK09RbExpQjRxSGZNS1JYcmsyTUFvVS9GNCtI?=
 =?utf-8?B?MjQwTlA2clBFdmpIQ1lnN1lEMlpqR2RtRFBzVXUwa21MZ2twREhPT2V0YXVQ?=
 =?utf-8?B?L010ZFpNM3YyU0tlTUs2TEw5c3lVQ1BHY29uZDVqUzVNTFF4VXBpRDhDcWlN?=
 =?utf-8?B?U05lWHRqcktDb2JTam0weGFHUVlkQW5kVHBaWTVZc2t1bDdtYlYzTG1mUXlY?=
 =?utf-8?B?NzI4R2dmcExRck82ZDFMaDNZbXE5Z2RWWUR0RFp4S2VjQzRFMzBRMmRaU1RH?=
 =?utf-8?B?ZGgwNG0vZzFFNUdWVGNwZDhUOFRNdWZ5NXB2OUZHOGhrQ1FVSnNwYkVPZE8z?=
 =?utf-8?B?bmtkRzNIY0VwT2tZeWpkNm45RUJpUWoyM25QQ0dncTBsTWU3WWNYRUwxY0s5?=
 =?utf-8?B?M0FjSkMyRUtqbnlFcU9HYm9qbjB6eEtKOXd5NnA5MFg0MWMyOUhQaGxrazQz?=
 =?utf-8?B?dGZwU2locHJyMy9VZGZsVXpFd1FNLzJEbGMwVm0yY1psbDNOSmRxTXZVTzVY?=
 =?utf-8?B?WEo4cjZnTXRrZDVwemZ4REZGR0dQV3BTclhxdmFUbWZuaTlVeDhabmF4OXdk?=
 =?utf-8?B?M205VWUyN3U3N040amZ6blY1dno1cmtCVjVoSUNZNFU1NjExWE5uUjIrTnUv?=
 =?utf-8?B?RDJzUkFTbXFOUEEvczduMHlBenAxenRFTDJaRW1NZGQ4cG8vWjg0VkFEL3N5?=
 =?utf-8?B?MlQxR1AxSURidWVPejlWVmp3R0hVKzFPUk5yTmhuUnQ3RlI1ejlseFJiWmdP?=
 =?utf-8?B?eEJORG8yTzB4V0d1NnlucXJYb1ZrOHo3alhZOVRIMlp3Y3MrUEZzaktzWlFu?=
 =?utf-8?B?OUc4MTY5SGFISEtIS3lqaDRlUmtBVlFKZU4rNFh6a1ZKSFJrWmpMcWpXQXN0?=
 =?utf-8?B?R3JwSVBCZlRrN0krallmYjc4NWZaTlFYZ3MyeGJSOXlyb2wzOG5sSUNJeVox?=
 =?utf-8?B?N1dXSjBhdHU5Z0FWOWcwYjAzTUNFdGY4UC8vVENWSStXZFo3c29YZElZSnlp?=
 =?utf-8?B?c1diMS9BNkxWKzZOY2tJT05nSkJrN2paOTViS3FIcUg1NGZ1K2FNY1NWS0Vw?=
 =?utf-8?B?RjUveW9rUkhtbE9Pcy9DdzRiU3k4WkxoVmllWENDZ1hqMnFBTHhHOThueUpO?=
 =?utf-8?B?Tkh2M1ZOclViSENUTmhtdFhqUmxjQk05NHN0UXVpRzViN3pBNC9wUEVNbEV0?=
 =?utf-8?B?K0pDajdEV203RjFNMC9LNlpJM3IzNDRUV3pjdy9SQ3J0S0U4RTBOa05WMnAx?=
 =?utf-8?B?ZEZ6cGlrN0tvVzRTNzh3UGk2QjJRMXJqeGlvT2xSTGFUVWhkS2I5NXduTWRH?=
 =?utf-8?B?L0pwOXc4UU5IWlJNQVRZMlZxWDgyWGFYVCswTDQ2alJNb1FKYXphQkpaSzJB?=
 =?utf-8?B?K3BhZENkd0RrS01TMk05aHp6bjFocTZYcEZteklCbmNvckRVcmJ3ZEMvSXR5?=
 =?utf-8?B?MUlGMzFPdDBPeXRZWTd5QWo4OWQ2OHlOQVUyRUNvTmtkTFNOa0poVHpZcDRT?=
 =?utf-8?B?ek9JbEdkWGNVTmdZOUJUZEE3ODllVEtHa0FCUDRoaXB0c3EyckRLMGFBYkwv?=
 =?utf-8?B?QmpnL3lJVWxwSlp0bTd4ODlnMXRnRUxWOUR2ZEpjQm5FV0R2VnJwY2pzWFNY?=
 =?utf-8?B?bTBRWFFWajNGL3hMaTJBOTZXQ3NoWkxoK0dRejBCRWtGWDdMMWZYZkRUdDlM?=
 =?utf-8?B?SDlyVjlCV3N4TE9NZVE0WGlqc0pOWng5NkVtVUM3d2pnanhFa2dudXpObkI1?=
 =?utf-8?B?WE5yVVNLQnFud3dHck1LWkVPVDROYUduRUxjQ3BVbkdhUXgvVDF5V2YzTE9w?=
 =?utf-8?B?Ylh2dHArc0RJM05qTmgxdENZS0tHMis3aURzVFEzcFM2L096Z2cwcVJiT0Vj?=
 =?utf-8?B?d1Q4REZYM0gxSUlvWnFXNVRJTEg1UDV4Y0lTWFBmUXJnL3ZnaGFjeU1lYy9M?=
 =?utf-8?B?dldvdHZjSmFET3ZPczNrako5Q2pNdlRLSHB4QW14VitSbWdXeFpFc0hwSFNB?=
 =?utf-8?B?U0Y3VnV6VW9TbGtJV0VyTDVYeldYdkEvczUzbWw4Ly84V25qR2ZDYkVaUVox?=
 =?utf-8?B?QlNQNms1aXVSK2VlblhVZmY5UlVQVzdiaEkyNlptd2dwS3VzKzZpVmVmUGRD?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PnL1hEJ/T2sSwLT9yab1WG0tBm8gSVwd08/kRLbalP8yRb7tZLbRgglhNLKHvZSeI7Te68xjQRKhKsnG8eW5mM4LtJ3n6Hd/kmcd2GhBjl+dQjPFcvs30yOXxplC3ZYfxh92kyAUYfmwQ9P9RzCAD+7xGhhqmZS8g8Q8GC7hsHAPBGqnpQYINPJJPZ4+0pOiu+mW33gD0DCGUNjP8sOB6S+4801iuzUQmhvFcjd7EZ14RiZbFomVo7n9daoUc3LDzF70CANV8iRzx9hAFMSHkpu4Q7yVPI9KkDfv+2vFK7fW8IFoFBSK/DxGAE5leYAUgdl1rZ2K6vDoDDr5jR95q7VOq7cSYWNbOockp3DGlqJN8CBVStByaCz2YtC62PgRk/IpNBIcgyfoQ65rkBKl+qz1sT48i01VdxXOdBS4tXBb5978Y6DqDVCs5ItQqcLWlMj9fNPSsjAUUxeiw1FrZ5n8GwzGphbnMVkl2zy0HxWjmxKeIG255FpoDwwVh8MRZJGqo2QW0O/W8g4AtVIlIwNog1nUMwkgJscCaNvDvx1ctj7OR0JsM3j8+yU7BNJJd5rBSy0h6EktXBIYFN+RAESlbE/ft0ASEa1LXrNqZ64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb4013f-f0bf-4d2d-f3a2-08dd9783a4f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 09:49:42.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfYx7pL6KkBokzhxg2Y6eutNRT6OqD+j1HIo6IvbCPR3sfWG7NYtAWSSf/lAHJ0RHjdiGoRH+gxJU48KKP8DgCl6p+PoTxkUdawQaz7FAak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200080
X-Proofpoint-ORIG-GUID: ZD1CiFy6AhuvS41UrGkiFJYa_ydYGL8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA4MCBTYWx0ZWRfX///7roPCiAbc 7eQ2yRp9Zb3MGN1KiTOVtu7QzR6HUp/fTNKR7dbSiknnQR5NKtEaBr3bwLhnNLxnpRyc9xHJcAT 87zxddnGmUsDPhVRWOxNw7NEIra+CUueYzdNTz9k14Q/noWDq9LULxYGK8vzX0cgBYOn6iirzc4
 ZCoLrrzhee/U4EijmDY3g2Ug/Dz/oCBQB0Gryh0p9xHYmWl/ptSy31OtTqRxCA3J2iMi5Ryb9yV Fe8rfdej1YdC2tASj/dIMtjIXQe9OGRGt5FUcu5Tm5D0DMuzkZ0ChqtMpVMZpU5TdJ2eobzx4Dp HWkNee1VyTx7K86tOpcpfii1ltTmq1dB0mP0EeKTvC3MOM9QaMtNOlLXlC0r+w3Xo+pxOcOIgAg
 P1lIbkS1f99DIUE3gQ4qv4Ja//WVxagwtT4713BHjEr+NoEKZpisc4yEXwkcMw8xoEkmiW0c
X-Authority-Analysis: v=2.4 cv=CMIqXQrD c=1 sm=1 tr=0 ts=682c503a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=ny3M3ul7Ccew9JtMoxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: ZD1CiFy6AhuvS41UrGkiFJYa_ydYGL8x

On Tue, May 20, 2025 at 11:43:11AM +0200, David Hildenbrand wrote:
> > Conclusion
> > ----------
> >
> > Introducing a new "bpf" mode for BPF-based per-task THP adjustments is the
> > most effective solution for our requirements. This approach represents a
> > small but meaningful step toward making THP truly usable—and manageable—in
> > production environments.
> A new "bpf" mode sounds way too special.
>
> We currently have:
>
> never -> never
> madvise -> MADV_HUGEPAGE, except PR_SET_THP_DISABLE
> always -> always, except PR_SET_THP_DISABLE and MADV_NOHUGEPAGE
>
> Whatever new mode we add, it should honor PR_SET_THP_DISABLE +
> MADV_NOHUGEPAGE.
>
> So, if we want another way to enable things, it would live between "never"
> and "madvise".
>
> I'm wondering how we could make that generic: likely we want this new
> mechanism to *not* be triggerable by the process itself (madvise).
>
> I am not convinced bpf is the answer here ...

Agreed.

I am also very concerned with us inserting BPF bits here - are we not then
ensuring that we cannot in any way move towards a future where we
'automagically' determine what to do?

I don't know what is claimed about BPF, but it strikes me that we're
establishing a permanent uABI (uAPI?) if we do that and essentially
promising that THP will continue to operate in a fashion similar to how it
does now.

While BPF is a wonderful technology, I thik we have to be very very careful
about inserting it in places that consist of -implementation details- that
we in mm already are planning to move away from.

It's one thing adding BPF in the oomk (simple interface, unlikely to
change, doesn't really constrain us) or the scheduler (again the hooks are
by nature reasonably stable), it's quite another sticking it in the heart
of a part of mm that is undergoing _constant_ change, partly as evidenced
by the sheer number of series related to THP that are currently on-list.

So while BPF may be the best solution for your needs _right now_, we need
be concerned with how things affect the kernel in the future.

I think we really do have to tread very carefully here.

>
> --
> Cheers,
>
> David / dhildenb
>

