Return-Path: <bpf+bounces-28686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7418BD173
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F1A286336
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52189155356;
	Mon,  6 May 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OxSKW8Z6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f2mIiHqm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42015531A
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008737; cv=fail; b=eWg3dOlDeNuLEz0iypKn1WFzzhqQx27SJ69ytOs4mhQgZJSGPe+gbKbwYk9wDgvz7HKthI1Xl4vR/yxlxJguC0IXhUnCpS13R/TMPtkHikaGgS6b76T4aW9t1x2b36ctIpjzKgP4t2/33hRKqFuJHJ51APzHcqHI+EcG18/a0GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008737; c=relaxed/simple;
	bh=XfLMTSFaEZHpScrTIjKLopuqKnNBjYC2ba4WBxzAPtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iUQqpLXiwZmCqWIwYWusbT+iwI+k060Qq1OG3UglYtoZy8c3I4hdeh7pSu87IrKtYWpt6lsa+31YNZeMw3jwLm40QFAbw+ssYS01Pfs2LlDL2vkL9v9nNno3TTOw+XZlrJqaq4eujP7Ni0Ie2Qf0UMjvn7fCNNuhEMhNZ25UvNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OxSKW8Z6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f2mIiHqm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446An4ct027858;
	Mon, 6 May 2024 15:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=hKw8TUZgiF/0XcRjt0vzw+7ZblVxrOR0/n9Lxo8Wg+8=;
 b=OxSKW8Z6zf0fAfqTwWKY8ROEQydHhhpmZxLc8fHYjoTzpsOoPQs0QxKDttXK8GbgZ/OL
 YziSLHIepSINk1IPWngeDShroDuAR2D71yRLP8BTC1SVUvjptTMQ1X0kzzIjb0CdR6At
 1jpM7sD2gBsV2+lW+QclBfVdeThNLPp+N+2wgrCxskQ4MkQVUtiwpepDew4LKnzEuqNW
 EgvnQrs7CO5Jig8Xw8SVZ7ZgwAesA58oVOviKKPrz3cEGPkhecE/UwEc0DDCTQs20EcZ
 CnIu8fPMol7fOR26Ht3gjUU/iE50UhaP6O1LbWPhTywbYd2ElpnfeMyLDBdeZMF6EyFh 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2dtu9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:18:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446ERLW3029320;
	Mon, 6 May 2024 15:18:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfc0dg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 15:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXv+aR6LGtrHh4TKqc15vAzT06Pij4mf4349PMmQV/aGOVmPd+IJ52zTNWEUFOylEEf9EZC8sh/yjXx8s1DBc9uFg+YqOgBXXam1thenUcMJ3R5iVcxNjKrXc34wZ4y1D+l6OX+EdGWdLed4hPyo8WQnUzXsMwoYJ1ucFl4Ev6tv2bkQaw7IVJko3I8LdJ/RqH1ibzNhAWmvhO7Sl8sGMDqfVHjzO9vuYpYOuFFoX4bfTDK+EIarfeZytcdNVBJGP6lT7k3EDLr4QwZHSMi3nCGFUPO7/nniZ83MVMHNWTxH/ccQX216hJ8hRZSX8kqVvkkDRhBHDpZoFTJe7qCtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKw8TUZgiF/0XcRjt0vzw+7ZblVxrOR0/n9Lxo8Wg+8=;
 b=ceJ/5rsM8DePV6d/tJQA9Tnmmyes5Bu/uBkdqEiCk6YqmAlbaRJsAVayb47uSKvgr9XK9YaRZqgs1BG8aJpGlTr8jpz8GkW2K2VgHuago0RNksbbomUAgNpXzX1CXOdfSl6GyhMxDCQsDfCLM6tGUX/IJG30mlPndKdF6ST8i/BsAu1IAmziCksHnLEXfbXZLwZ+Jlm6jPdNnS1z5dBRDAmWrBnhWcr6CNGqgXuw7uLbNoyWOf69rAdnLgDDgk04RRcWj90NMj4L+ZdEpPOihEqnyVFdExupuGBdVsg5oEYZ/47LSwDDHfxe8wlcJXA0WFST0l00XNMRpdAI/hs7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKw8TUZgiF/0XcRjt0vzw+7ZblVxrOR0/n9Lxo8Wg+8=;
 b=f2mIiHqmaZcMox62uF9yEyLyx9pAQs8ZIvporHSV5AuS9W5Q697ix0pUpy/1n6HZMqqZ+sSR0mU3op0poaIyk1HCUfrvHgcJrADenSDwikoPZlmrjGYZolaSL/NwEgtpWNcuAglVXBnFDFufMjIQSYsHiQuSwVUzJfu4ynK/xGQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH8PR10MB6410.namprd10.prod.outlook.com (2603:10b6:510:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 15:18:51 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 15:18:51 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Add CFLAGS per source file and runner
Date: Mon,  6 May 2024 16:18:28 +0100
Message-Id: <20240506151829.186607-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506151829.186607-1-cupertino.miranda@oracle.com>
References: <20240506151829.186607-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH8PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f751247-2948-4940-5437-08dc6ddfd598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yL7vgjrytt3r8sLI1ZwoOthtOus0vkguy6ZiwnqwcQXFLi0FoTf6ANfAJZqx?=
 =?us-ascii?Q?/w2zj36cjuz8r8Kk8UmWZjz3eqcN0FvqbE4SkNCoq3csRQ5HRLjsNqa3uJza?=
 =?us-ascii?Q?EuZgpNfcNvRuupQDKwn2iCiA1HtAneiBJ/KHbP/7nXpQKerPYfOfVDTCakIF?=
 =?us-ascii?Q?LRh0dj+jH9zXjIB5FnHUrRuRgKemvmKHqplZYNA0y3aUIgZy+4EmAnCQSn2D?=
 =?us-ascii?Q?ZinbUliia1Aa6jx5VFkzuhg2WoiOcARsasVsSuzrtbWE55Xm+Zpnd/TCQR36?=
 =?us-ascii?Q?jD3uUCBGHJqnJ35ouGHkY3aWIRsfGVIMvxXuxYHLoMEjHYmr1q/Se7RKErhL?=
 =?us-ascii?Q?RGzKufwkXBaK8VsBvxh6ftsYibr8hDGzvMKwCImJwtksXUqgzJstCSQnbiXi?=
 =?us-ascii?Q?xmG7TEsLsZK8spG+DYQjQqZOneDphJxzPMTPlUjt++YSS8QdfEgHQuh45rCy?=
 =?us-ascii?Q?EkihoozS4SFSDq+evF3O37vAtTQp6acxRcdR6wGcSCSL04myhxE6HkYMgPN6?=
 =?us-ascii?Q?+TDGLvHufU2ka1S7yJwRUYm2rZS6nQbNdd4d89FoEoHAAdwCLcjwLjftVBm8?=
 =?us-ascii?Q?jqUXevULc8m5OuassiKT5HeQ0Eu5g9Y7VmnxdDDaZ8ssD3knHarBh3zdbA32?=
 =?us-ascii?Q?YD5PmvGNlzIvG3FtwECisLgoY3GP/03oDgkNNFoAa4agHjtwKGCezqnsg2tK?=
 =?us-ascii?Q?F7TGd1GloNjRwdp5Lgpc2jMvPQZ1PrOQEYjgJDYhzfcrZppWDiLSymUY5Jbc?=
 =?us-ascii?Q?pTgkhLyYSomjoZfUHJmTk+7DbM5mMvBuc3C7btEmVTgk1ipq+Cwo4BcR4eLD?=
 =?us-ascii?Q?P5WolpGWaK+g7r3buFP7+3fxt8R9HE9ehtyVJy/9Fi2VnSQ+qhJfZpWxyEZc?=
 =?us-ascii?Q?NbH0CbmVU1GD9PuSl9F3hcCcPTaOdtQzDAyVyFAQtkUUQuXEWAkQkuTNNLMc?=
 =?us-ascii?Q?V+I8MLjKBBK79SWA19xUnZkXZUSy5QcmktJwAmme+FeZllsHS76HxJkE625X?=
 =?us-ascii?Q?0rI5GK3tbCEFPdxerD/BsbWXbXKmX1nDEAQnmktof0LhEK7x5YVcH7SUFX3f?=
 =?us-ascii?Q?kVAcXONxJa8NcT26dLgIX0gs9PJpCuSF31kX/BZzavYTDPAivZ8nXVVAco86?=
 =?us-ascii?Q?sgLcbL2x770SXBNiRjPOt72T9IV2C+Wr/quVtCqGdQ6an/kyVPrZZgbEVVzL?=
 =?us-ascii?Q?+Lrc1IPO0A4KehCS3CBkgj4S4A11DvhbZOJZuGG1CmTDSa+YNBvCoGT4snJ6?=
 =?us-ascii?Q?a3q9UEcbGOhOwa4bNIhUlPYFv0moGA6y7EE3tMhDMw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1YmtUXtnAHV1ACA7eivZ3ghpCn2mPWAztpZ1peWQZdZXN22vQW37ECuhnMJQ?=
 =?us-ascii?Q?ydcXRl6O/18smryHU/GV8KIXlZio4KZV2ne1Le0GaNGLFAo1F4Ys6F3BdFvM?=
 =?us-ascii?Q?d6Y5wlFVUMmmI09ykuz/2jCz4pP2UFQAIBIr0l+IWlDjS9zmjbltX0Ay3utN?=
 =?us-ascii?Q?849/N6u2aWlCgKxcABh0L3Sm9biHbUMtgwdq/3iMlZlzAt6c8VDB4mGp/dDM?=
 =?us-ascii?Q?lTK13FBTrWVmk3R7/JU6Y26RdmKBoiyVPQnjFfcfwgGC2sBQ9YRrpJeIaBSV?=
 =?us-ascii?Q?aPolxuJh3FwKLakG7qm3GlpsbSf05exoxy9Db6+E1V9yQzxogHIgCu4Gy+V7?=
 =?us-ascii?Q?ecPNmVfDNWhtQkfjHQ8mhLmih/T/s3/WLYUfdEfppKIcauHCVRRsT0CV3XYi?=
 =?us-ascii?Q?L6RhVxdiIhFbvIu9229jmAEtnF5PXoW3qqEJh9PR4HcmWPrqTlrdUr1pejnp?=
 =?us-ascii?Q?MGztr+dVdDrpB/+1vU5akWJk/ktmUAjncw/5dEMpThiapQvk/NydzKOFHyhN?=
 =?us-ascii?Q?QbQUOd564QKJcD+TtnT3cOu6E/gYPxpfcBEQe2supltAcm0OntwGN9y/G+uY?=
 =?us-ascii?Q?7wChh6qd4nHIzHVcENVDbb5hAZPuyw8SzIlZrbDt7Zp6XWjeW2KhQ+FJeyNO?=
 =?us-ascii?Q?6wdg7q+yu+KYRvrvyP8OJ5MmhnqsYv/nRMAGCK8M5ZeaKJOu2HQIekhVYI53?=
 =?us-ascii?Q?QFkr8oaNdiwugFsMX5IsMJQEFOhjRNMfQ+KOm/HBWHLALeuKh+hokf6IaFmA?=
 =?us-ascii?Q?8wF16KiDy+1fcRjYdHqwmAtl7MYEW5RJFQcpIcs6RtvDMLAA7bW6/LeGHNjR?=
 =?us-ascii?Q?dVYRHvhkrSAZn8FIXtGVNV0p48DDkN4vQ0zAOZURgw0Vqm/DWjNXRHCg8FH4?=
 =?us-ascii?Q?BR+xtWv9ivQOuc6UmwKrJgaoKPziWPYdPCeafSre59UqvLI/dZCWjUwJMvis?=
 =?us-ascii?Q?p5rYvaoLaTvGHVxs1aMBbKdkozn3kd6IC+3aUVvfxJmszY5aSGO1ptYbjRX7?=
 =?us-ascii?Q?beLK1UO4aMiam1xgQt8FhSkcGwjw7zW94cKTT+Jp/sw0ybrDfZ7pxmdEbCFW?=
 =?us-ascii?Q?JtUbovUqT8JvDiSottdhGXUJenYw42RO1/zJu9dbWY6D6K1FTY50ehHBsR5k?=
 =?us-ascii?Q?KOeUXBTN82ny1HrIzfLZoyHApp3yAwTIg3a4+BOhxRirEim1jbvcaUNCdXdB?=
 =?us-ascii?Q?RfUsdkAfDpnFL4VvDL4N3CxDKXZDnqWDgEZqR9/hwKgfWeKNzM2L63f1Q8p3?=
 =?us-ascii?Q?BBHqOpnaXZpucxIe4MflHQPuZ5FIV8rN6H/LoEETUuunIfhcOQhLsoM8XXUf?=
 =?us-ascii?Q?g1/IxiihE9iGXozFraUdNldroUJWuRojSGnE37Aw0lm3ThUvp/LGFCSMhadb?=
 =?us-ascii?Q?EyMsp171aRd+U1TvIFlj+xZCE6/47ECi8K47hsLwZtSZdJL4/AWpRAu7oYrR?=
 =?us-ascii?Q?0I0u/uTIp5q0EOz0Ekr712oyX7EHlNVhl+xNCrmEF+ycQld0rv17Ae0B+DFv?=
 =?us-ascii?Q?CmBOJnMtfH5eZa0Y2wCWtlgXKcHnF7KFKauwMM5BZvwgBrdfgoTaY4L41A8O?=
 =?us-ascii?Q?3iH07PZuBO6wMdGQOJ2UnRoOclmTvzTXdwGdSFowPuohWRN1M71Sr9LJ86vv?=
 =?us-ascii?Q?n4/fDiJ0nnItKt2PNs63xA8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O5ylRbS+f5l3tFe21fUYClO0Dwxy5/g86Pd8wCatJGICxzqCfTggc+tDCG3vPfPfOv/iKTgZ+NXVKdx0QeOFgJqTMgVj4TjS/rgvXjbe3RunihCcs2+67bUw8NXpKYzsUMsPhfMh85/0EeD2cydzKnhI34taCaD8lSAkDLY+GM3khWDTt6CNgl+XrN2LQXjSBZ/U+fzi7QcLEcj+voKING0SsThCtzAR4K0Y6eRvlMnjyHIvI9cvs7YWIObt0WweOxvlbi/oG/kBGewpvzmmHN5RN3WL3eB67cognNJa6emsizL+a7Kndx8bEwrizlnm7M1Ux8C8k/ptoQ4afLcPeFGWpCrOalcqEGAOB9zDTc8t7jwefUqelgcbQ3U3Q7rvxq8vOragUWd0SaeAwA69wCk2gE2QRbvE664tdYYD4PI/o0/pbdXuM2g8YS21p6gqxSluURitRn65otNWYN9z8aSDEjApJCAOMKdOqLuW9uzmNysKjnNLzggbeXJVKJ9wFkUaYSdkKdQVH58KN3Y4T+XCMP6rERLMfwbRc7EBU9ZE2oCQ14Ba/vE7XbRznDfRMTCi2KPrcXwXNkD09+VJlqemdrjeRSgII/8PMjxTsV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f751247-2948-4940-5437-08dc6ddfd598
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 15:18:51.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjgzrH24O6RmWUZ3fvZ92UA2pxdnjXSHmjyX/3Ae3SLl5QXILdIHYrQJ+wTq7p0S9aKULTMY4lB5MsoFE+EmVROchmGF/lL8NEc+SfrZgq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_09,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060106
X-Proofpoint-GUID: t92QpJK2l_-48gBg9l_Njb2-SAs2ozRX
X-Proofpoint-ORIG-GUID: t92QpJK2l_-48gBg9l_Njb2-SAs2ozRX

This patch adds support to specify CFLAGS per source file and per test
runner.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ba28d42b74db..e506a5948cc2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -81,11 +81,11 @@ TEST_INST_SUBDIRS += bpf_gcc
 # The following tests contain C code that, although technically legal,
 # triggers GCC warnings that cannot be disabled: declaration of
 # anonymous struct types in function parameter lists.
-progs/btf_dump_test_case_bitfields.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
-progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_bitfields.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_namespacing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_packing.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_padding.c-bpf_gcc-CFLAGS := -Wno-error
+progs/btf_dump_test_case_syntax.c-bpf_gcc-CFLAGS := -Wno-error
 endif
 
 ifneq ($(CLANG_CPUV4),)
@@ -498,7 +498,7 @@ endef
 # Using TRUNNER_XXX variables, provided by callers of DEFINE_TEST_RUNNER and
 # set up by DEFINE_TEST_RUNNER itself, create test runner build rules with:
 # $1 - test runner base binary name (e.g., test_progs)
-# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, gcc-bpf, etc)
+# $2 - test runner extra "flavor" (e.g., no_alu32, cpuv4, bpf_gcc, etc)
 define DEFINE_TEST_RUNNER_RULES
 
 ifeq ($($(TRUNNER_OUTPUT)-dir),)
@@ -521,7 +521,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS)         \
-					  $$($$<-CFLAGS))
+					  $$($$<-CFLAGS)		\
+					  $$($$<-$2-CFLAGS))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-- 
2.39.2


