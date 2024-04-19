Return-Path: <bpf+bounces-27210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F28AAB89
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 11:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556711F21F66
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCD578676;
	Fri, 19 Apr 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSO4u0X5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AwX+PY6W"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3F8BE2
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519469; cv=fail; b=tHwr7SD+Uh2Qw7FsBJyA0iIBYZ2U8JWK4W5C40wRRnRUMQC7t0JDZn3vDKuFKEXWiuxvou5s15yf5j3Ja3wnfRRlrwwZuaw6qQhDBT7kxsy78hOIqNVkEdx9N2o3hatngbfDuHokM+j34ODtnBAROWIRSLVuaUklzt2/XXKycXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519469; c=relaxed/simple;
	bh=yPTCCv/ooIH4eE+5gfbLdAiZHiZEO4yhtSQ6tbWMeDY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=EzGy37KI0kfVWHXZp2qqzgFxfJ5ytEZgwCiqfgW+fTC8ZlLiltblxMVsZSlZ7DX/DXyuGGekFANeixMcjQ7hRbr3Xq0VjneRd40mJbWjoFa61dllFgyvKj0WUiUwcSNUt8JqEkVycYJFik05i3meRHjLiFxOaEOuBbQiL9CLVZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BSO4u0X5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AwX+PY6W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J8xIcF012550;
	Fri, 19 Apr 2024 09:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=L0sFJ4jANTLQoPwJGYYXjps8xmEu/xriwwMWjWynnX8=;
 b=BSO4u0X5f4nn3ZwKq7y5oG59A+MuaGbbPL115tvLcsCAY2NkdMtseJqWzU0dCmqpfjVI
 aIIJXfaJyKRga57qXOoq7oHioXpN0yjhwyODjRhvcFgyZz40imRis2NLeeI6sQunFKsE
 2nLHmpEIVHZg6TB/+LhlhnZoWfyfYNuN1dUB1Vs6b7xvQJlXHJ7C2rL9YkiT6+DOCK2a
 fUckkB6L3jr8SylHnLRYN/8vGo0UDJBRuZn+U02J0TQ3bMIXGStyV69OJMoR237gB3xC
 /rb1ShNu9PB4xn1mBKGz1T2Ge7iHDo7NUyoDCTuAb2PbJnUu9twF9GKcW1Lb2YS2IDK7 sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbvbd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:37:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J7Y0em014362;
	Fri, 19 Apr 2024 09:37:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc97a0p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 09:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee1l/s53ULDm/lU1KK1FlkOJdm2HUGUTI9uVzz1/Ntt6xHE9j2Vc+8w9zDPPghBok5TSQonszNL82Skq9GySUbbjhksvrzza2yJEugvgEj4v8AfF56qbpCqvFfKZ+4MAVktm4SfINojGFZ33jJ3X+ld9pkBdve5s7fDsA76ABGW/7MsrFQAm/QDtH9xZZmxikS1Yf+9DwuUJQUFvSVcrj2jXEUpR74bZNo7GUl2HxbPfIXHBMDfgKR1xlD+yyAS8tQqM7nq9MU57HnokGk8NQxt/j9bR+6R0Y9fze6ghFKL6+UNZNPBagKp/y4xaZk1chQD5zwU0iOKJTB+sJbsQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0sFJ4jANTLQoPwJGYYXjps8xmEu/xriwwMWjWynnX8=;
 b=FWeraDSsaACtsfuUe+BD7yu0MUN4nUb3S88mYvxnAIeCQcsLO2Zx1wDLwBTHaw7q1eqA+MJ6+AOfJC8o66gZdywdemaM1cM+sDrZjRC5FsRCmAuct7UaCT9vvpHNUzW1Raj8mkwZryFGYn6C9akhv+gvdSdDmKH489+iCnlpdiIoYh5+WJP0Yi0imNNP+OcLr3AMxNHFFfDDMH0ExuN6ASTNMTxN3fo1XzXxmdMv+BMX0XLpt+lbBu13H7f+vrSOYzw7G7yfPefrKUSdtmONQ+SAnoDYXcQvz9Gg1qnNB1WeCSsk9WWjK43YeernoP0r+CGq/Zqo5FrLxF3p6eE84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0sFJ4jANTLQoPwJGYYXjps8xmEu/xriwwMWjWynnX8=;
 b=AwX+PY6W+WToeZd8MvAWRwoHWhQfzXLJXQQ6TbH/X+WE7jIzRHqCB7UCavy7qJLvxPQ0WS500Vkf9MNCxMyLbiW8VkK/Wsg3sFLzQdI/gGTPt5EMibAd3xazz4HEF6cVr0rqNCJU7b9Jh7yjQyXkoChsJbsmKwYz6ec3Yess9QM=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7274.namprd10.prod.outlook.com (2603:10b6:208:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 19 Apr
 2024 09:37:34 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 09:37:34 +0000
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-2-cupertino.miranda@oracle.com>
 <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        "Elena
 Zannoni" <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf/verifier: refactor checks for range
 computation
In-reply-to: <f347d6ea9a0d8ecb77fe13a89470195735c706d2.camel@gmail.com>
Date: Fri, 19 Apr 2024 10:37:29 +0100
Message-ID: <878r19k812.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0234.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::23) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6386b4-91a8-4607-1f0c-08dc60545755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YCa1JQrQ4K3Iekp8iHU1jEqqwQ6mhigv3s9ZLYNgZXQlQQvuH+cglb2FnlLHiV2KGx0w9fxcVo/lEY9+2CdexImOEz0YPgJ0kXRhrFkPr/1uUa9AecgizNL/3bbBvqoOagSjCjs9+oE+55AIgiIZ2cxcXa2Leo+DgTs78oTLRE2MSVd3QJPkBMUCQWR2S7FuEnQeWnDzruBOIl+zI9Ma1G7PLMmwkO5lQIe/IeG0KEpGwdPm8Vjmo5/zIpxys01h8y0wi3uazJt8FODqMMNhpjSn3W7tcK4b5SkUwcGmZ1wUpW10jtlSN4imIhf6IooXYSD8mjRM56/dO4gViSjIqEdXOOC8MWuna3yE+LR2EiC7pIthhp+bkmtgDWV7ZTrY2q8zrIGpoGaB7K86KBs71NIfRX3QivXrFqS873AOshdwQ1DcOQHKiKggj/ybFkYzIkFPzsjhOhlQb4zItZeagOrDEmsgzfYRMOISNcukOAXUracoRAQU7E2iDA7N8buXIdZ5sRGBivtA3t4BUPrz/H8Qt9sxFGiSgP6forQG9ulGqOiv0PkogvnS0ZKDa9P1S1mcuijEPNdtQo/hD9/Adp/WBylvo6gxtD5e9FSAo9OsQv0xG/evrNkrrAoP27GV1iQ4LH1gKaJ/r92AT1VJt+TmKac0n3BEyGy5fIVFL74=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WMchNYGAwn2bk+7rVrfL9LXcBQ5zLXvb8tClHve+1kg48XmB2sCAMZ5LIrs3?=
 =?us-ascii?Q?/ao5I/WVul8DUj+IZDsndcpN2iEUyHy7dtq34msTJfapZ62wa8LBEZrc0qtx?=
 =?us-ascii?Q?SiXFLj5H483JwVNxgwagFpZ7vy6Vk/9oz0o1Qmd9xl8SdgPsfYc82kb0FFjw?=
 =?us-ascii?Q?5JA/Oye4EpqERoYgMXQv6+rgQUnjfnDt+PJGO9vUeD0yfjOP2/HtAwyFh8x9?=
 =?us-ascii?Q?zBy8cvLGybRwxstKeH7uW1h7oFziz9VEgtnYlKTmVCpaC0I+fzneFGKDPx3H?=
 =?us-ascii?Q?5asfUZ7SSuOcaQC1UjfM2HnhS5ODW4fAkTzBd/FgCNbi3Vh8AT5qpzx5C8Ch?=
 =?us-ascii?Q?W3f2pfxJgcW7AgrolxXvO2PHoelrxidafnULHqzxZFT1R3zBAFH7XizUDdHp?=
 =?us-ascii?Q?V+ij+0eMsAIAKJREQxSua2QBSPUHkiwrtfZZIhFM33bXernB/E+Sfe5+yQ30?=
 =?us-ascii?Q?ruFSsiKc3G38SXCelvSUDsedoAbid/PfTODlllCUF0fdKK6f5UUb8jH/Ctnb?=
 =?us-ascii?Q?HhUr6YHtT7UZmSEWmxnf0WruVVMgA0aubJzh0ozymaOi+KsI28ZTslaky08H?=
 =?us-ascii?Q?zbO45ftvz+55qJP/ruzz2H+dHi6qc/PRtpTU43CYw580b0/ky07URBpBlHty?=
 =?us-ascii?Q?Gig+LfKItzVjbamON6hxg7DuQyPACcVFtnYEdj6T3JHxg4dLMfe71Eutp3PX?=
 =?us-ascii?Q?QMX8jjmQnWzja6RxiTGDwQuAFfeesTHk2KUkt7Q0c6LDQxCv8Guuc9Hawvpu?=
 =?us-ascii?Q?jQpwf3g83EHEtY+RN6vdzefzWC3/jftu8MaY7vC7jynvH5qyPwJoDdQQP5ib?=
 =?us-ascii?Q?9FLM7xv8SpA3b/fqXMoWDBIWKVv1rGV34Jg28ttAFTB+I9EdILgMmzNVJMRf?=
 =?us-ascii?Q?LBxldqUxyFYrsqN8iEiW01S9HJVVnWwP6/+JiqDXRMCpR0c7RWUXXHCn7xLF?=
 =?us-ascii?Q?L9uD95FiRt3G2wAsV8OAnNdf/6xJlOEttNrc7aZL7GiPE1JpYLBb5kDbkkQV?=
 =?us-ascii?Q?d2wyoUOgDap0bAdY/ZNZZcUyGxnaetUat4Pw206Uyi5L3BZDzULNkzn039Vu?=
 =?us-ascii?Q?jmJSU+hmL9ihxCE16nEzO10ZDRo+tLBK5fsxVBXcmX3BC4zUOTnqFX0LdCDp?=
 =?us-ascii?Q?PvMk46RAJsUaIn8qa6c0RoS7oKr8iQafcZDT9BiLItIBmt8QpzvzsfWZ8fqj?=
 =?us-ascii?Q?gCa4Cpl+hijVka3S5832kYlxKTiQwE5vA68tYFMmUsCwKC0ddnenc88rvIEe?=
 =?us-ascii?Q?LxBIk/EGMJPwNDAdEMYbvuswlC6ocliZp6qMnzElDiRPrnzv+Dsdy8juhI8w?=
 =?us-ascii?Q?wFQHEI969mo6oEOv+9je+D0124tHZh29ajXbaBGIuVauB+SaeCsZKdarGAH9?=
 =?us-ascii?Q?tSrX1U2kKhYflEr3Ww8aQrrs0uNXRpJZ/ISvd13GMu7jRr8/VMJHvYlXVxtR?=
 =?us-ascii?Q?0quxPrCAAdW8gSK+sOQqnSTx0Do5NHmQkyuKEk4xXGn/ikIsJvV5khLVDZs5?=
 =?us-ascii?Q?vhi1kpXwVm9aQ1mDyCZaWqAowgisO6nXOXATW8hjfPmLDnsz3dVgSc5a0LHV?=
 =?us-ascii?Q?odFdZiaKLZ4UxtkTg2XD1XEtI1MUlLnNrisAK48XUzsKHsXt86XLdOPjPfrj?=
 =?us-ascii?Q?Ekmw4cjTObGhdBFsN4eIk1g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6ZwBA0rewhL8HuGXX73XxOhMEtk7XnVaKLYrJbBsKBX8+RySNxkxuvbiDEk3nkL+qywh7kUMQvwJscqo5sKQfjuFTeXLQLlCVowXjf3EKpmf6krYfkFUw2OYaZPCLT2lsBRQiEFoEemA9DdWjjpPLICzbYUIdNqSVzHLRzxdr0XAQTSJYXr9i9r29S93+fyVOJKWL2jlq8F82jwDNSqeKFUE/of9hHBOKehijpYuzEBgITOIcFGrcHmX+sVRG3eJA33cUhJuLYc5RdBNwOymoovfddtlGIOiVY8t9dZ7D/FskgZ6Gu5xagf7B03Mw1uF8Zw915yDQ+FBDwcFA8HAM0OECXTcXQg6Px8z20JTx0syP1ibuHw2I1HI1aFKyAaZ72lua92KTUwAklyhl1AN9N7OvqxewlFSJqqAkZvXHJTD3dwx9tsqp/xQ3HdiSwq29zXJKfUv14ttZfh0yZFVluB9WneHft7PCC3r1UL40TvhSYcebojoyrVMDw+ZFl4hZS7z3zp5x+CCWiHGwsshVSebD1AlXPI1pdueH04vRngr1vS/Gzx2yDkgfdBhgRz2RPbDNNtOv+d94KYqzKdOagPr2ya72hOsrPfwPJitVnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6386b4-91a8-4607-1f0c-08dc60545755
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:37:34.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+RaF0eBjMh3IRN59AH+OUMugeWNcvQLVprMH9NmmJh+5Q7srrzdri87+Itvi4/Sr/35Lgm4pVH/QwX2WPAS4eNLSO0ZclsE9W0Qoa2HzEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190071
X-Proofpoint-ORIG-GUID: 1j2QGc2kXIPkAEv54A3c4TgtKw0blZvm
X-Proofpoint-GUID: 1j2QGc2kXIPkAEv54A3c4TgtKw0blZvm


Eduard Zingerman writes:

> On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
> [...]
>
>> @@ -13406,53 +13490,19 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>
> [...]
>
>> -	if (!src_known &&
>> -	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
>> +	int is_safe = is_safe_to_compute_dst_reg_range(insn, src_reg);
>> +	switch (is_safe) {
>> +	case UNCOMPUTABLE_RANGE:
>>  		__mark_reg_unknown(env, dst_reg);
>>  		return 0;
>> +	case UNDEFINED_BEHAVIOUR:
>> +		mark_reg_unknown(env, regs, insn->dst_reg);
>> +		return 0;
>> +	default:
>> +		break;
>>  	}
>
> Nit: I know that the division between __mark_reg_unknown() and
> mark_reg_unknown() was asked for directly, but tbh I don't think that
> it adds any value here, here is how mark_reg_unknown() is implemented:
>
> static void mark_reg_unknown(struct bpf_verifier_env *env,
> 			     struct bpf_reg_state *regs, u32 regno)
> {
> 	if (WARN_ON(regno >= MAX_BPF_REG)) {
> 		... mark all regs not init ...
> 		return;
>     }
> 	__mark_reg_unknown(env, regs + regno);
> }
>
> The 'regno >= MAX_BPF_REG' does not apply here, because
> adjust_scalar_min_max_vals() is only called from the following stack:
> - check_alu_op
>   - adjust_reg_min_max_vals
>     - adjust_scalar_min_max_vals
>
> The check_alu_op() does check_reg_arg() which verifies that both src
> and dst register numbers are within bounds.
>
> I suggest to replace the enum with as boolean value.
> Miranda, Yonhong, what do you think?

Thanks for the detailed review.

Well, honestly I could not evaluate if there was any actual difference
between the approaches. Although I can understand range computation in
isolation of an instruction I still did not explore the code in the
global perspective, for example the handling of control-flow.
I was proud of the initial boolean implementation that was very clean
and simple, although like Yonghong said, not truly a refactor.
If everyone agrees that it is Ok, I will be happy to change it back.

>
> [...]

