Return-Path: <bpf+bounces-44430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06869C2E5A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEDA2823A8
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF719AD73;
	Sat,  9 Nov 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vrg5LIKQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="URSCSNUG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18B1547C5
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168142; cv=fail; b=a+ychpVVMT8jSHM2BDeNeYGt/mwu6+FrjWP974BclifwENuuVNTuppaAeoZf6gSxwuuvXvsIZM1kuWVwzeQL9KfGiOnty4vfG3NyqwwpSLIVpP34NKO5xvsMiIYAuCzfnCjvpMBnY68zNV2ecaxZdYs6teNZHZL0rBUYy4KioiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168142; c=relaxed/simple;
	bh=GVJUvjJZEPKSiDtz611puqqD7EaCg4HR6+4mnAhhoQw=;
	h=From:To:Cc:Subject:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=DUUiijuSffz/dNgqtGad/i3myRSIJYMePjuLG1zPrqIYeSjdXu/dpMvHiV9Z7W+pbAdMxVCs2ukGXm2pEfyvv7BbS2ALmEHNUbsn6TlMjBbE0magXyPV7BwvIAugM+RiYtehujmbdUV0y6KP1xo0iQjfZn/HdJCatWsKtJZIWj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vrg5LIKQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=URSCSNUG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A98sm5e019386;
	Sat, 9 Nov 2024 16:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=23kamJPQMJ9gUliZ+v
	TpTC2Zmnd+tKeddwwhnDE/RVM=; b=Vrg5LIKQ7z97H4CYX2E76nOUGCYoepcJHZ
	OZ+nEI7Sd+OqdIqIo7YPvjCNqw+GJYk3laQPT49tERILYc6IwyzlDP+WkuNeCl1T
	jB0sF5r/ILgsxuBPJfMEtJeSqMIs1vhkVnDnok1cTFh71OpPuTRC9bbQOkWvql4q
	GJCF1cjBm6kqJjjhzyCOa9+dDyrexe5QO5VBeqOfsnLLlVIJleE50la7je6/2Gzk
	tx6lMbpsn9903U4Gp8yxBd1SJLZxNN3Qn860cZQwWFu1QM1CAu6KIttJ+TBmZL2T
	ialrgo6eP7i98z6Pi0lBoIC1yJynpo0f0euWtQ8P5l6aMjNdom/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hegc2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:02:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9BbWVD025412;
	Sat, 9 Nov 2024 16:02:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx65dw0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 16:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCILw5NqYObNuDXc492+KyqVyKwlB4ZtYSlnAklF5SbyyB2D6Z85VCGJdFSjAW8AxCNLcFxwvG/Rsz+zbxc5f8C3F2vjYJ0BSV+6h83jGgBcKvLYQKk4KHQgEHSBbL2tB9OjSCPZJvmGdsXJdJ2B+8nEgRNkbADJ5iHuSjyxFMER+Wch/97Z0sGshPx/VLsvt0qsA56LXHQYcVmt1UGBI+YewgeYTe7PZIztHZLieiM3nI1ex55zn4ld8AGMzQUUZ+FsOx9PcRe2EGCSfceCi4uisQfW59wcH+/H0u2O87MPW4x/C5eTHOlJyXBzhflzxZ8gKDY8M1WfXN/5rqhsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23kamJPQMJ9gUliZ+vTpTC2Zmnd+tKeddwwhnDE/RVM=;
 b=zAA9sriVYhre26o+y7Ue9nLFvxmbpIVsAI21LKlo747Lou7OpiLlN9PpNlQ7rV5+A9PRONq5mEJD1DIWWMclAkhrhCPWBreXsJNUb8+gQNl2TVk4CrSLyWEYn9275Qdiy0UIfDy70jElf4Vqb1mbME276zVhH+UGm1UGp28qKYqo0tz6cf8V7PvpU/bB5d9nu+8shwXFJbxg07zzEV1dQA3mGzKc/8fTQLfKMX3TMNxAXIfQsbXWF+cyXzW7uyMAIcljfNQlJOklzPcwEknD0u2SpEHRiC9MJ/OvxcCYumsxHELG84KErEjR/QSZlxLwBn4FRDnWMMTOcfvCfJPp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23kamJPQMJ9gUliZ+vTpTC2Zmnd+tKeddwwhnDE/RVM=;
 b=URSCSNUGm7N0sRbOcRQTrJ4v/Ie/R29r3uvVEJ6VSmT1ic7U+R1wfoW3WSGrheUFKt9MnQ6/mBM1IOjyIGeSw1gzNAIlaP6D+BiCrLVnLEvzsDLb02KLTCldYAh9zUv7a6vE//T4+472TPxz1LnGiooYLXJRcTv9R3FuoSyBoJw=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sat, 9 Nov
 2024 16:02:14 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8137.022; Sat, 9 Nov 2024
 16:02:13 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Holger =?utf-8?Q?Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: bpf@vger.kernel.org, indu.bhagat@oracle.com
Subject: Re: Using gcc-bpf for bpftool: problems with CO-RE feature detection
In-Reply-To: <8665818f-8a32-3796-1efc-1a9e5d036f18@applied-asynchrony.com>
	("Holger =?utf-8?Q?Hoffst=C3=A4tte=22's?= message of "Sat, 9 Nov 2024
 12:55:36 +0100")
Message-ID: <87zfm8bdx2.fsf@oracle.com>
References: <8665818f-8a32-3796-1efc-1a9e5d036f18@applied-asynchrony.com>
Date: Sat, 09 Nov 2024 17:02:11 +0100
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a56ccf9-437c-4e76-eae3-08dd00d7e02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmGpfvXgMGfiU6ZeWfpDszjlyX8nmAaNuBChYn3SARq2HmQB/U5O96wfEU6D?=
 =?us-ascii?Q?C/ObK59TdGBMGweozBF+iAyPkDrekE1vQ8xuG+Y7DC6QAfnv9yHr+Pa4xglz?=
 =?us-ascii?Q?nBzBRaf9Qs6IQUHEXgsG739j9JvpjnaHOOv0I4EAbtsal+0PiEeU3l2CrWYN?=
 =?us-ascii?Q?lwgYf+0+tOWMRBIQTs0Tzod9WvrRzgbUsAgJRP8WQk5j7KtbUHW+mNbzrbtB?=
 =?us-ascii?Q?CdA6K4O49CHtdKb2zoHYByaDJKEBjt8YjfvWJFnLC8NPc7LvicCfc/G8r81X?=
 =?us-ascii?Q?u/FFCbFU6ixZgdFJzZbcZlpysMPSSWEuFjI0708YI/SFY8WZTQRA1uksrWXf?=
 =?us-ascii?Q?QdUdJ18kxv5os2R0Psw4Zw/jpluXj7qeShuDOALU+5ZJlRnXJ1i0xyTGUtcw?=
 =?us-ascii?Q?i+8jtDfwzeMt+RIz1xTsC0dBNKzUdTFfvwTE/hQ31YD2PTNJ20CL//9wpINu?=
 =?us-ascii?Q?WnipswjM7noihBEnGm8xThrwePCiCDDK521DkrLoMc3Th87IDWLi/cBhzGIO?=
 =?us-ascii?Q?ITnnEvdJ9ZcgWNdw95BYGpAKnBGn3ZNpye7VB1Qy0LrwvVavBeyxXvmP5Mjn?=
 =?us-ascii?Q?bRNzLxaMPjgvCEkRzt+qKuGMehkwxAR5PfRyqzn+6f8A5VF0gsILIHxdqmSF?=
 =?us-ascii?Q?eJ/oGdPY0TVvr9rT9hOzezYfa29mTNx1v8nqSCOfCzZuuAQue3D6KinHyxHU?=
 =?us-ascii?Q?9UzkFrq++jrg6dEln4ZarSdpkxRXGoByBIRs3wk8XjB80TlBjZNx/apmxFR7?=
 =?us-ascii?Q?DyYLVc5NIli5fzEoMqU66BaZIboadpoDVOnhpQGq2pR6R1/BjGBKXdre3i4L?=
 =?us-ascii?Q?HopYt/5n0EP+8d26JuQPH2QOyds4AynSFRMZMQJuJrwhAK08SuGQgipI46AM?=
 =?us-ascii?Q?yMa7H1ycDIIuoboDBNS3amG0vKVMick9pWbb3XBN01W5Rh6xuSqKO1Ih+lgC?=
 =?us-ascii?Q?dMWLk5AQjVDGPDoagrzRRhWv3u0ovQ2c/Hpo7BIQSIpfFLQx/bLE//E9a04n?=
 =?us-ascii?Q?NOyv9F8i7JzlH/lefl9ul6fhJsTyz8DhmEHRMFE+jTCHvZBQenwYPkf0sj0L?=
 =?us-ascii?Q?OaGa4fY6EuI0/tFaLpeoeErKeuAhIiF0s5t7sZc8/8rO0f8mafMk2bX8aZlb?=
 =?us-ascii?Q?BwP8KRlug5tWUlleDF1ZBwcxzaQHUPRquQRStY78jxDVyv3xEb0XmS2JIjPR?=
 =?us-ascii?Q?Tr6a2LfJTb4pT9qEjjAdY9VC2HoA1Sb/PDEZGrLJWfLZDnNrQbprAbW3wlWb?=
 =?us-ascii?Q?oH8Ah+jlE1hW0TvS7/RN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLv750rzOltBgVxdOKbHZ3Ps5ycfHwvGlBvON2FThVLIpfJPiM65oW9lEvXJ?=
 =?us-ascii?Q?XOic3zr70//B+jWgOoGVz2eBVzLmnsI+Q37qqHa40dw/5PhY/NNHqEWTa9DW?=
 =?us-ascii?Q?TsjtBw5DRZ3jHuElW5PTvt0gfAbLWC746T2Je/EuzxGLsQ65Ei84k4LwBHK8?=
 =?us-ascii?Q?l5mO/BRewN4ZAFnCCRiYYVsSoTPAq08HRIR6CM1oCCyH4u8A23woTcJ+JR/b?=
 =?us-ascii?Q?Ej2JFOIGVQbegdOm3lJcQ/LAjqOQuYfFbtGrX+auvwwaVZ+BeppukHj9xtdY?=
 =?us-ascii?Q?mjdTGHRslWz2UQ7gsJg1jE5zthwX8z65FYZ2coGheaOfjdzD6+JwUwsfGf1T?=
 =?us-ascii?Q?iQdCrnsZlXqQ/KaT3qjdeNjsdY7EK1l9XtPXlaR2T3m1noC9onBUwWZYJPQ+?=
 =?us-ascii?Q?WUIdUqKjngcgpliTtbyhRafjjNegF+Qiu9C3oq/A2Pc2er1bZbIHbRQNui+M?=
 =?us-ascii?Q?Gf6FjOpH1tE03u0nG25gioK/BUS7IgaEqzuUT8AtXqSgjjPArfMZDME5mczQ?=
 =?us-ascii?Q?OW22rX8QqH5pyjW/NK07Z1cjA0wqUkAOUHkRys9dzQWNiXMxkucef/NY9o+k?=
 =?us-ascii?Q?akhy3GWQw0dGqzda/yzpgs1omtyPy62G0oaaA2UuXKzArgAGQKJnzMgaPMuQ?=
 =?us-ascii?Q?+3bqygOQItJ6XmUWxXustHGPZhiinHpKTpAaFID0dsnpuIAAE5M1bHHsiL7u?=
 =?us-ascii?Q?D72elRO9PQ3ITdnmgp78EvPKYC3hOtah1wCX1U6dTtmM6ekyZaF8xtwPt+CU?=
 =?us-ascii?Q?ZIbpuTiL074ecXzJMAKwJt2drOk7faTlpzD86iLWo+073UQw1WnLBrrLGt1E?=
 =?us-ascii?Q?zBdmtIYb58SLuzOXw9jwmIsjs5mpB0uH7v6tBPmp8yV0iFLOWMTkesDorOfo?=
 =?us-ascii?Q?7n4bHI0Fm7w0mSRT3aFN/+OqgrKDk0pjmCZr41UxuD3BMhnGrTGtz70lgOpD?=
 =?us-ascii?Q?nMLkDa8lsB27+2EBWWJaxUfU0Xs5/wQpiUPvhBdoRVcP/JrP7X+PkhHtWB5o?=
 =?us-ascii?Q?sN9jM9ZxvRBQgygPhqZg1GpLfEAWusMbHV5bnEPD6zFjQR0oJtXcezLy+pUn?=
 =?us-ascii?Q?OJwyOnmrwTxxBenI6+0jBLvaE1a/Dj4lPU5cVDOZn9MeHu//7g5BXFspRPDS?=
 =?us-ascii?Q?eac7MKRbanF4FxvPIV/dCEQVl5mTflpHqJfMZp0w4FPjDceVrPyKeMgn5pTC?=
 =?us-ascii?Q?1QplXxpNYeqOcafvHqyS27wKj7eH+NndKOKpUc2x94jLAqqeHQV9m99d4cJE?=
 =?us-ascii?Q?oT485E4fKbArXsBJ/4X8+1ryYSTYkR46kLoWUImyE75x4Z/E7N0/YqIBPqT8?=
 =?us-ascii?Q?zYhk0K27cq3uFeTXEIjdEw5WfKQwnN92zXTgbhRt3PHq7fBTchtOp21Whgnu?=
 =?us-ascii?Q?g4gShhTpFD/KlEnK18Ar6OxyaRNg/guop0PgXf0+2eyAkYsOI/pUbmustvL3?=
 =?us-ascii?Q?w4VJXfkEU7Cw7HwHC1hC6Icf7IfR/TPRDHh12tVV3i6XgMNzFejUMI39v0uX?=
 =?us-ascii?Q?ZUw/GLDHBmTKJxg6DGv48AdGgQDd0kJFDz7aIAzWPpTLM7kaohxhzvnhgv89?=
 =?us-ascii?Q?OoU5NftAsJj/h+/o1KcrleKIzMqNJ5ntI3vTXTBr3vbT53ijcyEwgcw4jyb7?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BcmhZFlrmuR2DtDnQfcjKedbl+QIvHCsagzEcf9cAlAiVWK83Q2h2wctjaXJhRfmiXjc9iwueda7+MuXmULDRPS1VYVTCZxLNTmuuuCFwwAq4FlcUycyc4FFBnTc+OOKCarlky0TiEv/J7EDU6lT768BNACOuJT5/YueZJ1Zv/A/x3pbhYhV6pwRLSVY+we8v3QSzBxZ1sfm/6UGQ3Gqgz1AM9Pvzsd+IlsZPs3eX8J04ID5+2CUdy9YLNoSz60n8ghWNQWRbZC9E+WTmsIGIm4LaEilQLT7PwXrP7sf5TP1ln4DqNm9RfogjkPiNAuNI5TGyPg8m8vXEbVV6+aBxLYbDZx/uReKmQRkK1L/zktLImhvmMFtetj1Gqfg7/bmlhpdHjnxw5gHu1EuhzCje5wvWfD3xaw/61D3zkJ5PjMj0+mu15QWnrDv9ChK450SrJktqTAQaKFBtDO8qKWb8hOdJ0B3b0lK/yZre2ncOWGHhYn6rM9jLb7F71SYB2gnbCk1xmeR2ndI4iajQUxMxuDFslDydQMWw6G7QAiyW+532fzPqoCR/I8jwDe96KoJpufnGK+fbf0jUdtS2A5PeCuJbvKXdWCC8IaUV3Of8V8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a56ccf9-437c-4e76-eae3-08dd00d7e02b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 16:02:13.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFvT/Vzjc5s+e49qb431tV71iOH5CfXTPR/kNX+1SELP2zFPSEBKNohtIIoIehaKjxT5UENuR42/34GmxII1s/7GHgkVTK6zt9zvTjlEYGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_15,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411090137
X-Proofpoint-ORIG-GUID: g-_rChViuXGCk-M84wi9JyO2OsEog-DH
X-Proofpoint-GUID: g-_rChViuXGCk-M84wi9JyO2OsEog-DH


Hello.

> I'm trying to use Gentoo's bpf-toolchain - basically just gcc built for
> the BPF target - to build the CO-RE support in bpftool, in order to
> provide an alternative to clang.
>
> This currently fails because the feature detection relies on a comment
> in the generated BPF assembly, which gcc does not seem to generate.
>
> While I'm using the Github mirror for bpftool, the same check is
> being done in the kernel build, so it affects both.
>
> Our tracker bug with full output etc. is: https://bugs.gentoo.org/943113
>
> Basically the problem boils down to:
>
> 	.long	16777248                        # 0x1000020
> 	.long	9                               # BTF_KIND_VAR(id = 3)
> 	.long	234881024                       # 0xe000000
>
> generated by clang (19.1.3)
>
> vs.
>
> 	.4byte	0x1000020
> 	.4byte	0x9
> 	.4byte	0xe000000
>
> generated by gcc (14.2.0).
>
> As the values themselves are correct, the problem is really just
> the missing debug information in gcc's output. So far I've tried
> every option I could find, but to no avail. I have no idea whether
> this is because I'm holding it wrong, gcc cannot do it for the bpf
> target (yet?) or anything else.
>
> Does anybody know how I can convince gcc to generate symbol comments?
> Alternatively can we find a better way to verify the generated output
> instead of grepping for a comment?

GCC can generate similar comments if you pass the -dA option.  These are
intended for testing the generated BTF in the GCC testsuite, however,
and right now I don't remember whether the comments mimic what clang
generates.  You can give it a try...

>
> This is not really a bug, but IMHO having an alternative toolchain to
> build BPF seems like a good idea in general. Gentoo's bpf-toolchain
> package was initially made to build dtrace, and seems to be working
> fine so far.
>
> Thanks for any suggestions!
>
> cheers
> Holger

