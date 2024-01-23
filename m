Return-Path: <bpf+bounces-20117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B7839A23
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA1C1F2AB5C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1182D99;
	Tue, 23 Jan 2024 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+bxXosJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WfIdpuLs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053082D97
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041074; cv=fail; b=XQzcR6hOIvlV7S3l0YgaJZhF1l85RsH9Eh3xipRXbCYeqCeWS8n67vj993bqNt1bUG/npEh9oU/eB7PYkmgut/qT/e1YGT6GZ65jgleksMYjqMyHnN5VvqneMKxNXgG3RHP7EQPkHLtZkRLETSOpzgH3cuT9x/2UvTSj2XTYxD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041074; c=relaxed/simple;
	bh=2k1Eir4bJPHyDAkKdXlglueueWppirSJNs0OpkWbUts=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OWYF728UnqcWVjWa7jIzMOW4BLBNsHiVRL/pklAfwK0xsCdNX/Fr9hQ812p+F29asHgXSYqcd/IeK6r2tLTFjgcUfaDT4Xjwa7zaBsjHpyqie7IrW80s8cE9QePwohjouOHuutuHCzRR+73YAQppdStPp7Dw5ejLG0KyXw3vPYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+bxXosJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WfIdpuLs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRUYj011681;
	Tue, 23 Jan 2024 20:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=86EeCetMcmdgMOUwhIsxmLmaNGtfXbhPTUdldvAswEQ=;
 b=J+bxXosJVCONXdf5ibp23pp2Vf0lCfl0diPuuGRVGNfg50nVnOMIXh3kH/keYC73enhA
 Aja3AE1n3nRyxYIZXHEz8aUgaMSzwFD3SX8y7/uWZBGm9KGMuWiBf6cNyw1DXW4+4Q53
 JIOwfyxqKN4a3SR+5DWwtJWDUPpw51qlSsHFv3hKphdd+jpYfjGhu929zg6v93EH0YeE
 Jxkxa0qWRv978BxnR/+yuMaq/RBKIhSf7swnyKJU9mfzpc/OwocoxGfjYMxbnEG4eoQ6
 nCewtGMFTjbHr36w0nbwxjXYjMMhXYJRXtfSNayMyQXsVGzXmX3fAEFxupaDrpHFk7mX 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuqc46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 20:17:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NJA1kr005547;
	Tue, 23 Jan 2024 20:17:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371cq3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 20:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXpfRcEJ0Cu6i+7FB5QVZRulDfCQC45BagIaY8GYtOWaqKUtvxHtSJ/ZZnX97C9q1ndcII1ODnyTbQAXe71Mdar2Eb8O69yn7btBFpmePG/ybMFKUBRvsqkyIDaUWN3nAIrV3PvocPLwQvv2sUEREFWDPzOBf24R08NodIVY8owrEBGaQSMOcKHtrEmFORXmwxcr8+SAHPMpvtLySv4ovdd6oZEaaCjTg4w4lqVX4oxt4IQMtf/CxXU4WN3HYEa0y8yZ+tVFoXEpHr5EdtaiKZSGnFICiAHg18EtzSyn6MRVD+a9eZol4zQgdXHbn08pn6+k2fYHtGqamrr+UOftbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86EeCetMcmdgMOUwhIsxmLmaNGtfXbhPTUdldvAswEQ=;
 b=G/nW/stlERh9kNYVgUh5jSHHwBVFexFC+lEj1WgZjcT+0fgqXzwh9tIyNzqtpJl7mhg/YSrES6dgts5s7U9QaexEBRP5xlfhm7i8CU6/636W6WWF09+ILZAHTfrgv22JNEqVSi2rGmaE5h9abkDtYBM7flPJS5gQ7k6jA3FRiIIwRVlKTMLffZh7urNlAArKDqZ6mxJoNTmd+EWXRTyohPooa2kkd18gU88cpId99dHZWM2Kjuae08FGqMU1iy5QQIi7YmEWPeaS9hT2nyx5mmlkgWZw/Y/JsBy8YsuCQ1s+84v953ZxaJeQ18d5hSlBr7mNMRsoGFODHK/oSmsLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86EeCetMcmdgMOUwhIsxmLmaNGtfXbhPTUdldvAswEQ=;
 b=WfIdpuLsVz4y9xprUL+dWEHoKg4PCa0CpkQ/1V9wur6g5ffkpoo+47Djihe7zo5ICMB7BL1jtLlm7k+bEnBt5EcEwcSMJd4VCPzXfn0kpnPAL121cQdCdHQ1D2EFYT3Ko26AQdfXjbVQLkPUxbXm5TUNQ+juNrSiNx/GlOSumRI=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 20:17:44 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 20:17:44 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH] bpf: avoid VLAs in progs/test_xdp_dynptr.c
Date: Tue, 23 Jan 2024 21:17:29 +0100
Message-Id: <20240123201729.16173-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf23105-55f8-4b48-1bf9-08dc1c505bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ag0sdJACn/gHWtGG0YWI/hssewvsZVC/rimHi8wXc4t1JtKQzFNt1fhNIzK0AI59QwzIcyfbDRK5hGFi3x7Lq8pHXNahfuhhv9n/OBRn4LHaIemxMvIwjUT8AUP+7SmVvCI5RbHHlP+M6dXrYlWlUIeQJu6ioDnp8HXHrCLJ4qIWkxGNplgmoUrmYfi9VhbCIAeyfLz3zJxBrs4JmAZ2fyEIwUCK2oyLrJ9MGQ71P5yDAGKFRega5oxfyvbNbhMXeYkt4n2qA14BLzWmTcfQRWjSqCfdCqmeCgOhHRjxDTMs5hABnwgMVgXNg1M9dzdAwrs5k//tBtkvxcR8a+KyrvJEk6Pj4H4szo0KTWNh5G0ULff/KCExSuN0GyssEPqzo7Es77ojYwL5/jkgRGXF8itTSBrEAbSEPMPeGljU1cqfMhimeB1T0vmbjpqBtNAzfw2EFb/Aq7p5VL4IJ2hiizOfR4kFfK3grxviQsYDhgj6JCUZH394H7Dpo3vxaV7Suc82nPoGPCvt3s+LIBBO8Ihu37LZmat897ubXNVYBB8Egzianx9FlTYx6Aoc96mo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(107886003)(6512007)(2616005)(1076003)(38100700002)(5660300002)(8676002)(8936002)(66946007)(2906002)(4326008)(478600001)(6916009)(6486002)(66556008)(6506007)(66476007)(6666004)(54906003)(316002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W5dJJwRkJd8gmGLE903dj5C6DvgUVBvfdFdnMlyntMRL/hQ3G/axQa9mKopK?=
 =?us-ascii?Q?hUFycZDblKfRMutXlzZcB/S8SCxX0/4PeViFPKxWsjIisMXlnfrkJB/GIHsK?=
 =?us-ascii?Q?AeDlgNsG4OlnJ+7v+BF8bzNGpuT6aDiKJBqxLdtWcIDCalfRNSiWh+J8E3PN?=
 =?us-ascii?Q?rhGns0Y17Yz4ok9xXNF9oPlMDwXJ4NUFpLu8Oj0DmbJemcuYrOpO6OPwL9uF?=
 =?us-ascii?Q?B52Od9oO9RVFXuY7cnLV/Ib+5tvqa1LvkIzKyG0bWLU7bABXWe3sPIfJg2T8?=
 =?us-ascii?Q?TI+P4DrcTEKKLgNHOt/TQNLuuQ61x3lfEbwt3+/od4P8vIq877Gjs58ArCTv?=
 =?us-ascii?Q?OUDRJvc5JOeB51ukOhD5BbNf8oHMmqhEnTmqIDwgtsqBErqRnWfH8p04CdTz?=
 =?us-ascii?Q?XtOslK0SI1IoAsZeqdrBLgsfY3FKIDCcKDjYre0d5pwhUgp0DzLlO94VEUvF?=
 =?us-ascii?Q?3Fhkw0fHD5k2tODysqm8Vls4e/UGWpeo9YIb+m+Ck540s3A+CeHaFscx0ZGP?=
 =?us-ascii?Q?mUJvx/IqmQeX1MjMw5tZPWTkpDxXPEtYCQmkvGapewTU9+RlefsD31Bod4Bn?=
 =?us-ascii?Q?gHXElzvPe0+SXkcX/yryET03xiZAocXfi123UdawU5BM+A1iIT/mctMADSzL?=
 =?us-ascii?Q?ebOb9wEFeGRvsJpQeH98xOoqwFomeUs/dGA82eu3+7n7bmMRDT/YRARAQTYQ?=
 =?us-ascii?Q?tIu+2rKkyjOw/3m1CU9KifUpdTLHL5OwZU7S3zixedhCjwF7XMVXetl8e5F3?=
 =?us-ascii?Q?YsA8nHmiOuBwQ7H5W1gp7FfGxiEVZ1qHV6RfhpBxSmvMuVacZ+/YbWgAnnmK?=
 =?us-ascii?Q?cWQ0uOYEXojaEhb8bGbf5ihiUG4wRqJd6c8HPz1rj6yub7Zu/nRNwLD5luzW?=
 =?us-ascii?Q?cz7w8vrUFnPViJ6URymsl6uVd+GBBE09Plxl7f/VruYJRPEsPcr6pWefkRBA?=
 =?us-ascii?Q?5jD+nIMnByblhtm+i7Wn3n7F8WvHhGUGFgUbe36cxgCQ3uPV3Ss3pn6VWrsl?=
 =?us-ascii?Q?ALbYalAN4sxZxwUfB5l4shvdn+QyAPgH46AQTVZUiY+ii2zl0eKlU4zNCBvP?=
 =?us-ascii?Q?LPCYQaaqNakq/z5WMfFsrz18kpPxD+k1fcaMLaoD0SOYU3o8D0VSeRuUf0mt?=
 =?us-ascii?Q?MyxNxo59616I3jQKVDP9D9kY8MuaZq9VM/JfT0kPGge4RBqihAxZselrMBAn?=
 =?us-ascii?Q?sCI1XeburReWsHXEIVUrGMRkHoh9hn3wgelYUB7ugxaFPZtAhvq0uk58QMpp?=
 =?us-ascii?Q?Vq9RGLibuCYjXNj9MtCOu2/tGlVXNnQ+1qXXKEcrsTbLeKW6B3OaTijZCmXo?=
 =?us-ascii?Q?zq7trfwrD2zkwdBOXwr+euQNFbVywnnOW4qJX4HJ9p4TkbxjbBoZ4qME+5Xi?=
 =?us-ascii?Q?VraBQHbUGLTap0pyc66IP0IGIPWA6KhkXZmA7IBmMYFd0I0Rj6a32LshMm8h?=
 =?us-ascii?Q?ZTXgfFOOILdDhrfe9WidMCOnKfXpPwmjif2A8toiEjtFKWVdNVIKKWgKP09P?=
 =?us-ascii?Q?nToSkb0gS7lxTFV/B/FDHO2Z1IkPnU8+s5qsyZswWjUdmMQd8sy9Rt+Qn9cA?=
 =?us-ascii?Q?P0kN4Wkhj3blhT2ZvbGZ1OuPQryg2dCZyhZMFyXiSF8S418Br9Xtz8OUx6QD?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1fB2IczpVF5wyTMVaCmID7HrRvB3H4oQ8gEpRic2PqXi+S2uj3mhQ2iwQN6RhI14DvhIIw4a5k00Jdmx1dC7RRUFMMC7sd3HcmEA0Vr4z48qNzkdaHNYVxxn+EMoecG/Tf1gFU2TO57c2luFwiM2VCC+8ZWNzv/Rn/VIBaEt4sF+H4WQTzfi2g2HNuKgXBgbrUNB6XEXZcMFL1AkRGw1VgyWTDXF6PTiWWHVaO5MtCZGCUuViJMmBr4I1Esb/hX2NdMGve0K+VLuVxObwmqKAvBalVhAfcoqovU/U8xHibbGrfxyDRWSGJwTIjsrJ43Vc8d1lJ5xQXBFAhGdxPa3Jj8zlSXT+wMrUhVk34c42b/vJ3qL6z8fVuHLxnjeOBmHXKbAB3usPJ7h4slgJ00xwExJcmqMsatVjhzMYvvy22XeaPt9TyDU+7szsEqnAc1QSuhch/gwUGiQU/hiyZFb9UTZj0G+4tMlTuG6CeYB4KuguQftTKJTvSx6BEL/RpiSELfnBMnTNeRIlKVq1xm/n0C14OQTp6ErENdd/v4/2DDxoWg8kOdJcQbwsK104PifwECttsUzBOYBhk0EOg6iXKy28KbIpUrJz4NZE+LlQMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf23105-55f8-4b48-1bf9-08dc1c505bfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 20:17:44.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/qlgE3Yje7TDsfaFjWfDFZOkc3ncVwnM7yLma84fjQ82ou1YXa54CBR6ZOhqeqbWzQQ9VNgnEDOQ/43HM4le8k7getk0kEYu3KSYfwk0kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_12,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=848 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230150
X-Proofpoint-ORIG-GUID: P0hqcVjBlS3X15uQQ5glL16h-Mwrj9-f
X-Proofpoint-GUID: P0hqcVjBlS3X15uQQ5glL16h-Mwrj9-f

VLAs are not supported by either the BPF port of clang nor GCC.  The
selftest test_xdp_dynptr.c contains the following code:

  const size_t tcphdr_sz = sizeof(struct tcphdr);
  const size_t udphdr_sz = sizeof(struct udphdr);
  const size_t ethhdr_sz = sizeof(struct ethhdr);
  const size_t iphdr_sz = sizeof(struct iphdr);
  const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);

  [...]

  static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
  {
	__u8 eth_buffer[ethhdr_sz + iphdr_sz + ethhdr_sz];
	__u8 iph_buffer_tcp[iphdr_sz + tcphdr_sz];
	__u8 iph_buffer_udp[iphdr_sz + udphdr_sz];
	[...]
  }

The eth_buffer, iph_buffer_tcp and other automatics are fixed size
only if the compiler optimizes away the constant global variables.
clang does this, but GCC does not, turning these automatics into
variable length arrays.

This patch removes the global variables and turns these values into
preprocessor constants.  This makes the selftest to build properly
with GCC.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 78c368e71797..67a77944ef29 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -18,11 +18,11 @@
 #include "test_iptunnel_common.h"
 #include "bpf_kfuncs.h"
 
-const size_t tcphdr_sz = sizeof(struct tcphdr);
-const size_t udphdr_sz = sizeof(struct udphdr);
-const size_t ethhdr_sz = sizeof(struct ethhdr);
-const size_t iphdr_sz = sizeof(struct iphdr);
-const size_t ipv6hdr_sz = sizeof(struct ipv6hdr);
+#define tcphdr_sz sizeof(struct tcphdr)
+#define udphdr_sz sizeof(struct udphdr)
+#define ethhdr_sz sizeof(struct ethhdr)
+#define iphdr_sz sizeof(struct iphdr)
+#define ipv6hdr_sz sizeof(struct ipv6hdr)
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
-- 
2.30.2


