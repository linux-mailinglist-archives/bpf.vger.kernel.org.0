Return-Path: <bpf+bounces-21863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D622F853865
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075951C264AD
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8513605D0;
	Tue, 13 Feb 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vdxw1l8k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oz790ZHR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28778605B5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845762; cv=fail; b=V7AQtvE9yNzrPdLMqZKD7/oyKtXG7Zs1pCh9aSVkzW7xyP+yzfYryJvGO0bQ2w8E7ebJIsvxQ7+SmaGzF+vv8eOJiq8f/Y8LDJLJWdXN4MXYxpHA88YPvgOC54dBf5dMDnJSziRqckcCotbNXMO2P8DJzcM28JMMFOT4IIqPxBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845762; c=relaxed/simple;
	bh=Df/8tRmrF9fc1dLOMzz7l6C5/rBTc43A1uoeW3/6SZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cM3jswp41JKyyM6vNi3sd/+tyJoHmnQeqnNH+Gcrfc4jnaZsQHQe7oys71357+AybeP+MDny0p4pO6rlD2u027RzY4A9SK1uBakHhKIShctGpi1YBpGrBEqKjKj2zr7thrTLeS8AbDdzrTzupesJe516KKUmzfkTjegTU+Gy1ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vdxw1l8k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oz790ZHR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DHYs2U009554;
	Tue, 13 Feb 2024 17:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=TGVs3fu94LV/T+ZKo3+kr5Yijpv2NykdXis4Bx9wHrQ=;
 b=Vdxw1l8kXWLW1HvONLG1Sxzi6waxRP82TeQ6y3nhG7HOaHLzE70Of7SpERT7T3rAq1Re
 5D8FenrWjZozQ40yjI2cMR2w5EQlO7pwkYKKhT/fkFSAi2W5gESVPRpMIfoZdjqxtwh+
 ERrS7gMDrkkVoz+AQyxGCPJhR+ykZxn/91vHRu5gvhu9JP4viyuAR5Rv1q61e/7nFOrc
 2a3sSFX60SYNWuagjgR0DaqtC+PT+NqZbz3RT8PLFuYCs/tuE0PL399z2hGo7CsdDDT0
 LmDVIp1dZdOeqHO/keQwBNfvaTzqA6pJVYvJR6TR2wImo1KfWsgToubnN/uk1H3jjxdf MQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8cxr8016-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:35:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGqW9O031484;
	Tue, 13 Feb 2024 17:35:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7p6xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgI8lEdNkwUPzzVkidU9+OLoQIKCBPeVrty++u83dV1jKloTh4lJUcgZc7dJFGvl7FuKmcrDnBEsMCYSw7KlQSkb6VMIlvVxazA2yhxeovmTy/mucpVTlr80/Dg+Dxrpb4kLh9Nbz5wCBBstW6pT149RjBuKTfCLeUnioGcBEN09675KmfLYP7/NsrHKtbTquMehT8nmGYC6t/YofeFgR3+yMkHCJ2S1qfE1g+f1FpuSnvtOIshbahDOR+B+knMBfUNqZh1oZwpL7FcxQhmtHCGEkoJOCe2UT4IfQhgs1EselRt42x8WQCx7kadWqL4dVxedQ6+qnO4uYQv0FstQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGVs3fu94LV/T+ZKo3+kr5Yijpv2NykdXis4Bx9wHrQ=;
 b=OLZTJ4qJAIQr2X6vEokX47vtiulOZh2FI8NPS0eNv2klmSDPFJf+LYWYLJpEKlnMtbz5vNunUMwO+er7TaU35lsxnaHBOYFQvbFlNGOohKoAoS0EVsPWv/E8MeImQvf4ogpX2/w+mAn4zwWOA78/STGtXZrIumblkjGoYXXgH3wi0KdkM6VNZr9B/f+lp+f+ecIixg2mKJTowDWbHs87POPHp04NKuQBNkrHNV7fv8V0+TI+jMUOBiyJfGIs+SM1hCub4sBAp3hQZXeHSLHxAJnr/HCSSe5Zsb1RC/hcvm6lpR3SB2+HLxEih1ySdfOa4FkUbOYQwap0lDVkTqVWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGVs3fu94LV/T+ZKo3+kr5Yijpv2NykdXis4Bx9wHrQ=;
 b=oz790ZHRsGGqCDjf7MaFO9see3nBD2E8is1pzRXLvbP9LoGr0H1ZS04pPh1jNPUhXbGChmA4TbYnX+0zlEDxYy+00lWrJN0p2nHuE1f0aD5BsM9Y1XsBnwv4rHuC8nq/6ilk0rFlx3st4VTzh8C897mg5Gxr/F8ldYMNiCYh1OE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 17:35:52 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8de3:eccb:9288:95d0]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8de3:eccb:9288:95d0%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 17:35:50 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com,
        alexei.starovoitov@gmail.com, david.faust@oracle.com,
        jose.marchesi@oracle.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH v2 bpf-next] libbpf: add support to GCC in CORE macro definitions
Date: Tue, 13 Feb 2024 17:35:43 +0000
Message-Id: <20240213173543.1397708-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aacf3a-b965-42e5-e3ec-08dc2cba38b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6ZRMvtC/GXm0ZzdB95fp1HhdJzDdyUWXq61d8H3E+rldCNiEwOwf2Acyh+8HMVq0v5mXzUCfliSnWXW9VNbfA32tgmasDleigGq+BHElFq29xMl4l6uNnGtC7NAkobcpq1M5EUlCT3JVIssG9ufialthkqlFtnT1T8FI/+zTW4i+123Ndg+Es6hysoPI0BgVw5/DtuXbWPKqoHOvK3PXaVly5Qe6BlhSuOb3s4sgZZl/N7sydRi0DfYvTkdg5ykpO8n9QRLx6PSZ5Q3F/FpFrBlQJXvc7fAu71Ts/YyVgjj5WbNI49GpfLVeYZtq16jHXrlohasSMksCrJDZIncPu02Y0JCFNolsLyD/ZmSawNSSrvPqLb4DVzAFa9BiBHZitueVWv52aG5LG9Xw0rF/fqZ3e/VzJ8Ila4Yxk3HJzAFHIt7d6EufOsa7FympkW/uVwiaXUVRYtHuGgrSOxcLlSKyRuVU2qWDY0qZrSEsgnDS9U0G2iS1p2E4v2yKeK1A8RPTo2hns31orw2GXA1kYkabkvzD0knFzXcRyp5nwYbOFAQCqhndyV6d+2lv5o1+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(6506007)(6512007)(2906002)(36756003)(44832011)(66946007)(86362001)(66556008)(6916009)(38100700002)(1076003)(478600001)(6666004)(66476007)(4326008)(83380400001)(107886003)(5660300002)(316002)(8676002)(8936002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hN9fKJejkbVUHGpt08jrxH4juuyY3tPZLSHs+zFAPqFS7v9v1siWg06k7EB/?=
 =?us-ascii?Q?rTiqw2UKRa/g+elGsqvaC1meF7TehJexrOkhiDtcCO3f8lNCZZJEC5kZv+4Q?=
 =?us-ascii?Q?2slxPczHpoQr9yc+70O00SDX+ja3znV2rT4Cv7FwQnrBzS9nctEsNwBa4Kk+?=
 =?us-ascii?Q?Q+OxPDUvhQ/dZDmed6icP4PFzh0RMNevzz59HCssLlx565cLe0cS/nvRvAtN?=
 =?us-ascii?Q?0lQfpyB8fIjjTaVMHm96eqAw4Vsit68K7qrix566a2ODVsrBe8MukajcJz3J?=
 =?us-ascii?Q?pV5B9kOGmKSLqCxE67oe/ATVpI2/N4whiEytGQIQxI+0XmifAkMgo+LWwH4h?=
 =?us-ascii?Q?+Uz+nj8FYvJ9vi2xQ2c95wbEIVdwDnLY1HB5385J0gEPI3s/AyhH5cOFKGlQ?=
 =?us-ascii?Q?25qBMX6H7VtZJTR6+ZRVWXMImGvghp67FDCMV+plPw06FY7A6s3J0pCUe8om?=
 =?us-ascii?Q?JCLhFPOb4TC0yWSaAwzmV/VEZPcxfIwNN0eT7cCKk3r7HTzl+AP+5VGc3Fbv?=
 =?us-ascii?Q?dRBEtno+86t6dFvFL7nX01RNo0krdVvvPkPSscS7WTYozHYyxQ2SNHPHf6/r?=
 =?us-ascii?Q?6gCzX/GDD9aIM5O3iWh/KNULoDMrSDl+qGJhNI+ziXD+qHcI5DEHNu3d+n9s?=
 =?us-ascii?Q?DGZCb8GCGxvcEL2V2OU2LaGcpYEABx+KcoxF3deEFkh21qDmhUZRM/1S9O11?=
 =?us-ascii?Q?l++vDrxwHWMHDx+MMwT1cbsnN/tpPFhGJR87MhyCOHB50PT6peFFovp23wVW?=
 =?us-ascii?Q?5FPhQAyn9iWbmlhZqaD4T5GC2nbzrzVaAf6WRES38s46RAuyc/GMYfUOS7Vs?=
 =?us-ascii?Q?+mYlCMLQJjT1MIx31eyTprDEuF+HSayxnk3sbYDES7texeCiECZvCCCygR35?=
 =?us-ascii?Q?Y2IkCBWh1wps8QuiekdUbzQP49Qam03e6IFMQfFEDmbMfs3bLot8PbM2f8qw?=
 =?us-ascii?Q?7M8b3CS9YwO2rr+naM7Q8qSIYvYLpjWka4lRFTWLh7UtEivgbCP5vZu/czsk?=
 =?us-ascii?Q?AhI+GLXNVUGrNQs4vwPwqcsKQpe22rcH3xgqjcwYQuBgGRK8Zn/l76242nrY?=
 =?us-ascii?Q?7zzMY5TeEA1QWx9zmki+2Hll8aiWx4VB34eLafxMhRUjUo2BYEHkEqUew2yH?=
 =?us-ascii?Q?zSd9+ZPIHjT6XlXhBgOFO0c7CPxkLop6tXVmX0TLGep5VAAkmNze/r5/ipXP?=
 =?us-ascii?Q?YPamFM2mBEVBMqK6VCjX3eF9mmEdIELOipt33wV7aNyaeSeNglni7NvKHQ5Y?=
 =?us-ascii?Q?CSxWsRcL873gRkwGPm4fDISbJDcynS7T0LG4F45k03hPtpHBnSGfJ9AIN5EG?=
 =?us-ascii?Q?PmcJgABEpZCLdDsRsakgePfrOoJj9U6W4BP8Eqk1cpdPxSgjIh/9feZ2EuY7?=
 =?us-ascii?Q?l+KKjZwMwiv6D1976xfx1i7aIVuAYcnNJ8TA1sXlqGmOigJfq8+IVOuJKp5n?=
 =?us-ascii?Q?+t5DwWH9KTZ/t3cV+Umg1OARJk1NKsyvL8itjhvOTMhOYH2Cl62wx+EUBP8s?=
 =?us-ascii?Q?GRV0TesGQKw5W1DBZRmJp0yErL1tXHpCmQj/V4Fc6GBdZG++Rz/+2n/F2AYS?=
 =?us-ascii?Q?klr1uDLZ1LpUrLIFzSyv678csTiouWyWdiep8xxy/IlHNudGUlGEyogBzfoC?=
 =?us-ascii?Q?gpukpaIvZj8TgzUPuCAOGgA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Po0cw2y2SjVl3NfiTYR/qX/qkLrkrZj7d9u4uvjdGaPak6P1QIcPlnA1KKbkcc80VhOPZX8kNkT/WU7B8G+8Gl3Jhrta7GbQQcl5antEGLv7VRLRu3lZ9100JXi3L0NPB5GpbmLk9leYMkEL4K0GQqSX7VfB7nTvn/NBSI/h55mua9bAERm54WnuMy1VAs92Z2L+LOnVnBXC8kBgGZ5phmWEggppDrE3Js0CsavINPERB57GYGMY+YYaEw9DCukH2vncYujzMVHjHogH46KWXi7EYxCsl/Gy3mdSKYgXNsnkOyc8ENKcGloIIZihcYyrBmh+Ix411Z0l1E8jVzLRQ3TlQcw8469QrAIjJCX3KQQoVnM43Z0oynsIDnhuVYOWzRx0B9Bbykh5gAQ/KAn+QPqY/Lnt0f3Mi0nJJcvMCFSeG+GiyraRNaOrT3Pb3I8K1arrbEQBt8iOaPr3y3V6sKsHO5JnoLRWFo/3QPZo82b5R1TdAgByt+o2U4qakNiA6x0S1FUvWL3Sn6PBYAx6EN0/1nwL1JIg4tcGV0IIpUmFVV9bv8Okwhz6bEby3RITIWZPzPvLHsJX23/DEqwCIdXwJO+109z0WK7J3IX1wRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aacf3a-b965-42e5-e3ec-08dc2cba38b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:35:50.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjAhq9zRCQoIlM7kG8z0+OxVrZRN6AsQa9ZkXhmpNd4QvklRqqb8dJp7cS6bDUl9/4HSqLgOUv+q2YH8qUXEFiuoFM4N+QuikgYNUljXOVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130138
X-Proofpoint-GUID: Hm6-gRB1jUm9GX5gRBhhDlwUosiUGacP
X-Proofpoint-ORIG-GUID: Hm6-gRB1jUm9GX5gRBhhDlwUosiUGacP

Due to internal differences between LLVM and GCC the current
implementation for the CO-RE macros does not fit GCC parser, as it will
optimize those expressions even before those would be accessible by the
BPF backend.

As examples, the following would be optimized out with the original
definitions:
  - As enums are converted to their integer representation during
  parsing, the IR would not know how to distinguish an integer
  constant from an actual enum value.
  - Types need to be kept as temporary variables, as the existing type
  casts of the 0 address (as expanded for LLVM), are optimized away by
  the GCC C parser, never really reaching GCCs IR.

Although, the macros appear to add extra complexity, the expanded code
is removed from the compilation flow very early in the compilation
process, not really affecting the quality of the generated assembly.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/lib/bpf/bpf_core_read.h | 43 ++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 0d3e88bd7d5f..b548ceb28be4 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -81,6 +81,22 @@ enum bpf_enum_value_kind {
 	val;								      \
 })
 
+/* Differentiator between compilers builtin implementations. This is a
+ * requirement due to the compiler parsing differences where GCC optimizes
+ * early in parsing those constructs of type pointers to the builtin specific
+ * type, resulting in not being possible to collect the required type
+ * information in the builtin expansion.
+ */
+#ifdef __clang__
+#define ___bpf_typeof(type) ((typeof(type) *) 0)
+#else
+#define ___bpf_typeof1(type, NR) ({					\
+	extern typeof(type) *___concat(bpf_type_tmp_, NR);		\
+	___concat(bpf_type_tmp_, NR);					\
+})
+#define ___bpf_typeof(type) ___bpf_typeof1(type, __COUNTER__)
+#endif
+
 /*
  * Extract bitfield, identified by s->field, and return its value as u64.
  * This version of macro is using direct memory reads and should be used from
@@ -145,8 +161,13 @@ enum bpf_enum_value_kind {
 	}								\
 })
 
+#ifdef __clang__
 #define ___bpf_field_ref1(field)	(field)
-#define ___bpf_field_ref2(type, field)	(((typeof(type) *)0)->field)
+#define ___bpf_field_ref2(type, field)	(___bpf_typeof(type)->field)
+#else
+#define ___bpf_field_ref1(field)	(&(field))
+#define ___bpf_field_ref2(type, field)	(&(___bpf_typeof(type)->field))
+#endif
 #define ___bpf_field_ref(args...)					    \
 	___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
 
@@ -196,7 +217,7 @@ enum bpf_enum_value_kind {
  * BTF. Always succeeds.
  */
 #define bpf_core_type_id_local(type)					    \
-	__builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_LOCAL)
+	__builtin_btf_type_id(*___bpf_typeof(type), BPF_TYPE_ID_LOCAL)
 
 /*
  * Convenience macro to get BTF type ID of a target kernel's type that matches
@@ -206,7 +227,7 @@ enum bpf_enum_value_kind {
  *    - 0, if no matching type was found in a target kernel BTF.
  */
 #define bpf_core_type_id_kernel(type)					    \
-	__builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_TARGET)
+	__builtin_btf_type_id(*___bpf_typeof(type), BPF_TYPE_ID_TARGET)
 
 /*
  * Convenience macro to check that provided named type
@@ -216,7 +237,7 @@ enum bpf_enum_value_kind {
  *    0, if no matching type is found.
  */
 #define bpf_core_type_exists(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_EXISTS)
+	__builtin_preserve_type_info(*___bpf_typeof(type), BPF_TYPE_EXISTS)
 
 /*
  * Convenience macro to check that provided named type
@@ -226,7 +247,7 @@ enum bpf_enum_value_kind {
  *    0, if the type does not match any in the target kernel
  */
 #define bpf_core_type_matches(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_MATCHES)
+	__builtin_preserve_type_info(*___bpf_typeof(type), BPF_TYPE_MATCHES)
 
 /*
  * Convenience macro to get the byte size of a provided named type
@@ -236,7 +257,7 @@ enum bpf_enum_value_kind {
  *    0, if no matching type is found.
  */
 #define bpf_core_type_size(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_SIZE)
+	__builtin_preserve_type_info(*___bpf_typeof(type), BPF_TYPE_SIZE)
 
 /*
  * Convenience macro to check that provided enumerator value is defined in
@@ -246,8 +267,13 @@ enum bpf_enum_value_kind {
  *    kernel's BTF;
  *    0, if no matching enum and/or enum value within that enum is found.
  */
+#ifdef __clang__
 #define bpf_core_enum_value_exists(enum_type, enum_value)		    \
 	__builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_EXISTS)
+#else
+#define bpf_core_enum_value_exists(enum_type, enum_value)		    \
+	__builtin_preserve_enum_value(___bpf_typeof(enum_type), enum_value, BPF_ENUMVAL_EXISTS)
+#endif
 
 /*
  * Convenience macro to get the integer value of an enumerator value in
@@ -257,8 +283,13 @@ enum bpf_enum_value_kind {
  *    present in target kernel's BTF;
  *    0, if no matching enum and/or enum value within that enum is found.
  */
+#ifdef __clang__
 #define bpf_core_enum_value(enum_type, enum_value)			    \
 	__builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_VALUE)
+#else
+#define bpf_core_enum_value(enum_type, enum_value)			    \
+	__builtin_preserve_enum_value(___bpf_typeof(enum_type), enum_value, BPF_ENUMVAL_VALUE)
+#endif
 
 /*
  * bpf_core_read() abstracts away bpf_probe_read_kernel() call and captures
-- 
2.30.2


