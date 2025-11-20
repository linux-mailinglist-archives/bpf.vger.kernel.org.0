Return-Path: <bpf+bounces-75174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D3C75D7E
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D418634B9A7
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E22E54DA;
	Thu, 20 Nov 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kK27cpy8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGbD5YvH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFB2E0939
	for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661269; cv=fail; b=jHi8zIxS24swpC0RIooHpgd4hG/lauw6J00yFE3ycY2E6Mv8UNG8HKJMs5q8mUZJ9cMDwoEiQ7JzB+1R6Al5kvcJ4GcCoN9gtXUkSzWA8Ybym9LQ2KX4exFczixds9z57/WTKV3V+5i5A/PQK8M8/2I3SnJLfBBxn/El2BkaFTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661269; c=relaxed/simple;
	bh=JzCPtUOhIiQkiiv5/pMFs7kIZqhfFRYR8dcmQTAT9wk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qslp7h+ta5dfv38AbJAC5UOGLLVuy9kZHZr/AXGPEP6xhKVTPBnXss3M6m+5j7/kpyIa86abmdZsskPpBqTraj5maTgN1FQcAQUFzFJcTgO6iWle364MhdEFqthfyanVwxYNFXjGcu8whvZTY5RHYHf2yd3d7N2J149AFm4LCw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kK27cpy8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGbD5YvH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKGNUbH017776;
	Thu, 20 Nov 2025 17:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6EpbhqyCarG5bmEl3aOMUNdEepH8S7RuGU0RgZlJANo=; b=
	kK27cpy8MI9Bns5t7c1/nysF6d58BOXnxQsdWqcdIFsxPPgTJDkqeZTSa0ts46nz
	GBy9hVY99comkt8SghQqniTsbaZ1kO414BnZO/lxrhjWFU4uQCHIa8qEOp1Q3mFC
	Gfb0bGZuh74exQynEhDOTb6GTLFDL1VwjFD7L4zYtCw/+FDceKWkFlKhEz6vJzzz
	bs4Lx93OmPna+27dJ/Yabjc69uJ0JmTqz8jSOKFI72utgUKqnc4xVhySD8LIsij6
	sEoEAOOsN4CvnAviroiqQnJhJAx47iWySXrMjdqaLz/PyrCZ8vLVEZQaJX7BnPBW
	ExA1okT1RSr5RxJ6y2SMAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbq1q4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 17:53:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKH55qw007748;
	Thu, 20 Nov 2025 17:53:48 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefycfpjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 17:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW7jBFceAdAaYg4L1bINx01U76A8GaOcP2whYdvUP0BuO7w7buo05JPbTgN2NCY6J4QFn+MmY9bTxz7i0EZB7jPF3q1DkKCeQBsqYCAjVUErsiyPdc+6rEu8Xd36sR1CD8SgUu7cs+nsKDnwjmpLOoFsegrLM0oig46AbVSZvPMXpk5gR+5oIJnrz8W86YvfOFkTNJkZNPVjS+QU9Xs8OI7Fu+KeFV9GVmxtW/VS6Yf9fWRGd1K76EPfxb1F5KbZqQLdygzMiECdHHk/D0yf33VlToEMaPsyGHOwJ+CSrnLHgw6bPYdtKnnPx26XjH2hJvmr9Ajg+UN+MCONe7EigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EpbhqyCarG5bmEl3aOMUNdEepH8S7RuGU0RgZlJANo=;
 b=bqXw0Gf2Ld8EaikeB89VUBCAOc/yx4bV8/JFU0zk5alSxURn963NnhS4MQD4yGJtcBLyEPPrHEesL/9pqzRI5R7a+B2v6Y9BP7MZPqfLNETCsn+XIfTVWzSjHg5d54vz6BVOuKZRSp/BG/4c90A//wRM1qDhLR8bU9yVpUGxLTXQQi2IKWwTmFPz3Z1KtKSHShwhJUNkIUw0LC9dapkAhu+imLCYx4WNCHdWq0bZrjOPOlOBXH/TBH1FBSuvCJm3WJCOPAJVm8qLrhZ99QfetljHpIwvq1oDsyAREQMhQNbr5HCIrPbi80usNDruKkB3hpxjYZvlXQarZJ/H5SWe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EpbhqyCarG5bmEl3aOMUNdEepH8S7RuGU0RgZlJANo=;
 b=fGbD5YvHRKnD1U6ozlJvrOy0khzBN/+SNGWmvmquESH70pXleZMKJCW9H87n9FRMhJjH6EgWucpDTS52rHtAUFIt2DFRbYXOv8YMVACgVFIo9jGN5Oc4P6qKdizmOv4Qx2LP9B9fj7/hOlY9zeRc7ouNDbGRUylGyFGdxMVIuX4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CO1PR10MB4465.namprd10.prod.outlook.com (2603:10b6:303:6d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 17:53:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 17:53:44 +0000
Message-ID: <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
Date: Thu, 20 Nov 2025 17:53:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
From: Alan Maguire <alan.maguire@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>, bharat@chelsio.com
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
Content-Language: en-GB
In-Reply-To: <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CO1PR10MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: e864959d-ca61-404d-55a4-08de285dbf79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cncxenhkNkVwc1IzMDZZeE1LUGdCTUZGNHZndHZabHJMT3FjbGxyMW83V29k?=
 =?utf-8?B?QlYveDRRb2JORnZUcC9wZVo2U0FHMHh0RVpIZEpZV3ZFYzFQNys2dUtXNk9t?=
 =?utf-8?B?ZGNhZzZMWVlSU3pGWGpHME1hbTgvdWxKUndrd1lzZmpmVDRPdHhCd2RScGwr?=
 =?utf-8?B?WXFEWmxyTWZrUi9RUGNlR2FsUm5RRk9Edzh0ZG5MRCtQblNRNjhBQVY4YzBN?=
 =?utf-8?B?WFpaN3BNdGE5QUx1VCtsSjMvZFEySTJjaFQyQVNhZ3hWK1lFTUpqdEMreUNy?=
 =?utf-8?B?T3o0bDRCQTJYSDEzbW1QN3ZnUDdxaTQvZkpmTThTdDEwNHdwVkRxQWRBZTBB?=
 =?utf-8?B?allNekZqU1F3akg3SWhqR1ZpSFVJbWxCcTJLcy95S1ZoaGtQbmYxdVMxNDZa?=
 =?utf-8?B?MDRsSmhCdElVa0FXOVY0djdmK1JEendaV2J0S3NvQ0lNekJHaXdQZ2NUWTlt?=
 =?utf-8?B?STNuZmlocFk3U1hYc3g0ejArT3Y1SGJPZ29QM1RwMkwzOWxGdlBidmkwWkNM?=
 =?utf-8?B?TzhZcFZZYnlUNlZHck9RQ2VQRGxlWUZ6L0hqZkY5NXVvRjFGK2dwR2ZmQnVj?=
 =?utf-8?B?SkUwN2gvNGJKbFh5ZFlodmFveUZXZG1TSlUzVllQNVZRbnpTQWpJVzhEeEtT?=
 =?utf-8?B?RG5hWkd0aUdORnZjYTllSm5MMTJBUUQ3d2NGS0hSN2EvNGJwY2pVSnI4R3hE?=
 =?utf-8?B?SVIwMm4ybE54QnlOU0RubWVUbmJDU3l2eW9zTmM5R0RIanNlWlg0d1NEMTBl?=
 =?utf-8?B?ZHhCWmVPdVVXNzJ4QlRBWWNncXdXL200OGFlOTJNUUFTTGFFUlIzd0ZFdGs2?=
 =?utf-8?B?OFd0WWZ3Yk1vSzRRSzFNb2tVUjJ4NE5Nc1BUM0FobHpESFdmaXZNdThQRmNr?=
 =?utf-8?B?SWZMZWh4dmYxcGV1bUowYlU5NnRoaFBEMUFyTVdTYkxPWXhoSmtwQUNPQlgx?=
 =?utf-8?B?bStOV2dxUzNEZE5vRmk3bU1KSjFQb0RodjB6WkFxT0xvc2o2eVljRERZYlhJ?=
 =?utf-8?B?cFlLZ252aXF0eEtYemQrM0ZyT2lIeEFKM2dod3lZMytwcjBMSXdQSlhnZG1q?=
 =?utf-8?B?ZWxkV052blVMcjRmVDBjOXhOenphd3ZCTjRGUlNPc09pVVBIU2g3VTNSUlpV?=
 =?utf-8?B?SEtRZ1FHY25aaUJCWnFIK0JUMU9rQkl1OTRXZVpsVkUwT25jUEZuM1VGRjlN?=
 =?utf-8?B?OGFPaEgrUjdUYjNKS3V1Zk9sOGRVL2FGbEhLbkY0Vmp0K1Irc25haitxTjA4?=
 =?utf-8?B?cmxMNWdWdC92eWRBa0lUblpETVB0SU9mdHJQSGZCWTFSM3NiOXozUDh3bnNp?=
 =?utf-8?B?YUpuYVhjNkhJVzczaW5yOG9aTFg3WVVGdHZBckpvQ3YxaWR2ckpzYUhKVnA5?=
 =?utf-8?B?TkdLSmE3QjBWWDhkTmQ5emI3Mm9MQmFSZnI1TThBM05qcWJIZzYwYlBIbDhB?=
 =?utf-8?B?SkVveHpIZlNUSWQyMFgxcE5PWkUrMFl6NFBxM0MrVzVQK2l6bDltcGJTdjZB?=
 =?utf-8?B?VFpCV2EwZWJCQWJsUnZzTTlWV3duTHpHS3BuUzd5NzFkUjgxL0Rlczc1MkIx?=
 =?utf-8?B?TldzVEZVaEpNTmxMRkdpNE55ZExvaXpObWw0QStOMzlIMFBybU9rclNQZXpM?=
 =?utf-8?B?akQyZ0ZSWXRwUURZSmNYN204VStaeTJ4Z0dyNGI3Mi94eXJicUpjUlNkMXlH?=
 =?utf-8?B?eGZwVU5MY1NqSVVRS1ZWUGI4cmxOU2lSKzVVTkdvZENMMlFqRFhPSU91Tnh0?=
 =?utf-8?B?Yi8xZHpBZzcvVTBWUmwxYm1tMmljWCs0d2FZN2NqQ1F6bmV4R3VmTGZtOWFt?=
 =?utf-8?B?anJTR1BGMGhTeVVmK3o0ZjdLRnNudzNIdzdVRHZva1JncnBHdVBzQmovM3RY?=
 =?utf-8?B?M0psK2h3elpIK1VPalFzR2pJSTJ3T2hTK0FONkx2dFlLdS9ZNkllTHpldTZs?=
 =?utf-8?Q?ryzErLbQMUlm3t91Ba/G2CA16m74GleJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJsenVsVFc3bkdNWWZXeDVGQzBXZzR3ZlpNaWJvVWliZlIxb25CR0dhd3hJ?=
 =?utf-8?B?VGVVaUpFQnRaSHIrU2NBTU9yTVJqeFloYWtueVlZMzlIekVyZWhqcUhQbGVM?=
 =?utf-8?B?S2dZdHI5bG90dVZxeENEZHUvR1hPQnZRRWZIUm5ucmVDUnlYWnZCUFBXOWEr?=
 =?utf-8?B?VnhEZmN6OHZNSGt5a1Y3NnpUTWt3QWNYMXhrVkE4T0V3S1F1NFFrak1PU2N5?=
 =?utf-8?B?dFNQaXdHTTR1bUZZRjErZWFjQ1A5Y0l0d0NaOWlwUXVJb2JwZUZFN2dNZmlr?=
 =?utf-8?B?SFhadHpxcFh6LzlId0gwV3pnOE5tMjZ6VFVaSmw2eldPS2xyTXR4a05RNk1L?=
 =?utf-8?B?cDZYSEdTT2h0dWwwRmkzRE1lb2FiK3RHd052SVUzNmNjWGkzQnQ4VWdJMlVB?=
 =?utf-8?B?Qm5SSW5zNjB1NFhha2ZFL1Z4bzk0RkVtWm1zcEd0eHNtakN1YmZYK1BWWGsy?=
 =?utf-8?B?U0QrY0tkcUhjSmc2azU3SHR4WDZhTVBNaEZvTGUyTlBHc21GemtPNnk2TS9Q?=
 =?utf-8?B?ZSs5c2tLa3pvN0VYWTdiUEY3dHN4M2xyKzZSMWFXWG92YWdLdC9IOFpGLzJ5?=
 =?utf-8?B?eUVlZHVsQzk4YUN3UERhckFvUjRLVTM2QkVvY0pLcEw5dUh6TDJ5d2tjelN3?=
 =?utf-8?B?bUpEQTh0TVhIQzUyOXBnbW5mQVZtL3hPM1RKeXJab2h4bVBNVjQ4Q1QxVFJj?=
 =?utf-8?B?MmVscjNSZ3crL3g4ckt5dlFiSU5YUDVTZzdNYjhMSUlPZ3J4c2tYTDkyMEFi?=
 =?utf-8?B?Qy9RWUkvazFsQ1NKNHZJNytkZVkxeWpaUTg4bTM2dlZPaEtOQUV2amhUTzZE?=
 =?utf-8?B?UklQdWRnSUZFN3FJMGU0ZVU2aWJLcXBQRlpCYkdWOStoSnlvSWhEVUlzbGFt?=
 =?utf-8?B?S29FZllGUUZOaVRWRHk5dm5hNm1raElMYTlSN0xTaWZNd1BjRWVxSkc5dGhE?=
 =?utf-8?B?b0NhcTVQMXNrZVJ5MjFoTURnaE9XOTlnMEd5bjBvRGswWDhvU20vMkJiZlps?=
 =?utf-8?B?OXptaTZlM3FoYnhUeXBCdTBraWNVMXNuSlVOWTVxblY4T2pDUDE0L2JTTG9t?=
 =?utf-8?B?OHJoV3MxVHViWnNVTkZSREJKaSs4SUtnSUxEVUhraUlpYkhDVUdMQ2lVc2lT?=
 =?utf-8?B?djY2RVhtRkN1R1I4U2dMUXlBWTAxVHdyNVJoZld5WFBNNVpweWVxSGpvZVBY?=
 =?utf-8?B?V3ZSVm5jSmZIWUtIaWJEMEFnYWRzamhFN2VmeG5BRnllTUVwU2syZlJXVGpB?=
 =?utf-8?B?ejA5ZDZCWHhYdHg0ekJZSkRXQXhyT3JOVGJjOC9haUhEOHlVY3k5KzRKQjVt?=
 =?utf-8?B?TytvZU50d1RhQlJJMkFleGJ6UG5CQm9uQmpFbDF6bmdBMFp3TkozYklFazZM?=
 =?utf-8?B?STl4TmpOd2ZJZW8xbmY3L3pubDFJd01OU1M1d1hIZ3VKMWUwSHhHWkh5aUUv?=
 =?utf-8?B?a0ZUNGZkUnhCWjlmZ2dRUU9nK2xkazFLSm1CNUhOc2NHK3Z4V3ZSREc4OUNm?=
 =?utf-8?B?Nk9WdWpHLzVEbkliejhieDloM200RXJMeG5ZZkJ6ZHd1QnNiOVRNWnZxZVlY?=
 =?utf-8?B?YlFjOTErRHZ3aFZ2UjdKSFhoOG94dTRuckdmSFJhUXIwMTB2QUJqVHBTN2hI?=
 =?utf-8?B?Y3RDQWpsdG5vRHBWU2RnNDJuZzBNcGJkSmNvK2dVUkNwN2RWWmw2SWlOaEdE?=
 =?utf-8?B?bG1la2trOWVMbUUyOUZPRFRxK0k1YkNXVkMyTEhRbE1vNzBtSXgvOVV0UTA5?=
 =?utf-8?B?SlRPZG9Oc3U5ZE5kWTBQd3JyQ01jL0VoMTlwRDRBSENITERnVVpqU0VwSjBQ?=
 =?utf-8?B?MmZGR0JsbGZuN1VyZzNpV3BqcmMrN3NzZFZrb2R5WmhraFZqZC9ib05JbEU5?=
 =?utf-8?B?ZGJ2bDVpN1N2TUJSQkhkUVovU25QSC8zNS9mcUFvWHBtS3E4UXVzR3NKMGI0?=
 =?utf-8?B?VytHeVpqb0dUeEp0bERCb08ySnRrRGJ0NlVpQVFFTzhXUnN3NWRBTFNmT1B0?=
 =?utf-8?B?U3R3TFkrYiszMW9Gc0tsblpZWUsyMDNkbTRBdGh5eGJBL0hwS1NZdzBxd0JO?=
 =?utf-8?B?Y2RSYnJKNzJwWHg0Z2RaWWZjUWs5VUQyMHg0L2VaUlBldnJoeFZyTXQ4M2J0?=
 =?utf-8?B?c0J3Q0RyVnFhc2kvcVM1alIzNWEvSUhDa3BuOHVxY0J6WjBWcGdpZDczbGla?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f4sx5UwxaEFDBjFpFhC99FcN90LkmP3YlPKcwLVFxArVBZVUOTPa5bBXBn5U8K7AwNc/zDRe01v6iBTQvweFx4xnx/zuWV8hB62qT8p22i5s4zpWEEfwF8uVnUW2JUKYhxDLpSc3aJkAJhCF4GJ14uSqsmjuXRoShDNo/RFJSVdcvqSUSEXoDL88wBW4TtrKI19vSBBer/UQGhNRuzg2zvSLid5IxZBiAUfSU0iSXgWi54QPWwHA1EET3/Dc5xfiWx5eJlsZsi252vpb48PKRQXGF8RvBKEKG+7gcfreVDi36jI4Hu+wua3LENBUHWkDqphsDoPbtWVPyf2T6MTqan+13kWQWpa8NGhFi7zCInPPz57xUpY+yADNsyDQFnRUkIWckXKSqvDqBbYI2uWAgGO5ddyyv4ZbujwjAL1HFYKCLmssDmY1pdE4ivJfoi5ygtc2sncoi62wZvtJ11YLYl63nfqztSRjVX5ka3fpTHBZEuP+oeR/wAGt3YUky9gGkt/P7HwW90d0zBNkuKF4ql3I7PaDmbOVrz/inpKECyNd6uhJUlzEsu38fHhPjOrvpEDKTXscrr83FFR3tgnfXnUaq2+0/U4i2V0HN2T2uaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e864959d-ca61-404d-55a4-08de285dbf79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:53:44.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCMhd4PVt4wp+//QXq3G/VhIA5tpxZEF3xXjYjir8bimsu1St2h6Ky9zXpCFurL6ytTjRKFCf+Ifod7nyOO6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX6WKV4wxyzNFT
 Qr79Xff8mEeqmKJIimZySgSoo0uBkvmIH7CWVgekPzwshlNrKJMGswODyh1Q1lhOq8+CaWGKSuw
 lZHnImHc0KRt+2Bz2cquXHjRcoaxmS6wYexTn5rUAB4w0useHFSqbXoYio9uZT2T9OX2tnFq5TM
 JAJA3S3c9TRjcxEMcfSBgIDCC9dyNw+H+3H2748UudguzXoNRdWHxPkns+f7+pfBRmKmQQPifjn
 i6UK9Xu6HZSU5WagSvpDwqZNSIFq/tVci0XBEUiw0g+TSkSJuGNiWsa+uf6Pb+4JTzBHnGN0giQ
 MQROj9dgS4D5Tqqo+4mStEHLK0FvEMLYz0IOrCPGBTlN2jtEExWpFmuz0yBwfwZb4aqlUbJPzN2
 31LCBksdhTlQXeXbnKLZwEnEwrBWZA==
X-Proofpoint-ORIG-GUID: PM3cqt2PmExe9eO819h8MT6G2nUFQVNJ
X-Proofpoint-GUID: PM3cqt2PmExe9eO819h8MT6G2nUFQVNJ
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691f55ac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zflB3thc44jalDZYAu4A:9 a=QEXdDO2ut3YA:10

On 20/11/2025 14:20, Alan Maguire wrote:
> On 18/11/2025 16:47, Bart Van Assche wrote:
>> On 11/18/25 4:07 AM, Alan Maguire wrote:
>>> hi Bart, thanks for the report! Not a know issue to me at least; I tried
>>> to reproduce it with pahole v1.31 + gcc 12 and no luck. Would you mind
>>> sharing a few additional details:
>>>
>>> - compiler version
>>> - pahole version
>>> - full .config
>>
>> Hi Alan,
>>
>> My answers to your questions are as follows:
>> * Compiler version: gcc version 14.2.0 (Debian 14.2.0-19+build5)
>> * pahole version: v1.30
>> * Kernel config: has been attached to this email.
>>
> 
> thanks Bart! I've reproduced this now with gcc-14.2.1 + pahole 1.30 and
> it is also observed with latest pahole 1.31. Investigating now, but if
> you want to work around it in the short term, disabling CONFIG_WERROR
> should allow resolve_btfids to proceed even where duplicate types are
> present. Hopefully we will have a root cause/fix shortly though. Thanks
> again for the report!
>

[adding cxgb4 maintainer, for reasons that will become clearer below.
Context here is that Bart is seeing kernel builds fail at the
resolve_btfids stage; resolve_btfids is finding the BPF Type Format
representation of core kernel data structures has duplicate entries for
key kernel data structures like task_struct]

After adding some debug-only messaging to btf__dedup() in libbpf (which
I will send as a patch as it makes debugging these situations much
easier) I saw:

libbpf: struct 'task_struct' (size 2560 vlen 194) appears equivalent but
differs for 23-indexed cand/canon member 'sched_class'/'sched_class': 0

Examining sched_class we see:

[107] STRUCT 'task_struct' size=2560 vlen=194
	...
        'sched_class' type_id=480 bits_offset=5440
	...

[479] CONST '(anon)' type_id=8624
[480] PTR '(anon)' type_id=479

[8624] STRUCT 'sched_class' size=216 vlen=27
        'enqueue_task' type_id=8844 bits_offset=0
        'dequeue_task' type_id=8846 bits_offset=64
        'yield_task' type_id=8823 bits_offset=128
        'yield_to_task' type_id=8848 bits_offset=192
        'wakeup_preempt' type_id=8844 bits_offset=256
        'balance' type_id=8851 bits_offset=320
        'pick_task' type_id=8853 bits_offset=384
        'pick_next_task' type_id=8855 bits_offset=448
        'put_prev_task' type_id=8857 bits_offset=512
        'set_next_task' type_id=8859 bits_offset=576
        'select_task_rq' type_id=8861 bits_offset=640
        'migrate_task_rq' type_id=8863 bits_offset=704
        'task_woken' type_id=8865 bits_offset=768
        'set_cpus_allowed' type_id=8868 bits_offset=832
        'rq_online' type_id=8823 bits_offset=896
        'rq_offline' type_id=8823 bits_offset=960
        'find_lock_rq' type_id=8870 bits_offset=1024
        'task_tick' type_id=8844 bits_offset=1088
        'task_fork' type_id=236 bits_offset=1152
        'task_dead' type_id=236 bits_offset=1216
        'switching_to' type_id=8865 bits_offset=1280
        'switched_from' type_id=8865 bits_offset=1344
        'switched_to' type_id=8865 bits_offset=1408
        'reweight_task' type_id=8873 bits_offset=1472
        'prio_changed' type_id=8844 bits_offset=1536
        'get_rr_interval' type_id=8875 bits_offset=1600
        'update_curr' type_id=8823 bits_offset=1664


Now looking at the first duplicate:

[36354] STRUCT 'task_struct' size=2560 vlen=194
	...
        'sched_class' type_id=36389 bits_offset=5440
	...


[36387] STRUCT 'sched_class' size=64 vlen=6
        'state' type_id=28 bits_offset=0
        'idx' type_id=28 bits_offset=8
        'info' type_id=38195 bits_offset=32
        'bind_type' type_id=38228 bits_offset=256
        'entry_list' type_id=90 bits_offset=320
        'refcnt' type_id=84 bits_offset=448
[36388] CONST '(anon)' type_id=36387
[36389] PTR '(anon)' type_id=36388


sched_class looks totally different! The reason is cxgb4 declares its
own sched_class while also #include'ing task_struct-related headers.
Bart's config exposed this because he had CONFIG_CHELSIO_T4=y (I had 'm'
in my config).

If we look at drivers/net/ethernet/chelsio/cxgb4/sched.h we indeed see:

struct sched_class {
        u8 state;
        u8 idx;
        struct ch_sched_params info;
        enum sched_bind_type bind_type;
        struct list_head entry_list;
        atomic_t refcnt;
};

..and cxgb4_main.c has #include <linux/sched.h> and #include <sched.h>
with the clashing sched_class. Using pahole we can establish that the
BTF encoding is simply reflecting the DWARF representation ("pahole
cxgb4.ko" shows this), so BTF is effectively correctly reflecting the
underlying DWARF representation. This will make life confusing for
debuggers too.

So although it is a bit of a pain, I would suggest the simplest approach
is to perhaps look at renaming sched_class to be a bit more
domain-specific - ch_sched_class perhaps? That way it will not clash
with task_struct's sched_class.

I can send a patch but it would be great to get cxgb4 maintainers' take
here first.

Thanks!

Alan

