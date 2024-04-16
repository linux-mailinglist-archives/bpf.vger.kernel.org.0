Return-Path: <bpf+bounces-26923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9008A668E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CC82821BA
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6E84A37;
	Tue, 16 Apr 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbE+mboX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvZr79Cx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FADDEEB7
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257862; cv=fail; b=j+maBGjHJGkDUd8ohCL25aD+SuMlssMzV8Cki26LcV/7q0yNiuMnx3z6G+8xGlOt7tKNgCAr0eI7GJrfMveIROg0LeGEtexa7QsoJk4J/TQdzf8sOMPxmLCCK07japYsg4aNOFtui2XhCVcLQJ/TOkBILHM3cZuDvOJlMa3ffwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257862; c=relaxed/simple;
	bh=huXRYjJ41WjYdBjIyUxdKzm/PiI9Hh5gG6pIoKgj1Gs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=UcREbUaVW642W9SBMaBPEg7qGlSAr2Zw26uVJCkou8qO+8wcKzE7wc2w3ZwgvEpF8UaURYvU1ZA/OZB0Jj56GyFcb6tzhW8IU8t0UH2+V4h7i+pZuKdsArxRUIc6TlDd9Lh2nq8HferT/rLVC7eZML904P5gEMNpUJMTcW4x2eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbE+mboX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvZr79Cx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8nq7E028552;
	Tue, 16 Apr 2024 08:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=kEfoI4eJIMvucLlHZNjkYFuqy+MtItm42+1+Jmr4unw=;
 b=nbE+mboXnMk7yz5PajQ44gxtw660QV0dQ+7Z3MVDgZ0r7OsrAO0kRglvkLoQE462h5AH
 Jj9hj7yE7riwlPSe5k+aaeUW2tRjKLEFhVnnPqsshY2zPNp3LgweK+keFHr1zyK4ObKx
 s7dskXUxCbDF2OuWHzUQSVk2O3k9QQxFdeLgQVIKtOlSzc/t1V9jbfRjOaAqB2JssdMv
 cG1mUx1g2hDAf4PYMGQ51cRDmnL4Bimb9Uix8L2JzITh4tknQj3qxIkcTr43dV4k4HBi
 qlCqpWBUed8h1FyPQ6tstEVnWRUgPuGgXAkt3/4Bz36VUJK0qH4C7QdVLbmhcaBaQKRj hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2mqkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 08:57:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43G73us9021550;
	Tue, 16 Apr 2024 08:57:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggd73j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 08:57:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtYxVPbeYMRJVgPgzucNDIazC9LYj9saiNVBtzIjUZvTLJXS7TnZxaXQqHLLZJ/n7FmH98KU95WkzySaxlnKLlr1RcM/vreTd4BIFGxXx8P15/3P62u+QmKZTdGK7sEO3tTeoy8rVCh82gexa9nTYDGXjtcbwwDnUugPG2NKG/j3pgh5dGQQvyyTLjgeNE3T0urqBrGCuVoFH+xGwxMY5mL59aFOJnWRqyJ6HmHuSAoalshyp5NPxt6QpiOU8t+Af76PFatabiYUhpg4sgaPYt7d8ICu/5fLSHrIViIfrmjARZWvpAdrISJ5iD+5ZNz2bVDdwmhqkBKH4AJpgsOH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEfoI4eJIMvucLlHZNjkYFuqy+MtItm42+1+Jmr4unw=;
 b=Qv2czU744PbIC3nZ6vdmmvfM4/vxxKv6me6tzpTOTWyxh7/NFSlj3c4l+s1Z3I9KIo6zwPfoD7XbyuUNS6k1OWFCGKEZRVjWvehm/hQherW2ggztcmIV1TZVi/mvp5/w/4OyxAnCklD0h/F1CCo5EigSONF6eb2KKkpxsxnqzOZABM09lOzlI/zfihX0UxTI024np0ZJKmYGNDfWSWgA1LKwrj9mxrNtAsh20TkcRpwUXntO/gZ1uDbhLAjD8vpxhaZCdVv7i6/CDf0pcM3pxnvZAYCSgaBx0rGEMuw5RLWYPCsMxR8aWnq20gNlTthE9Ij3RUo6F2gen6rWmkWQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEfoI4eJIMvucLlHZNjkYFuqy+MtItm42+1+Jmr4unw=;
 b=BvZr79CxIriCt6ZFAqXjW55JY9ROYURuoOgSDuvmryuZ3mvltt4siL5fRMT+ovWE8TYhMTq9kcYzxQ2mFbkL2h1Szark0P6bCGnKN4D/gmZyHyRmBuTkFrMgnQBL+19wpRfAGbeghl7ahtX7f2Tcdgur8axkAUdEKVlf97Ov5zE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 08:57:32 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 08:57:32 +0000
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
 <20240411173732.221881-3-cupertino.miranda@oracle.com>
 <154c5a8c-181c-4922-b1f8-a772b831fca3@linux.dev>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        elena.zannoni@oracle.com, alexei.starovoitov@gmail.com
Subject: Re: [PATCH bpf-next 3/3] bpf: relax MUL range computation check
In-reply-to: <154c5a8c-181c-4922-b1f8-a772b831fca3@linux.dev>
Date: Tue, 16 Apr 2024 09:57:24 +0100
Message-ID: <87a5ltznuz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 559064c3-4674-4159-a3be-08dc5df340c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jS/5ocFxlUHr+xQh52DrUs8yzXGrlyOkF7tAJY6Kbob2EYF1mp1a4jwxi7iR1NaVQIp9cBBY0tUzRfrmzlNlAaxApEQKcV0fu2zpGd8ryECGXUIHavfLgHxBFnWsvZ6kAN/uDtWZWJDGaVXuYo4eq7B2sZ0Ush9S3ABY4ovdqM+o00vMMlSwU4VRLO8DQrOHW4LQvv8pXdsIdxFM/uaU07KUF4WYL60q4Poo9heRlQj6Nam+PmVUhlsFKNvOD/Vx5WJ5QEO7+T/+KwFU+H0d+XWh3PnVUiGB+DwIi8xSp/63L5Qzstb+Yhrm565Xoz+9N5Xt83LanxXZBy76/S20kXerf4vYWECTKT6oaA7G9n0LyiphHK0AHxU1U+4T1/Ojy8XglM451/skB0hCsKE378k1q1bfaZ6sOwZk/CA+zTC0zcrKTS+fkdNH1QksuGHXOANMss3Kl1VllIKpzVlGoGg2tJ/4XJpwi6f28QomARb6SPINbXwzAaNV8MmpDpqQhP+fFm34ltP9KgOPPJoqExEyDBnlWYejER1ylvnRQAUP6KkV083ieWxhZb4+9z2kj1lTv9qaDmT+G/bF9ueAsKmzwwTOYedpUXjMxYXJxfpDk1l7wOQFWBx1htJtmVPlbfRVciOFjsPSLZCkjFhogv7mKRrvsXr5KbJ7QuTGIqg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6YKF3BLVjj7VsnTMepywTEvahKQVgrbUSBbL2oukf//ZBny6R0mUKPL27bM3?=
 =?us-ascii?Q?n0RAwab+b2MAqaICIxkTY1/wndUScd/D1ZwH+ApnXJK1fCNaVqRXx30PGRZB?=
 =?us-ascii?Q?dKjMDtjEnq8WP1yQOvTtPRiwrV83tLA80MMVQkyHHmeHVnxruK7fBJpKsd/Z?=
 =?us-ascii?Q?EhashtjkXJ3tpt6HAtZ4f+0cW5QnWQ1aOaJbawB3AL9BG3DAUsdB1/7+0eJb?=
 =?us-ascii?Q?cBR2Li/i9mqV1pAioFacaL2OeNrVkJQrHrfQUbm8Bf1kaY36Faa1eWsuMABv?=
 =?us-ascii?Q?bjBXYtgkGjDqbP1azRSVDoIKaf3TCIkI3wvzqyKDYisbPQkUIC4Yo12Vu9VU?=
 =?us-ascii?Q?/RtYqtqjV22vrgQEWo5fROwnDqEkbM/WTxCF6/sL5DpxQaR7w+ODRUoHDq2M?=
 =?us-ascii?Q?p8wfxhulxEIfCDSMr+vcWLwcBJfx4XkP23YJ+3PAiQJsKM+NCu3zXtFOUqjJ?=
 =?us-ascii?Q?pSsgpgyuQjHz+kpY/Ra73NQc0/Hz3RE/cAcCRhFSK79FrzMLO/otr8Q6J5zm?=
 =?us-ascii?Q?POHVi34HryVpFJRlQNVh18qMCrsy3AWWnKzwAPf/ISfOxegjsL9ithnM25RL?=
 =?us-ascii?Q?df6G0ppfjCEKYjSVLsD0xEVdK5hBGDekDN+QoC8wk/yhzJp7qdCJdvCnc6RE?=
 =?us-ascii?Q?DIb/LTDqFVfH7bkkx7FTmykoDaO74AnnXIcCp7OD08adCc8UlRI3th0+3U/0?=
 =?us-ascii?Q?CDEfykH4Z8XqtF6frdL51E1i1G3XQ6+Iub/eJ6v6/uLPku89Y1QWHzd0WKaf?=
 =?us-ascii?Q?GOVaXgds2BjiMi4cW7SdcZXuYYLpfwWUcVGyL3/5wreVBkiHmtxkEMNz4HLa?=
 =?us-ascii?Q?wI0fJYQEwrEVTaHKAeQnP+7nRvJ2h0OtGvMy8LWDFa0VhlRMWpTfj5cGQbYH?=
 =?us-ascii?Q?NfRUCkIZIsJqjfEbdZ0oQU8AkDwXzKsOLz8JQs6rkUE5br7KdVUc0XbZKd4O?=
 =?us-ascii?Q?O8c+9AuNxaOq49/rKn3n/QQU7PUUKGMKg0afG8W/FK7G6Ggcyps5ITBJARFg?=
 =?us-ascii?Q?GltHh6HzdaJuNFIodJzGXu6thg1vjADVxk3Uqs+dSfgvx7lgvQAVnnHamk/D?=
 =?us-ascii?Q?orAPRR4+BLZLMYKjt9iXWyl2c2ePrZ43CpHyi9TF6ztyhT8rPK/GAIhaBA7L?=
 =?us-ascii?Q?Rs5eDbjKr6bBlBDwgUvBZXYkWr2OXetaOX6msonkj9z5O+xI0dqLpF22Z8zR?=
 =?us-ascii?Q?pIRKxR1IJzXiI45y1R53xKFI1/akoFSkqoNWvcQtG+ygy0+le6E/5cWmKzkT?=
 =?us-ascii?Q?i/qcFSYgBnAPAxEMQTJhMhtPIuQIoMF6WYRsfYkUhNXWl/dKjapDjJyTUINy?=
 =?us-ascii?Q?EQxlpfMXznKCo4Tm5vwVoaOGrvwh/G8ejGN5FLVnbR2+gWW1YVtfqOchzbbN?=
 =?us-ascii?Q?/3h+4Dw39bjerDxoGxwvDlb10LPblGWggi4omCuUlzW1FFaWouL/8TNqJEs1?=
 =?us-ascii?Q?O1mG5jGXKcZ68a8kXtrKPMEK5fza3zoAH/PAIxd4MwESLm63CN6jNShEndf4?=
 =?us-ascii?Q?930simzSgttQNWaqpWnENhsHSN1dyzDdLFpb78b8cQeS/pWpJSLXote3N1J4?=
 =?us-ascii?Q?nTAaEj2zXUa2rMIZys5AjtobFM4fghZfVSOLAUUJMTHh8ANBhmCZli8pDMJL?=
 =?us-ascii?Q?4DzlhTNSpDPD2KI0Z/cW/Vs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MZ0aA+lezDHiW5CGL+MRy9/0pwqOSvjSgVcbCmoxeB1N9zTtjwai9yHHNVttEkGmJfyygb3EiqR723RVsz8ISblm+jzlkteVaUgMLkNiE8bh7XhmrNy+ZK3xN+tDLRWAVXTRNwZDQrp+Mlpmf3nXM2y5b9XoDI4AZVz760fLSqNZKiCEN70E/d7Y4fy/r6eGK9bWJemNXAHEpxXxqABlaQIzOZ+HXklchngnFv13m+tLlfe+VyS5ZtTC/Y4zHWArg6wxNWREtjaZbJy7bSd0su/9TvOZNzlvCH0CirtrI+y101QaI/n0yFx/T/dvohkRsHjD8E6gZwk/fQFYyQMnphpNWMOgCB4crYZQXAuVoX/xROx9JPvQbE7oayPukGjEzj6HjF8GTQLM2FW6QTmDg2Pw5kG8p+Kq0NGBgYr0j77LtRlxxmGVxbvfH4mVMSgDTEaRZMcSSzTckGtPkjn3iVrFY/VxZaV2NWsVjQ0oOSaz8aslXfX22HbqN8QKaCUAG8oyTzXRazIeXTYTiXK9iFoTpu9IEQTMmtmPmg4qNvCb8/p+5D+6cE5w46qV/++/X8wb1D35BNYFMNRErj3ikKsYZi0KuNS9LW9dUqa3gKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559064c3-4674-4159-a3be-08dc5df340c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 08:57:32.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reppspo7QBccyZGNCvBiOwwywPUemSGu2FeWBVgarNthGIWIfiZKRZgZvDhM5i+tzRDymBRxGgoVXwkTW9gPL6a9JzMyLSfpxy6x39BxcCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160054
X-Proofpoint-ORIG-GUID: MzLbCetJgLLYIQfjAHfKjM-gFoC4gFkG
X-Proofpoint-GUID: MzLbCetJgLLYIQfjAHfKjM-gFoC4gFkG


Hi Yonghong,

Thanks for the reviews. I will prepare a patch series with your
recomendations soon.

> On 4/11/24 10:37 AM, Cupertino Miranda wrote:
>> MUL instruction required that src_reg would be a known value (i.e.
>> src_reg would be evaluate as a const value). The condition in this case
>> can be relaxed, since multiplication is a commutative operator and the
>> range computation is still valid if at least one of its registers is
>> known.
>>
>> BPF self-tests were added to check the new functionality.
>>
>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> ---
>>   kernel/bpf/verifier.c                         | 10 +-
>>   .../selftests/bpf/progs/verifier_bounds.c     | 99 +++++++++++++++++++
>>   2 files changed, 105 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7894af2e1bdb..a326ec024d82 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13741,15 +13741,17 @@ static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
>>   }
>>     static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
>> +					      struct bpf_reg_state dst_reg,
>>   					      struct bpf_reg_state src_reg)
>>   {
>> -	bool src_known;
>> +	bool src_known, dst_known;
>>   	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>   	u8 opcode = BPF_OP(insn->code);
>>     	bool valid_known = true;
>>   	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
>> +	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known);
>
> Is it a possible the above could falsely reject some operation since
> in the original code, dst_reg is not checked here?
I guess, I believe in the case where min/max information is not matching
tnum value/mask, when the value is known.
My thoguht was that there would be no arm, since it could not
rely on that known value to compute MUL ranges anyway.
Still, I just realized this applies for all the other expressions, so
indeed it is rejecting and need some more patching.

>>     	/* Taint dst register if offset had invalid bounds
>>   	 * derived from e.g. dead branches.
>> @@ -13765,10 +13767,10 @@ static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
>>   	case BPF_OR:
>>   		return true;
>>   -	/* Compute range for MUL if the src_reg is known.
>> +	/* Compute range for MUL if at least one of its registers is know.
>
> know => known
>
>>   	 */
>>   	case BPF_MUL:
>> -		return src_known;
>> +		return src_known || dst_known;
>>     	/* Shift operators range is only computable if shift dimension operand
>>   	 * is known. Also, shifts greater than 31 or 63 are undefined. This
>> @@ -13799,7 +13801,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>   	int ret;
>>   -	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
>> +	if (!is_safe_to_compute_dst_reg_ranges(insn, *dst_reg, src_reg)) {
>>   		__mark_reg_unknown(env, dst_reg);
>>   		return 0;
>>   	}
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
>
> Let us break this commit into two patches: verifier change and selftest change. This will make possible backport easier.
>
>> index 2fcf46341b30..09bb1b270ca7 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
>> @@ -949,6 +949,105 @@ l1_%=:	r0 = 0;						\
>>   	: __clobber_all);
>>   }
>>
> [...]

