Return-Path: <bpf+bounces-27043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B068A831D
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6392822F6
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1913E419;
	Wed, 17 Apr 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWGCEKMv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DrA5imPI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B013D2AB
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356702; cv=fail; b=kNXPU/7FPW915EZH5NZGwoPLI2gPPULjamt1ws1vo0CufUQXUbNdJZ+mruTBoa+MDFX62QSwkhbw2d7L1ouvZsJHWUMXJRacg4l5+pm6MjDOTWuZ/z7VNzzyoYVGztiTcX/a0qWrtGrjeeaGpJ/qTHl+2DfI6vgfvXnZmJ1n2JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356702; c=relaxed/simple;
	bh=LNNEcxMgiofbuj90IxDJO8EQX+GGPtMdpIUAINiLb94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4CMtNUFtgmwyhMJH6fbS3BM5mXUiGDTHc/a6B0QZ8+PP/BszrDnlFo+PlCnYUjTAoAl5kDbDJ/O37ty/TPzZkWE4uxKwTfPFB8mS7Q1ZebVkyYCVysdd/HPYHn+aa60xDrA/h7SxSK/sTQ7bhx0iFtIA2oypJlCXGJY1uJhmIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWGCEKMv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DrA5imPI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xpfl021226;
	Wed, 17 Apr 2024 12:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=PaxhIippKWAtkkfsm/cyuIt4IQv0QNaDCkzcdbf35Xg=;
 b=cWGCEKMvSi5j0uXnkPCPq/hId2fnE4Yno35T9UGQEGaNQfQJBXZ0ipnRNaV1I7mUhNK7
 K41oG9knV9wadVo3ago6a5C7tKUiLwSbS+XEXkjiT/ULi8fxpq0WKRDTFWZq+V7Bq+43
 kcKxyYn/evUQQ7bke7i3ioEPqoM2X5TUB1VztjxOZs8hAsUFOEipIaR2Xn72rR+GiNoL
 IAOhD6zRQtlD+hGsrTpUgY36EkMKlUWnJBwnPo1bOI8SqCI2zP3bbmKoDmTuGavr+m/U
 lQOy3ERoK3fJikZ0tf0QVC8KjOWv6C9Fuw50d72iG5EfFJUI0WiQbdEXIuyeA5Fuip8W Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycqq8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HCFmNp021707;
	Wed, 17 Apr 2024 12:24:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggf188q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkz9kq+cY+2oq2BW/YyUqsGjZZ+zb66otUophNu0Amr6fU+msYGSjXUCg1Zzgbx7DiqigeJhSTWJDY/pacULWWIkOfXvkMBPxl52Ptk3VgUNqQZP26xDYILtAUD5VLFEkc/XNa2Y5BvEI2Qef5DMPeGK3rFzY1N0ZZG2RMvxB6iOEmkT4WLlcyMfEqNQeYCUg8NdJgsQZVlNw1iv0b6jKWJi4IvWmCRmFAbyiu3rtmdlIU25QQU1rbrcjNbpOqYG3+yRZbII9Jw6Zyg3dNu0YTZlGwrnqqmsBWJ1kOV03IamYKiNXqZ4H3O+Q29g9SQ44IQ8SgRTZJcOwet3ApXJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaxhIippKWAtkkfsm/cyuIt4IQv0QNaDCkzcdbf35Xg=;
 b=giawJ83BD/FcwlPHegoo42Ncgr3mrORViTEGRAlTuYSLc3CX8ZN9nGrNnpYdisdM+o+n0vzIrJ81qyaqbSB0xKv5Ud8bOxqKSVUDl0IONksOREOpSq2bTLfmzdRO6JrGtOShbZTK9q2O4DyuuOgxtPsfFqmUc/UrqKR3Oyb0umUnSfKDbJ6ZaAKnPYVnLj92WmvI3/dlNZhZBkDRK7+xIkhkgAj+BAlG+7YJOZxstrRiAn9BDTTZxnvsPIQeNEtTUIqeeLx/Xa5dzFfLDD9asv9z2YYBKuSJnyOekyZK1dKSvXsw1spyisMMNNn401rGPewySA3//Xen5/9rnTvkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaxhIippKWAtkkfsm/cyuIt4IQv0QNaDCkzcdbf35Xg=;
 b=DrA5imPI9OQyVwXOj8pcVNP4p/Skzs8OMh2ynV66ClPnOonT0eLFxJiQxf7RhE+aI0KPiFJTbZo0wj/mLWxVTTPunsjQ/L7CjhPJv2Z7FkLKGKzM5gnruoe1a2qxas8W4v8baOeuoNaWYWH5v9NPCSW63747ENMEhpKJFg+9/5U=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:24:54 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:54 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 4/5] bpf/verifier: relax MUL range computation check
Date: Wed, 17 Apr 2024 13:23:40 +0100
Message-Id: <20240417122341.331524-5-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417122341.331524-1-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c336d7-b058-436f-cbbf-08dc5ed962e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uHAQPxqfP9wImsCJtvjgOH80OlDKypFYjC/ZbEwiC7VAPdilRBaq9GAYXhF5kii+9ezm85P5SQLWG4mjF3ixsJYyW4grTDlhbPKtiQBPkMb00nLG2d0rVcelPFUVhlZsxbToSdunicVkDBJMu0e2pF3gL2RU67ngk2cWmpVSGS2fBQiWKe9mEgGiiQZLjCnPCUukoFecUu0uxkT7+z2SKRm8P1cEQ0kzFY6N9USsY9DP3+80hWtUxbr3L1lkvq8+YCJDtfrcofOIx3tWqIOLJfNY3JxHij8sqTDNpnvgnVPkQzwYdOGuDkNoxw5TWbZeatvBNLwPto2ij8lXOBW4juqisL2qWHeBD45Qgzh9LBqrIX94q+p9u6MsGu1w8yuZpLOYtQd0aL6q7g2iTrvF3GriATPbaqcGE66sSRRmOsE9cCqnFucZZFFhA+BX9/YGe1kpC7rJ4BXID/CB4C6ux6POiX6hzHrcpj3ftj5SwcOmID1PFlhAElwsat1rb+nZMb2SaaWrBuPHNY2WI+lwbxchQ/SYX+z4gyAOmer8EJ0DIExCt6woIcByVdTRL/Ya2GMD69EB2BPp2GfWJVLqBwl4nKlS+n9J+TFE+kW0mQGuIOj8YrZw3qVAKNNeBX3yjWc+AHKwaOBRJUt66+xum03z5TIne64YOR2Q8gm0WT4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qv0EXT1CcLxEYFjrAq7AjDRiyY630Mf9lcKPlS3U5rY19d9BKInz7Yza+ffO?=
 =?us-ascii?Q?x0bvB6ZDr5u5tQ7fIQKK6gu0k1++4Qr8LpnIPjfNW1Hzr3Dk3Q9GFRSrR/9u?=
 =?us-ascii?Q?K8AJVU4zEp0o1LmsHzReXlrFrn20qUQH5qofA8Siypn0nmq81NGgcU4W2QXT?=
 =?us-ascii?Q?gPEpaBb/iArQGq1EyaLHnA8JPs0obxG1XbbaGdZ7JpppmZnyx0jcOD4A8MNK?=
 =?us-ascii?Q?C9pZMKdz+Jikn56J0Ym3zN3+oMDUA1lolwvOkwP7ok6vn5rm/fD9bap/O5i/?=
 =?us-ascii?Q?pWEn5vbgXkFyJ6rcDUlU8roddWyGWhJQ1bchfyn7uADoMvnE3mj3Ycx9ISkF?=
 =?us-ascii?Q?QDWriY78UAKe1o/1oiZMMN2so4jjem3GIrEPq7RD805NY+dB+ILHB7h+GD3x?=
 =?us-ascii?Q?YMSqp+yKgOfgYYa+3Qyg7BbQj8/bGXDF1M3cyrqPVdm4p37geyIDLt2G8nnJ?=
 =?us-ascii?Q?h41AprWh0/iZ3YnHH9kbqq0x9zdOWfzMhoM6+LuK9sFaZcr3LtC+yd3QXP6+?=
 =?us-ascii?Q?SE/iPJBwYjhJV2vkhdcR3RuRIuTR6rvYw324jSkIFb8wrU4VrHgsMb3Xd0R3?=
 =?us-ascii?Q?gjQ2nXkxneKwbSNCDBBzcJUszciMogVHnEFaK/SbJ8HR3LPl12GZWs6udFPF?=
 =?us-ascii?Q?r/ySxmrZwyS/Hjr/ol1oDIwct+Z6jvZDHOU26Ked/GtJBhns/6kbepL8WLZB?=
 =?us-ascii?Q?/T3GjVB7ndq9jzO//P71z7/JqmJiIU4zLBQU91UDpX0WxeaQuV8q4J+tH3ix?=
 =?us-ascii?Q?sE7gc/4IBzWXYRJpouldgfBlPmOceU+6VgMUcpTWSJJ94wvuhZ+2jGlKuwix?=
 =?us-ascii?Q?mENKBixyvpdxnV6Tl9waVnMwjMSulMm3uLVYP2T3aUvxfhY3Cf19fu0+ZPtx?=
 =?us-ascii?Q?4snMRR/s05vDsQ5glD0ID0lDVU7i504CB8lxFsgbLxBP6mT3/TYU/deFLz/y?=
 =?us-ascii?Q?NdAkyx35BquGt9WKITH0CszDyNIVh6wjMavTjhfzyn0D7yXWTV8pVfeT92p+?=
 =?us-ascii?Q?OY0BmftgGpp02EwUecisl/jxsLl9kwyuLfJ6JfkiVS4Bh9l78DpquuiiT4mz?=
 =?us-ascii?Q?Bq3g/jgl+Epe+Nocnj5zwhkNYcaZMRwFQs76aHd021DYGj1oYRgZL87WJPXy?=
 =?us-ascii?Q?NC8ddLC/6nTpTzTPLqTdFWNDWsZd5nDg2ckkAKmgkehHkdUQcLymJCwKMAGq?=
 =?us-ascii?Q?KLc+QmiKg407ymW8Y4mCnRqoIRiNVL5yUrC2FEOkFaVz1hgOxffJco9ETuUF?=
 =?us-ascii?Q?gW+MCOl17l1faM93zURuVCwohqW6LLpUqifEz9gcQNbyc14zeK1CeVjwbbQq?=
 =?us-ascii?Q?8YxUXVBcy5hLn7uRJoHpLYTp788dv0bRuEiSa2p/s9h9raR1ZVy7K5XJa61D?=
 =?us-ascii?Q?DlVfrG+UThqCJ/45mKqVyMbgB94baJqiSnhHzpl/eCIGG6HVBp2FxErWSUy/?=
 =?us-ascii?Q?Wn6Qn6VXWmeFXWho8k/uoMdvOM9kDcpeIT4FDbVAUZgEMJs0Hp0+G1KsWVbR?=
 =?us-ascii?Q?Ha6poEKxL6/nqbscvwr4PAbbZphiN2zCDxpPBJmjLja/ymAiG3GE72fyneWC?=
 =?us-ascii?Q?vZNe4/QPtLz6saCvL+6eip3NNLq02vGz/CiCn0juRLEW9MzdGdPL8UKyiFHu?=
 =?us-ascii?Q?L6Di56aYh6T3hzRy21D2Sjs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n50+bMLE682tapO3tpnvaML6NVFh8e7sRdNi8OensY3j9e69b18jI+LmFYFCDKmbDtZOPsUkjN1zKm0FNQHhs6w+QyAjHsSLFAvTMaynw94eJ9nNcIBA3j126N5KlCjJEmtO+xghDy01LgZBb5ZGB6+gfDrq2Pq8K70itTZxv6GGP5UW9RFR7nCQz9uUKMK3ecDZxAeViUmqijq1m/c+urptPcab2KFhzrcLHhj/DmVxeodZ8qPadXO71tfTSfQZsNIgkk9kbZOJ0QPUn8lziSh6UU0c1Pj2B486popMIBnmDvGv66qHmlvEC8kOBP5RcLSE9WtlYwkWTxfj4ZkOmgf84l0wKkmjqSetV7RLi77wW9MHs8yCKvTKgar3qFWJuliM1E6K4aDf98DXZk0RpzgrLAlRKyvXiQszihWc2V1cxz+XlnKaAw3QCbnlpsTLtUrQo5XsTJ4K+Qu8XK4KJHbUH1hTAtwPEgEVb5bh/rIVvNupAmncMHtm5w+HT49GYIf0vuwuM0f78KH4yKNfAyt+udad4GOiq+T3RpW+wGrRvCSK+ekTdq8mMSfZwJMMAs+HKm72SPPmbmXIIbiXDshYLeISNLcJbLF/lmuROZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c336d7-b058-436f-cbbf-08dc5ed962e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:54.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7FM3t9smnuL03t2uKgD+hM2BYnUWJz2VcnZcwL8qi91Q3hq1UY2tqBY/dc9eDDYFD4ckhdnpYy+MVSBHcLnPvaEVGoDm6n/W6MJkdOZx0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170085
X-Proofpoint-ORIG-GUID: uDl4TPgnrBlt0H0AWfHtP_WUignamxiq
X-Proofpoint-GUID: uDl4TPgnrBlt0H0AWfHtP_WUignamxiq

MUL instruction required that src_reg would be a known value (i.e.
src_reg would be a const value). The condition in this case can be
relaxed, since multiplication is a cummutative operator and the range
computation is still valid if at least one of its registers is known.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f410eb027e25..185ea7f19a79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13433,20 +13433,23 @@ enum {
 };
 
 static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
+					    struct bpf_reg_state dst_reg,
 					    struct bpf_reg_state src_reg)
 {
-	bool src_known;
+	bool src_known, dst_known;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	u8 opcode = BPF_OP(insn->code);
 
-	bool valid_known = true;
-	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
+	bool valid_known_src = true;
+	bool valid_known_dst = true;
+	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known_src);
+	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known_dst);
 
 	/* Taint dst register if offset had invalid bounds
 	 * derived from e.g. dead branches.
 	 */
-	if (valid_known == false)
+	if (valid_known_src == false)
 		return UNCOMPUTABLE_RANGE;
 
 	switch (opcode) {
@@ -13457,10 +13460,12 @@ static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_OR:
 		return COMPUTABLE_RANGE;
 
-	/* Compute range for the following only if the src_reg is known.
+	/* Compute range for MUL if at least one of its registers is known.
 	 */
 	case BPF_MUL:
-		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
+		if (src_known || (dst_known && valid_known_dst))
+			return COMPUTABLE_RANGE;
+		break;
 
 	/* Shift operators range is only computable if shift dimension operand
 	 * is known. Also, shifts greater than 31 or 63 are undefined. This
@@ -13493,7 +13498,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	int is_safe = is_safe_to_compute_dst_reg_range(insn, src_reg);
+	int is_safe = is_safe_to_compute_dst_reg_range(insn, *dst_reg, src_reg);
 	switch (is_safe) {
 	case UNCOMPUTABLE_RANGE:
 		__mark_reg_unknown(env, dst_reg);
-- 
2.39.2


