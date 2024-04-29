Return-Path: <bpf+bounces-28167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E429C8B647F
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ABA1C21474
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BB141999;
	Mon, 29 Apr 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwnWZdRR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VjTc57nh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3E181CE1
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425814; cv=fail; b=fAtXYJokfvM3awTUMEqyQm8AjjVs7h0PBQJN1oW/h2knuMI4jDA4qXJI50ZfpvNZhjDs12b8uD2Z4nfOZJM2aXxiMz6y0g+zOD/jnQE1JMBEDfIHrniKIO5zyiuknvou80P3r/fE4/jVHKJRTrrVzzc6cjwFxQ0F65XQuvVNqZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425814; c=relaxed/simple;
	bh=BxfJ/cSEyH7X2E/oOj6V8QyjZVS+7LGrG7rYX6OqUuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7G9ZIaZOO1xf96nkUwMCJgJhS8nLqWaYtVVaelyafO5Hu0mfgfOrpLmCmSRtGtxNmR6kfibUy9TgGQP9cRjpPhFsweCG+T9zkFr+n2/huDIkpm9HUzw4zga7IE147CcLz/yPSOnVekryrICIUIWv2OnQ9slk9TG8Pti52uoFB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwnWZdRR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VjTc57nh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFdYn013329;
	Mon, 29 Apr 2024 21:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=TLZBu/J9zzqT61og26lnaL5HnWeYvmlSTTwj17M5ZzI=;
 b=iwnWZdRR4sJWtUE9g+7p8DyASXcvJcepqZD33RrYJmOH26FyX/yA1+FyEvCKy+z7AOqm
 x6qNVc/0FfVwhVQ+cV2qcFZQrtrkNZMVTt2bSzDmfOWI8vlK6K9MfqamsOFuP3/JzhcP
 rcP6re92OS6ca8JcuN5yDFSKSYk8I/tmZM8oKaRBl6nEb482qEnWY938tW9kn6VJ4uXV
 agfS3UDJ8Tc4kDnixAJjpi+K4y/KSTQgmPKrJuqrWaI/nlMn9UULaEl2hf7qeBxu54o7
 QHMJZGnEWEayruS2TwFw1NrnUGFu0Wa0NpcNLx1GmE3SvRy2ZKd+V6sgmeuJ9pTopPOh vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2urk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TJlXVl033179;
	Mon, 29 Apr 2024 21:23:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6qy47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLl3qQTMWb3cMbkgO61xB26XOVSpJ8iPMi7AvpUzga/T4uWIkS9Lo9Rltvfc58GIuumQrBUuNaun7bcKh6fCd2x2pFfQd3XTA9TzXPv4RqZoMuNu92Q7bjgWkBpP90ajj/Z/iG2t//C3o50+ZWrileKZUGY/tMHtuUpqMREChEje0fwsumK0qAZau2C1mU4micQsjqUBTmgHujiwaKxrcr8Ka6SeVObddzSAr+KS4dMyI7LPb8deBvZFR+CBI8trNA3X6jT6IiD8m7D+7onQQUWqfUhyuZmsUbLj2AEeSxeZbPodvhua2Tz+7SY4ONUS77cofvn4KO+kxmGsXWWAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLZBu/J9zzqT61og26lnaL5HnWeYvmlSTTwj17M5ZzI=;
 b=jDilGTYa3osKzqTv98sqkDDB+6gydxYF0i4w54AvLAU8N4+inePoyZjhllZbZiE7COA9wXbuOHsVFB+WIaP3sOIYLx7nzJ/Zfhlhv98wjgkZdJvZuOmEtGyVUQ8qKEP/mc57pEgQoVv4AweUNN7LkwuIHzepFyd2tQaut5p5Orv+0z3XA6INHXIj6PTj1x14Oc9p/SQDXVtXAb2R3hez1pXBaqWkLhQMcjbzzqRWzfacR4kSdUN6KtDwxdz4t+ev6Ae2TwJpqEm8Z64uVL7Ao2bffE2bqKedIhiWI7AKGDIPDkVBQP0JvZGmUXjdJ7Zpxpq5BBlyZ3Fjt2paC4g3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLZBu/J9zzqT61og26lnaL5HnWeYvmlSTTwj17M5ZzI=;
 b=VjTc57nhBRcvQ3C7vYy3te1vqbiVDBRO4UIzM1yJI6JJtEfnlXC19OPzoZ6y/f892PuATHz+uolqOQP90zmu2LaupJs7b5SBeGdzmAMZ/rvkMRFM8NqeGfBTDrVAa8ZHTd97aPiy/DGyaNj8dZSiKnQWiAXDWqkomHXzN4Phnfg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:22 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:22 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 1/7] bpf/verifier: replace calls to mark_reg_unknown.
Date: Mon, 29 Apr 2024 22:22:44 +0100
Message-Id: <20240429212250.78420-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::20) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 290aafe7-a797-4ddc-1002-08dc689298e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M6SqMNBgfGbe6v/K9VREl0sL/lSlbtGuGKk6FEScUUdzuNpkqsXRTSdhrs4o?=
 =?us-ascii?Q?oClL4anq9rooguH9IucIfxHOMdjrX+YcXZH3gWmZFGkDMD2kLjXweYzXYFaY?=
 =?us-ascii?Q?CzHb7xx+0jvwYSgJaBdwrXXkMv3l5oxyPAp/BH/eu/wI3GY2rnlTi0zJFw3Z?=
 =?us-ascii?Q?d7+CZjYihoj/TQLI+hcjLnxYPdRoXZ+QDv05TuFlhj/+ykBKtLbm/EGE3pT6?=
 =?us-ascii?Q?gD1dYfaVA89nfYuxMA1PhqWf1TqrlTxovsN3d7vjxxaEVPGDAtJWOxvNveun?=
 =?us-ascii?Q?6W6dfLcvrTlbPfOAVgx0meq0N+XhS5FcXk3Ncx84P765mHm785Mu8//45L0q?=
 =?us-ascii?Q?ywWOFrIi04FhIUngpZ+HAX4LcO6psQ/AG1RWEZVz/5pt4CFFBmJk93OzrJPB?=
 =?us-ascii?Q?atkcEOvFuou9Q4p0tPHfoA4n+ACAHP1WW/Bs2nLmfc3we4IH8NXXSjltmoO0?=
 =?us-ascii?Q?OZ96JujGkDVUfCs1w6vf4hYtvCcN4kZhMT2k+/kw4rEUdQQagCcUVZl1zma1?=
 =?us-ascii?Q?KCNIo7TS6HiMsdnjckeKxqRUiKzbp91AJQhUpl+B3vWqlpgjxJPrZRQF8TVu?=
 =?us-ascii?Q?ToOE/cjyF75w2mCM5PDWYiu2U4v80X14Pp7kxtVSTQcwlnLTpGGforsROxPL?=
 =?us-ascii?Q?DObodGkcUBdbbv0fGrV9xAPqLf/6eME8m6yDWDBg1MC4HO1kn2nmmC1KFs0e?=
 =?us-ascii?Q?/79fhSYcElfre2B5yfyxseK1JNinYMyFfok1ZgBKWtgipc9VjldqmhaoHbOL?=
 =?us-ascii?Q?S4PlrW+0xmq6+EAgwf716/iehAIR40V7cLjs3EFXVw+f8zkJbvndWHSqbMU1?=
 =?us-ascii?Q?ij0wTC38Trg0eL0pxPwefAusDfh6RR8bXtgLwxaQ+oQXk+5o6Wmjds0taOYc?=
 =?us-ascii?Q?blkzjLpz0ptsDFRP5dm3+k5oMD7xqkcpuoZcmdIJeYwCZuzT+k3oTaZ4Yixa?=
 =?us-ascii?Q?Fry6g8bnxBVHd9+vvzyxdMX+/aia64qj4aCZzw2pyCVdPcpJ9VefTmMWlmoQ?=
 =?us-ascii?Q?QK/Ou5FoBNRkHLPopdTEWv1Zg0X6uUnUyn95jmEKe9HARM5QdBh4hmDrehkO?=
 =?us-ascii?Q?5TM+lCeTk7Vr7dnbpU7ghJN3Or5T6xyPOCGVzZXB8YjaXWbUYKcoXjBzTLZJ?=
 =?us-ascii?Q?S+e9BhhxtuER1sF8aQaHNpBFnSD99xSDeI5I9VC/iQ1Z+X/RvV3JJEl5ntb2?=
 =?us-ascii?Q?TMa3mO5qrFwJvFU6YVeO5kPv41xUdGNt0UVvvYzurfwOLvB0aqVIopBqMYSs?=
 =?us-ascii?Q?EQhaQz00qHxfm4CgrpwTDV/ahk010Tum+Ffs5zis9A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aRyoNXha/98T9H8yh+409zoCFyZpDwOqMe3/5+7WyI58j/LqDZeTlSqJYy3Z?=
 =?us-ascii?Q?1OjMly2wt52JIeROWB3qIMg9OQwFNt4PrJ6PR/OH47V9ArYMAuMrXCcZGF1i?=
 =?us-ascii?Q?3UdQuzGj0Z7uCwFvvTUd9LXIuf9WhtkpUmDqlgO3+FbyHCELvY/yBIsq0ShV?=
 =?us-ascii?Q?rQCPUBjaYLA3XRMEmECdXDofuVYuCD/5Gy5fnaNr8nWImkmBOwnHqVUW+nQl?=
 =?us-ascii?Q?4Wf4q77yorllwE8Gyv2kZSAsP29UHRIZSV5JCW0NLsrt+SiubX5qF0qPmzS+?=
 =?us-ascii?Q?XHSa9TkbOd5RjLWXnE+lXzK/t8gOYg1LzB/ph1+nV/gT/xqRuSzg29KVxnr1?=
 =?us-ascii?Q?kbK+PHI/vjvhmgtcVYN8pOfCtTSBx07vJjjrrmyweolCO1GuHCb9m1xDNIPv?=
 =?us-ascii?Q?O+HY9dSkuPP+UONEWfh1+93k7Nk/84TtGup9QOsOpdh3ji6/4uLbZSlOwDZt?=
 =?us-ascii?Q?2Q2RyXbYVz9Mba1kDmMLe87IKswvpHI73WGPRqvmzegwleeyscfbJ6Y/SwKv?=
 =?us-ascii?Q?niB+VbkjzlP6v+r6hGur0gYMwGBz7uqgFM66j6DYjVtfl7s692YWfqatSclD?=
 =?us-ascii?Q?7JbZlTJQwYr6HLqhKgC4HC+xfjPENAKG5U4OO9VlPAJJMXV1SYR/uHv95sNN?=
 =?us-ascii?Q?+4bLXauk+8r234fUPU9i6Nra9hdRAO2EakzRWFKaWmJDxhPUmOFXovtZ/daM?=
 =?us-ascii?Q?c7itQz5jAzDpgb6J7I1mkjBnAYyUGNa3eSvxucWGkxmyg/QyEj6O0DAVmjvA?=
 =?us-ascii?Q?r4/iPfnZijGr5R1snq7r2OrKcKI+mPUWiqVa7yrVlTXO02G/x3IqqVFZhQ/9?=
 =?us-ascii?Q?1dFyAAhL9NoILdv6pFrBv181ryycbRUaCO7ecr3h4cvjA8jFRAAPSJ4aMuli?=
 =?us-ascii?Q?Brjv9O27BOyJ5IKiROb7vwLcrncAdOn7dPvhtAd7SJxlaH7VvDFenoWj/yI/?=
 =?us-ascii?Q?KnSK5Z3N1sYTJh+1Y4xl2SHYoTslVQ8pm0VsV+bprJZUm6WoUGJ6zIoBvUne?=
 =?us-ascii?Q?tA34nnf2ktjJYBrAMqx3ol6v0akmoGX4XyDNoA0gtG1ScgJ0UxJXddDSqlL9?=
 =?us-ascii?Q?Y5A82J8mWbDnF61nQO+Phu9k6pZ4OusdOGjZTnVOvR/O583yEMDRkGUZgN2L?=
 =?us-ascii?Q?zjbr+VXlXDEQbYXD0QsrQpsDbCZJGiVkWgnZw1Slrpf/CcCTOxOuSwYuSLMS?=
 =?us-ascii?Q?BQ1HThk9rYkqs5RCUol0n0uStlzTE6tTknT9oX8/GsyVvOdu9BZfDR64fcc5?=
 =?us-ascii?Q?r2DXng0cygZxbh95NhC+uYQqU+1yT1BdOxCZ8KG1emsD2v7XUC2Y61yGc4VE?=
 =?us-ascii?Q?swko9LOfzvSEdJHmIJzT0qSOLKfY8vXM1h7314Xl2yQKHwzBWfopAWbFBF4M?=
 =?us-ascii?Q?oLYdh/0N5e5JAreAEZ6Eq6AR+eIg5eQnAVh7XlR+sDOJZbVF0m1kbHintVma?=
 =?us-ascii?Q?OyDWpL7SwCHsfg6dItX/k2/mRJCl40BVYA5VJoCN4QMuOxrSKyiOQvUNZrw1?=
 =?us-ascii?Q?v1D3fwsbCmJu7WxCs15MiqzSLodFbxr6bn2ZIncth0ONOYC1HdUR4ApQ3M4D?=
 =?us-ascii?Q?MvTfOARIczplWS+HhyPIyXZgq8VbkFtw3+WUnWD9EzKiqPRIGK7RyMGVDu2m?=
 =?us-ascii?Q?n0d67Hlry4pDRVCKkCQg9gs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h9bmgCVj6ibQOVC2FFS3ZclLys5mHdByKw+qT1Ry2lgMRAYgh9ihE9rxVZm4Rfg2FSUhK3mDUY8YRw+xrIcERvernbsRlBLdvW6QY7q40FNtaa0lLBFPu98tMq6xq6P4W4AWXx5iOvH0ZLb0lZuZCD4e2MWeoNTPLN4u1awHymGaCnAzmzvLLW1/jPgOmGrS/CTvnsKqeEZDahgtHqmBC/LT32cKUKmbmy8jDLsXNfohzykRVRzUfX9+UQXfhEqt221L9hncEB05cfiSSDOH2dpAhAqGwLB+xTYeQTrS+EE8D6dRWBzUp9zPvSiYUFoeTEdmNI+FEzjuHiFr9hoBBhROj3B6vveruX92LJLqzKEUCLNCAgOVzVeLFPaJS1QoJfyF1aecxoT8hmHHgXZ7C4+L0Z4O3TcVRHQujznLOvNbUkkH8gJz5XVZGzad/qXMnLY3nx8DSpxN/e8gPm+XFZiBsyyo9mNThhaEZ2GxHTs2hq2Of+okOdCMOOxK6aI0A2u8R2U3541W4uz2uHxgaFlciuv/rQzA9Zi5gDUv3jXUrvsJ5HHyfmkjxabckoUrdg8zF5+mUNxn8MOZYlz7z/9zh1INUVv1VgDERtR25TQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290aafe7-a797-4ddc-1002-08dc689298e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:22.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txsHB5Muhr2RiUZfY7auKw2nJfUV6KRkQZLZG7u7QFg33PuYePXEh5xTeGzYHDOkV5pQo0+iVRfVvUtpT54hikBfBlJ9G5gNWBsdKIQfb88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-ORIG-GUID: E1ysYDmMauwe-klFJe99mRBgoR87Yayh
X-Proofpoint-GUID: E1ysYDmMauwe-klFJe99mRBgoR87Yayh

In order to further simplify the code in adjust_scalar_min_max_vals all
the calls to mark_reg_unknown are replaced by __mark_reg_unknown.

static void mark_reg_unknown(struct bpf_verifier_env *env,
  			     struct bpf_reg_state *regs, u32 regno)
{
	if (WARN_ON(regno >= MAX_BPF_REG)) {
		... mark all regs not init ...
		return;
    }
	__mark_reg_unknown(env, regs + regno);
}

The 'regno >= MAX_BPF_REG' does not apply to
adjust_scalar_min_max_vals(), because it is only called from the
following stack:
  - check_alu_op
    - adjust_reg_min_max_vals
      - adjust_scalar_min_max_vals

The check_alu_op() does check_reg_arg() which verifies that both src and
dst register numbers are within bounds.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a7e34e83a5b..6fe641c8ae33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13704,7 +13704,6 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state *dst_reg,
 				      struct bpf_reg_state src_reg)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
 	bool src_known;
 	s64 smin_val, smax_val;
@@ -13811,7 +13810,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13824,7 +13823,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13837,7 +13836,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			/* Shifts greater than 31 or 63 are undefined.
 			 * This includes shifts by a negative number.
 			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
+			__mark_reg_unknown(env, dst_reg);
 			break;
 		}
 		if (alu32)
@@ -13846,7 +13845,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		mark_reg_unknown(env, regs, insn->dst_reg);
+		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


