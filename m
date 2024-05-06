Return-Path: <bpf+bounces-28709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB358BD532
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4601F22B32
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0830158DD8;
	Mon,  6 May 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y7Ch7Xcn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hvgVlJoY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C5158DC4
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022630; cv=fail; b=M8RfAcyuRroAiekxlht+YS8e7H8KrbyQtcqdHguLLfTATy6GdhVupcwor30lK690ACiq78LNUUCVcHqrKLVSmm/5W5qElFLN66VCphBAaTA1o8nsOU5QoZn2UB/6icGqE0o75op+l8KKrwweK9lnU6trptb3J9iWcDeGKrxnOqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022630; c=relaxed/simple;
	bh=5ZP4kEVSOhUkx0USAmIfNGN0dY8VnZS6s6DutOSJ6M4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=AZd1BC8QJt7wZC06SmGhdmQz8vqI/vjRj2pe2Pwu3SNHOxHN1D5sNJOCpeGoOTvWWMGzKTu5aJ63onhIdXl82dbzlEumjuxQAEsz/GnVOzjiQtCFGZ4FFgtwu75UgsYKXuYT3+Tl2GRWwk9ApqnWdyL8VqczJS+04IZHnQSr5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y7Ch7Xcn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hvgVlJoY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446IWE7T003366;
	Mon, 6 May 2024 19:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=drXcrEuGJokNmZooS/GpWpnE59qk35HQHwNNqxd5DtI=;
 b=Y7Ch7XcnW/TNO2KREx7XvPaT0inPTBL0vLoOU9NtSHkoVXdxfbj672YNPEkyEpwM9vMO
 21od4/cxETQSH7aHOCQGTjegaYvQgixBpt/MAKk0vta2sBzQKUnhWsGT2MwOzU5xqrgR
 ykp1pPuf0xdAM/3jiMcX3cLJQi6R2ICTttTphSELdLZeGUntgdvFnhLZxEXtqTikYVxM
 TRztGgCMmd/f58GJI3PdzdhGf1YmTUKtxH8gHkTHZ5RbQHKhk1PYMBhqZXt3oV7u6zOJ
 UllXDZFhvO/GLrZYNLfkWVpmKXvj5u56q+sBPfV+Dtb1+laQ5eg824ILCYzlZ1bBbsKd eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjuuade-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:10:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446I27CK040807;
	Mon, 6 May 2024 19:10:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf68wc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 19:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq/mPhPfbNJejJkrtZgKO7wJhlF54T0iKIMRTsSIfW/SNB7Z1AR1Si/lHGG5AulbtmyNi5LTFTXfjcT7/0msNUGOuTc4Zq9ZvaESOhzlYmOYRw4QEyrrI8/bbOuhYvDr2762GUnXeuYOckHQI0SJBKs2rmP3nwtjS1NKvGUfVo7VHbB/qUB/1B+qsxLX8s3efgWUUj2wBsQN9z9pifTVpea4Hn1AX/HEcOW+ETjH/IhIhAmuxmorBi39mmpmtUz3lRdADyD0F6UbhQMXMC/v1xh7M9dTVfdyYMzQTc8itmwYftnFxD+8niSic9iwc3kZCijCehhP+xtrJgsd+wsNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drXcrEuGJokNmZooS/GpWpnE59qk35HQHwNNqxd5DtI=;
 b=VKfjyUEAENu/4ARfH7rPMr2TmAc1QvCMT/OwCe1boePRTwpZDr10EP3RbiuZ5wWWjQGS8iJRmFU7HVohYlbOwyOk2NNFu61NMaGP2oALM5TAjBY2fiBTf90G+kc/U+ogETzWbrn+x4GBLvKB+2K7GVtrf8ZfKDWvqpHG/maLmwu2aX3sSP+zJeMX0KOrakWeBhh9fkkzmHgmhdFAGoBKp2/PiJS68LWB1KOp1hcM3IgPjKcBUyYpMNQM465kgGpJhHcQTNLo6qdAwxkxB1sCgdChGM33w3LVkJpJMtG6ZKgtA6jC8laBhTgYpdate+DsAfwiG+GCwPyoWIMPFsm2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drXcrEuGJokNmZooS/GpWpnE59qk35HQHwNNqxd5DtI=;
 b=hvgVlJoYTd/O4T1ZAE+H8Om5q4c4RCQHBLMUaEErUax5v2H1mEjsWuNl2UFyKY7XV6Zl0CYVMWKv44ZPrNnX6N4h4ZmxI1T9i1RYWBkwWYXBAvHUZxA6z5IPdTpp/qa4Iqsiq8jD51lX9BKSbFriv2KAN17EbpWi/L/fkVWEgX4=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS7PR10MB4992.namprd10.prod.outlook.com (2603:10b6:5:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 19:10:21 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 19:10:21 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
In-Reply-To: <14531c3db62da3761e0783d12fa67060171ed722.camel@gmail.com>
	(Eduard Zingerman's message of "Mon, 06 May 2024 11:55:59 -0700")
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
	<6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
	<171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
	<CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
	<87a5l5jncs.fsf@oracle.com>
	<14531c3db62da3761e0783d12fa67060171ed722.camel@gmail.com>
Date: Mon, 06 May 2024 21:10:14 +0200
Message-ID: <87h6faiwo9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS7PR10MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e4ed32-649f-44fa-5610-08dc6e002ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U9KNA6OJHyPRZ++sDzt7gfEDugBFk3C4dw0fggXJxzzYZLFXebg74hlytV/2?=
 =?us-ascii?Q?WA9/Ip49b4YPcqrRg7pVTFpa84IGAM42RsuQhhtyIdNIn6oc5XZA5Taq5hVT?=
 =?us-ascii?Q?Umtq9NOneFjE29CxR917tWyqzkz44pe4MVREdaojkbsNMw2R5nNdWtG/a8Yf?=
 =?us-ascii?Q?DkqVXk1WW3OpN+yc2IiAjblhWQspvWlKXHXWtegCpbGcdjLlldqc0X6T9RIy?=
 =?us-ascii?Q?nvr5htSUKgCndM3rMUmluHo5Q9lmHNg+Yh+MyeODGJnzZRq0hykTVN9ZQ9Hu?=
 =?us-ascii?Q?8u88mlCHNxFXmY6tWmswu8UimcgZ/tkW+9KU45Hv8S2CJUU4syK8kqY0wpRm?=
 =?us-ascii?Q?45w9Ju0+hkORVN9JQGAbzBhzr95LBstqp/rwisIElgObXjPX0cQJY+kBW6P+?=
 =?us-ascii?Q?KfZDq/53FdVvRPji/OSQ1mYxN47lz5Q6JUg9SZl7Oc9PdBoiJPonbmrnHGh7?=
 =?us-ascii?Q?h5RmSfrYfjWlyhRYhZlb+YUGR2dCK+pSiskrMG9C0tUqbyh3k67HmLbi4b1O?=
 =?us-ascii?Q?JKHx0AO8nl82xWQbBRS9XzdOLWqcmQqjCqlEy6pnWYIsW3LiZrFGPra8p66P?=
 =?us-ascii?Q?2m/o+cc1asgHjLMuvxyx86I+vzyQkw+DiXd7AEMr0IK55KHysHpg0V8QYKAh?=
 =?us-ascii?Q?iekAdVkj9pkPvHZM//M2134EHdBgFe/SDAOA62RzR/YeT92QNlmApUnkia1w?=
 =?us-ascii?Q?kdgV7ws/Cb+Ez6cTDGJJLgpDjLYLYaKWt5nQtFOpnG8AOpA0FtKY3LC2znMX?=
 =?us-ascii?Q?NjA0/CJpKBW03xVK7nu10tlz62Vr/KrDcpCtXMcr1av+KaxMRFj9ll0Vuwu0?=
 =?us-ascii?Q?O1Mx8swVp4TQ+82OjGrAusAV3CDSf95TxXHYwTdHSpTk/uerqjPsNUbFZ+/J?=
 =?us-ascii?Q?pe9A8CVc4/XD6znPvBSX/sV3EqXvnMG9kx+IL2er1NiSwWSg1Nt8CUNGARuY?=
 =?us-ascii?Q?L1zT9fgf9upOK97gaIrYmMlzEc9FRmJnlyMkSI5z2MqvgycLgft6GMWaWYSI?=
 =?us-ascii?Q?0+4oGegeaA5EyKXV81keqIFuWtbkCF5I5nyK95yY4WxOLPxEeCDsOvRLNdzW?=
 =?us-ascii?Q?5NZ/Z5s1bHyvz45OZY312DGy529fhIFNtd6JcO5tovPriKnG82KKsBswwyZp?=
 =?us-ascii?Q?/B9x2ZUCk381NdhzuwsVlzrqTMNhLjxL3MLssgrJOIEyITvFBYBRntQf8bhp?=
 =?us-ascii?Q?HH2RiStW+2zNG7FkNcMbhU0JvEl2rAoZ7cqI23tRjPHlAMIta0BCMx2Od3zB?=
 =?us-ascii?Q?jDR8loNYJ8TU1DcP+DkeD88+m1Vopt7HFI4GoVaKfw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2IiiuIBY7DRx7+PCDxXWcnAyfVs8/Cd7ZXKn0s9VJ3BjJ8WY1OQ5Iud7shlC?=
 =?us-ascii?Q?vPR9bj6PUWvLhpiw0KP4JkHP3MQ0AFubYtgispJfhDIsLxhg4NBddqF8bE+F?=
 =?us-ascii?Q?qH696aPTdz0DU/bVxKCoi8l6kZsfBVKLX0ncV89AQkOc+kv58Wv35UeQLGfj?=
 =?us-ascii?Q?uk6GYrqoBWH1gBOPcUMcQskDnF0W63wNlCrgvniWXZYASP97GwnNIxBkrFIV?=
 =?us-ascii?Q?sf/HOFPB8lrDHBjlWPHC963nKPz9UJi9HD/+45WEskBhl4xq8A30BULGHfAx?=
 =?us-ascii?Q?sg2ZOCE55+OdcaJXXsTfG5dNPbh64FjOz8zgBhTOjzBhjVyd42QnReqt2Zn9?=
 =?us-ascii?Q?RXt6JPQqdd7yW4359DGMiFVzZ083zqCFI5N5B+4hwIN+NNS+b82H41fBB0+Z?=
 =?us-ascii?Q?U+m66taPNyWsvPWHBk3tICCtwORcLu3hu2ucOlC9aIq3Kkw2VEQK/NleXalT?=
 =?us-ascii?Q?5XxoT46HGJO4yjNx3Iseji2FulFxyu3fTiblCGdsl178d+RTka1Y10JKaa4q?=
 =?us-ascii?Q?IGzKNKKsKHEXhJBxiL4O5TK/ivgXN/TWbsBHzrBlafgfXayoZOn4S0PNl6s3?=
 =?us-ascii?Q?UAUhOWiAaMroawLGajLR7uUIgGJ2zDHDEI1b8CXYIjyuTeOUcFE/8t5ZsJ8U?=
 =?us-ascii?Q?DYUuSs+3fPvtHgsP0/Gjp3rAdKIzEqZWBcCvP3y8EnFSw5yItwY+vpRvyjtn?=
 =?us-ascii?Q?jfyCNBAFIxRZRxXebnTcc71zHPaBATAx06OrCxXCaE2WoSH9sq+CA2mWxjIq?=
 =?us-ascii?Q?aHsT1fGJ/AykvxS4oOUMHXIW6wmGcD7ohqUiQSc+xnrhYi1lw0Qzuan68rnQ?=
 =?us-ascii?Q?/+wIN/VDjP+E8uR0XKPvlTcwBNbX1T/hizJTsvLxLciiRyPESm7f8N30AeRE?=
 =?us-ascii?Q?O1sG4GqSE5xT0EfKktDy6Ax24Suhu5LGG6H8+hXgR+4OFp1tbCVaXmf7Sm9H?=
 =?us-ascii?Q?runQdsFkxQpoCCMePd7QIPsQpbrZ87h1OOp473zI2PddzKOkQhRH/ZuwNvYT?=
 =?us-ascii?Q?uX6Df7gtecOj3xuoKpojhK7oUctG0EQcC5VEn+CQ1mzbdh11iY8AuZJME/T3?=
 =?us-ascii?Q?bh4zCSkQISsUlQLlw1eppxEPspKvTyLbvpNPnzqsrkTASdlVRmQBUDZd8zw7?=
 =?us-ascii?Q?Yr1q+XB6QgNc8mlGmRtYGLp7i8TL/usL/pK5mV8Sp+Bt/IZXetJrloS/8o1f?=
 =?us-ascii?Q?D8oiWF8xgWaRoP0GjWM3EVOWvwq3QkFdBDawSC5bAWA74zvGwtihfLAY6+9I?=
 =?us-ascii?Q?aG2tHvuhJLcqfVG8/reUTYJ9YBI5qq+CVaxRmaQ1VrNxClkJdXiX7pyC1Npx?=
 =?us-ascii?Q?2VkbcOZo6kJoA9Lw9R4eFUZj8EDguTqQknxPqn7x29szlQv6MCEYdK0prmYX?=
 =?us-ascii?Q?QA3BrQoDzcsKulT35jRxcJcCZtmDXTHk7pdYLUAUBvHPksTNFo4HpGsbxItI?=
 =?us-ascii?Q?0rpPtC5W+gCb7+cq9764edTbNx2ZkRVHyiK3flybKsJ8DhX10STsLyI+IOE2?=
 =?us-ascii?Q?Q/Ajw3Zt8L+rfAqSHUbbhORGv62vMNeThEdS+IPitwO2Zv4O6ZRPlZFR6Fe6?=
 =?us-ascii?Q?hyA5ZW0oMNwf4B9dITFnmAYqI4buaYHlw7MfPW/d2vkfC4Npjv05iCMyDSZf?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EpKywGarn0K+h6C8XpDyUck9YG6st43ETY91Vn1EhlTWXg0l8db4JPfBYwojRyihDx4kfrqd7IHF1sDEAyhmR90QxpyRSiM5O0NEwe+wlr7Ln/tBfrLwZFYgKBAT6rryfCUKMgR0U1LR4reEAQee5ebE3c/uOumYGgoZX2NjPuxVXSNmbGvUXB1QzDH4In5OJAY421FkWsMWIRGqxttQUNZS/YtyhkBTbd39uAFT3utQ8LFEtduQsfFbX/vn0kJPHoFh8QDBZux+x5oSehl8Gtev3+isfNnWurR3A9SL+ccogfaTNX9TLlJQI/7TDXTCAY8gigPlv4v2ThM7EZzyqLVjXCGZktPsXC5EOtB3jHkgChmuw4rjg8wIgAeQiYHULDFCSnAQbCjJ1B+QquSUqOJbfHPjp7Bz63ks6DZCrhaOrypYAVz3xltvE4UJ8F7roYQQS5RGCkFazIHHa3IkJehWT/WiF02BAQyFwRTrggExOBAZ3qx2S9GVJVYoudmSMhLxgEv6tp9UJ2wi4e+absEw8fPwu4ich287dZwYU/Ww3yNyMn/5Zb1JqlBViFaT9+Xx7xGVG8JIpp0QpY8DvjKPnp7d8NJVtmhM35DafgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4ed32-649f-44fa-5610-08dc6e002ba9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 19:10:21.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czU7DFuueKNcoBMqocrqkxZXIDK39joLeP+16ELedlEyEZtThS2o8ZoO0nGUQxvRtWzAWuKYcnW+Um0VN/znogSpc4EROwbKhmKjXL1LZY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060138
X-Proofpoint-ORIG-GUID: eRTZK-V88jumSajhjSbskhPlMPbxyABg
X-Proofpoint-GUID: eRTZK-V88jumSajhjSbskhPlMPbxyABg


> On Sat, 2024-05-04 at 23:09 +0200, Jose E. Marchesi wrote:
>
> [...]
>
>> I have sent a tentative patch that adds the `record_attrs_str'
>> configuration parameter to the btf_dump_opts, incorporating a few
>> changes after Eduard's suggestions regarding avoiding double negations
>> and docstrings.
>
> [...]
>
>> I am not familiar with the particular use cases, but generally speaking
>> separating sorting and emission makes sense to me.  I would also prefer
>> that to iterators.
>
> Hi Jose,
>
> I've discussed this issue with Andrii today,
> and we decided that we want to proceed with API changes,
> that introduce two functions: one for sorting ids,
> one for printing single type.
>
> I can do this change on Tue or Wed, if that is ok with you.

Sure, thank you.

