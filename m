Return-Path: <bpf+bounces-20736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01E8426F8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E58285583
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B504205B;
	Tue, 30 Jan 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dh3G7M7R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U23lxMmY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49D6D1A8
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625154; cv=fail; b=YQgiZnoBjYIRFARjFvtaV3bnfqQ2sVifZDlWZ2dKenmJub0JcptWXwO4+g9J/2qTwT8Zg/hwt3lwkx/BEH/ADGwzSoOUbBgB59+pAMHdvnJRQYY7rMmhyeLxg+qblMBig4R6k1wi4blgGDCmnYx8WG3BYN0riG5F59NWr/ypU1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625154; c=relaxed/simple;
	bh=jkSVP8+4UAQtTT4TY2ZuyCV3mpsCK0MeIrA28Pp2DSg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GqjH5bSkHBdyclMWw+2kXnzq36lh51VjbFxI+esXwKQJK2FW4rKGZCMc8qZRc7JvKHskmB+0PUCtJWPPAV9SMnu2oiEu2qMLGrjWQ+uMNFmsEhHnhbHy+jUBo+uqgbyDT4RdKmf8lX7UXB0rHLTLb10zMzeUfiQ4C2RYsvyOIsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dh3G7M7R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U23lxMmY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCAC28027205;
	Tue, 30 Jan 2024 14:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=jZjJp8SMyydlo08ICRNBcQJwhrYUINCuwNnEpYcOhaM=;
 b=dh3G7M7R49AKx2F+UZ5/+bvrUrGyF9eCWNW8wxTCaLhBR+dsKHO+zXpzp7hyVTRQEu7Y
 jeG+W1tYSnAEy8wDBJKFFIm0rKeuq3F7/zcjLbL6RT/EeNQuLj3OrgmFTXfSe46lPXre
 VZc1+siLHG+jDwT6Ca2Byx+Kmr3LSvqzATpr7i+4sBa0U5NMoHnlVE5p2PpyypYR7n+d
 TIORzUq55QJNLLssCzk2ACPL/9SIyukSgYNMesvkxA/TjlImv3BEEX3MuShJyVXxKd2I
 1zxEKtdptnE8sH9RQEIBRH8UNyt847c9ThHPudMV7ilCAX36w+woe8Uj12e45QEMdc90 Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2f0kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 14:32:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UEADec014646;
	Tue, 30 Jan 2024 14:32:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9dfrep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 14:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R63+qBonQb0cMLmyDdKarPmYv7GvIGFAVFa2FG2jfic4BHKULxpv8ABhyzbcVqSW2+F2/YvjRgfEPrxjCdfxdsSUD06UN/Ss9xHxVgfxsRbguS67My9daxFUKOgZVnHbU00tGS0dqTLxI3moyrkw1iX2giiChD+M97xcZJqYVvP0uwkjYGPRzD07qYvEK6W1Wi81ruU4cEDrQiMP7+8lIZCpcGlw8c6TBIt1jtI+UjW3pwMdUWKBed0OhWhBQ3L+HCRlzmlhmXR9K5eiBU2Dq84mngu2zBBJjXQAtl72DiXsI+8f/LxIshMjJQPBLJZNsK2EXYuDlV9yiuMxAM0IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZjJp8SMyydlo08ICRNBcQJwhrYUINCuwNnEpYcOhaM=;
 b=XmzjwqKUSbfRzoM8ANHA/ngGav8zSjboZCb/0IMIYj2xobxV9tJtLe+ovpkhey+9mXffZEkWaR6A3EqLx3ruJXr5biWtSxgSdYTskID/o80+HjraTLjxGOBI3YuREmhLOAUB10IsMbPQVJVppyR5yuQEWJPy/JBrPjQLycl30Cq6RDz0pHQG+h3moBp6VMX9aPEVbY/xX59l6DRjvWUpD5Tr8G6J8idP8DCfPGEZHvlhHFkSi44eCFwkWQGbglKaflPncLPKtvBEVfsaw71IsZudDFVxyOaejwHEg+bwq2EjcC/JDR8pxn2Uj/eh+86rBkHRTaHFM7wNAmh9GRMSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZjJp8SMyydlo08ICRNBcQJwhrYUINCuwNnEpYcOhaM=;
 b=U23lxMmYLZTLt/zsGEmMGJrnlvSXR8CkmqEZ1KQ2Vp5bQdD1tHO0w2hKt0HnYZGOLqhCMfNIyZZsm2duxU3e5vuzJdYvibnk34aLfKYTTA1YfOiTmLik/NFvNQDwYmwlz8/eABkPM2FCJXrxAdB3qVfO9DyIj6RP+/RkySs41Jg=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 14:32:25 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 14:32:25 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next] bpf: use -Wno-address-of-packed-member when building with GCC
Date: Tue, 30 Jan 2024 15:32:20 +0100
Message-Id: <20240130143220.15258-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 748fa2c0-2719-4901-a4c8-08dc21a04700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yudgWhgD5mHd0BF53T14iKglBMOWfS+MzDMlgf/LPQxVc2zQNSwB6n9vwPtuQZgQtl6ilWbCeHAb85bnZX5YbsC/wjB648uZmALQQmrqCTL33epy6YyB6w1+BMj6dEPiD9irhNkW5iKli5WMvvhCtcs9ridWRnyhu8w2eblJJagiyNI8YAgit2jyS2R1SHBF89myvB4D9OlKrpTZMG3FI9BEzTJJiriNqL83OqTX4U5Q+FSasfJKgv3POvuocyEW31PebXDxPRUA/JuarIKKtDXiCa6yek32naZSUWnsqAzURy4w32uoU49KUs0keWoih6hlOVyRuqxCrC8i2ndH4v7yqk0M2rIyPZNKrTeA9gilkjg+cP49TyribfRq1VS6CipGRYu5uWqCPNYR5nm5JGswZs4kYKyTHwguhf/Ii8X3NUp+Eii97bbs/AADss9dmVUymaKOp2yvXSfOSZibkqYYIrXOwVNVjOY8TSr72neyPQ85TDSlAGRvcWc4W9ZZgm6zq6esuP740HH5N/fDmRfVPJcfTXUI37dEygkEobNeh7/PmIzUdY0tciDdSXhMH0TtzFPycsss7nqHFNe/JWA3BTHBZJOk/wiUsagahRfMAO0znybXYZkIWn7O9c77
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2906002)(36756003)(41300700001)(54906003)(6916009)(86362001)(316002)(66556008)(66946007)(6666004)(66476007)(1076003)(107886003)(2616005)(6506007)(26005)(6512007)(478600001)(83380400001)(6486002)(8936002)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bNh8fP/SGOF5Bfy8z9ONG33qTnZgJi43lKWeAc6YO5DnfTUAAu4CkCDbHkPy?=
 =?us-ascii?Q?jCEggC4CAgCl4/+CvsS/jJZyo8P3jvs+GXpWwIomKU4k0C7TKbhIA04cqP8/?=
 =?us-ascii?Q?8gctczeSP8kHvnhSj5ztX1qDwmEMg8nClOLGgU2gJj813qX663fB1fA4El55?=
 =?us-ascii?Q?Dfi5ByNgw+aaAPA/FehV6dmUvXpCUT24+zgCW4Ie2Xen4DclQ1UL3PL5EOy+?=
 =?us-ascii?Q?JiYuNZzZhDia+M18XbrIRDc4IE8j4sWQcXLfPEhfBJaMAdEbxGSjTPmZ8IjX?=
 =?us-ascii?Q?l4A+vdyPBgi+8jGQU2nmoi8m6hg2gUTZLHNCg//Y1dvVdN9uKiO+gaCyHYrL?=
 =?us-ascii?Q?lzGp7HoGor8PdgFA43T0HwEqAFpgIHPhkc69/sc/RXZ2OyDF/RNxnbXt9hZ+?=
 =?us-ascii?Q?PnyFCYy6SMYKymfZjljk8NZk0gpEXLuyN1Ixly2vF/KBl4qrQgCiw9936+s6?=
 =?us-ascii?Q?Bh/mnlmsW3srj0Q58+qnO2nRwJlrcJmvbQ39MrG8tRWrZvSOA89Zht4gAUmJ?=
 =?us-ascii?Q?f4iw5JrjIgTOUF6wlUsbuOaNT1h3aC4AIX3q4R5yaFvDhPM4vZgmuGJonW+K?=
 =?us-ascii?Q?GO80AivdWxW3Lb562nYZdONbTQl5cscH3w18nwFIoD34qNuf3uUlnPO8INQs?=
 =?us-ascii?Q?Malm7Z/yYNn/H4Lby5atA92sjIynrLr/cWZbGtzFAHUTR+QKomVviqtmeaPx?=
 =?us-ascii?Q?L49sEzsjH7YYB3Tl1EWH+Fzkr436HfUj3RJql1cIlcJ0K2ws9PCqbAMa2Tnv?=
 =?us-ascii?Q?y6/gMJp4qKElfZoi7EeB98/I/vUteX6UcrOHOpWPNVtoFxI0I7Q9RrVOvlCn?=
 =?us-ascii?Q?Hh9NRtTCXaBA2SZwfaV6aGSD4tTd4LR31x7HqAYDwdYrBQUNyuWE7nFg+g9N?=
 =?us-ascii?Q?PqZOTTn78WvRMonn2VBFF1844x1Eku7JanWG3z4Yx/RFg4H8OVQ8ga0ExHC+?=
 =?us-ascii?Q?LW0UroGq2g2C2MjtuOT7B3Jv8FCiU4ee0BUWSQKNq4jHCtLTFswtWDAkL8XU?=
 =?us-ascii?Q?SY8boq/ioVwAIHrGZaqRZKZJBL7jPYNv7/Fegfwx6XCvgnkvLN/orX+LAOaO?=
 =?us-ascii?Q?yFJvMTZGS56zsykRj5suXtKfe+nJleojcXJzvtQOinE+0990u5W+jaq1lN3z?=
 =?us-ascii?Q?7BzUcUdHdEGIkDLfgotF6apsz8WO4IoYzIytVBHtL8wW69OdBP+2IAkfvqik?=
 =?us-ascii?Q?m3eebkZVMFxQZ5Zf3wKDUkUX/VCIrYm3CuYaEhLKC57fZmtd70VNcuOKMffH?=
 =?us-ascii?Q?2c/TaT1TUOVh5Zg6opJ4jk1DMnah6ZTGPleBUdL12yt2QvSo0taMVgvdLP6J?=
 =?us-ascii?Q?oSV+caC9/ARRphNFLjKyrHkAbwDemUi5iUTWGnzZGm6tqaoWLaqFtFKrkRUn?=
 =?us-ascii?Q?TNffVaHuvkWjrXAII2eSCul42XHTLXLlnazIZHerUD5ay1knREIPTa+C5qfB?=
 =?us-ascii?Q?6U2s+WSZy+Lmu1YC3wsn+RRqELjANbYyi8zl1LTNwPP07CyZFwHaLhf8bblm?=
 =?us-ascii?Q?TmgjNGIHBczF4K81vmji5q0I+D1t+1bQyPQV1obc//2lIZdGM+I0XUnzS6Sy?=
 =?us-ascii?Q?SoUttu9CgZwr6mFybdGig2vvTIODzG2jGcGoaf9ixRitMwe16knLMwulTtQd?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fGhqh0A9+GP/Yg/6vvv2lHcWwxQ/dkUfurVNSdcxJ0bx0AZCtfXDLcI0Ib12rXwindtmLW7Dh/bQdfMPle9mjPucezIL7/awA6f8V1RcOY9ICc2CHr8Svt0T7oniwPu9vN1+a7IO2owVnIbg2L/puNBMsiApqE7CACmPCVY7v3kI12nQyCPdvbUeAd2mpp1IEOKkO3SNle3hPNYyVLt6KbqvCMXedmBkQpi7pTWylOG3EYRmv7YNCwjHwns68K9heX4t35kibFY8tO3v/8udRFL4EHst9S4Ob1brnuigtZXBf6M5R/5uYbn+OIyiefHA6DvxqFSzKmsvMmymxie6a0VV24aUmpyaj6uTdQGTwPAT8YXv4S3WvaPrilrpo9GVB5FLFKdvVoGJk3x1kwTlvX4XdZMoQwWAxOdCK381bA5ZeEmdG4TahPRYqMdq5D7DWrxlayqY+6TGvDxCRvWHBSYDDCNd1ZhMWd1/KzxWi4yZZJcfJ/7E4fxSXkqJ6Pj/XM+QNNUAmOFIrmU8wvdXjdsAoUZvjoyE1QT4H88DHJk49c10QYkgIvN1EdhIKDOAu/gTVS1X4V0oK8QAdITZgD35HdvOXPeLATWEfIlGLc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748fa2c0-2719-4901-a4c8-08dc21a04700
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:32:25.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXjao35jDiAM5sfNCeYMGdFD5Sc3FDoaUqSsEzh7AC5SysEo20tP9/4VT7YxwS1s+ELLeybwL9nNLQlV2zMQjCuMwiJ/sjoU2IuDSTrk31o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300106
X-Proofpoint-GUID: C3Jrz5RD45q0FA8u_eHbEDJJnMgT6SXm
X-Proofpoint-ORIG-GUID: C3Jrz5RD45q0FA8u_eHbEDJJnMgT6SXm

GCC implements the -Wno-address-of-packed-member warning, which is
enabled by -Wall, that warns about taking the address of a packed
struct field when it can lead to an "unaligned" address.  Clang
doesn't support this warning.

This triggers the following errors (-Werror) when building three
particular BPF selftests with GCC:

  progs/test_cls_redirect.c
  986 |         if (ipv4_is_fragment((void *)&encap->ip)) {
  progs/test_cls_redirect_dynptr.c
  410 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_cls_redirect.c
  521 |         pkt_ipv4_checksum((void *)&encap_gre->ip);
  progs/test_tc_tunnel.c
   232 |         set_ipv4_csum((void *)&h_outer.ip);

These warnings do not signal any real problem in the tests as far as I
can see.

This patch modifies selftests/bpf/Makefile to build these particular
selftests with -Wno-address-of-packed-member when bpf-gcc is used.
Note that we cannot use diagnostics pragmas (which are generally
preferred if I understood properly in a recent BPF office hours)
because Clang doesn't support these warnings.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1a3654bcb5dd..036473060bae 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -73,6 +73,12 @@ progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
 progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
 progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
 progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
+
+# The following selftests take the address of packed struct fields in
+# a way that can lead to unaligned addresses.  GCC warns about this.
+progs/test_cls_redirect.c-CFLAGS := -Wno-address-of-packed-member
+progs/test_cls_redirect_dynpr.c-CFLAGS := -Wno-address-of-packed-member
+progs/test_tc_tunnel.c-CFLAGS := -Wno-address-of-packed-member
 endif
 
 ifneq ($(CLANG_CPUV4),)
-- 
2.30.2


