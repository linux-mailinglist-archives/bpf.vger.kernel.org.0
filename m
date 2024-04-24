Return-Path: <bpf+bounces-27732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CF8B154C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355A91C20D3E
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2819156F53;
	Wed, 24 Apr 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQwPhEz8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B3hgsSNx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8E156999
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995265; cv=fail; b=XFmRnI96GIicyNXml4flE16bq4+gVCybT4kMSr366kAkzPs9i3Fz2uMjCmGkBztx2123lItcZnD6cxWPIOMjNLaoOmYuRJm3Db4ViEUNod8Ws9oM5GEtkA3MwJCBYUEGV5QuNXkKY5wa7odft+qJM9VxrPSbiXmW9yibtneNBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995265; c=relaxed/simple;
	bh=U1TH/j6PZ+0odHFOdrrziQ2cgg776edABblObTOye/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfeFBdgYrkafZOlwHuFmfr0W/AoPhzoYXTAgJy3Iv3Ebqa6PHqcd/3GKr20WsYCSa4mHhObST74BUDn/bPlgo95hImmXlTlvSwMUhbientvJlNOOmLZLTrPOPCoCkj4zMZZzXFYfYzigTa66O9zv+3SzHOY7KN7U833AX/kN6hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQwPhEz8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B3hgsSNx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFeWUE018991;
	Wed, 24 Apr 2024 21:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uzdTvOWb6/GJqpYqx3ZzjScpFb7feLW+5VakSrv4qf8=;
 b=ZQwPhEz8w/+xRlbBqUfL1yqAfPe6vHj2IuM6zd9iBB7huMv/ZYzBgsaTk+4lyUkDwvGX
 UMZu/jFLFca6dYUo7xpDedOZtJYCRqg8NxZTDOtM6nFVD6FCfdCt1+Lq3fpA7/BO6MKu
 x+dPHIJF64xXRnbqHN90HQ+F4L7H1ZYfSPsfPUZueo/gWgmFgoQ4i0EYnB8m5K9zKwme
 K6YYuGQt/WYY0S265YzclYAkfipAdlasQa14Ujhm4PMMs8NY5AsWs4H7v0e76EKxqW3O
 8OvXF0BYfzANFMvhO4gr5xUGX5xY2HQ+Kpvxds2J6b8oyxmzz4dCn+OihT4L+F8cKEbI qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f15wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 21:47:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OLZupu019962;
	Wed, 24 Apr 2024 21:47:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5f0km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 21:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBn/6vzuHdgD/xo5VHoz5UCCPvwG9cOMX31s2EMJN21DqZ87SzzZIX5okBqlvyyVJe2yV3xetyBVKU4aonwYvW92ZILDkvnsLxPQHlVllZwqnmIOploWlfkaeIRuHOwpyvGMFnowStJ2lAm4HsJjBKUz+7wVQfMDHVZzgw/o3+Swcz3dFXh8w9QdPON/3MiN5n0GLu0dSc78DwSv4efTXSVgegeiFV9dPt3zeZIlJ2m4FEf3jJBMi/9iAKWuahHwNjuun0C0dyOdC0lkwSxCDNWw1voBd00KaW/63IlT6U2LLOSVhoR63OZiljsPUkHBnqPmivNClFeUCBHVQ1InKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzdTvOWb6/GJqpYqx3ZzjScpFb7feLW+5VakSrv4qf8=;
 b=fmIHFmGMYFmJjuZcCuJBkeb66ZXI6KHxsLKBKB/E/cqVznT2XJxQhUU5U+CBNfhv3az5rwlf/MmNswjSg8javoPnel1uNtr2MUH2gPcyvIVxlf+QaDfgMvBp6A6BSHKW4/6o1sdq5dffJhxja1vlqOg33YwdYZvzE241DBKy1ttJHwuU0KXRsm9ekCwl/YCfzcXZw8uD7w+90/8dlCwMrlsU7A4bRoqRmH5pBNhQ/dr+jHhDJarsQILcMnAC5v8Rut+9+9GwyNz9SHlKlJAIrh02TPZz95z4IjvhdPvK1nWHEL2nSIYGB8/OGnQ3oWODT1EMRvniPMitZNQGMBreiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzdTvOWb6/GJqpYqx3ZzjScpFb7feLW+5VakSrv4qf8=;
 b=B3hgsSNxR90csbXSb6IzlSwSxz882ZFrB9iY5jSA4rX5VcHDZnNepbrQDQBOFP2pBtZqvMAcHbAc36+HNml1mnksyVpxxw49jaZUNLp0F8sgxPCRIwBEA2BzxIG7ZJM1i83qcSlR0I94RXkec8sXdTyXevgpnb69pbrQjCSN8oU=
Received: from CH3PR10MB7958.namprd10.prod.outlook.com (2603:10b6:610:1c9::10)
 by IA0PR10MB7327.namprd10.prod.outlook.com (2603:10b6:208:40e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Wed, 24 Apr
 2024 21:47:36 +0000
Received: from CH3PR10MB7958.namprd10.prod.outlook.com
 ([fe80::b2cb:d08e:7e5a:a438]) by CH3PR10MB7958.namprd10.prod.outlook.com
 ([fe80::b2cb:d08e:7e5a:a438%7]) with mapi id 15.20.7409.049; Wed, 24 Apr 2024
 21:47:35 +0000
Message-ID: <4eba5d08-8352-4f22-b2af-b5e629adfaae@oracle.com>
Date: Wed, 24 Apr 2024 14:47:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman <eddyz87@gmail.com>, cupertino.miranda@oracle.com,
        indu.bhagat@oracle.com
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
 <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> <87v8465u8p.fsf@oracle.com>
From: David Faust <david.faust@oracle.com>
Content-Language: en-US
In-Reply-To: <87v8465u8p.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To CH3PR10MB7958.namprd10.prod.outlook.com
 (2603:10b6:610:1c9::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7958:EE_|IA0PR10MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: eb740da3-efd5-4d6b-9375-08dc64a826e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V0plMFNmdWxTd21BZ0Uwd2lXdEk0aWpSN0l1QmNYVC9DNUpKTjBBZThtLzlW?=
 =?utf-8?B?eHBwSGExWGdxN2JJTCt5RlA1ckRKMllpWEdjYWJYcWdLV3NsbzlKU0N6UnhB?=
 =?utf-8?B?VVdBWWppMVVwQS9rWEhzU2RxV01tZ2JuTGxyK3RYc3Q0emdmSDhaeXJHc1hi?=
 =?utf-8?B?Tm9aNW1zQzZVaEFLNWQxN1htV2V0MUxtb2NKSWtxVDhNeXFWYU1CQnlGWjV6?=
 =?utf-8?B?a0gyNUtJcjB4UTc1RHZKTTJzSlhDVE44QWhYZSs4NmVleGpHOExHOTlQd2hE?=
 =?utf-8?B?cEgxeUtnSVpFL2pLaGtaMmFTdGc5Nk95dGNoa3NMSjhDbzRweEZBZldsQ3J4?=
 =?utf-8?B?UU5rRXUxU2RyTjA2ZUxZRmxXNXdha0YvaDZ2ZU1JeDgwOEtiK1h3TzRJbkNt?=
 =?utf-8?B?Ry9tSTRMTzQ1ZlNMd1VEL2x1RHdWbW5mTGhXVWNzZmVidG8yVktFUmk4Y0hO?=
 =?utf-8?B?cXBuanJ0RU5YUXlYekJBbHFTWDB1VEZYTFE1TUdsVm85OWRVb3JsYXVpQ2xE?=
 =?utf-8?B?bExvZEp4SERwbzY5bzkreTJtbmZMKzlCS1B2dWRrV0RpQmROZXVGbXJhWmIz?=
 =?utf-8?B?Mlk3c0M0b3VUSDMyY0FjQUMxVHZ4ZUZxZUN6cFdueG9rN0hRZHZmZUowOW1U?=
 =?utf-8?B?NlVDU1EydTB1ajRueGZ5eENVWExkMDhNb0taK3lWaVNHOUNqbzdMckcxTDBt?=
 =?utf-8?B?dUpZRU5nalZkeVNndzlySGNiMG9XVmpPWlZPa1R4QWE0SytoYjI0MEZ6aVNC?=
 =?utf-8?B?V2hkVlNyNVlLSGhKc1ZJZEFJNlBVVVhHRXhHbE9nOStnRStTQUNGTUZDVkVn?=
 =?utf-8?B?ZDVkRXBTbWpuVE9aNlRjUXJnSW13SU5VQkVzWkxqK1A1anlDU1RWbUxYVUJY?=
 =?utf-8?B?STNYWEdTcERGVzlId1c2aGRQY0xOMmdGZWU1b1FuV1d3WWJZUk9lTk8wTVVM?=
 =?utf-8?B?aEt0RStwaVZjV1hSZHpiUjBmUkN6NHgwV3ZRb3ZMY2dIaVN6RzYxY0w3RTlP?=
 =?utf-8?B?M2dTRlBhSFJxOC9STkJ6M3FLQjBRcnV2TVVnZFV2SHVuREhxVy9UUnpUVU9O?=
 =?utf-8?B?SE9TQnpLcnNtaHE2QlgyVjF2K1dONVR6dDBjbjhxNFhpekVBQnQ2QW1Zdkxx?=
 =?utf-8?B?dXZFVEVnTU52WGRzczVsUWVQQUgybjIzbGJmUnRtUUhiR0NqOEM3VTNRN25N?=
 =?utf-8?B?dkpVbFhrRGovS0ZuRkxzQmN4a3Jmc1V0L096d3RvTVFoKzJZY1BuajlnZHh4?=
 =?utf-8?B?LzhqeW5RTzZ5WFlkdUgyVVVYS2lGOVNSbk1qU0lFczBtZ01PNlBzYmxtNGxI?=
 =?utf-8?B?c3NEdU1GWWxDazczTTd6bldkOGw5N2U2NFhoUENoOENIVkJpSk1GNEl0bFd0?=
 =?utf-8?B?ZzBQQ0FKL2VXWEl6UEZLODVVODZTSGIydVBNSXQwUUNyM3loSmJlOEFpRHE5?=
 =?utf-8?B?QU8vWWlIR0FjSkM2N3NPeWx5OGlaSXlQMlY4YVJFeWVjQzUzb21oRlVpa1Zz?=
 =?utf-8?B?MURUbXBmVmQ3cDNzN0RTdFpIeklodGV3ODVnTVNDNE1Ra1BTeGpWS1R0SHkv?=
 =?utf-8?B?ZG8yV3dvYU5qNFFGL2hWVzBsNmUyNHJEejFSdjNCNWR1R2xRKzlaYzZVd1lI?=
 =?utf-8?B?Y0ZBVmFzTCtIV1AyTm9YR2FoS0VhK1I3QmVHa0pMUGtJQ2tyWFRRNThBcWlk?=
 =?utf-8?B?dlp3OGV2N3I3Rmc4ekthMGYxb0FPTG1kZlZZSUs5aGVhU1FXME1GeGZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7958.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkQxL25FU05DK3g0ejAzSXJGZDRabU9pbitNeTNHbUN6UW5rVlNIRXJUMDJJ?=
 =?utf-8?B?dVdsVXE2VlpkQ2QyaVBSaDZEYnQ0MHhJbUMyM2hqakNnTVdMUGpaakVtV2xr?=
 =?utf-8?B?RDNFZjV5YWJDbHhzRGhRQTh4bXNlYmtDUGF5QnFobHIxM29QR2M4YzZTS2gv?=
 =?utf-8?B?MVFXK080NGVyaTBSSmFxTVdGN3RnQkk2ZDZ1eDRrcjVVbVlwc3RpMVJBS1ls?=
 =?utf-8?B?QWxTT0lady9qemZTL0c0a1crSFg3R04zTDJxYkNrODFxc3hZT2xaV2pObndR?=
 =?utf-8?B?cDBoNFM1RVhlbDFnSklNd3g0ZmJSUVJjSUVYS2w4djRMeUhZVWFyejlrem1E?=
 =?utf-8?B?K3ZxQXdzTjg3QnJpdmtPc01lSjdrblNGYXlpdWl6cHVndGNYUG1wVVBWZnFa?=
 =?utf-8?B?U3hIanEyc2I4RExoQzFZQXYxMjd5WUN1UG9zQVRUNHFKTG5DWGxKaTBJa0NS?=
 =?utf-8?B?emUxZGdPRWhWUDlpSjVCbW5BaW9FMzlpQ1ZQaXl3Q0RGRlFHa0JwazNuVUp4?=
 =?utf-8?B?OXRmaGJmbTRiV1FycTA5ZVd1Q0JJdFBxWmNNRmxhdWhNRTI1MTN6QVhXVDg3?=
 =?utf-8?B?OUZtVjhlM05qbzdWOWU2azIzQjBjMmgyWkU1VkRrKzZ3Z0pPNWM4OElZNXFr?=
 =?utf-8?B?R05nbHRkZTBFUno1V2hQeDBBbFZFSWd4RjFuY1dIMk1kZVdjSVZCNmNSSnRa?=
 =?utf-8?B?eGJ6dVc1YytNek54WCttS0o0VTRSQlp0ei84TURIOXZFS0pCZzZIYVI1Ny9s?=
 =?utf-8?B?aVpWZEZUNjM4M0RSY0o1NGIvUEJQUGdHMG5UbFArbzZkRklhdEVkN2tISURH?=
 =?utf-8?B?TXlDUWp4QmN3M3dkQThqb3JWMkpuUnVHU3hORU5zRXpwNnFLb1RTeDJPN1dI?=
 =?utf-8?B?ZzM2bSs1RU5vcTJ5bDdpekp5VGQxdXpWZXpQSXUyNWFwRnhYR1RRaTJJWWxl?=
 =?utf-8?B?UlJZRGhIcXJhNkc4WklWV2lienl5QkYvN1dyWlRwZGgvYkVBcGtld3VuTDZW?=
 =?utf-8?B?VWx4a3FoRnhYdzdETEtDa01FKzNHa1ZMSU83Y3N4ZG52WjhwYjhrVTBYVVJv?=
 =?utf-8?B?clBjTlZSKzRzdnBPV2hvYnBQQVk5SUw2SFdacWcwUGxxa1p5OGEwUGp5UHMv?=
 =?utf-8?B?UjdnUW1lbUFsbVJXTnBjUllHZnUwQzl2bkpRTGp2UGJXTzB5b2JrK2JCcWRS?=
 =?utf-8?B?UzNGeHNzMXVVajlhTXhDZG9aUTBVWjVpV1ViM2dvOFJWNXJ2bXY4R2wwYnZk?=
 =?utf-8?B?eTBNNDVFcXFscnB6NjlJQkpMaU12dFIrMWpaYkRna1BiL01penh5Wjd0MWZP?=
 =?utf-8?B?NGthbVR4STNPOUMyeldIWEs3ZmQ2V0l5QVdpclUxVjBUeHpNWnNpY1k4and2?=
 =?utf-8?B?QWZhQTdGMEtsNnRiTHgwcjZwOFZLbGR6QlA5akt4ajkzUXZkc0RzWUplZjJw?=
 =?utf-8?B?NDNjOWI4NzVpNGJpL09tVEJNRUZJVkhrRUh0WHNDYzN6T2lJOGMzcjJqeXp1?=
 =?utf-8?B?ZXJqQkVjZkw5TjRMcU91RHl0MktaN0p1UUVwN0RFVmZmVHQzWHI5Z044VzBD?=
 =?utf-8?B?YnlESnV0bzFYSG1LN1dBZ0d3amdVTTZ3bHZkUkVieVJRd3RQY21ZUlRxaEg3?=
 =?utf-8?B?T3gyeWh1ak9Qc1dtbHozV1Q0WHU2VlV3UTJtdFpaSjZ4R2lzbW1nUDBxVm5s?=
 =?utf-8?B?cWMzdDdYY0tFNWlzVXZoK3JZbzU3bThGS3NqTWZXUmQvK1R3WHgwdkFSbXNY?=
 =?utf-8?B?WWpxNGtBN0Fza0lRWWVYSDhKWUUvRFRzZkRxdVNRbDI2K1ZOZGZMVE5VRzhm?=
 =?utf-8?B?WHlBWDBlZXI1d1E2VnZGWlFoUWtxa0MxT0Q3QktoVTJjblJjbHFJdnJGMEJo?=
 =?utf-8?B?aXVkQkhiRGxITnAvb3YrakFxZkVHM2drTFpEUlU2RDl1V3BjRzAwRU94YjVN?=
 =?utf-8?B?cktKWWNUbHUwSEluMWVySi80YnRBQ1k4NU1ySFZXT3A4cXdDMmsvc1lCT1Q4?=
 =?utf-8?B?QUlqUGFwMnNMUzN0M1k3Y0JiSW5vZnNtZld1NE5oOVh3WHE4blhzV2F2ZC8z?=
 =?utf-8?B?QUNSdXkwSGpwSUplM0hDTDNqZS9UbjBNN0VnMTFuaWs2dmxrOW1nOW5vWVlS?=
 =?utf-8?Q?hJXtMAbRKLFea8Dn9Dcgxow4C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PZ8xyGiOmz+bD7RvPfTFd0RIuUJjXLnQ3uxH2sdezduxVkCJXQ4a87Bw/EyxdZO6Oq+nNPI5Q4rYEqzmumJMsbPL1s5GIWtw7SaEhu4zNqJjRKVM+d6YRvHvOeD8IVnQCDZ7GuoYUMI5X8ebdnnQ0i/SRWFKNDC1AkWquhxfzKTNqogg9F16TeEMpT7hC6uCQ/dHqbzkYzXHKhWiiGnCLJ3FekYhPpYFiar2vqUybtG96/dfJo9DJU+WbBBCxazjrDGHnZjxmYNNYdwiaAjxQKFln15lPVkySwQc79R+s5KaW3TzmAKxx9FfbT0eObChBVUth/PnDEZuWKIVqa8OXjIhFK+BAVkf4IqBZP2uTsdg+KcObvsEPF4TGDrHXWuZF3p07/jmTiA1xz2To8KJ1eie8XUe2oPK3qf72BAdQIYwKE8CEKKmXC7W43s0k7Wksm3ALg2/8IzOmAQg2AyU9lF9xiic8RPV9hSNe2rxYn83VLoSAIYXd9HOmOztkzxBkMOevzkV8gbzAeR17yWJcYorphGUaGYkkIDnFPty9amjYV4P7OGKN8M4MLCKbXjHbfcUJ0hv2uRhhkj3Ai1UmzjIyF9nufCZMFSHrRlzRFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb740da3-efd5-4d6b-9375-08dc64a826e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7958.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 21:47:35.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghHCUKqMHh8KgHKt8RsiN9/h6kgzXmnzQ2qEJr4iGHTER2ieITdfQdWIZo0k79R2hNoBJj4Ja6infcZXyX04dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240111
X-Proofpoint-ORIG-GUID: pSSTizrOHy7okkmsBoROOFofw1yK22sz
X-Proofpoint-GUID: pSSTizrOHy7okkmsBoROOFofw1yK22sz



On 4/24/24 14:24, Jose E. Marchesi wrote:
> 
> Hi Yonghong.
> 
>> On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
>>> This little patch modifies selftests/bpf/Makefile so it passes the
>>> following extra options when invoking gcc-bpf:
>>>
>>>   -gbtf
>>>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>>
>> Could we do if '-g' is specified, for bpf program,
>> btf will be automatically generated?
> 
> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
> -gdwarf.  DWARF can always be generated by using -gdwarf.
> 
> Faust, Indu, WDYT?

I agree it makes sense. Will need to look for the appropriate way
to set this in gcc, but I am happy to prepare a patch.

> 
>>>
>>>   -mco-re
>>>     This tells GCC to generate CO-RE relocations in .BTF.ext.
>>
>> Can we make this default? That is, remove -mco-re option. I
>> can imagine for any serious bpf program, co-re is a must.
> 
> CO-RE depends on BTF.  So I understand the above as making -mco-re the
> default if BTF is generated, i.e. if -gbtf (or -g with the modification
> above) are specified.  Isn't that what clang does?  Am I interpreting
> correctly?

This is already the default. We enable -mco-re automatically in the BPF
backend if also generating BTF, unless user explicitly disables via
-mno-co-re.

This should work the same way with plain -g, once -g means BTF for the
target.

> 
>>>
>>>   -masm=pseudoc
>>>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
>>
>> Can we make it the other way round such that -masm=pseudoc is
>> the default? You can have an option e.g., -masm=non-pseudoc,
>> for the other format?
> 
> We could add a configure-time build option:
> 
>   --with-bpf-default-asm-syntax={pseudoc,normal}
> 
> so that GCC can be built to use whatever selected syntax as default.
> Distros and people can then decide what to do.
> 
>>>
>>> Tested in bpf-next master.
>>> No regressions.
>>>
>>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>>> Cc: Yonghong Song <yhs@meta.com>
>>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>>> Cc: david.faust@oracle.com
>>> Cc: cupertino.miranda@oracle.com
>>> ---
>>>   tools/testing/selftests/bpf/Makefile | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>> index edc73f8f5aef..702428021132 100644
>>> --- a/tools/testing/selftests/bpf/Makefile
>>> +++ b/tools/testing/selftests/bpf/Makefile
>>> @@ -442,7 +442,7 @@ endef
>>>   # Build BPF object using GCC
>>>   define GCC_BPF_BUILD_RULE
>>>   	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
>>> -	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
>>> +	$(Q)$(BPF_GCC) $3 -O2 -gbtf -mco-re -masm=pseudoc -c $1 -o $2
>>>   endef
>>>     SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c

