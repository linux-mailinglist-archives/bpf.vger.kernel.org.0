Return-Path: <bpf+bounces-27041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B38A8314
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900B91C20FEA
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4613D293;
	Wed, 17 Apr 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lz9xqoRx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pSVKj4tk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6713CF87
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356689; cv=fail; b=jbcRPDrGUsgDdCpRyuJTQ+69u1e+aJ9Hy3YUE3qAgEgUEB3jq3lWMH+Rnj5XCvS5DX+B5wGPo1qSU8LeSn3rctG8dIcebJtXoXmC4UWhLS26MpuJMSrfhsx87oAVK6mWr4zPeBmWaWGWQSdpOBVOVWmfbKfBXnpsv1D4QfoPH7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356689; c=relaxed/simple;
	bh=sqS6NlN3urOpe1HS8o9m+Eo9bfXMDLhcHcXCK+hY8g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXE0I96YJ63Ir31Xvw9o0ip0vGAMrpy5JT51Hsp225GQYidtAJhntAyTUWU8PsbJwKhA2pwpRNBcHGOvFUzcUZE3DD0dKGqZnQ3MpmQvnyBn80KFZ+H6nk0C77q1amDPHXkB4TiZTcEeEtC7I0QBfuk5NiHS/V3UGakRkqr9rY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lz9xqoRx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pSVKj4tk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43H8xP1A012466;
	Wed, 17 Apr 2024 12:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=7hvYT3YFKQ+wZz/3hnHgcWUambsRF6MDudWjPxNwMBo=;
 b=Lz9xqoRxL7FaoqDmfER6wbw6ekVrMFrVbNSIXmIEyCTx/QgND519aZ3g4ZyVEbJ5EiHB
 tit7SLqxe/ADhqNuUA+eWMa5Y++Z8zcdwZiwsxDseBbzPIoU7mTxh5La1Su0AN/ZDrmY
 yPtLripGwBFZLn76XGlNrlCE2SyARQaikhUabQXuRyA854sYN+ikLfi/9CQ0yNOUr8ja
 0hNTQF4XBlg1pRL6ZoIyYW8M/MLw/dQXt9bWQ6gin8YNY+whea8x6wFFnmqnEfFAas/6
 3ucMKnfyR+e0b90BTQ7UX8AYNoval/Vtb0EH1vXmsbv7xxbC5yqXg/iibG7Is0H/aYXJ 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbqkbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HCMK65028673;
	Wed, 17 Apr 2024 12:24:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg8qp0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 12:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8L8/mipU8bGOBEugmnk43uxcxyVCg23NhYzWvtlZ25VOSjVFbuiis1QB+QP3LC+MtJz94td2p+coXVbjpo10xYNtrwFej2noFrqDOfOSHjzSgaXN1LerYVcF3wxSJZSA7ObrbFlJT8A7nmD2uvu4CqjWfULjNzSpcx9tmHKNcAlXqsqXa3Gy++cSQJcvIvKF6ys/Pe5ASFmpPHOI0m+74+g2YRILX8V1NBuOQXHkaLphCvT5joeqp0hr80c2/XfGyfnM1JTNeNwtwvkfItiwpaRtBxH3PIMYBu4OePmAH7zLLGPQRniNB1yyPpzHMGL1fymASq6OMM9aZKuMsvIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hvYT3YFKQ+wZz/3hnHgcWUambsRF6MDudWjPxNwMBo=;
 b=PAaVhnzvYOlXGeuF5QbETj7/ymlw3FF4PrIWbCzdsfvrFbfrqelZcRGXHpzO2dPFZi12ZcKnMD/l8/uwnLumG7ZeHR8lV/JQFy5eGxSdLhzRF4qVtPnZKNcKjaB7/UJDf/6w1K4UiVj/KFdE90BpJMYh1LCXs5Xw0VPSVNLwdCzMzKvGehMsrK6EXtaihp/KJ9C7aQjcAlEwr8NC7+0i4quzp2gvakrUKQW/pAcKvqnLaYau81IbKCDp9TZLgHOP56TV8w7A8SOfPrP+pgPSpRJ2G9ceufBJrHZ2OT9JGvtP+4KGdMWJHlOzBlq9yxoJZ0AWBAb37M15GxUfOY9ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hvYT3YFKQ+wZz/3hnHgcWUambsRF6MDudWjPxNwMBo=;
 b=pSVKj4tkXGDdtQ5HehCY5milPYUK4lxmPceHwFZ3beJcsYPP07dj6P6SnDhxg6SS9u03VCqftLZ16DIawoI6voCpjWBLyIcNt8EmJeR0YfYaK7stcanGFZ/GaWJA01iIux6g8DZj1ustKfoU2jBKDUl9Hs01g6+JnnrmgX2UY8k=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:24:40 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:24:40 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range computation
Date: Wed, 17 Apr 2024 13:23:37 +0100
Message-Id: <20240417122341.331524-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417122341.331524-1-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0558.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::14) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 95043995-4426-4a16-0aca-08dc5ed95a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IuM6djIcX1Nu60pRUVtzdWUnW+Dr658Jqa9+RmE7bLSyV3sYbXXWqPEE6AXkvQROUf288g78MNQczF/1pPPxDeEvQhngWP9ce+9BjbXvPR8ZMgI8412Bz7+m36ntEZ91qn+uKZBuVqDG9QAJVIfXbEajMUo2oFcxbUg/m7vZWNVHOZ/3vQwgQBmfiKZxgKfqvnJXI7zABSPDIkCNDNFvi6wA3Sk8zVm+3XCYDtNPWHNDeGS8MwZn1lNMM/QnoZhGvngRQFO0vx/adYWTcUNW1HECmuItCmEj1b8QptMK1BdwMa6CJCbcGis33h0yLGdUBikyYosD2zOoMl7YFsss/h/6MQFIvLvJnBmswIL/Ml6WlszwIMtlk5WsZ9ThiE+vSqh7nh+zBdAFvzCeyTHL73w6Q6O82ji/mUMcKKNUe5zPux8IqTiNPIutoubhNoQAgPtSeJN6tIMb2+54Dp+/ARyGVNFEf1CppHxaTpWZ4kRe517BZEU4wMZUoBSfH8w33pKzDpa/xpwuBtZb/RP6xTdR92f+qf5NIAvl0sDnzSyjAWi+CUJfLoTriswIDAsMH8WSobLW3kp7NWJVrSQZQ24mJeV3pIIiUwBG/sVvAhplB4HUaewbEnDjncKB/NmY8wkbgxQSxv40oANwt7VuLJ++o92eeeT5khiExNw+DbE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?teyETVYf5oLTCRPD59WS6q2yj8zAoD+tjIFjXlbUjw5C+GA2N4CaDKe21bvy?=
 =?us-ascii?Q?uLALtare6dK0KJlWlsf66z69GDrLt6+hjzOq7HxeNdKXO8lhDbHnvI21ZVXY?=
 =?us-ascii?Q?RxSYPxQd+Mi6bM+MsI22+TVjpdCatibHgQN56FiB9YXiaEWndY3sDBRgg96i?=
 =?us-ascii?Q?xwpEoI8qMdeV70vo1rfRFuKBzS1GTCKzAIDaXS2dmc3MSvLZvsxXcJoHK/vZ?=
 =?us-ascii?Q?EPLb7hEi1AsEuTsi6IxH187AumvENM7xldRawlMrktqgeI/gQaKok/Gky8PI?=
 =?us-ascii?Q?rimj5Ztw0+8Btf8Lmz+SlaUa/KeeLZKrvWQbbeYL9ZM2RV9k8jj3JLe+pTKq?=
 =?us-ascii?Q?tZ6sLaCoUDioIZvAgENel1L0yZ807WMO4zZgI2Q/Xnk/O/C5JmzY587TwnDz?=
 =?us-ascii?Q?uv/QsKfUWsnXbHjf8O3eqZNpYvXZEuNj+uHEELmsNzbXkf6RR1rBPwOT3kvU?=
 =?us-ascii?Q?/+QbU/xAprTpj4gfIpYkU4GiF3UAHHjClZvNws861a1qMZGBlpUw/56XUDNu?=
 =?us-ascii?Q?OFCXdnL85r38eb78fbIrRgf0qxNTbaPi57eeYc2dLIkVyk52mQQNH9Fs3wUD?=
 =?us-ascii?Q?SFVKj31yhGmbNKjprO33wzqptDWWWgPdUZgHmefOE4U8U2P3XIQ611mh1C+x?=
 =?us-ascii?Q?3plrbyiAaVzPSAkXAqTYMi2lSmsOiC1CAUjnxY4KJdnV8GmGY/3Tojp5Ybzb?=
 =?us-ascii?Q?UQjBtbreHHKBuR2OvbxhUjU+zqnT4g7VjkHmLoufWFhBEF9xlF9jLsiSLWOY?=
 =?us-ascii?Q?bn276mCPmeGoxydfNNocxr8OgFDHUpNnQoWGg792G4xXbNjbo1wzOXorxJFq?=
 =?us-ascii?Q?6JP9lsQrqDXPe0E+nRItQZf2qicOFyRxVZyeX4f4z/41RXuoNCIyCzMd1M7a?=
 =?us-ascii?Q?nZ7qj73UYk39YWpvupuPrstqxGNUQpql8WF84fGvmLzlwfP9ozAl/U1nl+MG?=
 =?us-ascii?Q?unjdPO2C4uisPl9ryGJcASiI31PnRntA8J7ppx9L9fA1lgUFpasmIp/gHf+q?=
 =?us-ascii?Q?jvCyi0G5a26BihPYy0glKrkTb0j8P/HFrtXv4PfBPv+yKGC5HD+s5Z9Qxhhv?=
 =?us-ascii?Q?XXlKm+WXWSpk3KSJNFuah82vqfua2i0oAlQGS4VquBtY9YGu06oLff4SCSGL?=
 =?us-ascii?Q?G2pELaOaJlWM9UZgXjZQO80qSrf6Tmh66t+6N+VsAOZ1CVwOqikKniF/q8lG?=
 =?us-ascii?Q?5hTn1/zrfssQA9R7lmST533Dg5KeYFJxY8TXhNnzMPBRWI5bZ46nDrOW3lRF?=
 =?us-ascii?Q?1yS3mTrsgvILn/5qUux7HmgHb5zRFF3cKs+MXadF9bIL1bhaoxTKyGkbxovg?=
 =?us-ascii?Q?mwCRjNFNifcuPWcGfB0+7X+xaJnPZlvzD6IS7/nq6kY3JiOGF9royt5XVAX0?=
 =?us-ascii?Q?cct2Z815WuqTKih2TjTD1rXSc6Uscn2Vxwg/weLhXcCj6mpjh15zGgWhbKKp?=
 =?us-ascii?Q?0ByKVlJIEkLYiFRy2GgVNRcpO34estXAB3TOxq0hM1solBXzhs7aqDchV9B1?=
 =?us-ascii?Q?ioVRAHnInNxHfPUUR1OXv4QFHK1prZr1XZiN52fvOQtg5iJ8g5YlWb4uZPs9?=
 =?us-ascii?Q?NNlU/XeilKNCnctcohdl4nL3hrL55pAP4AIEGzUlkrxwjp/ndSLDkyx5flvD?=
 =?us-ascii?Q?eWn1mB/4iD5dECcsg71WLqk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wPh54I0JfizaYw51REBYvlNUM0+nbj44bauhoaBuiC8ipCASjGTBGPf+KrvaftIuw6X4onhtojzknNFCsKZCo3I0gZ8mloDagNp/MCvNIQsPi09t1za2ilSqoC9CpkHxY5o2cj3MMnHwNfTrRzdGPwDMq15LW93hcSNo384ChZ8Rx6LkoBudOz7sVDMANX+QSifztrct1qZ88odSCSU59WhPjRuAEQcTlcUS1Xx2YDd6C7rfh9ppc4HoG4UT2o/k0emEXkOqMe9dlMYZLDfrSJcLGYhb4ja9OOcIQ2S+QEGFGiInpKwqGpGDrobTUgcmmn6/yxgH7LqVKXDqqhmpxZNNv3ZGUmiyOuD45CpAusERTqfJpdmQFXQYeXiVnG6tVs/0HQiPR56C5UawEz7TXdkC8kLrZhECpYV+/OJRAeI+VCsR9pxM1gRyKG+7H7pv8IxXBxqgfQWYCQaEHo+/F/oIhB+GpOIqb2Wr0VPhas1QvaZiYOi59BtMwYqUnb+oFrXFGIvse9eC0VhuYOAFOu3ObPYiB5qK34PczrjalUsUvzJJvDpdymqSxd+qWo/yptyqKANLjR8DFpjwGK736iEFhbD7Ym+Z/y6LSsddUXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95043995-4426-4a16-0aca-08dc5ed95a9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:24:40.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPnq8boOS6Jlm4i2livRPG3+7n4rNcAYYTMu5PwYe/47VfPpCNz07j/8Oqhwu2uXIeM0c7OVJos2krx+rU4TAWlFZbL5P96k9S2M55aUCEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170085
X-Proofpoint-ORIG-GUID: Nr9LZZOobUAqbWTkvoQLO7LN6bz_5yqq
X-Proofpoint-GUID: Nr9LZZOobUAqbWTkvoQLO7LN6bz_5yqq

Split range computation checks in its own function, isolating pessimitic
range set for dst_reg and failing return to a single point.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 155 +++++++++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7b6072e3f4..0aa6580af7a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13395,6 +13395,90 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
+				   bool *valid)
+{
+	s64 smin_val = reg.smin_value;
+	s64 smax_val = reg.smax_value;
+	u64 umin_val = reg.umin_value;
+	u64 umax_val = reg.umax_value;
+
+	s32 s32_min_val = reg.s32_min_value;
+	s32 s32_max_val = reg.s32_max_value;
+	u32 u32_min_val = reg.u32_min_value;
+	u32 u32_max_val = reg.u32_max_value;
+
+	bool known = alu32 ? tnum_subreg_is_const(reg.var_off) :
+			     tnum_is_const(reg.var_off);
+
+	if (alu32) {
+		if ((known &&
+		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
+		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
+			*valid = false;
+	} else {
+		if ((known &&
+		     (smin_val != smax_val || umin_val != umax_val)) ||
+		    smin_val > smax_val || umin_val > umax_val)
+			*valid = false;
+	}
+
+	return known;
+}
+
+enum {
+	COMPUTABLE_RANGE    =  1,
+	UNCOMPUTABLE_RANGE  =  0,
+	UNDEFINED_BEHAVIOUR = -1,
+};
+
+static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
+					    struct bpf_reg_state src_reg)
+{
+	bool src_known;
+	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
+	u8 opcode = BPF_OP(insn->code);
+
+	bool valid_known = true;
+	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
+
+	/* Taint dst register if offset had invalid bounds
+	 * derived from e.g. dead branches.
+	 */
+	if (valid_known == false)
+		return UNCOMPUTABLE_RANGE;
+
+	switch (opcode) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+		return COMPUTABLE_RANGE;
+
+	/* Compute range for the following only if the src_reg is known.
+	 */
+	case BPF_XOR:
+	case BPF_OR:
+	case BPF_MUL:
+		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
+
+	/* Shift operators range is only computable if shift dimension operand
+	 * is known. Also, shifts greater than 31 or 63 are undefined. This
+	 * includes shifts by a negative number.
+	 */
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		if (src_reg.umax_value >= insn_bitness)
+			return UNDEFINED_BEHAVIOUR;
+		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
+	default:
+		break;
+	}
+
+	return UNCOMPUTABLE_RANGE;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -13406,53 +13490,19 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
-	bool src_known;
-	s64 smin_val, smax_val;
-	u64 umin_val, umax_val;
-	s32 s32_min_val, s32_max_val;
-	u32 u32_min_val, u32_max_val;
-	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	smin_val = src_reg.smin_value;
-	smax_val = src_reg.smax_value;
-	umin_val = src_reg.umin_value;
-	umax_val = src_reg.umax_value;
-
-	s32_min_val = src_reg.s32_min_value;
-	s32_max_val = src_reg.s32_max_value;
-	u32_min_val = src_reg.u32_min_value;
-	u32_max_val = src_reg.u32_max_value;
-
-	if (alu32) {
-		src_known = tnum_subreg_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	} else {
-		src_known = tnum_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	}
-
-	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	int is_safe = is_safe_to_compute_dst_reg_range(insn, src_reg);
+	switch (is_safe) {
+	case UNCOMPUTABLE_RANGE:
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
+	case UNDEFINED_BEHAVIOUR:
+		mark_reg_unknown(env, regs, insn->dst_reg);
+		return 0;
+	default:
+		break;
 	}
 
 	if (sanitize_needed(opcode)) {
@@ -13507,39 +13557,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_xor(dst_reg, &src_reg);
 		break;
 	case BPF_LSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
 		break;
 	case BPF_ARSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			mark_reg_unknown(env, regs, insn->dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
-- 
2.39.2


