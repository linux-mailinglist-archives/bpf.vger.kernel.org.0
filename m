Return-Path: <bpf+bounces-28469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C88B9FB3
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0EDB231B1
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7D816FF54;
	Thu,  2 May 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bLHN/wSf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="logIOnEv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F416FF3E
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671881; cv=fail; b=eh6AaNiFQgVVErF/4XJafaCsZW7Nn5tuibLXYU2EbA58FDN1o1knfvaV5UqvJ/HDS9Mx1I/IO/D7PJGjid+mEyLUx0e++bgkHRA985dpiOvbqrT37XGJIv0RPivjDhLk3tXkjFHaIww2+3ypFjEGHsgwNLeoGQNa2fZFpgHNO+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671881; c=relaxed/simple;
	bh=eCcDpOeBBqHL9vXMnua38tg9YwGdKHHaKqwK3gcij0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LDHROnChRdMtkqtUwopL7xAar3ZSwZJuarE+5cTsTckiN9CBPyGZ975DqbFDdiQsNFTBGIDAC2PVUi+2lu9B6FXg74zUxgLI9olLJy58cin5sH9RlWPyq0VdA7tCLj5KkWq3nLYUKT5cVfcYOeiU2ZGjDohhR/wJ8/xSIvQF0fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bLHN/wSf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=logIOnEv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HHATr008382;
	Thu, 2 May 2024 17:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Xfd4yCs88hbSk/euV7beh1w66sFZQ8ox730FNdXOqPM=;
 b=bLHN/wSfx9HhL68gS3kXn3+xiPbHO2npvZ2N9n2afjnG7b9yPiyWNMTCSQ0h44PgzTBK
 rTQZ76bJ+XAFJu45msGEv5jMOiZmI2qKFq4h34DdA3nE4WqsBtqVIK7N0jBLB38Ze9Gy
 wiWoGxl2TUsVZ4Wd8JofJEWJNpVACByL0J33rdpPMSazDIks3nWRHSRFekN1DwZJPmp+
 hbvrr6gHnTeEeStQDllDcZ/37Mh/SzzcssBel7nsX1vElnQAcTyIM4RN3i/vdaNAFuKB
 w8vOmL0aTLs9qYfkrRW06l2WMYUTY93Rf1vhnP6APLGPFqBVezoEatYtYEExj++TYTe/ XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf67x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:44:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442HJT23034828;
	Thu, 2 May 2024 17:44:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtb1uh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/CWLyJBM3AuBXnuxX6tY8pEyFwTXPXova0PsNDrqz+b4rUvxoz8L1Yd5r1DfeNlo8854HKue9hNJNtOyfcPlz+CmirWcrWr5CC/hkeky6kti+FRchaAWLXbV5QNfVP6pY7w48UvjVwxOPFetRX85ICmWKFMenTxcUrzF7VEP1AeGjMRJWqi6eyc+z2VGzzNPhINXujdqu3fHLH2Sx5d8itsp0HTOmYhe2A4LWMujHqJnkIp/BHncpP39PP6i9hwbanrNjgjHXsa75XkSL1bNCqEU8haD5hhZmSSuu/5wDFaQhAs+D/7KOtP6aAwfiN5nU1XVzgcke9UnABmnTZZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfd4yCs88hbSk/euV7beh1w66sFZQ8ox730FNdXOqPM=;
 b=QajWhc3VY33mDJ1JHHkVg/Bt5Z+MqCtMuZUHwdggxGxgSGrjLoh1yFIzVn8n0k1AtuYhE/if7U7SiX40U4oG5VJQDRTLdXb64o11hwYMtWF3nNzuNKn5ioGbanqGuaDUJFih0NZkREBUigskavuswEKVFGvHtZs2jL/iKat8BpnxREo38ANxWm86XKYOwyzl8c4LeyIHA+9WJx25cxkY2Knb12/3QV00aqAXR2RDekirq95xcLvdyMFDEuU9b6gu11aTs8M7KsUatdZSf1QF5PljQapMjPAqtuI0T2vgP8GIn/F9yU/AnuJUdtNWnGe6UNEfITn8iZNetM0nP7tPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfd4yCs88hbSk/euV7beh1w66sFZQ8ox730FNdXOqPM=;
 b=logIOnEvdpL0in/Go3ILPne9QKOSPe7BWDBF2pgwGqV1pMLHMXbYxuuAC8jxKXAAJLRbFWT7TzW8hlDjDOFgIhve1x7mm1uib9WCcVlRlO4e7Mlb9CO6A2SmNBbyjeQxJskxNjfVWoUBqqqScI5Vy7RH2G0UgA1REe0GKxEZ3R4=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BLAPR10MB4850.namprd10.prod.outlook.com (2603:10b6:208:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 17:44:35 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 17:44:35 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
In-Reply-To: <c4d99195-f000-47f2-b167-12e76b705dc9@linux.dev> (Yonghong Song's
	message of "Mon, 29 Apr 2024 13:52:48 -0700")
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
	<c4d99195-f000-47f2-b167-12e76b705dc9@linux.dev>
Date: Thu, 02 May 2024 19:44:30 +0200
Message-ID: <87jzkcqfb5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BLAPR10MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: a49e41fc-6c9a-455d-6e85-08dc6acf87b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CO+dJrj2yJQg2j1j7SQRVW98XSpt98MITdH52SG3/cE81ZaYtCzToOYnVNVO?=
 =?us-ascii?Q?bBwyAfTXQpiEFds15Jn7yfZSSXj3g5gXAJ92wjsL4wxbIYbYv67IP4tBNs2N?=
 =?us-ascii?Q?4GcFCAEpEIxdKrDzf5u0XeIcQ7AmiMdNGCTyN0rMUGxdILMibF76SIQH+KQy?=
 =?us-ascii?Q?3PwrNXCeYQS3zrv9Oh+v1qqVX3M1zVCVhfkW1+z8/myiILCtGcXAK4c4dIL0?=
 =?us-ascii?Q?Ka9lwNh3F4IaHS8ngU268R0pnLWwX7godfbuUX7zZdtqZhFsQE7qltaxNLFI?=
 =?us-ascii?Q?W6HZKMLUgWaWZGVJbFHm28WvX6v5hEgbjMbaUce3AoIaR3Ixyc44m9u6T37j?=
 =?us-ascii?Q?gtcBPSl3mcqwtBYShV2puHw5kU9RkDwplR4BrJssXTVaZplNuSZ7+RPPpL9b?=
 =?us-ascii?Q?um3j8cQmElUaqSbPgbaQSc7LhwcQTvRuZkeQ/VLWMVk7OHV3WbwkwXJge9J7?=
 =?us-ascii?Q?1D8OPa5Wos7UhG4iBWPhvAEMAvp1ouTirfh91aIjfsALWD+iikJ++6a+NgW1?=
 =?us-ascii?Q?f6bAdU6SmR0it4hy+ZLAk0Phg06Afey406JmdcAfBK2NXvSud+2M1rPNkk4c?=
 =?us-ascii?Q?dGMwYNrO2TQEQpbl+89MTQSwPRPqWyrZyhGCQZCiksXDPgSFNrCTd4xgMS6K?=
 =?us-ascii?Q?gEyWOxcJN5yyjWIzaB1Swv0/6g7H7pjOyCThf9Uh0d33SW/Tss6No9KZui/J?=
 =?us-ascii?Q?An81q2mqInOMkDbQejeTLBv0eSPSAoVXL657ZzAYFj+2oqtvdQw5L9KrbO1i?=
 =?us-ascii?Q?+dFMMMKjwkg8f4+JJAWybTdOPVT0gIrB0pEhpk75eu/d/MVkSn3xTpuT4W3N?=
 =?us-ascii?Q?9GhuHBiYGLvwSRVm85AgyVf+ehEfo6kVwMWIVavL2N+zP4Zw/eDUlQcV0Hh6?=
 =?us-ascii?Q?HUenU+d0oAxeJ+cCN1YqTmJaHRUjexmCJrmT2WeMl2z0HOQO9fCLtmzzCCfT?=
 =?us-ascii?Q?+pp6xSvlQHTNSKEMz00rwHgndfeu26Cg0dQUYpQ6QLt5MF1IJyNTsipaGwti?=
 =?us-ascii?Q?Pb0ybifsZDKzqD7Dcu7vPuGUxlhD4hn2YCBR3jo40ZjwGRpk9zMVva3RPV9n?=
 =?us-ascii?Q?9j6947bnasMc1wvCLE7aoyy295DcvjxiwOA/zl1mQ0Pf6E2VSugam9h2M5jV?=
 =?us-ascii?Q?5dlkQdCPyRFuY0/T8vmM0pD9rtvtJC5exKlR7mLgwGbe2b7MCfgzcbBnY3TA?=
 =?us-ascii?Q?Cld25CqTctj53MeLI2ukI66jIEdieQZxZNud30qHxAeybsxqNAK3bjezGih9?=
 =?us-ascii?Q?gBoOO8b3gcXK9byBSrmR2k3asPvlkrVfGKmJblR1VQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CslbLJDueJe51aUEb5Cm/+7WNq6nOG0CJ54hDbKLhI9JflcNtKBaDmFBrwgW?=
 =?us-ascii?Q?ZclOdD5sNmtR7gKJ4MCtLUgoT1vDfDlUiwSZZB9dnJe1Eb1CWgkj7WHx572x?=
 =?us-ascii?Q?DAFD8ENaYt6tXF/Gw4dEgbXUZjt2Wnnhi5HQqzhfpxeqlPI2SQrrcFcnzLVQ?=
 =?us-ascii?Q?9oXk65gAQJMOsGjylTeeNhWPQ27ICEsKIoeljKvLPbFdj37gbh6YuEOxTT91?=
 =?us-ascii?Q?hkvw4FQWvWauAJzUlWet43p8RhlgxZJUVZFiT8TP4XlfjRJyyiKY3ucIgpBv?=
 =?us-ascii?Q?UbChROqosFn35ZXexflx5ClGHxC8tC9wmpvbi+Z31QxrBHmm+q707eiOpsWs?=
 =?us-ascii?Q?5VJafGKpScc7muK2C1VLVOH/64rU54lP7RTPQgnkEdQ7CUIrppi+hv49+ob+?=
 =?us-ascii?Q?UVYyOSIvLmvR7L99OHhHpOCHPS6pWfvwmy/QYKRl/gzg+k43A+BgEnbYiS/x?=
 =?us-ascii?Q?Yw4ggNS8gpkX9zSBvB3uoPNNLa9IN1GN2dTMU63/MqLelI6fGS2CYTwy44Y7?=
 =?us-ascii?Q?uakSMBYDbltfGhVSxaexOWkWV1pDXm1mjPtSNmrB+Y4Ak/Ah9pfrbpqo5clK?=
 =?us-ascii?Q?7PBwOnfZfzfhHGZjOkwSOy2zMEXdxMYhjGHzB76nwyiP5R6L/SVFygBGxQM3?=
 =?us-ascii?Q?9mexqELXMU2bLsj/QW41+HapZiwhIGfx5rkw17SNsbjWMjcfL8dPHlVcrW0r?=
 =?us-ascii?Q?C+2YdAM/1DeI8H/xESYoKfpTroXcLpZWeVZtt/ypXN6l9cuf5jby72SAgkRI?=
 =?us-ascii?Q?5leuyH0Jr/t+8ALO+xLoTaG3pVz4ylxisjokuJN51lmmAfYwOuu7zPSXDYNF?=
 =?us-ascii?Q?ptJR+OO0Gn0hWWwgrQJpJM2B+uHt8LUYTt2sDJZzKq7kfGc44YZZSF2CRef5?=
 =?us-ascii?Q?OA9pauD/EeQ3WqVatwCQp1jFWXKbfdXrV/TRwzy641K0geoI7q1y/9+7MqLA?=
 =?us-ascii?Q?ZKkvMeTbmNfenpnhrgA6Z1Lw+wfli45UaM5fqnQOXF4a6ImL+/73NHR+iNAC?=
 =?us-ascii?Q?K/KByqdq1YRV3P8fP5aLD5wKc0hnEjtH3sZVBltFsV12zWXarqoC8jpOQrm/?=
 =?us-ascii?Q?HwWcvsUd/WrFViej+8FP/8VZ5iCBockr9myCkkRVWaSG3GFklABhGKroxrDJ?=
 =?us-ascii?Q?c3+yyGWnOXx5mZtE66GdpJmZM2vBt8s/OmbD0QLA6SbZyoNYCw0fXg06DwNx?=
 =?us-ascii?Q?EfO2pct/A2Xf1PSWhX5FeLDIHVNMtfriE1F50iLR93628o6fAjbp+LmiyRtD?=
 =?us-ascii?Q?sanc2gBJOUf4mudHa/0vb+mxM6jdyBqfUy0eWL17YEA6r7NOS7cdVFkBGi3D?=
 =?us-ascii?Q?DZPPcMb+J5Ooy4olZTVneEczAzhaHa7yFWTPEfIl+hLMgCJUEdMYc+P0PzV4?=
 =?us-ascii?Q?vjaHYlOeMs+ft8qTmuO4PSiLXRrew7jWDYE0Ak15fOk9SuUf9MsUGRUCkgnV?=
 =?us-ascii?Q?rRVPSM0nRGeAlIOo3IoAJzzJKse93EhxGFMInsmcIxyoXDvfBycg67p3n+AD?=
 =?us-ascii?Q?KLKBQvajv7hpCnZn3pfRZt5cgg8TbHGHwiZ+xIuQkupztntyUVlcqUAMIkvs?=
 =?us-ascii?Q?VlCJiNOdUF4s6X2yBni9xOjz6sWkk9GQYwMS7RWEjDp1aIpulRuEoWp6meOL?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YY3It0CJ2RSQ+CbyFhli8GycNsWzFa5jP0GQ0fU6xripw55DekWjvYyYZ7/0LCkElk78b2AeYw7S7Q+JBTnrCFN0mIdSAj2JBTE0uhqaaLpZdLlaLVhPFyUxHjhebd6m7EJEgS5mQajZX4YZRBgk2t2fapwQc/MLiy882V+k8j1MeTn+kD99BQ4VO6KBdRIsRbTq8KSkcExXYk8OyhzsXRkvc7ewIFektVPfojcvyiNyL+QS4uXZNPAIjBffdF/xGA+rlsIAm9ibAmtzJJzNlu4T/cbP26O54zW0c7Qcxilsq0+y7YiVx0nbG2GgP3dPj++OEqU2E91vcy9sAIYBLXaC477xlGI9bzavGoktpsnnQGx42Km92b4hLwQ+e4KXOWfsu+6Q/6rmRQXrjcgrdGPJ++L4ZpRt4cS+W8Mb3bfGbzW8jSvIopGkGzuYM71X0qN5Wmu1ikltfqE44uawQByfSu0gO5K0va5wjT8BpHChJgxSTUt28DBtWXqBtLIkNQJ4TLoaEOoRSEuJ6wcthiTbrt8eNRWhtP+eDYlutw5rY1OgvbsC+S5jQcdw5V1r2JveXq5oK/V/LciyE1qH3t+mEaWh2GkkCIMtvhNGxdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49e41fc-6c9a-455d-6e85-08dc6acf87b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:44:34.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi65Ut/wR8UzmwJaDASsS7S8PUfmBathXHs5c+kwgnDM4/hCDQtfzT7Ewv5PrQQs5NNuY7eXjq5A1Gc242zlKkXz7syFqjhmY0HJC17+Aak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_09,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020116
X-Proofpoint-ORIG-GUID: RKNpb5MbxXVugSDsySKIQjwL7yli9h7v
X-Proofpoint-GUID: RKNpb5MbxXVugSDsySKIQjwL7yli9h7v


> On 4/28/24 4:25 AM, Jose E. Marchesi wrote:
>> The macro bpf_ksym_exists is defined in bpf_helpers.h as:
>>
>>    #define bpf_ksym_exists(sym) ({								\
>>    	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
>>    	!!sym;											\
>>    })
>>
>> The purpose of the macro is to determine whether a given symbol has
>> been defined, given the address of the object associated with the
>> symbol.  It also has a compile-time check to make sure the object
>> whose address is passed to the macro has been declared as weak, which
>> makes the check on `sym' meaningful.
>>
>> As it happens, the check for weak doesn't work in GCC in all cases,
>> because __builtin_constant_p not always folds at parse time when
>> optimizing.  This is because optimizations that happen later in the
>> compilation process, like inlining, may make a previously non-constant
>> expression a constant.  This results in errors like the following when
>> building the selftests with GCC:
>>
>>    bpf_helpers.h:190:24: error: expression in static assertion is not constant
>>    190 |         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");       \
>>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fortunately recent versions of GCC support a __builtin_has_attribute
>> that can be used to directly check for the __weak__ attribute.  This
>> patch changes bpf_helpers.h to use that builtin when building with a
>> recent enough GCC, and to omit the check if GCC is too old to support
>> the builtin.
>>
>> The macro used for GCC becomes:
>>
>>    #define bpf_ksym_exists(sym) ({									\
>> 	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
>> 	!!sym;												\
>>    })
>>
>> Note that since bpf_ksym_exists is designed to get the address of the
>> object associated with symbol SYM, we pass *sym to
>> __builtin_has_attribute instead of sym.  When an expression is passed
>> to __builtin_has_attribute then it is the type of the passed
>> expression that is checked for the specified attribute.  The
>> expression itself is not evaluated.  This accommodates well with the
>> existing usages of the macro:
>>
>> - For function objects:
>>
>>    struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
>>    [...]
>>    bpf_ksym_exists(bpf_task_acquire)
>>
>> - For variable objects:
>>
>>    extern const struct rq runqueues __ksym __weak; /* typed */
>>    [...]
>>    bpf_ksym_exists(&runqueues)
>>
>> Note also that BPF support was added in GCC 10 and support for
>> __builtin_has_attribute in GCC 9.
>
> It would be great if you can share details with asm code and
> BTF so we can understand better. I am not 100% sure about
> whether __builtin_has_attribute builtin can help to do
> run-time ksym resolution with libbpf.

Hi Yonghong.

I am a bit confused.  Is the _Static_assert supposed to contribute
anything to the generated code?

This is what GCC generates for pass_handler:

-----
pass_handler:
.LFB1:
	r2 = 0
	r1 = runqueues ll
	call	153
	if r0 == 0 goto .L2
	r1 = runqueues ll
	if r1 == 0 goto .L2
	r2 = out__existing_typed ll
	r0 = *(u32 *) (r0+2920)
	*(u32 *) (r2+0) = r0
.L2:
	r6 = out__non_existent_typed ll
	r1 = bpf_link_fops2 ll
	r3 = out__existing_typeless ll
	r4 = bpf_prog_active ll
	r5 = out__non_existent_typeless ll
	r9 = bpf_link_fops1 ll
	*(u64 *) (r3+0) = r4
	*(u64 *) (r5+0) = r9
	*(u64 *) (r6+0) = r1
	if r1 == 0 goto .L3
	r2 = 0
	call	153
	*(u64 *) (r6+0) = r0
.L3:
	r1 = bpf_task_acquire ll
	if r1 == 0 goto .L20
.L4:
	r1 = bpf_testmod_test_mod_kfunc ll
	if r1 == 0 goto .L21
.L5:
	r1 = invalid_kfunc ll
	if r1 == 0 goto .L6
	call	invalid_kfunc
.L6:
	r0 = 0
	exit
.L21:
	call	bpf_testmod_test_mod_kfunc
	goto .L5
.L20:
	call	bpf_task_acquire
	goto .L4
.LFE1:
	.size	pass_handler, .-pass_handler
-----

And the .ksyms datasec:

-----
[7693] DATASEC '.ksyms' size=0 vlen=7
	type_id=7690 offset=0 size=0 (FUNC 'invalid_kfunc')
	type_id=7691 offset=0 size=0 (FUNC 'bpf_testmod_test_mod_kfunc')
	type_id=7692 offset=0 size=0 (FUNC 'bpf_task_acquire')
	type_id=7530 offset=0 size=4 (VAR 'bpf_link_fops2')
	type_id=7550 offset=0 size=1 (VAR 'bpf_link_fops1')
	type_id=7475 offset=0 size=1 (VAR 'bpf_prog_active')
	type_id=7535 offset=0 size=3456 (VAR 'runqueues')
-----

Is the entry for runqueues en the datasec enough for libbpf to patch the
ksym value in the corresponding `r1 = runqueues ll' instructions?

>
> The following is what clang does:
>
> For example, for progs/test_ksyms_weak.c, we have
>  43         if (rq && bpf_ksym_exists(&runqueues))
>  44                 out__existing_typed = rq->cpu;
> ...
>  56         if (!bpf_ksym_exists(bpf_task_acquire))
>  57                 /* dead code won't be seen by the verifier */
>  58                 bpf_task_acquire(0);
>
> The asm code:
>
>         .loc    0 42 20 prologue_end            # progs/test_ksyms_weak.c:42:20
> .Ltmp0:
>         r6 = runqueues ll
>         r1 = runqueues ll
>         w2 = 0
>         call 153
> .Ltmp1:
> .Ltmp2:
>         #DEBUG_VALUE: pass_handler:rq <- $r0
>         .loc    0 43 9                          # progs/test_ksyms_weak.c:43:9
> .Ltmp3:
>         if r0 == 0 goto LBB0_3
> .Ltmp4:
> .Ltmp5:
> # %bb.1:                                # %entry
>         #DEBUG_VALUE: pass_handler:rq <- $r0
>         if r6 == 0 goto LBB0_3
> ...
> LBB0_5:                                 # %if.end4
>         .loc    0 56 6 is_stmt 1                # progs/test_ksyms_weak.c:56:6
> .Ltmp25:
>         r1 = bpf_task_acquire ll
>         if r1 != 0 goto LBB0_7
> # %bb.6:                                # %if.then9
>
> Here, 'runqueues' and 'bpf_task_acquire' will be changed by libbpf
> based on the *current* kernel state. The BTF datasec encodes such ksym
> information like below which will be used by libbpf:
>
>         .long   13079                           # BTF_KIND_DATASEC(id = 395)
>         .long   251658247                       # 0xf000007
>         .long   0
>         .long   377
>         .long   bpf_task_acquire
>         .long   0
>         .long   379
>         .long   bpf_testmod_test_mod_kfunc
>         .long   0
>         .long   381
>         .long   invalid_kfunc
>         .long   0
>         .long   387
>         .long   runqueues
>         .long   3264
>         .long   388
>         .long   bpf_prog_active
>         .long   1
>         .long   389
>         .long   bpf_link_fops1
>         .long   1
>         .long   391
>         .long   bpf_link_fops2
>         .long   4
>
> What gcc generates for the above example? It would be great
> if this can be put in the commit message.
>
>>
>> Locally tested in bpf-next master branch.
>> No regressions.
>>
>> Signed-of-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>   tools/lib/bpf/bpf_helpers.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 62e1c0cc4a59..a720636a87d9 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -186,10 +186,19 @@ enum libbpf_tristate {
>>   #define __kptr __attribute__((btf_type_tag("kptr")))
>>   #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
>>   +#if defined (__clang__)
>>   #define bpf_ksym_exists(sym) ({									\
>>   	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
>>   	!!sym;											\
>>   })
>> +#elif __GNUC__ > 8
>
> | +#define bpf_ksym_exists(sym) ({									\
>
>> +	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
>> +	!!sym;												\
>> +})
>> +#else
>> +#define bpf_ksym_exists(sym) !!sym
>> +#endif
>>     #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
>>   #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))

