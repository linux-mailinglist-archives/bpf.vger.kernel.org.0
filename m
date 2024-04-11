Return-Path: <bpf+bounces-26567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88188A1DF8
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA2E28E71B
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802AD8594D;
	Thu, 11 Apr 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6nUXZT6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gqFctOPH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDD85940
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857097; cv=fail; b=NePfAAut7yfjmEyN4v4/cLElZwT61g0WkUVjQXI6S1zOjfgjCswDFyDfdbKhuGLizVQShkJhjK/LvFev2JEUAl49z5wNGChthOQMHc6xEjS5kosixLpzI5VLV7i3bOIDxFTu8XBqq1GedKm66OzVHYFAJOyerABgUStk6+dq30w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857097; c=relaxed/simple;
	bh=K1qxiEajISSSH6LhSErrcbtuMoTss/NeCQ2AiA3bJSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5dP/2Qd/bGIxtuMvp0Gwi1I402wMrkG0ZpaGnJLJRxWHvbOQSUNfZHRL08lQ/s8ASGNxgnCcIYaTWuob97uyVYEPGS/EJw8dqhnLkiPUmmbcJHj+VirzY82oGNoj2fxwCXm7jq6BrXLEo7LkY37BY5scatZ3j6zfXr9HVPwXb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S6nUXZT6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gqFctOPH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGtJlW008724;
	Thu, 11 Apr 2024 17:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=yrjUhEvqtYug2fBb/9/AxI9ufraTrTjV4Io8q6M6HKI=;
 b=S6nUXZT693CcUisPGRj8/vNcZUIWT8FcaSdeMUefymuqw3Dk1Rx4PDHUC1fs9f4P6rFH
 LqITY/DxUGycU7uRAXQdUJFurPAqh6QQHEFEg03fElE3tQrZCtYA0HAzNjqXHuGXammh
 ReI/yguEPWJcK4gQ62hJhkC8KRyoBzWPAQFwyt1BsiQEI/oLi7yzm3cI3OMnECQZxaAO
 P3NrSZ+V+TW9WkMWUdF4UMu0tslriOLcHDAX0YCJcnJ8411iXFsYThwuRhWjTVTppAua
 zuQ5ppWzBLT24/F6HcBhaNAmbbChSWI5Vv88+7Xq1v+Ot6CCCkWR5CqF0lE8zr7HBETa 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtfa0x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:38:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BHJ0i4003080;
	Thu, 11 Apr 2024 17:38:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavug4w0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TINUCFMyP/6pP+fb7tpYOEkM6kHZYU+8B9xHy+4HtLN3WHUsfNX1ISEzfY+rgM3/srseMp008LyfM7+WSsf178Sh07WVxF+oFF5DaTIHh30IHwUbrY7Ybs84n+0vteqDRLaY5siemuYzPKwWw+lPRVLtuhBHCi5R0LdePlbLqmc0h2Z1hVr5CP5j6PI3h8xJlTdcjc+0obPYbeVumy4waU62xR4bIfA6Xj+3+16QyXSp1I7S095MEee3PIeWpZE3kZdQJoKp7QoXNw5aFCEesHBOaVOS+mqRnIvGYE3Vcn/kS5sAFXxwyVT6ZQEZ56rlfLW21VFXRDX9b6h980LNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrjUhEvqtYug2fBb/9/AxI9ufraTrTjV4Io8q6M6HKI=;
 b=RYb9JkLlD0T2CQ/28djrRdqQmpTxGMwp+ARiWZGchJp9DH/PyR7VP7d79UIT3ZTud939h1qN2Dylovf0uIl8SugBWwY25UZcsr+IOt71tolKaMHb0JUUNzS8CZQIr7cZvWZC0TAdsK9CoXxFMkCPNJ8ItAvijVToKfMoxIZleV95G+MzB2c2bAbY/fTs606KAdf+oLO9uJiZK1FMEZn0zGTHzGO0NYmYcgnbUc3s8s0kjNLHOe4wid9gIQ7vQEHz4Bs1C5BVEcgInUwcGsQTcvTjCDJodrJRQJ3+J3GhFigNZbJTxkKQWFzKEaW2JYjSz4wXQ21fRCSg+jaxvKvtGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrjUhEvqtYug2fBb/9/AxI9ufraTrTjV4Io8q6M6HKI=;
 b=gqFctOPHaMbQ+WYMAhz/1Ydq/DW/bw6Tc68IRpW1o0qh4ZK2kM/WhcZN6v3GdMeXmvXQdlMhT5TGRddRYCflEynOZpr+pY+1clYBPmhSIkEIKYQbhZ7pvPc8tTlUXuH3Uj+SqcC3PEdAEcMPm+KBSeppyNzHEJmrk/IkISaxnpg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by MW5PR10MB5828.namprd10.prod.outlook.com (2603:10b6:303:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:38:09 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:38:06 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, elena.zannoni@oracle.com,
        yonghong.song@linux.dev, alexei.starovoitov@gmail.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next 3/3] bpf: relax MUL range computation check
Date: Thu, 11 Apr 2024 18:37:32 +0100
Message-Id: <20240411173732.221881-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411173732.221881-1-cupertino.miranda@oracle.com>
References: <20240411173732.221881-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0587.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::15) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|MW5PR10MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: ac236c23-5464-42f5-181a-08dc5a4e25a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HRSYBeY5BpvZ1ZeGKm0GPFdBCCLjNKygk0HNZDkrkhfrBcp2WoSKsxYB/CdvJ9J4JnJN9BIiLqaMgnmnS5ZsNEjaCilz7cO7Q8O7GewDLvLAMLe04Qt2ifMF3fIRuc0QYUCVvyhpng341kL7CodiS/ASRUDshn8v958Vo6u/xbPNgJH2c+0G/ZuY4p4Z33iK2cN2kKKzTNSRMAUIyBuPzrNhw3/2BADJ6Yqa9SzjzHqrE60tJwdHZO9q3Net5FDwa1Rlm4ZngcdjE04i9NwDonuMpwXEK4hfyVCvaWFawXU+b6drGYBAsdwTsZ5j+XZ3wq8KomJI2t/5nPV7nwUXvV61bqJcMRuhWGU3OZODPutwfUjiqD/c/1fgIEo/xQrydbTFEMcrFpUV/KoPe+JYk7JDmiHJ+E/nXD3sGZLe69UeMogpgBBW7RXDKeNp319uEraXfqf1NSj9JGxMguRMB4WvJfOO1wHNsBHqcTtHlMO4Afg6Yda/Nmgo2+rf1L1HG2OGx7LX4QRAy2cOnw00zyODaP4Zt396TP/7brhfGsrOHS5AlB0voYt/hU51u5eSoA3d85AF67dUj0OgueqvArQbJZA3/ZLNha897fkK1unb/XbR5oHf/dkR57N+LoE6bgmuixzNSEMAt4ZMJgE8JCpUDaHyAeXneC4OUHnVNfI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DEqev9dInfCcfzmfQFIL5NBYudyvQqG3m3IAFqXj9S0qIEVJCD+/eZB2CmNS?=
 =?us-ascii?Q?LptPHqIKc17+5/7hkJYG7jY4r1Jy8EeQNP3x46Gt70+P06aBveV1bKdt2vHX?=
 =?us-ascii?Q?x3ewapBledu6yd65e5V4YR8ZE5rKg8iFBRc8LxR9giEDQU/1w0f9QxBZU50M?=
 =?us-ascii?Q?+Vd1xDlJtj2lhxBy9Pcpr8bXGzSYQrtFH/bphPR5JSE9lKe4QGF8aSOSGziM?=
 =?us-ascii?Q?/5X+/30TM1XyAPpRC3p5zaofdB88GdOjBTvB9nuCtn3Tc+WOCIkmKYBfj5wr?=
 =?us-ascii?Q?vgjiDFB9BxgF2c/jCSi+QAsyoTiQNK+z34Yne5Y+tLAoICCfjTbM1OlDo9mb?=
 =?us-ascii?Q?u4CwMsGzRL7FJwcfzy1L0OvILNnvvw+5BX1zlde6ynWKDuFyZVesDbch3qSl?=
 =?us-ascii?Q?rZjDGMx3m1EF/YFVZlzV0kyjwJKs2+e+cpar6xgYEb2AClrD7x4aBF8QwlPv?=
 =?us-ascii?Q?euYvr9nM55wqhhsb6ak4W0GiGctbfyH+MhIakJF6DUWZEV/11Lcr8f8MVZyJ?=
 =?us-ascii?Q?YBAvbubuJyiaZ+MhroK59VxP4GDFTeYfFJj45rW6HyBZFzDHfObb8F6txkj7?=
 =?us-ascii?Q?xYme/f/h8kux2JaF8nMyFfkEOFIxJVRbybNFeyyItjR8RLExhdovUc19k0TY?=
 =?us-ascii?Q?+UjS/8EIb12h+ZlvFYAdrNdPb58m7SdzyozVJCTunQtYXzwz/A/ODuRPkyAo?=
 =?us-ascii?Q?/fPj4OETsFvMl8KZt9Qx1JxEa+8u0DLKDiNJfaCRVT0CIyuy1IEPv1u2XNDu?=
 =?us-ascii?Q?oOI6sRnu7SAoKon5wtFPsmf9oX9jthGvGV3RdT7J8Kuz86nobvrUH/keFnOP?=
 =?us-ascii?Q?9Cms1lVVeISOHc1jSwNb4g5iwRdOVgbTHOhTkgEs1NuLIksHCupemYna9Lky?=
 =?us-ascii?Q?Zv2QpnJSjB454k5CC4O4TkXsSbrkZCMf8rR4OPkIvR4ca9/mR/NzgTY4VE4p?=
 =?us-ascii?Q?BiTXuLxixDCVQs2k/2CNsyMCxUqe29mOS0jp97BNUqUGpVxmIGJnyRz3UCHf?=
 =?us-ascii?Q?A5HJBXxZnqT6MjVjfFYz25y2zbPctM1x59rObhZe1YBO202uCaPzWpjjzVn2?=
 =?us-ascii?Q?yTVGUoYt+OL8S6Lldfg6X9PRxPBQ4I5OJ+kIhangoPBkt6U8QH7AYMCsUTQ9?=
 =?us-ascii?Q?8Igj6CemmfDaC4QDPLAo6zS3pLEIu+2hZ0Cd0wYxlsPRvdRxs4bPznVTOwtO?=
 =?us-ascii?Q?+3d/wqvj2yRCe4AcNe72QAcRmRtaLoR1927DtgPmDV6OWs2PIFeGIuHr+ajW?=
 =?us-ascii?Q?VEu/AS3xjic0zG4YVclgK+vuazeBLzpLSc94FbdSKRnax6xMdXjXNnaq6bHJ?=
 =?us-ascii?Q?GYcngQpGDuuXUZP5H7h1ujGcUUzmVsiD3xmillh0WG/sbUVpJHLvt84oqhhL?=
 =?us-ascii?Q?1X1LD9tyM8QK1qftoqxTYgywY4/7LUXNY8iQwRIDyswYGf1+J/87Jz9+DtUs?=
 =?us-ascii?Q?+Rg/InxkmALOs5SZxzxd3LGBuLABL7HPjGRYCR6crnMDNeYBMNvZ5jlgYq/n?=
 =?us-ascii?Q?25e6PM/h8Be3H/mjdpFRkwhbmYgJq4Jw2QYMBJlh3hWSJMVAACGbdwCPbaGH?=
 =?us-ascii?Q?Kz+07M5OlPTumxd65DzDymVjlR3pbqMWZhqdHBuIQ+NiY1EVx55+Bn48Dj2c?=
 =?us-ascii?Q?eE0HS4Jbbbh53HfxDQ64OQg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	B2iBK4L7r49PmINwr7WWdtLYWnUMjPug9YgyL95N18Wy24rJ5NMTTgumzNmAQ46F5IaOvbddCplbNp3b8dstQcw6NxQAd98Ys/O7kwwwVRkRyNsOYhyyE9a6Cu/i6pqw73v0dPAFgtEAP/2UYabOKK3yC05bDGlIBqsheDvXuhyoxk5Ugwz5jVaGPZ6YgDC5vFw3T+xiI4JVdcuiud5hjIBSjNQ5ZYu/CsafcVsD00+4KKBhgKZC4psi3xej/dTinwSYk0R6NZf52XCchIuAc2I6uKQc+LimAGdZEaVfn6my+qWnVkP7jsoLTWQOskf8Ey7XgpZkLG1xUvKbFqwsZmfwkP0W8VHeInylOa/lT/l/U2im+QlG0cFMp9L5wEdqw8sQ4+49sHZ552SMV3ysrH/tmz8PNH2WKmwLJgwRQk58Poqg+XD+pw8tBcfvfmNwQIA9ESNBBOgoaTEb+QeAcFRsu6vavsvKX6EBJ6NnlwzvbJi5Hlui+oIR1FNDkA3N3P5XiPGDX/242RqHl9M6wLWxzklvIkX9Di41BNUrkzaiXMnpwzcSZueVSCzTuytXRSvoedYyNzShSNNwyigxIwSf2IOpWY0tejNBukIigoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac236c23-5464-42f5-181a-08dc5a4e25a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:38:06.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02PiTR/MA7Luh4AhSaid4p1vUqg8Lys+zFY3xtpFY+cjPeSPpqPumgreKyCiRELMhduJ3Jin7B4dlJzi4lKkhCJDCP+QVqkxo4RJk/+5GRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110128
X-Proofpoint-GUID: fANxzG4j6qBRNH1OWk0oCzFpDWn6oTw_
X-Proofpoint-ORIG-GUID: fANxzG4j6qBRNH1OWk0oCzFpDWn6oTw_

MUL instruction required that src_reg would be a known value (i.e.
src_reg would be evaluate as a const value). The condition in this case
can be relaxed, since multiplication is a commutative operator and the
range computation is still valid if at least one of its registers is
known.

BPF self-tests were added to check the new functionality.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 kernel/bpf/verifier.c                         | 10 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 99 +++++++++++++++++++
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7894af2e1bdb..a326ec024d82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13741,15 +13741,17 @@ static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
 }
 
 static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
+					      struct bpf_reg_state dst_reg,
 					      struct bpf_reg_state src_reg)
 {
-	bool src_known;
+	bool src_known, dst_known;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	u8 opcode = BPF_OP(insn->code);
 
 	bool valid_known = true;
 	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
+	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known);
 
 	/* Taint dst register if offset had invalid bounds
 	 * derived from e.g. dead branches.
@@ -13765,10 +13767,10 @@ static bool is_safe_to_compute_dst_reg_ranges(struct bpf_insn *insn,
 	case BPF_OR:
 		return true;
 
-	/* Compute range for MUL if the src_reg is known.
+	/* Compute range for MUL if at least one of its registers is know.
 	 */
 	case BPF_MUL:
-		return src_known;
+		return src_known || dst_known;
 
 	/* Shift operators range is only computable if shift dimension operand
 	 * is known. Also, shifts greater than 31 or 63 are undefined. This
@@ -13799,7 +13801,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	if (!is_safe_to_compute_dst_reg_ranges(insn, src_reg)) {
+	if (!is_safe_to_compute_dst_reg_ranges(insn, *dst_reg, src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 2fcf46341b30..09bb1b270ca7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -949,6 +949,105 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for reg32 <= 9, 3 mul (0,3)")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_3_mul_reg_01(void)
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
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	w1 *= w6;					\
+	if w1 <= 9 goto l1_%=;				\
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
+__description("bounds check for reg32 <= 9, (0,3) mul 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_13_mul_reg_3(void)
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
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	w6 *= w1;					\
+	if w6 <= 9 goto l1_%=;				\
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
+__description("bounds check for reg32 >= 6 && reg32 <= 15, (2,5) mul 3")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(0)
+__naked void reg32_25_mul_reg_3(void)
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
+l0_%=:	w1 = 3;						\
+	r6 >>= 62;					\
+	r6 += 2;					\
+	w6 *= w1;					\
+	if w6 > 15 goto l1_%=;				\
+	if w6 < 6 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:  r0 = *(u64*)(r0 + 8);				\
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


