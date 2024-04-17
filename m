Return-Path: <bpf+bounces-27045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A58A831F
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD961F252A8
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540E13D61A;
	Wed, 17 Apr 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BvDz1FhY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ROcDDov5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941A13C8FD
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356711; cv=fail; b=QFdXRjAj+CGGtG4jWhS1gLKNFknYo7A08rSfmKupVl7u/f71N5Pyyi2b2E54AH0AAEQQ02YTCjw3N9+eB9FuGteuleLZ1kr13ddMbeAc2tPm33zt4GWhzhq44LslIB/s5Mgv5tY6XGA3l162hsbbT1vCDYwwVIGMNawmYu+G3q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356711; c=relaxed/simple;
	bh=UORXqqI4e/NJ5pHUO+5rCM/XYV7/ungTVN3Fzghi4w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g8t/XZjtkEonvwaSxa/b+gq60oC/Pw+XOO2sRo6F7X6XiRUK2winnZzb3lowt0OwzM41Z83oqqYfbzSi6pKkoiEu+Exp7ogEOQlukUQPn6/Mzp478PwIt7lNkMIpwAjbExdBOhmSHL45stxKwi7lL9QpLrfzOlqOrSWsN9CtUmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BvDz1FhY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ROcDDov5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xNq4012432;
	Wed, 17 Apr 2024 12:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=snbHceJIm2uz8WCnWA1utUsetMzMrt3xYh6lhLnaTEs=;
 b=BvDz1FhYGkvmiZYTPilXtszkX8oCHgzfCcXaVT2iGEwhvnkC7fPy1ysLXkz14cMpjnTy
 RjnTdfOgdtuvQewO16xXR5LHCKsWYCDAR+1svXtsd3aSPaMqt4DKLgEe2tX/5ZjP0x4h
 K1qVtmksQ5ceQ1+IUOAoraGW3MMr/aL/1yXm+fSq722rkPHSwKOjnx26Jx13EYkBWSyP
 O3ZzxdPEaXAUvobcS0SCjHRe54sxolzl6xNqWGPnAqQRok0csdybxbX3LOJ4VK7+iQky
 2aT8nFl95XSGlOqkNKAjohOFZbPqi4sgyXTIW5WKM8syV4B9K/FZN8rppnoPSmANp5Tb IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbqkc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:25:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HC1OXD014453;
	Wed, 17 Apr 2024 12:24:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggf09r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBlcp99wWvVNI8NbkMY8Tu6VRuDOLpOjsLit9DwJX15uRvytAWQNRqEUKMUo6of0FWMFtJap6XYlR2klUSYn+O0+LJKhZ6Gm/R+pKf6pfRctFxTkRR1FVeEFy8HJ16bJEv3qLghwzkgSG5i8eN2lyWm5f5Bk+THjeBQbkYFTHLBHPtwKA0cg1iKQ1fdXsEZZgEtINETNpWgZ6Cghh7/DBjVFdnBp9467BxOHoy/JoTXLnyMVvqED3g99LEQ+3ZFI0EFbEQeCaQkP9AzIu6w15NwyO3si1AgwEMgsPjvEJrdBiGOkpPyuDIA3MwMDdRsXy4VlWfw1IWqYfOOb5RBm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snbHceJIm2uz8WCnWA1utUsetMzMrt3xYh6lhLnaTEs=;
 b=Jvc1Djli4TkthUZclrjZAtOT+FRkQeNBsoczm/ezybK/0ZFBdsnigYlEs+f4FR9J00232v8BXa5JJxXRiHa7QvywtpzOrPSHMvxhMJrFYT4wcEFbkYKvw/380nHBWPROY3vqjKbg2aBoFryfpAGbzZipiBLNrhy/+VWAPSU+Sd9IIqrJJG1Nh97BFamVoi1iKdWA5OlOhJAaG8mDu1m+0ABdv7mFBBAeMY220UAslXVURSaBJqYMdWC2tLbDXw7q+y1hqOZ4L4MTTv/yeRxPJMJdbxRdeQwLpC7qrSAoznF4W069mDChwVgq3YcfMMCOG/WFl/3GGQiucO1IJSoQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snbHceJIm2uz8WCnWA1utUsetMzMrt3xYh6lhLnaTEs=;
 b=ROcDDov52NJm8/ZFACUpqCsKtoIuTpYR+uog8bo9wt0WlqMWtgHL4ZWfhrb0IGawcmJgL8ueyqbBRGKQhTnw4LHXvJJ8A/l9io2+180rA3zDYRFmMF6WhnwtHNkg978m/Wsljn0f0do+REt1ozU9gvsBA9xUF0Rji/DBTdvghP8=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:24:49 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:49 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: XOR and OR range computation tests.
Date: Wed, 17 Apr 2024 13:23:39 +0100
Message-Id: <20240417122341.331524-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417122341.331524-1-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::28) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba79a86-7cd6-403a-fb93-08dc5ed96047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HGaLyxWAUzpTv56xQk+nG/i0bsGYDKKdOeZfh+73ydzv1ka4f4Eoo2fDNyyVNDXoqGgs9bvYSaidx8E5v1AYV4KSfSvu1sCA3t4jC27IBsPX27+9F7X6v3nw06g3KKNJQUTl0SLOKKo0+JUoj+snHyXS+QRfBxvTK+UgbYNSq9O67iDOAjesTQc9aUPUS9K1hNcuckPbw2zPtpzF2WxDqRW6FbTz8BMCALsPUBnZ/UMYCgHUBtZcfeWGLHiJ4nd8JUkZdTo0IKEaA2bVeYHOKAV058OYNwUuSJgpG1IbUQU7ExJKmbZRpvi8wFivfeseMc18FotEasm5267gt4nIuiaTjwM9/LZ+E4EXRRhP6z9MTu7RZcPDVm85uoCvYzDI5suKb5onS8EJ/JWz388iSaAenb20LuGG+dPNmSmJx48TiNLmBRupsSkErHXSz4GSIHgdAA+x7OXziOu+OGfKQEeNIDSgW+pPye2jw9h6cXWiSBA+q0wmG1cVB5WyF2D3EojwyeNoUE5/GYjFoCJKv+1ebKOy87KlKEpGXLvBC2d0aTQ6fHmj20nn54wDVbjDXKu8/efrUPSOnTO8SPoF/V5bFt5UhAERnolooT/2i8mK4RQzPkoKnmPW466i4DIbBdiXpJSrPCdDY3B2oTK2ERrvQW6fRWik2ir1RdFP7rI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?puO4ZE92hwxb/xCBEEkqXxPQamkp++mM7XYu7G8ClcZ2ugfGnFC5XwTZObuP?=
 =?us-ascii?Q?c7KQ3VtM9385vrc/SevT0BEw7hdotWmIqj4IhAJBjB3p2PUUlybcu0qxkIAU?=
 =?us-ascii?Q?4DWu5c6v7ZWfYAmPEqWy5SJ/ibzJf7GjvgD6TGgCHJgjo1ajQ19voFIV+XBb?=
 =?us-ascii?Q?6szlEZJTHwZR1s/Uo7zYlBNlL0OgeRwy4wOmH7JInMeoIty5LJzTOzRBfMyq?=
 =?us-ascii?Q?/SUYs9QBj5TE87ioz2oROmrzEzxCTlrngWemmWqfbhVQh5OzDymrVpH4fJ3s?=
 =?us-ascii?Q?TsdaA1r4iS44q1GC4I/etKgSbuAwXtuRPMHtJex/i+7w3LhtyeLLuWsoGNPI?=
 =?us-ascii?Q?pcAZmMn9PnOHRyItPAm7uXjHocVQX6T2Z7Ce488tHnvutloWcxOo1GUnUNme?=
 =?us-ascii?Q?/g6GU755UeJjEHqtV11SdTn3WQEjjhFWhgA6arF1iRqngrwZgjB3l7+KyBXK?=
 =?us-ascii?Q?BPkFDW3TsrQBaWo8t2KKi5Hc3ywCIrWF7sHUB04sQvc7kccOSFlfc0XVzXBy?=
 =?us-ascii?Q?fLMxAWO01Nukbd6xnraGCsZnVAaZgUp3ueLSlKKWpfpry3z/QiTd8LhM4Vbx?=
 =?us-ascii?Q?dS+LOILFa8pNXSCQ9bCV/fc84MeuwFUnrLAWAG+RjValDHcTdc7eqvSTiVVj?=
 =?us-ascii?Q?KJ43wYPTHiRGk3TBpuKyTrd9e2JmKs7LBxld24VlbWpASer2bhxkQOc3joQ6?=
 =?us-ascii?Q?wKinYRYv4qliMmbiOdkrlYKuvOq49jXroCN2JluSRcnDGKYnpzqT07ZLuG2k?=
 =?us-ascii?Q?FEaFsjrLwbsWdmRRARv0WPQmqvSwULjziotVFp5oXaq4JPllCPh2gVYnehdR?=
 =?us-ascii?Q?6QSZHDgN6+R5FDz8v/+alYp35BQwjbJyaqstlq3ifnbRGDM2jdzhnAtyHZkG?=
 =?us-ascii?Q?o6nCNgwY5pyHG1cOkbaIMB4yb3tBTQ3YjFOlWPdAQRLiHlV+nt3WIhAQZgRe?=
 =?us-ascii?Q?WKj8Iil8TWY+z/w0/pSXhcyTQbvw3J+i1aTrd6NrvKZ6Nsf3op/w6u3QdEM6?=
 =?us-ascii?Q?1Np7AG+Dqa26agSDTwZPRGh5QNqqK92lThAuxVqKd4UOVjSDOqvBXC/7onwL?=
 =?us-ascii?Q?D8eNyKryBh1uS2h5/Jum8nAfS7QyyLN3Blc4LfkxLVrSiC7SCmEIW1QT7kJN?=
 =?us-ascii?Q?SpLCQd7cfQXIoLfYOIavex4bdebvYrfY4U12WYpjNpC8IYCjBwRL9MwNGLEk?=
 =?us-ascii?Q?TmuQQ8L1TIfnQ6RiygHdu0a/AR0LWwwtB4jtlnqyGzA+1DKVEdc2l7dnYpFd?=
 =?us-ascii?Q?R2HPgEXqHnAEVCLjdwrJK8576V65Pwiddv4vLvMlC4xso53oASw0wK/9O+s8?=
 =?us-ascii?Q?pi+a6FXiHwcw147ezmUVHBnjdjkZZBhi79l9ZYD/3poLm1swWQM4nNszk9CK?=
 =?us-ascii?Q?xdl61wc8NjferFRArkmMVyGfCxk8kjY6xA2HDH4ate9/YwWPemgd9UA2bbcR?=
 =?us-ascii?Q?D4bPUURtYuFYb9ruAf6XxG2NA7Xlfj3Mi9VxkgERkd6J2ZXHEofJhO/+YoxH?=
 =?us-ascii?Q?iF3qEnG5sfutTBMr8B58U+Vwta/hGvSvNHOpv66KrgXgd/y90VxLwQzNIm9Z?=
 =?us-ascii?Q?I3+PnZRl6fInNYpvZJ0hmJMugXt6k7fFyeVksEITBDGvta9GeNfIJ+Y1CEFy?=
 =?us-ascii?Q?W35kALS5089urvAmtR0Xkdw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QaOkpedBs31Jz9WOxb4AY5OQkzbsmyfRI4HUrZeZozq+BI5E3gTSKih/5nFZ/47d9gsS9GENvl4uSB4HaG+3W/PL38DPOWznjVJ4PoOOQVASZxatMG044+X1PygwAz+NV767gq8NhvI01zNSh0r9qyuqdM0FgWjSOF8UfFtxJBSiBfgIN7g4/JRSGISWcXVer6zQlZv5PwnHWdqHrtTim9Jy11xZM0XuNjqLHtHO+PuDLcnjObEfT/26bMa9ayrvFuX+/AsRIEqoYNmyMX9XMT0T0LTKit+vZKL5nKrh9o5uVpLktF3dIBHHhiEzIoN+GoAjF3KxSh3hJi3yPPff8BT4T2uQWKdsgxhBdutGeaN3k8AjjACN2B6XMr0sJhMP1J0YsMPhDrRaDClfWKHVC06QH974IVyqO83xoEIv9Dgd9iAG/aGl09rr9SM9/Cv7qbzn1Y3G6DCJHRXu3RD8U8vCU935193Cpa95i5uvX4aCLUL+k7srs24diXR01Xzdldqj6gDpp2Iz5djyzvfntpANtjTCfLO9khbnsc29heFBExH5gcDkvmk4524717PPmJOjSU+fkZukvOVlvkiWt6tXbcltN8Facy1LyLdUrNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba79a86-7cd6-403a-fb93-08dc5ed96047
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:49.7577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZkWrqwcfoUiQp31B8ApM+xfzYHYPHu43GYEvSdHaGC6wQWTttJRvCB26PUqrMEhlB35dGYBaax+gNgaST5ensam4p+NpOuef2GoijSA2Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170085
X-Proofpoint-ORIG-GUID: ZD_5BS9Dut8NfF8iaQ03kel7r2IiNKDK
X-Proofpoint-GUID: ZD_5BS9Dut8NfF8iaQ03kel7r2IiNKDK

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index ec430b71730b..e3c867d48664 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -885,6 +885,70 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for reg32 <= 1, 0 xor (0,1)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void t_0_xor_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	r6 >>= 63;					\
+	w1 ^= w6;					\
+	if w1 <= 1 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 <= 1, 0 or (0,1)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void t_0_or_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	r6 >>= 63;					\
+	w1 |= w6;					\
+	if w1 <= 1 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


