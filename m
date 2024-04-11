Return-Path: <bpf+bounces-26565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AB8A1DF7
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685CF1F22CD5
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885515E8C;
	Thu, 11 Apr 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JWUNIx2x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ybtFPbZK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8885926
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857075; cv=fail; b=ASDECAJfzAfZ8IoJ0g2A38DjaFohzUf/nfn6HgdzU+NIz7LwRQEUvCmi3qesbiXHV1jD4bzq+gl+ocCF4MCjg3jEkNZPUN+BECUMyTtcgmMzbVDU1uqAu9egaC2bTIoCWkZo3YJMFWg2dZZl2Duoyy6/BeAzAXUxM0SsYp24Gt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857075; c=relaxed/simple;
	bh=yLNKRi+ny5HAV3T+rWfyce2mZojuLL1+qBaD5SdQv9M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r1jNv4iib9/Dfgc1Syjxky3gSteInmHaI3q9m1H2eb2+IEYAzTFpFGTnbTW3Ir5QT6Bl8EMcGmiYsUWQz2XLsrIXqGWHx0a0HVZ6p93MWM6zvMVkiMzSil1lZlDJXLjGRNUPGdiABx29CcHkyVA7w5S8aXOekcp9cj8t32zktHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JWUNIx2x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ybtFPbZK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGtLQK009488;
	Thu, 11 Apr 2024 17:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=fTKLabFtJopO2HitcRyR7ojTsNMZTcAXA3phEVrLZ5c=;
 b=JWUNIx2xg/5InEG65bdzaImRSK6u39miWA1Z2jASxNxWUXm6J09Qkd/1F5QcCELZfkG0
 iP1Njotl1AMIzu64+xCA76JcLb40JDTPpLScvTvZIw2rCkxGCmqFgtVpC9wYC95XbECA
 Ph/bAWt1QP3yUn1Qe71MADOPyhmXqoF0sNLQPqevjNXZ9MbGtii1HiP2Qkk6akkZgVj+
 DmXG7UGLiWooUyo/uTw1+RwhvauKv6fCQ0pDRw+IvbyUdZgUlBGUPlDVvE79rVfHNkBp
 VgbHZwVLWhlp/HL4Y1BrzIkIKqf2MMUgdrmhAlcaQzYhNj6f6l6shc7ux7q78Px8sOHZ gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xed4jry58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:37:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGgsRc002885;
	Thu, 11 Apr 2024 17:37:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavug4vms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0fagaA5tpStfXchicHRyhgj45cpV4pd+6xgEuT9DjurB0EK9/f/pqpiPqt6DLhLiabLyIErJAra+MS2koMeon0NoP51EAnJHjYlsgHjoXJRtY1wtD3rSHlRHTJMb9bWkkgj9Ls3WBMbZoSkzBkl3brMmhcfdrLENlq449YNrnpMrMgp4oGZ3zFlOGQ+ixf2i45LbfjOH0ctcNNHpzxovYb2GISqGFVZwm7y/3KDIwQjXHZLnRXGhmGsm4bZFb/eME+t3sdmBh3WG2T12fqitO531sJaEc+fOwTH3pE2MC7K3oaTkrsZ2EgPAU/pXCpUeq5jJRR+oh+iR2AX68eaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTKLabFtJopO2HitcRyR7ojTsNMZTcAXA3phEVrLZ5c=;
 b=d6/xM84ri69yxKxodpTahS/5s8R7rF2KEslJ/wVW7TxTmBhbNH28AiS0ISqiW+d7aycFCqp9n+XRsQswTK2gb0bjTgrNRgVvQnkQBN0WgSfJVbrUwKcA6g0wA3IrK1buJPFeb9Q9N3jjbSteYd2Egn7YoJyR3yC2QNH4elLfz9TW9pm19HBSv8KRqXzJTQv5dM6Mx5+lfuJfMfB9VqBo3eUJ9TLCN4R57OdGXWBRmyqR7xQhkWJWQpk9Zmn7+wbK3GvXyyfx4Ji0zi8ncRVqMysJcK1Ib1r++mgTWDBCYXnZQdw9urzy0ajG40IGvOl36H5BgHo4QdT0PqUTF2olpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTKLabFtJopO2HitcRyR7ojTsNMZTcAXA3phEVrLZ5c=;
 b=ybtFPbZKEsGc4o28fv5JuPwj7UScgeoSk0AhqvDgq7OE6EEsRpmcjz8HsmCWf0VTbc6Jvms55iiBm1/yQzWlNpPPT5J0sIEfmlFACLabOuFx0p+cO2qTnzuqfD7ajT/NFQhvgIwI60gEq1Fe+NfRErlDQiwor0mcHq7kw/T6gHo=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by MW5PR10MB5828.namprd10.prod.outlook.com (2603:10b6:303:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:37:47 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:37:47 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, elena.zannoni@oracle.com,
        yonghong.song@linux.dev, alexei.starovoitov@gmail.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next 1/3] bpf: fix to XOR and OR range computation
Date: Thu, 11 Apr 2024 18:37:30 +0100
Message-Id: <20240411173732.221881-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0657.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::6) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|MW5PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 019032bd-bca7-46f9-f7a3-08dc5a4e1a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RuvBqu/tPUS6PtvWSE48OwN9IP/uWGr0n+3uUmUV2L4ePfxD+US4Uz0D/rDBDLwKdyl/VQXsavsGWo1Gt5G0+sYtEHcisDwkHztxr/BtlKjzIw7FdNhEsFTW3XcffR0nH/fWomS977NKiq9ep8j0O3vRcnPKPlKFpCbg3h9it0hXphzk26cMwnRcsTYMC9936GRzrxKQ7+6POZYNa4oNhwqk/cfPljBG4/qpJzFusHgbDnLC2RhjzNwoIeCUdguXpKR58nXTaaTPBZZMgr2MSqayk2X4fLVx/et2jkeTJVh1OCrox/Z3ypPuGetua8zapBGC+Wv4NtMvhIGiyhvgutiiAjUTxfLWD+PkdyZj0qvsymdUR/yM519rehA2KKGkMXSDKO5jmf3R6Il42kVknACgMPARESK2K8HWgma4d1RG+SpBY6OxDufZREw9RSY2bsU+8YlZf0dGSpLCRI/wCArw9RHetprwYEMrSQuDKn3tX9HTXAYK1Mk0y1VxkHT8LTO+fAXXD0yqP59jVNmKrQUWXas2Dce5f7ELzhJllqhdPDK/uE6rdyNMQRItIJOToABM8PcYgKfA8kcg7WBWsJzi9xk8T33XoQYhSz6/NL+C3AV85++mXW1fH0p3cz2eNHVa+k/ZidGjRQBjof88T9tPOMbnrFVdfVgqN8Xqufg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eutSCf26mWw+FRXpOyMUe2Sz4NwuukEd4fxlOmRXgzoHMK20tLUuAvkljQj1?=
 =?us-ascii?Q?Do/iO8ksTn2Hvu45eaNTM2bHvS9ZvpsA7hspbp3nBwJJLX9Bmvu81CQ93DdN?=
 =?us-ascii?Q?nbuv6ExyTs4p/J5VLtn+1p4jYpzGHiKvRE1wzD4zkpIfKHDdpnrIXnqs7Bue?=
 =?us-ascii?Q?wcW5DuIpWM6brExNsirazWN85WQbh4riOtjZxOiZRqoX7iya25a/JOPAI1xe?=
 =?us-ascii?Q?wi74yrXZxLS6mwox1XgeFA2xJOPd49uouOz9hXOHPr2EalzsigSKlsdUakbp?=
 =?us-ascii?Q?RZMWgE1YbawOS+F6fdltryX0FQGIUAF+0OGAcqOo/kBJ926/0fhDCBtNQnsg?=
 =?us-ascii?Q?2xgxEZ+37cMGzF400iF106LQqPn6tpoKY+19CTlAPLiZ6CGUPrXKD6L9Dbey?=
 =?us-ascii?Q?UaPJs+RK4j/N/ccjBErGraXR+y2HBv5tBw5qf7gT87/OULpZ9hJLxaU2MXiW?=
 =?us-ascii?Q?vlD8sP/z0Oay6hZQwZJUYvRyLl84xo84DhZfBBhCbYxdZWiROJt+bBCN3rN8?=
 =?us-ascii?Q?w8QbQzNXKmxVAFPw2LOIJAnMb+Xp/efuSqxAuVUEWFmyTuuG3eg5W2fKYAJ9?=
 =?us-ascii?Q?OIeCCVv/p7wQEU3EdChGHS+pGYfatyDchU18wXfhISOL9oN1hYkbioRo0mue?=
 =?us-ascii?Q?Xx4TQ2BUAjujYcKPhK69LXqd+FeAVS/SfnW8x6p2fp6VKNyBQ90ckmWDAxNA?=
 =?us-ascii?Q?qFN6QJcUlAEq+RNUEJWp6d3IuFI8YiIhbyPyzCJ+KC47gy5k1l2nZrK3u98q?=
 =?us-ascii?Q?WW7hJNfqtmdjtt4h5rnAtbz41tWTN2FYTu4zOYhCLDy067iQGaZSOW/w6IKB?=
 =?us-ascii?Q?0eY7MLnBVnCAyEEAKAdn/1tqieNiZ/eOAPaTvxoQJdB6d2sRt8LgsyKriw5J?=
 =?us-ascii?Q?G/2+lfVyvTbgF7e1pqVzaqZHfwkLi4MUK07LDEUXmn6sH5yTHimfnQ1zlmAw?=
 =?us-ascii?Q?8mO0uSBWsVj2T7zenPMeooR5IEBnf7MbgzR0THPo18LtTlFx3TPdQmavMtXS?=
 =?us-ascii?Q?KIUvrsr+DxpQspzmSvznMim0v+LKZKAbTUc5StMS7xCxG+DijWo/ZtPNptyV?=
 =?us-ascii?Q?1PHft5RD7Xn/DOl/XdZxduSRSyZfxS6MvK4FLMBR8TiCiHEdlOwIHPyWuHuj?=
 =?us-ascii?Q?ZTeA2Eenxlhwzk1BYmgxc6NAu2VQaudIxXScNSLgbKiUIROL88OgRxo/w9nF?=
 =?us-ascii?Q?Lc+WhajeNuf78zcFoouipBe9VuGZmsuppX0Os2ye6MvkEhT6d2V0yCfc2sQ0?=
 =?us-ascii?Q?st/phALtHvQ+z6fscEKRDS7UWBuyK/JU6rmFds7iijpWAKFSqpYfVJShFLks?=
 =?us-ascii?Q?FbdOP47HkA27NaZv433leJnQybgJUBVWPfIA0MSlkkQrTxv1OBaQ9MjhAm4H?=
 =?us-ascii?Q?h6Q/eaYXKAVWfC6xp95WGJCowTCynwP2cJaGxyTayI929Aiup0Y+8wKnBWxP?=
 =?us-ascii?Q?9CT/iD3BBdaHi6n9OmCxTvpbj+nCZMBcduGUYIg93szrBuYZFEmF6VJo0CkE?=
 =?us-ascii?Q?igviCX3WzBb7LvTCzJprNk1S++GxZW+p3yNmLh5jXSI/0LP65jdVRf6/id9J?=
 =?us-ascii?Q?0c63AWnOdg5CBwSZIta7L4hinZ6rpKroFiu4p2Uby+zaREPN7lSgxmX8OlD3?=
 =?us-ascii?Q?nIfubsCi+7JgEcptPgrJZuE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vb2hKYjubTSgsypgEZPIGOU/ABPXEV3s+B0543Rnpc6BiEttfsPRqJ3xYofHYYZDUHBFwQVJuHGqUxcOyrLTOOx7BiPrLvnVcJvdsloEoYxe0rn3gOMl/vmt33DWQeNN1JHO+a4+MsYFS0Mn1heo3qKpoCnbZE3b/x7zsTnQQOeXjf6z6v64Z/94BFvb6Isy60Q2QRgpmGFS9lqwnrMtQMUPKHS2K1LDQNDtt6TJs3kzYCPumwpVi9zYzWG7dMwEmqpPxVHLCWRE5xTrzQggikcEGI7FrQmIhHr8dcFlRv4FiZdb+qy031R1jKBIiK4GpSLdCKDkIFWF9eJlP3/W2A3Pw8VoU2BIRk3v6efnc2SorlobhJFimIGXPGRZoTp+ekxKvFRusf58HqibdsNtDwss7tGTketL1j+E3aOZBsFuUjctrRUfZrAqK4uTFalBt4wOoIxvd2zrb84ShUH/8cOOd3XF5mCinm+oTd6u5PfBLaGEe0G8/EsrT4DapnKphL+hVF+FaX1tTStCA3q6PUrD5kUQZE6FX0shIUcSMHmLInMepOovzyLo8OgV/cMH5DiRhXc1VluHdzzhrZDYtzfG7sXEr4gXK/T1k9SX9HU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019032bd-bca7-46f9-f7a3-08dc5a4e1a5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:37:47.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDlvl5zF7U7GOV7CMkd/X0OsQ3GnrWgpuIpFqe8vjbksOUJs/IUM8HYyuusnOKzjsDBCRUNUVv41S0ngMCiJBPUMJAehdwsEQBsjeMvoank=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110128
X-Proofpoint-GUID: vF3CSxzaFsKsf5ivpxkaqMjszwmT9HUZ
X-Proofpoint-ORIG-GUID: vF3CSxzaFsKsf5ivpxkaqMjszwmT9HUZ

Range for XOR and OR operators would not be attempted unless src_reg
would resolve to a single value, i.e. a known constant value.
This condition seems excessive, relative to how easy it is to compute a
safe range for these operators.

BPF self-tests were added to validate the new functionality.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 64 +++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..a219f601569a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13764,7 +13764,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	}
 
 	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND &&
+	    opcode != BPF_XOR && opcode != BPF_OR) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 960998f16306..2fcf46341b30 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -885,6 +885,70 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for reg32 <= 1, 0 xor (0,1)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void t_0_xor_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	r6 >>= 63;					\
+	w1 ^= w6;					\
+	if w1 <= 1 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for reg32 <= 1, 0 or (0,1)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void t_0_or_01(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;                                        \
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	w1 = 0;						\
+	r6 >>= 63;					\
+	w1 |= w6;					\
+	if w1 <= 1 goto l1_%=;				\
+	r0 = *(u64*)(r0 + 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.30.2


