Return-Path: <bpf+bounces-28387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591098B8F11
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB351F22D31
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877611B59A;
	Wed,  1 May 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ondMiUX3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cnmeysMh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01EFBEA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584713; cv=fail; b=CyU1gIfit3/GW+RymwkcbXsVONGv2nMG0Vp03JkNAlHA2w7Ueyyn3boGiXxab1yGbBePXQ345DvHe/NMotTwokG3dqQ/T4v+tG2jhrjEfsLgaD8mLy1nN/6b17R8hfl2gikHKJbUYPdzx9t/V6q1n7qz/DZybn6qZDrYxZxGAFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584713; c=relaxed/simple;
	bh=I6/fMqXj1l4giCnKCWgZH3+UYJmKTZh7RCStK1ifq9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aLugfWMkSwomIzaSgy4XYSSJFkthcLhpisN6bgD0ac6IIUxnCOYFWkyJ/nUF+/v4x+gArLJR85hlK75IrUiMFeUhXd57/PBYMAbj5AbqmsMK0twnWy9xy/3uJkTQXx+4SxPypmOnSNHRdPoEyo6gKo3/lfhG9bVaCgT2Jd6NokU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ondMiUX3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cnmeysMh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ARrm2001642;
	Wed, 1 May 2024 17:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Da6iVyQxLwOgPj5/2ZzW78H+IJnJTHBugYJMWp/HLVY=;
 b=ondMiUX3cykyradGMvym5COWGYw7Xkt7xOLRgq5Ciu9owJ2wFzj4sjan7viK1sjB/8QQ
 QkigzSgsW2KP8A+raBkvl4kXBdIYQ3vRcnQG5E227YnxQtCYs6sp0bqzwYFbCv3kKLF9
 xNz8M44mvpZl0S5s9gFoMxnmnZUTdT15g7DWCOXx+RU2JyU96Ya+yrQ/kfSAb1Z6wcsW
 vwQpwPtb4as3CHihMYN8GXVTsvq01NC8SdlC4oRrCr2K88pwEudIrwQSbyAIDA9tNZYR
 wA72OmeByqNVVK1pFHujQ/33wE37Yfa4EBkHIt5OpzxK+t2hhtABHJzIl5cImXSXO3ML 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cqsb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:31:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441HGh2U008609;
	Wed, 1 May 2024 17:31:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9n7e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 17:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgLAMxa9GPYm5ioErCf2ol+dbceX0Kfn8bjPIHFXDkaB4MjNGrcBFa5/jzKl2WVR07wrFuktLSd9Mc+pXVGJkFLeGifQ8204L2cLiDPXEOtdU+AhL6T7DBYyZwKjx4kwAmpLw4Gtjo0y5QWnKXZaSX3U3Cavr0hluXxMnMOB9845vOofRjc9l6NogEYt6bzFIHBbJZ6t935av/+BxgrvnMWqe+UBiVv39zyHaVuroe6s4di9T/YHuay1g9n3j206lxU/Nv+Bq471elxyIORDhM2ILSY7XCCnJpTVDf2S1Qr+OiQTaFy71pOKiXk2OlTVE3I40vo3vHhXga+PKfIyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da6iVyQxLwOgPj5/2ZzW78H+IJnJTHBugYJMWp/HLVY=;
 b=fB2sOfPTxBu3fiKECPcv629pWar2YDFrAMN5uqHB3iOpUSV1wpY9zJhiZILBKBChcBDLNEUXevHKWowsknIMuKkdbQxP3LQ6EpezDxOq/dLqlFKBXb5ABZjY4G+4N/ljm2XqJqN2MJto3eI7D4sVB3NIQ0KvrYVSKEWX/TQ6nWe5bc+FWsVgk2h5o4yHxgRj+NeuDYzCfEnYM8o2Wmbo0+GlAvP5V7DI+y9c7etLuYv+TF8kVoU1WCKYPN7mYokac+4EEhPPxfV48h0MardWTt4A5Jl0op9WAJK10Bx3ZdTtPWhAZ79AnUw0XnLPw/ZuRQU2OVO1LYT1WCCQiO4tXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da6iVyQxLwOgPj5/2ZzW78H+IJnJTHBugYJMWp/HLVY=;
 b=cnmeysMhRg6r5WpCyOrpmE18/MjFRS4dhRLRE/GdD/a4EQDnZkvDTZQVHUdNA6YqoUjkpcn+VJ9/8zJBGo0IEe/X1FQGYiQmusMFd9b0MOTzfI03EhgGNNTB83H0eONE6GzLnaQEcm/CKGSZlqlSSVSFFq9Hw6ZgPYL8bIaD868=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 17:31:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:31:16 +0000
Message-ID: <e60a8bb8-6202-47a1-b099-b47f334de472@oracle.com>
Date: Wed, 1 May 2024 18:31:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 03/13] selftests/bpf: test distilled base,
 split BTF generation
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com, mykolal@fb.com,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-4-alan.maguire@oracle.com>
 <d73031b51394b8db13556177e42820674dcc8157.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <d73031b51394b8db13556177e42820674dcc8157.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: e3346326-129f-4431-41cf-08dc6a048182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHRsS05rV0dQWDBCTnJrQlJkRXg5cmY3aDUxTmdQK3FNWmxvZ3FXY1VtOG94?=
 =?utf-8?B?UVFEc2hKNEdiTVZiQUYxcVBUMU04blRJM1hLcGVpOWZVQlY4M0xLL2hVTEU3?=
 =?utf-8?B?RjhQcmloUnpINWNYdU1oTXJzbFpSN0huM0JmWFlrOGg3emo4bWlPQ1JkT29s?=
 =?utf-8?B?MUE0MHBwa3dLSUN4UkdmSmFVazA5aWpFZzFOc2g2UjdsZ0ZWMGNCVzBVVWRv?=
 =?utf-8?B?QkQwZmhDS3JxViszUXp4UHZEbkNZTUJud01SV09yMWhLYjIza1BBZFFaQmUx?=
 =?utf-8?B?M2NVSVJiWHpvMFlia3RyVTB3emZVMnhpRHBESklkOWQrbzJyblU4OGc0SzVQ?=
 =?utf-8?B?MEpOYXNoZmp6ZHFIblZFQVVRNWVUbVRFL05wQnVoUkVzSXFYUlBicmtGVUtV?=
 =?utf-8?B?YjM0dmczc2ZES05zWXB1OHhiZWV4Yyt1NFA4bzlrcFdwV2JTRVg2KzRRY255?=
 =?utf-8?B?L3ZQWXlRU2h6T0p0cGVaZEdNMGpseGh3bWxQNmJLdFNVdm9EU1ZEZStPVHVs?=
 =?utf-8?B?emNXTFo3S3BNc3ZLSEZ3RVdweWN1aDRnY3A5cDByNWhqSEFOWDlGdjhkUGhG?=
 =?utf-8?B?OWtQZE9xclJVWldGTUZlNzlmb2FDUGR1dFp3Unh2WWJoZjlVdjN5TEZZUU9Z?=
 =?utf-8?B?a21iaFgzMEg4d0JQbFF4WWltcU5nOFRkU1JDUDUvRHdza3JkY1IvUXJlaHNm?=
 =?utf-8?B?eUV4dWlaM0pibmFrV3dwRU5WeHVzS0o4cC9uMVh4MWlPaFFQNllXWGhSNFJK?=
 =?utf-8?B?NWVvbnp6dDFnNXljdE1lMkxCQ3Uzak5vVnJzN1J2a3pLOHNvL3lkeGowMFlW?=
 =?utf-8?B?YjVsUFRnZ1p4bGJZc2wvdmdXSSt5b2d0cEpib002aHR4U0N5S1FIWXhKZjVK?=
 =?utf-8?B?UEhJbDczZE81bmV1am1Xc0NqSkFsTFEvSHVkZWhndXJRWXhKRUVHZGE4S1I5?=
 =?utf-8?B?RUtYOXF3ai9RYzh6VWdrYTBvbkxjQ1JSRkF2dFZkL2FMdDltSHZlODRQd0Nm?=
 =?utf-8?B?YnNTSkg1RTR3Qkh1UXRUSC9nTXRUVzJpVlNNeERnRlJ1cVJGdmJ2NW55TXVx?=
 =?utf-8?B?VXdMN0R1Ky9YN3EyTHp6bEJVS3BBeXZLYUpOSlJqNGkxWHRRYjFmT0IrT0hX?=
 =?utf-8?B?VG1NY0xYM3lieVpmZE1CK2FUVG1qZDhxTkw4d0ZJUHRkTUtlMXVVWnBOZU5L?=
 =?utf-8?B?Q1FkM2pCKzBMWHdBNm1hZXhzeUdIT3F4bnlBRENHNEV5UzRNZC9VR04yc0F5?=
 =?utf-8?B?OVRaN0xXZG9KUUlQTmxvYWRkeVdqSGN6cThCdmFTOW14Z1d4dzlSWSsyUGFB?=
 =?utf-8?B?MDZ2aml5cnJkT2d0SHpLVklJbFMvZDBJdTZWc2s0b0FmVE1VRERhMlhLeDcz?=
 =?utf-8?B?VGl5QkFFMm1SUE1aTkc3OFc5N2xQTDVUTkpiclhsNTlvUTYvdHh2dzhYZ0w4?=
 =?utf-8?B?OTNybFdqNnF1U1l4ZmdFMkVhdW1DWkNPRzljeE1XUGNISHprZHpydGpITHR0?=
 =?utf-8?B?WTRTYVZpK0t3eXl2a0s1YUlMZWxDMTkrZUNySHJrNVFlbmV6RVUvR0Y4OUpY?=
 =?utf-8?B?RTFBWENCUm11ak02akJUWWIwRjlpa2VNVWV1RUxXRWU1U09TUGdLZTIvMDIz?=
 =?utf-8?B?Y3NvVUZRZWZTM3dmUFRsaHd1akwvbjlhOHd0VlVuREZLc0pHNytkbUtoU3dF?=
 =?utf-8?B?L1R3UkpJbWY0eHZNZmxycm5RWnlhelFOcXpQVjQ1dS8vYnJmL1BzaC9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zi8ydmZFbVEzc1BNVkhPV2VzeW54M1p4Rmt3c2VQM1NlcklTdnVJMTg5SXpC?=
 =?utf-8?B?V2dOVXBSL1ZsUjhTV1kwK3pUWnV2S3QzeDh2S280QW9KcmpLRTFYR0xBdk44?=
 =?utf-8?B?eTJuM3UzQ0l1RlRGMy93anJLQVlvb3ZIOXl0QUszWm0zNGpsRDZoVW5tLzRm?=
 =?utf-8?B?WkZreUk3OXNZNGx6NTMwclltRmlCOWU5cW9uNzU3ZCtRWnVwUnVEOEZTL2VE?=
 =?utf-8?B?TWVDUkFlUllxYWlNZWxnTUVRWG1VdFA3Wk14eXZPc0V6OG1VMy9XNWROQlV1?=
 =?utf-8?B?ZURuWjVqcmdVRStKaVpHRmFkZTFTTmdZdWhPamFUZzdqTWQxZ1NEbkMza2JY?=
 =?utf-8?B?S0xHbGxlS0hmQnd2Qi9TaGtHQTBTcytVV0U5RmFoVmlRekxlaUZ6TkNFdUVD?=
 =?utf-8?B?VGZXVnYvU2xGQnR4eVpxK3p6SU5lUmJKQTZ2OGozc1ZFWERYWk1ML29nazV0?=
 =?utf-8?B?WFRhSC81M0FYanJTRFNMczU4cEdUOXRMM1BaVTAwY2FCY1kxV2o2K0hTUjJF?=
 =?utf-8?B?cWNBYTFIZjllRXVXV1dVWnZNYmdGNXhyaFE1T0d6NCtNNUxkV3ZBb2JFbTkz?=
 =?utf-8?B?WWthNy8wTENhenF5U1YxaWgyZzJnLzN5Rmd1eXBLTjlrbkk5RFRxaXRJa2hR?=
 =?utf-8?B?QUpzRS81elJOVXN3WkNaSmFUMnJpTUFuSDhEM1F4bzc0b1hZcDQyL1hhQUxy?=
 =?utf-8?B?N29CdXAvMklZQ1MvcVd1UDMrSDlJbG9LSUVFWS9QSHF1b1JURHFicGlubCt4?=
 =?utf-8?B?L21NYW95UHZ5bjJvWnRya090cVhUWWlQc0wzcnNQRHNkd1daeDFEVVgwSUNL?=
 =?utf-8?B?TXFYTXUvd0RiWGxQTVZxYTQycG4yTHRrclBmdzJxcVNHWmdrR1JvNDhEeUtI?=
 =?utf-8?B?Qk0rdGVjYXVJVmhjTkpDRTVOZG02UElneXU5N3ZzVytYUHB5Vk1kbUduYXZG?=
 =?utf-8?B?TUMyZWdBODlrVXFzZ3Y0NTZGRGd4QXhodEdITG9WbnR3cjhJdEpXbHJFdGxj?=
 =?utf-8?B?cFV6ZmRrWWx5WFBZY3o4eVE0T2pEcUQ5MmJzS1ZTS051dnpJczV5N254Sm43?=
 =?utf-8?B?aXUwQzlWMmxScjU2bWI0YWt0T1pNVXVsWWZDQkJkdWROeEJXRHBWZU1FcWJX?=
 =?utf-8?B?QUNsN3JVVzJoMXNrNC9GRldtMWl3QzFTZGEwM0ZFeFJNdnllQ2JaNXNia0Zv?=
 =?utf-8?B?cjg3VEp0Y0tRZk5OLzVrZWZ0S2tuWmM5N0lDM1N5NlJSb0R5RVhzRzVmcGJz?=
 =?utf-8?B?a09nVlp1dExLVDdtQml6OGpQcEVrdkFUb0tBVzN6ZElXRjJ0TTZDMmVCUDIr?=
 =?utf-8?B?bEVLSmorWG9ndEFjZm1TSkhhbDkyNmtUdmx1VUFRWnpSVUIyN09JSzlmQVZ1?=
 =?utf-8?B?ZFRrWVB5dzdoN0NSN1BzazdoSHJHNlN3K0NseE01cHNWQTZRQWErUHI1WENu?=
 =?utf-8?B?SzVOSzc3YWIwN3hOK2lXVGNhc3RDdEdwQmFFeWdxdHRVWU9DVDNWcUZmT0R2?=
 =?utf-8?B?OThycnhJSHhid2JRN3JJZ2Vmb3BoUGNEbTdFczZEUDlBellpbS9YY2l3K0Vu?=
 =?utf-8?B?eElEeXltZWdlZHRrYjdRbGhRcmZYczk2eTAyQklwQVlEYVV0L3V6YzFPdW5L?=
 =?utf-8?B?bS9xc3VXWWt3SENpTFZTeGd6b2Z2YTVNL0RoazlFaWFBS2lVVUxubCs0UzBm?=
 =?utf-8?B?WkIzMytrUm1mZml0aksyN2g5UmU3SUpjYnVYbE9lNThCbklDZFBBaDd4Tkc4?=
 =?utf-8?B?RXkvcE9JdmlpdTBLYWw0T3JYTC9aaFRpSDAxYXJ2WmsxTDZnTzBLUUF0eHBw?=
 =?utf-8?B?Q2JRSTV1RlBtYnE3aURGTGJsY211SGhSOGxGMEN5WEdoVFNKOVk1NWRFVXhm?=
 =?utf-8?B?T3pBRy8vbk1hSFVoK0dRTDFhdW1NaXZwYXN0UXlldC9hOWpOZHJOVEllZ3Yv?=
 =?utf-8?B?dWpWMFRhTVY2WUJ6clRJV0FremxscUxobUN6aTZvU1l0V1FybHJndkJ0U3Vt?=
 =?utf-8?B?UTB6d20wUkFWeDNNVFY0Y3RGS0xML3N6Q1ovK0FjL2hEcHFsTFpROThLZHNC?=
 =?utf-8?B?V2l4YUU3R0xpaHFCK1pVMEt4bFBuVmtOaXlvelFpN3VTa3g0Q1psWG1qaXUw?=
 =?utf-8?B?QndITE5hWWVKMkwyNWU4MFdFb2poWG1xdThJWTNMTUliMkIvK3kxcEdjRVFx?=
 =?utf-8?Q?Ek37/q7WmqAF1Y1EtPvSVuU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/mggJUc0p9Q0tFRaXbsX9YPKuXgqN+Z6/F4wypY5OSu2534E5zZofLpcUHxDQ+CWaXtYOw6gy36hf/k0+yUh4QoZOlOa4pWpDycetFVmlkHoNapxD6deYHyEbDPsCPUY6g+PkkaFDOoo1xPQbNyEdB29qQF6kvbZ3ZIOOJs6pYKkpa9j8/t/+A0FGI0LW9NL0Cr6JpSAKYJ1WyrcrpwPWYgKHkcKBjuToZh9nKdegflqnjGh7rPzhulQ0GAapsbPG8qfEJyWjCpIBYA/jMDAXlmP/Tttobm02xwn07bbxun2D7a/LsxiNaAaXuuTzJmx2VGQab8KyeByPPJgmhtahitXPlPEOSZmh9ag/05x1WS00n/22zlE8FcLfcTju59KpUgpTzuLPysAr+qg5aJvOhvxqhd248ETN3f1ZsRDvJWIRF0yhunQsv91nz38FYMoXojMuJIAarg7KeTMGqSh9LQXN0F5Q6ESJJRqigqeshZL5Kxp0FOe+Jtfb0wClD/bQ403peG8KskXWCr+5mTi0HU4f1ZJ8E7PS8ZTkreXOcHgkkbB1HVMsz5PpYz3hP+8YrC1RxQGOcZLjoJYx8LDIvbxj7DLS1T1/mi+y9NqxdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3346326-129f-4431-41cf-08dc6a048182
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:31:16.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejVA/kJbBujCVqKvVkDs5HVrR/dTP+M/r5wzHChMCY7U/bqXVK0qhVUJz1X+j82R/bEuAOqmh5PhFl72yeGA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010122
X-Proofpoint-GUID: LH-ZbsHV6Dw-qaaYycVzCIHyGqNLFOWi
X-Proofpoint-ORIG-GUID: LH-ZbsHV6Dw-qaaYycVzCIHyGqNLFOWi

On 01/05/2024 00:55, Eduard Zingerman wrote:
> On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:
> 
> 
> [...]
> 
>> +static void test_distilled_base(void)
>> +{
>>
> 
> [...]
> 
>> +
>> +	VALIDATE_RAW_BTF(
>> +		btf1,
>> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>> +		"[2] PTR '(anon)' type_id=1",
>> +		"[3] STRUCT 's1' size=8 vlen=1\n"
>> +		"\t'f1' type_id=2 bits_offset=0",
>> +		"[4] STRUCT '(anon)' size=12 vlen=2\n"
>> +		"\t'f1' type_id=1 bits_offset=0\n"
>> +		"\t'f2' type_id=3 bits_offset=32",
>> +		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
>> +		"[6] UNION 'u1' size=12 vlen=2\n"
>> +		"\t'f1' type_id=1 bits_offset=0\n"
>> +		"\t'f2' type_id=2 bits_offset=0",
>> +		"[7] UNION '(anon)' size=4 vlen=1\n"
>> +		"\t'f1' type_id=1 bits_offset=0",
>> +		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
>> +		"\t'v1' val=1",
>> +		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
>> +		"\t'av1' val=2",
>> +		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
>> +		"\t'v1' val=1024",
>> +		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
>> +		"\t'v1' val=1025",
>> +		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
>> +		"\t'f1' type_id=1 bits_offset=0",
>> +		"[13] STRUCT 'embedded' size=4 vlen=1\n"
>> +		"\t'f1' type_id=1 bits_offset=0",
>> +		"[14] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
>> +		"\t'p1' type_id=1",
>> +		"[15] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3");
> 
> Sorry, one more thing,
> maybe add a a FUNC_PROTO referencing a struct and refer to this proto from btf2?
> To check that FUNC_PROTOs are visited as appropriate.
>

good idea, I'll add this. the test will need to be reworked anyway since
ref types etc will move to split BTF.

>> +
>> +	btf2 = btf__new_empty_split(btf1);
>> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
>> +		goto cleanup;
>> +
> 
> [...]

