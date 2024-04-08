Return-Path: <bpf+bounces-26213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9089CC10
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884A11C21B82
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178414A619;
	Mon,  8 Apr 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dau+pFLS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vYMOVtXH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430201494DC
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602530; cv=fail; b=DdcwnHIOpfukJMbqO8Hz1ZQdr26/omrU1B5IDzGSmpb7hb2UrwVA/ZmSe/c6THLepvLbKbnpExksl3sAalWW15tm1e2EeB7FFfd2gYHA6pLm4tRg16qbBoF9IzjA7uVXWvDqsNZPXhXeh7az/zKtMo63JgF9Lm9N4lu+yZ1zMQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602530; c=relaxed/simple;
	bh=XZxqOA05zcLrCABuMT6EyeJVho7jkPqy145IygLO/6k=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=dc2osOYTNceaBC6IuuCK3G0AdcsX25anGP9kRclNvphnr8U8KPI6gSql+6bes/42XamUf2gVPNOHvxLS6ObAEP0wP8LcgxtRDPoTpZ7WBMDfgAihO0JglkZTeTcx27ed3F0TjVRtQr2z75cgDHOx0/51H+7yLkZTnbqqAnaWAgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dau+pFLS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vYMOVtXH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438EPXJo011856;
	Mon, 8 Apr 2024 18:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=QzGLmGIUnK7eZxznoZz/ZWfSVUiQjDhymPu5ueQEiQw=;
 b=dau+pFLSieFkWmJ4d4MAwja6P9A3LBgCLTkYq8fGCbvlZIqyy+wPh864cZVQYOf5FtlZ
 IWYcsVRWkRDcT5yCUPw4tuIuf4N3RcvVM4vDO1E0MJH7QDtgxokgL4sSxmzh4DQyQUnS
 sSOeAmbNMSekNo4kXsa5NFOGE0dAcq4mOaOnDX2mXbrZG102btC3LecC9iJCA1FJhyq8
 u80ARrJcQluNKH9j2c8pNn4nI0VjkSUznFSJeAk1D9AlkxhZTwwpsodTbrta4B74ApZk
 Udd4PxBoSyWtAJEsMmbAO1RWU8fgN9TK8rqZxf3G3Aj02Frd6WZC8Xn8hVGh9JZMVQ7/ oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvbee3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 18:55:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438HAk9J040131;
	Mon, 8 Apr 2024 18:55:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuc507p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 18:55:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXptla/fc7a9X+di642Imsi8cIF3iNSlAl20FE4osdRM0i7lUHO3p9yDjg6fsNPNeVjQPacbCIknqMqhuFxzZlqw0XqGdrFWb5D7G0ijpn3uOmEpiUoGNuiTK4oo6AEeIPa7IeH1GlXMCWbcoltPgrYVhqsacpXAnEwe++XL4bF9nRjVrO8RC9MqL1enLijIQY4BYV2AIdibNzmfmZVhm1lmPQxahdCe5+XIk7Cfc/rXJBG+F8kgURIPZ1J2T7kJ6FkojgC0zCU+ggj1V5+/Nf07rZ3U9YNQG8J3cCeThRLzAvW2VZv0wTaQpgHB9Jk5zGiiugQYa0gyvxX1Rs1QGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzGLmGIUnK7eZxznoZz/ZWfSVUiQjDhymPu5ueQEiQw=;
 b=QrWIyopHWqHjhKJO8SmU2ssAwiUELhOrLuXAsA/ptA/qugK/+t7rkP3IxN4RvT4etJ+IqAIYvKQRo10UILJYoOXGYSoxEBpeEWJcf8RH1+Y8hO+JoDVn0fOeHDACLY57QU7+f60QjaGQK9JZ3kOV1EneyG54tHFITwFndHGSvaW9bmBSX87/0+2SOrHBIt/7T/eQW2BJk9wxfcUgv2vpGJ5o4NNDH+biynoQnfHCnS69cjcBu/5W7EzEDBk57I0icaA7o2Hoj+oPxltihmvZcrkYjKSigpFYz5j40yfxWXtjzfA5SOn8Z5nkEaktPVhMDYEjho4wqSRSyM9CA6D8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzGLmGIUnK7eZxznoZz/ZWfSVUiQjDhymPu5ueQEiQw=;
 b=vYMOVtXHgcRb5d9J6CVUMU/n9FaulK+o/fdh8GJxQBJ4G7HkZ38rI/VjSvOSk4fKvQf9brwXxX/pU2WbV+euYn2CD2JejW1KPA+DKaVTJACh9fsZmHGiN+IAAbhd8a+I2Ob2g7Dwg6yUNUhPDoq8kojVcX60oCoPnMiM4QlxduQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS7PR10MB7374.namprd10.prod.outlook.com (2603:10b6:8:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 8 Apr
 2024 18:55:20 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::a112:9d4b:46a1:879f%7]) with mapi id 15.20.7409.046; Mon, 8 Apr 2024
 18:55:20 +0000
References: <20240405220817.100451-1-cupertino.miranda@oracle.com>
 <6a03bf80-de12-4207-80a1-a18a5788d6d3@linux.dev>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        elena.zannoni@oracle.com
Subject: Re: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
In-reply-to: <6a03bf80-de12-4207-80a1-a18a5788d6d3@linux.dev>
Date: Mon, 08 Apr 2024 19:55:15 +0100
Message-ID: <8734rv3crw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS7PR10MB7374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f9fsrQaI3Oe75ADZbgXmJlwnweN5EhClffOaDHxBagk4KET2W5+0PQe/0Tm2JU9nHtdNzKfNc/L77dgfLEqD7Y8iEtxCcALeyugQJGNsl36WJsikinIP7pLdzEa2C1QfCDrrQ5Of68O8UyDcKJFQ53dbPpsW+jSHf0zBdvan3+sB0Wqbf/FbwuArcc2f2JiZjOOAD/WdoxWq2wbZCR1FX+XS9UaelGbSGa0KE2PTDCtxfQAPD2F5QpAPBGKHMpxdNyjvNFvxo6d0R4eCFfupRLBxdR30JYgZe1VBWbzMpAlL+qfoyhjQE/9VD3ZAS5ph3U/5NngT03UwtU1+BcXzQlgyvsnQYsbTmWuOQh5FyR4IC5t90L/eBkVnYiUfAgo1h9GUZXSISIzCY+fjJMI15vsZNBFBO3Wme0QK8W61oZF/LkWF/9fCPpc/YnUn/XWqcC1wEiTOg1bgGVj+fedONhX/MuUJx45MpkW1nT3cSbfmo8DK6dKgyoqLq7qmWHYlaeHjtZhCJjPV/iZNhuYf+eKPXCfzYBUBHAl3ZJM+XKbcNBYXpkqUsrDygIbJjydpiMzhz9g50GbmVxpyGvgW9qLOdWn4jSVGeUy0tb15u5VS/ImnMUOHqw7jYB5Yiayg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QthzKoCgT5rlcQLpJdb4AkAs8t3Wzd2T7Gx94Q535r9HzuPsiGqrBkeXGlHQ?=
 =?us-ascii?Q?uIP3BGL31pOlfxOTu/HoCE2eikJjSKoGzQ9dISmQfiWNfQtZUfGdTyKsVR7y?=
 =?us-ascii?Q?tTHovvfb1hQ1BWpzrYEQSjuKfbIeweNwJ/ujrdRUfeym2+QtMoSo95BzL/p/?=
 =?us-ascii?Q?XNrAQVnYk6V/i+Ndi+/VFxMZYhpeJJhDkH5f69TFMwOraUz/eaflAkStFXHL?=
 =?us-ascii?Q?O+PchzDMKnOpsUhbrdVVDXOG9J/sWmlAh5DARP1nO4l6zB7RPQxr4key5pMl?=
 =?us-ascii?Q?H9M8JwyK1qdUi+q0kcnrLJNsST91fyqaXvRIS0LhcX+Y+UJHnNxJGshGjD7z?=
 =?us-ascii?Q?V7ZdrDdmIbWxf4CsbB+KQTyloIzLLHtUYMpGAUniUj29awrywcjLvLtcwTRi?=
 =?us-ascii?Q?9t+ZVt8pgkerZg7612QQUtjnBxHULDDQW4n53M0wf5OJlaux0xwYWHiF0sjS?=
 =?us-ascii?Q?D3Wb+yZZBo4YqY6WdcKvLDVJpLakSby5GPPNntEMRnBRWQd0hZ3FgI3j+hRE?=
 =?us-ascii?Q?H93aPwd9UHaIBIQTwbOQ6jPJLpWK9tPEpGPmY/6LWQPx7IgvBQNQtUnUr2Fe?=
 =?us-ascii?Q?difXPfB5EQbESLtHbKCQD+j3QRhYHbD+111BKJeg0t9rNXho01t0J0D4CyGf?=
 =?us-ascii?Q?L6VS7CnT8VcmHKREfL6tJ2kPOMwvXO7FNGPttwituaJiLFfDIzvCOYuMdrkv?=
 =?us-ascii?Q?yf/U14nRvMIaQCusw0j9ktKgsJMyLJAE6wQL0OF5fAEgV3MBboQcIQ9UXc26?=
 =?us-ascii?Q?iukv4dAG7P5Bv2pPfwfiS6rvgDbx2BF4k87YaK+ymCCxVdc03/50K5Ldh1h6?=
 =?us-ascii?Q?fZagGYnBP5kl0fBzTifAPi8+3K4udlxjC5M90a3+7AtK2cv3Cn+at3lfI2zw?=
 =?us-ascii?Q?txntKcwvYxbzyFLSGXyc+bfH8BHkJq4guxppvVvMlZ7E0Vb0tSNWM4NnzR55?=
 =?us-ascii?Q?Ogv+iyFgH017VsLiy6qTsrCbYJJr6J5DOUp0V6ysL2Fenyn5ptxjn9+7VqnT?=
 =?us-ascii?Q?AvCGtHm4e+IDcLzgQwgSwcuD/+irnXPIr/x9ZL5CvhbP5BWJnPY7zgg4ySv1?=
 =?us-ascii?Q?w+V7dfLYbAvcGFi3TtBNE4API2fAOloqKCR2X7PK1IWpMYNOVH1RVff20qFY?=
 =?us-ascii?Q?fFeCdJvEfjNRGAc7Mix8Ix5yvKEKrWs8c5GST1mDOePrD1T6jAbmLcjO9Zwk?=
 =?us-ascii?Q?M1/BbM51GmlPqX5ZpLn6J4SBpCD5XKnXWdS1bvJXNWuYt9hu7AObjyNNoiFl?=
 =?us-ascii?Q?s5r5OkwFViJVNmtlhyRX7UoElRBHgRN64BlVN4S14ZpqQBPV2UOfo/X6tfoS?=
 =?us-ascii?Q?ssHO8AoasyJNY3r6UyiOEqoBMD6095C0u0opNrr42Qa2C8Jubyr/BnmT3FMx?=
 =?us-ascii?Q?zfeeIm+yoF/zApYKYUnd0oaJnD0i5DV9/FnEkWVMGz6lfb8HvcYzfk7iVi71?=
 =?us-ascii?Q?rHAKblOVNYn0VpXLSEM9H0for4aapHx42MKB7J3Q+xZK3E9WOigujqOpN8Us?=
 =?us-ascii?Q?vtbbzW+VoPBuMpYC5RUOH57TLGy+JKk88NpgO0C4spRBFiXAxcgFeXr8Mpjt?=
 =?us-ascii?Q?L0eT4jFS9Mvd7p+sjIxvMVkQw9cbbXyWEK7izUJsos+0gz/PgGGcCh8kbYuB?=
 =?us-ascii?Q?/CrO0DGDaozOqjJRJe3WMJs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VD/uj9CO9w6wKpGmts/Jr4nJE6imvwUuvXLec3VQXSVM+lJPvmzjh0z5fH2Qyaiha8TeNn2lISoekUGXORX/h/A8AiWSQKrEREtK/vKIzBy7KhB30rB/4mOgUc8bvw/UrQztRth2iSE6MzrooW/BC582cRKg2iL04ff4UH/Uxw4m+t1HIDsFcFfRkUcRrESwqWzqE82RNJBpDWjihdCm/k0cH3BGre9cuTZx+EsVLT4OlOrhaSI2X6OcUcHAhLOQ3dv6xPUGQaMmtVB8W2Upl1twFv3hW9NAS7aU4mW2d7SSKpp8lZkitwaI1B4nauo1Sbi12uS45mD6ah44/EvtZrTHq3D6T0Zf4C40vGlJLXZdUfvIjTW0R7pWTisDbk+MRNBT0Z5XAKpO5BH8ujVCgQZxaUwJqI06dUi+dgf2ERbZqidzr0kDEIeZOwYeqrnX+JVpO3hu+BNmlqz+SfWixUY2pXWEM6uZhEx9TkvO8gmsbVH2FVpoG6jSYihY68HQ/jmLtSfX0XhJt5UtMRnjSVj+hAtusn4XIm8spLKx0auX2f/06/nX1ujatOyhzXY8xNzQ0wQnifiG0Qiptyaf1PWEupeCt7pi2a5ZfY0/inU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41307c7b-07ef-4484-e860-08dc57fd704f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 18:55:20.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP+GjF+JHQ1+9A8ovqG68NiZV3Z8ZPmIJLZXnnHsdEILys2Ou/IG6SZLOuZTja82UXzfJu9fhqZ39QQVPVzLigE4HV8ZSQiq7vTrLBY/8nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080147
X-Proofpoint-ORIG-GUID: DdUmycDsalTKQw1I72CTQ5-j8EW3REq3
X-Proofpoint-GUID: DdUmycDsalTKQw1I72CTQ5-j8EW3REq3


Yonghong Song writes:

> On 4/5/24 3:08 PM, Cupertino Miranda wrote:
>> Hi everyone,
>>
>> This email is a follow up on the problem identified in
>> https://github.com/systemd/systemd/issues/31888.
>> This problem first shown as a result of a GCC compilation for BPF that ends
>> converting a condition based decision tree, into a logic based one (making use
>> of XOR), in order to compute expected return value for the function.
>>
>> This issue was also reported in
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114523 and contains both
>> the original reproducer pattern and some other that also fails within clang.
>>
>> I have included a patch that contains a possible fix (I wonder) and a test case
>> that reproduces the issue in attach.
>> The execution of the test without the included fix results in:
>>
>>    VERIFIER LOG:
>>    =============
>>    Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only those are supported.
>>    0: R1=ctx() R10=fp0
>>    ; asm volatile ("                                       \ @ verifier_bounds.c:755
>>    0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
>>    1: (bf) r6 = r0                       ; R0_w=scalar(id=1) R6_w=scalar(id=1)
>>    2: (b7) r1 = 0                        ; R1_w=0
>>    3: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=0 R10=fp0 fp-8_w=0
>>    4: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
>>    5: (07) r2 += -8                      ; R2_w=fp-8
>>    6: (18) r1 = 0xffff8e8ec3b99000       ; R1_w=map_ptr(map=map_hash_8b,ks=8,vs=8)
>>    8: (85) call bpf_map_lookup_elem#1    ; R0=map_value_or_null(id=2,map=map_hash_8b,ks=8,vs=8)
>>    9: (55) if r0 != 0x0 goto pc+1 11: R0=map_value(map=map_hash_8b,ks=8,vs=8) R6=scalar(id=1) R10=fp0 fp-8=mmmmmmmm
>>    11: (b4) w1 = 0                       ; R1_w=0
>>    12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>>    13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>>    14: (16) if w1 == 0x0 goto pc+2       ; R1_w=scalar(smin=0x8000000000000001,umin=umin32=1)
>>    15: (16) if w1 == 0x1 goto pc+1       ; R1_w=scalar(smin=0x8000000000000002,umin=umin32=2)
>>    16: (79) r0 = *(u64 *)(r0 +8)
>>    invalid access to map value, value_size=8 off=8 size=8
>>    R0 min value is outside of the allowed memory range
>>    processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
>>    =============
>>
>> The test collects a random number and shifts it right by 63 bits to reduce its
>> range to (0,1), which will then xor to compute the value of w1, checking
>> if the value is either 0 or 1 after.
>> By analysing the code and the ranges computations, one can easily deduce
>> that the result of the XOR is also within the range (0,1), however:
>>
>>    11: (b4) w1 = 0                       ; R1_w=0
>>    12: (77) r6 >>= 63                    ; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>>    13: (ac) w1 ^= w6                     ; R1_w=scalar() R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
>>                                              ^
>>                                              |___ No range is computed for R1
>>
>> The verifier seems to act pessimistically and will only compute a range for
>> dst_reg, if the src_reg is a known value.
>> This happens in:
>>
>>    -- verifier.c:13700 --
>>    if (!src_known &&
>>        opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
>>            __mark_reg_unknown(env, dst_reg);
>>            return 0;
>>    }
>>
>> Is this really a requirement for XOR (and OR) ?
>
> Not really. The earlier verifier is a little bit conservative
> and it is not improved since we didn't hit an issue until now.
>
>> Unless I am missing some corner case and based on the logic presented in
>> tnum_xor (and even in tnum_or), it seems to me that it is safe to compute a new
>> range for both XOR (and OR) in case both operands are not known.
>
> Please send a formal patch to bpf-next. This way proper review can be done.
>
>>
>> Looking forward to your comments.
>>
>> Regards,
>> Cupertino
>>
>> ---
>>   kernel/bpf/verifier.c                         |  3 +-
>>   .../selftests/bpf/progs/verifier_bounds.c     | 33 +++++++++++++++++++
>>   2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 1c34b91b9583..850a2950e740 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13698,7 +13698,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>>   	}
>>     	if (!src_known &&
>> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
>> +	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND
>> +	    && opcode != BPF_XOR) {
>>   		__mark_reg_unknown(env, dst_reg);
>>   		return 0;
>>   	}
>
> There are some other operators as well, e.g. BPF_OR, could you also help take a look?
Sure, will try to identify any other cases and send a patch.
Thanks !

>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
>> index 960998f16306..b0f9aa9203f6 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
>> @@ -745,6 +745,39 @@ l1_%=:	r0 = 0;						\
>>   	: __clobber_all);
>>   }
>>   +SEC("socket")
>> +__description("bounds check for reg32_0 = 0, reg32_1 = (0,1), reg32_1 xor reg32_2")
>> +__success __failure_unpriv
>> +__msg_unpriv("R0 min value is outside of the allowed memory range")
>> +__retval(0)
>> +__naked void reg32_0_reg32_xor_reg_01(void)
>> +{
>> +	asm volatile ("					\
>> +	call %[bpf_get_prandom_u32];                    \
>> +	r6 = r0;                                        \
>> +	r1 = 0;						\
>> +	*(u64*)(r10 - 8) = r1;				\
>> +	r2 = r10;					\
>> +	r2 += -8;					\
>> +	r1 = %[map_hash_8b] ll;				\
>> +	call %[bpf_map_lookup_elem];			\
>> +	if r0 != 0 goto l0_%=;				\
>> +	exit;						\
>> +l0_%=:	w1 = 0;						\
>> +	r6 >>= 63;					\
>> +	w1 ^= w6;					\
>> +	if w1 == 0 goto l1_%=;				\
>> +	if w1 == 1 goto l1_%=;				\
>> +	r0 = *(u64*)(r0 + 8);				\
>> +l1_%=:	r0 = 0;						\
>> +	exit;						\
>> +"	:
>> +	: __imm(bpf_map_lookup_elem),
>> +	  __imm_addr(map_hash_8b),
>> +	  __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>>   SEC("socket")
>>   __description("bounds check for reg = 2, reg xor 3")
>>   __success __failure_unpriv

