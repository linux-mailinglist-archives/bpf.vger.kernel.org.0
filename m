Return-Path: <bpf+bounces-75909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29673C9C883
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3979F3449BB
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371332C21D0;
	Tue,  2 Dec 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aSr++24l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W3V83PIP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4E26A1B9
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698572; cv=fail; b=L84QD3ghFC7m6DHaGmJ35/YZMRP7GOkyT1nEgKynhJzg27jov7Rpuyv4zwIQQtwl6DNQKp0yKRF05aStUJp33es/nJiFoAZPOqpOIeACCGj/91aCfGCxoYRgUXt3Ml82/fgD6JuSMB38tEtmxvXNjlMhzO6LVitoAMTXosKlhAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698572; c=relaxed/simple;
	bh=rS3RkXpPF6Snt2fNvFz5FJpV12c5wCZX5QL7Z0h+5hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=didLWVLAAFYingJWpU7dt7h8lyEV9Qyu2LtBdnYw6D+RkZd/hwBgUzS1duAmO16o5zxvLWVn/B4g4ADEXaPmGPCNhOWeWUOyuOcHQEBLW1MO0aNWB2snTeCBuqcrXT9gSYfb2nY5pDVIMx4yPmGjx8scAbkD5RIWwX5JE0YFjRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aSr++24l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W3V83PIP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2Hu75f741011;
	Tue, 2 Dec 2025 18:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IRtUiuZHaWxm/ou1J3JV6t/11BdCqDqOX+/1etMNizI=; b=
	aSr++24lBM3zaxR6Zhjob7jx8oS9LfOxSDYveTq3UZ2GJwvviEPvlb9bDSrOLXXc
	5LTwDuQJavVOi4OSwcBAj3xBspXZe6XibaoU+d69h2buUIAH0pyeW9n/Na+gx1tF
	xcmthdNZdJRlE0kJPYkElCOolxYuhX5gqfeVoI4Pj65Dhj9CEyqNpoxsV/9eL7Xc
	p6wB10Q9/xXPPw9cQqMITiOOh53L9cNmwNZhuVkdP3doUsIdDuIZx6yGXOchfnYJ
	GvE+SMWh34ODn+JiTWl+iMS9CeAMLyXhGSVvIhkOPbBky4wIOa56qGI9tJSJq5QV
	1J/bxuHOvYuFD35Dc1qZ0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wnbh7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2GeaKQ035498;
	Tue, 2 Dec 2025 18:02:47 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9kpupm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 18:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7Qf78JhENlC6bwodXqxWgzP8dNrIoL+Kh7rDKG14dmM2fC3jn2oHTHTHq2NjJhDDsLiFYvZYIlC9MSsVeoBKAnkEhXBmuBJIr0AJfL2duZY68FTtWAO9E8Rc6keQAVyvAoAUf4V1Dd6ebHPWdC35aLQMmp6/JlAOccPa9Dd9x/4KMn97k/e0lIaMknusQNm1rl+dgFsruqAQWizEi2LoF5Sev7GmX5ePyax9U7nLhYMqS0pxu0MDJDAYZhdSh0toF/6mQuLcVth52IZtgovFJv59bzRiGzqfES4sB97kYRHTrQxBTDBokfIiXuODEyQlqhPD3x1Ys02XaBGu9XWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRtUiuZHaWxm/ou1J3JV6t/11BdCqDqOX+/1etMNizI=;
 b=AHIPhZ0YDPwTMu8mmEJdFnVkQJkwpg8ghCf61e3ziKDw19O+YAtO6fYZYuSPKe4z/FTN7uzufUwsDSxelIeu2wMpGnWbVRUA0FO+6FBn56xI0g/PV7rr//RGj9QMWAr9ydYOAgVyy920kefTm85hoYoUkrJez0fKUdp50aLXXuze76t3R0MGPNnNx1M3ARLLcxefA7lcELqjUgsg8kKZMwoSYr50NODIFlGva41DffuwooaX854ESCZio089wvPxCmyguMnuo5akgxdJWX0aBxig3y1viZbsGRyNgXkErguYlkcKdhNeHoQG/2AqM6INhAzjxTyCuNriNkEixXlMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRtUiuZHaWxm/ou1J3JV6t/11BdCqDqOX+/1etMNizI=;
 b=W3V83PIPX3Xk6ddyHoMyCrNvt2bpEPYRtbxHY2TA7r1efX9c/slcqop11iuO0jBCvAWz0NRwG9vr4NOYG9lNWJx/zMzvbijCKes3licdxcglk7Y+hcyVz3oJTJe54aj9IO9+YkKUMUAtBFlmiWYGrAiZdvsezlCrfJKjG8P+G+0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH3PR10MB7164.namprd10.prod.outlook.com (2603:10b6:610:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 18:02:43 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:02:43 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH v3 2/2] selftests/bpf: add verifier sign extension bound computation tests.
Date: Tue,  2 Dec 2025 18:02:20 +0000
Message-Id: <20251202180220.11128-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251202180220.11128-1-cupertino.miranda@oracle.com>
References: <20251202180220.11128-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH3PR10MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b02dddf-7bf1-4b1f-7cc7-08de31ccfd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZgdqlq5UPslqeh/7maTOPK2wjIne43S3zgYG8JFpZSbISCXgkgrmYPMKUZk?=
 =?us-ascii?Q?/KAU3LWFmfKHAMWVJfWCT0iolUWcc9nlD8xjrswHD32M8AJAAILVweqSck/Y?=
 =?us-ascii?Q?vUCN7lHbQulg9DjW6MaC1RkZWA7Ist5jHNO4nO50GEecncQUA4yu5RzmMuKU?=
 =?us-ascii?Q?ag17qRLJNIS4wa8B6+938SgokgsG1uJL3IGmqLsCxP0AVllKb7TzwkS+Ly3O?=
 =?us-ascii?Q?aSlBjdsBhoUat8qiKwhteBAB/Z0tPFBZ1zna85eZYmgtTqeE5N9rcgSnUesR?=
 =?us-ascii?Q?gn2th0AiRSHCiVqqQPyzHhFj7BzGTJgCmwn3RgDgQ/Zk1CmGeSQKYNejTgWm?=
 =?us-ascii?Q?VQ3XLSdHRHwy/5cQ7IPbZL3wy8L24ibhsvXv8yw40bMsma8Pett2BBpiWV7Q?=
 =?us-ascii?Q?ylCi44/4aXIAotifyLeidHSUuWmH7Rt1TIeejJ1txgwMtAn7GXFl5MpGUwgO?=
 =?us-ascii?Q?n4pKmQ3RvkHmXETngMxKj+ZqoxCXjTa7dxUQYQFYLqM28imGM9c9YorBLqcH?=
 =?us-ascii?Q?wRCapv1nSm3NFHVcIyQ+nNhS5uFywwV7L7UmOVlMCyZC+u43xgECpxn7VvVI?=
 =?us-ascii?Q?4TNJO/LGxkFYHYsQvGHhV7KzRc3d6yIL0KPuhQOAXlB+HxK/WOR5YDMtLlQj?=
 =?us-ascii?Q?czele9gPZM0YTs3Ka5STBR4lVMycAT7Ig4pirqGJhcm4ySM97a8Z3xqkNjsF?=
 =?us-ascii?Q?WTbBFzARirkQ4LM8XrrJi2DGbhd1EAn9lv5I+fYzyXmM7PydjRGVeB+WUEEP?=
 =?us-ascii?Q?PKG1/oDYIrHTonkBjzeCiw0kGqHjsGlq5PMRY8RtGDT64heIjzMgwkbwYp87?=
 =?us-ascii?Q?p4kqZMwW1cM0jC5c0MaarHGqiLyjb0Nahj3Sr9hpgUk0uOcItrw+bXJye+RP?=
 =?us-ascii?Q?Ns2vQGKRt/hRWHe3mV6HddTkw7PS1fbXIgHCxwH/Bdkaq2WuKX1YxVEu2Cd7?=
 =?us-ascii?Q?Jd0SwI2NPZ5+a4RJvUP8Tu9dNBhqVP/vLarYH1MGBi27t6TKczS0EMCugzEI?=
 =?us-ascii?Q?j++wv4yRKq9CXaDi/ObItD4keWeWPbDtN+NNLxUuSqexLw/y0TMU0YtLZ0j8?=
 =?us-ascii?Q?f6c46Im0MlOJL6Tg7Yl7oaU8qAh6zygiijvxJxsvqophJXTWsJWYjKCp+ZJA?=
 =?us-ascii?Q?XXtdQcv8o9t2OPSVgzcQwwF0d1T/KSN/rxTndfd+s0i774CIm6D4d6Fuv1s1?=
 =?us-ascii?Q?t3nEODKQ07w76Fgdp5PkW9LZQypkUHcwcISlOB4HJKZ68T373N+6Sl73WLpn?=
 =?us-ascii?Q?xbWzCJr+B29ddd/8kJ6juMju1o5Va+TIF+lNEYlpq3IHrrPC5io34OZJCRbu?=
 =?us-ascii?Q?QbBSvMWIOSRJXXsEJqruFnRX6IQvszmaC95O8tjBiKI6vE+ifSBI/Z+0sh+W?=
 =?us-ascii?Q?LPH6b+BS/2VHqv0QLcVuZ1GSo5kp8sw6WX5Lv7+PP2PLUXF/koea9y9hqYcd?=
 =?us-ascii?Q?KLZhSoEP92RVuth8HK+LC0P4oxrXvwvm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4qra5dQpv6fXovjhZfPvOt2qUZ69itjI5zz4eoyXujsGwvrnKCZfDTLQQV8?=
 =?us-ascii?Q?Z8ep6Q3bDgbk48o7dDJuDw/y4jBtRXvZfuIiEYTkGLpMwk7FKhf8vAUkvOxu?=
 =?us-ascii?Q?GECNJZcD1hv9cRLe029z0LRPT5BA4LDMWIj7rsaWOum/MXLA2W8RxsmNwNwg?=
 =?us-ascii?Q?mGjdQ54j5CKQgH18YZVoK/WnrFwRWYhnmKX4xdjT+bmIBRsLBoEUt5PRxaAB?=
 =?us-ascii?Q?asaa5SJ9FeLMZ5Aq97EFtpiEyVMZ9QX5/hCQvaH0QkDnjAMRuI0rhAw04oyF?=
 =?us-ascii?Q?TthX7RaPTQcdy5QpZ06w02PabxOHUDWtsf1h7RWljMgiE+UZ6D+wm//S/1AV?=
 =?us-ascii?Q?w+NDBfX8RSIPR4CbAd8/EpYFvwwvOazvzMi0ZQy0qnwBbZV2K/A3Lh5CcSB1?=
 =?us-ascii?Q?/LwmkL60UIPikoaZ78fizCdt6uEbAl8nns8WSe+hb8ZRv49bYe8pcEB0Cn/x?=
 =?us-ascii?Q?RbhuG08XwxnVgPywLP5RuydzoKYOJ+VYo4KMXtbK9i4UPvL50++BLhnDDf27?=
 =?us-ascii?Q?x3aCYty+32EXJefqLUNQbtDi27RWXqS4t+Wux210hy9Vpl9BYVZQMSN/TCc+?=
 =?us-ascii?Q?afR9UJNjq5omHyQXJc7L1gvIt0UB5gbWTBYSItlxF2FJ5yS6EkB1QXk2ZXoQ?=
 =?us-ascii?Q?2UnmMy2q23+uDn39uYNTrGDP731ANYl/VPDfG8nX9hxwcrVnB7YyuT3ksEHv?=
 =?us-ascii?Q?/Om+oVV0Pl77kvycnn4gf4F8swll/Q58nQkPqKmed5OkLx2pHEM/zn2OzqOy?=
 =?us-ascii?Q?Sd1AdRl/Ccg24k1K4htr8xT2k7HJ3iM2A/1Sk6+kQmm8NnvjAggfVHekZ2IG?=
 =?us-ascii?Q?UX3/qs3u2YniNoc/Xfe6VzGC+RcSaUoik3/qMU6s/DJatrpapmmVST7kjxRN?=
 =?us-ascii?Q?HT/eVcS7Sr7vGTSrFQpF71zSPapjvfLS7ZPM7LztTilqNmR86hoe9oOSmxOK?=
 =?us-ascii?Q?IwMq3ax0KxUZOwt2iNdJEq3ydcfFpCdq/5LUFzlw4o3Jwok8X+DdrzD/ZilJ?=
 =?us-ascii?Q?zwYMmqClgUsEgPjM9rvIVaorCixgqC4U8dtDH56CI2b55cnpBMwhD+QZ0LT+?=
 =?us-ascii?Q?OUuSsRTNTOBqkSB6q7MH2EPwufSH204M8x+1be2ZYrdsUPP9gEpL7Os4MOl5?=
 =?us-ascii?Q?j/D2PzGPmwJY50wHwrsduaOX97lLpE3/wELrRWaQgaMwfenCU4HkKhOX/Xap?=
 =?us-ascii?Q?A3DREEg841mFeKAazflEhdbc9Ub5xziEz1wCC26ViVJ1bW0olMnWGfDsSyhQ?=
 =?us-ascii?Q?pO3ku5xSdi9SFNe337eJ/ese4JCR99mwmdA+fdGpgyfQU1hlfolgHisHnX9W?=
 =?us-ascii?Q?xrTmIpaK+RHF7AfxZr1LRafOzyi9HOhD2gVsKuzVtxC/DGM5xh7fF5eVsV5O?=
 =?us-ascii?Q?lfQzBVlqpyBpAE/UCF7UWKS8DU+WKhjOzZSdYQuN+xQfajpWEctPpdDdb4WY?=
 =?us-ascii?Q?CaA2Tbo3T+98lGYIyLvn0GpzhBHAR4f7g1NVj/W6FJVYJwurN5BhSFcvLTst?=
 =?us-ascii?Q?5sediakgfHQcTWOR5qdyozwzlIDm6EES5beWiTl1hLTPjDHp7plBJaLyDN01?=
 =?us-ascii?Q?DigYW7lwvj8Z/pUzRrMnSN6F9Octjdw7COaw7l10gNT0K0WNEQwIHKscUeTA?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlfn8jV6+nRAqqbxXWm8cz3MEM3bAxbU1E+g50QAabBVfRAqRMbNIzWmuEDAZRJj3UvT4HCQSmPD7xV5EJJKYDs96W1+ujNUBJrYK9uB6F0eU7Segvsiymx7AtuMoOf8DOfviNI6ag+JNOqIHMfAHtn7QsEnwnrASLgFEYDwRWDTBc5CvHXR3k/4sx15KDRcpEBWMjubNrwC3an2EXxLuQ/HRG9/r9XqL+CijWMXphdzp/QWvI+pFEQqYVls9MdCa1qugXM8aUPLRO4+KuYYmVEkYtveAcLW93x1PwoCkjgvOsnruYKPpeRsc3fl7tph5mEoKwGm8pA4kEWim4jSwOfG926JxuoauyMFbWNuefPaY12ukrp0qZwQAlNVnkOqXNDi/aNXyiSn2Jzr6fCv+ckUq16cPep7swDmGEWQpMPLeWomJed2chPQQcRfWll6LljukrMq9qsut6AkCrgxPSDn3VxxjKmpFBuGp4XfwkF/C0842GDqZWlwqWwFm6cwRPtVbiWWUR3hqA2cQeR0bXQCif+Dv3gfkqUuBh5FOKlDrl9mqm+qzjq6bVPSlcMDGNTb0bLAevfTjJHX3ldFxVugClgbO62g7S+gJ3qD9gQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b02dddf-7bf1-4b1f-7cc7-08de31ccfd88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:02:43.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anKdILsvgYIWFNZuvc+gYxh4JS28dfDOZgxVoCzA3dtWE3qwfWblL+wO7XYjFdJdwMnygPT615ozJM+5BabG2jtnnhxFZnyNB1YKDHMGg/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020143
X-Proofpoint-GUID: uHQk05A9P-nEcWR_7KLY_gMW04C2cVU1
X-Proofpoint-ORIG-GUID: uHQk05A9P-nEcWR_7KLY_gMW04C2cVU1
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=692f29c8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=YKY8qPteO0UkzRZ4YNIA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE0MyBTYWx0ZWRfX+XOQ/M3JRw6d
 dTBNLTTQttK3aDiEuapv6v1YPKcpXej/EnJf82JHiqYoBqgshomfYRUhC1MJNKWlHEXNodhqxii
 UIar5uM1/548dOaFhlYzCJuLZjEASu14ZWcnBIS97ZYRakqwZUJ+uJg71J2E+UmCvzdRsVGfgz8
 6Is4voQ2InFQB3SnZOq0Zg19y6G0NLLjsyYFucby9QVhp22Zy0YTnNwYhITcOejmMpLASStEklV
 Ul3Ac1BicIv/dfT90V9KXWcGt+SewjjoquOnUi33CzXNZSYg4FzkjMcJxl7D09k0Melzmn6Y8OM
 FqTzltAD01eYQVmg0WlHqjUBYzEFO0tZhh1fwar5JMWkCwbcbCsDErJI/S2iHhuu5IsmwNAZI5K
 96Or/5MtU0MwXx9bv2iJjP633LH8p1sBrTDiU74aqOFHUFKKDhY=

This commit adds 3 tests to verify a common compiler generated
pattern for sign extension (r1 <<= 32; r1 s>>= 32).
The tests make sure the register bounds are correctly computed both for
positive and negative register values.

Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust  <david.faust@oracle.com>
Cc: Jose Marchesi  <jose.marchesi@oracle.com>
Cc: Elena Zannoni  <elena.zannoni@oracle.com>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index 8613ea160dcd..b3e1c3eef9ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -531,6 +531,74 @@ __naked void arsh32_imm_zero_extend_check(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("arsh32 imm sign positive extend check")
+__success __retval(0)
+__log_level(2)
+__msg("2: (57) r6 &= 4095                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
+__msg("3: (67) r6 <<= 32                     ; R6=scalar(smin=smin32=0,smax=umax=0xfff00000000,smax32=umax32=0,var_off=(0x0; 0xfff00000000))")
+__msg("4: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4095,var_off=(0x0; 0xfff))")
+__naked void arsh32_imm_sign_extend_positive_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign negative extend check")
+__success __retval(0)
+__log_level(2)
+__msg("3: (17) r6 -= 4095                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff00100000000,smax=smax32=umax32=0,umax=0xffffffff00000000,smin32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-4095,smax=smax32=0)")
+__naked void arsh32_imm_sign_extend_negative_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 -= 4095;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("arsh32 imm sign extend check")
+__success __retval(0)
+__log_level(2)
+__msg("3: (17) r6 -= 2047                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
+__msg("4: (67) r6 <<= 32                     ; R6=scalar(smin=0xfffff80100000000,smax=0x80000000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))")
+__msg("5: (c7) r6 s>>= 32                    ; R6=scalar(smin=smin32=-2047,smax=smax32=2048)")
+__naked void arsh32_imm_sign_extend_check(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 4095;					\
+	r6 -= 2047;					\
+	r6 <<= 32;					\
+	r6 s>>= 32;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("end16 (to_le) reg zero extend check")
 __success __success_unpriv __retval(0)
-- 
2.39.5


