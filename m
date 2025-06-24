Return-Path: <bpf+bounces-61390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51CAE6C3F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E435A4F83
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92221ABCB;
	Tue, 24 Jun 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mp31xP3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Aez4NbKA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F72E2EF5;
	Tue, 24 Jun 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781712; cv=fail; b=a3ykPSPCsPJlxOsObMrS5gh+WjRCKpvQ9/8NCP3VgU+KzLcCgK2yL1TfpDSQfcPrNQNAVSssBBTZUrYttZpxVMqSDZveELkwnvrI1b5t+F57KK+4yRBsdxlGFz85a9SQX06vyBGwNiWRlictk40jKTRr6nyJG4So9REcpDZppio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781712; c=relaxed/simple;
	bh=25RWx4Hdokr26H9ZZuuqGDCJPV050H1qI7CXmMrzp6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bg/A4BdEcuKmq/2zozExtldGNsu8fJ10SUXIpBSg8tip69pD1kzLJL4WbsUm8xCsqrHQKIqAjOA00G9nnbO7bLcCXXx2RzvY0lWiNXKoSSmoy2G6eftcJyWUTpVBILcyOkB6vq+xYxRhWb/4xhgk0JPlSKL2k022pQ/ei5+Bjnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mp31xP3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Aez4NbKA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFMlJZ002116;
	Tue, 24 Jun 2025 16:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Nrs5qwbm1fIOLMcsaBy4uVEzs98kZ50xrCagWcAAOG8=; b=
	Mp31xP3fHyvin2TfE2DAym/TXNBQ6R12fD6AmE3SbDmnOwKbwxePk5ajw6i8mDlK
	oIoza+A4uMHSIxT69XXKfsjVBslAZUS5SMTjy56A2d0WspreAlgEJx2N4GJ8yY8s
	1nEbjyQ8tCgr0Jkn1njGDMmE9stpyxYKXcB5gUskDMzKyqn4M/WBBnUd2pPPnB0n
	mmT16qdTfs+3DLe50RGvx8x4vrFKA8wl6bRYALcA81V0wmUAuCKVnG7XodUY0ex6
	CUbhRFn45NZyQpZ5lXHm4WQXa/sN9CSE1cfpKB7ghZflroNOx9+0Tc3iPVYDdhs7
	7on5fyqguBXWVsliNvgzsw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5meaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 16:14:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OG0NRT002087;
	Tue, 24 Jun 2025 16:14:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpdb8yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 16:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri+pa5fwpcrZV8pH0ksieNaQpf8UJH4TYq2jdhFgzO36UPwMrH/lIBQcagN6UkYY4Q13ocR87KZ0zZNrq7R/UNdRWxKgNwqBkltY7U/T6DkC9ORCIHTYOaylD7PHAd7nHInYh0twQ/yFzlKCLHXqo7CN/6eda1puq4Ujtrk8ZjMIt2QvgDhOj0W7klG+qlGyZbv9oM+8tdvc2vDEPtb+5BdOWchnYHRGGheVbbyXKhzyg942sU+uRhsYJswIrbQS3aFrF6Rn57WMCX8Xoq2vYqnJDvi/WbvJVowmr/0Svqd0Iwl7PpCVVLFDWrsqER80ljVtWFCkeRP7d5Svd/V/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrs5qwbm1fIOLMcsaBy4uVEzs98kZ50xrCagWcAAOG8=;
 b=E/g9vcpRg3V3cSS8LGisruEyFwmsTJHAAjg1fOCxduQ6Pssi5/z5AZTCc9kBy0XCaz+5awxjeIASg0imO4JW6DnCuvM5G3O6Z8WrwPo7qv0D3MHE8fsBK30skRfnQsO8gfeSW+qhYnhJpTv4I5riVeVZbvDHrkejtBlOTSsCsHzIowkl0J3IBPyCGUZ3BDvnAe3DpXoVBrHp+FE7SJJuoiXKvB7kBKVFfZuCr84hbS4VrE8KGiIrg0ZPfkmoDt4u7JkCOAvQOCW2W551sUqACaHsxgwlyeKgj3iHn1AN9yGhZss4+jW6w+efXpLO0KVc8IqliYLBVrSZKKMG9FWa4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nrs5qwbm1fIOLMcsaBy4uVEzs98kZ50xrCagWcAAOG8=;
 b=Aez4NbKA2pUND6NbL8oVygAJBBF48flV/xs8NttAu6YIs9cIr1HDv9wfydD8G9aJpwiIkvJXaM0EzFNswxPNw82p3piCq393lAbhrn6crEwxJqqy6YgGgNdDhhRANMiYmEbed6bqxFQEhmLW1uYJ4bytqXlMKYEWDEhoWtBNZ/8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 IA0PR10MB7254.namprd10.prod.outlook.com (2603:10b6:208:3dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 16:14:46 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 16:14:46 +0000
Message-ID: <66861840-0d4e-4b83-a89c-3e56667ac55b@oracle.com>
Date: Tue, 24 Jun 2025 17:14:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v3] dwarf_loader: Fix skipped encoding of function
 BTF on 32-bit systems
To: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
References: <20250502070318.1561924-1-tony.ambardar@gmail.com>
 <20250522063719.1885902-1-tony.ambardar@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250522063719.1885902-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::49) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|IA0PR10MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f8d310-9921-4b45-663b-08ddb33a3c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCsvcXA5bGtkUDB3NzJGVXBuTitRaDBqUlFiclI2a3hGRzFWeGd6R3cwM1dM?=
 =?utf-8?B?TjJWdEkrS3ppcTVubG1rM0x2aVVkK1Juc214eTZvY3dMNllMbEM1SWxXUmxt?=
 =?utf-8?B?dDZ3UFpOMldKM3VzRmEyYUFPTFlOMjB1aVZxNzZsUnE2WFU5Z21NM0srTlpm?=
 =?utf-8?B?d0tYR1VjWEtQNEVidXViR09OYlhHRy81eWtkOS9LakZ0aGdhemZXM2gwNVdN?=
 =?utf-8?B?bHRSdUpSU3ZocXM0VGE0bHIySjlvT1pTYzd1WklaYnFQRDdDazJuUzNueFRP?=
 =?utf-8?B?L1gvOWd3SkxsUlVrbStaWjRlbEI3aHRSamlIbzhaUHVwbzBlWUkxUERwQkhq?=
 =?utf-8?B?b2h4U2w3Wk1UZDZmZkYxTFh1YXJkSWFUNEhETDFrWlNXRG5BYkZINDlnZ0xK?=
 =?utf-8?B?TVN3N3BBb2dOM2t3QWxMb1VRbXczL0ZNcm9BMVNhRHBmSUU4aTVCTUtJbjhr?=
 =?utf-8?B?ZW9LT0RLamJjSEtmN05Pck1kdUQ1RVAyeUtsM2JiS3JqNHd4bFoyanRsUWtN?=
 =?utf-8?B?S3hickI2TzlUejVTUFM2TFptQm0wd29yZCtiMmNKcEk3bWUxRVdVQjZCVERu?=
 =?utf-8?B?K3FSM1lBM01NbzEvUE9XbCtJbFZIbnlVQ2tnRkNMNXdnczdBcTlldWZVb1pD?=
 =?utf-8?B?cFlrcjRSNWNpbWo4VjlVWG5ndzF3eFBhL0pBOVBqRm1QcjZMYVJ3QldKMklE?=
 =?utf-8?B?d0FNNkk1dmFieWJwZk53bnlNckF1L1QxU2dlc1QvWDNSK1hjWjBxN3U2ZXl3?=
 =?utf-8?B?TTJNd3lGMjVEdEpSV3hyZzRUdUY4d2VzVkgyL0p5OWJUQXBCS3pxVWIvRUw3?=
 =?utf-8?B?SGJoak9XempoNEFZeUc2YVN6aHczeFkrc3p6TE1JSHNsbGNzVkt1cWI4amdK?=
 =?utf-8?B?T2VESThpWHIxN1RHWVZFN09GM2c2K2RUZE1TdEVPSng5UFRBRit6dVRNTnVq?=
 =?utf-8?B?S2RsbHFuaWFPdWZldGthVktXVVJoN2VaWVJhdmszYitXdkh1TUViaHN4clQv?=
 =?utf-8?B?VERMWEt6MUhwdjN4ZFlVT0ZqZFkxQmhiZTNJN2ZPNXMxVHltY3M5VEdDWFNQ?=
 =?utf-8?B?dmVPa0VSM2F5SzQ2bUZYbWFoT0MwVy9TUzhOVGJzeWgzeGpjZzBXQUM3citE?=
 =?utf-8?B?UHVtMFdwRGhUL3hOYW9YWFJpcHZseUYycnRaVEhZc2RjR2tWY2pFY3gyR1Nt?=
 =?utf-8?B?V0hxQ2JvN0hubEVqdnpYKzVnRzB2UVhSZXU0REd4eGE3N3RLSlljeHdVK0Yv?=
 =?utf-8?B?UVYzbjVwOGIxV0FRSmY2aTNkYkpxSm5ONUZqd05zN3lJQWZ0YTNIUkc2ME1L?=
 =?utf-8?B?TXF1L3cwSStGSE9KNVh4Unhia0RaRDU4L1NoeG5CREJMVzBhaDlqSVA2eWxX?=
 =?utf-8?B?dW5LODZWYzVZSUJVM0RVZloyWjJ5WFZhODFPODFwYUR6eElzazdvNkJIUVBV?=
 =?utf-8?B?V3V0V21wL2swRk1IQzJrTWk2Y1pqVVlObXR4QytDT2Z3N0s3OEd2UzE0MXZ0?=
 =?utf-8?B?RDFlbnYrNnI4Q040VERWRGtsYmJ0T2lNT1BKS3g3dkw0ZDhUQXNlUkJ2dUhF?=
 =?utf-8?B?TVlXVXdQdVRYRDI1ZkVFTEpnUHJVNTc1ZVdnWm9sMVoveFV5bmVXUVQxL1pS?=
 =?utf-8?B?MGZiL2xzMnFlT3cxcGlITzIzQ3JPWEVCTWlwdDNxVTFVTFY1MUNIeFY0eEFr?=
 =?utf-8?B?UDEvL2gzQWZmZmU4ZWJ2WWRzZEFOZ1FGMmNVZWRNVTZCVGNUT2I1N0k2ZmpC?=
 =?utf-8?B?cGhzWlJoQnp5N2ZYaUcrQm0xTzg5OC9vUnpwRVUxOGlGZjR1RGNIOE1ncXEy?=
 =?utf-8?B?OWN2RHVEZmIwN3FZY1VrcjB1eEpyVVpqekV0Z2hNenpXVzRzU3J4SjdISjJ3?=
 =?utf-8?B?QlJvMTRXeHE5cHNxU094M3RYYi9jTVdIZXNOM2ZKVnhIWVoyc3RrVGZYaGRT?=
 =?utf-8?Q?qZuqtNiTYQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNzeWZUVUdkai9DelVyblZwL0FvR1VEbWdFbEVjK05mN3FGZUlUZ1kzVUFo?=
 =?utf-8?B?bGd2YWd1S2YzTXgxdUlDREtFaEJUSDRnd0gxRi9qSmM2QWl3M0pxOTVTL1M3?=
 =?utf-8?B?eFlsc1VCOVhVWmV6QmM1UTU3NnJIMU1xck84SUd2SXhUaGFjdWdYTGJLWFZy?=
 =?utf-8?B?MDIvTlJZMm9JdkV6a2kzc0FUaTdvTXdWa0JkYjIyQ3V6L0MveC9Dc3hEWHpZ?=
 =?utf-8?B?Yk9OWmhZMGZvTmZjRFpnM3RDTXJZMW50MGhKcW1IY3o0MU1Ec2tMZHdtQkY1?=
 =?utf-8?B?RE8wQmpUMkx6bkVLZEV0NEdlbzZyZzRGZk9hdFM1N0FabTMvUXQwUGEyVEZ1?=
 =?utf-8?B?a0hkQ1NWQlI0Y0NhNGVTSy96eGtLT2lIOWMxZ3ZHOG9ieC9TdWNuTU1KSnZV?=
 =?utf-8?B?TjJ1LzJua2xZSXNuR3NpWlJsWWhYTWlNMHhReTFTTzZjV08zajlNdXRSRURz?=
 =?utf-8?B?b0R1U3NEWFUwZ09KcHB4ZTJFcWlOakpuUGF5UFlFcG5aUmJjNGpHeHlHamNN?=
 =?utf-8?B?clk1RVV3NVlHM0EyQk9xREJFd2MxSmw2c1NqZEM2OE9RRDJ4S3pWeGdnaGxh?=
 =?utf-8?B?V1Z6WlJLL2FFVnZCa0huVm85aER5a0R3RXZsT0tYcVkySkYwSWJrdDdHTHBz?=
 =?utf-8?B?aFNxZUdPcStLdFBvaUJlbGRSUkxZMUZNMGg1SjBPN2FQVFpTSitGTU5xYWk3?=
 =?utf-8?B?V1ZnK3NNK0FvSjVXNGFlWGw0enFZV2pEQWZndDVoRklSWkkySFFtTXhrSEdo?=
 =?utf-8?B?bmdZVWR0UzdWUnUwb05pRWpEOU91dlBYUkhseDZoTlIrTHdrQlo5OVhac010?=
 =?utf-8?B?NWIwQmNNc1VQdTVuSHUvZmRVUDJHdy9xM2N6WG44S1drZUFtODh3bFlLREx3?=
 =?utf-8?B?VXF2c0hmVFF4YWd3R0FCMVZIVjVMQW5LdERnRG1GNC83N3ZENFptM3lYekVs?=
 =?utf-8?B?dFlYY001TVZ2UHZsY2JlZFhPU0hGODVoWlRCL1FLMkNlcG1FdzNwUkkxZmtV?=
 =?utf-8?B?akZEaFV5VUxFN21hN0M5eGdzVGNQQmNXOUE5MEUzZG5QOUJxYnFsUUd1WUlW?=
 =?utf-8?B?L3pkQzY1bDZXUlRSbnVJaDFlYzBLWlY1UFJSUXdjTlhLdVE3ZEJpSkRiOGJk?=
 =?utf-8?B?aVhVdW82OHJkRTZRQ2FSRzNsaWhjV1p5WVlwSkFRNWRIWmRDbW5TeDJIaEdS?=
 =?utf-8?B?Y1N4ZHBDYlRWM1h1cEZDMTlzSlRJbERIYnF3cFlYNk5VeVNDRzhzY1VPbllI?=
 =?utf-8?B?VnBzN2VzSEY4SmV4RFRoMitTNTZ6OHdvREFUS2xRYW1xZ1BTcjVzS0VZRXlh?=
 =?utf-8?B?TklmaG5ENVVlSmhiTUlsaC9Pa25rL1BrbWZIVkY5NjA2dmN2RWVHRVExUGVX?=
 =?utf-8?B?aU9TYlVTNkpNU1pSNHFKd2h1VTBkWFFFci93WDM4ZGFDSXFZREkxZU9ZZHM5?=
 =?utf-8?B?WWFBQUpoYjFRQno0MXByUTFTaGQvQUNUSS9vL1JuZm50Qzh3WUJaeU51dlkv?=
 =?utf-8?B?TUZPcUplcmVSQVZMV0lUcDFscVR4STVKWFRBLzZ4Q0VOb0RzS2M3ZWRxTEpE?=
 =?utf-8?B?eWVRVWdaemJaL2RSZ2ttamtyTUJsWVNEWENwcHVRdFN0TGJ4MXNJVHFIMit2?=
 =?utf-8?B?bURuZWJLNkFRZHkxZ2NiZkNKTnlRNE5jWUhESzFrZytNK3AySFN1anRRSGVp?=
 =?utf-8?B?OTg3cFNIRXgvb0prTEpzSkVrL245SUg2SVNmbTNvVStEMXpyUnZRNW54YzZT?=
 =?utf-8?B?Vkt2d1NJQUFoQnpKSkVGbUhOVHo5TzdZc3dJOE1LZUc2SzJWODhpZ3FzbzYv?=
 =?utf-8?B?ZVVPTGFQZmdaTUJLYTBlbURaOVowQ3hxcDBwdUt3dGx4WUtXS0ZYTmRWRDZj?=
 =?utf-8?B?bVVCWnp0NU9yRzZoVUExZEovSkJvK3ZFT0NhM2MzWkt2UXg5c0RHUkxIZTYv?=
 =?utf-8?B?YUlKeHc3UWphSjBDUnU5T1dPdG52c2hZbXNBb3IxOSthTTBTRXI2WjFwRzgr?=
 =?utf-8?B?aGxVVEJGYmJ5VGF3ZWJPRTZ5NVMrWkUwUnBoYVBjek1wSVVDNG1id2h0NFE5?=
 =?utf-8?B?Yml2YlRFY1RMOU1hUWxjaFA3UTdnT1hlYnNTNkVSZHQ2akdIazg4K0ttVzhk?=
 =?utf-8?B?TXJIQ2VldmFjRkpQVHFlcTVwWWlya3NvTmdaeEMvb25LRUhVVCtodmY1SzFT?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zw5wMCMjP2mPxMPEOkAVetgb6Ax0hVorduDQLtyj+Aoj29a8PnHkf1Dfba7qDSZOpv8F+0CtfynoeiIWoJbH76OpnPld4nWc5onisWhhmMbl2OFhbb1pPW0Z4HYU9u3DrQoeD4+293Q5nTHMG34BQoYa9odn3O2Or1Ioi/DK5hjxcwjgRNIm25gtIvSAQPGxD93Df54QP6XJo2E2wFo+IcDaeI5Fr5xug1E/NhBeLFkR5bf66louwkp9jL3JTGoIhVSy3rkJhWseyDOAs0rb9TDPWAIPjIq1k+yO+EIdQB9SQasxsnngye+EYzqd+jqHxRe25ylSz7jloWOoZuw3sd6r9uqTp1xjtM6KB0S2MMs8pH3/w5HfbCFllP78w7fhaMdLkJRQri6HaKYUlt8xbicRhPTWcjSK4w+q9l6L+0iAOqP6JrwGBCo27gmX2fkWG0Vs7g2y2CGZIbHUMv3Bf2D+7j9ATDfjnF8gKwwGvw30p3pduXW66d4+/Jkf0Zkthr0PUJbR25WoMQzD1TuKykqbyh8ehEikCPP2tvVRnXVxJmb3ZnEruqbDYvcG+oJfYTGW8dy1BFCWXEoUDzmjdDJ4cAE0lBAtYT3IXsqft08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f8d310-9921-4b45-663b-08ddb33a3c69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:14:46.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKB9rfEj7efzebyk9Uysyi0sLep0sdZjMupbwi0if/0DTcqMQdmswrybKe0FYpJ79//K4b1tPUYEzjJkpsT59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240136
X-Proofpoint-GUID: LJMcQCFgPUxj9ye0M5CEGmu2m-byTSlY
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685acefc b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=s6w_4jUbMWS8x-NRqc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzNiBTYWx0ZWRfXxRzbbvBnner8 wlsG4DMilyVVCjHHD9Erj/yNaV02VQ4xSm7Ff/zmz3R7kY52PtcCbw00QwHu8PtphP8V/FwBg3n /DntQ4YfDmDvNRtthgZNzDwq1/pS0JxtEeiPt8cxZcfGRogfCFYJH8/NsiyWI5CwIgAYPvK6DlC
 VVCwDYtqZApjqXXDeMsEcPSDzrFhWw+vtv2/vU3H9QHcE6yYNqldbTQTxTzXbyaG/uembj8dUSk DadaKQFacJX1HHJ+RaxDXx1AUugoefoBIpuz//rrTTHulrm9ZMS2D0CblxdtpUNkPDJCc8GhPev MvGTx8wUBybaihfnicQ0VxDeGraRGu/1q9+Gw2vceLTlbrYdrbthjlv8+zu8TsY20a0hRK+Ea/R
 khROL/ribH6g+1F7AYV4Nd9xh2RMCXZeoQGsCqTQZRqZmzLcqiAOmSeD9CPpiFXXhHbUhxG8
X-Proofpoint-ORIG-GUID: LJMcQCFgPUxj9ye0M5CEGmu2m-byTSlY

On 22/05/2025 07:37, Tony Ambardar wrote:
> I encountered an issue building BTF kernels for 32-bit armhf, where many
> functions are missing in BTF data:
> 
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol vfs_truncate
> WARN: resolve_btfids: unresolved symbol vfs_fallocate
> WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
> WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_consume
> WARN: resolve_btfids: unresolved symbol bpf_throw
> WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
> WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
> WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>   NM      System.map
> 
> After further debugging this can be reproduced more simply:
> 
> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> <nothing>
> 
> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> The key things to note are the pahole 'consistent_func' feature and the u64
> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
> code handling arguments larger than register-size, allowing them to be
> BTF encoded but only if structs.
> 
> Generalize the code for any argument type larger than register size (i.e.
> size > cu->addr_size). This should work for integral or aggregate types,
> and also avoids a bug in the current code where a register-sized struct
> could be mistaken for larger. Note that zero-sized arguments will still
> be marked as inconsistent and not encoded.
> 
> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

hi Tony,

I'm planning on landing this shortly unless anyone objects; and on that
topic if anyone has the cycles to test with this patch that would be
great! I ran it through the work-in-progress BTF comparison in github CI
and all looks good; see the "Compare functions generated" step in [1].

Thanks!

Alan

[1] https://github.com/alan-maguire/dwarves/actions/runs/15854137212

> ---
> v2 -> v3:
>  - Added Tested-by: from Alexis and Alan.
>  - Revert support for encoding 0-sized structs (as v1) after discussion:
>    https://lore.kernel.org/dwarves/9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com/
>  - Inline param__is_wide() and clarify some naming/wording.
> 
> v1 -> v2:
>  - Update to preserve existing behaviour where zero-sized struct params
>    still permit the function to be encoded, as noted by Alan.
> 
> ---
>  dwarf_loader.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e1ba7bc..134a76b 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2914,23 +2914,9 @@ out:
>  	return 0;
>  }
>  
> -static bool param__is_struct(struct cu *cu, struct tag *tag)
> +static inline bool param__is_wide(struct cu *cu, struct tag *tag)
>  {
> -	struct tag *type = cu__type(cu, tag->type);
> -
> -	if (!type)
> -		return false;
> -
> -	switch (type->tag) {
> -	case DW_TAG_structure_type:
> -		return true;
> -	case DW_TAG_const_type:
> -	case DW_TAG_typedef:
> -		/* handle "typedef struct", const parameter */
> -		return param__is_struct(cu, type);
> -	default:
> -		return false;
> -	}
> +	return tag__size(tag, cu) > cu->addr_size;
>  }
>  
>  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> @@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		struct tag *tag = pt->entries[i];
>  		struct parameter *pos;
>  		struct function *fn = tag__function(tag);
> -		bool has_unexpected_reg = false, has_struct_param = false;
> +		bool has_unexpected_reg = false, has_wide_param = false;
>  
> -		/* mark function as optimized if parameter is, or
> +		/* Mark function as optimized if parameter is, or
>  		 * if parameter does not have a location; at this
>  		 * point location presence has been marked in
>  		 * abstract origins for cases where a parameter
> @@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		 *
>  		 * Also mark functions which, due to optimization,
>  		 * use an unexpected register for a parameter.
> -		 * Exception is functions which have a struct
> -		 * as a parameter, as multiple registers may
> -		 * be used to represent it, throwing off register
> -		 * to parameter mapping.
> +		 * Exception is functions with a wide parameter,
> +		 * as single register won't be used to represent
> +		 * it, throwing off register to parameter mapping.
> +		 * Examples include large structs or 64-bit types
> +		 * on a 32-bit arch.
>  		 */
>  		ftype__for_each_parameter(&fn->proto, pos) {
>  			if (pos->optimized || !pos->has_loc)
> @@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		}
>  		if (has_unexpected_reg) {
>  			ftype__for_each_parameter(&fn->proto, pos) {
> -				has_struct_param = param__is_struct(cu, &pos->tag);
> -				if (has_struct_param)
> +				has_wide_param = param__is_wide(cu, &pos->tag);
> +				if (has_wide_param)
>  					break;
>  			}
> -			if (!has_struct_param)
> +			if (!has_wide_param)
>  				fn->proto.unexpected_reg = 1;
>  		}
>  


